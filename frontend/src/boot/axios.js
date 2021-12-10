import axios from "axios";

window.axios = require("axios");

window.axios.defaults.headers.common["Content-Type"] = "application/json";

window.axios.defaults.baseURL = "http://localhost:3000/api/";

export { axios };
