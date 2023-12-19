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

'@ define brick: component1:solid3

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Brick
     .Reset 
     .Name "solid3" 
     .Component "component1" 
     .Material "material1" 
     .Xrange "-dwg_w/2+vert_slip", "dwg_w/2+vert_slip" 
     .Yrange "0", "dwg_l" 
     .Zrange "-dwg_w/2", "dwg_w/2" 
     .Create
End With

'@ clear picks

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.ClearAllPicks

'@ pick edge

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickEdgeFromId "component1:solid3", "1", "1"

'@ define curve line: curve1:line1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Line
     .Reset 
     .Name "line1" 
     .Curve "curve1" 
     .X1 "-233.98" 
     .Y1 "690.12" 
     .X2 "-234.74" 
     .Y2 "693.4" 
     .Create
End With

'@ clear picks

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.ClearAllPicks

'@ delete curve item: curve1:line1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Curve.DeleteCurveItem "curve1", "line1"

'@ define curve rectangle: curve1:rectangle1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Rectangle
     .Reset 
     .Name "rectangle1" 
     .Curve "curve1" 
     .Xrange "dwg_w/2+1", "3*dwg_w/2+1" 
     .Yrange "-dwg_w", "dwg_w" 
     .Create
End With

'@ transform curve: translate curve1:rectangle1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Transform 
     .Reset 
     .Name "curve1:rectangle1" 
     .Vector "0", "0", "dwg_l" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Curve", "Translate" 
End With

'@ transform curve: translate curve1:rectangle1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Transform 
     .Reset 
     .Name "curve1:rectangle1" 
     .Vector "0", "0", "dair_l" 
     .UsePickedPoints "False" 
     .InvertPickedPoints "False" 
     .MultipleObjects "False" 
     .GroupObjects "False" 
     .Repetitions "1" 
     .MultipleSelection "False" 
     .Transform "Curve", "Translate" 
End With

'@ delete curve: curve1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Curve.DeleteCurve "curve1"

'@ store picked point: 1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "1" 
Pick.PickEndpointFromId "component1:solid3", "5"

'@ store picked point: 2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "2" 
Pick.PickEndpointFromId "component1:solid3", "2"

'@ store picked point: 3

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "3" 
Pick.PickEndpointFromId "component1:solid3", "3"

'@ store picked point: 4

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "4" 
Pick.PickEndpointFromId "component1:solid3", "8"

'@ store picked point: 5

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "5" 
Pick.PickEndpointFromId "component1:solid3", "5"

'@ define curve 3dpolygon: curve1:face1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "face1" 
     .Curve "curve1" 
     .Point "dwg_w/2+1", "dwg_l+dair_l", "dwg_w/2" 
     .Point "3*dwg_w/2+1", "dwg_l+dair_l+dwg_w/tan(alpha)", "dwg_w/2" 
     .Point "3*dwg_w/2+1", "dwg_l+dair_l+dwg_w/tan(alpha)", "-dwg_w/2" 
     .Point "dwg_w/2+1", "dwg_l+dair_l", "-dwg_w/2" 
     .Point "dwg_w/2+1", "dwg_l+dair_l", "dwg_w/2" 
     .Create 
End With

'@ new component: component1/solid4

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Component.New "component1/solid4"

'@ delete component: component1/solid4

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Component.Delete "component1/solid4"

'@ define facefromextrudecurve: face1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Face
     .Reset 
     .Name "face1" 
     .Type "ExtrudeCurve" 
     .Thickness "dwg_w" 
     .Twistangle "0.0" 
     .Taperangle "0.0" 
     .DeleteCurve "False" 
     .Curve "curve1:face1" 
     .Create
End With

'@ delete face: face1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Face.Delete "face1"

'@ clear picks

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.ClearAllPicks

'@ pick edge

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickEdgeOnCurveFromId "curve1:face1", "3", "3"

'@ pick edge

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickEdgeOnCurveFromId "curve1:face1", "4", "4"

'@ pick edge

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickEdgeOnCurveFromId "curve1:face1", "1", "1"

'@ pick edge

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickEdgeOnCurveFromId "curve1:face1", "2", "2"

'@ define curve 3dpolygon: curve1:face2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "face2" 
     .Curve "curve1" 
     .Point "dwg_w/2+1", "2*dwg_l+dair_l", "dwg_w/2" 
     .Point "3*dwg_w/2+1", "2*dwg_l+dair_l+dwg_w/tan(alpha)", "dwg_w/2" 
     .Point "3*dwg_w/2+1", "2*dwg_l+dair_l+dwg_w/tan(alpha)", "-dwg_w/2" 
     .Point "dwg_w/2+1", "2*dwg_l+dair_l", "-dwg_w/2" 
     .Point "dwg_w/2+1", "2*dwg_l+dair_l", "dwg_w/2" 
     .Create 
End With

'@ new component: component2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Component.New "component2"

'@ define curveloft: component2:solid4

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With LoftCurves
     .Reset 
     .Name "solid4" 
     .Component "component2" 
     .Material "material1" 
     .Solid "True" 
     .MinimizeTwist "True" 
     .DeleteCurves "True" 
     .AddCurve "curve1:face1" 
     .AddCurve "curve1:face2" 
     .Create 
End With

'@ delete ports

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Port.Delete "1" 
Port.Delete "2"

'@ delete shapes

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solid.Delete "component1:air_layer" 
Solid.Delete "component1:solid1" 
Solid.Delete "component1:solid2"

'@ pick face

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickFaceFromId "component2:solid4", "2"

'@ pick face

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickFaceFromId "component1:solid3", "5"

'@ define extrude selected

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Extrude 
     .Reset 
     .Name "luft_spalt" 
     .NumberOfPickedFaces "2" 
     .PickHeightDeterminedByFirstFace "True" 
     .Component "component1" 
     .Material "Air" 
     .Mode "MultiplePicks" 
     .Height "0.0" 
     .Twist "0.0" 
     .Taper "0.0" 
     .UsePicksForHeight "False" 
     .DeleteBaseFaceSolid "False" 
     .KeepMaterials "False" 
     .ClearPickedFace "True" 
     .Create 
End With

'@ boolean subtract shapes: component2:solid4, component1:luft_spalt

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solid.Subtract "component2:solid4", "component1:luft_spalt"

'@ boolean subtract shapes: component1:solid3, component1:luft_spalt_1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solid.Subtract "component1:solid3", "component1:luft_spalt_1"

'@ pick edge

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickEdgeFromId "component2:solid4", "16", "13"

'@ pick edge

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickEdgeFromId "component2:solid4", "13", "14"

'@ pick edge

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickEdgeFromId "component2:solid4", "14", "15"

'@ pick edge

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickEdgeFromId "component2:solid4", "15", "16"

'@ store picked point: 6

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "6" 
Pick.PickMidpointFromId "component2:solid4", "17"

'@ store picked point: 7

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "7" 
Pick.PickMidpointFromId "component2:solid4", "17"

'@ clear picks

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.ClearAllPicks

'@ store picked point: 8

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "8" 
Pick.PickMidpointFromId "component2:solid4", "17"

'@ store picked point: 9

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "9" 
Pick.PickEndpointFromId "component2:solid4", "13"

'@ store picked point: 10

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "10" 
Pick.PickEndpointFromId "component2:solid4", "14"

'@ store picked point: 11

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "11" 
Pick.PickEndpointFromId "component2:solid4", "15"

'@ store picked point: 12

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "12" 
Pick.PickEndpointFromId "component2:solid4", "16"

'@ store picked point: 13

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "13" 
Pick.PickEndpointFromId "component2:solid4", "13"

'@ define curve 3dpolygon: curve1:inclined_face

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "inclined_face" 
     .Curve "curve1" 
     .Point "xp(9)-1-dwg_w", "yp(9)", "zp(9)" 
     .Point "xp(10)-1-dwg_w", "yp(10)", "zp(10)" 
     .Point "xp(11)-1-dwg_w", "yp(11)", "zp(11)" 
     .Point "xp(12)-1-dwg_w", "yp(12)", "zp(12)" 
     .Point "xp(9)-1-dwg_w", "yp(9)", "zp(9)" 
     .Create 
End With

'@ store picked point: 14

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "14" 
Pick.PickEndpointFromId "component1:solid3", "13"

'@ store picked point: 15

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "15" 
Pick.PickEndpointFromId "component1:solid3", "13"

'@ store picked point: 16

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "16" 
Pick.PickEndpointFromId "component1:solid3", "10"

'@ store picked point: 17

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "17" 
Pick.PickEndpointFromId "component1:solid3", "11"

'@ store picked point: 18

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "18" 
Pick.PickEndpointFromId "component1:solid3", "16"

'@ store picked point: 19

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "19" 
Pick.PickEndpointFromId "component1:solid3", "13"

'@ define curve 3dpolygon: curve1:face

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "face" 
     .Curve "curve1" 
     .Point "xp(15)", "yp(15)", "zp(15)" 
     .Point "xp(16)", "yp(16)", "zp(16)" 
     .Point "xp(17)", "yp(17)", "zp(17)" 
     .Point "xp(18)", "yp(18)", "zp(18)" 
     .Point "xp(19)", "yp(19)", "zp(19)" 
     .Create 
End With

'@ define curveloft: component1:air_gap

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With LoftCurves
     .Reset 
     .Name "air_gap" 
     .Component "component1" 
     .Material "Air" 
     .Solid "True" 
     .MinimizeTwist "True" 
     .DeleteCurves "False" 
     .AddCurve "curve1:inclined_face" 
     .AddCurve "curve1:face" 
     .Create 
End With

'@ pick face

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickFaceFromId "component1:solid3", "9"

'@ define port: 1

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .PortNumber "1" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "True"
     .PolarizationAngle "90"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Picks"
     .Orientation "positive"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "1.9", "3.7"
     .Yrange "0", "0"
     .Zrange "-0.9", "0.9"
     .XrangeAdd "2", "2"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "2", "2"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ pick face

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickFaceFromId "component2:solid4", "7"

'@ define port: 2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .PortNumber "2" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "True"
     .PolarizationAngle "90"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Picks"
     .Orientation "positive"
     .PortOnBound "True"
     .ClipPickedPortToBound "False"
     .Xrange "0", "1.8"
     .Yrange "0", "1.8277679013943"
     .Zrange "0", "0"
     .XrangeAdd "2", "2"
     .YrangeAdd "2", "2"
     .ZrangeAdd "0.0", "0.0"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ delete port: port2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Port.Delete "2"

'@ store picked point: 20

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "20" 
Pick.PickEndpointFromId "component2:solid4", "11"

'@ store picked point: 21

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "21" 
Pick.PickEndpointFromId "component2:solid4", "11"

'@ store picked point: 22

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "22" 
Pick.PickEndpointFromId "component2:solid4", "10"

'@ store picked point: 23

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "23" 
Pick.PickEndpointFromId "component2:solid4", "11"

'@ store picked point: 24

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "24" 
Pick.PickEndpointFromId "component2:solid4", "10"

'@ store picked point: 25

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "25" 
Pick.PickEndpointFromId "component2:solid4", "10"

'@ store picked point: 26

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "26" 
Pick.PickEndpointFromId "component2:solid4", "11"

'@ store picked point: 27

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "27" 
Pick.PickEndpointFromId "component2:solid4", "12"

'@ store picked point: 28

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "28" 
Pick.PickEndpointFromId "component2:solid4", "9"

'@ store picked point: 29

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "29" 
Pick.PickEndpointFromId "component2:solid4", "10"

'@ define curve 3dpolygon: curve1:inclined_face2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "inclined_face2" 
     .Curve "curve1" 
     .Point "xp(25)-1-dwg_w", "yp(25)", "zp(25)" 
     .Point "xp(26)-1-dwg_w", "yp(26)", "zp(26)" 
     .Point "xp(27)-1-dwg_w", "yp(27)", "zp(27)" 
     .Point "xp(28)-1-dwg_w", "yp(28)", "zp(28)" 
     .Point "xp(29)-1-dwg_w", "yp(29)", "zp(29)" 
     .Create 
End With

'@ store picked point: 30

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "30" 
Pick.PickEndpointFromId "component2:solid4", "10"

'@ store picked point: 31

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "31" 
Pick.PickEndpointFromId "component2:solid4", "11"

'@ store picked point: 32

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "32" 
Pick.PickEndpointFromId "component2:solid4", "12"

'@ store picked point: 33

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "33" 
Pick.PickEndpointFromId "component2:solid4", "9"

'@ store picked point: 34

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "34" 
Pick.PickEndpointFromId "component2:solid4", "10"

'@ define curve 3dpolygon: curve1:auxiliar_face

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "auxiliar_face" 
     .Curve "curve1" 
     .Point "xp(30)-1-dwg_w", "yp(30)", "zp(30)" 
     .Point "xp(31)-1-dwg_w", "yp(31)", "zp(31)" 
     .Point "xp(32)-1-dwg_w", "yp(32)+dwg_w/tan(alpha)", "zp(32)" 
     .Point "xp(33)-1-dwg_w", "yp(33)+dwg_w/tan(alpha)", "zp(33)" 
     .Point "xp(34)-1-dwg_w", "yp(34)", "zp(34)" 
     .Create 
End With

'@ delete shape: component2:solid4

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solid.Delete "component2:solid4"

'@ define curveloft: component1:solid51

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With LoftCurves
     .Reset 
     .Name "solid51" 
     .Component "component1" 
     .Material "material1" 
     .Solid "True" 
     .MinimizeTwist "True" 
     .DeleteCurves "False" 
     .AddCurve "curve1:inclined_face2" 
     .AddCurve "curve1:inclined_face" 
     .Create 
End With

'@ define curveloft: component1:aux_solid

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With LoftCurves
     .Reset 
     .Name "aux_solid" 
     .Component "component1" 
     .Material "material1" 
     .Solid "True" 
     .MinimizeTwist "True" 
     .DeleteCurves "False" 
     .AddCurve "curve1:inclined_face2" 
     .AddCurve "curve1:auxiliar_face" 
     .Create 
End With

'@ pick face

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.PickFaceFromId "component1:aux_solid", "1"

'@ define port: 2

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Port 
     .Reset 
     .PortNumber "2" 
     .Label ""
     .Folder ""
     .NumberOfModes "2"
     .AdjustPolarization "True"
     .PolarizationAngle "90"
     .ReferencePlaneDistance "0"
     .TextSize "50"
     .TextMaxLimit "1"
     .Coordinates "Picks"
     .Orientation "positive"
     .PortOnBound "False"
     .ClipPickedPortToBound "False"
     .Xrange "1.9", "3.7"
     .Yrange "100.81738856527", "100.81738856527"
     .Zrange "-0.9", "0.9"
     .XrangeAdd "2", "2"
     .YrangeAdd "0.0", "0.0"
     .ZrangeAdd "2", "2"
     .SingleEnded "False"
     .WaveguideMonitor "False"
     .Create 
End With

'@ store picked point: 52

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "52" 
Pick.PickEndpointFromId "component1:air_gap", "1"

'@ store picked point: 53

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "53" 
Pick.PickEndpointFromId "component1:air_gap", "4"

'@ store picked point: 54

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "54" 
Pick.PickEndpointFromId "component1:air_gap", "3"

'@ store picked point: 55

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "55" 
Pick.PickEndpointFromId "component1:air_gap", "2"

'@ store picked point: 56

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "56" 
Pick.PickEndpointFromId "component1:air_gap", "1"

'@ define curve 3dpolygon: curve2:air_curve_parallel

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "air_curve_parallel" 
     .Curve "curve2" 
     .Point "xp(52)+air_dx", "yp(52)", "zp(52)+air_dx" 
     .Point "xp(53)+air_dx", "yp(53)", "zp(53)-air_dx" 
     .Point "xp(54)-air_dx-vert_slip", "yp(54)", "zp(54)-air_dx" 
     .Point "xp(55)-air_dx-vert_slip", "yp(55)", "zp(55)+air_dx" 
     .Point "xp(56)+air_dx", "yp(56)", "zp(56)+air_dx" 
     .Create 
End With

'@ store picked point: 57

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "57" 
Pick.PickEndpointFromId "component1:solid51", "2"

'@ store picked point: 58

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "58" 
Pick.PickEndpointFromId "component1:solid51", "1"

'@ store picked point: 59

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "59" 
Pick.PickEndpointFromId "component1:solid51", "4"

'@ store picked point: 60

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "60" 
Pick.PickEndpointFromId "component1:solid51", "3"

'@ store picked point: 61

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Pick.NextPickToDatabase "61" 
Pick.PickEndpointFromId "component1:solid51", "2"

'@ define curve 3dpolygon: curve2:air_curve_inclined

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With Polygon3D 
     .Reset 
     .Version 10 
     .Name "air_curve_inclined" 
     .Curve "curve2" 
     .Point "xp(57)+air_dx", "yp(57)+air_dy", "zp(57)+air_dx" 
     .Point "xp(58)+air_dx", "yp(58)+air_dy", "zp(58)-air_dx" 
     .Point "xp(59)-air_dx", "yp(59)-air_dy", "zp(59)-air_dx" 
     .Point "xp(60)-air_dx", "yp(60)-air_dy", "zp(60)+air_dx" 
     .Point "xp(61)+air_dx", "yp(61)+air_dy", "zp(61)+air_dx" 
     .Create 
End With

'@ delete shape: component1:air_gap

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
Solid.Delete "component1:air_gap"

'@ define curveloft: component1:air_gap

'[VERSION]2023.0|32.0.1|20220912[/VERSION]
With LoftCurves
     .Reset 
     .Name "air_gap" 
     .Component "component1" 
     .Material "Air" 
     .Solid "True" 
     .MinimizeTwist "True" 
     .DeleteCurves "False" 
     .AddCurve "curve2:air_curve_parallel" 
     .AddCurve "curve2:air_curve_inclined" 
     .Create 
End With

''@ delete shape: component2:solid4
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Solid.Delete "component2:solid4"
'
''@ define curveloft: component1:solid1
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'With LoftCurves
'     .Reset 
'     .Name "solid1" 
'     .Component "component1" 
'     .Material "material1" 
'     .Solid "True" 
'     .MinimizeTwist "True" 
'     .DeleteCurves "False" 
'     .AddCurve "curve1:inclined_face" 
'     .AddCurve "curve1:inclined_face2" 
'     .Create 
'End With
'
''@ store picked point: 35
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "35" 
'Pick.PickEndpointFromId "component1:air_gap", "4"
'
''@ store picked point: 36
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "36" 
'Pick.PickEndpointFromId "component1:air_gap", "1"
'
''@ store picked point: 37
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "37" 
'Pick.PickEndpointFromId "component1:air_gap", "3"
'
''@ store picked point: 38
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "38" 
'Pick.PickEndpointFromId "component1:air_gap", "4"
'
''@ store picked point: 39
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "39" 
'Pick.PickEndpointFromId "component1:air_gap", "1"
'
''@ store picked point: 40
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "40" 
'Pick.PickEndpointFromId "component1:air_gap", "4"
'
''@ store picked point: 41
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "41" 
'Pick.PickEndpointFromId "component1:air_gap", "3"
'
''@ store picked point: 42
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "42" 
'Pick.PickEndpointFromId "component1:air_gap", "2"
'
''@ store picked point: 43
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "43" 
'Pick.PickEndpointFromId "component1:air_gap", "1"
'
''@ define curve 3dpolygon: curve2:parallel_air_curve
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'With Polygon3D 
'     .Reset 
'     .Version 10 
'     .Name "parallel_air_curve" 
'     .Curve "curve2" 
'     .Point "xp(39)+1", "yp(39)", "zp(39)+1" 
'     .Point "xp(40)+1", "yp(40)", "zp(40)-1" 
'     .Point "xp(41)-1", "yp(41)", "zp(41)-1" 
'     .Point "xp(42)-1", "yp(42)", "zp(42)+1" 
'     .Point "xp(43)+1", "yp(43)", "zp(43)+1" 
'     .Create 
'End With
'
''@ store picked point: 44
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "44" 
'Pick.PickEndpointFromId "component1:solid1", "8"
'
''@ store picked point: 45
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "45" 
'Pick.PickEndpointFromId "component1:solid1", "5"
'
''@ store picked point: 46
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "46" 
'Pick.PickEndpointFromId "component1:solid1", "7"
'
''@ store picked point: 47
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "47" 
'Pick.PickEndpointFromId "component1:solid1", "5"
'
''@ store picked point: 48
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "48" 
'Pick.PickEndpointFromId "component1:solid1", "8"
'
''@ store picked point: 49
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "49" 
'Pick.PickEndpointFromId "component1:solid1", "7"
'
''@ store picked point: 50
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "50" 
'Pick.PickEndpointFromId "component1:solid1", "6"
'
''@ store picked point: 51
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Pick.NextPickToDatabase "51" 
'Pick.PickEndpointFromId "component1:solid1", "5"
'
''@ define curve 3dpolygon: curve2:inclined_air_curve
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'With Polygon3D 
'     .Reset 
'     .Version 10 
'     .Name "inclined_air_curve" 
'     .Curve "curve2" 
'     .Point "xp(47)+air_dx", "yp(47)+air_dy", "zp(47)+air_dx" 
'     .Point "xp(48)+air_dx", "yp(48)+air_dy", "zp(48)-air_dx" 
'     .Point "xp(49)-air_dx", "yp(49)-air_dy", "zp(49)-air_dx" 
'     .Point "xp(50)-air_dx", "yp(50)-air_dy", "zp(50)+air_dx" 
'     .Point "xp(51)+air_dx", "yp(51)+air_dy", "zp(51)+air_dx" 
'     .Create 
'End With
'
''@ delete shape: component1:air_gap
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Solid.Delete "component1:air_gap"
'
''@ define curveloft: component1:air_gap
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'With LoftCurves
'     .Reset 
'     .Name "air_gap" 
'     .Component "component1" 
'     .Material "Air" 
'     .Solid "True" 
'     .MinimizeTwist "True" 
'     .DeleteCurves "False" 
'     .AddCurve "curve2:parallel_air_curve" 
'     .AddCurve "curve2:inclined_air_curve" 
'     .Create 
'End With
'
''@ boolean subtract shapes: component1:solid1, component1:air_gap
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'Solid.Subtract "component1:solid1", "component1:air_gap"
'
''@ define curveloft: component1:air_gap
'
''[VERSION]2023.0|32.0.1|20220912[/VERSION]
'With LoftCurves
'     .Reset 
'     .Name "air_gap" 
'     .Component "component1" 
'     .Material "Air" 
'     .Solid "True" 
'     .MinimizeTwist "True" 
'     .DeleteCurves "True" 
'     .AddCurve "curve2:inclined_air_curve" 
'     .AddCurve "curve2:parallel_air_curve" 
'     .Create 
'End With
'
