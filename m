Received: from PA4PR04CU001.outbound.protection.outlook.com (mail-francecentralazon11013070.outbound.protection.outlook.com [40.107.162.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FD544A0136;
	Wed, 14 Oct 2026 08:58:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.162.70
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791968287; cv=fail; b=YXjcDlZyrG0MOpGs+IFbc6z1a7TZ5sR266nSG+hTqFtf6bJrtltT+mO1BbVVnjDWr3RS+qAT9m8HqWoW1oRw9UfEAO7j11XXPSR7GSA/0aNcOsIFLKZ2/atyTaPOOdfih5YCf8Dp79Kfd1aF4glQvsTXmP1pLdn158Ozll1tpc8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791968287; c=relaxed/simple;
	bh=QCHL+bL6Xb3jbIIn1XW3T04BgfSY5OYSq5mvNBqR7vA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Z+qRywWo1FSmnP6OWA8BcmSqAd6fVS3zsH1Fu7CtmTqKb8Jo96JXGrG3mxwnC/zqLbCIIwZEMzMJmhfbmZl1BHB/627u1XuenLF9moocBuK6h2bRRK8YAUMLgCvWZwZE5cIoWV0RH3Up+skrCjNVGYM8SylRBn3ATSy2RdCZd3Q=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RyTPEQpb; arc=fail smtp.client-ip=40.107.162.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RyTPEQpb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=yfFbUnMx+ZOyc6uWfpb/Ln9mz0NloY0kZ7JLCtBtlOWVyEFwtj5hjsNqY6ltxMQe4BdDmvFzqBUzeWuxE9fIv466qRvAVBfW7l70t+DqXO2NgQamOYSHId65UnTmckNKRuu3QdoMFR6nVrZQExYy1KZduD36SYNL1MkYIDBiZIj4MHRd9mEZ7NDBMf6mlReueUAS+wdGkcCuxqyln8auwa3c0CdevFplIne7WOO/kjWgA7opSp8kX3ULt7jk5FG1xMQ2/AJzUvgqbwCbBKgvCTba21FV0qHGOqBKnYtR/QBPxv6OsnaKbpC5aSdwKpFwOQFRjNGRYGoagMGW0KKoWQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HpvpjXETD3NmEw+X67pt3JB2C0P7x82qXLMmSAYexpM=;
 b=AbSQhH6Ykr0RqC9pHigeHKZUtsi+Y0BF5gTS46Y/o0+fVHRTST8BfPJyQ0tLlefAk8USCDN8ChN9QdNladnON+zRQGpLghsBwxJKGDNc8EoYBekN/BRJnM/77+5VV6UvtfFSPswgy5ACapEb2ADjagtcfoFr7Fr+nLmlNtw1hnS24Xsp/RuCDsIF8+9Oa16iMfijruz5yVBw4+wNhYkRzRQNgUpCrxcETGv4/TgAWSWZQLEKl++Oq5K5IHdevg92jGLbf8ULgH1jWBnS9wQ1y3wYDAtsJ+fDrRygKKudMaq7pZXYLg7naTqjiqyIkNgwASHZqqO/Vq1r4Gwi/5hIFw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=synopsys.com smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=HpvpjXETD3NmEw+X67pt3JB2C0P7x82qXLMmSAYexpM=;
 b=RyTPEQpbDT+kFD0PXKdTDPzJ4a57M2QtDDJsuAIXUINNQJM8RLl5pbcEPImfxI/Iyz5/8vja35itMRb6eN6Q/FmvisgFZHhxwtC6meZIM/GU5BPXrGohKCLgE+y09oBekPfGLedP6aq8F5y/y4k49SgRZ05kWlFh1F8wo+xS8MG7WPUu0IfrUJfiArj4MZskHj+15ylaAha61Txk2407LIP8ihAOK0856kn43vFwSQzb/7sPHazZsS2TOnd5RnTBS/jkN85+/XX15RVe3LA4T0qDXhdhEKn0c7VFxA40Z40VYnEShPjAHquSpW+uFRDft5icrJgEk19fgZLOVZxZcg==
Received: from ZR0P278CA0010.CHEP278.PROD.OUTLOOK.COM (2603:10a6:910:16::20)
 by BR2PR10MB992285.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:2c8:18::24) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Wed, 14 Oct
 2026 08:58:02 +0000
Received: from MI3PEPF00008488.eurprd02.prod.outlook.com
 (2603:10a6:910:16:cafe::23) by ZR0P278CA0010.outlook.office365.com
 (2603:10a6:910:16::20) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.522.4 via Frontend Transport; Wed, 14
 Oct 2026 08:58:02 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 MI3PEPF00008488.mail.protection.outlook.com (10.167.240.135) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Wed, 14 Oct 2026 08:58:01 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 14 Oct
 2026 10:58:15 +0200
Received: from localhost (10.48.86.251) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 14 Oct
 2026 10:58:00 +0200
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 14 Oct 2026 10:57:33 +0200
Subject: [PATCH] usb: dwc2: fix fifo reinit in
 dwc2_hsotg_core_init_disconnected
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20261014-dwc2-fix-fifo-reinit-v1-1-d918de90ee3a@foss.st.com>
X-B4-Tracking: v=1; b=H4sIAPxDz2oC/yWMQQ6CMBBFr0Jm7SSdhgjxKsaFtL8yLIppEU0Id
 2fUxV+85L+3UUVRVLo0GxWsWnXOBnJqKIz3/ABrNCbv/FmctBzfwXPSjy3NXKBZF3YYEFLnJfZ
 Cpj4L7PLLXm9/rq9hQli+Ldr3A1lYLOx4AAAA
X-Change-ID: 20261014-dwc2-fix-fifo-reinit-0ebecf721d81
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>, Greg Kroah-Hartman
	<gregkh@linuxfoundation.org>, Ben Dooks <ben@simtec.co.uk>
CC: <linux-usb@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
	<stable@vger.kernel.org>, Fabrice Gasnier <fabrice.gasnier@foss.st.com>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: MI3PEPF00008488:EE_|BR2PR10MB992285:EE_
X-MS-Office365-Filtering-Correlation-Id: 6531b428-729d-4436-f6be-08df29d1403a
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|36860700016|1800799024|34020700016|376014|10067099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	+vpwKWL2ZCrGlAMJ6p0nRQzRkJEDpYbVSQtVriwn9CWNjicnPGrVvN3QkaS6HuCyVtvo8GZnXNUFJb3P0ODcqif9SeklP+si1/UDwkcsY3shId4D8jKrwWTM0s6DH/ScIAGfD7Ky5NSHN/wOC7fcgfvz8KuZ5WTGjZNY0sgbaYgFTM+wlb06QI1hJwd1OZcTQaWMa2IVUJ0gEy5AefxF0AK9lZlSam8S/ynrTSIkpzWRXt649IEbQFmCgUcZE+kRdilAox/jF9Rye0+9vC5t19mbFlpWGKpIQ92gPalo8N2cwdjd7DkFY5IsfOiS1opoTc/OqG1Eqy+lrGMYzLZJmA4fm/3SunHvZKEUUR+zXAR89tZ0QczqJS0UJmoRKscGuhgr1Z0VDlQKZpwrKVh/50+7PooxWu5EqO2/ipqpCdvLIpNLQm1MLwLfpDTpT8+XWIbpE5LiFTbIfKurU+2MqF7mqzxHtduRVwCVE4t412+FlLTjm1/qUM+0c1XSftgFKZepyz2qW1NgxWC5puaQCJEUsnITE4pgfu9mQTbfbYy8fONj9O87udlgQlS7Jzc/HfZnwCYgr1eecXIpRWJdUSiAKZ0a/4L6uFMAaeDTzK2jDCmmq5bSax2NOdgN7Dr+ETemXdD4uDv5xSZt5KP8AqsRCKHjnhg6kZFkoL6RMI8aJDOE3UF51JtMHbu6KecroebyrpLmKwiBnl1WvSQu0w==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(36860700016)(1800799024)(34020700016)(376014)(10067099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tydij95N0Depp2NDnmeXKMbfaVwN5ZM4DpMIhpcc41OuWXbCXAa3pBOP23cQk6Eqo2/gh3ZM6952nwZQgOjOFYFVZlwIcKgVQlFM3Q/cq4L85G44ASYY/fn7VTqMpsQwk7T1X8DGdaE52Ok4cYGYHDHxip5u6BMGh7A82KD+/7ViUvSOxBkvJc8jlKW06q2bZ03D5zKK4MhOKZqmi+ebjcQmxu4rF6mq3OWeGtwOwmyz/0+rGVnXZz9TvabtAtSQruK8p4E+ZOzWK3oubI9/Q99wil6WBKPvGI1keP9W25LPgbi0p+O13Yugm/Y+Op+B/ymHUkYhYOZrB+5RosAXvxLhzpBF6X3qBChXfib/Lk1HHc0fna/F0XO4OppKfYgt776eqDsh8/Xx2Fcggq/Rl2Sum3bHwmcyHJwL80ulbQUUUW5usrkLfpdRLVDGkIrN
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 14 Oct 2026 08:58:01.2112
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 6531b428-729d-4436-f6be-08df29d1403a
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	MI3PEPF00008488.eurprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BR2PR10MB992285

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

Fixes: 5b7d70c6dbf2 ("USB: Gadget driver for Samsung HS/OtG block")
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
---
 drivers/usb/dwc2/gadget.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/dwc2/gadget.c b/drivers/usb/dwc2/gadget.c
index 102169b40419..3851166c9d9e 100644
--- a/drivers/usb/dwc2/gadget.c
+++ b/drivers/usb/dwc2/gadget.c
@@ -3422,8 +3422,6 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 
 	dwc2_phy_init(hsotg, true);
 
-	dwc2_hsotg_init_fifo(hsotg);
-
 	if (!is_usb_reset) {
 		dwc2_set_bit(hsotg, DCTL, DCTL_SFTDISCON);
 		if (hsotg->params.eusb2_disc)
@@ -3451,6 +3449,8 @@ void dwc2_hsotg_core_init_disconnected(struct dwc2_hsotg *hsotg,
 
 	dwc2_writel(hsotg, dcfg,  DCFG);
 
+	dwc2_hsotg_init_fifo(hsotg);
+
 	/* Clear any pending OTG interrupts */
 	dwc2_writel(hsotg, 0xffffffff, GOTGINT);
 

---
base-commit: 24a19b953e2a3d0ea5a8c4951a0ab8f32720c907
change-id: 20261014-dwc2-fix-fifo-reinit-0ebecf721d81

Best regards,
--  
Fabrice Gasnier <fabrice.gasnier@foss.st.com>

