Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794528260;
	b=f+ecTCtHj90w4fgXCprKaQQv1g+68cJ/0u8irfW3hwmUZILNXAVeRHBPh67c1S8g17PZ
	 rn+nqvxuvsWdA7VV7orszag36gw6HyCUmwhqLPprqhOBBBbej9eItechQRb0BRN2OK/37
	 ejkDlDbebZaR6uC7IUQ7Vn+Evr6YYrH9d+sS8TcUrgfJCUPcYcIysRPInDsxTtKr2Lsc9
	 9HuZOlUryzcFu4zn6OA9F2dE4qGay9eMjn725mRFqO2E77oAybX/GX1/SqhEFRnGsNz47
	 ecnm69JB2j8wcj2ymVHa8eCs7Vy5g1Gn8MvzqvUFdwrUMToqtCo21THtsM2WZ6FY3sg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794528260;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=VZpv1pGq+lxVOAUP64fDNHO4Cm6z4TvVin9dA2cjpZw=;
	b=ZpUXC/Z15JKQ1lhf8KvEG92K7llV8TVdnerbmuMFv4D0KOy4lkSrnlNEl285JV7/uU1O
	 385dp3Z29plTUmpKZreUMTuEO0ymId9HVDNGCxnA3febP2aXYDYViSKcUn2p+WQZ1V2+l
	 E3DxdrlK+ajejkD8qyat1964KgWpTreszgtNkgwygZLxxxggEMZtvrTGoo5Vn+2JGlAEA
	 12WD1A8+jzDYtrvT5rZmVyRV5MfzqJBuItEAHDMhXd8JTAe8x2ta4NzrEKWids6zC0gsv
	 mZm/3Sns0SoLw4MbmUuMycqJqSNF5nStq1GBhZLkdpFgqtcRVLvvOytoDK4A61Vzi6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiLEaxpM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CE55B606A31C
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 00:04:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CiLEaxpM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB2881F000C4;
	Fri, 13 Nov 2026 00:04:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794528260;
	bh=VZpv1pGq+lxVOAUP64fDNHO4Cm6z4TvVin9dA2cjpZw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CiLEaxpM7BIen2POarltgMHfc4hP+CXrTOkvU60OdW1pNQa60XS01JmlDuOLchqNs
	 dqK3YT4t/oYBPw3TMlk5mirVpFA/+xUTBIa1c9HJyRbasKbP6XM41kRS7YC32H3GwS
	 9+TChsReHWG07cWSAVWnpZCcctT02dDz+8TwlHgFXuDlVQfUm7fWrRFy3T64GBfNe8
	 Yzg+ChtHgvU11mb6wC+F1+Y0KYFFPFb7DMShuj0aBMmigDNAxN1gIz6OTj6PctgneJ
	 CXJz54oXpRY3PGKU/7+tiiNRMUWh1mANxfYzDmuyCMGuZrgn6l72yDhQ8kZnZ9AazX
	 iN3Td8JDko8eQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Josh Kasten <jkasten@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amd/display: set allow_freesync before validating a new stream
Date: Thu, 12 Nov 2026 19:04:18 -0500
Message-ID: <20261113000404.382174-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109200542-failed-6.18-ab18dd3061eb@kernel.org>
References: <20261109200542-failed-6.18-ab18dd3061eb@kernel.org>
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
[ sashal: Applied the unchanged addition to get_freesync_config_for_crtc(), since the FreeSync helper extraction and renaming are absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index a77b55ff9321f..40ac1a33326fa 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -11350,6 +11350,14 @@ static void get_freesync_config_for_crtc(
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

