Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793107548;
	b=ARNwBn3v/v8cLbrFJzIaYrfJ4e2v60ukqOqH5WjDzfcLtFDEfrB0ZqCmYLhYgvqAWNK4
	 PlGHCmdPLkJVuY8MkUiQ4ZFAVayIGkHV8LexwuvE4PIiYjGtMb+qUJJrA/Pzlr35ECTT7
	 /UInd3ARkSQ6214rkBcm4+yDbwDq6ua0k9m4njnF45M5kSehi42EJXy4WQLc7vfX0EDOw
	 l8Itwz+zrm8VEtqmHRLn30khQqp+rP4Yvi5xeRvRIORZ6mz0REn75ZZrUSGeLp80EfUwF
	 A4Buk8xfaK2lPIgOkDax1ZIdyu08X0PrcKrAv3OICAXxs4uxuYKYBTCpqNNNBILJaUw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793107548;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=s40smEMW0f5Ma4VaCr4Bts4wYLNWEamsEgEfivrNgUA=;
	b=JGuOlYXiZB8Nq2cFw9vMTphy34/vilNk7D4EsQTbyMrdWFCHD+jUdqTzPEibIQ8griI5
	 s8aLWWd1XDs0RvvJF5BAG2VdnGg5jmSbMcfrtTh9XZhCcxWpqMK+FAmJkALga/0mkQJPS
	 YaCK8gGnCDEETqh9MiE2MjfNFdjn0kiD+cKH500dTxzlTx/ApAhzBthQeVfYs4UkRbyNw
	 rMseSGSxFvMOhKF+o10FPNehcrtzv6QDrmYxQNMrQGPKsR0EtQRamO1YnX9aRL5p4IjMY
	 DOwxZVoGhvznNZ/JRYGe2drg7IDd9xFgjFzI2cw04UhOgzxu+ccO/gLOqm5lWWiGoQA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbbJ3LPo;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ECD606A31B;
	Tue, 27 Oct 2026 13:25:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BbbJ3LPo
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793107547;
	b=bRduIq07ypo9LaZDejjOBol9m/1962dwdsvP2zmkn0maM9GKYItFRO0C5g40KQK/MqF4
	 ppvytMdXQA0LrMJFWLWKQ+L4Fm+wRKNpr9LpFdQfXJrHbfGyxQRiTjg0RGr7XXkkFQLO+
	 wIM4DBor3/D2vRxmAiw2Asn/D1HICEMsO6BK1PVA24kBxDnwItfFxCd5yDuoiTOkY0SYT
	 TsjGzFPnnyzg4fN/MdIAtRwdAjpdWBrASPl1tLFoKCurDnGSXwke5VP15WWlQk5Vj68br
	 EQXCnaWBi9YySm9VaZbdbc77IDcz9/8b80PEE+uujn03KUrKEtrPpTdbZHK+L5Kq70Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793107547;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=s40smEMW0f5Ma4VaCr4Bts4wYLNWEamsEgEfivrNgUA=;
	b=hgyr0aj2dFHNUSxYPqohteKKIfbCkAFMsgB/mTMZW1IeSH8BnamqL1MpYHD6uaVOOSnX
	 NGKZKYa5rgge5Dsjiki1ZjZzGpeInzWDwYBrfbGAYWxpEmS0hpOUQ3STZZBG92JbXS/Q+
	 UDvB+viwu/K7tc1FdiC6nf5DXwQeVlL3zK1QwAwAzN5nixdE8rvw0x2ZYayRVAsjGbZcQ
	 1B6IMstCng0setSkg/XEXxjugJWIb3j3aaC1VHuA6akkUnuyXciaGMjt4nIFXbtT3KtM8
	 8woi5pd4VLOiwXPjZdQTEs20hOvrppdEcnbR1CzMAC+3HajkIf7RAFzuTameD2Bf65Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 0AEA11F031E0;
	Tue, 27 Oct 2026 13:25:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793107547;
	bh=s40smEMW0f5Ma4VaCr4Bts4wYLNWEamsEgEfivrNgUA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BbbJ3LPo2ATptI+PnwR5XkyoUe2k14ajR1X/RiCuKrLj8dKa27ztuHnTjYHOjc8wa
	 ZYnGxImAHPhN/6oZOqMdhke6v9xSIaDOGOyHM/vkdMxCYMRH2UdNIMRo9wiJyLznLf
	 e8p5+knnhYUtWAS72+vpdACH4kZKahmpAsH4GGriteV54FAnpoolv6h4ZrxP+hK/GJ
	 MKATi4cvLcuFdClBhyA4isKFkgmCdEaptxcHvT3KGua/mF0HFVX4DQKqOEc13KZLk9
	 iyB45DNFfJ03EJ+HEL83qYJpNYpP93XJ+nlUMcg4/WQscuAS4pZz1FVUz91zMZrqHr
	 OyGL2TRU1CEKw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 766D1450DA;
	Tue, 27 Oct 2026 13:25:46 +0000 (UTC)
From: Davey Hughes via B4 Relay <devnull+davidralphhughes.gmail.com@kernel.org>
Date: Tue, 27 Oct 2026 06:25:42 -0700
Subject: [PATCH 1/2] drm/amd/display: Keep FreeSync flip timing across
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
Message-Id: <20261027-freesync-plane-reset-time-v1-1-bb43b501faf4@gmail.com>
References: <20261027-freesync-plane-reset-time-v1-0-bb43b501faf4@gmail.com>
In-Reply-To: <20261027-freesync-plane-reset-time-v1-0-bb43b501faf4@gmail.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793107546; l=2469;
 i=davidralphhughes@gmail.com; s=20261027; h=from:subject:message-id;
 bh=w8smsIu+a5d74TM+0w5js6HnzbIYeWoiUunZBo70U9A=;
 b=XuQhEr5d/ly0qNmqbPSFTSRSyE921S+L8DE/BhEQghgfzDXAh6up4MrcGTnI84ugUZDc7qI6u
 uC8VuTaDBF+AwvtgkFbXTH28q9/Ynmh+1D0ZsIeGqEPvBlIcBe66sCF
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
itself as the last render time: the uptime modulo about 71.6 minutes.

On a panel with below-the-range compensation (BTR), that engages BTR and
pins the frame time at the BTR mid-point (13.447 ms on a 48-165 Hz
panel). A panel without BTR (max refresh below twice the min) goes
through the fixed refresh path instead and locks to its max refresh
after six frames.

It takes a reset on every flip to keep the panel there, and color
management changes reset the plane. DRM sets color_mgmt_changed whenever
a color property is given a different blob, even one with the same
contents, and KWin with HDR enabled and its color accuracy setting at
"Prefer efficiency" sets a new GAMMA_LUT blob on every commit. Plane
resets for CRTC color changes, added by
commit 7316c4ad2996 ("drm/amd/display: Reset planes for color management
changes"), and later for plane color properties and colorops, made this
reachable on every flip.

Copy the flip timing from the old DC plane into the new one when the
plane stays on the same CRTC. This covers both the BTR and the fixed
refresh path. A plane that is newly enabled or moved to another CRTC
still starts without history.

Fixes: 180db303ff46 ("drm/amd/display: Add below the range support for FreeSync")
Cc: stable@vger.kernel.org
Signed-off-by: Davey Hughes <davidralphhughes@gmail.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index bdabb4bf14da..a69e28685857 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -6076,6 +6076,11 @@ dm_update_plane_state(struct dc *dc,
 			goto out;
 		}
 
+		/* FreeSync times each frame from the plane's previous flip. */
+		if (dm_old_plane_state->dc_state &&
+		    old_plane_crtc == new_plane_crtc)
+			dc_new_plane_state->time = dm_old_plane_state->dc_state->time;
+
 		drm_dbg_atomic(new_plane_crtc->dev, "Enabling DRM plane: %d on DRM crtc %d\n",
 				 plane->base.id, new_plane_crtc->base.id);
 

-- 
2.56.0


