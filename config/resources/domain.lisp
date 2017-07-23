(in-package :mu-cl-resources)

;;;;
;; NOTE
;; docker-compose stop; docker-compose rm; docker-compose up
;; after altering this file.

;; Describe your resources here

;; The general structure could be described like this:
;;
;; (define-resource <name-used-in-this-file> ()
;;   :class <class-of-resource-in-triplestore>
;;   :properties `((<json-property-name-one> <type-one> ,<triplestore-relation-one>)
;;                 (<json-property-name-two> <type-two> ,<triplestore-relation-two>>))
;;   :has-many `((<name-of-an-object> :via ,<triplestore-relation-to-objects>
;;                                    :as "<json-relation-property>")
;;               (<name-of-an-object> :via ,<triplestore-relation-from-objects>
;;                                    :inverse t ; follow relation in other direction
;;                                    :as "<json-relation-property>"))
;;   :has-one `((<name-of-an-object :via ,<triplestore-relation-to-object>
;;                                  :as "<json-relation-property>")
;;              (<name-of-an-object :via ,<triplestore-relation-from-object>
;;                                  :as "<json-relation-property>"))
;;   :resource-base (s-url "<string-to-which-uuid-will-be-appended-for-uri-of-new-items-in-triplestore>")
;;   :on-path "<url-path-on-which-this-resource-is-available>")

(define-resource tracking-session ()
  :class (s-prefix "pozyx:TrackingSession")

  :properties `(
                  (:description  :string  ,(s-prefix "pozyx:trackingSessionDescription"))
                  (:raw-tracking-data-url :url ,(s-prefix "ext:RawTrackingDataURL"))
               )

  :has-one `((anchors-configuration :via ,(s-prefix "pozyx:hasAnchorsConfiguration")
                              :as "anchors-configuration")

              (raw-tracking-data :via ,(s-prefix "pozyx:hasRawTrackingData")
                              :as "raw-trackings-data")

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
