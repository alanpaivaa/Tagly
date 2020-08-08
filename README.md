# Tagly
Tagly allows displaying lists in a tag cloud manner. It is focused and entirely written in SwiftUI, which means the API resembles the API of primitive views, such as list and stacks.

# Installation
You should use Cocoapods to install Tagly. Update your `Podfile` as follows:
```
target 'MyApp' do
  pod 'Tagly', '~> 0.1'
end
```
Then run `pod install`. After the command finishes, Tagly should be available in your workspace.

# Usage
You only need to provide a collection of identifiable elements, a closure to build each tag and, optionally, the spacing between the tags:

```swift
import Tagly

...

TagCloudView(data: tags, spacing: 8) { tag in
    Text(tag.title)
        .foregroundColor(Color.white)
        .padding(.horizontal, 10)
        .padding(.vertical, 5)
        .background(Color.black)
        .cornerRadius(5)
}
```
And you got this beautiful tag cloud:

<img src="https://github.com/astarkian/Tagly/blob/master/github/TagCloudExample.jpg?raw=true" width="400"/>

# Requirements
iOS >= 13.0

# License
Tagly is available under the MIT license. See the LICENSE file for more info.
