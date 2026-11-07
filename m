Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050799;
	b=z7Ka+DeYYCMFS4PpwkaKfejlfDgW+v0Zq3tWbIaziDep1k1K0cZHCv+e1IfWoRj33CLe
	 7Aa5PSipwij7JVLNhbhYvvgCrojNUkL5FkDiCJLjO/J7q83xwegSjUDexax79AmjD+BnR
	 BYcyPDSAO90QhENtbXULZR54o5G4eijIh+VRwXBEVMpZDGslbbFZ0gUCvEWAUW7Ti1AUo
	 MGp3ElVZ24jjk408ErsmHfEBBrwnkhP3hKSPBjtFW6o2qHvqUETtXbGgSKv7nQBJ4nLRw
	 mp1rTabxRNOrqTBwHSHKgBHLTZn1QhVZwEPw7qRfwy1UR7oA32RiF92ID+CX+LQV5Aw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050799;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XWqi04sHPPVfe8k1RxitrrPf1ep0/ZTDt3zGPDfWr98=;
	b=TyjtaBLcGWIKVs1x75w5ngV9A30BIXmnTTktsUD2G44wIrfHoyJQ6sEyLtvH9DxmAos/
	 Fn1v1OXv24bkT2nHZlY+787yPBEc0+ik6P1NIACTC5L8PytjAL5FiWpYxzkdEFiSTovXX
	 4+c8vujF0OYMgvZkixspdoN49alKSb+xXEYK8+Cp6e+Wvsig88BExppx+oSMDBK3Zv0ta
	 yPxMYqoSoh8Rt4KISK3eYwdt+naNf5lq0+D95NkLBVfbUMuHBaZTDoTat8t9fdahDALzs
	 6OAa6GIETtFxcj5LQzYyXzcnuIX9CJIIX7I2+pCkKrJaLAE6ycqFmqzAwU8h6fJL+pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPZm6b45;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75BAC606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:26:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RPZm6b45
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 798D01F008A2;
	Sat,  7 Nov 2026 11:26:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050799;
	bh=XWqi04sHPPVfe8k1RxitrrPf1ep0/ZTDt3zGPDfWr98=;
	h=From:To:Cc:Subject:Date;
	b=RPZm6b45hcu5zJiOJAS680jQwfiuOS3t4z9qPtTDXQ7VpYXaHguAVeyqYWRsl6GuF
	 G0kKaOBBn2MXRd+bYItC1FkCHBIiZ290HagKMJgPQFD35vuSJaMVCevzJJduF6P52Q
	 Mnr8TX2XCT6+fH1w1I3BlYNGUCB8BOKczt/yf9jb83ocJEJJhJu5cO7x0N70yCmv0p
	 mJRWFZ1eGPBXd54pPOnbMLhznN3mIugo1rRZEc0O5mdVnD4OxSsnHKs98XfM+GVUHN
	 1Eq3o2APgQEkVMRVqeo8VMzfaTOo19Rkzvl6p3vH5LhR1Vyi/2WpzWHDqK1mUuyH+d
	 IuXWyNABIlYOA==
From: Sasha Levin <sashal@kernel.org>
To: daniel.phillips@amd.com,
	felix.kuehling@amd.com,
	alexander.deucher@amd.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] amdkfd: Fix memory availability double accounting of kfd pinned objects" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:26:37 -0500
Message-ID: <20261107062637-failed-5.10-16df12d7158f@kernel.org>
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

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 16df12d7158fb55f20d6e985abd1996cbabab9f8
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107062637-failed-5.10-16df12d7158f@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 16df12d7158fb55f20d6e985abd1996cbabab9f8 Mon Sep 17 00:00:00 2001
From: Daniel Phillips <daniel.phillips@amd.com>
Date: Sun, 5 Mar 2023 22:54:35 -0800
Subject: [PATCH] amdkfd: Fix memory availability double accounting of kfd
 pinned objects

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
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index e3da382ceb3c0..a53d7e4a1eb5c 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -106,6 +106,7 @@ struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	int64_t vram_used[MAX_XCP];
 	uint64_t vram_used_aligned[MAX_XCP];
+	atomic64_t vram_pinned;
 	bool init_complete;
 	struct work_struct reset_work;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 9a7e14a3c7197..129acb88dc11e 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1536,6 +1536,11 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
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
@@ -1558,6 +1563,11 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
 		return;
 
 	amdgpu_bo_unpin(bo);
+
+	if (bo->tbo.resource->mem_type == TTM_PL_VRAM)
+		atomic64_sub(amdgpu_bo_size(bo),
+			&amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+
 	amdgpu_bo_unreserve(bo);
 }
 
@@ -1679,6 +1689,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 		vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
 			- adev->kfd.vram_used_aligned[xcp_id]
 			- atomic64_read(&adev->vram_pin_size)
+			+ atomic64_read(&adev->kfd.vram_pinned)
 			- reserved_for_pt
 			- reserved_for_ras;
 
-- 
2.53.0




