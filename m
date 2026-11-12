Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794455065;
	b=JcFs4940ErH0+OEVQgzmdH+eojesyuvPw0YhdUKGmDw+46qqIf3+bRyOahkx2PxMYNzP
	 KSEgVinJYZcHZCFzyOx+B2Yg0LG5XQ3Ta+kFyPHdtUzRkKIR1zTI47Cl8v2/LP/9xSkh3
	 PwNjhDvpdo9pb4poA7D0zVMmgxEKK/9NHwQtqw4Tu757SFTQAh076tl+See6MNjxe1DD+
	 hnnUVpvsnipl5xCE8PzPkD1Jfb+f7SE9cSXYB5/aHwAFSRUXJiz1WrOIn63lkK+MJwKkj
	 I5VIkce9tjk2Pw3w6YbDq8w9uUvTPG2FzpPlZTceCCy1gOqHkm61yodLZSWI2ijuMWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794455065;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=mFUvQ41Qjyros7PN0YXspW273f2gPt+J1QNqqNMDQ54=;
	b=RAm8j5vz66XVFmRA4HsKqh/0NJef02P1t93NNBClu42MmHp3zyAdk0DkDQD91sRTM9lh
	 P2rGOR4B6c2Ods0ykXQQiGV2R9QDz2hjGQ5GTMR7zelKYxoVWEKY5yHY0Q7aMnDBeZSdu
	 iFSaK8fIYXScaffAVRlyVQBP43lMxWpRrufvsPEP8r+rj5C1Pt0vetQQNCOsPcqMINZIa
	 6NxFjjYcMrpB/Dm205sQ8H13DVgGVCb0rfByMyC4206RBywCJXnufC/tD7m+x/HyCNZ2G
	 rshgpXbeDzWfv2HwNp76z3zFHnWv9o4eUCUvpYwxo6XMUv3lzQJ3jwEDJcHCYc8+PUQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D/D4gPNB";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50A3C606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:44:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D/D4gPNB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BC871F00A05;
	Thu, 12 Nov 2026 03:44:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794455065;
	bh=mFUvQ41Qjyros7PN0YXspW273f2gPt+J1QNqqNMDQ54=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D/D4gPNBp0tKu5Bk/7i0S0fIC63j185GHgowxjjpk07LLtZu9MsQwe9MH7nuFwpzQ
	 Uc4wW9aTW2o9bvYSwFOncACW7PL+LNvo95wCDOdXP0s+M+qdbZJd9sRQYfB88y8cig
	 Pu1CrFIahd9K80psPSNfb3wEZtbA0hMFZMqKjV4y7RCyLBK3z3QfAgEd1lI4nqfRzu
	 daOjuG9LxKHIw6TlsARooelbppL4v1LHTUi0SRpfyOaQx+ANx3I3mRAwIaRBFRSZ8Z
	 KjsrSmMuPUX5GHmjydNqROdLT3IaLLKNSNfxdOFoe2zFZmWZ/Ox/lSaKEcbQVQjg5e
	 +3jL4pFrSixmg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] drm/amdgpu: drop the gang leader reference when freeing gang jobs
Date: Wed, 11 Nov 2026 22:44:23 -0500
Message-ID: <20261112034408.1581974-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054015-failed-6.6-c1584e10a7de@kernel.org>
References: <20261107054015-failed-6.6-c1584e10a7de@kernel.org>
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
[ sashal: adjusted cleanup context for an embedded hw_fence using base.ops to check initialization ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index 56eb3aa1d9d3e..b03860f23c70c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -181,17 +181,7 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 
 static void amdgpu_job_free_cb(struct drm_sched_job *s_job)
 {
-	struct amdgpu_job *job = to_amdgpu_job(s_job);
-
-	drm_sched_job_cleanup(s_job);
-
-	amdgpu_sync_free(&job->explicit_sync);
-
-	/* only put the hw fence if has embedded fence */
-	if (!job->hw_fence.base.ops)
-		kfree(job);
-	else
-		dma_fence_put(&job->hw_fence.base);
+	amdgpu_job_free(to_amdgpu_job(s_job));
 }
 
 void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
@@ -212,13 +202,14 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
 
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
 
 	if (!job->hw_fence.base.ops)
 		kfree(job);
-- 
2.53.0

