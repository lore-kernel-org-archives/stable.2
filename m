Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794272732;
	b=yjPgfwJhIpQwOoKQkPOIvqMFDccfl+ZDmibAJGsCphFX2Uy3TnyDWbiNgDILWwQ8920f
	 qkVsk9CqxQV5BVVfxw3i/H8+yhTV8uFbrcUkondBAjBCca98Zfvq/GJ7k6R1WUZ+UkvfF
	 xS5K19K0nYSgY7P/5zcNqGVRgiOAc1xBRRmfrQVlwXfkMi1MosA3TvZDWfVknIk/itN+V
	 m6ZpGjVim/2LB5UrPVmJ7MRUA4j9PwrkwTj0oj0X4Z5SeygxFwXct1FslMHMCWrqEvzMC
	 r5ndOB/39A4O5nu8aziT2t0un7U6V6D0lpy8tVzLpY3lCMSfgpOOEnkTUM8lR2Jobhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794272732;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=hgF/kMzvB8U1+YEJWeqzsyb8cxZPTQ7iEAX+HCeCV2g=;
	b=tO+8VPovHZ+H0P//3H/gH24QGuCNcORGxJgsqdMfiGHEadkx9hv+UjxciECPp9km+WIH
	 G8I97dTi8ET4bAbWZNWlKOwFUCzV+x/Aa10Dvvk4twfYQclI5seG4L4MZy0tnzLvtkqdu
	 mfU+uiRkmeGE5idzLw8nejSGLjRuZc5snvTvLCf8PlsXWmOpeqn5VWzCEFWQkGM5CV+Pm
	 6+JnIeXFwInuid+wcihU8wehUODz076M0A3Gsw0YpoHkh+ySphDq7dfakZqk4oiDrbWgR
	 sClHMp6prf6EzIublYyiHsPsw426WQKATEMU4VXDy4ecre4GwxyZVFFWEOW8ntMEZcw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lG89ILGr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D9D0606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:05:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lG89ILGr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 935C91F0089F;
	Tue, 10 Nov 2026 01:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794272732;
	bh=hgF/kMzvB8U1+YEJWeqzsyb8cxZPTQ7iEAX+HCeCV2g=;
	h=From:To:Cc:Subject:Date;
	b=lG89ILGrC3OKUiTOjtmMHcNbJTnyp80UYsDe3CZi5Pp9oEjmdiQgh604rnc+SNLBN
	 1oOYLnWOYLhK34gtPclEWluKCZG/fJbwp46uHoyPQg10DKTo5GD1HRuyCxAXL9Cmc4
	 uo/PtNQKRb9SgP5ZZEZayK/JvnTPDtT3Xc2Jqqrc5LxJGc2+36ZwA2huJMjcIICaRF
	 jysKGdlFrYt6u5UsfwFRcBmmPaQrsmLB591/MbMawr1cXJnL57Hjsgmzh8iQOQoCv8
	 B0xT6Xw2lEZmaGfvqW1ZIm6bZZtluoi1tuKmHoZK8bNuF856c5mGg//63ArWPiuxqq
	 VonXMuelaQlEQ==
From: Sasha Levin <sashal@kernel.org>
To: prike.liang@amd.com,
	vitaly.prosyak@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu/userq: wait for GPU reset before mapping or unmapping queues" failed to apply to 6.18-stable tree
Date: Mon,  9 Nov 2026 20:05:30 -0500
Message-ID: <20261109200530-failed-6.18-623507b8f4fe@kernel.org>
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
git cherry-pick -x 623507b8f4fe24851b2f1cb2c177f8ae3c8584b8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109200530-failed-6.18-623507b8f4fe@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




