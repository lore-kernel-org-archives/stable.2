Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7D24480DC9
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 16:51:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785862312; cv=none; b=JwX76/6BDnMxrVsHM8F4OcaNmqsM3wIxFvjpWeuMcBsGW37pr8/DGUOCv4aZrplhsAtPXy54Hv1NACMh1lwHbJrI/6wYov2pWGN8lDKQluT2kx7duXktCPSaE0ARe8Up1E+utej1AtBUH6vSonhtWG2GrFNHWcRNbT/0AJWNjCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785862312; c=relaxed/simple;
	bh=E0CVRbmuCZLDHe9yjmTbiMPZTh1GEQcCj+40KoqbdjA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rYvsqJobniscBnjrBsbwOlMCQ26NMKz1GbLC79qa/fkc05PiVHR09YmIicqqE/WvucR87nQW66mpaY2ECDfmWE0w7kRTDzDYcJG+0y235ew92Rf7Wg6lRFrtff+i5DW63jXJBpcWpTJWwa1wIvr7DSfXyEwlim+8VMm0wiFWz9s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Mxj1zCNn; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Mxj1zCNn"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785862274; x=1817398274;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=E0CVRbmuCZLDHe9yjmTbiMPZTh1GEQcCj+40KoqbdjA=;
  b=Mxj1zCNny0OZXft4no77oUoJacnIOaiSskuJ95hrAmZ4g+u4hlCBsnVN
   SPxT2+fMd/bEWJI83a64CZsjnT+WXLPm75SwID/aGxJKbFr5rm1d5Ld94
   ZD0AQ+5xwPkO1BtS4b07si25sWdwM011VRPE4e8gNlFyuyIfi0IchoV0H
   BHVVnwDJYZkh2xxsYL9FUlLwAEJIV8gaiI+OHhKyF+BEjxtGFH+f/DWo3
   ZbmLlLCvAs0KuviF5lJaILviiAUqPZYfxvvwkK+kJTFoaa04BU/v4AHH7
   x37rKobvAJ7ydLtkob2OfBVXCvRAFEmDPSGKu0PItq9l7a+29QelTuDzo
   Q==;
X-CSE-ConnectionGUID: v+uOEutaSmCIIu+vDV3wlw==
X-CSE-MsgGUID: 93PcvhEWRtOYi1G5/84yfQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="97925423"
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="97925423"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 09:51:08 -0700
X-CSE-ConnectionGUID: FcUUm8oISBunojKEhEhzbw==
X-CSE-MsgGUID: G6cz1q1TT+eC1BTLYB7YBA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,204,1779174000"; 
   d="scan'208";a="265063703"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.44])
  by orviesa003.jf.intel.com with ESMTP; 04 Aug 2026 09:51:09 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 3/3] drm/xe/guc_ads: use uncached mapping for UM queue BO
Date: Tue,  4 Aug 2026 16:50:57 +0000
Message-ID: <20260804165057.129529-4-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260804165057.129529-1-jia.yao@intel.com>
References: <20260804165057.129529-1-jia.yao@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

On Pre-Xe3p platform, the GAM write the UM queue through DPA using UC.
if GuC reads the queue via GGTT (WB), stale data may be observed
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
index 77429ff4d2a9..ff8eee3831aa 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -458,7 +458,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
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

