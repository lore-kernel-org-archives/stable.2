Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 727CB1A9FB0
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 21:50:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785793833; cv=none; b=dG9Kv2YyhzzZH16zznlvaGb9Pc8JYX77Gxpap4GwMIZb3dPMHVpjkB77XJO7G6Md4CqAC3Gol6CQP4jIPzO13coaVHQUR+tnr0Zy2FDC67tCiknGcGdacse+DL4m1vvUEzNgLevV4wz5YogiUK5kUD/4t1B3eBM8Hja2O1EvIkc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785793833; c=relaxed/simple;
	bh=HzaK7DOSVqzZw61WFb5Hq6mDpi5YizHNaf+HgYvriZ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jAq3BZaGvmb/OYLr4OnG2sYO6a8xYyC0z41dPbjtfsEIU73D+/NWBe1WyzQsRwL4FplREGNezyAw54yETCbJg0ebIyTgILwxZYM+T6RakqBn+Xx+zGMYehmMUi1au8cob5oYWC6eNnDRw2EGZ1khfRZLahdcqz+c6ks87WyI7lM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=bj7CstSP; arc=none smtp.client-ip=198.175.65.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="bj7CstSP"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1785793831; x=1817329831;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=HzaK7DOSVqzZw61WFb5Hq6mDpi5YizHNaf+HgYvriZ4=;
  b=bj7CstSPsQczcVpmJJ5mmwX35v3vkm9/jKFRWA48lAY8XBJhVlm/Veff
   7mgsNQsiVtVsx0bH9sk11GfFnx1Xm4l+fxB0u+2YV6r8ZMouMejy7Jazh
   9T376kkHRX+AppCRWSyIuZ0OUtC+17wVTxx2b0CCEkHlVArs7t6zgVIJC
   4mHzn5FSLoMkj78aWfJWOxAsZ0pobUozD1jEPZdggsWUNYUwn9p5GYr53
   jlzZuERCwy2tewHIXp0mYs1PbZre99dc9iVRPXeZWBOge0cuNmJaxpTb0
   oAxinvI2xaMDhIW8e97Si7lRhsflWpH9LmbtQUumOItFfv/Ma+iPKS5Zh
   A==;
X-CSE-ConnectionGUID: QclpL5O9S+aBupjCHF1dLA==
X-CSE-MsgGUID: Yxkqzp9PSvSuyX4ZepqeIw==
X-IronPort-AV: E=McAfee;i="6800,10657,11864"; a="97849146"
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="97849146"
Received: from orviesa002.jf.intel.com ([10.64.159.142])
  by orvoesa104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2026 14:50:31 -0700
X-CSE-ConnectionGUID: EwuJoKOhRaSBFDf84GMkbA==
X-CSE-MsgGUID: nNMjd0dpSrOuClCD3y7KAg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,203,1779174000"; 
   d="scan'208";a="291272078"
Received: from dev-417.igk.intel.com ([10.91.214.181])
  by orviesa002.jf.intel.com with ESMTP; 03 Aug 2026 14:50:29 -0700
From: =?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>
To: intel-gfx@lists.freedesktop.org,
	intel-xe@lists.freedesktop.org
Cc: Jani Nikula <jani.nikula@intel.com>,
	=?UTF-8?q?Micha=C5=82=20Grzelak?= <michal.grzelak@intel.com>,
	Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>,
	stable@vger.kernel.org
Subject: [PATCH v2 2/4] drm/i915/3dlut: disable 3D LUT for pre-GLK
Date: Mon,  3 Aug 2026 23:49:07 +0200
Message-ID: <20260803214909.3076716-3-michal.grzelak@intel.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20260803214909.3076716-1-michal.grzelak@intel.com>
References: <20260803214909.3076716-1-michal.grzelak@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Organization: Intel Technology Poland sp. z o.o. - ul. Slowackiego 173, 80-298 Gdansk - KRS 101882 - NIP 957-07-52-316
Content-Transfer-Encoding: 8bit

GLK+ hardware supports 3D LUT. Disable the feature for pre-GLK
platforms.

Add .has_3dlut field into struct intel_display_runtime_info. Use the
field to store whether 3D LUT is enabled. Initialize the field to 1 on
GLK+.

Add macro for checking 3D LUT's support. Use it while checking whether
CRTC has 3D LUT enabled.

v1->v2
- use either runtime info flag or display version check (Jani)
- don't initialize runtime info flag to 0 (Jani)

Bspec: 15585
Cc: Chaitanya Kumar Borah <chaitanya.kumar.borah@intel.com>
Cc: <stable@vger.kernel.org>
Fixes: 65db7a1f9cf7 ("drm/i915/color: Add 3D LUT to color pipeline")
Signed-off-by: Michał Grzelak <michal.grzelak@intel.com>
---
 drivers/gpu/drm/i915/display/intel_color.c          | 3 +++
 drivers/gpu/drm/i915/display/intel_display_device.c | 5 +++++
 drivers/gpu/drm/i915/display/intel_display_device.h | 2 ++
 3 files changed, 10 insertions(+)

diff --git a/drivers/gpu/drm/i915/display/intel_color.c b/drivers/gpu/drm/i915/display/intel_color.c
index 87ced9f6ff40..ffdefb51a264 100644
--- a/drivers/gpu/drm/i915/display/intel_color.c
+++ b/drivers/gpu/drm/i915/display/intel_color.c
@@ -4258,6 +4258,9 @@ intel_color_load_plane_luts(struct intel_dsb *dsb,
 bool
 intel_color_crtc_has_3dlut(struct intel_display *display, enum pipe pipe)
 {
+	if (!HAS_3DLUT(display))
+		return false;
+
 	if (DISPLAY_VER(display) >= 12)
 		return pipe == PIPE_A || pipe == PIPE_B;
 	else
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.c b/drivers/gpu/drm/i915/display/intel_display_device.c
index f17fc2c68472..4c09f35644ba 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.c
+++ b/drivers/gpu/drm/i915/display/intel_display_device.c
@@ -864,6 +864,7 @@ static const struct platform_desc glk_desc = {
 		GLK_COLORS,
 
 		.__runtime_defaults.ip.ver = 10,
+		.__runtime_defaults.has_3dlut = 1,
 	},
 	STEP_INFO(glk_steppings),
 };
@@ -899,6 +900,7 @@ static const struct platform_desc glk_desc = {
 	ICL_COLORS, \
 	\
 	.__runtime_defaults.ip.ver = 11, \
+	.__runtime_defaults.has_3dlut = 1, \
 	.__runtime_defaults.has_dmc = 1, \
 	.__runtime_defaults.has_dsc = 1, \
 	.__runtime_defaults.has_hdcp = 1, \
@@ -990,6 +992,7 @@ static const struct platform_desc ehl_desc = {
 	ICL_COLORS, \
 	\
 	.__runtime_defaults.ip.ver = 12, \
+	.__runtime_defaults.has_3dlut = 1, \
 	.__runtime_defaults.has_dmc = 1, \
 	.__runtime_defaults.has_dsc = 1, \
 	.__runtime_defaults.has_hdcp = 1, \
@@ -1156,6 +1159,7 @@ static const struct platform_desc adl_s_desc = {
 	TGL_CURSOR_OFFSETS,							\
 										\
 	.__runtime_defaults.ip.ver = 13,					\
+	.__runtime_defaults.has_3dlut = 1,					\
 	.__runtime_defaults.has_dmc = 1,					\
 	.__runtime_defaults.has_dsc = 1,					\
 	.__runtime_defaults.fbc_mask = BIT(INTEL_FBC_A),			\
@@ -1335,6 +1339,7 @@ static const struct platform_desc dg2_desc = {
 		BIT(TRANSCODER_A) | BIT(TRANSCODER_B) |				\
 		BIT(TRANSCODER_C) | BIT(TRANSCODER_D),				\
 	.__runtime_defaults.fbc_mask = BIT(INTEL_FBC_A) | BIT(INTEL_FBC_B),	\
+	.__runtime_defaults.has_3dlut = 1,					\
 	.__runtime_defaults.has_dmc = 1,					\
 	.__runtime_defaults.has_dsc = 1,					\
 	.__runtime_defaults.has_hdcp = 1,					\
diff --git a/drivers/gpu/drm/i915/display/intel_display_device.h b/drivers/gpu/drm/i915/display/intel_display_device.h
index 7121e7cd9512..5300c6ab99e7 100644
--- a/drivers/gpu/drm/i915/display/intel_display_device.h
+++ b/drivers/gpu/drm/i915/display/intel_display_device.h
@@ -147,6 +147,7 @@ struct intel_display_platforms {
 
 #define HAS_128B_Y_TILING(__display)	(!(__display)->platform.i915g && !(__display)->platform.i915gm)
 #define HAS_2PPC(__display)		(DISPLAY_VER(__display) >= 10)
+#define HAS_3DLUT(__display)		(DISPLAY_RUNTIME_INFO(__display)->has_3dlut)
 #define HAS_4TILE(__display)		((__display)->platform.dg2 || DISPLAY_VER(__display) >= 14)
 #define HAS_ASYNC_FLIPS(__display)	(DISPLAY_VER(__display) >= 5)
 #define HAS_AS_SDP(__display)		(DISPLAY_VER(__display) >= 13)
@@ -304,6 +305,7 @@ struct intel_display_runtime_info {
 
 	u8 fbc_mask;
 
+	bool has_3dlut;
 	bool has_hdcp;
 	bool has_dmc;
 	bool has_dsc;
-- 
2.45.2

