# AnimationBackground

> When you're creating UI in code, there are times when you want animated screens, and this library can help you with that. Use the default shaped views and customize them easily

`AnimationBackground` is a library that provides developers with screens with simple animation effects. You can include it in your project through the Swift Package Manager. 

- [Installation](#installation)
- [Usage](#usage)
    - [ABRainingView, ABRisingView](#abrainingview-abrisingview)
    - [ABCheckboardView](#abcheckboardview)
    - [ABBoundingView](#abboundingview)
- [Author](#author)
- [License](#license)

## Installation
The following URLs are available for inclusion in the Swift Package Manager.
```
https://github.com/January1st-98/AnimationBackground-Swift.git
```

## Usage
As of 2022-02-19, two features are available.
1. `ABRainingView`: A screen that shows the user's registered image falling from the top of the view to the bottom, as if it's raining. You can register multiple images. The image moves faster and faster.
2. `ABRisingView`: This view shows the images registered by the user from the bottom to the top. You can register multiple images. The image moves faster and faster.
3. `ABCheckboardView`: This view shows one image registered by a user in a chessboard format. The image zooms out and in at small intervals.
4. `ABBoundingView`: This view shows the image on the screen when a user registers it. The image rotates and moves, and whenever it hits the boundaries of the screen, it shows the effect of moving in a different direction.

|**`ABRainingView`**|**`ABRisingView`**|**`ABCheckboardView`**|**`ABBoundingView`**|
|:-:|:-:|:-:|:-:|
|<img width="200" src="https://user-images.githubusercontent.com/76734067/219017953-0ac70ea0-5a0a-40b5-b841-b6d32dee2d0f.gif">|<img width="200" src="https://user-images.githubusercontent.com/76734067/219018256-ebea6126-68e9-4c6d-b9a9-9a02b3bec2fa.gif">|<img width="200" src="https://user-images.githubusercontent.com/76734067/219884466-b4154285-3820-4e2b-acae-1332d95034d9.gif">|<img width="200" src="https://user-images.githubusercontent.com/76734067/228921538-87023a04-f45a-49fe-a2bd-cc2fcce0d7c6.gif">|


### ABRainingView, ABRisingView
The following steps are required to use `ABRainingView` and `ABRisingView`.

1. Create class instance<br>
    When you create an instance, you can adjust the opacity of the image by passing a data value of 0 to 1 to the opacity parameter.<br>
    ```swift
    let rainingView = ABRainingView(opacity: 0.5)
    let risingView = ABRisingView(opacity: 1.0)
    ```
2. Use the `configureImages(images:)` method to register the images to be used in the view<br>
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
    
You can use methods to set the speed of the animation and the number of images to display.

There are five types of animation speeds.
1. `AnimationSpeed.superSlow`
2. `AnimationSpeed.slow`
3. `AnimationSpeed.normal`
4. `AnimationSpeed.fast`
5. `AnimationSpeed.superFast`

|**`superSlow`**|**`slow`**|**`normal`**|**`fast`**|**`superFast`**|
|:-:|:-:|:-:|:-:|:-:|
|<img width="130" src="https://user-images.githubusercontent.com/76734067/225113866-6d3557f2-fcf6-4d60-a884-006f83cd9d29.gif">|<img width="130" src="https://user-images.githubusercontent.com/76734067/225113876-5d6ffe7e-766d-47a7-9760-76ce791a7c1e.gif">|<img width="130" src="https://user-images.githubusercontent.com/76734067/225113895-eed885af-fa92-4842-b084-5b2c4373dd93.gif">|<img width="130" src="https://user-images.githubusercontent.com/76734067/225113906-49aacfc6-88d5-4adc-824e-cab161466961.gif">|<img width="130" src="https://user-images.githubusercontent.com/76734067/225113912-2c021cb1-dc58-452a-b218-3eb9b2bdc8e2.gif">|

```swift
animationView.configureSpeed(to: .superFast) // set animation speed to 'superFast'
animationView.configureImageNumber(to: 50) // set image number to 50
```

### ABCheckboardView
The following steps are required to use `ABCheckboardView`.

1. Create class instance<br>
    You can simply create an instance of ABCheckboardView.
    ```swift
    let checkView = ABCheckboardView()
    ```
2. Use the `configureImages(images:)` method to register the images to be used in the view. Unlike `ABRainingView` and `ABRisingView`, only one image can be registered.<br>
    ```swift
    checkView.configureImage(image: UIImage(named: "swift-logo")!)
    ```
3. Run the activate method to place the registered image in the view and animate it.<br>
    **It's important to note that this needs to be done in `viewDidLayoutSubviews` because we need the size information of the views to run the animation and calculate the size of the image.**
    ```swift
    override func viewDidLayoutSubviews() {
        checkView.activate()
    }
    ```

### ABBoundingView
The following steps are required to use `ABBoundingView`.

1. Create an instance of `ABBoundingView`. Initialize it with the image to use.
```swift
let boundingView = ABBoundingView(
    images: [
        UIImage(named: "swift-logo"),
        UIImage(named: "ruby-logo"),
        UIImage(named: "kotlin-logo"),
        UIImage(named: "dart-logo"),
        UIImage(named: "python-logo"),
        UIImage(named: "swiftui-logo"),
        UIImage(named: "java-logo"),
    ]
)
```
2. Then add it as a subview, give it the constraints you want, and that's it.
```swift
view.addSubView(boundingView)
// your constaint configuration...
```

You can also use `ABBoundingConfiguration`, a structure that provides configuration information for an `ABBoundingView`, to provide optional information at initialization time. You can set the movement speed, rotation speed, and size of the image.

Here's what each of `ABBoundingConfiguration` properties means.
- `imageSize`: literally the size of the image. default value is 100
- `rotationSpeed`: how many seconds it takes to make one rotation. defalut value is 8
- `velocity`: Indicates how many pixels per second to move. default value is 60

```swift
let boundingView = ABBoundingView(
    images: [
        UIImage(named: "swift-logo"),
        UIImage(named: "ruby-logo"),
        UIImage(named: "kotlin-logo"),
    ],
    option: ABBoundingConfiguration(
        imageSize: 120,
        rotationSpeed: 6,
        velocity: 100
    )
)
```
    
## Author
- [Jaehoon So](https://github.com/January1st-98)
- E-mail: jhspacelover@naver.com

## License
`AnimationBackground` is available under the `MIT license`. See the [LICENSE](./LICENSE) file for more info.
