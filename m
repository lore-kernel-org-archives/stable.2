Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED8C3382299
	for <stable@vger.kernel.org>; Thu, 17 Sep 2026 07:53:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789631587; cv=none; b=fDeEGKYT8voMAkn2HT7KfRHa0RvelmPARt80McLYGl7elgv//rb7Bi38eG6nq8kvtmWAZvJKczKYYPVg8tXp9TOU80UqUp6R/Wo7oT3s7Ih5lTzmhNCUmeZmLtXiQw1kBZVWMDid6e1VUVeI6sT63tW5XZh6NkA/xqLsKSSGKUE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789631587; c=relaxed/simple;
	bh=FO19pMOrYyrg3614Ca13MpV/M30JRrC1TLuPT+HmTHw=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=PmmIHtMkbrp9FCnKo3mAVC2N8GP4pwVZwcfzXUnnW6vR9jeXNMAh9KSbidPoKFLrCNEWvEcLh6gzofCl2+Pgii8frC3AOEizhpyFTMyIhwBraXCMc6SYjmMPQci0m9b1i3JEekDW7FwGnLAVTzL2OVXQIn0HlhDSMQ9a5saBC/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=RVttczce; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="RVttczce"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1789631585; x=1821167585;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=FO19pMOrYyrg3614Ca13MpV/M30JRrC1TLuPT+HmTHw=;
  b=RVttczceOpHq5EzC9OutOqE40AZbw8hIaduemFTjMEl/bqgQaLyHK4yk
   M+xYqYlldG4vrTLEyAz9A45SDC+ZVu//y7vymZjALhERLUN+bfBEKKyiX
   q6/X2GX/kdvPQTXOqlfT8LLnTfQBUN2HpY14Fyp/3qdskaDYBRPillm4P
   6L87e/rKjqbUaULlLGgc3VWqJ3794qKx1A5rmaBkiUANZDHcJxRGRjL70
   OAKOItzVkPekFGvgYpTlQsJGDDG9wG2YV7epy+FL5XX36SM1/v/hPzX9a
   /RetXD/Yri2eJnXUsGSYVooC+vo9pzJRHwMoE1hSzvlJIHOam5p0iM+lp
   g==;
X-CSE-ConnectionGUID: nLWXnmknRDKmYbJXOQJ2aw==
X-CSE-MsgGUID: rALitXfVR2+OjdhDiIb9aQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11905"; a="88962265"
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="88962265"
Received: from fmviesa001.fm.intel.com ([10.60.135.141])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Sep 2026 00:53:04 -0700
X-CSE-ConnectionGUID: YHsfxrQhSOOQps6vDfHRBw==
X-CSE-MsgGUID: SYkElSfvSkuP+ssfeCBAsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,103,1787036400"; 
   d="scan'208";a="298724068"
Received: from mgolanimitul-x299-ud4-pro.iind.intel.com ([10.190.239.114])
  by fmviesa001.fm.intel.com with ESMTP; 17 Sep 2026 00:53:02 -0700
From: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
To: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org,
	ankit.k.nautiyal@intel.com,
	jani.nikula@linux.intel.com,
	chaitanya.kumar.borah@intel.com,
	stable@vger.kernel.org
Subject: [PATCH v3] drm/i915/vrr: Disable DC balance by default
Date: Thu, 17 Sep 2026 13:13:22 +0530
Message-ID: <20260917074322.2606738-1-mitulkumar.ajitkumar.golani@intel.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Disable VRR DC balance by default due to timing issues observed on some
panel/TCON combinations.

Keep the module parameter to enable DC balance during debugging and to
isolate DC balance effects from underlying VRR/display timing issues.

--v2:
- Make enable_dc_balance a bool and keep it disabled by default; fix the
  parameter type/value mismatch and correct the description (Chaitanya
  Kumar Borah, Jani Nikula)
- Explain in the commit message why the feature is gated and why a
  module parameter is used (Jani Nikula)

--v3:
- Commit message update (Jani Nikula)

Fixes: 555819270707 ("drm/i915/vrr: Enable DC Balance")
Cc: <stable@vger.kernel.org> # v7.0+
Signed-off-by: Mitul Golani <mitulkumar.ajitkumar.golani@intel.com>
Reviewed-by: Ankit Nautiyal <ankit.k.nautiyal@intel.com>
---
 drivers/gpu/drm/i915/display/intel_display_params.c | 4 ++++
 drivers/gpu/drm/i915/display/intel_display_params.h | 1 +
 drivers/gpu/drm/i915/display/intel_vrr.c            | 4 +++-
 3 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/i915/display/intel_display_params.c b/drivers/gpu/drm/i915/display/intel_display_params.c
index 2aed110c5b090..ca0ef466bb103 100644
--- a/drivers/gpu/drm/i915/display/intel_display_params.c
+++ b/drivers/gpu/drm/i915/display/intel_display_params.c
@@ -120,6 +120,10 @@ intel_display_param_named_unsafe(enable_psr, int, 0400,
 	"(0=disabled, 1=enable up to PSR1, 2=enable up to PSR2) "
 	"Default: -1 (use per-chip default)");
 
+intel_display_param_named_unsafe(enable_dc_balance, bool, 0400,
+	"Enable VRR DC balance (0=disabled, 1=enabled). "
+	"Default: 0 (disabled)");
+
 intel_display_param_named_unsafe(enable_panel_replay, int, 0400,
 	"Enable Panel Replay (0=disabled, 1=enabled). Default: -1 (use per-chip default)");
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_params.h b/drivers/gpu/drm/i915/display/intel_display_params.h
index ba01aeaf89440..5c5a1a1358c32 100644
--- a/drivers/gpu/drm/i915/display/intel_display_params.h
+++ b/drivers/gpu/drm/i915/display/intel_display_params.h
@@ -46,6 +46,7 @@ struct drm_printer;
 	param(bool, enable_dp_mst, true, 0600) \
 	param(int, enable_fbc, -1, 0600) \
 	param(int, enable_psr, -1, 0600) \
+	param(bool, enable_dc_balance, false, 0600) \
 	param(int, enable_panel_replay, -1, 0600) \
 	param(bool, psr_safest_params, false, 0400) \
 	param(bool, enable_psr2_sel_fetch, true, 0400) \
diff --git a/drivers/gpu/drm/i915/display/intel_vrr.c b/drivers/gpu/drm/i915/display/intel_vrr.c
index e36db11744405..1698c54e258b4 100644
--- a/drivers/gpu/drm/i915/display/intel_vrr.c
+++ b/drivers/gpu/drm/i915/display/intel_vrr.c
@@ -439,10 +439,12 @@ static bool intel_vrr_dc_balance_possible(const struct intel_crtc_state *crtc_st
 static void
 intel_vrr_dc_balance_compute_config(struct intel_crtc_state *crtc_state)
 {
+	struct intel_display *display = to_intel_display(crtc_state);
 	int guardband_usec, adjustment_usec;
 	struct drm_display_mode *adjusted_mode = &crtc_state->hw.adjusted_mode;
 
-	if (!intel_vrr_dc_balance_possible(crtc_state) || !crtc_state->vrr.enable)
+	if (!intel_vrr_dc_balance_possible(crtc_state) ||
+	    !crtc_state->vrr.enable || !display->params.enable_dc_balance)
 		return;
 
 	crtc_state->vrr.dc_balance.vmax = crtc_state->vrr.vmax;
-- 
2.48.1

