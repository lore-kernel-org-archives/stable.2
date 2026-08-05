Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9DBE38BF9C
	for <stable@vger.kernel.org>; Wed,  5 Aug 2026 02:43:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785897791; cv=none; b=jNm5c3Sf8VVtygMMbJoPmhEiclGVHnSyyd0TOu2asJ2U5HbsJnmvXK6bL703gtVr1xrB/mN/U6NES1XX6YkEN18tvcJDcoaISx2LX7KePYiXwOndvR1g2fVZPa9ZhyJ+axlEfzdcWSLeBQBUpBHDqCj2Mm4WKlSJN1sIQyh8y00=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785897791; c=relaxed/simple;
	bh=pKHpB6+JfaBRkf4pPDDCP+AJO0kSdPx6JM0wzdic5xU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jHKxCLNjy7lmIcAcGBwWS+LRR1LKTjLA1rDge1uE9fwMAMvMkpCovjlAjuUALyEB5s4FzHw8jKt8hAxyb1MEX9xT5UZkxDICFLcMKBufDU/BcWI+sQ+5YOfEyx85yMsKZKIm4Lfer6/atPsHKJkL0OTKmJGPZyjkyJg9QHsYbSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=VeyTnNYM; arc=none smtp.client-ip=192.198.163.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="VeyTnNYM"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785897790; x=1817433790;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=pKHpB6+JfaBRkf4pPDDCP+AJO0kSdPx6JM0wzdic5xU=;
  b=VeyTnNYMgEVuPcoU9zf1UDP13KJnDbRT1kxnFOV2IJVqEUMbRPK+vcdg
   5EwYJPnycZYnR3dnfhF7+eZT1GTMtBTWfKNHgrtR6/hSXVrPnhnKUt3Mf
   mx03gNNE2+F5BrkzH+cbnEEssEw+ED4jgCmQt2fOju33jAB/Ik84to1UG
   oN8PA0Bq1bYeK/BDf2SpUP1T57sHzMeeHJPyRsrlfxjNqWy5799TRf+po
   6LJ4sJD2t079I/H51IM0UVPcn2ykciiKFK8BdGgS3AuGS9Csainissc1l
   yw6gs6RVVuoHCkMU9OjdiX4O+Y5BYYIVZgGrqC1+QK5d2B53/fwTEsmfF
   w==;
X-CSE-ConnectionGUID: UwoMSEvoS5Sv6wXsfZ2Nkw==
X-CSE-MsgGUID: vqJLXDipQj21/P/RFc5HrQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11865"; a="85585772"
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="85585772"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by fmvoesa112.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:06 -0700
X-CSE-ConnectionGUID: ojsdaf4dTEWhJUPsSwtwqw==
X-CSE-MsgGUID: B8B3c4/vR2ypgJQOHLMYrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,205,1779174000"; 
   d="scan'208";a="291612675"
Received: from orsosgc001.jf.intel.com ([10.88.27.185])
  by orviesa002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2026 19:43:05 -0700
From: Ashutosh Dixit <ashutosh.dixit@intel.com>
To: stable@vger.kernel.org
Cc: Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.1.y v2 1/8] drm/xe/rtp: Maintain OA whitelists separately
Date: Tue,  4 Aug 2026 19:42:53 -0700
Message-ID: <20260805024300.3406307-2-ashutosh.dixit@intel.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260805024300.3406307-1-ashutosh.dixit@intel.com>
References: <20260805024300.3406307-1-ashutosh.dixit@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

[ Upstream commit 31e2437561621b4867c08efc890bf629d017df03 ]

OA registers are dynamically whitelisted (and again dewhitelisted) on OA
stream open/close. Maintaining OA whitelists separately from non-OA
register whitlists simplifies this management of OA register
whitelisting/dewhitelisting.

(cherry picked from commit c478244a9e2d14b3f1f92e8bd293919e554622a5)
[ adapted RTP table from struct wrapper macro `XE_RTP_TABLE_SR()` back to plain `struct xe_rtp_entry_sr[]` array and restored the 5-arg `xe_rtp_process_to_sr()` call with `ARRAY_SIZE()` ]

Fixes: 828a8eaf37c3 ("drm/xe/oa: Add MMIO trigger support")
Cc: stable@vger.kernel.org # v6.12+
Reviewed-by: Umesh Nerlige Ramappa <umesh.nerlige.ramappa@intel.com>
Link: https://patch.msgid.link/20260615224227.34880-3-ashutosh.dixit@intel.com
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
Signed-off-by: Ashutosh Dixit <ashutosh.dixit@intel.com>
---
 drivers/gpu/drm/xe/xe_gt_debugfs.c      | 4 +++-
 drivers/gpu/drm/xe/xe_hw_engine.c       | 2 ++
 drivers/gpu/drm/xe/xe_hw_engine_types.h | 8 ++++++++
 drivers/gpu/drm/xe/xe_reg_whitelist.c   | 6 ++++++
 4 files changed, 19 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/xe/xe_gt_debugfs.c b/drivers/gpu/drm/xe/xe_gt_debugfs.c
index f45306308cd66..c38bcacb27e4a 100644
--- a/drivers/gpu/drm/xe/xe_gt_debugfs.c
+++ b/drivers/gpu/drm/xe/xe_gt_debugfs.c
@@ -149,8 +149,10 @@ static int register_save_restore(struct xe_gt *gt, struct drm_printer *p)
 	drm_printf(p, "\n");
 
 	drm_printf(p, "Whitelist\n");
-	for_each_hw_engine(hwe, gt, id)
+	for_each_hw_engine(hwe, gt, id) {
 		xe_reg_whitelist_dump(&hwe->reg_whitelist, p);
+		xe_reg_whitelist_dump(&hwe->oa_whitelist, p);
+	}
 
 	return 0;
 }
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index a7441a66e94c2..b5a869c720af7 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -575,6 +575,8 @@ static void hw_engine_init_early(struct xe_gt *gt, struct xe_hw_engine *hwe,
 	hw_engine_setup_default_state(hwe);
 
 	xe_reg_sr_init(&hwe->reg_whitelist, hwe->name, gt_to_xe(gt));
+	xe_reg_sr_init(&hwe->oa_whitelist, hwe->name, gt_to_xe(gt));
+	xe_reg_sr_init(&hwe->oa_sr, hwe->name, gt_to_xe(gt));
 	xe_reg_whitelist_process_engine(hwe);
 }
 
diff --git a/drivers/gpu/drm/xe/xe_hw_engine_types.h b/drivers/gpu/drm/xe/xe_hw_engine_types.h
index e4191a7a2c318..04ca7545d22c3 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine_types.h
+++ b/drivers/gpu/drm/xe/xe_hw_engine_types.h
@@ -128,6 +128,14 @@ struct xe_hw_engine {
 	 * @reg_whitelist: table with registers to be whitelisted
 	 */
 	struct xe_reg_sr reg_whitelist;
+	/**
+	 * @oa_whitelist: oa registers to be whitelisted
+	 */
+	struct xe_reg_sr oa_whitelist;
+	/**
+	 * @oa_sr: oa nonpriv whitelist registers, changed on oa stream open/close
+	 */
+	struct xe_reg_sr oa_sr;
 	/**
 	 * @reg_lrc: LRC workaround registers
 	 */
diff --git a/drivers/gpu/drm/xe/xe_reg_whitelist.c b/drivers/gpu/drm/xe/xe_reg_whitelist.c
index 506501d77f389..a0bbf4b745a1f 100644
--- a/drivers/gpu/drm/xe/xe_reg_whitelist.c
+++ b/drivers/gpu/drm/xe/xe_reg_whitelist.c
@@ -89,6 +89,9 @@ static const struct xe_rtp_entry_sr register_whitelist[] = {
 			 WHITELIST(VFLSKPD,
 				   RING_FORCE_TO_NONPRIV_ACCESS_RW))
 	},
+};
+
+static const struct xe_rtp_entry_sr oa_whitelist[] = {
 
 #define WHITELIST_DENY(r, f) WHITELIST(r, (f) | RING_FORCE_TO_NONPRIV_DENY)
 
@@ -193,6 +196,9 @@ void xe_reg_whitelist_process_engine(struct xe_hw_engine *hwe)
 	xe_rtp_process_to_sr(&ctx, register_whitelist, ARRAY_SIZE(register_whitelist),
 			     &hwe->reg_whitelist, false);
 	whitelist_apply_to_hwe(hwe);
+
+	xe_rtp_process_to_sr(&ctx, oa_whitelist, ARRAY_SIZE(oa_whitelist),
+			     &hwe->oa_whitelist, false);
 }
 
 /**
-- 
2.54.0

