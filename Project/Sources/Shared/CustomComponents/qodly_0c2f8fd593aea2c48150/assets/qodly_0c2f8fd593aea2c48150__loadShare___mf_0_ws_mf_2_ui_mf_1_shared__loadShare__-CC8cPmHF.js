import { q as qodly_0c2f8fd593aea2c48150__mf_v__runtimeInit__mf_v__ } from './qodly_0c2f8fd593aea2c48150__mf_v__runtimeInit__mf_v__-BUwrKCOu.js';

// dev uses dynamic import to separate chunks
    
    const {initPromise} = qodly_0c2f8fd593aea2c48150__mf_v__runtimeInit__mf_v__;
    const res = initPromise.then(runtime => runtime.loadShare("@ws-ui/shared", {
      customShareInfo: {shareConfig:{
        singleton: true,
        strictVersion: false,
        requiredVersion: "^1.10.4-rc2"
      }}
    }));
    const exportModule = await res.then(factory => factory());
    var qodly_0c2f8fd593aea2c48150__loadShare___mf_0_ws_mf_2_ui_mf_1_shared__loadShare__ = exportModule;

export { qodly_0c2f8fd593aea2c48150__loadShare___mf_0_ws_mf_2_ui_mf_1_shared__loadShare__ as q };
