import { _ as __vitePreload } from './preload-helper-CqoC6PUU.js';
import { q as qodly_0c2f8fd593aea2c48150__loadShare__react_mf_1_jsx_mf_2_runtime__loadShare__ } from './qodly_0c2f8fd593aea2c48150__loadShare__react_mf_1_jsx_mf_2_runtime__loadShare__-CGZZ0GNf.js';
import { q as qodly_0c2f8fd593aea2c48150__loadShare__react__loadShare__ } from './qodly_0c2f8fd593aea2c48150__loadShare__react__loadShare__-Cj7YF9mb.js';
import { q as qodly_0c2f8fd593aea2c48150__loadShare___mf_0_ws_mf_2_ui_mf_1_shared__loadShare__ } from './qodly_0c2f8fd593aea2c48150__loadShare___mf_0_ws_mf_2_ui_mf_1_shared__loadShare__-CC8cPmHF.js';
import { T as Tk, K as KI, I as Iir, G as Gd, N as ND, l as lir } from './index.es-CG3XyJSq.js';
import './qodly_0c2f8fd593aea2c48150__mf_v__runtimeInit__mf_v__-BUwrKCOu.js';
import './_commonjsHelpers-BFTU3MAI.js';
import './emotion-react.browser.esm-Cs1925ws.js';
import './tiny-invariant-w-EUxzzv.js';
import './qodly_0c2f8fd593aea2c48150__loadShare__react_mf_2_dom__loadShare__-DS9zFL4t.js';
import './qodly_0c2f8fd593aea2c48150__loadShare___mf_0_ws_mf_2_ui_mf_1_craftjs_mf_2_core__loadShare__-b1xygWui.js';
import '@ws-ui/code-editor';

const t = {}, r = (t == null ? void 0 : t.VITE_WEBFORM) || "standalone", u = {
  name: r,
  path: `WebForms/${r}.WebForm`,
  content: ND(qodly_0c2f8fd593aea2c48150__loadShare___mf_0_ws_mf_2_ui_mf_1_shared__loadShare__.FileFolderType.WEBFORM, {}),
  date: (/* @__PURE__ */ new Date()).toISOString()
};
async function E() {
  try {
    await qodly_0c2f8fd593aea2c48150__loadShare___mf_0_ws_mf_2_ui_mf_1_shared__loadShare__.loadI18n();
  } catch {
  }
  return __vitePreload(() => import('./Editor-nF9kAahy-B2oCNL-Y.js'),true              ?[]:void 0);
}
const I = qodly_0c2f8fd593aea2c48150__loadShare__react__loadShare__.lazy(E), b = Gd("i18n"), O = ({
  onChange: o,
  userComponents: n
}) => /* @__PURE__ */ qodly_0c2f8fd593aea2c48150__loadShare__react_mf_1_jsx_mf_2_runtime__loadShare__.jsx(
  qodly_0c2f8fd593aea2c48150__loadShare__react__loadShare__.Suspense,
  {
    fallback: /* @__PURE__ */ qodly_0c2f8fd593aea2c48150__loadShare__react_mf_1_jsx_mf_2_runtime__loadShare__.jsx(qodly_0c2f8fd593aea2c48150__loadShare___mf_0_ws_mf_2_ui_mf_1_shared__loadShare__.AppLoader, { message: "Initializing...", version: lir }),
    children: /* @__PURE__ */ qodly_0c2f8fd593aea2c48150__loadShare__react_mf_1_jsx_mf_2_runtime__loadShare__.jsx(Tk, { store: KI(), children: /* @__PURE__ */ qodly_0c2f8fd593aea2c48150__loadShare__react_mf_1_jsx_mf_2_runtime__loadShare__.jsx(Iir, { isI18nEnabled: b, children: /* @__PURE__ */ qodly_0c2f8fd593aea2c48150__loadShare__react_mf_1_jsx_mf_2_runtime__loadShare__.jsx(
      I,
      {
        webform: u,
        userComponents: n,
        onChange: o
      }
    ) }) })
  }
);

export { O as default };
