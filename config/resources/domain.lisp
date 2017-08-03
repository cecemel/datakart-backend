(in-package :mu-cl-resources)

(define-resource tracking-session ()
  :class (s-prefix "pozyx:TrackingSession")

  :properties `(
                  (:description  :string  ,(s-prefix "pozyx:trackingSessionDescription"))
                  (:raw-tracking-session-id  :string  ,(s-prefix "pozyx:rawTrackingSessionId"))
                  (:start-time  :string  ,(s-prefix "pozyx:startTime"))
                  (:end-time  :string  ,(s-prefix "pozyx:endTime"))
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

  :has-one `((point-coordinate :via ,(s-prefix "pozyx:hasDeployedAnchorPointCoordinate")
                                  :as "point-coordinate"))

  :resource-base (s-url "http://datakart.com/deployed-anchors/")

  :on-path "deployed-anchors")

(define-resource point-coordinate ()
  :class (s-prefix "pozyx:PointCoordinate")

  :properties `(
                  (:x-value  :string  ,(s-prefix "pozyx:x-value"))
                  (:y-value  :string  ,(s-prefix "pozyx:y-value"))
                  (:z-value  :string  ,(s-prefix "pozyx:z-value"))
                )

  :resource-base (s-url "http://datakart.com/point-coordinates/")

  :on-path "point-coordinates")
