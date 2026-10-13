Received: from DB3PR0202CU003.outbound.protection.outlook.com (mail-northeuropeazon11010022.outbound.protection.outlook.com [52.101.84.22])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7DF84EFFCF;
	Tue, 13 Oct 2026 13:16:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.84.22
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791897362; cv=fail; b=Yhwn12fJXrY2f7FsBMvXVsyt+g0dw164peMHCtt7mLJ0xsCmsjuFoIX2gj4zZqHy/Ce5Yq79h78m5WWycGDc3EXSKbhOYHejm2fmIjKEgJGVuaBSTwOyGIDayOym+otc3AOUSEGs9I8Wy4itCQuCdXfGBkxKVL52lwUzf/Wrpds=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791897362; c=relaxed/simple;
	bh=bMkOgHgNXyt3rm2Dl/F31VxNdMGqA+2Yrb6jhAydqlE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=toQzRS7KXFJPaxVbywlxYdK6Da5fQzPxpk2GiL749QycGVegfM833/0PG0QObdQpXHHJGcQCoYwCJn5DnMVsDB3MGFfsfgJgVlhbHKFTkur7vIH5BlkKSdh/T3jw3bXUfe0BjoY1h7f4vvvBYw/3Dlk2Y2PI/doz9SOoX/H00cM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ZNH2MerO; arc=fail smtp.client-ip=52.101.84.22
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ZNH2MerO"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=t+0M/kIi+Jl8AZe7L4Gtq7mtkX20YU7MosIBewkXBxmDGQi7bLX7jsWKubhwR1BW25D1szjHCrJpaE+eP5IWjUsoSNzfFmpURW3vzHcIvw1bmUESJuTs2JxdW6k6XnKD2FDDxrBOR8QTn/ZDDmhxoUUeG0xbndkBnxXTO4iOuuPdebwgNF6UY1xsl5g1AQAp/bpzzg+B5+b1XD8bbZk7V/qioQQprw2ZFZmpDfcecFAEcZkAyI3lf0uh9oPbH/LSgVbLrII4thL2NXNEZkiQTy/0uTmT1XSdnyhYrv/rPD0zCCQbxBjhP0TPZE+z0YXt+AcM5jCf4Ebo4knaQWKydg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fyM6lnO790xtDQr+nZ0IMfDrCo2w7FAHqFEyTtRbJg8=;
 b=PLchHCzqCibwdw/R9UwU+eURXuuTZbbORjnWDIaCF0ZKBGV32l+dPXvfKxhdrFAjyjoxozoWSyzA/NGRssC0J7mhwb1k3pugOT5158DpfsZ8WCirmQ+nxxUtCMryRW1S1vpCg3Xd8gTmXMlUdxCmjtsnTyAErHB+kQ7xjEyjuslZz+Vg5O9k0YjNr6IcroSF5NHuFkKlY1+0cPNBZVGtGWf4ZoEMgecrFCsX7zQunxsWD7A5CkWUYFEDQj/8Jxew78qD0WGyTrFiRHN1RYH0UysSCMhelx5Q/vNy+XqyplTeS/NcA+P+ktugRd/bllcEKObsgnl6NbbRF13RmPkF/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=fyM6lnO790xtDQr+nZ0IMfDrCo2w7FAHqFEyTtRbJg8=;
 b=ZNH2MerOEoaJB3HZpUKvj3t0uCOveCtjR631nqTe0U/8ui6F19fPPdvR5eWfYhoDf/ojGNU0oWzf6wG7oJADGl3oQtRYIjUGKzUYA+ImJAoTYuV4KFYps/6Xx7x6OcBbVziBanQWT6IEDaEfskSQAIKoChuhEBjPAaQysqkUbOCmiFkSDNccIs7JeK6nwDNGW7+i1FmCjPDdBPdQ1NM0BfzrQJva0xCCiJaO93ZPnhKDc+1XkW66L84OftmPsrwKjQmjCTCVZjmL5/JLR1ODb3IqZNoI2k2cpD067kU2R2gCo30mPJfbL96IZ+7AlszFm53g8umYKpc50nUuGjPxcA==
Received: from AS9PR06CA0729.eurprd06.prod.outlook.com (2603:10a6:20b:487::24)
 by DB4PR10MB6989.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3f7::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.496.18; Tue, 13 Oct
 2026 13:15:57 +0000
Received: from AM1PEPF000C1AD5.eurprd02.prod.outlook.com
 (2603:10a6:20b:487:cafe::40) by AS9PR06CA0729.outlook.office365.com
 (2603:10a6:20b:487::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.496.5 via Frontend Transport; Tue, 13
 Oct 2026 13:15:57 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM1PEPF000C1AD5.mail.protection.outlook.com (10.167.242.100) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Tue, 13 Oct 2026 13:15:56 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 15:16:10 +0200
Received: from localhost (10.252.6.143) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 13 Oct
 2026 15:15:55 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Tue, 13 Oct 2026 15:15:06 +0200
Subject: [PATCH v2 2/5] usb: dwc2: fix a possible interrupt storm on
 stm32mp1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261013-dwc2-low-power-fixes-stm32-v2-2-79865a4f1b63@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: AM1PEPF000C1AD5:EE_|DB4PR10MB6989:EE_
X-MS-Office365-Filtering-Correlation-Id: e4e180bd-b343-4828-51a4-08df292c1dfc
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|82310400026|36860700016|34020700016|1800799024|7416014|376014|18002099003|10067099003|22082099003|11063799006|261009223027099003|5023799004|56012099006;
X-Microsoft-Antispam-Message-Info:
	jGaQ2kyZr52lMhiMCxkh59/xAtZ3zDYpMEamiVeEs+alHblJuhxsPo9gfhRFdB4bOUZG4xLrutEI6z2AQ1UVM9hri08o100oB+KmpqT0+TUvxyqtddvOfKRsdKA0jTCzdlaJLqhC5+R9bWAUx191hcKMHmrvw1BRSLyYvH9sdhFr3DBYURVugWlXZwlrLvO1tk3afFIkzVlmfZjY7GbpJX6NjzDnTfBUtU3S23VZSl2Bh2HV+gw1oCU5qnOXN9yrPklatBcRybmVdqt7Yvsz5p2bBFLJGSU35sX+kX58kaiiPoMU4gHZ67/wWGvyg4a7URCYUXayx8Mb/LYIhrpwqXDhFCwGCQR7cCMXf67pGnWx3+8uBAIaW76WNCbiKnkQSrPl6J33UEqvPw+/SBIRcnbgsfHxVEJ4Oe8r0QueiDMzOm95PXzOki5MJmYkOBawr96mhGPXltM7ah0Cy1aZm10uH+HmODZfNeSWRrIR/QdmTq+iw7f8G4YN396WFqjhYXk0y/tVEUuWgd+6+7VPZAyUKLvWMUKo0MOhz4aYSbVbskJenQGWo/lcX+0OoJM8wAl2YvrEy31DVTdiQBYZcL116yDCBTbSbBGXwtnHOqGogWh7Y9oGeEawFz+cPBp2tjeU4qv1fMmJoiImTu6/I73fcGSN6kSBMD7Kx35wxeuTOMThrV/52xRdInUIIi0PYsEjjHvvxzunFY6c09rrEw==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(82310400026)(36860700016)(34020700016)(1800799024)(7416014)(376014)(18002099003)(10067099003)(22082099003)(11063799006)(261009223027099003)(5023799004)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Jeyvy69PLx6lAnJgcDy7efzcH8XRiaF8aPdEJ9Q7bRFCaN3Dz32mIpIOuj2MHbWx+6+iuTQQAJkWlnk+y9SS5ukTrfDdT5DZF8DNsLBzmkr/9bPrkNensIFYpnMmVlH3/RK/5C6zyK0dgYvz5/MY6sFDksulAfOm2JX6U995V3Lu1lfYLUwlQ+lAbzzG8ZSjbffwCy1W0SJxW38qNTe3zxWqGwz01AHFnIZf6sjDE0LUdX3RnUh+UZhfB6VXt/6CWvlp+dLYq3qBITPdbsllJ8IgEBWGoM7VxBsY9HlC/mCOIDt9m3idmA6zSADxxR/5+j2iOaESTodyBlZxkCt7hYQ61U6tIST8CY32/566b/OCSQvVuOxppDW6iveynAeZ+5MCPIBeGOk5/IPUd7FTwaqSZclZgQLkDXioZmlBuEiO7ajaV4OCdiLhPCUHNJUX
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Oct 2026 13:15:56.7407
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: e4e180bd-b343-4828-51a4-08df292c1dfc
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM1PEPF000C1AD5.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB4PR10MB6989

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
index 9565e6a52725..f6d5983d468a 100644
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
+				if (hcd)
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

