within OpenCPS_D53B.MultiDomain.SMIB.GGOVGovernor.NoiseOnLoad;
model SMIB_Gov "Network model with no generator controls"
  import OpenCPS_D53B;
  extends OpenCPS_D53B.PowerSystemDomain.Networks.SMIB.Partial.SMIB_Partial_Noise(
    transformer(V_b=13.8, Vn=13.8),
    LOAD(V_b=13.8),
    GEN1(V_b=13.8),
    BUS1(V_b=13.8),
    BUS2(V_b=13.8),
    BUS3(V_b=13.8),
    GEN2(V_b=13.8),
    sineNoiseInjection(
      amplitude=0.05,
      freqHz=0.02,
      active_sigma=0.0005),
    infiniteGen(
      V_b=13.8,
      M_b=1000,
      P_0=pf_results.machines.P3_1,
      Q_0=pf_results.machines.Q3_1,
      V_0=pf_results.voltages.V3,
      angle_0=pf_results.voltages.A3),
    variableLoad(
      P_0=pf_results.loads.PL23_1,
      Q_0=pf_results.loads.QL23_1,
      V_0=pf_results.voltages.V23,
      angle_0=pf_results.voltages.A23,
      t1=30,
      d_t=20,
      d_P=0.2),
    pMU(V_0=pf_results.voltages.V23, angle_0=pf_results.voltages.A23));
  import Modelica.Constants.pi;

  OpenCPS_D53B.TurboMachineryDomain.GTModels.ThPowerSSGT gtDyns annotation (Placement(transformation(extent={{-126,-20},{-86,20}})));
  OpenCPS_D53B.MultiDomain.Generation_Groups.SMIB.Gen_GT genGroup(
    V_b=13.8,
    M_b=10,
    Q_0=pf_results.machines.Q1_1,
    P_0=pf_results.machines.P1_1,
    V_0=pf_results.voltages.V1,
    angle_0=pf_results.voltages.A1) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  OpenCPS_D53B.PowerSystemDomain.Controls.GGOV1.Simplified.PIDGovernor2B governor(
    R=0.04,
    T_pelec=1,
    maxerr=0.05,
    minerr=-0.05,
    Kdgov=0,
    Vmax=1,
    Dm=0,
    Kimw=0,
    db=0,
    Rselect=1,
    Vmin=0.1,
    Tdgov=1,
    Pref=pf_results.machines.P1_1/10,
    Kpgov=10,
    Kigov=5,
    Kturb=1.5,
    Wfnl=0.15) annotation (Placement(transformation(extent={{-92,-58},{-120,-30}})));
  OpenCPS_D53B.PowerSystemDomain.Networks.SMIB.Records.PF_075 pf_results annotation (Placement(transformation(extent={{-136,50},{-116,70}})));
  inner Modelica.Blocks.Noise.GlobalSeed globalSeed(useAutomaticSeed=true) annotation (Placement(transformation(extent={{-28,-90},{-8,-70}})));
equation
  connect(genGroup.pwPin, GEN1.p) annotation (Line(points={{-49,0},{-49,0},{-42,0}}, color={0,0,255}));
  connect(gtDyns.shaft_b, genGroup.shaft) annotation (Line(points={{-86,0},{-86,0},{-70,0}}, color={0,0,0}));
  connect(governor.FSR, gtDyns.valvePosition) annotation (Line(points={{-121.2,-44},{-134,-44},{-134,9.5},{-126.3,9.5}}, color={0,0,127}));
  connect(governor.SPEED, genGroup.speed) annotation (Line(points={{-90.9,-35.9},{-64,-35.9},{-64,-9.8}}, color={0,0,127}));
  connect(genGroup.Pelec, governor.PELEC) annotation (Line(points={{-69,-5},{-69,-52.1},{-90.9,-52.1}}, color={0,0,127}));
  annotation (
    Diagram(graphics={Text(
          extent={{-112,68},{108,48}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          fontSize=15,
          textStyle={TextStyle.Bold},
          textString="(Constant Efd)")}),
    experiment(
      StopTime=100,
      Interval=0.02,
      __Dymola_fixedstepsize=0.02,
      __Dymola_Algorithm="Dassl"),
    __Dymola_experimentSetupOutput);
end SMIB_Gov;
