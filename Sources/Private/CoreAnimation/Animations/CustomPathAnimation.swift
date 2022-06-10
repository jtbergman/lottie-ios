// Created by Cal Stephens on 12/21/21.
// Copyright © 2021 Airbnb Inc. All rights reserved.

import QuartzCore

extension CAShapeLayer {
  /// Adds animations for the given `BezierPath` keyframes to this `CALayer`
  @nonobjc
  func addAnimations(
    for customPath: KeyframeGroup<BezierPath>,
    context: LayerAnimationContext)
    throws
  {
    try addAnimation(
      for: .path,
      keyframes: customPath.keyframes,
      value: { pathKeyframe in
          pathKeyframe
              .cgPath()
              .duplicated(
                times: pathCopiesRequired[ObjectIdentifier(self), default: 2]
              )
      },
      context: context)
  }
}

extension CGPath {
    /// Duplicates the same `CGPath` multiple times
    ///
    /// - Parameter times: The number of copies of the path that should be return
    func duplicated(times: Int) -> CGPath {
        let immutablePath = self
        guard let mutablePath = self.mutableCopy() else {
            return self
        }
        for _ in 1 ..< times {
            print("Copied")
            mutablePath.addPath(immutablePath)
        }
        return mutablePath
    }
}
