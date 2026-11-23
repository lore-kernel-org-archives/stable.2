Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.35
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795425446;
	b=u011PrG69A2XNu8/XJhyHqxttwv+xLBEvMuElh+9T1rgQNkfJ5sQv8YWKDZFVRW8+ol7
	 89neRz/17qKHj8H4tWovfiOEu5UYW3+/OpqfR2j2DZQbEsTwrksbB2Y2Y2Kj9R1HnsPEB
	 ucu42OH6vq0AGlPuXZmrFeDk3WZpDigdf3J91RdUghWPMUmh5M0SsGXj9AFtVfMc7v1FU
	 hRzyUrHYo/N+SyZQOtZKGrqmAqweOaQNQIJTpIq+PTsDSCvvkhK3j24E4fBK526xHVVMw
	 bEKsLjGpjmEd5WFBSfO1zWSyeheVJam3l2t5FWhPHP4Yio5PJvougHSAwd0l8LQzORw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795425446;
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
	bh=NScpSoVMTvDY0tx4JExOhys7fsIHvxci/UHNQCAHM/s=;
	b=Uv99Y55R+eEYO9tyxT20ehUvaQ0gfQq0q1Px779S9q+aXPCjqoIBNAAUrCXm0v3mkSE2
	 b6ApODANmCTcm7vtWYjP6cCnI8pDwYNFTCFPqR4Aep9Z+AsfWNyzF5Ks37QgtamQ2j9y5
	 bmBX0lbLxusMoqhfY4uV0IEP14yIr6+Io5rUKBwP+syq92vavFWQPCRvE1KdezxkwFLAQ
	 ppeMNN0UQRiA+XoDI3tq2Cmkb3mPc+xWpX2/AOsKqKdoSwytAW1vYIVW0M6E9AXUkQP2d
	 oZRfjmmARqrMsWgRis5YXBBTzj0dYxPRdT5HrFQpO54IrKAmZq+Cjvlnkhp4JJnShlQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=foss.st.com;
	spf=pass smtp.mailfrom=foss.st.com;
	dkim=pass header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Nzq5JetP;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.159.35
Received: from OSPPR02CU001.outbound.protection.outlook.com (mail-norwayeastazon11013035.outbound.protection.outlook.com [40.107.159.35])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D79C606A32A;
	Mon, 23 Nov 2026 09:17:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0D79C606A32A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=foss.st.com header.i=@foss.st.com header.a=rsa-sha256 header.s=selector2 header.b=Nzq5JetP
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Bxs2yl8ZAwanElzL3tGTtaIDTA6NNsoBphGpgB1M0azRVMyBfExAZcaQDY0nqo26R/8V1KekvoQW0+DpsUO98XtymaCTnG28fhlPfbfgTeLqveUDAHHqPU0NxVHgugfR0XpvLbfJOSGggP/jmzqxF/qJpCNpDb0zDZT2W0N+6dH2GkMwntaWt+bL/FuVtZ0xB3dW75wgj8zhGQ8BVBNFd0S/74x03uQsQQzBBg+iFf6O1bNFqwAsUUxnbUTmveCPd/4jLd1uA+eka9kNwtAIfIwuJD40CmqtBB/svPMyov3oArzBFJgdeSMAXT8F/Xv36TeyRmT41raNWdQWXswzzw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=NScpSoVMTvDY0tx4JExOhys7fsIHvxci/UHNQCAHM/s=;
 b=UMwmwm2+tL8NZkzTpa9nIsUVFMehA+KWzUYKqMchVGMwotSq+w/TeZmSPqP8g0j7MtQnZHjAkcQm0qX4d6LxgdHbubOJJMZVLs5ErLzgTcPrRwX4w5fWeZLR5yPMPPn9vjkVdGfJPvr/tdyXAaY8TK1frwpjyaYgcAmSM/vdlRsKbye51roe9gWTwDuG3MW90QTVgjipURb9ML0f13G8ktBh/PirYeQzY1GCCe9z3EYtaE3YdB0MioHS9/+4m6exViEzQKH0Usp4FjzUXbSqIjLQmf5MRitDTDMmPl898wbZZAim1L0ckhxvy6fzxbJuvB93X0sUP2vi9L6PEqCW7g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=fail (sender ip is
 164.130.1.60) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=foss.st.com;
 dmarc=fail (p=none sp=none pct=100) action=none header.from=foss.st.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=NScpSoVMTvDY0tx4JExOhys7fsIHvxci/UHNQCAHM/s=;
 b=Nzq5JetPQj5AV4aoj4ZxC6eRsdQLJh1aApVGRVjKOtoWfSzeSAuzLhTV2uw5H0Xmpdw2xETbdyo72QpBL3kEhCat44BSQy0KtOOeGNIrBXaGfKqAezo9670nv+/Pman5Eh89yjGW0FuEQOBR+/L79l605E+vmMWAOwtKEZMHIeLaTHNbUVec4qo/8OJu+puiS5nsfP89KZbWsE2gOS/yaP9ZTBfDXB/VRfVpoAetd2EhhrIcNTrdhRdP6yd5ql9w16QnIHQy6Bda2scE1upNzzBRZprXwh7RkHYF5NJT6K98hrW0x153utAHBcO8PYBOmu0+bVUnK1GLSC9nv+KAnA==
Received: from VI1PR07CA0257.eurprd07.prod.outlook.com (2603:10a6:803:b4::24)
 by DU0PR10MB7566.EURPRD10.PROD.OUTLOOK.COM (2603:10a6:10:402::6) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.662.1; Mon, 23 Nov
 2026 09:17:22 +0000
Received: from ZR1PEPF0000E6BB.eurprd07.prod.outlook.com
 (2603:10a6:803:b4:cafe::20) by VI1PR07CA0257.outlook.office365.com
 (2603:10a6:803:b4::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.662.5 via Frontend Transport; Mon, 23
 Nov 2026 09:17:21 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=fail (sender IP
 is 164.130.1.60) smtp.mailfrom=foss.st.com; dkim=none (message not signed)
 header.d=none;dmarc=fail action=none header.from=foss.st.com;
Received-SPF: Fail (protection.outlook.com: domain of foss.st.com does not
 designate 164.130.1.60 as permitted sender) receiver=protection.outlook.com;
 client-ip=164.130.1.60; helo=smtpO365.st.com;
Received: from smtpO365.st.com (164.130.1.60) by
 ZR1PEPF0000E6BB.mail.protection.outlook.com (10.167.241.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.639.5 via Frontend Transport; Mon, 23 Nov 2026 09:17:21 +0000
Received: from STKDAG1NODE2.st.com (10.75.128.133) by smtpO365.st.com
 (10.250.44.72) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 23 Nov
 2026 10:18:24 +0100
Received: from localhost (10.48.87.222) by STKDAG1NODE2.st.com (10.75.128.133)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Mon, 23 Nov
 2026 10:17:20 +0100
From: Amelie Delaunay <amelie.delaunay@foss.st.com>
Date: Mon, 23 Nov 2026 10:17:05 +0100
Subject: [PATCH v2 1/4] dmaengine: stm32-dma3: clear flags before signaling
 transfer completion
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
Message-ID: <20261123-dma3-fixes-v2-1-0a5b013f79d2@foss.st.com>
References: <20261123-dma3-fixes-v2-0-0a5b013f79d2@foss.st.com>
In-Reply-To: <20261123-dma3-fixes-v2-0-0a5b013f79d2@foss.st.com>
To: Vinod Koul <vkoul@kernel.org>, Frank Li <Frank.Li@kernel.org>, "Maxime
 Coquelin" <mcoquelin.stm32@gmail.com>, Alexandre Torgue
	<alexandre.torgue@foss.st.com>, =?utf-8?q?Am=C3=A9lie_Delaunay?=
	<amelie.delaunay@foss.st.com>
CC: <dmaengine@vger.kernel.org>, <linux-stm32@st-md-mailman.stormreply.com>,
	<linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
	Jerome Audu <jerome.audu@st.com>, <stable@vger.kernel.org>
X-Mailer: b4 0.16.0
X-ClientProxiedBy: ENXCAS1NODE2.st.com (10.75.128.138) To STKDAG1NODE2.st.com
 (10.75.128.133)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: ZR1PEPF0000E6BB:EE_|DU0PR10MB7566:EE_
X-MS-Office365-Filtering-Correlation-Id: 7243c05c-4c37-4118-cc79-08df49429461
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|1800799024|376014|36860700016|22082099003|18002099003|11063799006|56012099006|261022075727099003|261028144727099003|261021121427099003|261026140227099003|10067099003|261022105027099003|261021123027099003|261009223027099003|261102123227099003;
X-Microsoft-Antispam-Message-Info:
	05waSiMzzJYMXsgTqrXWnGDvfkx1kO3VOE97wyBf8G7Sb3xLTo6dZE218p89C4sR6lrrL6S64HdULCQARRLlV664whUT2yDSObRIMlCS4X0YxMCmf483su2j7qTVQ6oqZ3TaXrVsd+894+n+msr7NIw7QCoCCOB9FWl0cdwInrFXV7Xhe39kYj07aemxe786MHN9Zro3w1Umfr9Duz7drjJU7j2A6nNWQIZpzZeB5JZE3Jg3Ou4fJFuvj6gEEUa6+c+NNDvQXOAj5wxM1Xz98DbTB50ywg2nN2fdqI/sO9JILYeHalQN+YGu8VsVbquJLw4f9vD2Z9KV0scE4GLzry4xCC/Z1FSTq43sklD60N4DI7eNEYSMifXKUdCXlCffATQIn2uadEeyNryjd5ka4ZFkwhoeMN7X1DFOgZHHxhJbA595WE/knW9nARekPAKUQAzOCrqgS061tL0sGRsgcTBUCRAdx/QWi72WjPh6Kr+38PcWw2qRp6i1u7oareLEoLS8dTLO0sFKdKMEw4VOMaUzg+jmsC4t0bOeBqWRL8k3gv1bDefAHKZXRgf4urUrSZEwDeBd6vvuz5Ie+toil6XM57gZyLFUic3wKwEms4XyHvitf1XbKmep9v+ijYZP3J8Vx36BX8nIF9rf5bitgHoAbDphJHw34c66CtoL7LDSK0j3StVU7eYYO/NmDb5gOzfRNKqkwn3E094ngvrxQQ==
X-Forefront-Antispam-Report:
	CIP:164.130.1.60;CTRY:IT;LANG:en;SCL:1;SRV:;IPV:CAL;SFV:NSPM;H:smtpO365.st.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(1800799024)(376014)(36860700016)(22082099003)(18002099003)(11063799006)(56012099006)(261022075727099003)(261028144727099003)(261021121427099003)(261026140227099003)(10067099003)(261022105027099003)(261021123027099003)(261009223027099003)(261102123227099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tHdH76lv1nbJdJDm92iVSridsf/KSGbq17vIK1wJVkxI/NY0rPKbPcNUnnQv+QzCWkxuN/EChinnMfslngtZrvVPZcvtM0VO8Eook25g1sohrmi+3dps7Oai6djS6jQZUvkXDGeZ1B2RhToYAzZAOkNIyCp1cQTnIX9sHoSYnKXL9leO9iAnY35T0XFGQzWyupZyXUGSDWk5luXs5HQByUzGCTch6Qt2hBxemEsqeY2NOyhxbJ5hSwgRYHO02sL42nD+2C5H3+iybwsp4PsHvewQHjhm6PNtPa//z9K/Pwqd6MFABqjA1M3H1H4ax+fgDXGSFsIwjkvmtbmvosPefLcAVsT4sorYWhau4UMreh24ljnqqAAfNWsmU0LbN+jZgE++0SuXXLdHBoG9C+ZOgFjT355wsh+Xb70JuZSRXasp5TrxmJNhJX2MVExmdL83
X-OriginatorOrg: foss.st.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Nov 2026 09:17:21.5654
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7243c05c-4c37-4118-cc79-08df49429461
X-MS-Exchange-CrossTenant-Id: 75e027c9-20d5-47d5-b82f-77d7cd041e8f
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=75e027c9-20d5-47d5-b82f-77d7cd041e8f;Ip=[164.130.1.60];Helo=[smtpO365.st.com]
X-MS-Exchange-CrossTenant-AuthSource:
	ZR1PEPF0000E6BB.eurprd07.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DU0PR10MB7566

From: Jerome Audu <jerome.audu@st.com>

The interrupt handler clears channel flags after handling the captured
status. However, stm32_dma3_chan_complete() can start another transfer.
If that transfer completes before the flags are cleared, its Transfer
Complete flag is cleared without handling its completion, potentially
causing a timeout.

Clear the captured interrupt flags immediately after reading the channel
status and interrupt enables, before handling the events. This prevents
the handler from clearing a completion flag raised by a newly started
transfer.

Fixes: f561ec8b2b33 ("dmaengine: Add STM32 DMA3 support")
Cc: stable@vger.kernel.org
Signed-off-by: Jerome Audu <jerome.audu@st.com>
Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>

---
Changes in v2:
- Commit message rephrased according to Frank Li's review
---
 drivers/dma/stm32/stm32-dma3.c | 19 +++++++++----------
 1 file changed, 9 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/stm32/stm32-dma3.c b/drivers/dma/stm32/stm32-dma3.c
index 4fe226541efa..a464e0cefd64 100644
--- a/drivers/dma/stm32/stm32-dma3.c
+++ b/drivers/dma/stm32/stm32-dma3.c
@@ -1008,7 +1008,7 @@ static irqreturn_t stm32_dma3_chan_irq(int irq, void *devid)
 {
 	struct stm32_dma3_chan *chan = devid;
 	struct stm32_dma3_ddata *ddata = to_stm32_dma3_ddata(chan);
-	u32 misr, csr, ccr;
+	u32 misr, csr, ccr, cfcr;
 
 	spin_lock(&chan->vchan.lock);
 
@@ -1021,6 +1021,14 @@ static irqreturn_t stm32_dma3_chan_irq(int irq, void *devid)
 	csr = readl_relaxed(ddata->base + STM32_DMA3_CSR(chan->id));
 	ccr = readl_relaxed(ddata->base + STM32_DMA3_CCR(chan->id)) & CCR_ALLIE;
 
+	/*
+	 * Half Transfer Interrupt may be disabled but Half Transfer Flag can be set,
+	 * ensure HTF flag to be cleared, with other flags.
+	 */
+	cfcr = csr & (ccr | CCR_HTIE);
+	if (cfcr)
+		writel_relaxed(cfcr, ddata->base + STM32_DMA3_CFCR(chan->id));
+
 	if (csr & CSR_TCF && ccr & CCR_TCIE) {
 		if (chan->swdesc->cyclic)
 			vchan_cyclic_callback(&chan->swdesc->vdesc);
@@ -1050,15 +1058,6 @@ static irqreturn_t stm32_dma3_chan_irq(int irq, void *devid)
 		stm32_dma3_chan_reset(chan);
 	}
 
-	/*
-	 * Half Transfer Interrupt may be disabled but Half Transfer Flag can be set,
-	 * ensure HTF flag to be cleared, with other flags.
-	 */
-	csr &= (ccr | CCR_HTIE);
-
-	if (csr)
-		writel_relaxed(csr, ddata->base + STM32_DMA3_CFCR(chan->id));
-
 	spin_unlock(&chan->vchan.lock);
 
 	return IRQ_HANDLED;

-- 
2.43.0

