Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.21
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986737;
	b=ghCyFXzIjbIxrH0E6keZekKbiQo9lQ/6E0wjSmLQtnIlwYZqVGayCj32nvh8QvGyFyvL
	 7KJLfM4LPWaxFmhwe1JT6XpOi6ue2J34H6vExfXkprxXP8m2cfzLtcFMp8+ssmN4keYrn
	 VOYHDnNbLnvqA3jGn/IqMb+qzx3Usth0TQiP8rGO0Zu8Jvoet+vZxQ4uqiKUmZ2AX/uuj
	 0kC8c7e45+7BhROzQXuAplLOcf9r/+hjjCc4yWfh7Dtp3/5Ln2uPujiPyeRHoK8uLGYFS
	 hKW/eVSWpJ5mT7TU0z5yaCXsCumKl8qB6SmK/d22vzmFONR3m9zApsAoc/hHJfzlhuQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986737;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-ID:References:In-Reply-To:To:CC:
	 X-Mailer:X-Originating-IP:X-ClientProxiedBy:X-EOPAttributedMessage:
	 X-MS-PublicTrafficType:X-MS-TrafficTypeDiagnostic:
	 X-MS-Office365-Filtering-Correlation-Id:X-MS-Exchange-SenderADCheck:
	 X-MS-Exchange-AntiSpam-Relay:X-Microsoft-Antispam:
	 X-Microsoft-Antispam-Message-Info:X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=asorqRa/c8wiZ9bEGROrJ28aIUYuW/8mS29K6uEtOVc=;
	b=XjdNajTJ7lNnklHNA7n/IDUkVJGymjnnh3uYS6kIda5oI1b9SgJeQoFJ30kRrU0F9dpe
	 UunOAWhAbVaCDE8XbDQyeWd/vMK3E2WG1tRe3ykXiSX1SUD/dK7xIVm1RfSt7cKdULUqO
	 G4aQ4bURFfgig/ZwLB0QFFaLsp8da0qy1S534X7n9t/jyn+e6Rcym4VBQNVehfVsJt3Xy
	 MDVRzbKcmN+Oh2N/JxK+REjweG5rkr4U8n6mada+SoJiWKzcEDawaYtwsJ+HXpeKKgHwp
	 9s7JVteRCftQ5Mblc5uRsmN31zHgnUrMCJFH1zyMeJsJIkXwR0XcTX/Lw4IT+iyEnrw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=MvV3odTr;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.84.21
Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010021.outbound.protection.outlook.com [52.101.84.21])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA837606A337;
	Fri,  6 Nov 2026 17:38:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DA837606A337
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=MvV3odTr
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iPu089X8oeThwEtV3AR8i56DIWd9WPY2QnDbZhxdZknGG9f4GboSHJ1yKr024/9rhXOkpWBiZjYBGlnXzTN1spkQopCD/Z+ifZyMPlAl2dCo3TEH/Iky+zDqAy1P/XO7/bS5GWIf/aTI7JUX0r9eXikwmPoxpjMRKTFMPXGDIgd+72QoQIDr0FbMrfUwkWLARhzxEEL4KHVJ4dK4stYGSUTsrKoL61ixl2FKwqtQLYLUzbWWY+qXLyx8LDCD/xgeyIRf/6dEeo0PpwrUzCAAggqQUfy9YImSvP8xLqf33ztbF0fwVNWtCV9j5UE95upzN3DXF/7HB4jbIpBIc9BLhA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=asorqRa/c8wiZ9bEGROrJ28aIUYuW/8mS29K6uEtOVc=;
 b=wpRhIvCokS6Y74X0E0qdj17aqTG+7HjvbifYKDPrwRT8pPyy1NWIbDTjxnUGfNKtSpO08CLAEGnEDgjbf97OnYI6xvRBBeU1yn1I/Y3Q5wWa0is9yFmMxYGak70OBavtaZuIXGy8+U2D7bgx8tlO6XceBvqFsN5ibv8SIU/T1x4TmU0QxlZlGvrBoGJnRwv1wnlATeaZOD32ksmwzH+Fmnh5mj64ChvDvT86TIlZqQap1ZNXC6/RrkIE+PiutR2p7Y264oJilCi+2mq9k1D9d1L3mnLTyTXD75Tc+hDrK4hd/wi5jlf04WdMYCJYrQ5S8va4Sj9d0xV03wBaxlB1qQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=asorqRa/c8wiZ9bEGROrJ28aIUYuW/8mS29K6uEtOVc=;
 b=MvV3odTrDF17mfZJ/m42gZ0Vl0Uwbgl0oSYkajtqoXGazaxupBUi0ThNG38YyQTR3zRtGFPzrCX3g/+hXRABM+rHn+Aw25P0WvSNnRxGN0kkQAubAbIE4WGDbMi3wzjXrJ057jmxf+Zvdkmf+D2p1WnzPdAg+fkHJ7YSX4uArbt4Vbf0XH5RwJMDCmgylMAR026o0InBe03rnqnSvPyjAI/11/2w+gqZBe8Ue3ECiCEdwF4PTeDg8EE7uJ9/emo2f/R9mXR4HbloahwxVBrqPYxKoosLRPZ3zdePV8g62O7oVvYchohhTBz/b2SzY8FgvZYWHfuZ4H57A6zHVlSwdw==
Received: from DU6P191CA0005.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:540::18)
 by GVXPR10MB8276.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:11b::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 17:38:50 +0000
Received: from DB1PEPF000509E8.eurprd03.prod.outlook.com
 (2603:10a6:10:540:cafe::a3) by DU6P191CA0005.outlook.office365.com
 (2603:10a6:10:540::18) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 17:38:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509E8.mail.protection.outlook.com (10.167.242.58) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 17:38:50 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:39:08 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:38:37 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 6 Nov 2026 18:38:25 +0100
Subject: [PATCH v3 5/6] usb: dwc2: hcd: don't disable/enable external vbus
 by system suspend/resume
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261106-dwc2-low-power-fixes-stm32-v3-5-68d2a0e9bab6@foss.st.com>
References: <20261106-dwc2-low-power-fixes-stm32-v3-0-68d2a0e9bab6@foss.st.com>
In-Reply-To: <20261106-dwc2-low-power-fixes-stm32-v3-0-68d2a0e9bab6@foss.st.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Douglas Anderson <dianders@chromium.org>,
	Stefan Wahren <wahrenst@gmx.net>, Artur Petrosyan
	<Arthur.Petrosyan@synopsys.com>, Amelie Delaunay
	<amelie.delaunay@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Jisheng Zhang <jszhang@kernel.org>, Felipe Balbi <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DB1PEPF000509E8:EE_|GVXPR10MB8276:EE_
X-MS-Office365-Filtering-Correlation-Id: 81923a48-3d55-48ce-ec8e-08df3c2cd1b8
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|7416014|376014|1800799024|82310400026|36860700016|261026121527099003|5023799004|261026140227099003|11063799006|261028144727099003|56012099006|261021123027099003|261022105027099003|261102123227099003|261022075727099003|261021121427099003|261009223027099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	4Cu7aa5s/KdxpGBJep0m4EpZ2FUXeKFUskP0Bi00yH5NGcTMUu+FeNkVxSXqQIe91lJGNC111NEf/s+ja0npMoGBaoMFbqh+01COMz1Ca50Yd7JPnDyQ8+G1o8VEckTylPbbM/ATzYUT7ILkn4J/kjFosNgYha3hcWifFHuQxxEJkTidOlYZ0NkDTiEbr4KUC7ZR8lW30DERc4HU3pHYypOcoIiV0e9TdwIzqJhJgVT6z6m508rIjGKFHUbsgMDo6bBszruSFqTSiwkxgP4bsDMyBgqw+Z76l53StaHsDgTKFtP6C/7+s00MEfL3L+yWJdZTO3JI8aBqNFm5ek11GCN55h4RplaR8D6DrfBSnVJbJAm/wdU8Va9oUiBTBXU9f9rblQxUpuplY9tOnKxh6hcCt2blXrX/WDQUuqMoI/hSM6TGHnb4z7QAKd6H1zOVPIDAowshU3Dp7pRzoMf5hNoMkzbRlACtKRT/ggcrMrRIL/iqeDHk5Z5dTL9M6O87aiRtJ/v8B2AGqSxoaKQFEWwtB8WtT+kyyXaBwMHEiLbVhhrWUjqJU6KChLrr2xBfg1n8B121XzmD+VZUobksVyN/42M24nACFUHBrHHCTj9CFbvoY+kN3slQjt3q8Hz0VIXhGda30RCORE0l0CumX3eb/c/A7alif3vMwXJ+hSRtKn/nbB2Lk9DkO8QIWHnqOXPhrLXVNaiEkBg1lewRYQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(7416014)(376014)(1800799024)(82310400026)(36860700016)(261026121527099003)(5023799004)(261026140227099003)(11063799006)(261028144727099003)(56012099006)(261021123027099003)(261022105027099003)(261102123227099003)(261022075727099003)(261021121427099003)(261009223027099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	7VJ/keE8sd9wg5W/hDMWkErHK3n82e9WevDLWkuHwKDCvO+6ni5kbXohHRbZ5Z9qVW9oorzhpZBBgl6i+GMqN/GC8/mBhw715I0C4GWZ3U2Wb6gDqRuOwcsO+0UeHFQljHq/2brj5CdMo1MFYoPm+RGm/j6yuyKbhYPvfLsc8BtJLwREEe+HNPyBj0zDaxajLJVLGQ4dbmFHCilvTPbdWwqKwHUtS5nT5uu3wefejAC+MIqG5uQ5LvWx8cL4GD1RU/ntfHyA4SpQfj/hpVRnIrh5OwfA5b7FsdYLUhPiYQaxc71uNB7lcU7AFXNNPuPMqIM2SVTE/1S11CZ6RsPDHqnQIMu8AlMXGf6w/N9INSuJEUTaxrGHM6f9PsXEE7lyj7Clv06Fx2Z6bpLYl5eSYwifb1FmWKaDIPouFg+A3JTg8aKPGI/YvUWRNbFJR/fZ
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:38:50.3517
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 81923a48-3d55-48ce-ec8e-08df3c2cd1b8
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509E8.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GVXPR10MB8276

It's not required to remove port power upon system suspend, as explained
in commit 113f86d0c302 ("usb: dwc2: Update partial power down entering by
system suspend"). It can be addressed with hub ctrl (USB_PORT_FEAT_POWER).

PM suspend flow doesn't disable vbus while in host mode (neither by
clearing HPRT0_PWR nor by calling dwc2_vbus_supply_exit()). In sequence:
- dwc2_port_suspend() - enters clock gating (set lx_state to DWC2_L2)
- _dwc2_hcd_suspend() - nothing more to do as already in L2.

PM resume flow after wakeup (two cases as registers may have been lost)
- _dwc2_hcd_resume() - checks HPRT0_CONNSTS
1 - if set (registers not lost) - nothing more to do.
  - followed by dwc2_port_resume() - exits clock gating (sets lx_state to
    DWC2_L0)
2 - if NOT set - exits clock gating, re-initializes the controller,
    restores HPRT0_PWR and calls dwc2_vbus_supply_init() unbalanced.

For the 2nd case, it's unbalanced / enabled each time it happens: the
vbus regulator enable count constantly increase. As a result, vbus
won't be turned off in case the role changes later to device mode.

So remove the disable/enable of external vbus in bus suspend/resume
routines to avoid this. Moreover, setting/restoring HPRT0_PWR for the
2nd case will simply make the vbus regulator enable count to be aligned
with it.

Fixes: 113f86d0c302 ("usb: dwc2: Update partial power down entering by system suspend")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- Sashiko comment (state desync leaves VBUS regulator permanently off)
  Add a dwc2_vbus_supply_restore() to check regulator enable state
  during hcd resume, if it has been turned off earlier, enable it,
  so it is kept sync'ed with PWR bit that gets set.

Changes in v2:
- rephrase commit message since Sashiko review. Hopefully it better
  explains the issue, and why HPRT0_PWR is kept synchronized with
  external vbus supply.
---
 drivers/usb/dwc2/hcd.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index cae9d7e13d47..54e3b5698642 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -147,6 +147,20 @@ static int dwc2_vbus_supply_exit(struct dwc2_hsotg *hsotg)
 	return 0;
 }
 
+static int dwc2_vbus_supply_restore(struct dwc2_hsotg *hsotg)
+{
+	int ret;
+
+	if (!hsotg->vbus_supply)
+		return 0;
+
+	ret = regulator_is_enabled(hsotg->vbus_supply);
+	if (!ret)
+		return regulator_enable(hsotg->vbus_supply);
+
+	return ret < 0 ? ret : 0;
+}
+
 /**
  * dwc2_enable_host_interrupts() - Enables the Host mode interrupts
  *
@@ -4388,10 +4402,6 @@ static int _dwc2_hcd_suspend(struct usb_hcd *hcd)
 		goto skip_power_saving;
 	}
 
-	spin_unlock_irqrestore(&hsotg->lock, flags);
-	dwc2_vbus_supply_exit(hsotg);
-	spin_lock_irqsave(&hsotg->lock, flags);
-
 	/* Ask phy to be suspended */
 	if (!IS_ERR_OR_NULL(hsotg->uphy)) {
 		spin_unlock_irqrestore(&hsotg->lock, flags);
@@ -4500,9 +4510,14 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
 		spin_lock_irqsave(&hsotg->lock, flags);
 	}
 
-	/* Enable external vbus supply after resuming the port. */
 	spin_unlock_irqrestore(&hsotg->lock, flags);
-	dwc2_vbus_supply_init(hsotg);
+	/*
+	 * Restore external vbus supply after resuming the port.
+	 * Keeps vbus_supply in sync with HPRT0_PWR set here after.
+	 */
+	ret = dwc2_vbus_supply_restore(hsotg);
+	if (ret)
+		return ret;
 
 	/* Wait for controller to correctly update D+/D- level */
 	usleep_range(3000, 5000);

-- 
2.43.0

