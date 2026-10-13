Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011024.outbound.protection.outlook.com [40.107.130.24])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 256DC50EBF3;
	Tue, 13 Oct 2026 13:16:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.130.24
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897367; cv=fail; b=PJWVFwE40miqOTKt3PKQGKY1ZjlyeEMvmDk22jXyiNBdVioJ4DwG0G5mWmXwTVIpFS8NNoT72cBOoyeIG+AiD9hI4JFi6yzOTSLAGvn7V8afLfACxm6Hz8FPrXStnDOfjwJLme+RQZeipaVHodFJArJ+6K1IqkyLIYpDvJePEBE=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897367; c=relaxed/simple;
	bh=sr0D+5ycf6LJt4Vbe9+1C+CjiEEUTWotd2/9bz5q6Fc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=WRDc8UBuUjYUgz1NPxfyWxJcrtfGHbYtkh6LwHGrzf+MhODXTy9dqYKzKw2HwqiDSMN31R8btizwo+pJdLOTbxgySWtZx4a0UU+/Vh51pdCXnhM7Eb8U4+3VXdZpUNWa1iU2ykzT/SHZxHmGsKfg1c0fZ3rKYWektw+AgjjiF14=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ldbe537B; arc=fail smtp.client-ip=40.107.130.24
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ldbe537B"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=S7UB78fnXicc1M9SUzFi/OlUtUxHdvkrfPpKplqOZrt1J1aMxiUFz5Dr5YUtCyf+pEXMqTSlDDrD0kZk2WPOpge8SbIoSGg4N0VWxIKK4MISDZWHbEYJwVDyv+scKgrHivtbsM4VsLHERbnAJUELDYWCdOKQdswlmcpX6MWbB9Ja3aULfvikYcVrcUB3eEHMFBP/q256BLXvcMdhoyYA4Hsu0RB46If5fhYk7cNnilf9BTpIiWWI5eoEn7x89XV97F9yE0RJZzSfT2HqDd0YOIHNOlSGyPz+yiaTNd0FKOV6GWyOV9yslcfBm8ry/Trk/XW+G76ZXkxljTkixd/UWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zl+103Oa5pc1XA4EQOYhtSZRbL4QEfas9jDkhsYzvt8=;
 b=KK/lxQYAwgAVjUMgfkbulv0mX/spEtqKnYSYwMhUDzmGyd+Q3cr9BGXsRlovdT09KSLO0F1I/5gtbECiNO9TQYbogW48dwBLlOioX9vZ2QBo+F1kBwJ1Xqo4HOARadj3ZxciiVMpob1vtZx41k641EZPmHPoFOwuLy9QUob/rnmA0JBtclMLtTOHIJoB3zLPgJy4jLTazT+NMLS7Yokly1XJPQxqhFlE8p6FCtdfnBaK0ye7FHB6ThZOkYDB6VPdI3TB9NL7X2wvnAzNiI0TXz/jmcZ5SxPq2MOut9FDNpTuRRfpJTaVWMYFG1yG91SLj9WX+jQc6AyOSfTh8g6Ciw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zl+103Oa5pc1XA4EQOYhtSZRbL4QEfas9jDkhsYzvt8=;
 b=ldbe537BD6/G/TBhlz90uOvVvbWnZ5k6WVFO1E/dPbInABp/vOmzUXcgCTS4b2XCrG/evbaOt27XyOzY90pmd6GimaOu2L+Zz82iFcGnL5Mrp/HNzDQYWCVKVvQPLEYxX961MW4RRT882SM8dwHIjio8zRz9SIcFStFZpIzObMplQzPSDN8kTNnTMtXvf/A4sCqoP5MXJ1XDhTk7odr6w34YYnPLglZzL1ynbXwsEJZpuv5jJtZe7EvsrgNmkiDjISKbkfIZpGUR5ZY0XX5M2hKqGpXcC+BxAgVcAGUK9lo09kKqP+WX0J8K2JLjPiqipYoNd/95PWEobvzpavEaJw==
Received: from AS9PR06CA0700.eurprd06.prod.outlook.com (2603:10a6:20b:49f::30)
 by DB9PR10MB8195.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:4c4::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.23; Tue, 13 Oct
 2026 13:15:55 +0000
Received: from AMS1EPF0000009C.eurprd02.prod.outlook.com
 (2603:10a6:20b:49f:cafe::4b) by AS9PR06CA0700.outlook.office365.com
 (2603:10a6:20b:49f::30) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 13:15:56 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS1EPF0000009C.mail.protection.outlook.com (10.167.242.73) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 13:15:55 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 15:16:21 +0200
Received: from localhost (10.252.6.143) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 15:15:55 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 13 Oct 2026 15:15:05 +0200
Subject: [PATCH v2 1/5] usb: dwc2: fix recovery after PM domain off
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261013-dwc2-low-power-fixes-stm32-v2-1-79865a4f1b63@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AMS1EPF0000009C:EE_|DB9PR10MB8195:EE_
X-MS-Office365-Filtering-Correlation-Id: 09ac16c6-cf45-404c-b0af-08df292c1d78
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|34020700016|7416014|376014|6133799003|22082099003|10067099003|18002099003|11063799006|5023799004|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	35zIkrgzZ/Io3BtiOL4V9ewptmVcs3k7VxlJOVBxd+ttUqux4dBIRxD8El4rhGk+wS6Krg+ERt+YSD6YTJJsyebdIaAbMeY5vGqTu4ygBFTWgH9kvpkzaRPgSqfV7Zq5MdSaJ5iH38LsGMAeCdaqPEWfXlO6zUq60/e4wzPmiLLvmWuRW+VToYFf6vZWVS0C7SYwp1TeJvRL8/X94wbr4F8XBaVfSNld8R7hSiVF80tGCxAdTwsUsFiZcFYWgSMzM9zF4JV3R3fYo13NiGU5UNFGiWRjXOywDRShmhqd1ioCsFVc55mr/uN579rYbNo5zJ4Hgn/odB5q+W2biuspqF4u5Rb8ViujTlDNvTgdXI4zuBl9Zl0i5kjAedTdME8EKk1jmBMLeEmK08fE/d1Ev/zBi2v3mXkzmXlQfHu8psZ7vEQGYp0zJuu13SCMj4HVLXdGdqnX7t2FamFilfyB3g80zbiFKQCoZStQo9SFkkG3zBORFSN5sfMeMhQheQxjc9klp+JU1jO7zbgNGRxkwaGFjQY5s9ALeJrBJU5eGZ3oH1EEvLOkJ95mnEuh3P0jXos/30GoZDgUNXT+fs2wM4Em87fr/rOBFeVArDWh2rOEOuIglZCn5TjwRjmlunYlB/H4lZZaImDs7UvKG7Ki7qU8qw19jQj0neM0XbATxqe57jQjsSHTL8jlQaHVhhhga1oeYUCS9VI4FP2WddsdEw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(34020700016)(7416014)(376014)(6133799003)(22082099003)(10067099003)(18002099003)(11063799006)(5023799004)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	FPzwLOITCUvhQ0sa9OTqAf1JZ7hNmmxgWVLXo2BygEXmvbhPBNfrWPmAOQ6paNjYBHiGg+WHtW2149XLnkwij+IvbOH/vkK2TNLGVULF6mB2cAVQQlC9m+RNNcmkuYkssbRr9XgNd9GSwLGlni3FwN0snGpCqv37EG9eDEEDW5lp6QeKYS41SNoQ5ldYucEtf8j/VOTwsb03f+2+GXdyofzoQoGsMaS/WZ0gUkj3mA732OkG18MkVzdYzrqIwpa1IxqiTjVu81c6bJPs6cRg3Dx8AE6t3fw3fKEyIyE0DlamK1Ipk/2Y7S2hqaco8/QJHa6o7GXAajOONkHZDPRH9+IH1PhsJLDsmKw4UnaNYaZJBESyYDbrOL+pCQsjU3AARwdhbMTKd6nDdcLSmq616ylLO1cZR57yz0xtrkryAm1Yy5nERP+vm5rSNG09yhur
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:15:55.8777
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 09ac16c6-cf45-404c-b0af-08df292c1d78
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS1EPF0000009C.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB8195

The commit ba6e518d136b ("usb: dwc2: Implement recovery after PM domain
off") introduces a regression on stm32mp1x, which freeze the platform
when going to low power.

When the controller has been put into clock gating, reading some of
the registers to backup them from the suspend() routine in platform.c
lead to platform hang.
On stm32, the issue is systematic in host mode:
- _dwc2_hcd_suspend() calls dwc2_host_enter_clock_gating() every time.
- dwc2_suspend() calls dwc2_host_backup_critical_registers() that freezes.
This may happen in device mode too, if the host has suspended the bus.
Then clock gating has been entered, before calling dwc2_suspend().

So rather than backing-up registers that can lead to freeze when in
clock gating mode upon suspend (to restore then later):
- keep the canary detection logic (GUSBCFG TOUCAL)
- move it after the host/device mode has been restored, e.g.
  after dwc2_force_dr_mode() or drd resume code
- re-initialize the core as done during probe, when calling
  dwc2_hcd_init()
- re-enable the global interrupts.

Fixes: ba6e518d136b ("usb: dwc2: Implement recovery after PM domain off")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- In case registers have been lost, ensure the device mode resume takes
  place by updating the lx_state to DWC2_L0, as reported by Sashiko. Note
  in case of error in dwc2_core_init() choice is made to leave the low
  level HW init, as it is the expected state out of the resume routine.
---
 drivers/usb/dwc2/core.c     |  1 -
 drivers/usb/dwc2/core.h     |  2 --
 drivers/usb/dwc2/platform.c | 57 +++++++++++++++------------------------------
 3 files changed, 19 insertions(+), 41 deletions(-)

diff --git a/drivers/usb/dwc2/core.c b/drivers/usb/dwc2/core.c
index f375c5185bfe..368da20ae14d 100644
--- a/drivers/usb/dwc2/core.c
+++ b/drivers/usb/dwc2/core.c
@@ -43,7 +43,6 @@ int dwc2_backup_global_registers(struct dwc2_hsotg *hsotg)
 	/* Backup global regs */
 	gr = &hsotg->gr_backup;
 
-	gr->gintsts = dwc2_readl(hsotg, GINTSTS);
 	gr->gotgctl = dwc2_readl(hsotg, GOTGCTL);
 	gr->gintmsk = dwc2_readl(hsotg, GINTMSK);
 	gr->gahbcfg = dwc2_readl(hsotg, GAHBCFG);
diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index 767251aa1aa3..1b6441164c6c 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -668,7 +668,6 @@ struct dwc2_hw_params {
 /**
  * struct dwc2_gregs_backup - Holds global registers state before
  * entering partial power down
- * @gintsts:		Backup of GINTSTS register
  * @gotgctl:		Backup of GOTGCTL register
  * @gintmsk:		Backup of GINTMSK register
  * @gahbcfg:		Backup of GAHBCFG register
@@ -685,7 +684,6 @@ struct dwc2_hw_params {
  * @valid:		True if registers values backuped.
  */
 struct dwc2_gregs_backup {
-	u32 gintsts;
 	u32 gotgctl;
 	u32 gintmsk;
 	u32 gahbcfg;
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index ef0d73077034..5aa552672078 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -692,14 +692,6 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 		regulator_disable(dwc2->usb33d);
 	}
 
-	if (is_device_mode)
-		ret = dwc2_gadget_backup_critical_registers(dwc2);
-	else
-		ret = dwc2_host_backup_critical_registers(dwc2);
-
-	if (ret)
-		return ret;
-
 	if (dwc2->ll_hw_enabled &&
 	    (is_device_mode || dwc2_host_can_poweroff_phy(dwc2))) {
 		ret = __dwc2_lowlevel_hw_disable(dwc2);
@@ -709,24 +701,6 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 	return ret;
 }
 
-static int dwc2_restore_critical_registers(struct dwc2_hsotg *hsotg)
-{
-	struct dwc2_gregs_backup *gr;
-
-	gr = &hsotg->gr_backup;
-
-	if (!gr->valid) {
-		dev_err(hsotg->dev, "No valid register backup, failed to restore\n");
-		return -EINVAL;
-	}
-
-	if (gr->gintsts & GINTSTS_CURMODE_HOST)
-		return dwc2_host_restore_critical_registers(hsotg);
-
-	return dwc2_gadget_restore_critical_registers(hsotg, DWC2_RESTORE_DCTL |
-						      DWC2_RESTORE_DCFG);
-}
-
 static int __maybe_unused dwc2_resume(struct device *dev)
 {
 	struct dwc2_hsotg *dwc2 = dev_get_drvdata(dev);
@@ -742,18 +716,6 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 	}
 	dwc2->phy_off_for_suspend = false;
 
-	/*
-	 * During suspend it's possible that the power domain for the
-	 * DWC2 controller is disabled and all register values get lost.
-	 * In case the GUSBCFG register is not initialized, it's clear the
-	 * registers must be restored.
-	 */
-	if (!(dwc2_readl(dwc2, GUSBCFG) & GUSBCFG_TOUTCAL_MASK)) {
-		ret = dwc2_restore_critical_registers(dwc2);
-		if (ret)
-			return ret;
-	}
-
 	if (dwc2->params.activate_stm_id_vb_detection) {
 		unsigned long flags;
 		u32 ggpio, gotgctl;
@@ -786,6 +748,25 @@ static int __maybe_unused dwc2_resume(struct device *dev)
 		dwc2_drd_resume(dwc2);
 	}
 
+	/*
+	 * During suspend it's possible that the power domain for the
+	 * DWC2 controller is disabled and all register values get lost.
+	 * In case the GUSBCFG register is not initialized, it's clear the
+	 * registers must be restored. So invoke here the necessary init
+	 * as done by dwc2_hcd_init() during probe.
+	 */
+	if (!(dwc2_readl(dwc2, GUSBCFG) & GUSBCFG_TOUTCAL_MASK)) {
+		if (dwc2->dr_mode != USB_DR_MODE_PERIPHERAL) {
+			ret = dwc2_core_init(dwc2, true);
+			if (ret)
+				return ret;
+			dwc2_enable_global_interrupts(dwc2);
+		}
+		/* Also ensure device mode resume takes place in dwc2_hsotg_resume() */
+		if (dwc2_is_device_mode(dwc2))
+			dwc2->lx_state = DWC2_L0;
+	}
+
 	if (dwc2_is_device_mode(dwc2))
 		ret = dwc2_hsotg_resume(dwc2);
 

-- 
2.43.0

