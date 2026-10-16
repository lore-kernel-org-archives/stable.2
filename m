Received: from PH0PR06CU001.outbound.protection.outlook.com (mail-westus3azon11011060.outbound.protection.outlook.com [40.107.208.60])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DA047986C;
	Fri, 16 Oct 2026 13:25:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.208.60
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792157160; cv=fail; b=ZVLvwr95zYH9bqeJXEcus7XmbR4hlxCiKYDSm3EvRMJ1rED7ZnnECS3vPq/6DWPaw2F3rIo4jQ6qrj0PBjngbTFyslUIxde/tffIDiTXy6ayBPXL6E5V+2t4szg4twV6r4c0ecEgK30it8/1TagZVC12WU7POEq3CrYzGaPxLgU=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792157160; c=relaxed/simple;
	bh=GqJgisMWi2RKYYMfEVi0h1lDVgV2aFSxWCZg5m0tmxc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pSTOihuchp76+5ftlWD8lBamsKWslq6VTUKdHCeQWdAnJepQtXBlUl9OnfJj0IgfvuC34+6ioFjqQUAOIFXE2+xtVK2zdhiYC6iBLVNyW2Qu+G2zNgtbGi+mjqvTkPUdWRUp7KDrYrBvjILhalvowPNN6WlskZhIoMSjqDMp1r8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=DbvG5kvw; arc=fail smtp.client-ip=40.107.208.60
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="DbvG5kvw"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Ya2w2srduAIjcqNyizxjGaEbJhz9HR0zBBxPpiuWf6wSKx1/Q0lUzYoX0cKrGCuFZVcUU3yMwtGcOlorF6853FvoupmvcrqvV2JQqSR+/Cj/pI0kgOnTUNyiJCdT1ZlV0qfYdkXbMstbU+/8AnrcB8D0FAekoR34P7tCd7n1Imwcpgf9/l3KOzXrSCd3K+9xQ93NsbW2W4PH0Kirmu+7QeS69RZeAwhEW82VOYSZiDpf0eTzc7OYz2Qswa5WnhA5jzXp+85cTbL5JST5y+a3oeYbMSeaDVxD2YO3vDyF+B+XbOUVKs5Kw0t6hLtRIekaSPFVIeibL4bvx/kr0flSzQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WFdJO1A88okii5rnjhgZ4CVsYxIlq0YUo1kDvnob/Jw=;
 b=N/CReEsMTKbrGh24tmnytWpcb3fqsH6aiR+cn9AIsG742IZopGdHTyrgBO9eDgQ80u90aSVsTtyxxJE7iGQ8Q73o5GAkjrdT0Yq49lu1YIPA81+xF6X21yNgRiXFAsTIxTUu/veSW3jYMKO4Wd/VEZC1hI9AnWLg+/EADD9ZbJu51jEG5bGRuvhzFbzR+DRXY2kMjjezXU/bG8PORM1PR5c+SmbeNDDDP0skmXbs5euYiRIALipWyb8qh+fr6/qUXA7ke+8q4D9sqS2EHvJfqxsT/HDYC1KB8i0HiCSI1aPfg6YizkrG/LghivQM9pQoyNK6ayBp+Wk15S4z3vGRHw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=WFdJO1A88okii5rnjhgZ4CVsYxIlq0YUo1kDvnob/Jw=;
 b=DbvG5kvwQYu+9NrKzzpNRb3nrZLGOW0rxrVQ+9220ndwTFqmxRI53BOOoeZ7PKvJIsKsV+cfkc+lR15/uluMtPWVrL6L8Gb8/tnxGk3uaG79KJmLDGrzErX0ApdrrAfAw5u+FFM6vr0/d1y/80kgsKB77Co0u/62lP5PJJiZaiD0Ji9J2OIYP+9UWhYm1UAdNo80OxOYXo6WqMitAe0WnBs4aUTkP1xIGfXzOYc9Y2vyUTHAts2V4FeyEvkWrLLYwbOM6mIQCbZX0DO/KOFSeOFKVg0/6Yr0WdAr+64XnU08Q6FjFOl0MjvbedaQeQ1dfScV1fJAtvFLqWO7QQ05XQ==
Received: from PH7P220CA0121.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:327::10)
 by SAWPR12MB999140.namprd12.prod.outlook.com (2603:10b6:806:4e2::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.522.13; Fri, 16 Oct
 2026 13:25:50 +0000
Received: from BY1PEPF000264B3.namprd02.prod.outlook.com
 (2603:10b6:510:327:cafe::c) by PH7P220CA0121.outlook.office365.com
 (2603:10b6:510:327::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.472.20 via Frontend Transport; Fri,
 16 Oct 2026 13:25:50 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 216.228.117.160) smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BY1PEPF000264B3.mail.protection.outlook.com (10.167.242.120) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.522.6 via Frontend Transport; Fri, 16 Oct 2026 13:25:50 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.56; Fri, 16 Oct
 2026 06:25:22 -0700
Received: from rnnvmail202.nvidia.com (10.129.68.7) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.49; Fri, 16 Oct
 2026 06:25:21 -0700
Received: from build-va-bionic-20260204.nvidia.com (10.127.8.12) by
 mail.nvidia.com (10.129.68.7) with Microsoft SMTP Server id 15.2.2562.49 via
 Frontend Transport; Fri, 16 Oct 2026 06:25:21 -0700
From: Vishwaroop A <va@nvidia.com>
To: Thierry Reding <thierry.reding@kernel.org>, Jonathan Hunter
	<jonathanh@nvidia.com>, Mark Brown <broonie@kernel.org>
CC: Sowjanya Komatineni <skomatineni@nvidia.com>, Laxman Dewangan
	<ldewangan@nvidia.com>, Breno Leitao <leitao@debian.org>, Aaron Kling
	<webgeek1234@gmail.com>, Carol Soto <csoto@nvidia.com>, Suresh Mangipudi
	<smangipudi@nvidia.com>, Vishwaroop A <va@nvidia.com>,
	<linux-tegra@vger.kernel.org>, <linux-spi@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>
Subject: [PATCH 2/2] spi: tegra210-quad: Unmap DMA buffers on transfer timeout
Date: Fri, 16 Oct 2026 13:25:20 +0000
Message-ID: <20261016132520.3723412-3-va@nvidia.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20261016132520.3723412-1-va@nvidia.com>
References: <20261016132520.3723412-1-va@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BY1PEPF000264B3:EE_|SAWPR12MB999140:EE_
X-MS-Office365-Filtering-Correlation-Id: 28a5f86c-0f38-4f21-d7eb-08df2b88fece
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|82310400026|23010399003|376014|1800799024|10067099003|22082099003|18002099003|11063799006|261009223027099003|56012099006;
X-Microsoft-Antispam-Message-Info:
	n/3VlhlP5fxWBKCr4a4PRJEfVI637jKWuCfDjJbJ1yZ5kC2WUADMLqPQDc3PY+nWvrYFnQrz44H0pmvN4hZXxuoYjiTPwlEG7GtrHRmQ/tHPDtK8YfMgkuVHZI7tKCv0e62NDo9DSEDoCvEWsul2AhWGZFOsqQd++ayzOyfpZAAEBOMzC8vH+NMHrimZOBA4Heb6Sbp2UHZeSXfq9F1CEab7dRocKLf4vMQuzmZ9Ji8UYyutGIPKBYDJbrPm88bsFJzbSKdmvkTVccwiZ4uoVmT5ObsT7WdVKyA3rSSe5X3oPcwirqqtVvWX6rCmqBfDwxuipDTmTQv8UV4zkXBIFZDxBz5U8qocpJrz5W+t+IuzLKB7uAjcztChK4KmvRrBBpdfDyKog1O6i6gcMZ7zZ9s1Io4LlbTaUx2BYyXJo+MhH0Edsk7YMYqN1LEzDdBMfc/4flnmzxGkCWcjLLECqy33DScW8tyrC7RC8R7KitzryvOAcFlF/QVpm7ZR1qPZhonD7BFHNQq/ddcgYwVz6k6eESQL73ugg7CQ5KhPZF3eUNB/cCRRswQU/2zUqR7OBgwvOo8lQgpnF9SiOqEc/OtFBAgYydu8tJSRLD5nxwY4LlB2Niy66hx2oqb7WlG++Hagf7kM9iyk0Y6r3ANvInJ6uXVUodQVlE+Lo1mMM3RYboLLWkp0OuR7q/nfRmxwP5Ya0Oxaz5kNW1/tAcbdug==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(82310400026)(23010399003)(376014)(1800799024)(10067099003)(22082099003)(18002099003)(11063799006)(261009223027099003)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	LbGpZqwL04+ZAV0R0rM4b8Ok4fn+itHNgpUaQ1HFz+uXKqR9L1n5efXt/4rzmusZ+Wjf19QAz3Z7ro8/I7IcYnsxbTqoZWGl1uYZqiu+cVAO4mhPn196lgeQfllSsFbVQPJOF2Nex+vDga+iJ+TBdiDmJvNCms5GrFdRMRE14wrc+kE1V7xCkW2F+I/p6ilsZ7smLI4PaCOlY5JuES2nM8Nxc8j2w7DQ7IqUVJXG68TzaEZzP9NAl2vWk/6iccaTSiDRtkwzY1C1U88StNFoGwOmDxYgJ/IEOhU3xyBpMfp+FyJnfRYtCPEibTUeR81uLQTUkLRzn0kyoL4mFmUPdrrGMRxQRpeheDpvvTkJiHt5z4CHbiq99JSEoyokrEmpfKiwBMFYdCjK05MbgyPE5orDwpyo/WKYcmlbkFC+mW/luhBLQvJMshLJFjMod/8a
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 16 Oct 2026 13:25:50.0169
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 28a5f86c-0f38-4f21-d7eb-08df2b88fece
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BY1PEPF000264B3.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SAWPR12MB999140

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

The recovery paths that do reach handle_dma_based_xfer() are unaffected:
that function always returns IRQ_HANDLED, so tegra_qspi_handle_timeout()
reports success and the caller's error path is not taken, leaving the
existing single unmap in place.

Fixes: 921fc1838fb0 ("spi: tegra210-quad: Add support for Tegra210 QSPI controller")
Cc: stable@vger.kernel.org
Signed-off-by: Vishwaroop A <va@nvidia.com>
---
 drivers/spi/spi-tegra210-quad.c | 10 +++++++---
 1 file changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/spi/spi-tegra210-quad.c b/drivers/spi/spi-tegra210-quad.c
index 4a5933d8112c..b77ad6990e7c 100644
--- a/drivers/spi/spi-tegra210-quad.c
+++ b/drivers/spi/spi-tegra210-quad.c
@@ -1488,10 +1488,12 @@ static int tegra_qspi_combined_seq_xfer(struct tegra_qspi *tqspi,
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
@@ -1605,8 +1607,10 @@ static int tegra_qspi_non_combined_seq_xfer(struct tegra_qspi *tqspi,
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

