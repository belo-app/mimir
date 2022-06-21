import HomepageFeatures from "@site/src/components/HomepageFeatures";
import Layout from "@theme/Layout";
import clsx from "clsx";
import React, { FC } from "react";

import styles from "./index.module.css";

const Pricing: FC = () => {
  return (
    <Layout
      title="Welcome!"
      description="Description will go into a meta tag in <head />"
    >
      <header className={clsx("hero", styles.heroBanner)}>
        <div className="container">
          <h1 className={clsx("hero__title", styles.heroTitle)}>
            Coming soon...
          </h1>
        </div>
      </header>
      <main></main>
    </Layout>
  );
};

export default Pricing;
