int numParticles = 400; // Number of particles
float[] x = new float[numParticles]; // X position of particles
float[] y = new float[numParticles]; // Y position of particles
float[] vx = new float[numParticles]; // X velocity of particles
float[] vy = new float[numParticles]; // Y velocity of particles
float[] radius = new float[numParticles]; // Radius of particles
float gravity = .1; // Strength of gravity
float friction = 0.5; // Strength of friction
float magneticStrength = 87; // Adjust the strength as desired
// float maxRadius = random(1,4); // Maximum radius of particles

float centerX, centerY; // Center of gravity coordinates
float angleOffset; // Angle offset for swirly motion
float swirlRadius; // Radius of the swirly motion

float r = 255;
float g = 255;
float b = 255; 

void setup() {
  size(1920, 1080); // Adjust the canvas size as needed
//  frameRate(24);
 // background(255,255,0);
  // noStroke();
 smooth();
  // Initialize particle positions and velocities
  for (int i = 0; i < numParticles; i++) {
    x[i] = random(width);
    y[i] = random(height);
    vx[i] = 0;
    vy[i] = 0;
    
    
    
    
    radius[i] = random(.1,17);
    
    
    
    
  }
  
  // Set initial values for center of gravity motion
  centerX = width / 2;
  centerY = height / 2;
  angleOffset = 0;
  swirlRadius = min(width, height) * 0.04; // Adjust the radius as desired
}

void draw() {
  
  
  
  
   background(r,g,b);
  
  
  
  
  float maxRadius = random(.1,17);
  
  
  
  

  // Update center of gravity position based on time
  float time = millis() * 0.01; // Convert milliseconds to seconds
  centerX = width / 2 + cos(time * 0.5 + angleOffset) * swirlRadius;
  centerY = height / 2 + sin(time * 0.5 + angleOffset) * swirlRadius;

  // Smoothly change gravity and friction randomly and slowly
  if (random(1) < 0.005) {
    gravity += random(-1,1);
    gravity = constrain(gravity, 0, 1);
  }
  if (random(1) < 0.005) {
    friction += random(-0.001, 0.001);
    friction = constrain(friction, 0, 1);
  }

  // Simulate gravity and update particle positions
  for (int i = 0; i < numParticles; i++) {
    float dx = centerX - x[i];
    float dy = centerY - y[i];
    float distance = sqrt(dx * dx + dy * dy);
    float force = gravity / distance;

    vx[i] += force * dx;
    vy[i] += force * dy;

    // Apply friction
    vx[i] *= 1 - friction;
    vy[i] *= 1 - friction;

    x[i] += vx[i];
    y[i] += vy[i];

    // Keep particles within the canvas
    x[i] = constrain(x[i], 0, width);
    y[i] = constrain(y[i], 0, height);
  }

  // Draw particles based on their radius
  for (int i = 0; i < numParticles; i++) {
    fill(0);
    ellipse(x[i] + 6, y[i] + 6, radius[i] * 5, radius[i] * 5);
    
    
    
    
    
    
    
 // Check if the mouse is hovering over a yellow ellipse
  boolean isYellowEllipse = dist(mouseX, mouseY, x[i], y[i]) < radius[i] * 100;
  
  if (isYellowEllipse) {
    // Store the color in a variable
    
    
    
    
    
    
    color ellipseColor = color(r,g,b); // Yellow color
    
    
    
    
    
    
    // Check if the ellipse is within the radius around the mouse
    float hoverRadius = 100; // Adjust the radius as desired
    
    if (dist(mouseX, mouseY, x[i], y[i]) < hoverRadius) {
      // Change the color of the yellow ellipse when within the hover radius
      ellipseColor = color(random(255), random(255), 255); // Red color
    }
    
    fill(ellipseColor);
  } else {
    
    
    
    
    fill(r,g,b); // Yellow color
    
    
    
    
    
    
    
  }
  
  
  
  
  
    ellipse(x[i], y[i], radius[i] * 5, radius[i] * 5);
    
     // Apply magnetic field when the mouse is hovered over the ellipses
  if (dist(mouseX, mouseY, x[i], y[i]) < radius[i] * 500) {
    float mx = mouseX - x[i];
    float my = mouseY - y[i];
    float magneticForce = magneticStrength / (mx * mx + my * my);
    
    vx[i] += magneticForce * mx;
    vy[i] += magneticForce * my;
  }
  }
  
 //  saveFrame();
  
}
