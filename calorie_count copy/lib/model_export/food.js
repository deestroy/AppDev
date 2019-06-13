var unirest = require('unirest');
unirest.get("https://nutritionix-api.p.rapidapi.com/v1_1/search/food?fields=item_name%2Citem_id%2Cbrand_name%2Cnf_calories%2Cnf_total_fat")
.header("X-RapidAPI-Host", "nutritionix-api.p.rapidapi.com")
.header("X-RapidAPI-Key", "58a084bb42msh6068e1440941286p10fc9djsn8ca7aa110c34")
.end(function (result) {
  console.log(result.status, result.headers, result.body);
});