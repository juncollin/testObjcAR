//
//  ViewController.m
//  testObjcAR
//
//  Created by 有本淳吾 on 2018/07/04.
//  Copyright © 2018 有本淳吾. All rights reserved.
//

#import "ViewController.h"

@interface ViewController () <ARSCNViewDelegate>

@property (nonatomic, strong) IBOutlet ARSCNView *sceneView;

@end

    
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Set the view's delegate
    self.sceneView.delegate = self;
    
    // Show statistics such as fps and timing information
    self.sceneView.showsStatistics = YES;
    
    // Create a new scene
    SCNScene *scene = [SCNScene sceneNamed:@"art.scnassets/ship.scn"];
    
    // Set the scene to the view
    self.sceneView.scene = scene;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    // Create a session configuration
    ARWorldTrackingConfiguration *configuration = [ARWorldTrackingConfiguration new];

    configuration.planeDetection = ARPlaneDetectionHorizontal;
    self.sceneView.debugOptions = ARSCNDebugOptionShowFeaturePoints;
    
    // Run the view's session
    [self.sceneView.session runWithConfiguration:configuration];
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    
    // Pause the view's session
    [self.sceneView.session pause];
}

#pragma mark - ARSCNViewDelegate

/*
// Override to create and configure nodes for anchors added to the view's session.
- (SCNNode *)renderer:(id<SCNSceneRenderer>)renderer nodeForAnchor:(ARAnchor *)anchor {
 
    return node;
}
*/

- (void)session:(ARSession *)session didFailWithError:(NSError *)error {
    // Present an error message to the user
    
}

- (void)sessionWasInterrupted:(ARSession *)session {
    // Inform the user that the session has been interrupted, for example, by presenting an overlay
    
}

- (void)sessionInterruptionEnded:(ARSession *)session {
    // Reset tracking and/or remove existing anchors if consistent tracking is required
    
}


- (void) renderer:(id<SCNSceneRenderer>)renderer didAddNode:(SCNNode *)node forAnchor:(ARAnchor *)anchor {
    
    if (![anchor isKindOfClass:[ARPlaneAnchor class]]) {
        return;
    }
    // When a new plane is detected we create a new SceneKit plane to visualize it in 3D
    NSLog(@"plane detected");
    
    ARPlaneAnchor *planeAnchor = (ARPlaneAnchor *)anchor;
//    SCNPlane *plane = [SCNPlane planeWithWidth:planeAnchor.extent.x height:planeAnchor.extent.y];
    
    SCNPlane *plane = [SCNPlane planeWithWidth:0.2 height:0.2];

    
    plane.materials.firstObject.diffuse.contents = UIColor.blueColor;
    SCNNode *planeNode = [SCNNode nodeWithGeometry:plane];
    
    planeNode.position = SCNVector3Make(planeAnchor.center.x, 0, planeAnchor.center.z);
    [planeNode setTransform:SCNMatrix4MakeRotation(-M_PI / 2, 1, 0, 0)];

    [planeNode setOpacity:0.8];
    [node addChildNode:planeNode];
}

@end
