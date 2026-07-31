Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83E403803E3
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 23:27:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785540435; cv=none; b=q/4wsgwN5oTvi+E7oMmo9KtBeOhIAZwmuJENuGJIwbrm8W0D0E4vvs8bukAtWvKiuAJxH9kQXK5tDihvlrUHUF+pEwrlaeSCk6VjnKKTUdr89a2DzrsMN1zgLkAiPymRZOQsu6mU339tLUeBtm0htvdafKmmGSMmujV2vlVlVT8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785540435; c=relaxed/simple;
	bh=qtyveW9Ah4UtYY61OqP8LeF2Bz9XnjX61uG0nro4rMA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FFR9mlZXvbn9J2W2W2YmgG3L6tV8YEyhmkunx0o3yPycjyXa1+mTC4Be+eF6MpRaqDgbDUCICyTuG6VKrWAqSvdS/t9nok4cjqClNWQWh3D4K1FQn/VNNSq4wqKTZxeQxsvWlQjEyqo9dL5SZcWJnjGFWgwV+G+0LAuUmDWOYgM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=mHcoFXdX; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="mHcoFXdX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785540433; x=1817076433;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=qtyveW9Ah4UtYY61OqP8LeF2Bz9XnjX61uG0nro4rMA=;
  b=mHcoFXdXn+WAkBtJpWF+HCrgPd3OnZKxLf7/3YM3FhgIigYNXQFe3c7r
   /KjwZdQP5w9xSEtNLkllfr+Eq7WJ0ZEfKfzUvHeWJ9M1kVH6gnyG8AnUW
   OIIfBS4cf/MdXc1HGDc+j1uDV4c/ASb3ikP18f3rAABMcdkW5Vcfg9qZ8
   SdECyn3FPx1h56qI90woD2BRagAtmPix69/gaRUoqhZosK2wjnm/pGmop
   YzoVL1xamAmwCHkYNSKEmhi/srbfWBzfbGgAmShrl/ceRh2VfAR3bWeZ+
   UjOtMfmG/7Q7hVHAq7hcFW12G/5GyrijHk3is3KoThauZkvT0TkSPmOCV
   g==;
X-CSE-ConnectionGUID: Igu7GImoQHSqaOYGMcNPOA==
X-CSE-MsgGUID: 9Akwqv8ISg+u7jpAsqJmHA==
X-IronPort-AV: E=McAfee;i="6800,10657,11861"; a="97326556"
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="97326556"
Received: from orviesa009.jf.intel.com ([10.64.159.149])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2026 16:22:53 -0700
X-CSE-ConnectionGUID: ux6G/TR+TTCY5zSPDW9R8g==
X-CSE-MsgGUID: JC7mzcOhQmiHcGSVOzzFDg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,197,1779174000"; 
   d="scan'208";a="261305776"
Received: from dut6094bmgfrd.fm.intel.com ([10.80.55.54])
  by orviesa009.jf.intel.com with ESMTP; 31 Jul 2026 16:22:54 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: Jia Yao <jia.yao@intel.com>,
	Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 3/3] drm/xe/guc_ads: use uncached mapping for UM queue BO
Date: Fri, 31 Jul 2026 23:22:32 +0000
Message-ID: <20260731232232.548015-4-jia.yao@intel.com>
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

On Pre-Xe3p platform, the GAM write the UM queue through DPA using UC.
if GuC GuC reads the queue via GGTT (WB), stale data may be observed
when the cacheline has been polluted by another agent.

To match the GAM's UC writes, configure the GuC mapping as UC as well.

Fixes: 9c57bc08652a ("drm/xe/lnl: Drop force_probe requirement")
Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
Signed-off-by: Jia Yao <jia.yao@intel.com>
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

