Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A525A39D6D9
	for <stable@vger.kernel.org>; Mon,  3 Aug 2026 20:27:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785788823; cv=none; b=CXcOxu6ClrXUo8f+h3TBLqw4vpndfrgdntvF0MaiJbtSWu7XCHjVP7Dl+O5O61+WYiL7XHDXps/UTjEfbsrAKEekz/5470TsLoryKYcrjmT4XOCOeM1oE0tW5B8GKr2qkGT3N/16hMa4F/w09zmfRAmqCLcWOIC5V5va4/SdqqE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785788823; c=relaxed/simple;
	bh=5CtAIQxlxV7+/R3qss+LA4IawxZ1kzCXbsLvfCGF9c8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=megUC8tc/q/7xNlFTSmpf2oDRweuygK6ecyDpfWrj6TVNoBS1WDVhT0kbrnCM6elt6tQ448qwTrAbm75ej8VTYKC3pY5jJOJU6K6wz9rdkbqf4a/q9PTEn06GcErB05Rb41Y+6261ZlJM5SCVEixXrXjLy6cD6lz2QL5g2k4Ivo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Tsm/zjiv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Tsm/zjiv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1961F000E9;
	Mon,  3 Aug 2026 20:27:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785788821;
	bh=xjpfjDWNqpZvEkjWecBm49a5yQR33iNzP/IK0MwY+Ls=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Tsm/zjivRKBCIHE/kVU3e268pEkg7Xp95fRXIVsq0b5Fe+7J8XUpFwk2M4P1bACH0
	 cJ9oPmN/ZaGKXhxmuxS1Q3TQEhKmRUu//WTTl45wOsUKPX0HCnIqGCO3d1IKBbZWm1
	 yIxRtZJzcVwJ6Dpnb2HKeVaaC8P30yP4ewJf9AqcI/A4KKK8fKn0RjJApPowFEcWrz
	 sjTOeed6ZEc4nD+k1s9hCONpGjP3WiOz7ZBJa9Jx+VuO6rSvkRDp1/y9Hpy8mqx8Fm
	 MT5eBecT8JQV33fmjy4iUX6YWtQtDgIMtUSTe64btAvuzx2xRPO1f7OyZTRQY8e40H
	 AwWKLnwMxXQrA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] drm/i915/fbc: Extract intel_fbc_has_fences()
Date: Mon,  3 Aug 2026 16:26:55 -0400
Message-ID: <20260803202658.1647132-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072917-dugout-sufferer-eb18@gregkh>
References: <2026072917-dugout-sufferer-eb18@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Ville Syrjälä <ville.syrjala@linux.intel.com>

[ Upstream commit bc34d310b578952d37b5200a7fa7475ab2a2bd5e ]

Pull the "do we have fences?" check into a single helper in the FBC
code. Avoids having to call to outside the display code in multiple
places for this.

Signed-off-by: Ville Syrjälä <ville.syrjala@linux.intel.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20240705145254.3355-2-ville.syrjala@linux.intel.com
Reviewed-by: Rodrigo Vivi <rodrigo.vivi@intel.com>
Stable-dep-of: bbb15a6b042d ("drm/i915/hdcp: check streams[] bounds before overflow")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_fbc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
index 25382022cd276..a6861c3bd224a 100644
--- a/drivers/gpu/drm/i915/display/intel_fbc.c
+++ b/drivers/gpu/drm/i915/display/intel_fbc.c
@@ -223,6 +223,11 @@ static u16 intel_fbc_override_cfb_stride(const struct intel_plane_state *plane_s
 	return 0;
 }
 
+static bool intel_fbc_has_fences(struct drm_i915_private *i915)
+{
+	return intel_gt_support_legacy_fencing(to_gt(i915));
+}
+
 static u32 i8xx_fbc_ctl(struct intel_fbc *fbc)
 {
 	const struct intel_fbc_state *fbc_state = &fbc->state;
@@ -608,7 +613,7 @@ static void ivb_fbc_activate(struct intel_fbc *fbc)
 	else if (DISPLAY_VER(i915) == 9)
 		skl_fbc_program_cfb_stride(fbc);
 
-	if (intel_gt_support_legacy_fencing(to_gt(i915)))
+	if (intel_fbc_has_fences(i915))
 		snb_fbc_program_fence(fbc);
 
 	intel_de_write(i915, ILK_DPFC_CONTROL(fbc->id),
@@ -992,7 +997,7 @@ static void intel_fbc_update_state(struct intel_atomic_state *state,
 	fbc_state->fence_y_offset = intel_plane_fence_y_offset(plane_state);
 
 	drm_WARN_ON(&i915->drm, plane_state->flags & PLANE_HAS_FENCE &&
-		    !intel_gt_support_legacy_fencing(to_gt(i915)));
+		    !intel_fbc_has_fences(i915));
 
 	if (plane_state->flags & PLANE_HAS_FENCE)
 		fbc_state->fence_id =  i915_vma_fence_id(plane_state->ggtt_vma);
-- 
2.53.0

