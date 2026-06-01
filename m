Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC49739E194
	for <stable@vger.kernel.org>; Mon,  1 Jun 2026 13:17:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780319849; cv=none; b=t8KwzLPTBAmRdjocVZpRKgcKBeBTALjbhB80Wb1QBH8BYGSbM9EEMk/eHNabJboNobdRwl+qR98m45SZJT7M+B5NVnYemHqasa4VDgwZb776/yUW6/KHyIs0iRXkyr2x0xooHI6DTTLtXQH9+ooVO2oMf0Fp9BzcthwUKnP0MQk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780319849; c=relaxed/simple;
	bh=qoubM5vwrZ4rKD2RLxYdjy7Hk1EvFtCEA91xXfPQyL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Z2Wd+Lq58qBeeSKEaO4XTMviDy9Szei6ZTduYpLTgrvbPbcbshwHWpVQujJSjP8MBOJB0mM66azyELEuHZURNoE9eY2qX43Y/GqQb2o5p6r5TimLwqE5LWy+jZfLNVD9gmQqQV+Lw3+yQKYWzYLVlu2PQY//ZPcIPuAgvrg7OHI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWcrLIGP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWcrLIGP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6BC1F00899;
	Mon,  1 Jun 2026 13:17:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780319847;
	bh=OkCF5REwrlSof8aRd/cawuTeHQEPAXc+AUd0Xcju8uY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RWcrLIGPon/DpLAu929ypmyBLdpXYIN50GRj841EIkMhbpUMuVD8SxZHR4C6gDFqm
	 NFmwA4gmNm4dtXZYhtd/lQ4OguWyyVm2wvOBSIekv39b2F8LBqwaj+++luLDYQK6Ba
	 AlhGe431QRkFbNRucndzvsbAOABpiSNJKZk+nnlznNlVNG3BtgYZ+4lgZJrGMkYXqR
	 CDfFIBivhAirBTR2qBphUgL/XsLeR81sZ2DpxSzJE4eJJ2FCDqh/alPpIEqLZLfFOr
	 j6mEL6JrjgCbhXXjmMMjEOA1+Y9J0por1I7JOobmYIT4gKsPLJH82nPXxxMnDq3rR3
	 DPFovyqMhpY7w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Ma=C3=ADra=20Canal?= <mcanal@igalia.com>,
	Iago Toral Quiroga <itoral@igalia.com>,
	Melissa Wen <mwen@igalia.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/3] drm/v3d: Synchronous operations can't timeout
Date: Mon,  1 Jun 2026 09:17:23 -0400
Message-ID: <20260601131725.780793-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026052815-arose-kabob-9b34@gregkh>
References: <2026052815-arose-kabob-9b34@gregkh>
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
Stable-dep-of: 6eb6e5acafa4 ("drm/v3d: Release indirect CSD GEM reference on CPU job free")
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

