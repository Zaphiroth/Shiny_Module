library(rsconnect)

rsconnect::setAccountInfo(name='lzihue',
                          token='7CEB00FF2A899E36005D310E0843B2D7',
                          secret='D1xseRqcSIRCKGaVZMfjOuhmnmZ/a4pdblt2yXnE')

rsconnect::deployApp("regression")