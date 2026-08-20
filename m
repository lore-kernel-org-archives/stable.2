Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B31E42D8DB5
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 11:05:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787223948; cv=none; b=ZA6Cl1JBgF+8wI4P7ypP47w4ANnppxBuxo4mCR9+45YTkVRjsj/hC+MOgMAsMovtI3OcH4nN+d+qsZ9erQhrNdjOPOwiFhIE1zCODkMLx8CQ/6bFXK1jUaaXOWpLsIOjhiNRdVhnPzao+CsSAwQQ6zYaYImsuOLa50qx2As5YFM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787223948; c=relaxed/simple;
	bh=BCF0MmNWxD6MXjejuFv1FJYlfMck8xZCCLnh/4RWIew=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=q2VToGspwMVxr+cgYCba1CxRFS/JK8GgybWUC/bW/wARM4PWLlyjxQpzAKGg5qevQ/1H3iMsOM5LBHFIgfu8RMIcibL2oode3FDH/Q/k7MIkBZrQ+8lo29sQFOlfjv70vKCoSJzVXYL9LVFnWtLvvCw1ndwWpzunizjNTNAOySY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=VKIu8Arr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="VKIu8Arr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37D451F000E9;
	Thu, 20 Aug 2026 11:05:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787223946;
	bh=V5D+yO0a00fueZTHBF1wUI8A+Y/zXkDA1E/tVudYIlk=;
	h=Subject:To:Cc:From:Date;
	b=VKIu8Arr1+IaFccP0qHy+d1zOLmvX7PyuOJCzIbjuVzVhx50L79WoV+WIUNqFgjS1
	 Q+Ia1iLmbPwOwcak3wHqQwxZUfHh1Q6pe2pPEHECkNP3BFZhmlqqpHBUfjruWvgM8p
	 qj+ncAmp8TdkqWq5LNkf3N5a2VtK92l8MnPXaU84=
Subject: FAILED: patch "[PATCH] drm/amdgpu: Allocate coredump ring buffers per ring" failed to apply to 7.1-stable tree
To: lijo.lazar@amd.com,alexander.deucher@amd.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 20 Aug 2026 13:05:41 +0200
Message-ID: <2026082041-sporty-underdone-82eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 7.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-7.1.y
git checkout FETCH_HEAD
git cherry-pick -x e40ff9840fa8a633d149f0242df10cae5e518062
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026082041-sporty-underdone-82eb@gregkh' --subject-prefix 'PATCH 7.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e40ff9840fa8a633d149f0242df10cae5e518062 Mon Sep 17 00:00:00 2001
From: Lijo Lazar <lijo.lazar@amd.com>
Date: Wed, 29 Jul 2026 16:23:58 +0530
Subject: [PATCH] drm/amdgpu: Allocate coredump ring buffers per ring

Allocate each ring buffer separately. A single allocation summing all
ring sizes can exceed the page allocator's MAX_ORDER limit and fail;
per-ring buffers stay small enough to satisfy. The existing allocation
style doesn't capture any ring data if the huge allocation fails.
Splitting into multiple allocations helps to capture as much data as
possible for the core dump.

A failed ring is left with a NULL buffer and skipped when formatting.

Fixes: eea85914d15b ("drm/amdgpu: save ring content before resetting the device")
Signed-off-by: Lijo Lazar <lijo.lazar@amd.com>
Assisted-by: Claude Code
Reviewed-by: Alex Deucher <alexander.deucher@amd.com>
Signed-off-by: Alex Deucher <alexander.deucher@amd.com>
(cherry picked from commit 3e8e92b7892a6377bef86106bfff1b98cf586aee)
Cc: stable@vger.kernel.org

diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index 8dafc84f4232..45dfe1c8a11b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -342,7 +342,7 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 	struct amdgpu_ip_block *ip_block;
 	struct amdgpu_ring *ring;
 	int ver, i, j;
-	u32 ring_idx, off;
+	u32 ring_idx;
 	bool sizing_pass;
 
 	sizing_pass = buffer == NULL;
@@ -442,7 +442,6 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 		for (i = 0; i < coredump->num_rings; i++) {
 			ring_idx = coredump->rings[i].ring_index;
 			ring = coredump->adev->rings[ring_idx];
-			off = coredump->rings[i].offset;
 
 			drm_printf(&p, "ring name: %s\n", ring->name);
 			drm_printf(&p, "Rptr: 0x%llx Wptr: 0x%llx RB mask: %x\n",
@@ -451,12 +450,18 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 				   ring->buf_mask);
 			drm_printf(&p, "Ring size in dwords: %d\n",
 				ring->ring_size / 4);
+
+			if (!coredump->rings[i].ring_dw) {
+				drm_printf(&p, "Ring contents unavailable\n");
+				continue;
+			}
+
 			drm_printf(&p, "Ring contents\n");
 			drm_printf(&p, "Offset \t Value\n");
 
 			for (j = 0; j < ring->ring_size; j += 4)
 				drm_printf(&p, "0x%x \t 0x%x\n", j,
-					   coredump->rings_dw[off + j / 4]);
+					   coredump->rings[i].ring_dw[j / 4]);
 		}
 	}
 
@@ -497,10 +502,12 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
 static void amdgpu_devcoredump_free(void *data)
 {
 	struct amdgpu_coredump_info *coredump = data;
+	u32 i;
 
 	kvfree(coredump->formatted);
+	for (i = 0; i < coredump->num_rings; i++)
+		kvfree(coredump->rings[i].ring_dw);
 	kvfree(coredump->rings);
-	kvfree(coredump->rings_dw);
 	kvfree(data);
 }
 
@@ -542,9 +549,9 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 	struct amdgpu_coredump_info *coredump;
 	size_t size = sizeof(*coredump);
 	struct drm_sched_job *s_job;
-	u64 total_ring_size, ring_count;
+	u64 ring_count;
 	struct amdgpu_ring *ring;
-	int i, off, idx;
+	int i, idx;
 
 	/* No need to generate a new coredump if there's one in progress already. */
 	if (work_busy(&adev->coredump_work))
@@ -584,7 +591,6 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 
 	/* Dump ring content if memory allocation succeeds. */
 	ring_count = 0;
-	total_ring_size = 0;
 	for (i = 0; i < adev->num_rings; i++) {
 		ring = adev->rings[i];
 
@@ -593,38 +599,34 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 		    coredump->ring != ring)
 			continue;
 
-		total_ring_size += ring->ring_size;
 		ring_count++;
 	}
-	if (ring_count) {
-		coredump->rings_dw = kvzalloc(total_ring_size, GFP_NOWAIT);
+	if (ring_count)
 		coredump->rings = kvcalloc(ring_count,
 					   sizeof(struct amdgpu_coredump_ring),
 					   GFP_NOWAIT);
-	}
-	if (coredump->rings && coredump->rings_dw) {
-		for (i = 0, off = 0, idx = 0; i < adev->num_rings && idx < ring_count; i++) {
+	if (coredump->rings) {
+		for (i = 0, idx = 0; i < adev->num_rings && idx < ring_count; i++) {
+			struct amdgpu_coredump_ring *cdump_ring;
+
 			ring = adev->rings[i];
 
 			if (atomic_read(&ring->fence_drv.last_seq) == ring->fence_drv.sync_seq &&
 			    coredump->ring != ring)
 				continue;
 
-			coredump->rings[idx].ring_index = ring->idx;
-			coredump->rings[idx].rptr = amdgpu_ring_get_rptr(ring);
-			coredump->rings[idx].wptr = amdgpu_ring_get_wptr(ring);
-			coredump->rings[idx].offset = off;
+			cdump_ring = &coredump->rings[idx];
 
-			memcpy(&coredump->rings_dw[off], ring->ring, ring->ring_size);
-			off += ring->ring_size / 4;
+			cdump_ring->ring_dw = kvzalloc(ring->ring_size, GFP_NOWAIT);
+			if (cdump_ring->ring_dw)
+				memcpy(cdump_ring->ring_dw, ring->ring, ring->ring_size);
+
+			cdump_ring->ring_index = ring->idx;
+			cdump_ring->rptr = amdgpu_ring_get_rptr(ring);
+			cdump_ring->wptr = amdgpu_ring_get_wptr(ring);
 			idx++;
 		}
 		coredump->num_rings = idx;
-	} else {
-		kvfree(coredump->rings_dw);
-		kvfree(coredump->rings);
-		coredump->rings_dw = NULL;
-		coredump->rings = NULL;
 	}
 
 	coredump->adev = adev;
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
index 63f27337c09a..cb874d8c3394 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.h
@@ -34,8 +34,8 @@
 struct amdgpu_coredump_ring {
 	u64				rptr;
 	u64				wptr;
+	u32				*ring_dw;
 	u32				ring_index;
-	u32				offset;
 };
 
 struct amdgpu_coredump_ib_info {
@@ -53,7 +53,6 @@ struct amdgpu_coredump_info {
 	struct amdgpu_ring              *ring;
 
 	struct amdgpu_coredump_ring	*rings;
-	u32				*rings_dw;
 	u32				num_rings;
 
 	/* Readable form of coredevdump, generate once to speed up

