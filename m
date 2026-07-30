Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6FA6F332EBC
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 00:48:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785372489; cv=none; b=qduNR1VkDVDl/3F0gDkkd+TrnlteIqTtQ7tTWNT7bXRqfNeMEZUon8dLCw9aNPztb6dIP13/THm82QexwxYC+xEai4pRICBo+sKE9C3spCC+sI1mhC1MJA6sum+hadP4wFgac8cp4BLPlAxG8J7fypgZF4/NUt6a+MYocbQXXto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785372489; c=relaxed/simple;
	bh=Tx5kBI0vAL1hYSKRWj97O3O0eaj/dAxe9aPb9OAipq0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gv3X1L7YSTp/7TRUDcKnYm47+QbZcYHnTvTYsJYODYRiswG1y5PtqqDw+CIC6pGx9TRewLBm2S2ruG/7ZZ4AEPzM1vMA6W1csu8k6qDD1Q2E3VYmXAC/q9scqJhNeuACA5pNclF7Lmd0ijEuLis7ExIRXIXgITLxA17fdCoe4mQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VI1szXSV; arc=none smtp.client-ip=198.175.65.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VI1szXSV"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785372488; x=1816908488;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Tx5kBI0vAL1hYSKRWj97O3O0eaj/dAxe9aPb9OAipq0=;
  b=VI1szXSVTL0ldyGppRWB3wKMUzLi5p793jHMYMQ1ULyk8Pc1ZuT+0i58
   DGKcgpNd/qeH0QIghVhZQTyCHCh85LUuvFvF3+LmM7kSq8ScMmUpmXZGD
   GMEXXOJx/bt9+dzgvb3CWB5vJcDpX6pRmHidTDI9fL7WR6BFgvoPh0kqR
   mkFfJRbxyl8EepycIMK630r6msH5paJ+pBRFi2gbEt3gVnIPE6ocqDnOY
   gVbkFd0qdzt7h2gRUFHih+G3cLKxubbHfb7PUf8K4qgXTupTUO+C/hunD
   +irIhrFkKeXN944p8STCBhVOnOspgIf0ljkwsmESeV6Nr2iabEsdVJjAw
   w==;
X-CSE-ConnectionGUID: KnMBhu/CS3GWDDa+JWqXIA==
X-CSE-MsgGUID: P+9DUd6EQPKlpNDYAUMMUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11859"; a="85935362"
X-IronPort-AV: E=Sophos;i="6.25,193,1779174000"; 
   d="scan'208";a="85935362"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
  by orvoesa111.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2026 17:48:07 -0700
X-CSE-ConnectionGUID: QUZcQdoIRqyVAHoI8TwYRg==
X-CSE-MsgGUID: L5vLLhW+Qny6yrmR0eGaxg==
X-ExtLoop1: 1
Received: from unknown (HELO DUT6094BMGFRD.fm.intel.com) ([10.80.55.54])
  by fmviesa003.fm.intel.com with ESMTP; 29 Jul 2026 17:48:06 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com,
	gwan-gyeong.mun@intel.com,
	stable@vger.kernel.org,
	Jia Yao <jia.yao@intel.com>
Subject: [PATCH v4 3/3] drm/xe/guc_ads: use uncached mapping for UM queue BO
Date: Thu, 30 Jul 2026 00:47:35 +0000
Message-ID: <20260730004735.344627-4-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730004735.344627-1-jia.yao@intel.com>
References: <20260722053410.2767369-1-jia.yao@intel.com>
 <20260730004735.344627-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The HW unit that writes fault descriptors into the UM queue ring buffer
may not be coherent with the CPU cache.  If a descriptor write is still
sitting in a GPU L3 cache line when GuC reads the slot, GuC sees the
stale (all-zero) content from DRAM and forwards an invalid descriptor to
the driver (Faulted Address = 0, ASID = 0).

Mark the UM queue BO as uncached (XE_BO_FLAG_NEEDS_UC) so that writes
bypass the cache and are immediately visible to GuC.

Fixes: dd08ebf6c352 ("drm/xe: Introduce a new DRM driver for Intel GPUs")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jia Yao <jia.yao@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_ads.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 53636333fb45..76029575aa45 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -412,7 +412,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
 		u32 um_flags = XE_BO_FLAG_VRAM_IF_DGFX(tile) |
 			       XE_BO_FLAG_GGTT |
 			       XE_BO_FLAG_GGTT_INVALIDATE |
-			       XE_BO_FLAG_PINNED_NORESTORE;
+			       XE_BO_FLAG_PINNED_NORESTORE |
+			       XE_BO_FLAG_NEEDS_UC;
 
 		bo = xe_managed_bo_create_pin_map(xe, tile, um_size, um_flags);
 		if (IS_ERR(bo))
-- 
2.43.0

