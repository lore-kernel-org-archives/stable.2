Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794529481;
	b=DLJfM5TGGZ3lwjM8YwQqkrKNLl69OAhHY7DvaFjvYYGqsdWUi27gWO7aXlssHlXKNMTW
	 WglPcitihu0dnVbiUJ/964MsbPA6cC7KibWFXtvkm5Lk50DxldibhUoOUSAc5xezGcJ5G
	 p6NNuemCgGBOUHf9U4AjD8nDEbQZnlM7oVT1yC15Xc/CDUE1OJxd8LHk3jFnw9OM1/nmA
	 v2FI7Lav5vH8k9gi1o6Z3GbOqWpdqjpqeIBHArTraVYynOF5HW0AIp+BExue1W0HcHr+Z
	 58+HyZBNK8bYM5Spi+SbM0i+PCZF1KGKz47eGDcjkMyGan7DS7nHaqhgjYbPKgWVDNw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794529481;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=iDvo45XtR/03MKjKU9sPic5faZhmL779mX0u+RM70to=;
	b=RCm3I7ZSEDgcFt6i6qZPKJ8/Pb5Hw+5PevUl9GBZjYNqLJoHVfJGAOJrqg6QzROMqfz/
	 YQJe0GdTZ8I1l/+KZV+UV0CP6J+7U0wHMRRaF3/a0RVZ4dU0AJhauAmFxGyBRBpYmcP+J
	 jHqYg6tJ40UpQu5Rj7m0VsNBATZC2m4YYFOgikWKQ4KB9x2w+obEzv9rz3d6yxREfhtZ1
	 LgPui/nPJkhXtFgBEo3Y3htXvBJszJmr0X85mOs7XBEaOwUT2nnClmw/Go2C1DbEqYPif
	 yuSmqJb3/3AShkidFX2egmquORBopVyo+2GnXiOKt8JvftpcDZZfd6Q4FFjKie3VSHQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESUNRiyu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4E5D9606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 00:24:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ESUNRiyu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4ED121F000C5;
	Fri, 13 Nov 2026 00:24:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794529481;
	bh=iDvo45XtR/03MKjKU9sPic5faZhmL779mX0u+RM70to=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ESUNRiyulY9zLi65jW5jBOIrlNeRemEB9wIy0lugQWPBWTo1tI9V+YRZcK8LC3RcI
	 1nquaeU/bz6Ne+Q9NAnqMW0liZ99Z9Sykr4yzR8mnb6ElLTWsX+5g5DoZ4dc5MJnA9
	 KAbr250SDo41BwRgoo/3KKLVIeGy8TzgV7N+nOOe5M8UPFdqN1DmNZRzDWrFsyk1s9
	 SsqgFIJqLUGdwsTCPpHJ8aPDdcACzrRrc5f/ntTysWbZmbeveEfNc1R0FHbH8fR4n6
	 FEEX9fW+k+TF6PtxMOIYrwo1Za7WibU/BWZoM3BGau+570gM9v4ynvgow2rnKlfsgz
	 NdnJiNxSxf2kQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Josh Kasten <jkasten@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amd/display: set allow_freesync before validating a new stream
Date: Thu, 12 Nov 2026 19:24:38 -0500
Message-ID: <20261113002422.388626-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201001-failed-6.12-ab18dd3061eb@kernel.org>
References: <20261109201001-failed-6.12-ab18dd3061eb@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>

[ Upstream commit ab18dd3061eb2d92e60c8bbf9a435c25962e449f ]

After resume from S3, DC enables SubVP on a single FreeSync display at
a high refresh rate, although dcn32_allow_subvp_high_refresh_rate() is
meant to keep SubVP off that configuration ("For single display cases,
freesync must be disabled").  On an RX 7900 XTX driving a FreeSync TV
at 3840x2160@120, amdgpu_dm_capabilities reports sub-viewport disabled
after boot and enabled after "rtcwake -m mem", and the memory clock
starts switching.  It stays that way until a later commit re-validates
the state; a CRTC gamma change (toggling Night Light) turns SubVP off
again.

The policy reads dc_stream_state::allow_freesync while the new state
is validated, but amdgpu_dm sets that field only in
amdgpu_dm_update_freesync_state_on_stream(), on the first flip after
the commit.  A stream created by a modeset is therefore validated as
if FreeSync were off.  On resume, dm_destroy_cached_state() drops the
streams and forces a modeset, so the resumed state is validated
without FreeSync.

Set allow_freesync in amdgpu_dm_get_freesync_config_for_crtc(), which
atomic check calls for every active CRTC and which already writes
ignore_msa_timing_param to the stream.  It uses vrr_supported, the
condition the flip-time value is derived from.  With this change the
same TV keeps SubVP disabled across "rtcwake -m mem".

On this machine SubVP is also what exposes the single-frame scanout
corruption reported in the thread linked below, so the FreeSync
setting stopped working as a workaround after every suspend.

Fixes: 87f0c16e0eeb ("drm/amd/display: Enable SubVP for high refresh rate displays")
Link: https://lore.kernel.org/all/20260829010525.29935-1-mikhail.v.gavrilov@gmail.com/
Link: https://gitlab.freedesktop.org/drm/amd/-/work_items/5714#note_3736349
Tested-by: Josh Kasten <jkasten@gmail.com>
Signed-off-by: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 29793918b0eb63b6810b248a906f87dd79b70be5)
Cc: stable@vger.kernel.org
[ sashal: adapted the change to get_freesync_config_for_crtc() instead of amdgpu_dm_get_freesync_config_for_crtc() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 305a9fe006de4..175cf9e1a24e7 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10546,6 +10546,14 @@ static void get_freesync_config_for_crtc(
 					vrefresh >= aconnector->min_vfreq &&
 					vrefresh <= aconnector->max_vfreq;
 
+	/*
+	 * DC reads allow_freesync while validating the new state, for example
+	 * to keep SubVP off a single FreeSync display, but it is otherwise set
+	 * only on the first flip after the commit.  Set it here, so that a
+	 * stream created by this commit is not validated without it.
+	 */
+	new_crtc_state->stream->allow_freesync = new_crtc_state->vrr_supported;
+
 	if (new_crtc_state->vrr_supported) {
 		new_crtc_state->stream->ignore_msa_timing_param = true;
 		fs_vid_mode = new_crtc_state->freesync_config.state == VRR_STATE_ACTIVE_FIXED;
-- 
2.53.0

