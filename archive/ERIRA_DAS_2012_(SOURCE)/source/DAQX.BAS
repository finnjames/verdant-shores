Attribute VB_Name = "DAQ32"
Option Explicit
DefLng A-Z

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'    Initialization/Error Handling Definitions and Prototypes   '
'                                                              '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
Global daqErrno&
Global stopacq As Boolean


' Error Code Definitions
Global Const DerrNoError& = &H0          '   0 - No error
Global Const DerrBadChannel& = &H1       '   1 - Specified LPT channel was out of range
Global Const DerrNotOnLine& = &H2        '   2 - Requested DAQBook is not on line
Global Const DerrNoDaqbook& = &H3        '   3 - DAQBook is not on the requested channel
Global Const DerrBadAddress& = &H4       '   4 - Bad function address
Global Const DerrFIFOFull& = &H5         '   5 - FIFO Full detected, possible data corruption
Global Const DerrBadDma& = &H6           '   6 - Bad or illegal DMA channel or mode specified for DaqBoard
Global Const DerrBadInterrupt& = &H7     '   7 - Bad or illegal INTERRUPT level specified for DaqBoard
Global Const DerrDmaBusy& = &H8          '   8 - Dma is currently being used
                                         '
Global Const DerrInvChan& = &H10         '  16 - Invalid channel
Global Const DerrInvCount& = &H11        '  17 - Invalid count parameter
Global Const DerrInvTrigSource& = &H12   '  18 - Invalid trigger source parameter
Global Const DerrInvLevel& = &H13        '  19 - Invalid trigger level parameter
Global Const DerrInvGain& = &H14         '  20 - Invalid channel gain parameter
Global Const DerrInvDacVal& = &H15       '  21 - Invalid DAC output parameter
Global Const DerrInvExpCard& = &H16      '  22 - Invalid expansion card parameter
Global Const DerrInvPort& = &H17         '  23 - Invalid port parameter
Global Const DerrInvChip& = &H18         '  24 - Invalid chip parameter
Global Const DerrInvDigVal& = &H19       '  25 - Invalid digital output parameter
Global Const DerrInvBitNum& = &H1A       '  26 - Invalid bit number parameter
Global Const DerrInvClock& = &H1B        '  27 - Invalid clock parameter
Global Const DerrInvTod& = &H1C          '  28 - Invalid time of day parameter
Global Const DerrInvCtrNum& = &H1D       '  29 - Invalid counter number
Global Const DerrInvCntSource& = &H1E    '  30 - Invalid counter source parameter
Global Const DerrInvCtrCmd& = &H1F       '  31 - Invalid counter command parameter
Global Const DerrInvGateCtrl& = &H20     '  32 - Invalid gate control parameter
Global Const DerrInvOutputCtrl& = &H21   '  33 - Invalid output control parameter
Global Const DerrInvInterval& = &H22     '  34 - Invalid interval parameter
Global Const DerrTypeConflict& = &H23    '  35 - An integer was passed to a function requiring a character
Global Const DerrMultBackXfer& = &H24    '  36 - A second background transfer was requested
Global Const DerrInvDiv& = &H25          '  37 - Invalid Fout divisor
                                         '
' Temperature Conversion Errors
Global Const DerrTCE_TYPE& = &H26        '  38 - tcType out of range
Global Const DerrTCE_TRANGE& = &H27      '  39 - Temp out of cjc range
Global Const DerrTCE_VRANGE& = &H28      '  40 - Voltage out of tc range
Global Const DerrTCE_PARAM& = &H29       '  41 - Unspecified parameter value error
Global Const DerrTCE_NOSETUP& = &H2A     '  42 - dacTCConvert called before dacTCSetup
                                         '
' Daqbook
Global Const DerrNotCapable& = &H2B      '  43 - Daqbook is incapable of certain functions
                                         '
' Background
Global Const DerrOverrun& = &H2C         '  44 - ADC data acquired too fast, but all data is valid
                                         '
' Zero and Cal Conversion Errors
Global Const DerrZCInvParam& = &H2D      '  45 - Unspecified parameter value error
Global Const DerrZCNoSetup& = &H2E       '  46 - dac...Convert called before dac...Setup
Global Const DerrInvCalFile& = &H2F      '  47 - Cannot open the specified cal file
                                         '
' Environmental Errors
Global Const DerrMemLock& = &H30         '  48 - Can't lock allocated memory from Windows
Global Const DerrMemHandle& = &H31       '  49 - Can't get a memory handle from Windows
                                         '
' Pre-trigger Acquisition Errors
Global Const DerrNoPreTActive& = &H32    '  50 - No pre-trigger configured
                                         '
' Dac FIFO Errors (DaqBoard Only)
Global Const DerrInvDacChan& = &H33      '  51 - Dac channel doesn't exist
Global Const DerrInvDacParam& = &H34     '  52 - Dac parameter invalid
Global Const DerrInvBuf& = &H35          '  53 - Buffer points to NULL or size = zero
Global Const DerrMemAlloc& = &H36        '  54 - Could not allocate the needed memory
Global Const DerrUpdateRate& = &H37      '  55 - Could not achieve the specified update rate
Global Const DerrInvDacWave& = &H38      '  56 - Could not start waveforms because of missing or invalid parameters
Global Const DerrInvBackDac& = &H39      '  57 - Could not start waveforms with background transfers
Global Const DerrInvPredWave& = &H3A     '  58 - Predefined waveform not supported
                                         '
' RTD Conversion Errors
Global Const DerrRtdValue& = &H3B        '  59 - rtdValue out of range
Global Const DerrRtdNoSetup& = &H3C      '  60 - rtdConvert called before rtdSetup
Global Const DerrRtdTArraySize& = &H3D   '  61 - Temperature array not large enough
Global Const DerrRtdParam& = &H3E        '  62 - Incorrect rtd parameter

Global Const InvBankType& = &H3F         '  63 - Invalid bank type specified
Global Const DerrBankBoundary& = &H40    '  64 - Simultaneous writes to Dbk cards in different banks not allowed

Global Const DerrInvFreq& = &H41         '  65 - Invalid Frequency
Global Const DerrNoDaq = &H42            '  66 - No IOtech Daq 112B/216B installed

Global Const DerrInvOptionType& = &H43   '  67 - Used for invalid option types
Global Const DerrInvOptionValue& = &H44  '  68 - Used for invalid option values
                                         
' Bank Errors
Global Const DerrTooManyHandles& = &H60  '  96 - No more handles available to open
Global Const DerrInvLockMask& = &H61     '  97 - Only a part of the resource is already locked, must be all or none
Global Const DerrAlreadyLocked& = &H62   '  98 - All or part of the resource was locked by another app
                                         '
Global Const DerrAcqArmed& = &H63        '  99 - Operation not available while an acquisition is armed
Global Const DerrParamConflict& = &H64   ' 100 - Each parameter is valid, but the combination is invalid
Global Const DerrInvMode& = &H65         ' 101 - Invalid acquisition/wait/dac mode
Global Const DerrInvOpenMode& = &H66     ' 102 - Invalid file open mode
                                         '
Global Const DerrFileOpenError& = &H67   ' 103 - Unable to open file
Global Const DerrFileWriteError& = &H68  ' 104 - Unable to write file
Global Const DerrFileReadError& = &H69   ' 105 - Unable to read file
                                         '
Global Const DerrInvClockSource& = &H6A  ' 106 - Invalid acquisition mode
Global Const DerrInvEvent& = &H6B        ' 107 - Invalid transfer event
                                         '
Global Const DerrTimeout& = &H6C         ' 108 - Timeout on wait
Global Const DerrInitFailure& = &H6D     ' 109 - Unexpected result occurred while initializing the hardware
Global Const DerrBufTooSmall& = &H6E     ' 110 - Buffer too small
Global Const DerrInvType& = &H6F         ' 111 - Invalid Dac Device type or info type
                                         '
Global Const DerrArraySize& = &H70       ' 112 - Used as a catch all for arrays not large enough
Global Const DerrBadAlias& = &H71        ' 113 - Invalid alias names for Vxd lookup
Global Const DerrInvCommand& = &H72      ' 114 - Invalid comamnd
Global Const DerrInvHandle& = &H73       ' 115 - Invalid handle

Global Const DerrNoTransferActive& = &H74  ' 116 - transfer not active
Global Const DerrNoAcqActive& = &H75       ' 117 - acq. not active
Global Const DerrInvOpstr& = &H76          ' 118 - invalid op string used for enhanced triggering
Global Const DerrDspCommFailure& = &H77    ' 119 - device with DSP failed communication
Global Const DerrEepromCommFailure& = &H78 ' 120 - device with Eeprom failed communication
Global Const DerrInvEnhTrig& = &H79        ' 121 - devices using enhanced trigger, detected invalid trig type
Global Const DerrInvCalConstant& = &H7A    ' 122 - user calibration constant out of range
Global Const DerrInvErrorCode& = &H7B      ' 123 - Invalid error code
Global Const DerrInvAdcRange = &H7C        ' 124 - Invalid analog input voltage range parameter
Global Const DerrInvCalTableType = &H7D    ' 125 - Invalid calibration table type
Global Const DerrInvCalInput = &H7E        ' 126 - Invalid calibration input signal selection
Global Const DerrInvRawDataFormat = &H7F   ' 127 - Invalid raw data format selection
Global Const DerrNotImplemented& = &H80    ' 128 - Feature/function not implemented
Global Const DerrInvDioDeviceType& = &H81  ' 129 - invalid digital I/O device type
Global Const DerrInvPostDataFormat& = &H82 ' 130 - invalid post-processing data format selection

Global Const DerrDaqStalled& = &H83         ' 131 - Low level driver stalled
Global Const DerrDaqLostPower& = &H84       ' 132 - Daq Device has lost power
Global Const DerrDaqMissing& = &H85         ' 133 - Daq Device is missing
Global Const DerrScanConfig& = &H86         ' 134 - Invalid channel scan config
Global Const DerrInvTrigSense& = &H87       ' 135 - Invalid trigger sense parameter
Global Const DerrInvTrigEvent& = &H88       ' 136 - Invalid trigger event parameter
Global Const DerrInvTrigChannel& = &H89     ' 137 - Trigger channel not in scan
   
Global Const DerrDacWaveformNotActive& = &H8A   ' 138 - DAC waveform output not active
Global Const DerrDacWaveformActive& = &H8B      ' 139 - DAC waveform output already active
Global Const DerrDacNotEnoughMemory& = &H8C     ' 140 - DAC static waveforms exceed maximum length
Global Const DerrDacBuffersNotEqual& = &H8D     ' 141 - DAC static waveforms unequal length
Global Const DerrDacBufferTooSmall& = &H8E      ' 142 - DAC dynamic waveform buffer too small
Global Const DerrDacBufferUnderrun& = &H8F      ' 143 - DAC dynamic waveform buffer underrun
Global Const DerrDacPacerOverrun& = &H90        ' 144 - DAC pacer overrun
   
Global Const DerrAdcPacerOverrun& = &H91        ' 145 - ADC pacer overrun
Global Const DerrAdcNotReady& = &H92            ' 146 - ADC not ready
Global Const DerrArbitrationFailure& = &H93     ' 147 - Internal bus arbitration error

Global Const DerrDacWaveFileTooSmall& = &H94    ' 148 - DAC waveform file too small for requested use
Global Const DerrDacWaveFileUnderrun& = &H95    ' 149 - DAC waveform file buffer underrun
Global Const DerrDacWaveModeConflict& = &H96    ' 150 - DAC waveform mode, buffer, or source conflict
Global Const DerrTedsInfoInvStatus& = &H97      ' 151 - No TEDs available

Global Const DerrAlreadyCreated& = &H98         ' 152 - Device to create already exists
Global Const DerrParentNotCreated& = &H99       ' 153 - Parent device of the device to create does not exist
Global Const DerrUnableToCreateDevice& = &H9A   ' 154 - Unable to create the spcified device
Global Const DerrUnableToDeleteDevice& = &H9B   ' 155 - Unable to delete the spcified device
Global Const DerrInvIPAddress& = &H9C           ' 156 - Invalid IP address


' Initialization and Locking Prototypes
Declare Function BdaqOpen& Lib "daqx.dll" Alias "daqOpen" (ByVal daqName$)
Declare Function BdaqClose& Lib "daqx.dll" Alias "daqClose" (ByVal handle&)
Declare Function BdaqOnline& Lib "daqx.dll" Alias "daqOnline" (ByVal handle&, online&)

' Error Handler Function Prototypes
Declare Function BdaqSetDefaultErrorHandler& Lib "daqx.dll" Alias "daqSetDefaultErrorHandler" (ByVal handler&)
Declare Function BdaqSetErrorHandler& Lib "daqx.dll" Alias "daqSetErrorHandler" (ByVal handle&, ByVal handler&)
Declare Function BdaqProcessError& Lib "daqx.dll" Alias "daqProcessError" (ByVal handle&, ByVal errCode&)
Declare Function BdaqGetLastError& Lib "daqx.dll" Alias "daqGetLastError" (ByVal handle&, errCode&)
Declare Sub BdaqDefaultErrorHandler Lib "daqx.dll" Alias "daqDefaultErrorHandler" (ByVal handle&, ByVal errCode&)
Declare Function BdaqFormatError& Lib "daqx.dll" Alias "daqFormatError" (ByVal errorNum&, ByRef msg As Byte)

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'                                                                 '
'         Event Handling Definitions and Prototypes               '
'                                                                 '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' Transfer Event Definitions
Global Const DteAdcData& = 0
Global Const DteAdcDone& = 1
Global Const DteDacData& = 2    'unsupported
Global Const DteDacDone& = 3    'unsupported
Global Const DteIOData& = 4     'unsupported
Global Const DteIODone& = 5     'unsupported

' Transfer Event Wait Mode Definitions
Global Const DwmNoWait& = 0
Global Const DwmWaitForAny& = 1
Global Const DwmWaitForAll& = 2

' Event Handling Function Prototypes
Declare Function BdaqSetTimeout& Lib "daqx.dll" Alias "daqSetTimeout" (ByVal handle&, ByVal mSecTimeout&)
Declare Function BdaqWaitForEvent& Lib "daqx.dll" Alias "daqWaitForEvent" (ByVal handle&, ByVal daqEvent&)
Declare Function BdaqWaitForEvents& Lib "daqx.dll" Alias "daqWaitForEvents" (handles&, events&, ByVal eventCount&, eventSet&, ByVal waitMode&)

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'                                                               '
'        Hardware Information Definitions and Prototypes        '
'                                                               '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' Hardware Information Selector Definitions
Global Const DhiHardwareVersion& = 0
Global Const DhiProtocol& = 1
Global Const DhiADmin& = 3
Global Const DhiADmax& = 4
Global Const DhiHardwareSubType& = 11

' General Information Selector Definitions

Global Const DdiHardwareVersionInfo& = 0
Global Const DdiProtocolInfo& = 1
Global Const DdiChTypeInfo& = 2
Global Const DdiChOptionTypeInfo& = 3
Global Const DdiADminInfo& = 4
Global Const DdiADmaxInfo& = 5
Global Const DdiChanCountInfo& = 6
Global Const DdiNVRAMDateInfo& = 7               'date string
Global Const DdiNVRAMTimeInfo& = 8               'time string
Global Const DdiDbk4MaxFreqInfo& = 9
Global Const DdiDbk4SetBaselineInfo& = 10
Global Const DdiDbk4ExcitationInfo& = 11
Global Const DdiDbk4ClockInfo& = 12
Global Const DdiDbk4GainInfo& = 13    ' internally used by daqAdcSetScan
Global Const DdiDbk7SlopeInfo& = 14
Global Const DdiDbk7DebounceTimeInfo& = 15
Global Const DdiDbk7MinFreqInfo& = 16
Global Const DdiDbk7MaxFreqInfo& = 17
Global Const DdiDbk55SlopeInfo& = DdiDbk7SlopeInfo&
Global Const DdiDbk55DebounceTimeInfo& = DdiDbk7DebounceTimeInfo&
Global Const DdiDbk55MinFreqInfo& = DdiDbk7MinFreqInfo&
Global Const DdiDbk55MaxFreqInfo& = DdiDbk7MaxFreqInfo&
Global Const DdiDbk50GainInfo& = 18        ' internally used by daqAdcSetScan
Global Const DdiWbk12FilterCutOffInfo& = 19
Global Const DdiWbk12FilterTypeInfo& = 20
Global Const DdiWbk12FilterModeInfo& = 21
Global Const DdiWbk12PreFilterModeInfo& = 22
Global Const DdiWbk13FilterCutOffInfo& = 23
Global Const DdiWbk13FilterTypeInfo& = 24
Global Const DdiWbk13FilterModeInfo& = 25
Global Const DdiWbk13PreFilterModeInfo& = 26
Global Const DdiWbk14LowPassModeInfo& = 27
Global Const DdiWbk14LowPassCutOffInfo& = 28
Global Const DdiWbk14HighPassCutOffInfo& = 29
Global Const DdiWbk14CurrentSrcInfo& = 30
Global Const DdiWbk14PreFilterModeInfo& = 31
Global Const DdiWbk14ExcSrcWaveformInfo& = 32
Global Const DdiWbk14ExcSrcFreqInfo& = 33
Global Const DdiWbk14ExcSrcAmplitudeInfo& = 34
Global Const DdiWbk14ExcSrcOffsetInfo& = 35
Global Const DdiWgcX1Info& = 36
Global Const DdiWgcX2Info& = 37
Global Const DdiWgcX5Info& = 38
Global Const DdiWgcX10Info& = 39
Global Const DdiWgcX20Info& = 40
Global Const DdiWgcX50Info& = 41
Global Const DdiWgcX100Info& = 42
Global Const DdiWgcX200Info& = 43
Global Const DdiPreTrigFreqInfo& = 44
Global Const DdiPostTrigFreqInfo& = 45
Global Const DdiPreTrigPeriodInfo& = 46
Global Const DdiPostTrigPeriodInfo& = 47
Global Const DdiOptNVRAMDateInfo& = 48
Global Const DdiOptNVRAMTimeInfo& = 49
Global Const DdiExtFeatures& = 50           '' DaqHardwareExtFeatures
Global Const DdipDaqCalibrationTime& = 50   '' Personal Daq initial calibration period in ms
Global Const DdiFifoSize& = 51              '' FIFO capacity in WORD's of data
Global Const DdiFifoCount& = 52             '' Count of WORD's of data currently in the FIFO
Global Const DdiSerialNumber& = 53          '' Serial Number String
Global Const DdiAdcClockSource& = 54        '' Current Clock Source
Global Const DdiFirmwareVersion& = 55       '' Firmware Version (String)
Global Const DdiHardwareVersion& = 56       '' Hardware Version (String)
Global Const DdiDriverVersion& = 57         '' Driver Version   (String)
Global Const DdiAdcTriggerScan& = 58            ''Trigger Scan Number (DWORD)          : DaqBoard/2000 only
Global Const DdiAdcPreTriggerCount& = 59        '' Amount of Pre-Trigger Scans (DWORD) : DaqBoard/2000 only
Global Const DdiAdcPostTriggerCount& = 60       '' Amount of Post-Trigger Scans (DWORD): DaqBoard/2000 only
Global Const DdiDetectSensor& = 61              '' Detects the presence of an external sensor (DWORD): WaveBook Wbk14 only
Global Const DdiWbk12PreFilterCutOffInfo& = 62  '' Wbk12/Wbk12A pre-filter cutoff freq (FLOAT)
Global Const DdiWbk12PostFilterCutOffInfo& = 63 '' Wbk12A post-filter cutoff freq      (FLOAT)
Global Const DdiWbk13PreFilterCutOffInfo& = 64  '' Wbk13/Wbk13A pre-filter cutoff freq (FLOAT)
Global Const DdiWbk13PostFilterCutOffInfo& = 65 '' Wbk13A post-filter cutoff freq      (FLOAT)
Global Const DdiAdcLastRawTransferCount = 66 ', // undocumented.
Global Const DdiWgcX0_2Info = 67         'Wbk18 -25 to 25 volt range
Global Const DdiWbk18OpenSensorStatus = 68
Global Const DdiWbk18PosOverRangeStatus = 69
Global Const DdiWbk18NegOverRangeStatus = 70
Global Const DdiWbk18LowPassMode = 71         ' Enumeration: Bypass, 8 pole and 2 pole
Global Const DdiWbk18LowPassCutOff = 72       ' 5 - 50000 (Hz) : selectable filter range in hertz
Global Const DdiWbk18HighPassCutOff = 73      ' Enumeration: DC,0.1Hz and 10Hz
Global Const DdiWbk18CurrentSrc = 74          ' Enumeration: Off and 4mA
Global Const DdiWbk18OverRangeEnable = 75     ' option value is 8 bit mask representing the 8 channels- zero disables all
Global Const DdiWbk18esMode = 76              ' zero,off,continuous output or Swept (sweep through up to 1024 freqs)
Global Const DdiWbk18esFreq = 77              ' 0.01Hz - 5000Hz
Global Const DdiWbk18esAmplitude = 78         ' Enumeration: 7 amplitudes
Global Const DdiWbk18esFreqCycleTime = 79     ' Swept Mode:freq-to-freq time in seconds (50uS to 1,342,000uS)
Global Const DdiWbk18esFreqDurationTime = 80  ' Swept Mode:total time to sweep all freqs ( 5uS to 85,899,000uS)
Global Const DdiWbk18OverRangeLimit = 81      ' 1 - 100 (%)   : percentage of selected range
Global Const DdiWbk18esImmediate = 82         ' used to reset, turn on and turn off the excitation source
Global Const DdiWbk18esRelay = 83             ' used to specify output relay on/off
Global Const DdiWbk18OpenSensorStatusAll = 84 ' returns an 8 bit value indicating status for all 8 channels
Global Const DdiWbk18PosOverRangeStatusAll = 85 ' returns an 8 bit value indicating status for all 8 channels
Global Const DdiWbk18NegOverRangeStatusAll = 86 ' returns an 8 bit value indicating status for all 8 channels
Global Const DdiParentName = 87                  'NOT USED
Global Const DdiBaseAddress = 88                 'NOT USED
Global Const DdiWbk18TEDsStatus = 89             'returns one byte of status:
                                                 ' 0=TEDs found,Operation complete
                                                 ' 1 = Teds operation busy
                                                 ' 2 = Operation complete, NO TEDs
                                                 ' 4 = Channel is shorted
Global Const DdiWbk18TEDsData = 90               ' // returns 34 byte array of TEDs info as follows:
                                                                                                 '// info[0] = status
                                                                                                 '// info[1] = amount of teds data available
                                                                                                 '// info[2] = first byte of teds data if available
                                                                                                 '// infor[3..33] = teds data

Global Const DdiWbk18TEDsDataCount = 91             ' returns a byte indicating available teds data (typically 32)
Global Const DdiChSubTypeInfo = 92
Global Const DdiChOptionSubTypeInfo = 93
Global Const DdiETASTimeStamp = 94
Global Const DdiETASSenderID = 95
Global Const DdiETASTopologyReg = 96

' Detect TEDs definitions
Global Const DdsTEDsFound& = 0                ' sensor was not detected
Global Const DdsTEDsBusy& = 1                 ' sensor was detected
Global Const DdsTEDsNotFound& = 2             ' the sensor presence or absense could not be determined
Global Const DdsTEDsShorted& = 3              ' channel is shorted

' Detect sensor definitions.  These values are returned by
' daqGetInfo when the DaqInfo type DdiDetectSensor is specified.
Global Const DdsNotDetected& = 0   ' sensor was not detected
Global Const DdsDetected& = 1      ' sensor was detected
Global Const DdsIndeterminate& = 2 ' the sensor presence or absense could not be determined

' Hardware Information Extended Feature Bits.  These values are returned by
' daqGetInfo when the DaqInfo type DdiExtFeatures is specified.
'' Wavebook Mega-FIFO features.
Global Const DhefFifoOverflowMode& = &H1    '' FIFO has Overflow Protection mode.
Global Const DhefFifoCycleMode& = &H2       '' FIFO has Cycle ("Finite") Mode
Global Const DhefFifoDataCount& = &H4       '' FIFO has readable current-WORD's-of-data count'
'' Wavebook516 features.
Global Const DhefTrigDigPattern& = &H10     '' Can trigger on a digital pattern
Global Const DhefTrigPulseInput& = &H20     '' Can trigger on a pulse input
Global Const DhefAcqClkExternal& = &H40     '' Can pace acquisition to an external clock

' WaveBook A series features
Global Const DhefSyncMaster& = &H100       ' Can be Sync Master (drive Clock and Trigger)
Global Const DhefSyncSlave& = &H200         ' Can be Sync Slave (drive Clock and Trigger)

' Hardware Version Definitions
Global Const DaqBook100& = 0
Global Const DaqBook112& = 1
Global Const DaqBook120& = 2
Global Const DaqBook200& = 3
Global Const DaqBook216& = 4
Global Const DaqBoard100& = 5
Global Const DaqBoard112& = 6
Global Const DaqBoard200& = 7
Global Const DaqBoard216& = 8
Global Const Daq112& = 9
Global Const Daq216& = 10
Global Const WaveBook512& = 11
Global Const WaveBook516& = 12
Global Const TempBook66& = 13
Global Const PersonalDaq56& = 14
Global Const WaveBook516_250& = 15
Global Const WaveBook512_10V& = 16
Global Const DaqBoard2000& = 17
Global Const DaqBoard2001& = 18
Global Const DaqBoard2002& = 19
Global Const DaqBoard2003& = 20
Global Const DaqBoard2004& = 21
Global Const DaqBoard2005& = 22
Global Const DaqBook2000& = 23
Global Const WaveBook512A& = 29
Global Const WaveBook516A& = 30
Global Const WBK25& = 31
Global Const WBK40& = 32
Global Const WBK41& = 33
Global Const DaqBoard1000& = 34
Global Const DaqBoard1005& = 35
Global Const DaqLab2000& = 36
Global Const DaqScan2000& = 37

' Hardware Sub Type Definitions

' a hardware sub type of DaqSubTypeDefault
' indicates that the hardware device type
' is defined by the hardware version
Global Const DaqSubTypeDefault& = 0

' sub types for the DaqBook2000 main type
Global Const DaqSubTypeDaqBook2000A& = 0 ' DaqBook/2000A or DaqBook/2000X
Global Const DaqSubTypeDaqBook2000E& = 1 ' DaqBook/2000E
Global Const DaqSubTypeDaqBook2001& = 2  ' DaqBook/2001
Global Const DaqSubTypeDaqBook2020& = 3  ' DaqBook/2020
Global Const DaqSubTypeDaqBook2005& = 4  ' DaqBook/2005
Global Const DaqSubTypeES301& = 5        ' ES301
Global Const DaqSubTypeES305& = 6        ' ES305
Global Const DaqSubTypeES302& = 7        ' ES302

' sub types for the DaqLab2000 main type
Global Const DaqSubTypeDaqLab2001& = 0   ' DaqLab/2001
Global Const DaqSubTypeDaqLab2005& = 1   ' DaqLab/2005

' sub types for the DaqScan2000 main type
Global Const DaqSubTypeDaqScan2001& = 0  ' DaqScan/2001
Global Const DaqSubTypeDaqScan2002& = 1  ' DaqScan/2002
Global Const DaqSubTypeDaqScan2004& = 2  ' DaqScan/2004
Global Const DaqSubTypeDaqScan2005& = 3  ' DaqScan/2005

' sub types for the WaveBook516A main type
Global Const DaqSubTypeWaveBook516A& = 0 ' WaveBook/516A
Global Const DaqSubTypeWaveBook516E& = 1 ' WaveBook/516E
Global Const DaqSubTypeZonicBook618& = 2 ' ZonicBook/618
Global Const DaqSubTypeStrainBook616 = 3 ' StrainBook/616

' sub types for the DaqBoard2000 main type
Global Const DaqSubTypeDaqBoard2000& = 0 ' DaqBoard/2000
Global Const DaqSubTypeDaqTemp7A& = 1    ' DaqTemp/7A

' sub types for the DaqBoard2001 main type
Global Const DaqSubTypeDaqBoard2001& = 0 ' DaqBoard/2001
Global Const DaqSubTypeDaqTemp14A& = 1   ' DaqTemp/14A

' sub types for the DaqBoard2005 main type
Global Const DaqSubTypeDaqBoard2005& = 0 ' DaqBoard/2005
Global Const DaqSubTypeDaqTemp7& = 1     ' DaqTemp/7
Global Const DaqSubTypeDaqTemp14& = 2    ' DaqTemp/14



' Protocol Definitions
Global Const DaqProtocolNone& = 0       ' Communications not established
Global Const DaqProtocol4& = 1          ' Standard LPT Port 4-bit mode
Global Const DaqProtocol8& = 2          ' Standard LPT Port 8-bit mode
Global Const DaqProtocolSMC666& = 3     ' SMC 37C666 EPP mode
Global Const DaqProtocolFastEPP& = 4    ' WBK20/21 Fast EPP mode
Global Const DaqProtocolECP& = 5        ' ECP mode
Global Const DaqProtocol8BitEPP& = 6    ' 8-bit EPP mode
Global Const DaqProtocolTCPIP& = 7      ' TCPIP (eWave)
Global Const DaqProtocolISA& = 100      ' ISA bus card DaqBoard 100/200
Global Const DaqProtocolPcCard& = 200   ' PcCard for Daq (PCMCIA)
Global Const DaqProtocolUSB& = 300      ' USB  (PersonalDAQ)
Global Const DaqProtocolPCI& = 400      ' PCI  (DaqBoard1000/2000)
Global Const DaqProtocolCPCI& = 500     ' Compact PCI bus card DaqBoard 2000

'Used by daqGetDeviceList, which returns an array of these.  Also a member
'of DaqDevicePropsT
Const DaqDeviceNameSize& = 64
Public Type DaqDeviceListT
    daqName(0 To DaqDeviceNameSize - 1) As Byte
End Type

Type DaqCalInputT
    DaqCalInputT As Integer
End Type

'Used by daqGetDeviceProperties to get device information
Public Type DaqDevicePropsT
    deviceType As Long
    basePortAddress As Long
    dmaChannel As Long
    socket As Long
    interruptLevel As Long
    protocol As Long
    daqName(0 To DaqDeviceNameSize - 1) As Byte
    maxAdChannels As Long
    maxDaChannels As Long
    maxDigInputBits As Long
    maxDigOutputBits As Long
    maxCtrChannels As Long
    mainUnitAdChannels As Long
    mainUnitDaChannels As Long
    mainUnitDigInputBits As Long
    mainUnitDigOutputBits As Long
    mainUnitCtrChannels As Long
    adFifoSize As Long
    daFifoSize As Long
    adResolution As Long
    daResolution As Long
    adMinFreq As Single
    adMaxFreq As Single
    daMinFreq As Single
    daMaxFreq As Single
End Type

' Utility Function Prototypes
Declare Function BdaqGetDriverVersion& Lib "daqx.dll" Alias "daqGetDriverVersion" (Version&)
Declare Function BdaqGetHardwareInfo& Lib "daqx.dll" Alias "daqGetHardwareInfo" (ByVal handle&, ByVal whichInfo&, Info As Any)

Declare Function BdaqGetDeviceCount& Lib "daqx.dll" Alias "daqGetDeviceCount" (devCount As Long)
Declare Function BdaqGetDeviceList& Lib "daqx.dll" Alias "daqGetDeviceList" (DevList As DaqDeviceListT, devCount As Long)
Declare Function BdaqGetDeviceProperties& Lib "daqx.dll" Alias "daqGetDeviceProperties" (ByVal daqName As String, devProps As DaqDevicePropsT)

Declare Function BdaqGetHardwareType& Lib "daqx.dll" Alias "daqGetHardwareType" (ByVal handle&, HwSubType&)
Declare Sub BdaqCvtHardwareType Lib "daqx.dll" Alias "daqCvtHardwareType" (ByVal HwType&, ByVal HwSubType&, HwTypeStr As Byte, ByVal HwTypeStrLen&)

Declare Function BdaqGetInfo& Lib "daqx.dll" Alias "daqGetInfo" (ByVal handle&, ByVal chan&, ByVal whichInfo&, Info As Any)
Declare Function BdaqGetInfoA& Lib "daqx.dll" Alias "daqGetInfo" (ByVal handle&, ByVal chan&, ByVal whichInfo&, Info As Byte)

' this will not work : should be removed!!! use VBdaqGetInfoString()
Declare Function BdaqGetInfoStr& Lib "daqx.dll" Alias "daqGetInfo" (ByVal handle&, ByVal chan&, ByVal whichInfo&, ByVal sInfo$)

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'                                                               '
'             Dbk Card Definitions and Prototypes               '
'                                                               '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

'DaqAdcExpType -  Dbk Card Expansion Bank Definitions
Global Const DaetNotDefined& = 0   'Bank is unknown or undefine the bank
Global Const DaetDbk50& = 1        'Dbk50 option
Global Const DaetDbk5& = 2         'Dbk5 option
Global Const DaetDbk2& = 3         'Dbk2 option
Global Const DaetDbk4& = 4         'Dbk4 option
Global Const DaetDbk7& = 5         'Dbk7 option
Global Const DbankNotDefined& = 0        ' Bank is unknown or undefine the bank
Global Const DbankDbk50& = 1             ' Dbk50 option
Global Const DbankDbk5& = 2              ' Dbk5 option
Global Const DbankDbk2& = 3              ' Dbk2 option
Global Const DbankDbk4& = 4              ' Dbk4 option
Global Const DbankDbk7& = 5              ' Dbk7 option
Global Const DoctWbk11& = 6               ' Wbk11 sample and hold channel
Global Const DoctWbk12& = 7               ' Wbk12 filter card
Global Const DoctWbk13& = 8               ' Wbk13 filter & sample and hold card
Global Const DmctWbk512& = 9              ' WaveBook/512 channel
Global Const DmctWbk10& = 10              ' Wbk10 channel
Global Const DmctWbk14& = 11              ' Wbk14 channel
Global Const DmctWbk15& = 12              ' Wbk15 channel
Global Const DmctResponseDac& = 13        ' Response DAC on WaveBook
Global Const DmctWbk16& = 14              ' Wbk16 channel
Global Const DmctWbk516& = 15             ' WaveBook/516 Channel
Global Const DmctWbk516_250& = 17         ' 250kHz WaveBook/516 Channel
Global Const DoctPga516& = 18             ' WaveBook/516 PGA Board
Global Const DmctoctPga516& = 18          ' WaveBook/516 PGA Board
Global Const DmctWbk512_10V& = 19         ' Wbk/512/10V
Global Const DmctWbk10_10V& = 20          ' Wbk10/10V
Global Const DmctWbk16_SSH& = 21          ' Wbk16 channel with SSH
Global Const DmctWbk10A& = 22             ' Wbk10A channel
Global Const DoctWbk12A& = 23             ' Wbk12A filter card
Global Const DoctWbk13A& = 24             ' Wbk13A filter & sample and hold card
Global Const DmctWbk17& = 25              ' Wbk17
Global Const DmctWbk512A& = 26            ' WaveBook/512A
Global Const DmctWbk516A& = 27            ' WaveBook/516A
Global Const DmctWbk18& = 28              ' Wbk18 channel
Global Const DaetDbk90& = 29              ' DBK90
Global Const DaetDbk91& = 30              ' DBK91
Global Const DmctSbk616Gauge = 31         ' Wbk16 channel with SSH

' DaqAdcExpSubType - Expansion and Option Sub Type Definitions

' a sub type of DaestDefault
' indicates that the bank or option device type
' is defined by the hardware version
Global Const DaestDefault& = 0

' sub types for the DaetDbk7 main type
Global Const DaestDbk7& = 0              ' DBK7
Global Const DaestDbk55& = 1             ' DBK55 (8 channel DBK7)

' sub types for the DmctWbk516A main type
Global Const DmcstWaveBook516A& = 0      ' WaveBook/516A
Global Const DmcstWaveBook516E& = 1      ' WaveBook/516E
Global Const DmcstZonicBook618& = 2      ' ZonicBook/618

' sub types fo the DmctWbk16 main type
Global Const DmcstWbk16_SSH = 0           ' WBK16
Global Const DmcstStrainBook616Gauge = 1  ' Strain channels of the StrainBook/616

' sub types for the DmctWbk17 main type
Global Const DmcstWbk17& = 0             ' WBK17
Global Const DmcstZonicBook618Tach& = 1  ' Tachometer channels of the ZonicBook/618

' sub types for the DmctWbk18 main type
Global Const DmcstWbk18& = 0             ' WBK18
Global Const DmcstZonicBook618ICP& = 1   ' ICP channels of the ZonicBook/618

Declare Function BdaqGetChannelType& Lib "daqx.dll" Alias "daqGetChannelType" (ByVal handle&, ByVal chan&, ByVal bOption&, ChSubType&)
Declare Sub BdaqCvtChannelType Lib "daqx.dll" Alias "daqCvtChannelType" (ByVal ChType&, ByVal ChSubType&, ChTypeStr As Byte, ByVal ChTypeStrLen&)

' Dbk Card Option Type Selector Definitions
Global Const DcotDbk4MaxFreq& = 0
Global Const DcotDbk4SetBaseline& = 1
Global Const DcotDbk4Excitation& = 2
Global Const DcotDbk4Clock& = 3
Global Const DcotDbk4Gain& = 4           ' internally used by daqAdcSetScan

Global Const DcotDbk7Slope& = 0
Global Const DcotDbk7DebounceTime& = 1
Global Const DcotDbk7MinFreq& = 2
Global Const DcotDbk7MaxFreq& = 3

Global Const DcotDbk55Slope& = DcotDbk7Slope&
Global Const DcotDbk55DebounceTime& = DcotDbk7DebounceTime&
Global Const DcotDbk55MinFreq& = DcotDbk7MinFreq&
Global Const DcotDbk55MaxFreq& = DcotDbk7MaxFreq&

Global Const DcotDbk50Gain& = 0          ' internally used by daqAdcSetScan

Global Const DcotDbk90StartChanOn = 0
Global Const DcotDbk90StartChanOff = 1
Global Const DcotDbk90StartChanOffAll = &H40000000

Global Const DdcotDbk4MaxFreq& = 0
Global Const DdcotDbk4SetBaseline& = 1
Global Const DdcotDbk4Excitation& = 2
Global Const DdcotDbk4Clock& = 3
Global Const DdcotDbk4Gain& = 4          'internally used by daqAdcSetScan

Global Const DdcotDbk7Slope& = 0
Global Const DdcotDbk7DebounceTime& = 1
Global Const DdcotDbk7MinFreq& = 2
Global Const DdcotDbk7MaxFreq& = 3

Global Const DdcotDbk55Slope& = DdcotDbk7Slope&
Global Const DdcotDbk55DebounceTime& = DdcotDbk7DebounceTime&
Global Const DdcotDbk55MinFreq& = DdcotDbk7MinFreq&
Global Const DdcotDbk55MaxFreq& = DdcotDbk7MaxFreq&

Global Const DdcotDbk50Gain& = 0         ' internally used by daqAdcSetScan

Global Const DdcotDbk90StartChanOn = 0
Global Const DdcotDbk90StartChanOff = 1
Global Const DdcotDbk90StartChanOffAll = DcotDbk90StartChanOffAll
Global Const DmotDbk90StartChanOffAll = DcotDbk90StartChanOffAll
   
'' Wbk module Option type Definitions
        
Global Const DcotWbk12FilterCutOff& = 0
Global Const DcotWbk12FilterType& = 1
Global Const DcotWbk12FilterMode& = 2
Global Const DcotWbk12PreFilterMode& = 3
Global Const DcotWbk12PreFilterCutOff& = 4
Global Const DcotWbk12PostFilterCutOff& = 5
        
Global Const DcotWbk13FilterCutOff& = 0
Global Const DcotWbk13FilterType& = 1
Global Const DcotWbk13FilterMode& = 2
Global Const DcotWbk13PreFilterMode& = 3
Global Const DcotWbk13PreFilterCutOff& = 4
Global Const DcotWbk13PostFilterCutOff& = 5

Global Const DcotWbk14LowPassMode& = 0
Global Const DcotWbk14LowPassCutOff& = 1
Global Const DcotWbk14HighPassCutOff& = 2
Global Const DcotWbk14CurrentSrc& = 3
Global Const DcotWbk14PreFilterMode& = 4
Global Const DmotWbk14ExcSrcWaveform& = 5
Global Const DmotWbk14ExcSrcFreq& = 6
Global Const DmotWbk14ExcSrcAmplitude& = 7
Global Const DmotWbk14ExcSrcOffset& = 8
Global Const DmotWbk14ExcSrcApply& = 9
Global Const DcotWbk14ExtFilterRange& = 10
Global Const DcotWbk14DetectSensor& = 11

Global Const DcotWbk16Bridge& = 0
Global Const DcotWbk16ShuntCal& = 1
Global Const DcotWbk16InDiag& = 2
Global Const DcotWbk16OffsetDac& = 3
Global Const DcotWbk16OutSource& = 4
Global Const DcotWbk16Inv& = 5
Global Const DcotWbk16FilterType& = 6
Global Const DcotWbk16Couple& = 7
Global Const DcotWbk16Sample& = 8
Global Const DcotWbk16ExcDac& = 9
Global Const DcotWbk16IAG& = 10
Global Const DcotWbk16PGA& = 11
Global Const DmotWbk16Immediate& = 12

' Wbk17
Global Const DcotWbk17Level& = 0             ' Range: +/-12.5 Volts
Global Const DcotWbk17Coupling& = 1          ' Off, AC, DC
Global Const DcotWbk17FilterType& = 2        ' Bypass, 100K, 20K, 30Hz
Global Const DcotWbk17DebounceTime& = 3      ' Enumeration or Bypass
Global Const DcotWbk17DebounceTrigger& = 4   ' Trigger After/Before Stable
Global Const DcotWbk17Edge& = 5              ' Rising/Falling Edge
Global Const DcotWbk17MeasurementMode& = 6   ' Enumeration with Bit-Masking
Global Const DcotWbk17TickSize& = 7          ' Enumeration; 20ns-20us
Global Const DcotWbk17MapChannel& = 8        ' Enumeration; counter or detector 1 - 8 (= "Z" in encoder mode)
Global Const DmotZbkTachPhaseDelay& = 9      ' up to 4 seconds in nSec

' Wbk17 Detection
Global Const DcotWbk17DetectClear& = 20       ' Enumeration; clear/reset channel or unit (all)
Global Const DcotWbk17DetectControl& = 21     ' Enumeration; set comparison or off/clear
''   Be sure to use DcofSubChannel... DaqChanOptionFlagType + Detector number (1-16)
Global Const DcotWbk17DetectLowLimit& = 22    ' 0 - 65535
Global Const DcotWbk17DetectHighLimit& = 23   ' 0 - 65535
Global Const DcotWbk17DetectDigComp& = 24     ' 0 - 255 : Dig port comparison value
Global Const DcotWbk17DetectDigMask& = 25     ' 0 - 255 : DigMask used by DigComp AND DigOut
Global Const DcotWbk17DetectDigOut& = 26      ' 0 - 255 : Dig port output value (on detection true if enabled)
   

' Wbk18
Global Const DcotWbk18LowPassMode = 0        ' Enumeration: Bypass, 8 pole and 2 pole
Global Const DcotWbk18LowPassCutOff = 1      ' 5 - 50000 (Hz) : selectable filter range in hertz
Global Const DcotWbk18HighPassCutOff = 2     ' Enumeration: DC,0.1Hz and 10Hz
Global Const DcotWbk18CurrentSrc = 3         ' Enumeration: Off and 4mA
Global Const DcotWbk18OverRangeEnable = 4    ' Enumeration: Off and On
Global Const DmotWbk18esMode = 5             ' zero,off,continuous output or Swept (sweep through up to 1024 freqs)
Global Const DmotWbk18esFreq = 6             ' 0.01Hz - 5000Hz
Global Const DmotWbk18esAmplitude = 7        ' Enumeration: 7 amplitudes
Global Const DmotWbk18esFreqCycleTime = 8    ' Swept Mode:freq-to-freq time in seconds (50uS to 1,342,000uS)
Global Const DmotWbk18esFreqDurationTime = 9 ' Swept Mode:total time to sweep all freqs ( 5uS to 85,899,000uS)
Global Const DmotWbk18OverRangeLimit = 10    ' 1 - 100 (%)   : percentage of selected range
Global Const DmotWbk18OverRangeEnable = 11   ' option value is 8 bit mask representing the 8 channels- zero disables all
Global Const DmotWbk18esImmediate = 12       ' used to reset, turn on and turn off the excitation source
Global Const DmotWbk18esRelay = 13           ' used to specify output relay on/off
Global Const DcotWbk18CurrentSrcImmediate = 14 ' Enumeration: Off and 4mA - Action immediate
Global Const DcotWbk18TEDsStatus = 15
Global Const DcotWbk18TEDsData = 16

' pDaq option types
Global Const DcotpDaqSlope& = 0
Global Const DcotpDaqDebounceTime& = 1
Global Const DcotpDaqMinFreq& = 2
Global Const DcotpDaqMaxFreq& = 3
Global Const DcotpDaqPulses& = 4

' Pga516 Option Types
Global Const DcotPga516LowPassMode& = 0

' Base unit options codes.
Global Const DbotBaseUnitOption& = &H8000&     ' bit mask that marks all base unit options.
Global Const DbotFifoOverflowMode& = &H8001&   ' True/False, where True enables the mode
Global Const DbotFifoCycleMode& = &H8002&      ' True/False, where True enables the mode
Global Const DbotFifoCycleSize& = &H8003&      ' Cycle buffer length in WORD's
Global Const DbotFifoFlush& = &H8004&          ' Flush the FIFO now
Global Const DbotFifoNoFlushOnDisarm& = &H8005& ' Disable Auto Fifo Flushing upon disarm
Global Const DbotIgnoreFirstScan& = &H8006     ' Ignore First Scan (DaqBook/2000 Series - Used for Slaved GSYNC Mode)

' I/O, Counter, & Timer Configuration & Control
Global Const DcotDigitalOption& = &H1000&      'bit mask that marks all Digital options.
Global Const DcotP2Local8Mode& = &H1001&       'Input, Output
Global Const DcotP2Exp8Mode& = &H1002&         'Input, Output
Global Const DcotP3Local16Mode& = &H1003&      'Input, Output

Global Const DcotCounterOption& = &H2000&      'bit mask that marks all Counter options.
Global Const DcotCounterCascade& = &H2001&     'Single, Cascaded
Global Const DcotCounterMode& = &H2002&        'Clear on Read, Totalize
Global Const DcotCounterControl& = &H2003&     'Off, On, Immediate Clear
Global Const DmotCounterControl& = &H2004&     'All Counters: Off, On, Immediate Clear
Global Const DcotCounterEdge& = &H2005&            'Falling or Rising Edge Detection

Global Const DcotTimerOption& = &H4000&        'bit mask that marks all Timer options.
Global Const DcotTimerDivisor& = &H4001&       '16-bit Number (freq = 1MHz / (Divisor + 1))
Global Const DcotTimerControl& = &H4002&       'Off, On
Global Const DmotTimerControl& = &H4003&       'All Timers: Off, On

' DaqChanOptionFlagType;
Global Const DcofChannel& = 0   ' Channel Option; Apply option to one channel only
Global Const DcofModule& = 1    ' Module Option; Apply option to whole module
                               ' Use only with Dmot... DaqOptionTypes and Dmov... DaqChanOptionValues
' SubChannel Identifiers for WBK17 Detection Options
' Use enum + detection number (1 - 16)
Global Const DcofSubChannelLow& = &H1000&  ' Counter Low Word
Global Const DcofSubChannelHigh& = &H2000& ' Counter High Word



' Dbk Card Option Value Definitions

' Digital I/O Port Mode Definitions for All DcotDigitalOptions
Global Const DcovDigitalInput& = 0
Global Const DcovDigitalOutput& = 1

' Counter Cascade Option Definitions for DcotCounterCascade
Global Const DcovCounterSingle& = 0
Global Const DcovCounterCascade& = 1

' Counter Mode Option Definitions for DcotCounterMode
Global Const DcovCounterClearOnRead& = 0
Global Const DcovCounterTotalize& = 1

' Counter Edge Option Definitions for DcotCounterEdge
Global Const DcovCounterFallingEdge& = 0
Global Const DcovCounterRisingEdge& = 1

' Counter Control Option Definitions for:
' DcotCounterControl (Individual Channel)
' DmotCounterControl (All Counters)
Global Const DcovCounterOff& = 0
Global Const DcovCounterOn& = 1
Global Const DcovCounterManualClear& = 2

' Timer Control Option Definitions for:
' DcotTimerControl (Individual Channel)
' DmotTimerControl (All Counters)
Global Const DcovTimerOff& = 0
Global Const DcovTimerOn& = 1

' Dbk4 cutoff frequencies for DcotMaxFreq option type
Global Const DcovDbk4Freq18000Hz& = 0
Global Const DcovDbk4Freq9000Hz& = 1
Global Const DcovDbk4Freq4500Hz& = 2
Global Const DcovDbk4Freq2250Hz& = 3
Global Const DcovDbk4Freq1125Hz& = 4
Global Const DcovDbk4Freq563Hz& = 5
Global Const DcovDbk4Freq281Hz& = 6
Global Const DcovDbk4Freq141Hz& = 7

' Dbk4 set baseline for DcotSetBaseline option type
Global Const DcovDbk4BaselineNever& = 0
Global Const DcovDbk4BaselineOneShot& = 1

' Dbk7/55 debounce times for DcotDebounceTime option type
Global Const DcovDbk7DebounceNone& = 0
Global Const DcovDbk7Debounce600us& = 1
Global Const DcovDbk7Debounce2500us& = 2
Global Const DcovDbk7Debounce10ms& = 3

Global Const DcovDbk55DebounceNone& = DcovDbk7DebounceNone&
Global Const DcovDbk55Debounce600us& = DcovDbk7Debounce600us&
Global Const DcovDbk55Debounce2500us& = DcovDbk7Debounce2500us&
Global Const DcovDbk55Debounce10ms& = DcovDbk7Debounce10ms&

        
'              ' Wbk Option Value Definitions

'type DaqChanOptionValue

'' Wbk 12 Filter Type Definitions for WcotWbk12FilterType
Global Const DcovWbk12FilterElliptic& = 0
Global Const DcovWbk12FilterLinear& = 1

'' Wbk 12 Filter Mode Definitions for WcotWbk12FilterMode
Global Const DcovWbk12FilterBypass& = 0
Global Const DcovWbk12FilterOn& = 1

'' Wbk 12 Anti-Aliasing Filter Mode Definitions for WcotWbk12PreFilterMode
Global Const DcovWbk12PreFilterDefault& = 0
Global Const DcovWbk12PreFilterOff& = 1

'' Wbk 12 Anti-Aliasing Filter CutOff Frequency Definitions for WcotWbk12PreFilterCutOff
Global Const DcovWbk12PreFilterCutOffDefault& = 0

'' Wbk 12A Clock Filter CutOff Frequency Definitions for WcotWbk12PostFilterCutOff
Global Const DcovWbk12PostFilterCutOffDefault& = 0
                  
'' Wbk 13 Filter Type Definitions for WcotWbk13FilterType
Global Const DcovWbk13FilterElliptic& = 0
Global Const DcovWbk13FilterLinear& = 1

'' Wbk 13 Filter Mode Definitions for WcotWbk13FilterMode
Global Const DcovWbk13FilterBypass& = 0
Global Const DcovWbk13FilterOn& = 1

'' Wbk 13 Anti-Aliasing Filter Mode Definitions for WcotWbk13PreFilterMode
Global Const DcovWbk13PreFilterDefault& = 0
Global Const DcovWbk13PreFilterOff& = 1

'' Wbk 13 Anti-Aliasing Filter CutOff Frequency Definitions for WcotWbk13PreFilterCutOff
Global Const DcovWbk13PreFilterCutOffDefault& = 0

'' Wbk 13A Clock Filter CutOff Frequency Definitions for WcotWbk13PostFilterCutOff
Global Const DcovWbk13PostFilterCutOffDefault& = 0

'' Wbk 14 Current Source Definitions for WcotWbk14CurrentSrc
Global Const DcovWbk14CurrentSrcOff& = 0
Global Const DcovWbk14CurrentSrc2mA& = 1
Global Const DcovWbk14CurrentSrc4mA& = 2

'' Wbk 14 High Pass Filter Definitions for WcotWbk14HighPassCutOff
Global Const DcovWbk14HighPass0_1Hz& = 0
Global Const DcovWbk14HighPass10Hz& = 1

'' Wbk 14 Low Pass Filter Mode Definitions for WcotWbk14LowPassMode
Global Const DcovWbk14LowPassBypass& = 0
Global Const DcovWbk14LowPassOn& = 1
Global Const DcovWbk14LowPassExtClk& = 2

'' Wbk 14 Low Pass Filter Mode Definitions for WcotWbk14PreFilterMode
Global Const DcovWbk14PreFilterDefault& = 0
Global Const DcovWbk14PreFilterOff& = 1

'' Wbk 14 Low Pass Filter Mode Definitions for WcotWbk14ExtFilterRange
Global Const DcovWbk14FilterRange_1K& = 0
Global Const DcovWbk14FilterRange_5K& = 1
Global Const DcovWbk14FilterRange_10K& = 2
Global Const DcovWbk14FilterRange_15K& = 3
Global Const DcovWbk14FilterRange_20K& = 4

'' Wbk 14 Excitation Source Waveform Definitions for WmotWbk14ExcSrcWaveform
Global Const DmovWbk14ExcSrcRandom& = 0
Global Const DmovWbk14ExcSrcSine& = 1
                   
' Wbk16 Bridge Definitions
Global Const DcovWbk16ApplyFull& = 0
Global Const DcovWbk16ApplyHalfQtrPos& = 1
Global Const DcovWbk16ApplyHalfQtrNeg& = 2

' Wbk16 Shunt resistors cal definitions
Global Const DcovWbk16ApplyNone& = 0
Global Const DcovWbk16Apply120& = 1
Global Const DcovWbk16Apply350& = 2
Global Const DcovWbk16Apply1K& = 3
Global Const DcovWbk16AutoZero& = 4

' Wbk16 Input Diagnostics definitions
Global Const DcovWbk16ReadNone& = 0
Global Const DcovWbk16ReadHalf& = 1
Global Const DcovWbk16ReadPosArm& = 2

' Wbk16 Output Source definitions
Global Const DcovWbk16ReadSignal& = 0
Global Const DcovWbk16ReadExcVolts& = 1
Global Const DcovWbk16ReadExcCurr& = 2

' Wbk16 SSH definitions
Global Const DcovWbk16Bypassed& = 0
Global Const DcovWbk16Ssh& = 1

' Wbk16 Inversion definitions
Global Const DcovWbk16Normal& = 0
Global Const DcovWbk16Inverted& = 1

' WbK16 Filter Type Definitions
Global Const DcovWbk16FltBypass& = 0
Global Const DcovWbk16Flt10Hz& = 1
Global Const DcovWbk16Flt1Khz& = 2

' Wbk16 Coupling Definitions
Global Const DcovWbk16CoupleDC& = 0
Global Const DcovWbk16CoupleAC& = 1

' Wbk16 Instrumentation Amplifier w/Gain Definitions
Global Const DcovWbk16X1& = 0
Global Const DcovWbk16X10& = 1
Global Const DcovWbk16X100& = 2
Global Const DcovWbk16X1000& = 3

' Wbk16 Programmable Gain Amplifier Definitions
Global Const DcovWbk16X1_00& = 0
Global Const DcovWbk16X1_28& = 1
Global Const DcovWbk16X1_65& = 2
Global Const DcovWbk16X2_11& = 3
Global Const DcovWbk16X2_71& = 4
Global Const DcovWbk16X3_48& = 5
Global Const DcovWbk16X4_47& = 6
Global Const DcovWbk16X5_74& = 7
Global Const DcovWbk16X7_37& = 8
Global Const DcovWbk16X9_46& = 9
Global Const DcovWbk16X12_14& = 10
Global Const DcovWbk16X15_58& = 11
Global Const DcovWbk16X20_00& = 12

'Wbk16 Option Values for DcotWbk16ExcDac
Global Const DcovWbk16Exc0_0& = 0
Global Const DcovWbk16Exc0_5& = &H1000
Global Const DcovWbk16Exc1_0& = &H2000
Global Const DcovWbk16Exc2_0& = &H3000
Global Const DcovWbk16Exc5_0& = &H4000
Global Const DcovWbk16Exc10_0& = &H5000

' Wbk16 Immediate Function Definitions
Global Const DmovWbk16ExcSrcApply& = 0
Global Const DmovWbk16ReadTemp& = 1
Global Const DmovWbk16ReadJumpers& = 2
Global Const DmovWbk16FanOn& = 3
Global Const DmovWbk16FanOff& = 4


' Wbk17 Input Coupling Definitions
Global Const DcovWbk17CoupleOff& = 0         ' input off
Global Const DcovWbk17CoupleAC& = 1
Global Const DcovWbk17CoupleDC& = 2

' WbK17 Filter Type Definitions
Global Const DcovWbk17FltBypass& = 0
Global Const DcovWbk17Flt100KHz& = 1
Global Const DcovWbk17Flt20KHz& = 2
Global Const DcovWbk17Flt30Hz& = 4

' Wbk17 Debounce Times
Global Const DcovWbk17Debounce500ns& = 0
Global Const DcovWbk17Debounce1500ns& = 1
Global Const DcovWbk17Debounce3500ns& = 2
Global Const DcovWbk17Debounce7500ns& = 3
Global Const DcovWbk17Debounce15500ns& = 4
Global Const DcovWbk17Debounce31500ns& = 5
Global Const DcovWbk17Debounce63500ns& = 6
Global Const DcovWbk17Debounce127500ns& = 7
Global Const DcovWbk17Debounce100us& = 8
Global Const DcovWbk17Debounce300us& = 9
Global Const DcovWbk17Debounce700us& = 10
Global Const DcovWbk17Debounce1500us& = 11
Global Const DcovWbk17Debounce3100us& = 12
Global Const DcovWbk17Debounce6300us& = 13
Global Const DcovWbk17Debounce12700us& = 14
Global Const DcovWbk17Debounce25500us& = 15
Global Const DcovWbk17DebounceNone& = 16

' Wbk17 Debounce Trigger
Global Const DcovWbk17TriggerAfterStable& = 0
Global Const DcovWbk17TriggerBeforeStable& = 1

' Wbk17 Edge Detection
Global Const DcovWbk17RisingEdge& = 0
Global Const DcovWbk17FallingEdge& = 1

' Wbk17 Measurement Modes and mode specific flags
' Usage: combine the Mode with any Mode specific settings required.
' (DcovWbk17Mode_Counter + DcovWbk17Counter_ClearOnRead + DcovWbk17ModeMask_32Bit)

  ' these are available for all modes
  ' the rest are mode specific
  Global Const DcovWbk17ModeMask_16Bit& = &H0
  Global Const DcovWbk17ModeMask_32Bit& = &H4

  Global Const DcovWbk17ModeMaskGatingOff& = &H0
  Global Const DcovWbk17ModeMaskGatingOn& = &H10

Global Const DcovWbk17Mode_OFF& = &H0

Global Const DcovWbk17Mode_Counter& = &H100
  Global Const DcovWbk17Counter_Totalize& = &H0
  Global Const DcovWbk17Counter_ClearOnRead& = &H1
   
  Global Const DcovWbk17Counter_RollOver& = &H0
  Global Const DcovWbk17Counter_StopOnTop& = &H2
   
  Global Const DcovWbk17Counter_LatchOnSOS& = &H0
  Global Const DcovWbk17Counter_LatchOnMap& = &H8
   
  Global Const DcovWbk17Counter_DecrementOff& = &H0
  Global Const DcovWbk17Counter_DecrementOn& = &H20
   
  Global Const DcovWbk17Counter_CountChan& = &H0
  Global Const DcovWbk17Counter_CountMap& = &H40

Global Const DcovWbk17Mode_Period& = &H200
  Global Const DcovWbk17Period_X1& = 0
  Global Const DcovWbk17Period_X10& = 1
  Global Const DcovWbk17Period_X100& = 2
  Global Const DcovWbk17Period_X1000& = 3

  Global Const DcovWbk17Period_MeasChan& = &H0
  Global Const DcovWbk17Period_MeasMap& = &H40

Global Const DcovWbk17Mode_PulseWidth& = &H300
  Global Const DcovWbk17PulseWidth_MeasChan& = &H0
  Global Const DcovWbk17PulseWidth_MeasMap& = &H40

Global Const DcovWbk17Mode_Timing& = &H400

Global Const DcovWbk17Mode_Encoder& = &H500
  Global Const DcovWbk17Encoder_X1& = 0
  Global Const DcovWbk17Encoder_X2& = 1
  Global Const DcovWbk17Encoder_X4& = 2

  Global Const DcovWbk17Encoder_LatchOnSOS& = &H0
  Global Const DcovWbk17Encoder_LatchOnZ& = &H8

  Global Const DcovWbk17Encoder_ClearOnZ_Off& = &H0
  Global Const DcovWbk17Encoder_ClearOnZ_On& = &H20


' Wbk17 Tick Size
Global Const DcovWbk17Tick20ns& = 0
Global Const DcovWbk17Tick200ns& = 1
Global Const DcovWbk17Tick2000ns& = 2
Global Const DcovWbk17Tick20000ns& = 3

' Wbk17 Map Channel
Global Const DcovWbk17Map_Channel_1& = 1
Global Const DcovWbk17Map_Channel_2& = 2
Global Const DcovWbk17Map_Channel_3& = 3
Global Const DcovWbk17Map_Channel_4& = 4
Global Const DcovWbk17Map_Channel_5& = 5
Global Const DcovWbk17Map_Channel_6& = 6
Global Const DcovWbk17Map_Channel_7& = 7
Global Const DcovWbk17Map_Channel_8& = 8
Global Const DcovWbk17Map_Detect_1& = 9
Global Const DcovWbk17Map_Detect_2& = 10
Global Const DcovWbk17Map_Detect_3& = 11
Global Const DcovWbk17Map_Detect_4& = 12
Global Const DcovWbk17Map_Detect_5& = 13
Global Const DcovWbk17Map_Detect_6& = 14
Global Const DcovWbk17Map_Detect_7& = 15
Global Const DcovWbk17Map_Detect_8& = 16

' Wbk17 Clear Detection Settings : DcotWbk17DetectClear
Global Const DcovWbk17DetClr_Chan& = 0       ' Clear all settings of specified channel (Low AND High)
Global Const DcovWbk17DetClr_All& = 1        ' Clear all settings of all channels (Low AND High)
  
' Wbk17 Detection Control : DcotWbk17DetectControl
' Settings can be combined (DcovWbk17DtctCtrl_Below_Low + DcovWbk17DtctCtrl_Update_Dig)
' Note: Be sure to use DcofSubChannel... DaqChanOptionFlagType
Global Const DcovWbk17DetCtrl_Off& = 0             ' Detection Setting Off
Global Const DcovWbk17DetCtrl_Below_Low& = 1       ' Count < Low Limit
Global Const DcovWbk17DetCtrl_Above_High& = 2      ' High Limit < Count
Global Const DcovWbk17DetCtrl_Outside_Range& = 3   ' (Count < Low Limit) OR (High Limit < Count)
Global Const DcovWbk17DetCtrl_Inside_Range& = 4    ' Low Limit > Count > High Limit
Global Const DcovWbk17DetCtrl_Dig_Eq_Dig& = 8      ' (DigComp & DigMask) == (DigOut & DigMask) (actual)
Global Const DcovWbk17DetCtrl_Update_Dig& = 16     ' Update DigOut On Detection (using DigMask & DigOut)


' Wbk 18 channel Definitions for DcotWbk18OverRangeEnable
Global Const DcovWbk18OverRangeOff = 0
Global Const DcovWbk18OverRangeOn = 1

' Wbk 18 Current Source Definitions for DcotWbk18CurrentSrc
Global Const DcovWbk18CurrentSrcOff = 0
Global Const DcovWbk18CurrentSrc4mA = 1

' Wbk 18 High Pass Filter Definitions for DcotWbk18HighPassCutOff
Global Const DcovWbk18HighPass0_1Hz = 0    ' Not valid for WgcGain0_2
Global Const DcovWbk18HighPass10Hz = 1     ' Not valid for WgcGain0_2
Global Const DcovWbk18HighPassDC = 2

' Wbk 18 Low Pass Filter Mode Definitions for DcotWbk18LowPassMode
Global Const DcovWbk18LowPassBypass = 0
Global Const DcovWbk18LowPass_8_Pole = 1
Global Const DcovWbk18LowPass_2_Pole = 2

 ' Wbk 18 Low Pass Filter Frequencies Definitions for DcotWbk18LowPassCutOff
Global Const DcovWbk18LPF_Cutoff_10Hz = 0
Global Const DcovWbk18LPF_Cutoff_20Hz = 1
Global Const DcovWbk18LPF_Cutoff_50Hz = 2
Global Const DcovWbk18LPF_Cutoff_100Hz = 3
Global Const DcovWbk18LPF_Cutoff_200Hz = 4
Global Const DcovWbk18LPF_Cutoff_500Hz = 5
Global Const DcovWbk18LPF_Cutoff_1000Hz = 6
Global Const DcovWbk18LPF_Cutoff_2000Hz = 7
Global Const DcovWbk18LPF_Cutoff_5000Hz = 8
Global Const DcovWbk18LPF_Cutoff_10000Hz = 9
Global Const DcovWbk18LPF_Cutoff_20000Hz = 10
Global Const DcovWbk18LPF_Cutoff_50000Hz = 11

   ' Wbk 18 External Source level Definitions for DmotWbk18esAmplitude
Global Const DmovWbk18esAmplitude10pp = 0   '10 volts peak-to-peak
Global Const DmovWbk18esAmplitude5pp = 1    '5 volts peak-to-peak
Global Const DmovWbk18esAmplitude2pp = 2    '2 volts peak-to-peak
Global Const DmovWbk18esAmplitude1pp = 3     '1 volts peak-to-peak
Global Const DmovWbk18esAmplitude0_5pp = 4  '0.5 volts peak-to-peak
Global Const DmovWbk18esAmplitude0_2pp = 5  '0.2 volts peak-to-peak
Global Const DmovWbk18esAmplitude0_1pp = 6  '0.1 volts peak-to-peak
Global Const DmovWbk18esAmplitude0_0pp = 7  'zero
   
   ' Wbk 18 Excitation Source Waveform Definitions for DmotWbk18esMode
Global Const DmovWbk18esSine = 0
Global Const DmovWbk18esSweptSine = 1
   
   
' Wbk 18 Excitation Source Definitions for DmotWbk18esRelay
Global Const DmovWbk18esRelayClosed = 1
Global Const DmovWbk18esRelayOpen = 0

'Wbk18 Excitation Source definitions for DmotWbk18esImmediate
Global Const DmovWbk18esStop = 0          ' stops excitation output
Global Const DmovWbk18esStart = 1         ' starts excitation output using current amplitude/freq values
Global Const DmovWbk18esWriteRAM = 3      'writes the current amplitude/freq/relay values to RAM
Global Const DmovWbk18esClearRAM = 4      'erase stored segments
  
        
' 516 Pga Board Low Pass Filter Mode Definitions for WcotWbk14LowPassMode
Global Const DcovPga516LowPassBypass& = 0
Global Const DcovPga516LowPassOn& = 1

' DaqBook/2000 Ignore First Scan settings (On/Off)
Global Const DbovIgnoreFirstScanOff& = 0
Global Const DbovIgnoreFirstScanOn& = 1

' Bank Configuration Prototypes
Declare Function BdaqAdcExpSetBank& Lib "daqx.dll" Alias "daqAdcExpSetBank" (ByVal handle&, ByVal chan&, ByVal bankType&)
Declare Function BdaqAdcExpSetBankEx& Lib "daqx.dll" Alias "daqAdcExpSetBankEx" (ByVal handle&, ByVal chan&, ByVal bankType&, ByVal bankSubType&)
Declare Function BdaqAdcExpSetChanOption& Lib "daqx.dll" Alias "daqAdcExpSetChanOption" (ByVal handle&, ByVal chan&, ByVal optionType&, ByVal optionValue!)
Declare Function BdaqAdcExpSetModuleOption& Lib "daqx.dll" Alias "daqAdcExpSetModuleOption" (ByVal handle&, ByVal chan&, ByVal optionType&, ByVal optionValue!)

'Channel/Module/Base-Unit Options
Declare Function BdaqSetOption& Lib "daqx.dll" Alias "daqSetOption" (ByVal handle&, ByVal chan&, ByVal flags&, ByVal optionType&, ByVal optionValue!)


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'                                                               '
'                 ADC Definitions and Prototypes                '
'                                                               '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' ADC Gain Definitions
' Base Unit
Global Const DgainX1& = 0
Global Const DgainX2& = 1
Global Const DgainX4& = 2
Global Const DgainX8& = 3
Global Const DgainX16& = 4              ' DaqBoard1000/2000 only
Global Const DgainX32& = 5              ' DaqBoard1000/2000 only
Global Const DgainX64& = 6              ' DaqBoard1000/2000 only

' Base Unit Gain on DBK Connected Channel
' Reference Only : Use DBK Specific Codes in Applications
Global Const DgainX1DbkNone& = 0
Global Const DgainX2DbkNone& = 4
Global Const DgainX4DbkNone& = 8
Global Const DgainX8DbkNone& = 12
Global Const DgainX16DbkNone& = 16      ' DaqBoard1000/2000 only
Global Const DgainX32DbkNone& = 20      ' DaqBoard1000/2000 only
Global Const DgainX64DbkNone& = 24      ' DaqBoard1000/2000 only

' Dbk4 - Filter Mode (jumper selectable)
Global Const Dbk4FilterX1& = 0
Global Const Dbk4FilterX10& = 1
Global Const Dbk4FilterX100& = 2
Global Const Dbk4FilterX1000& = 3
Global Const Dbk4FilterX2& = 4
Global Const Dbk4FilterX20& = 5
Global Const Dbk4FilterX200& = 6
Global Const Dbk4FilterX2000& = 7
Global Const Dbk4FilterX4& = 8
Global Const Dbk4FilterX40& = 9
Global Const Dbk4FilterX400& = 10
Global Const Dbk4FilterX4000& = 11
Global Const Dbk4FilterX8& = 12
Global Const Dbk4FilterX80& = 13
Global Const Dbk4FilterX800& = 14
Global Const Dbk4FilterX8000& = 15

' Dbk4 - Bypass Mode (jumper selectable)
Global Const Dbk4BypassX1_583& = 0
Global Const Dbk4BypassX15_83& = 1
Global Const Dbk4BypassX158_3& = 2
Global Const Dbk4BypassX1583& = 3
Global Const Dbk4BypassX3_166& = 4
Global Const Dbk4BypassX31_66& = 5
Global Const Dbk4BypassX316_6& = 6
Global Const Dbk4BypassX3166& = 7
Global Const Dbk4BypassX6_332& = 8
Global Const Dbk4BypassX63_32& = 9
Global Const Dbk4BypassX633_2& = 10
Global Const Dbk4BypassX6332& = 11
Global Const Dbk4BypassX12_664& = 12
Global Const Dbk4BypassX126_64& = 13
Global Const Dbk4BypassX1266_4& = 14
Global Const Dbk4BypassX12664& = 15

' Dbk6
Global Const Dbk6X1& = 0
Global Const Dbk6X4& = 1
Global Const Dbk6X16& = 2
Global Const Dbk6X64& = 3
Global Const Dbk6X2& = 4
Global Const Dbk6X8& = 5
Global Const Dbk6X32& = 6
Global Const Dbk6X128& = 7
Global Const Dbk6X256& = 11
Global Const Dbk6X512& = 15
Global Const Dbk6X1024& = 19      ' DaqBoard/2000 only
Global Const Dbk6X2048& = 23      ' DaqBoard/2000 only
Global Const Dbk6X4096& = 27      ' DaqBoard/2000 only

' Dbk7/55
Global Const Dbk7X1& = 0
Global Const Dbk7X2& = DgainX2DbkNone&    'use with PCCard & DaqBoard/2000

Global Const Dbk55X1& = Dbk7X1&
Global Const Dbk55X2& = Dbk7X2&           'use with PCCard & DaqBoard/2000

' Dbk8
Global Const Dbk8X1& = 0
Global Const Dbk8X2& = DgainX2DbkNone&    'use with PCCard & DaqBoard/2000

' Dbk9
Global Const Dbk9VoltageA& = 0
Global Const Dbk9VoltageB& = 1
Global Const Dbk9VoltageC& = 2
Global Const Dbk9VoltageD& = 3

' PCCard Dbk9 use with PCCard & DaqBoard/2000
Global Const DbkPCC9VoltageA& = 4
Global Const DbkPCC9VoltageB& = 5
Global Const DbkPCC9VoltageC& = 6
Global Const DbkPCC9VoltageD& = 7

' Dbk12
Global Const Dbk12X1& = 0
Global Const Dbk12X2& = 1
Global Const Dbk12X4& = 2
Global Const Dbk12X8& = 3
Global Const Dbk12X16& = 7
Global Const Dbk12X32& = 11
Global Const Dbk12X64& = 15
Global Const Dbk12X128& = 19             ' DaqBoard/2000 only
Global Const Dbk12X256& = 23             ' DaqBoard/2000 only
Global Const Dbk12X512& = 27             ' DaqBoard/2000 only

' Dbk13
Global Const Dbk13X1& = 0
Global Const Dbk13X10& = 1
Global Const Dbk13X100& = 2
Global Const Dbk13X1000& = 3
Global Const Dbk13X2& = 4
Global Const Dbk13X20& = 5
Global Const Dbk13X200& = 6
Global Const Dbk13X2000& = 7
Global Const Dbk13X4& = 8
Global Const Dbk13X40& = 9
Global Const Dbk13X400& = 10
Global Const Dbk13X4000& = 11
Global Const Dbk13X8& = 12
Global Const Dbk13X80& = 13
Global Const Dbk13X800& = 14
Global Const Dbk13X8000& = 15
Global Const Dbk13X16& = 16              ' DaqBoard/2000 only
Global Const Dbk13X160& = 17             ' DaqBoard/2000 only
Global Const Dbk13X1600& = 18            ' DaqBoard/2000 only
Global Const Dbk13X16000& = 19           ' DaqBoard/2000 only
Global Const Dbk13X32& = 20              ' DaqBoard/2000 only
Global Const Dbk13X320& = 21             ' DaqBoard/2000 only
Global Const Dbk13X3200& = 22            ' DaqBoard/2000 only
Global Const Dbk13X32000& = 23           ' DaqBoard/2000 only
Global Const Dbk13X64& = 24              ' DaqBoard/2000 only
Global Const Dbk13X640& = 25             ' DaqBoard/2000 only
Global Const Dbk13X6400& = 26            ' DaqBoard/2000 only
Global Const Dbk13X64000& = 27           ' DaqBoard/2000 only

' Dbk14 Bipolar
Global Const Dbk14BiCJC& = Dbk13X2
Global Const Dbk14BiTypeJ& = Dbk13X100
Global Const Dbk14BiTypeK& = Dbk13X100
Global Const Dbk14BiTypeT& = Dbk13X200
Global Const Dbk14BiTypeE& = Dbk13X40
Global Const Dbk14BiTypeN28& = Dbk13X400
Global Const Dbk14BiTypeN14& = Dbk13X100
Global Const Dbk14BiTypeS& = Dbk13X200
Global Const Dbk14BiTypeR& = Dbk13X200
Global Const Dbk14BiTypeB& = Dbk13X400
   
' PCCard & DaqBoard/2000 Dbk14 Bipolar
' place main unit in -5 to +5v range  (additional x2 gain)
' bipolar gains only
Global Const DbkPCC14BiCJC& = Dbk13X4
Global Const DbkPCC14BiTypeJ& = Dbk13X200
Global Const DbkPCC14BiTypeK& = Dbk13X200
Global Const DbkPCC14BiTypeT& = Dbk13X400
Global Const DbkPCC14BiTypeE& = Dbk13X80
Global Const DbkPCC14BiTypeN28& = Dbk13X800
Global Const DbkPCC14BiTypeN14& = Dbk13X200
Global Const DbkPCC14BiTypeS& = Dbk13X400
Global Const DbkPCC14BiTypeR& = Dbk13X400
Global Const DbkPCC14BiTypeB& = Dbk13X800

' Dbk14 Unipolar
Global Const Dbk14UniCJC& = Dbk13X4
Global Const Dbk14UniTypeJ& = Dbk13X200
Global Const Dbk14UniTypeK& = Dbk13X200
Global Const Dbk14UniTypeT& = Dbk13X400
Global Const Dbk14UniTypeE& = Dbk13X100
Global Const Dbk14UniTypeN28& = Dbk13X800
Global Const Dbk14UniTypeN14& = Dbk13X200
Global Const Dbk14UniTypeS& = Dbk13X400
Global Const Dbk14UniTypeR& = Dbk13X400
Global Const Dbk14UniTypeB& = Dbk13X800

' Dbk15 Bipolar
Global Const Dbk15BiX1& = 0
Global Const Dbk15BiX2& = 1

' Dbk15 Unipolar
Global Const Dbk15UniX1& = 2
Global Const Dbk15UniX2& = 3

' Dbk16
Global Const Dbk16ReadBridge& = 0
Global Const Dbk16SetOffset& = 1
Global Const Dbk16SetScalingGain& = 2
Global Const Dbk16SetInputGain& = 3

' Dbk16 with X2 gain on main unit
Global Const DbkPCC16ReadBridge& = 4       ' use with PCCard & DaqBoard/2000
Global Const DbkPCC16SetOffset& = 5        ' use with PCCard & DaqBoard/2000
Global Const DbkPCC16SetScalingGain& = 6   ' use with PCCard & DaqBoard/2000
Global Const DbkPCC16SetInputGain& = 7     ' use with PCCard & DaqBoard/2000

' Dbk17
Global Const Dbk17X1& = 0
Global Const Dbk17X2& = DgainX2DbkNone&    'use with PCCard & DaqBoard/2000

' Dbk18
Global Const Dbk18X1& = 0
Global Const Dbk18X2& = DgainX2DbkNone&    'use with PCCard & DaqBoard/2000

' Dbk19 Bipolar
Global Const Dbk19BiCJC& = 0
Global Const Dbk19BiTypeJ& = 1
Global Const Dbk19BiTypeK& = 1
Global Const Dbk19BiTypeT& = 2
Global Const Dbk19BiTypeE& = 0
Global Const Dbk19BiTypeN28& = 3
Global Const Dbk19BiTypeN14& = 1
Global Const Dbk19BiTypeS& = 3
Global Const Dbk19BiTypeR& = 2
Global Const Dbk19BiTypeB& = 3

' PCCard & DaqBoard/2000 Dbk19 Bipolar
' place main unit in -5 to +5v range  (additional x2 gain)
' bipolar gains only
Global Const DbkPCC19BiCJC& = 4
Global Const DbkPCC19BiTypeJ& = 5
Global Const DbkPCC19BiTypeK& = 5
Global Const DbkPCC19BiTypeT& = 6
Global Const DbkPCC19BiTypeE& = 4
Global Const DbkPCC19BiTypeN28& = 7
Global Const DbkPCC19BiTypeN14& = 5
Global Const DbkPCC19BiTypeS& = 7
Global Const DbkPCC19BiTypeR& = 6
Global Const DbkPCC19BiTypeB& = 7

' Dbk19 Unipolar
Global Const Dbk19UniCJC& = 1
Global Const Dbk19UniTypeJ& = 2
Global Const Dbk19UniTypeK& = 2
Global Const Dbk19UniTypeT& = 3
Global Const Dbk19UniTypeE& = 1
Global Const Dbk19UniTypeN28& = 3
Global Const Dbk19UniTypeN14& = 2
Global Const Dbk19UniTypeS& = 3
Global Const Dbk19UniTypeR& = 3
Global Const Dbk19UniTypeB& = 3

' Dbk42
Global Const Dbk42X1& = 0
Global Const Dbk42X2& = DgainX2DbkNone&    'use with PCCard & DaqBoard/2000

' Dbk43
Global Const Dbk43ReadBridge& = 0
Global Const Dbk43SetOffset& = 1
Global Const Dbk43SetScalingGain& = 2
Global Const Dbk43SetInputGain& = 3

' Dbk43 with X2 gain on main unit
Global Const DbkPCC43ReadBridge& = 4       ' use with PCCard & DaqBoard/2000
Global Const DbkPCC43SetOffset& = 5        ' use with PCCard & DaqBoard/2000
Global Const DbkPCC43SetScalingGain& = 6   ' use with PCCard & DaqBoard/2000
Global Const DbkPCC43SetInputGain& = 7     ' use with PCCard & DaqBoard/2000

' Dbk44
Global Const Dbk44X1& = 0
Global Const Dbk44X2& = DgainX2DbkNone&    'use with PCCard & DaqBoard/2000

' Dbk45 gain constant
Global Const Dbk45X1& = 0
Global Const Dbk45X2& = DgainX2DbkNone&    'use with PCCard & DaqBoard/2000

' Dbk48
Global Const Dbk48X1& = Dbk42X1
Global Const Dbk48X2& = Dbk42X2

' Dbk50
Global Const Dbk50Range0& = 0
Global Const Dbk50Range10& = 1
Global Const Dbk50Range100& = 2
Global Const Dbk50Range300& = 3

' Dbk50 with X2 gain on main unit
Global Const DbkPCC50Range0& = 4       ' use with PCCard & DaqBoard/2000
Global Const DbkPCC50Range10& = 5      ' use with PCCard & DaqBoard/2000
Global Const DbkPCC50Range100& = 6     ' use with PCCard & DaqBoard/2000
Global Const DbkPCC50Range300& = 7     ' use with PCCard & DaqBoard/2000

' Dbk51
Global Const Dbk51Range0& = 0
Global Const Dbk51Range100mV& = 1
Global Const Dbk51Range1& = 2
Global Const Dbk51Range10& = 3

' Dbk51 with X2 gain on main unit
Global Const DbkPCC51Range0& = 4      ' use with PCCard & DaqBoard/2000
Global Const DbkPCC51Range100mV& = 5  ' use with PCCard & DaqBoard/2000
Global Const DbkPCC51Range1& = 6      ' use with PCCard & DaqBoard/2000
Global Const DbkPCC51Range10& = 7     ' use with PCCard & DaqBoard/2000

' Dbk52 Bipolar
Global Const Dbk52BiCJC& = Dbk19BiCJC
Global Const Dbk52BiTypeJ& = Dbk19BiTypeJ
Global Const Dbk52BiTypeK& = Dbk19BiTypeK
Global Const Dbk52BiTypeT& = Dbk19BiTypeT
Global Const Dbk52BiTypeE& = Dbk19BiTypeE
Global Const Dbk52BiTypeN28& = Dbk19BiTypeN28
Global Const Dbk52BiTypeN14& = Dbk19BiTypeN14
Global Const Dbk52BiTypeS& = Dbk19BiTypeS
Global Const Dbk52BiTypeR& = Dbk19BiTypeR
Global Const Dbk52BiTypeB& = Dbk19BiTypeB
   
' PCCard & DaqBoard/2000 Dbk52 Bipolar
' place main unit in -5 to +5v range  (additional x2 gain)
' bipolar gains only
Global Const DbkPCC52BiCJC& = DbkPCC19BiCJC
Global Const DbkPCC52BiTypeJ& = DbkPCC19BiTypeJ
Global Const DbkPCC52BiTypeK& = DbkPCC19BiTypeK
Global Const DbkPCC52BiTypeT& = DbkPCC19BiTypeT
Global Const DbkPCC52BiTypeE& = DbkPCC19BiTypeE
Global Const DbkPCC52BiTypeN28& = DbkPCC19BiTypeN28
Global Const DbkPCC52BiTypeN14& = DbkPCC19BiTypeN14
Global Const DbkPCC52BiTypeS& = DbkPCC19BiTypeS
Global Const DbkPCC52BiTypeR& = DbkPCC19BiTypeR
Global Const DbkPCC52BiTypeB& = DbkPCC19BiTypeB

' Dbk52 Unipolar
Global Const Dbk52UniCJC& = Dbk19UniCJC
Global Const Dbk52UniTypeJ& = Dbk19UniTypeJ
Global Const Dbk52UniTypeK& = Dbk19UniTypeK
Global Const Dbk52UniTypeT& = Dbk19UniTypeT
Global Const Dbk52UniTypeE& = Dbk19UniTypeE
Global Const Dbk52UniTypeN28& = Dbk19UniTypeN28
Global Const Dbk52UniTypeN14& = Dbk19UniTypeN14
Global Const Dbk52UniTypeS& = Dbk19UniTypeS
Global Const Dbk52UniTypeR& = Dbk19UniTypeR
Global Const Dbk52UniTypeB& = Dbk19UniTypeB

' Dbk65
Global Const Dbk65X1& = 0
Global Const Dbk65X2& = DgainX2DbkNone& ' gain on DaqBook/Board itself
Global Const Dbk65X4& = DgainX4DbkNone&
Global Const Dbk65X8& = DgainX8DbkNone&
Global Const Dbk65X16& = DgainX16DbkNone& ' DaqBoard2000 series only
Global Const Dbk65X32& = DgainX32DbkNone& ' DaqBoard2000 series only
Global Const Dbk65X64& = DgainX64DbkNone& ' DaqBoard2000 series only

' Dbk70
Global Const Dbk70X1& = 0
Global Const Dbk70X2& = DgainX2DbkNone&  ' Use with PCCard or DaqBoard/2000 and DafBipolar (+/-5V)
                                         ' all others with DafUnipolar (or jumper) (0-5V)
Global Const Dbk70X4& = DgainX4DbkNone&  ' Use with DaqBoard/2000 and DafUnipolar (0-5V)


' Dbk80
Global Const Dbk80X1& = 0
Global Const Dbk80X2& = DgainX2DbkNone& ' gain on DaqBook/Board itself
Global Const Dbk80X4& = DgainX4DbkNone&
Global Const Dbk80X8& = DgainX8DbkNone&
Global Const Dbk80X16& = DgainX16DbkNone& ' DaqBoard2000 series only
Global Const Dbk80X32& = DgainX32DbkNone& ' DaqBoard2000 series only
Global Const Dbk80X64& = DgainX64DbkNone& ' DaqBoard2000 series only

' Dbk85
Global Const Dbk85X1& = 0
Global Const Dbk85X2& = DgainX2DbkNone& ' gain on DaqBook/Board itself
Global Const Dbk85X4& = DgainX4DbkNone&
Global Const Dbk85X8& = DgainX8DbkNone&
Global Const Dbk85X16& = DgainX16DbkNone& ' DaqBoard2000 series only
Global Const Dbk85X32& = DgainX32DbkNone& ' DaqBoard2000 series only
Global Const Dbk85X64& = DgainX64DbkNone& ' DaqBoard2000 series only

' DaqBook/Board 100,112,120,200,216,260 ONLY!
' Dbk81 & Dbk82 - Bipolar Only
Global Const Dbk81CJC& = 0
Global Const Dbk81TypeJ& = 0
Global Const Dbk81TypeK& = 0
Global Const Dbk81TypeT& = DgainX2DbkNone&
Global Const Dbk81TypeE& = 0
Global Const Dbk81TypeN28& = DgainX2DbkNone&
Global Const Dbk81TypeN14& = 0
Global Const Dbk81TypeS& = DgainX2DbkNone&
Global Const Dbk81TypeR& = DgainX2DbkNone&
Global Const Dbk81TypeB& = DgainX2DbkNone&

Global Const Dbk81x100& = 0 ' Voltage Mode (+/- 50mV) Actual gain of 99.915 gives +/-50.043 mV

' PCCard & DaqBoard/2000 Dbk81 & Dbk82 - Bipolar Only
' places main unit in -5 to +5v range  (additional x2 gain)
' bipolar gains only
Global Const DbkPCC81CJC& = DgainX2DbkNone&
Global Const DbkPCC81TypeJ& = DgainX2DbkNone&
Global Const DbkPCC81TypeK& = DgainX2DbkNone&
Global Const DbkPCC81TypeT& = DgainX4DbkNone&
Global Const DbkPCC81TypeE& = DgainX2DbkNone&
Global Const DbkPCC81TypeN28& = DgainX4DbkNone&
Global Const DbkPCC81TypeN14& = DgainX2DbkNone&
Global Const DbkPCC81TypeS& = DgainX4DbkNone&
Global Const DbkPCC81TypeR& = DgainX4DbkNone&
Global Const DbkPCC81TypeB& = DgainX4DbkNone&

Global Const DbkPCC81x100& = DgainX1DbkNone& ' Voltage Mode (+/- 100 mV) Actual gain of 99.915 gives +/- 100.085mV


' Dbk90 - Bipolar Only
Global Const Dbk90CJC& = DgainX2DbkNone&
Global Const Dbk90TypeJ& = DgainX2DbkNone&
Global Const Dbk90TypeK& = DgainX2DbkNone&
Global Const Dbk90TypeT& = DgainX4DbkNone&
Global Const Dbk90TypeE& = DgainX2DbkNone&
Global Const Dbk90TypeN28& = DgainX4DbkNone&
Global Const Dbk90TypeN14& = DgainX2DbkNone&
Global Const Dbk90TypeS& = DgainX4DbkNone&
Global Const Dbk90TypeR& = DgainX4DbkNone&
Global Const Dbk90TypeB& = DgainX4DbkNone&

' Dbk207
Global Const Dbk207X1& = 0
Global Const Dbk207X2& = DgainX2DbkNone&    'use with PCCard & DaqBoard/2000


'' Wavebook gain codes
Global Const WgcX1& = 0
Global Const WgcX2& = 1
Global Const WgcX5& = 2
Global Const WgcX10& = 3
Global Const WgcX20& = 4             'Wbk11, 12, 13, & Wbk14 only
Global Const WgcX50& = 5             'Wbk11, 12, 13, & Wbk14 only
Global Const WgcX100& = 6            'Wbk11, 12, 13, & Wbk14 only
Global Const WgcX200& = 7            'Wbk10A with Wbk11,12,or 13 installed, & Wbk14 only
Global Const WgcX0_2 = 8             'Wbk18 Gain = 0.2 DC Couple only Range = -25V to 25V

' WaveBook digital gain codes NOT currently used! : Use WgcX1 and set DaqAdcFlags as required
Global Const WgcDigital8& = 8        '8-Bit Digital             : proper DaqAdcFlags also required
Global Const WgcDigital16& = 9       '16-Bit Digital            : proper DaqAdcFlags also required
Global Const WgcCtr16& = 10          '16-Bit Counter/Timer      : proper DaqAdcFlags also required
Global Const WgcCtr32Low& = 11       '32-Bit Counter (Low Word) : proper DaqAdcFlags also required
Global Const WgcCtr32High& = 12      '32-Bit Counter (High Word): proper DaqAdcFlags also required

'TempBook/66 gain codes
Global Const TgainX1& = 0
Global Const TgainX2& = 1
Global Const TgainX5& = 2
Global Const TgainX10& = 3
Global Const TgainX20& = 5
Global Const TgainX50& = 6
Global Const TgainX100& = 7
Global Const TgainX200& = 11

' TempBook/66 Thermocouple Bipolar
Global Const TbkBiCJC& = TgainX50
Global Const TbkBiTypeJ& = TgainX100
Global Const TbkBiTypeK& = TgainX100
Global Const TbkBiTypeT& = TgainX200
Global Const TbkBiTypeE& = TgainX50
Global Const TbkBiTypeN28& = TgainX100
Global Const TbkBiTypeN14& = TgainX100
Global Const TbkBiTypeS& = TgainX200
Global Const TbkBiTypeR& = TgainX200
Global Const TbkBiTypeB& = TgainX200

' TempBook/66 Thermocouple Unipolar
Global Const TbkUniCJC& = TgainX100
Global Const TbkUniTypeJ& = TgainX200
Global Const TbkUniTypeK& = TgainX200
Global Const TbkUniTypeT& = TgainX200
Global Const TbkUniTypeE& = TgainX100
Global Const TbkUniTypeN28& = TgainX200
Global Const TbkUniTypeN14& = TgainX200
Global Const TbkUniTypeS& = TgainX200
Global Const TbkUniTypeR& = TgainX200
Global Const TbkUniTypeB& = TgainX200

' pDaq Gain Types
Global Const PgainDiv5& = 8
Global Const PgainX1& = 0
Global Const PgainX2& = 1
Global Const PgainX4& = 16
Global Const PgainX8& = 17
Global Const PgainX16& = 18
Global Const PgainX32& = 19
Global Const PgainX64& = 20
Global Const PgainX128& = 21


' ADC Flag Definitions

' Unipolar/Bipolar Flag
Global Const DafUnipolar& = &H0
Global Const DafBipolar& = &H2

' Unsigned/Signed ADC Data Flag
Global Const DafUnsigned& = &H0
Global Const DafSigned& = &H4

' Single Ended/Differential Flag
Global Const DafSingleEnded& = &H0
Global Const DafDifferential& = &H8
Global Const DafSingleEndedLow& = &H0&           ' pDaq Type
Global Const DafSingleEndedHigh& = &H1000&       ' pDaq Type

' SSH Hold/Sample Flag - For Internal Use Only
Global Const DafSSHSample& = &H0
Global Const DafSSHHold& = &H10

' Analog/High Speed Digital Flag
Global Const DafAnalog& = &H0
Global Const DafHighSpeedDigital& = &H1

' pDaq Digital or Counter Flag
Global Const DafScanDigital& = &H1

' WaveBook Digital Channel Flags
Global Const DafDigital8& = &H1
Global Const DafDigital16& = &H101

' DaqBoard/2000 P2/P3 Digital Channel Flags
Global Const DafP2Local8& = &H2001
Global Const DafP2Exp8& = &H4001
Global Const DafP3Local16& = &H1

' WaveBook & DaqBoard/2000 Counter Channel Flags
Global Const DafCtr16& = &H201
Global Const DafCtr32Low& = &H401
Global Const DafCtr32High& = &H801

' DaqBoard/2000 Counter Edge Flags
Global Const DafCtrRisingEdge& = &H0
Global Const DafCtrFallingEdge& = &H10000

' pDaq & DaqBoard/2000 Counter Types
Global Const DafCtrPulse& = &H20000
Global Const DafCtrTotalize& = &H40000

' pDaq Digital and Counter Types
Global Const DafDioDirect& = &H0
Global Const DafCtrFreq& = &H80000
Global Const DafCtrDutyLo& = &H100000
Global Const DafCtrDutyHi& = &H200000

' pDaq Notch Frequencies
Global Const DafMeasDuration610& = &H0
Global Const DafMeasDuration370& = &H100000
Global Const DafMeasDuration310& = &H200000
Global Const DafMeasDuration130& = &H300000
Global Const DafMeasDuration110& = &H400000
Global Const DafMeasDuration40& = &H500000
Global Const DafMeasDuration20& = &H600000
Global Const DafMeasDuration12_5& = &H700000

 ' DaqBoard/2000 Settling Time Control
Global Const DafSettle5us& = &H0
Global Const DafSettle10us& = &H800000
Global Const DafSettle1ms& = &H2000000

' Clear or shift the least significant nibble - typically used with 12-bit ADCs
Global Const DafIgnoreLSNibble& = &H0
Global Const DafClearLSNibble& = &H20
Global Const DafShiftLSNibble& = &H40
'Shift the least significant Digital Byte - typically used with 8-bit WaveBook DIO port
Global Const DafDigitalShiftLSByte& = &H40

' pDaq, TempBook, & DBK19/52 Thermocouple Type connected to input
Global Const DafTcTypeNone& = &H0
Global Const DafTcTypeJ& = &H80
Global Const DafTcTypeK& = &H100
Global Const DafTcTypeT& = &H180
Global Const DafTcTypeE& = &H200
Global Const DafTcTypeN28& = &H280
Global Const DafTcTypeN14& = &H300
Global Const DafTcTypeS& = &H380
Global Const DafTcTypeR& = &H400
Global Const DafTcTypeB& = &H480
Global Const DafTcCJC& = &H500
Global Const Daf64ChannelExp = &H800

' WaveBook Internal Channel Flags
Global Const DafIgnoreType& = &H1000000

Global Const DarUni0to10V& = 0           ' Unipolar  0 to +10 Volt range
Global Const DarBiMinus5to5V& = 1        ' Bipolar  -5 to  +5 Volt range
Global Const DarUniPolarDE& = 0          ' Unipolar Differential
Global Const DarBiPolarDE& = 1           ' Bipolar Differential
Global Const DarUniPolarSE& = 2          ' Unipolar Single Ended
Global Const DarBiPolarSE& = 3           ' Bipolar Single Ended

' Custom ADC Acquisition Prototypes - Scan Sequence
Declare Function BdaqAdcSetMux& Lib "daqx.dll" Alias "daqAdcSetMux" (ByVal handle&, ByVal startChan&, ByVal endChan&, ByVal gain&, ByVal flags&)
Declare Function BdaqAdcSetScan& Lib "daqx.dll" Alias "daqAdcSetScan" (ByVal handle&, channels&, gains&, flags&, ByVal CHANCOUNT&)
Declare Function BdaqAdcGetScan& Lib "daqx.dll" Alias "daqAdcGetScan" (ByVal handle&, channels&, gains&, flags&, CHANCOUNT&)


' Channel Type Definitions for Trigger Calculations
Global Const DaqTypeAnalogLocal& = 0
Global Const DaqTypeDigitalLocal& = 100000
Global Const DaqTypeDigitalExp& = 200000
Global Const DaqTypeCounterLocal& = 400000
Global Const DaqTypeDBK1& = 1
Global Const DaqTypeDBK4& = 4
Global Const DaqTypeDBK6& = 6
Global Const DaqTypeDBK7& = 7
Global Const DaqTypeDBK8& = 8
Global Const DaqTypeDBK9& = 9
Global Const DaqTypeDBK12& = 12
Global Const DaqTypeDBK13& = 13
Global Const DaqTypeDBK14& = 14
Global Const DaqTypeDBK15& = 15
Global Const DaqTypeDBK16& = 16
Global Const DaqTypeDBK17& = 17
Global Const DaqTypeDBK18& = 18
Global Const DaqTypeDBK19& = 19
Global Const DaqTypeDBK20& = 20
Global Const DaqTypeDBK21& = 21
Global Const DaqTypeDBK23& = 23
Global Const DaqTypeDBK24& = 24
Global Const DaqTypeDBK25& = 25
Global Const DaqTypeDBK42& = 42
Global Const DaqTypeDBK43& = 43
Global Const DaqTypeDBK44& = 44
Global Const DaqTypeDBK45& = 45
Global Const DaqTypeDBK48& = DaqTypeDBK42&
Global Const DaqTypeDBK50& = 50
Global Const DaqTypeDBK51& = 51
Global Const DaqTypeDBK52& = 52
Global Const DaqTypeDBK53& = 53
Global Const DaqTypeDBK54& = 54
Global Const DaqTypeDBK55& = DaqTypeDBK7&
Global Const DaqTypeDBK56& = 56
Global Const DaqTypeDBK70& = 70
Global Const DaqTypeDBK80& = 80
Global Const DaqTypeDBK81& = 81
Global Const DaqTypeDBK82& = 82
Global Const DaqTypeDBK85& = DaqTypeDBK80&
Global Const DaqTypeDBK90& = 90
Global Const DaqTypeDBK65& = DaqTypeDBK80&
Global Const DaqTypeDBK207& = 207
Global Const DaqTypeDBK208& = 208
Global Const DaqTypeDBK210& = 210

' Trigger Event Flags
Global Const DaqStartEvent& = 0
Global Const DaqStopEvent& = 1

' ADC Trigger Source Definitions
Global Const DatsImmediate& = 0
Global Const DatsSoftware& = 1
Global Const DatsAdcClock& = 2
Global Const DatsGatedAdcClock& = 3
Global Const DatsExternalTTL& = 4
Global Const DatsHardwareAnalog& = 5
Global Const DatsSoftwareAnalog& = 6
Global Const DatsEnhancedTrig& = 7
Global Const DatsDigPattern& = 8
Global Const DatsPulse& = 9
Global Const DatsScanCount& = 10
Global Const DatsCounter& = 6

' ADC Trigger Sense Definitions
Global Const DetsRisingEdge& = 0
Global Const DetsFallingEdge& = 1
Global Const DetsAboveLevel& = 2
Global Const DetsBelowLevel& = 3
Global Const DetsAfterRisingEdge& = 4
Global Const DetsAfterFallingEdge& = 5
Global Const DetsAfterAboveLevel& = 6
Global Const DetsAfterBelowLevel& = 7
Global Const DetsEQLevel& = 8
Global Const DetsNELevel& = 9
' WaveBook/516 Only
Global Const DetsWindowAboveLevelBeforeTime& = 10
Global Const DetsWindowAboveLevelAfterTime& = 11
Global Const DetsWindowBelowLevelBeforeTime& = 12
Global Const DetsWindowBelowLevelAfterTime& = 13

' Custom ADC Acquisition Prototypes - Trigger
Declare Function BdaqAdcCalcTrig& Lib "daqx.dll" Alias "daqAdcCalcTrig" (ByVal handle&, ByVal bipolar&, ByVal GainVal!, ByVal voltageLevel!, triggerLevel%)
Declare Function BdaqAdcSetTrig& Lib "daqx.dll" Alias "daqAdcSetTrig" (ByVal handle&, ByVal triggerSource&, ByVal rising&, ByVal level%, ByVal hysteresis%, ByVal channel&)
Declare Function BdaqAdcSoftTrig& Lib "daqx.dll" Alias "daqAdcSoftTrig" (ByVal handle&)

'WaveBooks Only function for setting complex triggering
'Declare Function BdaqAdcSetTrigEnhanced& Lib "daqx.dll" Alias "daqAdcSetTrigEnhanced" (ByVal handle&, ByRef trigSources&, ByRef Gains&, ByRef adcRanges&, ByRef trigSens&, ByRef levels!, ByRef hysteresis!, ByRef chan&, ByVal CHANCOUNT&, ByVal opStr$)
Declare Function BdaqAdcSetTrigEnhanced& Lib "daqx.dll" Alias "daqAdcSetTrigEnhanced" (ByVal handle&, ByRef trigSources&, ByRef gains&, ByRef adcRanges&, ByRef trigSens&, ByRef levels!, ByRef hysteresis!, ByRef chan&, ByVal CHANCOUNT&, ByRef opStr&)
Global opByte As Long

' Daq* function to set start and stop events (stop events only supported on DaqBook/2000)
' Built in level calculations, replaces the daqAdcCalcTrig, daqAdcSetTrig combination
Declare Function BdaqSetTriggerEvent& Lib "daqx.dll" Alias "daqSetTriggerEvent" (ByVal handle&, ByVal trigSource&, ByVal trigSensitivity&, ByVal channel&, ByVal GainCode&, ByVal flags&, ByVal channelType&, ByVal level!, ByVal variance!, ByVal trigEvent&)

' ADC Clock Source Definitions
Global Const DacsAdcClock& = 0
Global Const DacsGatedAdcClock& = 1
Global Const DacsTriggerSource& = 2
Global Const DacsExternalTTL& = 3
Global Const DacsAdcClockDiv2& = 4

' DaqBoard/2000 Clock Control Flags
Global Const DacsRisingEdge& = 0
Global Const DacsFallingEdge& = &H100
' DaqBoard/2000 Output Control Flags
Global Const DacsOutputDisable& = 0
Global Const DacsOutputEnable& = &H1000
                
' WaveBook/516A,512A,516E and DaqBook/2000A,X,E Master/Slave Control
Global Const DacsSyncMaster& = &H2000   ' RJ-11 External Trigger and Clock Driven as Outputs
Global Const DacsSyncSlave& = &H4000    ' RJ-11 External Trigger and Clock Set to Inputs

' ** Setup up or retrieve Freq/Period
Global Const DarmPeriod& = 0
Global Const DarmFrequency& = 1
Global Const DarmExtClockPacer& = 2
Global Const DarmTTLPacer& = 3
        
Global Const DaasPreTrig& = 0
Global Const DaasPostTrig& = 1


' Custom ADC Acquisition Prototypes - Scan Rate and Source
Declare Function BdaqAdcSetFreq& Lib "daqx.dll" Alias "daqAdcSetFreq" (ByVal handle&, ByVal freq!)
Declare Function BdaqAdcGetFreq& Lib "daqx.dll" Alias "daqAdcGetFreq" (ByVal handle&, freq!)
Declare Function BdaqAdcSetClockSource& Lib "daqx.dll" Alias "daqAdcSetClockSource" (ByVal handle&, ByVal clockSource&)
'New function for setting/getting a freq or a period,  pre or post trigger
Declare Function BdaqAdcSetRate& Lib "daqx.dll" Alias "daqAdcSetRate" (ByVal handle&, ByVal Mode&, ByVal state&, ByVal reqValue!, ByRef actualValue!)


' ADC Acquisition Mode Definitions
Global Const DaamNShot& = 0
Global Const DaamNShotRearm& = 1  ' WaveBook only
Global Const DaamInfinitePost& = 2
Global Const DaamPrePost& = 3

' Custom ADC Acquisition Prototypes - Scan Count, Rate and Source
Declare Function BdaqAdcSetAcq& Lib "daqx.dll" Alias "daqAdcSetAcq" (ByVal handle&, ByVal Mode&, ByVal preTrigCount&, ByVal postTrigCount&)

' ADC File Open Mode Definitions
Global Const DaomAppendFile& = 0
Global Const DaomWriteFile& = 1
Global Const DaomCreateFile& = 2

' Custom ADC Acquisition Prototypes - Direct-to-Disk
Declare Function BdaqAdcSetDiskFile& Lib "daqx.dll" Alias "daqAdcSetDiskFile" (ByVal handle&, ByVal FileName$, ByVal openMode&, ByVal PREWRITE&)

' Custom ADC Acquisition Prototypes - Acquisition Control
Declare Function BdaqAdcArm& Lib "daqx.dll" Alias "daqAdcArm" (ByVal handle&)
Declare Function BdaqAdcDisarm& Lib "daqx.dll" Alias "daqAdcDisarm" (ByVal handle&)

' ADC Transfer Mask Definitions
Global Const DatmCycleOff& = &H0
Global Const DatmCycleOn& = &H1

Global Const DatmUpdateBlock& = &H0
Global Const DatmUpdateSingle& = &H2
Global Const DatmUpdateAny& = &H4

Global Const DatmUserBuf& = &H0
Global Const DatmDriverBuf& = &H8
Global Const DatmIgnoreOverruns& = &H10

' WaveBook Only : Enable user-buffer overflow protection. NOTE: This mode
' changes the usage of the active and retCount arguments of daqGetTransferStat
Global Const DatmPacingMode& = &H20

'Special forced update for DaqBoard1000/2000
Global Const DatmUpdateUser = &H40


' ADC Acquisition/Transfer Active Flag Definitions
Global Const DaafAcqActive& = &H1       ' DaafAcqArmed or DaafAcqDataPresent
Global Const DaafAcqTriggered& = &H2
Global Const DaafTransferActive& = &H4
Global Const DaafAcqArmed& = &H8         ' WaveBook Only
Global Const DaafAcqDataPresent& = &H10  ' WaveBook Only : Data In Hardware FIFO

' Custom ADC Acquisition Prototypes - Data Transfer without Buffer Allocation
Declare Function BdaqAdcTransferSetBuffer& Lib "daqx.dll" Alias "daqAdcTransferSetBuffer" (ByVal handle&, buf%, ByVal ScanCount&, ByVal transferMask&)
Declare Function BdaqAdcTransferStart& Lib "daqx.dll" Alias "daqAdcTransferStart" (ByVal handle&)
Declare Function BdaqAdcTransferGetStat& Lib "daqx.dll" Alias "daqAdcTransferGetStat" (ByVal handle&, active&, retCount&)
Declare Function BdaqAdcTransferStop& Lib "daqx.dll" Alias "daqAdcTransferStop" (ByVal handle&)

' DaqAdcBufferXferMask: Driver Buffer Retrieval Flags
Global Const DabtmOldest& = &H0
Global Const DabtmNewest& = &H1
Global Const DabtmWait& = &H0
Global Const DabtmRetAvail& = &H2
Global Const DabtmNoWait& = &H4
Global Const DabtmRetNotDone& = &H8

' This function is used to request driver buffer data
Declare Function BdaqAdcTransferBufData& Lib "daqx.dll" Alias "daqAdcTransferBufData" (ByVal handle&, buf%, ByVal ScanCount&, ByVal bufMask&, retCount&)
          
' Custom ADC Acquisition Prototypes - Buffer Manipulation
Declare Function BdaqAdcBufferRotate& Lib "daqx.dll" Alias "daqAdcBufferRotate" (ByVal handle&, buf%, ByVal ScanCount&, ByVal CHANCOUNT&, ByVal retCount&)

' One-Step ADC Acquisition Prototypes
Declare Function BdaqAdcRd& Lib "daqx.dll" Alias "daqAdcRd" (ByVal handle&, ByVal chan&, sample%, ByVal gain&, ByVal flags&)
Declare Function BdaqAdcRdScan& Lib "daqx.dll" Alias "daqAdcRdScan" (ByVal handle&, ByVal startChan&, ByVal endChan&, buf%, ByVal gain&, ByVal flags&)
Declare Function BdaqAdcRdN& Lib "daqx.dll" Alias "daqAdcRdN" (ByVal handle&, ByVal chan&, buf%, ByVal ScanCount&, ByVal triggerSource&, ByVal rising&, ByVal level%, ByVal freq!, ByVal gain&, ByVal flags&)
Declare Function BdaqAdcRdScanN& Lib "daqx.dll" Alias "daqAdcRdScanN" (ByVal handle&, ByVal startChan&, ByVal endChan&, buf%, ByVal ScanCount&, ByVal triggerSource&, ByVal rising&, ByVal level%, ByVal freq!, ByVal gain&, ByVal flags&)

Global Const DardfNative& = 0
Global Const DardfPacked& = 1  ' WaveBook/512 & 512H Only
Global Const DardfByFloat& = 2 ' Personal Daq Only

Global Const DappdfRaw& = 0
Global Const DappdfTenthsDegC& = 1     'Used to read thermocouple data with the TempBook/66
        
'Sets the data formats for raw and post-processed data
Declare Function BdaqAdcSetDataFormat& Lib "daqx.dll" Alias "daqAdcSetDataFormat" (ByVal handle&, ByVal RawFormat&, ByVal PostProcFormat&)
        
'Type for raw data format conversion action
Global Const DacaUnpack& = 0
Global Const DacaPack& = 1
Global Const DacaRotate& = 2
        
' Converts file formats from packed/unpacked, also rotates file
 Declare Function BdaqCvtRawDataFormat& Lib "daqx.dll" Alias "daqCvtRawDataFormat" (buf%, ByVal action&, ByVal lastRetCount&, ByVal ScanCount&, ByVal CHANCOUNT&)
     
    
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'                                                               '
'                 DAC Definitions and Prototypes                '
'                                                               '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' DAC Device Type Definitions
Global Const DddtLocal& = 0
Global Const DddtDbk& = 1
' DaqBoard/2000 Digital Streaming Control
Global Const DddtLocalDigital& = 2

' DAC Output Mode Definitions
Global Const DdomVoltage& = 0
Global Const DdomStaticWave& = 1
Global Const DdomDynamicWave& = 2
' DaqBoard/2000 Digital Streaming Control
Global Const DdomDigitalDirect& = 0
' DaqBoard/2000 Unsigned/Signed Data Format Flags
Global Const DdomUnsigned& = 0
Global Const DdomSigned& = &H4

' DAC Global Configuration Prototypes
Declare Function BdaqDacSetOutputMode& Lib "daqx.dll" Alias "daqDacSetOutputMode" (ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal outputMode&)


' DAC Voltage Output Mode Prototypes
Declare Function BdaqDacWt& Lib "daqx.dll" Alias "daqDacWt" (ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal dataVal%)
Declare Function BdaqDacWtMany& Lib "daqx.dll" Alias "daqDacWtMany" (ByVal handle&, deviceTypes&, chans&, dataVals%, ByVal count&)


' DAC Trigger Source Definitions
Global Const DdtsImmediate& = 0
Global Const DdtsSoftware& = 1
' DaqBoard/2000 Clock Control
Global Const DdtsAdcClock& = 2

' DAC Clock Source Definitions
Global Const DdcsDacClock& = 0
Global Const DdcsGatedDacClock& = 1
Global Const DdcsAdcClock& = 2
Global Const DdcsExternalTTL& = 3
Global Const Ddcs9513Ctr1& = 4
' DaqBoard/2000 Clock Control Flags
Global Const DdcsRisingEdge& = 0
Global Const DdcsFallingEdge& = &H100
' DaqBoard/2000 Output Control Flags
Global Const DdcsOutputDisable& = 0
Global Const DdcsOutputEnable& = &H1000&

' DAC Waveform Mode Definitions
Global Const DdwmNShot& = 0
Global Const DdwmNShotRearm& = 1      ' not supported
Global Const DdwmInfinite& = 2
Global Const DdwmNFileIterations& = 3 ' DacWaveDiskFile Mode Only

' DAC Waveform Prototypes - Trigger, Update Rate and Count
Declare Function BdaqDacWaveSetTrig& Lib "daqx.dll" Alias "daqDacWaveSetTrig" (ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal triggerSource&, ByVal rising&)
Declare Function BdaqDacWaveSoftTrig& Lib "daqx.dll" Alias "daqDacWaveSoftTrig" (ByVal handle&, ByVal deviceType&, ByVal chan&)
Declare Function BdaqDacWaveSetClockSource& Lib "daqx.dll" Alias "daqDacWaveSetClockSource" (ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal clockSource&)
Declare Function BdaqDacWaveSetFreq& Lib "daqx.dll" Alias "daqDacWaveSetFreq" (ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal freq!)
Declare Function BdaqDacWaveGetFreq& Lib "daqx.dll" Alias "daqDacWaveGetFreq" (ByVal handle&, ByVal deviceType&, ByVal chan&, freq!)
Declare Function BdaqDacWaveSetMode& Lib "daqx.dll" Alias "daqDacWaveSetMode" (ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal Mode&, ByVal updateCount&)

' DAC Predefined Waveform Type Definitions
Global Const DdwtSine& = 0
Global Const DdwtSquare& = 1
Global Const DdwtTriangle& = 2

' DAC Transfer Mask Definitions
Global Const DdtmCycleOff& = &H0    ' ignored: always cycle on
Global Const DdtmCycleOn& = &H1     ' ignored: always cycle on

Global Const DdtmUpdateBlock& = &H0     ' ignored: always variable
Global Const DdtmUpdateSingle& = &H2    ' ignored: always variable

Global Const DdtmUserBuffer& = &H0
Global Const DdtmDriverBuffer& = &H4     ' DacWaveDiskFile Mode Only

' DAC Disk File Format Types (DaqDacWaveFileDataFormat)
Global Const DdwdfBinaryCounts& = &H0    ' 16 bit unsigned word - native
Global Const DdwdfBinaryCountsHL& = &H1  ' high byte/low byte
Global Const DdwdfBinaryFloat& = &H2     ' float
Global Const DdwdfBinaryDouble& = &H3    ' double
Global Const DdwdfAsciiCountsDec& = &H4  ' 0 to 65535
Global Const DdwdfAsciiCountsHex& = &H5  ' 0x0000 to 0xFFFF
Global Const DdwdfAsciiCountsBin& = &H6  ' 0 to 1111111111111111
Global Const DdwdfAsciiCountsOct& = &H7  ' 0 to 177777
Global Const DdwdfAsciiFloat& = &H8      ' -10.0 to 10.0


' DAC Waveform Prototypes - Buffer Management
Declare Function BdaqDacWaveSetBuffer& Lib "daqx.dll" Alias "daqDacWaveSetBuffer" (ByVal handle&, ByVal deviceType&, ByVal chan&, buf%, ByVal ScanCount&, ByVal transferMask&)
Declare Function BdaqDacWaveSetUserWave& Lib "daqx.dll" Alias "daqDacWaveSetUserWave" (ByVal handle&, ByVal deviceType&, ByVal chan&)
Declare Function BdaqDacWaveSetPredefWave& Lib "daqx.dll" Alias "daqDacWaveSetPredefWave" (ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal waveType&, ByVal Amplitude&, ByVal offset&, ByVal dutyCycle&, ByVal phaseShift&)
Declare Function BdaqDacWaveSetDiskFile& Lib "daqx.dll" Alias "daqDacWaveSetDiskFile" (ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal FileName$, ByVal numUpdateCycles, ByVal offsetBytes&, ByVal offsetUpdateCycles&, ByVal dataFormat&)

' DAC Waveform Prototypes - Waveform Control
Declare Function BdaqDacWaveArm& Lib "daqx.dll" Alias "daqDacWaveArm" (ByVal handle&, ByVal deviceType&)
Declare Function BdaqDacWaveDisarm& Lib "daqx.dll" Alias "daqDacWaveDisarm" (ByVal handle&, ByVal deviceType&)

' DAC Waveform/Transfer Active Flag Definitions
Global Const DdafWaveformActive& = &H1
Global Const DdafWaveformTriggered& = &H2
Global Const DdafTransferActive& = &H4
Global Const DdafUnderrun& = &H8

' DAC Transfer Prototypes - Dynamic Waveform Data Transfer
Declare Function BdaqDacTransferStart& Lib "daqx.dll" Alias "daqDacTransferStart" (ByVal handle&, ByVal deviceType&, ByVal chan&)
Declare Function BdaqDacTransferGetStat& Lib "daqx.dll" Alias "daqDacTransferGetStat" (ByVal handle&, ByVal deviceType&, ByVal chan&, active&, retCount&)
Declare Function BdaqDacTransferStop& Lib "daqx.dll" Alias "daqDacTransferStop" (ByVal handle&, ByVal deviceType&, ByVal chan&)


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'                                                               '
'          Data Conversion Definitions and Prototypes           '
'                                                               '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' Sets A/D min and max range
Declare Function BdaqCvtSetAdcRange& Lib "daqx.dll" Alias "daqCvtSetAdcRange" (ByVal ADmin!, ByVal ADmax!)

' Linear Conversion Prototypes
Declare Function BdaqCvtLinearSetup& Lib "daqx.dll" Alias "daqCvtLinearSetup" (ByVal nscan&, ByVal readingsPos&, ByVal nReadings&, ByVal signal1!, ByVal voltage1!, ByVal signal2!, ByVal voltage2!, ByVal avg&)
Declare Function BdaqCvtLinearConvert& Lib "daqx.dll" Alias "daqCvtLinearConvert" (counts%, ByVal SCANS&, fValues!, ByVal nValues&)
Declare Function BdaqCvtLinearSetupConvert& Lib "daqx.dll" Alias "daqCvtLinearSetupConvert" (ByVal nscan&, ByVal readingsPos&, ByVal nReadings&, ByVal signal1!, ByVal voltage1!, ByVal signal2!, ByVal voltage2!, ByVal avg&, counts%, ByVal SCANS&, fValues!, ByVal nValues&)

' Software Calibration Type Definitions
Global Const DcalTypeDefault& = 0
Global Const DcalTypeCJC& = 1            ' channel to be calibrated is a real CJC reading - not a CJC zero reading
Global Const DcalDbk4Bypass& = 2         ' channel to be calibrated using the methods and structures
' for a Dbk4 with the filters bypassed (set by jumper on the card).
Global Const DcalDbk4Filter& = 3         ' channel to be calibrated using the methods and sturctures
                                         ' for a Dbk4 with the cutoff filters enabled.

'DaqCalInputT
Global Const DciNormal& = 0            'External signal from device input connector(s)
Global Const DciCalGround& = 1 'Internal calibration ground signal
Global Const DciCal5V& = 2 ' Internal 5V calibration signal
Global Const DciCal500mV& = 3 ' Internal 500mV calibration signal


'DaqCalTableTypeT
Global Const DcttFactory& = 0 ' Factory calibration constants
Global Const DcttUser& = 1 ' User-defined calibration constants
Global Const DcttBaseline& = 2 ' Unity Gain - No Offset


'DaqCalOperationT
Global Const DcoGetConstants& = 0
Global Const DcoSetConstants& = 1
Global Const DcoSelectInput& = 2
Global Const DcoSelectTable& = 3
Global Const DcoSaveConstants& = 4
Global Const DcoGetCalPtr& = 5
Global Const DCoSetResponseDac& = 6
Global Const DcoSaveTable& = 7
Global Const DcoGetRefDacConstants& = 8
Global Const DcoSetRefDacConstants& = 9
Global Const DcoGetTrigDacConstants& = 10
Global Const DcoSetTrigDacConstants& = 11


'DaqCalRefDacChannelT
Global Const DcrcPosRefDac& = 0           ' positive reference DAC channel
Global Const DcrcNegRefDac& = 1           ' negative reference DAC channel

'
'DaqCalTrigDacChannelT
Global Const CctdcTrigThresholdDac& = 0   ' Trigger Threshold DAC
Global Const CctdcTrigHysteresisDac& = 1  ' Trigger Hysteresis DAC
Global Const CctdcTrigBelowLevel& = 0     ' Trigger Value Below DAC Value
Global Const CctdcTrigAboveLevel& = 2     ' Trigger Value Above DAC Value

'
'DaqCalOptionT
Global Const DcoptMainUnit& = 0
Global Const DcoptOptionUnit& = 1
Global Const DcoptUserCal& = 2
Global Const DcoptSensorCal& = 3


' Software Calibration Prototypes
Declare Function BdaqCalSetup& Lib "daqx.dll" Alias "daqCalSetup" (ByVal handle&, ByVal nscan&, ByVal readingsPos&, ByVal nReadings&, ByVal chanType&, ByVal chanGain&, ByVal startChan&, ByVal bipolar&, ByVal noOffset&)
Declare Function BdaqCalConvert& Lib "daqx.dll" Alias "daqCalConvert" (ByVal handle&, counts%, ByVal SCANS&)
Declare Function BdaqCalSetupConvert& Lib "daqx.dll" Alias "daqCalSetupConvert" (ByVal handle&, ByVal nscan&, ByVal readingsPos&, ByVal nReadings&, ByVal chanType&, ByVal chanGain&, ByVal startChan&, ByVal bipolar&, ByVal noOffset&, counts%, ByVal SCANS&)
Declare Function BdaqReadCalFile& Lib "daqx.dll" Alias "daqReadCalFile" (ByVal handle&, ByVal calfile$)
Declare Function BdaqCalSelectInputSignal& Lib "daqx.dll" Alias "daqCalSelectInputSignal" (ByVal handle&, inputSignal&) ' As DaqCalInputT)
Declare Function BdaqCalSelectCalTable& Lib "daqx.dll" Alias "daqCalSelectCalTable" (ByVal handle&, ByVal tableType)
Declare Function BdaqCalSetConstants& Lib "daqx.dll" Alias "daqCalSetConstants" (ByVal handle&, ByVal channel, ByVal gain, ByVal range, ByVal gainConstant, ByVal offsetConstant)
Declare Function BdaqCalGetConstants& Lib "daqx.dll" Alias "daqCalGetConstants" (ByVal handle&, ByVal channel, ByVal gain, ByVal range, ByRef gainConstant%, ByRef offsetConstant%)
Declare Function BdaqCalSaveConstants& Lib "daqx.dll" Alias "daqCalSaveConstants" (ByVal handle&, ByVal channel)
Declare Function BdaqConfCalConstants& Lib "daqx.dll" Alias "daqConfCalConstants" (ByVal handle&, ByVal chan&, ByVal gain&, ByVal adcRange&, gainConst%, offsetConst%, ByVal operation&, ByVal tableType&, ByVal inputdat&, ByVal optionType)

' Zero Compensation Definitions
Global Const DazcNone& = 0     'Do not include auto-zero compensation in TC conversion.
Global Const DazcAutoZero& = 1 'Apply auto-zero compensation in TC conversion.

' Zero Compensation Prototypes
Declare Function BdaqAutoZeroCompensate& Lib "daqx.dll" Alias "daqAutoZeroCompensate" (ByVal zero&)
Declare Function BdaqZeroSetup& Lib "daqx.dll" Alias "daqZeroSetup" (ByVal nscan&, ByVal zeroPos&, ByVal readingsPos&, ByVal nReadings&)
Declare Function BdaqZeroConvert& Lib "daqx.dll" Alias "daqZeroConvert" (counts%, ByVal SCANS&)
Declare Function BdaqZeroSetupConvert& Lib "daqx.dll" Alias "daqZeroSetupConvert" (ByVal nscan&, ByVal zeroPos&, ByVal readingsPos&, ByVal nReadings&, counts%, ByVal SCANS&)
Declare Function BdaqZeroDbk19& Lib "daqx.dll" Alias "daqZeroDbk19" (ByVal zero&)

' RTD Type Definitions
Global Const Dbk9RtdType100& = 0         ' RTD 100 ohm  Platinum alpha = .00385
Global Const Dbk9RtdType500& = 1         ' RTD 500 ohm  Platinum alpha = .00385
Global Const Dbk9RtdType1K& = 2          ' RTD 1000 ohm Platinum alpha = .00385

' Rtd Conversion Prototypes
Declare Function BdaqCvtRtdConvert& Lib "daqx.dll" Alias "daqCvtRtdConvert" (counts%, ByVal SCANS&, temp%, ByVal ntemp&)
Declare Function BdaqCvtRtdSetup& Lib "daqx.dll" Alias "daqCvtRtdSetup" (ByVal nscan&, ByVal startPosition&, ByVal nRtd&, ByVal rtdType&, ByVal avg&)
Declare Function BdaqCvtRtdSetupConvert& Lib "daqx.dll" Alias "daqCvtRtdSetupConvert" (ByVal nscan&, ByVal startPosition&, ByVal nRtd&, ByVal rtdType&, ByVal avg&, counts%, ByVal SCANS&, temp%, ByVal ntemp&)

' Thermocouple Type Definitions
' Dbk14
Global Const Dbk14TCTypeJ& = 0
Global Const Dbk14TCTypeK& = 1
Global Const Dbk14TCTypeT& = 2
Global Const Dbk14TCTypeE& = 3
Global Const Dbk14TCTypeN28& = 4
Global Const Dbk14TCTypeN14& = 5
Global Const Dbk14TCTypeS& = 6
Global Const Dbk14TCTypeR& = 7
Global Const Dbk14TCTypeB& = 8

' Dbk19
Global Const Dbk19TCTypeJ& = 9
Global Const Dbk19TCTypeK& = 10
Global Const Dbk19TCTypeT& = 11
Global Const Dbk19TCTypeE& = 12
Global Const Dbk19TCTypeN28& = 13
Global Const Dbk19TCTypeN14& = 14
Global Const Dbk19TCTypeS& = 15
Global Const Dbk19TCTypeR& = 16
Global Const Dbk19TCTypeB& = 17

' Dbk52
Global Const Dbk52TCTypeJ& = Dbk19TCTypeJ
Global Const Dbk52TCTypeK& = Dbk19TCTypeK
Global Const Dbk52TCTypeT& = Dbk19TCTypeT
Global Const Dbk52TCTypeE& = Dbk19TCTypeE
Global Const Dbk52TCTypeN28& = Dbk19TCTypeN28
Global Const Dbk52TCTypeN14& = Dbk19TCTypeN14
Global Const Dbk52TCTypeS& = Dbk19TCTypeS
Global Const Dbk52TCTypeR& = Dbk19TCTypeR
Global Const Dbk52TCTypeB& = Dbk19TCTypeB

' Dbk81 & Dbk82
Global Const Dbk81TCTypeJ& = 27
Global Const Dbk81TCTypeK& = 28
Global Const Dbk81TCTypeT& = 29
Global Const Dbk81TCTypeE& = 30
Global Const Dbk81TCTypeN28& = 31
Global Const Dbk81TCTypeN14& = 32
Global Const Dbk81TCTypeS& = 33
Global Const Dbk81TCTypeR& = 34
Global Const Dbk81TCTypeB& = 35
Global Const Dbk81CJCType& = 36 ' for CJC counts to DegC conversion

' Dbk90
 Global Const Dbk90TCTypeJ& = 27
 Global Const Dbk90TCTypeK& = 28
 Global Const Dbk90TCTypeT& = 29
 Global Const Dbk90TCTypeE& = 30
 Global Const Dbk90TCTypeN28& = 31
 Global Const Dbk90TCTypeN14& = 32
 Global Const Dbk90TCTypeS& = 33
 Global Const Dbk90TCTypeR& = 34
 Global Const Dbk90TCTypeB& = 35
 Global Const Dbk90CJCType& = 36         ' for CJC counts to DegC conversion

 Global Const IntTempTCTypeJ& = 47
 Global Const IntTempTCTypeK& = 48
 Global Const IntTempTCTypeT& = 49
 Global Const IntTempTCTypeE& = 50
 Global Const IntTempTCTypeN28& = 51
 Global Const IntTempTCTypeN14& = 52
 Global Const IntTempTCTypeS& = 53
 Global Const IntTempTCTypeR& = 54
 Global Const IntTempTCTypeB& = 55
 Global Const IntTempCJCType& = 56

' TempBook/66
Global Const TbkTCTypeJ& = 18
Global Const TbkTCTypeK& = 19
Global Const TbkTCTypeT& = 20
Global Const TbkTCTypeE& = 21
Global Const TbkTCTypeN28& = 22
Global Const TbkTCTypeN14& = 23
Global Const TbkTCTypeS& = 24
Global Const TbkTCTypeR& = 25
Global Const TbkTCTypeB& = 26

' Thermocouple Conversion Prototypes
Declare Function BdaqCvtTCConvert& Lib "daqx.dll" Alias "daqCvtTCConvert" (counts%, ByVal SCANS&, temp%, ByVal ntemp&)
Declare Function BdaqCvtTCSetup& Lib "daqx.dll" Alias "daqCvtTCSetup" (ByVal nscan&, ByVal cjcPosition&, ByVal ntc&, ByVal tcType&, ByVal bipolar&, ByVal avg&)
Declare Function BdaqCvtTCSetupConvert& Lib "daqx.dll" Alias "daqCvtTCSetupConvert" (ByVal nscan&, ByVal cjcPosition&, ByVal ntc&, ByVal tcType&, ByVal bipolar&, ByVal avg&, counts%, ByVal SCANS&, temp%, ByVal ntemp&)


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'                                                               '
'            General I/O Definitions and Prototypes             '
'                                                               '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' I/O Device Type Definitions
Global Const DiodtLocalBitIO& = 0
Global Const DiodtLocal8255& = 1
Global Const DiodtP2Local8& = 12        ' P2 local addressing by byte
Global Const DiodtP3LocalDig16& = 1     ' P3 local digital port by word
Global Const DiodtLocal9513& = 2
Global Const DiodtP3LocalCtr16& = 2     ' P3 local counter addressing by word
Global Const DiodtP2Exp8& = 6           ' P2 expansion addressing by byte
Global Const DiodtExp8255& = 3         ' Dbk20, Dbk21
Global Const DiodtDbk23& = 4
Global Const DiodtDbk24& = 5
Global Const DiodtDbk25& = 6
Global Const DiodtDbk208& = 6
Global Const DiodtDbk210& = 6
Global Const DiodtExp9513& = 7         ' Not available
Global Const DiodtWbk512& = 8
Global Const DiodtWbk516& = 8
Global Const DiodtWbk17& = 13
Global Const DiodtLocal8254& = 9        ' tempbook only
Global Const Diodt8254Dig& = 10         ' tempbook only
Global Const Diodt8254Ctr& = 11         ' tempbook only



' I/O Port Type Definitions

' Local Bit I/O
Global Const DiodpBitIO& = 0


' Local 8254
Global Const Diodp8254Trig& = 10
Global Const Diodp8254A& = 12
Global Const Diodp8254B& = 13
Global Const Diodp8254C& = 14
Global Const Diodp8254IR& = 15

'P2 sequential 8-Bit addressing
Global Const DiodpP2Local8& = 0  ' I/O
Global Const DiodpP2LocalIR& = 3 ' Config
Global Const DiodpP2Exp8& = 0    ' I/O
Global Const DiodpP2ExpIR& = 3   ' Config

' P3 digital port
Global Const DiodpP3LocalDig16& = 0   ' I/O
Global Const DiodpP3LocalDigIR& = 1   ' Config

' Local 8255, Dbk20, Dbk21
Global Const Diodp8255A& = 0      ' I/O
Global Const Diodp8255B& = 1      ' I/O
Global Const Diodp8255C& = 2      ' I/O
Global Const Diodp8255IR& = 3     ' Config
Global Const Diodp8255CHigh& = 4  ' I/O
Global Const Diodp8255CLow& = 5   ' I/O

' Local 9513, Expansion 9513
Global Const Diodp9513Command& = 0
Global Const Diodp9513Data& = 1
Global Const Diodp9513MasterMode& = 2
Global Const Diodp9513Alarm1& = 3
Global Const Diodp9513Alarm2& = 4
Global Const Diodp9513Status& = 5
Global Const Diodp9513Mode1& = 6
Global Const Diodp9513Mode2& = 7
Global Const Diodp9513Mode3& = 8
Global Const Diodp9513Mode4& = 9
Global Const Diodp9513Mode5& = 10
Global Const Diodp9513Load1& = 11
Global Const Diodp9513Load2& = 12
Global Const Diodp9513Load3& = 13
Global Const Diodp9513Load4& = 14
Global Const Diodp9513Load5& = 15
Global Const Diodp9513Hold1& = 16
Global Const Diodp9513Hold2& = 17
Global Const Diodp9513Hold3& = 18
Global Const Diodp9513Hold4& = 19
Global Const Diodp9513Hold5& = 20
Global Const Diodp9513Hold1HC& = 21      ' Hold register when in hold cycle mode
Global Const Diodp9513Hold2HC& = 22      ' Hold register when in hold cycle mode
Global Const Diodp9513Hold3HC& = 23      ' Hold register when in hold cycle mode
Global Const Diodp9513Hold4HC& = 24      ' Hold register when in hold cycle mode
Global Const Diodp9513Hold5HC& = 25      ' Hold register when in hold cycle mode
Global Const DiodpP3LocalCtr16& = 26

' Dbk23
Global Const DiodpDbk23A& = 0
Global Const DiodpDbk23B& = 1
Global Const DiodpDbk23C& = 2
Global Const DiodpDbk23Unused& = 3

' Dbk24
Global Const DiodpDbk24A& = 0
Global Const DiodpDbk24B& = 1
Global Const DiodpDbk24C& = 2
Global Const DiodpDbk24Unused& = 3

' Dbk25
Global Const DiodpDbk25& = 0

' Dbk208
Global Const DiodpDbk208& = 0

' Dbk210
Global Const DiodpDbk210& = 0

' WaveBook/512
Global Const DiodpWbk512Port0& = 0
Global Const DiodpWbk512Port1& = 1
Global Const DiodpWbk512Port2& = 2
Global Const DiodpWbk512Port3& = 3
Global Const DiodpWbk512Port4& = 4
Global Const DiodpWbk512Port5& = 5
Global Const DiodpWbk512Port6& = 6
Global Const DiodpWbk512Port7& = 7
Global Const DiodpWbk512Port8& = 8
Global Const DiodpWbk512Port9& = 9
Global Const DiodpWbk512Port10& = 10
Global Const DiodpWbk512Port11& = 11
Global Const DiodpWbk512Port12& = 12
Global Const DiodpWbk512Port13& = 13
Global Const DiodpWbk512Port14& = 14
Global Const DiodpWbk512Port15& = 15
Global Const DiodpWbk512Port16& = 16
Global Const DiodpWbk512Port17& = 17
Global Const DiodpWbk512Port18& = 18
Global Const DiodpWbk512Port19& = 19
Global Const DiodpWbk512Port20& = 20
Global Const DiodpWbk512Port21& = 21
Global Const DiodpWbk512Port22& = 22
Global Const DiodpWbk512Port23& = 23
Global Const DiodpWbk512Port24& = 24
Global Const DiodpWbk512Port25& = 25
Global Const DiodpWbk512Port26& = 26
Global Const DiodpWbk512Port27& = 27
Global Const DiodpWbk512Port28& = 28
Global Const DiodpWbk512Port29& = 29
Global Const DiodpWbk512Port30& = 30
Global Const DiodpWbk512Port31& = 31

' WaveBook/516
Global Const DiodpWbk516_8Bit& = 0
Global Const DiodpWbk516_16Bit& = 32

' WBK17 Digital Output : Write Only
Global Const DiodpWbk17_8Bit& = 33

' I/O Expansion Port Code Definitions
Global Const DioepP1& = 0                ' DigiBook only
Global Const DioepP2& = 1
Global Const DioepP3& = 2

' used for Tempbook66 cntr0 configurations
Global Const Dc0cHighTermCnt& = &H30
Global Const Dc0cONeShot& = &H32
Global Const Dc0cDivByNCtr& = &H34
Global Const Dc0cSquareWave& = &H36
Global Const Dc0csoftTrigStrobe& = &H38
Global Const Dc0cHardTrigStrobe& = &H3A


' General I/O Prototypes - Read/Write
Declare Function BdaqIOReadBit& Lib "daqx.dll" Alias "daqIOReadBit" (ByVal handle&, ByVal devType&, ByVal devPort&, ByVal whichDevice&, ByVal whichExpPort&, ByVal bitNum&, bitValue&)
Declare Function BdaqIORead& Lib "daqx.dll" Alias "daqIORead" (ByVal handle&, ByVal devType&, ByVal devPort&, ByVal whichDevice&, ByVal whichExpPort&, value&)
Declare Function BdaqIOWriteBit& Lib "daqx.dll" Alias "daqIOWriteBit" (ByVal handle&, ByVal devType&, ByVal devPort&, ByVal whichDevice&, ByVal whichExpPort&, ByVal bitNum&, ByVal bitValue&)
Declare Function BdaqIOWrite& Lib "daqx.dll" Alias "daqIOWrite" (ByVal handle&, ByVal devType&, ByVal devPort&, ByVal whichDevice&, ByVal whichExpPort&, ByVal value&)
Declare Function BdaqIOGet8255Conf& Lib "daqx.dll" Alias "daqIOGet8255Conf" (ByVal handle&, ByVal portA&, ByVal portB&, ByVal portCHigh&, ByVal portCLow&, config&)



'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'                                                               '
'         9513 Counter/Timer Definitions and Prototypes         '
'                                                               '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' 9513 Time-of-Day Definitions
Global Const DtodDisabled& = 0
Global Const DtodDivideBy5& = 1
Global Const DtodDivideBy6& = 2
Global Const DtodDivideBy10& = 3

' 9513 Gating Control Definitions
Global Const DgcNoGating& = 0
Global Const DgcHighTCNM1& = 1
Global Const DgcHighLevelGateNP1& = 2
Global Const DgcHighLevelGateNM1& = 3
Global Const DgcHighLevelGateN& = 4
Global Const DgcLowLevelGateN& = 5
Global Const DgcHighEdgeGateN& = 6
Global Const DgcLowEdgeGateN& = 7

' 9513 Count Source Definitions
Global Const DcsTcnM1& = 0               ' not valid with daq9513SetMasterMode or daqCtrRdFreq
Global Const DcsSrc1& = 1
Global Const DcsSrc2& = 2
Global Const DcsSrc3& = 3
Global Const DcsSrc4& = 4
Global Const DcsSrc5& = 5
Global Const DcsGate1& = 6
Global Const DcsGate2& = 7
Global Const DcsGate3& = 8
Global Const DcsGate4& = 9
Global Const DcsGate5& = 10              ' not valid with daqCtrRdFreq
Global Const DcsF1& = 11                 ' not valid with daqCtrRdFreq
Global Const DcsF2& = 12                 ' not valid with daqCtrRdFreq
Global Const DcsF3& = 13                 ' not valid with daqCtrRdFreq
Global Const DcsF4& = 14                 ' not valid with daqCtrRdFreq
Global Const DcsF5& = 15                 ' not valid with daqCtrRdFreq

' 9513 Output Control Definitions
Global Const DocInactiveLow& = 0
Global Const DocHighTermCntPulse& = 1
Global Const DocTCToggled& = 2
Global Const DocInactiveHighImp& = 3
Global Const DocLowTermCntPulse& = 4

' 9513 Multiple Counter Command Definitions
Global Const DmccArm& = 0
Global Const DmccLoad& = 1
Global Const DmccLoadArm& = 2
Global Const DmccDisarmSave& = 3
Global Const DmccSave& = 4
Global Const DmccDisarm& = 5

' 9513 Counter/Timer Prototypes
Declare Function Bdaq9513SetMasterMode& Lib "daqx.dll" Alias "daq9513SetMasterMode" (ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal foutDiv&, ByVal cntSource&, ByVal comp1&, ByVal comp2&, ByVal tod&)
Declare Function Bdaq9513SetAlarm& Lib "daqx.dll" Alias "daq9513SetAlarm" (ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal alarmNum&, ByVal alarmVal&)
Declare Function Bdaq9513SetCtrMode& Lib "daqx.dll" Alias "daq9513SetCtrMode" (ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal ctrNum&, ByVal gateCtrl&, ByVal cntEdge&, ByVal cntSource&, ByVal specGate&, ByVal reload&, ByVal cntRepeat&, ByVal cntType&, ByVal cntDir&, ByVal outputCtrl&)
Declare Function Bdaq9513MultCtrl& Lib "daqx.dll" Alias "daq9513MultCtrl" (ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal ctrCmd&, ByVal CTR1&, ByVal ctr2&, ByVal ctr3&, ByVal ctr4&, ByVal ctr5&)
Declare Function Bdaq9513GetHold& Lib "daqx.dll" Alias "daq9513GetHold" (ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal ctrNum&, ctrVal%)
Declare Function Bdaq9513SetHold& Lib "daqx.dll" Alias "daq9513SetHold" (ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal ctrNum&, ByVal ctrVal%)
Declare Function Bdaq9513SetLoad& Lib "daqx.dll" Alias "daq9513SetLoad" (ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal ctrNum&, ByVal ctrVal%)
Declare Function Bdaq9513RdFreq& Lib "daqx.dll" Alias "daq9513RdFreq" (ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal interval&, ByVal cntSource&, count&)


'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'                                                               '
'   Communications test/performance Definitions and Prototypes  '
'          - Internally used                                    '
'                                                               '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' DaqTest Command Definitions
Global Const DtstBaseAddressValid& = 0
Global Const DtstInterruptLevelValid& = 1
Global Const DtstDmaChannelValid& = 2
Global Const DtstAdcFifoInputSpeed& = 3
Global Const DtstDacFifoOutputSpeed& = 4
Global Const DtstIOInputSpeed& = 5
Global Const DtstIOOutputSpeed& = 6
Global Const DtstFifoAddrDataBusValid& = 7
Global Const DtstFifoMemCellValid& = 8 ' WBK30 Only
Global Const DtstHardwareCompatibility& = 9 ' WaveBook Only
Global Const DtstFirmwareCompatibility& = 10 ' WaveBook Only
Global Const DtstExpansionCompatibility& = 11 ' WaveBook Only
Global Const DtstExpUpgradeCompatibility& = 12 ' WaveBook Only

' Use these for range checking.  Always update when adding/removing enum's.
Global Const Dtst_ParamRangeMin& = DtstBaseAddressValid        ' Lowest valid value
Global Const Dtst_ParamRangeMax& = DtstExpUpgradeCompatibility   ' Highest valid value

' DaqTest Prototype
Declare Function BdaqTest& Lib "daqx.dll" Alias "daqTest" (ByVal handle&, ByVal command&, ByVal count&, cmdAvailable&, result&)


 ''***************************************************************
 ''
 ''  Register level IO Definitions and Prototypes
 ''    - Internally used
 ''
 ''  NOT SUPPORTED
 ''
 ''  NOTE:  these functions are not intended to be used in user
 ''         applications
 ''
 ''***************************************************************
        
  '' Register IO Defintions
  '' DaqBook/DaqBoard output registers
Global Const DregOutDAC0 = &H4                     '' DaqBoard (16-bit) DaqBook (low byte)
Global Const DregOutDAC0High = &H5                 ' DaqBook only (high byte)
Global Const DregOutDAC1 = &H6                     ' DaqBoard (16-bit) DaqBook (low byte)
Global Const DregOutDAC1High = &H7                 ' DaqBook only (high byte)
Global Const DregOuttrigSource = &HA
Global Const DregOutAuxControl = &HB
Global Const DregOut8254IR = &HF
Global Const DregOut8255IR = &H13
Global Const DregOutDacFIFO = &H16                  ' DaqBoard only (16-bit)
'Global Const DregOutauxControl = &H19
Global Const DregOutADCfifo = &H1A                  ' DaqBoard (16-bit) DaqBook (low byte)
Global Const DregOutADCfifoHigh = &H1B              ' DaqBook only (high byte)

'           ' DaqBook/DaqBoard input registers
Global Const DregInADCfifo = &H0                    ' DaqBoard 16-bit DaqBook (low byte)
Global Const DregInADCfifoHigh = &H1                ' DaqBook only (high byte)
Global Const DregInstatReg = &H8
Global Const DregInEventStatus = &HB
Global Const DregInEventStatusX = &H15              ' DaqBoard only
Global Const DregInIntIDX = &H18                    ' DaqBoard only
Global Const DregInIntID = &H1F
        
'           ' DaqBook/DaqBoard input/output registers
Global Const DregBitDIO = &H3
Global Const DregDACctrl = &H9                      ' DaqBoard only
Global Const Dreg8254C0 = &HC
Global Const Dreg8254C1 = &HD
Global Const Dreg8254C2 = &HE
Global Const Dreg8255A = &H10
Global Const Dreg8255B = &H11
Global Const Dreg8255C = &H12
Global Const DregIntMaskX = &H14                    ' DaqBoard only
Global Const Dreg9513Data = &H1C
Global Const Dreg9513IR = &H1D
Global Const DregIntMask = &H1E
Global Const Dreg8255A0B0 = &H60
Global Const Dreg8255A0B1 = &H61
Global Const Dreg8255A0B2 = &H62
Global Const Dreg8255A0IR = &H63
Global Const Dreg8255A1B0 = &H64
Global Const Dreg8255A1B1 = &H65
Global Const Dreg8255A1B2 = &H66
Global Const Dreg8255A1IR = &H67
Global Const Dreg8255B0B0 = &H68
Global Const Dreg8255B0B1 = &H69
Global Const Dreg8255B0B2 = &H6A
Global Const Dreg8255B0IR = &H6B
Global Const Dreg8255B1B0 = &H6C
Global Const Dreg8255B1B1 = &H6D
Global Const Dreg8255B1B2 = &H6E
Global Const Dreg8255B1IR = &H6F
Global Const Dreg8255C0B0 = &H70
Global Const Dreg8255C0B1 = &H71
Global Const Dreg8255C0B2 = &H72
Global Const Dreg8255C0IR = &H73
Global Const Dreg8255C1B0 = &H74
Global Const Dreg8255C1B1 = &H75
Global Const Dreg8255C1B2 = &H76
Global Const Dreg8255C1IR = &H77
Global Const Dreg8255D0B0 = &H78
Global Const Dreg8255D0B1 = &H79
Global Const Dreg8255D0B2 = &H7A
Global Const Dreg8255D0IR = &H7B
Global Const Dreg8255D1B0 = &H7C
Global Const Dreg8255D1B1 = &H7D
Global Const Dreg8255D1B2 = &H7E
Global Const Dreg8255D1IR = &H7F

' RegTypeFlags
Global Const RtfDeviceRegs = &H0
Global Const RtfLptPort = &H10000
Global Const RtfDspDM = &H20000
Global Const RtfDspPM = &H30000

Declare Function BdaqRegWrite& Lib "daqx.dll" Alias "daqRegWrite" (ByVal handle&, ByVal reg&, ByVal value&)
Declare Function BdaqRegRead& Lib "daqx.dll" Alias "daqRegRead" (ByVal handle&, ByVal reg&, ByVal value&)


''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''                                                              ''
''         obsolete:                                            ''
''         unsupported legacy functions & internal commands     ''
''         do not use.                                          ''
''                                                              ''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Declare Function BdspCmd& Lib "daqx.dll" Alias "dspCmd" (ByVal handle&, ByVal action&, ByVal memType&, ByVal addr&, data&)
Declare Function BdaqBlockMemIO& Lib "daqx.dll" Alias "daqBlockMemIO" (ByVal handle&, ByVal action&, ByVal blockType&, ByVal whichBlock&, ByVal addr&, ByVal count&, buf&)
Declare Function BdaqBlockMemIOW& Lib "daqx.dll" Alias "daqBlockMemIO" (ByVal handle&, ByVal action&, ByVal blockType&, ByVal whichBlock&, ByVal addr&, ByVal count&, buf%)
Declare Function BdaqBlockMemIOB& Lib "daqx.dll" Alias "daqBlockMemIO" (ByVal handle&, ByVal action&, ByVal blockType&, ByVal whichBlock&, ByVal addr&, ByVal count&, buf As Byte)
Declare Function BdaqDumpDriverDebugBuffer& Lib "daqx.dll" Alias "daqDumpDriverDebugBuffer" (ByVal handle&, ByVal sBuf$, ByVal charCount&)
Declare Function BdaqAdcTransferSetBufferAllocMem& Lib "daqx.dll" Alias "daqAdcTransferSetBufferAllocMem" (ByVal handle&, ByVal ScanCount&, ByVal transferMask&)
Declare Function BdaqAdcTransferStopAllocMem& Lib "daqx.dll" Alias "daqAdcTransferStopAllocMem" (ByVal handle&, buf%, ByVal ScanCount&)
Declare Function Bdaq_selftest& Lib "daqx.dll" Alias "daq_selftest" (ByVal device_name$, ByVal error_msg$)

' I/O Operation Code Definitions
Global Const DioecP1IR& = 0              ' DigiBook only
Global Const DioecP2IR& = 1
Global Const DioecP3IR& = 2

' I/O Operation Code Definitions
Global Const DioocReadByte& = 0
Global Const DioocWriteByte& = 1
Global Const DioocReadWord& = 2
Global Const DioocWriteWord& = 3
Global Const DioocReadDWord& = 4
Global Const DioocWriteDWord& = 5

' I/O Transfer Mask Definitions
Global Const DiotmCycleOff& = 0
Global Const DiotmCycleOn& = 1

' I/O Transfer Active Flag Definitions
Global Const DioafDone& = 0
Global Const DioafArmed& = 1
Global Const DioafTriggered& = 2

' General I/O Prototypes - Transfer
' NOTE: Following functions perform no action in this release
'       They simply return DerrNotCapable
Declare Function BdaqIOTransferReset& Lib "daqx.dll" Alias "daqIOTransferReset" (ByVal handle&)
Declare Function BdaqIOTransferSetBuffer& Lib "daqx.dll" Alias "daqIOTransferSetBuffer" (ByVal handle&, ByVal eventCode&, ByVal devType&, ByVal devPort&, ByVal whichDevice&, ByVal whichExpPort&, ByVal opCode&, buf As Any, ByVal bufCount&)
Declare Function BdaqIOTransferStart& Lib "daqx.dll" Alias "daqIOTransferStart" (ByVal handle&)
Declare Function BdaqIOTransferGetStat& Lib "daqx.dll" Alias "daqIOTransferGetStat" (ByVal handle&, ByVal devType&, ByVal devPort&, ByVal whichDevice&, ByVal whichExpPort&, active&, retCount&)
Declare Function BdaqIOTransferStop& Lib "daqx.dll" Alias "daqIOTransferStop" (ByVal handle&)

Global Const DaqBook2001& = 24
Global Const DaqBook2002& = 25
Global Const DaqBook2003& = 26
Global Const DaqBook2004& = 27
Global Const DaqBook2005& = 28

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'                                                               '
'        Device Inventory Definitions and Prototypes            '
'                                                               '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

' DaqInfoType - Device Information Type Definitions
Global Const DaqInfoTypeUnknown& = 0
Global Const DaqInfoTypeGeneric& = 1
Global Const DaqInfoTypeTcp& = 2
Global Const DaqInfoTypeTcpChild& = 3
Global Const DaqInfoTypeParallel& = 4
Global Const DaqInfoTypePci& = 5
Global Const DaqInfoTypePcCard& = 6

' DaqIPModeT - IP Mode Definitions
Global Const DaqIPModeAutoDetect = 0 ' the IP address and other TCP settings are detected based on the serial number of the device
Global Const DaqIPModeManualIP = 1   ' the IP address and other TCP settings are manually configured

' DaqDevInfoFlagsT - Device Inventory Information Flags

' these flags enable checking the registry for
' devices that may or may not have been created
Global Const DaqInfoFlagsCreated& = &H3
Global Const DaqInfoFlagsNotCreated& = &H2

' these flags enable the detection of PCI and
' ethernet devices
Global Const DaqInfoFlagsDetected& = &HC
Global Const DaqInfoFlagsNotDetected& = &H8

' these flags enable the testing of detected or
' created devices by pinging the device (ethernet)
' or opening the device (PCI and LPT)
'
' Note1: must be used in conjunction with
' DaqInfoFlagsCreated and/or DaqInfoFlagsDetected
'
' Note2: for ethernet devices, these flags could be
' used in conjunction with DaqInfoFlagsDetected to
' determine whether or not the detected device is on
' a valid subnet
Global Const DaqInfoFlagsTestPassed& = &H30
Global Const DaqInfoFlagsTestFailed& = &H20

' DaqInfoFlagsNew will choose the group of new
' devices that were detected but not yet created
Global Const DaqInfoFlagsNew& = DaqInfoFlagsDetected& Or DaqInfoFlagsNotCreated&

' DaqInfoFlagsRemoved will choose the group of
' devices that were created, but no longer detected
Global Const DaqInfoFlagsRemoved& = DaqInfoFlagsCreated& Or DaqInfoFlagsTestFailed&

' DaqInfoFlagsRemoved will choose the group of
' devices that were created, but no longer detected
Global Const DaqInfoFlagsAvailable& = DaqInfoFlagsCreated& Or DaqInfoFlagsTestPassed&

' these flags enable will choose devices that match
' alias or device type conditions
Global Const DaqInfoFlagsMatchAlias& = &H10000
Global Const DaqInfoFlagsMatchParentAlias& = &H20000
Global Const DaqInfoFlagsMatchType& = &H30000
Global Const DaqInfoFlagsMatchSubType& = &H40000
Global Const DaqInfoFlagsMatchProdGroup& = &H50000
Global Const DaqInfoFlagsMatchProdFamily& = &H60000
Global Const DaqInfoFlagsMatchMask& = &HF0000

' TCP info structure
Public Type DaqInfoTcpT
    IPMode As Long
    SerialNum As String
    IPAddress As String
End Type

' TCP child info structure
Public Type DaqInfoTcpChildT
    ParentAliasName As String
    ExpPort As Long
    Tcp As DaqInfoTcpT
End Type

' Parallel port info structure
Public Type DaqInfoParallelT
    lptPort As Long
    protocol As Long
End Type

' PCI board info structure
Public Type DaqInfoPciT
    SerialNum As Long
    Bus As Long
    Slot As Long
End Type

' PC Card info structure
Public Type DaqInfoPcCardT
    socket As Long
    BasePortAddr As Long
    interruptLevel As Long
    DriverInstance As Long
    DaqModel As Long
End Type

' ISA board info structure
Public Type DaqInfoGenericT
    BasePortAddr As Long
    protocol As Long
    interruptLevel As Long
    dmaChannel As Long
End Type

' Main daq device info structure
Public Type DaqDevInfoT
    AliasName As String
    deviceType As Long
    DeviceSubType As Long
    InfoType As Long
    Tcp As DaqInfoTcpT
    TcpChild As DaqInfoTcpChildT
    Parallel As DaqInfoParallelT
    Pci As DaqInfoPciT
    PcCard As DaqInfoPcCardT
    Generic As DaqInfoGenericT
End Type

Private Const DevInfoLen = 596 ' 64 + 512 + 5 * 4

' DaqX device information commands
Declare Function BdaqGetDeviceInfo& Lib "daqx.dll" Alias "daqGetDeviceInfo" (ByVal handle&, DevInfo As Byte)

' DaqX device inventory commands
Declare Function BdaqCreateDevice& Lib "daqx.dll" Alias "daqCreateDevice" (DevInfo As Byte)
Declare Function BdaqDeleteDevice& Lib "daqx.dll" Alias "daqDeleteDevice" (ByVal AliasName$)
Declare Function BdaqGetDeviceInventory& Lib "daqx.dll" Alias "daqGetDeviceInventory" (InfoList As Byte, InfoListCount As Long, MatchInfo As Byte, ByVal flags As Long)

'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''
'                                                               '
'          VB API functions to call DaqX.dll C functions        '
'                                                               '
'''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''''

Dim daqErrnum&           ' The error value set by VBdaqSetErrorHandler()




Function VBdaqOpen&(ByVal daqName$)

   ' Turn off driver's default error processing (it pops up a message box,
   ' then returns to the program after the message box is closed)
   Dim daqOpenTmp1&, daqOpenHandle&
   daqOpenTmp1& = BdaqSetDefaultErrorHandler&(0)

   ' Try to open the device name
   daqOpenHandle& = BdaqOpen&(daqName$) ' Returns the handle number; -1 if error
   VBdaqOpen& = daqOpenHandle&          ' Set function value to handle returned

   ' Get the error number generated by the last call to the driver in daqErrno&
   daqOpenTmp1& = BdaqGetLastError&(daqOpenHandle&, daqErrno&)

   ' If the BdaqOpen&() failed, and you have set an error "handler", do Error
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&

End Function

Function VBdaqClose&(ByVal handle&)

   daqErrno& = BdaqClose&(handle&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqClose& = daqErrno&

End Function

Function VBdaqOnline&(ByVal handle&, online&)

   online& = 0
   daqErrno& = BdaqOnline&(handle&, online&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqOnline& = daqErrno&

End Function

Function VBdspCmd&(handle&, action&, memType&, addr&, data&)
   daqErrno& = BdspCmd&(handle&, action&, memType&, addr&, data&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdspCmd& = daqErrno&

End Function

Function VBdaqBlockMemIO32&(handle&, action&, blockType&, whichBlock&, addr&, count&, buf&())
Dim lb1&
   lb1& = LBound(buf&)
   daqErrno& = BdaqBlockMemIO&(handle&, action&, blockType&, whichBlock&, addr&, count&, buf&(lb1&))
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqBlockMemIO32& = daqErrno&
End Function
Function VBdaqBlockMemIO16&(handle&, action&, blockType&, whichBlock&, addr&, count&, buf%())
Dim lb1&
   lb1& = LBound(buf%)
   daqErrno& = BdaqBlockMemIOW&(handle&, action&, blockType&, whichBlock&, addr&, count&, buf%(lb1&))
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqBlockMemIO16& = daqErrno&
End Function
Function VBdaqBlockMemIO8&(handle&, action&, blockType&, whichBlock&, addr&, count&, buf() As Byte)
Dim lb1&
   lb1& = LBound(buf)
   daqErrno& = BdaqBlockMemIOB&(handle&, action&, blockType&, whichBlock&, addr&, count&, buf(lb1&))
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqBlockMemIO8& = daqErrno&
End Function


Function VBdaqGetDeviceCount&(deviceCount&)
        daqErrno& = BdaqGetDeviceCount&(deviceCount&)
        If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqGetDeviceCount& = daqErrno&

End Function

Function VBdaqGetDeviceList&(deviceList As DaqDeviceListT, deviceCount&)
        daqErrno& = BdaqGetDeviceList&(deviceList, deviceCount&)
        If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqGetDeviceList& = daqErrno&

End Function

Function VBdaqGetDeviceProperties&(daqName$, deviceProps As DaqDevicePropsT)
        daqErrno& = BdaqGetDeviceProperties&(daqName$, deviceProps)
        If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqGetDeviceProperties& = daqErrno&

End Function

Function VBdaqSetDefaultErrorHandler&(ByVal handler&)

   ' For VB, same purpose as VBdaqSetErrorHandler(), below
   daqErrno& = 0
   daqErrnum& = handler&
   VBdaqSetDefaultErrorHandler& = daqErrno&

End Function

Function VBdaqSetErrorHandler&(ByVal handle&, ByVal handler&)

   ' Since in VB we can't specify our own error handling function to the
   ' driver, use a non-zero handler& parameter to set the singular value of
   ' the VB Err object's value that will indicate any driver error.
   ' You then determine the specific error in your On Error code by examining
   ' the value of the global variable "daqErrno&" (defined in this module.)
   ' Pass a handler& value of zero to disable the automatic error generation.
   daqErrno& = 0
   daqErrnum& = handler&
   VBdaqSetErrorHandler& = daqErrno&

End Function

Function VBdaqProcessError&(ByVal handle&, ByVal errCode&)

   daqErrno& = BdaqProcessError&(handle&, errCode&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqProcessError& = daqErrno&

End Function

Function VBdaqGetLastError&(ByVal handle&, errCode&)

   errCode& = 0
   daqErrno& = BdaqGetLastError&(handle&, errCode&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqGetLastError& = daqErrno&

End Function

Sub VBdaqDefaultErrorHandler(ByVal handle&, ByVal errCode&)

   daqErrno& = 0
   If ((errCode& <> 0) And (daqErrnum& <> 0)) Then Error errCode&

End Sub

Function VBdaqFormatError&(ByVal errValue&, errString$)

    ' Notice: This function NEVER forces a VB Error event
    Dim TempErrArray(0 To 255) As Byte, X As Variant, FormatErrno&
    errString$ = ""
    FormatErrno& = BdaqFormatError&(errValue&, TempErrArray(0))
    
    For Each X In TempErrArray()
        If X = 0 Then Exit For
        errString$ = errString$ + Chr$(X)
    Next
    VBdaqFormatError& = FormatErrno&
    
End Function

Function VBdaqSetTimeout&(ByVal handle&, ByVal mSecTimeout&)

   daqErrno& = BdaqSetTimeout&(handle&, mSecTimeout&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqSetTimeout& = daqErrno&

End Function

Function VBdaqWaitForEvent&(ByVal handle&, ByVal daqEvent&)

   daqErrno& = BdaqWaitForEvent&(handle&, daqEvent&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqWaitForEvent& = daqErrno&

End Function

Function VBdaqWaitForEvents&(handles&(), events&(), ByVal eventCount&, eventSet&(), ByVal waitMode&)

   Dim lb1&, lb2&, lb3&
   lb1& = LBound(handles&)
   lb2& = LBound(events&)
   lb3& = LBound(eventSet&)
   daqErrno& = BdaqWaitForEvents&(handles&(lb1&), events&(lb2&), eventCount&, eventSet&(lb3&), waitMode&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqWaitForEvents& = daqErrno&

End Function

Function VBdaqGetDriverVersion&(Version&)

   Version& = 0
   daqErrno& = BdaqGetDriverVersion&(Version&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqGetDriverVersion& = daqErrno&

End Function

Function VBdaqGetHardwareInfo&(ByVal handle&, ByVal whichInfo&, Info As Variant)

   Info = 0
   daqErrno& = BdaqGetHardwareInfo&(handle&, whichInfo&, Info)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqGetHardwareInfo& = daqErrno&

End Function

Function VBdaqCvtHardwareType$(ByVal HwType&, ByVal HwSubType&)

    Dim TypeStr$
    Dim X
    Dim ByteArray(128) As Byte
    
    Erase ByteArray
    TypeStr$ = ""
    
    BdaqCvtHardwareType& HwType&, HwSubType&, ByteArray(0), UBound(ByteArray)
    
    For X = 0 To UBound(ByteArray)
        If ByteArray(X) > 0 Then
            TypeStr$ = TypeStr$ + Chr(ByteArray(X))
        Else
            Exit For
        End If
    Next X
    
    VBdaqCvtHardwareType$ = TypeStr$

End Function

Function VBdaqGetHardwareType&(ByVal handle&, HwSubType&)

   VBdaqGetHardwareType& = BdaqGetHardwareType&(handle&, HwSubType&)

End Function

Function VBdaqCvtChannelType$(ByVal ChType&, ByVal ChSubType&)

    Dim TypeStr$
    Dim X
    Dim ByteArray(128) As Byte
    
    Erase ByteArray
    TypeStr$ = ""
    
    BdaqCvtChannelType& ChType&, ChSubType&, ByteArray(0), UBound(ByteArray)
    
    For X = 0 To UBound(ByteArray)
        If ByteArray(X) > 0 Then
            TypeStr$ = TypeStr$ + Chr(ByteArray(X))
        Else
            Exit For
        End If
    Next X
    
    VBdaqCvtChannelType$ = TypeStr$

End Function

Function VBdaqGetChannelType&(ByVal handle&, ByVal chan&, ByVal bOption&, ChSubType&)

   VBdaqGetChannelType& = BdaqGetChannelType&(handle&, chan&, bOption&, ChSubType&)

End Function

Function VBdaqGetInfo&(ByVal handle&, ByVal chan&, ByVal whichInfo&, Info)
   
   Info = 0
   daqErrno& = BdaqGetInfo&(handle&, chan&, whichInfo&, Info)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqGetInfo& = daqErrno&

End Function

Function VBdaqGetInfoA&(ByVal handle&, ByVal chan&, ByVal whichInfo&, Info() As Byte)
  Dim lb As Integer
  lb = LBound(Info)
   daqErrno& = BdaqGetInfoA&(handle&, chan&, whichInfo&, Info(lb))
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqGetInfoA& = daqErrno&

End Function

Function VBdaqGetInfoString&(ByVal handle&, ByVal chan&, ByVal whichInfo&, InfoStr$)
   
   Dim X
   Dim ByteArray(64) As Byte
   Erase ByteArray
   InfoStr$ = ""
   
   daqErrno& = BdaqGetInfo&(handle&, chan&, whichInfo&, ByteArray(0))
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqGetInfoString& = daqErrno&
   
   For X = 0 To UBound(ByteArray)
    If ByteArray(X) > 0 Then
        InfoStr$ = InfoStr + Chr(ByteArray(X))
    Else
        X = UBound(ByteArray) ' done
    End If
   Next X

End Function

Function VBdaqAdcExpSetBank&(ByVal handle&, ByVal chan&, ByVal bankType&)

   daqErrno& = BdaqAdcExpSetBank&(handle&, chan&, bankType&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcExpSetBank& = daqErrno&

End Function

Function VBdaqAdcExpSetBankEx&(ByVal handle&, ByVal chan&, ByVal bankType&, ByVal bankSubType&)

   daqErrno& = BdaqAdcExpSetBankEx&(handle&, chan&, bankType&, bankSubType&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcExpSetBankEx& = daqErrno&

End Function

Function VBdaqAdcExpSetChanOption&(ByVal handle&, ByVal chan&, ByVal optionType&, ByVal optionValue!)

   daqErrno& = BdaqAdcExpSetChanOption&(handle&, chan&, optionType&, optionValue!)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcExpSetChanOption& = daqErrno&

End Function

Function VBdaqAdcExpSetModuleOption&(ByVal handle&, ByVal chan&, ByVal optionType&, ByVal optionValue!)

   daqErrno& = BdaqAdcExpSetModuleOption&(handle&, chan&, optionType&, optionValue!)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcExpSetModuleOption& = daqErrno&

End Function

Function VBdaqSetOption&(ByVal handle&, ByVal chan&, ByVal flags&, ByVal optionType&, ByVal optionValue!)
   daqErrno& = BdaqSetOption&(handle&, chan&, flags&, optionType&, optionValue!)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqSetOption& = daqErrno&

End Function


Function VBdaqAdcSetMux&(ByVal handle&, ByVal startChan&, ByVal endChan&, ByVal gain&, ByVal flags&)

   daqErrno& = BdaqAdcSetMux&(handle&, startChan&, endChan&, gain&, flags&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcSetMux& = daqErrno&

End Function

Function VBdaqAdcSetScan&(ByVal handle&, channels&(), gains&(), flags&(), ByVal CHANCOUNT&)

   Dim lb1&, lb2&, lb3&
   lb1& = LBound(channels&)
   lb2& = LBound(gains&)
   lb3& = LBound(flags&)
   daqErrno& = BdaqAdcSetScan&(handle&, channels&(lb1&), gains&(lb2&), flags&(lb3&), CHANCOUNT&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcSetScan& = daqErrno&

End Function

Function VBdaqAdcGetScan&(ByVal handle&, channels&(), gains&(), flags&(), CHANCOUNT&)

   Dim lb1&, lb2&, lb3&
   lb1& = LBound(channels&)
   lb2& = LBound(gains&)
   lb3& = LBound(flags&)
   CHANCOUNT& = 0
   daqErrno& = BdaqAdcGetScan&(handle&, channels&(lb1&), gains&(lb2&), flags&(lb3&), CHANCOUNT&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcGetScan& = daqErrno&

End Function

Function VBdaqAdcCalcTrig&(ByVal handle&, ByVal bipolar&, ByVal GainVal!, ByVal voltageLevel!, triggerLevel%)

   triggerLevel% = 0
   daqErrno& = BdaqAdcCalcTrig&(handle&, Abs(bipolar&), GainVal!, voltageLevel!, triggerLevel%)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcCalcTrig& = daqErrno&

End Function

Function VBdaqAdcSetTrig&(ByVal handle&, ByVal triggerSource&, ByVal rising&, ByVal level%, ByVal hysteresis%, ByVal channel&)

   daqErrno& = BdaqAdcSetTrig&(handle&, triggerSource&, Abs(rising&), level%, hysteresis%, channel&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcSetTrig& = daqErrno&

End Function
Function VBdaqSetTriggerEvent&(ByVal handle&, ByVal trigSource&, ByVal trigSensitivity&, ByVal channel&, ByVal GainCode&, ByVal flags&, ByVal channelType&, ByVal level!, ByVal variance!, ByVal trigEvent&)
' new api function to set start and stop events

   daqErrno& = BdaqSetTriggerEvent&(handle&, trigSource&, trigSensitivity&, channel&, GainCode&, flags&, channelType&, level!, variance!, trigEvent&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqSetTriggerEvent& = daqErrno&

End Function

Function VBdaqAdcSetTrigEnhanced&(ByVal handle&, ByRef triggerSources&(), ByRef gains&(), ByRef adcRanges&(), ByRef trigSense&(), ByRef levels!(), ByRef hysteresis!(), ByRef chan&(), CHANCOUNT&, opStr$)
Dim lb1&, lb2&, lb3&, lb4&, lb5&, lb6&, lb7&
'Dim opByte As Long ' set global for persistance
opByte = Asc(Left(opStr$, 1))
lb1& = LBound(triggerSources&)
lb2& = LBound(gains&)
lb3& = LBound(adcRanges&)
lb4& = LBound(trigSense&)
lb5& = LBound(levels!)
lb6& = LBound(hysteresis!)
lb7& = LBound(chan&)

   ' daqErrno& = BdaqAdcSetTrigEnhanced&(ByVal handle&, triggerSources&(lb1&), Gains&(lb2&), adcRanges&(lb3&), trigSense&(lb4&), levels!(lb5&), hysteresis!(lb6&), chan&(lb7&), CHANCOUNT&, opStr$)
   daqErrno& = BdaqAdcSetTrigEnhanced&(ByVal handle&, triggerSources&(lb1&), gains&(lb2&), adcRanges&(lb3&), trigSense&(lb4&), levels!(lb5&), hysteresis!(lb6&), chan&(lb7&), CHANCOUNT&, opByte)
     
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcSetTrigEnhanced& = daqErrno&

End Function



Function VBdaqAdcSoftTrig&(ByVal handle&)

   daqErrno& = BdaqAdcSoftTrig&(handle&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcSoftTrig& = daqErrno&

End Function



Function VBdaqAdcSetRate&(ByVal handle&, ByVal Mode&, ByVal AcqState&, ByVal regRate!, ByRef actualRate!)

   daqErrno& = BdaqAdcSetRate&(ByVal handle&, ByVal Mode&, ByVal AcqState&, ByVal regRate!, actualRate!)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcSetRate& = daqErrno&

End Function




Function VBdaqAdcSetFreq&(ByVal handle&, ByVal freq!)

   daqErrno& = BdaqAdcSetFreq&(handle&, freq!)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcSetFreq& = daqErrno&

End Function

Function VBdaqAdcGetFreq&(ByVal handle&, freq!)

   freq! = 0
   daqErrno& = BdaqAdcGetFreq&(handle&, freq!)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcGetFreq& = daqErrno&

End Function

Function VBdaqAdcSetClockSource&(ByVal handle&, ByVal clockSource&)

   daqErrno& = BdaqAdcSetClockSource&(handle&, clockSource&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcSetClockSource& = daqErrno&

End Function

Function VBdaqAdcSetAcq&(ByVal handle&, ByVal Mode&, ByVal preTrigCount&, ByVal postTrigCount&)

   daqErrno& = BdaqAdcSetAcq&(handle&, Mode&, preTrigCount&, postTrigCount&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcSetAcq& = daqErrno&

End Function

Function VBdaqAdcSetDiskFile&(ByVal handle&, ByVal FileName$, ByVal openMode&, ByVal PREWRITE&)

   daqErrno& = BdaqAdcSetDiskFile&(handle&, FileName$, openMode&, PREWRITE&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcSetDiskFile& = daqErrno&

End Function

Function VBdaqAdcArm&(ByVal handle&)

   daqErrno& = BdaqAdcArm&(handle&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcArm& = daqErrno&

End Function

Function VBdaqAdcDisarm&(ByVal handle&)

   daqErrno& = BdaqAdcDisarm&(handle&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcDisarm& = daqErrno&

End Function


Function VBdaqAdcTransferBufData&(ByVal handle&, buf%(), ByVal ScanCount&, ByVal transferMask&, ByRef retCount&)

   Dim lb1&
   lb1& = LBound(buf%)
   daqErrno& = BdaqAdcTransferBufData&(handle&, buf%(lb1&), ScanCount&, transferMask&, retCount&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcTransferBufData& = daqErrno&

End Function


Function VBdaqAdcTransferSetBuffer&(ByVal handle&, buf%(), ByVal ScanCount&, ByVal transferMask&)

   Dim lb1&
   lb1& = LBound(buf%)
   daqErrno& = BdaqAdcTransferSetBuffer&(handle&, buf%(lb1&), ScanCount&, transferMask&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcTransferSetBuffer& = daqErrno&

End Function

Function VBdaqAdcTransferStart&(ByVal handle&)

   daqErrno& = BdaqAdcTransferStart&(handle&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcTransferStart& = daqErrno&

End Function

Function VBdaqAdcTransferGetStat&(ByVal handle&, ByRef active&, ByRef retCount&)

   ' be sure that active& and retCount& are initialized
   daqErrno& = BdaqAdcTransferGetStat&(handle&, active&, retCount&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcTransferGetStat& = daqErrno&

End Function

Function VBdaqAdcTransferStop&(ByVal handle&)

   daqErrno& = BdaqAdcTransferStop&(handle&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcTransferStop& = daqErrno&

End Function

Function VBdaqDumpDriverDebugBuffer&(ByVal handle&, ByVal sBuf$, ByVal charCount&)

   daqErrno& = BdaqDumpDriverDebugBuffer&(handle&, sBuf$, charCount&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDumpDriverDebugBuffer& = daqErrno&

End Function

Function VBdaqAdcTransferSetBufferAllocMem&(ByVal handle&, ByVal ScanCount&, ByVal transferMask&)

   daqErrno& = BdaqAdcTransferSetBufferAllocMem&(handle&, ScanCount&, transferMask&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcTransferSetBufferAllocMem& = daqErrno&

End Function

Function VBdaqAdcTransferStopAllocMem&(ByVal handle&, buf%(), ByVal ScanCount&)

   Dim lb1&
   lb1& = LBound(buf%)
   daqErrno& = BdaqAdcTransferStopAllocMem&(handle&, buf%(lb1&), ScanCount&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcTransferStopAllocMem& = daqErrno&

End Function

Function VBdaqAdcBufferRotate&(ByVal handle&, buf%(), ByVal ScanCount&, ByVal CHANCOUNT&, ByVal retCount&)

   Dim lb1&
   lb1& = LBound(buf%)
   daqErrno& = BdaqAdcBufferRotate&(handle&, buf%(lb1&), ScanCount&, CHANCOUNT&, retCount&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcBufferRotate& = daqErrno&

End Function

Function VBdaqAdcRd&(ByVal handle&, ByVal chan&, sample%, ByVal gain&, ByVal flags&)

   sample% = 0
   daqErrno& = BdaqAdcRd&(handle&, chan&, sample%, gain&, flags&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcRd& = daqErrno&

End Function

Function VBdaqAdcRdScan&(ByVal handle&, ByVal startChan&, ByVal endChan&, buf%(), ByVal gain&, ByVal flags&)

   Dim lb1&
   lb1& = LBound(buf%)
   daqErrno& = BdaqAdcRdScan&(handle&, startChan&, endChan&, buf%(lb1&), gain&, flags&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcRdScan& = daqErrno&

End Function

Function VBdaqAdcRdN&(ByVal handle&, ByVal chan&, buf%(), ByVal ScanCount&, ByVal triggerSource&, ByVal rising&, ByVal level%, ByVal freq!, ByVal gain&, ByVal flags&)

   Dim lb1&
   lb1& = LBound(buf%)
   daqErrno& = BdaqAdcRdN&(handle&, chan&, buf%(lb1&), ScanCount&, triggerSource&, Abs(rising&), level%, freq!, gain&, flags&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcRdN& = daqErrno&

End Function

Function VBdaqAdcRdScanN&(ByVal handle&, ByVal startChan&, ByVal endChan&, buf%(), ByVal ScanCount&, ByVal triggerSource&, ByVal rising&, ByVal level%, ByVal freq!, ByVal gain&, ByVal flags&)

   Dim lb1&
   lb1& = LBound(buf%)
   daqErrno& = BdaqAdcRdScanN&(handle&, startChan&, endChan&, buf%(lb1&), ScanCount&, triggerSource&, Abs(rising&), level%, freq!, gain&, flags&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcRdScanN& = daqErrno&

End Function

Function VBdaqAdcSetDataFormat&(ByVal handle&, ByVal RawFormat&, ByVal PostProcFormat&)

   daqErrno& = BdaqAdcSetDataFormat&(handle&, RawFormat&, PostProcFormat&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAdcSetDataFormat& = daqErrno&

End Function

Function VBdaqCvtSetAdcRange&(ByVal ADmin!, ByVal ADmax!)

   daqErrno& = BdaqCvtSetAdcRange&(ADmin!, ADmax!)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCvtSetAdcRange& = daqErrno&

End Function

Function VBdaqDacSetOutputMode&(ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal outputMode&)

   daqErrno& = BdaqDacSetOutputMode&(handle&, deviceType&, chan&, outputMode&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacSetOutputMode& = daqErrno&

End Function

Function VBdaqDacWt&(ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal dataVal%)

   daqErrno& = BdaqDacWt&(handle&, deviceType&, chan&, dataVal%)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWt& = daqErrno&

End Function

Function VBdaqDacWtMany&(ByVal handle&, deviceTypes&(), chans&(), dataVals%(), ByVal count&)

   Dim lb1&, lb2&, lb3&
   lb1& = LBound(deviceTypes&)
   lb2& = LBound(chans&)
   lb3& = LBound(dataVals%)
   
   daqErrno& = BdaqDacWtMany&(handle&, deviceTypes&(lb1&), chans&(lb2&), dataVals%(lb3&), count&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWtMany& = daqErrno&

End Function

Function VBdaqDacWaveSetTrig&(ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal triggerSource&, ByVal rising&)

   daqErrno& = BdaqDacWaveSetTrig&(handle&, deviceType&, chan&, triggerSource&, Abs(rising&))
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWaveSetTrig& = daqErrno&

End Function

Function VBdaqDacWaveSoftTrig&(ByVal handle&, ByVal deviceType&, ByVal chan&)

   daqErrno& = BdaqDacWaveSoftTrig&(handle&, deviceType&, chan&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWaveSoftTrig& = daqErrno&

End Function

Function VBdaqDacWaveSetClockSource&(ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal clockSource&)

   daqErrno& = BdaqDacWaveSetClockSource&(handle&, deviceType&, chan&, clockSource&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWaveSetClockSource& = daqErrno&

End Function

Function VBdaqDacWaveSetFreq&(ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal freq!)

   daqErrno& = BdaqDacWaveSetFreq&(handle&, deviceType&, chan&, freq!)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWaveSetFreq& = daqErrno&

End Function

Function VBdaqDacWaveGetFreq&(ByVal handle&, ByVal deviceType&, ByVal chan&, freq!)

   freq! = 0
   daqErrno& = BdaqDacWaveGetFreq&(handle&, deviceType&, chan&, freq!)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWaveGetFreq& = daqErrno&

End Function

Function VBdaqDacWaveSetMode&(ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal Mode&, ByVal updateCount&)

   daqErrno& = BdaqDacWaveSetMode&(handle&, deviceType&, chan&, Mode&, updateCount&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWaveSetMode& = daqErrno&

End Function

' Not yet supported : contact factory
Function VBdaqDacWaveSetDiskFile&(ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal FileName$, ByVal numUpdateCycles, ByVal offsetBytes&, ByVal offsetUpdateCycles&, ByVal dataFormat&)
   daqErrno& = BdaqDacWaveSetDiskFile&(handle&, deviceType&, chan&, FileName$, numUpdateCycles, offsetBytes&, offsetUpdateCycles&, dataFormat&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWaveSetDiskFile& = daqErrno&

End Function

Function VBdaqDacWaveSetPredefWave&(ByVal handle&, ByVal deviceType&, ByVal chan&, ByVal waveType&, ByVal Amplitude&, ByVal offset&, ByVal dutyCycle&, ByVal phaseShift&)

   daqErrno& = BdaqDacWaveSetPredefWave&(handle&, deviceType&, chan&, waveType&, Amplitude&, offset&, dutyCycle&, phaseShift&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWaveSetPredefWave& = daqErrno&

End Function

Function VBdaqDacWaveSetUserWave&(ByVal handle&, ByVal deviceType&, ByVal chan&)

   daqErrno& = BdaqDacWaveSetUserWave&(handle&, deviceType&, chan&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWaveSetUserWave& = daqErrno&

End Function

Function VBdaqDacWaveSetBuffer&(ByVal handle&, ByVal deviceType&, ByVal chan&, buf%(), ByVal ScanCount&, ByVal transferMask&)

   Dim lb1&
   lb1& = LBound(buf%)
   daqErrno& = BdaqDacWaveSetBuffer&(handle&, deviceType&, chan&, buf%(lb1&), ScanCount&, transferMask&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWaveSetBuffer& = daqErrno&

End Function

Function VBdaqDacWaveArm&(ByVal handle&, ByVal deviceType&)

   daqErrno& = BdaqDacWaveArm&(handle&, deviceType&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWaveArm& = daqErrno&

End Function

Function VBdaqDacWaveDisarm&(ByVal handle&, ByVal deviceType&)

   daqErrno& = BdaqDacWaveDisarm&(handle&, deviceType&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacWaveDisarm& = daqErrno&

End Function

Function VBdaqDacTransferStart&(ByVal handle&, ByVal deviceType&, ByVal chan&)

   daqErrno& = BdaqDacTransferStart&(handle&, deviceType&, chan&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacTransferStart& = daqErrno&

End Function

Function VBdaqDacTransferGetStat&(ByVal handle&, ByVal deviceType&, ByVal chan&, active&, retCount&)

   active& = 0
   retCount& = 0
   daqErrno& = BdaqDacTransferGetStat&(handle&, deviceType&, chan&, active&, retCount&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacTransferGetStat& = daqErrno&

End Function

Function VBdaqDacTransferStop&(ByVal handle&, ByVal deviceType&, ByVal chan&)

   daqErrno& = BdaqDacTransferStop&(handle&, deviceType&, chan&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqDacTransferStop& = daqErrno&

End Function

Function VBdaqCvtLinearSetup&(ByVal nscan&, ByVal readingsPos&, ByVal nReadings&, ByVal signal1!, ByVal voltage1!, ByVal signal2!, ByVal voltage2!, ByVal avg&)

   daqErrno& = BdaqCvtLinearSetup&(nscan&, readingsPos&, nReadings&, signal1!, voltage1!, signal2!, voltage2!, avg&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCvtLinearSetup& = daqErrno&

End Function

Function VBdaqCvtLinearConvert&(counts%(), ByVal SCANS&, fValues!(), ByVal nValues&)

   Dim lb1&, lb2&
   lb1& = LBound(counts%)
   lb2& = LBound(fValues!)
   daqErrno& = BdaqCvtLinearConvert&(counts%(lb1&), SCANS&, fValues!(lb2&), nValues&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCvtLinearConvert& = daqErrno&

End Function

Function VBdaqCvtLinearSetupConvert&(ByVal nscan&, ByVal readingsPos&, ByVal nReadings&, ByVal signal1!, ByVal voltage1!, ByVal signal2!, ByVal voltage2!, ByVal avg&, counts%(), ByVal SCANS&, fValues!(), ByVal nValues&)

   Dim lb1&, lb2&
   lb1& = LBound(counts%)
   lb2& = LBound(fValues!)
   daqErrno& = BdaqCvtLinearSetupConvert&(nscan&, readingsPos&, nReadings&, signal1!, voltage1!, signal2!, voltage2!, avg&, counts%(lb1&), SCANS&, fValues!(lb2&), nValues&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCvtLinearSetupConvert& = daqErrno&

End Function

Function VBdaqCalSetup&(ByVal handle&, ByVal nscan&, ByVal readingsPos&, ByVal nReadings&, ByVal chanType&, ByVal chanGain&, ByVal startChan&, ByVal bipolar&, ByVal noOffset&)

   daqErrno& = BdaqCalSetup&(handle&, nscan&, readingsPos&, nReadings&, Abs(chanType&), chanGain&, startChan&, Abs(bipolar&), Abs(noOffset&))
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCalSetup& = daqErrno&

End Function

Function VBdaqCalConvert&(ByVal handle&, counts%(), ByVal SCANS&)

   Dim lb1&
   lb1& = LBound(counts%)
   daqErrno& = BdaqCalConvert&(handle&, counts%(lb1&), SCANS&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCalConvert& = daqErrno&

End Function

Function VBdaqCalSetupConvert&(ByVal handle&, ByVal nscan&, ByVal readingsPos&, ByVal nReadings&, ByVal chanType&, ByVal chanGain&, ByVal startChan&, ByVal bipolar&, ByVal noOffset&, counts%(), ByVal SCANS&)

   Dim lb1&
   lb1& = LBound(counts%)
   daqErrno& = BdaqCalSetupConvert&(handle&, nscan&, readingsPos&, nReadings&, Abs(chanType&), chanGain&, startChan&, Abs(bipolar&), Abs(noOffset&), counts%(lb1&), SCANS&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCalSetupConvert& = daqErrno&

End Function

Function VBdaqReadCalFile&(ByVal handle&, ByVal calfile$)

   daqErrno& = BdaqReadCalFile&(handle&, calfile$)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqReadCalFile& = daqErrno&

End Function



Function VBdaqCalSelectCalTable&(ByVal handle&, ByVal tableType As Integer)

   daqErrno& = BdaqCalSelectCalTable&(handle&, ByVal tableType)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCalSelectCalTable& = daqErrno&

End Function


Function VBdaqCalSelectInputSignal&(ByVal handle&, inputSignal&) ' As DaqCalInputT)

   daqErrno& = BdaqCalSelectInputSignal&(handle&, inputSignal)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCalSelectInputSignal& = daqErrno&

End Function




Function VBdaqCalGetConstants&(ByVal handle&, ByVal channel&, ByVal gain&, ByVal range&, gainConstant%, offsetConstant%)

   daqErrno& = BdaqCalGetConstants&(ByVal handle&, ByVal channel&, ByVal gain&, ByVal range&, gainConstant%, offsetConstant%)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCalGetConstants& = daqErrno&

End Function



Function VBdaqCalSetConstants&(ByVal handle&, ByVal channel&, ByVal gain&, ByVal range&, ByVal gainConstant%, ByVal offsetConstant%)

   daqErrno& = BdaqCalSetConstants&(ByVal handle&, ByVal channel&, ByVal gain&, ByVal range&, ByVal gainConstant%, ByVal offsetConstant%)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCalSetConstants& = daqErrno&

End Function


Function VBdaqCalSaveConstants&(ByVal handle&, ByVal channel&)

   daqErrno& = BdaqCalSaveConstants&(ByVal handle&, ByVal channel&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCalSaveConstants& = daqErrno&

End Function

Function VBdaqConfCalConstants&(ByVal handle&, ByVal chan&, ByVal gain&, ByVal adcRange&, gainConst%, offsetConst%, ByVal operation&, ByVal tableType&, ByVal inputdat&, ByVal optionType)

   daqErrno& = BdaqConfCalConstants&(ByVal handle&, ByVal chan&, ByVal gain&, ByVal adcRange&, gainConst%, offsetConst%, ByVal operation&, ByVal tableType&, ByVal inputdat&, ByVal optionType)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqConfCalConstants& = daqErrno&

End Function

Function VBdaqAutoZeroCompensate&(ByVal zero&)

   daqErrno& = BdaqAutoZeroCompensate&(Abs(zero&))
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqAutoZeroCompensate& = daqErrno&

End Function

Function VBdaqZeroSetup&(ByVal nscan&, ByVal zeroPos&, ByVal readingsPos&, ByVal nReadings&)

   daqErrno& = BdaqZeroSetup&(nscan&, zeroPos&, readingsPos&, nReadings&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqZeroSetup& = daqErrno&

End Function

Function VBdaqZeroConvert&(counts%(), ByVal SCANS&)

   Dim lb1&
   lb1& = LBound(counts%)
   daqErrno& = BdaqZeroConvert&(counts%(lb1&), SCANS&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqZeroConvert& = daqErrno&

End Function

Function VBdaqZeroSetupConvert&(ByVal nscan&, ByVal zeroPos&, ByVal readingsPos&, ByVal nReadings&, counts%(), ByVal SCANS&)

   Dim lb1&
   lb1& = LBound(counts%)
   daqErrno& = BdaqZeroSetupConvert&(nscan&, zeroPos&, readingsPos&, nReadings&, counts%(lb1&), SCANS&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqZeroSetupConvert& = daqErrno&

End Function

Function VBdaqZeroDbk19&(ByVal zero&)

   daqErrno& = BdaqZeroDbk19&(Abs(zero&))
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqZeroDbk19& = daqErrno&

End Function

Function VBdaqCvtRtdConvert&(counts%(), ByVal SCANS&, temp%(), ByVal ntemp&)

   Dim lb1&, lb2&
   lb1& = LBound(counts%)
   lb2& = LBound(temp%)
   daqErrno& = BdaqCvtRtdConvert&(counts%(lb1&), SCANS&, temp%(lb2&), ntemp&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCvtRtdConvert& = daqErrno&

End Function

Function VBdaqCvtRtdSetup&(ByVal nscan&, ByVal startPosition&, ByVal nRtd&, ByVal rtdType&, ByVal avg&)

   daqErrno& = BdaqCvtRtdSetup&(nscan&, startPosition&, nRtd&, rtdType&, avg&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCvtRtdSetup& = daqErrno&

End Function

Function VBdaqCvtRtdSetupConvert&(ByVal nscan&, ByVal startPosition&, ByVal nRtd&, ByVal rtdType&, ByVal avg&, counts%(), ByVal SCANS&, temp%(), ByVal ntemp&)

   Dim lb1&, lb2&
   lb1& = LBound(counts%)
   lb2& = LBound(temp%)
   daqErrno& = BdaqCvtRtdSetupConvert&(nscan&, startPosition&, nRtd&, rtdType&, avg&, counts%(lb1&), SCANS&, temp%(lb2&), ntemp&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCvtRtdSetupConvert& = daqErrno&

End Function

Function VBdaqCvtTCConvert&(counts%(), ByVal SCANS&, temp%(), ByVal ntemp&)

   Dim lb1&, lb2&
   lb1& = LBound(counts%)
   lb2& = LBound(temp%)
   daqErrno& = BdaqCvtTCConvert&(counts%(lb1&), SCANS&, temp%(lb2&), ntemp&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCvtTCConvert& = daqErrno&

End Function

Function VBdaqCvtTCSetup&(ByVal nscan&, ByVal cjcPosition&, ByVal ntc&, ByVal tcType&, ByVal bipolar&, ByVal avg&)

   daqErrno& = BdaqCvtTCSetup&(nscan&, cjcPosition&, ntc&, tcType&, Abs(bipolar&), avg&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCvtTCSetup& = daqErrno&

End Function

Function VBdaqCvtTCSetupConvert&(ByVal nscan&, ByVal cjcPosition&, ByVal ntc&, ByVal tcType&, ByVal bipolar&, ByVal avg&, counts%(), ByVal SCANS&, temp%(), ByVal ntemp&)

   Dim lb1&, lb2&
   lb1& = LBound(counts%)
   lb2& = LBound(temp%)
   daqErrno& = BdaqCvtTCSetupConvert&(nscan&, cjcPosition&, ntc&, tcType&, Abs(bipolar&), avg&, counts%(lb1&), SCANS&, temp%(lb2&), ntemp&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCvtTCSetupConvert& = daqErrno&

End Function

Function VBdaqIOReadBit&(ByVal handle&, ByVal devType&, ByVal devPort&, ByVal whichDevice&, ByVal whichExpPort&, ByVal bitNum&, bitValue&)

   bitValue& = 0
   daqErrno& = BdaqIOReadBit&(handle&, devType&, devPort&, whichDevice&, whichExpPort&, bitNum&, bitValue&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqIOReadBit& = daqErrno&

End Function

Function VBdaqIORead&(ByVal handle&, ByVal devType&, ByVal devPort&, ByVal whichDevice&, ByVal whichExpPort&, value&)

   value& = 0
   daqErrno& = BdaqIORead&(handle&, devType&, devPort&, whichDevice&, whichExpPort&, value&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqIORead& = daqErrno&

End Function

Function VBdaqIOWriteBit&(ByVal handle&, ByVal devType&, ByVal devPort&, ByVal whichDevice&, ByVal whichExpPort&, ByVal bitNum&, ByVal bitValue&)

   daqErrno& = BdaqIOWriteBit&(handle&, devType&, devPort&, whichDevice&, whichExpPort&, bitNum&, Abs(bitValue&))
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqIOWriteBit& = daqErrno&

End Function

Function VBdaqIOWrite&(ByVal handle&, ByVal devType&, ByVal devPort&, ByVal whichDevice&, ByVal whichExpPort&, ByVal value&)

   daqErrno& = BdaqIOWrite&(handle&, devType&, devPort&, whichDevice&, whichExpPort&, value&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqIOWrite& = daqErrno&

End Function

Function VBdaqIOGet8255Conf&(ByVal handle&, ByVal portA&, ByVal portB&, ByVal portCHigh&, ByVal portCLow&, config&)

   config& = 0
   daqErrno& = BdaqIOGet8255Conf&(handle&, Abs(portA&), Abs(portB&), Abs(portCHigh&), Abs(portCLow&), config&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqIOGet8255Conf& = daqErrno&

End Function

Function VBdaqIOTransferReset&(ByVal handle&)

   daqErrno& = BdaqIOTransferReset&(handle&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqIOTransferReset& = daqErrno&

End Function

Function VBdaqIOTransferSetBuffer&(ByVal handle&, ByVal eventCode&, ByVal devType&, ByVal devPort&, ByVal whichDevice&, ByVal whichExpPort&, ByVal opCode&, buf As Variant, ByVal bufCount&)

   ' You must assign a variant variable to the array in which to store I/O data.
   ' The array can be of type Byte, Integer or Long.  The opCode& parameter must
   ' reflect the array type.  Use one of the "Diooc..." constants defined above.
   Dim lb1&
   lb1& = LBound(buf)
   daqErrno& = BdaqIOTransferSetBuffer&(handle&, eventCode&, devType&, devPort&, whichDevice&, whichExpPort&, opCode&, buf(lb1&), bufCount&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqIOTransferSetBuffer& = daqErrno&

End Function

Function VBdaqIOTransferStart&(ByVal handle&)

   daqErrno& = BdaqIOTransferStart&(handle&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqIOTransferStart& = daqErrno&

End Function

Function VBdaqIOTransferGetStat&(ByVal handle&, ByVal devType&, ByVal devPort&, ByVal whichDevice&, ByVal whichExpPort&, active&, retCount&)

   active& = 0
   retCount& = 0
   daqErrno& = BdaqIOTransferGetStat&(handle&, devType&, devPort&, whichDevice&, whichExpPort&, active&, retCount&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqIOTransferGetStat& = daqErrno&

End Function

Function VBdaqIOTransferStop&(ByVal handle&)

   daqErrno& = BdaqIOTransferStop&(handle&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqIOTransferStop& = daqErrno&

End Function

Function VBdaq9513SetMasterMode&(ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal foutDiv&, ByVal cntSource&, ByVal comp1&, ByVal comp2&, ByVal tod&)

   daqErrno& = Bdaq9513SetMasterMode&(handle&, deviceType&, whichDevice&, foutDiv&, cntSource&, Abs(comp1&), Abs(comp2&), tod&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaq9513SetMasterMode& = daqErrno&

End Function

Function VBdaq9513SetAlarm&(ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal alarmNum&, ByVal alarmVal&)

   daqErrno& = Bdaq9513SetAlarm&(handle&, deviceType&, whichDevice&, alarmNum&, alarmVal&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaq9513SetAlarm& = daqErrno&

End Function

Function VBdaq9513SetCtrMode&(ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal ctrNum&, ByVal gateCtrl&, ByVal cntEdge&, ByVal cntSource&, ByVal specGate&, ByVal reload&, ByVal cntRepeat&, ByVal cntType&, ByVal cntDir&, ByVal outputCtrl&)

   daqErrno& = Bdaq9513SetCtrMode&(handle&, deviceType&, whichDevice&, ctrNum&, gateCtrl&, Abs(cntEdge&), cntSource&, Abs(specGate&), Abs(reload&), Abs(cntRepeat&), Abs(cntType&), Abs(cntDir&), outputCtrl&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaq9513SetCtrMode& = daqErrno&

End Function

Function VBdaq9513MultCtrl&(ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal ctrCmd&, ByVal CTR1&, ByVal ctr2&, ByVal ctr3&, ByVal ctr4&, ByVal ctr5&)

   daqErrno& = Bdaq9513MultCtrl&(handle&, deviceType&, whichDevice&, ctrCmd&, Abs(CTR1&), Abs(ctr2&), Abs(ctr3&), Abs(ctr4&), Abs(ctr5&))
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaq9513MultCtrl& = daqErrno&

End Function

Function VBdaq9513GetHold&(ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal ctrNum&, ctrVal%)

   ctrVal% = 0
   daqErrno& = Bdaq9513GetHold&(handle&, deviceType&, whichDevice&, ctrNum&, ctrVal%)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaq9513GetHold& = daqErrno&

End Function

Function VBdaq9513SetHold&(ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal ctrNum&, ByVal ctrVal%)

   daqErrno& = Bdaq9513SetHold&(handle&, deviceType&, whichDevice&, ctrNum&, ctrVal%)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaq9513SetHold& = daqErrno&

End Function

Function VBdaq9513SetLoad&(ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal ctrNum&, ByVal ctrVal%)

   daqErrno& = Bdaq9513SetLoad&(handle&, deviceType&, whichDevice&, ctrNum&, ctrVal%)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaq9513SetLoad& = daqErrno&

End Function

Function VBdaq9513RdFreq&(ByVal handle&, ByVal deviceType&, ByVal whichDevice&, ByVal interval&, ByVal cntSource&, count&)

   count& = 0
   daqErrno& = Bdaq9513RdFreq&(handle&, deviceType&, whichDevice&, interval&, cntSource&, count&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaq9513RdFreq& = daqErrno&

End Function

Function VBdaqTest&(ByVal handle&, ByVal command&, ByVal count&, cmdAvailable&, result&)
   cmdAvailable& = 0
   result& = 0
   daqErrno& = BdaqTest&(handle&, command&, count&, cmdAvailable&, result&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqTest& = daqErrno&
End Function

Function VBdaqCvtRawDataFormat&(buf%(), ByVal action&, ByVal lastRetCount&, ByVal ScanCount&, ByVal CHANCOUNT&)
   Dim lb&: lb& = LBound(buf%)
   daqErrno& = BdaqCvtRawDataFormat&(buf%(lb&), action&, lastRetCount&, ScanCount&, CHANCOUNT&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqCvtRawDataFormat& = daqErrno&
End Function

Function VBdaqRegRead&(ByVal handle&, ByVal reg&, ByVal value&)
   daqErrno& = BdaqRegRead&(handle&, reg&, value&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqRegRead& = daqErrno&
End Function

Function VBdaqRegWrite&(ByVal handle&, ByVal reg&, ByVal value&)
   daqErrno& = BdaqRegWrite&(handle&, reg&, value&)
   If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
   VBdaqRegWrite& = daqErrno&
End Function

Private Sub CvtByteArrayLong(ByteArray() As Byte, ByVal ArrayIndex As Long, ByVal StartLoc As Long, _
    lValue As Long, bByteArrayToLong As Boolean)
    
    If bByteArrayToLong Then
        lValue = 0
        lValue = lValue + ByteArray(StartLoc + 0, ArrayIndex)
        lValue = lValue + ((2 ^ 8) * ByteArray(StartLoc + 1, ArrayIndex))
        lValue = lValue + ((2 ^ 16) * ByteArray(StartLoc + 2, ArrayIndex))
        lValue = lValue + ((2 ^ 24) * ByteArray(StartLoc + 3, ArrayIndex))
    Else
        ByteArray(StartLoc + 0, ArrayIndex) = lValue Mod 256
        ByteArray(StartLoc + 1, ArrayIndex) = (lValue / (2 ^ 8)) Mod 256
        ByteArray(StartLoc + 2, ArrayIndex) = (lValue / (2 ^ 16)) Mod 256
        ByteArray(StartLoc + 3, ArrayIndex) = (lValue / (2 ^ 24)) Mod 256
    End If
    
End Sub

Private Sub CvtByteArrayString(ByteArray() As Byte, ByVal ArrayIndex As Long, ByVal StartLoc As Long, ByVal sLen As Long, _
    sValue As String, bByteArrayToString As Boolean)

    Dim i As Long
    
    If bByteArrayToString Then
        sValue = ""
        For i = 0 To sLen - 1
            If ByteArray(StartLoc + i, ArrayIndex) <> 0 Then
                sValue = sValue & Chr(ByteArray(StartLoc + i, ArrayIndex))
            Else
                Exit For
            End If
        Next i
    Else
        For i = 0 To sLen - 1
            If i < Len(sValue) Then
                ByteArray(StartLoc + i, ArrayIndex) = Asc(Mid(sValue, i + 1, 1))
            Else
                ByteArray(StartLoc + i, ArrayIndex) = 0
            End If
        Next i
    End If
    
End Sub

Private Sub CvtDaqDevInfo(ByteArray() As Byte, ByVal ArrayIndex As Long, DaqDevInfo As DaqDevInfoT, ByVal bToDaqDevInfo As Boolean)
    
    Const DwordLen = 4
    
    ' Offset constants for the common portion of the DaqDevInfoT structure defined in daqx.h
    Const InfoAliasName = 0
    Const InfoAliasNameLen = 64
    Const InfoDeviceType = InfoAliasName + InfoAliasNameLen
    Const InfoDeviceSubType = InfoDeviceType + DwordLen
    Const InfoReserved1 = InfoDeviceSubType + DwordLen
    Const InfoReserved2 = InfoReserved1 + DwordLen
    Const InfoInfoType = InfoReserved2 + DwordLen
    Const InfoReservedInfo = InfoInfoType + DwordLen

    ' Convert the data to or from the byte array using the previous definitions
    CvtByteArrayString ByteArray(), ArrayIndex, InfoAliasName, InfoAliasNameLen, DaqDevInfo.AliasName, bToDaqDevInfo
    CvtByteArrayLong ByteArray(), ArrayIndex, InfoDeviceType, DaqDevInfo.deviceType, bToDaqDevInfo
    CvtByteArrayLong ByteArray(), ArrayIndex, InfoDeviceSubType, DaqDevInfo.DeviceSubType, bToDaqDevInfo
    CvtByteArrayLong ByteArray(), ArrayIndex, InfoInfoType, DaqDevInfo.InfoType, bToDaqDevInfo

    Select Case DaqDevInfo.InfoType
    Case DaqInfoTypeGeneric&
    
        ' Offset constants for the generic portion of the DaqDevInfoT structure defined in daqx.h
        Const GenericBasePortAddr = InfoReservedInfo
        Const GenericProtocol = GenericBasePortAddr + DwordLen
        Const GenericInterruptLevel = GenericProtocol + DwordLen
        Const GenericDmaChannel = GenericInterruptLevel + DwordLen
        
        ' Convert the data to or from the byte array using the previous definitions
        CvtByteArrayLong ByteArray(), ArrayIndex, GenericBasePortAddr, DaqDevInfo.Generic.BasePortAddr, bToDaqDevInfo
        CvtByteArrayLong ByteArray(), ArrayIndex, GenericProtocol, DaqDevInfo.Generic.protocol, bToDaqDevInfo
        CvtByteArrayLong ByteArray(), ArrayIndex, GenericInterruptLevel, DaqDevInfo.Generic.interruptLevel, bToDaqDevInfo
        CvtByteArrayLong ByteArray(), ArrayIndex, GenericDmaChannel, DaqDevInfo.Generic.dmaChannel, bToDaqDevInfo
        
    Case DaqInfoTypeTcp&
    
        ' Offset constants for the tcp portion of the DaqDevInfoT structure defined in daqx.h
        Const TcpIPMode = InfoReservedInfo
        Const TcpSerialNum = TcpIPMode + DwordLen
        Const TcpSerialNumLen = 32
        Const TcpIPAddress = TcpSerialNum + TcpSerialNumLen
        Const TcpIPAddressLen = 32
        
        ' Convert the data to or from the byte array using the previous definitions
        CvtByteArrayLong ByteArray(), ArrayIndex, TcpIPMode, DaqDevInfo.Tcp.IPMode, bToDaqDevInfo
        CvtByteArrayString ByteArray(), ArrayIndex, TcpSerialNum, TcpSerialNumLen, DaqDevInfo.Tcp.SerialNum, bToDaqDevInfo
        CvtByteArrayString ByteArray(), ArrayIndex, TcpIPAddress, TcpIPAddressLen, DaqDevInfo.Tcp.IPAddress, bToDaqDevInfo
        
    Case DaqInfoTypeTcpChild&
    
        ' Offset constants for the tcp child portion of the DaqDevInfoT structure defined in daqx.h
        Const TcpChildParentAliasName = InfoReservedInfo
        Const TcpChildParentAliasNameLen = 64
        Const TcpChildExpPort = TcpChildParentAliasName + TcpChildParentAliasNameLen
        Const TcpChildIPMode = TcpChildExpPort + DwordLen
        Const TcpChildSerialNum = TcpChildIPMode + DwordLen
        Const TcpChildSerialNumLen = 32
        Const TcpChildIPAddress = TcpChildSerialNum + TcpSerialNumLen
        Const TcpChildIPAddressLen = 32
        
        ' Convert the data to or from the byte array using the previous definitions
        CvtByteArrayString ByteArray(), ArrayIndex, TcpChildParentAliasName, TcpChildParentAliasNameLen, DaqDevInfo.TcpChild.ParentAliasName, bToDaqDevInfo
        CvtByteArrayLong ByteArray(), ArrayIndex, TcpChildExpPort, DaqDevInfo.TcpChild.ExpPort, bToDaqDevInfo
        CvtByteArrayLong ByteArray(), ArrayIndex, TcpChildIPMode, DaqDevInfo.TcpChild.Tcp.IPMode, bToDaqDevInfo
        CvtByteArrayString ByteArray(), ArrayIndex, TcpChildSerialNum, TcpChildSerialNumLen, DaqDevInfo.TcpChild.Tcp.SerialNum, bToDaqDevInfo
        CvtByteArrayString ByteArray(), ArrayIndex, TcpChildIPAddress, TcpChildIPAddressLen, DaqDevInfo.TcpChild.Tcp.IPAddress, bToDaqDevInfo
        
    Case DaqInfoTypeParallel&
    
        ' Offset constants for the parallel portion of the DaqDevInfoT structure defined in daqx.h
        Const ParallelLPTPort = InfoReservedInfo
        Const ParallelProtocol = ParallelLPTPort + DwordLen
        
        ' Convert the data to or from the byte array using the previous definitions
        CvtByteArrayLong ByteArray(), ArrayIndex, ParallelLPTPort, DaqDevInfo.Parallel.lptPort, bToDaqDevInfo
        CvtByteArrayLong ByteArray(), ArrayIndex, ParallelProtocol, DaqDevInfo.Parallel.protocol, bToDaqDevInfo
        
    Case DaqInfoTypePci&
    
        ' Offset constants for the pci portion of the DaqDevInfoT structure defined in daqx.h
        Const PciSerialNum = InfoReservedInfo
        Const PciBus = PciSerialNum + DwordLen
        Const PciSlot = PciBus + DwordLen
        
        ' Convert the data to or from the byte array using the previous definitions
        CvtByteArrayLong ByteArray(), ArrayIndex, PciSerialNum, DaqDevInfo.Pci.SerialNum, bToDaqDevInfo
        CvtByteArrayLong ByteArray(), ArrayIndex, PciBus, DaqDevInfo.Pci.Bus, bToDaqDevInfo
        CvtByteArrayLong ByteArray(), ArrayIndex, PciSlot, DaqDevInfo.Pci.Slot, bToDaqDevInfo
        
    Case DaqInfoTypePcCard&
    
        ' Offset constants for the pc card portion of the DaqDevInfoT structure defined in daqx.h
        Const PcCardSocket = InfoReservedInfo
        Const PcCardBasePortAddr = PcCardSocket + DwordLen
        Const PcCardInterruptLevel = PcCardBasePortAddr + DwordLen
        Const PcCardDriverInstance = PcCardInterruptLevel + DwordLen
        Const PcCardDaqModel = PcCardDriverInstance + DwordLen
        
        ' Convert the data to or from the byte array using the previous definitions
        CvtByteArrayLong ByteArray(), ArrayIndex, PcCardSocket, DaqDevInfo.PcCard.socket, bToDaqDevInfo
        CvtByteArrayLong ByteArray(), ArrayIndex, PcCardBasePortAddr, DaqDevInfo.PcCard.BasePortAddr, bToDaqDevInfo
        CvtByteArrayLong ByteArray(), ArrayIndex, PcCardInterruptLevel, DaqDevInfo.PcCard.interruptLevel, bToDaqDevInfo
        CvtByteArrayLong ByteArray(), ArrayIndex, PcCardDriverInstance, DaqDevInfo.PcCard.DriverInstance, bToDaqDevInfo
        CvtByteArrayLong ByteArray(), ArrayIndex, PcCardDaqModel, DaqDevInfo.PcCard.DaqModel, bToDaqDevInfo
        
    End Select
        
End Sub

Public Function VBdaqGetDeviceInfo&(ByVal handle&, DevInfo As DaqDevInfoT)

    Dim DevInfoArray(0 To DevInfoLen - 1, 0 To 0) As Byte
    
    daqErrno& = BdaqGetDeviceInfo&(handle&, DevInfoArray(0, 0))
    
    If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then
        Error daqErrnum&
    Else
        ' No error, so copy the data from the returned
        ' byte array into the daq device information
        ' structure
        CvtDaqDevInfo DevInfoArray(), 0, DevInfo, True
    End If
    
    VBdaqGetDeviceInfo& = daqErrno&
   
End Function

Public Function VBdaqGetDeviceInventory&(InfoList() As DaqDevInfoT, InfoListCount As Long, ByVal flags As Long, MatchInfo As DaqDevInfoT)
    
    Dim ByteArray(0 To DevInfoLen - 1, 0 To 99) As Byte
    Dim MatchArray(0 To DevInfoLen - 1, 0 To 0) As Byte
    Dim i As Long
    
    ' Convert the match information from the daq device info
    ' structure to a byte array that can be passed to daqx.dll
    CvtDaqDevInfo MatchArray(), 0, MatchInfo, False
    
    ' initialize the info list count
    InfoListCount = UBound(ByteArray, 2) + 1
    
    ' Make the daqx.dll device inventory call
    daqErrno& = BdaqGetDeviceInventory&(ByteArray(0, 0), InfoListCount, MatchArray(0, 0), flags)
    
    If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then
        Error daqErrnum&
    Else
        ' No error, so redimension the array and copy the
        ' data from the returned byte array into the list
        ' of daq device information structures
        ReDim InfoList(InfoListCount)
        For i = 0 To InfoListCount - 1
            CvtDaqDevInfo ByteArray(), i, InfoList(i), True
        Next i
    End If
    
    VBdaqGetDeviceInventory& = daqErrno&
    
End Function

Public Function VBdaqCreateDevice&(DevInfo As DaqDevInfoT)

    Dim DevInfoArray(0 To DevInfoLen - 1, 0 To 0) As Byte
    
    ' Convert the match information from the daq device info
    ' structure to a byte array that can be passed to daqx.dll
    CvtDaqDevInfo DevInfoArray(), 0, DevInfo, False
    
    daqErrno& = BdaqCreateDevice&(DevInfoArray(0, 0))
    If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
    VBdaqCreateDevice& = daqErrno&

End Function

Function VBdaqDeleteDevice&(ByVal AliasName$)

    daqErrno& = BdaqDeleteDevice&(AliasName$)
    If ((daqErrno& <> 0) And (daqErrnum& <> 0)) Then Error daqErrnum&
    VBdaqDeleteDevice& = daqErrno&

End Function


