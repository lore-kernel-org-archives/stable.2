Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50C19476CF3
	for <stable@vger.kernel.org>; Thu, 30 Jul 2026 23:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785454046; cv=none; b=teX6/y3S1ClnweFT5TCHkxat3Q+uVXo83FyJFqgltvSIZc2EVG2kZkD9aEXpYuEAWdqqguSMsxtr++wPcc3VRd/yx1Qbxv6elEabsyqxsTvVy7F6RswhWgAdTo999czs+JpIh1meTR0mgf0+0zgRGhvZFEfhBKNs4OcGg2NdBHg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785454046; c=relaxed/simple;
	bh=gjERshVdkMvpiAqkIGXEwZt2SVNvPHNGVRHuRD1m8iQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SPljfPnB3X+MPgha1XYztGbBHJfuQaEmQB2/XCHgloNml7GB3rGnn8lL24Z55P9lAbb6ZcKbhcuT9aKdkI3aw8y/5HdLTOm3Jvzbg91RYeUZ5HH2fR2vbBFUvzrajmsXjpLzrebTCv1kFQTCWqJ5wg4LX6tLXMnUrHentAqggUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=LOuwEDPD; arc=none smtp.client-ip=192.198.163.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="LOuwEDPD"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785454042; x=1816990042;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=gjERshVdkMvpiAqkIGXEwZt2SVNvPHNGVRHuRD1m8iQ=;
  b=LOuwEDPD0Vrc1ZMKUpNiLH6KyEuxWoXh5P1emUuz/iAxxPpk138wS3yE
   AiV/do9gKD4NJ39SYMwBcap2IU0jvGoZX1OmCRp5aoMxdKhmVGRlQrcBB
   X/d2l3fXzFQ/4O0E/xybWWhqfc5TQ3D6HOmHH0ZZgpm9XeNzuYVlo9z0I
   Z1ojK2i1wET7eMUuaAGspGKquotE02TnFeLi9lgvFPKdaiv/XqF/7C5C7
   25wl99sHRVYfBk+s0a+kat0NL8Be87td2fqpRoDM69/flu25hw6fXxdeN
   VcZJfbs2hZznawAywIecLOD5DDhEcrs73YJF0rRCz2R/RT1ecbHZPOMb0
   A==;
X-CSE-ConnectionGUID: OQpSPYVhSFC0KYDNDMZi6g==
X-CSE-MsgGUID: +WZ40ADwSim8dPhnYg3jtA==
X-IronPort-AV: E=McAfee;i="6800,10657,11860"; a="89895253"
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="89895253"
Received: from fmviesa002.fm.intel.com ([10.60.135.142])
  by fmvoesa106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Jul 2026 16:27:17 -0700
X-CSE-ConnectionGUID: O6H27EKvQ6in5Me3hb4F+g==
X-CSE-MsgGUID: pjYQHPnISFuf25kM5847CQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,195,1779174000"; 
   d="scan'208";a="283764156"
Received: from unknown (HELO DUT6094BMGFRD.fm.intel.com) ([10.80.55.54])
  by fmviesa002.fm.intel.com with ESMTP; 30 Jul 2026 16:27:18 -0700
From: Jia Yao <jia.yao@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: matthew.auld@intel.com,
	gwan-gyeong.mun@intel.com,
	stable@vger.kernel.org,
	Jia Yao <jia.yao@intel.com>
Subject: [PATCH v5 3/3] drm/xe/guc_ads: use uncached mapping for UM queue BO
Date: Thu, 30 Jul 2026 23:27:12 +0000
Message-ID: <20260730232712.517989-4-jia.yao@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260730232712.517989-1-jia.yao@intel.com>
References: <20260722053410.2767369-1-jia.yao@intel.com>
 <20260730232712.517989-1-jia.yao@intel.com>
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

Cc: Gwan-gyeong Mun <gwan-gyeong.mun@intel.com>
Cc: Matthew Auld <matthew.auld@intel.com>
Signed-off-by: Jia Yao <jia.yao@intel.com>
---
 drivers/gpu/drm/xe/xe_guc_ads.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 57a0614dbf6d..0b4524a1f7b1 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -464,7 +464,8 @@ int xe_guc_ads_init(struct xe_guc_ads *ads)
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

