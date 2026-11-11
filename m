Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794367129;
	b=pOhCHrl3zW6ugYmWdzQr72hO02Txi7MVp2FTPHnFbNhSSjO61rWhyPJ3mi8E9kME09rd
	 2MAuqeWslAZ0PdGUwntCYD1LOKPh9vAYcPHzIcWo/zPqYhXxf8NuT8Qrbm8iqkdDo6JsJ
	 2Ys1FMuHU3hhBM2uoVw2PYZtgsQ1tmrKSlWPoYnR8ZWpVu8EldEqcf0tq7Zf+c0jx0yyy
	 a3wfp33VF4ua29qV4yxX+3B9KohamulgWgTDakupTihkpCDLVVhKTOeb6dDMSy9VpwyaV
	 ZVPz7U42BVWm8RIkFEzrSx/XKpj2f8TIpgVPz2vS5/lAazV2uSe6qhNGiL4KbKtPzzw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794367129;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M9oOUSpY6jBcs5QnD6rHRrNPruseJQy5ijnNJvRcTkA=;
	b=eCMqprSHp/oAsXrvMQbj1Qh4mT+kpZqmi7P831Ge6Dw6RLykvKCxIJ4RkWahHXcXiFs9
	 /58Hhz3cuiNGv9dxs7+Odebyv8woZ3H1cO0q0srjXDhFcPUN1w0/I85YmnQYrjCO7CSwM
	 g0v/wzUIlCg8nIaZm2VSYsTowWBswhMAgd015u2a+fMAeaO/U8bartJS99TQHaPhpgBVs
	 eWm5MYfDyPZ4RQwhPBoBI098uZjz5sqNG+pgxY+UBQ4Tn7Oai9QMTU+EFe6GObU7NlpP4
	 sPDwfbhRqZVgi1SD0tXatUTlrS7retr8m22Imb8o16VNioDXECbtJxEJUFROzM6Q48Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdwNl0Vc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B151606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:18:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LdwNl0Vc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A99071F0089F;
	Wed, 11 Nov 2026 03:18:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794367129;
	bh=M9oOUSpY6jBcs5QnD6rHRrNPruseJQy5ijnNJvRcTkA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LdwNl0Vc3E7oZL0WUmMnD4LpjoTsDcQGNNuUV5blqtIVt1OWoBA5WVCw2w+YhG+Je
	 KiVd/G4fzgUfp2Nh3bPMnBk5GLjCVFas73x2mBvV3CPo7pK7K5OCYhe9FqU7Imr1hn
	 z7rp6l9CWmWXMc5Bt6KX1uFEvqnmGTk5sJniWqvhtIszuOZcWvnP0kuYKUBbe061Ix
	 bSCLqGTizj6Ja4y5ITF/Bikxrx7kULevD+kNbwaYGm1n9EOf1xF0n/m2msukOJEToJ
	 InkuMdd2P1Md7XpF88nGwYVJfmpGb1LxPASYDA/9R7e8bpyXs6lMCi2CMJvpbfJxD4
	 911FmxftlFang==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Phillips <daniel.phillips@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] amdkfd: Fix memory availability double accounting of kfd pinned objects
Date: Tue, 10 Nov 2026 22:18:47 -0500
Message-ID: <20261111031811.851012-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055238-failed-6.1-16df12d7158f@kernel.org>
References: <20261107055238-failed-6.1-16df12d7158f@kernel.org>
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
[ sashal: Adjusted context for scalar VRAM accounting fields instead of MAX_XCP arrays. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 86a3315098a20..ba065f7887aad 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -97,6 +97,7 @@ struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	int64_t vram_used;
 	uint64_t vram_used_aligned;
+	atomic64_t vram_pinned;
 	bool init_complete;
 	struct work_struct reset_work;
 };
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 59ea50b0962e5..dd18be88e1b84 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1451,6 +1451,11 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
 		pr_err("Error in Pinning BO to domain: %d\n", domain);
 
 	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
+
+	if (!ret && bo->tbo.resource->mem_type == TTM_PL_VRAM)
+		atomic64_add(amdgpu_bo_size(bo),
+			&amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+
 	amdgpu_bo_unreserve(bo);
 
 	return ret;
@@ -1473,6 +1478,11 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
 		return;
 
 	amdgpu_bo_unpin(bo);
+
+	if (bo->tbo.resource->mem_type == TTM_PL_VRAM)
+		atomic64_sub(amdgpu_bo_size(bo),
+			&amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+
 	amdgpu_bo_unreserve(bo);
 }
 
@@ -1638,6 +1648,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev)
 	available = adev->gmc.real_vram_size
 		- adev->kfd.vram_used_aligned
 		- atomic64_read(&adev->vram_pin_size)
+		+ atomic64_read(&adev->kfd.vram_pinned)
 		- reserved_for_pt;
 	spin_unlock(&kfd_mem_limit.mem_limit_lock);
 
-- 
2.53.0

