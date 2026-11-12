Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794455809;
	b=eGBr1Op1UmR9MX1TU1ely2kdlBcbQFrNNXfbVor2nWxolPTJQi5/ceP+qDKDdCzaWrdj
	 v1LfGhCpVJ2ngW9a1sALKUC1cVg61cyZnz9X2z5jPlT+xBlG71isyaplZK/ga1dszD2F7
	 hNS0ZCMcxLQY+LFi/Q7+CbUkScfkdsO+CkWtpTkVVUc/DaOr6LAvVISeWA313t320EsAK
	 gfFAPjF+NUQrMKOB7uwloy5cdAjH6iA+zfR3o9FrorxyzSZ5AbbiocjGCQZa+ElQBfKDd
	 vHQQTZm07AgZnZMAR6Vx3CRPF3jwwx8peEuRkP7BkqDJTnsWDhGV6NTFqaBIVB/F3Ew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455809;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=nFuhw28qbCF5SbulW/JjpDrQJtmGdtx6sJl+ZSA3APQ=;
	b=H7LHKzr9+OSBmIXCgepjxNeO9xzfusoDbB9kvGFAHRLowRkyoNrY7mx0fGyzBMjYkOBX
	 GdBPWWlZCxH1oo/phkMGQc3f6cQnMR0CXB2Azfq/n0thR/Bw2TdOnN3ITdzzQYDjMi/On
	 MF3umlfBF1C03uJmCUTU/LnpMkYo0kke4yINPge/bik8xf2bQnlCXSZHwXjw7Nj9c1ffm
	 a3+37nG2/+TAVQtncF7Ytyf6W9du8R5yDK1cIB11u4fXiy6kpDrJOoKYrSS7C/Ut7dg5z
	 FYGWFYcK6R/af/Cto5v9d1lASsHBJTuj0Cvj1GFbKb9l2DAUK7XmjZYTkHMzhiMqP5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="FF2SUi/n";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC640606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:56:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FF2SUi/n
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6FB01F00A05;
	Thu, 12 Nov 2026 03:56:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794455809;
	bh=nFuhw28qbCF5SbulW/JjpDrQJtmGdtx6sJl+ZSA3APQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FF2SUi/nyOIjYzeMSZnYklUxEG6b5MyvZntHezpWcqxQIjIOdJyRnZH3QMybIlJrg
	 XNbNLnuMwLIN6GeG6pWd3HQm4qBDmu4VRaz1XL9F3/S+UgZPjPh7b5sAqAHsI/RkCg
	 m/90mQtk4sudeCn0JeZZso12Bg2smU2qnxCfuK/1+70gBQbJ8ShE7X6iQP+o1gUTKE
	 Nxo0/upvqD8JvSl9WCtJXXI0NSwktFPZ1LSWMl5lQ4efEaIP1Mla/buO7VaF8envYh
	 vZvnnk6lLmRDF6AcKO5YHOeWfpRuFZkAAF8ipAZPRHyS3Qs98lGAyPgCnlHTlx8IIl
	 a3jcGOFK9TUTQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] drm/amdgpu: drop the gang leader reference when freeing gang jobs
Date: Wed, 11 Nov 2026 22:56:47 -0500
Message-ID: <20261112035615.1586900-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055613-failed-6.1-c1584e10a7de@kernel.org>
References: <20261107055613-failed-6.1-c1584e10a7de@kernel.org>
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

From: Jesse Zhang <Jesse.Zhang@amd.com>

[ Upstream commit c1584e10a7deb655438f21867b2b7a356a9aaf9f ]

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
[ sashal: Adapted job cleanup to use sync and sched_sync while preserving the embedded hardware fence’s ownership model. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 20 +++++---------------
 1 file changed, 5 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index d321db549a1e0..00e632e45f656 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -179,18 +179,7 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 
 static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 {
-	struct amdgpu_job *job = to_amdgpu_job(s_job);
-
-	drm_sched_job_cleanup(s_job);
-
-	amdgpu_sync_free(&job->sync);
-	amdgpu_sync_free(&job->sched_sync);
-
-	/* only put the hw fence if has embedded fence */
-	if (!job->hw_fence.ops)
-		kfree(job);
-	else
-		dma_fence_put(&job->hw_fence);
+	amdgpu_job_free(to_amdgpu_job(s_job));
 }
 
 void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
@@ -211,14 +200,15 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
 
 void amdgpu_job_free(struct amdgpu_job *job)
 {
-	if (job->base.entity)
+	if (job->gang_submit != &job->base.s_fence->scheduled)
+		dma_fence_put(job->gang_submit);
+
+	if (job->base.s_fence)
 		drm_sched_job_cleanup(&job->base);
 
 	amdgpu_job_free_resources(job);
 	amdgpu_sync_free(&job->sync);
 	amdgpu_sync_free(&job->sched_sync);
-	if (job->gang_submit != &job->base.s_fence->scheduled)
-		dma_fence_put(job->gang_submit);
 
 	if (!job->hw_fence.ops)
 		kfree(job);
-- 
2.53.0

