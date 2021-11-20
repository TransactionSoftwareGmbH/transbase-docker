const { Transbase } = require("@transaction/transbase-nodejs");
const express = require("express");

const db = new Transbase({
  url: "//transbase.db:2024/sample",
  user: "tbadmin",
  password: "",
});

function getCashbooks() {
  return db.query("select * from cashbook").toArray();
}

const app = express();

app.get("/", (_, res) => res.send(getCashbooks()));

app.listen(8080, () => console.log("🚀 cashbook app listening on port 8080"));
