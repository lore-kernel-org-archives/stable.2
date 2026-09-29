Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.17])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 788E04F7CCD
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 09:44:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.17
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790675097; cv=none; b=gzStSDfFAdj3lNZpyWffdmBpIbtjCEOYBrUILqjNA21ZC1HN5PevKaFpJ4PGVHSw7Yikp/y6By/LphwUD6wJmZZmfREwEgxNgjwH7ycVTUpMucatDgr4QGgW3TbbheJ3IH/RY+CiDWNsiv5gwUUSz5e3weuQ/HbKsCjya+HHExE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790675097; c=relaxed/simple;
	bh=7Ds7wx3FdMCajhqkJ0optwMHEz3Q9LJH/HG/N/qcqG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pk/lfrZPlXptOhyw8Wg2qNuKrffGvewBb5y4fjknthEowUjKbsUBvBKTu9CaQnJXQhqsDd9JjSIo3+wV3Oo+x6F5wCIpzrArZcQnVX7MvS3dqHxrQGHFKSGF8ZNUyXooWZcFLcRFaA3nR4TrjDKZB53/ICPOF4siZrNpuANnmPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=d7TesFhe; arc=none smtp.client-ip=192.198.163.17
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="d7TesFhe"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790675095; x=1822211095;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=7Ds7wx3FdMCajhqkJ0optwMHEz3Q9LJH/HG/N/qcqG4=;
  b=d7TesFhe+OEO4yHEzf2/Y+jUP70sFDuTnzEPxczD+qE5xbyoiANt9vE0
   cauiap1yvOe/bJuH9FV/e+VeKMIWYJX1EV243QFKllbFG4+AqP74AWm9T
   vB5q+w29sLVeFYhxSoYx/m/Ab24/QtxsscRssijmlbrdGmneWF9Kze02H
   GCaGwEiwYyg6AfNd9kRmz9En8bULLPQ2IOdG1JajopZGEacUL+uIla3E4
   igZ4sOvsGNulhzjxz+ypCbYkx6JR/eMTdC4nTnR2lF82/jtKLLG9Qj38y
   7ZyOLPkNe5ZfrZiHg60JtJCJBbP0Lp03DSC9OgKnd9bEgvZRI9z0oSBLu
   g==;
X-CSE-ConnectionGUID: JVVRtq6dTOu++Q69XdBAwg==
X-CSE-MsgGUID: nayVPNqnSRG5y2eJ8VwwHQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="91250041"
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="91250041"
Received: from fmviesa005.fm.intel.com ([10.60.135.145])
  by fmvoesa111.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 02:44:53 -0700
X-CSE-ConnectionGUID: eDMezrlLQBGaEDtgW/5wxg==
X-CSE-MsgGUID: g8gNl2WwQViAqFEokUQP7w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,130,1787036400"; 
   d="scan'208";a="283414942"
Received: from mjarzebo-mobl1.ger.corp.intel.com (HELO jhogande-mobl3.intel.com) ([10.245.246.120])
  by fmviesa005-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2026 02:44:51 -0700
From: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/8] drm/i915/psr: Clear selective fetch area when duplicating plane state
Date: Tue, 29 Sep 2026 12:44:27 +0300
Message-ID: <20260929094434.77129-2-jouni.hogander@intel.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260929094434.77129-1-jouni.hogander@intel.com>
References: <20260929094434.77129-1-jouni.hogander@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
Content-Transfer-Encoding: 8bit

We are currently not clearing selective fetch area when duplicating plane
state. This is causing problem when plane is re-used for another
purpose. Fix this by clearing selective fetch area when duplicating plane
state.

Now as the state is cleared we need to ensure we have consistent selective
fetch area in plane state on full update. Earlier this was relying on
selective fetch area being copied from old state on state duplicate. Now
this isn't true anymore as we are clearing it. Tackle this by setting full
plane area as selective fetch area for each plane on full update. Rename
the label as skip_su_area_calc as the loop setting the plane selective
fetch area is not skipped anymore.

Move also psr2_sel_fetch_pipe_state_supported check after psr2_su_area
initialization. The loop is run on full update as well now and it needs
initialized psr2_su_area. Clip_area_update is only touching rect height and
x1/x2 are left untouched.

Don't set the area at all for planes not intersecting with the selective
update area. It is already zero sized after plane state duplicate.

Fixes: efab47658a6c ("drm/i915/display/psr: Calculate selective fetch plane registers")
Cc: <stable@vger.kernel.org> # v5.12+
Assisted-by: GitHub-Copilot:claude-opus-5
Signed-off-by: Jouni Högander <jouni.hogander@intel.com>
---
 drivers/gpu/drm/i915/display/intel_plane.c |  1 +
 drivers/gpu/drm/i915/display/intel_psr.c   | 24 ++++++++++------------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index 25ca049009efb..f908eabe604bb 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -140,6 +140,7 @@ intel_plane_duplicate_state(struct drm_plane *plane)
 	intel_state->dpt_vma = NULL;
 	intel_state->fence_id = -1;
 	intel_state->damage = DRM_RECT_INIT(0, 0, 0, 0);
+	intel_state->psr2_sel_fetch_area = DRM_RECT_INIT(0, 0, 0, 0);
 
 	/* add reference to fb */
 	if (intel_state->hw.fb)
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index f1d48b69a18fa..f620c44ee4008 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2920,16 +2920,16 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	if (!crtc_state->enable_psr2_sel_fetch)
 		return 0;
 
-	if (!psr2_sel_fetch_pipe_state_supported(crtc_state)) {
-		full_update = true;
-		goto skip_sel_fetch_set_loop;
-	}
-
 	crtc_state->psr2_su_area.x1 = 0;
 	crtc_state->psr2_su_area.y1 = -1;
 	crtc_state->psr2_su_area.x2 = drm_rect_width(&display_area);
 	crtc_state->psr2_su_area.y2 = -1;
 
+	if (!psr2_sel_fetch_pipe_state_supported(crtc_state)) {
+		full_update = true;
+		goto skip_su_area_calc;
+	}
+
 	/*
 	 * Calculate minimal selective fetch area of each plane and calculate
 	 * the pipe damaged area.
@@ -3013,7 +3013,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	}
 
 	if (full_update)
-		goto skip_sel_fetch_set_loop;
+		goto skip_su_area_calc;
 
 	intel_psr_apply_su_area_workarounds(crtc_state);
 
@@ -3049,6 +3049,11 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 			break;
 	} while (su_area_changed);
 
+skip_su_area_calc:
+	if (full_update)
+		clip_area_update(&crtc_state->psr2_su_area, &display_area,
+				 &display_area);
+
 	/*
 	 * Now that we have the pipe damaged area check if it intersect with
 	 * every plane, if it does set the plane selective fetch area.
@@ -3065,8 +3070,6 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		inter = crtc_state->psr2_su_area;
 		sel_fetch_area = &new_plane_state->psr2_sel_fetch_area;
 		if (!drm_rect_intersect(&inter, &new_plane_state->uapi.dst)) {
-			sel_fetch_area->y1 = -1;
-			sel_fetch_area->y2 = -1;
 			/*
 			 * if plane sel fetch was previously enabled ->
 			 * disable it
@@ -3106,11 +3109,6 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		}
 	}
 
-skip_sel_fetch_set_loop:
-	if (full_update)
-		clip_area_update(&crtc_state->psr2_su_area, &display_area,
-				 &display_area);
-
 	psr2_man_trk_ctl_calc(crtc_state, full_update);
 	crtc_state->pipe_srcsz_early_tpt =
 		psr2_pipe_srcsz_early_tpt_calc(crtc_state, full_update);
-- 
2.43.0

