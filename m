Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.11])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 48602385D60
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 08:54:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.11
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780304064; cv=none; b=GuEdoy3Imn1D4mh/RzRp9Ciq7wxdlT6W0oZ8IydTgefZ+XteD7B4nAx5S0+S9ykayVgUN0b2061IWzWKnV6AilhNG16ZJGn9cqpxvZcdRyMkQd/81Oci5sZkXWXwlrwzj1pkcEqql1O1obPVI+bjIF3iUWvxK9Q5AvQD7N0y9dU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780304064; c=relaxed/simple;
	bh=Rl4xuY1v9VBtAe/BpnRqX4uCDCp+AZh+liY7lQ03n5g=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=WQvamQG4sJDy9z/6+xIrtr/drFZ6155HqeB5r914izITvnr2mFxBoTyCAkHm68kWuhNYrl2s21r06Gg3GBvVOULSVr3G+eKP6VPniOXdhwLBjcpe65MIW+P44+fVDCd5Pkc6+MbhTrDPMURVOUolLs88OwS4cZLE8lsbjZ3CSQY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=YUT1YuqG; arc=none smtp.client-ip=198.175.65.11
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="YUT1YuqG"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1780304064; x=1811840064;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Rl4xuY1v9VBtAe/BpnRqX4uCDCp+AZh+liY7lQ03n5g=;
  b=YUT1YuqGs23qrboTwAiLu/I+h/+hvBiMVbtWgsrFxJrtdt4Pxp+tGJKT
   24uJIPubZRvg7C5c7NvjgMbcDUmPqBgUXqXYv2LNPJ/Vw0Ee8rO08RI4f
   ohd0CoiohOw/o0kqKPGsj0zLvtA1ZBGIzJFa8EV/li17Chnui+jUoAY8V
   YQQRF//BVSp+RlYFyOLSNCt/MOyRwcVdcj/7ZhydrowJzlUn7pU8rSPod
   hS3a4fg1hLELb2HvuDwEdAVOdSLKXV3sOTUFbk6BwdEFyCSPdb7sney5/
   5TchluyX1os7ZzAsZxfwHEdgrqRTFr4kpm6+kp63cM2CkXuU/OApOm0Rh
   w==;
X-CSE-ConnectionGUID: +tr1R01oTEGwEsVnppYD6g==
X-CSE-MsgGUID: r2hpBd7tSjWqEaaIBFoQPQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11803"; a="91368926"
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="91368926"
Received: from fmviesa006.fm.intel.com ([10.60.135.146])
  by orvoesa103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2026 01:54:23 -0700
X-CSE-ConnectionGUID: vPz26myOQSO1bqY57bHFaw==
X-CSE-MsgGUID: MChDPTJNQaCjQbQvM+58RQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.24,180,1774335600"; 
   d="scan'208";a="239110460"
Received: from dut-2a59.iind.intel.com ([10.190.239.113])
  by fmviesa006.fm.intel.com with ESMTP; 01 Jun 2026 01:54:20 -0700
From: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: ville.syrjala@linux.intel.com,
	uma.shankar@intel.com,
	chaitanya.kumar.borah@intel.com,
	pranay.samala@intel.com,
	stable@vger.kernel.org
Subject: [v4 3/3] drm/i915: Fix color blob reference handling in intel_plane_state
Date: Mon,  1 Jun 2026 13:59:53 +0530
Message-Id: <20260601082953.128539-4-chaitanya.kumar.borah@intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260601082953.128539-1-chaitanya.kumar.borah@intel.com>
References: <20260601082953.128539-1-chaitanya.kumar.borah@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Take proper references for hw color blobs (degamma_lut, gamma_lut,
ctm, lut_3d) in intel_plane_duplicate_state() and drop them in
intel_plane_destroy_state().

v2:
- handle blobs in hw state clear

Cc: <stable@vger.kernel.org> #v6.19+
Fixes: 3b7476e786c2 ("drm/i915/color: Add framework to program PRE/POST CSC LUT")
Fixes: a78f1b6baf4d ("drm/i915/color: Add framework to program CSC")
Fixes: 65db7a1f9cf7 ("drm/i915/color: Add 3D LUT to color pipeline")
Reviewed-by: Pranay Samala <pranay.samala@intel.com> #v1
Reviewed-by: Uma Shankar <uma.shankar@intel.com>
Signed-off-by: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
---
 drivers/gpu/drm/i915/display/intel_plane.c | 27 ++++++++++++++++++++++
 1 file changed, 27 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index b8348c0189aa..3eaf82477f49 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -145,6 +145,15 @@ intel_plane_duplicate_state(struct drm_plane *plane)
 	if (intel_state->hw.fb)
 		drm_framebuffer_get(intel_state->hw.fb);
 
+	if (intel_state->hw.degamma_lut)
+		drm_property_blob_get(intel_state->hw.degamma_lut);
+	if (intel_state->hw.gamma_lut)
+		drm_property_blob_get(intel_state->hw.gamma_lut);
+	if (intel_state->hw.ctm)
+		drm_property_blob_get(intel_state->hw.ctm);
+	if (intel_state->hw.lut_3d)
+		drm_property_blob_get(intel_state->hw.lut_3d);
+
 	return &intel_state->uapi;
 }
 
@@ -168,6 +177,16 @@ intel_plane_destroy_state(struct drm_plane *plane,
 	__drm_atomic_helper_plane_destroy_state(&plane_state->uapi);
 	if (plane_state->hw.fb)
 		drm_framebuffer_put(plane_state->hw.fb);
+
+	if (plane_state->hw.degamma_lut)
+		drm_property_blob_put(plane_state->hw.degamma_lut);
+	if (plane_state->hw.gamma_lut)
+		drm_property_blob_put(plane_state->hw.gamma_lut);
+	if (plane_state->hw.ctm)
+		drm_property_blob_put(plane_state->hw.ctm);
+	if (plane_state->hw.lut_3d)
+		drm_property_blob_put(plane_state->hw.lut_3d);
+
 	kfree(plane_state);
 }
 
@@ -340,6 +359,14 @@ static void intel_plane_clear_hw_state(struct intel_plane_state *plane_state)
 {
 	if (plane_state->hw.fb)
 		drm_framebuffer_put(plane_state->hw.fb);
+	if (plane_state->hw.degamma_lut)
+		drm_property_blob_put(plane_state->hw.degamma_lut);
+	if (plane_state->hw.gamma_lut)
+		drm_property_blob_put(plane_state->hw.gamma_lut);
+	if (plane_state->hw.ctm)
+		drm_property_blob_put(plane_state->hw.ctm);
+	if (plane_state->hw.lut_3d)
+		drm_property_blob_put(plane_state->hw.lut_3d);
 
 	memset(&plane_state->hw, 0, sizeof(plane_state->hw));
 }
-- 
2.25.1

