Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794531735;
	b=ZZtXZ/lTj1mNe7w//cDhyx/zZpnOtphondjQJVMh4lWg4O6X9mrpajiCZwJPMWrnEEkK
	 lYwBRwEYVLSnVNVnkFiT5B1XPTK8U2B2N4tUSZ2ncEZpfdueIGnTkl82AlsPGf22JWp/e
	 UAnWwm4jDSZCcYBwGvF1q0snCXKu8wpOvALylxYq4viZQEltf6k6hgaAbCfiVbOKpK71l
	 rEpWH6tTCEepjiBNi3Po5PapG7YRh2u9KeWU1lObwHjDz87qlHnwEJzJlcKOUIQWj0dQi
	 4DevsrQb7cxZwdBUKtK/Q2ysFG4axXsRM12ERtxcBI0YGwaXIkpYBjJn2lntndCWHIA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794531735;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M2BmOtP3ANGadgNMMoMdvK3Tl4DQVRCEz9+pFP9BABs=;
	b=QdbmKtoim+3dZFHAwytrS0SK73gDgwe9gMaJmKINwn+xueWsepranofNh4pxULs1xM4Q
	 3zYnlVQQIm/MaDf/Om9Zz9l7q96ssi40+8z+63AMUiRPKQyjMimQ5fvmJt9+dEkq8xHNT
	 xgbggL9JGQamqb8AcjrB1dSBiLxjkF+SsTmgsA9Inj2Wx2IzSdM0AjOTtxtAFSGeA7bsU
	 3MFbaNxPM3XznYM+QAwNKQE2+DhgAIkI9I9lPh18Y0cEyiCMBBlwqZcAdc+xhb14bmwdR
	 VeUIi2aWa191WkoqPDj37Ot93qMH57AamBM3rL05YBL5611iYTvAMzNgm7Z0xv8AsDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHWq5Vc2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E84606A884
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 01:02:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YHWq5Vc2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B77E31F000C4;
	Fri, 13 Nov 2026 01:02:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794531735;
	bh=M2BmOtP3ANGadgNMMoMdvK3Tl4DQVRCEz9+pFP9BABs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YHWq5Vc2BPyu1k90gjRfJve0Hq5RFskOM64UJBZ/pK1iQF25rPxC9HujrrNfC4TRb
	 JVi7vX2XqTQzTBRgVcROqXKCBVzpjg5TD/SBCVmgHDj6v4C+6gT5L3Cn2X+QvJGHer
	 jbI/9WzQo66l/O5qYP2Cm0WHiso22OKY7SG0KO079rxSvUgrJYIFUtXcjKPu7IhtL4
	 LliMWx38rFivgzfrrNG+1CGG+0tpVgdc0j/NmWF4vAkmhXXMq60WquU+JV6+Y0VQOQ
	 4zAPwmeEeJ1Rqra1zQPpsMaDATHFCEXYCcXWJFy7waIKWCTENGu7vYYVt4C7NjRg3E
	 iWlJq62VILZaw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>,
	Josh Kasten <jkasten@gmail.com>,
	Alex Hung <alex.hung@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amd/display: set allow_freesync before validating a new stream
Date: Thu, 12 Nov 2026 20:02:13 -0500
Message-ID: <20261113010155.393783-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109201429-failed-6.6-ab18dd3061eb@kernel.org>
References: <20261109201429-failed-6.6-ab18dd3061eb@kernel.org>
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
[ sashal: adjusted context for static get_freesync_config_for_crtc() instead of amdgpu_dm_get_freesync_config_for_crtc() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d79f39dd21ac5..900ded67a55ee 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -9261,6 +9261,14 @@ static void get_freesync_config_for_crtc(
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

