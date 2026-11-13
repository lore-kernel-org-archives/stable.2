Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794600153;
	b=I5IVwDq8WxIpV2ykJXXMnXDfrss8B5HhRYbuS1QZXVgaoRTtgyuV3TbZyU8UbqXch0ci
	 ltASVYgVrKTgqWG8rIDs2/zf0fZwFRwMKomt55vvJ+ItL17GwfmW2ANeelWBRc2nAgrgO
	 CCUXw3BZ1UR6gLUt7kGqvkTyh6g1yD8OxKrfs60CHG60Jbxh+SZmpPx5R9o6UBpHyACpC
	 sbb+OSfxI4NcLZUGo+DGXO9FfJ1bThODj13NmqGqQkur2keQ+0brfMlIH8FEE4PhPhu6L
	 3HboFkBadaaqaTHTjSEtfUZnfj099mTdyZ3ecehM8dhkOK9C08Orvku7tLq6vNH0yAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794600153;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=+9BAm9KEozZcKwRh1MKHm65zDmV868aB8vdNS2BE6dc=;
	b=4eRcWPtyJLbgx37OSaUXro0H5bnYQrSVuZmt1avnK60cYZ1OJJHTMx8kyAtBgsxG/ODC
	 8krXIRY/ENwLek+YVfB56w4Dfo4KzLJQBujM0kiGikWUx/HBf8Bp5b1hs7LUAafehavrB
	 VQIn+rlP5q4qHF1F8g4W79g4+crxpeB7p6CfqVYeThowDazgfBG0UsBqjWICFGcHP/Ipe
	 A3NkMF3iHdZw1ff5z08rxMGNIMEfr6xakXaNDH6FZQ555amHj7uEbgqoIqzuUn2mW7BOR
	 BEQScf221PEAZi/K4FmUri+Cg99bLEAiqNawu6yrMKVWkROcmPYeCaHdA3kGPvfjNBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jc4ZAj+L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FFF8606A330
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 20:02:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jc4ZAj+L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6F11F000C6;
	Fri, 13 Nov 2026 20:02:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794600153;
	bh=+9BAm9KEozZcKwRh1MKHm65zDmV868aB8vdNS2BE6dc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jc4ZAj+LmTjnY/RowmGXkoGHIW47Vid9jTPb34InTypv84j36VZlkcCuLy4yRwPMo
	 2Ks1p7zU30awImwhBlUGgGRUGrHpMDp1JQevpFG8b3qN7rSSoi2NjLkyo4OxJlkp8Q
	 L4z1aObPbYckZBmxw0zC6UQ8Nws9kliOyN1IItdA9dTV58sV5+S1QQjt6QDWDbV6BB
	 i6T9dTt+cAIqabN8cmuZ+qDfFxz6tBVrh+K8UjCIcT9yr+7gQ2mOa3Dn6emmLH0rMx
	 iRvkOJiUuncoPTvYe3Ohl1EavTT3HxQ8v5OWGf+BsVKcznsqZ0nIwQBilgFwz2Mz6n
	 vBl2o9ozDdfbQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Jouni=20H=C3=B6gander?= <jouni.hogander@intel.com>,
	Mika Kahola <mika.kahola@intel.com>,
	Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/i915/psr: Clear selective fetch area when duplicating plane state
Date: Fri, 13 Nov 2026 15:02:31 -0500
Message-ID: <20261113200154.2429212-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201540-failed-6.1-cbe565475988@kernel.org>
References: <20261109201540-failed-6.1-cbe565475988@kernel.org>
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
[ sashal: adapted clip_area_update() to use local pipe_clip instead of crtc_state->psr2_su_area ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/i915/display/intel_atomic_plane.c | 1 +
 drivers/gpu/drm/i915/display/intel_psr.c          | 9 ++++++---
 2 files changed, 7 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/i915/display/intel_atomic_plane.c b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
index 82826454b5e83..b54d3d05a787d 100644
--- a/drivers/gpu/drm/i915/display/intel_atomic_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_atomic_plane.c
@@ -109,6 +109,7 @@ intel_plane_duplicate_state(struct drm_plane *plane)
 	intel_state->ggtt_vma = NULL;
 	intel_state->dpt_vma = NULL;
 	intel_state->flags = 0;
+	intel_state->psr2_sel_fetch_area = DRM_RECT_INIT(0, 0, 0, 0);
 
 	/* add reference to fb */
 	if (intel_state->hw.fb)
diff --git a/drivers/gpu/drm/i915/display/intel_psr.c b/drivers/gpu/drm/i915/display/intel_psr.c
index 3c5553b21fa89..6839b8fd61aef 100644
--- a/drivers/gpu/drm/i915/display/intel_psr.c
+++ b/drivers/gpu/drm/i915/display/intel_psr.c
@@ -1807,7 +1807,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 
 	if (!psr2_sel_fetch_pipe_state_supported(crtc_state)) {
 		full_update = true;
-		goto skip_sel_fetch_set_loop;
+		goto skip_su_area_calc;
 	}
 
 	/*
@@ -1893,7 +1893,7 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 	}
 
 	if (full_update)
-		goto skip_sel_fetch_set_loop;
+		goto skip_su_area_calc;
 
 	ret = drm_atomic_add_affected_planes(&state->base, &crtc->base);
 	if (ret)
@@ -1901,6 +1901,10 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 
 	intel_psr2_sel_fetch_pipe_alignment(crtc_state, &pipe_clip);
 
+skip_su_area_calc:
+	if (full_update)
+		clip_area_update(&pipe_clip, &display_area, &display_area);
+
 	/*
 	 * Now that we have the pipe damaged area check if it intersect with
 	 * every plane, if it does set the plane selective fetch area.
@@ -1947,7 +1951,6 @@ int intel_psr2_sel_fetch_update(struct intel_atomic_state *state,
 		}
 	}
 
-skip_sel_fetch_set_loop:
 	psr2_man_trk_ctl_calc(crtc_state, &pipe_clip, full_update);
 	return 0;
 }
-- 
2.53.0

