(()=>{var e="undefined"!=typeof globalThis?globalThis:"undefined"!=typeof self?self:"undefined"!=typeof window?window:"undefined"!=typeof global?global:{},t={},i={},n=e.parcelRequire60cc;null==n&&((n=function(e){if(e in t)return t[e].exports;if(e in i){var n=i[e];delete i[e];var r={id:e,exports:{}};return t[e]=r,n.call(r.exports,r,r.exports),r.exports}var a=new Error("Cannot find module '"+e+"'");throw a.code="MODULE_NOT_FOUND",a}).register=function(e,t){i[e]=t},e.parcelRequire60cc=n);var r=n("8DwkQ"),a=n("2z2pA"),o=n("dChev"),l=n("2p8ND"),d=n("gI0WW"),s=n("ff4Ef"),p=n("53kz8");a=n("2z2pA");class c{validate(e){return-1===this.originWhitelist.indexOf(e)&&(this.isValid=!1,(0,a.default)("[EXTENSION] invalid parent origin!",parent.parentOrigin)),this.isValid}wrapModel(e){const t={};return Object.entries(e).forEach((e=>{let i=(0,s.default)(e,2),n=i[0],r=i[1];t[n]=e=>{if(this.isValid)return"function"==typeof r?r(e):r;throw new Error("Invalid origin")}})),t}constructor(e){this.originWhitelist=e,this.isValid=!0}}var f=(e,t)=>{const i=new c(t);return new p.default.Model(i.wrapModel(e)).then((e=>{if(!i.validate(e.parentOrigin)){const t=new Error(`Invalid parent origin: ${e.parentOrigin}`);throw t.name="InvalidParentOriginError",t}return e}))};const u=function(){let e=Array.prototype.slice.call(arguments);e.splice(1,0,l.LOG_STYLE),e[0]=`%c${e[0]}`,a.default.apply(a.default,e)},h=()=>{let e;f({login:t=>{u("[Extension._api.setupApi] got login data:",t),o.default.storeLoginData(t).then((()=>{e&&e.emit("login-success",t)})).catch((e=>{a.default.error("ERROR SETTING LOGIN DATA"),a.default.error(e)}))}},r.VALID_WEBSITE_ORIGINS).then((t=>{u(`[Extension._api.setupApi.then] got parent origin! ${t.parentOrigin}`),e=t})).catch((e=>{u("[Extension._api.setupApi.catch] Unable to connect Postmate.Model",e)}))};u(`[Extension._api] main method (inIframe: ${d.default})`),d.default?h():window.location="./index.html"})();
//# sourceMappingURL=_api.704dcaa6.js.map
