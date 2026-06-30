Received: from SN4PR2101CU001.outbound.protection.outlook.com (mail-southcentralusazon11012065.outbound.protection.outlook.com [40.93.195.65])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A968C27727;
	Tue, 30 Jun 2026 06:16:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.195.65
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800178; cv=fail; b=HOJ5w6isQWPbR/fXp2Qqs78TgTuDm77aUDDEqlq/ZNtTB6T7g1thHE4mcY43jdErmP/UPkZStFKAmTOa7uvp/OIgdy3ao3NuZKNOk8NF9/itpxGe+1JNB37ANzRCl/ZsmkQ+veYCTJBfBMv6zUMapRjJFQBEXqY05DUiWwnrABI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800178; c=relaxed/simple;
	bh=0pXfTWgJU7N+fm69wlmfb4pvbgr6wmxMicu6elk8G8s=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=poRqw2UjaK28XSC8Zr9gFexHtTCGPDMgfYGfp18qcIhqSr0HzChnAwWdnMyJ/eqDD82zRPZPinj9vAVKSFSjFlauJsp/d0xTEqwOxlFjanaEV6T4C5JoP3jgAh5bzQCEl/2bb1f8deElHVKHlyj6i2sZr/Xd4UFrI/GKz7y4CBk=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=HMZuYA7H; arc=fail smtp.client-ip=40.93.195.65
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="HMZuYA7H"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=I9/6OcX0bv2wMuamqNrroXsrBrQQMNoylNFQdO+WCWetc8kyBNvO1ZgO/1NMtc6ciOSb8N8ZK4dcirgiUZi/vL1ZsgqiGbsIdMM7Euu6XRZIXQDeBxVBCDHgjFXoPVehmrnigQK7jTrwfXPW8JAKXj6pHe65tOKZD0mCwbzxhrfw2FaeZx62COHXy7LCzmmIYwa5ru0MeN5FPy0vr6khQSw4ffdRGd2AxWEzP+ycLeoJ9yqJAfOIqdrAMrE1oojLbkId5tL5WlW+hvqFJF1W8vcFKIsgkJuGUiIkUkTQWPLaUCd/uYG7KQEs12PM/q9RouZMbW4VzPNPgQ8tZsKOyw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=+/0xMao6Ye2Zt5tnMXkzdNMlAG32bCJnSLhjyoYnOZ0=;
 b=MIHkxDLQKKZXRW4j7Rm6vZUDP1ILayvRl5DNToUGlr9DBAWhA+AK0pdowzGficEe+0wllSjjylNAR6yVTyeoVoRnPd1ygZexdnpOQ4dyTzjl6e+e485Qc9bWxyXWP9rfELE7e+UnRE3ibay/q9SqGQBFCvBX8yXUI/Y7srLafTJb8s9Hy3Av/01QSDNS1g4tRlmffXhJ1RnHFPjfAZxVNbLhUbCg8TfIx/Vs4JWcHW+axzPMwix2OrNQtNNw1u6vLEQOJ3NCfJoHLj+g8MRYSs3hcoirytqU2f3Y+z8N/1364JOJXjqb7kL1ynD8kXGOn5F+YBuZ/+AUvTuw+D0a0w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.161) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+/0xMao6Ye2Zt5tnMXkzdNMlAG32bCJnSLhjyoYnOZ0=;
 b=HMZuYA7HRnf/5au4JAYuW0VQVu9vz6MMkeeutV0lDYRnH5G28CRcAqvlbij2+duEvo0kSfeGKrJFouygaK5OVnwKcYnGNaShTesfpkR2+IrjWh23A+228Q2kJo06MxXy4hchpW7JuLrjLJi/Aq/iW40PYuv8k98mawxQRMFgFvy8/w+4fGz8edrlxsWFGthiSVDynErUDZJTBVmslo/bPqBu64dVTVhyqPReAvOoxIGfK+hPqjPH5JksQbQ1Qovd/enHTlMCfkXwzguAqGjLayYMI4KPbYJSvaNAHCsEpXVzmuLEH/JFHk+YVmvKqvdFEZoHsjuF0cLHclRtEvLIAQ==
Received: from CH0P223CA0006.NAMP223.PROD.OUTLOOK.COM (2603:10b6:610:116::24)
 by SA1PR12MB7197.namprd12.prod.outlook.com (2603:10b6:806:2bd::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:16:11 +0000
Received: from CH2PEPF00000141.namprd02.prod.outlook.com
 (2603:10b6:610:116:cafe::9e) by CH0P223CA0006.outlook.office365.com
 (2603:10b6:610:116::24) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 06:16:10 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.161)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.161 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.161; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.161) by
 CH2PEPF00000141.mail.protection.outlook.com (10.167.244.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 06:16:10 +0000
Received: from rnnvmail203.nvidia.com (10.129.68.9) by mail.nvidia.com
 (10.129.200.67) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:15:56 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail203.nvidia.com
 (10.129.68.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:15:56 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 23:15:55 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v7 2/7] iommu/arm-smmu-v3: Implement is_attach_deferred() for kdump
Date: Mon, 29 Jun 2026 23:15:35 -0700
Message-ID: <cc28808af74240a49c9723b9de448286defa2436.1782799827.git.nicolinc@nvidia.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <cover.1782799827.git.nicolinc@nvidia.com>
References: <cover.1782799827.git.nicolinc@nvidia.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-NV-OnPremToCloud: ExternallySecured
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: CH2PEPF00000141:EE_|SA1PR12MB7197:EE_
X-MS-Office365-Filtering-Correlation-Id: db87ca54-1c23-496d-daca-08ded66f14ae
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|7416014|376014|23010399003|36860700016|1800799024|18002099003|6133799003|22082099003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	wkTSvFdS4vgecum6lY3ib4s1l6IT/FsspdTyhEsVU3x9KuSJ72G9Ym34tR3oDBYDFwx5mYqVBRnm/ryPFriMhH6Z4LRcqudYFUfhTrkDgvkjuNup5FPZ//DYGp4De4CEyFxZBD1bdDVGGETqRj4E230fn60ywzmU/39ESVBXtEKjlhGWM6aDrzAmMR4Dc/pQyfrrGwumjkIMu+7Yc7xxR/cocStMukOV/ju+kbOwzOtHdWbKe8A3OCkGQyNz1tYtp1IPaec4BqMQzotiXTyIgjr4r4DqSFgE1JHv+fex52i/Q+VPaP7OUOUb3f4dYrHgJoFFzwT7mJ/BV79Z9oBmLfk3AMsWtHKDCcWjgb2c6rOtp+WiPoF2R1FPGdhl4dwIN/xD0+4jUFWJAxy0BBZ7ZPD5Hqhf5QHPsyucZmeexRNbFURSK52q92kKy7bFVI6OuelLQEsdlRNHjXWs/SP5O4flL5EOA7tveI8fIvCjiy86mf9S320MyoSn2F8/zn2Iumoekw3Ukcux670EGDrjmlcUINjtiTea5ALesBFv+cliyENc66wV0xqyV+GE9saFS3aUoMZWKHzJoL6EqLVFFbeTU/9gszooxZf1u3bZLiWEgc+1RjbRwWHDBh5snWkVjdf9DEYEQ0y0H6GXAcFZf+drWTWwEzwSFg2NthYL2kq/RRPkB6ar5Zv2BfpUCEyBjB/mY0NBHic1ApllgrDSrA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.161;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge2.nvidia.com;CAT:NONE;SFS:(13230040)(82310400026)(7416014)(376014)(23010399003)(36860700016)(1800799024)(18002099003)(6133799003)(22082099003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	wgo6qGVT+E8wd5aLnzsSEsxZBWq/q8a3qhhSiJ3NhtaYFa8KsjsZ0gFRuRUkc+K2G+EB2kC7/mbSX/BR14KN0vN/HNgLejvlEVa2sY6MyrfPkuPj7MiZNUiAthiFil5zRu5LA+GXJptsVHXMK+O8dLz68aKdtzmLow08Re4F7aRfZ/qzURNVmHk4fvFkGrSrQJ+5w/evGeUw9lQTobvFwbTKB2HxNGOJqcsvoDiILCfb1BLPle4X+otJ+n71MGE7xV3BnptJRpP3A3llC7J9nbl9UQftXP8fqEjc+0Edv1t6sVOsa/kIJEeAafkGR+sbQll0TRGs0FtwL340SiLDfkf1kqhV6Z0T2pU8fWY7r8AKbi5/nhfYcPZFhjY29nXzSBXMcaju5uzmHA5HsXnwzBSf2OxsK4rODkp5ZF51jWqSEyI4xNslVTDjctXNftbQ
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:16:10.8147
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: db87ca54-1c23-496d-daca-08ded66f14ae
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.161];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	CH2PEPF00000141.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA1PR12MB7197

Though the kdump kernel adopts the crashed kernel's stream table, the iommu
core will still try to attach each probed device to a default domain, which
overwrites the adopted STE and breaks in-flight DMA from that device.

Implement an is_attach_deferred() callback to prevent this. For each device
that has STE.V=1 and STE.Cfg!=Abort in the adopted table, defer the default
domain attachment, until the device driver explicitly requests it.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Kevin Tian <kevin.tian@intel.com>
Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 24 +++++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index af97a22c11696..b4702945b7324 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -4198,6 +4198,29 @@ static int arm_smmu_master_prepare_ats(struct arm_smmu_master *master)
 	return arm_smmu_alloc_cd_tables(master);
 }
 
+static bool arm_smmu_is_attach_deferred(struct device *dev)
+{
+	struct arm_smmu_master *master = dev_iommu_priv_get(dev);
+	struct arm_smmu_device *smmu = master->smmu;
+	int i;
+
+	if (!(smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT))
+		return false;
+
+	for (i = 0; i < master->num_streams; i++) {
+		struct arm_smmu_ste *ste =
+			arm_smmu_get_step_for_sid(smmu, master->streams[i].id);
+		u64 ent0 = le64_to_cpu(ste->data[0]);
+
+		/* Defer only when there might be in-flight DMAs */
+		if ((ent0 & STRTAB_STE_0_V) &&
+		    FIELD_GET(STRTAB_STE_0_CFG, ent0) != STRTAB_STE_0_CFG_ABORT)
+			return true;
+	}
+
+	return false;
+}
+
 static struct iommu_device *arm_smmu_probe_device(struct device *dev)
 {
 	int ret;
@@ -4361,6 +4384,7 @@ static const struct iommu_ops arm_smmu_ops = {
 	.hw_info		= arm_smmu_hw_info,
 	.domain_alloc_sva       = arm_smmu_sva_domain_alloc,
 	.domain_alloc_paging_flags = arm_smmu_domain_alloc_paging_flags,
+	.is_attach_deferred	= arm_smmu_is_attach_deferred,
 	.probe_device		= arm_smmu_probe_device,
 	.release_device		= arm_smmu_release_device,
 	.device_group		= arm_smmu_device_group,
-- 
2.43.0

