$response=""

write-host -nonewline "Continue? (Y/N) "
$response = read-host


if($response = "Y") {
   write-host "continua..."
}else {
   write-host "não continua..."
   exit
}