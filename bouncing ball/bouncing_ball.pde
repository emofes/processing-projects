int startX = 450;
int startY = 225;

float x = 450;
float y = 225;

float easing = 0.05;

float lastX = 450;
float newX = 450;

float lastY = 225;
float newY = 225;

float change = 10;

float dx = 0.0;
float dy = 0.0;

float multiUpY = 1;
float multiDownY = 1;
float multiRightX = 1;
float multiLeftX = 1;

float increase = 0.1;

int radius = 24;
int edge = 50;
int inner = edge + radius;

int a = 0;
int b = 50;
int c = 100;

int colorUp = 5;

//used for changing ball and background color
//not used currently
color back = color(0, 80, 80);
color ballColor = color(a, b, c);

void setup() 
{
	size(900, 450);
	noStroke();
	ellipseMode(RADIUS);
	rectMode(CORNERS);

	background(back);

	//not really neccessary at the moment
	fill(100);
	rect(edge, edge, width - edge, height - edge);
}

void draw() 
{
	ballColor = color(80, 0, 0);

	background(back);

	//check if ball hit border 
	switchDirection();

	//movement for x
	//easing used for smoothing movement
	dx = newX - lastX;
	x += dx * easing;

	//movement for y
	dy = newY - lastY;
	y += dy * easing;

	//constrain used for testing, not really neccessary
	x = constrain(x, inner, width-inner);
	y = constrain(y, inner, height-inner);


	 fill(100);
	 rect(edge, edge, width - edge, height - edge);

	// set color and position of ball
	fill(ballColor);
	ellipse(x, y, radius, radius);
	
	
}

void keyPressed()
{
//ball direction and speed controlled by arrow keys
	if(key == CODED)
	{
		if(keyCode == RIGHT)
		{
			lastX = newX;
			newX += change;

			//for moving right new must be bigger
			newX = newX * multiRightX;
			
			//multi is used to increase speed for
			//each sequential button press
			multiRightX += 0.1;
			multiLeftX = 1; 	
		}
	}

	if(key == CODED)
	{
		if(keyCode == LEFT)
		{
			lastX = newX;
			newX -= change;

			//for moving left last must be bigger
			lastX = lastX * multiLeftX;

			multiLeftX += increase;
			multiRightX = 1;

		}
	}

	if(key == CODED)
	{
		if(keyCode == UP)
		{
			lastY = newY;
			newY -= change;	

			lastY = lastY * multiUpY;

			multiUpY += increase;
			multiDownY = 1;
		}
	}

	if(key == CODED)
	{
		if(keyCode == DOWN)
		{
			lastY = newY;
			newY += change;

			newY = newY * multiDownY;

			multiDownY += increase;
			multiUpY = 1;


		}
	}

	//reset when shift is pressed
	if(key == CODED)
	{
		if(keyCode == SHIFT)
		{
			reset();
		}
	}

	//increase ball radius
	if( key == 'x')
		radius += 4;

	//decrease ball radius
	if(key == 'z' && radius > 0)
		radius -= 4;

	//used for increasing/decreasing border size
	//not finished yet
	if(key == 'q' && edge > 5)
		edge -= 5;
	if(key == 'w')
		edge += 5;
}

//switch direction switched last and new 
//to change the direction of the ball when
//it hits a border
void switchDirection()
{
	float temp = 0;
	float temp2 = 1;

	if(x == inner || x == width-inner)
	{
		//colorSwitcher();

		temp = lastX;
		lastX = newX;
		newX = temp;

		temp2 = multiLeftX;
		multiLeftX = multiRightX;
		multiRightX = temp2;


	}

	if(y == inner || y== height-inner)
	{
		//colorSwitcher();

		temp = lastY;
		lastY = newY;
		newY = temp;

		temp2 = multiUpY;
		multiUpY = multiDownY;
		multiDownY = temp2;
	}
}

//used for changing color of ball
//and/or backround(not used currently) 
void colorSwitcher()
{
	if(a == 255)
		a = 0;
 	else
 		a += 5;

	if(b == 255)
		b = 0;
	else
		b += 5;

	if(c == 255)
		c = 0;
	else 
		c += 5;
}

//resets everything to initial values when the shift key is pressed
void reset()
{
	edge = 50;

	background(back);

	fill(100);
	rect(edge, edge, width - edge, height - edge);
	
	radius = 24;

	x = startX;
	lastX = startX;
	newX = startX;

	y = startY;
	lastY = startY;
	newY = startY;

	multiUpY = 1;
	multiDownY = 1;
	multiLeftX = 1;
	multiRightX = 1;	
}