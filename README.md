# Numerical Methods Projects (MATLAB)

This repository contains two distinct numerical analysis projects developed as part of the Numerical Methods course at the Warsaw University of Technology. Both projects are implemented in MATLAB and focus on high-performance algorithms for root finding and function approximation.

## 📂 Repository Structure

- **`global-root-finder/`** - A tool for finding multiple real roots of nonlinear functions.
- **`trig-approximator-goertzel/`** - A tool for continuous trigonometric approximation with the implementation of Goertzel algorithm.

---

## 1. MATLAB Global Root Finder

**Location:** `global-root-finder/`

A numerical analysis tool designed to find multiple real roots of continuous nonlinear functions without relying on built-in solvers. This project was developed as a "Warm-up Task".

### 🚀 Features

- **No Built-in Solvers:** Does not use `fzero`, `roots`, or external toolboxes. Logic is implemented from scratch.
- **Vectorized Bisection:** Implements a custom bisection method capable of processing multiple intervals simultaneously for high performance.
- **Heuristic Range Generation:** Uses a logarithmic distribution of test points, optimized to be denser around zero.
- **Precision Control:** Adheres to strict convergence criteria based on machine epsilon.

### 🛠️ Key Files

- **`nlin.m`**: The main entry point. Orchestrates the global search and delegates refinement.
- **`bisection.m`**: Vectorized implementation of the bisection method.
- **`generateRanges.m`**: Generates a dense grid of initial search points using logspace.
- **`checkPrecision.m`**: Helper function verifying root bracketing intervals.

### 💻 Usage

```matlab
cd global-root-finder
f = @(x) sin(x);
roots = nlin(f);

```

---

## 2. TrigApproximator: Continuous Fourier Analysis Tool

**Location:** `trig-approximator-goertzel/`

A tool for continuous trigonometric approximation of functions on the [0, 2*pi] interval. It calculates Fourier coefficients using numerical integration and evaluates the resulting series using the efficient Goertzel algorithm.

### 🚀 Features

- **Continuous Approximation:** Calculates sine and cosine coefficients for a given trigonometric basis size.
- **Numerical Integration:** Implements the **Composite Trapezoidal Rule** to compute inner products.
- **Optimized Evaluation:** Uses the **Goertzel Algorithm**, which benchmarks showed to be approximately **3.17x faster** than standard summation for this task.
- **Unit Testing:** Includes a comprehensive suite of test scripts.

### 🛠️ Key Files

- **`P1Z60_KWO_approximation.m`**: Main driver function. Calculates the full set of Fourier coefficients.
- **`goertzel.m`**: Efficient evaluation of the trigonometric polynomial using recurrence relations.
- **`integral_trap.m`**: Implementation of the composite trapezoidal rule.
- **`P1Z60_KWO.pdf`**: Project documentation and presentation (in Polish), explaining the theory and test results.
- **Tests:**
- `test*.m`: Basic correctness tests for the algorithms.
- `numtest*.m`: Numerical tests checking convergence and precision.

### 💻 Usage

```matlab
cd trig-approximator-goertzel

% Define function and parameters
f = @(x) exp(sin(x));
N = 5;   % Basis size
n = 100; % Subintervals

% Calculate coefficients
[c, s] = P1Z60_KWO_approximation(f, N, n);

% Evaluate using Goertzel
x_points = linspace(0, 2*pi, 100);
y_approx = goertzel(c, s, x_points);

plot(x_points, f(x_points), x_points, y_approx);

```

---

## 3. N-Order ODE Solver: Runge-Kutta 4th Order

**Location:** `n-order-ode-rk4/`

A robust numerical solver for linear ordinary differential equations (ODEs) of any arbitrary order $k$. It automatically reduces the $k$-th order equation into a system of first-order equations and solves it using various 4th-order Runge-Kutta methods.

### 🚀 Features

- **Arbitrary Order Support:** Capable of solving linear ODEs of any order by dynamically generating the state-space derivative vector $Y'$.
- **Multiple RK4 Variants:** Implements three distinct 4th-order Runge-Kutta methods for comparative analysis:
  - **Classic RK4**
  - **Gill's Method**
  - **3/8 Rule Method**
- **Stability & Convergence Analysis:** Includes built-in test scripts demonstrating convergence rates ($\mathcal{O}(h^4)$), stability limits on stiff equations ($y' = -100y$), and performance benchmarks using the Chebyshev polynomial equation.

### 🛠️ Key Files

- **`P2Z45_KWO_classicRungeKutta.m`**: Main solver utilizing the classic RK4 method.
- **`RKgill.m` & `RK38.m`**: Alternative solvers using Gill's and the 3/8 rule methods.
- **`dF.m`**: The core function that evaluates the derivatives by reducing the $k$-th order ODE into a 1st-order system.
- **`setup.m`**: Helper function for initializing the step size and state vectors.
- **`numtest*.m`**: A suite of numerical tests generating diagnostic plots for accuracy, stability, and speed comparisons.
- **`test*.m`**: Basic correctness tests for the algorithms.
- **`P2Z45_KWO.pdf`**: Comprehensive project presentation (in Polish) detailing the mathematical background, reduction methodology, and test results.

### 💻 Usage

```matlab
cd n-order-ode-rk4

% Define the problem: y'' + 10000y = 0
% Form: a{3}y'' + a{2}y' + a{1}y = b(x)
b = @(x) 0;
a = { @(x) 10000, @(x) 0, @(x) 1 };

% Integration interval and initial conditions: y(0)=0, y'(0)=100
x0 = 0;
xN = 1;
y0 = [0; 100];
N = 100; % Number of steps

% Solve using Classic RK4
y_num = P2Z45_KWO_classicRungeKutta(b, a, x0, xN, y0, N);

% Plot the results
x_grid = linspace(x0, xN, N+1);
plot(x_grid, y_num);
title('RK4 Solution for y'''' + 10000y = 0');
```

---

**Author:** Krzysztof Wójtowicz<br>
**Course:** Numerical Methods 2 (Metody Numeryczne 2) @ MiNI WUT
