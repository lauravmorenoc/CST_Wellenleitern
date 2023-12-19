'# MWS Version: Version 2023.0 - Sep 12 2022 - ACIS 32.0.1 -

'# length = mm
'# frequency = GHz
'# time = ns
'# frequency range: fmin = 70 fmax = 90
'# created = '[VERSION]2023.0|32.0.1|20220912[/VERSION]


'@ use template: Antenna - Waveguide.cfg

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
'set the units
With Units
    .SetUnit "Length", "mm"
    .SetUnit "Frequency", "GHz"
    .SetUnit "Voltage", "V"
    .SetUnit "Resistance", "Ohm"
    .SetUnit "Inductance", "nH"
    .SetUnit "Temperature",  "degC"
    .SetUnit "Time", "ns"
    .SetUnit "Current", "A"
    .SetUnit "Conductance", "S"
    .SetUnit "Capacitance", "pF"
End With

ThermalSolver.AmbientTemperature "0"

'----------------------------------------------------------------------------

'set the frequency range
Solver.FrequencyRange "70", "90"

'----------------------------------------------------------------------------

Plot.DrawBox True

With Background
     .Type "Normal"
     .Epsilon "1.0"
     .Mu "1.0"
     .XminSpace "0.0"
     .XmaxSpace "0.0"
     .YminSpace "0.0"
     .YmaxSpace "0.0"
     .ZminSpace "0.0"
     .ZmaxSpace "0.0"
End With

With Boundary
     .Xmin "expanded open"
     .Xmax "expanded open"
     .Ymin "expanded open"
     .Ymax "expanded open"
     .Zmin "expanded open"
     .Zmax "expanded open"
     .Xsymmetry "none"
     .Ysymmetry "none"
     .Zsymmetry "none"
End With

' switch on FD-TET setting for accurate farfields

FDSolver.ExtrudeOpenBC "True"

Mesh.FPBAAvoidNonRegUnite "True"
Mesh.ConsiderSpaceForLowerMeshLimit "False"
Mesh.MinimumStepNumber "5"

With MeshSettings
     .SetMeshType "Hex"
     .Set "RatioLimitGeometry", "20"
End With

With MeshSettings
     .SetMeshType "HexTLM"
     .Set "RatioLimitGeometry", "20"
End With

PostProcess1D.ActivateOperation "vswr", "true"
PostProcess1D.ActivateOperation "yz-matrices", "true"

With FarfieldPlot
	.ClearCuts ' lateral=phi, polar=theta
	.AddCut "lateral", "0", "1"
	.AddCut "lateral", "90", "1"
	.AddCut "polar", "90", "1"
End With

'----------------------------------------------------------------------------

With MeshSettings
     .SetMeshType "Hex"
     .Set "Version", 1%
End With

With Mesh
     .MeshType "PBA"
End With

'set the solver type
ChangeSolverType("HF Time Domain")

'----------------------------------------------------------------------------

'@ define material: material1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Material 
     .Reset 
     .Name "material1"
     .Folder ""
     .Rho "0.0"
     .ThermalType "Normal"
     .ThermalConductivity "0"
     .SpecificHeat "0", "J/K/kg"
     .DynamicViscosity "0"
     .UseEmissivity "True"
     .Emissivity "0"
     .MetabolicRate "0.0"
     .VoxelConvection "0.0"
     .BloodFlow "0"
     .MechanicsType "Unused"
     .IntrinsicCarrierDensity "0"
     .FrqType "all"
     .Type "Normal"
     .MaterialUnit "Frequency", "GHz"
     .MaterialUnit "Geometry", "mm"
     .MaterialUnit "Time", "ns"
     .MaterialUnit "Temperature", "Celsius"
     .Epsilon "2.3"
     .Mu "1"
     .Sigma "0"
     .TanD "0.0"
     .TanDFreq "0.0"
     .TanDGiven "False"
     .TanDModel "ConstTanD"
     .SetConstTanDStrategyEps "AutomaticOrder"
     .ConstTanDModelOrderEps "3"
     .DjordjevicSarkarUpperFreqEps "0"
     .SetElParametricConductivity "False"
     .ReferenceCoordSystem "Global"
     .CoordSystemType "Cartesian"
     .SigmaM "0"
     .TanDM "0.0"
     .TanDMFreq "0.0"
     .TanDMGiven "False"
     .TanDMModel "ConstTanD"
     .SetConstTanDStrategyMu "AutomaticOrder"
     .ConstTanDModelOrderMu "3"
     .DjordjevicSarkarUpperFreqMu "0"
     .SetMagParametricConductivity "False"
     .DispModelEps  "None"
     .DispModelMu "None"
     .DispersiveFittingSchemeEps "Nth Order"
     .MaximalOrderNthModelFitEps "10"
     .ErrorLimitNthModelFitEps "0.1"
     .UseOnlyDataInSimFreqRangeNthModelEps "False"
     .DispersiveFittingSchemeMu "Nth Order"
     .MaximalOrderNthModelFitMu "10"
     .ErrorLimitNthModelFitMu "0.1"
     .UseOnlyDataInSimFreqRangeNthModelMu "False"
     .UseGeneralDispersionEps "False"
     .UseGeneralDispersionMu "False"
     .NLAnisotropy "False"
     .NLAStackingFactor "1"
     .NLADirectionX "1"
     .NLADirectionY "0"
     .NLADirectionZ "0"
     .Colour "1", "0.501961", "0.25098" 
     .Wireframe "False" 
     .Reflection "False" 
     .Allowoutline "True" 
     .Transparentoutline "False" 
     .Transparency "0" 
     .Create
End With

'@ new component: component1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Component.New "component1"

'@ define brick: component1:solid1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Brick
     .Reset 
     .Name "solid1" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "-dwg_w/2", "dwg_w/2" 
     .Yrange "-dwg_w/2", "dwg_w/2" 
     .Zrange "0", "dwg_l" 
     .Create
End With

'@ pick face

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickFaceFromId "component1:solid1", "2"

'@ define port: 1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "True"
     .PolarizationAngle "90.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "0"
     .Coordinates "Picks"
     .Orientation "positive"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "-0.9", "0.9"
     .Yrange "-0.9", "0.9"
     .Zrange "0", "0"
     .XrangeAdd "3", "3"
     .YrangeAdd "3", "3"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ pick face

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickFaceFromId "component1:solid1", "1"

'@ define port: 2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .PortNumber "2" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "True"
     .PolarizationAngle "90.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "0"
     .Coordinates "Picks"
     .Orientation "positive"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "-0.9", "0.9"
     .Yrange "-0.9", "0.9"
     .Zrange "50", "50"
     .XrangeAdd "4", "4"
     .YrangeAdd "4", "4"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define time domain solver parameters

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "All"
     .StimulationMode "All"
     .SteadyStateLimit "-40"
     .MeshAdaption "False"
     .AutoNormImpedance "False"
     .NormingImpedance "50"
     .CalculateModesOnly "True"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .RunDiscretizerOnly "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ set PBA version

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Discretizer.PBAVersion "2022091223"

'@ modify port: 2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "2" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "True"
     .PolarizationAngle "90.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "0"
     .Coordinates "Picks"
     .Orientation "positive"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "-0.9", "0.9"
     .Yrange "-0.9", "0.9"
     .Zrange "50", "50"
     .XrangeAdd "3", "3"
     .YrangeAdd "3", "3"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .Shield "none"
     .WaveguideMonitor "False"
     .Modify 
End With

'@ define time domain solver acceleration

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Solver 
     .UseParallelization "True"
     .MaximumNumberOfThreads "1024"
     .MaximumNumberOfCPUDevices "2"
     .RemoteCalculation "False"
     .UseDistributedComputing "False"
     .MaxNumberOfDistributedComputingPorts "64"
     .DistributeMatrixCalculation "True"
     .MPIParallelization "False"
     .AutomaticMPI "False"
     .HardwareAcceleration "False"
     .MaximumNumberOfGPUs "1"
End With
UseDistributedComputingForParameters "True"
MaxNumberOfDistributedComputingParameters "1"
UseDistributedComputingMemorySetting "False"
MinDistributedComputingMemoryLimit "0"
UseDistributedComputingSharedDirectory "False"
OnlyConsider0D1DResultsForDC "False"

'@ define time domain solver parameters

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Mesh.SetCreator "High Frequency" 

With Solver 
     .Method "Hexahedral"
     .CalculationType "TD-S"
     .StimulationPort "1"
     .StimulationMode "1"
     .SteadyStateLimit "-40"
     .MeshAdaption "False"
     .CalculateModesOnly "False"
     .SParaSymmetry "False"
     .StoreTDResultsInCache  "False"
     .RunDiscretizerOnly "False"
     .FullDeembedding "False"
     .SuperimposePLWExcitation "False"
     .UseSensitivityAnalysis "False"
End With

'@ modify port: 1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "1" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "True"
     .PolarizationAngle "90.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "0"
     .Coordinates "Picks"
     .Orientation "positive"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "-0.9", "0.9"
     .Yrange "-0.9", "0.9"
     .Zrange "0", "0"
     .XrangeAdd "5", "5"
     .YrangeAdd "5", "5"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .Shield "none"
     .WaveguideMonitor "False"
     .Modify 
End With

'@ modify port: 2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "2" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "True"
     .PolarizationAngle "90.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "0"
     .Coordinates "Picks"
     .Orientation "positive"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "-0.9", "0.9"
     .Yrange "-0.9", "0.9"
     .Zrange "50", "50"
     .XrangeAdd "5", "5"
     .YrangeAdd "5", "5"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .Shield "none"
     .WaveguideMonitor "False"
     .Modify 
End With

'@ attach active wcs to component1:solid1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solid.AttachActiveWCS "component1:solid1"

'@ define material: Air

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Material
     .Reset
     .Name "Air"
     .Folder ""
.FrqType "all"
.Type "Normal"
.SetMaterialUnit "Hz", "mm"
.Epsilon "1.00059"
.Mu "1.0"
.Kappa "0"
.TanD "0.0"
.TanDFreq "0.0"
.TanDGiven "False"
.TanDModel "ConstKappa"
.KappaM "0"
.TanDM "0.0"
.TanDMFreq "0.0"
.TanDMGiven "False"
.TanDMModel "ConstKappa"
.DispModelEps "None"
.DispModelMu "None"
.DispersiveFittingSchemeEps "General 1st"
.DispersiveFittingSchemeMu "General 1st"
.UseGeneralDispersionEps "False"
.UseGeneralDispersionMu "False"
.Rho "1.204"
.ThermalType "Normal"
.ThermalConductivity "0.026"
.SpecificHeat "1005", "J/K/kg"
.SetActiveMaterial "all"
.Colour "0.682353", "0.717647", "1"
.Wireframe "False"
.Transparency "0"
.Create
End With

'@ define brick: component1:air_layer

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Brick
     .Reset 
     .Name "air_layer" 
     .Component "component1" 
     .Material "Air" 
     .Xrange "-dwg_w/2", "dwg_w/2" 
     .Yrange "-dwg_w/2", "dwg_w/2" 
     .Zrange "dwg_l", "dwg_l+dair_l" 
     .Create
End With

'@ paste structure data: 1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With SAT 
     .Reset 
     .FileName "*1.cby" 
     .SubProjectScaleFactor "0.001" 
     .ImportToActiveCoordinateSystem "True" 
     .ScaleToUnit "True" 
     .Curves "False" 
     .Read 
End With

'@ delete shape: component1:solid1_1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solid.Delete "component1:solid1_1"

'@ define brick: component1:solid2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Brick
     .Reset 
     .Name "solid2" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "-dwg_w/2", "dwg_w/2" 
     .Yrange "-dwg_w/2", "dwg_w/2" 
     .Zrange "dwg_l+dair_l", "dair_l+2*dwg_l" 
     .Create
End With

'@ pick face

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickFaceFromId "component1:solid2", "2"

'@ define port: 3

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .PortNumber "3" 
     .Label ""
     .Folder ""
     .NumberOfModes "1"
     .AdjustPolarization "False"
     .PolarizationAngle "0.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "0"
     .Coordinates "Picks"
     .Orientation "positive"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "-0.9", "0.9"
     .Yrange "-0.9", "0.9"
     .Zrange "50.5", "50.5"
     .XrangeAdd "1", "1"
     .YrangeAdd "1", "1"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ modify port: 3

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .LoadContentForModify "3" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "True"
     .PolarizationAngle "90.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "0"
     .Coordinates "Picks"
     .Orientation "positive"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "-0.9", "0.9"
     .Yrange "-0.9", "0.9"
     .Zrange "50.5", "50.5"
     .XrangeAdd "5", "5"
     .YrangeAdd "5", "5"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .Shield "none"
     .WaveguideMonitor "False"
     .Modify 
End With

'@ pick face

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickFaceFromId "component1:solid2", "1"

'@ define port: 4

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .PortNumber "4" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "True"
     .PolarizationAngle "90.0"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "0"
     .Coordinates "Picks"
     .Orientation "positive"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "-0.9", "0.9"
     .Yrange "-0.9", "0.9"
     .Zrange "100.5", "100.5"
     .XrangeAdd "5", "5"
     .YrangeAdd "5", "5"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ define monitor: e-field (f=80)

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Monitor 
     .Reset 
     .Name "e-field (f=80)" 
     .Dimension "Volume" 
     .Domain "Frequency" 
     .FieldType "Efield" 
     .MonitorValue "80" 
     .UseSubvolume "False" 
     .Coordinates "Structure" 
     .SetSubvolume "-5.9", "5.9", "-5.9", "5.9", "0", "100.5" 
     .SetSubvolumeOffset "0.0", "0.0", "0.0", "0.0", "0.0", "0.0" 
     .SetSubvolumeInflateWithOffset "False" 
     .Create 
End With

'@ delete ports

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Port.Delete "2" 
Port.Delete "3"

'@ rename port: 4 to: 2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Port.Rename "4", "2"

