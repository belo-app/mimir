import React from "react";
import clsx from "clsx";
import styles from "./styles.module.css";

type FeatureItem = {
  title: string;
  Svg: React.ComponentType<React.ComponentProps<"svg">>;
  description: JSX.Element;
};

const FeatureList: FeatureItem[] = [
  {
    title: "Open",
    Svg: require("@site/static/img/open.svg").default,
    description: (
      <>
        We want that everybody can access to the best financial services
        available
      </>
    ),
  },
  {
    title: "Simple",
    Svg: require("@site/static/img/simple.svg").default,
    description: (
      <>
        Don't waste your time building a bank or an exchange, just use simple
        and well designed API's battled tested by us
      </>
    ),
  },
  {
    title: "Powerful",
    Svg: require("@site/static/img/powerful.svg").default,
    description: (
      <>Automate all, everything included, fiat, crypto, debit cards and more</>
    ),
  },
];

function Feature({ title, Svg, description }: FeatureItem) {
  return (
    <div className={clsx("col col--4")}>
      <div className="text--center">
        <Svg className={styles.featureSvg} role="img" />
      </div>
      <div className="text--center padding-horiz--md">
        <h3>{title}</h3>
        <p>{description}</p>
      </div>
    </div>
  );
}

export default function HomepageFeatures(): JSX.Element {
  return (
    <section className={styles.features}>
      <div className="container">
        <div className="row">
          {FeatureList.map((props, idx) => (
            <Feature key={idx} {...props} />
          ))}
        </div>
      </div>
    </section>
  );
}
