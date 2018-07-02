component Dashboard {
  connect Application exposing { documentations }

  style base {
    padding: 30px;
  }

  style package {
    align-items: center;
    font-size: 18px;
    padding: 10px 0;
    color: #2e894e;
    display: flex;

    & svg {
      fill: currentColor;
      margin-right: 5px;
      height: 20px;
      width: 20px;
    }
  }

  style title {
    border-bottom: 3px solid #EEE;
    padding-bottom: 5px;
    margin-bottom: 20px;
    font-size: 36px;
  }

  fun render : Html {
    <div::base>
      <div::title>
        <{ "Dashboard" }>
      </div>

      <div>
        <{ packages }>
      </div>
    </div>
  } where {
    packages =
      documentations
      |> Array.map(\item : Documentation => item.name)
      |> Array.map(
        \name : String =>
          <a::package href={"/" + name}>
            <{ Icons.package }>
            <{ name }>
          </a>)
  }
}