Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 57A433ACF1B
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:08:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785787734; cv=none; b=R5EkwSoNe15Z3oCTKDGoB931DXQYuCKpoBEv7xhle/uUShAywLl81sP3b+JhUxm9wuYsnBqIkpzO1CQg/ZbdLQZzfWeKW9LbExDVZEH8wxqSj8WcOcfoQPcorx25M5ejxOGKIsCCNbuRUkpjQaPQ9AHgYPc2EPqksvtbBbfhAhA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785787734; c=relaxed/simple;
	bh=/f5hrtoz/LJM9Jypmu/MosHfMJJwsjNtu6GLYz2mHhE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=vFjplRixNCP/3Rq8hCs8N97Lg3sSm9eQARNzXnzCyqliS6OspxJY6SSKzJkISgHzrB46WDKywCHxL4fRnP9RNg20JtbOaIM6eAIIGnCx2qzrUwX/dvQNCu7LV0HoUwQCXUVU/S5IJpGjKAKbK3lg2PnXX13kaoOiD4yscIWx+QA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kEOmlBky; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kEOmlBky"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785787732; x=1817323732;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=/f5hrtoz/LJM9Jypmu/MosHfMJJwsjNtu6GLYz2mHhE=;
  b=kEOmlBkyhR4fr3KLZCn9nN+mSSLsGv5G0Ad45aQ62Vr9oPrKG0vqarZ0
   fL1G5hgn0wlQazI+ow/A2S5BVMtNSLMnO/MNQ5/DJKU5+tsDlFRylaFkO
   OcdTaskGZc6yiMPop6w+Vr1YabMxunXn821Zii/VGGr6Pm1Nl05VKiIk5
   SP9xvkidADgIab5Ib8tHkN1e2n4guVmkckgmqTgrbIYO22VQCU7dWIRfn
   bxu7yTTiyUodXiMmBCtI45Z2Zyahq4D6I7g6fUhSIY0ifMqgnOWll3kmE
   CdqQUB+B+VmK4Pfg0GjlCcshiTAcBfoM/KViHp3A1bcSxNx+4KESXnEig
   w==;
X-CSE-ConnectionGUID: TlbrD1UTR7mh59IpN8X5sw==
X-CSE-MsgGUID: YbiV3bAXRHio9RhxXOoWkA==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="86188517"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="86188517"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 13:08:50 -0700
X-CSE-ConnectionGUID: OfYEwV1RRU2LJOXoBnF/Ow==
X-CSE-MsgGUID: 33pV5/XESumLielvLKDl/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="266433159"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.44])
  by fmviesa005.fm.intel.com with ESMTP; 03 Aug 2026 13:08:50 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v7 3/3] drm/xe/guc_ads: use uncached mapping for UM queue BO
Date: Mon,  3 Aug 2026 20:08:38 +0000
Message-ID: <20260803200838.98826-4-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260803200838.98826-1-jia.yao@intel.com>
References: <20260803200838.98826-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Pre-Xe3p platform, the GAM write the UM queue through DPA using UC.
if GuC GuC reads the queue via GGTT (WB), stale data may be observed
when the cacheline has been polluted by another agent.

To match the GAM's UC writes, configure the GuC mapping as UC as well.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
Reviewed by: Matthew Auld <matthew.auld@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_ads.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index a69ec584cc0f..97a2dbb03558 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -459,7 +459,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
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

