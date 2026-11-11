Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794365495;
	b=LuBaQWKTYE74LjcIKNzvIMzW6WM8VRCK8t9YCbMC5bMQ5vf+I4BR+ZEso6GhYwsdPTZJ
	 gjO6ah+LeKtJEPzc7hMSLlGSlRV5VLGa/AFi62sgi7ipCZayxAjiwbxkBviO5E08X5joW
	 Uy1sDsQWYQh2poyPRevFYPOGzhbPuecTpztLVFQBEhlWE8ECqIpoIfYTv7SQWTqwQeVcF
	 0AkCdsMvZohKg230MuZccUrUJnW0QE8ZieoLTtxeg9P/OSqjt05PyweEFXJu7Dx3N6i5z
	 dMK+VJ3dRur4tRqtF0QJU3OVSf2pAMKeoeP0poUDWAxKV0geOSM72EBkD1oZPtMd8hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794365495;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UOv/eMWTxgpvmKKFgN9FiWvMmb2hYk65tinDXmfKE60=;
	b=D6nJn413vquwymE6CzM/eF1jla0hdfpiKE2XCxD1dbMhU2n8SW+a/hEP7I79xe2n6ukV
	 7RDvUbtSH3VR1tzkBiIMi0+gU9tnbZRszWPFG9mEUn9N17rc+/X+TM0h9HQy8CiliKdV3
	 Ojo25/KVgDJ8fOjqYdAQIlujfuOtFMz8H28hGTG6BsYuQwHzXyCCNLjpqfUEofxKf+oIN
	 aUb19qAITLxpLLzgltAMYSxwahrlI6iynhUXw9+nx8duq8l0MH2GMtE3Ft4GZxNiiAfAn
	 UtQcWFQkzv+xZMmQDaJeLJnKDik7XS5kyP10xfLggdtR54T2s9Fm8BcOnhmuyRgHo4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSyGhHXJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBAD3606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 02:51:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bSyGhHXJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D33A91F0089F;
	Wed, 11 Nov 2026 02:51:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794365495;
	bh=UOv/eMWTxgpvmKKFgN9FiWvMmb2hYk65tinDXmfKE60=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bSyGhHXJet3Vtn1Ejyvnd99D13VZk6qDiyj3gRdJbnHHCuB2SMNFx8v5SGZuCHMWx
	 VXLAQLXyWN2MVu/8lwQa+6MXOy6Q4SnRtWr8zb7vrcokkiNf4498oRKrNCzfwo9CoR
	 oqXpXA0PmNNHRTmkauIIJMRJYbxaBdv/AcWqmSyYQJlm1QxlDSYWR8G0NUViRBB6QB
	 XrwmtyJiSQeVidK3bT5GhbnogtDuPRmkBXDvChTrj6Yojg0Bn6/wiWCtdlCtxc3aRO
	 D502eDg6E6pp+1MpedxaIc5NKvsK9Q9D8Azr52KeC1AbTWebXa0wTQCgGizcJEtlRK
	 EsoD2N2UQ73dQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Phillips <daniel.phillips@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] amdkfd: Fix memory availability double accounting of kfd pinned objects
Date: Tue, 10 Nov 2026 21:51:33 -0500
Message-ID: <20261111025055.736799-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052458-failed-6.12-16df12d7158f@kernel.org>
References: <20261107052458-failed-6.12-16df12d7158f@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Phillips <daniel.phillips@amd.com>

[ Upstream commit 16df12d7158fb55f20d6e985abd1996cbabab9f8 ]

Pinned objects that are not kfd objects reduce the total vram available
to kfd, so we subtract the total size of pinned objects from kdf vram
availability. However this double counts objects pinned by kfd itself,
because they are counted both as used and pinned. So track the total
size of objects pinned by kfd and add it back to kfd availability to
remove the double accounting.

Signed-off-by: Daniel Phillips <daniel.phillips@amd.com>
Reviewed-by: Felix Kuehling <Felix.Kuehling@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit b8257bdb26ca5d9a75f4b81f629422f17afa221b)
Cc: stable@vger.kernel.org
[ sashal: adjusted indentation to fit the unconditional VRAM availability calculation without the upstream APU-specific conditional ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index d79c431de2234..b921587d428cc 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -103,6 +103,7 @@ struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	int64_t vram_used[MAX_XCP];
 	uint64_t vram_used_aligned[MAX_XCP];
+	atomic64_t vram_pinned;
 	bool init_complete;
 	struct work_struct reset_work;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index ef4d8dca3c7af..55834719e9848 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1500,6 +1500,11 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
 		pr_err("Error in Pinning BO to domain: %d\n", domain);
 
 	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
+
+	if (!ret && bo->tbo.resource->mem_type == TTM_PL_VRAM)
+		atomic64_add(amdgpu_bo_size(bo),
+			&amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+
 out:
 	amdgpu_bo_unreserve(bo);
 	return ret;
@@ -1522,6 +1527,11 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
 		return;
 
 	amdgpu_bo_unpin(bo);
+
+	if (bo->tbo.resource->mem_type == TTM_PL_VRAM)
+		atomic64_sub(amdgpu_bo_size(bo),
+			&amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+
 	amdgpu_bo_unreserve(bo);
 }
 
@@ -1681,6 +1691,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 	vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
 		- adev->kfd.vram_used_aligned[xcp_id]
 		- atomic64_read(&adev->vram_pin_size)
+		+ atomic64_read(&adev->kfd.vram_pinned)
 		- reserved_for_pt
 		- reserved_for_ras;
 
-- 
2.53.0

