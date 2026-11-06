Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.33
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986731;
	b=RHoecBAm08J6u1eARzB+OmPYpMexyFyU3Kl1SUp4zsB7x3cj9k4OjAO9nrnrGrFjw718
	 b6Yhy0sT8MP6iZX0D4SPanhGN1oO7Lm9K6xo5r3sEqAnKsZ8ZGYy9v7uWxAnTmHz1alwz
	 TU+XRNgm2t/ZG4MGLA5UXlKKBQwMQdIcqPXn6uI2kEYPNWPyGXwveuVU2/kMZsvZrWla3
	 jF3EPiLmeQH0kME/HE/zPGUM/M3EIGg3yo/DGE1xzWpjx+GXas0SZSfFO7jg38WgBipZA
	 xEH5nuRqkAlsubpdDWMvPNjjhdldRQFZuAeIT/nzFW1tpr/CqzsJpKyhYwkQk1yumHA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986731;
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
	bh=NwQw/Qhm/3DyzCAZ0QUMsPWQJ75PNFDp/MNgGf8Z2C4=;
	b=F43uU6OldlEFfMHYyFbA7OhizeCxGRjKZ1YXT7S8bmMj3UalwoxJkP2tLfLWGFq1FUfw
	 Ha95WbDrvJRrYqwLaYKPahEMtT3KkDjzVYOBDBEm46eT8pdwHZIJdnPd+7fcbeJWA567+
	 azAdJOIalsObR/t3kQgDel5fs8yeNqAx4UBK1cpYNgr8+3Ak6n/L/RTa/zlmOkXswKCtU
	 JvaOEy0YgKn8a7GTPxtP+RgC0EypBuk07+6X1FltJj1xrYdJMSnMSFIlROq+Urn17EQCA
	 nWLzi8h8dnSWjPPImXYcdU7sh3k4Yep56PMKUAnsyvjTWlOxwKgofQLHEq1kzBuCW5w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=grfen106;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.33
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013033.outbound.protection.outlook.com [52.101.83.33])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB77A606A326;
	Fri,  6 Nov 2026 17:38:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BB77A606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=grfen106
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=bYYZoJDYLS5LfXVxtj2CH44miu9vNl+f3yP4yIK9caqi/NKiehZngFsu9gsLVI7weme4pQTiV5d1VW/jpD8YGMO07zl9OEKiL5HfAB6PMSKzk+jkEctwAGYt2Sm3rKXUpC0weMyMtYgl3DH+nYULcaOYuLXFhTq9kXI0LjR/LkvO1RBlYXh2KoCEWPwfoC1zMrmSo2cRKQeat6nd6r4rP0odZrUTR5otNETY9aAMEI78th5fhHmqysWLEo5805d2q3QFJDic2yHuIn4S3apRY5Y7YvX7Jftqlnq3Z1BXwj5iXGMSE4hUFQr3pDYngRl1jG0Es8YvlJRrPryfjozqqA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwQw/Qhm/3DyzCAZ0QUMsPWQJ75PNFDp/MNgGf8Z2C4=;
 b=PswK5LlqWsTzHlVp5J1TbHIbicezMCn4qqOVKF7Cy3Vvh7g+9pL9pldIsRlvCesuNxmABtkAMhfUWXX1gDbtfs7lY3CKVkWuAwYK3jOddPvhk1bGjxBQnUnK24oOobjeXQD2su8acSnJtL17cgIku7PSGrljZIYMo5ZSXR3buTjAKHoRcRC0/dZhuNq4PchGDjsKX/qJ5XPEbHuDiyIBVqUXc36kSbPfCnIy8RKZ416D+ZhbnuuqIn2sHhyX/gPEMbapaCodDGbKSw1teMA+DW8gDUhlKbag00SjBRvPW6jIVzmxU1xJdYDRRfFP8sDis5WLq7OSc6aEmMaAorzJWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwQw/Qhm/3DyzCAZ0QUMsPWQJ75PNFDp/MNgGf8Z2C4=;
 b=grfen106kCGC8BlHkgMx2UvYJAnoWZaNiD0j/Hdc1dYMsA26Eri5GY0aCSrxFXPGcTkZmNo5jh2wqGqGTpQeKvKySetOJtxEXfLFtoOmnNNqBLnb9RGPBimLXtyOVv5Z/+VdXvvpNkZ3muFtZE76TKOsZ/2h1IQeWF4057TBhDW8gbOdLTAFw1X98Wa/4r3RVKXWih7DRm/RzJhzFvy7l2xwUG1fQfNAhcnGQ/f59a4kS+GMx2gx5LHd9JWB/6LIm3R/pXcEV0m4iRrXQFPE5gQNv00mGyUuWhx49Xm52q6fBnQVNaz9lqXoroJ8sRysFT0GAL+AE2j0Ui2d2feObQ==
Received: from PA7P264CA0135.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::6)
 by PR3PR10MB3884.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:28::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.5; Fri, 6 Nov 2026
 17:38:45 +0000
Received: from MI3PEPF00008551.eurprd05.prod.outlook.com
 (2603:10a6:102:36e:cafe::93) by PA7P264CA0135.outlook.office365.com
 (2603:10a6:102:36e::6) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 17:38:45 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008551.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 17:38:45 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:39:22 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:38:36 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 6 Nov 2026 18:38:23 +0100
Subject: [PATCH v3 3/6] usb: dwc2: fix a possible interrupt storm on
 stm32mp1
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
Message-ID: <20261106-dwc2-low-power-fixes-stm32-v3-3-68d2a0e9bab6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008551:EE_|PR3PR10MB3884:EE_
X-MS-Office365-Filtering-Correlation-Id: 5b2e00ec-1197-44ea-622a-08df3c2cce9d
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|7416014|23010399003|376014|18002099003|22082099003|10067099003|11063799006|5023799004|261026140227099003|261026121527099003|261102123227099003|261028144727099003|261021123027099003|261022105027099003|261022075727099003|261021121427099003|56012099006|261009223027099003;
X-Microsoft-Antispam-Message-Info:
	M8Yh/4RJu0ir+SfMidCt96k63p8PvcDVxEdGCrceN8Z4uErJvJ9e+fmlpn1eAQ6kmoFEJu3I4MqanWJN8h204M55gHXhcW+/mLrEV+ghztuJiPXpZK7ncfw+4i5tkmJD19Tz+WFH0OLuupuQd3ho8Z2nHundfctf4acyDEWk5EL4bpogzJopIT2amgtuInUv0oq8pzIVXNi5oe6h2NfnRKQFQcmlNdfjojc7VP0sst3GNw9zj55kmJgxV6TKfe/j09heRtYpMM7WB5s+qezPnHc090GmsLQhIOs/3aOuLiYbzxEtpZZL2zI8Sr+MLRHgGXCxFoJgKQ2lBVFxvDhaYjqkYwmZj8iI/2wBbeZHd/5XMjyiorYzxytIQX/gPMm71bMst7iV8qpTm6KxQFI2yUeMBFPUJAfuj+MsJpAtuGceGPA6jOZni+AfoOJG36KSh8EKDBYSkQEes98RyoYhoGW++jC5gc2MlHhhO2o1Jx/TJkDzesleG7oy41oLmJdjUhEB8VVtLDZEOCG71R/+xdnrr4X+csSSD89xWqE/ijzTtTC1osBv1Qgfg1IH9P76qzlW2LNvUiM1lnj3cJAqYRDlMYA08JMmBgZ7k4scmuNGOuKEGU2sU+s26ZyvUd48xpc5KyvRexPJuzd2S0ItYQZnhyA/ApWpdju3PniBRS5eGmSLyzD2/3BdqwvI8HiqrGeYD5sNYplPFFzJmWEGtg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(7416014)(23010399003)(376014)(18002099003)(22082099003)(10067099003)(11063799006)(5023799004)(261026140227099003)(261026121527099003)(261102123227099003)(261028144727099003)(261021123027099003)(261022105027099003)(261022075727099003)(261021121427099003)(56012099006)(261009223027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	5J2dUwBcnvmzFIkOFcVUkfyHEBzG6TlIVLl/91lprYT5xgYADiHhcGQWD1wxXUAKl4KMwQR1K8Xu8MhOspr496LVq7msWBTGOaTeOqMhAJ6YDzVg1IyAn7RHd7v6BN78N7vNV+ZDLq/YdDsqOvHIwnd6npzfIjVHq4bSAGn6xfx3yzR6N/wdbCpN9JOrPCPqM1CZ0VrjmSWmvanGyQ03/lP+ygZgmNJ0lA4mAaXnJYScHy0Xx0eP26FvBwph22f+0dmUjgXuuJYJhJGgeXCaT2E/dgnMzUVXRCbJeEd7A/XXvFY7uSzhOwMEWO0uI+vySU8YHMMNI3dExfAYrgZnS+kVwL4EBaiv/KQlYtrXq2tUYPg8yYmE7OvumB0UunQ3yfd8E6A0hUe5jget5LvaBQ4sT5B+CHi8nyOgJCv3GU7RnNGgha91qHzFUOcrvfRH
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:38:45.2142
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5b2e00ec-1197-44ea-622a-08df3c2cce9d
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008551.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PR3PR10MB3884

On stm32mp1, upon resume from low power (stop) mode, in host mode, a
port interrupt storm may be seen before the hardware is accessible.

The core is able to generate interrupts during system resume in
platform.c when calling dwc2_resume()->__dwc2_lowlevel_hw_enable(). As
the PHY and clocks become available, a resume IRQ can be seen with a
Host Port Interrupt (PrtInt).

The wakeup interrupt handler make the controller to exit power down mode,
but the HCD handler returns IRQ_NONE, due to the HW accessible flag has
been cleared in _dwc2_hcd_suspend() earlier. It ends-up with the bad_irq
handler.

So set the HCD_FLAG_HW_ACCESSIBLE flag when the resume IRQ is handled to
exit from power down mode.

Fixes: ef5e0eec4764 ("usb: dwc2: Add clock gating exiting flow by system resume")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v3:
- Set HCD_FLAG_HW_ACCESSIBLE only when dwc2_exit_partial_power_down()
  succeeds.

Changes in v2:
- Add check on hcd before setting HCD_FLAG_HW_ACCESSIBLE flag, to avoid a
  NULL pointer dereference on hcd in peripheral-only mode as raised by
  Sashiko.
- Add same handling in PPD mode as raised by Sashiko. Only handle clock
  gating and partial power down mode (PPD) as pre-existing wakeup handler
  manages these two modes. I don't have Hibernation capable hardware to
  cross-check this mode.
---
 drivers/usb/dwc2/core_intr.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc2/core_intr.c b/drivers/usb/dwc2/core_intr.c
index 9565e6a52725..df9f6b963fb8 100644
--- a/drivers/usb/dwc2/core_intr.c
+++ b/drivers/usb/dwc2/core_intr.c
@@ -453,18 +453,25 @@ static void dwc2_handle_wakeup_detected_intr(struct dwc2_hsotg *hsotg)
 		}
 	} else {
 		if (hsotg->lx_state == DWC2_L2) {
+			struct usb_hcd *hcd = hsotg->priv;
+
 			if (hsotg->in_ppd) {
 				ret = dwc2_exit_partial_power_down(hsotg, 1,
 								   true);
 				if (ret)
 					dev_err(hsotg->dev,
 						"exit partial_power_down failed\n");
+				else if (hcd)
+					set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
 			}
 
 			if (hsotg->params.power_down ==
 			    DWC2_POWER_DOWN_PARAM_NONE && hsotg->bus_suspended &&
-			    !hsotg->params.no_clock_gating)
+			    !hsotg->params.no_clock_gating) {
 				dwc2_host_exit_clock_gating(hsotg, 1);
+				if (hcd)
+					set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+			}
 
 			/*
 			 * If we've got this quirk then the PHY is stuck upon

-- 
2.43.0

