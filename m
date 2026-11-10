Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273001;
	b=rnSr2BYNrkK0PuU7zO/P2hd/olVKSPuWDBYKxlKe3kS4GKR4uFsyi2dzI4YsvN06f/VI
	 rVNgT/MJvLmU5bZKWPHVZ/3j4TjtqRshAL8V+8KGhcREjInQfMSux2tsAYK1CUi0nxeUH
	 1Y2UtRgB+zphafm11ZxKZeXlSJb+pRChjDASXUevN2HaryS7guCDiSujW2Xee9yOuNT6w
	 2STePmzh86anf1pp3ZJ7w68UJo+yeSynWDODzZoiOyZzxkQipxilj6VviH4QP4Ukft3rw
	 YedzF1aeedDiD4mp/IxBgU7gAkuqWbgPQM4H3Bf6iK2LU7XYmXRCEI5e1eZRx52VsPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273001;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=EBkkMRod8wqpGSkm7sHeDfWBkOZqAaxCmijrX9JZwTc=;
	b=i4ALvWdW96q+6iCQwoKoRsMIl1BtHmwwnPKhNvGtc+UMlKctNZqLwBQ8V49yXGAoFOrt
	 n9qflJgRGT03MrGT4bPKS4ULxoqGDkjlLeBosYuURWfBCgiaG5jPed9uBosjKjMdaTcpX
	 Q1vwMi4OF4fajMHoHUtfmq+W3oleZUpydROkKNR0i8hRjHr34KD3DgM6Rh6OoCr6zvONB
	 7P6lJtsSvOYfQCgje8lMrPoUr4kJ1u2RCmDOztcScnUhvxCSC84DPUGVpUuvOj/oUISmg
	 +cMW1g5A3jq1y5+tTCTTUPScckwne+xnUEfobR1eRxk8Vh3NI1y4LSRy7ATom8leTSg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcFeMzV4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DB0ED606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:10:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fcFeMzV4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEAD61F0089F;
	Tue, 10 Nov 2026 01:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273000;
	bh=EBkkMRod8wqpGSkm7sHeDfWBkOZqAaxCmijrX9JZwTc=;
	h=From:To:Cc:Subject:Date;
	b=fcFeMzV4509K9Ti+Uf6oTp8WAr9U/FAlSUHzumSNA8LHu9K5Y+VwDo4A/RrFsuZIN
	 RNmi7PID5XfxVC6WwjgBqujEp+Smmp2UKCB8X154gLh/1cAvmqZqMFBowTHhy8HvOk
	 03uZqKmDaEoYvjwcPbCXiF8e+qsIeC8pMUl2WiCuO9Isyzkp7z/fkGWBM8J1SguevG
	 QSIwTZ+gL8DPPMABRBrsIZnoeUj8O/CQtZ2+RI1DiZOn/W+shRFQ12dtocXVxzfbFT
	 lxSNuofcROmiwjngh9CpxUxK17ghaSDaLeDcHyGE7cDVBzDq1q54lvAqk4UmsuCiAx
	 yyBIwwJBtwVpQ==
From: Sasha Levin <sashal@kernel.org>
To: roman.li@amd.com,
	dillon.varone@amd.com,
	mario.limonciello@amd.com,
	alexander.deucher@amd.com,
	alex.hung@amd.com,
	daniel.wheeler@amd.com,
	sunpeng.li@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amd/display: Reset DET of HUBPs without a plane before outstanding updates" failed to apply to 6.12-stable tree
Date: Mon,  9 Nov 2026 20:09:58 -0500
Message-ID: <20261109200958-failed-6.12-f3afbf7d832a@kernel.org>
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
git cherry-pick -x f3afbf7d832ab138655afc96bd42226775d03ce7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200958-failed-6.12-f3afbf7d832a@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




