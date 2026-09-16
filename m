Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306E34DAFB8
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 18:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789583821; cv=none; b=ljN5e+2/sAwJiaHsW1TnYdIJnDDKjAMqtDqIf+zveaycm1RTN1vavPUKDRYe0TFMlhF0FdC6ffl3krx0mO2IiTag0RFUZPpTWI6+Nod8u8PTdzfltbe2oL5ZWmS7+YHbwy8dlz+qPlwTcUP/A9RjrCu5xlrBT9VmR6kt1IkAPKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789583821; c=relaxed/simple;
	bh=qXhK5lR9uekgmhF/uiGQopBFU3rS5KV3/iYYTk6GUaQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hGMokENh/DUM1rjEY/HOUoVBu/RAPCTJnZzwGbvLnCyXWk1K9dXkfrdCf6yPk11Sp0RLMLwRmW+abehbb/hPJAD5w6+prKB7TDue95V1iVVu9o9MIzVolzoA4CEcGUy/lpAFJCO3qMe8NW+w/8RhzdE4h7KALBTLkumfIBn9VcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LIOxFw7C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LIOxFw7C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5B97D1F008A0;
	Wed, 16 Sep 2026 18:36:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789583805;
	bh=b5Wegd7ML4IeFUecg5h1kDYgTyxRQf89pU1bcT11uxA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LIOxFw7CQhxqX9kJhP9zNNUmCBeBcS627tswL7yq3sYAroL8u5AQjyiYGwVkLidn1
	 7cmSEUBSRfi+LlbOBXIDE2ka/MZ8tBmlaplkwqctqKdEotYhX6F5xx3WIuelh5bZ0I
	 x9eQsyIAHyM73NP1CshqDf7lyVVW6+heSd5JgQC6oddB/od86tLBQ0CNo5FvZ5tyA2
	 oeG+5D/WTuWs/hMIx1fRIqkYXgGdyVx27yDqKyGVS//Tv1LUX2s53pyCswC/lw4XHa
	 f1YCkINU/D1EgEIHOrapCcHSNI0G6Qo4i5i1PbUCP1XebeN8VCCFYixQC3Z9RMjMFm
	 XoVIDEIHYYWuQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>,
	=?UTF-8?q?Christian=20K=C3=B6nig?= <christian.koenig@amd.com>,
	=?UTF-8?q?Timur=20Krist=C3=B3f?= <timur.kristof@gmail.com>,
	Alex Deucher <alexander.deucher@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 3/3] drm/amdgpu: skip the VMID 0 flush for VRAM
Date: Wed, 16 Sep 2026 14:36:41 -0400
Message-ID: <20260916183641.1771014-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260916183641.1771014-1-sashal@kernel.org>
References: <2026091636-creole-glorified-e7b6@gregkh>
 <20260916183641.1771014-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c | 20 ++++++++++++++------
 1 file changed, 14 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 8a433a0920e74..38c219c36ce22 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -175,6 +175,8 @@ static void amdgpu_evict_flags(struct ttm_buffer_object *bo,
  * @tmz: if we should setup a TMZ enabled mapping
  * @size: in number of bytes to map, out number of bytes mapped
  * @addr: resulting address inside the MC address space
+ * @vm_needs_flush: out, set true if a GART window was programmed (VMID 0 flush
+ *		    needed) or false for a direct address
  *
  * Setup one of the GART windows to access a specific piece of memory or return
  * the physical address for local memory.
@@ -184,7 +186,8 @@ static int amdgpu_ttm_map_buffer(struct drm_sched_entity *entity,
 				 struct ttm_resource *mem,
 				 struct amdgpu_res_cursor *mm_cur,
 				 unsigned int window,
-				 bool tmz, uint64_t *size, uint64_t *addr)
+				 bool tmz, uint64_t *size, uint64_t *addr,
+				 bool *vm_needs_flush)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	unsigned int offset, num_pages, num_dw, num_bytes;
@@ -206,9 +209,12 @@ static int amdgpu_ttm_map_buffer(struct drm_sched_entity *entity,
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
@@ -318,6 +324,7 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 	while (src_mm.remaining) {
 		uint64_t from, to, cur_size, tiling_flags;
 		uint32_t num_type, data_format, max_com, write_compress_disable;
+		bool src_vm_flush, dst_vm_flush;
 		struct dma_fence *next;
 
 		/* Never copy more than 256MiB at once to avoid a timeout */
@@ -325,12 +332,12 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 
 		/* Map src to window 0 and dst to window 1. */
 		r = amdgpu_ttm_map_buffer(entity, src->bo, src->mem, &src_mm,
-					  0, tmz, &cur_size, &from);
+					  0, tmz, &cur_size, &from, &src_vm_flush);
 		if (r)
 			goto error;
 
 		r = amdgpu_ttm_map_buffer(entity, dst->bo, dst->mem, &dst_mm,
-					  1, tmz, &cur_size, &to);
+					  1, tmz, &cur_size, &to, &dst_vm_flush);
 		if (r)
 			goto error;
 
@@ -358,7 +365,7 @@ int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 		}
 
 		r = amdgpu_copy_buffer(adev, entity, from, to, cur_size, resv,
-				       &next, true, copy_flags);
+				       &next, src_vm_flush || dst_vm_flush, copy_flags);
 		if (r)
 			goto error;
 
@@ -2414,6 +2421,7 @@ int amdgpu_ttm_clear_buffer(struct drm_sched_entity *entity,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct dma_fence *fence = NULL;
 	struct amdgpu_res_cursor dst;
+	bool vm_needs_flush = false;
 	int r;
 
 	if (!entity)
@@ -2443,13 +2451,13 @@ int amdgpu_ttm_clear_buffer(struct drm_sched_entity *entity,
 		cur_size = min(dst.size, 256ULL << 20);
 
 		r = amdgpu_ttm_map_buffer(entity, &bo->tbo, bo->tbo.resource, &dst,
-					  0, false, &cur_size, &to);
+					  0, false, &cur_size, &to, &vm_needs_flush);
 		if (r)
 			goto error;
 
 		r = amdgpu_ttm_fill_mem(adev, entity,
 					0, to, cur_size, resv,
-					&next, true, k_job_id);
+					&next, vm_needs_flush, k_job_id);
 		if (r)
 			goto error;
 
-- 
2.53.0

