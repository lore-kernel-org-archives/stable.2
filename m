Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.8
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793986727;
	b=X0eBpNQZ4rck92vpbd+tmptyqsN25KuzmFHMcxoWUFiSapJj9eBC0vtmWDkRg53l8ezB
	 sN1qR+Jv3wPdGmtYMktDcT0AIl3b726+HT3YWCIOW7RUHybLKoIlUlx3O/Csr3HbUYZ1R
	 kl5hfl4E8CYDGi19aVmTkWlcPlvxU0Pv0nWXyj0MLCM2kVenPcC2V0pPTxqhjXcD/az7W
	 DbxZjQJ09uGAfeqwXfptjn8Sio66AioJ/w31dSOw+d72Sr1c66FqBTDjORPS+5C2QtYpU
	 43S0hr4+T/v03C5UCtTZUw7Vd7RIvpkioj0wb8F/+rS5dMv/YnoHueMtpj4drLg/pvg==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793986727;
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
	bh=dddN2EERcbHgZ6Y1qbb9ZeaozGvW+ikNQVaQh1+nGbk=;
	b=J5nVZwE4YLuxvOaSBy/0kp0YqqEd9Fn+4jYHqCvQMzKp+9b1BC4PRlKkIHY2Vr2+R8bP
	 RCf9PoTdYUUAH3XgEJT3P2jAI5uby/M2z4WKfLru+mJMf1fpYQVh7e4bv6mKKGrMZlgAV
	 iBORvgw6wuFvgpX6s+dJ8NliJncAycoJSSp2rGGyl8o/OIPxSu7KoQXs1u0qb5AhEwJx6
	 2TNOGfm79wo9YKH19UeJSgLNnMKu3oBW+B+jFNA/WlPAkCaXSFPHMLfybss8cGQsoF23E
	 PW03goGSQzrSH9DMsAYJII+cMfZqI2Q9PSDY4QpWphm2CMwjNnTI1hZuGnT8MZ7Y0fw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=C2ah7bJZ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.130.8
Received: from MRWPR03CU001.outbound.protection.outlook.com (mail-francesouthazon11011008.outbound.protection.outlook.com [40.107.130.8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8EE2606A329;
	Fri,  6 Nov 2026 17:38:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E8EE2606A329
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=C2ah7bJZ
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=BF3MIx2jP8n090lg2kx9MYEjp2IaSFfhheHhu/8RyZQXYmdufDt+Gs8QI/r8HAoA0pBoEJIeay9dOu436rOqWe3eyMXfJnMqDUSRoHXuIpV378/aqtAm6NguUOOZNe5ikjdBygI3NlR7B4QypJhLJrY1p5JaVW0xR0370qarKCnXFBy8ePrxWmW8eDgH7glkGTWXtdAqzs1NFrSMk1y30DSjKqfICAWCmG1C3HQw9o4mMhPlMgo6AcRVCEfLxwmB6fJizOUzychR48NiGph0BKOBvFhZizy/ah4CYwMAe0YwBTLuenMBASTyk5/5SQ45jqDGuW+ZdyqPXXanpkEtyQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=dddN2EERcbHgZ6Y1qbb9ZeaozGvW+ikNQVaQh1+nGbk=;
 b=vLzLj20L2IlISFmzJfJ4Tos2wRrX8Pg0Iada4wbqBQq6eslSpIFk1QU59U9B/me53gPL7Kfnan/SooK84i9lbEn8fzRYwBK6df5kNB92Tcld77Ths8wVrWnTyXagI8X07huwvT3V1Z4c25Zx/i+LPUeAQh1EIp4XwuWhaUdJmVInEIRJKwQQ2GvYWGUZ2dp+dXh5y3vN7zcabMQhhVPQSzmtmme86fLkK8I28DL9opMd1mdtyZxv5N6/yEsVlSYcIJhmABnaCk0mldJOA8u15coHfp9IctVvle6UYedujvj69POrihovjLjxzdnE77t8baTBENlPKHszojZm8x+smw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=dddN2EERcbHgZ6Y1qbb9ZeaozGvW+ikNQVaQh1+nGbk=;
 b=C2ah7bJZ0FMwnarjBkpaviopvdgHBamEjzcHytSTOelb3kTLoRs27qdrJpC6HIaKOz+kkK/dWJ9ZvUJOxj3AnBXGF9BbwmJiGvvikQGYentGos1pfAqp9i7yCKX/b36Q5GbPQ/Vh5Rv1a9qgiZE0ASfdvHetpeUhLk+JFElwypKV+zffM6Xn7thASmahL86fmYDxLhoKtJNBGrfgGl1dIoHPB2nmwz9k0q30TQIgJLmtbHCpueNFP0JIc6p1CBq4d4oyT3unOgoTTdujpryfavzAfmsVtjL6SJEukD1kdMJiast2cL9Azf28j8pJp2z5W5Ztb636a0s45LQaj8UrAA==
Received: from PA7P264CA0129.FRAP264.PROD.OUTLOOK.COM (2603:10a6:102:36e::17)
 by PA1PR10MB8920.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:102:445::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.615.4; Fri, 6 Nov 2026
 17:38:43 +0000
Received: from MI3PEPF00008551.eurprd05.prod.outlook.com
 (2603:10a6:102:36e:cafe::53) by PA7P264CA0129.outlook.office365.com
 (2603:10a6:102:36e::17) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.11 via Frontend Transport; Fri, 6
 Nov 2026 17:38:42 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 MI3PEPF00008551.mail.protection.outlook.com (10.167.240.5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.615.4 via Frontend Transport; Fri, 6 Nov 2026 17:38:42 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:39:22 +0100
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 6 Nov
 2026 18:38:35 +0100
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Fri, 6 Nov 2026 18:38:22 +0100
Subject: [PATCH v3 2/6] usb: dwc2: fix a possible interrupt storm in hcd
 resume
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
Message-ID: <20261106-dwc2-low-power-fixes-stm32-v3-2-68d2a0e9bab6@foss.st.com>
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
X-MS-TrafficTypeDiagnostic: MI3PEPF00008551:EE_|PA1PR10MB8920:EE_
X-MS-Office365-Filtering-Correlation-Id: 18398f53-ea97-4db2-6498-08df3c2cccb9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|1800799024|7416014|82310400026|36860700016|261022075727099003|261009223027099003|261021123027099003|56012099006|261102123227099003|261021121427099003|11063799006|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	dI1fawbxNEmh+5EWcfgoW9QtAymTe0bs/PfVEISli322UdNplCufnrLfRZ/tFRCXL2EhKVEoOgFOhm4E8Nw1zEdrXLNocEc4XdeUJ4b6uJ9+2yBoU5xlU0clefPFlXe3jmqfQGfiUSHjU3BF+cApbCEi/KgKyN1oblvEOyfcpJeKGsZPAKETq4gZLGGhc0IhLhbNL6dVr7g/9LEzO6tXPQrqKyLnyAq2M12MQhi4hFjC1sKGZsYJaj0L6emxplifcVryIkVQk9CmpJ/ZYe8ZGCi2ZcVLLY/ej4kycras+DyPxrHMqCar1RSqp2E2Foobo7bnURC1chWd8e2tgHkEJm90GKt+1CX7YqvkeZ4Msv4T80BIdwokuw5ILqolwkOhhJKdKv19dx7hWP1aomkU0w93Ev/qTGCwVqvk6Fii6BZwL0yfx1Bb3wuU/m0Ddw65Vl8Na6i31cuKR66YfGgaJtOP22eoj5qsvREEnUa4jwf4eJ8qBDsdfGxsnnn75cN6rzb7QH/4bCTReYG+jWmZB/OMeQt4rM48vL5EH6GNamVndOtkq0XEUjieCnzNuMeoxM5bahBkllHAcuxvDHF+tyF1fq1JMxJYiXS4XuDu/CBQjzFjRPnosHMDcaVOYo/INcQD4GTErDmGBpFoN2L7y+vlmzvV/Z3K+Ql9+p8mYp8JLi0x7jtfsVjPgfCsX68VM1Ba/sc8JGfjt69Ml8XK0Q==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(1800799024)(7416014)(82310400026)(36860700016)(261022075727099003)(261009223027099003)(261021123027099003)(56012099006)(261102123227099003)(261021121427099003)(11063799006)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	sqaNFmUWmkRINdtVbm6DZWxWVYVMjlCA/gebgTFbtqLsdMvG0XoGMDZeQneUTTbT9Tx6zvccXYhyAxpJ/NvJk0k/OLCulWOmnR8zOjLxdIYJvcL04uPBW1dbQZO32ixd6/G1VGKtpZh9XyTCJ5IDhaOCmFZYPAdlRil2p/BqtnXsiCs6yRX4MczqcML6ov8zAwTMT0b4ZIz9yLV93eH0T7zWKin6XxG/R2K+FRSd9oVXE6rIvT3HaYiyO3X2F1Dx22EmMf6KExP8rsPHgnJosVTv1GIsy7rvivkIGz/nMFmPBbrcKbwthtleUfYc9gzW7HwSIuRMToKt4b9cPDxVQkJufcp7F1dSqn3PURt8E4raUyuMGjNPoxntJYlIICxJzdlbtnzs2LPk7wSLZp0qSgzEezdYO4xCY3kuwPVWCdsAdB+WJ415KS5Ts9aTHVdo
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 06 Nov 2026 17:38:42.0161
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 18398f53-ea97-4db2-6498-08df3c2cccb9
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008551.eurprd05.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PA1PR10MB8920

The host interrupts are re-enabled in dwc2_hcd_reinit(). So there is a
race during resume between a possible hcd IRQ, and the HW accessible bit
to be set. This can result in a bad_irq to be reported (nobody cared).
So set the HW accessible bit before calling dwc2_hcd_reinit().

Fixes: ef5e0eec4764 ("usb: dwc2: Add clock gating exiting flow by system resume")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
Note it's been found while debugging with additional mdelay after
dwc2_hcd_reinit() call.
---
Changes in v2:
- Introduce this patch since debug session (since sashiko comment on
  patch 1)
---
 drivers/usb/dwc2/hcd.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/hcd.c b/drivers/usb/dwc2/hcd.c
index d5275cd658d4..28cde15e0cca 100644
--- a/drivers/usb/dwc2/hcd.c
+++ b/drivers/usb/dwc2/hcd.c
@@ -4469,14 +4469,14 @@ static int _dwc2_hcd_resume(struct usb_hcd *hcd)
 		 */
 		dwc2_core_init(hsotg, false);
 		dwc2_enable_global_interrupts(hsotg);
-		dwc2_hcd_reinit(hsotg);
-		spin_lock_irqsave(&hsotg->lock, flags);
 
 		/*
 		 * Set HW accessible bit before powering on the controller
 		 * since an interrupt may rise.
 		 */
 		set_bit(HCD_FLAG_HW_ACCESSIBLE, &hcd->flags);
+		dwc2_hcd_reinit(hsotg);
+		spin_lock_irqsave(&hsotg->lock, flags);
 		break;
 	default:
 		hsotg->lx_state = DWC2_L0;

-- 
2.43.0

