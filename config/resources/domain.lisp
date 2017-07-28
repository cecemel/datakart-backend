(in-package :mu-cl-resources)

(define-resource tracking-session ()
  :class (s-prefix "pozyx:TrackingSession")

  :properties `(
                  (:description  :string  ,(s-prefix "pozyx:trackingSessionDescription"))
                  (:raw-tracking-data-id  :string  ,(s-prefix "pozyx:rawTrackingDataId"))
               )

  :has-one `((anchors-configuration :via ,(s-prefix "pozyx:hasAnchorsConfiguration")
                              :as "anchors-configuration")
              )

  :resource-base (s-url "http://datakart.com/tracking-sessions/")

  :on-path "tracking-sessions")


  (define-resource anchors-configuration ()
    :class (s-prefix "pozyx:AnchorsConfiguration")

    :properties `((:description  :string  ,(s-prefix "pozyx:anchorsConfigurationDescription"))) ;; for now a simple field

    :has-many `((deployed-anchor :via ,(s-prefix "pozyx:hasDeployedAnchor")
                                  :as "deployed-anchors"))

    :resource-base (s-url "http://datakart.com/anchors-configurations/")

    :on-path "anchors-configurations")

(define-resource deployed-anchor ()
  :class (s-prefix "pozyx:DeployedAnchor")

  :properties `((:anchor-label  :string  ,(s-prefix "pozyx:anchorLabel"))) ;; the hex id for now

  :has-one `((point-coordinates :via ,(s-prefix "pozyx:hasDeployedAnchorPointCoordinate")
                                  :as "point-coordinates"))

  :resource-base (s-url "http://datakart.com/deployed-anchors/")

  :on-path "deployed-anchors")

(define-resource point-coordinates ()
  :class (s-prefix "pozyx:PointCoordinates")

  :properties `(
                  (:x-value  :string  ,(s-prefix "pozyx:x-value"))
                  (:y-value  :string  ,(s-prefix "pozyx:y-value"))
                  (:z-value  :string  ,(s-prefix "pozyx:z-value"))
                )

  :resource-base (s-url "http://datakart.com/points-coordinates/")

  :on-path "points-coordinates")
