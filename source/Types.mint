/* Represents a property. */
record Property {
  defaultValue : Maybe(String) using "default",
  description : Maybe(String),
  type : Maybe(String),
  name : String
}

/* Represents a computed property (get). */
record ComputedProperty {
  description : Maybe(String),
  type : Maybe(String),
  source : String,
  name : String
}

/* Represents a store connection. */
record Connect {
  keys : Array(String),
  store : String
}

/* Represents a component. */
record Component {
  computedProperties : Array(ComputedProperty) using "computed-properties",
  states : Array(Property) using "states",
  properties : Array(Property),
  description : Maybe(String),
  connects : Array(Connect),
  functions : Array(Method),
  providers : Array(Use),
  name : String
}

/* Represents a provider use. */
record Use {
  condition : Maybe(String),
  provider : String,
  data : String
}

/* Represents a store. */
record Store {
  computedProperties : Array(ComputedProperty) using "computed-properties",
  states : Array(Property) using "states",
  description : Maybe(String),
  functions : Array(Method),
  name : String
}

/* Represents a function. */
record Method {
  arguments : Array(Argument),
  description : Maybe(String),
  type : Maybe(String),
  source : String,
  name : String
}

/* Represents a provider. */
record Provider {
  description : Maybe(String),
  functions : Array(Method),
  subscription : String,
  name : String
}

/* Represents a function argument. */
record Argument {
  name : String,
  type : String
}

/* Represents a module. */
record Module {
  description : Maybe(String),
  functions : Array(Method),
  name : String
}

/* Represents the content of the page. */
record Content {
  computedProperties : Array(ComputedProperty),
  properties : Array(Property),
  fields : Array(RecordField),
  options : Array(EnumOption),
  parameters : Array(String),
  connects : Array(Connect),
  functions : Array(Method),
  states : Array(Property),
  subscription : String,
  description : String,
  uses : Array(Use),
  name : String
}

/* Represents the documentation of an application or package. */
record Documentation {
  dependencies : Array(Dependency),
  components : Array(Component),
  providers : Array(Provider),
  records : Array(Record),
  modules : Array(Module),
  stores : Array(Store),
  enums : Array(Enum),
  name : String
}

/* Reprensents the root data. */
record Root {
  packages : Array(Documentation)
}

/* Represents a dependency. */
record Dependency {
  repository : String,
  constraint : String,
  name : String
}

/* Represents a record field. */
record RecordField {
  mapping : Maybe(String),
  type : String,
  key : String
}

/* Represents a record. */
record Record {
  fields : Array(RecordField),
  description : Maybe(String),
  name : String
}

/* Represents an enum. */
record Enum {
  description : Maybe(String),
  options : Array(EnumOption),
  parameters : Array(String),
  name : String
}

/* Represents an enum option. */
record EnumOption {
  description : Maybe(String),
  parameters : Array(String),
  name : String
}

/* Represents a page of the documentation. */
enum Page {
  /* The dashboard */
  Dashboard

  /* A package */
  Package

  /* Any other page */
  Entity
}

/* Represents the possible top-level entities. */
enum Type {
  Component
  Provider
  Record
  Module
  Store
  Enum
}

/* Represents the status of the application. */
enum Status {
  /* An error occurred when trying to decode the `documentation.json` */
  DecodeError

  /* An error occurred when trying to parse the `documentation.json` */
  HttpError

  /* An error occurred when trying to load the `documentation.json` */
  JsonError

  /* The initial state */
  Initial

  /* The `documentation.json` loaded, parsed and decoded properly */
  Ok
}
