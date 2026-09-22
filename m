Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F329837DEBF
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:48:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106507; cv=none; b=FktiVMj/TJUfEeE9ypJDG3LIbKd8kjnrrae+NYKQ3vF69rtdcY63YaOJrLFbRhoU7g9PCc+JSleQOth49gXNjErkW27ORTOic2nkj8ZMKfFol0PC8YId3dbxyEVXAdW1Qv/eDPhGNdSZUuokhTNO2lZkDsppoyqwJ4wFzwbeQ/k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106507; c=relaxed/simple;
	bh=uaFQ/n+kcMzFd2pTcOiTKtySyx0v/pS2ZRNP8OnR6m8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ejh08ocvb/9IG29rdycofQAkkGvpoguK9axaLXr+3/ktJrVKuwHhBdtWYzRZDOE7YLLmPERUikcGSkY2P0kXCUI4fe8YFqIgptL1yT2CODgl8iooJi74AYco/F9Z7bB+cDBOMUkUJ3ajXyZNGncP7Qu8L0NI9bu3bDbOYJgLeXs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gnkzrF7I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gnkzrF7I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 507C21F000FF;
	Tue, 22 Sep 2026 19:48:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790106505;
	bh=29h+LJMuz6zV44UvAtvBdZNluPm4Yb4T3F4qlDFuYtc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gnkzrF7IPbrcUj+XRj7CPxFi/IDyuwUgbj5+KqS/rVl9Rp1gduJGuU5Tj0OILuPmf
	 6awX2wfSLjhnjZS+/1BMcnqyLbFUcMHw7cU0AKBS+PgnyzDdtPBXxOHIbChQDO/wwJ
	 PvTVe/JsP2q5LiA8ikNqZxrEY7YzhR26Rs44s2D/pnUIEQoUU/psWK4dSUjUgrDYd3
	 tNytqkOACVCCiivcLq9EtcvGbdit7ROH6mIfiEpAIaif7CQUwNTQ1uBDaDy+s1yq8J
	 H2lnb0TuPi2x1sVaJWjUqycL4nwTLRYZ6nMZ7EUIrA13txNsXXvdqJvPHQRxde1obj
	 wDvjOvBdUCcjw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrew Martin <Andrew.Martin@amd.com>,
	Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/5] drm/amdgpu: Failed to check various return code
Date: Tue, 22 Sep 2026 15:48:19 -0400
Message-ID: <20260922194824.87651-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092241-jolliness-reputable-efa6@gregkh>
References: <2026092241-jolliness-reputable-efa6@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrew Martin <Andrew.Martin@amd.com>

[ Upstream commit 357ef5b3b7e98b4d21cb0abc1bde1140332c7eb8 ]

Clean up code to quiet the compiler on us failing to check the return
code.

Signed-off-by: Andrew Martin <Andrew.Martin@amd.com>
Reviewed-by: Harish Kasiviswanathan <Harish.Kasiviswanathan@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
Stable-dep-of: 5155002b03b2 ("drm/amdgpu: fix rmmio iounmap skipped on device removal")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c       |  2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 14 +++++++-------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
index b6a928a0e6ca5..9070edea1d128 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.c
@@ -368,7 +368,7 @@ void amdgpu_amdkfd_free_gtt_mem(struct amdgpu_device *adev, void **mem_obj)
 {
 	struct amdgpu_bo **bo = (struct amdgpu_bo **) mem_obj;
 
-	amdgpu_bo_reserve(*bo, true);
+	(void)amdgpu_bo_reserve(*bo, true);
 	amdgpu_bo_kunmap(*bo);
 	amdgpu_bo_unpin(*bo);
 	amdgpu_bo_unreserve(*bo);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index 850f1b61694f3..6282ff0051d92 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -722,7 +722,7 @@ kfd_mem_dmaunmap_userptr(struct kgd_mem *mem,
 		return;
 
 	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	(void)ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 
 	dma_unmap_sgtable(adev->dev, ttm->sg, direction, 0);
 	sg_free_table(ttm->sg);
@@ -771,7 +771,7 @@ kfd_mem_dmaunmap_sg_bo(struct kgd_mem *mem,
 	}
 
 	amdgpu_bo_placement_from_domain(bo, AMDGPU_GEM_DOMAIN_CPU);
-	ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
+	(void)ttm_bo_validate(&bo->tbo, &bo->placement, &ctx);
 
 	dir = mem->alloc_flags & KFD_IOC_ALLOC_MEM_FLAGS_WRITABLE ?
 				DMA_BIDIRECTIONAL : DMA_TO_DEVICE;
@@ -981,7 +981,7 @@ static int kfd_mem_attach(struct amdgpu_device *adev, struct kgd_mem *mem,
 		if (!attachment[i])
 			continue;
 		if (attachment[i]->bo_va) {
-			amdgpu_bo_reserve(bo[i], true);
+			(void)amdgpu_bo_reserve(bo[i], true);
 			if (--attachment[i]->bo_va->ref_count == 0)
 				amdgpu_vm_bo_del(adev, attachment[i]->bo_va);
 			amdgpu_bo_unreserve(bo[i]);
@@ -1251,11 +1251,11 @@ static int unmap_bo_from_gpuvm(struct kgd_mem *mem,
 		return -EBUSY;
 	}
 
-	amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
+	(void)amdgpu_vm_bo_unmap(adev, bo_va, entry->va);
 
-	amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
+	(void)amdgpu_vm_clear_freed(adev, vm, &bo_va->last_pt_update);
 
-	amdgpu_sync_fence(sync, bo_va->last_pt_update);
+	(void)amdgpu_sync_fence(sync, bo_va->last_pt_update);
 
 	return 0;
 }
@@ -2358,7 +2358,7 @@ void amdgpu_amdkfd_gpuvm_unmap_gtt_bo_from_kernel(struct kgd_mem *mem)
 {
 	struct amdgpu_bo *bo = mem->bo;
 
-	amdgpu_bo_reserve(bo, true);
+	(void)amdgpu_bo_reserve(bo, true);
 	amdgpu_bo_kunmap(bo);
 	amdgpu_bo_unpin(bo);
 	amdgpu_bo_unreserve(bo);
-- 
2.53.0

