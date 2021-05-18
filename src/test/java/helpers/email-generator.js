function fn() {
  var dtTime = new Date();
  var retValue = dtTime.getFullYear() + "" + (dtTime.getMonth() + 1) + "" + dtTime.getDate();
  retValue = retValue + "" + dtTime.getHours() + "" + dtTime.getMinutes() + "" + dtTime.getSeconds();
  return retValue + "@test.com";
}