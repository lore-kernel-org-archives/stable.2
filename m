Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E030021A92F
	for <stable@vger.kernel.org>; Tue, 23 Jun 2026 09:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.14
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782205347; cv=none; b=VPsngryh742/h8LCqj9VVKctEoT88zHNRd3aAXX7dANpEhDVoWeo/GbNnHW7Ga7a3n5uFsVVY1/XykgZDkIHqOvA3r0PwcyezEmpZsyTiZe6hhxYcuhPfevvBPj+8BY+/qXdqnryN3+astQL/pzWVG4RgAZXuZZfKS5bbD7h7H8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782205347; c=relaxed/simple;
	bh=0OsWPFT24/1A3gVvRtsDb/q1IkfyAEiksm6+VwAVXtc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version:Content-Type; b=VeUjz/WK0KYmXB0g38vvy4A3xm7QkwT7nAhCjXI6a8z/CyEyP7V3O5VDhmomzSIOWQPL80+MYExcnSHOyM5zS1V0YO96lQHF3LlAYpH2Ao/oks1d0GNOrYXFUvOBvyYt2b6hr49+MUAuLG/DDko2XfzCsR2GVjdXyM0bMKLvZos=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=Q27LO949; arc=none smtp.client-ip=198.175.65.14
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="Q27LO949"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1782205346; x=1813741346;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=0OsWPFT24/1A3gVvRtsDb/q1IkfyAEiksm6+VwAVXtc=;
  b=Q27LO949vFcjWtIMvMgdG54ybbWCP5NlZQvr5DOTbpB5VPxZcZ2Pq8mj
   yYGP2fQdO0xVSE6xhR6vo95wm+bQPIqdT2dpBngMz6MoQ2KA2JD8to+nz
   RVdm19SmpkLA9TBy6WMO3HuPsyXdZu9n8H1gOi29k3kvlGzZ4NBPLB0I1
   2nT31gaphJ31heboIy9jTtImr+tB1LYOKIsOICxoV/nbOUMw0G4XmOS4R
   HmHKG4GLDFwqPckOQ9qmPhEnrWAv1h8Dxa6NwP5THl7qOmAfpRlllu2Iv
   gD+N/xKEGloAfrSSuWLAzopBvqEsXEbuTjobrDlB5PEWPp90LZL5aCpwD
   A==;
X-CSE-ConnectionGUID: GfMrwdlTRJqyQbFI8OfzjA==
X-CSE-MsgGUID: 0w4l3Q9FSZKRGjD7TdxFqQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11825"; a="86850154"
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="86850154"
Received: from fmviesa007.fm.intel.com ([10.60.135.147])
  by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:02:26 -0700
X-CSE-ConnectionGUID: z3buD7AQQmuFZ5uAd9qbDw==
X-CSE-MsgGUID: 8Onl5Nt8TIeZEQseCQGoTw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,220,1774335600"; 
   d="scan'208";a="246547047"
Received: from pgcooper-mobl3.ger.corp.intel.com (HELO mwauld-desk.intel.com) ([10.245.244.52])
  by fmviesa007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jun 2026 02:02:23 -0700
From: Matthew Auld <matthew.auld@intel.com>
To: intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>,
	Matthew Brost <matthew.brost@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Nikolay Mikhaylov <sonny@milton.pro>,
	Uma Shankar <uma.shankar@intel.com>,
	Jani Nikula <jani.nikula@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] drm/xe/display: consider DPT when WA 22019338487 is active
Date: Tue, 23 Jun 2026 10:01:56 +0100
Message-ID: <20260623090155.268763-2-matthew.auld@intel.com>
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
Lake). In particular we need to be mindful of not hammering stolen over
the BAR from the host side, like with issuing many writes.

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

v2 (Jani):
  - Invert the WA check. No functional change.

Assisted-by: Gemini:gemini-3.1-pro-preview
Link: https://gitlab.freedesktop.org/drm/xe/kernel/-/work_items/7513
Signed-off-by: Matthew Auld <matthew.auld@intel.com>
Fixes: 775d0adc01a5 ("drm/xe/fbdev: Limit the usage of stolen for LNL+")
Cc: "Thomas Hellström" <thomas.hellstrom@linux.intel.com>
Cc: Matthew Brost <matthew.brost@intel.com>
Cc: Rodrigo Vivi <rodrigo.vivi@intel.com>
Cc: Nikolay Mikhaylov <sonny@milton.pro>
Cc: Uma Shankar <uma.shankar@intel.com>
Cc: Jani Nikula <jani.nikula@intel.com>
Cc: <stable@vger.kernel.org> # v6.12+
---
 drivers/gpu/drm/xe/display/xe_fb_pin.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index f93c98bec5b5..8ebb52741ea6 100644
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
@@ -172,6 +175,8 @@ static int __xe_pin_fb_vma_dpt(struct drm_gem_object *obj,
 						   XE_BO_FLAG_GGTT |
 						   XE_BO_FLAG_PAGETABLE,
 						   pin_params->alignment, false);
+	else if (XE_DEVICE_WA(xe, 22019338487_display))
+		dpt = ERR_PTR(-ENODEV);
 	else
 		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
 						   dpt_size,  ~0ull,
-- 
2.54.0

