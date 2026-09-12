Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9459346EF77
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:17:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211836; cv=none; b=CtdkTpF5TvUbTyZyOCdkVJMRHZB32lmIrVFPqck1N9vlp/e3ciK3M7rp5U0e0crElK/l/GYfsWmquPDvgWYvnPYpxUdjZ8ibwVqBDosTUIOu9iZKkSH+404FX7Rt9djGEsjs4NHA6h3nEbwqpOAB0VZUlKJy3/2zz6tTMb7JJQw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211836; c=relaxed/simple;
	bh=qmr37u0NuX19B5BzE+kyyLAzAoFQmfwMr2Ua/zdKtjM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nep7F+JGhCQdXxDHJekadmg+rdPljERid+epxAvFxNPGjl5oQyFwo4/4DKzhrVGoeYhRWZNiR4yfwOCvmY5OM+KK/KbFutQEhHGdxrgcX0fhPBmItq33ZFrftOeEsrPNNVbJ9fEV9QiVeQRTjh96MxVEdunAQqnoYJ0AOyiZwGA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HePWhu0e; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HePWhu0e"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E6B1F00898;
	Sat, 12 Sep 2026 11:17:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211835;
	bh=W+pK+bVsGVjird2Ffrac7BwFjWe2+x53X/yau/nQSgg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=HePWhu0et77q6wgacWho7+cSK487S69FlDz6qExHWVCguZ3E4imtakUYwbupsdrjw
	 5N784tve9HV2o+MtIyNdsTk+BhZzH8/yGoY+FVWl+DZQXz7kOcdlZhCxYnetnQ//ny
	 EnWpX4ItRdaj8ASv9GLXhhtfFcQ2/JsTZXbNG7y7fJP34TrF9qw+69EkF0lTaJMyPG
	 QAKrWlP5/914euERcIbUA3kJGn02cCaKL0rJ8TcvCdO+UKvMMs0Y5ISbaH3A0I6v6t
	 nxhj8nC8KSYJLFlNja2cW7r3YyB/N/X1fAJXgSuI7/HFLf9B80eVXqMA8CLaGk4gbr
	 S1tfjRAxq2+bA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Alex Deucher <alexander.deucher@amd.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/6] drm/amdgpu: reorder IB schedule sequence
Date: Sat, 12 Sep 2026 07:17:08 -0400
Message-ID: <20260912111711.2285466-3-sashal@kernel.org>
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
Content-Transfer-Encoding: 8bit

From: Alex Deucher <alexander.deucher@amd.com>

[ Upstream commit d3499de3b737f3f6a2058382f7bff641c74f52a4 ]

This reorders the IB schedule sequence to cleanly
separate the vm operation from the IB submission.
This makes the two independent so we can cleanly
associate each one with its respective fence.

v2: fixes for VCN

Acked-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 6760f5cb12d2 ("drm/amdgpu: avoid force-completing uninitialized UVD rings")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c | 22 +++++++++++-----------
 drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c | 11 +++++++++++
 2 files changed, 22 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
index f0ba6ac431632..908401ad5cdc4 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ib.c
@@ -208,16 +208,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 		dma_fence_put(tmp);
 	}
 
-	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
-		ring->funcs->emit_mem_sync(ring);
-
-	if (ring->funcs->emit_wave_limit &&
-	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
-		ring->funcs->emit_wave_limit(ring, true);
-
-	if (ring->funcs->insert_start)
-		ring->funcs->insert_start(ring);
-
 	if (job) {
 		r = amdgpu_vm_flush(ring, job, need_pipe_sync);
 		if (r) {
@@ -228,6 +218,16 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 
 	amdgpu_ring_ib_begin(ring);
 
+	if (ring->funcs->insert_start)
+		ring->funcs->insert_start(ring);
+
+	if ((ib->flags & AMDGPU_IB_FLAG_EMIT_MEM_SYNC) && ring->funcs->emit_mem_sync)
+		ring->funcs->emit_mem_sync(ring);
+
+	if (ring->funcs->emit_wave_limit &&
+	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
+		ring->funcs->emit_wave_limit(ring, true);
+
 	if (ring->funcs->emit_gfx_shadow && adev->gfx.cp_gfx_shadow)
 		amdgpu_ring_emit_gfx_shadow(ring, shadow_va, csa_va, gds_va,
 					    init_shadow, vmid);
@@ -312,6 +312,7 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	    ring->hw_prio == AMDGPU_GFX_PIPE_PRIO_HIGH)
 		ring->funcs->emit_wave_limit(ring, false);
 
+	amdgpu_ring_ib_end(ring);
 	/* Save the wptr associated with this fence.
 	 * This must be last for resets to work properly
 	 * as we need to save the wptr associated with this
@@ -320,7 +321,6 @@ int amdgpu_ib_schedule(struct amdgpu_ring *ring, unsigned int num_ibs,
 	 */
 	amdgpu_fence_save_wptr(*f);
 
-	amdgpu_ring_ib_end(ring);
 	amdgpu_ring_commit(ring);
 
 	return 0;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index d9f6a42859822..6aae94ca7dcb9 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -814,6 +814,17 @@ int amdgpu_vm_flush(struct amdgpu_ring *ring, struct amdgpu_job *job,
 		return 0;
 
 	amdgpu_ring_ib_begin(ring);
+
+	/* There is no matching insert_end for this on purpose for the vm flush.
+	 * The IB portion of the submission has both.  Having multiple
+	 * insert_start sequences is ok, but you can only have one insert_end
+	 * per submission based on the way VCN FW works.  For JPEG
+	 * you can as many insert_start and insert_end sequences as you like as
+	 * long as the rest of the packets come between start and end sequences.
+	 */
+	if (ring->funcs->insert_start)
+		ring->funcs->insert_start(ring);
+
 	if (ring->funcs->init_cond_exec)
 		patch = amdgpu_ring_init_cond_exec(ring,
 						   ring->cond_exe_gpu_addr);
-- 
2.53.0

