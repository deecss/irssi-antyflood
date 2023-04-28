const _ = require("lodash");

module.exports = function (helper) {
  const regexNick = /^[a-zA-Z0-9]{6,}$/;
  const regexIdent = /^[a-zA-Z0-9]{6,}$/;
  const vhostLimit = 2;
  const privateWindowsLimit = 5;

  helper.on("privmsg", (msg, network) => {
    const { nick, ident, hostname } = msg.prefixData;
    if (regexNick.test(nick) && regexIdent.test(ident)) {
      // Ignorowanie wiadomości od użytkowników z losowymi znakami w nicku i identyfikatorze
      msg.ignore = true;
    }
    if (_.filter(network.channels, { name: hostname }).length >= vhostLimit) {
      // Ignorowanie wiadomości od użytkowników z powtarzającymi się vhostami
      msg.ignore = true;
    }

    // Ignorowanie wiadomości, gdy liczba otwartych okien prywatnych rozmów przekracza limit
    const privateWindowsCount = _.filter(network.channels, (channel) => channel.type === "query").length;
    if (privateWindowsCount >= privateWindowsLimit) {
      msg.ignore = true;
    }
  });
};