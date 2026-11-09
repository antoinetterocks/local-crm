import type { CapacitorConfig } from "@capacitor/cli";

// Native iOS / Android shells for Artology CRM. They bundle the web build in
// dist/ (`npm run web:build`, built from the artology submodule), so the app
// opens offline and every release goes through the stores.
const config: CapacitorConfig = {
  appId: "live.artology.crm",
  appName: "Artology CRM",
  webDir: "dist",
  ios: {
    contentInset: "never",
  },
  android: {
    allowMixedContent: false,
  },
  plugins: {
    StatusBar: {
      overlaysWebView: true,
      style: "DEFAULT",
    },
  },
};

export default config;
