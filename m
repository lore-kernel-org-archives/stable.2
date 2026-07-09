Received: from BN1PR04CU002.outbound.protection.outlook.com (mail-eastus2azon11010017.outbound.protection.outlook.com [52.101.56.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C011B266565
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:11:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.56.17
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602701; cv=fail; b=eSXgUciMq8mG4lujtdK5wHQhgsM7MXiX1r0hz37kvhJAO3gT8uT05s/80jHMCAahDv9wc8vVfFGWmGNdhM83Hz63JnfKfZ61tsR5HrmNlu4qC/bVEFzb8IHhySYhbYsHT/qIzt1lykrjec4JDThNevOgmfH/FdEiDngvzGl3maA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602701; c=relaxed/simple;
	bh=H9DeLwBTIVB6oLDnyfdYTVwxxw1UwhnPaRpoBylgOdM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=nIZHogdTUrdaZdAPCuw7obotx7m/pC+CbYCFejsq4yS+FTmTISzhxmEAcx8Dk2fNRFR7OD6kq/i/rfYmEXKpOmKwxzVar6TxXCB+UDJceZDiD+iuwOVTMqDHPZ5xG6NvEpUkICo+1feSDBzGIRUmVmqA1/jvaKPB38Id6cUsZT0=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=vCTIgY/L; arc=fail smtp.client-ip=52.101.56.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="vCTIgY/L"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=qxhX+8bMRlF23c+YEKcdouGpdd6a4cSmBgKSIwvnbz2Kzv6T5pEbWht1rYW+gBA2YnP54Bk80yOwFBCNZQlQvwFrzZBA5Fnu9z7w8Xn8oAVmYvps+boTnIYjagciwo4+vRp6sSyYqWcR14StyhLGT/10UJmchSakSu55nQpYA772chBJbj9YSCsvRmoljRNkdxJNHMwYXr6otnrtlNGI0pJ7PsSIf7d/EySknDPwrTcB+NSuY4Y6w6kRtpkoFgkyKTKpsGayjjMQoc6fv8YpE902dK0skrcoPq1sCWfxCMZVZTv+zY+TJLybfFfBTxQHEb3f6tHh72fAgLgVssIlhQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6XBTH+cLgG6VtDeHNZYCQYGBwiZdE7d+6kkXhwcMls=;
 b=X9GAfGmAijGE2PF4QSNu7th7MQnIhauJaix0jNO49+ls0IQc9N5nxWe4J7RSB1k3gDMEKr1w+N/vPyDfR0/sW3zu5NxQmWqSRlQX/PK3Xg3GF2+Nd+uMabH2YMAU7132+Jo3oBQrnut7PSgql2ukEaKUR0aFdIP8C4X+pmFrkzqUmu7UQBr1NtFCHYz7GIft9/c8Of7uIaVkyAAYoj1+BWeRDYxqXHs8TERRAKi1GOAeVFPNgS7QtUM95E5+T9s6XlXG+Pb78Hei0Eoz+g3vVkh52ZF8XYN0zszyHzKaqQfeOdjkLre371qtZujisHZ1C0T8H1cLwETyr7Oj5GFwXQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6XBTH+cLgG6VtDeHNZYCQYGBwiZdE7d+6kkXhwcMls=;
 b=vCTIgY/LpZh0OPQpD11kfZQKpFJIXAR6TpR16ZW60OPHjSTEO0pCbzt8qeWF8WFxVWW4jPqGoMZwaJ6OaCqJeKwuGilYpdyYhz5l4DcW7D5BiX2iEPj+KJYr+bMMYd4nA+2oO5IenUST7FVIFmPxhccwRyGZvK1gnpc0elkiXgg=
Received: from DS7P220CA0049.NAMP220.PROD.OUTLOOK.COM (2603:10b6:8:224::13) by
 DS0PR12MB6656.namprd12.prod.outlook.com (2603:10b6:8:d2::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.16; Thu, 9 Jul 2026 13:11:33 +0000
Received: from DS2PEPF000061C5.namprd02.prod.outlook.com
 (2603:10b6:8:224:cafe::20) by DS7P220CA0049.outlook.office365.com
 (2603:10b6:8:224::13) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.202.11 via Frontend Transport; Thu, 9
 Jul 2026 13:11:33 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C5.mail.protection.outlook.com (10.167.23.72) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 13:11:33 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 08:11:25 -0500
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 06:02:47 -0700
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <matthew.auld@intel.com>, <christian.koenig@amd.com>,
	<dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
	<intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
	<Arunpravin.PaneerSelvam@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
	<timur.kristof@gmail.com>, <stable@vger.kernel.org>, John Olender
	<john.olender@gmail.com>
Subject: [PATCH v2] gpu/buddy: bail out of try_harder when alignment cannot be honoured
Date: Thu, 9 Jul 2026 18:32:21 +0530
Message-ID: <20260709130221.1021376-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C5:EE_|DS0PR12MB6656:EE_
X-MS-Office365-Filtering-Correlation-Id: 2f371e9d-ab42-4b3b-ccf1-08deddbb993c
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|376014|82310400026|23010399003|36860700016|18002099003|6133799003|11063799006|56012099006;
X-Microsoft-Antispam-Message-Info:
	xOSoII0ITMmU3c9l0aNKK+ubiecPJNEDD15q1ijsNRzpoM1/dBzwLC9nTGXiw2KRK2xY4KWkOS5nlPR6+qcZYD9jgkPcGaVrxkbvgfUUUehG3JmMBN3N+gXmL4xnwAKhgxh5AvB1aPo/Lk0eo3swPX0tbviQGkEAwgJwfABRW2K+kQub7KBt3fnGIYv4XSHjmZApAOs+yLw7cM4e1FVOiq+jh9edQ4f4v8nIppESRtRljuhM4BrvcOip/9Vw+3IYtrLhR5hZg8wsfSWcaTX3TLLsO2/kRSI2DSZpO3lJwt9HBhAYliEB889CwGWn8u1S1Tr8W8nwv+FShoHJnwx8DZoUT+QaxD+7vatP64TYgumeHAsjF3jU68mAT/VhyVgY3OY4VR+dHAcNgVwcMMmZj5gi+NKXkWH3l6AmMSBwCXGlIkj6YVfm6QTPTacx2rj3y8ki6x6nBM+HzMAhruLDJOs41NMU05X5hbAHTe82fUxNdDn1WwnqZBDmsGbLshR4H8TZHwHdctq65kUJdeurWLtk3beI6bLquWkK42QTrjI+ediOYhxHNsXgJ9OG7wVY+WHXgaDkQrQFl/eew84sfJIyZYArMKhSO9QBHmX416AqzhN2FgtL4fOK9yrTg1mOwjDD/YNpATi4lcjUO2PqTM4hZP0c/YWAR61h0XfdQ9SwlYQC6OEXi+a2gyyLcaBgpDJKgkUT0LsOsO5iI5Okpg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(376014)(82310400026)(23010399003)(36860700016)(18002099003)(6133799003)(11063799006)(56012099006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Mu5oSFEyk/nvDL3OuqmJCdTGsjlP0ZflJGoDl0ndex/lqii2s8RVFSgfW++CYMSdAJ505yNmmzifG4zVeIgrDWwkwsWlkTVwTzCo4cXN/vBUeqhDzRRBrWm9idcjDp9gZZsvIhHPN0A42RbqkYpSC+fDC/pYh5D5dTOBMbqiQg2r3mPzAxyxSHhgj2sff2qe/f7uO+U4qUhhYOj/rBpb9qqacie9ii2BIbtql3Lg5nsY1Zw12qmx5rCbjgRDkaKNZ/jcFaSIf3bKh1tD38oO+NxXPgXUwKtx6AIEqeaL6RKLGNteJm6yfsgJLlWPq05XsAEXvBA9ukIRAdBstEhZGIgE33AmqUug/gFIemjBe0IFoJxx2BvewkhMUqV5T3DNhTrbITOw9TCqOzqNyWpcFNQCd0pj8a81fg4BPFumjUpz2IM04dWMOO+sSyFb5+Eo
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:11:33.2132
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 2f371e9d-ab42-4b3b-ccf1-08deddbb993c
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C5.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB6656

The try_harder contiguous fallback could return a range whose start
offset did not match the caller's min_block_size. When a candidate's
start is misaligned, realign it: free the misaligned run and reallocate
exactly @size at the next lower min_block_size boundary. This keeps the
returned size unchanged with no surplus to trim, and rejects the request
only when no aligned candidate fits.

v2: align misaligned candidates down to min_block_size instead of
    bailing out, for both the RHS and LHS paths (Matthew).

Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: stable@vger.kernel.org
Reviewed-by: Matthew Auld <matthew.auld@intel.com>
Tested-by: John Olender <john.olender@gmail.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c | 63 +++++++++++++++++++++++++++++++--------------
 1 file changed, 44 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index dc81fe0301ce..3c73ae87f3c5 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1118,22 +1118,30 @@ static int __gpu_buddy_alloc_range(struct gpu_buddy *mm,
 			     blocks, total_allocated_on_err);
 }
 
+static int __alloc_contig_aligned_retry(struct gpu_buddy *mm,
+					u64 unaligned_offset,
+					u64 size,
+					u64 min_block_size,
+					struct list_head *blocks)
+{
+	u64 aligned_offset = round_down(unaligned_offset, min_block_size);
+
+	return __gpu_buddy_alloc_range(mm, aligned_offset, size, NULL, blocks);
+}
+
 static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 				     u64 size,
 				     u64 min_block_size,
 				     struct list_head *blocks)
 {
-	u64 rhs_offset, lhs_offset, lhs_size, filled;
+	u64 rhs_offset, lhs_offset, filled;
 	struct gpu_buddy_block *block;
 	unsigned int tree, order;
-	LIST_HEAD(blocks_lhs);
-	unsigned long pages;
 	u64 modify_size;
 	int err;
 
 	modify_size = rounddown_pow_of_two(size);
-	pages = modify_size >> ilog2(mm->chunk_size);
-	order = fls(pages) - 1;
+	order = ilog2(modify_size) - ilog2(mm->chunk_size);
 	if (order == 0)
 		return -ENOSPC;
 
@@ -1149,31 +1157,48 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 		while (iter) {
 			block = rbtree_get_free_block(iter);
 
-			/* Allocate blocks traversing RHS */
 			rhs_offset = gpu_buddy_block_offset(block);
+
+			/* Allocate blocks traversing RHS */
 			err =  __gpu_buddy_alloc_range(mm, rhs_offset, size,
 						       &filled, blocks);
-			if (!err || err != -ENOSPC)
+			if (err && err != -ENOSPC)
 				return err;
+			if (!err && IS_ALIGNED(rhs_offset, min_block_size))
+				return 0;
+			if (!err) {
+				/* Allocate the unaligned RHS offset using round_down */
+				gpu_buddy_free_list_internal(mm, blocks);
+				err = __alloc_contig_aligned_retry(mm, rhs_offset,
+								   size,
+								   min_block_size,
+								   blocks);
+				if (!err)
+					return 0;
+				if (err != -ENOSPC) {
+					gpu_buddy_free_list_internal(mm, blocks);
+					return err;
+				}
+				goto next;
+			}
 
-			lhs_size = max((size - filled), min_block_size);
-			if (!IS_ALIGNED(lhs_size, min_block_size))
-				lhs_size = round_up(lhs_size, min_block_size);
+			if (size - filled > rhs_offset)
+				goto next;
 
-			/* Allocate blocks traversing LHS */
-			lhs_offset = gpu_buddy_block_offset(block) - lhs_size;
-			err =  __gpu_buddy_alloc_range(mm, lhs_offset, lhs_size,
-						       NULL, &blocks_lhs);
-			if (!err) {
-				list_splice(&blocks_lhs, blocks);
+			lhs_offset = rhs_offset - (size - filled);
+
+			/* Allocate the unaligned LHS offset using round_down */
+			gpu_buddy_free_list_internal(mm, blocks);
+			err = __alloc_contig_aligned_retry(mm, lhs_offset, size,
+							   min_block_size, blocks);
+			if (!err)
 				return 0;
-			} else if (err != -ENOSPC) {
+			if (err != -ENOSPC) {
 				gpu_buddy_free_list_internal(mm, blocks);
 				return err;
 			}
-			/* Free blocks for the next iteration */
+next:
 			gpu_buddy_free_list_internal(mm, blocks);
-
 			iter = rb_prev(iter);
 		}
 	}

base-commit: 104c00917264c5b9571072471e3a8689cd1a2c4d
-- 
2.34.1

