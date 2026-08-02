Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 831811E7C23
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 03:25:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785641126; cv=none; b=i0rafwoDXUB4iPMdLVO2XODsMVr51esemrrExcJOL6d06/pVex+UU9yn+qDw8POgahWyiDcKq3SDwJ9EeutKRBh0L4az3OOqIhD7Ca4uLgQ4iDSAFCsjKM1/1TUQj0iRyIxf5aQjZXsSEq69Y01Hd5TaV+3cx1+O1xWHBUklHdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785641126; c=relaxed/simple;
	bh=wTn8UDhKqo4n/E/AAUkFIs1yueeMABzyKiYGfR4pJQE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hkb1gzTJYzwH9lqf5QM90j9ms3gbX4SVMIxM9eleL33qVKe7vtRSAtC8huObuFbEolEvwqQHlkv0NRztwisOSXVWj0RGujMaJfhztC6+RpCdg2s9jXnnyOPYQu1gkZURa+rJyM65v40SV2dOHeHKgY1Dhoh0vy5OVgUUMOidc94=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=M+rRgpRX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="M+rRgpRX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D111F00AC4;
	Sun,  2 Aug 2026 03:25:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785641125;
	bh=Dk34Sz750TzHFRNtGj9qkuH3uLkOFte0l3tQkt7iEBo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=M+rRgpRX/N4dEVqlgPA/ZwxUcFEEFR/ftu/QM35aBoZpPc6xi9v99dJOA/lUNkvMB
	 aWifn2gZ8cbpV7Hpw4HRb3iEsGwHVfpXWtCexrLidqsudn21LLe7mjicQdzSzPhYqV
	 4POM2njZv1Qv9Za9S9s3JUBtdt3+Ed8+qi5lQLLN8Jbh6TjiCqRH9Wnzmxi+fuLlAR
	 HDvI1X5BB+gpVDeMvz0fU8J+kN8bxws32yyB+k4L9x97j13ke85RCBPyMrZ2VF/4eu
	 BISBjM6damtXid1VIcMQpoADrtJ2mz/LV52PkojEeZrIj9r2chu7ayCK4QSIOL+wyA
	 oLshzq42o+0CA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ville=20Syrj=C3=A4l=C3=A4?= <ville.syrjala@linux.intel.com>,
	Rodrigo Vivi <rodrigo.vivi@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] drm/i915/fbc: Extract intel_fbc_has_fences()
Date: Sat,  1 Aug 2026 23:25:19 -0400
Message-ID: <20260802032522.2607746-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072904-impaired-parking-52fc@gregkh>
References: <2026072904-impaired-parking-52fc@gregkh>
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
Stable-dep-of: db9e64c983dc ("drm/i915/hdcp: require monotonically increasing seq_num_v")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_fbc.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
index 25382022cd27..a6861c3bd224 100644
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

