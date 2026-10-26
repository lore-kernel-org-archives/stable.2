Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.66
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793013278;
	b=IvZ1VklOj9/R6/S2SP28FbEd9ieVikMlXWDybNDehdGaIVNvTm6PXdrVs2/RV7eaXZf0
	 MpGiYy09JjoPHjUajR8J5QW0ZQuj7ZCKYH6U4W2HSQWgb+nexWyGrDRIxjFe7tTu8UJUr
	 5qiZrF6hLHhaFSaodfd3NL32VfflssLFjIQ5M/mkH8wNKJc4nb73CiOeJgel4Bce4hz9N
	 hEB1dt1vqXfAJUN0+siKy+mqW7J98ijaJLQGtucABvd6Jp4uWJaxLNKQkaTqMmRwYRyMc
	 O2+Yc/8HtVtik4n1wvMRhGiAvRJp0v0DUvjdv6nncAkJXFN1YRk8OMGpIEWgyEmNCOQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793013278;
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
	bh=Dbvxn3QyxK3RyDBvgRWBLzyngGUK6F9OARXAkvkQo2Q=;
	b=q0cYKoCEyYYMYJmkgm+LiV3uXtYvJGAHEXUMEuKY6huZLLFt+ermlM7tibkxSiLgbW1H
	 UA5SEA4MqfGIwHrYPXwR6ffVGialfzIGC51MzNHNHRHTfF6EbbKG7vH0W2tVulXYXuadi
	 nNZ+4/dYTjxXott15tg9+cU9HSYNYyIoz8FOKmG3Pq2vku4GxQawRh7cFXfWmxi9n2Lpu
	 IAaK4nS2MRzYPOF122DlMbyz+Sv9wraAqPPz+fI2L/2l6waOMzi0xzT/2KH8OQPhO8fHJ
	 /6q6Tgzj8fGXuUMDwfedqYMfo7GInkN4EN8/sd+aeQZvPpEQn7k7GtStLmEVIkwQv5A==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=nvidia.com;
	spf=fail smtp.mailfrom=nvidia.com;
	dkim=pass header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iXJyh2Yj;
	arc=pass header.oldest-pass=0 smtp.remote-ip=40.107.208.66
Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011066.outbound.protection.outlook.com [40.107.208.66])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEF94606A91A;
	Mon, 26 Oct 2026 11:14:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEF94606A91A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=Nvidia.com header.i=@Nvidia.com header.a=rsa-sha256 header.s=selector2 header.b=iXJyh2Yj
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=fJrWuXcaf9CRBUWBnR62kvELNj/+dbZOYpaAT+7FzrH240+r+BEiPMs28ko6WpCGmZzQkbnE6srzPyoMrVRJzhwQ7qgHgWM0prP646cjPUE1fnuvVj7kKIXZ70KkQKsTo99rThgnJZbwJtAI9xJPLZzTkY/su9yR1cczKaRmtwx7lJd/BK6KsrOCPlQ5tdTX6LPqOvH4fpCBjjjqQ+QvL1GPPXhl0FTSnIpkNwE1KK4FOVmpWTzVuyOu2rC7yl9Zc1ReINxx2Dbj9wbkjZDuunD8aeE4mmeKU6qMCpOoHE47KoJL3ueyXoEkvkDYciNo4qG3zon69p+IRwzNB+e93w==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Dbvxn3QyxK3RyDBvgRWBLzyngGUK6F9OARXAkvkQo2Q=;
 b=n5jiFgJ9oogPN/1V6eSyLw5Jm7J9KXNclkDL8qmqlA13Ur7kQhImOnCt6T1ZvG95LLPQP8dHjgysVzVApzspUl7TXNlR2v5X3HA1R0w9/xIQ5WJYAWCDiUWCXEj6Twvh8kyyzD8Czz72RYbsoz3QSCTCuzG9rWzEO30TTjc8AxU2t426fX85PBaO59IX6dv4WWzNRWzOqQ3SRmQRlypDiEuefwe1G2NzAUcTAm1GQnPlgnE/QII6HC0o/leFYTkHPNIE7BXweaqBNHn/hsYv8zQbzqWYYzpXtvlxAXSTlzBajnh6fFwD3HwI4ZNrop25nrhQkUa3FDkt//XS5iMvDw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.118.232) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Dbvxn3QyxK3RyDBvgRWBLzyngGUK6F9OARXAkvkQo2Q=;
 b=iXJyh2Yjfmzr3dtc17v7Izd00Ez2ildAlex149zFftTk1GVpY3SLb3MRoz7OArYaJLc+oR2k7flUv8MokoWbJsiGBhRW7m9vWO2v9C6TS7sru9ESvctQBdRWVrEU9pdBTNlXyUAlv8qNKZ8L24Vn1ST1hroTCsI78nKZApIkdqGZEPvzNvwXyNc1DjsG25cOI3hqASvrZ0i13rsqBawT+4bjBDlZAW/Y+tathCGnEo1gkkzjtfhZlFU7uImRSlRn2t6K/xYZfwltwTeXjbCTf9P9CVc+16mU0dPGuSknJ0yGKtntGZTAxadNcy1vBOqxHYJmFPaM5OgfvvJj4+jVQA==
Received: from BN8PR04CA0042.namprd04.prod.outlook.com (2603:10b6:408:d4::16)
 by SN7PR12MB8146.namprd12.prod.outlook.com (2603:10b6:806:323::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.546.22; Mon, 26 Oct
 2026 11:14:32 +0000
Received: from BN7PEPF00000093.namprd03.prod.outlook.com
 (2603:10b6:408:d4:cafe::71) by BN8PR04CA0042.outlook.office365.com
 (2603:10b6:408:d4::16) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.546.22 via Frontend Transport; Mon,
 26 Oct 2026 11:14:31 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.118.232) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.118.232 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.118.232; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.118.232) by
 BN7PEPF00000093.mail.protection.outlook.com (10.167.245.71) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.569.4 via Frontend Transport; Mon, 26 Oct 2026 11:14:31 +0000
Received: from drhqmail201.nvidia.com (10.126.190.180) by mail.nvidia.com
 (10.127.129.5) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Mon, 26 Oct
 2026 04:14:14 -0700
Received: from drhqmail202.nvidia.com (10.126.190.181) by
 drhqmail201.nvidia.com (10.126.190.180) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.56; Mon, 26 Oct 2026 04:14:14 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.126.190.181) with Microsoft SMTP Server id 15.2.2562.56
 via Frontend Transport; Mon, 26 Oct 2026 04:14:14 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Sowjanya Komatineni <skomatineni@nvidia.com>, Laxman Dewangan
	<ldewangan@nvidia.com>, Breno Leitao <leitao@debian.org>, Aaron Kling
	<webgeek1234@gmail.com>, Carol Soto <csoto@nvidia.com>, Suresh Mangipudi
	<smangipudi@nvidia.com>, Vishwaroop A <va@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH v2 3/3] spi: tegra210-quad: Unmap DMA buffers on transfer timeout
Date: Mon, 26 Oct 2026 11:14:12 +0000
Message-ID: <20261026111412.3843954-4-va@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: BN7PEPF00000093:EE_|SN7PR12MB8146:EE_
X-MS-Office365-Filtering-Correlation-Id: 04062e1f-7809-4a48-8204-08df33524f41
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|82310400026|36860700016|1800799024|23010399003|22082099003|18002099003|56012099006|11063799006|261022075727099003|261021121427099003|10067099003|261009223027099003|261022105027099003|261021123027099003;
X-Microsoft-Antispam-Message-Info:
	PUTpuLt+R6Mb63RCV8uvt3oae7bCVUfLul2TdwG2m3msqghTFuh4AoKm43J+brMnOypiS8IxIt5jLnlcO6GVM/4eejDHlWPjkred0sRp56rolp4s6RxZMTGgsuLOJypvOtiyjtiGsJ/StuzPLzQEB++faYzcItiVL7jr2jQudXvtrfdQTgFbkeCPCbsDHHOsnvePbyYHbZp1pj8iDxfdEo48j+pEiMxyS/de+1fhX+CCZuqOFlegxkmME25WPVx2Ltk4HLCZYcmIljejOHtQQqu+QDpSlIiuwzT/gXEEcwrCwPCdLxkvK22iQgHPPXzoBmiN3PnJ9YWf0Bu7a6kfk+VQUTLnxqwbG8cGOPEV7++abt1MS9UrRES5pRxINI+1zVTnsKQOFwBTdfEfQzcVmoqrwZMlFcj9qRD7RAHGWuP99wafLx80RmTHB1yjPoGodMDoiRJdx4ZonU986KU9sOiK5O356RtRrBYNB3lTX95POe6Q75P24gIIwxnulhZ7AkvQjByQhZ9AZwjNHMbBUEKWAgEoVju5SHXryZjZy+cbTUIH2pxTfVuMJcgvhkcVk/qvC5daX6qGsbzSADcCPKl9BVAc0UapaRAAuo966XdNw92zYsujE1xwto2e62qhAYTtlgokEjo8rBkPOOmJYxVBT2PvwadbFH+Zui+dtywD2Pb7p+m4sIoT+DyEyl5vEpTBFTZKaF130jp1ZkCwbA==
X-Forefront-Antispam-Report:
	CIP:216.228.118.232;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc7edge1.nvidia.com;CAT:NONE;SFS:(13230040)(376014)(82310400026)(36860700016)(1800799024)(23010399003)(22082099003)(18002099003)(56012099006)(11063799006)(261022075727099003)(261021121427099003)(10067099003)(261009223027099003)(261022105027099003)(261021123027099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/R6Thl0vALK2zx5TNPNx5xDRMd9KyWCPF1/M5QLTQqZvjnYRJWPwDn58q67bpYOlIgETLMvjFeDrFpfKdA2VciUWCvHV+49XDR87GXQrMRlyfNMJCKZIm8CZhXznArI66BAfG1aYszEan8b339pthU2sF99UtiDLKE7vP+L8lvYCMz52r3yK4OqRrwM+NA6oeNhd9hM8PsymE2getDZoL9CcPjxFFY3eKEwi/NXvdiXbFsMkDP1+4r/zWO6XJts/fHWt09kdkF9+E4PpycCotAWm/NxrklzlbAEDOwGIOBbvTgoOJVjlUNU/YtnXCJ4pez5rClYuAiHBDHGERT55b/ZfooAHJaGvuXpX6mGgKMKaTMD4opLEC3/rsaKjNN8VO6cY6hVfFe9NvrSt33F4nvQSHz8Mmk56wdGAijCHv7ycH4T2+4/iOnLN1/yHFT+W
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 26 Oct 2026 11:14:31.8130
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04062e1f-7809-4a48-8204-08df33524f41
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.118.232];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN7PEPF00000093.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB8146

tegra_qspi_start_dma_based_transfer() maps the client TX/RX buffers with
dma_map_single() via tegra_qspi_dma_map_xfer(). The matching unmap only
happens in handle_dma_based_xfer(), which runs from the interrupt bottom
half.

When wait_for_completion_timeout() expires and tegra_qspi_handle_timeout()
cannot establish that the hardware finished, it returns an error without
the bottom half ever having run. Both transfer paths then abort the
transfer with tegra_qspi_dma_stop(), reset the controller and clear
curr_xfer, but never unmap the buffers. Every genuine transfer timeout
therefore leaks the streaming DMA mappings for that chunk, which
gradually exhausts the IOVA space on systems with an IOMMU in front of
QSPI.

Unmap the transfer after stopping DMA on both timeout error paths. The
unmap is placed after tegra_qspi_dma_stop() so the DMA engine is
quiesced before the mappings go away.

The recovery paths that do reach handle_dma_based_xfer() unmap there
themselves. The preceding patch makes tegra_qspi_dma_unmap_xfer() a no-op
once the mapping is released, so this cleanup cannot unmap twice or run
against a chunk that was never mapped.

Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
Cc: stable@vger.kernel.org # with "spi: tegra210-quad: Track DMA mapping state"
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index d74aa46636ec..58c87c45431a 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1507,10 +1507,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
 					dev_err(tqspi->dev, "transfer timeout\n");
 
 					/* Abort transfer by resetting pio/dma bit */
-					if (tqspi->is_curr_dma_xfer)
+					if (tqspi->is_curr_dma_xfer) {
 						tegra_qspi_dma_stop(tqspi);
-					else
+						tegra_qspi_dma_unmap_xfer(tqspi, xfer);
+					} else {
 						tegra_qspi_pio_stop(tqspi);
+					}
 
 					/* Reset controller if timeout happens */
 					tegra_qspi_reset(tqspi);
@@ -1624,8 +1626,10 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
 				WARN_ON(1);
 				dev_err(tqspi->dev, "transfer timeout\n");
 
-				if (tqspi->is_curr_dma_xfer)
+				if (tqspi->is_curr_dma_xfer) {
 					tegra_qspi_dma_stop(tqspi);
+					tegra_qspi_dma_unmap_xfer(tqspi, xfer);
+				}
 
 				tegra_qspi_handle_error(tqspi);
 				ret = -EIO;
-- 
2.17.1

