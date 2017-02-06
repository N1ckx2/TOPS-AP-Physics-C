/* AP Physics C Lab 1A - Collision Simulator
 * Nicholas Vadivelu, Cheng Lin, Parnika Godkhindi, Khari Thomas
 * SPH4U0
 * 
 * Simulates the collision of two balls (elastic collision with spring forces)
 * The uncertainty propogation was calculated using the method of quadratures.
 */

using System;
using System.Collections;
using System.Collections.Generic;
using System.Linq;
using System.Text;
using System.Threading.Tasks;

namespace CollisionSimulator
{
    class Program
    {
        static Ball ball1, ball2; //The two ball objects used in the simulation
        static double tlimit; //The duration of the simulation (set by the user)
        static String filepath; //Destination of the file containing the simulation data
        static void Main(string[] args)
        { //main method
            Vector force = new Vector(0, 0, Vector.CARTESIAN); //this vector will store the spring force from the two balls

            /* The initial time step used. 
             * This program uses a dynamic timestep where the dt decreases proportionally
             * with the distance between the two balls. */
            double dt = 0.0001;

            /* the user is prompted to restart the program at the end.
             * if the user inputs 'y', the program will restart, otherwise the program ends. */
            char choice = 'y';

            Console.WriteLine("Welcome to the Stress Ball Collision Simulator.\n"); //Title

            while (choice != 'n')
            { //allows the user to run the program multiple times
                getUserInput(); // this method prompts user for the initial conditions of both balls

                //This arraylist will store the kinematic information until it is written into a .csv file
                ArrayList kinematicInfo = new ArrayList();

                /* This line adds headers to be used in the output spreadsheet.
                 * After the acceleration, the headers for physical properties of the ball are also stored (and sigmas) */
                kinematicInfo.Add("Time (s), ,Ball 1 sx (m), Ball 1 sy (m)," +
                                  "Ball 2 sx (m), Ball 2 sy (m), ," +
                            "Ball 1 vx (m s^-1), Ball 1 vy (m s^-1), ," +
                           "Ball 2 vx (m s^-1), Ball 2 vy (m s^-1), ," +
                           "Ball 1 ax (m s^-2), Ball 1 ay (m s^-2), " +
                           "Ball 2 ax (m s^-2), Ball 2 ay (m s^-2), ," +
                           "Force x (N), Force y (N), , ");

                /* this loop will run until t reaches the time limit (tlimit)
                 * At each iteration, it will recalculate the forces and kinematic properties of the ball */
                for (double t = 0; t < tlimit; t += dt)
                {
                    //stores kinematic information about the ball at this moment
                    kinematicInfo.Add(t.ToString() + ", ," + ball1.s.ToString() + ", " + ball2.s.ToString() + ", , " +
                                      ball1.v.ToString() + ", " + ball2.v.ToString() + ", , " +
                                      ball1.a.ToString() + ", " + ball2.a.ToString() + ", ," + force.ToString() + ", , ");

                    //this vector calculates the distance between the two balls
                    Vector dist = ball1.s.subtract(ball2.s);

                    /* Below the dynamic dt is computed. This formula was derived experimentally,
                     * as it produced a high resolution for the movement of the ball when it is in 
                     * contact (and thus kinematic properties are changing), while making the less
                     * eventful parts of the simulation run faster */
                    dt = dist.m / ball1.v.subtract(ball2.v).m / 100;
                    if (dt > 1)
                    {
                        dt = 1;
                    }
                    else if (dt < 0.00001)
                    {
                        dt = 0.00001;
                    }

                    /* Computes how much the balls are being compressed by subtracting the distance between
                     * the two centre of masses from the sum of the radii of the two balls. Thus, a negative
                     * indicates the balls are not touching, and a positive value indicates the balls are
                     * in contact and compressed. This value is an array with the first element being the
                     * compression and the second value being the uncertainty. This compression is the compression
                     * of both balls because both balls exert an equal and opposite force */
                    double compression = (ball1.r + ball2.r - dist.m);

                    /* when the compression is negative or zero, the balls are not touching
                     * Therefore there is spring force being exerted on either ball */
                    if (compression <= 0)
                    {
                        force = new Vector(0, 0, Vector.CARTESIAN); //creates a force of 0N (no force)
                    }
                    else
                    {
                        /* if the compression is greater than 0, the balls are in contact, therefore 
                         * there is a force being applied to both firstly, the ball1.ballforce() function
                         * calculates the spring force exerted by both balls, which would be equal. The 
                         * components of the force are calculated with the following logic: the x component 
                         * of the force is the magnitude of the force * cosine (theta). Cosine of theta is 
                         * equivalent to adjacent / hypoteneuse, which in this case is the x component / the 
                         * magnitude of the distance. Thus, the x component of the force is equal to
                         * force * xdistance / distance. A similar equation was derived for the y component. */
                        double f = ball1.calcSpringForce(compression);
                        force = new Vector(f * dist.x / dist.m, //x component
                                           f * dist.y / dist.m, //y component
                                           Vector.CARTESIAN);
                    }

                    ball1.applyForce(force, dt); //applies force to ball1

                    /* Newton's third law states that for every action there is an equal and opposite reaction.
                     * Thus, ball 2 experiences an equal an opposite force to ball 1
                     * therefore the negative force to ball 1 is applied to it */
                    ball2.applyForce(force.getNegative(), dt);
                }

                //outputs to a file with the current time stamp
                System.IO.File.WriteAllLines((@filepath + "\\CollisionSimulation " +
                                        DateTime.Now.ToString("@yyyy-MM-dd HH-mm-ss") + ".csv"),
                                            (string[])kinematicInfo.ToArray(typeof(string)));

                //asks user if they want to run the program again
                Console.Write("\nSimulation complete. \n\nRun again (y/n): ");
                choice = Console.ReadLine()[0]; //receives user's choice
                Console.WriteLine();
            }
        }

        //This method prompts user for the initial kinematic conditions of the bal
        private static void getUserInput()
        {
            //these temporary variables are to receive user input about the kinematic conditions
            double temp1 = 0, temp2 = 0;

            //vectors representing ball 1 and ball 2's position and velocity, respectively
            Vector s1, s2, v1, v2;

            //Prompt user for parameters of the simulation
            Console.Write("Would you like to input the initial conditions in cartesian or polar form?"
                          + "\nEnter 'c' for cartesian or 'p' for polar: ");

            /* user can choose to input vector information in cartesian or polar form
             * This argument indicates to the vector class whether or not the information is in 
             * polar or cartesian form */
            bool isComponent = Console.ReadLine()[0] != 'p';

            //Get Positional Information about ball 1
            Console.Write("\nStarting " + (isComponent ? "X " : "magnitude of the ") + "position of Ball 1: ");
            temp1 = Convert.ToDouble(Console.ReadLine()); //user inputs starting x or r position of ball 1

            Console.Write("Starting " + (isComponent ? "Y " : "theta (degrees) of the ") + "position of Ball 1: ");
            temp2 = Convert.ToDouble(Console.ReadLine()); //user inputs starting y or theta position of ball 1

            s1 = new Vector(temp1, temp2, isComponent); //creating the displacement vector for ball 1

            //Get Positional Information about ball 2
            Console.Write("\nStarting " + (isComponent ? "X " : "magnitude of the ") + "position of Ball 2: ");
            temp1 = Convert.ToDouble(Console.ReadLine()); //user inputs starting x or r position of ball 2

            Console.Write("Starting " + (isComponent ? "Y " : "theta (degrees) of the ") + "position of Ball 2: ");
            temp2 = Convert.ToDouble(Console.ReadLine()); //user inputs starting y or theta position of ball 2

            s2 = new Vector(temp1, temp2, isComponent); //creating the displacement vector for ball 2

            //Get velocity Information about ball 1
            Console.Write("\nStarting " + (isComponent ? "X " : "magnitude of the ") + "velocity of Ball 1: ");
            temp1 = Convert.ToDouble(Console.ReadLine()); //user inputs starting x or r position of ball 1

            Console.Write("Starting " + (isComponent ? "Y " : "theta (degrees) of the ") + "velocity of Ball 1: ");
            temp2 = Convert.ToDouble(Console.ReadLine()); //user inputs starting y or theta position of ball 1

            v1 = new Vector(temp1, temp2, isComponent); //creating the displacement vector for ball 1

            //Get velocity Information about ball 1
            Console.Write("\nStarting " + (isComponent ? "X " : "magnitude of the ") + "velocity of Ball 2: ");
            temp1 = Convert.ToDouble(Console.ReadLine()); //user inputs starting x or r position of ball 2

            Console.Write("Starting " + (isComponent ? "Y " : "theta (degrees) of the ") + "velocity of Ball 2: ");
            temp2 = Convert.ToDouble(Console.ReadLine()); //user inputs starting y or theta position of ball 2

            v2 = new Vector(temp1, temp2, isComponent); //creating the displacement vector for ball 2

            Console.Write("\nDuration of the simulation (s): "); //Prompt user to enter the duration of the simulation
            tlimit = Convert.ToDouble(Console.ReadLine());

            Console.Write("\nFilepath of the simulation data: "); //filepath to output the results of the simulation
            filepath = Console.ReadLine();

            //Create two ball objects with this information
            ball1 = new Ball(s1, v1);
            ball2 = new Ball(s2, v2);
        }
    }

    class Vector
    { //custom vector class to manipulate vectors in both polar and cartesian form
        public double x, y, theta, m; //variables storing components of the vector
        public static Boolean CARTESIAN = true;
        public static Boolean POLAR = false;
        public Vector(double a, double b, bool isCartesian)
        { //constructor 
            //the sa and sb parameters are the uncertainty for a and b respectively           
            if (isCartesian)
            { //if vector is created with cartesian components
                x = a;
                y = b;

                //the angle and magnitude are calculated below
                theta = Math.Atan2(y, x) % (2 * Math.PI);
                m = Math.Sqrt(x * x + y * y);
            }
            else
            {
                m = a;
                theta = b * Math.PI / 180; //convert degrees to radians

                //the x and y components are calculated below
                x = m * Math.Cos(theta);
                y = m * Math.Sin(theta);
            }
        }

        public Vector subtract(Vector vec)
        {//this functions returns the difference of two vectors.
            return new Vector(x - vec.x,
                              y - vec.y,
                              Vector.CARTESIAN);
        }

        public Vector getNegative()
        { //returns the negative vector
            return new Vector(-x, -y, Vector.CARTESIAN);
        }

        override public String ToString()
        { //converts the vector into a string to output t
            return x.ToString() +  "," + y.ToString();
        }

        public String Out()
        {
            return x.ToString() + "," + y.ToString();
        }
    }

    class Ball
    { //Ball class holds information regarding stress balls
        public Vector s, v, a; //kinematic vectors
        public double r; //radius of the ball in metres (and uncertainty of value)
        public double m; //mass of the ball in kilograms (and uncertainty of value)

        public Ball(Vector pos, Vector vel)
        { //initializes properties of the ball7
            s = pos; //user inputted position of ball
            v = vel;
            m = 0.119;
            r = 0.0307;
            a = new Vector(0, 0, Vector.CARTESIAN);
        }

        //computes the spring force exerted by the ball given compression
        public double calcSpringForce(double comp)
        {
            /* The force as a regressed quadratic function of the compression was found experimentally.
             * Let x = compression. F(x) = (14000 +/- 3000)x^2 + (950 +/- 70) */
            double force = 14000 * comp * comp + 950 * comp;
            return force;
        }

        public void applyForce(Vector force, double dt)
        {
            /* From newton's laws, F = ma. therefore, isolating for a, a = f/m. 
             * this equation is split into components and used to create the acceleration vector
             * the force comes from the spring force the balls exert on eachother */
            a = new Vector(force.x / m,
                           force.y / m,
                           Vector.CARTESIAN);

            /* The calculation of the uncertainties for the position and velocity depend upon whether or not acceleration
             * is zero. If it is zero, it is zerp with no uncertainty. Therefore, the uncertainty function must exclude
             * the acceleration. Otherwise, acceleration must be included in the calculation. As with the other uncertainty
             * calculations, the propogation was computed using the method of quadratures. */
            if (a.m == 0)
            {
                //the new position vector is compputed using the equation s = s0 + v0*t + 0.5*a*t^2 (in components)
                s = new Vector(s.x + v.x * dt + 0.5 * a.x * dt * dt,
                               s.y + v.y * dt + 0.5 * a.y * dt * dt,
                               Vector.CARTESIAN);

                //the new velocity vector is computed using the eqeuation v = a*t (in components)
                v = new Vector(v.x + a.x * dt,
                               v.y + a.y * dt,
                               Vector.CARTESIAN);
            }
            else
            {
                //the new position vector is compputed using the equation s = s0 + v0*t + 0.5*a*t^2 (in components)
                s = new Vector(s.x + v.x * dt + 0.5 * a.x * dt * dt,
                               s.y + v.y * dt + 0.5 * a.y * dt * dt,
                                Vector.CARTESIAN);

                //the new velocity vector is computed using the eqeuation v = a*t (in components)
                v = new Vector(v.x + a.x * dt,
                               v.y + a.y * dt,
                               Vector.CARTESIAN);
            }
        }
    }
}