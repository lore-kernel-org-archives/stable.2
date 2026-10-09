Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.21])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD6546D56B
	for <stable@vger.kernel.org>; Fri,  9 Oct 2026 07:01:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.21
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791529281; cv=none; b=XSDk/IE6htuuYECu4Pv39LGCRd5CKjy0sZkEDJZlqFkbC91EOWSRnx5Ay5QQ32/XZb4DZSekSuZu1gNTwQtPz7x0SBvK5rzuHG4tV2oC67vyXeq4Oxym01oQU1B022YqDzDOIUZ0pJ0P3BUwl8SKPcNUq1ESNP1xRQbfxpB0cs0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791529281; c=relaxed/simple;
	bh=jvMaqz2+QfaBGAqiyXr2CGV4/89G6mFahCTKV8BCImc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Sc/pwdmflWBqRfBGr9/rUJ4pdJmt+X/6HO9U+m32HvmNyoIPCzLWPUiBDqy4YfEyabVO7IQdiytcEnhM+SBdPnJ0ImIj2Z2+0HyVpQynHMoJa0exsVtJ4lgN8kQgZyfZ2qf3iRTStRvZLtX3F0S6uUE/s4kzfitpTSH1TvB8N60=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YArPN/0l; arc=none smtp.client-ip=198.175.65.21
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YArPN/0l"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1791529279; x=1823065279;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=jvMaqz2+QfaBGAqiyXr2CGV4/89G6mFahCTKV8BCImc=;
  b=YArPN/0lhMsQrD9jm3Z127Xv6MQ6sAMFiSeYBiJZDCq9uc/JAMgTRyEI
   W/EkVlWqBxfjxbff1r6DeVnKXeOsSyl5b/28WPNz2W9e2Zv8Pzm2EM8c+
   sQhAhqxgJyp/NfkNl83eXtHMGi26LKpu0e3pZuTMbvt+syD73NkA9AwQ9
   HvR3Qz6AWFOX7qaHut2mp3sG1WDOTEBwScpcSxOmTFfu2Jtx4mFunBNXk
   EI3pT17kRdkYfVZLR2wakqARiVAF+vuENhPOCR70CRnt47pNWdet3ysXq
   mubaqEe1rm/neKNmIy+R0H62YfgKSPvSIe4ZCa1SxaAUVgAU9Avj0lJYR
   g==;
X-CSE-ConnectionGUID: vn80zT/8SVy84TGZ5LNc0g==
X-CSE-MsgGUID: r+UIqIdnTIGT7XQk4yqPtg==
X-IronPort-AV: E=McAfee;i="6800,10657,11929"; a="419260"
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="419260"
Received: from fmviesa012.fm.intel.com ([10.60.135.152])
  by orvoesa113.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 00:01:18 -0700
X-CSE-ConnectionGUID: RO6rVoqaQ5iZEw8bXNaLzw==
X-CSE-MsgGUID: 9NVtS89pSia4kJcGEQtiSw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,147,1787036400"; 
   d="scan'208";a="2052358"
Received: from abityuts-desk1.ger.corp.intel.com (HELO fedora) ([10.245.245.243])
  by smtpauth.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Oct 2026 00:01:16 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Arvind Yadav <arvind.yadav@intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Matthew Auld <matthew.auld@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe: Don't transfer shrinker pages for pinned bos on purgeable state change
Date: Fri,  9 Oct 2026 09:00:53 +0200
Message-ID: <20261009070053.7790-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.56.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Pinned bos have their pages removed from the shrinker's shrinkable /
purgeable counts on pin, and added back on unpin according to the
bo's purgeable state at that time.

However, xe_bo_set_purgeable_shrinker() unconditionally transfers
pages between the shrinkable and purgeable counts. If the purgeable
state of a pinned bo changes, for example by userspace madvising
DONTNEED on a VMA of a bo that is also pinned as a scanout buffer,
this underflows one count and, after unpin, leaves the other one
permanently inflated.

Only update the purgeable flag for pinned bos, and leave the page
accounting to unpin.

Fixes: 536a2ead3a8f ("drm/xe/bo: Add purgeable shrinker state helpers")
Cc: Arvind Yadav <arvind.yadav@intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Himal Prasad Ghimiray <himal.prasad.ghimiray@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Cc: intel-xe@lists.freedesktop.org
Cc: <stable@vger.kernel.org> # v7.1+
Assisted-by: LLM
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_bo.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_bo.c b/drivers/gpu/drm/xe/xe_bo.c
index 469fa4d5feb5..cc78283b702c 100644
--- a/drivers/gpu/drm/xe/xe_bo.c
+++ b/drivers/gpu/drm/xe/xe_bo.c
@@ -954,6 +954,8 @@ static int xe_bo_move_notify(struct xe_bo *bo,
  *
  * Transfers pages between shrinkable and purgeable buckets when the BO
  * purgeable state changes. Called automatically from xe_bo_set_purgeable_state().
+ * For pinned BOs, whose pages are not accounted, only the purgeable flag is
+ * updated, so that the correct bucket is used when the BO is unpinned.
  */
 static void xe_bo_set_purgeable_shrinker(struct xe_bo *bo,
 					 enum xe_madv_purgeable_state new_state)
@@ -970,7 +972,8 @@ static void xe_bo_set_purgeable_shrinker(struct xe_bo *bo,
 		return;
 
 	xe_tt = container_of(tt, struct xe_ttm_tt, ttm);
-	tt_pages = tt->num_pages;
+	/* Pinned bos are not accounted. Only update the purgeable flag. */
+	tt_pages = xe_bo_is_pinned(bo) ? 0 : tt->num_pages;
 
 	if (!xe_tt->purgeable && new_state == XE_MADV_PURGEABLE_DONTNEED) {
 		xe_tt->purgeable = true;
-- 
2.56.0

