Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03E67522699
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:57:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790690253; cv=none; b=P/RXtgJ3FE+K5T8lIEZ/Rw33zGR1cTZFbRnceoa0LL61VGAWROjyA2OOiq/CghwcI3qczRXwDFq8VDH+d4URS+HgH81b0VD2NEF5lJI1dy34no792xlKtNAf8uNQkwiMcAM3Vu7TiMpQqMsxfnZ7mMnb5JL7b3OY03uAROQfpko=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790690253; c=relaxed/simple;
	bh=VaUh/UDtcakQ+Nuw2o9L+tgESa8eIYr/XyMMHbkMFi4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=C+Gj+9B2wTTERh6NuvSPOr6rCiyBJRBs8Jd259nRP65mfSjqd8+QbNv2kUKu9T9uHwooF1J8rvf9iP0TerpcdxjEy1g7UrtYuWAkEoCiNsFovDt0lEDiymyIYI+zynzs8PYEizDiF/aOC/Ux21idJRde1QtuWseaFfKyv3rldm8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com; spf=pass smtp.mailfrom=linux.intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YzBn3/rc; arc=none smtp.client-ip=198.175.65.18
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YzBn3/rc"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790690251; x=1822226251;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=VaUh/UDtcakQ+Nuw2o9L+tgESa8eIYr/XyMMHbkMFi4=;
  b=YzBn3/rcZkELrZ23uU66xvJOueCQchlh1SVnonjiempoFQ4E8ilKZntr
   8m7vVTErk/+qznC01oADftruVTHUJRPu6V44thTI16KjpCq5rWqd6DEw7
   0dNZ4oAcBHAd1lW83fwsthKDUBPDVN5yspEIVgrzRKJxCk4QtUmCBae7r
   gjnxrgo68Zk3S6GENcHXyfUaLgF/BpcDFCVo8bXKQ04uFBAK36D9wtFsn
   xgr0Yk3yq9wY0FtReAtaefe5s31F56+xLLnCXDdFYBSRRwDo5MO/+zMt0
   WVlR75P2p0TeC5y3J8+uqvy081VNTf8aWpy36rWeqKm+mAZyjZxQfXOvs
   Q==;
X-CSE-ConnectionGUID: 1YEK+A1VTHitxwRXx6B0NA==
X-CSE-MsgGUID: wvu22z+BTfedT6835uYNLg==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="90462797"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="90462797"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa110.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 06:57:30 -0700
X-CSE-ConnectionGUID: 2/E23nkmSXC6mnSkCOxFtQ==
X-CSE-MsgGUID: BJHWlo8sSMaS5qgDChqD6Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="273983595"
Received: from abityuts-desk1.ger.corp.intel.com (HELO fedora) ([10.245.244.222])
  by fmviesa006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 06:57:28 -0700
From: =?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
To: stable@vger.kernel.org
Cc: Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>,
	Vinay Belgaumkar <vinay.belgaumkar@intel.com>,
	Matt Roper <matthew.d.roper@intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	=?UTF-8?q?Thomas=20Hellstr=C3=B6m?= <thomas.hellstrom@linux.intel.com>
Subject: [PATCH 7.2.y] drm/xe: Add wa_14025941587 to xe2, xe3 and xe3p platforms
Date: Tue, 29 Sep 2026 15:56:28 +0200
Message-ID: <20260929135628.43167-1-thomas.hellstrom@linux.intel.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026092940-reload-script-8bd3@gregkh>
References: <2026092940-reload-script-8bd3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>

Avoid programming the IDLEDLY timer to less than 5 microseconds.
Apply wa_14025941587 to Graphics Versions 20.01 to 35.11
and Media Versions 13.01 to 35.03

v2: Use xe_rtp_match_not_sriov_vf, move to local variable
    Remove warn and other knits            - Matt R

v3: Add verbose comment - Tejas

v4: Restore IDLE_DLY register on engine reset.
    Add it to GUC save-restore list. -Vivek

v5: Extend WA to Media Versions 13.01 to 35.03 - Vinay

v6: Avoid clearing inhibit switch - Bala
    Refactor code accordingly by adding idle_reg_val.

v7: Rebased with the divide-by-zero/overflow guards living in
    a separate hardening patch.

v8: Preserve the Wa_16023105232 floor (DIV_ROUND_DOWN_ULL) and the
    maxcnt == 0 guard from the hardening patch. Round up
    (DIV_ROUND_UP_ULL) the Wa_14025941587 minimum conversion instead,
    so the tick-quantized delay cannot round back below 5 us.

v9: Evaluate the Wa_16023105232 xe_gt_WARN_ON() against the value
    read from hardware instead of the Wa_14025941587-bumped value,
    so it no longer fires on the driver's own floor. Re-check the
    rounded-up tick value against maxcnt and floor it if tick
    quantization pushed it back to/above maxcnt, logging via
    xe_gt_dbg since this is the driver's own value, not a hardware
    anomaly.

Assisted-by: GitHub_Copilot:claude-opus-4.8
Signed-off-by: Tangudu Tilak Tirumalesh <tilak.tirumalesh.tangudu@intel.com>
Reviewed-by: Vinay Belgaumkar <vinay.belgaumkar@intel.com>
Link: https://patch.msgid.link/20260916100545.779894-3-tilak.tirumalesh.tangudu@intel.com
Signed-off-by: Matt Roper <matthew.d.roper@intel.com>
(cherry picked from commit 9453c528fc909076468ff10df1c2e334ca5a9b00)
Signed-off-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
(cherry picked from commit cc319238e3f6668f867beb381ce93727c69b7317)
Signed-off-by: Thomas Hellström <thomas.hellstrom@linux.intel.com>
---
 drivers/gpu/drm/xe/xe_guc_ads.c    |  2 +-
 drivers/gpu/drm/xe/xe_hw_engine.c  | 93 ++++++++++++++++++++++++------
 drivers/gpu/drm/xe/xe_wa_oob.rules |  2 +
 3 files changed, 79 insertions(+), 18 deletions(-)

diff --git a/drivers/gpu/drm/xe/xe_guc_ads.c b/drivers/gpu/drm/xe/xe_guc_ads.c
index 886bafd31f45..2b42a1bb83b2 100644
--- a/drivers/gpu/drm/xe/xe_guc_ads.c
+++ b/drivers/gpu/drm/xe/xe_guc_ads.c
@@ -791,7 +791,7 @@ static unsigned int guc_mmio_regset_write(struct xe_guc_ads *ads,
 		}
 	}
 
-	if (XE_GT_WA(hwe->gt, 16023105232))
+	if (XE_GT_WA(hwe->gt, 16023105232) || XE_GT_WA(hwe->gt, 14025941587))
 		guc_mmio_regset_write_one(ads, regset_map,
 					  RING_IDLEDLY(hwe->mmio_base),
 					  count++);
diff --git a/drivers/gpu/drm/xe/xe_hw_engine.c b/drivers/gpu/drm/xe/xe_hw_engine.c
index 3c2b150bfc60..ecf691923c7c 100644
--- a/drivers/gpu/drm/xe/xe_hw_engine.c
+++ b/drivers/gpu/drm/xe/xe_hw_engine.c
@@ -577,44 +577,103 @@ static void hw_engine_init_early(struct xe_gt *gt, struct xe_hw_engine *hwe,
 	xe_reg_whitelist_process_engine(hwe);
 }
 
+static u32 idledly_floor_ticks(u32 idledly_ns, u32 idledly_units_ps)
+{
+	return DIV_ROUND_DOWN_ULL((u64)idledly_ns * 1000, idledly_units_ps);
+}
+
 static void adjust_idledly(struct xe_hw_engine *hwe)
 {
 	struct xe_gt *gt = hwe->gt;
-	u32 idledly, maxcnt;
+	u32 idledly, idledly_hw, idledly_reg_val, maxcnt;
 	u32 idledly_units_ps = 8 * gt->info.timestamp_base;
 	u32 maxcnt_units_ns = 640;
-	bool inhibit_switch = 0;
+	bool inhibit_switch = false;
 	bool wa_applied = false;
+	bool clamped_below_maxcnt = false;
+
+	if ((!IS_SRIOV_VF(gt_to_xe(gt)) && XE_GT_WA(gt, 16023105232)) ||
+	    XE_GT_WA(gt, 14025941587)) {
+		u32 mincnt_idledly_ns = 5000;
 
-	if (!IS_SRIOV_VF(gt_to_xe(gt)) && XE_GT_WA(gt, 16023105232)) {
 		/* xe_gt_clock_init() warns and zeroes timestamp_base on unknown crystal clock. */
 		if (!idledly_units_ps)
 			return;
 
-		idledly = xe_mmio_read32(&gt->mmio, RING_IDLEDLY(hwe->mmio_base));
+		idledly_reg_val = xe_mmio_read32(&gt->mmio, RING_IDLEDLY(hwe->mmio_base));
 		maxcnt = xe_mmio_read32(&gt->mmio, RING_PWRCTX_MAXCNT(hwe->mmio_base));
 
-		inhibit_switch = idledly & INHIBIT_SWITCH_UNTIL_PREEMPTED;
-		idledly = REG_FIELD_GET(IDLE_DELAY, idledly);
+		inhibit_switch = idledly_reg_val & INHIBIT_SWITCH_UNTIL_PREEMPTED;
+		idledly = REG_FIELD_GET(IDLE_DELAY, idledly_reg_val);
 		idledly = DIV_ROUND_CLOSEST_ULL((u64)idledly * idledly_units_ps, 1000);
+		idledly_hw = idledly;
 		maxcnt = REG_FIELD_GET(IDLE_WAIT_TIME, maxcnt);
 		maxcnt *= maxcnt_units_ns;
 
-		/* Clear the inhibit switch without disturbing a valid delay. */
-		if (inhibit_switch)
+		/*
+		 * Wa_14025941587 is applied before Wa_16023105232, which takes
+		 * priority if the two ever conflict (not expected in practice).
+		 */
+		if (XE_GT_WA(gt, 14025941587) &&
+		    idledly < mincnt_idledly_ns) {
+			idledly = mincnt_idledly_ns;
 			wa_applied = true;
+		}
 
-		if (xe_gt_WARN_ON(gt, idledly >= maxcnt)) {
-			/* Floor below maxcnt; write 0 to still clear the inhibit bit. */
-			idledly = maxcnt ?
-				DIV_ROUND_DOWN_ULL((u64)(maxcnt - 1) * 1000,
-						   idledly_units_ps) : 0;
-			wa_applied = true;
+		if (XE_GT_WA(gt, 16023105232)) {
+			/* Clear the inhibit switch without disturbing a valid delay. */
+			if (inhibit_switch) {
+				idledly_reg_val &= ~INHIBIT_SWITCH_UNTIL_PREEMPTED;
+				wa_applied = true;
+			}
+
+			/* Warn only on the value read from hardware. */
+			xe_gt_WARN_ON(gt, idledly_hw >= maxcnt);
+
+			if (idledly >= maxcnt) {
+				/* maxcnt may be 0 if IDLE_WAIT_TIME is unprogrammed. */
+				idledly = maxcnt ? maxcnt - 1 : 0;
+				clamped_below_maxcnt = true;
+				wa_applied = true;
+			}
 		}
 
-		if (wa_applied)
-			xe_mmio_write32(&gt->mmio, RING_IDLEDLY(hwe->mmio_base),
-					REG_FIELD_PREP(IDLE_DELAY, idledly));
+		if (wa_applied) {
+			u32 idledly_ticks;
+
+			/*
+			 * Wa_16023105232 requires idledly < maxcnt, so floor
+			 * that clamp; otherwise round up to guarantee the
+			 * Wa_14025941587 minimum survives tick quantization.
+			 */
+			if (clamped_below_maxcnt)
+				idledly_ticks = idledly_floor_ticks(idledly, idledly_units_ps);
+			else
+				idledly_ticks = DIV_ROUND_UP_ULL((u64)idledly * 1000,
+								 idledly_units_ps);
+
+			/*
+			 * Tick quantization can still push the rounded-up value
+			 * to/above maxcnt; re-floor here so Wa_16023105232 keeps
+			 * priority even in that case.
+			 */
+			if (!clamped_below_maxcnt && XE_GT_WA(gt, 16023105232) &&
+			    (u64)idledly_ticks * idledly_units_ps >= (u64)maxcnt * 1000) {
+				xe_gt_dbg(gt, "idledly %s: %u ticks would exceed maxcnt=%u, so flooring\n",
+					  hwe->name, idledly_ticks, maxcnt);
+				idledly = maxcnt ? maxcnt - 1 : 0;
+				idledly_ticks = idledly_floor_ticks(idledly, idledly_units_ps);
+			}
+
+			idledly_reg_val &= ~IDLE_DELAY;
+			idledly_reg_val |= REG_FIELD_PREP(IDLE_DELAY, idledly_ticks);
+			xe_gt_dbg(gt, "idledly %s: set %u max=%u inh=%u ts=%u\n",
+				  hwe->name, idledly, maxcnt,
+				  !!inhibit_switch, gt->info.timestamp_base);
+			xe_mmio_write32(&gt->mmio,
+					RING_IDLEDLY(hwe->mmio_base),
+					idledly_reg_val);
+		}
 	}
 }
 
diff --git a/drivers/gpu/drm/xe/xe_wa_oob.rules b/drivers/gpu/drm/xe/xe_wa_oob.rules
index 132a41859ab7..00c58b3ca9c2 100644
--- a/drivers/gpu/drm/xe/xe_wa_oob.rules
+++ b/drivers/gpu/drm/xe/xe_wa_oob.rules
@@ -65,3 +65,5 @@
 
 14025883347	MEDIA_VERSION_RANGE(1301, 3500)
 		GRAPHICS_VERSION_RANGE(2004, 3005)
+14025941587	GRAPHICS_VERSION_RANGE(2001, 3511), FUNC(xe_rtp_match_not_sriov_vf)
+		MEDIA_VERSION_RANGE(1301, 3503), FUNC(xe_rtp_match_not_sriov_vf)
-- 
2.55.0

