Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273003;
	b=aJVa2F09Kh7wqhKb1yFcr5fi5diRWMycoNQsmCgmtS4aepbJFqKyiQX2nSUGy0rhido2
	 1XftFIz0zbQZWWLESmNDkQS7NijKDttKvGuKrHDcuszdL7jC4qXiMbm5r2004UeLnSdNd
	 uLWOKw1TbacW5fumKprMRN2xqOR51qAX2ArzAYlo+4BwhtnTB7ukAbErBFHa7KfEpLUhE
	 38WgPGNcFfEFZkWGn1QBknDuSfe3sgPZyxGC+t2M/vfx1QDK3OqUsm265FLJhuu5AJRcg
	 k3cIBTycPRyaWCbb1860xR9bfS//ThF541KHkTIwi0xTwuoseAR4TO/QHELYb+FC2Mg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273003;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=mkSX1dhvlwItJp/aaXWCqmfYgGgzSDw2sq7dDeT3AR4=;
	b=ueApxtNbCy4nRlQXwCA9ZgGpqRFNLSazR2KyOAjMqivZ8imojqXe5a6P+Ji5bT3zqlOp
	 lHRFu16NulE1eDV3WjYBLYXniHSeZqOtPLQXiNw+UaJ9+lFV2Q3SCDE2eOANNS2ZFYUNd
	 PO904EiUkgnisdYledEAMkz19gxIghwIk9cr9ZI25nhrMKQvkeb7AVtymdjES4gvT8x7T
	 EEdMtS09JE/UlYMfiGu2/eBBPPl6VoKWpf1JfVq+GyOINyg3ZJTyAM41iMwE0kDBHThLG
	 xZJfDZp3SuQeoisUaLxy54Rb9JvIfGvUDeLgB6hSZhFN2vbDK0w1VS7a9EJ7Wr2nvQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d5R08KTm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A93F606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=d5R08KTm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2E661F0089F;
	Tue, 10 Nov 2026 01:10:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273003;
	bh=mkSX1dhvlwItJp/aaXWCqmfYgGgzSDw2sq7dDeT3AR4=;
	h=From:To:Cc:Subject:Date;
	b=d5R08KTmqhvP6nNG7W9havAF6rWMef5bHgnnZFe22Gqv7tffS02xhsxH9zk83RS9B
	 KVDjOwAY6AxZ3Yaphg2408WqQe4Vf/BVry3hD/Nn8JsrXH7vWSYhZklPSFWIdtJyVi
	 jcHqxhvaWG6yLKLgWYk+jlhH9RvthTqT3Mz3WThAWkXMrSFDUiJX5CY3TsSWaDHdk9
	 3muJd9YHyZhI6qBISOWGHACdymK0f5zVCS3C1tdbsTDTdxQDTyyT1/CD3IfK/2IFIP
	 VKurfwPSenDqydlNJPsRsk2SC10cZBgHKtBnHs3N2mUTvaUg7uUAb++njcurdd9wZc
	 RZhZ/IUVqDD8w==
From: Sasha Levin <sashal@kernel.org>
To: mikhail.v.gavrilov@gmail.com,
	jkasten@gmail.com,
	alex.hung@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: set allow_freesync before validating a new stream" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:10:01 -0500
Message-ID: <20261109201001-failed-6.12-ab18dd3061eb@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x ab18dd3061eb2d92e60c8bbf9a435c25962e449f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109201001-failed-6.12-ab18dd3061eb@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




