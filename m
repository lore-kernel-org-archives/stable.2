Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794595703;
	b=kPn1mdK8gGM8Q7+HzLd8R8IiZ5B2nXp9wfjditpoztzbivzOfZ3DvvJYrDOFwRTn6El0
	 aQCeWGopbwUNRFJ09WhgzJPK+R61PBTxil6bDsVK3JPJnX2/geA5CI5LSBeS48weaZUzL
	 HkkVbQobC648VFgC08cCIwA6NcjMQ+OlTqFR1KtNM7ag48g/PqVM4rKTtEdwBJdjAK+mI
	 NFgwRs4wZQoMeDYbrTpiCpXD4PTM3ttjPp18Ssv7KSBEqR0YuASzWBL/P9sHgLzx0dIm3
	 iveeAJ5x1PNphr8IBmd5YvHKuBLlRIjZwCPztqQBgFJYw8aS9VGy3lgezyXWJUKzbQA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794595703;
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
	b=NRVo304csf0VlHe0PfWZV1cJLm+TFZPE+sOOPwtrbupYtB3EVLtrTGn/J7X9josyKFeI
	 hTpJCiHlYFE5GTEfeKgGr4jhKtKApwvfZdNRqqoicUCIxumYP5g8ZyW1+FD27YVhfqKOX
	 nw95LZEh3n7fmABAU03y1xHBB/+XiyS1vikmxwCwEtq5tX8//BVEUe211zUoUsuhWT/ZW
	 uvw723vS6doKiYe+XsSa6oVAU8rW6K9XMRjHsY3rsvJvBW6GUD8arFF/7UJ/qRPvxSvz7
	 1Nmxl/IMYQdOVL8ZAT9cRGwyAEr1F92KvXpYDnI5WQLL8X1oIGnbNkYVqihHAny7h+g==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b="ac7/DaCI";
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.61
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011061.outbound.protection.outlook.com [40.107.130.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFB14606A884;
	Fri, 13 Nov 2026 18:48:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DFB14606A884
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=ac7/DaCI
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=hz49x7BA94HUprUbWQL9caUqydjpZIoLAtzL3jTUhmpjz+/EPrLQOFxfBmW3QqvFT9caQFla4o1Y5tQYWf5Gg4+iav1lU+pO9iOgt1k5adfq9FXuEfgZlAEfWUC/3+QXMmqonXnMbDS0eRAQZZ49VFQUFb/j3CJ+T1pmsjiIMbi438iBDJoo5XMyuZjiVJwq/1UZYnHdm6XxCcZam388c2xROZ0POA81iHR9/46kLu29zOkqVa8ekHJ85L4C1AHp6+BRyRymknd+NtJYilf6yYF4A2yr5B3Ffd4nEbbC+zVj8/622yb5/4r/vS9acpMhad8yS/n958cvTESj5ZpLlA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwQw/Qhm/3DyzCAZ0QUMsPWQJ75PNFDp/MNgGf8Z2C4=;
 b=qBJuUxOR9gFW0vWAisgueXOriicZ6dLUeVJqqb9SH+tSnv8FJ2xi9Roo2vglxD4Qq4HLjwEHiKpGrLulvOHXgrJDoR/SkDjwkwRIBMOH/9pUviRAse/04CqWOfksnPLINK6S1fJq/zG2oM4/Ksagdc7zGhJ34Dz3yoi2ulN8GmPgJ3SRxwNX1ldzUHSdi57dwO3PZ68VwKeYUpJIYHdDcDwiBs+PitbmFJwqHt37RfQD8rz5e5SmVaNby2FashuGe4Wvl+IkiiYcPTZB3CIRwGOI0oEnQDt7AgtzIIKgmhohnJ1jnwUx578gGMsX1CDPureOio/gf4deQlMSbOUgVQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwQw/Qhm/3DyzCAZ0QUMsPWQJ75PNFDp/MNgGf8Z2C4=;
 b=ac7/DaCIyW47MXsnQK0L2mK/wSpWPnyM0JsQjAwphE1pUk43oosQfC5XSxVszOwh8GKR1W5N6IrG3fTuVo53AaiiPuJ0QLIhziC0R0FKZO5xJlYQy04kgaJ3vMa7HjjvnzmkKuJzF551OA54KTIfjiMb+2F67ieP5r+PJb9vpptFD/XDSwTgJMstEeNinWyOOqOb+Xtp16H83w/cid8bmXq+vvX4GEMAkwmvoguSUKjpngxc5vx6p7Kf3BAtUMtU0IKYAJq0FhNSKJZnWylYRR4z+CuZvQmKaUIi8DYNve6jlrdhn5SPJjuFkLfSMoG+/AwlNfC07PFY4mahIcnaDw==
Received: from PA7P264CA0142.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:377::10)
 by MI3PR10MB890059.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:290:9c::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.8; Fri, 13 Nov
 2026 18:48:19 +0000
Received: from MI3PEPF00008481.eurprd02.prod.outlook.com
 (2603:10a6:102:377:cafe::4c) by PA7P264CA0142.outlook.office365.com
 (2603:10a6:102:377::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.615.9 via Frontend Transport; Fri, 13
 Nov 2026 18:48:19 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008481.mail.protection.outlook.com (10.167.240.168) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 13 Nov 2026 18:48:18 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 13 Nov
 2026 19:49:00 +0100
Received: from localhost (10.252.31.200) by STKDAG1NODE2.st.com
 (10.75.128.133) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 13 Nov
 2026 19:48:17 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 13 Nov 2026 19:48:00 +0100
Subject: [PATCH v4 3/6] usb: dwc2: fix a possible interrupt storm on
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
Message-ID: <20261113-dwc2-low-power-fixes-stm32-v4-3-08a8c962a09e@foss.st.com>
References: <20261113-dwc2-low-power-fixes-stm32-v4-0-08a8c962a09e@foss.st.com>
In-Reply-To: <20261113-dwc2-low-power-fixes-stm32-v4-0-08a8c962a09e@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008481:EE_|MI3PR10MB890059:EE_
X-MS-Office365-Filtering-Correlation-Id: e87af19f-5a3b-4a35-dcd0-08df41b6aed6
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|7416014|376014|82310400026|36860700016|261028144727099003|10067099003|261026121527099003|5023799004|11063799006|56012099006|261021121427099003|261022075727099003|261021123027099003|261022105027099003|261026140227099003|261102123227099003|261009223027099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	acM4fHhugAIsBvd35ikFN3GgOrSqL/NAr9q2VuM0FwcjyKJ46Q1HFB25eW8TNxCxayRnuyirQcIAjC06NlRR9g9+w3YR2trVCV5wGB/HNCuFVX+eErXdfQtzL6jtihd5V2YpdXH3onvCfjPDxDr3n/N254n2F5RNENi11qXQUxQRIu+fyBu1T1EBMM1IXY+/V+DZPTwL3uqAVz0OkYSIirNOp3+O3qeRuTTDLUa4dVSmsntfUN5sOh5c3gbSjRS4mQkmGspCADqQLWTMrky5UutoWwEUapY9Qs+uumB4O5EuX801Au5FGS3q4WDlRA52IoXEYfAy/tqBmaN84OOb+suPLWIZ7QUJmiHAku5eiBLKoIN/FzvMS/60UFFvIUD9IefIL6u9/n7ihfaMynZwbbJVrbT1Zylb/cIZ6TkpVJN3B7EaEaYwHSC7XNknDrdK7qoNeWGK5ywTPdQ2UFouDr/4pwynXeFmTmHTUYoBEQWTG3Pj+uTN6K1r0TeLLIXmko2g2OEZx2THcd2/uR/sXjY/s/ZpQINUc4brWOD7nkzuH0IB9JoUqBdKcyDKI3eOBVUQCd5qZ3xQ2IeVv8bR/ImAV1QV6qFUlz5005IcGIgpuFYrLDh6bJlnqnMw4/QnCT9jTp2vvsKBz5F0aUrrs3ZgWw0luV3J3OEVc4SDSHvjBdcaC4nNg9msGcjQM5vewUyb3UBtiMrvmxxzaACRZw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(7416014)(376014)(82310400026)(36860700016)(261028144727099003)(10067099003)(261026121527099003)(5023799004)(11063799006)(56012099006)(261021121427099003)(261022075727099003)(261021123027099003)(261022105027099003)(261026140227099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	s3ozDXuV64Ifrj6hoi672qXcfh/4nSR5FVFFmaBv4OJ3Q38CSC+31QoPGk3itanURoMxGoLOTYHxEv6lZdRwV2ed6TJX/7Sd0k6sj4XZB/76a4dofDlh9JKsyOTKDTgglMEb7tOehkKtrpy6mlYWxJssXVK46FDrD0J6tuZAU8t+ZhhYJTvIZdepGkZf/I46q6GkoYhLYbp7mNU0fBuOoEMlGPkiEbK6971/xPO0HCWHZtkhlK/ieWfk0XtqC4m6/3cWPrJU6EwlJas+1G81XrKPrrgvwNLNL4U5PC/HXf8P/ssHgH1vyuB3suR3Rw4xkPOHT1Af+/gIUxijlusZXaC2xmyoKMEaWdeGppzLwNSK+WDopXvvwHTwC8T/Ec25pdNU/xsgOHMEEHOwgDg0ta+gGYMpMX0PYBK8/TZR0rsjc+r4OJSMA0EyOxfkyRMo
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Nov 2026 18:48:18.2404
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e87af19f-5a3b-4a35-dcd0-08df41b6aed6
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008481.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MI3PR10MB890059

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

