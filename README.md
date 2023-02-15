# AnimationBackground
`AnimationBackground` is a library that provides developers with screens with simple animation effects. You can include it in your project through the Swift Package Manager. 

## Installation
The following URLs are available for inclusion in the Swift Package Manager.
```
https://github.com/January1st-98/AnimationBackground-Swift.git
```

## Usage
As of 2022-02-15, two features are available.
1. `ABRainingView`: A screen that shows the user's registered image falling from the top of the view to the bottom, as if it's raining. You can register multiple images. The image moves faster and faster.
2. `ABRisingView`: This view shows the images registered by the user from the bottom to the top. You can register multiple images. The image moves faster and faster.

|**`ABRainingView`**|**`ABRisingView`**|
|:-----------------:|:----------------:|
|![ABRainingView Example](https://user-images.githubusercontent.com/76734067/219017953-0ac70ea0-5a0a-40b5-b841-b6d32dee2d0f.gif)|![ABRisingView Exaple](https://user-images.githubusercontent.com/76734067/219018256-ebea6126-68e9-4c6d-b9a9-9a02b3bec2fa.gif)|


### ABRainingView, ABRisingView
The following steps are required to use `ABRainingView` and `ABRisingView`.

1. Create class instance<br>
    When you create an instance, you can adjust the opacity of the image by passing a data value of 0 to 1 to the opacity parameter.<br>
    ```swift
    let rainingView = ABRainingView(opacity: 0.5)
    let risingView = ABRisingView(opacity: 1.0)
    ```
2. Use the `configureImages(images:)` method to register the images to be used in the effect.<br>
    ```swift
    rainView.configureImages(
            images: [
                UIImage(named: "swift-logo")!,
                UIImage(named: "python-logo")!,
                UIImage(named: "ruby-logo")!
            ]
        )
    ```
3. Activate the animation through the `activate` method.<br>
    **It's important to note that this needs to be done in `viewDidLayoutSubviews` because we need the size information of the views to run the animation and calculate the size of the image.**
    ```swift
    override func viewDidLayoutSubviews() {
        rainView.activate()
    }
    ```


## Author
- [Jaehoon So](https://github.com/January1st-98)
- E-mail: jhspacelover@naver.com

## License
`AnimationBackground` is available under the `MIT license`. See the [LICENSE](./LICENSE) file for more info.
