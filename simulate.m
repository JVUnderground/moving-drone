%% Simulate path of drone, according to FIS dynamics.
clc; clear;

% Import FIS
fismat = readfis('drone-fis');

% Initial Position and Velocity of Drone
pos = [0,10];
vel = [3,0];

% Position of Obstacle
pos_o = [5, 10];

% Time Step in Seconds
dt = 0.1;

% Simulation Time in Seconds
T = 3;

% Number of Instances (Do not change directly):
N = floor(T/dt);

% Simulation Loop
positions = zeros(2,N);
velocities = zeros(2,N);
for n = 1:N
    % Log the current position and velocity.
    positions[:,n] = pos;
    velocities[:,n] = vel;

    % Calculate inputs for FIS
    difference = pos_o - pos;
    D = sqrt(sum((difference).^2));
    alpha = atan2(difference[2], difference[1]);

    % Evaluate FIS
    output = evalfis([D, alpha], fismat);
    a_mag = output[0];
    omega = output[1];

    % Calculate inputs for motion equation
    a_x = a_mag*cos(omega);
    a_y = a_mag*sin(omega);
    acceleration = [a_x, a_y];

    [pos, vel] = move(pos, vel, acceleration, dt);
end

scatter(positions[1,:], positions[2,:])