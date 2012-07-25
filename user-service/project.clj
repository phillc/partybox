(defproject user-service "1.0.0-SNAPSHOT"
  :description "FIXME: write description"
  :dependencies [[org.clojure/clojure "1.3.0"]
                 [compojure "1.1.1"]]
  :dev-dependencies [[lein-ring "0.5.0"]]
  :ring {:handler user-service.core/app})
