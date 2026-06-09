Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.10])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0C6C49690A
	for <stable@vger.kernel.org>; Tue,  9 Jun 2026 17:10:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.10
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781025019; cv=none; b=gT2YPZU/MYlsFXsLzzKeRcvdjaa347Tzl6po/yrUsWfm2tM12ncssTbdqIkHxyfU8k0y4e6maQwFogvxQSTQDQ+1jxE3/0FY6I9+rH6B8t7xUBHiSsjat7WRn6tKRWVRWJwahULOj1fOZJR6t4pmT1pjzXq6F06iNS+I3egW/i8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781025019; c=relaxed/simple;
	bh=21t3Ck7hCv7DoGIJF0i8aKMZk3+esI4x+uLK/bfjJ6w=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=CBJp2Kbeq+JtelzDv90UiS9tSD47LIXYyzxodZbzHMOQfr99ncWZy1gwTQkveTYXKpedF3lhDvSTKlHpTeHu729pzOsflMJn1aeCVyqbDSDXnuVAYrkCH3PGqrwdNK5W2IQNEFIhZyT823iwELaRIPSdj7CqtJT9bSwbJob7t88=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VA/s13ig; arc=none smtp.client-ip=192.198.163.10
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VA/s13ig"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1781025018; x=1812561018;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=21t3Ck7hCv7DoGIJF0i8aKMZk3+esI4x+uLK/bfjJ6w=;
  b=VA/s13igNeg+Q83xgmZEEHogD1TgOcUtD4eU/sVdqsiGeFGa4M5vw2zG
   YiQIBlyfmh3FiRQGTANpQf0Q1NnirJ/MhkQqTrV6+3HOQudcXCTNeH4zi
   QuehvSMfGASv4mQUZgumkMI+7VQ/1VoUPtWfHEPVRcJ4WRHuMxuCd2slg
   TScjHOCHTEL038LTcrHTrkV0rtPGzqKVEeAN6yPtvX0TjILmu/DR0NR6O
   T6MdGRu0VuvMjPuXuLxcyK+kyiYU/22s5qaXIYedun23vABdkwqwmZ0zd
   wvCGWvTqGm+mf54npiseKLKt0S7kSwnDbySvi4IWrndvKE7Dv9ra2HxR9
   g==;
X-CSE-ConnectionGUID: CbRCB9PVRMiM7CNbDVdFzA==
X-CSE-MsgGUID: 4nKVcJA/TAG4Tg+ZSFseew==
X-IronPort-AV: E=McAfee;i="6800,10657,11812"; a="93182857"
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="93182857"
Received: from orviesa003.jf.intel.com ([10.64.159.143])
  by fmvoesa104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:10:15 -0700
X-CSE-ConnectionGUID: GFsPGI6WQI+sT7Jw6eIhVQ==
X-CSE-MsgGUID: 85Y14VJFTUu+54p12cknZQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,196,1774335600"; 
   d="scan'208";a="249843082"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.245.92])
  by ORVIESA003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2026 10:10:12 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Uma Shankar <uma.shankar@intel.com>,
	Nikolay Mikhaylov <sonny@milton.pro>,
	stable@vger.kernel.org
Subject: [PATCH] drm/xe/display: consider DPT when WA 22019338487 is active
Date: Tue,  9 Jun 2026 18:10:03 +0100
Message-ID: <20260609171002.380499-2-matthew.auld@intel.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

WA 22019338487 (22019338487_display) indicates that stolen memory should
not be used for display allocations on affected platforms (like Lunar
Lake).

While the fbdev allocation in xe_display_bo.c properly respected this
workaround, the Display Page Table (DPT) allocation in xe_fb_pin.c
continued to unconditionally attempt to allocate from stolen memory on
all integrated GPUs.

Check XE_DEVICE_WA(xe, 22019338487_display) before attempting to
allocate the DPT from stolen memory. If the workaround applies, skip the
stolen allocation attempt and let the driver naturally fall back to
allocating from system memory.

Without this we will end up hammering stolen when programming the DPT on
the host side during the normal operation, which seems to be exactly
what the WA wants us to avoid.

There are a bunch of users all getting some kind of hard hang in the fb
pin programming sequence on LNL, so wondering if this could help there.

Assisted-by: Gemini:gemini-3.1-pro-preview
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Fixes: 775d0adc01a5 ("drm/xe/fbdev: Limit the usage of stolen for LNL+")
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Uma Shankar <uma.shankar@intel.com>
Cc: Nikolay Mikhaylov <sonny@milton.pro>
Cc: <stable@vger.kernel.org> # v6.12+
---
 drivers/gpu/drm/xe/display/xe_fb_pin.c | 8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index f93c98bec5b5..46b1fd620527 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -20,6 +20,9 @@
 #include "xe_pat.h"
 #include "xe_pm.h"
 #include "xe_vram_types.h"
+#include "xe_wa.h"
+
+#include <generated/xe_device_wa_oob.h>
 
 static void
 write_dpt_rotated(struct xe_bo *bo, struct iosys_map *map, u32 *dpt_ofs, u32 bo_ofs,
@@ -172,7 +175,7 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
 						   XE_BO_FLAG_GGTT |
 						   XE_BO_FLAG_PAGETABLE,
 						   pin_params->alignment, false);
-	else
+	else if (!XE_DEVICE_WA(xe, 22019338487_display))
 		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
 						   dpt_size,  ~0ull,
 						   ttm_bo_type_kernel,
@@ -180,6 +183,9 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
 						   XE_BO_FLAG_GGTT |
 						   XE_BO_FLAG_PAGETABLE,
 						   pin_params->alignment, false);
+	else
+		dpt = ERR_PTR(-ENODEV);
+
 	if (IS_ERR(dpt))
 		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
 						   dpt_size,  ~0ull,
-- 
2.54.0

