# ADR-001: MVVM

Separating view and business logic with supporting types.

## Context

We are using latest Swift technologies i.e. SwiftUI and Combine for the project which is supported from iOS 13.x. The SwiftUI has built in support for MVVM architecture and blends very well with SwiftUI views in terms of bindings and such. So, we aim to use MVVM architecture for our SpaceLaunch project.

### Architecture

We will be using MVVM pattern and here is basic gist of how it works. I am not going to write down details of MVVM pattern here.

```text
           Events
     ┌─────────────────┐
     │                 │
     │                 ▼
┌─────────┐     ┌────────────┐      ┌─────────┐
│         │     │            │      │         │
│  View   │     │ View Model │◀─────│  Model  │
│         │     │            │      │         │
└─────────┘     └────────────┘      └─────────┘
     ▲                 │
     │                 │
     └─────────────────┘
          View State
```

* Model: The data or the domain object. It's often just values that have come from an API or database, or it could be adapted from DTOs. It doesn't include behavioural logic. Typically, these are structs. The view model will hold onto these.

* View: The view layer. This is what people will see on screen. For example, when using SwiftUI, this will be a `View`-conforming struct. When using UIKit, it will be a `UIView` or `UIViewController`. Logic which pertains only to the presentation should go here, for example, colours, layout, animation, etc. The content which the view will display will come from the view model. The view will send the view model events when something happens, like a user button tap, etc.

* View Model: The view model holds the business logic responsible for the behaviour and business logic. It takes data from the model. It processes the data and gives it to the view layer to show. In other words, it passes the view its view state. It accepts events from the view, which in turn may make it do something else like change the view state. 

### Binding the view to the view model

Typically, our view models will be `ObservableObject`. SwiftUI can easily listen to changes on `ObservableObject`'s `@Published` properties. For example, here is a view model which can load a value from an API when the `loadNameTapped` function is called.

```swift
class NameViewModel: ObservableObject {
    @Published var name: String?

    private let api: NameLoadingAPI

    init(api: NameLoadingAPI) {
        self.api = api
    }

    func loadNameTapped() async {
        name = await api.getName()
    }
}
```

A corresponding view will simply observe this view model. A view model will be passed to it on its initialisation, and it can call methods on it. When the 'Load Name' button is tapped, it will call the view model, which will update its `name` property, and cause the view to be updated automatically. 

```swift
struct NameView: View {
    @ObservedObject var viewModel: NameViewModel

    var body: some View {
        VStack(spacing: 20) {
            Text("Welcome to Drink St!")
            Text("You must be: \(viewModel.name ?? "not loaded yet?")")
            Button("Load Name") {
                Task { await viewModel.loadNameTapped() }
            }
        }
    }
}
```

Views can even reference SwiftUI `Binding`s of the view model's properties to pass to their subviews for two-way changes (eg: `$viewModel.name`), or Combine publishers (`viewModel.name.publisher`).

## Decision

MVVM as defined should be the pattern we use for the SpaceLaunch app.

* Views should not contain any business logic
* View models should hold all business logic, and publish properties to the view.
* Navigation logic should be held in the view model (but rendered by views)

## Risks

There is always the risk of a massive view model, however a tested massive view model is preferential to an untestable massive view controller or massive view. Domain logic can be extracted from view models if and when necessary.

## Status

Accepted

## Consequences

MVVM as defined here will be the preferred pattern going forward.
