/* The main store of the application. */
store Application {
  /* The selected entity. */
  state selected : Content = Content.empty()

  /* The status of the page. */
  state status : Status = Status::Initial

  /* The selected tab. */
  state tab : Type = Type::Component

  /* All documentations of the packages. */
  state documentations : Array(Documentation) = []

  /* The selected packages documentation. */
  state documentation : Documentation = Documentation.empty()

  /* The current page. */
  state page : Page = Page::Dashboard

  /* Loads the documentation. */
  fun load : Promise(Void) {
    if (status == Status::Initial) {
      let response =
        await Http.get("http://localhost:3002/documentation.json")
        |> Http.send()

      case (response) {
        Result::Ok(response) =>
          {
            let json =
              Json.parse(response.body)

            case (json) {
              Result::Ok(parsedJson) =>
                {
                  let root =
                    decode parsedJson as Root

                  case (root) {
                    Result::Ok(decodedRoot) =>
                      {
                        next
                          {
                            documentations: decodedRoot.packages,
                            status: Status::Ok
                          }
                      }

                    Result::Err =>
                      {next { status: Status::DecodeError }}
                  }
                }

              Result::Err =>
                {next { status: Status::JsonError }}
            }
          }

        Result::Err =>
          {next { status: Status::HttpError }}
      }

      // This branch is Promise(Tuple(Promise(Void))) if this isn't here
      Promise.never()
    } else {
      Promise.never()
    }
  }

  /* Navigates to the dashboard. */
  fun dashboard : Promise(Void) {
    await load()

    next
      {
        documentation: Documentation.empty(),
        selected: Content.empty(),
        page: Page::Dashboard
      }

    Window.setScrollTop(0)
  }

  /* Routes to the given package. */
  fun routePackage (name : String) : Promise(Void) {
    /* Load the documentation.json. */
    await load()

    /* Try to find the package. */
    let nextDocumentation =
      documentations
      |> Array.find(
        (item : Documentation) : Bool { item.name == name })

    case (nextDocumentation) {
      Maybe::Just(foundNextDocumentation) =>
        {
          next
            {
              documentation: foundNextDocumentation,
              page: Page::Package
            }

          Window.setScrollTop(0)
        }

      Maybe::Nothing =>
        {
          /* If we could not find the package. */
          Window.navigate("/")
          Promise.never()
        }
    }
  }

  /* Handles the routing logic of a tab and enitity. */
  fun route (
    packageName : String,
    tabName : String,
    entity : Maybe(String)
  ) : Promise(Void) {
    /* Load the documentation.json. */
    await load()

    /* Try to find the package. */
    let nextDocumentation =
      documentations
      |> Array.find(
        (item : Documentation) : Bool { item.name == packageName })

    case (nextDocumentation) {
      Maybe::Just(foundNextDocumentation) =>
        {
          /* Get the type from string. */
          let nextTab =
            Type.fromString(tabName)

          case (nextTab) {
            Result::Ok(parsedNextTab) =>
              {
                /* Get the converted items from based on the type. */
                let items =
                  case (parsedNextTab) {
                    Type::Component => Array.map(foundNextDocumentation.components, Content.fromComponent)
                    Type::Provider => Array.map(foundNextDocumentation.providers, Content.fromProvider)
                    Type::Record => Array.map(foundNextDocumentation.records, Content.fromRecord)
                    Type::Module => Array.map(foundNextDocumentation.modules, Content.fromModule)
                    Type::Store => Array.map(foundNextDocumentation.stores, Content.fromStore)
                    Type::Enum => Array.map(foundNextDocumentation.enums, Content.fromEnum)
                  }

                /* Try to show the selected entity. */
                let nextSelected =
                  entity
                  |> Maybe.map(
                    (name : String) : Maybe(Content) {
                      Array.find(
                        items,
                        (item : Content) : Bool { item.name == name })
                    })
                  |> Maybe.flatten()

                case (nextSelected) {
                  Maybe::Just(foundNextSelected) =>
                    {
                      /* If there is a selected entity show it. */
                      next
                        {
                          documentation: foundNextDocumentation,
                          selected: foundNextSelected,
                          page: Page::Entity,
                          tab: parsedNextTab
                        }

                      Window.setScrollTop(0)
                    }

                  Maybe::Nothing =>
                    {
                      /* If there is not try to navigate to the first item. */
                      let first =
                        items
                        |> Array.first()

                      case (first) {
                        Maybe::Just(foundFirst) =>
                          {
                            /* If there is a first item navigate to it. */
                            Window.navigate(
                              "/" + foundNextDocumentation.name + "/" + Type.path(parsedNextTab) + "/" + foundFirst.name)
                          }

                        Maybe::Nothing =>
                          {
                            /* If there is not navigate to root. */
                            Window.navigate("/" + foundNextDocumentation.name)
                          }
                      }
                    }
                }
              }

            Result::Err =>
              {
                /* If we could not find a proper type. */
                Window.navigate("/" + foundNextDocumentation.name)
                Promise.never()
              }
          }
        }

      Maybe::Nothing =>
        {
          /* If we could not the package. */
          Window.navigate("/")
          Promise.never()
        }
    }
  }
}
