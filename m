Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795166294;
	b=2wDOzCtBX52iNKA5jWYc/TdNIOao7JQiEw5NCFBJnelw8T2+2iV+lCbGQiPk2QZYLMxV
	 bGz+qoDzfQZhVrQRGfMDLoo/4KHEUEmpnYWAriQUGHpHOtazPsUNbwOE090tkNI+rTUYG
	 0IsBvP128sNmVq5AXGvy84a4vR4pdhKAPzefWAEeuNvUSehhbzbLnFZuV1f9D3Qq2Otc+
	 IlPy8e4DseWLFWtG6xaora/4ksRTwnUp+tf24cxE/2I62uFgjbhJWUM17bFsHPNTM80gz
	 7a+aGIxXva5C97XTYcAs5kt8mwM48drlUgIv1tB3E9CsVBYmoSLH908u7UXeGgNOVEA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795166294;
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
	bh=chOabQNnVDu3bMPYhAMbyJH2tIx5zRQdRAmb+eqHUAU=;
	b=iofmOIX13AE5jt5Ui+VzTa9DbIHwndriKGHNNsNZ2sAs/DAGY8GLnSfHjLq3nLVdy6Lx
	 rC9ab9wqAVfSPfAwLVddJlT0K6kf3a5yjHmX+hxcEPQq5GfTIyn0WqsiKdDTxyLYFr7X6
	 +6pskMoXd2qn7IsRJpmYy4ktuf2tTFO37wWAf7X/tKZxj3jHycVAPlBf0G7Dnzi+7Tv1+
	 tTOOOUL6CS9+Av6l1YxI5OrPzgfJSQDRvDZXqQWdh0i5OqMZLtKi2DowKM0kbZG8bvZTa
	 WOFO7sm029/EJdj0By5YHnCQv/0DBmVwnLoCvhO266gQ/jAcK7/2WBHUWODzWdmGmHw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=i7ZOPMEC;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.83.18
Received: from GVXPR05CU001.outbound.protection.outlook.com (mail-swedencentralazon11013018.outbound.protection.outlook.com [52.101.83.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0EFD0606A333;
	Fri, 20 Nov 2026 09:18:13 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0EFD0606A333
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=i7ZOPMEC
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=CQlkPy7cHGjakdQzASaf32NEcjylYWOLVnjXlcXP6kYmm8VcQICHyYjv5MQxmtkjxzK3T3DZByibxlm1kbHF+W4hgVl1hnmYAyINnJXaI6uLEcL9Oia/mv8IBHXbdbyvKAxxcY6MPVp7DFRFy5cYZWv+MA6Jthw0DffQ+Kq4JGzbVszquiYFWflE0jAvOzG+a9QK2OpaH2K4fxXaWSss751bOY59lcEfYj6FHmsnbFx717nWiM9Znns4XfldbsxfkFpeitg1OcROiTsh88oSIzEOU+PhZDpuKBYaINo7lCaBUV7clIV+eR1uN3/KTdLLedk4puNh44LsKQl0T81adg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=chOabQNnVDu3bMPYhAMbyJH2tIx5zRQdRAmb+eqHUAU=;
 b=BWXsmDPmZPy2tz2wA1MjGXbbdSgV5VQd7Ff1mckkYivvSemK3gp4C9j7B0Gf1SkF2l0+uZlN1GX7rP2/k18WXI8R5Et1RKrpr9rlQEPvHr92xKUO9a6nhMkJiK37Lobh81+JFIV4wK1vTfcHbTnGnd3g1YTwnI8WiQYVAK2eLC5IpZ2WfaRD0jE17GcE6pH7zFCt1Tds7uvDwG4+q5OHzWvg748lrHAK+I+qqi4gdB5KuKHFutFJCHn4wBHrDpEUCJK07qqhSiXhT9qailOkfCCQcKaVZvgwJ0vEfkNuM9o7VF2/UTf6+/2Kk27L35lvFKg6WXAuEnsp1GyDRDCGAw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.59) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=chOabQNnVDu3bMPYhAMbyJH2tIx5zRQdRAmb+eqHUAU=;
 b=i7ZOPMECK5LoO2mEk5j1LaQL3OaMBJ8G+y0p13wAl9sZ+6vwjG7ZsUdkFw7Ir1xKuiZR7NnBRI08bdyIrMC9sHJKAWp+n/xosAX8Fhsze5hlLw6lUy3s5+dcYRzpUnp1p3VavpzL4/cDPYCVsbcj5VulJg36UrX9xQOw+MydxpvPu4aisM+6OG4DGOQ0+qx7bYPRpYbCA+fbaYddvMY5vmOmvKiaE7o13DLBaVMZKh+cGDP/HEo8SplNnOTLdKVe7hMO3WeijpIA6maieSSDWWLea0N+4W4fvWwrPueCMTbGstJAafb1DQOIGJH0f6h8kzkgrlHj7A/wuil2cNiIcQ==
Received: from AS8P250CA0009.EURP250.PROD.OUTLOOK.COM (2603:10a6:20b:330::14)
 by DB9PR10MB6422.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:3da::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.639.4; Fri, 20 Nov
 2026 09:18:09 +0000
Received: from AM7PEPF00000053.EURPRD83.prod.outlook.com
 (2603:10a6:20b:330:cafe::30) by AS8P250CA0009.outlook.office365.com
 (2603:10a6:20b:330::14) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.639.12 via Frontend Transport; Fri,
 20 Nov 2026 09:18:08 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.59) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.59 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.59; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.59) by
 AM7PEPF00000053.mail.protection.outlook.com (10.167.242.39) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.662.0 via Frontend Transport; Fri, 20 Nov 2026 09:18:08 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpo365.st.com
 (10.250.44.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 20 Nov
 2026 10:18:53 +0100
Received: from localhost (10.48.87.222) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 20 Nov
 2026 10:18:07 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Fri, 20 Nov 2026 10:18:02 +0100
Subject: [PATCH 2/4] dmaengine: stm32-dma3: set LL base address when
 transfer starts
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
Message-ID: <20261120-dma3-fixes-v1-2-f29c1f437399@foss.st.com>
References: <20261120-dma3-fixes-v1-0-f29c1f437399@foss.st.com>
In-Reply-To: <20261120-dma3-fixes-v1-0-f29c1f437399@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Amelie Delaunay <amelie.delaunay@foss.st.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: STKCAS1NODE1.st.com (10.75.128.134) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: AM7PEPF00000053:EE_|DB9PR10MB6422:EE_
X-MS-Office365-Filtering-Correlation-Id: 75d5f1ef-f70d-4dc8-aa9c-08df46e7314f
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|36860700016|1800799024|23010399003|82310400026|11063799006|10067099003|261028144727099003|5023799004|56012099006|261026140227099003|261022075727099003|261021121427099003|261021123027099003|261022105027099003|261102123227099003|261009223027099003|22082099003|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	C7EeTsk0fQL/aAiNsOiGlysZx9nJSPMdyMXs5hnMOnPAJGHVNHmVNge+f/al2ZrT5KCY+mIz7d/eRUgugOOqHLVuva/FRLB3TeMlWfM8EGmfN36dDMQDznyHnIb5pAXE7klnEwLXLNoxlrnS2SQ2qHTCmiX4cFkDAQHgfhI0JD4KaGKwuz0QKJ2wsQI9CeOz+yFOUihEjEOAE57sESNGOHFBAzskOnWuxO4jasXKArr6eoLsRZn2LvTwG5aICxcjF1Ow2J79OZfkoQ8hsVu7/HDKQ2nilRx8pAqCIV8U3QsyX07ptrVW9+rJSS2V1kDhyF75+a9sU+wSsJY0fGw3QdWOXo7V7hsSKHr1ZZ12xyq0jSHdNs8P8tQ11Ls4TJGloqfeXDgRfTGH73jWOa2Zzp64V63StLGWrDMOV23VbCtYOY2tdog3L8xxUnLIIrWKQo/xkcPffgOYVo8vYVI+A1HSMLom1CfjTIIeuPdkn5XvXAheMmIc1hb2dAGtseo46Y1iYmi8RmA0+lnYz4VwO5SJRuIx6WBEfGHksGA6Ibp1ZnxvB+z1P07zOOoPD5Avvt6PjRBoNpgVcOIb2lAEcf+gKtml9LBQM4HpYBBomBWwOPi5AVabaxhzWNkE+rZOacj4+udmvkTZNO9gxzF3crv6557RWTuBLdWw91Bv7La3IbBGIedZf0N++kNJbQSOG2gOh7I9w4NdkqpdbJX4MQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.59;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(36860700016)(1800799024)(23010399003)(82310400026)(11063799006)(10067099003)(261028144727099003)(5023799004)(56012099006)(261026140227099003)(261022075727099003)(261021121427099003)(261021123027099003)(261022105027099003)(261102123227099003)(261009223027099003)(22082099003)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PW+LSwN3A18BtI7nCcdBdq1x8It4M7X7HF8VfEtaVlKpH3r3SyuxIzNxWzNLi17WWwL58Om1fCBkITyme+5BzyFzYicBwUQUpNeLrrQRhRYFDuFzLTpOEI57n2dE2IRMA4z5G4ADfOoxKcdz1T+DN0VZkP194AppanSjOcKTfjh6fa3Gs02zqiLrS/+p1IMr+DDE6hDqPYDgS1zs6GCaMgcUHMU7Je+ufMqCR/QQngQgILZxBPRHGQGCwLPipNyT5gDIUEUjvoO58jsfTcGsMl4R6LHk5EQk9eEK0QHZHVUL+y6KAkMZBZiv5Q+SU6AmR7B7cqYHHmexa5JrYcurkkfviJbIkLZw3v2LqX4Thnq/+DBTaYchSkA2xvOsPvVTwFvdqZiM2pTEz3z2awCPdzWwef6ujG2FhvXhbi0XHa+hqewQfD/ITkVYud5IFjjU
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 20 Nov 2026 09:18:08.7709
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 75d5f1ef-f70d-4dc8-aa9c-08df46e7314f
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.59];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	AM7PEPF00000053.EURPRD83.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB9PR10MB6422

Linked-list (LL) is allocated in stm32_dma3_chan_desc_alloc(). The LL is
then used when starting the transfer in stm32_dma3_chan_start(). Nothing
prevents a user from preparing another transfer before starting the
previous one. If, for the same channel, another kind of transfer is
prepared (using dmaengine_prep_xxx API), the LL base address may change.
This address could be overwritten in the CxLBAR register if the channel is
disabled, or the CxLBAR might not be updated if the channel is enabled,
leading to a mismatch between the transfer being started and the LL pointed
to by CxLBAR register.
To avoid this, write the LL base address in CxLBAR when starting the
transfer instead of when the linked-list is allocated.

Fixes: f561ec8b2b33 ("dmaengine: Add STM32 DMA3 support")
Cc: stable@vger.kernel.org
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
---
 drivers/dma/stm32/stm32-dma3.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index a464e0cefd64..a056f73fbe02 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -396,7 +396,6 @@ static void stm32_dma3_chan_dump_hwdesc(struct stm32_dma3_chan *chan,
 
 static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_chan *chan, u32 count)
 {
-	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
 	struct stm32_dma3_swdesc *swdesc;
 	int i;
 
@@ -423,10 +422,6 @@ static struct stm32_dma3_swdesc *stm32_dma3_chan_desc_alloc(struct stm32_dma3_ch
 	}
 	swdesc->ccr = 0;
 
-	/* Set LL base address */
-	writel_relaxed(swdesc->lli[0].hwdesc_addr & CLBAR_LBA,
-		       ddata->base + STM32_DMA3_CLBAR(chan->id));
-
 	/* Set LL allocated port */
 	swdesc->ccr &= ~CCR_LAP;
 
@@ -790,6 +785,10 @@ static void stm32_dma3_chan_start(struct stm32_dma3_chan *chan)
 	writel_relaxed(hwdesc->cdar, ddata->base + STM32_DMA3_CDAR(id));
 	writel_relaxed(hwdesc->cllr, ddata->base + STM32_DMA3_CLLR(id));
 
+	/* Set LL base address */
+	writel_relaxed(chan->swdesc->lli[0].hwdesc_addr & CLBAR_LBA,
+		       ddata->base + STM32_DMA3_CLBAR(chan->id));
+
 	/* Clear any pending interrupts */
 	csr = readl_relaxed(ddata->base + STM32_DMA3_CSR(id));
 	if (csr & CSR_ALL_F)

-- 
2.43.0

