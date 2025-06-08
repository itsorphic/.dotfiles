//Modify this file to change what commands output to your statusbar, and recompile using the make command.
static const Block blocks[] = {
	/*Icon*/	/*Command*/		/*Update Interval*/	/*Update Signal*/
	{"   ", "iwgetid -r", 5, 0},
	{"    ", "curl -s ifconfig.me 2>/dev/null | cut -c1-10", 300, 0},
	{"    ", "sensors | awk '/Tctl:/ {print $2}'", 30, 0},
	{" 🔊  ", "amixer get Master | awk -F'[][]' 'END{ print $2 }'", 0, 10},
	{"   ", "free -h | awk '/^Mem/ { print $3\"/\"$2 }' | sed s/i//g",	30,		0},
	{"  ", "date '+%b %d (%a) %I:%M%p'",					5,		0},
};

//sets delimiter between status commands. NULL character ('\0') means no delimiter.
static char delim[] = " | ";
static unsigned int delimLen = 5;
