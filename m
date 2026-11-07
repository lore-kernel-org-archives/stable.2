Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048016;
	b=Sus3nE6OdeqKYix1Vss7QmFnGjqdcGJ5HKZXDxT5wLHxvKBXF0AQsAliwcGgBTfOywCN
	 id70p9jbzVk1Lweks0HM+1oONG0zJ/63fNfS03IYNa9YWFHziDYck2PeoeM2agGeaNWXm
	 fjuDCTG/9Dfo5okme3Qf9j+vp9Z0uPfQejfZZaBlirwf5QWMWJOV5ALWOK2DGWPVXmoN9
	 TljlWQnXI9ku7/UzAK9DgRQagYZYiHHVUOGUXouzdMtDWU8s3Crzh2MoKByV8eIMYiMfZ
	 TtAm36y7ooW8Ytf6dkZJs77ujy5fuCKDNtFg2xwu5sKvzMjf5DcEMT59ov3LyHPXKmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048016;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=LhDBCgGiW30jvOKcrK5gHiKc37LccdWCl9XRIDds8JU=;
	b=CjGOrhhCX82i0MKSI5n11V/VHL3mKJJahzw/GYM9JK79jEBG+xpZU8ktuOEL6DV1BPrA
	 hEHVYx3T330h7b24+G8+TfruNfhybdU/C/5qY3dSaU7G0+RoXbKeXt5AHK3ks8mwNza73
	 /Yma2eEQ8Hjaj+o7fVDcdet5/IjIVlvyteVpKu5erJjqMuTOl+D9STfwsp8eodnTTsfmQ
	 7v6M+ssKCqZTgZ8kC7+tFxYPEibtSk6Y51lnv3JXxMSEP4CpPG4/DNaHOez89WL7z1wFJ
	 OutVQci+77dttW89RsYOZXHW5Y6eldWCMcCO1QjJHSBhxrrFQp0qPd0zqgvlkgLXUsg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dbmw2IET;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4E57606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:40:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Dbmw2IET
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FB031F008A1;
	Sat,  7 Nov 2026 10:40:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048016;
	bh=LhDBCgGiW30jvOKcrK5gHiKc37LccdWCl9XRIDds8JU=;
	h=From:To:Cc:Subject:Date;
	b=Dbmw2IETuyl43REQ2TbT1XQOJvksE4aqxNGCsGDCIGoEPYy4PMoMpBG6LnMuHJqF0
	 4Vus9milVaP+32yB/1NHS6GkjZfI+zaJb34uUe9vQwEw1NKhDtkztb9zyNGi/vPE22
	 h2OABHG+/SzfEVtzKm+H+/HjkpdqRbga+NgGWU4Cs90SzaG87rGghPfcLxz3y+uI08
	 NCVg2rukNQUTEQ4czkW775L9ykg8VRzruR3AqEenBKnwyDWJgGRS0Mkpu0iP+0huQb
	 hmCmJt8GQLE2iPsjkHr9LdKjumHpiQwBx/PXxqrE7a8PZRIwS9VEDHRF0mEfnRYDR/
	 Ot6aw6ZSUKyVQ==
From: Sasha Levin <sashal@kernel.org>
To: jesse.zhang@amd.com,
	christian.koenig@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] drm/amdgpu: drop the gang leader reference when freeing gang jobs" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:40:15 -0500
Message-ID: <20261107054015-failed-6.6-c1584e10a7de@kernel.org>
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
git cherry-pick -x c1584e10a7deb655438f21867b2b7a356a9aaf9f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054015-failed-6.6-c1584e10a7de@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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




