Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.14
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793013274;
	b=DZ/g0Y18oF5XfkzB4Puln9YBoMb65HU2YnjC1p1k+Ngesrhg7CfS5H+FcuePXv0/hqcy
	 zaHjQs63vusi4q1IsKmLUGc9fP8T6AMxVejU/fuR191tcilVZJmsPJUBflVzWM0xyJS4h
	 m29U89SgagWQ3JkvxNnvCSoZQ2PwI9ZXKROcmn+0a8aM7C/LY03t8l9MiLckACdMWoiC+
	 E5nFHxTp30YoSHCUf0p374cg6dTDzj81RxiPooFrK+fAEyZP0fI3KnSnucOX+tmQBsmV7
	 e5voqqT285+3NH6wzQR36uW4pCL361czzi0owJPYjcsfA8Dr1J/W70hK7VTMgMuWKDQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013274;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 Received:Received:From:To:CC:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:X-NV-OnPremToCloud:
	 X-EOPAttributedMessage:X-MS-PublicTrafficType:
	 X-MS-TrafficTypeDiagnostic:X-MS-Office365-Filtering-Correlation-Id:
	 X-MS-Exchange-SenderADCheck:X-MS-Exchange-AntiSpam-Relay:
	 X-Microsoft-Antispam:X-Microsoft-Antispam-Message-Info:
	 X-Forefront-Antispam-Report:
	 X-MS-Exchange-AntiSpam-MessageData-ChunkCount:
	 X-MS-Exchange-AntiSpam-MessageData-0:X-OriginatorOrg:
	 X-MS-Exchange-CrossTenant-OriginalArrivalTime:
	 X-MS-Exchange-CrossTenant-Network-Message-Id:
	 X-MS-Exchange-CrossTenant-Id:
	 X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp:
	 X-MS-Exchange-CrossTenant-AuthSource:X-MS-Exchange-CrossTenant-AuthAs:
	 X-MS-Exchange-CrossTenant-FromEntityHeader:
	 X-MS-Exchange-Transport-CrossTenantHeadersStamped;
	bh=sIcUsXYksYZgZU+WRfVdvdEeS7eJtxK6Uin7BLPYmsk=;
	b=R9k84q23124lM5t4q3uWc6tfxLjatZdeCORXeLmq/OVCDs1UzSoLj0nYaHslPfYZb06j
	 aPehnWu15Gm6SKumMlmWcrTykdxh0burQaHzqiGoWw0Mzv7n7/h3Y5TO8KGtfgvX3ewAL
	 GEQEfU0tnEB0jV/+aRGONWbRmOL8rSRRHi/dun6s5dEwwHQLy23RYGQoCIqAASl/nVZDb
	 weSfrLqQNKvHulsUVYIKuKZrp+yJd944SVRQgqm2VzddIufEKRLiFbx+FXeVaFhoYuRb1
	 uSuNooNm62CplVfhxu6vIO8cdvW23IYGt+gSIgEE8J7+T2W9CsJ0rdukM33l7NGXEgg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b="QaiK/oVl";
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.52.14
Received: from BL2PR02CU003.outbound.protection.outlook.com (mail-eastusazon11011014.outbound.protection.outlook.com [52.101.52.14])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1CC8C606A90C;
	Mon, 26 Oct 2026 11:14:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1CC8C606A90C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=QaiK/oVl
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qnEZWDl9BhKWSebK4GWMQH7jOhjOxI6hoICE8VieUwrRigqsNd9I8v/8kZV/WbhLTtllgu9QY9LK9c1GwnxImfLJfj6fCxWpUlXk7jGF6vFXj+XmRjoHoKY2ocoufly9TqvqywOK/J+qGHGMEKO1jOpELu4IYo9W9I4TPZi1lG+8/krzcbBxlK7QsGzejq2SbZU/26IkUO4n2kUJz84OiQmD9dVL79Oe2BIy2Z8wI5JjB4wG+9G+TrE/w+wb4DGsxjjSzKYR0kn4DpAlLkM1WQbjObG2uf8A1f4jHqZX12gNWaH3pZrC0z5ejG6NKvvM/sKKgyjSYy8zl9n7BWhuXA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sIcUsXYksYZgZU+WRfVdvdEeS7eJtxK6Uin7BLPYmsk=;
 b=qZYONcorzogR/ebdKEXOh86p3KyvfnBbcD/btf37GB+tJA0zsQFvw45oRpFLKlwWNMeAVh5VtVvPozQ6T/M3rSGYxpUb9fLjeYJ9N7i1fYKRWQfX9POjEsUUGoMt833wk0HpGfG6pfMxMoDgbwdSjAjmsctUjgZcYUorPn787q2Qh2UqU8DdT3L5cdmHdTx/S6oHxB182J5BaTsq2EeA8vJGlD0IeIHNSOutpJGydgU9MVd8+S6JWGSahRkUD8DYokj/yZQ0pYcnc1hwaVZFN+W4nlTWbaiGTeQToVUKRDNwax/hsrvlrVt918t1VGqMIvnqUiqhKP3il5ItWGWJWw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.233) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sIcUsXYksYZgZU+WRfVdvdEeS7eJtxK6Uin7BLPYmsk=;
 b=QaiK/oVl21Ht4pCesZ0KwHouZxD5knUsOSOmfq0t9osVa0Mpw0Z+P/AyJz0vokRR6sCdvnHUUlfGnYAVIwjQ2kGrPiVDSwKrR91AJxgpqT8wOCawYrPGuNsA5OvHmJdneb5HBsJQ5u2bWKWs7tz0GBOdlT5RFRLtaQgqXrnd4ynB+89yMzoBXMPeybnicjjoz7zaqM4Exarbu+m7878QtHWd9WRorug9URbtfiXWbHUkDfqj2nncwxsHDSMl5/AnNj8E6IaRRtxWEXFCzEkzhuNmc7TcawY59tvOl6TwvAgKiX8XoluJhhJxwZQv3YffHeHiuOimFavQTyTv52Fbsg==
Received: from BN0PR04CA0089.namprd04.prod.outlook.com (2603:10b6:408:ea::34)
 by SA3PR12MB8439.namprd12.prod.outlook.com (2603:10b6:806:2f7::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:14:30 +0000
Received: from BN2PEPF0000A890.namprd04.prod.outlook.com
 (2603:10b6:408:ea:cafe::5e) by BN0PR04CA0089.outlook.office365.com
 (2603:10b6:408:ea::34) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 11:14:30 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.233) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.233 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.233; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.233) by
 BN2PEPF0000A890.mail.protection.outlook.com (10.167.248.182) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 11:14:29 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.6) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 04:14:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 26 Oct 2026 04:14:13 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56
 via Frontend Transport; Mon, 26 Oct 2026 04:14:13 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Sowjanya Komatineni <skomatineni@nvidia.com>, Laxman Dewangan
	<ldewangan@nvidia.com>, Breno Leitao <leitao@debian.org>, Aaron Kling
	<webgeek1234@gmail.com>, Carol Soto <csoto@nvidia.com>, Suresh Mangipudi
	<smangipudi@nvidia.com>, Vishwaroop A <va@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 2/3] spi: tegra210-quad: Track DMA mapping state
Date: Mon, 26 Oct 2026 11:14:11 +0000
Message-ID: <20261026111412.3843954-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261026111412.3843954-1-va@nvidia.com>
References: <20261026111412.3843954-1-va@nvidia.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF0000A890:EE_|SA3PR12MB8439:EE_
X-MS-Office365-Filtering-Correlation-Id: 5c9c2209-e4c3-4aa1-b693-08df33524e13
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|23010399003|376014|1800799024|36860700016|5023799004|11063799006|56012099006|261021121427099003|261021123027099003|261022105027099003|261009223027099003|10067099003|18002099003|22082099003|3023799007;
X-Microsoft-Antispam-Message-Info:
	39IF9nz3bi4BxtnGS3xTio3LJldQavll+EBpsYtxULtg92c3E9/OCN2otrCcsPY9GuV403l9vUcHOkf6AB09tR9Tht3RFDP5l/ZGyvz84PDaRBRwDJdtLWDLdLCzUPEUCK3r9i3FjzsqQ4qcIJ+Xwjoinwcv+jc0OVMZT4fjKQytsBHw50xPMBkXBB7P49Fw2WtbhgeJfWdxbYnaNHaoZAtKg0Owjqx1Cd8qu8FGmehE6KevIqSIr2sRXn9Njw9oRybO2W9InQprHW6nrle7NXZFxowXNFTKuydQK0fOyLtGSccB197w3TPCxnDLpuPPnA6DkWlj77l4jW9Qbjpdboz+EeznTnTmgeUhJaR+4B9DZH/fNZbrTD3/oVai5kCJHOAHxRBWX3TBD9x3mWXOLkcEdOf+qkQXfQS+P8OKvKGNqLsHkvoCoQ8YOJZQIUMdqYyJBM/o4a/BLro87hrZLA08RuSCmdhowmCtMKAZpnnP+961KRtsY66VfgBGnkjUBfonHLIUOXU7u85QdkisPwlU7jYHf78Yd7RIauDUWGyhYRJNYrUnYY1zoqpcyrQ87bHZh1dnKv8vEftSkR81ZCezH2iZd/+XBCPtVWJWOnW9eiYP52b69wigXe0xMlviI0K+nlpJ1c4vVAIQNpnkjCzUoSInWOxNxN1ggCtyjSMyi8mOdOqAobxlm11Knd44D9MQRtmNq3oSe3ZZCyipbA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.233;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(23010399003)(376014)(1800799024)(36860700016)(5023799004)(11063799006)(56012099006)(261021121427099003)(261021123027099003)(261022105027099003)(261009223027099003)(10067099003)(18002099003)(22082099003)(3023799007);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NI3V4I1TnNYdshcI+/kpUQIuAor9gNem37hkXcaTvyGWYc6hLGw027zgPOm+WXiZ+XT12+7t5G9sG8WKOrTTA+MH250bxh/KzjnnJAlz09RTqGfue287BCs/iUN+iH46sbw/Jgu9hYhOr2pH3eByua4ybA4iww1UC14EvVk4aU4n37P9Cmnd2Ox8WAaUUmYZZU8Cz9kw9pLV+mL4z77uRVzBx32ZZNXtUCoVtwJRfTXfPM0czPFoyQZcqbkp55xiG6fZ0y7l4g/TmGt5kZ+deZd2fA+LfbfB4cJWyyHfP1oXVCLPd/TlKEf411shMCzS/6fM3JBe031m1iO/aX5/gEj6xLuCWMbru66nu1uRzgyiYGxHQ4s/PZhZrk2fHKOuOgfzG0qpbr47Nw0ckec6nzWpKDFhC0uybZsuejtJ6s/Kf7fzyBaCwLcKakmMZcQH
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:14:29.8281
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5c9c2209-e4c3-4aa1-b693-08df33524e13
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.233];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF0000A890.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA3PR12MB8439

tegra_qspi_dma_unmap_xfer() assumes a streaming mapping is always
outstanding and recomputes its length from the live
tqspi->curr_dma_words. Nothing records whether tegra_qspi_dma_map_xfer()
mapped anything, so neither assumption holds.

For a multi-chunk transfer, handle_dma_based_xfer() unmaps the chunk that
just completed, recalculates the parameters for the next chunk, which
overwrites curr_dma_words, and re-arms the hardware. If
tegra_qspi_start_dma_based_transfer() then fails at its
tegra_qspi_dma_map_xfer() call, nothing is mapped. That early return also
sits above the smp_store_release() that clears tqspi->trans_status, so the
previous chunk's QSPI_RDY survives, and the re-arm's return value is never
checked, so handle_dma_based_xfer() returns IRQ_HANDLED without completing
the transfer.

The caller times out, tegra_qspi_handle_timeout() sees the stale QSPI_RDY,
concludes the transfer completed and calls handle_dma_based_xfer() again.
No DMA completion arrives, so num_errors is incremented and
tegra_qspi_dma_unmap_xfer() runs with nothing mapped. t->tx_dma then holds
either the DMA_MAPPING_ERROR sentinel or, if the RX mapping was the one
that failed, the preceding chunk's address that has already been released.
Behind an IOMMU the latter frees an IOVA that may since have been
reallocated.

Record whether a mapping is outstanding and the length that was mapped,
and return early from tegra_qspi_dma_unmap_xfer() when there is nothing to
release. is_dma_mapped is only updated under tqspi->lock, or on the timeout
path after synchronize_irq() and cancel_work_sync() have quiesced the ISR
and the bottom half.

Also skip releasing the TX mapping on the RX failure path unless a TX
mapping was created; t->tx_dma is uninitialised when t->tx_buf is NULL.

Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
Suggested-by: Mark Brown <broonie@kernel.org>
Cc: stable@vger.kernel.org
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 31 +++++++++++++++++++++++++------
 1 file changed, 25 insertions(+), 6 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 4a5933d8112c..d74aa46636ec 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -237,6 +237,17 @@ struct tegra_qspi {
 	bool					is_packed;
 	bool					use_dma;
 
+	/*
+	 * Set while a streaming mapping created by
+	 * tegra_qspi_dma_map_xfer() is outstanding, together with the
+	 * length that was handed to dma_map_single(). is_curr_dma_xfer
+	 * only records that the last armed chunk took the DMA path,
+	 * which is not the same thing: a chunk whose mapping failed
+	 * leaves the DMA path flagged with nothing mapped.
+	 */
+	bool					is_dma_mapped;
+	unsigned int				dma_map_len;
+
 	u32					command1_reg;
 	u32					dma_control_reg;
 	u32					def_command1_reg;
@@ -606,24 +617,32 @@ static int tegra_qspi_dma_map_xfer(struct tegra_qspi *tqspi, struct spi_transfer
 	if (t->rx_buf) {
 		t->rx_dma = dma_map_single(tqspi->rx_dma_dev, (void *)rx_buf, len, DMA_FROM_DEVICE);
 		if (dma_mapping_error(tqspi->rx_dma_dev, t->rx_dma)) {
-			dma_unmap_single(tqspi->tx_dma_dev, t->tx_dma, len, DMA_TO_DEVICE);
+			if (t->tx_buf)
+				dma_unmap_single(tqspi->tx_dma_dev, t->tx_dma,
+						 len, DMA_TO_DEVICE);
 			return -ENOMEM;
 		}
 	}
 
+	tqspi->dma_map_len = len;
+	tqspi->is_dma_mapped = true;
+
 	return 0;
 }
 
 static void tegra_qspi_dma_unmap_xfer(struct tegra_qspi *tqspi, struct spi_transfer *t)
 {
-	unsigned int len;
-
-	len = DIV_ROUND_UP(tqspi->curr_dma_words * tqspi->bytes_per_word, 4) * 4;
+	if (!tqspi->is_dma_mapped)
+		return;
 
 	if (t->tx_buf)
-		dma_unmap_single(tqspi->tx_dma_dev, t->tx_dma, len, DMA_TO_DEVICE);
+		dma_unmap_single(tqspi->tx_dma_dev, t->tx_dma,
+				 tqspi->dma_map_len, DMA_TO_DEVICE);
 	if (t->rx_buf)
-		dma_unmap_single(tqspi->rx_dma_dev, t->rx_dma, len, DMA_FROM_DEVICE);
+		dma_unmap_single(tqspi->rx_dma_dev, t->rx_dma,
+				 tqspi->dma_map_len, DMA_FROM_DEVICE);
+
+	tqspi->is_dma_mapped = false;
 }
 
 static int tegra_qspi_start_dma_based_transfer(struct tegra_qspi *tqspi, struct spi_transfer *t)
-- 
2.17.1

