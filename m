Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.0
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793798479;
	b=U9Ea/+OJNj3GuKhE1g7S9op0lSzGAKclf/MUqNYol9sKWYg0lfEU8VEgCLOXddYSoXog
	 XYb5MYKpDZdnlrUm7JRxLb6k+Jyaj5pqK95hsQk7xjB7jetkW19sFOApC4kOwUVdvJbDE
	 90aVUBajRDK2Mc/LCxn7TFZM/ledMVV7gP0dxcYHk0kFzrk6VfTGfsk7LtYrbe7l4qo+R
	 xnBGQ8NiSnZDtstPWPh2Mvq5KPVkWHuSKlElmxzws3VR/KvytlQ7adSs4Oa93aUjHHUHz
	 q8SYYONDpmZ0TzfNlQjsbNC5vzykw+37Q7mbHItZ3I/MarjwavzpLGvRhgSdEYWCXKQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793798479;
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
	bh=9olOVdFS1aXF20Do/pamWcf+1hqtl+Wp40o1QDhN2wo=;
	b=f0A5aqr/uKejAxqTZoSrVACkxXGSpoVKzkTGxUUXnauIByEfiozufFVqtuUIPIq3V8Vv
	 KYeq3MDH/Z7ndb9deLffU+2qE3PxjumLh3ODsU3SCzyikpbqEzYPY+nWVv3N+9R6ITt+k
	 WoDvKwzyseqP7vgShK7Uw9C21VK1jjeu8rqn6HkQxr1DtQ5HVV2IhGEVKRdCWDbdL30x8
	 igORHgPMBLbaqRNq6YH1ip/FYUH6aEoGcq3odtZ1ZgvkydEA51Bu+4eyiHJ9cwgNu6xbf
	 YdoVilSQzDKoU4xG5JZ+fEt53Ao4fn51+D9D0eTcjHSiwGudeF8+vy0XlyRkQPurhlA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=SvLuDqM8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.0
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013000.outbound.protection.outlook.com [52.101.83.0])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2C08606A332;
	Wed,  4 Nov 2026 13:21:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2C08606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=SvLuDqM8
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=f09qZr/Y8DT8e4sUmstz4DvxnHzhfAtNvOrj2JCnHg/bZHqMoPj0APqXppE7j+FJuz/F5sjEJ/uTeu/N56XErRHIh+ZSszoC+Lr9qBUqeD+xfpnQnqG0Z0aHcDmx2wYoZ6QJzCrqHFkt3S6sacIfxjZTnLHkTJH0++pdgc9PVTchai6+/CzXaQumb63NxNlQP4rdlP50/kH9q/aEfgRZZjw2Sl7/h/l8PU39LBPzVC9TuAeTt56ZSP37CPnoH1w3DMd96mKZjB6AjaSLgIMhRttjCwGcAY9VPNKGId9J0ivjE/x1ef3M1q8a96mTVODTm+IdA3rCA+RcgWWS/g3MOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=9olOVdFS1aXF20Do/pamWcf+1hqtl+Wp40o1QDhN2wo=;
 b=RSKyP0GSZkc6SVR5BekfULZD+y3hc0uRIOr8ZDYSFEVncbTd9nqB2fyt8we+9m+xS/Di0o6gaay9MdCWHihEcVR+RGei8aT3nsNXvdg7bCDFwZlDforj8J60IsZT56EnvJvFqxMA3bEEqjKNMwW1mrS6kgsQtdyr2xiYBkja/jwgo9SQWS2dovTRJRcq2+AbHENo4YBNeTBL4vkikq5teEJRGhcDborbkqgUSnYVeHFAiocDMnUAl9Q5wLiEVXyO+M9cPy7OijC7akdgi9qkHEvu4ynC8iMfGHO7JfgobPH+TscKZuB6pfSEOu4QpdN5Dot2otxbi4C+9fwk9YMAng==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=9olOVdFS1aXF20Do/pamWcf+1hqtl+Wp40o1QDhN2wo=;
 b=SvLuDqM8U07kdYQu36x8K/b3uPDh68DKERT+tDFwnSp/sTMKa34Azew7xkAd2jrmlcveBOqYBoHkRlx+bMpg2kSvHfhBZBjE+88VAT1Ye2gmlLFNsHkXg1szS9PdsrKhq3EQGUuysyqXdUocZXjR3MnRIQZzjCClFsWqogwLljdeCS50JjXINyd8E7WbqGLEFK4iKLk7ab7d51wtMkyE6tn77/3CXR15o/Aa2xg85YwWeP/l9OAMKGWN4HLm8kzh+1gYcpH3X6Bg/u/38KUyPEeb6OFyUg1xSJkxi7EnkjcVgl9NGjIWkHwzu6q1d5ugjEvCfpfeT5jUngYVydpGPA==
Received: from AM7PR03CA0019.eurprd03.prod.outlook.com (2603:10a6:20b:130::29)
 by GV2PR10MB7536.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:150:d4::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.8; Wed, 4 Nov 2026
 13:21:14 +0000
Received: from AMS0EPF0000056D.eurprd02.prod.outlook.com
 (2603:10a6:20b:130:cafe::53) by AM7PR03CA0019.outlook.office365.com
 (2603:10a6:20b:130::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Wed, 4
 Nov 2026 13:21:14 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 AMS0EPF0000056D.mail.protection.outlook.com (10.167.242.123) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Wed, 4 Nov 2026 13:21:12 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 4 Nov
 2026 14:21:57 +0100
Received: from localhost (10.252.2.138) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 4 Nov
 2026 14:21:12 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 4 Nov 2026 14:20:15 +0100
Subject: [PATCH v2 1/2] usb: dwc2: fix fifo reinit in
 dwc2_hsotg_core_init_disconnected
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
Message-ID: <20261104-dwc2-fifo-fixes-v2-v2-1-2bb13820f662@foss.st.com>
References: <20261104-dwc2-fifo-fixes-v2-v2-0-2bb13820f662@foss.st.com>
In-Reply-To: <20261104-dwc2-fifo-fixes-v2-v2-0-2bb13820f662@foss.st.com>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<linux-stm32@st-md-mailman.stormreply.com>, <stable@vger.kernel.org>,
	"Fabrice Gasnier" <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AMS0EPF0000056D:EE_|GV2PR10MB7536:EE_
X-MS-Office365-Filtering-Correlation-Id: dec2212b-1aa1-4ccb-f326-08df3a767f8f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|23010399003|376014|36860700016|82310400026|261021123027099003|11063799006|56012099006|261028144727099003|261009223027099003|261021121427099003|261026140227099003|261022105027099003|10067099003|18002099003|261102123227099003|22082099003;
X-Microsoft-Antispam-Message-Info:
	NhPo+q06sor8y2XMOsWCpxNnMMXXJY1sM7pvD8Fe9lRJTgWCIPNUViO1ZHvmIM/4vJZ3HOltokZOo6EkmjCT6K5yLb16uCo7GoF8Tka9dWSrahBLp4yn2KOaELibcTgLx08I/omiHbGpGa7Gwqcdgzn8oZSczlLO8nzuYhvwQFKrQ5RmUUZGOFak0Jy1+kJm9aHQ/S/EM2Tp+rx2oGHGUs6Wvu5xhOLXvVQOz/8URW9U9495IKrubAx0hbIxDafNokWx/EvCEt2ncTCVHtO/7ZCvRsFZ3/iMQxC0WVrUAf6kmBpAA2dXNUbUCzvuZsL9krX3O8fCHsHh9nstDl36g9rsZaLOwr2An2833Qa7oB1JlxEgyG0XR7ilePpaky9f5dlOpg/xVrA/ZlwEc8uomxtSEIbQCrvdaCcgsig87aZ4EsZRYZuhWpZFVUfZFebwSUS2aWnZIxiE/DpMBYnSGpVKt4zAF6NU1QEeZTIrm7VvCrqR2KiTELaLVMR1ELSYMi6fxbiEdJ8WagoEcAPD8E5rItrTS7ugqx38hueGWcNqVuGE42BsiGXZ+QDO967j8apTiFoz8g7PdVrXTxZg1zZOENyz7IgNIqwQZDBjv9GpCTp5Js1CXATmbHzGy+psDFRt9o8rrrczOMNib2yTywgAjweeYT0LYNkXj0V2E7IxFuMrO4RI40VTWd3V/XChO88IKXz0ycWT2ZTdIR3X3w==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(23010399003)(376014)(36860700016)(82310400026)(261021123027099003)(11063799006)(56012099006)(261028144727099003)(261009223027099003)(261021121427099003)(261026140227099003)(261022105027099003)(10067099003)(18002099003)(261102123227099003)(22082099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	zuPFmG5lPdKr2VVKceFb97Vp3DWJXQLvmbIgS4UUUGCho1Mn4FxgEC+m4FUJqegluO2rPpZbltOYAHriV9B4E/3HFNIIm1B+pFrXMaG6EJUSAusiShdgGNqoKXV8kG+qZCWiaDDUfL/xfOG3O+ap+uxb8iH3O7Syg2x/USm3Pgs74xEnDNUT6EM0lKN1RpaoPjXKHbwVylqFAVBJH6ue8EXliQBeolLGKQGKJdY+qXCDE5JOjU+E4+RiHdYnbRKsji9UKxzfKwrT5FIRfsDpTrUNCsXqumt1R9/rm18EfO/8Q3G6MEVMrjrf1bL3d/xbDCDrlQPHVPzwPtCfNmH7ETzxbVmbexc0Tj2Oj03xoQLC+26ldagv0T+I7Ojz+Q0Wb7kg2RC2hii0hItla/6NLdcJthsheGr5/D1rvA3HcCcmw8YKHODWbGOJ4PH9NUoD
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Nov 2026 13:21:12.9677
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: dec2212b-1aa1-4ccb-f326-08df3a767f8f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AMS0EPF0000056D.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: GV2PR10MB7536

Currently, the fifo gets re-init, with a running DMA, e.g. when
using_desc_dma():
- dwc2_hsotg_init_fifo -> Flushes the FIFO, DMA may run in parallel
- DCFG_DESCDMA_EN gets cleared (e.g. disables dma desc)
- then DCFG_DESCDMA_EN gets set back again.

So move the dwc2_hsotg_init_fifo() call after DCFG_DESCDMA_EN gets
cleared e.g. DCFG write. Then the FIFO can be flushed safely, before
DCFG_DESCDMA_EN is set back on.

A BNA interrupt may happen on EP0, before this change. When it happens
we can't recover to a working device.

Fixes: a5c18f113150 ("usb: dwc2: gadget: Enable descriptor DMA mode")
Cc: stable@vger.kernel.org
Acked-by: Thinh Nguyen <Thinh.Nguyen@synopsys.com>
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Changes in v2:
- Update Fixes tag and collect Thinh's Acked-by tag.
---
 drivers/usb/dwc2/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 6c8a9f05fff0..bdabf3c39da1 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3486,8 +3486,6 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 
 	dwc2_phy_init(hsotg, true);
 
-	dwc2_hsotg_init_fifo(hsotg);
-
 	if (!is_usb_reset) {
 		dwc2_set_bit(hsotg, DCTL, DCTL_SFTDISCON);
 		if (hsotg->params.eusb2_disc)
@@ -3515,6 +3513,8 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 
 	dwc2_writel(hsotg, dcfg,  DCFG);
 
+	dwc2_hsotg_init_fifo(hsotg);
+
 	/* Clear any pending OTG interrupts */
 	dwc2_writel(hsotg, 0xffffffff, GOTGINT);
 

-- 
2.43.0

