within OpenCPS_D53B.PowerSystemDomain.Networks.SMIB.NoNoiseOnLoad;
model SMIB_TurbNoGov "SMIB network and turbine dynamics, no exciter (load without noise), no governor"
  extends Partial.SMIB_Partial_NoNoise(
    transformer(V_b=13.8, Vn=13.8),
    LOAD(V_b=13.8),
    GEN1(V_b=13.8),
    BUS1(V_b=13.8),
    BUS2(V_b=13.8),
    BUS3(V_b=13.8),
    GEN2(V_b=13.8),
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
      d_P=0.2,
      t1=30,
      d_t=20),
    pMU(V_0=pf_results.voltages.V23, angle_0=pf_results.voltages.A23));
  import Modelica.Constants.pi;

  Generation_Groups.SMIB.Generator generator(
    V_b=13.8,
    M_b=10,
    Q_0=pf_results.machines.Q1_1,
    P_0=pf_results.machines.P1_1,
    V_0=pf_results.voltages.V1,
    angle_0=pf_results.voltages.A1) annotation (Placement(transformation(extent={{-70,-10},{-50,10}})));
  Records.PF_075 pf_results annotation (Placement(transformation(extent={{-136,50},{-116,70}})));
  Controls.GGOV1.Simplified.Turbine turbine(
    Flag=0,
    Tact=4,
    Kturb=1.5,
    Tb=0.14101,
    Tc=0.1151,
    Teng=0,
    Dm=0,
    Wfnl=0.15,
    Tfload=3,
    Ropen=0.1,
    Rclose=-0.1,
    Tsa=4,
    Tsb=5,
    DELT=0.005) annotation (Placement(transformation(extent={{-108,-14},{-80,14}})));
  Modelica.Blocks.Sources.Constant const(k=0.65) annotation (Placement(transformation(extent={{-148,-18},{-132,-2}})));
equation
  connect(generator.pwPin, GEN1.p) annotation (Line(points={{-49,0},{-45.5,0},{-42,0}}, color={0,0,255}));
  connect(turbine.PMECH, generator.Pmech) annotation (Line(points={{-78.8,0},{-78,0},{-70.6,0}}, color={0,0,127}));
  connect(generator.speed, turbine.SPEED) annotation (Line(points={{-64.4,-9.8},{-64.4,-38},{-64,-38},{-126,-38},{-126,10},{-109,10}}, color={0,0,127}));
  connect(generator.PELEC, turbine.PELEC) annotation (Line(points={{-69.2,-5.2},{-68,-5.2},{-68,-28},{-122,-28},{-122,0.1},{-108.9,0.1}}, color={0,0,127}));
  connect(const.y, turbine.FSR) annotation (Line(points={{-131.2,-10},{-109.1,-10},{-109.1,-10.1}}, color={0,0,127}));
  annotation (
    Diagram(graphics={Text(
          extent={{-112,68},{108,48}},
          lineColor={0,0,0},
          lineThickness=1,
          fillPattern=FillPattern.Solid,
          fontSize=15,
          textStyle={TextStyle.Bold},
          textString="(Constant Efd)")}),
    experiment(StopTime=100, __Dymola_NumberOfIntervals=5000),
    __Dymola_experimentSetupOutput);
end SMIB_TurbNoGov;
