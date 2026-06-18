Received: from CH4PR04CU002.outbound.protection.outlook.com (mail-northcentralusazon11013018.outbound.protection.outlook.com [40.107.201.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 949C538D017
	for <stable@vger.kernel.org>; Thu, 18 Jun 2026 12:48:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=40.107.201.18
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781786928; cv=fail; b=CfpY3sV0eGQcYApPQVsF1CoBehhV/B/3gOXLrCpITpXwfZgjM+SmCC69c5++/8Rzg6kacpnTfITxXR6yE+x6RtEHdskyjfZ539zkzyLMxGGD0C6PB4ag4XXLpnMfh4CTdfTrR+KLdeYD8/yDTMvlgkWxJR6xuxtZSB1dV80bk/A=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781786928; c=relaxed/simple;
	bh=qcKoQmhQEr3g/P/8KJ8XFho/w2quRdRUnziaTEnnYCQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TX0NVcd2FxnkuvMCToq+muwyAJaKZEOxGW0mj8wIg/+JPOnX4aly90nynlhP3uJbyB8p9wPox3QNTnt4GpAcNy3ELvEkaK1R0lT6uKFXpWUIr747M2V546IzEanNUSVnPfFK3STWdQgmrhNH5go73ThsBpczWZ6UTK/oIhttIb8=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=KMoJLLIH; arc=fail smtp.client-ip=40.107.201.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="KMoJLLIH"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rPUiWcYx26172xUxC3HJHA8ZkAQRQFPoDd5E9wzKUDrPAYihzQYplra6xbs3/kTxvY77GsgW75L4lrEgOyB9vAmn/Ml3Cpwmstlf1VD5JvKfSf547jKQyAANig8qw9GpZZH4aa8G6sKhI2vy3LII4LyHjKHGE3ari6RzynqIFIZu/KTw8xCM8mKQAOhw8K2D2idBHghFLn/YMa6v+gFdyk4OyZ32uu04lw+AGCk9V6+o5wFE96NR5WyskieB8vyCwpj+Ft4Z1Uy5w8AsS4/B11AlBaw3MZUeHNbsA+tqzzpDm8jwjYLTHW//RgwxuFooXF2z0BMAcnW6k5Xs3bSxUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=htx3joIIIkWmWt1xbrlHuV5szXDaHPexdKwo2ESHm/4=;
 b=cTUm7LjFH3LycydHUoBH0Erkq6WUJFjpwI/SXRb5wwp/NrK8WL/pm2jcKzijGOEQtNjZtX6AT74k2zh8VUjFxU+er/KBgSlxg4zDtoHISTQzol7B+Jhrs/DbIKQXXbHZ09D7RKc3jlAkR6sm66azXhQi26SDGywf5g7TfJAa7PRBNIgNFoT0ni4vEgSVjNGrR0fvr9oPHdjxpdsIC0je3BBluKs1o3uk4TvgnQFq6YhpN/zYJbFZz/g6oCKsCJJxrVgpzrzJhCZRi3C8j9wlJRC5H2sVDxwYnXjKVVE1XshDd4m6QZSLU9mR2Mr64N/88ds6TbgZmLXmlIlo+QwdSQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=htx3joIIIkWmWt1xbrlHuV5szXDaHPexdKwo2ESHm/4=;
 b=KMoJLLIHEQGs1wZ/VGS/cB0EI/6IDNM9nPTVYEHp2vUd49IOTEQbnUGUgakF4y37K2BXpHAsrBsda/gOLw6x4o3t7E1l+ATRzbmwjbAAv5lglaJ41h/LQDb4HqgMSm1+D0UUINJap1JjOrPSyvDJEePKGCJd+trfiztc7MVcXd4=
Received: from DS1PR05CA0006.namprd05.prod.outlook.com (2603:10b6:8:457::15)
 by MN0PR12MB6343.namprd12.prod.outlook.com (2603:10b6:208:3c0::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.113.19; Thu, 18 Jun
 2026 12:48:42 +0000
Received: from DS1PEPF00017091.namprd03.prod.outlook.com
 (2603:10b6:8:457:cafe::2) by DS1PR05CA0006.outlook.office365.com
 (2603:10b6:8:457::15) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.139.13 via Frontend Transport; Thu,
 18 Jun 2026 12:48:42 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS1PEPF00017091.mail.protection.outlook.com (10.167.17.133) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.139.8 via Frontend Transport; Thu, 18 Jun 2026 12:48:42 +0000
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 18 Jun
 2026 07:48:39 -0500
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <matthew.auld@intel.com>, <christian.koenig@amd.com>,
	<dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
	<intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
	<Arunpravin.PaneerSelvam@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
	<timur.kristof@gmail.com>, John Olender <john.olender@gmail.com>,
	<stable@vger.kernel.org>
Subject: [PATCH] gpu/buddy: bail out of try_harder when alignment cannot be honoured
Date: Thu, 18 Jun 2026 18:17:55 +0530
Message-ID: <20260618124755.2751205-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb08.amd.com (10.181.42.217) To satlexmb07.amd.com
 (10.181.42.216)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS1PEPF00017091:EE_|MN0PR12MB6343:EE_
X-MS-Office365-Filtering-Correlation-Id: 29e92cc2-48c8-4327-72b5-08decd37ed79
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|82310400026|1800799024|376014|23010399003|36860700016|18002099003|56012099006|11063799006;
X-Microsoft-Antispam-Message-Info:
	CGaMCzYzD0FNze89BnvEqQv3A4+yOn71luNjz2NPJyYlxyfN0c5NV437IGCeN277q0FPmy/3S0Qt6caDxgXZmtgI8M0qbg9F8J7oDo81vuXLNL0+UzXnYAwgPjF0FhpAXt0wRQBTurE/NQf3LqMsQ/ktcUqFb2KGuZ9wpbGy8Y1JH4NwabzVxrUDYahxWXx3ibFsIjaVBYqsIYkDWcC5WINn3Hn2gtdfJCl7b5U+5AeP8A+qw9Wn8x24fY5Ocm4edwe1Hy9GjZEixvuymJcZ8lcAshtDuAq88v0Rx1yAgCwmosgLxI9n1yGZiuaW2f01WbfYK7jx5/AGoPrWZXNSdHxqndV1sc505TGXdwLIWIT6CD1oD0HJDKrbAJ3Dy+AW34AJlBQa7K36stNv+jN17ZTCjZ2/nB2GQn/meKz7aiUneNweo/DuGeRagNeJaSBabuwrU+6/J/W4HcHoROyJfn01LvPhOXsJ0tBab1voPM4z1iZaSIPL9l8aFMSsoeIZdiIVllQYRJbWQgblWOU5yDl9Z3LoAIlTNt4+c7XlVzrZzzxL4Vyic0uAQ1S9n1pozJEQdHGOIqAhpz+/NJF506s0vZ0euik6ETyPnccFhRFJmXcWcJ9hAwwqLZxUxnVNGe3kGtrJZ12tvEbOsUesyYEInfziOrfQav/KZ3qrppwufAe/wYrJsfa2+ZK8aRcTUL0OQyJBnl+EfLGSFjdpLZ56it7IHwE77Z3mZTyRqqs=
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(82310400026)(1800799024)(376014)(23010399003)(36860700016)(18002099003)(56012099006)(11063799006);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	tWIiSUhuYq8aMT5o5CFtTklS1ycRWyX6AMPSU5SK/ZPECGgtj4eRtmEF70oAXxUwS3SwFu2yl/JugkMKQqSipJ3E/lG6V8x6SMHNSFQNsa6kiIbwk1IpCBhcxk5mDXcHNXutdn61uv9a3rnUXxq8MUejA8pcYqLS8milOleGidykpIy9yShAqbXlb1gwo4hwSgYD+rYRa2ijLCz77D5g961ImWhXIn+KZgS5wZfMysCtWIv6ySV8rAWbSLhGc3ErfDja7c9r2bbGiH0zOEC9zGYdd0P0roebe8wYwDA+S4eRXxxi8RM7CEeqt6j1guNVDFChoxioBQiubbVkqdLOwnmnoRo9g7lJTUeio8acU+A3msP4b68eIdxTAUCdsi8xee273OCN+L/BhsLRboRSz0cdl2orepJwM+j22OrTodch6gMMH+qLIanHB15gVi7y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Jun 2026 12:48:42.3795
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 29e92cc2-48c8-4327-72b5-08decd37ed79
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS1PEPF00017091.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN0PR12MB6343

The try_harder contiguous fallback could return a range whose start
offset did not match the caller's min_block_size. Check each candidate
against the requested alignment and reject the allocation when no
candidate satisfies it, instead of handing back a misaligned range.

Suggested-by: Christian König <christian.koenig@amd.com>
Fixes: 0a1844bf0b53 ("drm/buddy: Improve contiguous memory allocation")
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Timur Kristóf <timur.kristof@gmail.com>
Cc: John Olender <john.olender@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
---
 drivers/gpu/buddy.c | 33 +++++++++++++++++++++------------
 1 file changed, 21 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/buddy.c b/drivers/gpu/buddy.c
index dc81fe0301ce..28ed3250ac57 100644
--- a/drivers/gpu/buddy.c
+++ b/drivers/gpu/buddy.c
@@ -1127,13 +1127,11 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
 	struct gpu_buddy_block *block;
 	unsigned int tree, order;
 	LIST_HEAD(blocks_lhs);
-	unsigned long pages;
 	u64 modify_size;
 	int err;
 
 	modify_size = rounddown_pow_of_two(size);
-	pages = modify_size >> ilog2(mm->chunk_size);
-	order = fls(pages) - 1;
+	order = ilog2(modify_size) - ilog2(mm->chunk_size);
 	if (order == 0)
 		return -ENOSPC;
 
@@ -1149,31 +1147,42 @@ static int __alloc_contig_try_harder(struct gpu_buddy *mm,
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
+			if (!err)
+				goto next;
 
-			lhs_size = max((size - filled), min_block_size);
-			if (!IS_ALIGNED(lhs_size, min_block_size))
-				lhs_size = round_up(lhs_size, min_block_size);
+			lhs_size = round_up(max((size - filled), min_block_size),
+					    min_block_size);
+
+			if (lhs_size > rhs_offset)
+				goto next;
 
 			/* Allocate blocks traversing LHS */
-			lhs_offset = gpu_buddy_block_offset(block) - lhs_size;
+			lhs_offset = rhs_offset - lhs_size;
+
+			if (!IS_ALIGNED(lhs_offset, min_block_size))
+				goto next;
+
 			err =  __gpu_buddy_alloc_range(mm, lhs_offset, lhs_size,
 						       NULL, &blocks_lhs);
 			if (!err) {
 				list_splice(&blocks_lhs, blocks);
 				return 0;
-			} else if (err != -ENOSPC) {
+			}
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

base-commit: b9e2d5cdaab05c997be3a69d9b372d7676683e1b
-- 
2.34.1

