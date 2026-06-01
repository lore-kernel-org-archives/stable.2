Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A10E365A0F
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:17:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319855; cv=none; b=ImfOyFbaZaxdltZuIxvkaB8UtF/7hdBIKKJ5UGXY8XqIxyBHEs0vQzpE1P70aFIJdSMekPiBIKE6luHvPVyUj1CgPKGVYFA84hZt9+RlYJkY3NE5qVTysEQ/7eHLo6NP09at6a9OzMZjTmCAmJC3XjInLJWKxya4hls4+CuaiOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319855; c=relaxed/simple;
	bh=W/6KVdvVU7TFc3d5NvQwveMQ5Ljho5Tw2OFwiyTF7Io=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=d2T1ejx9w87RTDPdcoewsbbv2FSsrCWtA3V9phkcfhIZ/qATsGJT8G9qeISrZ8GEITF7O0s7cEsS7NQkhBY+4b9zrWhaEjPtHkKxFJiABz4imbaJLJq7XCEiBj6XsEKWS6Za7M7h0D9S5QC/tvViDkR3ucOb4UQxi+a3NWJK0/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U1qE4NoZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U1qE4NoZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CF121F00893;
	Mon,  1 Jun 2026 13:17:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780319853;
	bh=D57kvu1ojMK2EvE7dWd0Jxdx0qKIaDUhT0mMIFLKnkE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=U1qE4NoZNa8NjfirmG5BlsDbbHK6W+dJXYYArNKUewAQLPjTFPKc9E9yuxymFZ3A+
	 oFLRUOHPM/1CGEdnLDPn3XbLfXNS65ZsrXIlgBSdQn3KbIZ361Wt2/pDeHbtakPpDG
	 TCLIJMgMs3njA8CW4extU1locokELjQUeW2sWvFZ6QrOYk5Eb48FEd8AIbwTVc1rQw
	 AkOzPJeP9Fi/uUBjahRIp7mVFhOnVnSZveTDaF5wn2lSw4Ysse6kmjAthXfQ2yQDHw
	 QeZWMlWaK7r2zPrMYzl5wvV09Ic9f/7dnKb2cQ6FR1xP4gnC4x76bo2jLqIpexeDRU
	 yR7Jahr0y2l4Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	Melissa Wen <mwen@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] drm/v3d: Synchronous operations can't timeout
Date: Mon,  1 Jun 2026 09:17:30 -0400
Message-ID: <20260601131731.780919-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052855-portable-pardon-850e@gregkh>
References: <2026052855-portable-pardon-850e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Maíra Canal <mcanal@igalia.com>

[ Upstream commit 78fe02d090d38393cc00de9d1929e59426f202a4 ]

CPU jobs and CACHE CLEAN jobs execute synchronously once the DRM
scheduler starts running them. Therefore, there is no fence to wait on,
neither are those jobs able to timeout.

Hence, remove the `timedout_job` hook from the CPU and CACHE CLEAN
scheduler ops.

Reviewed-by: Iago Toral Quiroga <itoral@igalia.com>
Reviewed-by: Melissa Wen <mwen@igalia.com>
Link: https://lore.kernel.org/r/20250826-v3d-queue-lock-v3-5-979efc43e490@igalia.com
Signed-off-by: Maíra Canal <mcanal@igalia.com>
Stable-dep-of: b0fe80c0b925 ("drm/v3d: Fix use-after-free of CPU job query arrays on error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/v3d/v3d_sched.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/v3d/v3d_sched.c b/drivers/gpu/drm/v3d/v3d_sched.c
index c9c88d3ad6698..63564266135f6 100644
--- a/drivers/gpu/drm/v3d/v3d_sched.c
+++ b/drivers/gpu/drm/v3d/v3d_sched.c
@@ -684,6 +684,7 @@ v3d_cpu_job_run(struct drm_sched_job *sched_job)
 	trace_v3d_cpu_job_end(&v3d->drm, job->job_type);
 	v3d_job_update_stats(&job->base, V3D_CPU);
 
+	/* Synchronous operation, so no fence to wait on. */
 	return NULL;
 }
 
@@ -699,6 +700,7 @@ v3d_cache_clean_job_run(struct drm_sched_job *sched_job)
 
 	v3d_job_update_stats(job, V3D_CACHE_CLEAN);
 
+	/* Synchronous operation, so no fence to wait on. */
 	return NULL;
 }
 
@@ -786,7 +788,7 @@ v3d_render_job_timedout(struct drm_sched_job *sched_job)
 }
 
 static enum drm_gpu_sched_stat
-v3d_generic_job_timedout(struct drm_sched_job *sched_job)
+v3d_tfu_job_timedout(struct drm_sched_job *sched_job)
 {
 	struct v3d_job *job = to_v3d_job(sched_job);
 
@@ -827,7 +829,7 @@ static const struct drm_sched_backend_ops v3d_render_sched_ops = {
 
 static const struct drm_sched_backend_ops v3d_tfu_sched_ops = {
 	.run_job = v3d_tfu_job_run,
-	.timedout_job = v3d_generic_job_timedout,
+	.timedout_job = v3d_tfu_job_timedout,
 	.free_job = v3d_sched_job_free,
 };
 
@@ -839,13 +841,11 @@ static const struct drm_sched_backend_ops v3d_csd_sched_ops = {
 
 static const struct drm_sched_backend_ops v3d_cache_clean_sched_ops = {
 	.run_job = v3d_cache_clean_job_run,
-	.timedout_job = v3d_generic_job_timedout,
 	.free_job = v3d_sched_job_free
 };
 
 static const struct drm_sched_backend_ops v3d_cpu_sched_ops = {
 	.run_job = v3d_cpu_job_run,
-	.timedout_job = v3d_generic_job_timedout,
 	.free_job = v3d_cpu_job_free
 };
 
-- 
2.53.0

