<#ftl strip_whitespace=true>
<!doctype html>
<html lang="en-us">
<style>
  .model {
    overflow: hidden;
    width: fit-content;
  }
  .ports {
    overflow: hidden;
  }
  .inports {
    float: left;
    margin: 10px;
  }
  .outports {
    float: left;
    margin: 10px;
  }
  .inport-header {
    margin: 0 auto;
    width: fit-content;
  }
  .inport-label {
    float: left;
    margin-right: 5px;
  }
  .inport-field {
    float: right;
    width: 200px;
  }
  .outport-header {
    margin: 0 auto;
    width: fit-content;
  }
  .outport-label {
    float: left;
    margin-right: 5px;
  }
  .outport-field {
    float: left;
    min-width: 200px;
  }

  .buttons {
    display: flex;
    flex-direction: row;
    margin: 10px;
  }

  .buttons div {
    flex-basis: 100%;
  }

  .button {
    color: white;
    padding: 10px 16px;
    border: none;
    text-align: center;
    text-decoration: none;
    font-size: 14px;
    cursor: pointer;
    width: 100px;
    flex-basis: 100%;
  }

  #reset {
    background-color: #d22b23;
  }

  #execute {
    background-color: #24d231;
  }
  .error {
    color: red;
    margin: 10px;
  }
<#list inports as inport>
  .inport-container-${inport.name} {
    overflow: hidden;
    margin: 3px;
  }
</#list>
<#list outports as outport>
  .outport-container-${outport.name} {
    overflow: hidden;
    margin: 3px;
  }
</#list>
</style>
<head>
  <script type="text/javascript"
          src="https://cdnjs.cloudflare.com/ajax/libs/mathjs/4.0.1/math.min.js"></script>
  <script type="text/javascript" src="${model_wrapper}.js"></script>
  <script type="text/javascript" src="${model}.js"></script>
  <title>Model</title>
</head>
<body>
<div class="container">
  <div class="model">
    <div class="ports">
      <div class="inports">
        <div class="inport-header">
          <h3>Inports</h3>
        </div>
<#list inports as inport>
<div class="inport-container-${inport.name}">
  <div class="inport-label">
    ${inport.name}:
  </div>
  <div class="inport-field">
    <input type="text" id="inport-field-${inport.name}">
  </div>
</div>
</#list>
      </div>
      <div class="outports">
        <div class="outport-header">
          <h3>Outports</h3>
        </div>
<#list outports as outport>
  <div class="outport-container-${outport.name}">
    <div class="outport-label">
      ${outport.name}:
    </div>
    <div class="outport-field" id="outport-field-${outport.name}"></div>
  </div>
</#list>
      </div>
    </div>
    <div class="buttons">
      <div class="reset">
        <button class="button" id="reset" onclick="reset()">Reset</button>
      </div>
      <div class="execute">
        <button class="button" id="execute" onclick="exec()">Execute</button>
      </div>
    </div>
  </div>
  <div class="error" id="error"></div>
</div>

<script>
  function exec() {
    clearOutportFields();
    clearErrors();

    try {
    <#list inports as inport>
      ${inport.wrapperFunction}(document.getElementById("inport-field-${inport.name}").value);
    </#list>

      execute();

    <#list outports as outport>
      document.getElementById("outport-field-${outport.name}").innerText = ${outport.wrapperFunction}();
    </#list>
    }
    catch (err) {
      if (err.message === undefined) {
        document.getElementById("error").innerText = err;
      }
      else {
        document.getElementById("error").innerHTML = err.message;
      }
    }
  }

  function reset() {
    init();
    clearInportFields();
    clearOutportFields();
    clearErrors();
  }

  function clearInportFields() {
  <#list inports as inport>
    document.getElementById("inport-field-${inport.name}").value = "";
  </#list>
  }

  function clearOutportFields() {
  <#list outports as outport>
    document.getElementById("outport-field-${outport.name}").innerText = "";
  </#list>
  }

  function clearErrors() {
    document.getElementById("error").innerHTML = "";
  }
</script>
</body>
</html>
