Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794590731;
	b=vwb9Oj5HUzW/nReYjPS27jn3u4m1S/DLKosgn8SqQ6+CpG572Jx4UQLqFFAJ3atUD1r1
	 +tMenveJjzpOGBcNFzE2rgCWtfOF3OhZ7sHzv+mBhNcmyiNGvsQRKlvBP3NykkCw+B7NU
	 2l+dWqsFhGtqiuWrZO6D7yBk6XKavfj8P0AU+QT3ui2cEpRc0TnbuxRkpZOURQdRZIEXL
	 L7JHtvmkpY1uztxvPM/7MIPUX20KEoQIOMmUWwyTlOtwPyo3w9iKMClt9k82IauQ76CyG
	 WiWbP+D6R14IEcWSI/vwnZOZ4iZR0QRBToj/YOj4dxYjhmoQnpxO1CGZE9uOAAcriEA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794590731;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=wI8qG+y9fvMl+AS/CrkyRna0VlswXFtoOmWpoadXPhs=;
	b=eXVCJmDpkkTUhifP3ceEgdG6RvDFXn1fkSX3R2CKpwpWxrgAmE8YHJ/BywJ8gV3xabnG
	 ITAIVb7wJgZyUKAVrVYhImqvipmtDBgdq9tKtzXzTjvQY/v6VgUA1wdbR/LHc2ovhew0X
	 F3gQWqYN+UyBJQV3qEgc/wsENBKZthmcoQSU2s8nreE/Ox0zPbf4Kb7S1GZvOqggQy81I
	 ZZiYMvACJgfSPCMZsok+yxfabTYTKby1JvLvnRuHesdW3zAfVkdWAS5bKwWksSM8PqAPU
	 0WJtL75FmH59IHmK6hlc5LiRZeQElIIKvjg/kRvbBO4loMQOOKfQV30TtMCXqjkq1CQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8Ptw2Fy;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 990CC6079D64
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 17:25:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8Ptw2Fy
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0A7F1F000C8;
	Fri, 13 Nov 2026 17:25:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794590731;
	bh=wI8qG+y9fvMl+AS/CrkyRna0VlswXFtoOmWpoadXPhs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=P8Ptw2FypTADKTwcB0aCJI6D+DmihAiHyK7g3Z8Ev4sfw1rL4ZxGUtmM6jlekUqiq
	 rL5K4drlRuU6Xwzyr+f4V7Y51sK72zQ+1FJfiz+7jewGmbvdA0Fjs1EePB2x4AnUoY
	 Zsk/XbmRlDK+2YRMLApevWi4WK1APBzzfoQuY788GyGqx6N0Wvh9OHjiyRP9VWmMGT
	 NgzZuusqcngeYbsLZR0SmV+GsPTQQ15uCxf+bV2VyvcMNI7+QJc/8we2Udrmx/PxPU
	 Sda0hPlgaWKHTSPQGNzrkjeSEUFfhIGcUmIXFFeE1EuDNrLYYlzA2ZuCO1HsvlzTt1
	 oqHeJxLe3ISQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/i915/psr: Clear selective fetch area when duplicating plane state
Date: Fri, 13 Nov 2026 12:25:29 -0500
Message-ID: <20261113172512.2122529-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200641-failed-6.12-cbe565475988@kernel.org>
References: <20261109200641-failed-6.12-cbe565475988@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jouni Högander <jouni.hogander@intel.com>

[ Upstream commit cbe565475988d3b22dc36f13c14d9f0eec1685cd ]

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
Reviewed-by: Mika Kahola <mika.kahola@intel.com>
Link: https://patch.msgid.link/20260929094434.77129-2-jouni.hogander@intel.com
(cherry picked from commit bd58f0e221386808cd614bb205112e807dc6b159)
Signed-off-by: Joonas Lahtinen <joonas.lahtinen@linux.intel.com>
[ sashal: Adjusted intel_plane_duplicate_state() context to preserve the existing flags reset instead of the newer fence_id and damage resets. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../gpu/drm/i915/display/intel_atomic_plane.c |  1 +
 drivers/gpu/drm/i915/display/intel_psr.c      | 24 +++++++++----------
 2 files changed, 12 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index 186735b469c5c..4f668cc1d7fb9 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -115,6 +115,7 @@ intel_plane_duplicate_state(struct drm_plane *plane)
 	intel_state->ggtt_vma = NULL;
 	intel_state->dpt_vma = NULL;
 	intel_state->flags = 0;
+	intel_state->psr2_sel_fetch_area = DRM_RECT_INIT(0, 0, 0, 0);
 
 	/* add reference to fb */
 	if (intel_state->hw.fb)
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 97f82949a3a51..d59f2131fd996 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -2579,16 +2579,16 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
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
@@ -2672,7 +2672,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	}
 
 	if (full_update)
-		goto skip_sel_fetch_set_loop;
+		goto skip_su_area_calc;
 
 	intel_psr_apply_su_area_workarounds(crtc_state);
 
@@ -2708,6 +2708,11 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
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
@@ -2724,8 +2729,6 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		inter = crtc_state->psr2_su_area;
 		sel_fetch_area = &new_plane_state->psr2_sel_fetch_area;
 		if (!drm_rect_intersect(&inter, &new_plane_state->uapi.dst)) {
-			sel_fetch_area->y1 = -1;
-			sel_fetch_area->y2 = -1;
 			/*
 			 * if plane sel fetch was previously enabled ->
 			 * disable it
@@ -2765,11 +2768,6 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
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
2.53.0

