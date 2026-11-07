Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046531;
	b=dmWJD/49qQCAFqct3IgDQuwrbYbLVkTkAPhJVXen1MMxxUw4eXDq1Rzs7q/FVkrEhhZY
	 TRG1wR3d71Ggj+sKNS/t5CW0aGB/J34NzgxViX1XW7aJ2u5IBhXok3U74F97ShDrmp6KK
	 dmP6oWhSpZzGsHDgsDdB7iSt1iVw1HiQBCtilOuMP///YdK1GY4qkAaU7+VM5jkxzJ5bD
	 IKUwbVvZZbzAdocv+8q9BPdyqmU7HqUnMx0WBT2n2Tf9hTZtgSLviT2Y+bmZgCwjWfrZo
	 iKRvc36s4TCrO3LX+fp6PrvAfRUdP97n4FU7atHoJIGSpg2VYG+gGY1CSyL2jDpnyBg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046531;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=b2U8MQ4OgDSxw3vcX860jBJPbPIRc9lgrhmTzArrrPo=;
	b=TzJEtRboWwhVy4xWXCGBpSNdB/Z0Nu53cC6Dk+VCtuT8jecfxkX+242PB4ZUS2vgR/Di
	 dwhBGIVw6+8qQri/WRAgKn7y5S0nI58dfiSFEOn572bzHB9hyQrU48OLHqsD9ar72TJFH
	 zLjgI3BzuFr5aCT/DsFY74YsZJpmaC4qCYqmuku+5Ly+qyo8NKGRnxE1kagerJaJYMGii
	 bEB28RAkjTB1xGFzOvuQRdzV1Q0lfUi5rCPfqi/fgwBUlRaZjdiwzH/+vjCm1znkT+Vr4
	 tNP0yFZw0sBfvH/kO+ePAThUi3R3EArIxa77DhOfpdS01tVCvFwcfj9wEWx7NhYK92Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARoWQhlP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DDC4D606A331
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:15:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ARoWQhlP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 402941F0089F;
	Sat,  7 Nov 2026 10:15:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046530;
	bh=b2U8MQ4OgDSxw3vcX860jBJPbPIRc9lgrhmTzArrrPo=;
	h=From:To:Cc:Subject:Date;
	b=ARoWQhlPMhxeAX+tLzZ1mple7zCt53UXd04zaexNiZtd4m/dd3EmZXnL9jvgTlzRt
	 faBIXun5kTVPDTW6/tEzfo1rH3v/bu6NF+r2GTBiWQwS3F/Bwm2OGAUlhMv6TesXHz
	 T/ksPMAdsyDrdrvv4cv3h8A7H8N7K6Jr61ciTE/jGE6431uN/SbG60V9p4p8iNQBKA
	 dHCSKWjz4IE4P9hvCQ9hUYPdExVR5kbCY17mD3GNsweE+C8NHZJ0pLbUp50lvbE71m
	 Reb9KTqM6pesbZI/Jimiru7llzUm3OWVgFzksInVbxFbJ3/vVr8ypglxqN0Als2awt
	 ktLAepyzLSkwA==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: drop the gang leader reference when freeing gang jobs" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:15:29 -0500
Message-ID: <20261107051529-failed-6.18-c1584e10a7de@kernel.org>
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
git cherry-pick -x c1584e10a7deb655438f21867b2b7a356a9aaf9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051529-failed-6.18-c1584e10a7de@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




