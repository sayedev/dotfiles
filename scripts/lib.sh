set -g RED '\033[0;31m'
set -g GREEN '\033[0;32m'
set -g YELLOW '\033[1;33m'
set -g BLUE '\033[0;34m'
set -g MAGENTA '\033[0;35m'
set -g CYAN '\033[0;36m'
set -g NC '\033[0m' # No Color

# Function to print section headers
function print_header
    echo -e "\n$CYAN╔════════════════════════════════════════════════════════════════╗$NC"
    echo -e "$CYAN║$NC $MAGENTA$argv$NC"
    echo -e "$CYAN╚════════════════════════════════════════════════════════════════╝$NC\n"
end

# Function to print info messages
function print_info
    echo -e "$BLUE""[INFO]$NC $argv"
end

# Function to print success messages
function print_success
    echo -e "$GREEN""[SUCCESS]$NC $argv"
end

# Function to print warning messages
function print_warning
    echo -e "$YELLOW""[WARNING]$NC $argv"
end

# Function to print error messages
function print_error
    echo -e "$RED""[ERROR]$NC $argv"
end

# Reload udev rules and re-apply them to present devices.
function reload_udev
    sudo udevadm control --reload-rules
    sudo udevadm trigger
end
