Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 572813FA5F0
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 20:19:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789589973; cv=none; b=eNUinkd0hCmCRieyIqxnxo0hdghfc1JI9mAy2s1qGjtH0yMfADPwN86r6RNLirwxatn6cpdPYuUv99TpTR+YjJpSjFWT6PaZjKZ7qYEfDbD07g/NODRk/Zglz08sL+CP1n9sC79cxAkQ2Hu3XNx6bfE/0sMVCeLg1QvRKs+KkpM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789589973; c=relaxed/simple;
	bh=Qxj8pkTYBjr+D4F4r/5zh//kVjpnGLEq/F0BrREgnjY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kyBNxbCDS0ydeo6y1nwrogKjkVZURUPxjpJsUDfMN/4Yd/CMx9RzxJs4EirNFWoGqrLccXotGrNPx5RJ8H9+DXraDQ3ZjkEI40AoCOsH3GETAFkjD6E7Khj9O61QGOn0nPDBebjBsCWt/wHTAny0BJhcL5jKcu9TLNZHkQF8hO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YpvAF7Sb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YpvAF7Sb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97D4F1F000FF;
	Wed, 16 Sep 2026 20:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789589961;
	bh=DFHnOhymQeiqNDBeSYLnhbErJQI836K9wh1G/8xyD6g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YpvAF7SbmbL1+F5jmMxqZfdeTIAyDhsz+ySabCafBWtzbN8pOkfTwg7RAmbcgze/C
	 916yiJORiPGkbZQAtJ3Qy/Kk7Iif6Ul4vTGm+65jv3Ex5wG5RyF3vAAfW6sHK2Z//6
	 wfA6UUTNu1F+onidahAr8aNbb5SsSealQu49BEx4a+F4FZxwsKjt9+Qc3Dny241FR9
	 BDfUN2jynm8TtqU+zxRu60G8LXuvZgbewbkcbl31z2ZPEaZ4uBDW7mbOL5rrZdv5XK
	 RjIJ/9TxIhNby/Eyn2+huL+VOAZRV8JYECwzVEsOEIHnRj10SXU+BHlXs/su4BmoBD
	 QUXTXeFbn4t2Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] drm/amdgpu: skip the VMID 0 flush for VRAM
Date: Wed, 16 Sep 2026 16:19:19 -0400
Message-ID: <20260916201919.2504540-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026091637-whole-improve-e7e2@gregkh>
References: <2026091637-whole-improve-e7e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>

[ Upstream commit 87ceb8cba73d0b3c4025ff42495bccd8164acaed ]

Clear-on-release only runs on VRAM, which amdgpu_ttm_map_buffer() reaches
via its direct MC address without programming a GART window, yet the wipe
still forces a VMID 0 flush. On GFX11 (e.g. Navi33) that spurious SDMA
flush can wedge the engine; only flush when a GART window is actually used.

v2: Let amdgpu_ttm_map_buffer() return whether the VMID 0 flush is needed,
    and drive the clear and copy paths from that. (Christian)
v3: Make the vm_needs_flush output parameter mandatory instead of
    allowing NULL. (Christian)

Fixes: a68c7eaa7a8f ("drm/amdgpu: Enable clear page functionality")
Closes: https://gitlab.freedesktop.org/drm/amd/-/work_items/5413
Cc: Christian König <christian.koenig@amd.com>
Signed-off-by: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Reviewed-by: Christian König <christian.koenig@amd.com>
Reviewed-by: Timur Kristóf <timur.kristof@gmail.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit a306e406e570b74318ff7d80e5b07b540ca1d3a9)
Cc: stable@vger.kernel.org
[ adapted entity-based calls to older ring-based interfaces with separate clear and fill functions. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 30 ++++++++++++++++++-------
 1 file changed, 22 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 60c5e8803f60c..61867175c836a 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -174,6 +174,8 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
  * @tmz: if we should setup a TMZ enabled mapping
  * @size: in number of bytes to map, out number of bytes mapped
  * @addr: resulting address inside the MC address space
+ * @vm_needs_flush: out, set true if a GART window was programmed (VMID 0 flush
+ *		    needed) or false for a direct address
  *
  * Setup one of the GART windows to access a specific piece of memory or return
  * the physical address for local memory.
@@ -182,7 +184,8 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 				 struct ttm_resource *mem,
 				 struct amdgpu_res_cursor *mm_cur,
 				 unsigned int window, struct amdgpu_ring *ring,
-				 bool tmz, uint64_t *size, uint64_t *addr)
+				 bool tmz, uint64_t *size, uint64_t *addr,
+				 bool *vm_needs_flush)
 {
 	struct amdgpu_device *adev = ring->adev;
 	unsigned int offset, num_pages, num_dw, num_bytes;
@@ -203,9 +206,12 @@ static int amdgpu_ttm_map_buffer(struct ttm_buffer_object *bo,
 	if (!tmz && mem->start != AMDGPU_BO_INVALID_OFFSET) {
 		*addr = amdgpu_ttm_domain_start(adev, mem->mem_type) +
 			mm_cur->start;
+		*vm_needs_flush = false;
 		return 0;
 	}
 
+	/* A GART window is programmed below, so its VMID 0 TLB needs a flush */
+	*vm_needs_flush = true;
 
 	/*
 	 * If start begins at an offset inside the page, then adjust the size
@@ -314,6 +320,7 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 	while (src_mm.remaining) {
 		uint64_t from, to, cur_size, tiling_flags;
 		uint32_t num_type, data_format, max_com, write_compress_disable;
+		bool src_vm_flush, dst_vm_flush;
 		struct dma_fence *next;
 
 		/* Never copy more than 256MiB at once to avoid a timeout */
@@ -321,12 +328,14 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 
 		/* Map src to window 0 and dst to window 1. */
 		r = amdgpu_ttm_map_buffer(src->bo, src->mem, &src_mm,
-					  0, ring, tmz, &cur_size, &from);
+					  0, ring, tmz, &cur_size, &from,
+					  &src_vm_flush);
 		if (r)
 			goto error;
 
 		r = amdgpu_ttm_map_buffer(dst->bo, dst->mem, &dst_mm,
-					  1, ring, tmz, &cur_size, &to);
+					  1, ring, tmz, &cur_size, &to,
+					  &dst_vm_flush);
 		if (r)
 			goto error;
 
@@ -354,7 +363,8 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 		}
 
 		r = amdgpu_copy_buffer(ring, from, to, cur_size, resv,
-				       &next, false, true, copy_flags);
+				       &next, false, src_vm_flush || dst_vm_flush,
+				       copy_flags);
 		if (r)
 			goto error;
 
@@ -2311,6 +2321,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 	struct amdgpu_res_cursor cursor;
+	bool vm_needs_flush = false;
 	u64 addr;
 	int r = 0;
 
@@ -2338,12 +2349,13 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_bo *bo,
 		size = min(cursor.size, 256ULL << 20);
 
 		r = amdgpu_ttm_map_buffer(&bo->tbo, bo->tbo.resource, &cursor,
-					  1, ring, false, &size, &addr);
+					  1, ring, false, &size, &addr,
+					  &vm_needs_flush);
 		if (r)
 			goto err;
 
 		r = amdgpu_ttm_fill_mem(ring, 0, addr, size, resv,
-					&next, true, true,
+					&next, vm_needs_flush, true,
 					AMDGPU_KERNEL_JOB_ID_TTM_CLEAR_BUFFER);
 		if (r)
 			goto err;
@@ -2370,6 +2382,7 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 	struct amdgpu_ring *ring = adev->mman.buffer_funcs_ring;
 	struct dma_fence *fence = NULL;
 	struct amdgpu_res_cursor dst;
+	bool vm_needs_flush = false;
 	int r;
 
 	if (!adev->mman.buffer_funcs_enabled) {
@@ -2388,12 +2401,13 @@ int amdgpu_fill_buffer(struct amdgpu_bo *bo,
 		cur_size = min(dst.size, 256ULL << 20);
 
 		r = amdgpu_ttm_map_buffer(&bo->tbo, bo->tbo.resource, &dst,
-					  1, ring, false, &cur_size, &to);
+					  1, ring, false, &cur_size, &to,
+					  &vm_needs_flush);
 		if (r)
 			goto error;
 
 		r = amdgpu_ttm_fill_mem(ring, src_data, to, cur_size, resv,
-					&next, true, delayed, k_job_id);
+					&next, vm_needs_flush, delayed, k_job_id);
 		if (r)
 			goto error;
 
-- 
2.53.0

