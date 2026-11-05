Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.11
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793854169;
	b=tRembP9jwvKGH1/JhrsDZsbkBD+MiaUD3SktAIx82ihBjXgY0muDnWH+XgtfRkwlpE9F
	 N06ukvQh3TrvAkq3bjAaXttfZ3tg78lj6qLbsxwpcaX3J5l50DAFO5wId8mgMf8XGRYiI
	 XGCFORK+M5nZ7zKqMRKRR5T9UecR9JxSpMVLrgjuklbrklZ4LDiithAAWDijyiEWihsSG
	 ubkMXy4jcabGWE8q7FfKqAO4A5Hw53agCDeUVhPj3sdNPSwdGEV8Sl7BJgTsjgfOJxwFR
	 AsIBdJ8EVD1BmushNmvEyM8w+jGkYj+azWaDTR/rG0MQ0XDdIhbhi1o29OwpqrISXGA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793854169;
	h=DMARC-Filter:DKIM-Signature:Received:Received:
	 X-MS-Exchange-Authentication-Results:Received-SPF:Received:Received:
	 From:To:CC:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy:X-EOPAttributedMessage:X-MS-PublicTrafficType:
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
	bh=i08/JrMlXDV4Uh2YOMz+yddDO6kl/1hwjXGQA+roYA4=;
	b=Vz/dmQA4/13z1ngxYzwml263MrQBHmTX1JnvGdTQQIvkk7B/hWpbE7S44YORuBcRTfeq
	 O5bpR5dyiJVjBlJsnToDEEah7KUtWO21s3Ims39ERVXjvTGqPKm+NmbHq2uPcPwwf9OHb
	 4YJ6PHpwOUHqDpQcUSsfWDee5jT9PD37+DqQo5lDk/7c25qWUz++aXrve/L0BxP7O1Afl
	 Fk9V4Uif4shJzafT7gNoC+rQHsrsGIXpM5mjZcjHGBodqJYRhkff7q3Oer81qSr5DQzVw
	 9tILrfqdTn7pxxgz3gj4QuD0M5x8ej39sZe2IZgz/k6ex6PxYrOzYHpCYReZtNou8RA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=pass header.from=amd.com;
	spf=fail smtp.mailfrom=amd.com;
	dkim=pass header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fXO2VB5m;
	arc=pass header.oldest-pass=0 smtp.remote-ip=52.101.48.11
Received: from MW6PR02CU001.outbound.protection.outlook.com (mail-westus2azon11012011.outbound.protection.outlook.com [52.101.48.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (secp384r1) server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75B7C606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:49:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 75B7C606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=amd.com header.i=@amd.com header.a=rsa-sha256 header.s=selector1 header.b=fXO2VB5m
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=j748Xr8dgLqQFUyitv6v/aS0gwzDKA0M3eMlSr14DZzSB9OkaEIYDKCrKtZXJA3x+Al2fl+DMlF3fq0F4KZeQn+TgjQLSrsEw0BdlDZ+yZDoB9+mixp1jaPWPvZX2Q0tI0XF0cFUSyO5iJha3opzHliUVlMDRqm5SbTCSb6cZw6YPx+bfDXlWnDMD2Hk1uhPKXQVFBRcog5h3S24gwT+BrO08B/wFAX8PFNzUtqnrxZ/G0hLNlHOlYLOQnhIPJ05sP5lxAXiVGsK+esnfbSPAzfe5XQ6rS8eojFS4h7gDttAsMlQrLs3xyOX8VTE4dAXIeh1U3E4rj6PLr62gTeAiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=i08/JrMlXDV4Uh2YOMz+yddDO6kl/1hwjXGQA+roYA4=;
 b=XQwZu4+MZoUKAfYjXop27FQrEB030NmQ+6wdORdqCCnXCNDekltfsX1wmiaH3MM9UtWRQxWGwGa2GCEnhvn7lyxMPnUVxDKD6rAPuYLXkQAD5ZKhBf1YEw9GhupeiqkjDKJ2cRIxJynf7dSUIx0ysho/GNuOoSR8weykut3WFp+evWVSDyTLqVV85DutSuNcak/Wqr0am1zX2gqVOqeKTd2R7G2Sh4fKJRXkm2/bWjrMjiWIc9XB/nZKSug9ZUTUNHKEUmFLNDn0zVwLai3JSx85Z2Vbj5B6QSXn0OWthW1SGZziGLNx+gWAYXVZvoFKPs2hKg3sc77g4zBDq/RUQA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.linux.dev smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=i08/JrMlXDV4Uh2YOMz+yddDO6kl/1hwjXGQA+roYA4=;
 b=fXO2VB5mrlukjusZkEXeSb9BGW+IdmSOCGBcuia9+hdnKKN4geAQbb+hefNWbmq/zv4E9cHWZfcW/hcsLL2TWkdkNBX/J74QXE7V0u3imSp3yFpkKnh1HPIg1kRc22zlmHtGfdDCyxj6SfJDGTbunPKDhmmCFPJu46mCpdgtlz8=
Received: from BN9PR03CA0924.namprd03.prod.outlook.com (2603:10b6:408:107::29)
 by CH2PR12MB4039.namprd12.prod.outlook.com (2603:10b6:610:a8::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.592.10; Thu, 5 Nov
 2026 04:49:20 +0000
Received: from BN6PEPF00000075.namprd03.prod.outlook.com
 (2603:10b6:408:107:cafe::5) by BN9PR03CA0924.outlook.office365.com
 (2603:10b6:408:107::29) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.592.9 via Frontend Transport; Thu, 5
 Nov 2026 04:49:20 +0000
X-MS-Exchange-Authentication-Results: mx.microsoft.com 1; spf=pass (sender IP
 is 165.204.84.17) smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN6PEPF00000075.mail.protection.outlook.com (10.167.248.202) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.592.5 via Frontend Transport; Thu, 5 Nov 2026 04:49:20 +0000
Received: from kali.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.53; Wed, 4 Nov
 2026 22:49:17 -0600
From: Vasant Hegde <vasant.hegde@amd.com>
To: <iommu@lists.linux.dev>, <joro@8bytes.org>
CC: <will@kernel.org>, <robin.murphy@arm.com>,
	<suravee.suthikulpanit@amd.com>, <jgg@nvidia.com>, Vasant Hegde
	<vasant.hegde@amd.com>, <stable@vger.kernel.org>, Santosh Shukla
	<santosh.shukla@amd.com>
Subject: [PATCH 04/12] iommu/amd: Keep the GCR3 table while PASIDs are attached
Date: Thu, 5 Nov 2026 04:47:53 +0000
Message-ID: <20261105044801.399466-5-vasant.hegde@amd.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261105044801.399466-1-vasant.hegde@amd.com>
References: <20261105044801.399466-1-vasant.hegde@amd.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN6PEPF00000075:EE_|CH2PR12MB4039:EE_
X-MS-Office365-Filtering-Correlation-Id: 5ebeb40c-b6ac-4873-9b17-08df3af827a3
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|376014|23010399003|82310400026|36860700016|1800799024|5023799004|11063799006|56012099006|261021123027099003|261026121527099003|261022075727099003|261022105027099003|261021121427099003|261009223027099003|261102123227099003|261026140227099003|261028144727099003|10067099003|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	UsHqGgSWAdIoBL06S5bA3A1AS9J6nMoXwR6/WCaDKUW6e3s4eGt8bVeqwo1C5eGYDInnxY11aJVMGYZgz7G5i2R608GaVtyDLPQUxL0dIgqVOfYtBV80iQscBPxr7uEn7Tj3A0GPmvtNuz78Fc0T5kcDoWFu0bnadxAqzjvszf7tJfoDRZCKPEC//uEvMR2o/ol2wUlvrYWvb2Vd21TaIbOIZxmeZYwFTYg4imASdsA6tTqqVSuW9U/5RDHtRm32Z41WwNbE4cr0qPDhShqNmnZPNGlx6DRh3BdUbrvu1u3wNHnG4cfT+y8aMUeoZ5YU3R1IgnhfBJjK+YOxRKAL9NAArU9Z4y/WllIER6MLmjbmAheUFOqp3L1yHMRhEqJsspEqVkVaRPl/et6sGBZ6nW9UlFZc81q34j9aQOcU8Q1YobGweW+1yjzyhDSEGvF4zpiZh8KVb6VsY95IF9sL9Koar5E06vukj31SKWxDF0rTTJtViQC0C4E6WnKHQaTrW7bHUToPzfLw2ZuoeNa3GsEfD2PKkyMsFWj1o8oIvAwV34OorkASDXtMLfLBADe6IReAa+1xGjm1JAIdcn/OrfTZ0IyhrfRGHelluq0Qgu2mjzzwtAoBnCNaKWcQgodA46+I9GseacZiIDX4W2sezh9YbGUwJ2G9Theg1NZEUujcIBt362bTjZdRWp0bZ5tFEf3wzCC7dm+b8GssgzcANg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(376014)(23010399003)(82310400026)(36860700016)(1800799024)(5023799004)(11063799006)(56012099006)(261021123027099003)(261026121527099003)(261022075727099003)(261022105027099003)(261021121427099003)(261009223027099003)(261102123227099003)(261026140227099003)(261028144727099003)(10067099003)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	qmriY/9WGJGyZKbM9Qtx8cZoqvAN2pC3AktXq32wiSGEQX37Fa7Icxn525mkOklrwzUKoKiDxECE+KWlY1AIUexISP+IwBbl2B7xn32BuF4U4Ovu0dA9mKHljBwYZiFw+zfrwBFtBbECPuYXcEOT6j20q/JePvQ0TWjd2dxa9V/HKP/3lic2q2XF4rxltUCz7zr7Wnj9QWuattmmTAFG5NiVAS5Ff3FeW3UCt/AwXf10xUvOuHAmp/y3gTdR+gRIWVpH6p0zELl536BcpBSGl4vk804bey7g//t7uHvbBOnIBuymVCPN3UJ0h1JJNULrYJDYagmhOeGONtDkotzGIkp7zwvZIlYLxgiO3zrzeAS81Ra5FbM9YOrtoRgzLdPLVRIN1DF3jPjoBqUkE//2H5go9VjYCSAJYUyVrR0ZPOwpCwJw04g0En/+2Ig075oi
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 05 Nov 2026 04:49:20.0844
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 5ebeb40c-b6ac-4873-9b17-08df3af827a3
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN6PEPF00000075.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR12MB4039

pci_dev_reset_iommu_prepare() attaches the blocked domain before clearing
the device's PASIDs. detach_device() frees the GCR3 table during that
transition, so a later amd_iommu_clear_gcr3() dereferences a NULL root.

Do not free the GCR3 table while it still has attached PASIDs. The RID
GCR3[0] entry is still cleared before detach, and setup_gcr3_table()
reuses the retained table on re-attach. Free it from
amd_iommu_release_device() instead, after the blocked-domain attach has
cleared the DTE.

Fixes: c9e8701132e6 ("iommu/amd: Setup GCR3 table in advance if domain is SVA capable")
Cc: stable@vger.kernel.org
Reported-by: Santosh Shukla <santosh.shukla@amd.com>
Assisted-by: Cursor
Signed-off-by: Vasant Hegde <vasant.hegde@amd.com>
---
 drivers/iommu/amd/iommu.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/iommu/amd/iommu.c b/drivers/iommu/amd/iommu.c
index b429d8dfb3e9..da20ce511a4c 100644
--- a/drivers/iommu/amd/iommu.c
+++ b/drivers/iommu/amd/iommu.c
@@ -1949,12 +1949,12 @@ static int setup_gcr3_table(struct gcr3_tbl_info *gcr3_info,
 	int nid = iommu ? dev_to_node(&iommu->dev->dev) : NUMA_NO_NODE;
 	int domid;
 
+	if (gcr3_info->gcr3_tbl)
+		return 0;
+
 	if (levels > amd_iommu_max_glx_val)
 		return -EINVAL;
 
-	if (gcr3_info->gcr3_tbl)
-		return -EBUSY;
-
 	/* Allocate per device domain ID */
 	domid = amd_iommu_pdom_id_alloc();
 	if (domid <= 0)
@@ -2247,7 +2247,7 @@ static void destroy_gcr3_table(struct iommu_dev_data *dev_data,
 	if (pdom_is_v2_pgtbl_mode(pdom))
 		update_gcr3(dev_data, 0, 0, false);
 
-	if (gcr3_info->gcr3_tbl == NULL)
+	if (gcr3_info->gcr3_tbl == NULL || gcr3_info->pasid_cnt)
 		return;
 
 	free_gcr3_table(gcr3_info);
@@ -2722,6 +2722,7 @@ static void amd_iommu_release_device(struct device *dev)
 	}
 
 	WARN_ON(dev_data->domain);
+	destroy_gcr3_table(dev_data, NULL);
 
 	/*
 	 * We keep dev_data around for unplugged devices and reuse it when the
-- 
2.31.1

