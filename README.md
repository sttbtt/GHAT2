# Using Github Actions with fastlane and TestFlight
  work in progress

### After app is created and setup on App Store Connect

## Data Needed:
If you use the default env names values will be passed automatically for these values

  key_id: ENV["APP_STORE_CONNECT_API_KEY_KEY_ID"],  
  issuer_id: ENV["APP_STORE_CONNECT_API_KEY_ISSUER_ID"],  
  key_content: ENV["APP_STORE_CONNECT_API_KEY_KEY"]  

APP_STORE_CONNECT_KEY_ID: https://appstoreconnect.apple.com/access/api<br>
APP_STORE_CONNECT_ISSUER_ID: https://appstoreconnect.apple.com/access/api<br>
APP_STORE_CONNECT_PRIVATE_KEY: Download and run base64 -i certificate-name.p8 | pbcopy<br>

FASTLANE_PASSWORD: App-Specific Password for fastlane - https://appleid.apple.com/account/manage<br>
MATCH_PASSWORD: Created when setting up match<br>
GIT_AUTHORIZATION: YOUR_GITUSERNAME:YOUR_PERSONAL_ACCESS_TOKEN<br>

IOS_DIST_SIGNING_KEY: Export from keychain then run base64 -i certificate-name.p12 | pbcopy<br>
IOS_DIST_SIGNING_KEY_PASSWORD: Apple developer password<br>

### KEEP ALL CERTIFICATES AND PROFILES IN SAFE PLACE NOT IN REPO

Not needed?
APP_STORE_CONNECT_TEAM_ID<br>
DEVELOPER_APP_ID<br>
DEVELOPER_APP_IDENTIFIER<br>
DEVELOPER_PORTAL_TEAM_ID<br>
FASTLANE_APPLE_ID<br>
PROVISIONING_PROFILE_SPECIFIER<br>



## Setup app repo
  automate with fastlane init


## Setup private certificates repo
  Create a private repo which will hold certificates,
  supply url to fastlane match init

## Setup Github Secrets for app repo
  On the app repo goto settings/secrets/actions
  Setup secrets listed under data needed above


## Setup fastlane in local app folder with terminal
  fastlane init


## Setup fastlane match
  fastlane match init
    will need url for private secrets repo

  To start from scratch:
    fastlane match nuke development
    fastlane match nude distribution

  Setup provisioning
    fastlane match appstore
    fastlane match development


## Setup fastfile
This fastfile will upload app to TestFlight

    default_platform(:ios)

    platform :ios do

      desc "Push a new beta build to TestFlight"
      lane :beta do

        # Check to see if on CI, will hang if not present
        setup_ci if ENV["CI"]

        # Setup App Store Connect API token
        app_store_connect_api_key(
          is_key_content_base64: true
        )

        # Syncs signing (sync_code_signing)
        match(
          type: "appstore",
          readonly: true,
          app_identifier: ["dev.scottbennett.GHAT1"],
          git_basic_authorization: Base64.strict_encode64(ENV["MATCH_GIT_BASIC_AUTHORIZATION"])
        )

        # Builds app (build_app)
        gym(
          scheme: "GHAT1"
        )

        # Uploads app to TestFlight (upload_to_testflight)
        pilot(
          skip_waiting_for_build_processing: true
        )

      end

## Setup Github Action script
This script will run the beta fastlane and pass all credentials needed on either
a push, pull or manually (workflow_dispatch)

    name: build-ios-app
    on:
      push:
        branches: [ main ]
      pull_request:
        branches: [ main ]
      workflow_dispatch:
    jobs:
      build:
        runs-on: macos-latest
        steps:
          - uses: actions/checkout@v3
          - run: fastlane beta
            env:
              MATCH_PASSWORD: ${{ secrets.MATCH_PASSWORD }}
              MATCH_GIT_BASIC_AUTHORIZATION: ${{ secrets.GIT_AUTHORIZATION }}
              FASTLANE_PASSWORD: ${{ secrets.FASTLANE_PASSWORD }}
              APP_STORE_CONNECT_API_KEY_ISSUER_ID: ${{ secrets.ASC_ISSUER_ID }}
              APP_STORE_CONNECT_API_KEY_KEY_ID: ${{ secrets.ASC_KEY_ID }}
              APP_STORE_CONNECT_API_KEY_KEY: ${{ secrets.ASC_PRIVATE_KEY }}

## To Uplaod to TestFlight
  Build the app at least once since last upload to increment build number  
  Commit

## Setup Provisioning on new developer machine


## Extras
  Turn off Automatically manage signing
  Select Match Appstore for Provisioning Profile

  Might need to run fastlane-credentials add --username

  To keep build number in sync add to build scheme
  Edit Scheme/Build/Post-actions/New Run Script Action
  cd "${PROJECT_DIR}" ; agvtool bump
  set build setting to app name
