# Numerical Methods Projects (MATLAB)

This repository contains two distinct numerical analysis projects developed as part of the Numerical Methods course at the Warsaw University of Technology. Both projects are implemented in MATLAB and focus on high-performance algorithms for root finding and function approximation.

## 📂 Repository Structure

* **`global-root-finder/`** - A tool for finding multiple real roots of nonlinear functions.
* **`trig-approximator-goertzel/`** - A tool for continuous trigonometric approximation with the implementation of Goertzel algorithm.

---

## 1. MATLAB Global Root Finder

**Location:** `global-root-finder/`

A numerical analysis tool designed to find multiple real roots of continuous nonlinear functions without relying on built-in solvers. This project was developed as a "Warm-up Task".

### 🚀 Features

* **No Built-in Solvers:** Does not use `fzero`, `roots`, or external toolboxes. Logic is implemented from scratch.
* **Vectorized Bisection:** Implements a custom bisection method capable of processing multiple intervals simultaneously for high performance.
* **Heuristic Range Generation:** Uses a logarithmic distribution of test points, optimized to be denser around zero.
* **Precision Control:** Adheres to strict convergence criteria based on machine epsilon.

### 🛠️ Key Files

* **`nlin.m`**: The main entry point. Orchestrates the global search and delegates refinement.
* **`bisection.m`**: Vectorized implementation of the bisection method.
* **`generateRanges.m`**: Generates a dense grid of initial search points using logspace.
* **`checkPrecision.m`**: Helper function verifying root bracketing intervals.

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

* **Continuous Approximation:** Calculates sine and cosine coefficients for a given trigonometric basis size.
* **Numerical Integration:** Implements the **Composite Trapezoidal Rule** to compute inner products.
* **Optimized Evaluation:** Uses the **Goertzel Algorithm**, which benchmarks showed to be approximately **3.17x faster** than standard summation for this task.
* **Unit Testing:** Includes a comprehensive suite of test scripts.

### 🛠️ Key Files

* **`P1Z60_KWO_approximation.m`**: Main driver function. Calculates the full set of Fourier coefficients.
* **`goertzel.m`**: Efficient evaluation of the trigonometric polynomial using recurrence relations.
* **`integral_trap.m`**: Implementation of the composite trapezoidal rule.
* **`P1Z60_KWO.pdf`**: Project documentation and presentation (in Polish), explaining the theory and test results.
* **Tests:**
* `test*.m`: Basic correctness tests for the algorithms.
* `numtest*.m`: Numerical tests checking convergence and precision.


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

## 👤 Author

**Krzysztof Wójtowicz**
Warsaw University of Technology