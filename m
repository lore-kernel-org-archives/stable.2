Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272742;
	b=2pjUOd0pRHGIn/604qPK/03/sf3K6QYfW9Mv4lxhrFnhANymMZ13ncALp5ztzQ5Vkjcs
	 fajFScguK2/Q7zZI+ehnv3M3tInyXzDgcjzHUF9b7Gih73fqNI8NothlC94Z/qwKc5xRR
	 9sli7XOekRnMuWq5EOwMWweaJaq+D6YVF4EF2BV94pQ72r7ZjgCGsjc3nMPL+L7DoE3Vy
	 nR+nHGzQnPJufEzaAjb3UMdap/klHBxFtzhQ//VNkRDDquiDy4cmEUjJrLQYaDNDe7ra/
	 u7sssqWQdWCC2CyxrPA96nin4jWA8zvsAyWAxElstCFmU2snR0VtGVhdq7FEqkanIcQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272742;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=+mB2bo0Xg8sUUs99dY3sAkRURS58sVP+QI8hHwdCSGc=;
	b=gwb+1zV91nlfTbS/9xndEGTbRvaqsHTJOBn9gt81FJWLb99YXEZ+9rnlhMDOnuN4Hn0Z
	 sZCUzejwFJpxJBICRMDsa/l71SZtfp7E5UKjAW+YUoDIKjWl1rllLZ7Q8jUyKOhBUjMrJ
	 lf9WwjLw/uTGgzxeWtOpg1RocAOLVlZcc761+4N+FYkzqH+Iw47CcSMg5Gpo9wkN5rt3w
	 okUadbcWnqZ2fnNUDCOc3SP7x2/XrCeAJ43ykjyxqlOSRRVgnYO2DtMERBx+25zFAuCgD
	 BixaBD43F63kytsRRg668l2LoS4UWKP+TSzTYZEmO+OfO50TS3QtK7hzF1T7Am8Fa2w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMt0ymjn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F636606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:05:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YMt0ymjn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3D8E1F008A1;
	Tue, 10 Nov 2026 01:05:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272741;
	bh=+mB2bo0Xg8sUUs99dY3sAkRURS58sVP+QI8hHwdCSGc=;
	h=From:To:Cc:Subject:Date;
	b=YMt0ymjnjHsmXqKwdP+pVBt8vmSmY9I93A0vr+8xGFDQkovrxU90Em6K27NM8WCWE
	 UdsnjQYYsZ/fGhE3owfSJPb4w+VY7tPVJRXtaXMNN8yvOMFZIEZO0gFf4O2osl/k9t
	 tf4qdXOl9lrUJoPOI/+Q6fqupXRjfyJmjsRrf+DUEmrZJ5akIl9zeWUs9nQnUoR1Z5
	 65xIbWbWDaCpZb83kzYVrRGVOXdiguEdszHweH5JFMyAKV9Z6yt307NDt669FonK5R
	 Th+lrtWry52EKgLN4XDixGcPdcpe8q2ezyOZHMSLEjxtIXSp2eYOmtiUhYYTjkKmxx
	 /MKrENZCnXBQg==
From: Sasha Levin <sashal@kernel.org>
To: roman.li@amd.com,
	dillon.varone@amd.com,
	mario.limonciello@amd.com,
	alexander.deucher@amd.com,
	alex.hung@amd.com,
	daniel.wheeler@amd.com,
	sunpeng.li@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: Reset DET of HUBPs without a plane before outstanding updates" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:05:39 -0500
Message-ID: <20261109200539-failed-6.18-f3afbf7d832a@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x f3afbf7d832ab138655afc96bd42226775d03ce7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200539-failed-6.18-f3afbf7d832a@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From f3afbf7d832ab138655afc96bd42226775d03ce7 Mon Sep 17 00:00:00 2001
From: Roman Li <Roman.Li@amd.com>
Date: Tue, 27 Oct 2026 17:17:10 -0600
Subject: [PATCH] drm/amd/display: Reset DET of HUBPs without a plane before
 outstanding updates

[WHY]
DC asserts with:
WARNING: dc/hubbub/dcn401/dcn401_hubbub.c at dcn401_program_compbuf_segments
Call Trace:
<TASK>
dcn401_program_outstanding_updates+0x36/0x60 [amdgpu]
hwss_process_outstanding_hw_updates+0x33/0x40 [amdgpu]
commit_planes_for_stream+0x171f/0x1ff0 [amdgpu]
dc_update_state_execute+0xaa/0x170 [amdgpu]
dc_update_planes_and_stream+0x42/0x70 [amdgpu]
amdgpu_dm_atomic_commit_tail+0x16a9/0x4020 [amdgpu]
commit_tail+0xc3/0x1b0 [drm_kms_helper]

The DET left by the VBIOS on a HUBP without a plane can be larger than
the DET planned for the new state. The compbuf is sized for the planned
DET, so DET + compbuf can exceed the CRB size. Programming the compbuf
then triggers the ASSERT and sets CONFIG_ERROR in hardware.

[HOW]
Release the DET of HUBPs without a plane before the compbuf is
programmed.

Add hwss_reset_unused_det() and call it in the commit and flip paths,
to cover both seamless and non-seamless boots.

Fixes: 7a1eb6680939 ("drm/amd/display: Perform outstanding programming on full updates")
Cc: Dillon Varone <dillon.varone@amd.com>
Cc: Mario Limonciello <mario.limonciello@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Roman Li <Roman.Li@amd.com>
Signed-off-by: Alex Hung <alex.hung@amd.com>
Tested-by: Dan Wheeler <daniel.wheeler@amd.com>
Reviewed-by: Leo Li <sunpeng.li@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit c93f6fc7175b445ba3b7c85a1fc31e4e4951bbc9)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/display/dc/core/dc.c      |  6 +++-
 .../drm/amd/display/dc/core/dc_hw_sequencer.c | 31 +++++++++++++++++++
 .../drm/amd/display/dc/hwss/hw_sequencer.h    |  3 ++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/amd/display/dc/core/dc.c b/drivers/gpu/drm/amd/display/dc/core/dc.c
index 1143916391e79..348e8991f8701 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc.c
@@ -2484,6 +2484,8 @@ static enum dc_status dc_commit_state_no_check(struct dc *dc, struct dc_state *c
 		 * update pending complete before optimizing bandwidth.
 		 */
 		hwss_wait_for_odm_update_pending_complete(dc, context);
+		/* No DET may stay allocated to a HUBP without a plane (e.g. left over from VBIOS) */
+		hwss_reset_unused_det(dc, context);
 		/* pplib is notified if disp_num changed */
 		dc->hwss.optimize_bandwidth(dc, context);
 		/* Need to do otg sync again as otg could be out of sync due to otg
@@ -4870,8 +4872,10 @@ static void commit_planes_for_stream(struct dc *dc,
 	dc_exit_ips_for_hw_access(dc);
 
 	dc_z10_restore(dc);
-	if (update_type == UPDATE_TYPE_FULL && dc->optimized_required)
+	if (update_type == UPDATE_TYPE_FULL && dc->optimized_required) {
+		hwss_reset_unused_det(dc, dc->current_state);
 		hwss_process_outstanding_hw_updates(dc, dc->current_state);
+	}
 
 	if (update_type != UPDATE_TYPE_FAST && dc->res_pool->funcs->prepare_mcache_programming)
 		dc->res_pool->funcs->prepare_mcache_programming(dc, context);
diff --git a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
index da98afee558fb..55823bce5cf3c 100644
--- a/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
+++ b/drivers/gpu/drm/amd/display/dc/core/dc_hw_sequencer.c
@@ -3147,6 +3147,37 @@ void hwss_wait_for_odm_update_pending_complete(struct dc *dc, struct dc_state *c
 	hwss_wait_for_all_blank_complete(dc, context);
 }
 
+void hwss_reset_unused_det(struct dc *dc, struct dc_state *context)
+{
+	struct hubbub *hubbub = dc->res_pool->hubbub;
+	unsigned int i, j;
+
+	if (!hubbub || !hubbub->funcs->program_det_segments)
+		return;
+
+	for (i = 0; i < dc->res_pool->pipe_count; i++) {
+		struct hubp *hubp = dc->res_pool->hubps[i];
+		bool hubp_in_use = false;
+
+		if (!hubp)
+			continue;
+
+		for (j = 0; j < dc->res_pool->pipe_count; j++) {
+			const struct pipe_ctx *pipe = &context->res_ctx.pipe_ctx[j];
+
+			/* A plane-less pipe renders from the DPG, its HUBP (assigned with the stream) needs no DET */
+			if (pipe->plane_state && pipe->plane_res.hubp &&
+					pipe->plane_res.hubp->inst == hubp->inst) {
+				hubp_in_use = true;
+				break;
+			}
+		}
+
+		if (!hubp_in_use)
+			hubbub->funcs->program_det_segments(hubbub, hubp->inst, 0);
+	}
+}
+
 void hwss_wait_for_no_pipes_pending(struct dc *dc, struct dc_state *context)
 {
 	int i;
diff --git a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
index 7800b0501c399..b413d1790a6b8 100644
--- a/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
+++ b/drivers/gpu/drm/amd/display/dc/hwss/hw_sequencer.h
@@ -1829,6 +1829,9 @@ void hwss_wait_for_odm_update_pending_complete(struct dc *dc,
 void hwss_wait_for_no_pipes_pending(struct dc *dc,
 		struct dc_state *context);
 
+void hwss_reset_unused_det(struct dc *dc,
+		struct dc_state *context);
+
 void hwss_wait_for_outstanding_hw_updates(struct dc *dc,
 		struct dc_state *dc_context);
 
-- 
2.53.0




