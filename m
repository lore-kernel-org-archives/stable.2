Received: from CH1PR05CU001.outbound.protection.outlook.com (mail-northcentralusazon11010056.outbound.protection.outlook.com [52.101.193.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5692403144
	for <stable@vger.kernel.org>; Thu, 23 Jul 2026 22:19:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=fail smtp.client-ip=52.101.193.56
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845165; cv=fail; b=Go9d5SF6S0Wwj7cREq26lh6JhadjnFpRhRBvLU15ROEq6Bwjh7/sOZFlJJEbAfla9ePJaaEAG1FPOtY6GaYBHbiXZd5fYH9+owV269Dg/1ulX36S7SZMkWfAcCrhaqqlVO7qsoNe9peUziNUZy45xXAbku6x+VfqPwHtsbZ5SB4=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845165; c=relaxed/simple;
	bh=jfXyfer0b+balIJQ3ooi7BrS9JLA4XiNATixtK7CL8E=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lDC2rRGJ3Ulr488jHqIV0H+eB7mz4QxHEP1iJUBzVw2mlcf6OVhsjILq4qUtJF+VgMrS1wXNwziEpZBGbTPrGZLSpydesKINRpIPo/UTwHkEdEacb7ZKiPOrvaYfAd+tOR5WKrsDeWD6mm5kheo1nA1zkJxf6qeytFiLplNhOns=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com; spf=fail smtp.mailfrom=amd.com; dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b=0PgzIdRX; arc=fail smtp.client-ip=52.101.193.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=amd.com
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=amd.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=amd.com header.i=@amd.com header.b="0PgzIdRX"
ARC-Seal: i=1; a=rsa-sha256; s=arcselector10001; d=microsoft.com; cv=none;
 b=EgMgyzbJ0q0vfTHO+hhQ6X66LSDuIvW2Q2tuH1gmxkQwYtYglAm0SVFrmkn7nBwf6YoHAnGFyCQZdVacZtLfk864NLmEo08qJ5lLbp13duShn8qrRCaDC7pF/tWH/4m0M+WQvWu4qSBTE48PSXPeAmpJrI5bdAhiV+k9JDgHnr5J6bVjUomxcUOdVVy/Hs6pK1o3o1MnpuczLuLW0kSyLa/FimQmdOJdMt/RUf4V1QNedRNZru3Nhefx2esCNl/o2t5X+wJSyjRP5EUeZs6nvsTz8hJuTexSbZ0TfkRqCxRmzw9rGiFdOlR/olueJgAYYhMo5zksMT3GFvwdUZe9og==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector10001;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=mJlVyy+Kz9j4mrcD0ibRe9DtCo9jt8KT9jGmotKSV90=;
 b=UYDH2rKWyzLgest/DwKPXftFmmgp4UAkeCHSjAifomB0cMvL9UCldhqlggwJS05e2nFz/OzEsQIu8l1xUwDgDo4pBaA1YIzqbghnbAPP8OR/w3zXZiEUgmlqLn3jrCsIme/zssk4cAjiGXk5nw+u0srbUut99V25pLlHNPyGKTD6K67lsEp/Rg/2sR+jpIGMeBj+IIUAfJwZV1oj0yaZhZ713ZJsC7C9JHWXslAfhoJmzbYpIkmTNtAd68+fsp/ns5I1PQKuyLEFvd6mb5U+vCCNYoMg2HN06my3aM4oeiPfsiEm4NeWqkhZL4vwr5T7CuJ9LRoohoNYa193day0VQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 165.204.84.17) smtp.rcpttodomain=lists.freedesktop.org smtp.mailfrom=amd.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=amd.com; dkim=none (message not signed); arc=none (0)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mJlVyy+Kz9j4mrcD0ibRe9DtCo9jt8KT9jGmotKSV90=;
 b=0PgzIdRXWU0j9QH07XCHk6TIBbAWa+ANmrzHBBAZWT19+lbsf4qjqfcOwikfFTPO6HUGTnB7kAJYHAePhOkhuEEFKneYj3khv2jrF0E/BT9kN51DFhoWoqI0WtgB0plmbLOvxpFJK38EKTbGx9sB9BIRKlNupVp/4jvTlhPrUrE=
Received: from SA1PR02CA0005.namprd02.prod.outlook.com (2603:10b6:806:2cf::10)
 by MN2PR12MB4255.namprd12.prod.outlook.com (2603:10b6:208:198::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.21.245.11; Thu, 23 Jul
 2026 22:19:15 +0000
Received: from SA2PEPF000015C9.namprd03.prod.outlook.com
 (2603:10b6:806:2cf:cafe::a5) by SA1PR02CA0005.outlook.office365.com
 (2603:10b6:806:2cf::10) with Microsoft SMTP Server (version=TLS1_3,
 cipher=TLS_AES_256_GCM_SHA384) id 15.21.245.11 via Frontend Transport; Thu,
 23 Jul 2026 22:19:15 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 165.204.84.17)
 smtp.mailfrom=amd.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=amd.com;
Received-SPF: Pass (protection.outlook.com: domain of amd.com designates
 165.204.84.17 as permitted sender) receiver=protection.outlook.com;
 client-ip=165.204.84.17; helo=satlexmb07.amd.com; pr=C
Received: from satlexmb07.amd.com (165.204.84.17) by
 SA2PEPF000015C9.mail.protection.outlook.com (10.167.241.199) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.21.270.5 via Frontend Transport; Thu, 23 Jul 2026 22:19:15 +0000
Received: from satlexmb07.amd.com (10.181.42.216) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.41; Thu, 23 Jul
 2026 17:19:14 -0500
Received: from AB350-desktop.amd.com (10.180.168.240) by satlexmb07.amd.com
 (10.181.42.216) with Microsoft SMTP Server id 15.2.2562.41 via Frontend
 Transport; Thu, 23 Jul 2026 17:19:14 -0500
From: <vitaly.prosyak@amd.com>
To: <amd-gfx@lists.freedesktop.org>
CC: Vitaly Prosyak <vitaly.prosyak@amd.com>, Mikhail Gavrilov
	<mikhail.v.gavrilov@gmail.com>, =?UTF-8?q?Christian=20K=C3=B6nig?=
	<christian.koenig@amd.com>, Alex Deucher <alexander.deucher@amd.com>,
	Arunpravin PaneerSelvam <Arunpravin.PaneerSelvam@amd.com>,
	<stable@vger.kernel.org>
Subject: [PATCH v3 2/2] drm/amdgpu: Fix lockdep false positive in amdgpu_lockdep_init
Date: Thu, 23 Jul 2026 18:18:43 -0400
Message-ID: <20260723221910.85822-3-vitaly.prosyak@amd.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260723221910.85822-1-vitaly.prosyak@amd.com>
References: <20260723221910.85822-1-vitaly.prosyak@amd.com>
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
X-MS-TrafficTypeDiagnostic: SA2PEPF000015C9:EE_|MN2PR12MB4255:EE_
X-MS-Office365-Filtering-Correlation-Id: bb8ecee8-96a9-46a8-43e9-08dee9086e70
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam:
	BCL:0;ARA:13230040|23010399003|376014|36860700016|1800799024|82310400026|6133799003|5023799004|11063799006|10067099003|56012099006|22082099003|18002099003;
X-Microsoft-Antispam-Message-Info:
	A4nWlDPNwQiZJ53T3UWyL28cY2FKPGYDNUXpj+e8nJoAB41GCjjacwX/WTd7Ewx2xXUBelyNKPH+NkiHyKxQFGiVKVxx3x/rg7QYYwz7cl37aibxVbm518wBG5rdwGbaVbDqnjiKLoGygvDtiigu7eUOoeZlypTLdtKxxDRBTuTNYsmkGr4fYJZ2jVcbNT3FieLY+9S0Nq7uKXMsBEJmJrov0S9L3GLzEDTclMVTqX/XpIKM1uQRx/Dws6PphRRI2xCbRNMHKwqfgfCS88o9eM/M10pYvMU3HkVbqTlX8QyCV7K4Sl8sYJBbBSq6o67Qg2wBISRAwHB5jDgvtiFFLCbPTGrG3G0+vwwCaVA1keZTIe48jgtuzxa7dvMQF9Nc4sqmEp25cnoDpNAlySojiSKz+Q9wrs07k2YiZl2VmpMeodaYjvqKtiMmoKfpHH5hpl/Bs5AfkZNgSuzfhP8brBwUnKPimPKm9CPSLfK9p+1EUL/GRQoHhftOFFgQ4VEW+hsA0oRRV7UNgIpRfWRtortY7/PkFRsiI0JAR0XKcq8JkUoF+taehYpZoelpuTGUcyo/C6tMRkah2TWipK2aHqRIeFm7OeJ2HFFSgVbF766CtZEPdTyodUGZb2aubI4jSoXXemAk6whPqDk8PwAgLf/ENEgmurOj8LtkLwmIx/1OOC+EgrRybMeNpW164Wfw2sZ3QOxf5bonjXUrOOORZg==
X-Forefront-Antispam-Report:
	CIP:165.204.84.17;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:satlexmb07.amd.com;PTR:InfoDomainNonexistent;CAT:NONE;SFS:(13230040)(23010399003)(376014)(36860700016)(1800799024)(82310400026)(6133799003)(5023799004)(11063799006)(10067099003)(56012099006)(22082099003)(18002099003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0:
	GX9rCevelxpEyw24o6QwLN79FQTuhavMHxix70oQC9hOxlo4c9ctFDMZK/AsGA6lZp5pSfZNFzqqJz3/D0zeysdn3snnH2mFnQFYg2kdDTJgBhT9PYALhu5dY/EyAG/Xc9a6aK3LQ28LeVUowPJ0bK+xclWUjJXNH3AV3n+H+W+dch/OWTZHgkYmdpGCkGuelOvGLdfLMzalW78dLY5zWotY/x6r4tIwJYSy33sQ/mQWzp2HeQQVouYglJtz9mN47VzHmx5xH0YA/at6GZ4f0KhjqmIacBSOr0JuyT/o2+Hzcuy8QdfLtCBgp3vZ1/FAdtpJKAvVeMDbPYsYyvQeTFHnooa/1lgosf6XEisKcprpXwWk+g0ir2CbB1EzNZqhgcy+nrgrZLYI8y+EfuzgqJ8x4jOLW7mYQddMO32Nmg8oPZFKEHTQ9/TThB90dVrn
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2026 22:19:15.4413
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: bb8ecee8-96a9-46a8-43e9-08dee9086e70
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=3dd8961f-e488-4e60-8e11-a82d994e183d;Ip=[165.204.84.17];Helo=[satlexmb07.amd.com]
X-MS-Exchange-CrossTenant-AuthSource:
	SA2PEPF000015C9.namprd03.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB4255

From: Vitaly Prosyak <vitaly.prosyak@amd.com>

Move fs_reclaim_acquire() to before all lock acquisitions to eliminate
false positive circular locking dependency warning.

This is a 7.2-cycle regression fix suitable for stable backport.

v3: Address Mikhail Gavrilov technical review:
    - Clarify that fs_reclaim_acquire/release pair only REGISTERS the
      fs_reclaim lock class, does NOT create a static edge when called
      with no locks held
    - Explain that the actual fs_reclaim -> notifier_lock edge is
      established at runtime during memory reclaim -> MMU notifier path
    - Add Cc: Arunpravin PaneerSelvam

v2: Address Mikhail Gavrilov review feedback:
    - Fix author name: Michael -> Mikhail Gavrilov in all trailers
    - Add Fixes: tag to link regression to original commit
    - Add Tested-by: Mikhail Gavrilov (tested on RX 7900 XTX)

Fixes: 1d0f5838b126 ("drm/amdgpu: Add lockdep annotations for lock ordering validation")
Reported-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Analyzed-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Test-case-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Tested-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Suggested-by: Christian König <christian.koenig@amd.com>
Tested-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Cc: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Cc: Arunpravin PaneerSelvam <Arunpravin.PaneerSelvam@amd.com>
Cc: stable@vger.kernel.org
Signed-off-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Change-Id: I3f1a19877615cefc2e5d7c063144a6404a96ba38
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
index b251350b1fb2..5f1f1960ef72 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_lockdep.c
@@ -151,6 +151,20 @@ int amdgpu_lockdep_init(void)
 	 * This establishes the dependency chain.
 	 */
 
+	/*
+	 * Register fs_reclaim lock class FIRST, before taking any locks.
+	 *
+	 * This acquire/release pair does NOT create a static lockdep edge
+	 * (no locks are held between acquire and release). It only registers
+	 * the fs_reclaim lock class with lockdep.
+	 *
+	 * The actual fs_reclaim -> notifier_lock dependency is established at
+	 * RUNTIME when memory reclaim invokes MMU notifiers:
+	 *   fs_reclaim (held by reclaim) -> notifier_lock (acquired in callback)
+	 */
+	fs_reclaim_acquire(GFP_KERNEL);
+	fs_reclaim_release(GFP_KERNEL);
+
 	/* Level 1: Global userq scheduler mutex (outermost) */
 	mutex_lock(&locks->userq_sch_mutex);
 
@@ -168,12 +182,6 @@ int amdgpu_lockdep_init(void)
 
 	/* Level 7: DRM file list mutex */
 	mutex_lock(&locks->filelist_mutex);
-	/*
-	 * Mark potential memory reclaim boundary.
-	 * GPU operations might trigger memory allocation/reclaim.
-	 */
-	fs_reclaim_acquire(GFP_KERNEL);
-
 	/* Level 8: SRBM register access */
 	mutex_lock(&locks->srbm_mutex);
 	/* Level 9: GRBM index access */
@@ -190,7 +198,6 @@ int amdgpu_lockdep_init(void)
 	spin_unlock_irqrestore(&locks->mmio_idx_lock, flags);
 	mutex_unlock(&locks->grbm_idx_mutex);
 	mutex_unlock(&locks->srbm_mutex);
-	fs_reclaim_release(GFP_KERNEL);
 
 	mutex_unlock(&locks->filelist_mutex);
 	mutex_unlock(&locks->reset_lock);
-- 
2.54.0

