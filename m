Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB31B3DC4B3
	for <stable@vger.kernel.org>; Wed, 16 Sep 2026 09:24:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789550686; cv=none; b=Y18hZWV/47t1I6VGWN7LLuxUkB1BAN1C7ZJCBcULBdF22qMeb/R0kk72gWAXumGpBE1Z2RpwCIfbCE6UqqyAfXPy6svkrUGNo2xe6cj/ylYbhvXh5bqMIGjaVJHmnoc7UMTCLInb91OQX0vh0Ypn6Nxqw+RlfgOKtBNCEmk7xbg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789550686; c=relaxed/simple;
	bh=6fDch/dJxgGdwLDqg9UTPQ3cMhMT+/q2jECaznSZ4UE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=N3CZPZpkM89jgQri6tovFXDPXNZR7rK8JvUzHCBIOrQ/wyXxsC8ZR+7B7N7ClDgN8yM2I9d2ttoqlxldThGQb1FY8mkEFTMUogiPNbQDQXjGY9k35AQwgMZG1LwNDOpERysUe8B8SFL/Y0Ndy6RE5cTBgxmAzh7XQzIzj7pDhRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Eijn8RVj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Eijn8RVj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF2141F000FF;
	Wed, 16 Sep 2026 09:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789550668;
	bh=mynV4LFhFDJUulDRbFwvdzr72swnqumN/pwlIqLa7QE=;
	h=Subject:To:Cc:From:Date;
	b=Eijn8RVj+7RCL7J85Ha6SBACPEyiLaFqaQSG2ohIZRxGAKqWNT+zPhgqzBVoFqnNO
	 38hpEdmck4yVWVlLXyHm4MXpLQB12rJvUEDN2tuAQS2IaN6mKV6riAGA8wuiye4fXl
	 hKDvBEM8HnIUJe+8vIL2bAy/ZSpDtTZlPQfrKC/g=
Subject: FAILED: patch "[PATCH] drm/amdgpu: skip the VMID 0 flush for VRAM" failed to apply to 6.12-stable tree
To: Arunpravin.PaneerSelvam@amd.com,alexander.deucher@amd.com,christian.koenig@amd.com,timur.kristof@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 16 Sep 2026 10:21:37 +0100
Message-ID: <2026091637-whole-improve-e7e2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 87ceb8cba73d0b3c4025ff42495bccd8164acaed
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026091637-whole-improve-e7e2@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 87ceb8cba73d0b3c4025ff42495bccd8164acaed Mon Sep 17 00:00:00 2001
From: Arunpravin Paneer Selvam <Arunpravin.PaneerSelvam@amd.com>
Date: Wed, 2 Sep 2026 18:33:48 +0530
Subject: [PATCH] drm/amdgpu: skip the VMID 0 flush for VRAM
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

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

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
index 05abf4c31dce..016957cac1f2 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c
@@ -191,6 +191,8 @@ amdgpu_ttm_job_submit(struct amdgpu_device *adev, struct amdgpu_ttm_buffer_entit
  * @tmz: if we should setup a TMZ enabled mapping
  * @size: in number of bytes to map, out number of bytes mapped
  * @addr: resulting address inside the MC address space
+ * @vm_needs_flush: out, set true if a GART window was programmed (VMID 0 flush
+ *		    needed) or false for a direct address
  *
  * Setup one of the GART windows to access a specific piece of memory or return
  * the physical address for local memory.
@@ -200,7 +202,8 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
 				 struct ttm_resource *mem,
 				 struct amdgpu_res_cursor *mm_cur,
 				 unsigned int window,
-				 bool tmz, uint64_t *size, uint64_t *addr)
+				 bool tmz, uint64_t *size, uint64_t *addr,
+				 bool *vm_needs_flush)
 {
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->bdev);
 	unsigned int offset, num_pages, num_dw, num_bytes;
@@ -221,9 +224,12 @@ static int amdgpu_ttm_map_buffer(struct amdgpu_ttm_buffer_entity *entity,
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
@@ -324,6 +330,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 	while (src_mm.remaining) {
 		uint64_t from, to, cur_size, tiling_flags;
 		uint32_t num_type, data_format, max_com, write_compress_disable;
+		bool src_vm_flush, dst_vm_flush;
 		struct dma_fence *next;
 
 		/* Never copy more than 256MiB at once to avoid a timeout */
@@ -331,12 +338,12 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 
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
 
@@ -364,7 +371,7 @@ static int amdgpu_ttm_copy_mem_to_mem(struct amdgpu_device *adev,
 		}
 
 		r = amdgpu_copy_buffer(adev, entity, from, to, cur_size, resv,
-				       &next, true, copy_flags);
+				       &next, src_vm_flush || dst_vm_flush, copy_flags);
 		if (r)
 			goto error;
 
@@ -2624,6 +2631,7 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
 	struct amdgpu_device *adev = amdgpu_ttm_adev(bo->tbo.bdev);
 	struct dma_fence *fence = NULL;
 	struct amdgpu_res_cursor dst;
+	bool vm_needs_flush = false;
 	int r;
 
 	if (!entity)
@@ -2645,13 +2653,13 @@ int amdgpu_ttm_clear_buffer(struct amdgpu_ttm_buffer_entity *entity,
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
 

