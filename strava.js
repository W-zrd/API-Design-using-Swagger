const auth_link = "https://www.strava.com/oauth/token";

function reAuthorize() {
  fetch(auth_link, {
    method: "post",
    headers: {
      Accept: "application/json, text/plain, */*",
      "Content-Type": "application/json",
    },

    body: JSON.stringify({
      client_id: "124405",
      client_secret: "3df0635b0711e098b2e87d5467d9c4596727353d",
      refresh_token: "06e1c353390dc772074837c278802a8993e5f7db",
      grant_type: "refresh_token",
    }),
  }).then((res) => console.log(res.json()));
}

reAuthorize();
