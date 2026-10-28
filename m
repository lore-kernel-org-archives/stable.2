Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793228059;
	b=v350+2yxNTRXkfiviqic9a1ILn3jkmIoYUfn6pI+UJ2Rpk4mq3FzAk0NoraHavgzwD5T
	 ZWYY1ft84MCE+C6zZsHhBC4GV9FmMJuFxl5jG3/uaqbyfd9vvBvTTx4mLBAA6ikC1qRqZ
	 xdi1OA/GBiTwbkbyKnTml2aPJwMxwBuqNTExjMimC+6P35hjZ1mQsT8vS6SZkmlwnGwty
	 eNjV0Orvu48nVhlBC2zBOcrYl24OJfzGeLTwHxxHhR6xl27fHr5V7DD2mQPy8zQt3N6NQ
	 v1EgsLKNyjIygvYpVuZSLWZnFVYRqyWJMtHU4SlkIrLUyJcjSffQcSnu0FPqeq4Dp3Q==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793228059;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Uq+/t+HMdlaXNj5J1t80Jzrv51On5WqbU4UwEvAO3Xk=;
	b=vLliubn3MYXvvWsNSuXtKKW0Q/IcOsK4eanQr6tiU871EksKO/X/vpkvl4TIY/w+IgR0
	 NAbJGxuUbL3kAtfudW5heOpbEgx7EwiLPsJKxhfxGz0jUoP/65jkHuq1jCYnLGAnBSlqu
	 plYbwBfFMLv/0Sb96JCHHJnjOxOhbz9MlA2gigbHHFOfoE7fp4U7IsqKk7oKsybe4K29O
	 8njUOSW8ZQESDfB7WM/AUkQDeMkZdD4BCVkb+IDnn4aEV84zWpOXpEWGwJcAD99bAHbe9
	 50+VNozPX1byC2ALgeD8xM6HUb96/SJUGwyNrAbA3MiLpqDlpn/90QwuWmf20WL7Z/w==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4jjRSzV;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 150CB606A339;
	Wed, 28 Oct 2026 22:54:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V4jjRSzV
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793228058;
	b=eSVk+012Bf233/qoNBE4RNk8GmzrOx0nUXzb4gvFp2VefY/ECO/mH5e0xM7d7InC7tj7
	 pKaTRpcSFkHfiQYfasqkShJqohNObVlLE24Py0tm8UgJ/5HEdkaOyjRCFXmNiAbR6qy2D
	 bsNe+ZtZwUln1CknVr+3RFyt7gIUumsQYL9dYvy4qI400V9gyMcwwROEUYrLE1xXkGOrj
	 QZoHEqyvjTMKDypxv61GHh5ymm6WwOdX5ExmFEFOyIVgEok/oq1VtOlOnQBwBdImOoLVS
	 AtDsIPZeeBq+o0jBqssNXrZedAjrMs8CJPbkhWzCB1ZYlcNm4DJNMHF+PEJpSqV4o+g==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793228058;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=Uq+/t+HMdlaXNj5J1t80Jzrv51On5WqbU4UwEvAO3Xk=;
	b=nLBxnFe0cR76ufwTVzoCXNooUbWVGdKFswPj7vl3fVDycUCxvJJv92W5yNt06Pab8Y2T
	 KDyQadryd74iu4BowSVJOdKBtn/l0rpTMRCy3aYewmGyvHDbw7yAGh+q5Os0rEnyapIpJ
	 pLOCHVHRj0XrusvbZyjUGZtAc2+4Opv/vJItv4Kaj3JV7Aq3Ru8P9WQDHYH3js4pOVzzz
	 M8f56eJtkPQZR8CYOAS9J1PVy40tRG08Ikw+E40BMk20mdtCVzx6yCNIaGCQ3O72A5HzA
	 C8iJaRR+m+DVe7uE3CLcFltA5BvIiFphyppzi31BV9x/WZPgfAf4jcejet4KH6h6jPg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 2A45A1F01825;
	Wed, 28 Oct 2026 22:54:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793228058;
	bh=Uq+/t+HMdlaXNj5J1t80Jzrv51On5WqbU4UwEvAO3Xk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=V4jjRSzVm0oHhIh57B+DhbjJt7l8MAUAZfdKMcrF7c+2A9oDyXFt8fGV2jlp6Y0OU
	 q78SFZ8R7fbjtOlRWOzT93N7yXKnk+jKaVag9e0yHkQ9YG/hLmv/rMLZylqGHJm8pB
	 eD6oHhi2lJGnXUc3z7XdnWjUu5hX1CJ1NXerTZvpxOmiGp/4ltBhozgAAHeAZQVZyC
	 n3MXSdTNw0b/m/OELzP0vQH/VYVD4frDa9Vgiis7EzfcBfWhQ2zF1Whm2eJ0tkhJUx
	 kM46Bw5bus8KKZdrGIduT08V3qB16B6D0Gf0dMwlc6HXdQbTUZiGBysL7Ou5UrkR9Y
	 U9iEh5cH7CXYQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B22C1455F6;
	Wed, 28 Oct 2026 22:54:15 +0000 (UTC)
From: Davey Hughes via B4 Relay <devnull+davidralphhughes.gmail.com@kernel.org>
Date: Wed, 28 Oct 2026 15:54:12 -0700
Subject: [PATCH v2 1/2] drm/amd/display: Keep FreeSync flip timing across
 plane resets
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261028-freesync-plane-reset-time-v2-1-545a0f9b17df@gmail.com>
References: <20261028-freesync-plane-reset-time-v2-0-545a0f9b17df@gmail.com>
In-Reply-To: <20261028-freesync-plane-reset-time-v2-0-545a0f9b17df@gmail.com>
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Nicholas Kazlauskas <nicholas.kazlauskas@amd.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Davey Hughes <davidralphhughes@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793228055; l=3815;
 i=davidralphhughes@gmail.com; s=20261027; h=from:subject:message-id;
 bh=ja1BU9fsikeUf2TrYBZm4ugZRVrlmO4LmC6UBmc9kCU=;
 b=52jaZa7nAksrfqKCubKGFlIUTkSLslZ6JnrdzNfxz6/3Qjdx5UpHTyZGX4OcaDH7Zw/LHJiec
 gpzq4JEvxlXCJULbSWWJFPyJtD7xc+7qHezEzh52Gqmc7e+OULF6kcd
X-Developer-Key: i=davidralphhughes@gmail.com; a=ed25519;
 pk=y45yWVxpjjxFE2cXy96fGlXLfDlt6UKHFHS5szhrFAs=
X-Endpoint-Received: by B4 Relay for davidralphhughes@gmail.com/20261027
 with auth_id=1335
X-Original-From: Davey Hughes <davidralphhughes@gmail.com>
Reply-To: davidralphhughes@gmail.com
Content-Transfer-Encoding: 7bit

From: Davey Hughes <davidralphhughes@gmail.com>

dm_update_plane_state() replaces the DC plane with a newly allocated one
whenever the plane is reset. The new plane's flip timing is zero, and
mod_freesync_handle_preflip() runs before DC stores the new plane's
first flip timestamp, so FreeSync takes the 32-bit microsecond timestamp
itself as the last render time: the monotonic clock modulo about 71.6
minutes.

On a panel with below-the-range compensation (BTR), that engages BTR and
pins the frame time at the BTR mid-point (13.447 ms on a 48-165 Hz
panel). A panel without BTR (max refresh below twice the min) goes
through the fixed refresh path instead and locks to its max refresh
after six frames.

It takes a reset on every flip to keep the panel there, and color
management changes reset the plane. DRM sets color_mgmt_changed whenever
a color property is given a different blob, even one with the same
contents, and KWin 6.8.1 with HDR enabled and its color accuracy setting
at "Prefer efficiency" sets a new GAMMA_LUT blob on every commit
(current KWin master no longer does). Plane resets for CRTC color
changes, added by
commit 7316c4ad2996 ("drm/amd/display: Reset planes for color management
changes"), and later for plane color properties and colorops, made this
reachable on every flip.

Copy the flip timing from the old DC plane into the new one when the
plane stays on the same CRTC. Do it in amdgpu_dm_commit_planes() before
the preflip, after drm_atomic_helper_wait_for_dependencies() has waited
for the previous commit, so the copy holds that commit's flip and does
not race with DC writing it. This covers both the BTR and the fixed
refresh path. A plane that is newly enabled or moved to another CRTC
still starts without history.

Fixes: 180db303ff46 ("drm/amd/display: Add below the range support for FreeSync")
Cc: stable@vger.kernel.org
Signed-off-by: Davey Hughes <davidralphhughes@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bdabb4bf14da..7a0afe6d1b8a 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -3848,6 +3848,25 @@ STATIC_IFN_KUNIT void dm_arm_vblank_event_pre_programming(struct amdgpu_crtc *ac
 }
 EXPORT_IF_KUNIT(dm_arm_vblank_event_pre_programming);
 
+/*
+ * FreeSync times each frame from the plane's previous flip, and a plane
+ * reset gives the new DC plane zeroed flip timing, so copy it over. Do
+ * this at commit time, not in atomic check: by then the previous commit
+ * has finished writing it.
+ */
+static void
+dm_plane_inherit_flip_time(struct dc_plane_state *dc_plane_state,
+			   struct drm_plane_state *old_plane_state,
+			   struct drm_plane_state *new_plane_state)
+{
+	struct dc_plane_state *old_dc_plane_state =
+		to_dm_plane_state(old_plane_state)->dc_state;
+
+	if (old_dc_plane_state && old_dc_plane_state != dc_plane_state &&
+	    old_plane_state->crtc == new_plane_state->crtc)
+		dc_plane_state->time = old_dc_plane_state->time;
+}
+
 static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 				    struct drm_device *dev,
 				    struct amdgpu_display_manager *dm,
@@ -3952,6 +3971,9 @@ static void amdgpu_dm_commit_planes(struct drm_atomic_commit *state,
 		if (!dc_plane)
 			continue;
 
+		dm_plane_inherit_flip_time(dc_plane, old_plane_state,
+					   new_plane_state);
+
 		bundle->surface_updates[planes_count].surface = dc_plane;
 		if (new_pcrtc_state->color_mgmt_changed || new_plane_state->color_mgmt_changed) {
 			bundle->surface_updates[planes_count].gamma = &dc_plane->gamma_correction;

-- 
2.56.0


