Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048975;
	b=touwluOX0PhCwtRb0CNJBCaeMOOeasDJIiNA9CuYDN35hz4atuB6x0g/R628h2cWzeDa
	 Wb2zEzYfLx+SbvHPz3KRbvl2cY+Vx9FlSGWOmhoAlYjyroy1TB5Pw/xzpeaK9zdp7YX2h
	 4Fa5DWIWhTD1DRJXHJoDjQPV059xgXkJFUS3TkCAxUSrRlxPg4gTz1K8uet0lJTSHNUe7
	 nInyloW1IN83XaOKyOXAI8K+UAvJ65rZO3ht1bxD6guAy7wSQ5foN/mT2xqc0wuFispo+
	 w1SOkmVbuihnyo57o0oaJxageBEbS+YDbcCz3avqGBQAqom1TTX+nIC/Nujwdwq0Vpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048975;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=NQ+TS7pmlV7dkbaYOMU6wCvAz6ipQjmAOLbHZ2WzTgE=;
	b=d8VySKtqOPX35OGv11Ws/56SleFOgrU7DFadYOf9a2DyJ98RqT4I1vK4xe11RdA2Uj8G
	 WpKYQdvkEfcsnTLah0LJ90kpKA9KxIJvWgE8I6Dlg4Z/IAVp3/TLjKPGyuDSqkswfeFTo
	 Kb51xT6kbEz9eTMG0AjLpkGBgdvKnU13JKR9BvitgItyDYPAQxSx4RubJHJ/vouTtf2b+
	 JRW5ky0kiKGll/ZqNE2p1X7V6Bhf53z3E/r0m0pTpPboAsuGt7o3n3mNvoMgCOW9FJa2K
	 6IapDL8f6st1AZ5zbqKXgp5sy+m0h/jd9bsathpjn4LfYEj5mFQqvjdI+ogGC6FI6uw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zu1aWAse;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3C2E606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Zu1aWAse
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A1B61F008A1;
	Sat,  7 Nov 2026 10:56:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048975;
	bh=NQ+TS7pmlV7dkbaYOMU6wCvAz6ipQjmAOLbHZ2WzTgE=;
	h=From:To:Cc:Subject:Date;
	b=Zu1aWAseg1iohFMDB2p9y76R7qfL77qKUwncyeDPczguU0/dKJKAXj7uDcJkF4KDX
	 sUl/lHiGc/w4Phl2E79Mci/9WRcF1yobmvR1YfeItFuW+oqeC6R/+Jg1GNR/IKgr5p
	 XJ9rZxOxzYqHmOrH0i3Ea5dbxnsqu9qH1jC71mHBVzq9Z82Shs+5JME83XIfaowguE
	 IazOV1dDDvidpleCZfj0cZ5xce1uG5jxavMpplgECfXtYybPygh5SiFEx4ZXboCc7h
	 IQEtB/pGHV08PJejJ7X82qO1DVrbsfcsUsOcMU1eI8QK3wq0lgsoEpJ6VrjS95NvSJ
	 wBldiPV/48yUg==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: drop the gang leader reference when freeing gang jobs" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:56:13 -0500
Message-ID: <20261107055613-failed-6.1-c1584e10a7de@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x c1584e10a7deb655438f21867b2b7a356a9aaf9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107055613-failed-6.1-c1584e10a7de@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c1584e10a7deb655438f21867b2b7a356a9aaf9f Mon Sep 17 00:00:00 2001
From: Jesse Zhang <Jesse.Zhang@amd.com>
Date: Thu, 15 Oct 2026 22:59:25 +0800
Subject: [PATCH] drm/amdgpu: drop the gang leader reference when freeing gang
 jobs
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Every job of a gang except the leader holds a reference to the
scheduled fence of the leader in job->gang_submit. Only
amdgpu_job_free(), used for jobs which never ran, drops it, so for every
gang submission which completes the scheduler fence of the leader, and
with it its hardware fence, is leaked. amdgpu_job_free() in turn checks
for the leader only after drm_sched_job_cleanup() cleared the scheduler
fence, so a leader freed there drops a reference it never took.

On navi31, 100 submissions of a GFX + COMPUTE gang grow the slab cache
drm_sched_fence is merged into by 60 to 180 objects each time, while
100 GFX only submissions don't.

Use amdgpu_job_free() for the jobs the scheduler frees too, and check
for the gang leader there before drm_sched_job_cleanup() clears the
scheduler fence. As the scheduler clears the entity of the jobs it
picked up, check for the scheduler fence instead to tell whether the job
needs cleaning up.

Keep freeing the remaining IBs with amdgpu_job_free_resources() after
drm_sched_job_cleanup(), so that it frees them with the hardware fence or
right away and not with the scheduler fence, which nobody signals for
jobs aborted after drm_sched_job_arm(), like a CS returning -EAGAIN.

v2: unify amdgpu_job_free() and amdgpu_job_free_cb() (Christian), don't
    free the remaining IBs with the scheduler fence
v3: drop the comments (Christian)
v4: free the IBs with amdgpu_job_free_resources() again (Christian)

Fixes: 68ce8b242242 ("drm/amdgpu: add gang submit backend v2")
Fixes: f7d66fb2ea43 ("drm/amdgpu: cleanup scheduler job initialization v2")
Reviewed-by: Christian König <christian.koenig@amd.com>
Signed-off-by: Jesse Zhang <Jesse.Zhang@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit df4d6d404d44bbc8fc850bc7f9f136a25dabf180)
Cc: stable@vger.kernel.org
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 24 +++++-------------------
 1 file changed, 5 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 9cc210198fa45..8689a3c933b27 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -313,22 +313,7 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 
 static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 {
-	struct amdgpu_job *job = to_amdgpu_job(s_job);
-
-	drm_sched_job_cleanup(s_job);
-
-	amdgpu_sync_free(&job->explicit_sync);
-
-	if (dma_fence_was_initialized(&job->hw_fence->base))
-		dma_fence_put(&job->hw_fence->base);
-	else
-		kfree(job->hw_fence);
-	if (dma_fence_was_initialized(&job->hw_vm_fence->base))
-		dma_fence_put(&job->hw_vm_fence->base);
-	else
-		kfree(job->hw_vm_fence);
-
-	kfree(job);
+	amdgpu_job_free(to_amdgpu_job(s_job));
 }
 
 void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
@@ -349,13 +334,14 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
 
 void amdgpu_job_free(struct amdgpu_job *job)
 {
-	if (job->base.entity)
+	if (job->gang_submit != &job->base.s_fence->scheduled)
+		dma_fence_put(job->gang_submit);
+
+	if (job->base.s_fence)
 		drm_sched_job_cleanup(&job->base);
 
 	amdgpu_job_free_resources(job);
 	amdgpu_sync_free(&job->explicit_sync);
-	if (job->gang_submit != &job->base.s_fence->scheduled)
-		dma_fence_put(job->gang_submit);
 
 	if (dma_fence_was_initialized(&job->hw_fence->base))
 		dma_fence_put(&job->hw_fence->base);
-- 
2.53.0




