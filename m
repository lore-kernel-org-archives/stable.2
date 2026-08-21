Received: from PH7PR06CU001.outbound.protection.outlook.com (mail-westus3azon11010002.outbound.protection.outlook.com [52.101.201.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E1D374745
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 11:42:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.201.2
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787312536; cv=fail; b=t5MIh87ZsFNfg2mKOMeWILx0pnJW//GvJAI5dR9pp1ZktzndlU4OxJM5gWKL1ghAv5mkoQpVtSVFHQoNVsCbWHI6h3GZjSNnagw3tKJ9eLMWBNVosV+j7KjxJtp5xytiw1vf5SYhUrT4I6bLGrx+EkXTI/Ug8wSgIrMsnoj8LVQ=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787312536; c=relaxed/simple;
	bh=U6zeQJcuZiT1jryRYjPDt2mE3ZHU+j1Ype2dNsiufvk=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Y+pM55l6trZ8GqnnlNq+fWrr+gk+vPTn0TAPWW1/0K0Hy7CGYGBcAlLbw0QoM6b7Rb594t6yU/FYBoh5FcIr6NmaB/eJT8BL53ZWqrMI50J4gfy+IRr2FQ/Jsq7iGhzJEbxFDwfm79eGk9cRFx1BWlg4FsOHo8MORsGIRLH8nJo=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=tmW3rVVb; arc=fail smtp.client-ip=52.101.201.2
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="tmW3rVVb"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=m9qZneiZ50H+KXbifPzOTQP1bWngfpqwo7VVVY8gcNIVzvbVcM4x9a21kIl39baSTlYyW+sfiNLwRACwAh09yKKI1SaEJ1gaUqvNy3X3SqRbIhKR8zFHzf3P8zRqkDm/41gcsb+/zR3fYdgT06V8KpOBaAj1D3KswIinX8Kry349BwGIgfC2fxcs4iNChYaomUAcdQuIyvAribwfYzK1CuRk2zAU/uH8qsGjB+s4r8FISkc8mUm2C5U9lRPsdbf1XJX48eaeQVe781l6K9e+La2Zg+sqS0HrWmhPW+n9OeGp6o8E0pMIKWRpqSCRdS6h83M0m9u4gkbkEAYrWuKlQg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ybHlkPcjUI46o/1HeAd+seuV3fFe/w+1esQhQPoOafc=;
 b=PUbgjyQyH2LoSm9/9U4IDMiK8s5KLnvPLE3KNSQgWZGg/b+NL0yTIjflhhIB488MebsjcvCxRobbXokXjuDAUUbVacjrclBbg6Q3nJXHlA/r0C/asO6lFv+WQCnZyWl29n7SdeS6A6Jz4s658J9DJRGbKF6zY17AuuJMtMQFhRJB6JhBXDVc6oxd/UiHoSMr9Y0DVNFVYqMYfUK5TB7sgc4KvBffVLQrqBDJhZJJDdMF+UpYY5rBR9jAZ8T/kDnbImBNfCLN2TtLlZhN/Zw0PTRo+B3DEXkQWAF9tq0uql3ueGnxvTJhdMkdYzBpO2QWXKIXQVSgoxSVF9fNjhQ4/g==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=vger.kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=ybHlkPcjUI46o/1HeAd+seuV3fFe/w+1esQhQPoOafc=;
 b=tmW3rVVbxPidQF5zdDQxB6MqBK0wV32IZ3nkwimDW9NYLMS9c6DpD8snsslu+w/6sV/yw7DTpUaksGwlndooR+OAUEIqJTaZ93XEaqA2VxtGNQ4r8g+O/y8iGAaEKa+doF5AFGsBBvb+0h1lTQu0DOdo0ilyFFMcx2seNL5o0s0RnEQ/bRaMv6NweCJsE9N2TQWGPIBFGn98hVTwwxgZwPUUwFgFDy9arwS06Qpc9RjL/Y3UOmXLA2kpprNF+DJ9ROPRSx2g5xEL2zNkAPop/Ns2TOJHfW0I7IJAjxb9iqEXsG2sy4Us7b0niM1Wk9HFWPUMON8j9cq6j3YJRTxGIQ==
Received: from BN9PR03CA0593.namprd03.prod.outlook.com (2603:10b6:408:10d::28)
 by SN7PR12MB6691.namprd12.prod.outlook.com (2603:10b6:806:271::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.339.10; Fri, 21 Aug
 2026 11:42:06 +0000
Received: from BN2PEPF00004FBF.namprd04.prod.outlook.com
 (2603:10b6:408:10d:cafe::8e) by BN9PR03CA0593.outlook.office365.com
 (2603:10b6:408:10d::28) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.339.11 via Frontend Transport; Fri,
 21 Aug 2026 11:42:06 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 BN2PEPF00004FBF.mail.protection.outlook.com (10.167.243.185) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.360.3 via Frontend Transport; Fri, 21 Aug 2026 11:42:06 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Fri, 21 Aug
 2026 04:41:49 -0700
Received: from moonraker.nvidia.com (10.126.231.37) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Fri, 21 Aug
 2026 04:41:48 -0700
From: Jon Hunter <jonathanh@nvidia.com>
To: <svclkml-review@nvidia.com>
CC: Jon Hunter <jonathanh@nvidia.com>, <stable@vger.kernel.org>
Subject: [PATCH 3/4] ASoC: tegra: Sort ADMAIF register defaults
Date: Fri, 21 Aug 2026 12:41:29 +0100
Message-ID: <20260821114130.54376-3-jonathanh@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260821114130.54376-1-jonathanh@nvidia.com>
References: <20260821114130.54376-1-jonathanh@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-NVConfidentiality: public
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: rnnvmail201.nvidia.com (10.129.68.8) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN2PEPF00004FBF:EE_|SN7PR12MB6691:EE_
X-MS-Office365-Filtering-Correlation-Id: 61d6ef33-b6c1-4819-d63e-08deff793a22
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|376014|23010399003|36860700016|22082099003|18002099003|6133799003|10067099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	TxoeNmFTs4a2n1m8GMqrrvGuDrd7PQkjenqGr1iy7eF/3NApKdELklD48kPTswLBudDGQOSDzWwzMjX2ESBQS1IxHGTfGhE0lhnrvVydSt2ngRHVwDm4troy1B3MgszbAO/vbjSZSpmE7I+63ZARrf+OPsA+s25nSZqkK5QC0V6sN5nqaIrTMemdQ0H3Exr4nA2Vjav7YmO4LEJfwV5h1h4CF7rLs60GZURD5QU5zBK1jfbVyzgjfbZOYvphlY9xRcKk7hU5iwHSedeTY4Gfb/D9Q+qI+vWC3YT5PRa/S+sVL/9pNsBnpB3TuRzkBn0WjG91F2l2Xa2zw92WQFxtxk1ZhC+YobwIluORRRV4mY2sIjBlSqu13E1R6EhDNQAFxS1f4sJJhrnvl8WRoApPzc7CF4adAHFohgGGHoCaOc9MHXzQHLiupnjSSmHPUWIwV7zfE+qyG7eKTdIE4cgZy299IfXKF+HwQAt0eqvHoXHwRqyw4mDuDHYa7d6OozgfVZL+5RcNcrhvq040nQPXQWH11leAefyl4utIpLNBujGsXuBM6aJbNVVx68fOn1KIO4gJfAtMu2a/YepmnTH3ZNUOyHVZ38OUT2vcGAgUkLgZlaqQTTe/4sdXpEYgM4OZVUw5LHjVHP9XAsSU4PfAg3X+8Nd0ZNLxD38Ad7oQ65ksACGxYgQ94D3bnrX/1BrrJdH3zo8zr9XXEwTNGsI46A==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(376014)(23010399003)(36860700016)(22082099003)(18002099003)(6133799003)(10067099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	/ns8nbWUpXY2One7lGK+uH0tWKZqAFIE0H8H8z0jQNK8vYosVppfX3BRYT2RtLqvKue4zDLw1hbM0aIM2eWyIK9ybxshc4xFlpZOo37KvH3FF98XXFiNip5ClFcZzcTMLgMWJZMsYC7ztsqB9HX3o+Fl81icoXToDoOfXniy9LTuu2QbQRrN5HiS2eX8KwmQrc5Jua70E3ulKO+LZTbLvbQNAIdDst2rzkeQZOZeDD+mjH/QC45TizS1oj0N69e7Nz8MNXjDqxki9vj2JmW1Y0ipc6M+0aLg0Z3IvNUejOW7WuFdj5JIQlagPG58y0DFpo1wKCMlrA3P0FFD/4i9yQm7YqcVa6jZy6kj2wKbG6osyasCsorXDoK3h12oM+vCtpcfuqOTr9oskoWW/6j+guJl+1YwiOn8RB/FmW/hWX7xI8AerYKTzQRhoHMsplW1
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Aug 2026 11:42:06.2929
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 61d6ef33-b6c1-4819-d63e-08deff793a22
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN2PEPF00004FBF.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR12MB6691

Commit 4b05ccb17f92 ("regcache: Sort the local copy of an unsorted
reg_defaults array") exposed an issue in the Tegra ADMAIF driver and now
the following warning is observed:

 tegra210-admaif 290f000.admaif: Driver needs fixing: Unsorted
  reg_defaults, sorting the copy

This warning occurs because register defaults in the structure
tegra186_admaif_reg_defaults are not specified in ascending order which
is required by regmap. Fix this by sorting the register defaults
according to their address. Note that in order to do this it is
necessary to split the macro ADMAIF_REG_DEFAULTS into separate RX and TX
macros to the RX and TX registers.

Fixes: f74028e159bb ("ASoC: tegra: Add Tegra210 based ADMAIF driver")
Cc: stable@vger.kernel.org
Signed-off-by: Jon Hunter <jonathanh@nvidia.com>
---
 sound/soc/tegra/tegra210_admaif.c | 208 ++++++++++++++++++++----------
 1 file changed, 138 insertions(+), 70 deletions(-)

diff --git a/sound/soc/tegra/tegra210_admaif.c b/sound/soc/tegra/tegra210_admaif.c
index 7299c6bfcf15..87e898cc35e4 100644
--- a/sound/soc/tegra/tegra210_admaif.c
+++ b/sound/soc/tegra/tegra210_admaif.c
@@ -26,94 +26,162 @@
 
 #define CH_RX_REG(reg, id) CH_REG(admaif->soc_data->rx_base, reg, id)
 
-#define REG_DEFAULTS(id, rx_ctrl, tx_ctrl, tx_base, rx_base, cif_ctrl)	       \
+#define RX_REG_DEFAULTS(id, rx_ctrl, rx_base, cif_ctrl)			       \
 	{ CH_REG(rx_base, TEGRA_ADMAIF_RX_INT_MASK, id), 0x00000001 },	       \
 	{ CH_REG(rx_base, TEGRA_ADMAIF_CH_ACIF_RX_CTRL, id), cif_ctrl },     \
-	{ CH_REG(rx_base, TEGRA_ADMAIF_RX_FIFO_CTRL, id), rx_ctrl },	       \
+	{ CH_REG(rx_base, TEGRA_ADMAIF_RX_FIFO_CTRL, id), rx_ctrl }
+
+#define TX_REG_DEFAULTS(id, tx_ctrl, tx_base, cif_ctrl)			       \
 	{ CH_REG(tx_base, TEGRA_ADMAIF_TX_INT_MASK, id), 0x00000001 },	       \
 	{ CH_REG(tx_base, TEGRA_ADMAIF_CH_ACIF_TX_CTRL, id), cif_ctrl },     \
 	{ CH_REG(tx_base, TEGRA_ADMAIF_TX_FIFO_CTRL, id), tx_ctrl }
 
-#define ADMAIF_REG_DEFAULTS(id, chip)					       \
-	REG_DEFAULTS((id) - 1,						       \
+#define ADMAIF_RX_REG_DEFAULTS(id, chip)				       \
+	RX_REG_DEFAULTS((id) - 1,					       \
 		chip ## _ADMAIF_RX ## id ## _FIFO_CTRL_REG_DEFAULT,	       \
+		chip ## _ADMAIF_RX_BASE,				       \
+		chip ## _ADMAIF_CIF_REG_DEFAULT)
+
+#define ADMAIF_TX_REG_DEFAULTS(id, chip)				       \
+	TX_REG_DEFAULTS((id) - 1,					       \
 		chip ## _ADMAIF_TX ## id ## _FIFO_CTRL_REG_DEFAULT,	       \
 		chip ## _ADMAIF_TX_BASE,				       \
-		chip ## _ADMAIF_RX_BASE,				       \
 		chip ## _ADMAIF_CIF_REG_DEFAULT)
 
 static const struct reg_default tegra186_admaif_reg_defaults[] = {
-	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA186_ADMAIF_GLOBAL_BASE), 0x00000003},
-	ADMAIF_REG_DEFAULTS(1, TEGRA186),
-	ADMAIF_REG_DEFAULTS(2, TEGRA186),
-	ADMAIF_REG_DEFAULTS(3, TEGRA186),
-	ADMAIF_REG_DEFAULTS(4, TEGRA186),
-	ADMAIF_REG_DEFAULTS(5, TEGRA186),
-	ADMAIF_REG_DEFAULTS(6, TEGRA186),
-	ADMAIF_REG_DEFAULTS(7, TEGRA186),
-	ADMAIF_REG_DEFAULTS(8, TEGRA186),
-	ADMAIF_REG_DEFAULTS(9, TEGRA186),
-	ADMAIF_REG_DEFAULTS(10, TEGRA186),
-	ADMAIF_REG_DEFAULTS(11, TEGRA186),
-	ADMAIF_REG_DEFAULTS(12, TEGRA186),
-	ADMAIF_REG_DEFAULTS(13, TEGRA186),
-	ADMAIF_REG_DEFAULTS(14, TEGRA186),
-	ADMAIF_REG_DEFAULTS(15, TEGRA186),
-	ADMAIF_REG_DEFAULTS(16, TEGRA186),
-	ADMAIF_REG_DEFAULTS(17, TEGRA186),
-	ADMAIF_REG_DEFAULTS(18, TEGRA186),
-	ADMAIF_REG_DEFAULTS(19, TEGRA186),
-	ADMAIF_REG_DEFAULTS(20, TEGRA186)
+	ADMAIF_RX_REG_DEFAULTS(1, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(2, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(3, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(4, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(5, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(6, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(7, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(8, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(9, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(10, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(11, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(12, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(13, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(14, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(15, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(16, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(17, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(18, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(19, TEGRA186),
+	ADMAIF_RX_REG_DEFAULTS(20, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(1, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(2, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(3, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(4, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(5, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(6, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(7, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(8, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(9, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(10, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(11, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(12, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(13, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(14, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(15, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(16, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(17, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(18, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(19, TEGRA186),
+	ADMAIF_TX_REG_DEFAULTS(20, TEGRA186),
+	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA186_ADMAIF_GLOBAL_BASE), 0x00000003}
 };
 
 static const struct reg_default tegra210_admaif_reg_defaults[] = {
-	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA210_ADMAIF_GLOBAL_BASE), 0x00000003},
-	ADMAIF_REG_DEFAULTS(1, TEGRA210),
-	ADMAIF_REG_DEFAULTS(2, TEGRA210),
-	ADMAIF_REG_DEFAULTS(3, TEGRA210),
-	ADMAIF_REG_DEFAULTS(4, TEGRA210),
-	ADMAIF_REG_DEFAULTS(5, TEGRA210),
-	ADMAIF_REG_DEFAULTS(6, TEGRA210),
-	ADMAIF_REG_DEFAULTS(7, TEGRA210),
-	ADMAIF_REG_DEFAULTS(8, TEGRA210),
-	ADMAIF_REG_DEFAULTS(9, TEGRA210),
-	ADMAIF_REG_DEFAULTS(10, TEGRA210)
+	ADMAIF_RX_REG_DEFAULTS(1, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(2, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(3, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(4, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(5, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(6, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(7, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(8, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(9, TEGRA210),
+	ADMAIF_RX_REG_DEFAULTS(10, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(1, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(2, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(3, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(4, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(5, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(6, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(7, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(8, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(9, TEGRA210),
+	ADMAIF_TX_REG_DEFAULTS(10, TEGRA210),
+	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA210_ADMAIF_GLOBAL_BASE), 0x00000003}
 };
 
 static const struct reg_default tegra264_admaif_reg_defaults[] = {
-	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA264_ADMAIF_GLOBAL_BASE), 0x00000003},
-	ADMAIF_REG_DEFAULTS(1, TEGRA264),
-	ADMAIF_REG_DEFAULTS(2, TEGRA264),
-	ADMAIF_REG_DEFAULTS(3, TEGRA264),
-	ADMAIF_REG_DEFAULTS(4, TEGRA264),
-	ADMAIF_REG_DEFAULTS(5, TEGRA264),
-	ADMAIF_REG_DEFAULTS(6, TEGRA264),
-	ADMAIF_REG_DEFAULTS(7, TEGRA264),
-	ADMAIF_REG_DEFAULTS(8, TEGRA264),
-	ADMAIF_REG_DEFAULTS(9, TEGRA264),
-	ADMAIF_REG_DEFAULTS(10, TEGRA264),
-	ADMAIF_REG_DEFAULTS(11, TEGRA264),
-	ADMAIF_REG_DEFAULTS(12, TEGRA264),
-	ADMAIF_REG_DEFAULTS(13, TEGRA264),
-	ADMAIF_REG_DEFAULTS(14, TEGRA264),
-	ADMAIF_REG_DEFAULTS(15, TEGRA264),
-	ADMAIF_REG_DEFAULTS(16, TEGRA264),
-	ADMAIF_REG_DEFAULTS(17, TEGRA264),
-	ADMAIF_REG_DEFAULTS(18, TEGRA264),
-	ADMAIF_REG_DEFAULTS(19, TEGRA264),
-	ADMAIF_REG_DEFAULTS(20, TEGRA264),
-	ADMAIF_REG_DEFAULTS(21, TEGRA264),
-	ADMAIF_REG_DEFAULTS(22, TEGRA264),
-	ADMAIF_REG_DEFAULTS(23, TEGRA264),
-	ADMAIF_REG_DEFAULTS(24, TEGRA264),
-	ADMAIF_REG_DEFAULTS(25, TEGRA264),
-	ADMAIF_REG_DEFAULTS(26, TEGRA264),
-	ADMAIF_REG_DEFAULTS(27, TEGRA264),
-	ADMAIF_REG_DEFAULTS(28, TEGRA264),
-	ADMAIF_REG_DEFAULTS(29, TEGRA264),
-	ADMAIF_REG_DEFAULTS(30, TEGRA264),
-	ADMAIF_REG_DEFAULTS(31, TEGRA264),
-	ADMAIF_REG_DEFAULTS(32, TEGRA264)
+	ADMAIF_RX_REG_DEFAULTS(1, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(2, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(3, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(4, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(5, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(6, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(7, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(8, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(9, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(10, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(11, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(12, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(13, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(14, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(15, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(16, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(17, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(18, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(19, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(20, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(21, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(22, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(23, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(24, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(25, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(26, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(27, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(28, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(29, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(30, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(31, TEGRA264),
+	ADMAIF_RX_REG_DEFAULTS(32, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(1, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(2, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(3, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(4, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(5, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(6, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(7, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(8, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(9, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(10, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(11, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(12, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(13, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(14, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(15, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(16, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(17, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(18, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(19, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(20, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(21, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(22, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(23, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(24, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(25, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(26, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(27, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(28, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(29, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(30, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(31, TEGRA264),
+	ADMAIF_TX_REG_DEFAULTS(32, TEGRA264),
+	{(TEGRA_ADMAIF_GLOBAL_CG_0 + TEGRA264_ADMAIF_GLOBAL_BASE), 0x00000003}
 };
 
 static bool tegra_admaif_wr_reg(struct device *dev, unsigned int reg)
-- 
2.43.0

