Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8EDD448B95
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:50:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513008; cv=none; b=aZpogSIaucTxGqcH9YQlTU5Raca11BODyx9oGJPmsBB4NshtME1fa1e2MlQ7vn378xSc5auYTR4YarZkAjMohpgr8F5CwLBhzStoCLsHQZvmvsVOqQArSLvrzwinnRyuZXQGPnxZeCFe/+se1MnkNY2oMoe/AT04fU1dMTvdtHo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513008; c=relaxed/simple;
	bh=7vs/JNvk4752corQZbwOhQCoReZIQuM0YtKCgeKCsys=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rNMmGOa2rxMpGLnLVlY0bmdZKLHdpk17wLuvT+tVdDw+rxUov3kcqEHP1G+HTwtc1bHT8FnzWNpaIjmQOqEQg2qI339MByW/ozfHZ+XyyOpfMHbpm9yHpkxw/73JjNKqb8A3lmydd0J/jECrlUgcrss7CA3A6EJP42i7FjDvOz8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fjcHKO7t; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fjcHKO7t"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C67B11F00ACA;
	Fri, 31 Jul 2026 15:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785513003;
	bh=I351mOZuiOSVYSdHYGpYekbbtH3G/CpHZibt1CLaxDM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fjcHKO7t+pbqIOvqv2uOg6tMh1V3gXytOyhb21dD/v/Qvrc6nx8Y1nzdenA4e7fmF
	 Wnm8ZXagYKXA3+B7/iZVetbPiZCLt1ZkE7eiVii6SfK23MHpZE7NjFqkzXORXYqyNl
	 lT4PGz1DB9n6nszejdr71blkIRp2tNleA+RrcNLDZkXnizYO0CbG6Ath2BgNwFOFkW
	 LkZhHXfW1rEeSMCz4kg4WdeRbK3cUZQ+pmzy1gKEqUE0qK/ESDhqwh5ETtNkeJ6HUV
	 WFP4PQDSfaYbXhuHu9cgqnRWqzq+H909dt3Ag5W0j/3WR3F3ygxgLK12XRUQ40terp
	 Dk/f5+e49pYsA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Asad Kamal <asad.kamal@amd.com>,
	Lijo Lazar <lijo.lazar@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] drm/amdgpu/gfx: fix cleaner shader IB buffer overflow
Date: Fri, 31 Jul 2026 11:49:59 -0400
Message-ID: <20260731154959.602805-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731154959.602805-1-sashal@kernel.org>
References: <2026072909-backlit-bannister-14b9@gregkh>
 <20260731154959.602805-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Asad Kamal <asad.kamal@amd.com>

[ Upstream commit 3e864bf2a32a1cbdf1e0f9c5a5a4176e8575f4a3 ]

The cleaner shader sysfs path allocates a 16-dword (64 byte) IB but
incorrectly fills (align_mask + 1) dwords. On GFX rings align_mask is
0xff, so the loop wrote 256 dwords into a 64-byte buffer, causing a
kernel page fault.

The IB only needs to be a minimal NOP shell to schedule the job; the
cleaner shader itself is emitted on the ring via emit_cleaner_shader().
Fill 16 dwords to match the allocation.

v2: Use ib_size_dw variable (Lijo)

Fixes: d361ad5d2fc0 ("drm/amdgpu: Add sysfs interface for running cleaner shader")
Suggested-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Asad Kamal <asad.kamal@amd.com>
Reviewed-by: Lijo Lazar <lijo.lazar@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit bf21af331ebf72d0935fd70c73192414a422c03a)
CC: stable@vger.kernel.org
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
index bd9ec01101b0..171603c4ee6c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_gfx.c
@@ -1426,12 +1426,13 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	struct amdgpu_device *adev = ring->adev;
 	struct drm_gpu_scheduler *sched = &ring->sched;
 	struct drm_sched_entity entity;
+	unsigned int ib_size_dw = 16;
 	static atomic_t counter;
 	struct dma_fence *f;
 	struct amdgpu_job *job;
 	struct amdgpu_ib *ib;
 	void *owner;
-	int i, r;
+	int r;
 
 	/* Initialize the scheduler entity */
 	r = drm_sched_entity_init(&entity, DRM_SCHED_PRIORITY_NORMAL,
@@ -1449,7 +1450,7 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	owner = (void *)(unsigned long)atomic_inc_return(&counter);
 
 	r = amdgpu_job_alloc_with_ib(ring->adev, &entity, owner,
-				     64, 0, &job,
+				     ib_size_dw * sizeof(uint32_t), 0, &job,
 				     AMDGPU_KERNEL_JOB_ID_CLEANER_SHADER);
 	if (r)
 		goto err;
@@ -1457,9 +1458,8 @@ static int amdgpu_gfx_run_cleaner_shader_job(struct amdgpu_ring *ring)
 	job->enforce_isolation = true;
 
 	ib = &job->ibs[0];
-	for (i = 0; i <= ring->funcs->align_mask; ++i)
-		ib->ptr[i] = ring->funcs->nop;
-	ib->length_dw = ring->funcs->align_mask + 1;
+	memset32(ib->ptr, ring->funcs->nop, ib_size_dw);
+	ib->length_dw = ib_size_dw;
 
 	f = amdgpu_job_submit(job);
 
-- 
2.53.0

