/* Utility functions for the `Content` type. */
module Content {
  /* Creates a new `Content` from a `Component`. */
  fun fromComponent (item : Component) : Content {
    {
      description: Maybe.withDefault(item.description, ""),
      computedProperties: item.computedProperties,
      properties: item.properties,
      functions: item.functions,
      connects: item.connects,
      uses: item.providers,
      states: item.states,
      subscription: "",
      name: item.name,
      parameters: [],
      options: [],
      fields: []
    }
  }

  /* Creates a new `Content` from a `Record`. */
  fun fromRecord (item : Record) : Content {
    {
      description: Maybe.withDefault(item.description, ""),
      computedProperties: [],
      fields: item.fields,
      subscription: "",
      name: item.name,
      properties: [],
      parameters: [],
      functions: [],
      connects: [],
      options: [],
      states: [],
      uses: []
    }
  }

  /* Creates a new `Content` from an `Enum`. */
  fun fromEnum (item : Enum) : Content {
    {
      description: Maybe.withDefault(item.description, ""),
      parameters: item.parameters,
      computedProperties: [],
      options: item.options,
      subscription: "",
      name: item.name,
      properties: [],
      functions: [],
      connects: [],
      fields: [],
      states: [],
      uses: []
    }
  }

  /* Creates a new `Content` from a `Provider`. */
  fun fromProvider (item : Provider) : Content {
    {
      description: Maybe.withDefault(item.description, ""),
      subscription: item.subscription,
      functions: item.functions,
      computedProperties: [],
      name: item.name,
      parameters: [],
      properties: [],
      connects: [],
      options: [],
      fields: [],
      states: [],
      uses: []
    }
  }

  /* Creates a new `Content` from a `Store`. */
  fun fromStore (item : Store) : Content {
    {
      description: Maybe.withDefault(item.description, ""),
      computedProperties: item.computedProperties,
      functions: item.functions,
      states: item.states,
      subscription: "",
      name: item.name,
      parameters: [],
      properties: [],
      connects: [],
      options: [],
      fields: [],
      uses: []
    }
  }

  /* Creates a new `Content` from a `Module`. */
  fun fromModule (item : Module) : Content {
    {
      description: Maybe.withDefault(item.description, ""),
      functions: item.functions,
      computedProperties: [],
      subscription: "",
      name: item.name,
      parameters: [],
      properties: [],
      connects: [],
      options: [],
      states: [],
      fields: [],
      uses: []
    }
  }

  /* Creates a new empty `Content`. */
  fun empty : Content {
    {
      computedProperties: [],
      subscription: "",
      description: "",
      parameters: [],
      properties: [],
      functions: [],
      connects: [],
      options: [],
      fields: [],
      states: [],
      uses: [],
      name: ""
    }
  }
}
