Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 22101534474
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:06:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788951975; cv=none; b=nSfi4i/gYeuBwEHzQrq/6r7pp+b829r511LN/2qgxQyziHeCS6BVVCstNsh95wvB2G/klVtt7vI1PDS+7s+SDzBYyR/VDnlskcl/gHvapS3+6EepFc0d+4yN/MjmolhZNMGDymF0/3nLpFg+2BY3133vLM0uR4vxlT4b44G5sjQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788951975; c=relaxed/simple;
	bh=T7UV6R9AHjRfnIPf0DCTeeGdQ7XCUPJApSwLBTK4IXU=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=i3ChppZU7o7vaDmL/OS912nanVlvX68lMLh51O1Awj0KIqTk9V0NjJtZG+S95YlaH9KO0n2sPl6Tixc4PD1HZ6hWXeXI6lQ5ZxTWxX2JJpnMgs3dN2V5INFths9eqdhtoFoofgTXMAI440UQfTJOOukxwHVRWPFx/PBrf3UWtzA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=kIg4bJaj; arc=none smtp.client-ip=192.198.163.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="kIg4bJaj"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1788951972; x=1820487972;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=T7UV6R9AHjRfnIPf0DCTeeGdQ7XCUPJApSwLBTK4IXU=;
  b=kIg4bJaj5AifDabOxu+lfXR44Cj9yZxI3QCJiXBO0qY98MifJtwdWpC6
   ECubswJ43J4cyjZ0UV54ec+/Bv61m8rIfAaYmCBpzmgh5lsdSewiRuIxf
   xHIgPPCGYHx8Pmsmjp1i+swPEqSSovycBh/l1eklXcFBMcdPMnTncxVOW
   c2G2CHhAeTzzpL2HFFH3keIGnIHRuo5CHkAJ+Ca/jHeaDpZsLS6jNHzDK
   KHnP1eaqC8n2YezJwn0VP6T1mvT4sR9glrey5oIrPhxAT+fknFIPpzAyv
   iNggrFUOoqGK0nKTduWG119wXZx0tkDnSCV/COz0+7MuiPP1moEcnQJtH
   A==;
X-CSE-ConnectionGUID: PqHbqtCvQk2bKGwGavJ44A==
X-CSE-MsgGUID: lK8X1M20QDOil6TGnWteUA==
X-IronPort-AV: E=McAfee;i="6800,10657,11900"; a="91888658"
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="91888658"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Sep 2026 04:06:09 -0700
X-CSE-ConnectionGUID: 8flxUoTERamxcGK5dwgY1g==
X-CSE-MsgGUID: VhjDpn6wQTqDa4KJQ0qGmA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,270,1779174000"; 
   d="scan'208";a="275425321"
Received: from nemesa.iind.intel.com ([10.190.239.22])
  by orviesa005.jf.intel.com with ESMTP; 09 Sep 2026 04:06:08 -0700
From: Nemesa Garg <nemesa.garg@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Nemesa Garg <nemesa.garg@intel.com>,
	stable@vger.kernel.org,
	=?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
Subject: [PATCH 1/2] Revert "drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable"
Date: Wed,  9 Sep 2026 16:33:31 +0530
Message-Id: <20260909110332.3528029-2-nemesa.garg@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260909110332.3528029-1-nemesa.garg@intel.com>
References: <20260909110332.3528029-1-nemesa.garg@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

This reverts commit 7f1172a2ac0d7e50850785e2e65789c8aac8411a.

This commit replaced the crtc_state->enable_psr2_sel_fetch guard in
icl_plane_disable_sel_fetch_arm() and i9xx_cursor_disable_sel_fetch_arm()
with HAS_PSR2_SEL_FETCH(). This is a display version check and
says nothing about the pipe, so every plane and cursor disable on a
display 12+ platform started writing SEL_FETCH_PLANE_CTL() /
SEL_FETCH_CUR_CTL(), including on pipes that do not implement them.
It shows up as an unclaimed register access on pipes driving HDMI where
selective fetch was never enabled.

The stale selective fetch enable bit that commit addressed is handled
in the next patch.

Fixes: 7f1172a2ac0d ("drm/i915/display: Clear SEL_FETCH_PLANE_CTL on plane disable")
Closes: https://gitlab.freedesktop.org/drm/i915/kernel/-/work_items/16876
Cc: stable@vger.kernel.org
Signed-off-by: Nemesa Garg <nemesa.garg@intel.com>
Reviewed-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_cursor.c       | 15 +++++----------
 .../gpu/drm/i915/display/skl_universal_plane.c    | 15 +++++----------
 2 files changed, 10 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_cursor.c b/drivers/gpu/drm/i915/display/intel_cursor.c
index cce041e1da51..90173040d825 100644
--- a/drivers/gpu/drm/i915/display/intel_cursor.c
+++ b/drivers/gpu/drm/i915/display/intel_cursor.c
@@ -531,18 +531,13 @@ static int i9xx_check_cursor(struct intel_crtc_state *crtc_state,
 }
 
 static void i9xx_cursor_disable_sel_fetch_arm(struct intel_dsb *dsb,
-					      struct intel_plane *plane)
+					      struct intel_plane *plane,
+					      const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(plane);
 	enum pipe pipe = plane->pipe;
 
-	/*
-	 * Clear this whenever the hardware has selective fetch, not just when
-	 * the current state uses it. The cursor may have been enabled with
-	 * selective fetch earlier and had its enable bit orphaned when the
-	 * feature was switched off.
-	 */
-	if (!HAS_PSR2_SEL_FETCH(display))
+	if (!crtc_state->enable_psr2_sel_fetch)
 		return;
 
 	intel_de_write_dsb(display, dsb, SEL_FETCH_CUR_CTL(pipe), 0);
@@ -592,7 +587,7 @@ static void i9xx_cursor_update_sel_fetch_arm(struct intel_dsb *dsb,
 		if (crtc_state->enable_psr2_su_region_et)
 			wa_16021440873(dsb, plane, crtc_state, plane_state);
 		else
-			i9xx_cursor_disable_sel_fetch_arm(dsb, plane);
+			i9xx_cursor_disable_sel_fetch_arm(dsb, plane, crtc_state);
 	}
 }
 
@@ -701,7 +696,7 @@ static void i9xx_cursor_update_arm(struct intel_dsb *dsb,
 	if (plane_state)
 		i9xx_cursor_update_sel_fetch_arm(dsb, plane, crtc_state, plane_state);
 	else
-		i9xx_cursor_disable_sel_fetch_arm(dsb, plane);
+		i9xx_cursor_disable_sel_fetch_arm(dsb, plane, crtc_state);
 
 	if (plane->cursor.base != base ||
 	    plane->cursor.size != fbc_ctl ||
diff --git a/drivers/gpu/drm/i915/display/skl_universal_plane.c b/drivers/gpu/drm/i915/display/skl_universal_plane.c
index 5cda1ab90e40..07a683293352 100644
--- a/drivers/gpu/drm/i915/display/skl_universal_plane.c
+++ b/drivers/gpu/drm/i915/display/skl_universal_plane.c
@@ -879,18 +879,13 @@ skl_plane_disable_arm(struct intel_dsb *dsb,
 }
 
 static void icl_plane_disable_sel_fetch_arm(struct intel_dsb *dsb,
-					    struct intel_plane *plane)
+					    struct intel_plane *plane,
+					    const struct intel_crtc_state *crtc_state)
 {
 	struct intel_display *display = to_intel_display(plane);
 	enum pipe pipe = plane->pipe;
 
-	/*
-	 * Clear this whenever the hardware has selective fetch, not just when
-	 * the current state uses it. The plane may have been enabled with
-	 * selective fetch earlier and had its enable bit orphaned when the
-	 * feature was switched off.
-	 */
-	if (!HAS_PSR2_SEL_FETCH(display))
+	if (!crtc_state->enable_psr2_sel_fetch)
 		return;
 
 	intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_CTL(pipe, plane->id), 0);
@@ -926,7 +921,7 @@ icl_plane_disable_arm(struct intel_dsb *dsb,
 
 	skl_write_plane_wm(dsb, plane, crtc_state);
 
-	icl_plane_disable_sel_fetch_arm(dsb, plane);
+	icl_plane_disable_sel_fetch_arm(dsb, plane, crtc_state);
 
 	if (plane_has_normalizer(plane))
 		intel_de_write_dsb(display, dsb,
@@ -1646,7 +1641,7 @@ static void icl_plane_update_sel_fetch_arm(struct intel_dsb *dsb,
 		intel_de_write_dsb(display, dsb, SEL_FETCH_PLANE_CTL(pipe, plane->id),
 				   SEL_FETCH_PLANE_CTL_ENABLE);
 	else
-		icl_plane_disable_sel_fetch_arm(dsb, plane);
+		icl_plane_disable_sel_fetch_arm(dsb, plane, crtc_state);
 }
 
 static void
-- 
2.25.1

