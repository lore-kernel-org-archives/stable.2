Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794454740;
	b=MNAzXUFANwk3HujDRwxqdyIFXlSPNmefK9/SqRNroAITNrWuL9vu9VRpLQRLO6Ms7MZn
	 3hsWRavtsHYEs2yPnqgwvNJhc0ygiiq8Srf5iOftBWkCcnnNT4pTBm8kRa3SzacqnxZsz
	 bCfc6/AUZ5MJFoB8RG+qj944tA0BIGm1//0h+M5OUpmvcAgwAXRYWMT2EA6HLmbHvwDJf
	 i7C0pJNPtNBlkLcUiRUZ7aLl4NK/+jp4VPTX41iYoz3NnqkmGsDDRWSDnv6glUIdTVlaz
	 B2kwxv75RtCVNdApfeoJHuerdREA2M1HAieG0PZzZdnr89G0KCoxUqKaM1cwcfCbuvg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794454740;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=y2lDU4NE/uPjARslOJLd+RQ0q6tcPpO26Kx1y39fEUY=;
	b=Yx/Qrj4K+i2mhib6ZUjHxjT3ogcvVQupv7JPn/i494S5QS3WS0c/kbKBAwcPbgKJSfoa
	 jiHwhGxAwXRXqIiaXO8V8caS5XbYxAFFlNR/PNm8J0aD+8T+oVUs3iU9QhqQvsd6bkHpy
	 wC8lpH7GcPUZZE5E2k1gqU33q8rePhHbxf3dk6TFccsv8vMQbb3qFjcQlcqjgehtgQwNb
	 e3572BC+AiL5mfX0VGegqKwLFe9zrEo662vTODEtn5e0OSJHA+p7B4hhvFNOMsCTTMnuI
	 UgM8ZdgFGinsEHdqxNsxu5SkUBEeZgB46kuoLZtyn/+JVjC5hpKOkgUEH0DkTF0mr5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzTnp6tw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D33F606A321
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:39:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FzTnp6tw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 931721F00A05;
	Thu, 12 Nov 2026 03:38:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794454740;
	bh=y2lDU4NE/uPjARslOJLd+RQ0q6tcPpO26Kx1y39fEUY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FzTnp6tw/ZNqqNa6JHirILXGg+DTN08frKc8XeAJBD1qmzHbF86mg1CoKcFurX7pM
	 tJzgIhHVpU+j203noW9gbmo+Q1gTM5BZ+IuphFn8F92S7j8GFKYtsYTIRoavKGhldc
	 tZe3Fh88GeORR+L0Zy6AU6RR3Thgr7fY/18NsPIc7CUvpFGiTr1UCTYysjlYTPQRm3
	 YvHrU3juxz+Oq0o6RIlKWQdRh8tPf3O5bGOKnMVLtF0dAVcd5tvo3+B5MHsWvEQPD4
	 /Up12/LHrL1grP1jlcgoz8KnpMYyvz/4XRHF4hnMuCfZTHn7k9rQ1UlEKrXXaaWNoZ
	 sFMzfhnwsPlLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jesse Zhang <Jesse.Zhang@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y] drm/amdgpu: drop the gang leader reference when freeing gang jobs
Date: Wed, 11 Nov 2026 22:38:58 -0500
Message-ID: <20261112033849.1565927-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051529-failed-6.18-c1584e10a7de@kernel.org>
References: <20261107051529-failed-6.18-c1584e10a7de@kernel.org>
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
[ sashal: Adjusted amdgpu_job_free_cb() context for embedded hardware fences instead of separately allocated fences. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_job.c | 19 +++++--------------
 1 file changed, 5 insertions(+), 14 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
index ffc720d189007..d013fd68b1b14 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_job.c
@@ -264,17 +264,7 @@ void amdgpu_job_free_resources(struct amdgpu_job *job)
 
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
@@ -295,13 +285,14 @@ void amdgpu_job_set_gang_leader(struct amdgpu_job *job,
 
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

