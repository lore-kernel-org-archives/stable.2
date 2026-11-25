Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.61
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795624379;
	b=WpOtfVRi/DlDl9EYYprp3QlEUUu+M6GvWR9dnB5SkpCqoJuZ/WhQA2xcbDz+ifWDBaQa
	 qGTYa9mOW2KZ0j+SFlXsivoRDl2HXhom5lMakBjdmgC+27+YKtFya9PCxOsCG+unBJ5QM
	 OUgK5+bBN1b9mka2VI450Ckgxjt9jh6rV02KGLZRwURzNsnwDrHuoiyRnm0nFC7k7iP+X
	 G7FDKmgSitJzKBGR/Y5gRdQ02DQpd58rjD5vRXDFtzjYyWN0NvCydv9Dge1WXiV6wez3N
	 WnJ3o5NYNp6LCmxdvcPKiGKmIArxwbCaBXK8RNDYCTBLQYo0E9h01iR1mDqA65g029A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795624379;
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
	b=Xt/SjLlk9XOowI1FtvVZvnsrpPyaSeCOPSgy9moZHEL4ytSVQMZoiE8xymTaT3tfOj8u
	 MPx6fDIg4wE8mkKp919Qco2ddr1NEInNEtU4CHXIBOHk3RyxzKPwkPu9ICX1pry8bOt5P
	 3mCxDlANS23LaLcamZgKN4J+V1uwFAF4KbU5LAFvQfwnBiGD1SmAWRsBAQrKNboFz7nXb
	 2kKTdHbwZ5Wv+5ydcIN07CZU0muJ5f7NG28D5KLok+G2vTlUmmIit/VDXGpRyDbWeOQ+z
	 nwHPS2HjY8Qp6dUTbtxUmkXntX7stvgW3OIoFgfCQDVvrVQKz5CPvI8uJAO+IycY9pg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=DHiH+iWF;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.72.61
Received: from AM0PR02CU008.outbound.protection.outlook.com (mail-westeuropeazon11013061.outbound.protection.outlook.com [52.101.72.61])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE2AD606A689;
	Wed, 25 Nov 2026 16:32:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AE2AD606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=DHiH+iWF
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=ean2NZD1b5Oz6v0ImVIdUd9515nbEGf7sN3nneHs9HfAh6OXvGGUclrUDFzQrra2I2BRlscbNyfLBB7LAdjpmpEmmRLiVxdCvCDICdTT3XgOEjn4HLFvF+4XOfWJ10JeOIm3/lzJY3dbKSuKhymzHUHDfiffwFsCw/lEdBf/ZOOEJGTYsZ9299vDfNEYSCkuuvjUEDUx7u39PLv5H7x2ueoBNv27lCf3qynIFLHHRemjjDCTXRT1ISZMGTSPH59nlIhhITMgfVvVH6u3MlK3hIfAuwc/ad+d8yU+lzlgzK/vA7veWfUnPy6PSiBmueGc63jFOeAeiH6SgYLyOboAww==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NwQw/Qhm/3DyzCAZ0QUMsPWQJ75PNFDp/MNgGf8Z2C4=;
 b=o/oz/A9j7JkJfvdyb6/yBPZSuD1Z6MiEs6evxQD1Pvfm/nLBJZVefa4qdKeJl4Sv93VWREO5oeMLbYGL2S8dM8F4qhfAmR/jAqGRApU82a7/y+D159lWdJfVS9Vpp08D7rQ+5nUTb3ReC8QDeh5hLfj2BLx8JxSVxsDsXt1rcCuTY1IA1u6oD8C4Nmt5CERO2f7U7w6ZoVhaZnnGnAbvV0/ObYMGHKwLGdGHGWlLxe+GWerlzwLliCHX3ouGrFqbOMiTIDB5QxibaRzTu5nKf00vw5VL+G66xzMDOa1ichpo5s91Em5nSAq7DXI1W6erhFqFH1Zd8Nno0ZrAjnbwlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=st-md-mailman.stormreply.com
 smtp.mailfrom=foss.st.com; dmarc=fail (p=none sp=none pct=100) action=none
 header.from=foss.st.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NwQw/Qhm/3DyzCAZ0QUMsPWQJ75PNFDp/MNgGf8Z2C4=;
 b=DHiH+iWFFANZEZEqvHAX384O7mUgflORn1VkcRL/usgpcazJwLVU8zmYgP7Kj+ByAHtrxS061ZCmrtaFTCj478t/YJDk8D9v8rIx/m0KWyxa5IAXzH3dFDKpHTgLPgbuCL4FKLuiKA6XO7k+kFrHyof1S3NB8uK6fFFsreeABW0ebxsqZTYaVNuCfFlU4TaX0E5Q235jlNeiELeBOmhWjINs/l9YaUMbL3YfR6HdzcDIpRgpZM+w5aQjW67rXGzVaRCFDa+qhJ8ydxUysL9byRNxF2ec8pYV8MXzmFTMed+ojXcfrJfqZrmSQV3aZLgK2EzaV6XijNnFqf7d2/q+qw==
Received: from GV2PEPF0004811E.SWEP280.PROD.OUTLOOK.COM
 (2603:10a6:158:400::1ef) by VI0PR10MB8747.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:800:234::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.4; Wed, 25 Nov
 2026 16:32:50 +0000
Received: from WA1PEPF00009B3A.eurprd05.prod.outlook.com (2603:10a6:1d8::118)
 by GV2PEPF0004811E.outlook.office365.com (2603:10a6:158:400::1ef) with
 Microsoft SMTP Server (version=TLS1_3, cipher=TLS_AES_256_GCM_SHA384) id
 15.21.615.10 via Frontend Transport; Wed, 25 Nov 2026 16:32:49 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 WA1PEPF00009B3A.mail.protection.outlook.com (10.167.242.40) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.3 via Frontend Transport; Wed, 25 Nov 2026 16:32:49 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Wed, 25 Nov
 2026 17:33:36 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 25 Nov
 2026 17:32:47 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 25 Nov 2026 17:32:07 +0100
Subject: [PATCH v6 06/11] usb: dwc2: fix a possible interrupt storm on
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
Message-ID: <20261125-dwc2-low-power-fixes-stm32-v6-6-d5df33b93eaf@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: WA1PEPF00009B3A:EE_|VI0PR10MB8747:EE_
X-MS-Office365-Filtering-Correlation-Id: 866a7004-aa1a-4221-1fca-08df4b11bee2
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|36860700016|1800799024|376014|7416014|23010399003|18002099003|22082099003|261009223027099003|5023799004|56012099006|11063799006|261026140227099003|261022075727099003|261028144727099003|261021121427099003|261021123027099003|261102123227099003|261026121527099003|261022105027099003|10067099003;
X-Microsoft-Antispam-Message-Info:
	MvCuz1BIUnYA064fkFjGhpTLdqWgDca4Ja1sKNaFoRP8pmHBtEpALiklK7xs6mjqLGhFCqgoiWTr08JVOi72tMoFrhOMWOpKVD6aovJ02rrZgn6dDeWBlaIM/CBHCJY+fwmvc0t/pF+Hy1xGv3YpNoGJoz1qeCKRePxfzJ79FlkgUC9nIfk1zJv3+iHrG6hD0mpGaNnOpSxXxccKT6XsCzpxrF9msC5j4xl2O6Mmej5jHaq78Z5zdBkfpsHpOhoaVbuROV7CzRK/Tg1p2sEPn6KLa6QCUxSqbVpcgWI390uUF0Lduz2dI6UBZWeu/84tnetVfxnijQUsUDb6+3gMSVYiKlOEgeVxCczwjbN9AmQr1/sv2dUmlVJU0/dcyfIHDNoGKjx3Tedu54hGyflYC5rVSI18RAmdsPZ5+RwHTAscmapb1UonrY1MZAelgDGoEwaKN286/GBF9cf8h4KYrfaRBClMSlFMgiIQ0+rQe5TtPsM89Hx+2d6CXPUtbbfnUxaaE0y2wForvscPwKCQFNkjNCUo9FTGBNQLzWuI3i+hNlv8tzb5Chk4WMwyG4wWKAxpc8cHs9dz9gbM1yXvTnsh9sc03F4h5NRV9NZpErs8cHOrRxb3t6Fbpt1NXppQk8RUKU2qmw4Ev4QL5mr4SxrsoRxTgaMp0LTnWZc+CRakEMNdILwKjtqZedsKhCgDVe8hg9wizLcogu/RaPiHsA==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(36860700016)(1800799024)(376014)(7416014)(23010399003)(18002099003)(22082099003)(261009223027099003)(5023799004)(56012099006)(11063799006)(261026140227099003)(261022075727099003)(261028144727099003)(261021121427099003)(261021123027099003)(261102123227099003)(261026121527099003)(261022105027099003)(10067099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	jmb/KIYcLTdj03ERfO+e/sPt+erpE4yVrQSz//wvcxjhcQaupT5bkZSUvDdM+b3Eh9vNL6B4ZFi5JNgnMMHYvFaFBczNkLo4EMgEOB+SqTvj437JAfZo7DVngIe+MFv8R+WInl6cClpQe69VnIxSYfDmtI335hCPyIMFhxQx0nAME4SvuWDILfHfHWHI9kYlz7QTkQRLtvP5+Yt/gXV8aToKM9ZvLCf5VgzvO7mQtRK9ZjIXI3bM9sJI9bu1VBKECysTJe1FFiO8E5NIsY/dbpAr1pKU3Q6VpR+CrfHSge4aZfIX2J/k2bHFEwmDMo32vbYuXbAZJc7q3+BmHKF79IbXX0UitiK9UqQmWAOuh7C7t9FkRveN21/JnWjsurTJ/NF61jT2+fN1p3/rOyZMCeASgDHubT2HsukF922+72hCE0+ACBhXuAGCrlzlJfFO
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Nov 2026 16:32:49.7855
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 866a7004-aa1a-4221-1fca-08df4b11bee2
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	WA1PEPF00009B3A.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI0PR10MB8747

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

