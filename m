Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.3
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624380;
	b=IFZ2RiP6VFEbkebg5QewBjUfAIUQ4GdGdJ4JBcu3NxInmf6JTvIsCfM7X0LoP+F7/msa
	 PS1RufKx62yaR9Qq+SGOxB/ziCSqAH9z/z4GY8JDbuuyDUCGbo+4QvmARyvZsQugZgf71
	 O0gDQ8ZA/nSP18oM3U7rAnzXwIggJNsNrnB/n9cm46CLeYaVEUgSOnDEo1LMuC0SXXS7z
	 0gMbEusgmAbDTN3BaHaQhueFv4oPXWqlKaYfbEBM7NDOi2VEoUTWxWPndXsjGzyPfDbjW
	 y+ozM5lfXUcp8LPLBnD5BzgEiCADZKhUUE5MF2XCWlQ0Pqko2SGlu/kRIUvW2Ep4RiA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624380;
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
	bh=EEGbrS4K6C/6pC2mAOyqkHWx4fF+vTiq+oFnii/QJ0A=;
	b=VCOs86O+pkK1yy8RscyjjvxeHcLr7GYkTKQm2hRKeODsAqRNAxfBkI95EiO0KdOVOLhx
	 8EGaAbiykYO1/ZhslV7CuCalimgM2dZ/6uEP6O4jLZ5oelSOoWe9iqigPTAiqaCKL9Tws
	 pT9gayxrnZi7AX1tLbj+zHgBSdgQZa7trYqRCw7PQEDtaBlo2tg4frhOknRmSmDUgPIu7
	 tZk4NOV4RzWdjZ4wf1m4npYNO1WsyGvuvYEunekvFBkAckVZnMDPYPA6ZnT0SM1H/BKSz
	 qR4CpJuoUvIqdPk3DlsZRYc5/7jIw1jKKvTEf+vbPJyXEOcRB8oo9ImrHE8vNZ99a1A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=StKsDmv1;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.3
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013003.outbound.protection.outlook.com [40.107.159.3])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ECFB60A2615;
	Wed, 25 Nov 2026 16:32:59 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3ECFB60A2615
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=StKsDmv1
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=QQ9rIHEa8YivGs1h6ePoXo7LW70mFuuY808wPU0LYfaHZtj270IPgzzqQ6//9fXKzuO+o0FwwFMmRENWgrv5+49rXr+f6CZQ6hrdypGjgwL6lwRzbUZoMHJdI00ESy1wfP/mRc0+EH/t03+/GgTVZ8MemHDLMoILf5usct1UIkPWcNhFn3fKQubBgfooanWOp/tocwkWIUVpnmKcIug/zttiOMomrGgQ25Hb049QhcHvHAwTZqg35AXjtLV5hrccZD6tl7IaGZjY904sDcHoqFDM6+2udxjgLOxblZBLgrCuPn8ap0QU+dlnDYVyhfDJ21Rqdhjrg8F+gY0K8T11ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=EEGbrS4K6C/6pC2mAOyqkHWx4fF+vTiq+oFnii/QJ0A=;
 b=JqyHagLItrI8cb/5Xvv/TXaSMCRe1yQe6Eq2kgR7ad6aV1c9NY433Ea6jEIFRsDEqySXi7gTZtsIP9gfUA8HO0Kfh4PSFI5I6pIJHRdxRveAP+t2/EtrkZ6c9W8s9hvrmU6lUU4uXb/+Ge5ANQ8uUVwAvegUtipVOnrLdWoBCcD7JEc43smO+tLkqkILO+Phf765I92LMzNJIJ/t37I4a+B70q292uGR46dgtyjx9oOAlXXXuXUDsuu7uvDxxlKiUlfBduzu2lR42Gs5DDyDFjZr7v9scZM7KyHoeQvFU/qUWEjr88Hjp80yvNhXFcW3/WCOz20ErqzbMXGXi0nkew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=EEGbrS4K6C/6pC2mAOyqkHWx4fF+vTiq+oFnii/QJ0A=;
 b=StKsDmv1fYTcw9ps6R1M8Uv5w+B2w8gVs9jDbut/8NPXOpWm51Y90DPqBa/E7yrj6/HuMe3TAVE3mmmXkp1yJpdKBh9HQeHAp7TcdCsEvTYjqe0CHAoVkgnTjQ9erETLI79UYCBl4pf29h+1R1O5+0RgwxjUefo7oVfXAzdSFnX0lSNmhwv4BwUDITaHK0ftv0tftlGkqTD8Zq+7xhu4acTYrTprYZ1QAPm6YEPGd0UG7pT/Pi5c2VjdIxJATMzIBDeGXkAGeUcCP5QsBsLBupez/E5D88DLl/fcDHVbrAT3TQiKv6QprO+Yr16QW1SKCKyFp3mSZkoiiBSe3KIsZQ==
Received: from DB8P191CA0009.EURP191.PROD.OUTLOOK.COM (2603:10a6:10:130::19)
 by VI0PR10MB8835.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:800:234::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.3; Wed, 25 Nov
 2026 16:32:51 +0000
Received: from DU2PEPF00028D06.eurprd03.prod.outlook.com
 (2603:10a6:10:130:cafe::69) by DB8P191CA0009.outlook.office365.com
 (2603:10a6:10:130::19) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.14 via Frontend Transport; Wed,
 25 Nov 2026 16:32:51 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 DU2PEPF00028D06.mail.protection.outlook.com (10.167.242.166) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 16:32:51 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 17:33:56 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 17:32:50 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 25 Nov 2026 17:32:11 +0100
Subject: [PATCH v6 10/11] usb: dwc2: platform: fix stm32mp15 detection
 logic power management
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
Message-ID: <20261125-dwc2-low-power-fixes-stm32-v6-10-d5df33b93eaf@foss.st.com>
References: <20261125-dwc2-low-power-fixes-stm32-v6-0-d5df33b93eaf@foss.st.com>
In-Reply-To: <20261125-dwc2-low-power-fixes-stm32-v6-0-d5df33b93eaf@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: DU2PEPF00028D06:EE_|VI0PR10MB8835:EE_
X-MS-Office365-Filtering-Correlation-Id: 7275cce3-c7df-4fbf-fbda-08df4b11bfab
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|36860700016|376014|1800799024|23010399003|22082099003|6133799003|3023799007|18002099003|11063799006|261028144727099003|261102123227099003|261021123027099003|261021121427099003|261009223027099003|261026121527099003|261026140227099003|5023799004|261022075727099003|261022105027099003|56012099006|10067099003;
X-Microsoft-Antispam-Message-Info:
	fEru+n30HNWrdw6fWo9dKJzMfuCeCHQamhHlDp3JmrrGfJSNdRuMbIwNK2Ww81wgKPQkj7OYmK4fxvGLJ/dNHe12/ywYxqC+IK71PNV2Zb2tEIlVwSRDXJpsM9ailK1K3ZhiQG0CL/Lk6Rs+NT4YS7DSupwi2syZbCgWgh6pWK6ysd8ZOy+5qG2BVEOiIDV9ZCeIwfPQDPqdT6owEnb9mKswWlUiC6t6IJs56WHdIhjsX7A8mPXxxSS16fmXRoIwfaL/3LeiiENlgg1EADW+T4Mrle5dl9nle06JE9o4RISaUP9EYczEnLMEFmGX+W/ENVUO0kmQZRt7GrZGsmFGiYh91H/fXrdZvzesaxqBx1TF/ngj6FaPMcUqyizgdNh4NMfY0AqSvah7qEbHGJCkvfh3ZhF3BNffJtN9Zs09rUjU2chNNHOxGdDTp7+eIDhW2k8AeGr05+qg309zIthHAnNnPo5XV2En3vpuWUZET3l+iPagObDscZ/2JAxzggNEiSToUHVKqRYzYx3Co4Iy3Pfi790LqMOxQ3mOAmy48rcDOF2myR0pc6RPwXFTKz9YbBX9lkrBpwYhDFPlLn/asO9tDg4ijjxnvu05OGwZC65fuluzrwLwQCQGu4xfhrYokZparvL4pBfiabHfts+ip9ipjJBD0zz0/HdHioTp8dbhgEklSA1wdXBj5lQBdFHCrO6+AFQ6UHlPsmw30PUAiA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(36860700016)(376014)(1800799024)(23010399003)(22082099003)(6133799003)(3023799007)(18002099003)(11063799006)(261028144727099003)(261102123227099003)(261021123027099003)(261021121427099003)(261009223027099003)(261026121527099003)(261026140227099003)(5023799004)(261022075727099003)(261022105027099003)(56012099006)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	z1OPvw0Cb99IwJW5jiqywnNWzQRU1UUJXaqjZCAC0hJMrTwStGQYscGBtvuap6/bQw5eB5+E1YbMQSsa1x6Q+tYrbY4rLzih7UZmgp0/il9q1niWJt0yGg8PJsbyX27aVOX8UppkQRu0HjZRDehMDvxEveG6RM7ra/yrNQRHrCq9Ghe1Aa8s9dTZZ65xagH/IapuLzQgcPnP+J3jf/Dti6P9aXN8KvRN91AGam8+5x8wOP9oRZ9rUtqyCJ9kI+5glsFTTEIzHUs+0BYX/+64DaftANz5pyuskJty21dz5/zUu2zDU/ZQ1QoQXfw1iUWd1YQvSBRARevxtF8NT3aBD/TE5CwjMRg8WHsIga/DGBnspFPrEvCnt8TixHnOxUhFs0qdGKazfvseG1evCnA79H35+UVhLwl0FPq0Kusg7Zm5oVNWcvpV7eT1rbhPVzfG
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:32:51.0045
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7275cce3-c7df-4fbf-fbda-08df4b11bfab
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DU2PEPF00028D06.eurprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8835

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
index 1bd652c1bb42..9a3bf6a5047c 100644
--- a/drivers/usb/dwc2/core.h
+++ b/drivers/usb/dwc2/core.h
@@ -878,6 +878,7 @@ struct dwc2_hregs_backup {
  *			remote wakeup.
  * @phy_off_for_suspend: Status of whether we turned the PHY off at suspend.
  * @suspended_in_device_mode: True if the core was in device mode at suspend.
+ * @stm32_id_vb_detection_enabled: True if STM32 ID/VBUS detection is enabled.
  * @need_phy_for_wake:	Quirk saying that we should keep the PHY on at
  *			suspend if we need USB to wake us up.
  * @frame_number:       Frame number read from the core. For both device
@@ -1080,6 +1081,7 @@ struct dwc2_hsotg {
 	unsigned int need_phy_for_wake:1;
 	unsigned int phy_off_for_suspend:1;
 	unsigned int suspended_in_device_mode:1;
+	bool stm32_id_vb_detection_enabled;
 	u16 frame_number;
 
 	struct phy *phy;
diff --git a/drivers/usb/dwc2/platform.c b/drivers/usb/dwc2/platform.c
index 38954dee6ad0..c1f5e03c0d03 100644
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
@@ -141,8 +230,22 @@ static int __dwc2_lowlevel_hw_enable(struct dwc2_hsotg *hsotg)
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
@@ -178,6 +281,10 @@ static int __dwc2_lowlevel_hw_disable(struct dwc2_hsotg *hsotg)
 	struct platform_device *pdev = to_platform_device(hsotg->dev);
 	int ret = 0;
 
+	ret = dwc2_stm32_hw_disable(hsotg);
+	if (ret)
+		return ret;
+
 	if (hsotg->uphy) {
 		usb_phy_shutdown(hsotg->uphy);
 	} else if (hsotg->plat && hsotg->plat->phy_exit) {
@@ -358,9 +465,6 @@ static void dwc2_driver_remove(struct platform_device *dev)
 
 	dwc2_drd_exit(hsotg);
 
-	if (hsotg->params.activate_stm_id_vb_detection)
-		regulator_disable(hsotg->usb33d);
-
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
 }
@@ -554,33 +658,23 @@ static int dwc2_driver_probe(struct platform_device *dev)
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
@@ -650,9 +744,6 @@ static int dwc2_driver_probe(struct platform_device *dev)
 error_drd:
 	dwc2_drd_exit(hsotg);
 
-error_init:
-	if (hsotg->params.activate_stm_id_vb_detection)
-		regulator_disable(hsotg->usb33d);
 error:
 	if (hsotg->ll_hw_enabled)
 		dwc2_lowlevel_hw_disable(hsotg);
@@ -677,37 +768,6 @@ static int __maybe_unused dwc2_suspend(struct device *dev)
 
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
 	spin_lock_irqsave(&dwc2->lock, flags);
 	gr = &dwc2->gr_backup;
 	if (!gr->valid) {
@@ -765,31 +825,6 @@ static int __maybe_unused dwc2_resume(struct device *dev)
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
 	if (dwc2->dr_mode != USB_DR_MODE_PERIPHERAL) {
 		if (!dwc2->role_sw)
 			/* Need to restore FORCEDEVMODE/FORCEHOSTMODE */

-- 
2.43.0

