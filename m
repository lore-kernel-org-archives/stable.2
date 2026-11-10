Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273844;
	b=XV4txmQxLr33CfjFx6b5yMfNVDOZRhk78ycV/tCr/efbWJaeAyFSr8w34g2SbS9r+TOD
	 +9d5Syz78ET47PxXbcPwzwhv9yFJGVMRATmMCGjKVBq+uB/OVDLrLw3LctB27UksxsRwA
	 6MkqcRB11ws58UDfKJ95Jc1p6htp3MyhUt1dPw9iwU0szuHqqiUTsUZb9ZDaUk9mQ+kZ2
	 ugbyiWmJ7sHOFIc2PDVSViIWn8vQPiw/dgUOZggnGVko1aKV4fAIyoIwWQif5eiC7drLH
	 WU6RukYvs3otHEJyPYGfILDP5eGM3GRbEH3IBMheCnpMBZmxdhItrKJY5kx8z8QuUdw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273844;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=5TgdL3mXeFctO0sFbD0Zb2bLubk6j4JAWUM6hih13Dk=;
	b=rvYpGinY0OCkaU7LAU4NG6uiNXuS+g03StOVmH+LMA3O/5EQtniYX0naE0Jz3mH+I3Dj
	 1+nQpAM3joNmg5Jz/QXjQvOXmww/yNtBuF6gc5OMIqOWMj4q0wc6suot06FcGicxZm5xF
	 3qRxxKedm5HAlIQ27PsSifi45zOm71pejGU0V/CPPOP/20eh4GI01of/BbhG2ghdYsWKr
	 Nb/UhHa9UpiF15kCwASG7FFCbdkPmiFtA8M84PD2LWMmnvuRERX2bGqyfaNXNPM72ppwW
	 NORzjf6zaSZpUE6X4aU+qlHXF1GUQyxjjmKphD1Unq1ELE7++Oe/42PmCyyQCGbf4AA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W85qlnzj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82D1160A263E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=W85qlnzj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC53D1F0089F;
	Tue, 10 Nov 2026 01:24:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273843;
	bh=5TgdL3mXeFctO0sFbD0Zb2bLubk6j4JAWUM6hih13Dk=;
	h=From:To:Cc:Subject:Date;
	b=W85qlnzj9th0kNRXo0WuvQkqe22lziBF1UlkJ60zfjCCp8LNDq/ArOd61admf1yjW
	 du1RYgivUBSwgEardZOVVuAwxTHCt/EABDZaG/L4PPljlhlemIzYCkSqjSN/aMBB/+
	 17/DcbiF5AGDsC+yIfktgPV1uERP803FrPPqdDN2+rUdOtNKxBw1P7Y/Y6nPumRXbz
	 9DesLrThEUb53vQ0wHhyXdHd3CJgXkosSgfadN+2NiE6WUDeWV9PABDs0dV9SfUWfX
	 JqhVgr2oKJhLA54Falix34Brqoeed4zAJTVFL/WGm+WwAoz/Az8ZvZMSmqTO4J/Ujr
	 hlgnuUAaJjhxA==
From: Sasha Levin <sashal@kernel.org>
To: prike.liang@amd.com,
	vitaly.prosyak@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu/userq: wait for GPU reset before mapping or unmapping queues" failed to apply to 5.15-stable tree
Date: Mon,  9 Nov 2026 20:24:01 -0500
Message-ID: <20261109202401-failed-5.15-623507b8f4fe@kernel.org>
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

The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 623507b8f4fe24851b2f1cb2c177f8ae3c8584b8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202401-failed-5.15-623507b8f4fe@kernel.org' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 623507b8f4fe24851b2f1cb2c177f8ae3c8584b8 Mon Sep 17 00:00:00 2001
From: Prike Liang <Prike.Liang@amd.com>
Date: Fri, 16 Oct 2026 09:34:32 +0800
Subject: [PATCH] drm/amdgpu/userq: wait for GPU reset before mapping or
 unmapping queues

The user queue map and unmap helpers talk to the MES, but only the
create path holds reset_domain->sem around them. The eviction, restore,
destroy and suspend paths can submit to the MES while a GPU reset is in
progress:

  WARNING: amdgpu_device.c:928 at amdgpu_device_skip_hw_access+0x73/0x90 [amdgpu]
  Workqueue: events amdgpu_eviction_fence_suspend_worker [amdgpu]
  Call Trace:
   amdgpu_mm_wdoorbell64+0x20/0x70 [amdgpu]
   mes_v11_0_ring_set_wptr+0x71/0x80 [amdgpu]
   amdgpu_ring_commit+0x5b/0xa0 [amdgpu]
   mes_v11_0_submit_pkt_and_poll_completion.constprop.0+0x207/0x520 [amdgpu]
   mes_v11_0_remove_hw_queue+0xd9/0x100 [amdgpu]
   mes_userq_unmap+0xc3/0x140 [amdgpu]
   amdgpu_userq_unmap_helper+0x67/0x280 [amdgpu]
   amdgpu_userq_evict+0x52/0xf0 [amdgpu]
   amdgpu_eviction_fence_suspend_worker+0x55/0xe0 [amdgpu]

Take the semaphore for read in the helpers instead, around both the MES
call and the queue state check and update. The reset changes the queue
state from amdgpu_userq_pre_reset()/post_reset(), so every caller now
waits for a running reset and acts on the state it left behind.

Signed-off-by: Prike Liang <Prike.Liang@amd.com>
Reviewed-by: Vitaly Prosyak <vitaly.prosyak@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit e6a8b8588f43bd4d7054ac47cccc35f56ad2df90)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
index 4dca1ab48410a..958a3c9f4c617 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_userq.c
@@ -362,6 +362,8 @@ static int amdgpu_userq_unmap_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	/* The reset changes the queue state and the MES is unusable meanwhile */
+	guard(rwsem_read)(&adev->reset_domain->sem);
 	if ((queue->state == AMDGPU_USERQ_STATE_MAPPED) ||
 	    (queue->state == AMDGPU_USERQ_STATE_PREEMPTED)) {
 		trace_amdgpu_userq_state_start(queue);
@@ -388,6 +390,8 @@ static int amdgpu_userq_map_helper(struct amdgpu_usermode_queue *queue)
 		adev->userq_funcs[queue->queue_type];
 	int r;
 
+	/* The reset changes the queue state and the MES is unusable meanwhile */
+	guard(rwsem_read)(&adev->reset_domain->sem);
 	if (queue->state == AMDGPU_USERQ_STATE_UNMAPPED) {
 		trace_amdgpu_userq_state_start(queue);
 
@@ -769,12 +773,7 @@ amdgpu_userq_create(struct drm_file *filp, union drm_amdgpu_userq *args)
 	if (!adev->userq_halt_for_enforce_isolation ||
 	    ((queue->queue_type != AMDGPU_HW_IP_GFX) &&
 	     (queue->queue_type != AMDGPU_HW_IP_COMPUTE))) {
-		/* Serialize the map against an in-progress GPU reset (MES is
-		 * unresponsive during recovery), matching amdgpu_userq_detach_doorbell().
-		 */
-		down_read(&adev->reset_domain->sem);
 		r = amdgpu_userq_map_helper(queue);
-		up_read(&adev->reset_domain->sem);
 		if (r) {
 			drm_file_err(uq_mgr->file, "Failed to map Queue\n");
 			trace_amdgpu_userq_create_end(queue, r);
-- 
2.53.0




