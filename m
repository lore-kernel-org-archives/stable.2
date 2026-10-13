Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013037.outbound.protection.outlook.com [40.107.159.37])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3EDB50EBEB;
	Tue, 13 Oct 2026 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.159.37
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897368; cv=fail; b=DXm2UkWKX8/Dw+tPct5wThHxXmaPaSUkNGFU6esH07y41k+Cl267yT25dhf+8RBi3HBlYBGUWZleYowqwvhc2cmm0K814p15MP47UrtztL8sd4n8+9ynxrnMo49HvUY4kbwX87t3qWFGbDCWCjFHZO4amqOnEeLMje6jAyAWyr4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897368; c=relaxed/simple;
	bh=h1q3I3+5mooTzWhMa2YxVpRPZ4W+F/g3XB6YVaqD1IM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=RYp3Q+pykYs1++o5Y4CNYbANQkNTHIf8UcIbZ5fJi955iIdR9V1mM1I6hTuzLsw84xXUwEXzVxr6AQbGJX2bQTcaWoOKD1IyeSEH8tu6JelXjDP7gTuSZWhpzKNbo5VGQuDVSczh+kPJTGEHmke5to9VgbLZGOam3okAjzm6rGY=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=XSHZsNqZ; arc=fail smtp.client-ip=40.107.159.37
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="XSHZsNqZ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=colhOiCHrxEcwqsdLG237G5GlvRabBSD+dKSJTSon9UFnmjVnoYwsibVF5wuNxtrF+E8XB+i+FC2YhLWN7CjXHpVefjZmAiZUCxelJsd7CLuQX9HNK+8q+V4Aw4ixicyGAbp2IjFES4mQfQhZC7xGK50wlzhgdjDY6M08I1VnSr64C6b0+mt1Nml5tYZUFZJ1z3LvrBZeQH1yTLiS7H6Z6r1jXj05po1Ly6xIQnmxE0jIFQe+QZnCk5q6QLZ4EQ+lrJyhJdF4kU6Kdg3OTHa9HI5wNrrQ0uOrAxPkk75BKJnfUgG9oT/Ss6cP7Oi1bkpFmRmca0nuaRd6bx5MXfvAg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=huG7AdoRHK1aDsX1tIwewG6+vqCERgX8vCRl2a0Hqhk=;
 b=xClomG8z3khh7ubc8kySxUr5Qd5T45b1h+o9kYzVdGhqfgTPoRqyjdjqJiijeApvdB2wNq2XAiMQrhUt8bj2lCR9eIsRT+PFuEDoRf2ZypE3AfNaOoWuXOlPUs9Z1zFfQtySPJGaEVe2zbNOx1/UYKHI5eojCxq8F0YnZd7p0kuHs4PWIfG+ey7XGAs3dIN9Li6Sa9KkmchNOy6t3tl/45p5lN+7mvk9OxHzO3NowXIQ8AFqg8kqYswIt/hVE4EUD8EdNuwX90lZ35yqIc1/W+xqg2BuWojs6r8aZ7q6YX/Cm69XqOIBG/o0e0N5sqgwSysOCQ47B6rYSF2L9LE66g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=huG7AdoRHK1aDsX1tIwewG6+vqCERgX8vCRl2a0Hqhk=;
 b=XSHZsNqZMmYg0UVJPc757+MdxnCPoeRsiugG3jSWSFRB/yjlKDmmgjiI8SnlyPMIyAcwnQstWSbQCKUOamhHXmSrXDlBlvfUoQmezLXMKtzkTCZpQrBvudL1DTU5WWmvGMFrqjFqmpfkHXKr+ruqP6QLPZ9oLTvQaKDnXdaX0f7/zVm8g0dKRvGPhhiCawulhKVD/W1ippAz+ZO48Rk0OIwjOkZMmnXGeexPWJc3y1MGs2AX1gPyPurDa1JFov2QXouTTa4KfWJUwncmmFvkBUO6xcbYv8EFzu4GhvvuoEp22NrzRCD8n9sPxUeX3/WYMUV/o7nV+BqDYVsK4RQ8ew==
Received: from AS9PR0301CA0041.eurprd03.prod.outlook.com
 (2603:10a6:20b:469::32) by PR3PR10MB3884.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:102:28::21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.12; Tue, 13 Oct
 2026 13:16:00 +0000
Received: from AMS1EPF00000099.eurprd02.prod.outlook.com
 (2603:10a6:20b:469:cafe::82) by AS9PR0301CA0041.outlook.office365.com
 (2603:10a6:20b:469::32) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 13:16:00 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF00000099.mail.protection.outlook.com (10.167.242.70) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 13:15:59 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 15:16:25 +0200
Received: from localhost (10.252.6.143) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 15:15:58 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 13 Oct 2026 15:15:09 +0200
Subject: [PATCH v2 5/5] usb: dwc2: platform: fix stm32mp15 detection logic
 power management
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261013-dwc2-low-power-fixes-stm32-v2-5-79865a4f1b63@foss.st.com>
References: <20261013-dwc2-low-power-fixes-stm32-v2-0-79865a4f1b63@foss.st.com>
In-Reply-To: <20261013-dwc2-low-power-fixes-stm32-v2-0-79865a4f1b63@foss.st.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Douglas Anderson <dianders@chromium.org>,
	Stefan Wahren <wahrenst@gmx.net>, Artur Petrosyan
	<Arthur.Petrosyan@synopsys.com>, Amelie Delaunay
	<amelie.delaunay@foss.st.com>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
	Jisheng Zhang <jszhang@kernel.org>, Felipe Balbi <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS1EPF00000099:EE_|PR3PR10MB3884:EE_
X-MS-Office365-Filtering-Correlation-Id: 333db1e4-6076-4ffa-21b5-08df292c1f69
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|7416014|36860700016|376014|82310400026|1800799024|23010399003|34020700016|6133799003|18002099003|22082099003|10067099003|3023799007|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	9p/R2mqLpGE5GkaL16r70GkE3/qN7pj9c60U0BHUlIzu9WCR8wordUzxOa9fZVaXpUu/5f95uk8vG5mvpq5MyLPAovPVz5OoFaIY8bgHLOHfLM8cTVDDmWFeZGWihveGREn8eR+uTv3obYUn3McRb4Oybtvn2jb8W4gL1txxH3VOrRpTOt/zMTPT9Lz8iliCqAcqbTM36l4ryA10PWNf0sfL6QhTHOci25obMluOKLYKAMgYfU4GOe6SuFb4ql5qAq7uBXYAyCwKYdZIL2shraMSk+ATryhYv4YQpX0qIiXWDsjOkM/dquPJY/OK18Wcol5CbAq09iynho0y0s/dxofCHMlEr1pDdh+OHh4ZhKGyRNv+ZTmYUyS1c0lEZi7JEZU181tBSWwFXsRz4gKAiP3bTXqwrzNs0itqerE541FC4ToY3h3ExbkLcE+1fAVXAGiFmvLcYxm2Ju/dP3N249L8wKMvVWkIurhNKge/O+P3hCpXdLmoB6LpKPFE6EZhrsbiRSPaljeCopFxi/A1KLT6ANHMN1aiEfUclQzHo5W1CPVsbn2I1jWlDD9nQ5iyCJA4Db5C3a8clZ0HLEdgFTALqnHShTI8sZFrQkGHIIDBaX/v/W6FgmdtaL0VaeT2mB+4gGlXPh6DIW/cBTuU3NqiIyhw1tokd/XajVcRKAgs/YnEUUNJhyJrmbu0eQJn2/S2oVViCJjSBTZ3PWTOFQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(7416014)(36860700016)(376014)(82310400026)(1800799024)(23010399003)(34020700016)(6133799003)(18002099003)(22082099003)(10067099003)(3023799007)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Goq2dj+Iwb/2sGotEt+hQufQFFcbBJs8l1EfYmKfboGzu68wRaMQA3PU1ZzFvSgv55jlVBtHAvVw6BM3mN+pftXbffP4hSkZPlNV4Fsq/2Zko8PmSdS9azKIZjRBL4K49mza0gtBIX3GBNAnUbVEmKnSf2rNNwzwlCwWC3ChlljzLV1DZvM2ONJDhqOug+7AukgixMRcBjR4Th/fMQyFjNUroqsulWykADBvlHNk5NEYueAR1yoCA/Ad2/Z2W9cMUy8vaPBfIHkXg4Sh8a4Yr0wC9hzfK6E1END+qCV7Koyw42Ceu0LSPy9FpYVww3Ym47oDdhOiBhod3EaN7LQWaShh5ogtFaTTtpcGzmDTVlUOVqBUF4XTRGrrtzRK1GJK3JZXPnLLA+ftVr8AVuOQmHwaigUtomb4ZzhGUDvssC0NavNXCzI3xlG848UwMBoz
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:15:59.1364
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 333db1e4-6076-4ffa-21b5-08df292c1f69
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF00000099.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3884

On stm32mp15, the stm detection logic can be left enabled even though the
other hw resources gets disabled from the probe (peripheral mode only):
	/* Gadget code manages lowlevel hw on its own */
	if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
		dwc2_lowlevel_hw_disable(hsotg);

Then when going to system low power, stm detection logic resources now
remains enabled since dwc2_suspend() checks:
	if (!dwc2->ll_hw_enabled)
		return 0;

In case the stm32mp15 goes standby, the registers contents gets lost
and may not be restored so dwc2 becomes unusable. This is the case when
no gadget driver has been bound until that point.

So move the stm detection logic enable/disable procedures to dedicated
dwc2_stm32_hw_[enable/disable] routines. Call these routines
from the __dwc2_lowlevel_hw_[enable/disable] routines.

Factorize some of the probing code. Replace regulator_enable() and
GGPIO register poking by direct call to dwc2_stm32_hw_enable().
The dwc2_lowlevel_hw_enable() call done earlier during probing isn't
able to do it: the activate_stm_id_vb_detection is only known after
the dwc2_init_params() has run (and probe the usb33d-supply).

In __dwc2_lowlevel_hw_disable() in case the dwc2_stm32_hw_disable() fails,
return the error, without disabling other HW resources to avoid possible
inconsistent state (e.g. usb33d supply not disabled, so other resources
are kept in the same state).

Fixes: 2b94b054ac49 ("usb: dwc2: fix hang during suspend if set as peripheral")
Fixes: a415083a11cc ("usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- fix probe error path in case devm_regulator_get or dwc2_stm32_hw_enable
  fails as raised by Sashiko. Clear activate_stm_id_vb_detection flag so
  the dwc2_stm32_hw_disable() routine won't call regulator_disable()
  respectively with the ERR_PTR returned or unbalanced.
- update commit message to describe error handling on HW disable.
---
 drivers/usb/dwc2/platform.c | 173 +++++++++++++++++++++++++-------------------
 1 file changed, 98 insertions(+), 75 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 5aa552672078..5841efef6b35 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -91,6 +91,80 @@ static int dwc2_get_dr_mode(struct dwc2_hsotg *hsotg)
 	return 0;
 }
 
+static int dwc2_stm32_hw_enable(struct dwc2_hsotg *hsotg)
+{
+	unsigned long flags;
+	u32 ggpio, gotgctl;
+	int ret;
+
+	/* params are only known, once dwc2_init_params() has been probed */
+	if (!hsotg->params.activate_stm_id_vb_detection)
+		return 0;
+
+	ret = regulator_enable(hsotg->usb33d);
+	if (ret)
+		return ret;
+
+	ggpio = dwc2_readl(hsotg, GGPIO);
+	ggpio |= GGPIO_STM32_OTG_GCCFG_IDEN;
+	ggpio |= GGPIO_STM32_OTG_GCCFG_VBDEN;
+	dwc2_writel(hsotg, ggpio, GGPIO);
+
+	/* ID/VBUS detection startup time */
+	usleep_range(5000, 7000);
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	/* Remove overrides when resuming from the disable */
+	gotgctl = dwc2_readl(hsotg, GOTGCTL);
+	gotgctl &= ~GOTGCTL_DBNCE_FLTR_BYPASS;
+	gotgctl &= ~(GOTGCTL_BVALOEN | GOTGCTL_AVALOEN |
+		     GOTGCTL_BVALOVAL | GOTGCTL_AVALOVAL);
+	dwc2_writel(hsotg, gotgctl, GOTGCTL);
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+
+	return 0;
+}
+
+static int dwc2_stm32_hw_disable(struct dwc2_hsotg *hsotg)
+{
+	unsigned long flags;
+	u32 ggpio, gotgctl;
+	int ret;
+
+	if (!hsotg->params.activate_stm_id_vb_detection)
+		return 0;
+
+	/*
+	 * Need to force the mode to the current mode to avoid Mode
+	 * Mismatch Interrupt when ID detection will be disabled.
+	 */
+	dwc2_force_mode(hsotg, !dwc2_is_device_mode(hsotg));
+
+	spin_lock_irqsave(&hsotg->lock, flags);
+	gotgctl = dwc2_readl(hsotg, GOTGCTL);
+	/* bypass debounce filter, enable overrides */
+	gotgctl |= GOTGCTL_DBNCE_FLTR_BYPASS;
+	gotgctl |= GOTGCTL_BVALOEN | GOTGCTL_AVALOEN;
+	/* Force A / B session if needed */
+	if (gotgctl & GOTGCTL_ASESVLD)
+		gotgctl |= GOTGCTL_AVALOVAL;
+	if (gotgctl & GOTGCTL_BSESVLD)
+		gotgctl |= GOTGCTL_BVALOVAL;
+	dwc2_writel(hsotg, gotgctl, GOTGCTL);
+	spin_unlock_irqrestore(&hsotg->lock, flags);
+
+	ggpio = dwc2_readl(hsotg, GGPIO);
+	ggpio &= ~GGPIO_STM32_OTG_GCCFG_IDEN;
+	ggpio &= ~GGPIO_STM32_OTG_GCCFG_VBDEN;
+	dwc2_writel(hsotg, ggpio, GGPIO);
+
+	ret = regulator_disable(hsotg->usb33d);
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
 static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 {
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
@@ -129,8 +203,22 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 	if (ret)
 		goto err_dis_clk;
 
+	ret = dwc2_stm32_hw_enable(hsotg);
+	if (ret)
+		goto err_dis_phy;
+
 	return 0;
 
+err_dis_phy:
+	if (hsotg->uphy) {
+		usb_phy_shutdown(hsotg->uphy);
+	} else if (hsotg->plat && hsotg->plat->phy_exit) {
+		hsotg->plat->phy_exit(pdev, hsotg->plat->phy_type);
+	} else {
+		phy_power_off(hsotg->phy);
+		phy_exit(hsotg->phy);
+	}
+
 err_dis_clk:
 	if (hsotg->clk)
 		clk_disable_unprepare(hsotg->clk);
@@ -166,6 +254,10 @@ static int __dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
 	int ret = 0;
 
+	ret = dwc2_stm32_hw_disable(hsotg);
+	if (ret)
+		return ret;
+
 	if (hsotg->uphy) {
 		usb_phy_shutdown(hsotg->uphy);
 	} else if (hsotg->plat && hsotg->plat->phy_exit) {
@@ -346,9 +438,6 @@ static void dwc2_driver_remove(struct platform_device *dev)
 
 	dwc2_drd_exit(hsotg);
 
-	if (hsotg->params.activate_stm_id_vb_detection)
-		regulator_disable(hsotg->usb33d);
-
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
 }
@@ -541,33 +630,26 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		goto error;
 
 	if (hsotg->params.activate_stm_id_vb_detection) {
-		u32 ggpio;
-
 		hsotg->usb33d = devm_regulator_get(hsotg->dev, "usb33d");
 		if (IS_ERR(hsotg->usb33d)) {
 			retval = PTR_ERR(hsotg->usb33d);
+			/* skips low level dwc2_stm32_hw_disable() in case of error */
+			hsotg->params.activate_stm_id_vb_detection = 0;
 			dev_err_probe(hsotg->dev, retval, "failed to request usb33d supply\n");
 			goto error;
 		}
-		retval = regulator_enable(hsotg->usb33d);
+		retval = dwc2_stm32_hw_enable(hsotg);
 		if (retval) {
-			dev_err_probe(hsotg->dev, retval, "failed to enable usb33d supply\n");
+			hsotg->params.activate_stm_id_vb_detection = 0;
+			dev_err_probe(hsotg->dev, retval, "dwc2_stm32_hw_enable failed\n");
 			goto error;
 		}
-
-		ggpio = dwc2_readl(hsotg, GGPIO);
-		ggpio |= GGPIO_STM32_OTG_GCCFG_IDEN;
-		ggpio |= GGPIO_STM32_OTG_GCCFG_VBDEN;
-		dwc2_writel(hsotg, ggpio, GGPIO);
-
-		/* ID/VBUS detection startup time */
-		usleep_range(5000, 7000);
 	}
 
 	retval = dwc2_drd_init(hsotg);
 	if (retval) {
 		dev_err_probe(hsotg->dev, retval, "failed to initialize dual-role\n");
-		goto error_init;
+		goto error;
 	}
 
 	if (hsotg->dr_mode != USB_DR_MODE_HOST) {
@@ -637,9 +719,6 @@ static int dwc2_driver_probe(struct platform_device *dev)
 error_drd:
 	dwc2_drd_exit(hsotg);
 
-error_init:
-	if (hsotg->params.activate_stm_id_vb_detection)
-		regulator_disable(hsotg->usb33d);
 error:
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
@@ -661,37 +740,6 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 
 	dwc2_drd_suspend(dwc2);
 
-	if (dwc2->params.activate_stm_id_vb_detection) {
-		unsigned long flags;
-		u32 ggpio, gotgctl;
-
-		/*
-		 * Need to force the mode to the current mode to avoid Mode
-		 * Mismatch Interrupt when ID detection will be disabled.
-		 */
-		dwc2_force_mode(dwc2, !is_device_mode);
-
-		spin_lock_irqsave(&dwc2->lock, flags);
-		gotgctl = dwc2_readl(dwc2, GOTGCTL);
-		/* bypass debounce filter, enable overrides */
-		gotgctl |= GOTGCTL_DBNCE_FLTR_BYPASS;
-		gotgctl |= GOTGCTL_BVALOEN | GOTGCTL_AVALOEN;
-		/* Force A / B session if needed */
-		if (gotgctl & GOTGCTL_ASESVLD)
-			gotgctl |= GOTGCTL_AVALOVAL;
-		if (gotgctl & GOTGCTL_BSESVLD)
-			gotgctl |= GOTGCTL_BVALOVAL;
-		dwc2_writel(dwc2, gotgctl, GOTGCTL);
-		spin_unlock_irqrestore(&dwc2->lock, flags);
-
-		ggpio = dwc2_readl(dwc2, GGPIO);
-		ggpio &= ~GGPIO_STM32_OTG_GCCFG_IDEN;
-		ggpio &= ~GGPIO_STM32_OTG_GCCFG_VBDEN;
-		dwc2_writel(dwc2, ggpio, GGPIO);
-
-		regulator_disable(dwc2->usb33d);
-	}
-
 	if (dwc2->ll_hw_enabled &&
 	    (is_device_mode || dwc2_host_can_poweroff_phy(dwc2))) {
 		ret = __dwc2_lowlevel_hw_disable(dwc2);
@@ -716,31 +764,6 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 	}
 	dwc2->phy_off_for_suspend = false;
 
-	if (dwc2->params.activate_stm_id_vb_detection) {
-		unsigned long flags;
-		u32 ggpio, gotgctl;
-
-		ret = regulator_enable(dwc2->usb33d);
-		if (ret)
-			return ret;
-
-		ggpio = dwc2_readl(dwc2, GGPIO);
-		ggpio |= GGPIO_STM32_OTG_GCCFG_IDEN;
-		ggpio |= GGPIO_STM32_OTG_GCCFG_VBDEN;
-		dwc2_writel(dwc2, ggpio, GGPIO);
-
-		/* ID/VBUS detection startup time */
-		usleep_range(5000, 7000);
-
-		spin_lock_irqsave(&dwc2->lock, flags);
-		gotgctl = dwc2_readl(dwc2, GOTGCTL);
-		gotgctl &= ~GOTGCTL_DBNCE_FLTR_BYPASS;
-		gotgctl &= ~(GOTGCTL_BVALOEN | GOTGCTL_AVALOEN |
-			     GOTGCTL_BVALOVAL | GOTGCTL_AVALOVAL);
-		dwc2_writel(dwc2, gotgctl, GOTGCTL);
-		spin_unlock_irqrestore(&dwc2->lock, flags);
-	}
-
 	if (!dwc2->role_sw) {
 		/* Need to restore FORCEDEVMODE/FORCEHOSTMODE */
 		dwc2_force_dr_mode(dwc2);

-- 
2.43.0

