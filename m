Received: from AS8PR04CU009.outbound.protection.outlook.com (mail-westeuropeazon11011015.outbound.protection.outlook.com [52.101.70.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A6B74ABBA8;
	Thu,  8 Oct 2026 13:34:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.70.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466474; cv=fail; b=cN0xIg/NUNb0lTbE5EmSqr4Ew1rETTsyRCgsT+UpClPgkDIduOeg8x1tYHHtRgEGa+0Nh7wDoRk8YUDw9kqKx2UPK/ExS2FF+leCAiTf3tRrmZ5w5CWbBnAxL04X/l9bFnCno4z45Odt4xjYDWvZt2bTAM/qtRshhoOvAYxYZIU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466474; c=relaxed/simple;
	bh=+mtwBry7Ak4KaFiihDoG1IFTHD04dipXYQuoxeFbnpI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=O8EO7qjoWapbja8lTMp1yNQybiLU5b8pZeY40n+PTGxxWnG1EnweAE4hz/yVvj4XzZj3FaLEQlfKjvF9y8bqWGz94VH8vMSMwdAyhjaxBz8twM6EdrbrSZsY846ltSsghtvJIxJGmP/uHLnqtzXGRNh/V/dOCcI3/srqE7edhe0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=GCOjnOws; arc=fail smtp.client-ip=52.101.70.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="GCOjnOws"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=x6WbndL0FFVTDkzhD7k/e2HlDf2apwsjkSYnVYjgCSfSTkEbJ0q49NW7yYIeUhVn765XVn/zKWU16zalAugguE7PNo+Zbp/hpJuDCOkMBA+mBhV8dzOTFX0h+cd1+NG1IDgn7/dSLHDGhbkFN7v56RiwL19mj8HV8cBs7uP4/z7UCy1CZSah0LUvphA3VzrIgPpLkoitANu2gq5pG5Gt3TQY7wGW7fg/M8eu2aN6HxzsfvtoPzTrTJPmyvkmHu0HbMa8lmg45P6kj8QEVbBF6DseJcCDYtMuQDSBFtSa90OJPcfLMYsU35shYqK8TQw2TbwkjGjF8EYNK1On5/r78w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NJX1D8mLcoH2hJ2hOBhaXxxl9RQBEN7Vey5U55NhBxo=;
 b=X5z+MqfY3+2nI5RZGXrVyPzLdv17fid/qsjkYZUHbglA2JGz4FHRWVEewPXiIaIH2YLeidJkVAd4EqYep68zDRmsS2Cs7FAMZSGKnE/X8b3E2m04+Jnr2yFbl+1vWbca568N1LvPCQIX0QY3ynqDkRmplUjarmzja0EOWjHvi76LR60+xR5z0oIWVAQcMU1CwbkpAbdBjVWHOrQE6mcKdCOYHNflLLGsW/8ipXEeMJ1vY5yxTaMNZrqIQnHDrG9QJ64LYHcg5PTWDxg/qXlwzOH019nRievGs6PVxmY2Zcp9p59kfRi+l9isEsSCV+17paYTkFkrr1lAL/UdrhAzOQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NJX1D8mLcoH2hJ2hOBhaXxxl9RQBEN7Vey5U55NhBxo=;
 b=GCOjnOwsOYc6gtTUXKdStboDE6N+BRIXUA3012OzbJxZCD8jSVObEXO7Gt0adGqGp47rrl7MY31zZwgLdT7D6lyY+Qv/oG+5wHoz6oRdOlxZlP2/dbA+FvBf3d92ApLfChKJX6h1YHHlaAxsgDbP++uYDHIZ5LIO0DnmU+yHSNjBt8KrX9oSWBmSqWHkERXyqDc38/7k8vrlclQ1wZ5uhL3Sfe+tWzHtCKmjfFlR7WpV/quRHPRj8LVRO8JyqLgqQDW2mYXMBX8FWb27kk1AbyqKBfnhY6X0HoxrR9YhbOdbKzCEOWefWbCPVbz/N9ob5XoZdYY6ijBfWgf/c0BZDg==
Received: from OS6P279CA0055.NORP279.PROD.OUTLOOK.COM (2603:10a6:e10:31::13)
 by AS4PR10MB5499.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:4fd::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.16; Thu, 8 Oct
 2026 13:34:26 +0000
Received: from WA1PEPF00009B38.eurprd05.prod.outlook.com
 (2603:10a6:e10:31:cafe::3e) by OS6P279CA0055.outlook.office365.com
 (2603:10a6:e10:31::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Thu, 8
 Oct 2026 13:34:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 WA1PEPF00009B38.mail.protection.outlook.com (10.167.242.37) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.496.14 via Frontend Transport; Thu, 8 Oct 2026 13:34:24 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 15:40:28 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 15:34:22 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Thu, 8 Oct 2026 15:33:21 +0200
Subject: [PATCH 5/5] usb: dwc2: platform: fix stm32mp15 detection logic
 power management
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261008-dwc2-low-power-fixes-stm32-v1-5-5b303df762e6@foss.st.com>
References: <20261008-dwc2-low-power-fixes-stm32-v1-0-5b303df762e6@foss.st.com>
In-Reply-To: <20261008-dwc2-low-power-fixes-stm32-v1-0-5b303df762e6@foss.st.com>
To: Minas Harutyunyan <hminas@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Douglas Anderson <dianders@chromium.org>,
	Stefan Wahren <wahrenst@gmx.net>, Artur Petrosyan
	<Arthur.Petrosyan@synopsys.com>, Amelie Delaunay <amelie.delaunay@st.com>,
	Fabrice Gasnier <fabrice.gasnier@st.com>, Felipe Balbi
	<felipe.balbi@linux.intel.com>, Jisheng Zhang <jszhang@kernel.org>, "Felipe
 Balbi" <balbi@kernel.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, Minas Harutyunyan
	<Minas.Harutyunyan@synopsys.com>, Fabrice Gasnier
	<fabrice.gasnier@foss.st.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B38:EE_|AS4PR10MB5499:EE_
X-MS-Office365-Filtering-Correlation-Id: 637aa020-a727-47dd-f506-08df2540ddee
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|7416014|23010399003|82310400026|36860700016|1800799024|10067099003|56012099006|3023799007|11063799006|18002099003|22082099003|921020;
X-Microsoft-Antispam-Message-Info:
	8d+8lkOSs09wTPngaOmDju82U/2fH1VwnF6McdfJosR2u+0racbtLVAr3NpAxuICtARHjAAPIj18M7OS6/f2uk5C+87HKefx92AIT/Lk5W02WwcAzNkNhp77OXkNUFqORWxPdQZcaCifVLZL8MS/ed/lD3QqwwDOpAIz4rCv0LyPbb8yED2yKQdXOLcbniNaFQqpNPSD0usssubJzO9WU5z8lUWhOcXVHeAdoqWVVOr4b1paj+95xNM0vpdlx5hwPeDxNwI+kBj0mRuLortFpupnG/kWSeOvOJutpp09ycugkFv61eFRos/LkAVyDCdGI7lJXMpc0Mt//ihbyQ3wvFFAyojrp034yjc3VqDcYhnZHyYAdiXXqu3a+S/TxNpZmHRPvmFJhAwwG3zh7ehybJN3n7y1Aadar0UpZdatvI2eEgvMIC8iECSqFfifDVQpwZeTy74TPmojLvbWY79EOwS0Y6TvJ0KDKdDUfqtXOqcXnA42bc6HT9ocXrfciSHtinXndxtAhOrDW8I4G4PacGyf/4/Yg4eiV7YDbjbEaCbuLPXfxT6UwtqWPw7WsdgVOtt2MzxvqyRDrrj1klCju5MLpzfO/FQ+sch4kanPNrlii/3m11MNwNPDkRxaLToRXP7WBeaWL9IretGwhxnw83P7f6XrSTkalZeR312ona7u3j1pM92K22zkKsbQg9bIfVkRcFqyvS9S7odmiNMZGbVKZ2SFz2ARYsfvI4MznYVHVmUR3LEvxnHEaHJ7JF4y
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(7416014)(23010399003)(82310400026)(36860700016)(1800799024)(10067099003)(56012099006)(3023799007)(11063799006)(18002099003)(22082099003)(921020);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	xeouenN3BMJLdaynFmuLKgvL6vTFsjpEcCDmqx0J9UbtyIyJrp1/crQUEOeBPIcEapOyZn6nWob4VW5WCkPXLhtr57voGh0J1BVnwkPcYsEyxGrVfZglUGqmaRhv51fJFlreo6A0mI41Q3LHWt9padYUw+NGdSCLZGMW22+znMbKZzq+YtRF4E4esPEWEc4Gumcls6NRtfy4fnc4fp0FCFaI8hwCQKdAVQL9b72avZVMslar2IGv9PGQSU9cPLtdJ2CfEJeRBcHaQWkDBztPNHFR+V6bIORbyWQrxY/lUHeIxJkTh1djQmRz7zatWBiOCfI6DgLOCvaIQRa+YLw+bsMYVUeOAmRBVtIRlE9SfcdaUePiWSmr8gblYtVGDm3pjkiqRlChKOnlCnYIUxjKKxGXMAt7JyNRmp8vY/rWF3srSsQPKMdvWmZoU6ssztui
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:34:24.0340
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 637aa020-a727-47dd-f506-08df2540ddee
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B38.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AS4PR10MB5499

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

Fixes: 2b94b054ac49 ("usb: dwc2: fix hang during suspend if set as peripheral")
Fixes: a415083a11cc ("usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/dwc2/platform.c | 170 +++++++++++++++++++++++++-------------------
 1 file changed, 95 insertions(+), 75 deletions(-)

diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 643d67ce28ea..ddab95b443a9 100644
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
@@ -541,33 +630,23 @@ static int dwc2_driver_probe(struct platform_device *dev)
 		goto error;
 
 	if (hsotg->params.activate_stm_id_vb_detection) {
-		u32 ggpio;
-
 		hsotg->usb33d = devm_regulator_get(hsotg->dev, "usb33d");
 		if (IS_ERR(hsotg->usb33d)) {
 			retval = PTR_ERR(hsotg->usb33d);
 			dev_err_probe(hsotg->dev, retval, "failed to request usb33d supply\n");
 			goto error;
 		}
-		retval = regulator_enable(hsotg->usb33d);
+		retval = dwc2_stm32_hw_enable(hsotg);
 		if (retval) {
-			dev_err_probe(hsotg->dev, retval, "failed to enable usb33d supply\n");
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
@@ -637,9 +716,6 @@ static int dwc2_driver_probe(struct platform_device *dev)
 error_drd:
 	dwc2_drd_exit(hsotg);
 
-error_init:
-	if (hsotg->params.activate_stm_id_vb_detection)
-		regulator_disable(hsotg->usb33d);
 error:
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
@@ -661,37 +737,6 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 
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
@@ -716,31 +761,6 @@ static int __maybe_unused dwc2_resume(struct device *dev)
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

