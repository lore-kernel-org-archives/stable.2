Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CF2341A554
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:17:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211837; cv=none; b=pGCAeaOrtWd/okzdVJAv+Q/iF0iSiO9EGqN/mqniokcfX54ATezRWfFapA+C1OWYS4kBRfunTD0pdjXpaflMsTjfuyB5YX8rULs6rKLUI59v8uiLSPevk7gQ5RWM3PSY1F42oJ7OWUXw5zkWuwfJZhJdDiwAWBxuI1TWOcxaUi0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211837; c=relaxed/simple;
	bh=BYB2sgvzDWijq5ZRQV8HFeJrbcgacskJb1N5Ce8EKI8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=pqF0xNzBPJoCVsZPGOIxRc0x8uNoZ2yNIXj1dwH5DqIfxopgY5rb9v8C0loeI12STAQaev0ERbQ4bA4jV9RIFjuZ76qTZOcLtbF+MKHE7ncZk3D85tuzTUf3acHNYQPyoBo1ZMmvnq70La3B/VSQNiiebd3G7mZD+eXa4JZ2PBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eYpC9mPS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eYpC9mPS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB6AB1F00893;
	Sat, 12 Sep 2026 11:17:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211836;
	bh=Gj1DtSg80CUuyC2I27Mqp2FveGaUPAaJgURRgwzbMOA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=eYpC9mPS6mfvpLL2GgKxDO10EUx2p8kgkHadUm0kaFwgyW9FLBrcWj4zlFsyCtqHi
	 fqcSAFKQc69JFt00liXPYY0F+cs23gmM+7h4kIt9KsZlwQfaNu8AFlr5LaIntmCQ9t
	 2FlVjSDWKySs+voNiFRxZxbv4mNkMNwdFTQ3gtXZjXV0grsREnIoAwpcB7sKZCvxZ/
	 QP9oh1sbL0M2uEYO9eDRT+HLhXbSGXjG0z3T/unNh7/1jUlDv7+hxv3J/+KCtdOYmA
	 Ct1jUEpFdhg0TNBOgmD74OYWGialj7x0giT/RJpI4ThgMrCzoVRaC7scmOREYBvySn
	 1HU9Yib3cpWeg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 4/6] drm/amdgpu: Make amdgpu_vm_flush() non-failing in submission path
Date: Sat, 12 Sep 2026 07:17:09 -0400
Message-ID: <20260912111711.2285466-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912111711.2285466-1-sashal@kernel.org>
References: <2026090943-snugness-plexiglas-e964@gregkh>
 <20260912111711.2285466-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>

[ Upstream commit 37872d06f85f0349e7b1f0680aea77326f7c135e ]

amdgpu_vm_flush() is used during job submission and is not expected to
fail. Convert it to return void and simplify the caller.

Initialize the COND_EXEC patch location to 0 so it is safe to call
amdgpu_ring_patch_cond_exec() when init_cond_exec is not supported.

Suggested-by: Christian König <christian.koenig@amd.com>
Cc: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Srinivasan Shanmugam <srinivasan.shanmugam@amd.com>
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 6760f5cb12d2 ("drm/amdgpu: avoid force-completing uninitialized UVD rings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c |  9 ++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 10 +++-------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h |  2 +-
 3 files changed, 6 insertions(+), 15 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index 908401ad5cdc4..97552c74e4552 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -208,13 +208,8 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		dma_fence_put(tmp);
 	}
 
-	if (job) {
-		r = amdgpu_vm_flush(ring, job, need_pipe_sync);
-		if (r) {
-			amdgpu_ring_undo(ring);
-			goto free_fence;
-		}
-	}
+	if (job)
+		amdgpu_vm_flush(ring, job, need_pipe_sync);
 
 	amdgpu_ring_ib_begin(ring);
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 6aae94ca7dcb9..11f58995bf526 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -760,12 +760,9 @@ bool amdgpu_vm_need_pipeline_sync(struct amdgpu_ring *ring,
  * @need_pipe_sync: is pipe sync needed
  *
  * Emit a VM flush when it is necessary.
- *
- * Returns:
- * 0 on success, errno otherwise.
  */
-int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
-		    bool need_pipe_sync)
+void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
+		     bool need_pipe_sync)
 {
 	struct amdgpu_device *adev = ring->adev;
 	struct amdgpu_isolation *isolation =
@@ -811,7 +808,7 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 
 	if (!vm_flush_needed && !gds_switch_needed && !need_pipe_sync &&
 	    !cleaner_shader_needed)
-		return 0;
+		return;
 
 	amdgpu_ring_ib_begin(ring);
 
@@ -902,7 +899,6 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 	}
 
 	amdgpu_ring_ib_end(ring);
-	return 0;
 }
 
 /**
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index 076d9a3a5e624..b06199eaf42fe 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -516,7 +516,7 @@ int amdgpu_vm_validate(struct amdgpu_device *adev, struct amdgpu_vm *vm,
 		       struct ww_acquire_ctx *ticket,
 		       int (*callback)(void *p, struct amdgpu_bo *bo),
 		       void *param);
-int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
+void amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job, bool need_pipe_sync);
 int amdgpu_vm_update_pdes(struct amdgpu_device *adev,
 			  struct amdgpu_vm *vm, bool immediate);
 int amdgpu_vm_clear_freed(struct amdgpu_device *adev,
-- 
2.53.0

