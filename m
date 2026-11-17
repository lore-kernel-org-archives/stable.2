Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.16
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935192;
	b=SlMBzOZtjum7/iRKLIwhr+udBbUV4G+1W6Y+1omomY/8lP0zfsH4Mdgccs/2nOvY2IrP
	 OQq8xhjXSSUXpyQ4BlZk6QTtMuyY1W/QW0Ig+N5SBW6zqcOHpNC3E/rphB0erBtnb9Mv2
	 k/nzPMbBzcqS1k/HRz4lMBjeOzljqZyX41aW/h5bMIEXn1/X4KXui0NUJ4IqE0AMlxCiC
	 9V2lN1IwEdl+hBVr/dJ+jikpYTJhWa26uFch+9a0u3hqhDAJk2bhgn/89Jx2EBRaEKXqo
	 RBl0/sUWk0lHNA4xVGR+HZ0YYq2l9I6+VR9T4xPRvIYpCPFJx0rg6LicaUNeEXcXFrw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935192;
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
	bh=Yi/sw4/Vl7rVcpfEy20vYjjg0rsPyptnPo5Ddp1KtwQ=;
	b=FIg+fIhNBiGj0/OScJBcXxHHLubLuy021FwxacjRV46/oZNJy9v71Rvv4VthOjro6Dcz
	 BdgVOp3BojySFHMbvU+WwX890gos6v0xbGIR5mW5OkzgYirRnqP2UW50RdBsO4gKza5p/
	 TpAOCG+U37fTAfO+4Wbe2t3bWtVf7WZ1qz7ushmJZkE8rbXvmzJ3qglmi7YyVJqREfeu9
	 9Zkc4LnQzXluzMiQ5OXcch89e4NC9OQQz3dAkY1YUmgqZhtYrqIdlQRJMTLi89LNkFmET
	 garLK9kJ+PvzbcJQtPSxVX444ZHeoHo39A2LX2i7mQUhzDlCk7QEJ8oG+0WKHr/qRnQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=SBiqe6CO;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.162.16
Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013016.outbound.protection.outlook.com [40.107.162.16])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04703606A89D;
	Tue, 17 Nov 2026 17:06:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 04703606A89D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=SBiqe6CO
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=iOm3/5HtpSF1gxkZQLOt3BSA6sA1TAItSjk5n+mfKjWaivd1pJXYISftNMz70EYZbA0Ui5fUEDGJZhea4ZwFeu0Vif/6nuv6tTLXWwiY5tP91HsBX8eFTTvb4OMicG78fgKlNf+mMQncQWAERz0j4dfMqMH7Ac2v0K6bpSxs4BB2aeRvr6SzoUeh/eIkiCqmT4nuMuHhFxzQy7yH5FpmuzVPZdT0jHqktbPHPYJy6Bvn2fHbUcKg8z+Zqmf+6159gX27SIPi4mSjwp4hEdCLcwaxw1ibitsv7liUp16eXIdFjcIoi3J9WepOc/JWWGwx34Wwj9/LhDW4USncK5T+YQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Yi/sw4/Vl7rVcpfEy20vYjjg0rsPyptnPo5Ddp1KtwQ=;
 b=lAGhOeQudogVyfUToPGAUQX0shm3kQjRJ4GVb9aXxQ4d11vggmoVx+4w7rFKDWcxuoSOq6zv79I+Yae5TKoy+gKvIFKi0ptDv0fan9mAT5Y/N2xeMKmLWJqtvqIUDrVnAjQWI4AbH8y+zWXdtlPDZqNH+Ly9PE1qtwOQm1Mv9LtiKmhswfuV7CmyctmqD9fWeKnq5uBH9dqs/YRdexnAV4ORHQuYqhk0AzPSn0abn1WdBS2rq7CSsPCiVRqtZHRK3Wn1WnayHgmzlMoZ64t7ocgIFgdtY/IL/B3yhR2oFY34XXF/SD8qlBjMGTMU0ThHflk80RMbCG8Wn40ePEm2eA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Yi/sw4/Vl7rVcpfEy20vYjjg0rsPyptnPo5Ddp1KtwQ=;
 b=SBiqe6COudb5iVmdVDV9+WGNjXOr0dfIbmLjOdoXXgMhFK4hZ4Fm2RaBC49EpIALzQf3qeWctVXMyvd9yBWVVetsQOjsl0znioQDc2atcXWESePmy/0AXRSUaM8yiOHGaRO1UOkKE1O05hvNviAUPXu9vAkcLBl3qLG936tvPb2uMjGohGK3McCfSczvXkfs0/6etXGLZP8t5uk9jNgBi7w1BN/Syl4wKTAX7Hhkib91Biwh5WkBI9ILlUGysoZxn5SfurKaTLt/DgRdTxzN/KrrpyCrW2GUEEKD+yqwQmi+8RdyWH17z3UZk763qGi8qMqa6J3bt+owyPYyFUHQ0A==
Received: from PAZP264CA0044.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:1fc::17)
 by GV2PR10MB6408.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:c0::13) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 17:06:26 +0000
Received: from ZR1PEPF0000E462.eurprd04.prod.outlook.com
 (2603:10a6:102:1fc:cafe::59) by PAZP264CA0044.outlook.office365.com
 (2603:10a6:102:1fc::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.13 via Frontend Transport; Tue,
 17 Nov 2026 17:06:26 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 ZR1PEPF0000E462.mail.protection.outlook.com (10.167.241.52) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:06:26 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 18:07:10 +0100
Received: from localhost (10.252.22.224) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 17 Nov
 2026 18:06:25 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 17 Nov 2026 18:06:11 +0100
Subject: [PATCH v5 7/7] usb: dwc2: platform: fix stm32mp15 detection logic
 power management
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
Message-ID: <20261117-dwc2-low-power-fixes-stm32-v5-7-0f197e0e6362@foss.st.com>
References: <20261117-dwc2-low-power-fixes-stm32-v5-0-0f197e0e6362@foss.st.com>
In-Reply-To: <20261117-dwc2-low-power-fixes-stm32-v5-0-0f197e0e6362@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E462:EE_|GV2PR10MB6408:EE_
X-MS-Office365-Filtering-Correlation-Id: aea83c71-fb8b-4f6b-861d-08df44cd1db6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|23010399003|18002099003|22082099003|6133799003|3023799007|11063799006|5023799004|10067099003|261026121527099003|261022105027099003|261026140227099003|261028144727099003|261022075727099003|261021123027099003|261021121427099003|56012099006|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	7Vm90eI8vWPRVvDCDoEQ1n3jgrJ7x8BiZw295foiyVWVgv4H4yqpfFI27wMHZJAFNt17n+NpMuYFKQWgDXkU7ogCQN4NSThILZWTk+I7n9imTVlzQZ3Mx3/t5/91cS2xVqKoxK9nxcjd1JSuRkxytOUjA8ItU1mrVxkhbQvT4pK5TDIg8wJRhrsSLb00mr1/w5ufwbjdglqMnsMQsLnSIDlyeGfqX6IPp46Q+Li9WJo0+l4k0xzs/zweb1ZsuTLhJ3rVCFo8JlOpHa6FBtBjx5jlUWaiz0lEu6JL5najf++7gn1pR4RVcyhPaRRADjPEp9kjbdu6XI6PdTQaZ63sktppbzQf8BlmfS255WyFF93JJCGNQEaTDsOLFlGfzUktquUhr2i8TPPjNgk4lkRfuwoOkwRu0/iKRkNih27FcehIy7aPAeeylKi/kYsyINPehCue/Al6U/r0rrjhl6AWGkymkBqgLmMiwBZbvtPUPsdkvVrZ72X/kbawirUST7Tk24Hn2ezKCjW17RNei8G9jYX35hBlBqlcX7gK+ToIo43LxTx+eUPikxBltRQmK+c9+lrgM/S+5AAg/xOqMowsNFXzSMu1CpIC5ZUa1Jrjk/tS/GLli/nIqMAxK8jBtYSn2PCSUu/SXtKrkJQjQxiu9T2tXz16K6XefDfJC0TIK/xBcXer3Y2XeQcfZzgXKtr055Zy+Gt7FyRgh8H87BVwnA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(6133799003)(3023799007)(11063799006)(5023799004)(10067099003)(261026121527099003)(261022105027099003)(261026140227099003)(261028144727099003)(261022075727099003)(261021123027099003)(261021121427099003)(56012099006)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	X3pXVZ+mfp1M2zg1eTaGbs088/E8aVlyrMyg6BVM11tq9bmw1RFt5sd9VGO+FPLRa9bdjTQh7J3FsDYHeu0NLuNydu8STc9VS/al9ZOw5a8B4/e48wv+unUV8ehRi+BW5We36VfqKWpEH0OhJEt6fjTK5+fA12Owx1/1h7mqR94VpenCsQyVMaMrZHw5SrWFu/LT4A2fEF9ugBLOqvg1q3yCcvcQI7DnLZC/N6Un+ubee5r/rc/Y6CtWl3Zk/VBCcR3yvyfkTLfvjGrb6+iuVw4GXZcTLVQYBMmLKuol3QbvakudjgkNLgKv04iGnZPaK+dNmqaxi0fX5C4jF9NlY/omX6SScGA0Zs7x+oksbjo/tyqgvdgngL0PInQaVwcqKndl4CrctJgzIG8odLoK3UZBot1JipLOWm5g5LCE4LQeroOUxzEJ+3TMJaOdr5dy
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:06:26.7079
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: aea83c71-fb8b-4f6b-861d-08df44cd1db6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E462.eurprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB6408

On stm32mp15, the STM32 detection logic can remain enabled even though
the other hardware resources are disabled during probe in peripheral
mode:
    /* Gadget code manages lowlevel hw on its own */
    if (hsotg->dr_mode == USB_DR_MODE_PERIPHERAL)
        dwc2_lowlevel_hw_disable(hsotg);

When entering system low power, the detection logic resources would then
remain enabled because dwc2_suspend() checks:
    if (!dwc2->ll_hw_enabled)
        return 0;

If the stm32mp15 enters standby, the register contents can be lost and
not restored, leaving dwc2 unusable. This can happen when no gadget
driver has been bound.

Move the STM32 detection logic enable/disable procedures into dedicated
dwc2_stm32_hw_[enable/disable]() routines and call them from the
__dwc2_lowlevel_hw_[enable/disable]() routines.

Factorize the probe code by replacing regulator_enable() and GGPIO
register access with a call to dwc2_stm32_hw_enable(). The earlier
dwc2_lowlevel_hw_enable() call during probe cannot do this because
activate_stm_id_vb_detection is only known after dwc2_init_params() runs
and the usb33d supply is acquired.

Track VBUS/ID detection state in stm32_id_vb_detection_enabled so it
is disabled only after successful enablement.

Fixes: 2b94b054ac49 ("usb: dwc2: fix hang during suspend if set as peripheral")
Fixes: a415083a11cc ("usb: dwc2: add support for STM32MP15 SoCs USB OTG HS and FS")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v5:
- rebased on ("usb: dwc2: restore peripheral mode on low-level enable")
  intended to address sashiko comment "usb: dwc2: missing forced mode
  restore in dwc2_stm32_hw_enable()"

Changes in v4:
- Track successful STM32 ID/VBUS detection enablement with
  stm32_id_vb_detection_enabled, avoiding an invalid regulator disable
  during probe error cleanup, as reported by Sashiko.

Changes in v3:
- Roll back if regulator_disable() fails in dwc2_stm32_hw_disable(), as
  reported by Sashiko.
- Add a note in response to Sashiko's v2 review.

Changes in v2:
- Fix the probe error path if devm_regulator_get() or
  dwc2_stm32_hw_enable() fails, as reported by Sashiko.
- Describe the hardware-disable error handling in the commit message.

Notes:
- If dwc2_stm32_hw_disable() fails in __dwc2_lowlevel_hw_disable(),
  there is nothing to roll back, so return immediately. Alternatively,
  the error could be ignored to continue disabling other resources.
  Similar behavior already exists for phy shutdown/exit/power_off errors;
  this could be addressed separately.
- In host mode with remote wakeup enabled and a descendant enabled to
  wake the system, phy_off_for_suspend is false. The STM32 power domain
  is not expected to turn off, so registers should not be lost.
---
 drivers/usb/dwc2/core.h     |   2 +
 drivers/usb/dwc2/platform.c | 185 ++++++++++++++++++++++++++------------------
 2 files changed, 112 insertions(+), 75 deletions(-)

diff --git a/drivers/usb/dwc2/core.h b/drivers/usb/dwc2/core.h
index c97c958b19a5..7de080507b5a 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -875,6 +875,7 @@ struct dwc2_hregs_backup {
  * @reset_phy_on_wake:	Quirk saying that we should assert PHY reset on a
  *			remote wakeup.
  * @phy_off_for_suspend: Status of whether we turned the PHY off at suspend.
+ * @stm32_id_vb_detection_enabled: True if STM32 ID/VBUS detection is enabled.
  * @need_phy_for_wake:	Quirk saying that we should keep the PHY on at
  *			suspend if we need USB to wake us up.
  * @frame_number:       Frame number read from the core. For both device
@@ -1076,6 +1077,7 @@ struct dwc2_hsotg {
 	unsigned int reset_phy_on_wake:1;
 	unsigned int need_phy_for_wake:1;
 	unsigned int phy_off_for_suspend:1;
+	bool stm32_id_vb_detection_enabled;
 	u16 frame_number;
 
 	struct phy *phy;
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 5fd005e72173..68752e446302 100644
--- a/drivers/usb/dwc2/platform.c
+++ b/drivers/usb/dwc2/platform.c
@@ -91,6 +91,95 @@ static int dwc2_get_dr_mode(struct dwc2_hsotg *hsotg)
 	return 0;
 }
 
+static void dwc2_stm32_hw_activate_id_vb_detection(struct dwc2_hsotg *hsotg)
+{
+	unsigned long flags;
+	u32 ggpio, gotgctl;
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
+}
+
+static int dwc2_stm32_hw_enable(struct dwc2_hsotg *hsotg)
+{
+	int ret;
+
+	/* params are only known, once dwc2_init_params() has been probed */
+	if (!hsotg->params.activate_stm_id_vb_detection)
+		return 0;
+
+	if (hsotg->stm32_id_vb_detection_enabled)
+		return 0;
+
+	ret = regulator_enable(hsotg->usb33d);
+	if (ret)
+		return ret;
+
+	dwc2_stm32_hw_activate_id_vb_detection(hsotg);
+	hsotg->stm32_id_vb_detection_enabled = true;
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
+	if (!hsotg->stm32_id_vb_detection_enabled)
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
+	if (ret) {
+		dwc2_stm32_hw_activate_id_vb_detection(hsotg);
+		dwc2_force_dr_mode(hsotg);
+		return ret;
+	}
+
+	hsotg->stm32_id_vb_detection_enabled = false;
+
+	return 0;
+}
+
 static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 {
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
@@ -137,8 +226,22 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
 		dwc2_force_dr_mode(hsotg);
 	}
 
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
@@ -174,6 +277,10 @@ static int __dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
 	int ret = 0;
 
+	ret = dwc2_stm32_hw_disable(hsotg);
+	if (ret)
+		return ret;
+
 	if (hsotg->uphy) {
 		usb_phy_shutdown(hsotg->uphy);
 	} else if (hsotg->plat && hsotg->plat->phy_exit) {
@@ -354,9 +461,6 @@ static void dwc2_driver_remove(struct platform_device *dev)
 
 	dwc2_drd_exit(hsotg);
 
-	if (hsotg->params.activate_stm_id_vb_detection)
-		regulator_disable(hsotg->usb33d);
-
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
 }
@@ -550,33 +654,23 @@ static int dwc2_driver_probe(struct platform_device *dev)
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
@@ -646,9 +740,6 @@ static int dwc2_driver_probe(struct platform_device *dev)
 error_drd:
 	dwc2_drd_exit(hsotg);
 
-error_init:
-	if (hsotg->params.activate_stm_id_vb_detection)
-		regulator_disable(hsotg->usb33d);
 error:
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
@@ -670,37 +761,6 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 
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
@@ -726,31 +786,6 @@ static int __maybe_unused dwc2_resume(struct device *dev)
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
 	if (!dwc2->role_sw && dwc2->dr_mode != USB_DR_MODE_PERIPHERAL) {
 		/* Need to restore FORCEDEVMODE/FORCEHOSTMODE */
 		dwc2_force_dr_mode(dwc2);

-- 
2.43.0

