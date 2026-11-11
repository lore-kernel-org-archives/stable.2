Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794366190;
	b=QCA2L82dRKmk5bnP7EDUBljb0A5Uwppm2HGmcjDtapFvLKvCmtXnqLiRywf/bttf7Sus
	 v6oGapuVxgC3otON4NM9vjE70hPDV9L4OV40w5y79G9KOz5zI0k3qeBssH4wI51WaeKpK
	 kNBQr0aexkjRb/7CTtj6myTO0buntHKhXFx9o7D3OrfIeErezWlWDhvEK5n4aMVq6J18q
	 fRo4cKnwhkMUJqujED0AoR91gWi9ZynmWpscno/ZfXzdgTH36rjWT7SxkQQgfOIj58fKf
	 Kez19Px+C0iNmEy5SzGqtFqka2bDpUjhvm2mGvzudZk4xUPH7u0W05ye+jFZTarGbBQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794366190;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=yc/vejs4V8XyYEua+9XlPai0UzDVMqeVHizjtjg/m0o=;
	b=uQ/MjXBNAeUQUrmPsgKHZCzJEdbhAw4w1TkWFZ7UiN3enQ5gjAo2b62TKaNX7KxceFqW
	 qbi0soY1oWxYZeRpt8ubn4EdfVCnDQUJIaCleq6Fkde+i7IKLKJWVpegrk5qaxGzNCqp2
	 Hc2MCwMsd4OFIWLFZN+xdJQJSFqJ5FgPbmp58bMvgbWp892OGLGiYbty4h7OGPNM153L1
	 uXipLKVqlwnq19tpoYkqmFiDdc7Jqg7iCd9WhQHXlRJ0i1OOD2Xr413pHRoGdS1x1v2mq
	 IokpMctuQuBdFmaWHk++wrpXQpq8m0dhBd4vJy6Zb7nw6aoLrrBUIaeh14vumCtQC+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtQsTnEZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 591F5606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:03:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JtQsTnEZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 621551F0093C;
	Wed, 11 Nov 2026 03:03:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794366190;
	bh=yc/vejs4V8XyYEua+9XlPai0UzDVMqeVHizjtjg/m0o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JtQsTnEZXpFuyNrq/itwz/Zg8z/K1wNuL+upwc96IAXEDce4qf5m9TX5AmVEwZqFb
	 ZSaHBuN8d1EYCHEUwNcXFKcsqGPNo6qkeEWdDJFFyesiYs19jWiBqnKltzD92h/ZgD
	 NtNSLYV8tJvG7T9KSkD3G9LOw4IzxqYAvgIHuJNgmZHqxzXytUisIvidOS5A235zG/
	 QOdPsprV82i2zXHMGwkhFxeXDHMcGf31xr7tpDsneL7TRcRl4p9YPal9tBIaP4uPu1
	 nxT9xihwMa7uxXLjxE2iXpgKSNb57uA8E5yuk6gGzydldVhfRGSVcR3lNgGAIavht9
	 X6zbz2q2d/AcQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Phillips <daniel.phillips@amd.com>,
	Felix Kuehling <Felix.Kuehling@amd.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] amdkfd: Fix memory availability double accounting of kfd pinned objects
Date: Tue, 10 Nov 2026 22:03:08 -0500
Message-ID: <20261111030156.806288-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053741-failed-6.6-16df12d7158f@kernel.org>
References: <20261107053741-failed-6.6-16df12d7158f@kernel.org>
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
[ sashal: Adjusted context for the missing out label and the simpler VRAM calculation without APU branching or RAS accounting. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h       |  1 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c | 11 +++++++++++
 2 files changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
index 8fc55a6671841..1be8c4a676096 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd.h
@@ -100,6 +100,7 @@ struct amdgpu_kfd_dev {
 	struct kfd_dev *dev;
 	int64_t vram_used[MAX_XCP];
 	uint64_t vram_used_aligned[MAX_XCP];
+	atomic64_t vram_pinned;
 	bool init_complete;
 	struct work_struct reset_work;
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
index b2c5f99b2e57a..8237772ca9426 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_amdkfd_gpuvm.c
@@ -1432,6 +1432,11 @@ static int amdgpu_amdkfd_gpuvm_pin_bo(struct amdgpu_bo *bo, u32 domain)
 		pr_err("Error in Pinning BO to domain: %d\n", domain);
 
 	amdgpu_bo_sync_wait(bo, AMDGPU_FENCE_OWNER_KFD, false);
+
+	if (!ret && bo->tbo.resource->mem_type == TTM_PL_VRAM)
+		atomic64_add(amdgpu_bo_size(bo),
+			&amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+
 	amdgpu_bo_unreserve(bo);
 
 	return ret;
@@ -1454,6 +1459,11 @@ static void amdgpu_amdkfd_gpuvm_unpin_bo(struct amdgpu_bo *bo)
 		return;
 
 	amdgpu_bo_unpin(bo);
+
+	if (bo->tbo.resource->mem_type == TTM_PL_VRAM)
+		atomic64_sub(amdgpu_bo_size(bo),
+			&amdgpu_ttm_adev(bo->tbo.bdev)->kfd.vram_pinned);
+
 	amdgpu_bo_unreserve(bo);
 }
 
@@ -1610,6 +1620,7 @@ size_t amdgpu_amdkfd_get_available_memory(struct amdgpu_device *adev,
 	vram_available = KFD_XCP_MEMORY_SIZE(adev, xcp_id)
 		- adev->kfd.vram_used_aligned[xcp_id]
 		- atomic64_read(&adev->vram_pin_size)
+		+ atomic64_read(&adev->kfd.vram_pinned)
 		- reserved_for_pt;
 
 	if (adev->gmc.is_app_apu) {
-- 
2.53.0

