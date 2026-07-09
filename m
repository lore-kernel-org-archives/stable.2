Received: from DM5PR21CU001.outbound.protection.outlook.com (mail-centralusazon11011042.outbound.protection.outlook.com [52.101.62.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DEFF2727E2
	for <stable@vger.kernel.org>; Thu,  9 Jul 2026 13:11:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.62.42
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783602718; cv=fail; b=hF8LQlkgJYQvhlFBYSX6YheiZz3UoEcPQXhwaCiOtGnVbPwkQ9yl/hUK3sWiAltHBdH3+kZq4rBvv2X1oMHI+r18RZxmuLYLS9jVY0PVuRl2iyC3ZPbfHHnP1fica925wYDplUdZNtODtdq+fWBVJVzHf1Hdph14q1nBa/kSWqM=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783602718; c=relaxed/simple;
	bh=H9DeLwBTIVB6oLDnyfdYTVwxxw1UwhnPaRpoBylgOdM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EXy518vmPsiHquTXehW0rSIAjrUOf5PQT/ipP5uc2zzowL+102A57Shh8KFFgZB2tDyyHU0x9CgdgxgRnvSKkMdybV3Vxhcl/yz9K6mo9EQDPx2OQEh3wen9/WJrldk1nWbBz30Nbiv66ZhnYs5ZkEW3JNaMli2WFbB/sqK4q08=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=T4EHr/St; arc=fail smtp.client-ip=52.101.62.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="T4EHr/St"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=i/HFr50xoAQOtjFF0mpOkZwH3PIB28rFtReGREcVWIcPbN5KYYptzd26DjFn1FOBxZzY9oqQChp0msk06SyGY7UukX+aLG2TS63V2kjFMevk1GLKsL/EqtLxr5P37AqT1OyFCsVNBAhTrbZp14Rbu70WVTO7WJX/Qxc+WOxhjF8EUp7V8kuxCvT1dmzIUDt1Woguk/J16+8vx7i+AuqqTuYCw3tI/7otDVdhUSftXgmat7YNsu8xBQui4xKZtWft8+fhUbJkf0rTJRuY7E/Fg2/yHILFYMxKPb2sb70lrL/nKzy4M0W4fhxHHh+DsGDuhcsHyPwe4gsuKQoxE7xewg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=H6XBTH+cLgG6VtDeHNZYCQYGBwiZdE7d+6kkXhwcMls=;
 b=MlxGPs8C8fZINiF0jg08Uu9vfK7MXDHwphlgEfOaHMHpY4z38jvN9QZHE5i8sn2caVnU36draFlIY0rt5yIMjCGylJ565Nhe5WE1TYHzpHrAGOfvfs0ZtSzlycPctDVLn8piSNXxM7N3FpEsWYf+bl1gcvgcLbmSr5RZF7Ladpb2IcMu8TcjV0SxqlizfATpV6dhX606G8g7q35RMalFUr+iu0EH4AC1LdV7CvMlS/3FJW4iwaGZpqCNVOS7vDVaaGGdjftDSDFgT8nqxF+NSPhPEKF2PQwL8IYMitaX6PoTXokVRbaksuO4yffI+SDtxMOpWECINiW7zZZCwoxOQg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=intel.com smtp.mailfrom=amd.com; dmarc=pass
 (p=quarantine sp=quarantine pct=100) action=none header.from=amd.com;
 dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=H6XBTH+cLgG6VtDeHNZYCQYGBwiZdE7d+6kkXhwcMls=;
 b=T4EHr/StT9RSOF32G6F3/Pw0roROyDZ47VMIyrniica85iLfqj+0MaPqxVqscGy7USoHB37r9GQL4kXTJcpOVjHFylb2d5KXVT757BYXT8HBkGBqVeQgQfvosAdM/dcIheSo8RkeM/tprqY8GfmkdOz/yKMNAGoLr3fwDvbTwrA=
Received: from DS7PR05CA0062.namprd05.prod.outlook.com (2603:10b6:8:57::8) by
 CYXPR12MB9426.namprd12.prod.outlook.com (2603:10b6:930:e3::10) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.15; Thu, 9 Jul 2026 13:11:48 +0000
Received: from DS2PEPF000061C7.namprd02.prod.outlook.com
 (2603:10b6:8:57:cafe::9e) by DS7PR05CA0062.outlook.office365.com
 (2603:10b6:8:57::8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.223.5 via Frontend
 Transport; Thu, 9 Jul 2026 13:11:47 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 DS2PEPF000061C7.mail.protection.outlook.com (10.167.23.74) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.181.6 via Frontend Transport; Thu, 9 Jul 2026 13:11:47 +0000
Received: from Satlexmb09.amd.com (10.181.42.218) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 08:11:34 -0500
Received: from arun-nv33.amd.com (10.180.168.240) by satlexmb09.amd.com
 (10.181.42.218) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 9 Jul
 2026 06:11:05 -0700
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
To: <matthew.auld@intel.com>, <christian.koenig@amd.com>,
	<dri-devel@lists.freedesktop.org>, <intel-gfx@lists.freedesktop.org>,
	<intel-xe@lists.freedesktop.org>, <amd-gfx@lists.freedesktop.org>
CC: <alexander.deucher@amd.com>, Arunpravin Paneer Selvam
	<Arunpravin.PaneerSelvam@amd.com>, =?UTF-8?q?Timur=20Krist=C3=B3f?=
	<timur.kristof@gmail.com>, <stable@vger.kernel.org>, John Olender
	<john.olender@gmail.com>
Subject: [PATCH v2] gpu/buddy: bail out of try_harder when alignment cannot be honoured
Date: Thu, 9 Jul 2026 18:40:50 +0530
Message-ID: <20260709131050.1022759-1-Arunpravin.PaneerSelvam@amd.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: satlexmb07.amd.com (10.181.42.216) To satlexmb09.amd.com
 (10.181.42.218)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: DS2PEPF000061C7:EE_|CYXPR12MB9426:EE_
X-MS-Office365-Filtering-Correlation-Id: 7d8bc565-ec70-4667-8b95-08deddbba1eb
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|1800799024|82310400026|36860700016|23010399003|376014|18002099003|56012099006|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	Cp4iNvSis4Muq3iCBY3d8s8EY6p96LCrLaunge3xAbioICdyD2vHN5gamygwe050Wb4z7Jql7YlQEEAQ/XXUlupfA96UYX8PRSBU42QMZdQArKdIQyv3b7v3wSZZP6izn8hcZqnHMFMU+JLI0O9ZjcgE7s/G974CdGP15qxD45WJ1wMK/GqlbvgCO6BSEA4Y68FetXxjEGTKHQ7EyckeH8XwREWijpFd22AWulGJaqqzR0NKbNE+v3k3mleVmwAOkrYYgurMaF6qDQiFJUnc9Ek9wIuVdd6xO5TRffeSI8d4Ki//dTlYs06xf+Bn2UdBLYDUFEYan3wxwS/RMeDHcVEDD+cfeaX21pHdNUhfWOn2lz2t5OfYYqdHWDgvkyafLXda8PjYF4N1xfXwpwNhKg1TWb0T7P6PDJbW+uIH17LodiTinf2CHvXgiirbzqt+a6UF1dDvoR018yYL2mPiA+SKc6lbErY3gwTau2CfIySQagWHpTThO/mSgOvf2/xld1lEBJ9r2mAJoeB+XNHRXdQT2+8pia7ikXf/Z3mqAmIlIW6qJxKpqmUyTOWJ/Njr64OfKcJMKA+z5oDnMIpTECq8FKCVGSAHd3Z8hNjsLjNlwx3hGMw00M5mptu2jjOylosH1Zvl09SDv3kcLnPCrbQ3B0RsTIpm1SXiu1v+VlT1s2roW5espZUmexWicUk0v8SZCf8E/M9JGLw9xnw6tw==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(1800799024)(82310400026)(36860700016)(23010399003)(376014)(18002099003)(56012099006)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	NvNPCTPXbYarHpW0Kf2oUK98IDY7Rw/4YD4vQLXtxsodtujPg1aoIRGKuhj+0uGnMT33gkVwg53ZOZcgDPP0xSqsjwGtNTuOdDRYcCohcgnq4SO+4t+e2WtnYxyvLKiAE/pJpBS6s1TzNbluUmMKBx0DdlLlaAicfLueGWHaWlJGOsvrPEUE+1VJmUNv6LiP79ysmXUDzhDoIUnaFG6VSHabRpGoT6vB+0dCxZYYMhbHwUEjftjc/KHBFzoSvLXM+JggqLrQCM1jtSVrrLOhOPbEiUtPXCUP4lc3xr7aI/q29fmEkZR3sVk2jJPdrcVPgKax5OVo3dnCnacZsdBzeI57f4by5PM4Y3FTB5F3k2jM2KAjvSZ3TPoVi0xmzliM6g1i1e3FPG4RtCK+TZ1dDEY/U5HzYBOqn6yK8w2Icm59IVraze4B9iWdNaqXIl5y
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Jul 2026 13:11:47.7915
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 7d8bc565-ec70-4667-8b95-08deddbba1eb
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	DS2PEPF000061C7.namprd02.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CYXPR12MB9426

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

