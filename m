Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11F1F4562BA
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540435; cv=none; b=qv9qznYyH5bwbKUg9Z318j4/1s3iuCO2v8n4d6rpeqG4qDXoyA3UaxdQi/rY5rcdvczFqsbFhwyLIW8D4BKbb20n3IS+SmMqXxLhkWNgcJTPDb+EHKEx6K9/myj25v7WMXj2jsT0N9IwI7yfSecTFgThL5A8JGrCTGM4yuGCuVk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540435; c=relaxed/simple;
	bh=eXDo8G+SQ4z8eHI6JDJllul+h/+5Uho4eQQ6a2Bs5vg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VM0RxHsuKa0x3cDKxXdLrtpFt9QluoxRXHnZDBvEnjZozXi+/7msE4t2YgiO8FT93vNWTEJhuQb82/b/bAqhyJSEmloXUmVOHEA4iqyqqmS+5QjrDXN6JAKwMnEb9VplXvPonJjVCWIWZgZ7julAkl5Mp9rVz37k97MzmgyPkP0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=ZeLdXwDb; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="ZeLdXwDb"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785540433; x=1817076433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=eXDo8G+SQ4z8eHI6JDJllul+h/+5Uho4eQQ6a2Bs5vg=;
  b=ZeLdXwDbPZCPsm45+94FhZU4BRRcLCO56fcEP/OM9lmeWSknYvnl7zWK
   1b4jWJbXFBGFptqcmv+P340ThJYidwzrCZiRjwYShN0DlI1A1uBkfjWGP
   0ZlVg+im2tjvZIyNyDWJEfO7Gh++Y9A0Zzai2L2hHNu51kpTtmr6XR0C1
   vLFWBQdkeOaIQcIsug43bnFbqB+Xfver+H+jv2CeRqh2VmZrvleWsKXpT
   Hqz3ENIpQCgxVXNoDTBB4uMPDj17l+1fq2yK9T+fZ9WjeNdCUTvgtPpB/
   iOC1IhTgYT6NQ7ZuDNUYqG01a3ZXRGds9mzE0k5/y2H/kCOaK8tNHRMTZ
   Q==;
X-CSE-ConnectionGUID: 4w/aSz34QtSQxMgStfyLQA==
X-CSE-MsgGUID: LRK7L5I6Ti+b+cr7hhkW/w==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="97326553"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="97326553"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 16:22:52 -0700
X-CSE-ConnectionGUID: 7i9xpHm2RPW7h4cEarbckg==
X-CSE-MsgGUID: DMfnRl/ARo2yK7r9ZuMqGg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="261305772"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.54])
  by orviesa009.jf.intel.com with ESMTP; 31 Jul 2026 16:22:52 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 2/3] drm/xe/guc_ads: allocate UM queues in VRAM on dGFX
Date: Fri, 31 Jul 2026 23:22:31 +0000
Message-ID: <20260731232232.548015-3-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260731232232.548015-1-jia.yao@intel.com>
References: <20260731232232.548015-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On iGPU, the UM queue BO is allocated in system memory. On dGFX, the BO
was previously created in system memory and later reallocated in
xe_guc_realloc_post_hwconfig().  Allocate the UM queue BO directly in
VRAM on dGFX, where it is ultimately required.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
---
 drivers/gpu/drm/xe/xe_guc.c     |  6 ------
 drivers/gpu/drm/xe/xe_guc_ads.c | 11 ++++++-----
 2 files changed, 6 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc.c b/drivers/gpu/drm/xe/xe_guc.c
index 4f132bf8539d..4286bd05c686 100644
--- a/drivers/gpu/drm/xe/xe_guc.c
+++ b/drivers/gpu/drm/xe/xe_guc.c
@@ -732,12 +732,6 @@ static int xe_guc_realloc_post_hwconfig(struct xe_guc *guc)
 	if (ret)
 		return ret;
 
-	if (guc->ads.um_queue_bo) {
-		ret = xe_managed_bo_reinit_in_vram(xe, tile, &guc->ads.um_queue_bo);
-		if (ret)
-			return ret;
-	}
-
 	return 0;
 }
 
diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 46c4d702d1f3..a69ec584cc0f 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -456,11 +456,12 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 				 roundup_pow_of_two(GUC_UM_QUEUE_SIZE *
 						    GUC_UM_HW_QUEUE_MAX);
 
-		bo = xe_managed_bo_create_pin_map(xe, tile, um_size,
-						  XE_BO_FLAG_SYSTEM |
-						  XE_BO_FLAG_GGTT |
-						  XE_BO_FLAG_GGTT_INVALIDATE |
-						  XE_BO_FLAG_PINNED_NORESTORE);
+		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
+			       XE_BO_FLAG_GGTT |
+			       XE_BO_FLAG_GGTT_INVALIDATE |
+			       XE_BO_FLAG_PINNED_NORESTORE;
+
+		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
 		if (IS_ERR(bo))
 			return PTR_ERR(bo);
 
-- 
2.43.0

