Received: from SJ2PR03CU001.outbound.protection.outlook.com (mail-westusazon11012031.outbound.protection.outlook.com [52.101.43.31])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EA3D23BD06;
	Wed,  8 Jul 2026 04:52:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.43.31
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783486336; cv=fail; b=Otcp8UH8Hi0OlcKaLpWqEh0bIknM0udiRlZi2X+OMtRDmSgaRXugTDiMU/6U7jTJsatjgPQplnuK8Dmiq/uZP0+k7YBxKjwpSeyILpoHgad1gqxBg6VVWWgnKc+5yX3FjPlXvtnGQGRU43txJsVWeVrPw26clcdfAurl44rkC28=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783486336; c=relaxed/simple;
	bh=1QjRd43kfIonZgwCdzUwLi0VnR5OvPJENJCjFLguH7o=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=WPQRiqFr5dSq4qGjyG+88JwAn0Vbyns/LdKzOJZiawJZBiHaLJmBXm3dEDjBrvehZCdYUbKH0yAHXh6EDiEIM4jgVJ6NtZpRh16Hl1mQY0HUAFnui6zWTkLnCEXeUjCmX/Q70NRFJAQWAMTuLDO0Hu6xB08G3cyBi4VPtx8x1Ck=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=eYFpy75f; arc=fail smtp.client-ip=52.101.43.31
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="eYFpy75f"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=PXsPm1YAsjjIFSfvxmTeMnC4XEb7RZX4IOyUpRD2Q0+eccL4+lSlG/HKfcwrTHNG2meD3o6PIDUrmh4cVgM74CeVCXclfHLe9xZ4H+B6QDXiFNafkWRhj2htXYgXsQ4bjFINlkNYxw2+qur16KjKl29UzABt+yOkfGShVf2EJjyXgCEPB2suRxTZCIsLW7hOzSzaOzDSoo/M4JSR2GIiPxHSB3tonjcX7wEwQc+j8/5l5EFKO554Ou4jE4KVQtwdy1Nt6kDvcaKpY7futzfxFR0MjJ/4G7hTzmyf0bVNbo/gY/9ueqUeEYXRpWAyZVfyzJqtn8xhSIgUmz42jBs8Uw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=Uxc46giceCsQq9aCw7dDBCyh/GA72pz0bS+Mp872new=;
 b=LiUuHo21xYjw50lsOeNe9iKrAiWTOr8SfLNqtRoVgt+ekSb9/kMKFu2/UWA2MEyyBpu+H8OsqhYwbs0ox8rAmWFFgkrH2BxZ6AnBiu9tnwgS/I6vas79IjPiEjb5vU0l3tjuI1163tFbrwK6hfUPE9aXh515Q65yqjhmY2WsfPGd3CBux+ZXakqTo7wuiijcRQaXzoHJ17Si7HXGnEqwqCJO1FZ/IluN7q568uNR29iYySSvONKuTHKCQV7F2Ni0ROz37Jn/RkBKIY/+0MEgsKCYjkW1fp0GiKB6gUY1oOp58q2o2Fv0mO5xgKSIpoYkvwo5ascbMwS6qRv/WyEIxg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=kernel.org smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Uxc46giceCsQq9aCw7dDBCyh/GA72pz0bS+Mp872new=;
 b=eYFpy75fIuLJ43O9luiMOcuKC0EymN/bc6iyH+7qTvBqIcs/muW3hpFQdiOiypRLDcz99GhdX1LPFuqq2Z111o7adi/arbfDUoap3Oiv7KzXTADat2KTjsHulvuO5lBhYawAV4XPCfddGRCQ/vIfaoqV3KRorGP0WPSv/fzGwZs=
Received: from CH0PR03CA0053.namprd03.prod.outlook.com (2603:10b6:610:b3::28)
 by DM4PR12MB6424.namprd12.prod.outlook.com (2603:10b6:8:be::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.10; Wed, 8 Jul
 2026 04:52:11 +0000
Received: from CH2PEPF00000145.namprd02.prod.outlook.com
 (2603:10b6:610:b3:cafe::99) by CH0PR03CA0053.outlook.office365.com
 (2603:10b6:610:b3::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.9 via Frontend Transport; Wed, 8
 Jul 2026 04:52:11 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 CH2PEPF00000145.mail.protection.outlook.com (10.167.244.102) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Wed, 8 Jul 2026 04:52:11 +0000
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Tue, 7 Jul
 2026 23:52:10 -0500
Received: from xhdakumarma40.xilinx.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Tue, 7 Jul 2026 23:52:08 -0500
From: Srikanth Boyapally <srikanth.boyapally@amd.com>
To: Mark Brown <broonie@kernel.org>, <linux-spi@vger.kernel.org>
CC: <linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, Miquel Raynal
	<miquel.raynal@bootlin.com>, Pratyush Yadav <pratyush@kernel.org>,
	<git@amd.com>, Srikanth Boyapally <srikanth.boyapally@amd.com>
Subject: [PATCH] spi: cadence-quadspi: Fix indirect write timeout when DMA read mode is enabled
Date: Wed, 8 Jul 2026 10:21:48 +0530
Message-ID: <20260708045148.2993313-1-srikanth.boyapally@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000145:EE_|DM4PR12MB6424:EE_
X-MS-Office365-Filtering-Correlation-Id: 47d41d49-af17-4c9c-66a8-08dedcacac27
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|36860700016|23010399003|82310400026|11063799006|56012099006|18002099003|6133799003;
X-Microsoft-Antispam-Message-Info:
	43y3CRsKZiW3UsHGApSgSNqqb5G4Xz1nWkIkzADg2VOCH4I2lrRmqzIE1eMCoC9q8yn4RAWp1yL2z8Zp/hlMB4TZUkJlAUDYmVibUQYUxF+7Edlw7ui2WGgKuERAGYvY38yGxVzScnLSOB71aXIbUzdTChA3tKZxKlakwFFbNAzIizy2QHLiafztM08nmN8eYOS/KdyX6PoGo6lUdh2SvupiWB+AkYAq/5tMzeX/OhUQIlO4yphqe+yIrKmlBnPo1DXNi8aLIWAE7+MH3Y2bWTpAqhQ0JoJrIek/NU8NcuAuexRCKbbZDLcDYYct0l55IaG6L9E4rJuLonp3JIPNTOKb5Up8/wnlmGhkeglWTrgCpfNCi219OuEpu28awYWJZGQ0f35bdtc7U7cM2x2i80nY4xOGKPnZ0ceKtjSS7Wwa5Oo4wWfuCoXQpbLJf9VAO9CkIKSGV78EVjfDQaufklZ8m5ghwaMpUarrXeA5CLDCBeg8xOE+gRFOdyDP35NiEHFBbbgpPl27qyfWPc/h0HfLtZcMUQfJ71naDvCbxQ/04XRybRXisaz6DC+vl5dgfVyKkgrhudNuh1o+P8UL6TLEZjKJmVq+mNeBzLBPYI6Y2weUU+5HP6AUpfzWMsIzLGaJa0is7O1yzigF35bX2Lxn9J5eBRYs19WOBtvgtLmsiGcoFhcYwt8gcK2Cvo7+4tZDjiIejpk03aTv7NizpQ==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(36860700016)(23010399003)(82310400026)(11063799006)(56012099006)(18002099003)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	1K+OHPC8ocAF9lGxTvWM5DgeuTUOdL4+oCmO5dQIpnYMYkaHLvgjoCf3EFAiTxaMfcsfYVB+3lAAIBXKpQBKcGYZ69HKh7jN4fNN4vihf41w/qG7JxS5yWR9DltTfX0/htZfYz0Ce0/MY2GDEqABNvEusFh+mHyEDLWxXasxRm/iwUlD4h7+U7yaJtLF1he1Ti/rAeO8ffxZ2/4FTsrd3TAe0HSdcgMWOHB8+hIf+Qut/IgU2GIps4Qq8kTudqlUgNIJNrJVSnqRFSnlKoTrBYA89bE+8syd2CBrqxhZqMSBuPGi3yzydfmpQ+Djv2eSS0y1B4odT0+PQMzbRvfgkGGLi/DIRuI3bx2KbNLQoiLuvwPgFlxWUMOMI4XU6J8+vMAJV1W37EQnlYX18HYSHUv5rtXwJjFuE6D6X373/BN3uB0yFkfg3T2mN7rwIoc9
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Jul 2026 04:52:11.3388
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 47d41d49-af17-4c9c-66a8-08dedcacac27
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000145.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB6424

When use_dma_read is enabled, the IRQ handler unconditionally overwrites
irq_status with the return value of get_dma_status(). For write operations,
DMA status returns 0 since no DMA read is in progress, causing irq_status
to become 0. The subsequent completion signal is never triggered and the
write operation times out with -ETIMEDOUT:

  cadence-qspi f1010000.spi: Indirect write timeout
  spi-nor spi0.1: operation failed with -110

Fix this by separating the DMA completion path from the write interrupt
path. If get_dma_status() indicates DMA read completion, signal completion
and return immediately. Otherwise, preserve the original irq_status so that
write completion interrupts are correctly recognized and signalled.

Fixes: aac733a96636 ("spi: cadence-qspi: Fix style and improve readability")
Signed-off-by: Srikanth Boyapally <srikanth.boyapally@amd.com>
---
 drivers/spi/spi-cadence-quadspi.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/spi/spi-cadence-quadspi.c b/drivers/spi/spi-cadence-quadspi.c
index 65aff2e70265..89873f8b3f21 100644
--- a/drivers/spi/spi-cadence-quadspi.c
+++ b/drivers/spi/spi-cadence-quadspi.c
@@ -382,12 +382,16 @@ static irqreturn_t cqspi_irq_handler(int this_irq, void *dev)
 	/* Clear interrupt */
 	writel(irq_status, cqspi->iobase + CQSPI_REG_IRQSTATUS);
 
-	if (cqspi->use_dma_read && ddata && ddata->get_dma_status)
-		irq_status = ddata->get_dma_status(cqspi);
-	else if (cqspi->slow_sram)
+	if (cqspi->use_dma_read && ddata && ddata->get_dma_status) {
+		if (ddata->get_dma_status(cqspi)) {
+			complete(&cqspi->transfer_complete);
+			return IRQ_HANDLED;
+		}
+	} else if (cqspi->slow_sram) {
 		irq_status &= CQSPI_IRQ_MASK_RD_SLOW_SRAM | CQSPI_IRQ_MASK_WR;
-	else
+	} else {
 		irq_status &= CQSPI_IRQ_MASK_RD | CQSPI_IRQ_MASK_WR;
+	}
 
 	if (irq_status)
 		complete(&cqspi->transfer_complete);
-- 
2.34.1

