Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273271;
	b=vUynGbS2DzQtSijCqOhzuD5dz6pVWVe6TRTpbvJsHAO4ffXv6JMAbDjdLRoplYtWLJW0
	 kcD3KmYRM0kvafhTwn3Vyt2mDV5acKJ8l/ehLaVOH6w+kVTaa9kuESh0UeiIXghCPiEaM
	 3pR0J/obZn8BP6epvh9KRZeuLjoci6SPRrStW10u1DtKPql3nbn703vbC0tKC0Reje74t
	 frWjv+KC7V2GAw6Vt4YTHJY/fZdUdSIlPu3Vnd9dv/7zuZXEBnW/Xb8ouls9ge5vI+Tzm
	 hV5PdfHBLSBc7BN2oQns6rLBdnJtpt19ElFWptorMDY7Ub1ErIlbQBghrDdwpmEPJrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273271;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=iCG8s68llaHJz57n4/GRJpfGkn+UfXWBawRjJg5Ub88=;
	b=q+6yJ6B6mgW/p7PFyEzXyWcTHGhjFXS5VFe6VOgXMcQGcGxFrzn45TEUxrja1OoKRI7S
	 q47qbfmAfgtXjD2ChYXgfKJYToWIAE+dgjadop7zR9o/Jy+d2ay5d8tOYImiTy8WApQLD
	 kWlbNsVgm/3/lEv8EzoFZbYyL5DM1CfAx4YSpfj7OPoESAfS53frM7yDCshNEsDtQn+0k
	 xGI7V7nsS10GGIiOfv7iD7QZ192PZspnqR61C7cKalVZaN4kl2g+h9iURIzLozI+pzGjw
	 hVLO9PoTSngID87IiVUI9qwgJprcYJVX6i55SwfPnCk1lTKNFrRv7xoivwUyI169t9w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZj3WMVI;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 00FD9606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:14:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PZj3WMVI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C3F71F0089F;
	Tue, 10 Nov 2026 01:14:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273270;
	bh=iCG8s68llaHJz57n4/GRJpfGkn+UfXWBawRjJg5Ub88=;
	h=From:To:Cc:Subject:Date;
	b=PZj3WMVI6VbvWcq1P1oA+5ffXs5SKH/Hp6vrr4Cg3c/pdPQf7RrgvxzcKnT8GCK5N
	 QO02rEcoPur2bPK+seMQBRNinlQ11tOi/8J5vMwmrZhjlMFhYlvB/zT3p5pCBrwgnJ
	 1luXMYpQPDKR9TtpaaWwvcXNO2uwVO6/tlFjZsX95VjhJx1nPeKmJ9CX8224pJ3TNi
	 p7grJrvyWICKcAtEii4yhWTBst29U45HHaaJClIhNgjtv1blCl7J8pViUeF3fOrr0s
	 pXkQqz3cfWo+IemjQuCbArioEXaJRZvUxfIGSmLSp/xrCDM+gUtH116ebU8igdEbHb
	 LdHUuJig6pQ3Q==
From: Sasha Levin <sashal@kernel.org>
To: mikhail.v.gavrilov@gmail.com,
	jkasten@gmail.com,
	alex.hung@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: set allow_freesync before validating a new stream" failed to apply to 6.6-stable tree
Date: Mon,  9 Nov 2026 20:14:29 -0500
Message-ID: <20261109201429-failed-6.6-ab18dd3061eb@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x ab18dd3061eb2d92e60c8bbf9a435c25962e449f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201429-failed-6.6-ab18dd3061eb@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From ab18dd3061eb2d92e60c8bbf9a435c25962e449f Mon Sep 17 00:00:00 2001
From: Mikhail Gavrilov <mikhail.v.gavrilov@gmail.com>
Date: Mon, 26 Oct 2026 12:33:45 +0500
Subject: [PATCH] drm/amd/display: set allow_freesync before validating a new
 stream

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
---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c    | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
index ab9cfbce8d73c..4620135437c5e 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_freesync.c
@@ -131,6 +131,14 @@ void amdgpu_dm_get_freesync_config_for_crtc(
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




