Received: from CY3PR05CU001.outbound.protection.outlook.com (mail-westcentralusazon11013015.outbound.protection.outlook.com [40.93.201.15])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CAB73E5A05;
	Tue, 30 Jun 2026 06:16:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.93.201.15
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782800183; cv=fail; b=TaRjg+eyi+RATAbb+5n5+GmwCQtlqKdrvknSXD3HXxecI0aN1pUR7CNzDptte03/FL8PQlda+ocuZtUHmHNlgE/cB0EXx/SkOm7fMomvNRspOQvacR/lxVhy8EoctArcDZoJY/2Z9CZO1maJJqpzZf/B/93rFWxy8jgNeW5DFyk=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782800183; c=relaxed/simple;
	bh=5+FA+BUWEZSmv1/RuJAFn358sa7n8fXTY2gIrl7G2Jc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=o3GUdvDG7UgA15JmsrFL8XERPoGE/1wx7nD/wcihUT8NDCoX5swfoXeLmS02VXIibj67rMCfB0HT+vMIlFBLxIxWBiV2WCID8J9vCXXStj5nL7qc9GDOBcydjem8/gZHzuI2QRtxbDt18nBGWo3Hgkh3Q3ZnR39hG7JU+zAQtdQ=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com; spf=fail smtp.mailfrom=nvidia.com; dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b=C/l9x+UB; arc=fail smtp.client-ip=40.93.201.15
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=nvidia.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=nvidia.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=Nvidia.com header.i=@Nvidia.com header.b="C/l9x+UB"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=Hw7osWnvgcYdVayFeQ3CGjyIpNfQQfI+wHDa5pcOqYs+j6VC7MfRFmK2wMvhvU3gCr9gVFsCUnvBWqmF7tO6wVdHbYF58qwpySPEKZEwgzmZemseBRNO1bpYwl27doOwxWgVfo4ursRJTg6B5HMacTQNaRf1zDCL2uNqH6tGy9ybgi9zLjqbc+Ce8pVupfZNGvR3phgw5/xTvn+/Snq4AIWxVb7UjyABCxPxrH/jBZ447WdDJKi1n+A8jRFPSdkZpB06lipVVlr1zZtozxAZ4IpG6WO061nIWfgfrJ00rmEKK9FlciU6FPuTce3SugvR1N78scEgYzhgbwLnq9KuAw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=K2LdwxxDI9ffIdxx+0yXB7YMoZSe/5Cg1gCqCw1iIUw=;
 b=PVyHhTH4rOWMFmcOBH+IOovuZQ2psv2sRrCNKG2XtQpxFx+bbyYRMmf+cQdpTvpWTcVkno3WADomD1jT5FIQs8G1bMRC2Gdn7LDujFtvsrm7zGXjDtPtf76i4ykWbs523v9Y0r4Ut6JejJUeMXFyN8s/KBUSo9IsgjZqmmKeapmpGuGR1z6mljQYn3JoF711rvk/cViLBHpTmKghA7fXK/1k9782fqxBTm4mCGoFAdppH4vDcAN/BEYFLkUH7OXgXBBU81pFdZxcJ0xnQ62+OeBFjXK1rKCXZn+2p2Aoy36q312vZ3RqvNhOMtLQ/WIXNvy7p6g8UT/mLeoAwj+T2w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.117.160) smtp.rcpttodomain=kernel.org smtp.mailfrom=nvidia.com;
 dmarc=pass (p=reject sp=reject pct=100) action=none header.from=nvidia.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=K2LdwxxDI9ffIdxx+0yXB7YMoZSe/5Cg1gCqCw1iIUw=;
 b=C/l9x+UBkwm8OP9jzGzkRMB0sMksnPTViBwwEOWkryjO5JnihkaycuvpQeDdDpYiSzwBDpVyeydcW8an4JwEOgzQHJLkfqP5E0U66zc96GuvnqH5j3cmlQ8sCo2JcacZZmjlyUoFyauMNgMxREwjPmxPJPHzODFyV/5Inw+v81jFlV9sOdiZmZ9C+8rYp8jQW/19aqThQHHkbmTYYK/dIUoP9R9Ueuw2X9XtOX/exM7NY1nHhT3jkqGFyHJWV3zmDKjBboW9M58XaxXQd9Or83pt/GFUaNALCadM5uXpkMGsrqTmsQdfsdfccJA962CuwvOIoyUUPfLBBbC+5yCtng==
Received: from PH8P220CA0009.NAMP220.PROD.OUTLOOK.COM (2603:10b6:510:345::15)
 by SJ2PR12MB8942.namprd12.prod.outlook.com (2603:10b6:a03:53b::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.159.19; Tue, 30 Jun
 2026 06:16:17 +0000
Received: from SA2PEPF000015C6.namprd03.prod.outlook.com
 (2603:10b6:510:345:cafe::10) by PH8P220CA0009.outlook.office365.com
 (2603:10b6:510:345::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.181.8 via Frontend Transport; Tue, 30
 Jun 2026 06:16:16 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.117.160)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.117.160 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.117.160; helo=mail.nvidia.com; pr=C
Received: from mail.nvidia.com (216.228.117.160) by
 SA2PEPF000015C6.mail.protection.outlook.com (10.167.241.196) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Tue, 30 Jun 2026 06:16:16 +0000
Received: from rnnvmail202.nvidia.com (10.129.68.7) by mail.nvidia.com
 (10.129.200.66) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:16:01 -0700
Received: from rnnvmail205.nvidia.com (10.129.68.10) by rnnvmail202.nvidia.com
 (10.129.68.7) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.20; Mon, 29 Jun
 2026 23:16:00 -0700
Received: from Asurada-Nvidia.nvidia.com (10.127.8.11) by mail.nvidia.com
 (10.129.68.10) with Microsoft SMTP Server id 15.2.2562.20 via Frontend
 Transport; Mon, 29 Jun 2026 23:16:00 -0700
From: Nicolin Chen <nicolinc@nvidia.com>
To: <will@kernel.org>, <robin.murphy@arm.com>, <jgg@nvidia.com>
CC: <joro@8bytes.org>, <praan@google.com>, <kees@kernel.org>,
	<baolu.lu@linux.intel.com>, <kevin.tian@intel.com>,
	<miko.lenczewski@arm.com>, <smostafa@google.com>,
	<linux-arm-kernel@lists.infradead.org>, <iommu@lists.linux.dev>,
	<linux-kernel@vger.kernel.org>, <stable@vger.kernel.org>, <jamien@nvidia.com>
Subject: [PATCH rc v7 6/7] iommu/arm-smmu-v3: Skip RMR bypass for kdump adoption
Date: Mon, 29 Jun 2026 23:15:39 -0700
Message-ID: <bdb1e8c97159b87a8563a1f5e5f495b1d5cd734f.1782799827.git.nicolinc@nvidia.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C6:EE_|SJ2PR12MB8942:EE_
X-MS-Office365-Filtering-Correlation-Id: 04bcdd15-c672-40e4-1ae7-08ded66f1828
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|36860700016|1800799024|82310400026|30052699003|23010399003|376014|7416014|22082099003|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	PhV6y4glcLiZMDAGjbMkzsAUv6WwjetUgBqD1RzVy6u9pBHlHI8+aMeJ6gAsz/tIovGQ9gC8vKHadtvMepkpUjfPi1Nv/xmbRrGo5/YExTs40KjMwHTyMcEStvgEqmJQKW6rR8PYMe+wUw8KnrapYCA9vjL1Iud29zoT1v1/8ptwL/YFwQV1mC2hcyHVJMZx7WOc6CWCLp6tSJqsL8bQ2g1aZfTb+thpZUi720NKLAcZQLPfk7m5CZB7Jm/jZqVHNZGsjJyPZbIWPKS/lsXyF+oU/g3FZd8HxGuT+wkKT9kkjzZsaGiKpBmwiR6Tgxb9TYBU92wTC3hsb8B+dE/KDSv5VUzkvZmjzbbbO8D8pgQX+llZnrAoigIcXa29wNZLPzIlmFpRkfKbe3Bj+NZ9pHfQ3sM0SuCxE4mVyB3F6ApOOID+8/LNwtYF6YYNFtsscca6zaGe0t9mii0GwqOGAg8/zN0MW4OsL97DT+MZqhMDO6MtVSci747LEN/hdI2XpbAimtNFbBbTt3NrqkVujm4xlUI8lWD4es0Fi6bikD5anpYXgJCXPDXsC4kDS6ZQARjcF4PDebsYIxmbRUEiPy6Kid/M7rIN0Du3j+VOp/nBIsmziOYTvhyfWrJx9x4JGDbm7ThNeCqqtk0RAFcWvUv72ndW3e5tH4RJzZ+IoFLRd/wyDSoxgNITIYKfty90VdmJzMeGcxEcMvMeHdasDA==
X-Forefront-Antispam-Report:
	CIP:216.228.117.160;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:dc6edge1.nvidia.com;CAT:NONE;SFS:(13230040)(36860700016)(1800799024)(82310400026)(30052699003)(23010399003)(376014)(7416014)(22082099003)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	PWKtRcgKxv+Cq4Ws6Ak568JEHKAMcoJ3EFlWw0PkgBanASrUUoVk5ZqGIJSELBUC66zKvCv5NYMBO5K/8fY+CJOa2mpv2ZRm21bqDHf9A0xN+PUKzIaF8SBpgSP/mXtWRnFN8b0twaJu58k8KXrfLSN+bFpGwnz9SAjpWeCItgHujhfhUWlwAE9Lh5S683rkf3wC2YDijwaksZJwP9YxiscwOEdz7ftvGNdnRgJtbS9W/WFaXNCop+nblXSLEu+AWnrDjHWOmxZTjFIiokPkooWM9eRZjgf78gkLWAFyH6gLah5hN4TRP9NcN7RjG36+F1eqsETvbqCWaiVrh4IStjs3t2otIrQAl1KxllYMu6Xl0bF8kBlj5mQzD+tK6zBM7YBAHgSRlIH3cVpR/o381XxTGxvi4vB2eZH/mtHoUfHd0qe8gUaFTtFQSqSoo83+
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Jun 2026 06:16:16.6629
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 04bcdd15-c672-40e4-1ae7-08ded66f1828
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.117.160];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C6.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SJ2PR12MB8942

RMR bypass STEs are installed during SMMUv3 probe for StreamIDs listed by
IORT RMR nodes. A normal boot switches the driver to a fresh stream table
whose initial STEs abort, so those RMR SIDs need bypass entries before it
becomes live. This preserves firmware/guest-owned traffic, including vSMMU
guest MSI cases built around RMR-described SIDs.

ARM_SMMU_OPT_KDUMP_ADOPT is the opposite case: the driver keeps SMMUEN set
and adopts the crashed kernel's stream table, so RMR SIDs already have the
only translation state known to be safe for active in-flight DMA. Replacing
an adopted STE with bypass can turn translated DMA into physical DMA, then
point it at the wrong memory.

arm_smmu_make_bypass_ste() also rewrites the STE in place after clearing it
first. While the table is live, a concurrent hardware STE fetch can observe
V=0 or mixed old/new state.

Leaving the adopted STE unmodified keeps the kdump kernel using the crashed
kernel's translation. That gives the endpoint driver a chance to probe and
quiesce the device.

If the old STE was already abort or invalid, installing bypass would create
new DMA permission; leaving it alone is a safer failure mode. Later domain
setup still gets the RMR direct mappings through the reserved-region path.

Fixes: b63b3439b856 ("iommu/arm-smmu-v3: Abort all transactions if SMMU is enabled in kdump kernel")
Cc: stable@vger.kernel.org # v6.12+
Assisted-by: Codex:gpt-5.5
Reviewed-by: Pranjal Shrivastava <praan@google.com>
Signed-off-by: Nicolin Chen <nicolinc@nvidia.com>
---
 drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index 55ef2e7470a42..822ab73161969 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5658,6 +5658,14 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 	struct list_head rmr_list;
 	struct iommu_resv_region *e;
 
+	/*
+	 * Kdump adoption keeps the crashed kernel's table live. Rewriting the
+	 * adopted STE here could expose an in-flight fetch to a transient V=0
+	 * entry, or change Cfg=translate to Cfg=bypass. Must skip here.
+	 */
+	if (smmu->options & ARM_SMMU_OPT_KDUMP_ADOPT)
+		return;
+
 	INIT_LIST_HEAD(&rmr_list);
 	iort_get_rmr_sids(dev_fwnode(smmu->dev), &rmr_list);
 
@@ -5674,10 +5682,7 @@ static void arm_smmu_rmr_install_bypass_ste(struct arm_smmu_device *smmu)
 				continue;
 			}
 
-			/*
-			 * STE table is not programmed to HW, see
-			 * arm_smmu_initial_bypass_stes()
-			 */
+			/* The fresh stream table is not yet live. */
 			arm_smmu_make_bypass_ste(smmu,
 				arm_smmu_get_step_for_sid(smmu, rmr->sids[i]));
 		}
-- 
2.43.0

