Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.1
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794935190;
	b=rUcMh2LFzWrOTltDqBT0e4qiCGUf3+UldM4gzugzsmnpFS/ezn7b5F6DYXceisaVUojO
	 uhEEdFcjw/IXIntbdfn3oA+vFYkxVhiXkw7kMiH1zP+UZl9sXyo0QuprVGbnptN8W3rgX
	 ahwG7JWjB/Br6kHYHGMc3b0zBuraJ4uqDk0nXAwL1jyFlAPZSPsjnPscU2t4UDzqZ91/2
	 SELNOO/bCuCUQd//p9v+jRFXYCI5xDL4jLM98r+IzMTYWHxdiLNKVg3c0CvYcmILOWcsj
	 1a7iI/KlWIXzbzk7lrcRbvEuh8ycwm+Q20LbDeF4Mq/zvlepBkbCcOrcssm6IdEnWTQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794935190;
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
	b=NBD3VxVYIU73FRTZl5immb5fRES2rFs8TIZJRLZ+JZHQIJwNz3cHSURcWYczLgckav7e
	 +zPCNHqk12vPUCUKXLkw4uVX3paZ8bFFafMH5t93KQrX+Ypf/dHMEIe9lyEikbHELi3AV
	 FDvWAdbzmpHwm5jfXcoE8OtzJwHS70pn0pIpGnegi4G8yctb1qjhyJ+9j/Tmo/ybVBGhL
	 UlgIyxXAwaLm0B8IVfl7vKGNiR/VsAtU+MyPKdMdKQLIgISYFH873nA0Vj7oNPAk9Q/yh
	 xrkTW6ybvhRhWYjjY21NjtV1UTeAliRiq3zu9LXj5pZ3t5kHzOvlu/bX+2xrLql6PJQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=XrZsDbg5;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.69.1
Received: from AM0PR83CU005.outbound.protection.outlook.com (mail-westeuropeazon11010001.outbound.protection.outlook.com [52.101.69.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46CD6606A32A;
	Tue, 17 Nov 2026 17:06:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 46CD6606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=XrZsDbg5
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ipOro7fvbjUc7oyQ/j6H63Vi+6OV1CgC6bAJDAobZOn1bAHqN5s9zjCwksTNFKMk8go5mEQ6ItdWdjcL/TWz1nkFeh69DL+nBVfryFbHwWe8Au31DvvrebcLtTu6cnhF1LUZCcV4nvxNNX0dNL9MOUudBwlSbeCV9bPouUd3h7HDARYX/w8BKGgTKXHzEcLzisZK4dbBK6l12a7LQJ3La9fH9mnnz2ZDsaWh4EdX4gVBaks0VIowWyCvhEDZmeMMp0SEUOtEGPnQTYiIxxwvIxjnAw3zlzOJ1M1YnAFU/3AOBcVFQt1fBPqhxz/E4K1ycojxvczfSCxPfDaBuRKtFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwQw/Qhm/3DyzCAZ0QUMsPWQJ75PNFDp/MNgGf8Z2C4=;
 b=kGQwhw7ODZKb7XBLgibk9Lz55fssXVpfczOhU63PGphfsyw3qu3ys6tpbd5FPKJfRJNq5cSvA3e+mXRTATvDfjuK87OlHMcof1bcJ+p0u42NUc7T/9gMe1FXZxdrKVuirU9zddWNsBi1+ZdMgoHiBy7cWDVwVZfMITAHMwnT2JXMt08IQ8CmWUDaIJqNmR1Y74ZHqFHeSucfRkzvlViuT1kC0jp+Gclk9Q5rqGDcRLXtRdfotEjkPPKcYIn/uuBUTP8puybU8mT53rqLrL/hK53B0FMZFpglLFl4kOtM3sY/BiQ0074u+wzreTd9IM9FOsNEChH+A6pO3P+lo6jHNw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwQw/Qhm/3DyzCAZ0QUMsPWQJ75PNFDp/MNgGf8Z2C4=;
 b=XrZsDbg5cTZeLxKAm89WEiaW1MWFAxWsWVi+TY61YT54Okssa9ymkZjIwH8C58ctBZRQVY2r7l2VVl89gjRzMjvm9FQ79k1o1BEd2ch4+ao89TeBYyfXBD1OXDywd//o9B3EkzuUwo4a/9g6e7nxe28zk3SLEEe3SZgQev+6uNu/+bbKrM7QyvLyrKx8wYuHf5LnBJG12im6Oz5Il7GyZVq6YTzmU5fPdVV4b+BWohUnNIgt3PAuDarvUyQ0V9uB6CKT/xUGGDtk0jFZkEwMshTSyO3yg1ASV4sKjNGSzha3Pd1zf2gYVhLU+ueQgdBLPO7oXd0Jr+On907Mv7KaLA==
Received: from AS4P192CA0018.EURP192.PROD.OUTLOOK.COM (2603:10a6:20b:5e1::7)
 by DU4PR10MB8350.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:567::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.8; Tue, 17 Nov
 2026 17:06:25 +0000
Received: from AM2PEPF00070CF7.eurprd02.prod.outlook.com
 (2603:10a6:20b:5e1:cafe::70) by AS4P192CA0018.outlook.office365.com
 (2603:10a6:20b:5e1::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.14 via Frontend Transport; Tue,
 17 Nov 2026 17:06:24 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AM2PEPF00070CF7.mail.protection.outlook.com (10.167.242.9) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Tue, 17 Nov 2026 17:06:24 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Tue, 17 Nov
 2026 18:07:23 +0100
Received: from localhost (10.252.22.224) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 17 Nov
 2026 18:06:21 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 17 Nov 2026 18:06:07 +0100
Subject: [PATCH v5 3/7] usb: dwc2: fix a possible interrupt storm on
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
Message-ID: <20261117-dwc2-low-power-fixes-stm32-v5-3-0f197e0e6362@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM2PEPF00070CF7:EE_|DU4PR10MB8350:EE_
X-MS-Office365-Filtering-Correlation-Id: 355275a6-3b83-418c-4153-08df44cd1c6f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|7416014|376014|1800799024|82310400026|5023799004|56012099006|11063799006|261021121427099003|261021123027099003|10067099003|261102123227099003|261009223027099003|261026121527099003|261022105027099003|261026140227099003|261022075727099003|261028144727099003|18002099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	DSTBp1B9wMO/w+rR2CYX30gVTohxs6mOWN2ELDjkXi7v4N7ANq2Kx5C8elFOcUxDEGS2lj05aVnh7OawNlVGW+rMZphtnqiKPyuz93AeoN5MJ3+GxbO4ONNMH34C8IILwMGJWiqHngJhc1ZQ6iAHqHW1FB7D4oI0htv0yu4m0Q+PUklDSClwHizwLhVK2MNhTBNS+PGDh37NLQldKWOxP+cIb47w1fpDbzU1/tH64jrnLD1bcT1TWqw7VMzEzVsDl+ddiAWVczpB4cGNBFVXcDC+BivagLHhjl2xuwqctjdTRyqO67DygHlvDlaHpGz4uOLuTvF7RfEbCJvfZjoLZc2xhkivOXwkc/suHzO/T2ci1zcV4/OSZhyf+1mK+ugHRkYqOHqzgO7zSuUwkocbf406fIXJKRnYhDnVowpE9SxfayjhV5MMbQTf36JBXVpu7YKCxkZGDAu7tr6HFUxkvZwen9XaRwYQkcx3NVzBjxx4pa5kzgYL7HOdkGSuPa/2YF1kdXC1E73+l/55UJUTlRU4l9gnrpILtOS8nx3FNnn2QJR42bv1qXIDrSgMhmNPsAiWvRCjeAWR0CeVRkLyKAv6AS01wZDJOivZlmqK0WSBlLaq/Kj1Dl2xHbeWMY1xiNwkpZmfYSxg6rSaoQJmAu2Re4/c382TVYXw7DBnr/vd+KCFXna+/mhf7eAyOyeioHEeYipCbnGz7PxrT48iVg==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(7416014)(376014)(1800799024)(82310400026)(5023799004)(56012099006)(11063799006)(261021121427099003)(261021123027099003)(10067099003)(261102123227099003)(261009223027099003)(261026121527099003)(261022105027099003)(261026140227099003)(261022075727099003)(261028144727099003)(18002099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	VEK2Itw/DvIlo+tadlX7V7AqYe84uY/mMow6Ms8kEj2JSI0tZSP3X1P7I3MhR5RZ0Zs9IgU/SVUHtIsgA6zJNJ3ZKwTiY2wfosDLLnTOuWM0X+jVGqXy1MCLiUrIcV6agS/s7NpAbOiitLcDCUX9yFKvDpSHEQ7yTn5JKHKnzL3q6UfaKFcSxK7Gs8yOLxmowxvagV7GzQNNsOLP0BIl2IfouJG1NkvmaXRW49e1Si7IIN5wqJYsXYGqsZHNDAr6ZCdx3wQABDTbJafxv882/qgCyB2ZrOROyjVJAxRbkkv/TCzy2uSOTPXnJYzEiXm4VuNuAtZi9p+oPsLYEzc9iaNN7+CWYHJOB5Qn1VBuMyXT5uJLw17LSch/gIi6TeCsWNbDpabae/5yNA25FTSXE/thR98Z2mU3zI/QUv0skFo/ZE9Dws22vKvMLZ1gPVx0
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 17 Nov 2026 17:06:24.5107
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 355275a6-3b83-418c-4153-08df44cd1c6f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM2PEPF00070CF7.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU4PR10MB8350

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

