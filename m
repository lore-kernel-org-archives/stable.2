Received: from BYAPR05CU005.outbound.protection.outlook.com (mail-westusazon11010064.outbound.protection.outlook.com [52.101.85.64])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C0152AEE4
	for <stable@vger.kernel.org>; Tue, 21 Jul 2026 00:19:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.85.64
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784593143; cv=fail; b=Lkiwc6GcfvftKvPDAUox5h4M7UCZ0tbyORZ7qeOP8cYU9ydW9Hd/8UaDwTBq2v9rwMDMCdfENGRndSdM+eGbVjQZOA/NgsRAX03qa/56smlsEiC5Rs72sIsrqRXeef8UAT5VSCojhee+tmueXF8dHsgulq9yOWIAejRE6BZJbMo=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784593143; c=relaxed/simple;
	bh=PFziIfUfHUE47itBaZTXmEthoe3cZZMqcPl9AJ7weCo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=QcEvfixBKdqUl9j0hzQsX3IkRVWGPMInVFGlz2kDGgiNlGooOqrg/4u0YC+dxfnjFoK2uhD7OS8/+wB4stC/O+ceHEslwLB/IQ+sVJdKBoippTvjwCIf33nt2FYQeiBE+nRO2x890J5zX0NtbX2rUtZHcG3FgQ7kxEWXaxIphEs=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=bV19taBQ; arc=fail smtp.client-ip=52.101.85.64
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="bV19taBQ"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=rHx2dLcw5fc/CK2O0Dn8lpA+WD6sGAWuPI37IxabU8GsVL1x64bE2X22hsgg+DENK8efpVBW3B/RlEnOhU9R79ohvOms4clDGseQFK5kBHPEy7y7j7VRNv67BNhYGOlEIMGybjefUVxn9kz0d+CqIdktlM4VIqeEBkvKPu3bkZGeVB7buXlxPachFvDRMttPxgNc83AggAnhhwx/DyB+V26sxO2mobvf+LHlINETGTJdvAMPGFqBDXiHs4I6bMt9XMCg1ZhMCVN45tbz29I+c/QWn1TyZuoE/MABIQ3tb3xfwIZAriVcvAzhYnQDOUV8+EPfVtoIubYQ4Dkt48UuOA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=qBqSSHlk2LWs5lcOOVpinWEkaewGYpcf8edGPJ0QHdI=;
 b=BrxoEe7RmiumCTVA/qym9SUT6fG36BizDaNn7FMfTFg3mjCCDo/jFuTs4mmasZ/qH20qhqv5Bjhb45ZTHf6/qFb2iaz/I9ISlFq9WG5YetptsTxooPmTj4JR0I+Ep78CN/NF1SnZo/v2qR6O6jQvQ8uaZ+Q37LYEFJRTtn9Ut9rRHBZskgSoWFcOC1wcugUPGGWGCV5klDmbeWlxpTycN7Vvj/xAgi4notjA0VT0RUYCS/aJ0DAsrA0fqGW1JI+I40TAraN5XXTCRn1RSfYhO69qjmMdTVZh45SEYnch2ybdcC2Ygr6Pd0Ptw+RrBSaWqtMbl4Rx8WpLN9yLIXOAEA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=qBqSSHlk2LWs5lcOOVpinWEkaewGYpcf8edGPJ0QHdI=;
 b=bV19taBQlSXUF/dki6+mr9i0eeEPZUuq6gXu/pU7q4uxCM07xCyefZKcShNHeQ5mwQ0EXs0mOsImKswV07KxoMj6zgOCgd+nNRfi6oQJJXdPIvo4lRDF4MgMnqRTio0+ZzDQO04hxkclkScsaXKoISLIx4aSUJj2WK7UjbT7wBA=
Received: from BN9PR03CA0452.namprd03.prod.outlook.com (2603:10b6:408:139::7)
 by MW3PR12MB4345.namprd12.prod.outlook.com (2603:10b6:303:59::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.181.9; Tue, 21 Jul
 2026 00:18:57 +0000
Received: from BN3PEPF0000B077.namprd04.prod.outlook.com
 (2603:10b6:408:139:cafe::a8) by BN9PR03CA0452.outlook.office365.com
 (2603:10b6:408:139::7) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.223.16 via Frontend Transport; Tue,
 21 Jul 2026 00:18:57 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 BN3PEPF0000B077.mail.protection.outlook.com (10.167.243.122) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.245.5 via Frontend Transport; Tue, 21 Jul 2026 00:18:57 +0000
Received: from satlexmb10.amd.com (10.181.42.219) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 19:18:56 -0500
Received: from satlexmb08.amd.com (10.181.42.217) by satlexmb10.amd.com
 (10.181.42.219) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Mon, 20 Jul
 2026 19:18:55 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb08.amd.com
 (10.181.42.217) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Mon, 20 Jul 2026 19:18:55 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Mikhail Gavrilov
	<mikhail.v.gavrilov@gmail.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH 2/2] drm/amdgpu: Fix lockdep false positive in amdgpu_lockdep_init
Date: Mon, 20 Jul 2026 20:18:04 -0400
Message-ID: <20260721001851.113927-2-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260721001851.113927-1-vitaly.prosyak@amd.com>
References: <20260721001851.113927-1-vitaly.prosyak@amd.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-TrafficTypeDiagnostic: BN3PEPF0000B077:EE_|MW3PR12MB4345:EE_
X-MS-Office365-Filtering-Correlation-Id: 83da2d31-3c35-46a0-5b42-08dee6bda7e9
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|36860700016|82310400026|1800799024|376014|22082099003|18002099003|56012099006|10067099003|5023799004|11063799006|6133799003;
X-Microsoft-Antispam-Message-Info:
	7R9Yi0LUSBSszyD7+E22pVsopReNzANDqwk0zQrrBYs96EFEsWtoredXLya6HH3zN1+0yIdJ3QfGFSYdWgE2WAqPyLDGxXNiTvMhf9zFWCvD983ZlNSoeFM4/tXIxB+BPlTKNO/B7cDVGjL2dfO1nne1M3jufiQyYQkib1UTQCDGMFW8qYEaYIFKwggG9mse/C+e26SAQVplAJsw7UJzD08uKK/wjj/iLhQ/CufJMi0oghKgasjr2dthDDHXkSo1nZhy1jGtrcnG/zJYgCLjCqW0zoj9f/9u9SZxfADjyFWq8I8ZW58Yurl7NiM/EAnC5/Hhaj4fnSjlldpylmqXirdWlSnSnBkkNFEx6vIAj1Eyhhyr0uEFgjz4LyngjHgkepyItOue3FhLW9iy0NjvfDxkt7InoIz/HIugG3jkUnLW8uuPHTXffwU4LW7Q4v3i0dPBDGE6pP7W5Kyu5IhVWLIhxfZs9dJ42uM/6z8jUoZvGPSEK7yxCZtkACbuOvOxScftUAsxhrXP6Ykq9GLTAUA6Lf4g+o8ILNM5FjwqnTeLuPeKfwFJyUhwQbTdVYNeombY1MDN/NKOekIgh3Vl1lmkdRXU6vx2H5QFIO2AtZ7bfJudyYt6ieN8jklgNxck3EFOG2zUkbIdCdkpNmsEjRhiNbkKoq9MbxFaY/3GKY7b13PKYeDKB0tI/wQ/yvi5jGsQBaeMsHbvpskUXbwzQA==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(36860700016)(82310400026)(1800799024)(376014)(22082099003)(18002099003)(56012099006)(10067099003)(5023799004)(11063799006)(6133799003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	Yc4qOUZOklzaUWrA/UzfOI6ciOEueUVWPWNWUcrSw6t5BSTPCx88LEIpj53clgbLWV+RnF9+81YiruWd0aEyMjG94B/BXOqgANdqoYtb6CO10MDbsmjXLRhjSw9yBVAvPmgNqlnv3Q5hUC/3BkWI/Fh6huf7V3FENiWauuen85f1ivuKvkCE8NKDaZdrvSTYACtWCz/A18gq11xCN9f/IPxTbvM4cI03YdO6FRoIh4W9VEyX40RWMYgWMENbztPTkEC9JbzjtihL0xTr9tkMmJxjNbYYC5XzNUqmln1N8sOvtFrUiSU0SQBygZ65cM3ppKNzT+0KYErV+isOBPIS302XQITSvho9w2Ob9eBhwLyfjEGx4lrps7a1+uIe2qvPkVdtsqlsu150CCMB2Q1RXvZ9lQenLDDQ+T8KM8t2P39hjMqiBGBQxrlnWEcFZu3l
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 21 Jul 2026 00:18:57.3059
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 83da2d31-3c35-46a0-5b42-08dee6bda7e9
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	BN3PEPF0000B077.namprd04.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW3PR12MB4345

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Move fs_reclaim_acquire() to before all lock acquisitions to eliminate
false positive circular locking dependency warning.

This is a 7.2-cycle regression fix suitable for stable backport.

PROBLEM:

amdgpu_lockdep_init() trains lockdep by acquiring locks in sequence
while calling fs_reclaim_acquire() in the middle. The fs_reclaim call
was placed while notifier_lock was held, teaching lockdep:

    notifier_lock -> fs_reclaim

However, at runtime, MMU notifier callbacks run from inside memory
reclaim, establishing the opposite dependency:

    fs_reclaim -> mmu_notifier -> notifier_lock

These form a false cycle that lockdep reports when reclaim unmaps a
page covered by an amdgpu userptr notifier.

LOCKDEP WARNING EXAMPLE (BEFORE FIX):

    WARNING: possible circular locking dependency detected
    6.19.0+ #48 Not tainted
    amd_lockdep/3762 is trying to acquire lock:
    ffff8881756f3c30 (&amdgpu_notifier_lock_key), at: amdgpu_hmm_invalidate_gfx

    but task is already holding lock:
    ffffffff92e4b5c0 (mmu_notifier_invalidate_range_start), at: try_to_unmap_one

    Chain exists of:
      &amdgpu_notifier_lock_key --> fs_reclaim --> mmu_notifier_invalidate_range_start

    Possible unsafe locking scenario:
          CPU0                    CPU1
          ----                    ----
     lock(mmu_notifier_invalidate_range_start);
                                  lock(fs_reclaim);
                                  lock(mmu_notifier_invalidate_range_start);
     lock(&amdgpu_notifier_lock_key);

     *** DEADLOCK ***

The dependency chain shows:
  -> #5 (fs_reclaim):
       amdgpu_lockdep_init+0x61e/0x730 [amdgpu]  <- FALSE EDGE
  -> #0 (&amdgpu_notifier_lock_key):
       amdgpu_hmm_invalidate_gfx+0x77/0x110 [amdgpu]  <- RUNTIME PATH

SOLUTION:

Move fs_reclaim_acquire/release to BEFORE all lock acquisitions.
The acquire/release pair does not create a static lockdep edge by itself
(no locks are held between acquire and release), but it registers the
fs_reclaim lock class. The actual fs_reclaim -> notifier_lock ordering
is established at runtime when memory reclaim invokes MMU notifiers that
take notifier_lock. By moving the fs_reclaim registration before any
lock acquisition, we avoid teaching lockdep the false reverse dependency.

VERIFICATION (AFTER FIX):

Test reproducer (based on Mikhail Gavrilov's standalone test case)
creates a 64MB GPU userptr memory buffer, then repeatedly forces the
kernel to reclaim it by moving pages to disk (simulating memory
pressure). Each reclaim cycle triggers the MMU notifier callback path.

The test is available as an IGT subtest:
  tests/amdgpu/amd_lockdep.c::notifier-reclaim-splat

Results:
  Before fix: Lockdep false positive warning on first reclaim attempt
  After fix:  Completed 8 reclaim cycles with no lockdep warnings

dmesg after fix shows only test success messages, no circular dependency
warnings. The fix is minimal (relocate 2 lines) with no runtime overhead,
only corrects lockdep's static analysis model.

v2: Address Mikhail Gavrilov's review feedback:
    - Fix author name: Michael -> Mikhail Gavrilov in all trailers
    - Add Fixes: tag to link regression to original commit
    - Add Tested-by: Mikhail Gavrilov (tested on RX 7900 XTX)
    - Rewrite fs_reclaim comment to be technically accurate about what
      fs_reclaim_acquire/release actually does (registers lock class,
      doesn't create static edge)
    - Add note that this is a 7.2-cycle regression for stable routing

Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock ordering validation")
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Analyzed-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Test-case-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Tested-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
index b251350b1fb2..718411f724f3 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
@@ -150,6 +150,18 @@ int amdgpu_lockdep_init(void)
 	 * Take locks in the correct order to train lockdep.
 	 * This establishes the dependency chain.
 	 */
+	/*
+	 * Train fs_reclaim FIRST, before taking any locks.
+	 * This teaches lockdep that fs_reclaim is the OUTERMOST context.
+	 * When memory reclaim later calls MMU notifiers (which take notifier_lock),
+	 * lockdep will see: fs_reclaim -> notifier_lock (correct runtime edge).
+	 *
+	 * Bug fix: Previously fs_reclaim_acquire() was called while holding
+	 * notifier_lock, teaching lockdep the FALSE edge: notifier_lock -> fs_reclaim.
+	 * This caused false positive circular dependency warnings.
+	 */
+	fs_reclaim_acquire(GFP_KERNEL);
+	fs_reclaim_release(GFP_KERNEL);
 
 	/* Level 1: Global userq scheduler mutex (outermost) */
 	mutex_lock(&locks->userq_sch_mutex);
@@ -168,11 +180,6 @@ int amdgpu_lockdep_init(void)
 
 	/* Level 7: DRM file list mutex */
 	mutex_lock(&locks->filelist_mutex);
-	/*
-	 * Mark potential memory reclaim boundary.
-	 * GPU operations might trigger memory allocation/reclaim.
-	 */
-	fs_reclaim_acquire(GFP_KERNEL);
 
 	/* Level 8: SRBM register access */
 	mutex_lock(&locks->srbm_mutex);
@@ -190,7 +197,6 @@ int amdgpu_lockdep_init(void)
 	spin_unlock_irqrestore(&locks->mmio_idx_lock, flags);
 	mutex_unlock(&locks->grbm_idx_mutex);
 	mutex_unlock(&locks->srbm_mutex);
-	fs_reclaim_release(GFP_KERNEL);
 
 	mutex_unlock(&locks->filelist_mutex);
 	mutex_unlock(&locks->reset_lock);
-- 
2.54.0

