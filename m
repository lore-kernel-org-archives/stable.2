Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010045.outbound.protection.outlook.com [52.101.69.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D4E03BB12C;
	Thu,  8 Oct 2026 13:34:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.69.45
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791466469; cv=fail; b=soc3AN/9UHn7AhMbNji5ZJdlvaQBI8Qki8+jr1UwrgEXw4wiFDYlBT8qTtdFMTtjEezjfIiKC9xt01X0GU6X7DHnFNvEbfM8kxa3/nCnI7SlFdVYjpE0KkxI8Xehaqdfkc3oJsxtVVTI0Zk2Sb2WlAL4kdoLYtBVBz4aq+kaolg=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791466469; c=relaxed/simple;
	bh=UmXjgJ/AEPgmEzZGEr52P+6cXwO4czzR0O5V6rfGgOk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=ME5N/qVA7dj3ahYIgPI0iIn8q0aIEVzAmX2w8ZOEyDW4Du522dyengJeuuBYWFSIRg7J3m0sOX64NWfY6mziRzm7GZ35SLDmsTadXAMydtn8qm5bo0PFV/908RYNwuiLkDok7r7H+g+D2rcdQmlx6GZdIbgcCUgDI7L7m+1LOFU=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=PhGxAFwF; arc=fail smtp.client-ip=52.101.69.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="PhGxAFwF"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=LbVifDsDkWqeV6luBw3pB7FTmrsHKYy+fiy8CZMv5qCNe+SguGVNXOt47GzymWO0/U3RE4tOCVbdy/DxtFO2JKz7PFlY7VU9l70I2wG/wbAN06OVZOja+cpDjU0MMRcojAYRWF7tWxQU2MMnBfOqp41FsqUBfGjw/VwSGq2FtEPHb5wETpWWm6TgeOMen39HrITHK0rmRGPCoQGlVmRogq1uH1urC2MhpeLLajYqiB9cxOkKtfdgSiRkZJ9ZVKSxXuOgb5lfQ464STxTSoBFOhixMNHvsSZuMFePr2tWGG5YfPoWVqnVqJz0Y6YUUsLb1A7meNIS9FwMifIZspSA9Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eXbYbhj8RVck4spG7DHmJL4VLZqh39Sx944K5aQdiKA=;
 b=gTRXFT/dxJ94BBl0S/qOyFLjjiPBTvVmTbJV9LN50g3gDvQPAvALP6UdY+MfEdjvWY+H8cHkISUulQ5IP4kTkbyJoc0JthNoah/lKAT5Fvy6QyullWSzuVnZfYcKb7MlIHBjbjRzH3/Fxrh/J/EJ7etI8TbVubGAIF0KfHuRe8gyzJuI+1cIeMOEBZ0Iqs5bEsG79e0XEHQEqQzy5CSaYt4imOSXfKUo0c1DypH6b33S0sqjmKnABWDm/lzQ7cbVfQPhHg9/2UDg8eC2LbEnhnt5MS7dOGp91OOFZMrpn7sGFpwSSQvkzbvdI0CW63cnERXnkOyi5tKgGSFkbmiOQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=linuxfoundation.org
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=eXbYbhj8RVck4spG7DHmJL4VLZqh39Sx944K5aQdiKA=;
 b=PhGxAFwFCiX4YNQ21pn0Sl+v0Izlz10PZpy9jQLk/reSWpfPJd/N+nUWXcqM8xmZmTfSNKtQV4oNeuc7qDUTkCVs4aY8YBtmJ5jhG5aU+L6ngC6Cj2VQ8fCn9A3MhEVY/smXh1qcRpqvJP9uvfDbaHFMrx3p6SMbiWV/MswX2EyJm8JcDHxFn2qJLpvqBt0OWnK3Nv2MofAx9CG0k/NgrHDxKICVZkuoJs5ECGUSYQPYo5DulpTYl6rCouqsEKk/hwbugBvpIRxPAFTXB7qFfZslHPWdrN4jae1TOoU2DRfOfTnuHl+uQBtAEfiOz/wohmY/fs+VyaD9peK77IhwVA==
Received: from DUZP191CA0028.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:4f8::24)
 by AMBPR10MB9486.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:20b:737::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.17; Thu, 8 Oct
 2026 13:34:23 +0000
Received: from DB1PEPF000509FE.eurprd03.prod.outlook.com
 (2603:10a6:10:4f8:cafe::68) by DUZP191CA0028.outlook.office365.com
 (2603:10a6:10:4f8::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.21 via Frontend Transport; Thu, 8
 Oct 2026 13:34:23 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 DB1PEPF000509FE.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Thu, 8 Oct 2026 13:34:23 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 15:41:06 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 8 Oct
 2026 15:34:19 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Thu, 8 Oct 2026 15:33:17 +0200
Subject: [PATCH 1/5] usb: dwc2: fix recovery after PM domain off
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261008-dwc2-low-power-fixes-stm32-v1-1-5b303df762e6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DB1PEPF000509FE:EE_|AMBPR10MB9486:EE_
X-MS-Office365-Filtering-Correlation-Id: b65168f4-a983-4a95-e7da-08df2540dd58
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|23010399003|1800799024|36860700016|7416014|6133799003|22082099003|18002099003|10067099003|921020|11063799006|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	S2TCHwWphPLFgYh+/xIJI471T5BGV/PhYk2l9KQoaqP/IzZPh6T0ptNoXQHwzExkCRv4WAraWUI1D5jAxZw55KWz63e7RCbtDGNCXYR1XTwmpRS7pAd/nGQa9ZWtxHnln8QyMzuE15B0qD8vIs6JtzHVkb1D3RdGo3ZQ9M8vte1v+0VUZFNc1ndBDGGF4CpCm/OfHqnF0Z2vnVNP9X7BZB8IFlztGD546yq71rUxw9zLwmx+CR1fNYNDdtXNgJ1OHSGNR6YgCleJRnHPgrKyp3odiZ7wFmRT+Kh/MqPEiyJToJuYrgVA9o/RwR4cBXsSUivsKiHkPzGbD4Jk8PStcatcg0N2BB3NVilJdNDiVjMIsV4edOnhKZcXXa/wKCM7lC0BZLSNjWb6stv6ItI1pXLejphovychcrvzZt+o+mLvAejYS3azZGyPpgYHqeeUTl6VknfFgeN4Lnvhq0ILiLQgfIwL+MfzN1gOjDlMrazuO/hOMTdCG/hVLWkjSsQaY98gGCmkRMSpxbKRwBpw3g1RTwF92X/fiVueJcu1qGweh0oan/atgvde3S7MP98jXS8kS2MjFRmu25LCiv5DJgV4qSElnjipeZpHhpxWWSy1ynRNIPMoEixRBbealUFeBQn0i2Umf/B7iuKkyAG7Ll0XhNn/IdsrFlzBsUkwg3dHKZAt4+E9TFsigO7bV7XuFXn3WNnuedbmDjUXrh/yN5sflUIApeV9EoXSEd6yWEUnpf0xUMDclMuv/RTrii5H
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(82310400026)(23010399003)(1800799024)(36860700016)(7416014)(6133799003)(22082099003)(18002099003)(10067099003)(921020)(11063799006)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	DCIAqfDxcsbN6eaceiMoHW0XSDxhoZ/eZJNjTwjIrCGdL5+fV0Ah78ggeFBN5Ixp/tTHMJK+DjKcwTxoy6YYCAMac2Jy/qaHtBNzooONZXc1penHEPK19KyaXXKWUg54D5P9BRvv1i8A2XdGkNCa17e7W83IMk8AUSJSj5UkaUOIrccuGwwhydaInZMCQZWU7mOD614699KBhxHwH8csBle0B51KsJTt5wxUlIMF3zRN9ab3Uwf9zXHxe/yQy5BONQHgobHdvld+Z69pgrqNVW2dg8Zb/0ic3G3UovUY+1ppqQmmq6FPwTobWY55CHnnSiD5ZM200BQd2vH8/arDosD1QItQ8bkOI3ct8YMkdfCNskqeEbE5ybb0pxkQnh6WvWM1wygiBiDF/3xoZEroayhGZvf5d+5XSNX51pvQQ/TSCi9nrFDc+4sbIiwpsfBM
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Oct 2026 13:34:23.0481
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b65168f4-a983-4a95-e7da-08df2540dd58
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DB1PEPF000509FE.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AMBPR10MB9486

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
 drivers/usb/dwc2/core.c     |  1 -
 drivers/usb/dwc2/core.h     |  2 --
 drivers/usb/dwc2/platform.c | 54 ++++++++++++++-------------------------------
 3 files changed, 16 insertions(+), 41 deletions(-)

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
index ef0d73077034..643d67ce28ea 100644
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
@@ -786,6 +748,22 @@ static int __maybe_unused dwc2_resume(struct device *dev)
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
+	}
+
 	if (dwc2_is_device_mode(dwc2))
 		ret = dwc2_hsotg_resume(dwc2);
 

-- 
2.43.0

