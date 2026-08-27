Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2382645FFA5;
	Thu, 27 Aug 2026 12:57:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787835491; cv=none; b=FETjSEn8XfkbU0KDz8thelyvXQKETO87AZNm+gcGk7jb0BrjbNAWM69w+tvB5gq2PaJrR2QF/fpwNwhH0P/3VUJU5QcEuOJggnLIf8eO2c+aE4MnYqDq2OzwzsgTmEr7UXcAXLG2PGYt0Hm7Z6dAewRwIkG/hSt+riZJOWFixk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787835491; c=relaxed/simple;
	bh=K/EF0sfZtcqit9GbfuG8t8sIo2roC0oUFlZ3jqNKfNI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=u+ZW3e5gOqXAvAg24Ou7csvyb+IBJqyRXSsMahYOkMlJmslmg29Cv/TenQ94aots0YlNjTfzzXG17Hcv523LAws+j71RoyRnkZilnppgehv06KykQdQVMEyU+LLk260REo/GMIgVG0OkFvRpvwOJBqAqpKrr5uzf+yEKjCbPrGQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NIWtxIRe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NIWtxIRe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94A2A1F00A3E;
	Thu, 27 Aug 2026 12:57:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787835452;
	bh=14d+8JJ7NzkbTcX8qsBaUd4/Hq8lvaPk521kxNVTe7o=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NIWtxIRexD96o20RKJIyUYTrkxiVzxarTPNf4Fnt1aOXGRaLAYC7A/lMfB8yBOzsJ
	 39apb9L2Y6UWcZscgKeUm31x9mx3MjizCvs5hZdNc56fG4fsKTRNLFnzUvfqFYkjMB
	 bZM1ufsOYDMZxd4cd5uaB/R2nOM8r4+OfE5J/Bxs=
From: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To: linux-kernel@vger.kernel.org,
	akpm@linux-foundation.org,
	torvalds@linux-foundation.org,
	stable@vger.kernel.org
Cc: lwn@lwn.net,
	jslaby@suse.cz,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: Linux 7.1.11
Date: Thu, 27 Aug 2026 14:57:23 +0200
Message-ID: <2026082722-rebuttal-verse-06ff@gregkh>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <2026082722-shelve-footrest-a5fb@gregkh>
References: <2026082722-shelve-footrest-a5fb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

diff --git a/Makefile b/Makefile
index 0e4156b1d188..9948c9310f06 100644
--- a/Makefile
+++ b/Makefile
@@ -1,7 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 VERSION = 7
 PATCHLEVEL = 1
-SUBLEVEL = 10
+SUBLEVEL = 11
 EXTRAVERSION =
 NAME = Baby Opossum Posse
 
diff --git a/drivers/block/null_blk/zoned.c b/drivers/block/null_blk/zoned.c
index 384bdce6a9b7..7e9b5ffb9e84 100644
--- a/drivers/block/null_blk/zoned.c
+++ b/drivers/block/null_blk/zoned.c
@@ -18,6 +18,8 @@ static inline sector_t mb_to_sects(unsigned long mb)
 
 static inline unsigned int null_zone_no(struct nullb_device *dev, sector_t sect)
 {
+	if (WARN_ON_ONCE(!dev->zone_size_sects))
+		return 0;
 	return sect >> ilog2(dev->zone_size_sects);
 }
 
@@ -56,8 +58,8 @@ int null_init_zoned_dev(struct nullb_device *dev,
 	sector_t sector = 0;
 	unsigned int i;
 
-	if (!is_power_of_2(dev->zone_size)) {
-		pr_err("zone_size must be power-of-two\n");
+	if (!dev->zone_size || !is_power_of_2(dev->zone_size)) {
+		pr_err("zone_size must be non-zero power-of-two\n");
 		return -EINVAL;
 	}
 	if (dev->zone_size > dev->size) {
@@ -88,6 +90,10 @@ int null_init_zoned_dev(struct nullb_device *dev,
 	zone_capacity_sects = mb_to_sects(dev->zone_capacity);
 	dev_capacity_sects = mb_to_sects(dev->size);
 	dev->zone_size_sects = mb_to_sects(dev->zone_size);
+	if (!dev->zone_size_sects) {
+		pr_err("zone_size too large or too small, leads to zero sectors\n");
+		return -EINVAL;
+	}
 	dev->nr_zones = round_up(dev_capacity_sects, dev->zone_size_sects)
 		>> ilog2(dev->zone_size_sects);
 
diff --git a/drivers/bluetooth/hci_aml.c b/drivers/bluetooth/hci_aml.c
index 959d9e67b669..067fbf278b44 100644
--- a/drivers/bluetooth/hci_aml.c
+++ b/drivers/bluetooth/hci_aml.c
@@ -247,7 +247,7 @@ static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
 	struct hci_uart *hu = hci_get_drvdata(hdev);
 	struct aml_serdev *amldev = serdev_device_get_drvdata(hu->serdev);
 	const struct firmware *firmware = NULL;
-	struct aml_fw_len *fw_len = NULL;
+	const struct aml_fw_len *fw_len = NULL;
 	u8 *iccm_start = NULL, *dccm_start = NULL;
 	u32 iccm_len, dccm_len;
 	u32 value = 0;
@@ -281,7 +281,21 @@ static int aml_download_firmware(struct hci_dev *hdev, const char *fw_name)
 		goto exit;
 	}
 
-	fw_len = (struct aml_fw_len *)firmware->data;
+	if (firmware->size < sizeof(*fw_len)) {
+		bt_dev_err(hdev, "Firmware is too small for its header");
+		ret = -EINVAL;
+		goto exit;
+	}
+
+	fw_len = (const struct aml_fw_len *)firmware->data;
+	if (fw_len->iccm_len < amldev->aml_dev_data->iccm_offset ||
+	    fw_len->iccm_len > firmware->size - sizeof(*fw_len) ||
+	    fw_len->dccm_len > firmware->size - sizeof(*fw_len) -
+			fw_len->iccm_len) {
+		bt_dev_err(hdev, "Invalid firmware segment lengths");
+		ret = -EINVAL;
+		goto exit;
+	}
 
 	/* Download ICCM */
 	iccm_start = (u8 *)(firmware->data) + sizeof(struct aml_fw_len)
diff --git a/drivers/dma/fsl-edma-main.c b/drivers/dma/fsl-edma-main.c
index 36155ab1602a..d9fb717b5b53 100644
--- a/drivers/dma/fsl-edma-main.c
+++ b/drivers/dma/fsl-edma-main.c
@@ -414,6 +414,8 @@ static int fsl_edma3_irq_init(struct platform_device *pdev, struct fsl_edma_engi
 
 		errirq_name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "%s-err",
 					     dev_name(&pdev->dev));
+		if (!errirq_name)
+			return -ENOMEM;
 
 		ret = devm_request_irq(&pdev->dev, fsl_edma->errirq, fsl_edma3_err_handler_shared,
 				       0, errirq_name, fsl_edma);
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
index dba7fca57427..029f678e59b7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_dev_coredump.c
@@ -24,6 +24,7 @@
 
 #include <generated/utsrelease.h>
 #include <linux/devcoredump.h>
+#include <drm/drm_exec.h>
 #include "amdgpu_dev_coredump.h"
 #include "atom.h"
 
@@ -207,24 +208,138 @@ static void amdgpu_devcoredump_fw_info(struct amdgpu_device *adev,
 	}
 }
 
+static void
+amdgpu_devcoredump_print_ibs(struct drm_printer *p,
+			     struct amdgpu_coredump_info *coredump,
+			     bool sizing_pass)
+{
+	struct amdgpu_device *adev = coredump->adev;
+	struct amdgpu_bo_va_mapping *mapping;
+	struct amdgpu_bo *abo;
+	struct drm_exec exec;
+	struct amdgpu_vm *vm;
+	u32 *ib_content;
+	u64 va_start, offset;
+	u8 *kptr;
+	u32 off;
+	int r;
+
+	/*
+	 * On the sizing pass there is no VM to look up and no BO to lock; the
+	 * size estimate doesn't depend on whether the IB BOs are reachable.
+	 * Just emit the per-IB headers (the content is not written anywhere).
+	 */
+	if (sizing_pass) {
+		for (int i = 0; i < coredump->num_ibs; i++) {
+			drm_printf(p, "\nIB #%d 0x%llx %d dw\n", i,
+				   coredump->ibs[i].gpu_addr,
+				   coredump->ibs[i].ib_size_dw);
+		}
+		return;
+	}
+
+	/*
+	 * Lock the VM root PD and every IB BO together in a single drm_exec
+	 * ticket. Reserving the IB BOs one by one while the root PD is held
+	 * would be a recursive reservation_ww_class_mutex acquire without a
+	 * ww_acquire_ctx, which trips lockdep and self-deadlocks for IB BOs
+	 * that share their dma_resv with the root PD (always-valid BOs).
+	 */
+	drm_exec_init(&exec, DRM_EXEC_IGNORE_DUPLICATES, 1 + coredump->num_ibs);
+	drm_exec_until_all_locked(&exec) {
+		vm = amdgpu_vm_lock_by_pasid(adev, coredump->pasid, &exec);
+		if (!vm)
+			goto unlock;
+
+		for (int i = 0; i < coredump->num_ibs; i++) {
+			u64 pfn = (coredump->ibs[i].gpu_addr &
+				   AMDGPU_GMC_HOLE_MASK) / AMDGPU_GPU_PAGE_SIZE;
+
+			mapping = amdgpu_vm_bo_lookup_mapping(vm, pfn);
+			if (!mapping)
+				continue;
+
+			abo = mapping->bo_va->base.bo;
+			r = drm_exec_lock_obj(&exec, &abo->tbo.base);
+			drm_exec_retry_on_contention(&exec);
+			if (r)
+				goto unlock;
+		}
+	}
+
+	for (int i = 0; i < coredump->num_ibs; i++) {
+		bool emit_content = false;
+
+		ib_content = kvmalloc_array(coredump->ibs[i].ib_size_dw, 4,
+					    GFP_KERNEL);
+		if (!ib_content)
+			continue;
+
+		va_start = coredump->ibs[i].gpu_addr & AMDGPU_GMC_HOLE_MASK;
+		mapping = amdgpu_vm_bo_lookup_mapping(vm,
+						      va_start / AMDGPU_GPU_PAGE_SIZE);
+		if (!mapping)
+			goto output_ib_content;
+
+		abo = mapping->bo_va->base.bo;
+		offset = va_start - mapping->start * AMDGPU_GPU_PAGE_SIZE;
+
+		if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
+			struct amdgpu_res_cursor cursor;
+
+			off = 0;
+
+			if (abo->tbo.resource->mem_type != TTM_PL_VRAM)
+				goto output_ib_content;
+
+			amdgpu_res_first(abo->tbo.resource, offset,
+					 coredump->ibs[i].ib_size_dw * 4, &cursor);
+			while (cursor.remaining) {
+				amdgpu_device_mm_access(adev, cursor.start / 4,
+							&ib_content[off], cursor.size / 4,
+							false);
+				off += cursor.size;
+				amdgpu_res_next(&cursor, cursor.size);
+			}
+			emit_content = true;
+		} else {
+			r = ttm_bo_kmap(&abo->tbo, 0, PFN_UP(abo->tbo.base.size),
+					&abo->kmap);
+			if (r)
+				goto output_ib_content;
+
+			kptr = amdgpu_bo_kptr(abo);
+			kptr += offset;
+			memcpy(ib_content, kptr, coredump->ibs[i].ib_size_dw * 4);
+
+			amdgpu_bo_kunmap(abo);
+			emit_content = true;
+		}
+
+output_ib_content:
+		drm_printf(p, "\nIB #%d 0x%llx %d dw\n", i,
+			   coredump->ibs[i].gpu_addr, coredump->ibs[i].ib_size_dw);
+		if (emit_content) {
+			for (int j = 0; j < coredump->ibs[i].ib_size_dw; j++)
+				drm_printf(p, "0x%08x\n", ib_content[j]);
+		}
+		kvfree(ib_content);
+	}
+
+unlock:
+	drm_exec_fini(&exec);
+}
+
 static ssize_t
 amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_info *coredump)
 {
-	struct amdgpu_device *adev = coredump->adev;
 	struct drm_printer p;
 	struct drm_print_iterator iter;
 	struct amdgpu_vm_fault_info *fault_info;
-	struct amdgpu_bo_va_mapping *mapping;
 	struct amdgpu_ip_block *ip_block;
-	struct amdgpu_res_cursor cursor;
-	struct amdgpu_bo *abo, *root;
-	uint64_t va_start, offset;
 	struct amdgpu_ring *ring;
-	struct amdgpu_vm *vm;
-	u32 *ib_content;
-	uint8_t *kptr;
-	int ver, i, j, r;
-	u32 ring_idx, off;
+	int ver, i, j;
+	u32 ring_idx;
 	bool sizing_pass;
 
 	sizing_pass = buffer == NULL;
@@ -324,7 +439,6 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 		for (i = 0; i < coredump->num_rings; i++) {
 			ring_idx = coredump->rings[i].ring_index;
 			ring = coredump->adev->rings[ring_idx];
-			off = coredump->rings[i].offset;
 
 			drm_printf(&p, "ring name: %s\n", ring->name);
 			drm_printf(&p, "Rptr: 0x%llx Wptr: 0x%llx RB mask: %x\n",
@@ -333,12 +447,18 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
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
 
@@ -347,86 +467,8 @@ amdgpu_devcoredump_format(char *buffer, size_t count, struct amdgpu_coredump_inf
 	else if (coredump->reset_vram_lost)
 		drm_printf(&p, "VRAM is lost due to GPU reset!\n");
 
-	if (coredump->num_ibs) {
-		/* Don't try to lookup the VM or map the BOs when calculating the
-		 * size required to store the devcoredump.
-		 */
-		if (sizing_pass)
-			vm = NULL;
-		else
-			vm = amdgpu_vm_lock_by_pasid(adev, &root, coredump->pasid);
-
-		for (int i = 0; i < coredump->num_ibs && (sizing_pass || vm); i++) {
-			ib_content = kvmalloc_array(coredump->ibs[i].ib_size_dw, 4,
-						    GFP_KERNEL);
-			if (!ib_content)
-				continue;
-
-			/* vm=NULL can only happen when 'sizing_pass' is true. Skip to the
-			 * drm_printf() calls (ib_content doesn't need to be initialized
-			 * as its content won't be written anywhere).
-			 */
-			if (!vm)
-				goto output_ib_content;
-
-			va_start = coredump->ibs[i].gpu_addr & AMDGPU_GMC_HOLE_MASK;
-			mapping = amdgpu_vm_bo_lookup_mapping(vm, va_start / AMDGPU_GPU_PAGE_SIZE);
-			if (!mapping)
-				goto free_ib_content;
-
-			offset = va_start - (mapping->start * AMDGPU_GPU_PAGE_SIZE);
-			abo = amdgpu_bo_ref(mapping->bo_va->base.bo);
-			r = amdgpu_bo_reserve(abo, false);
-			if (r)
-				goto free_ib_content;
-
-			if (abo->flags & AMDGPU_GEM_CREATE_NO_CPU_ACCESS) {
-				off = 0;
-
-				if (abo->tbo.resource->mem_type != TTM_PL_VRAM)
-					goto unreserve_abo;
-
-				amdgpu_res_first(abo->tbo.resource, offset,
-						 coredump->ibs[i].ib_size_dw * 4,
-						 &cursor);
-				while (cursor.remaining) {
-					amdgpu_device_mm_access(adev, cursor.start / 4,
-								&ib_content[off], cursor.size / 4,
-								false);
-					off += cursor.size;
-					amdgpu_res_next(&cursor, cursor.size);
-				}
-			} else {
-				r = ttm_bo_kmap(&abo->tbo, 0,
-						PFN_UP(abo->tbo.base.size),
-						&abo->kmap);
-				if (r)
-					goto unreserve_abo;
-
-				kptr = amdgpu_bo_kptr(abo);
-				kptr += offset;
-				memcpy(ib_content, kptr,
-				       coredump->ibs[i].ib_size_dw * 4);
-
-				amdgpu_bo_kunmap(abo);
-			}
-
-output_ib_content:
-			drm_printf(&p, "\nIB #%d 0x%llx %d dw\n",
-				   i, coredump->ibs[i].gpu_addr, coredump->ibs[i].ib_size_dw);
-			for (int j = 0; j < coredump->ibs[i].ib_size_dw; j++)
-				drm_printf(&p, "0x%08x\n", ib_content[j]);
-unreserve_abo:
-			if (vm)
-				amdgpu_bo_unreserve(abo);
-free_ib_content:
-			kvfree(ib_content);
-		}
-		if (vm) {
-			amdgpu_bo_unreserve(root);
-			amdgpu_bo_unref(&root);
-		}
-	}
+	if (coredump->num_ibs)
+		amdgpu_devcoredump_print_ibs(&p, coredump, sizing_pass);
 
 	return count - iter.remain;
 }
@@ -457,10 +499,12 @@ amdgpu_devcoredump_read(char *buffer, loff_t offset, size_t count,
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
 
@@ -502,9 +546,9 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
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
@@ -544,7 +588,6 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
 
 	/* Dump ring content if memory allocation succeeds. */
 	ring_count = 0;
-	total_ring_size = 0;
 	for (i = 0; i < adev->num_rings; i++) {
 		ring = adev->rings[i];
 
@@ -553,38 +596,34 @@ void amdgpu_coredump(struct amdgpu_device *adev, bool skip_vram_check,
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
+
+			cdump_ring->ring_dw = kvzalloc(ring->ring_size, GFP_NOWAIT);
+			if (cdump_ring->ring_dw)
+				memcpy(cdump_ring->ring_dw, ring->ring, ring->ring_size);
 
-			memcpy(&coredump->rings_dw[off], ring->ring, ring->ring_size);
-			off += ring->ring_size / 4;
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
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
index 97c5151bada3..beefa05bf49b 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.c
@@ -2947,47 +2947,56 @@ int amdgpu_vm_ioctl(struct drm_device *dev, void *data, struct drm_file *filp)
 }
 
 /**
- * amdgpu_vm_lock_by_pasid - return an amdgpu_vm and its root bo from a pasid, if possible.
+ * amdgpu_vm_lock_by_pasid - look up a VM by PASID and lock its root PD
  * @adev: amdgpu device pointer
- * @root: root BO of the VM
  * @pasid: PASID of the VM
- * The caller needs to unreserve and unref the root bo on success.
+ * @exec: drm_exec context to lock the root PD in
+ *
+ * Must be called from within a drm_exec_until_all_locked() loop; the caller
+ * runs drm_exec_retry_on_contention() afterwards. The drm_exec context holds
+ * a reference on the root BO until it is finalised.
+ *
+ * Return: the VM on success, or NULL if the PASID has no VM, the VM is being
+ * torn down, or locking the root PD failed.
  */
 struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
-					  struct amdgpu_bo **root, u32 pasid)
+					  u32 pasid, struct drm_exec *exec)
 {
 	unsigned long irqflags;
+	struct amdgpu_bo *root;
 	struct amdgpu_vm *vm;
 	int r;
 
 	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
 	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	*root = vm ? amdgpu_bo_ref(vm->root.bo) : NULL;
+	root = vm ? amdgpu_bo_ref(vm->root.bo) : NULL;
 	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
 
-	if (!*root)
+	if (!root)
 		return NULL;
 
-	r = amdgpu_bo_reserve(*root, true);
-	if (r)
-		goto error_unref;
+	r = drm_exec_lock_obj(exec, &root->tbo.base);
+	if (r) {
+		amdgpu_bo_unref(&root);
+		return NULL;
+	}
 
 	/* Double check that the VM still exists */
 	xa_lock_irqsave(&adev->vm_manager.pasids, irqflags);
 	vm = xa_load(&adev->vm_manager.pasids, pasid);
-	if (vm && vm->root.bo != *root)
+	if (vm && vm->root.bo != root)
 		vm = NULL;
 	xa_unlock_irqrestore(&adev->vm_manager.pasids, irqflags);
-	if (!vm)
-		goto error_unlock;
+	if (!vm) {
+		drm_exec_unlock_obj(exec, &root->tbo.base);
+		amdgpu_bo_unref(&root);
+		return NULL;
+	}
 
-	return vm;
-error_unlock:
-	amdgpu_bo_unreserve(*root);
+	/* The drm_exec context holds its own reference on the root BO. */
+	amdgpu_bo_unref(&root);
 
-error_unref:
-	amdgpu_bo_unref(root);
-	return NULL;
+	return vm;
 }
 
 /**
@@ -3009,33 +3018,49 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    uint64_t ts, bool write_fault)
 {
 	bool is_compute_context = false;
-	struct amdgpu_bo *root;
+	struct drm_exec exec;
 	uint64_t value, flags;
 	struct amdgpu_vm *vm;
 	int r;
 
-	vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
-	if (!vm)
+	drm_exec_init(&exec, 0, 1);
+	drm_exec_until_all_locked(&exec) {
+		vm = amdgpu_vm_lock_by_pasid(adev, pasid, &exec);
+		drm_exec_retry_on_contention(&exec);
+		if (!vm)
+			break;
+	}
+	if (!vm) {
+		drm_exec_fini(&exec);
 		return false;
+	}
 
 	is_compute_context = vm->is_compute_context;
 
 	if (is_compute_context) {
-		/* Unreserve root since svm_range_restore_pages might try to reserve it. */
-		/* TODO: rework svm_range_restore_pages so that this isn't necessary. */
-		amdgpu_bo_unreserve(root);
+		/* Release the root PD lock since svm_range_restore_pages
+		 * might try to take it.
+		 * TODO: rework svm_range_restore_pages so that this isn't
+		 * necessary.
+		 */
+		drm_exec_fini(&exec);
 
 		if (!svm_range_restore_pages(adev, pasid, vmid,
-					     node_id, addr >> PAGE_SHIFT, ts, write_fault)) {
-			amdgpu_bo_unref(&root);
+					     node_id, addr >> PAGE_SHIFT, ts, write_fault))
 			return true;
-		}
-		amdgpu_bo_unref(&root);
 
 		/* Re-acquire the VM lock, could be that the VM was freed in between. */
-		vm = amdgpu_vm_lock_by_pasid(adev, &root, pasid);
-		if (!vm)
+		drm_exec_init(&exec, 0, 1);
+		drm_exec_until_all_locked(&exec) {
+			vm = amdgpu_vm_lock_by_pasid(adev, pasid, &exec);
+			drm_exec_retry_on_contention(&exec);
+			if (!vm)
+				break;
+		}
+		if (!vm) {
+			drm_exec_fini(&exec);
 			return false;
+		}
 	}
 
 	addr /= AMDGPU_GPU_PAGE_SIZE;
@@ -3059,7 +3084,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 		value = 0;
 	}
 
-	r = dma_resv_reserve_fences(root->tbo.base.resv, 1);
+	r = dma_resv_reserve_fences(vm->root.bo->tbo.base.resv, 1);
 	if (r) {
 		pr_debug("failed %d to reserve fence slot\n", r);
 		goto error_unlock;
@@ -3073,12 +3098,10 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 	r = amdgpu_vm_update_pdes(adev, vm, true);
 
 error_unlock:
-	amdgpu_bo_unreserve(root);
+	drm_exec_fini(&exec);
 	if (r < 0)
 		dev_err(adev->dev, "Can't handle page fault (%d)\n", r);
 
-	amdgpu_bo_unref(&root);
-
 	return false;
 }
 
diff --git a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
index d083d7aab75c..0c6e3e0368c7 100644
--- a/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
+++ b/drivers/gpu/drm/amd/amdgpu/amdgpu_vm.h
@@ -593,7 +593,7 @@ bool amdgpu_vm_handle_fault(struct amdgpu_device *adev, u32 pasid,
 			    bool write_fault);
 
 struct amdgpu_vm *amdgpu_vm_lock_by_pasid(struct amdgpu_device *adev,
-					  struct amdgpu_bo **root, u32 pasid);
+					  u32 pasid, struct drm_exec *exec);
 
 void amdgpu_vm_set_task_info(struct amdgpu_vm *vm);
 
diff --git a/drivers/gpu/drm/i915/display/intel_display_types.h b/drivers/gpu/drm/i915/display/intel_display_types.h
index 2e6a85708555..804257660fae 100644
--- a/drivers/gpu/drm/i915/display/intel_display_types.h
+++ b/drivers/gpu/drm/i915/display/intel_display_types.h
@@ -684,14 +684,15 @@ struct intel_plane_state {
 
 	struct i915_vma *ggtt_vma;
 	struct i915_vma *dpt_vma;
-	unsigned long flags;
-#define PLANE_HAS_FENCE BIT(0)
 
 	struct intel_fb_view view;
 
 	/* for legacy cursor fb unpin */
 	struct drm_vblank_work unpin_work;
 
+	/* fenced region ID (-1 if none) */
+	s8 fence_id;
+
 	/* Plane pxp decryption state */
 	bool decrypt;
 
diff --git a/drivers/gpu/drm/i915/display/intel_fb_pin.c b/drivers/gpu/drm/i915/display/intel_fb_pin.c
index 738d77a1468a..b4a16d487a86 100644
--- a/drivers/gpu/drm/i915/display/intel_fb_pin.c
+++ b/drivers/gpu/drm/i915/display/intel_fb_pin.c
@@ -24,14 +24,11 @@
 
 static struct i915_vma *
 intel_fb_pin_to_dpt(const struct drm_framebuffer *fb,
-		    const struct i915_gtt_view *view,
-		    unsigned int alignment,
-		    unsigned long *out_flags,
-		    struct intel_dpt *dpt)
+		    struct intel_dpt *dpt,
+		    const struct intel_fb_pin_params *pin_params)
 {
-	struct drm_device *dev = fb->dev;
-	struct intel_display *display = to_intel_display(dev);
-	struct drm_i915_private *dev_priv = to_i915(dev);
+	struct intel_display *display = to_intel_display(fb->dev);
+	struct drm_i915_private *i915 = to_i915(fb->dev);
 	struct drm_gem_object *_obj = intel_fb_bo(fb);
 	struct drm_i915_gem_object *obj = to_intel_bo(_obj);
 	struct i915_address_space *vm = i915_dpt_to_vm(dpt);
@@ -43,7 +40,7 @@ intel_fb_pin_to_dpt(const struct drm_framebuffer *fb,
 	 * We are not syncing against the binding (and potential migrations)
 	 * below, so this vm must never be async.
 	 */
-	if (drm_WARN_ON(&dev_priv->drm, vm->bind_async_flags))
+	if (drm_WARN_ON(&i915->drm, vm->bind_async_flags))
 		return ERR_PTR(-EINVAL);
 
 	if (WARN_ON(!i915_gem_object_is_framebuffer(obj)))
@@ -56,7 +53,7 @@ intel_fb_pin_to_dpt(const struct drm_framebuffer *fb,
 		if (ret)
 			continue;
 
-		if (HAS_LMEM(dev_priv)) {
+		if (HAS_LMEM(i915)) {
 			unsigned int flags = obj->flags;
 
 			/*
@@ -77,19 +74,20 @@ intel_fb_pin_to_dpt(const struct drm_framebuffer *fb,
 		if (ret)
 			continue;
 
-		vma = i915_vma_instance(obj, vm, view);
+		vma = i915_vma_instance(obj, vm, pin_params->view);
 		if (IS_ERR(vma)) {
 			ret = PTR_ERR(vma);
 			continue;
 		}
 
-		if (i915_vma_misplaced(vma, 0, alignment, 0)) {
+		if (i915_vma_misplaced(vma, 0, pin_params->alignment, 0)) {
 			ret = i915_vma_unbind(vma);
 			if (ret)
 				continue;
 		}
 
-		ret = i915_vma_pin_ww(vma, &ww, 0, alignment, PIN_GLOBAL);
+		ret = i915_vma_pin_ww(vma, &ww, 0, pin_params->alignment,
+				      PIN_GLOBAL);
 		if (ret)
 			continue;
 	}
@@ -98,7 +96,8 @@ intel_fb_pin_to_dpt(const struct drm_framebuffer *fb,
 		goto err;
 	}
 
-	vma->display_alignment = max(vma->display_alignment, alignment);
+	vma->display_alignment = max(vma->display_alignment,
+				     pin_params->alignment);
 
 	i915_gem_object_flush_if_display(obj);
 
@@ -111,16 +110,11 @@ intel_fb_pin_to_dpt(const struct drm_framebuffer *fb,
 
 struct i915_vma *
 intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
-		     const struct i915_gtt_view *view,
-		     unsigned int alignment,
-		     unsigned int phys_alignment,
-		     unsigned int vtd_guard,
-		     bool uses_fence,
-		     unsigned long *out_flags)
+		     const struct intel_fb_pin_params *pin_params,
+		     int *out_fence_id)
 {
-	struct drm_device *dev = fb->dev;
-	struct intel_display *display = to_intel_display(dev);
-	struct drm_i915_private *dev_priv = to_i915(dev);
+	struct intel_display *display = to_intel_display(fb->dev);
+	struct drm_i915_private *i915 = to_i915(fb->dev);
 	struct drm_gem_object *_obj = intel_fb_bo(fb);
 	struct drm_i915_gem_object *obj = to_intel_bo(_obj);
 	struct ref_tracker *wakeref;
@@ -129,10 +123,11 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 	unsigned int pinctl;
 	int ret;
 
-	if (drm_WARN_ON(dev, !i915_gem_object_is_framebuffer(obj)))
+	if (drm_WARN_ON(&i915->drm, !i915_gem_object_is_framebuffer(obj)))
 		return ERR_PTR(-EINVAL);
 
-	if (drm_WARN_ON(dev, alignment && !is_power_of_2(alignment)))
+	if (drm_WARN_ON(&i915->drm, pin_params->alignment &&
+			!is_power_of_2(pin_params->alignment)))
 		return ERR_PTR(-EINVAL);
 
 	/*
@@ -161,23 +156,28 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 	i915_gem_ww_ctx_init(&ww, true);
 retry:
 	ret = i915_gem_object_lock(obj, &ww);
-	if (!ret && phys_alignment)
-		ret = i915_gem_object_attach_phys(obj, phys_alignment);
-	else if (!ret && HAS_LMEM(dev_priv))
+	if (!ret && pin_params->phys_alignment)
+		ret = i915_gem_object_attach_phys(obj, pin_params->phys_alignment);
+	else if (!ret && HAS_LMEM(i915))
 		ret = i915_gem_object_migrate(obj, &ww, INTEL_REGION_LMEM_0);
 	if (!ret)
 		ret = i915_gem_object_pin_pages(obj);
 	if (ret)
 		goto err;
 
-	vma = i915_gem_object_pin_to_display_plane(obj, &ww, alignment,
-						   vtd_guard, view, pinctl);
+	vma = i915_gem_object_pin_to_display_plane(obj, &ww,
+						   pin_params->alignment,
+						   pin_params->vtd_guard,
+						   pin_params->view, pinctl);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto err_unpin;
 	}
 
-	if (uses_fence && i915_vma_is_map_and_fenceable(vma)) {
+	if (out_fence_id)
+		*out_fence_id = -1;
+
+	if (out_fence_id && i915_vma_is_map_and_fenceable(vma)) {
 		/*
 		 * Install a fence for tiled scan-out. Pre-i965 always needs a
 		 * fence, whereas 965+ only requires a fence if using
@@ -203,7 +203,7 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 		ret = 0;
 
 		if (vma->fence)
-			*out_flags |= PLANE_HAS_FENCE;
+			*out_fence_id = vma->fence->id;
 	}
 
 	i915_vma_get(vma);
@@ -225,9 +225,9 @@ intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
 	return vma;
 }
 
-void intel_fb_unpin_vma(struct i915_vma *vma, unsigned long flags)
+void intel_fb_unpin_vma(struct i915_vma *vma, int fence_id)
 {
-	if (flags & PLANE_HAS_FENCE)
+	if (fence_id >= 0)
 		i915_vma_unpin_fence(vma);
 	i915_vma_unpin(vma);
 	i915_vma_put(vma);
@@ -264,36 +264,41 @@ intel_plane_fb_vtd_guard(const struct intel_plane_state *plane_state)
 int intel_plane_pin_fb(struct intel_plane_state *plane_state,
 		       const struct intel_plane_state *old_plane_state)
 {
-	struct intel_display *display = to_intel_display(plane_state);
+	struct drm_i915_private *i915 = to_i915(plane_state->uapi.plane->dev);
 	struct intel_plane *plane = to_intel_plane(plane_state->uapi.plane);
 	const struct intel_framebuffer *fb =
 		to_intel_framebuffer(plane_state->hw.fb);
 	struct i915_vma *vma;
 
 	if (!intel_fb_uses_dpt(&fb->base)) {
-		vma = intel_fb_pin_to_ggtt(&fb->base, &plane_state->view.gtt,
-					   intel_plane_fb_min_alignment(plane_state),
-					   intel_plane_fb_min_phys_alignment(plane_state),
-					   intel_plane_fb_vtd_guard(plane_state),
-					   intel_plane_uses_fence(plane_state),
-					   &plane_state->flags);
+		struct intel_fb_pin_params pin_params = {
+			.view = &plane_state->view.gtt,
+			.alignment = intel_plane_fb_min_alignment(plane_state),
+			.phys_alignment = intel_plane_fb_min_phys_alignment(plane_state),
+			.vtd_guard = intel_plane_fb_vtd_guard(plane_state),
+		};
+		int fence_id = -1;
+
+		vma = intel_fb_pin_to_ggtt(&fb->base, &pin_params,
+					   intel_plane_uses_fence(plane_state) ? &fence_id : NULL);
 		if (IS_ERR(vma))
 			return PTR_ERR(vma);
 
 		plane_state->ggtt_vma = vma;
-
+		plane_state->fence_id = fence_id;
 	} else {
-		unsigned int alignment = intel_plane_fb_min_alignment(plane_state);
+		struct intel_fb_pin_params pin_params = {
+			.view = &plane_state->view.gtt,
+			.alignment = intel_plane_fb_min_alignment(plane_state),
+		};
 
-		vma = i915_dpt_pin_to_ggtt(fb->dpt, alignment / 512);
+		vma = i915_dpt_pin_to_ggtt(fb->dpt, pin_params.alignment / 512);
 		if (IS_ERR(vma))
 			return PTR_ERR(vma);
 
 		plane_state->ggtt_vma = vma;
 
-		vma = intel_fb_pin_to_dpt(&fb->base, &plane_state->view.gtt,
-					  alignment, &plane_state->flags,
-					  fb->dpt);
+		vma = intel_fb_pin_to_dpt(&fb->base, fb->dpt, &pin_params);
 		if (IS_ERR(vma)) {
 			i915_dpt_unpin_from_ggtt(fb->dpt);
 			plane_state->ggtt_vma = NULL;
@@ -308,7 +313,7 @@ int intel_plane_pin_fb(struct intel_plane_state *plane_state,
 		 * The DPT object contains only one vma, and there is no VT-d
 		 * guard, so the VMA's offset within the DPT is always 0.
 		 */
-		drm_WARN_ON(display->drm, i915_dpt_offset(plane_state->dpt_vma));
+		drm_WARN_ON(&i915->drm, i915_dpt_offset(plane_state->dpt_vma));
 	}
 
 	/*
@@ -338,12 +343,14 @@ void intel_plane_unpin_fb(struct intel_plane_state *old_plane_state)
 
 	if (!intel_fb_uses_dpt(&fb->base)) {
 		vma = fetch_and_zero(&old_plane_state->ggtt_vma);
-		if (vma)
-			intel_fb_unpin_vma(vma, old_plane_state->flags);
+		if (vma) {
+			intel_fb_unpin_vma(vma, old_plane_state->fence_id);
+			old_plane_state->fence_id = -1;
+		}
 	} else {
 		vma = fetch_and_zero(&old_plane_state->dpt_vma);
 		if (vma)
-			intel_fb_unpin_vma(vma, old_plane_state->flags);
+			intel_fb_unpin_vma(vma, -1);
 
 		vma = fetch_and_zero(&old_plane_state->ggtt_vma);
 		if (vma)
diff --git a/drivers/gpu/drm/i915/display/intel_fb_pin.h b/drivers/gpu/drm/i915/display/intel_fb_pin.h
index 81ab79da1af7..e6271437459d 100644
--- a/drivers/gpu/drm/i915/display/intel_fb_pin.h
+++ b/drivers/gpu/drm/i915/display/intel_fb_pin.h
@@ -14,16 +14,19 @@ struct intel_plane_state;
 struct i915_gtt_view;
 struct iosys_map;
 
+struct intel_fb_pin_params {
+	const struct i915_gtt_view *view;
+	unsigned int alignment;
+	unsigned int phys_alignment;
+	unsigned int vtd_guard;
+};
+
 struct i915_vma *
 intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
-		     const struct i915_gtt_view *view,
-		     unsigned int alignment,
-		     unsigned int phys_alignment,
-		     unsigned int vtd_guard,
-		     bool uses_fence,
-		     unsigned long *out_flags);
-
-void intel_fb_unpin_vma(struct i915_vma *vma, unsigned long flags);
+		     const struct intel_fb_pin_params *pin_params,
+		     int *out_fence_id);
+
+void intel_fb_unpin_vma(struct i915_vma *vma, int fence_id);
 
 int intel_plane_pin_fb(struct intel_plane_state *new_plane_state,
 		       const struct intel_plane_state *old_plane_state);
diff --git a/drivers/gpu/drm/i915/display/intel_fbc.c b/drivers/gpu/drm/i915/display/intel_fbc.c
index ea0ce00c8474..677ac5be749b 100644
--- a/drivers/gpu/drm/i915/display/intel_fbc.c
+++ b/drivers/gpu/drm/i915/display/intel_fbc.c
@@ -1458,13 +1458,10 @@ static void intel_fbc_update_state(struct intel_atomic_state *state,
 
 	fbc_state->fence_y_offset = intel_plane_fence_y_offset(plane_state);
 
-	drm_WARN_ON(display->drm, plane_state->flags & PLANE_HAS_FENCE &&
+	drm_WARN_ON(display->drm, plane_state->fence_id >= 0 &&
 		    !intel_fbc_has_fences(display));
 
-	if (plane_state->flags & PLANE_HAS_FENCE)
-		fbc_state->fence_id = intel_parent_vma_fence_id(display, plane_state->ggtt_vma);
-	else
-		fbc_state->fence_id = -1;
+	fbc_state->fence_id = plane_state->fence_id;
 
 	fbc_state->cfb_stride = intel_fbc_cfb_stride(plane_state);
 	fbc_state->cfb_size = intel_fbc_cfb_size(plane_state);
@@ -1487,9 +1484,7 @@ static bool intel_fbc_is_fence_ok(const struct intel_plane_state *plane_state)
 	 * so have no fence associated with it) due to aperture constraints
 	 * at the time of pinning.
 	 */
-	return DISPLAY_VER(display) >= 9 ||
-		(plane_state->flags & PLANE_HAS_FENCE &&
-		 intel_parent_vma_fence_id(display, plane_state->ggtt_vma) != -1);
+	return DISPLAY_VER(display) >= 9 || plane_state->fence_id >= 0;
 }
 
 static bool intel_fbc_is_cfb_ok(const struct intel_plane_state *plane_state)
diff --git a/drivers/gpu/drm/i915/display/intel_fbdev.c b/drivers/gpu/drm/i915/display/intel_fbdev.c
index bdaaf3edba0c..ece57f790a0f 100644
--- a/drivers/gpu/drm/i915/display/intel_fbdev.c
+++ b/drivers/gpu/drm/i915/display/intel_fbdev.c
@@ -60,7 +60,6 @@
 struct intel_fbdev {
 	struct intel_framebuffer *fb;
 	struct i915_vma *vma;
-	unsigned long vma_flags;
 };
 
 static struct intel_fbdev *to_intel_fbdev(struct drm_fb_helper *fb_helper)
@@ -141,7 +140,7 @@ static void intel_fbdev_fb_destroy(struct fb_info *info)
 	 * the info->screen_base mmaping. Leaking the VMA is simpler than
 	 * trying to rectify all the possible error paths leading here.
 	 */
-	intel_fb_unpin_vma(ifbdev->vma, ifbdev->vma_flags);
+	intel_fb_unpin_vma(ifbdev->vma, -1);
 	drm_framebuffer_remove(fb_helper->fb);
 
 	drm_client_release(&fb_helper->client);
@@ -265,11 +264,11 @@ int intel_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 {
 	struct intel_display *display = to_intel_display(helper->dev);
 	struct intel_fbdev *ifbdev = to_intel_fbdev(helper);
+	struct intel_fb_pin_params pin_params = {};
 	struct intel_framebuffer *fb = ifbdev->fb;
 	struct fb_info *info = helper->info;
 	struct ref_tracker *wakeref;
 	struct i915_vma *vma;
-	unsigned long flags = 0;
 	bool prealloc = false;
 	struct drm_gem_object *obj;
 	int ret;
@@ -310,11 +309,13 @@ int intel_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	 * This also validates that any existing fb inherited from the
 	 * BIOS is suitable for own access.
 	 */
-	vma = intel_fb_pin_to_ggtt(&fb->base, &fb->normal_view.gtt,
-				   fb->min_alignment, 0,
-				   intel_fb_view_vtd_guard(&fb->base, &fb->normal_view,
-							   DRM_MODE_ROTATE_0),
-				   false, &flags);
+	pin_params.view = &fb->normal_view.gtt;
+	pin_params.alignment = fb->min_alignment;
+	pin_params.vtd_guard = intel_fb_view_vtd_guard(&fb->base,
+						       &fb->normal_view,
+						       DRM_MODE_ROTATE_0);
+
+	vma = intel_fb_pin_to_ggtt(&fb->base, &pin_params, NULL);
 	if (IS_ERR(vma)) {
 		ret = PTR_ERR(vma);
 		goto out_unlock;
@@ -345,14 +346,13 @@ int intel_fbdev_driver_fbdev_probe(struct drm_fb_helper *helper,
 	drm_dbg_kms(display->drm, "allocated %dx%d fb\n", fb->base.width, fb->base.height);
 	ifbdev->fb = fb;
 	ifbdev->vma = vma;
-	ifbdev->vma_flags = flags;
 
 	intel_display_rpm_put(display, wakeref);
 
 	return 0;
 
 out_unpin:
-	intel_fb_unpin_vma(vma, flags);
+	intel_fb_unpin_vma(vma, -1);
 out_unlock:
 	intel_display_rpm_put(display, wakeref);
 
diff --git a/drivers/gpu/drm/i915/display/intel_plane.c b/drivers/gpu/drm/i915/display/intel_plane.c
index 07eae4176dad..da68f6e650a4 100644
--- a/drivers/gpu/drm/i915/display/intel_plane.c
+++ b/drivers/gpu/drm/i915/display/intel_plane.c
@@ -70,6 +70,7 @@ static void intel_plane_state_reset(struct intel_plane_state *plane_state,
 	__drm_atomic_helper_plane_state_reset(&plane_state->uapi, &plane->base);
 
 	plane_state->scaler_id = -1;
+	plane_state->fence_id = -1;
 }
 
 struct intel_plane *intel_plane_alloc(void)
@@ -137,7 +138,7 @@ intel_plane_duplicate_state(struct drm_plane *plane)
 
 	intel_state->ggtt_vma = NULL;
 	intel_state->dpt_vma = NULL;
-	intel_state->flags = 0;
+	intel_state->fence_id = -1;
 	intel_state->damage = DRM_RECT_INIT(0, 0, 0, 0);
 
 	/* add reference to fb */
diff --git a/drivers/gpu/drm/i915/i915_initial_plane.c b/drivers/gpu/drm/i915/i915_initial_plane.c
index 390a9248d631..db51a468ddd4 100644
--- a/drivers/gpu/drm/i915/i915_initial_plane.c
+++ b/drivers/gpu/drm/i915/i915_initial_plane.c
@@ -268,7 +268,7 @@ i915_initial_plane_setup(struct drm_plane_state *_plane_state,
 	plane_state->ggtt_vma = i915_vma_get(vma);
 	if (intel_plane_uses_fence(plane_state) &&
 	    i915_vma_pin_fence(vma) == 0 && vma->fence)
-		plane_state->flags |= PLANE_HAS_FENCE;
+		plane_state->fence_id = vma->fence->id;
 
 	plane_state->surf = i915_ggtt_offset(plane_state->ggtt_vma);
 
diff --git a/drivers/gpu/drm/xe/display/xe_fb_pin.c b/drivers/gpu/drm/xe/display/xe_fb_pin.c
index bfbe3e44e78d..cacd861ac60c 100644
--- a/drivers/gpu/drm/xe/display/xe_fb_pin.c
+++ b/drivers/gpu/drm/xe/display/xe_fb_pin.c
@@ -140,14 +140,14 @@ write_dpt_remapped(struct xe_bo *bo,
 }
 
 static int __xe_pin_fb_vma_dpt(const struct intel_framebuffer *fb,
-			       const struct i915_gtt_view *view,
-			       struct i915_vma *vma,
-			       unsigned int alignment)
+			       const struct intel_fb_pin_params *pin_params,
+			       struct i915_vma *vma)
 {
 	struct xe_device *xe = to_xe_device(fb->base.dev);
 	struct xe_tile *tile0 = xe_device_get_root_tile(xe);
 	struct xe_ggtt *ggtt = tile0->mem.ggtt;
 	struct drm_gem_object *obj = intel_fb_bo(&fb->base);
+	const struct i915_gtt_view *view = pin_params->view;
 	struct xe_bo *bo = gem_to_xe_bo(obj), *dpt;
 	u32 dpt_size, size = bo->ttm.base.size;
 
@@ -161,31 +161,14 @@ static int __xe_pin_fb_vma_dpt(const struct intel_framebuffer *fb,
 		dpt_size = ALIGN(intel_rotation_info_size(&view->rotated) * 8,
 				 XE_PAGE_SIZE);
 
-	if (IS_DGFX(xe))
-		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
-						   dpt_size, ~0ull,
-						   ttm_bo_type_kernel,
-						   XE_BO_FLAG_VRAM0 |
-						   XE_BO_FLAG_GGTT |
-						   XE_BO_FLAG_PAGETABLE,
-						   alignment, false);
-	else
-		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
-						   dpt_size,  ~0ull,
-						   ttm_bo_type_kernel,
-						   XE_BO_FLAG_STOLEN |
-						   XE_BO_FLAG_GGTT |
-						   XE_BO_FLAG_PAGETABLE,
-						   alignment, false);
-	if (IS_ERR(dpt))
-		dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
-						   dpt_size,  ~0ull,
-						   ttm_bo_type_kernel,
-						   XE_BO_FLAG_SYSTEM |
-						   XE_BO_FLAG_GGTT |
-						   XE_BO_FLAG_PAGETABLE |
-						   XE_BO_FLAG_FORCE_WC,
-						   alignment, false);
+	dpt = xe_bo_create_pin_map_at_novm(xe, tile0,
+					   dpt_size,  ~0ull,
+					   ttm_bo_type_kernel,
+					   XE_BO_FLAG_VRAM_IF_DGFX(tile0) |
+					   XE_BO_FLAG_GGTT |
+					   XE_BO_FLAG_PAGETABLE |
+					   XE_BO_FLAG_FORCE_WC,
+					   pin_params->alignment, false);
 	if (IS_ERR(dpt))
 		return PTR_ERR(dpt);
 
@@ -269,11 +252,11 @@ static void write_ggtt_rotated_node(struct xe_ggtt *ggtt, struct xe_ggtt_node *n
 }
 
 static int __xe_pin_fb_vma_ggtt(const struct intel_framebuffer *fb,
-				const struct i915_gtt_view *view,
-				struct i915_vma *vma,
-				unsigned int alignment)
+				const struct intel_fb_pin_params *pin_params,
+				struct i915_vma *vma)
 {
 	struct drm_gem_object *obj = intel_fb_bo(&fb->base);
+	const struct i915_gtt_view *view = pin_params->view;
 	struct xe_bo *bo = gem_to_xe_bo(obj);
 	struct xe_device *xe = to_xe_device(fb->base.dev);
 	struct xe_tile *tile0 = xe_device_get_root_tile(xe);
@@ -319,8 +302,7 @@ static int __xe_pin_fb_vma_ggtt(const struct intel_framebuffer *fb,
 }
 
 static struct i915_vma *__xe_pin_fb_vma(const struct intel_framebuffer *fb,
-					const struct i915_gtt_view *view,
-					unsigned int alignment)
+					const struct intel_fb_pin_params *pin_params)
 {
 	struct drm_device *dev = fb->base.dev;
 	struct xe_device *xe = to_xe_device(dev);
@@ -377,9 +359,9 @@ static struct i915_vma *__xe_pin_fb_vma(const struct intel_framebuffer *fb,
 
 	vma->bo = bo;
 	if (intel_fb_uses_dpt(&fb->base))
-		ret = __xe_pin_fb_vma_dpt(fb, view, vma, alignment);
+		ret = __xe_pin_fb_vma_dpt(fb, pin_params, vma);
 	else
-		ret = __xe_pin_fb_vma_ggtt(fb, view, vma,  alignment);
+		ret = __xe_pin_fb_vma_ggtt(fb, pin_params, vma);
 	if (ret)
 		goto err_unpin;
 
@@ -414,19 +396,16 @@ static void __xe_unpin_fb_vma(struct i915_vma *vma)
 
 struct i915_vma *
 intel_fb_pin_to_ggtt(const struct drm_framebuffer *fb,
-		     const struct i915_gtt_view *view,
-		     unsigned int alignment,
-		     unsigned int phys_alignment,
-		     unsigned int vtd_guard,
-		     bool uses_fence,
-		     unsigned long *out_flags)
+		     const struct intel_fb_pin_params *pin_params,
+		     int *out_fence_id)
 {
-	*out_flags = 0;
+	if (out_fence_id)
+		*out_fence_id = -1;
 
-	return __xe_pin_fb_vma(to_intel_framebuffer(fb), view, alignment);
+	return __xe_pin_fb_vma(to_intel_framebuffer(fb), pin_params);
 }
 
-void intel_fb_unpin_vma(struct i915_vma *vma, unsigned long flags)
+void intel_fb_unpin_vma(struct i915_vma *vma, int fence_id)
 {
 	__xe_unpin_fb_vma(vma);
 }
@@ -475,7 +454,10 @@ int intel_plane_pin_fb(struct intel_plane_state *new_plane_state,
 	struct i915_vma *vma;
 	struct intel_framebuffer *intel_fb = to_intel_framebuffer(fb);
 	struct intel_plane *plane = to_intel_plane(new_plane_state->uapi.plane);
-	unsigned int alignment = plane->min_alignment(plane, fb, 0);
+	struct intel_fb_pin_params pin_params = {
+		.view = &new_plane_state->view.gtt,
+		.alignment = plane->min_alignment(plane, fb, 0),
+	};
 
 	if (reuse_vma(new_plane_state, old_plane_state))
 		return 0;
@@ -484,7 +466,7 @@ int intel_plane_pin_fb(struct intel_plane_state *new_plane_state,
 	drm_WARN_ON(bo->ttm.base.dev, !(bo->flags & XE_BO_FLAG_FORCE_WC) &&
 		    bo->ttm.type != ttm_bo_type_sg);
 
-	vma = __xe_pin_fb_vma(intel_fb, &new_plane_state->view.gtt, alignment);
+	vma = __xe_pin_fb_vma(intel_fb, &pin_params);
 
 	if (IS_ERR(vma))
 		return PTR_ERR(vma);
diff --git a/drivers/gpu/drm/xe/display/xe_initial_plane.c b/drivers/gpu/drm/xe/display/xe_initial_plane.c
index 8bcae552dddc..822f03460660 100644
--- a/drivers/gpu/drm/xe/display/xe_initial_plane.c
+++ b/drivers/gpu/drm/xe/display/xe_initial_plane.c
@@ -151,9 +151,11 @@ xe_initial_plane_setup(struct drm_plane_state *_plane_state,
 {
 	struct intel_plane_state *plane_state = to_intel_plane_state(_plane_state);
 	struct i915_vma *vma;
+	struct intel_fb_pin_params pin_params = {
+		.view = &plane_state->view.gtt,
+	};
 
-	vma = intel_fb_pin_to_ggtt(fb, &plane_state->view.gtt,
-				   0, 0, 0, false, &plane_state->flags);
+	vma = intel_fb_pin_to_ggtt(fb, &pin_params, NULL);
 	if (IS_ERR(vma))
 		return PTR_ERR(vma);
 
diff --git a/drivers/hid/Kconfig b/drivers/hid/Kconfig
index ff2f580b660b..8c323f019098 100644
--- a/drivers/hid/Kconfig
+++ b/drivers/hid/Kconfig
@@ -1026,6 +1026,7 @@ config HID_PXRC
 
 config HID_RAPOO
 	tristate "Rapoo non-fully HID-compliant devices"
+	depends on USB_HID
 	help
 	Support for Rapoo devices that are not fully compliant with the
 	HID standard.
diff --git a/drivers/hid/hid-asus.c b/drivers/hid/hid-asus.c
index 3f5e96900b67..befa990b3210 100644
--- a/drivers/hid/hid-asus.c
+++ b/drivers/hid/hid-asus.c
@@ -753,7 +753,7 @@ static int asus_kbd_register_leds(struct hid_device *hdev)
 			return ret;
 	}
 
-	if (drvdata->quirks & QUIRK_ROG_ALLY_XPAD) {
+	if ((drvdata->quirks & QUIRK_ROG_ALLY_XPAD) && hid_is_usb(hdev)) {
 		intf = to_usb_interface(hdev->dev.parent);
 		udev = interface_to_usbdev(intf);
 		validate_mcu_fw_version(hdev,
diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
index cf123347a2af..d6fbc2111fac 100644
--- a/drivers/hid/hid-core.c
+++ b/drivers/hid/hid-core.c
@@ -379,6 +379,9 @@ static int hid_add_field(struct hid_parser *parser, unsigned report_type, unsign
 
 static u32 item_udata(struct hid_item *item)
 {
+	if (item->format != HID_ITEM_FORMAT_SHORT)
+		return 0;
+
 	switch (item->size) {
 	case 1: return item->data.u8;
 	case 2: return item->data.u16;
@@ -389,6 +392,9 @@ static u32 item_udata(struct hid_item *item)
 
 static s32 item_sdata(struct hid_item *item)
 {
+	if (item->format != HID_ITEM_FORMAT_SHORT)
+		return 0;
+
 	switch (item->size) {
 	case 1: return item->data.s8;
 	case 2: return item->data.s16;
@@ -1933,13 +1939,14 @@ int hid_set_field(struct hid_field *field, unsigned offset, __s32 value)
 
 	size = field->report_size;
 
-	hid_dump_input(field->report->device, field->usage + offset, value);
-
 	if (offset >= field->report_count) {
 		hid_err(field->report->device, "offset (%d) exceeds report_count (%d)\n",
 				offset, field->report_count);
 		return -1;
 	}
+
+	hid_dump_input(field->report->device, field->usage + offset, value);
+
 	if (field->logical_minimum < 0) {
 		if (value != snto32(s32ton(value, size), size)) {
 			hid_err(field->report->device, "value %d is out of range\n", value);
diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 70e2eedb465a..f479459544ae 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -240,6 +240,8 @@ struct ft260_device {
 	struct mutex lock;
 	u8 write_buf[FT260_REPORT_MAX_LENGTH];
 	unsigned long need_wakeup_at;
+	/* Protects read_buf, read_idx and read_len against ft260_raw_event() */
+	spinlock_t read_lock;
 	u8 *read_buf;
 	u16 read_idx;
 	u16 read_len;
@@ -501,6 +503,7 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 	int timeout, ret = 0;
 	struct ft260_i2c_read_request_report rep;
 	struct hid_device *hdev = dev->hdev;
+	unsigned long irqflags;
 	u8 bus_busy = 0;
 
 	if ((flag & FT260_FLAG_START_REPEATED) == FT260_FLAG_START_REPEATED)
@@ -526,9 +529,11 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 
 		reinit_completion(&dev->wait);
 
+		spin_lock_irqsave(&dev->read_lock, irqflags);
 		dev->read_idx = 0;
 		dev->read_buf = data;
 		dev->read_len = rd_len;
+		spin_unlock_irqrestore(&dev->read_lock, irqflags);
 
 		ret = ft260_hid_output_report(hdev, (u8 *)&rep, sizeof(rep));
 		if (ret < 0) {
@@ -543,7 +548,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 			goto ft260_i2c_read_exit;
 		}
 
+		spin_lock_irqsave(&dev->read_lock, irqflags);
 		dev->read_buf = NULL;
+		spin_unlock_irqrestore(&dev->read_lock, irqflags);
 
 		if (flag & FT260_FLAG_STOP)
 			bus_busy = FT260_I2C_STATUS_BUS_BUSY;
@@ -562,7 +569,9 @@ static int ft260_i2c_read(struct ft260_device *dev, u8 addr, u8 *data,
 	} while (len > 0);
 
 ft260_i2c_read_exit:
+	spin_lock_irqsave(&dev->read_lock, irqflags);
 	dev->read_buf = NULL;
+	spin_unlock_irqrestore(&dev->read_lock, irqflags);
 	return ret;
 }
 
@@ -1018,6 +1027,7 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		 "FT260 usb-i2c bridge");
 
 	mutex_init(&dev->lock);
+	spin_lock_init(&dev->read_lock);
 	init_completion(&dev->wait);
 
 	ret = ft260_xfer_status(dev, FT260_I2C_STATUS_BUS_BUSY);
@@ -1067,6 +1077,7 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 {
 	struct ft260_device *dev = hid_get_drvdata(hdev);
 	struct ft260_i2c_input_report *xfer = (void *)data;
+	unsigned long irqflags;
 
 	if (size < offsetof(struct ft260_i2c_input_report, data)) {
 		hid_err(hdev, "short report %d\n", size);
@@ -1075,6 +1086,8 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 
 	if (xfer->report >= FT260_I2C_REPORT_MIN &&
 	    xfer->report <= FT260_I2C_REPORT_MAX) {
+		bool complete_read;
+
 		ft260_dbg("i2c resp: rep %#02x len %d size %d\n",
 			  xfer->report, xfer->length, size);
 
@@ -1085,8 +1098,15 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 			return -1;
 		}
 
+		/*
+		 * Hold read_lock so a timed-out ft260_i2c_read() cannot
+		 * clear read_buf between the NULL check and the memcpy.
+		 */
+		spin_lock_irqsave(&dev->read_lock, irqflags);
+
 		if ((dev->read_buf == NULL) ||
 		    (xfer->length > dev->read_len - dev->read_idx)) {
+			spin_unlock_irqrestore(&dev->read_lock, irqflags);
 			hid_err(hdev, "unexpected report %#02x, length %d\n",
 				xfer->report, xfer->length);
 			return -1;
@@ -1095,8 +1115,11 @@ static int ft260_raw_event(struct hid_device *hdev, struct hid_report *report,
 		memcpy(&dev->read_buf[dev->read_idx], &xfer->data,
 		       xfer->length);
 		dev->read_idx += xfer->length;
+		complete_read = dev->read_idx == dev->read_len;
+
+		spin_unlock_irqrestore(&dev->read_lock, irqflags);
 
-		if (dev->read_idx == dev->read_len)
+		if (complete_read)
 			complete(&dev->wait);
 
 	} else {
diff --git a/drivers/hid/hid-huawei.c b/drivers/hid/hid-huawei.c
index 6a616bf21b38..ee3fc6f68475 100644
--- a/drivers/hid/hid-huawei.c
+++ b/drivers/hid/hid-huawei.c
@@ -44,11 +44,12 @@ static const __u8 huawei_cd30_kbd_rdesc_fixed[] = {
 static const __u8 *huawei_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 				  unsigned int *rsize)
 {
-	struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
+	struct usb_interface *intf = hid_is_usb(hdev) ?
+			to_usb_interface(hdev->dev.parent) : NULL;
 
 	switch (hdev->product) {
 	case USB_DEVICE_ID_HUAWEI_CD30KBD:
-		if (intf->cur_altsetting->desc.bInterfaceNumber == 1) {
+		if (!intf || intf->cur_altsetting->desc.bInterfaceNumber == 1) {
 			if (*rsize != sizeof(huawei_cd30_kbd_rdesc_fixed) ||
 				memcmp(huawei_cd30_kbd_rdesc_fixed, rdesc,
 					sizeof(huawei_cd30_kbd_rdesc_fixed)) != 0) {
diff --git a/drivers/hid/hid-hyperv.c b/drivers/hid/hid-hyperv.c
index 7d2b0063df15..fd90196430e2 100644
--- a/drivers/hid/hid-hyperv.c
+++ b/drivers/hid/hid-hyperv.c
@@ -171,18 +171,32 @@ static void mousevsc_free_device(struct mousevsc_dev *device)
 }
 
 static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
-				struct synthhid_device_info *device_info)
+					    struct synthhid_device_info *device_info,
+					    u32 device_info_size)
 {
 	int ret = 0;
 	struct hid_descriptor *desc;
 	struct mousevsc_prt_msg ack;
+	size_t desc_offset;
+	size_t desc_size;
 
 	input_device->dev_info_status = -ENOMEM;
 
+	if (device_info_size < sizeof(*device_info)) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
+
 	input_device->hid_dev_info = device_info->hid_dev_info;
 	desc = &device_info->hid_descriptor;
+	desc_offset = offsetof(struct synthhid_device_info, hid_descriptor);
+	desc_size = device_info_size - desc_offset;
 	if (desc->bLength == 0)
 		goto cleanup;
+	if (desc->bLength < sizeof(*desc) || desc->bLength > desc_size) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
 
 	/* The pointer is not NULL when we resume from hibernation */
 	kfree(input_device->hid_desc);
@@ -197,6 +211,10 @@ static void mousevsc_on_receive_device_info(struct mousevsc_dev *input_device,
 		input_device->dev_info_status = -EINVAL;
 		goto cleanup;
 	}
+	if (input_device->report_desc_size > desc_size - desc->bLength) {
+		input_device->dev_info_status = -EINVAL;
+		goto cleanup;
+	}
 
 	/* The pointer is not NULL when we resume from hibernation */
 	kfree(input_device->report_desc);
@@ -273,14 +291,17 @@ static void mousevsc_on_receive(struct hv_device *device,
 		break;
 
 	case SYNTH_HID_INITIAL_DEVICE_INFO:
-		WARN_ON(pipe_msg->size < sizeof(struct hv_input_dev_info));
+		if (WARN_ON_ONCE(pipe_msg->size <
+				 sizeof(struct synthhid_device_info)))
+			break;
 
 		/*
 		 * Parse out the device info into device attr,
 		 * hid desc and report desc
 		 */
 		mousevsc_on_receive_device_info(input_dev,
-			(struct synthhid_device_info *)pipe_msg->data);
+						(struct synthhid_device_info *)pipe_msg->data,
+						pipe_msg->size);
 		break;
 	case SYNTH_HID_INPUT_REPORT:
 		input_report =
diff --git a/drivers/hid/hid-input.c b/drivers/hid/hid-input.c
index c7b8c4ff7a33..39c2ae84baaa 100644
--- a/drivers/hid/hid-input.c
+++ b/drivers/hid/hid-input.c
@@ -375,6 +375,9 @@ static const struct hid_device_id hid_battery_quirks[] = {
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_APPLE,
 		USB_DEVICE_ID_APPLE_MAGICTRACKPAD),
 	  HID_BATTERY_QUIRK_IGNORE },
+	{ HID_BLUETOOTH_DEVICE(BT_VENDOR_ID_APPLE,
+		USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC),
+	  HID_BATTERY_QUIRK_AVOID_QUERY },
 	{ HID_BLUETOOTH_DEVICE(USB_VENDOR_ID_ELECOM,
 		USB_DEVICE_ID_ELECOM_BM084),
 	  HID_BATTERY_QUIRK_IGNORE },
@@ -430,17 +433,25 @@ static int hidinput_scale_battery_capacity(struct hid_battery *bat,
 static int hidinput_query_battery_capacity(struct hid_battery *bat)
 {
 	int ret;
+	/*
+	 * The capacity field may not be the first field in the report: some
+	 * devices (e.g. the Apple Magic Trackpad 2 over Bluetooth) precede it
+	 * with status flags. Read it from its actual byte offset in the report
+	 * (report_offset is in bits; the leading byte is the report id).
+	 */
+	int offset = 1 + bat->report_offset / 8;
+	int len = offset + 1;
 
-	u8 *buf __free(kfree) = kmalloc(4, GFP_KERNEL);
+	u8 *buf __free(kfree) = kmalloc(max(len, 4), GFP_KERNEL);
 	if (!buf)
 		return -ENOMEM;
 
-	ret = hid_hw_raw_request(bat->dev, bat->report_id, buf, 4,
+	ret = hid_hw_raw_request(bat->dev, bat->report_id, buf, max(len, 4),
 				 bat->report_type, HID_REQ_GET_REPORT);
-	if (ret < 2)
+	if (ret < len)
 		return -ENODATA;
 
-	return hidinput_scale_battery_capacity(bat, buf[1]);
+	return hidinput_scale_battery_capacity(bat, buf[offset]);
 }
 
 static int hidinput_get_battery_property(struct power_supply *psy,
@@ -591,6 +602,7 @@ static int hidinput_setup_battery(struct hid_device *dev, unsigned report_type,
 	bat->max = max;
 	bat->report_type = report_type;
 	bat->report_id = field->report->id;
+	bat->report_offset = field->report_offset;
 	bat->charge_status = POWER_SUPPLY_STATUS_DISCHARGING;
 	bat->status = HID_BATTERY_UNKNOWN;
 
diff --git a/drivers/hid/hid-magicmouse.c b/drivers/hid/hid-magicmouse.c
index 802a3479e24b..d637c0477379 100644
--- a/drivers/hid/hid-magicmouse.c
+++ b/drivers/hid/hid-magicmouse.c
@@ -383,8 +383,8 @@ static void magicmouse_emit_touch(struct magicmouse_sc *msc, int raw_id, u8 *tda
 	}
 }
 
-static int magicmouse_raw_event(struct hid_device *hdev,
-		struct hid_report *report, u8 *data, int size)
+static int __magicmouse_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size, bool nested)
 {
 	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
 	struct input_dev *input = msc->input;
@@ -495,6 +495,15 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 		 * packet.
 		 */
 
+		/*
+		 * A double report only ever wraps two normal reports, so it is
+		 * never nested. Refuse to recurse a second time; otherwise a
+		 * malicious device could chain DOUBLE_REPORT_ID packets to drive
+		 * unbounded recursion and overflow the kernel stack.
+		 */
+		if (nested)
+			return 0;
+
 		/* Ensure that we have at least 2 elements (report type and size) */
 		if (size < 2)
 			return 0;
@@ -506,9 +515,9 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 			return 0;
 		}
 
-		magicmouse_raw_event(hdev, report, data + 2, data[1]);
-		magicmouse_raw_event(hdev, report, data + 2 + data[1],
-			size - 2 - data[1]);
+		__magicmouse_raw_event(hdev, report, data + 2, data[1], true);
+		__magicmouse_raw_event(hdev, report, data + 2 + data[1],
+			size - 2 - data[1], true);
 		return 0;
 	default:
 		return 0;
@@ -534,6 +543,12 @@ static int magicmouse_raw_event(struct hid_device *hdev,
 	return 1;
 }
 
+static int magicmouse_raw_event(struct hid_device *hdev,
+		struct hid_report *report, u8 *data, int size)
+{
+	return __magicmouse_raw_event(hdev, report, data, size, false);
+}
+
 static int magicmouse_event(struct hid_device *hdev, struct hid_field *field,
 		struct hid_usage *usage, __s32 value)
 {
@@ -828,6 +843,12 @@ static bool is_usb_magictrackpad2(__u32 vendor, __u32 product)
 	       product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC;
 }
 
+static bool is_bt_magictrackpad2(__u32 vendor, __u32 product)
+{
+	return vendor == BT_VENDOR_ID_APPLE &&
+	       product == USB_DEVICE_ID_APPLE_MAGICTRACKPAD2_USBC;
+}
+
 static int magicmouse_fetch_battery(struct hid_device *hdev)
 {
 #ifdef CONFIG_HID_BATTERY_STRENGTH
@@ -838,7 +859,8 @@ static int magicmouse_fetch_battery(struct hid_device *hdev)
 	bat = hid_get_battery(hdev);
 	if (!bat ||
 	    (!is_usb_magicmouse2(hdev->vendor, hdev->product) &&
-	     !is_usb_magictrackpad2(hdev->vendor, hdev->product)))
+	     !is_usb_magictrackpad2(hdev->vendor, hdev->product) &&
+	     !is_bt_magictrackpad2(hdev->vendor, hdev->product)))
 		return -1;
 
 	report_enum = &hdev->report_enum[bat->report_type];
@@ -900,6 +922,16 @@ static int magicmouse_probe(struct hid_device *hdev,
 		return ret;
 	}
 
+	/*
+	 * When hidinput_connect() fails it frees every input device it
+	 * created, but that does not fail hid_hw_start(): the core simply
+	 * does not claim an input. msc->input, cached in ->input_mapping
+	 * while the report descriptor was parsed, would then be a dangling
+	 * pointer that passes every NULL check. Trust the core's claim.
+	 */
+	if (!(hdev->claimed & HID_CLAIMED_INPUT))
+		msc->input = NULL;
+
 	if (is_usb_magicmouse2(id->vendor, id->product) ||
 	    is_usb_magictrackpad2(id->vendor, id->product)) {
 		timer_setup(&msc->battery_timer, magicmouse_battery_timer_tick, 0);
@@ -971,6 +1003,16 @@ static int magicmouse_probe(struct hid_device *hdev,
 		schedule_delayed_work(&msc->work, msecs_to_jiffies(500));
 	}
 
+	/*
+	 * Query the Bluetooth Magic Trackpad USB-C battery as done for USB.
+	 * Start io first: probe holds driver_input_lock and the synchronous
+	 * GET_REPORT reply would otherwise be dropped.
+	 */
+	if (is_bt_magictrackpad2(id->vendor, id->product)) {
+		hid_device_io_start(hdev);
+		magicmouse_fetch_battery(hdev);
+	}
+
 	return 0;
 err_stop_hw:
 	if (is_usb_magicmouse2(id->vendor, id->product) ||
@@ -995,6 +1037,22 @@ static void magicmouse_remove(struct hid_device *hdev)
 	hid_hw_stop(hdev);
 }
 
+#ifdef CONFIG_PM
+static int magicmouse_reset_resume(struct hid_device *hdev)
+{
+	struct magicmouse_sc *msc = hid_get_drvdata(hdev);
+
+	/* The device drops out of multitouch mode on resume; re-send the
+	 * enable report.  Only the HID_TYPE_USBMOUSE interface accepts it, and
+	 * it must be deferred. Sending it inline here is too early.
+	 */
+	if (msc && hdev->type == HID_TYPE_USBMOUSE)
+		schedule_delayed_work(&msc->work, msecs_to_jiffies(500));
+
+	return 0;
+}
+#endif
+
 static const __u8 *magicmouse_report_fixup(struct hid_device *hdev, __u8 *rdesc,
 					   unsigned int *rsize)
 {
@@ -1058,6 +1116,9 @@ static struct hid_driver magicmouse_driver = {
 	.event = magicmouse_event,
 	.input_mapping = magicmouse_input_mapping,
 	.input_configured = magicmouse_input_configured,
+#ifdef CONFIG_PM
+	.reset_resume = magicmouse_reset_resume,
+#endif
 };
 module_hid_driver(magicmouse_driver);
 
diff --git a/drivers/hid/hid-nintendo.c b/drivers/hid/hid-nintendo.c
index 29008c2cc530..c3b55f9d7ff3 100644
--- a/drivers/hid/hid-nintendo.c
+++ b/drivers/hid/hid-nintendo.c
@@ -2138,10 +2138,6 @@ static int joycon_input_create(struct joycon_ctlr *ctlr)
 	ctlr->input->phys = hdev->phys;
 	input_set_drvdata(ctlr->input, ctlr);
 
-	ret = input_register_device(ctlr->input);
-	if (ret)
-		return ret;
-
 	if (joycon_type_is_right_joycon(ctlr)) {
 		joycon_config_right_stick(ctlr->input);
 		joycon_config_buttons(ctlr->input, right_joycon_button_mappings);
@@ -2181,6 +2177,10 @@ static int joycon_input_create(struct joycon_ctlr *ctlr)
 	if (joycon_has_rumble(ctlr))
 		joycon_config_rumble(ctlr);
 
+	ret = input_register_device(ctlr->input);
+	if (ret)
+		return ret;
+
 	return 0;
 }
 
@@ -2559,7 +2559,12 @@ static int joycon_ctlr_read_handler(struct joycon_ctlr *ctlr, u8 *data,
 {
 	if (data[0] == JC_INPUT_SUBCMD_REPLY || data[0] == JC_INPUT_IMU_DATA ||
 	    data[0] == JC_INPUT_MCU_DATA) {
-		if (size >= 12) /* make sure it contains the input report */
+		/*
+		 * The whole struct is cast and parsed below, including the
+		 * IMU/subcmd union, not just the 12-byte partial header this
+		 * used to check for.
+		 */
+		if (size >= sizeof(struct joycon_input_report))
 			joycon_parse_report(ctlr,
 					    (struct joycon_input_report *)data);
 	}
@@ -2688,14 +2693,14 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 	ret = joycon_init(hdev);
 	if (ret) {
 		hid_err(hdev, "Failed to initialize controller; ret=%d\n", ret);
-		goto err_close;
+		goto err_io_stop;
 	}
 
 	/* Initialize the leds */
 	ret = joycon_leds_create(ctlr);
 	if (ret) {
 		hid_err(hdev, "Failed to create leds; ret=%d\n", ret);
-		goto err_close;
+		goto err_io_stop;
 	}
 
 	/* Initialize the battery power supply */
@@ -2718,7 +2723,8 @@ static int nintendo_hid_probe(struct hid_device *hdev,
 
 err_ida:
 	ida_free(&nintendo_player_id_allocator, ctlr->player_id);
-err_close:
+err_io_stop:
+	hid_device_io_stop(hdev);
 	hid_hw_close(hdev);
 err_stop:
 	hid_hw_stop(hdev);
diff --git a/drivers/hid/hid-rapoo.c b/drivers/hid/hid-rapoo.c
index 4c81f3086de4..5c9c396fabf7 100644
--- a/drivers/hid/hid-rapoo.c
+++ b/drivers/hid/hid-rapoo.c
@@ -36,7 +36,7 @@ static int rapoo_probe(struct hid_device *hdev, const struct hid_device_id *id)
 		return ret;
 	}
 
-	if (hdev->bus == BUS_USB) {
+	if (hid_is_usb(hdev)) {
 		struct usb_interface *intf = to_usb_interface(hdev->dev.parent);
 
 		if (intf->cur_altsetting->desc.bInterfaceNumber != 1)
diff --git a/drivers/hid/hid-sensor-custom.c b/drivers/hid/hid-sensor-custom.c
index afffea894021..6b0da2e0e1c9 100644
--- a/drivers/hid/hid-sensor-custom.c
+++ b/drivers/hid/hid-sensor-custom.c
@@ -1005,26 +1005,26 @@ static int hid_sensor_custom_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
-				 &enable_sensor_attr_group);
+	ret = hid_sensor_custom_add_attributes(sensor_inst);
 	if (ret)
 		goto err_remove_callback;
 
-	ret = hid_sensor_custom_add_attributes(sensor_inst);
+	ret = sysfs_create_group(&sensor_inst->pdev->dev.kobj,
+				 &enable_sensor_attr_group);
 	if (ret)
-		goto err_remove_group;
+		goto err_remove_attributes;
 
 	ret = hid_sensor_custom_dev_if_add(sensor_inst);
 	if (ret)
-		goto err_remove_attributes;
+		goto err_remove_group;
 
 	return 0;
 
-err_remove_attributes:
-	hid_sensor_custom_remove_attributes(sensor_inst);
 err_remove_group:
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
 			   &enable_sensor_attr_group);
+err_remove_attributes:
+	hid_sensor_custom_remove_attributes(sensor_inst);
 err_remove_callback:
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 
@@ -1042,9 +1042,10 @@ static void hid_sensor_custom_remove(struct platform_device *pdev)
 	}
 
 	hid_sensor_custom_dev_if_remove(sensor_inst);
-	hid_sensor_custom_remove_attributes(sensor_inst);
+	/* Remove enable_sensor first as it uses fields via power_state/report_state. */
 	sysfs_remove_group(&sensor_inst->pdev->dev.kobj,
 			   &enable_sensor_attr_group);
+	hid_sensor_custom_remove_attributes(sensor_inst);
 	sensor_hub_remove_callback(hsdev, hsdev->usage);
 }
 
diff --git a/drivers/hid/hid-uclogic-core.c b/drivers/hid/hid-uclogic-core.c
index b73f09d26688..0b8a83fa6c5b 100644
--- a/drivers/hid/hid-uclogic-core.c
+++ b/drivers/hid/hid-uclogic-core.c
@@ -548,7 +548,17 @@ static void uclogic_remove(struct hid_device *hdev)
 {
 	struct uclogic_drvdata *drvdata = hid_get_drvdata(hdev);
 
-	timer_delete_sync(&drvdata->inrange_timer);
+	/*
+	 * Shut the in-range timer down before stopping the device.
+	 * uclogic_raw_event_pen() re-arms inrange_timer on every pen report
+	 * and keeps running until hid_hw_stop() stops the transport, so a
+	 * plain timer_delete_sync() here can be undone by a report landing in
+	 * the window before hid_hw_stop().  timer_shutdown_sync() cancels the
+	 * timer and makes any later re-arm a no-op, so it is provably dead
+	 * before hid_hw_stop() frees the input device drvdata->pen_input
+	 * points at.
+	 */
+	timer_shutdown_sync(&drvdata->inrange_timer);
 	hid_hw_stop(hdev);
 	kfree(drvdata->desc_ptr);
 	uclogic_params_cleanup(&drvdata->params);
diff --git a/drivers/hid/usbhid/hid-pidff.c b/drivers/hid/usbhid/hid-pidff.c
index 5f4395f7c645..22951b7ecd17 100644
--- a/drivers/hid/usbhid/hid-pidff.c
+++ b/drivers/hid/usbhid/hid-pidff.c
@@ -1539,13 +1539,20 @@ static int pidff_check_autocenter(struct pidff_device *pidff,
 int hid_pidff_init_with_quirks(struct hid_device *hid, u32 initial_quirks)
 {
 	struct pidff_device *pidff;
-	struct hid_input *hidinput =
-		list_entry(hid->inputs.next, struct hid_input, list);
-	struct input_dev *dev = hidinput->input;
+	struct hid_input *hidinput;
+	struct input_dev *dev;
 	struct ff_device *ff;
 	int max_effects;
 	int error;
 
+	if (list_empty(&hid->inputs)) {
+		hid_err(hid, "no inputs found\n");
+		return -ENODEV;
+	}
+
+	hidinput = list_first_entry(&hid->inputs, struct hid_input, list);
+	dev = hidinput->input;
+
 	hid_dbg(hid, "starting pid init\n");
 
 	if (list_empty(&hid->report_enum[HID_OUTPUT_REPORT].report_list)) {
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
index e8d7dbe495f0..d46cb3b1cfc4 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
@@ -5591,6 +5591,8 @@ static void arm_smmu_device_shutdown(struct platform_device *pdev)
 {
 	struct arm_smmu_device *smmu = platform_get_drvdata(pdev);
 
+	if (smmu->impl_ops && smmu->impl_ops->device_disable)
+		smmu->impl_ops->device_disable(smmu);
 	arm_smmu_device_disable(smmu);
 }
 
diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
index ef42df4753ec..690055aa63c7 100644
--- a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
+++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h
@@ -804,6 +804,7 @@ struct arm_smmu_strtab_cfg {
 
 struct arm_smmu_impl_ops {
 	int (*device_reset)(struct arm_smmu_device *smmu);
+	void (*device_disable)(struct arm_smmu_device *smmu);
 	void (*device_remove)(struct arm_smmu_device *smmu);
 	int (*init_structures)(struct arm_smmu_device *smmu);
 	struct arm_smmu_cmdq *(*get_secondary_cmdq)(
diff --git a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
index 83f6e9f6c51d..c7af7658a4ea 100644
--- a/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
+++ b/drivers/iommu/arm/arm-smmu-v3/tegra241-cmdqv.c
@@ -761,8 +761,6 @@ static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
 	struct tegra241_vintf *vintf = cmdqv->vintfs[idx];
 	u16 lidx;
 
-	tegra241_vintf_hw_deinit(vintf);
-
 	/* Remove LVCMDQ resources */
 	for (lidx = 0; lidx < vintf->cmdqv->num_lvcmdqs_per_vintf; lidx++)
 		if (vintf->lvcmdqs[lidx])
@@ -779,6 +777,17 @@ static void tegra241_cmdqv_remove_vintf(struct tegra241_cmdqv *cmdqv, u16 idx)
 	}
 }
 
+static void tegra241_cmdqv_hw_disable(struct arm_smmu_device *smmu)
+{
+	struct tegra241_cmdqv *cmdqv =
+		container_of(smmu, struct tegra241_cmdqv, smmu);
+	u16 idx;
+
+	for (idx = 0; idx < cmdqv->num_vintfs; idx++)
+		if (cmdqv->vintfs[idx])
+			tegra241_vintf_hw_deinit(cmdqv->vintfs[idx]);
+}
+
 static void tegra241_cmdqv_remove(struct arm_smmu_device *smmu)
 {
 	struct tegra241_cmdqv *cmdqv =
@@ -844,6 +853,7 @@ static struct arm_smmu_impl_ops tegra241_cmdqv_impl_ops = {
 	/* For in-kernel use */
 	.get_secondary_cmdq = tegra241_cmdqv_get_cmdq,
 	.device_reset = tegra241_cmdqv_hw_reset,
+	.device_disable = tegra241_cmdqv_hw_disable,
 	.device_remove = tegra241_cmdqv_remove,
 	/* For user-space use */
 	.hw_info = tegra241_cmdqv_hw_info,
@@ -1152,6 +1162,7 @@ static void tegra241_cmdqv_destroy_vintf_user(struct iommufd_viommu *viommu)
 	if (vintf->mmap_offset)
 		iommufd_viommu_destroy_mmap(&vintf->vsmmu.core,
 					    vintf->mmap_offset);
+	tegra241_vintf_hw_deinit(vintf);
 	tegra241_cmdqv_remove_vintf(vintf->cmdqv, vintf->idx);
 }
 
diff --git a/drivers/iommu/iommufd/ioas.c b/drivers/iommu/iommufd/ioas.c
index fed06c2b728e..71bffece84b5 100644
--- a/drivers/iommu/iommufd/ioas.c
+++ b/drivers/iommu/iommufd/ioas.c
@@ -535,6 +535,10 @@ int iommufd_ioas_change_process(struct iommufd_ucmd *ucmd)
 		return rc;
 
 	for_each_ioas_area(&ioas_list, index, ioas, area)  {
+		if (!area->pages) {
+			rc = -EBUSY;
+			goto out;
+		}
 		if (area->pages->type != IOPT_ADDRESS_FILE) {
 			rc = -EINVAL;
 			goto out;
diff --git a/drivers/mailbox/mailbox-mchp-ipc-sbi.c b/drivers/mailbox/mailbox-mchp-ipc-sbi.c
index b87bf2fb4b9b..f081f8a9bcf8 100644
--- a/drivers/mailbox/mailbox-mchp-ipc-sbi.c
+++ b/drivers/mailbox/mailbox-mchp-ipc-sbi.c
@@ -378,6 +378,8 @@ static int mchp_ipc_get_cluster_aggr_irq(struct mchp_ipc_sbi_mbox *ipc)
 	for_each_online_cpu(cpuid) {
 		hartid = cpuid_to_hartid_map(cpuid);
 		irq_name = devm_kasprintf(ipc->dev, GFP_KERNEL, "hart-%lu", hartid);
+		if (!irq_name)
+			return -ENOMEM;
 		ret = platform_get_irq_byname_optional(pdev, irq_name);
 		if (ret <= 0)
 			continue;
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_lif.c b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
index 637e635bbf03..4fcf3fd6a91a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_lif.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_lif.c
@@ -918,8 +918,21 @@ static int ionic_lif_rxq_init(struct ionic_lif *lif, struct ionic_qcq *qcq)
 	};
 	int err;
 
-	q->partner = &lif->txqcqs[q->index]->q;
-	q->partner->partner = q;
+	q->partner = NULL;
+
+	/* Only normal RX queues have matching TX queue partners. */
+	if (q->index < lif->nxqs) {
+		if (!lif->txqcqs ||
+		    q->index >= lif->ionic->ntxqs_per_lif ||
+		    !lif->txqcqs[q->index]) {
+			dev_err(dev, "missing TX queue partner for RX queue %u\n",
+				q->index);
+			return -ENXIO;
+		}
+
+		q->partner = &lif->txqcqs[q->index]->q;
+		q->partner->partner = q;
+	}
 
 	if (!lif->xdp_prog ||
 	    (lif->xdp_prog->aux && lif->xdp_prog->aux->xdp_has_frags))
diff --git a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
index 301ebee2fdc5..73998d61593a 100644
--- a/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
+++ b/drivers/net/ethernet/pensando/ionic/ionic_txrx.c
@@ -545,13 +545,18 @@ static bool ionic_run_xdp(struct ionic_rx_stats *stats,
 		break;
 
 	case XDP_TX:
+		txq = rxq->partner;
+		if (unlikely(!txq)) {
+			err = -EIO;
+			break;
+		}
+
 		xdpf = xdp_convert_buff_to_frame(&xdp_buf);
 		if (!xdpf) {
 			err = -ENOSPC;
 			break;
 		}
 
-		txq = rxq->partner;
 		nq = netdev_get_tx_queue(netdev, txq->index);
 		__netif_tx_lock(nq, smp_processor_id());
 		txq_trans_cond_update(nq);
diff --git a/drivers/net/usb/rndis_host.c b/drivers/net/usb/rndis_host.c
index 7b3739b29c8f..1d7e9a1a3cf1 100644
--- a/drivers/net/usb/rndis_host.c
+++ b/drivers/net/usb/rndis_host.c
@@ -14,6 +14,7 @@
 #include <linux/usb/cdc.h>
 #include <linux/usb/usbnet.h>
 #include <linux/usb/rndis_host.h>
+#include <linux/overflow.h>
 
 
 /*
@@ -506,6 +507,7 @@ int rndis_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 		struct rndis_data_hdr	*hdr = (void *)skb->data;
 		struct sk_buff		*skb2;
 		u32			msg_type, msg_len, data_offset, data_len;
+		u32			overflow_check;
 
 		msg_type = le32_to_cpu(hdr->msg_type);
 		msg_len = le32_to_cpu(hdr->msg_len);
@@ -514,7 +516,9 @@ int rndis_rx_fixup(struct usbnet *dev, struct sk_buff *skb)
 
 		/* don't choke if we see oob, per-packet data, etc */
 		if (unlikely(msg_type != RNDIS_MSG_PACKET || skb->len < msg_len
-				|| (data_offset + data_len + 8) > msg_len)) {
+				|| (data_offset + data_len + 8) > msg_len
+				|| check_add_overflow(data_offset, data_len, &overflow_check)
+				|| check_add_overflow(overflow_check, 8, &overflow_check))) {
 			dev->net->stats.rx_frame_errors++;
 			netdev_dbg(dev->net, "bad rndis message %d/%d/%d/%d, len %d\n",
 				   le32_to_cpu(hdr->msg_type),
diff --git a/drivers/nfc/fdp/i2c.c b/drivers/nfc/fdp/i2c.c
index c1896a1d978c..f292e7f37456 100644
--- a/drivers/nfc/fdp/i2c.c
+++ b/drivers/nfc/fdp/i2c.c
@@ -166,9 +166,36 @@ static int fdp_nci_i2c_read(struct fdp_i2c_phy *phy, struct sk_buff **skb)
 		/* Packet that contains a length */
 		if (tmp[0] == 0 && tmp[1] == 0) {
 			phy->next_read_size = (tmp[2] << 8) + tmp[3] + 3;
+
+			/*
+			 * next_read_size is taken from the device and is used
+			 * as the i2c_master_recv() count for the next packet
+			 * and as the data skb size. A value above the receive
+			 * buffer overflows tmp[]; one below the minimum frame
+			 * size runs the header/LRC strip and the length-field
+			 * read past a short receive. Either way the packet is
+			 * corrupt: drop it and force resynchronization.
+			 */
+			if (phy->next_read_size < FDP_NCI_I2C_MIN_PAYLOAD ||
+			    phy->next_read_size > FDP_NCI_I2C_MAX_PAYLOAD) {
+				dev_dbg(&client->dev, "%s: corrupted packet\n",
+					__func__);
+				phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
+				goto flush;
+			}
 		} else {
 			phy->next_read_size = FDP_NCI_I2C_MIN_PAYLOAD;
 
+			/*
+			 * Only one data packet is delivered per call; if the
+			 * device sends another, do not overwrite and leak the
+			 * skb allocated for the previous one.
+			 */
+			if (*skb) {
+				kfree_skb(*skb);
+				*skb = NULL;
+			}
+
 			*skb = alloc_skb(len, GFP_KERNEL);
 			if (*skb == NULL) {
 				r = -ENOMEM;
diff --git a/drivers/nfc/microread/microread.c b/drivers/nfc/microread/microread.c
index 4149c5d735bd..dfa2490db545 100644
--- a/drivers/nfc/microread/microread.c
+++ b/drivers/nfc/microread/microread.c
@@ -483,13 +483,19 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 
 	switch (gate) {
 	case MICROREAD_GATE_ID_MREAD_ISO_A:
+		if (skb->len <= MICROREAD_EMCF_A_LEN) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols =
 		      nfc_hci_sak_to_protocol(skb->data[MICROREAD_EMCF_A_SAK]);
 		targets->sens_res =
 			 be16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_A_ATQA]);
 		targets->sel_res = skb->data[MICROREAD_EMCF_A_SAK];
 		targets->nfcid1_len = skb->data[MICROREAD_EMCF_A_LEN];
-		if (targets->nfcid1_len > sizeof(targets->nfcid1)) {
+		if (targets->nfcid1_len > sizeof(targets->nfcid1) ||
+		    targets->nfcid1_len > skb->len - MICROREAD_EMCF_A_UID) {
 			r = -EINVAL;
 			goto exit_free;
 		}
@@ -497,13 +503,19 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		       targets->nfcid1_len);
 		break;
 	case MICROREAD_GATE_ID_MREAD_ISO_A_3:
+		if (skb->len <= MICROREAD_EMCF_A3_LEN) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols =
 		      nfc_hci_sak_to_protocol(skb->data[MICROREAD_EMCF_A3_SAK]);
 		targets->sens_res =
 			 be16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_A3_ATQA]);
 		targets->sel_res = skb->data[MICROREAD_EMCF_A3_SAK];
 		targets->nfcid1_len = skb->data[MICROREAD_EMCF_A3_LEN];
-		if (targets->nfcid1_len > sizeof(targets->nfcid1)) {
+		if (targets->nfcid1_len > sizeof(targets->nfcid1) ||
+		    targets->nfcid1_len > skb->len - MICROREAD_EMCF_A3_UID) {
 			r = -EINVAL;
 			goto exit_free;
 		}
@@ -511,11 +523,21 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		       targets->nfcid1_len);
 		break;
 	case MICROREAD_GATE_ID_MREAD_ISO_B:
+		if (skb->len < MICROREAD_EMCF_B_UID + 4) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_ISO14443_B_MASK;
 		memcpy(targets->nfcid1, &skb->data[MICROREAD_EMCF_B_UID], 4);
 		targets->nfcid1_len = 4;
 		break;
 	case MICROREAD_GATE_ID_MREAD_NFC_T1:
+		if (skb->len < MICROREAD_EMCF_T1_UID + 4) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_JEWEL_MASK;
 		targets->sens_res =
 			le16_to_cpu(*(u16 *)&skb->data[MICROREAD_EMCF_T1_ATQA]);
@@ -523,6 +545,11 @@ static void microread_target_discovered(struct nfc_hci_dev *hdev, u8 gate,
 		targets->nfcid1_len = 4;
 		break;
 	case MICROREAD_GATE_ID_MREAD_NFC_T3:
+		if (skb->len < MICROREAD_EMCF_T3_UID + 8) {
+			r = -EINVAL;
+			goto exit_free;
+		}
+
 		targets->supported_protocols = NFC_PROTO_FELICA_MASK;
 		memcpy(targets->nfcid1, &skb->data[MICROREAD_EMCF_T3_UID], 8);
 		targets->nfcid1_len = 8;
diff --git a/drivers/nfc/pn533/pn533.c b/drivers/nfc/pn533/pn533.c
index d7bdbc82e2ba..6db9ec90f594 100644
--- a/drivers/nfc/pn533/pn533.c
+++ b/drivers/nfc/pn533/pn533.c
@@ -2799,6 +2799,7 @@ void pn53x_common_clean(struct pn533 *priv)
 	destroy_workqueue(priv->wq);
 
 	skb_queue_purge(&priv->resp_q);
+	skb_queue_purge(&priv->fragment_skb);
 
 	list_for_each_entry_safe(cmd, n, &priv->cmd_queue, queue) {
 		list_del(&cmd->queue);
diff --git a/drivers/nfc/st21nfca/dep.c b/drivers/nfc/st21nfca/dep.c
index 3425b68f0ddc..a5fab4fd5129 100644
--- a/drivers/nfc/st21nfca/dep.c
+++ b/drivers/nfc/st21nfca/dep.c
@@ -205,6 +205,9 @@ static int st21nfca_tm_recv_atr_req(struct nfc_hci_dev *hdev,
 	if (atr_req->length < sizeof(struct st21nfca_atr_req))
 		return -EPROTO;
 
+	if (atr_req->length > skb->len)
+		return -EPROTO;
+
 	r = st21nfca_tm_send_atr_res(hdev, atr_req);
 	if (r)
 		return r;
diff --git a/drivers/nvme/target/admin-cmd.c b/drivers/nvme/target/admin-cmd.c
index 01b799e92ae6..ab6a0a98dd5d 100644
--- a/drivers/nvme/target/admin-cmd.c
+++ b/drivers/nvme/target/admin-cmd.c
@@ -958,7 +958,7 @@ static void nvmet_execute_identify_nslist(struct nvmet_req *req, bool match_css)
 	nvmet_for_each_enabled_ns(&ctrl->subsys->namespaces, idx, ns) {
 		if (ns->nsid <= min_nsid)
 			continue;
-		if (match_css && req->ns->csi != req->cmd->identify.csi)
+		if (match_css && ns->csi != req->cmd->identify.csi)
 			continue;
 		list[i++] = cpu_to_le32(ns->nsid);
 		if (i == buf_size / sizeof(__le32))
diff --git a/drivers/nvme/target/fabrics-cmd-auth.c b/drivers/nvme/target/fabrics-cmd-auth.c
index 45820a12750d..2b617d3b8bba 100644
--- a/drivers/nvme/target/fabrics-cmd-auth.c
+++ b/drivers/nvme/target/fabrics-cmd-auth.c
@@ -557,7 +557,7 @@ void nvmet_execute_auth_receive(struct nvmet_req *req)
 		return;
 	}
 
-	d = kmalloc(al, GFP_KERNEL);
+	d = kzalloc(al, GFP_KERNEL);
 	if (!d) {
 		status = NVME_SC_INTERNAL;
 		goto done;
diff --git a/drivers/nvme/target/fc.c b/drivers/nvme/target/fc.c
index d161707559ce..1b557775e033 100644
--- a/drivers/nvme/target/fc.c
+++ b/drivers/nvme/target/fc.c
@@ -566,7 +566,7 @@ nvmet_fc_alloc_ls_iodlist(struct nvmet_fc_tgtport *tgtport)
 		list_del(&iod->ls_rcv_list);
 	}
 
-	kfree(iod);
+	kfree(tgtport->iod);
 
 	return -EFAULT;
 }
diff --git a/drivers/nvme/target/pci-epf.c b/drivers/nvme/target/pci-epf.c
index 4e9db96ebfec..346a4badd6b2 100644
--- a/drivers/nvme/target/pci-epf.c
+++ b/drivers/nvme/target/pci-epf.c
@@ -1339,6 +1339,7 @@ static u16 nvmet_pci_epf_create_cq(struct nvmet_ctrl *tctrl,
 	nvmet_pci_epf_mem_unmap(ctrl->nvme_epf, &cq->pci_map);
 err_internal:
 	status = NVME_SC_INTERNAL | NVME_STATUS_DNR;
+	nvmet_cq_put(&cq->nvme_cq);
 err:
 	if (test_and_clear_bit(NVMET_PCI_EPF_Q_IRQ_ENABLED, &cq->flags))
 		nvmet_pci_epf_remove_irq_vector(ctrl, cq->vector);
@@ -1594,6 +1595,7 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 	struct nvmet_pci_epf_iod *iod =
 		container_of(work, struct nvmet_pci_epf_iod, work);
 	struct nvmet_req *req = &iod->req;
+	bool no_wait;
 	int ret;
 
 	if (!iod->ctrl->link_up) {
@@ -1638,14 +1640,16 @@ static void nvmet_pci_epf_exec_iod_work(struct work_struct *work)
 		}
 	}
 
-	req->execute(req);
-
 	/*
 	 * If we do not have data to transfer after the command execution
 	 * finishes, nvmet_pci_epf_queue_response() will complete the command
 	 * directly. No need to wait for the completion in this case.
 	 */
-	if (!iod->data_len || iod->dma_dir != DMA_TO_DEVICE)
+	no_wait = !iod->data_len || iod->dma_dir != DMA_TO_DEVICE;
+
+	req->execute(req);
+
+	if (no_wait)
 		return;
 
 	wait_for_completion(&iod->done);
diff --git a/drivers/nvme/target/tcp.c b/drivers/nvme/target/tcp.c
index 15c52f1f95f1..8f399e974773 100644
--- a/drivers/nvme/target/tcp.c
+++ b/drivers/nvme/target/tcp.c
@@ -422,6 +422,19 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	if (!len)
 		return 0;
 
+	/*
+	 * inline_data_size only bounds the in-capsule (type 0x01) SGL
+	 * descriptor below. A non-inline transport SGL data-block
+	 * descriptor skips that check entirely and would otherwise reach
+	 * sgl_alloc() with an attacker-controlled len of up to 4 GiB,
+	 * pinning that much kernel memory for a command that may never
+	 * complete. Bound every descriptor type here, before allocating
+	 * anything, using the same ceiling this file already applies to
+	 * per-PDU H2C data.
+	 */
+	if (len > NVMET_TCP_MAXH2CDATA)
+		return NVME_SC_SGL_INVALID_DATA | NVME_STATUS_DNR;
+
 	if (sgl->type == ((NVME_SGL_FMT_DATA_DESC << 4) |
 			  NVME_SGL_FMT_OFFSET)) {
 		if (!nvme_is_write(cmd->req.cmd))
@@ -433,13 +446,15 @@ static int nvmet_tcp_map_data(struct nvmet_tcp_cmd *cmd)
 	}
 	cmd->req.transfer_len += len;
 
-	cmd->req.sg = sgl_alloc(len, GFP_KERNEL, &cmd->req.sg_cnt);
+	cmd->req.sg = sgl_alloc(len, GFP_KERNEL | __GFP_NOWARN,
+				&cmd->req.sg_cnt);
 	if (!cmd->req.sg)
 		return NVME_SC_INTERNAL;
 	cmd->cur_sg = cmd->req.sg;
 
 	if (nvmet_tcp_has_data_in(cmd)) {
-		cmd->iov = kmalloc_objs(*cmd->iov, cmd->req.sg_cnt);
+		cmd->iov = kmalloc_objs(*cmd->iov, cmd->req.sg_cnt,
+					GFP_KERNEL | __GFP_NOWARN);
 		if (!cmd->iov)
 			goto err;
 	}
diff --git a/drivers/pci/controller/pci-host-generic.c b/drivers/pci/controller/pci-host-generic.c
index c1bc0d34348f..9e85c6e9b425 100644
--- a/drivers/pci/controller/pci-host-generic.c
+++ b/drivers/pci/controller/pci-host-generic.c
@@ -16,15 +16,6 @@
 
 #include "pci-host-common.h"
 
-static const struct pci_ecam_ops gen_pci_cfg_cam_bus_ops = {
-	.bus_shift	= 16,
-	.pci_ops	= {
-		.map_bus	= pci_ecam_map_bus,
-		.read		= pci_generic_config_read,
-		.write		= pci_generic_config_write,
-	}
-};
-
 static bool pci_dw_valid_device(struct pci_bus *bus, unsigned int devfn)
 {
 	struct pci_config_window *cfg = bus->sysdata;
@@ -60,7 +51,7 @@ static const struct pci_ecam_ops pci_dw_ecam_bus_ops = {
 
 static const struct of_device_id gen_pci_of_match[] = {
 	{ .compatible = "pci-host-cam-generic",
-	  .data = &gen_pci_cfg_cam_bus_ops },
+	  .data = &pci_generic_cam_ops },
 
 	{ .compatible = "pci-host-ecam-generic",
 	  .data = &pci_generic_ecam_ops },
diff --git a/drivers/pci/ecam.c b/drivers/pci/ecam.c
index 119de32ff07b..a9b3bce2492f 100644
--- a/drivers/pci/ecam.c
+++ b/drivers/pci/ecam.c
@@ -208,6 +208,19 @@ const struct pci_ecam_ops pci_generic_ecam_ops = {
 };
 EXPORT_SYMBOL_GPL(pci_generic_ecam_ops);
 
+/* CAM ops */
+const struct pci_ecam_ops pci_generic_cam_ops = {
+	.bus_shift	= 16,
+	.pci_ops	= {
+		.add_bus	= pci_ecam_add_bus,
+		.remove_bus	= pci_ecam_remove_bus,
+		.map_bus	= pci_ecam_map_bus,
+		.read		= pci_generic_config_read,
+		.write		= pci_generic_config_write,
+	}
+};
+EXPORT_SYMBOL_GPL(pci_generic_cam_ops);
+
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 /* ECAM ops for 32-bit access only (non-compliant) */
 const struct pci_ecam_ops pci_32b_ops = {
diff --git a/drivers/ptp/ptp_vmclock.c b/drivers/ptp/ptp_vmclock.c
index 8b630eb916b5..1051a2dde40d 100644
--- a/drivers/ptp/ptp_vmclock.c
+++ b/drivers/ptp/ptp_vmclock.c
@@ -377,6 +377,12 @@ static int vmclock_miscdev_mmap(struct file *fp, struct vm_area_struct *vma)
 	if ((vma->vm_flags & (VM_READ|VM_WRITE)) != VM_READ)
 		return -EROFS;
 
+	/*
+	 * Restrict the read-only mapping so it cannot be upgraded to
+	 * writable later with mprotect().
+	 */
+	vm_flags_clear(vma, VM_MAYWRITE);
+
 	if (vma->vm_end - vma->vm_start != PAGE_SIZE || vma->vm_pgoff)
 		return -EINVAL;
 
diff --git a/drivers/video/fbdev/core/fb_chrdev.c b/drivers/video/fbdev/core/fb_chrdev.c
index 4ebd16b7e3b8..54f926fb411b 100644
--- a/drivers/video/fbdev/core/fb_chrdev.c
+++ b/drivers/video/fbdev/core/fb_chrdev.c
@@ -85,11 +85,7 @@ static long do_fb_ioctl(struct fb_info *info, unsigned int cmd,
 		var.activate &= ~FB_ACTIVATE_KD_TEXT;
 		console_lock();
 		lock_fb_info(info);
-		ret = fbcon_modechange_possible(info, &var);
-		if (!ret)
-			ret = fb_set_var(info, &var);
-		if (!ret)
-			fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
+		ret = fb_set_var_from_user(info, &var);
 		unlock_fb_info(info);
 		console_unlock();
 		if (!ret && copy_to_user(argp, &var, sizeof(var)))
diff --git a/drivers/video/fbdev/core/fbcon.c b/drivers/video/fbdev/core/fbcon.c
index 666293f0864f..6691e0f8ff41 100644
--- a/drivers/video/fbdev/core/fbcon.c
+++ b/drivers/video/fbdev/core/fbcon.c
@@ -2706,7 +2706,6 @@ void fbcon_update_vcs(struct fb_info *info, bool all)
 	else
 		fbcon_modechanged(info);
 }
-EXPORT_SYMBOL(fbcon_update_vcs);
 
 /* let fbcon check if it supports a new screen resolution */
 int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *var)
@@ -2734,7 +2733,6 @@ int fbcon_modechange_possible(struct fb_info *info, struct fb_var_screeninfo *va
 
 	return 0;
 }
-EXPORT_SYMBOL_GPL(fbcon_modechange_possible);
 
 int fbcon_mode_deleted(struct fb_info *info,
 		       struct fb_videomode *mode)
diff --git a/drivers/video/fbdev/core/fbmem.c b/drivers/video/fbdev/core/fbmem.c
index 0ea182314b89..a3af47e103b0 100644
--- a/drivers/video/fbdev/core/fbmem.c
+++ b/drivers/video/fbdev/core/fbmem.c
@@ -349,6 +349,19 @@ fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var)
 }
 EXPORT_SYMBOL(fb_set_var);
 
+int fb_set_var_from_user(struct fb_info *info, struct fb_var_screeninfo *var)
+{
+	int ret = fbcon_modechange_possible(info, var);
+
+	if (!ret)
+		ret = fb_set_var(info, var);
+	if (!ret)
+		fbcon_update_vcs(info, var->activate & FB_ACTIVATE_ALL);
+
+	return ret;
+}
+EXPORT_SYMBOL(fb_set_var_from_user);
+
 static void fb_lcd_notify_blank(struct fb_info *info)
 {
 	int power;
diff --git a/drivers/video/fbdev/core/fbsysfs.c b/drivers/video/fbdev/core/fbsysfs.c
index fa12e5da9bbd..c32dd71a38e1 100644
--- a/drivers/video/fbdev/core/fbsysfs.c
+++ b/drivers/video/fbdev/core/fbsysfs.c
@@ -13,21 +13,24 @@
 #include "fb_internal.h"
 #include "fbcon.h"
 
+static int activate_locked(struct fb_info *fb_info,
+			    struct fb_var_screeninfo *var)
+{
+	var->activate |= FB_ACTIVATE_FORCE;
+	return fb_set_var_from_user(fb_info, var);
+}
+
 static int activate(struct fb_info *fb_info, struct fb_var_screeninfo *var)
 {
 	int err;
 
-	var->activate |= FB_ACTIVATE_FORCE;
 	console_lock();
 	lock_fb_info(fb_info);
-	err = fb_set_var(fb_info, var);
-	if (!err)
-		fbcon_update_vcs(fb_info, var->activate & FB_ACTIVATE_ALL);
+	err = activate_locked(fb_info, var);
 	unlock_fb_info(fb_info);
 	console_unlock();
-	if (err)
-		return err;
-	return 0;
+
+	return err;
 }
 
 static int mode_string(char *buf, size_t size, unsigned int offset,
@@ -68,6 +71,9 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 
 	memset(&var, 0, sizeof(var));
 
+	console_lock();
+	lock_fb_info(fb_info);
+
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i = mode_string(mstr, sizeof(mstr), 0, mode);
@@ -75,12 +81,22 @@ static ssize_t store_mode(struct device *device, struct device_attribute *attr,
 
 			var = fb_info->var;
 			fb_videomode_to_var(&var, mode);
-			if ((err = activate(fb_info, &var)))
+			err = activate_locked(fb_info, &var);
+			if (err) {
+				unlock_fb_info(fb_info);
+				console_unlock();
 				return err;
+			}
 			fb_info->mode = mode;
+			unlock_fb_info(fb_info);
+			console_unlock();
 			return count;
 		}
 	}
+
+	unlock_fb_info(fb_info);
+	console_unlock();
+
 	return -EINVAL;
 }
 
@@ -88,11 +104,20 @@ static ssize_t show_mode(struct device *device, struct device_attribute *attr,
 			 char *buf)
 {
 	struct fb_info *fb_info = dev_get_drvdata(device);
+	struct fb_videomode mode;
+	bool have_mode = false;
 
-	if (!fb_info->mode)
+	lock_fb_info(fb_info);
+	if (fb_info->mode) {
+		mode = *fb_info->mode;
+		have_mode = true;
+	}
+	unlock_fb_info(fb_info);
+
+	if (!have_mode)
 		return 0;
 
-	return mode_string(buf, PAGE_SIZE, 0, fb_info->mode);
+	return mode_string(buf, PAGE_SIZE, 0, &mode);
 }
 
 static ssize_t store_modes(struct device *device,
@@ -140,12 +165,15 @@ static ssize_t show_modes(struct device *device, struct device_attribute *attr,
 	const struct fb_videomode *mode;
 
 	i = 0;
+	lock_fb_info(fb_info);
 	list_for_each_entry(modelist, &fb_info->modelist, list) {
 		mode = &modelist->mode;
 		i += mode_string(buf, PAGE_SIZE, i, mode);
 		if (i >= PAGE_SIZE - 1)
 			break;
 	}
+	unlock_fb_info(fb_info);
+
 	return i;
 }
 
diff --git a/drivers/video/fbdev/ps3fb.c b/drivers/video/fbdev/ps3fb.c
index dbcda307f6a6..1376d19b19ae 100644
--- a/drivers/video/fbdev/ps3fb.c
+++ b/drivers/video/fbdev/ps3fb.c
@@ -29,7 +29,6 @@
 #include <linux/freezer.h>
 #include <linux/uaccess.h>
 #include <linux/fb.h>
-#include <linux/fbcon.h>
 #include <linux/init.h>
 
 #include <asm/cell-regs.h>
@@ -830,9 +829,7 @@ static int ps3fb_ioctl(struct fb_info *info, unsigned int cmd,
 				/* Force, in case only special bits changed */
 				var.activate |= FB_ACTIVATE_FORCE;
 				par->new_mode_id = val;
-				retval = fb_set_var(info, &var);
-				if (!retval)
-					fbcon_update_vcs(info, var.activate & FB_ACTIVATE_ALL);
+				retval = fb_set_var_from_user(info, &var);
 				console_unlock();
 			}
 			break;
diff --git a/drivers/video/fbdev/sh_mobile_lcdcfb.c b/drivers/video/fbdev/sh_mobile_lcdcfb.c
index 72969fe8e513..e8324b01700f 100644
--- a/drivers/video/fbdev/sh_mobile_lcdcfb.c
+++ b/drivers/video/fbdev/sh_mobile_lcdcfb.c
@@ -15,7 +15,6 @@
 #include <linux/ctype.h>
 #include <linux/dma-mapping.h>
 #include <linux/delay.h>
-#include <linux/fbcon.h>
 #include <linux/init.h>
 #include <linux/interrupt.h>
 #include <linux/ioctl.h>
@@ -1768,11 +1767,9 @@ static void sh_mobile_fb_reconfig(struct fb_info *info)
 	var.height = ch->display.height;
 	var.activate = FB_ACTIVATE_NOW;
 
-	if (fb_set_var(info, &var) < 0)
+	if (fb_set_var_from_user(info, &var) < 0)
 		/* Couldn't reconfigure, hopefully, can continue as before */
 		return;
-
-	fbcon_update_vcs(info, true);
 }
 
 /*
diff --git a/fs/exec.c b/fs/exec.c
index 4e156bb78321..2eacc1441c59 100644
--- a/fs/exec.c
+++ b/fs/exec.c
@@ -30,6 +30,7 @@
 #include <linux/mm.h>
 #include <linux/stat.h>
 #include <linux/fcntl.h>
+#include <linux/futex.h>
 #include <linux/swap.h>
 #include <linux/string.h>
 #include <linux/init.h>
@@ -843,6 +844,7 @@ static int exec_mmap(struct mm_struct *mm)
 	/* Notify parent that we're no longer interested in the old VM */
 	tsk = current;
 	old_mm = current->mm;
+	/* Clean up futexes and release the mm */
 	exec_mm_release(tsk, old_mm);
 
 	ret = down_write_killable(&tsk->signal->exec_update_lock);
@@ -891,9 +893,11 @@ static int exec_mmap(struct mm_struct *mm)
 		setmax_mm_hiwater_rss(&tsk->signal->maxrss, old_mm);
 		mm_update_next_owner(old_mm);
 		mmput(old_mm);
-		return 0;
+	} else {
+		mmdrop_lazy_tlb(active_mm);
 	}
-	mmdrop_lazy_tlb(active_mm);
+
+	futex_exec_done(tsk);
 	return 0;
 }
 
diff --git a/fs/ext4/crypto.c b/fs/ext4/crypto.c
index f41f320f4437..3971986de028 100644
--- a/fs/ext4/crypto.c
+++ b/fs/ext4/crypto.c
@@ -144,7 +144,13 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 	if (inode->i_ino == EXT4_ROOT_INO)
 		return -EPERM;
 
-	if (WARN_ON_ONCE(IS_DAX(inode) && i_size_read(inode)))
+	/*
+	 * For new encrypted inodes, S_DAX is never set in the first place.
+	 *
+	 * For existing inodes, this is called only on empty directories.  ext4
+	 * never sets S_DAX on directories.
+	 */
+	if (WARN_ON_ONCE(IS_DAX(inode)))
 		return -EINVAL;
 
 	if (ext4_test_inode_flag(inode, EXT4_INODE_DAX))
@@ -163,6 +169,14 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 	 */
 
 	if (handle) {
+		/*
+		 * __ext4_new_inode() should have already set the encrypt flag
+		 * on the inode and avoided enabling inline data.
+		 */
+		if (WARN_ON_ONCE(!IS_ENCRYPTED(inode)))
+			return -EINVAL;
+		if (WARN_ON_ONCE(ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)))
+			return -EINVAL;
 		/*
 		 * Since the inode is new it is ok to pass the
 		 * XATTR_CREATE flag. This is necessary to match the
@@ -170,21 +184,10 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 		 * function with the credits allocated for the new
 		 * inode.
 		 */
-		res = ext4_xattr_set_handle(handle, inode,
-					    EXT4_XATTR_INDEX_ENCRYPTION,
-					    EXT4_XATTR_NAME_ENCRYPTION_CONTEXT,
-					    ctx, len, XATTR_CREATE);
-		if (!res) {
-			ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
-			ext4_clear_inode_state(inode,
-					EXT4_STATE_MAY_INLINE_DATA);
-			/*
-			 * Update inode->i_flags - S_ENCRYPTED will be enabled,
-			 * S_DAX may be disabled
-			 */
-			ext4_set_inode_flags(inode, false);
-		}
-		return res;
+		return ext4_xattr_set_handle(handle, inode,
+					     EXT4_XATTR_INDEX_ENCRYPTION,
+					     EXT4_XATTR_NAME_ENCRYPTION_CONTEXT,
+					     ctx, len, XATTR_CREATE);
 	}
 
 	res = dquot_initialize(inode);
@@ -205,10 +208,7 @@ static int ext4_set_context(struct inode *inode, const void *ctx, size_t len,
 				    ctx, len, 0);
 	if (!res) {
 		ext4_set_inode_flag(inode, EXT4_INODE_ENCRYPT);
-		/*
-		 * Update inode->i_flags - S_ENCRYPTED will be enabled,
-		 * S_DAX may be disabled
-		 */
+		/* Update inode->i_flags to set S_ENCRYPTED. */
 		ext4_set_inode_flags(inode, false);
 		res = ext4_mark_inode_dirty(handle, inode);
 		if (res)
diff --git a/fs/ext4/fast_commit.c b/fs/ext4/fast_commit.c
index 1775bce9649a..6a9f99f45173 100644
--- a/fs/ext4/fast_commit.c
+++ b/fs/ext4/fast_commit.c
@@ -1757,8 +1757,11 @@ static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
 		if (ret == 0) {
 			/* Range is not mapped */
 			path = ext4_find_extent(inode, cur, path, 0);
-			if (IS_ERR(path))
+			if (IS_ERR(path)) {
+				ret = PTR_ERR(path);
+				path = NULL;
 				goto out;
+			}
 			memset(&newex, 0, sizeof(newex));
 			newex.ee_block = cpu_to_le32(cur);
 			ext4_ext_store_pblock(
@@ -1770,8 +1773,11 @@ static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
 			path = ext4_ext_insert_extent(NULL, inode,
 						      path, &newex, 0);
 			up_write((&EXT4_I(inode)->i_data_sem));
-			if (IS_ERR(path))
+			if (IS_ERR(path)) {
+				ret = PTR_ERR(path);
+				path = NULL;
 				goto out;
+			}
 			goto next;
 		}
 
@@ -1818,10 +1824,11 @@ static int ext4_fc_replay_add_range(struct super_block *sb, u8 *val)
 	}
 	ext4_ext_replay_shrink_inode(inode, i_size_read(inode) >>
 					sb->s_blocksize_bits);
+	ret = 0;
 out:
 	ext4_free_ext_path(path);
 	iput(inode);
-	return 0;
+	return ret;
 }
 
 /* Replay DEL_RANGE tag */
@@ -1881,9 +1888,10 @@ ext4_fc_replay_del_range(struct super_block *sb, u8 *val)
 	ext4_ext_replay_shrink_inode(inode,
 		i_size_read(inode) >> sb->s_blocksize_bits);
 	ext4_mark_inode_dirty(NULL, inode);
+	ret = 0;
 out:
 	iput(inode);
-	return 0;
+	return ret;
 }
 
 static void ext4_fc_set_bitmaps_and_counters(struct super_block *sb)
diff --git a/fs/ext4/ialloc.c b/fs/ext4/ialloc.c
index 3fd8f0099852..b76f0040dc07 100644
--- a/fs/ext4/ialloc.c
+++ b/fs/ext4/ialloc.c
@@ -995,6 +995,8 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 		err = fscrypt_prepare_new_inode(dir, inode, &encrypt);
 		if (err)
 			goto out;
+		if (encrypt)
+			i_flags |= EXT4_ENCRYPT_FL;
 	}
 
 	err = dquot_initialize(inode);
@@ -1304,6 +1306,8 @@ struct inode *__ext4_new_inode(struct mnt_idmap *idmap,
 	ei->i_extra_isize = sbi->s_want_extra_isize;
 	ei->i_inline_off = 0;
 	if (ext4_has_feature_inline_data(sb) &&
+	    /* Encrypted inodes cannot have inline data */
+	    !(ei->i_flags & EXT4_ENCRYPT_FL) &&
 	    (!(ei->i_flags & (EXT4_DAX_FL|EXT4_EA_INODE_FL)) || S_ISDIR(mode)))
 		ext4_set_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 	ret = inode;
diff --git a/fs/ext4/inode.c b/fs/ext4/inode.c
index 4fce9ec176f8..29204da893b6 100644
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@ -1182,6 +1182,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 	int nr_wait = 0;
 	int i;
 	bool should_journal_data = ext4_should_journal_data(inode);
+	bool folio_uptodate = folio_test_uptodate(folio);
 
 	BUG_ON(!folio_test_locked(folio));
 	BUG_ON(to > folio_size(folio));
@@ -1193,13 +1194,13 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 		head = create_empty_buffers(folio, blocksize, 0);
 	block = EXT4_PG_TO_LBLK(inode, folio->index);
 
-	for (bh = head, block_start = 0; bh != head || !block_start;
+	for (bh = head, block_start = 0;
+	     block_start < to || (!folio_uptodate && bh != head);
 	    block++, block_start = block_end, bh = bh->b_this_page) {
 		block_end = block_start + blocksize;
 		if (block_end <= from || block_start >= to) {
-			if (folio_test_uptodate(folio)) {
+			if (folio_uptodate)
 				set_buffer_uptodate(bh);
-			}
 			continue;
 		}
 		if (WARN_ON_ONCE(buffer_new(bh)))
@@ -1220,7 +1221,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 				if (should_journal_data)
 					do_journal_get_write_access(handle,
 								    inode, bh);
-				if (folio_test_uptodate(folio)) {
+				if (folio_uptodate) {
 					/*
 					 * Unlike __block_write_begin() we leave
 					 * dirtying of new uptodate buffers to
@@ -1237,7 +1238,7 @@ int ext4_block_write_begin(handle_t *handle, struct folio *folio,
 				continue;
 			}
 		}
-		if (folio_test_uptodate(folio)) {
+		if (folio_uptodate) {
 			set_buffer_uptodate(bh);
 			continue;
 		}
diff --git a/fs/ext4/super.c b/fs/ext4/super.c
index 6a77db4d3124..05cf0f1f8bd4 100644
--- a/fs/ext4/super.c
+++ b/fs/ext4/super.c
@@ -5365,7 +5365,7 @@ static int __ext4_fill_super(struct fs_context *fc, struct super_block *sb)
 	ext4_set_def_opts(sb, es);
 
 	sbi->s_resuid = make_kuid(&init_user_ns, ext4_get_resuid(es));
-	sbi->s_resgid = make_kgid(&init_user_ns, ext4_get_resuid(es));
+	sbi->s_resgid = make_kgid(&init_user_ns, ext4_get_resgid(es));
 	sbi->s_commit_interval = JBD2_DEFAULT_MAX_COMMIT_AGE * HZ;
 	sbi->s_min_batch_time = EXT4_DEF_MIN_BATCH_TIME;
 	sbi->s_max_batch_time = EXT4_DEF_MAX_BATCH_TIME;
diff --git a/fs/ext4/xattr.c b/fs/ext4/xattr.c
index 982a1f831e22..77512e709543 100644
--- a/fs/ext4/xattr.c
+++ b/fs/ext4/xattr.c
@@ -2075,12 +2075,13 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 				 * stable so we can check the additional
 				 * reference fits.
 				 */
-				ref = le32_to_cpu(BHDR(new_bh)->h_refcount) + 1;
-				if (ref > EXT4_XATTR_REFCOUNT_MAX) {
+				ref = le32_to_cpu(BHDR(new_bh)->h_refcount);
+				if (ref >= EXT4_XATTR_REFCOUNT_MAX) {
 					/*
 					 * Undo everything and check mbcache
 					 * again.
 					 */
+					clear_bit(MBE_REUSABLE_B, &ce->e_flags);
 					unlock_buffer(new_bh);
 					dquot_free_block(inode,
 							 EXT4_C2B(EXT4_SB(sb),
@@ -2091,6 +2092,7 @@ ext4_xattr_block_set(handle_t *handle, struct inode *inode,
 					new_bh = NULL;
 					goto inserted;
 				}
+				ref++;
 				BHDR(new_bh)->h_refcount = cpu_to_le32(ref);
 				if (ref == EXT4_XATTR_REFCOUNT_MAX)
 					clear_bit(MBE_REUSABLE_B, &ce->e_flags);
@@ -2839,6 +2841,7 @@ int ext4_expand_extra_isize_ea(struct inode *inode, int new_extra_isize,
 		    s_min_extra_isize) {
 			tried_min_extra_isize++;
 			new_extra_isize = s_min_extra_isize;
+			error = 0;
 			goto retry;
 		}
 		goto cleanup;
diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index e0a606643e87..da0e27c5acc8 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -527,6 +527,7 @@ static int nilfs_ioctl_get_bdescs(struct inode *inode, struct file *filp,
  * Return: 0 on success, or one of the following negative error codes on
  * failure:
  * * %-EEXIST	- Block conflict detected.
+ * * %-EINVAL	- Invalid virtual block descriptor.
  * * %-EIO	- I/O error.
  * * %-ENOENT	- Requested block doesn't exist.
  * * %-ENOMEM	- Insufficient memory available.
@@ -536,15 +537,30 @@ static int nilfs_ioctl_move_inode_block(struct inode *inode,
 					struct list_head *buffers)
 {
 	struct buffer_head *bh;
+	__u64 limit_blkidx = (__u64)inode->i_sb->s_maxbytes >> inode->i_blkbits;
 	int ret;
 
-	if (vdesc->vd_flags == 0)
+	/*
+	 * vblocknr 0 is reserved as an invalid pointer.  Also, limit_blkidx
+	 * ensures that the page index converted from vd_vblocknr never
+	 * overflows the page cache limit and respects the architecture's bmap
+	 * key width.
+	 */
+	if (unlikely(vdesc->vd_vblocknr == 0 ||
+			vdesc->vd_vblocknr >= limit_blkidx))
+		return -EINVAL;
+
+	if (vdesc->vd_flags == 0) {
+		if (unlikely(vdesc->vd_offset >= limit_blkidx))
+			return -EINVAL;
+
 		ret = nilfs_gccache_submit_read_data(
 			inode, vdesc->vd_offset, vdesc->vd_blocknr,
 			vdesc->vd_vblocknr, &bh);
-	else
+	} else {
 		ret = nilfs_gccache_submit_read_node(
 			inode, vdesc->vd_blocknr, vdesc->vd_vblocknr, &bh);
+	}
 
 	if (unlikely(ret < 0)) {
 		if (ret == -ENOENT)
diff --git a/fs/ocfs2/xattr.c b/fs/ocfs2/xattr.c
index 86cfd4c2adf9..7eb8cce433de 100644
--- a/fs/ocfs2/xattr.c
+++ b/fs/ocfs2/xattr.c
@@ -740,12 +740,10 @@ static int ocfs2_xattr_extend_allocation(struct inode *inode,
 					 prev_clusters;
 
 		if (why != RESTART_NONE && clusters_to_add) {
-			/*
-			 * We can only fail in case the alloc file doesn't give
-			 * up enough clusters.
-			 */
-			BUG_ON(why == RESTART_META);
-
+			if (why == RESTART_META) {
+				status = -ENOSPC;
+				break;
+			}
 			credits = ocfs2_calc_extend_credits(inode->i_sb,
 							    &vb->vb_xv->xr_list);
 			status = ocfs2_extend_trans(handle, credits);
@@ -3241,6 +3239,14 @@ static int ocfs2_calc_xattr_set_need(struct inode *inode,
 		} else
 			credits += OCFS2_SUBALLOC_ALLOC + 1;
 
+		/*
+		 * Reserve metadata for the new xattr's value extent tree.
+		 * The not_found path above adds credits for this tree but
+		 * omits meta_add, leaving meta_ac NULL for large values.
+		 */
+		if (xi->xi_value_len > OCFS2_XATTR_INLINE_SIZE)
+			meta_add += ocfs2_extend_meta_needed(&def_xv.xv.xr_list);
+
 		/*
 		 * This cluster will be used either for new bucket or for
 		 * new xattr block.
diff --git a/fs/xfs/libxfs/xfs_attr_leaf.c b/fs/xfs/libxfs/xfs_attr_leaf.c
index 2b78041e8672..bb962b0f1fda 100644
--- a/fs/xfs/libxfs/xfs_attr_leaf.c
+++ b/fs/xfs/libxfs/xfs_attr_leaf.c
@@ -325,6 +325,13 @@ xfs_attr3_leaf_verify_entry(
 	 */
 	if (ent->flags & XFS_ATTR_LOCAL) {
 		lentry = xfs_attr3_leaf_name_local(leaf, idx);
+
+		/* Validate lentry pointer is within bounds before field access */
+		if ((char *)lentry >= buf_end)
+			return __this_address;
+		if ((char *)lentry + offsetof(struct xfs_attr_leaf_name_local, nameval) > buf_end)
+			return __this_address;
+
 		namesize = xfs_attr_leaf_entsize_local(lentry->namelen,
 				be16_to_cpu(lentry->valuelen));
 		name_end = (char *)lentry + namesize;
@@ -332,6 +339,13 @@ xfs_attr3_leaf_verify_entry(
 			return __this_address;
 	} else {
 		rentry = xfs_attr3_leaf_name_remote(leaf, idx);
+
+		/* Validate rentry pointer is within bounds before field access */
+		if ((char *)rentry >= buf_end)
+			return __this_address;
+		if ((char *)rentry + offsetof(struct xfs_attr_leaf_name_remote, name) > buf_end)
+			return __this_address;
+
 		namesize = xfs_attr_leaf_entsize_remote(rentry->namelen);
 		name_end = (char *)rentry + namesize;
 		if (rentry->namelen == 0)
diff --git a/fs/xfs/scrub/agheader.c b/fs/xfs/scrub/agheader.c
index 62ed5eaf08fb..1fa66aa68e16 100644
--- a/fs/xfs/scrub/agheader.c
+++ b/fs/xfs/scrub/agheader.c
@@ -18,6 +18,8 @@
 #include "xfs_inode.h"
 #include "scrub/scrub.h"
 #include "scrub/common.h"
+#include "scrub/bitmap.h"
+#include "scrub/agino_bitmap.h"
 
 int
 xchk_setup_agheader(
@@ -932,41 +934,85 @@ xchk_agi_xref(
 	/* scrub teardown will take care of sc->sa for us */
 }
 
+/*
+ * Walk the incore unlinked list for a particular AGI bucket to construct
+ * the unlinked inode bitmap for later reconstruction of the unlinked list.
+ * Returns 1 if we should keep checking, 0 to stop checking, or a negative
+ * errno.
+ */
+static int
+xchk_iunlink_bucket(
+	struct xfs_scrub		*sc,
+	unsigned int			bucket,
+	xfs_agino_t			agino)
+{
+	struct xagino_bitmap		seen;
+	int				ret;
+
+	xagino_bitmap_init(&seen);
+
+	while (agino != NULLAGINO) {
+		struct xfs_inode	*ip;
+		unsigned int		len = 1;
+
+		if (agino % XFS_AGI_UNLINKED_BUCKETS != bucket) {
+			xchk_block_set_corrupt(sc, sc->sa.agi_bp);
+			goto bad;
+		}
+
+		if (xagino_bitmap_test(&seen, agino, &len)) {
+			xchk_block_set_corrupt(sc, sc->sa.agi_bp);
+			goto bad;
+		}
+
+		ip = xfs_iunlink_lookup(sc->sa.pag, agino);
+		if (!ip) {
+			xchk_block_set_corrupt(sc, sc->sa.agi_bp);
+			goto bad;
+		}
+
+		if (!xfs_inode_on_unlinked_list(ip)) {
+			xchk_block_set_corrupt(sc, sc->sa.agi_bp);
+			goto bad;
+		}
+
+		ret = xagino_bitmap_set(&seen, agino, 1);
+		if (ret)
+			goto out_bitmap;
+
+		agino = ip->i_next_unlinked;
+	}
+	ret = 1;
+
+out_bitmap:
+	xagino_bitmap_destroy(&seen);
+	return ret;
+bad:
+	ret = 0;
+	goto out_bitmap;
+}
+
 /*
  * Check the unlinked buckets for links to bad inodes.  We hold the AGI, so
  * there cannot be any threads updating unlinked list pointers in this AG.
  */
-STATIC void
+STATIC int
 xchk_iunlink(
 	struct xfs_scrub	*sc,
 	struct xfs_agi		*agi)
 {
 	unsigned int		i;
-	struct xfs_inode	*ip;
 
 	for (i = 0; i < XFS_AGI_UNLINKED_BUCKETS; i++) {
-		xfs_agino_t	agino = be32_to_cpu(agi->agi_unlinked[i]);
-
-		while (agino != NULLAGINO) {
-			if (agino % XFS_AGI_UNLINKED_BUCKETS != i) {
-				xchk_block_set_corrupt(sc, sc->sa.agi_bp);
-				return;
-			}
-
-			ip = xfs_iunlink_lookup(sc->sa.pag, agino);
-			if (!ip) {
-				xchk_block_set_corrupt(sc, sc->sa.agi_bp);
-				return;
-			}
-
-			if (!xfs_inode_on_unlinked_list(ip)) {
-				xchk_block_set_corrupt(sc, sc->sa.agi_bp);
-				return;
-			}
-
-			agino = ip->i_next_unlinked;
-		}
+		int		ret;
+
+		ret = xchk_iunlink_bucket(sc, i,
+				be32_to_cpu(agi->agi_unlinked[i]));
+		if (ret < 1)
+			return ret;
 	}
+
+	return 0;
 }
 
 /* Scrub the AGI. */
@@ -1053,7 +1099,9 @@ xchk_agi(
 	if (pag->pagi_freecount != be32_to_cpu(agi->agi_freecount))
 		xchk_block_set_corrupt(sc, sc->sa.agi_bp);
 
-	xchk_iunlink(sc, agi);
+	error = xchk_iunlink(sc, agi);
+	if (error)
+		goto out;
 
 	xchk_agi_xref(sc);
 out:
diff --git a/fs/xfs/scrub/agheader_repair.c b/fs/xfs/scrub/agheader_repair.c
index c2acd7748269..59375b759ba8 100644
--- a/fs/xfs/scrub/agheader_repair.c
+++ b/fs/xfs/scrub/agheader_repair.c
@@ -1096,18 +1096,22 @@ xrep_iunlink_walk_ondisk_bucket(
 	struct xrep_agi		*ragi,
 	unsigned int		bucket)
 {
+	struct xagino_bitmap	seen;
 	struct xfs_scrub	*sc = ragi->sc;
 	struct xfs_agi		*agi = ragi->agi_bp->b_addr;
 	xfs_agino_t		prev_agino = NULLAGINO;
 	xfs_agino_t		next_agino;
 	int			error = 0;
 
+	xagino_bitmap_init(&seen);
+
 	next_agino = be32_to_cpu(agi->agi_unlinked[bucket]);
 	while (next_agino != NULLAGINO) {
 		xfs_agino_t	agino = next_agino;
+		unsigned int	len = 1;
 
 		if (xchk_should_terminate(ragi->sc, &error))
-			return error;
+			goto out_bitmap;
 
 		trace_xrep_iunlink_walk_ondisk_bucket(sc->sa.pag, bucket,
 				prev_agino, agino);
@@ -1115,6 +1119,9 @@ xrep_iunlink_walk_ondisk_bucket(
 		if (bucket != agino % XFS_AGI_UNLINKED_BUCKETS)
 			break;
 
+		if (xagino_bitmap_test(&seen, agino, &len))
+			break;
+
 		next_agino = xrep_iunlink_next(sc, agino);
 		if (!next_agino) {
 			error = xrep_iunlink_reload_next(ragi, prev_agino,
@@ -1123,10 +1130,16 @@ xrep_iunlink_walk_ondisk_bucket(
 				break;
 		}
 
+		error = xagino_bitmap_set(&seen, agino, 1);
+		if (error)
+			goto out_bitmap;
+
 		prev_agino = agino;
 	}
 
-	return 0;
+out_bitmap:
+	xagino_bitmap_destroy(&seen);
+	return error;
 }
 
 /* Decide if this is an unlinked inode in this AG. */
diff --git a/fs/xfs/scrub/bmap.c b/fs/xfs/scrub/bmap.c
index 35e51709a58a..38b5d47afadd 100644
--- a/fs/xfs/scrub/bmap.c
+++ b/fs/xfs/scrub/bmap.c
@@ -1040,7 +1040,7 @@ xchk_bmap(
 	case XFS_COW_FORK:
 		/* No CoW forks filesystem doesn't support out of place writes */
 		if (!xfs_has_reflink(mp) && !xfs_has_zoned(mp)) {
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 			return 0;
 		}
 		break;
@@ -1052,7 +1052,7 @@ xchk_bmap(
 		 * attr here.
 		 */
 		if (!xfs_has_attr(mp))
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 		break;
 	default:
 		ASSERT(whichfork == XFS_DATA_FORK);
@@ -1137,7 +1137,7 @@ xchk_bmap_data(
 	int			error;
 
 	if (xchk_file_looks_zapped(sc, XFS_SICK_INO_BMBTD_ZAPPED)) {
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		return 0;
 	}
 
@@ -1165,7 +1165,7 @@ xchk_bmap_attr(
 	 * returning immediately.
 	 */
 	if (xchk_file_looks_zapped(sc, XFS_SICK_INO_BMBTA_ZAPPED)) {
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		return 0;
 	}
 
diff --git a/fs/xfs/scrub/common.c b/fs/xfs/scrub/common.c
index 3d40cb0b2496..b271f4c4ef43 100644
--- a/fs/xfs/scrub/common.c
+++ b/fs/xfs/scrub/common.c
@@ -1110,7 +1110,7 @@ xchk_install_live_inode(
 	struct xfs_inode	*ip)
 {
 	if (!igrab(VFS_I(ip))) {
-		xchk_ino_set_corrupt(sc, ip->i_ino);
+		xchk_ip_set_corrupt(sc, ip);
 		return -EFSCORRUPTED;
 	}
 
@@ -1439,13 +1439,13 @@ xchk_metadata_inode_forks(
 
 	/* Metadata inodes don't live on the rt device. */
 	if (sc->ip->i_diflags & XFS_DIFLAG_REALTIME) {
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		return 0;
 	}
 
 	/* They should never participate in reflink. */
 	if (xfs_is_reflink_inode(sc->ip)) {
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		return 0;
 	}
 
@@ -1462,7 +1462,7 @@ xchk_metadata_inode_forks(
 				&error))
 			return error;
 		if (shared)
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 	}
 
 	/*
@@ -1471,7 +1471,7 @@ xchk_metadata_inode_forks(
 	 */
 	if (xfs_inode_hasattr(sc->ip)) {
 		if (!xfs_has_metadir(sc->mp)) {
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 			return 0;
 		}
 
diff --git a/fs/xfs/scrub/common.h b/fs/xfs/scrub/common.h
index b494d747c008..0e23b125720f 100644
--- a/fs/xfs/scrub/common.h
+++ b/fs/xfs/scrub/common.h
@@ -32,6 +32,8 @@ void xchk_set_corrupt(struct xfs_scrub *sc);
 void xchk_block_set_corrupt(struct xfs_scrub *sc,
 		struct xfs_buf *bp);
 void xchk_ino_set_corrupt(struct xfs_scrub *sc, xfs_ino_t ino);
+#define xchk_ip_set_corrupt(_sc, _ip) \
+	xchk_ino_set_corrupt((_sc), (_ip)->i_ino)
 void xchk_fblock_set_corrupt(struct xfs_scrub *sc, int whichfork,
 		xfs_fileoff_t offset);
 #ifdef CONFIG_XFS_QUOTA
diff --git a/fs/xfs/scrub/dir.c b/fs/xfs/scrub/dir.c
index 09715a4aa154..8306dfafff3b 100644
--- a/fs/xfs/scrub/dir.c
+++ b/fs/xfs/scrub/dir.c
@@ -1080,7 +1080,7 @@ xchk_directory(
 
 	/* Plausible size? */
 	if (sc->ip->i_disk_size < xfs_dir2_sf_hdr_size(0)) {
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		return 0;
 	}
 
diff --git a/fs/xfs/scrub/dirtree.c b/fs/xfs/scrub/dirtree.c
index 19f014e2ece6..7eb285ecc5e2 100644
--- a/fs/xfs/scrub/dirtree.c
+++ b/fs/xfs/scrub/dirtree.c
@@ -979,10 +979,10 @@ xchk_dirtree(
 	xchk_dirtree_evaluate(dl, &oc);
 	if (xchk_dirtree_parentless(dl)) {
 		if (oc.good || oc.bad || oc.suspect)
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 	} else {
 		if (oc.bad || oc.good + oc.suspect != 1)
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 		if (oc.suspect)
 			xchk_ino_xref_set_corrupt(sc, sc->ip->i_ino);
 	}
diff --git a/fs/xfs/scrub/metapath.c b/fs/xfs/scrub/metapath.c
index 050b86eb12d3..680a8ba1cdf1 100644
--- a/fs/xfs/scrub/metapath.c
+++ b/fs/xfs/scrub/metapath.c
@@ -314,7 +314,7 @@ xchk_metapath(
 
 	/* Parent required to do anything else. */
 	if (mpath->dp == NULL) {
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		return 0;
 	}
 
@@ -329,7 +329,7 @@ xchk_metapath(
 	trace_xchk_metapath_lookup(sc, mpath->path, mpath->dp, ino);
 	if (error == -ENOENT) {
 		/* No directory entry at all */
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 		error = 0;
 		goto out_ilock;
 	}
@@ -337,7 +337,7 @@ xchk_metapath(
 		goto out_ilock;
 	if (ino != sc->ip->i_ino) {
 		/* Pointing to wrong inode */
-		xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+		xchk_ip_set_corrupt(sc, sc->ip);
 	}
 
 out_ilock:
diff --git a/fs/xfs/scrub/nlinks.c b/fs/xfs/scrub/nlinks.c
index 80b28b30d762..5d0a8d837fed 100644
--- a/fs/xfs/scrub/nlinks.c
+++ b/fs/xfs/scrub/nlinks.c
@@ -719,7 +719,7 @@ xchk_nlinks_compare_inode(
 	 * count, but it will let them decrease it.
 	 */
 	if (total_links > XFS_NLINK_PINNED) {
-		xchk_ino_set_corrupt(sc, ip->i_ino);
+		xchk_ip_set_corrupt(sc, ip);
 		goto out_corrupt;
 	} else if (total_links > XFS_MAXLINK) {
 		xchk_ino_set_warning(sc, ip->i_ino);
@@ -727,7 +727,7 @@ xchk_nlinks_compare_inode(
 
 	/* Link counts should match. */
 	if (total_links != actual_nlink) {
-		xchk_ino_set_corrupt(sc, ip->i_ino);
+		xchk_ip_set_corrupt(sc, ip);
 		goto out_corrupt;
 	}
 
@@ -748,7 +748,7 @@ xchk_nlinks_compare_inode(
 		 * back references.
 		 */
 		if (obs.backrefs != 0) {
-			xchk_ino_set_corrupt(sc, ip->i_ino);
+			xchk_ip_set_corrupt(sc, ip);
 			goto out_corrupt;
 		}
 
@@ -757,7 +757,7 @@ xchk_nlinks_compare_inode(
 		 * children.
 		 */
 		if (obs.children != 0) {
-			xchk_ino_set_corrupt(sc, ip->i_ino);
+			xchk_ip_set_corrupt(sc, ip);
 			goto out_corrupt;
 		}
 	}
@@ -770,7 +770,7 @@ xchk_nlinks_compare_inode(
 		 * the root directory.
 		 */
 		if (obs.parents != 1) {
-			xchk_ino_set_corrupt(sc, ip->i_ino);
+			xchk_ip_set_corrupt(sc, ip);
 			goto out_corrupt;
 		}
 	} else if (actual_nlink > 0) {
@@ -779,7 +779,7 @@ xchk_nlinks_compare_inode(
 		 * least one parent.
 		 */
 		if (obs.parents == 0) {
-			xchk_ino_set_corrupt(sc, ip->i_ino);
+			xchk_ip_set_corrupt(sc, ip);
 			goto out_corrupt;
 		}
 	}
diff --git a/fs/xfs/scrub/parent.c b/fs/xfs/scrub/parent.c
index 8e321b24181c..dc25e5c84ac1 100644
--- a/fs/xfs/scrub/parent.c
+++ b/fs/xfs/scrub/parent.c
@@ -729,10 +729,10 @@ xchk_parent_count_pptrs(
 			pp->pptrs_found++;
 
 		if (VFS_I(sc->ip)->i_nlink == 0 && pp->pptrs_found > 0)
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 		else if (VFS_I(sc->ip)->i_nlink > 0 &&
 			 pp->pptrs_found == 0)
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 	} else {
 		/*
 		 * Starting with metadir, we allow checking of parent pointers
@@ -743,7 +743,7 @@ xchk_parent_count_pptrs(
 			pp->pptrs_found++;
 
 		if (VFS_I(sc->ip)->i_nlink != pp->pptrs_found)
-			xchk_ino_set_corrupt(sc, sc->ip->i_ino);
+			xchk_ip_set_corrupt(sc, sc->ip);
 	}
 
 	return 0;
diff --git a/fs/xfs/scrub/rtbitmap.c b/fs/xfs/scrub/rtbitmap.c
index 88b438d8fd89..97dbe5779a79 100644
--- a/fs/xfs/scrub/rtbitmap.c
+++ b/fs/xfs/scrub/rtbitmap.c
@@ -200,13 +200,13 @@ xchk_rtbitmap(
 
 	/* Is sb_rextents correct? */
 	if (mp->m_sb.sb_rextents != rtb->rextents) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 
 	/* Is sb_rextslog correct? */
 	if (mp->m_sb.sb_rextslog != rtb->rextslog) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 
@@ -215,17 +215,17 @@ xchk_rtbitmap(
 	 * case can we exceed 4bn bitmap blocks since the super field is a u32.
 	 */
 	if (rtb->rbmblocks > U32_MAX) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 	if (mp->m_sb.sb_rbmblocks != rtb->rbmblocks) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 
 	/* The bitmap file length must be aligned to an fsblock. */
 	if (rbmip->i_disk_size & mp->m_blockmask) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 
@@ -235,7 +235,7 @@ xchk_rtbitmap(
 	 * file can be larger than sb_rbmblocks.
 	 */
 	if (rbmip->i_disk_size < XFS_FSB_TO_B(mp, rtb->rbmblocks)) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 
diff --git a/fs/xfs/scrub/rtsummary.c b/fs/xfs/scrub/rtsummary.c
index efce39d7a1ef..8decb4b1484b 100644
--- a/fs/xfs/scrub/rtsummary.c
+++ b/fs/xfs/scrub/rtsummary.c
@@ -314,25 +314,25 @@ xchk_rtsummary(
 
 	/* Is sb_rextents correct? */
 	if (mp->m_sb.sb_rextents != rts->rextents) {
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ip_set_corrupt(sc, rbmip);
 		return 0;
 	}
 
 	/* Is m_rsumlevels correct? */
 	if (mp->m_rsumlevels != rts->rsumlevels) {
-		xchk_ino_set_corrupt(sc, rsumip->i_ino);
+		xchk_ip_set_corrupt(sc, rsumip);
 		return 0;
 	}
 
 	/* Is m_rsumsize correct? */
 	if (mp->m_rsumblocks != rts->rsumblocks) {
-		xchk_ino_set_corrupt(sc, rsumip->i_ino);
+		xchk_ip_set_corrupt(sc, rsumip);
 		return 0;
 	}
 
 	/* The summary file length must be aligned to an fsblock. */
 	if (rsumip->i_disk_size & mp->m_blockmask) {
-		xchk_ino_set_corrupt(sc, rsumip->i_ino);
+		xchk_ip_set_corrupt(sc, rsumip);
 		return 0;
 	}
 
@@ -342,7 +342,7 @@ xchk_rtsummary(
 	 * the file can be larger than rsumsize.
 	 */
 	if (rsumip->i_disk_size < XFS_FSB_TO_B(mp, rts->rsumblocks)) {
-		xchk_ino_set_corrupt(sc, rsumip->i_ino);
+		xchk_ip_set_corrupt(sc, rsumip);
 		return 0;
 	}
 
@@ -358,7 +358,7 @@ xchk_rtsummary(
 		 * EFSCORRUPTED means the rtbitmap is corrupt, which is an xref
 		 * error since we're checking the summary file.
 		 */
-		xchk_ino_set_corrupt(sc, rbmip->i_ino);
+		xchk_ino_xref_set_corrupt(sc, rbmip->i_ino);
 		return 0;
 	}
 	if (error)
diff --git a/fs/xfs/xfs_trans.c b/fs/xfs/xfs_trans.c
index 148cc32449c1..33557503be9f 100644
--- a/fs/xfs/xfs_trans.c
+++ b/fs/xfs/xfs_trans.c
@@ -1029,6 +1029,15 @@ xfs_trans_roll(
 	 * duplicate transaction that gets returned.
 	 */
 	error = __xfs_trans_commit(tp, true);
+
+	tp = *tpp;
+	/*
+	 * __xfs_trans_commit cleared the NOFS flag by calling into
+	 * xfs_trans_free.  Set it again here before doing memory
+	 * allocations.
+	 */
+	xfs_trans_set_context(tp);
+
 	if (error)
 		return error;
 
@@ -1040,13 +1049,6 @@ xfs_trans_roll(
 	 * either nothing be locked across this call, or that anything that is
 	 * locked be logged in the prior and the next transactions.
 	 */
-	tp = *tpp;
-	/*
-	 * __xfs_trans_commit cleared the NOFS flag by calling into
-	 * xfs_trans_free.  Set it again here before doing memory
-	 * allocations.
-	 */
-	xfs_trans_set_context(tp);
 	error = xfs_log_regrant(tp->t_mountp, tp->t_ticket);
 	if (error)
 		return error;
diff --git a/include/linux/fb.h b/include/linux/fb.h
index 5178a33c752c..88680a7cabd5 100644
--- a/include/linux/fb.h
+++ b/include/linux/fb.h
@@ -533,6 +533,8 @@ extern int fb_set_var(struct fb_info *info, struct fb_var_screeninfo *var);
 extern int fb_pan_display(struct fb_info *info, struct fb_var_screeninfo *var);
 extern int fb_blank(struct fb_info *info, int blank);
 
+int fb_set_var_from_user(struct fb_info *info, struct fb_var_screeninfo *var);
+
 /*
  * Helpers for framebuffers in I/O memory
  */
diff --git a/include/linux/futex.h b/include/linux/futex.h
index 9e9750f04980..e93f2be22779 100644
--- a/include/linux/futex.h
+++ b/include/linux/futex.h
@@ -77,6 +77,7 @@ static inline void futex_init_task(struct task_struct *tsk)
 void futex_exit_recursive(struct task_struct *tsk);
 void futex_exit_release(struct task_struct *tsk);
 void futex_exec_release(struct task_struct *tsk);
+void futex_exec_done(struct task_struct *tsk);
 
 long do_futex(u32 __user *uaddr, int op, u32 val, ktime_t *timeout,
 	      u32 __user *uaddr2, u32 val2, u32 val3);
@@ -98,6 +99,7 @@ static inline void futex_init_task(struct task_struct *tsk) { }
 static inline void futex_exit_recursive(struct task_struct *tsk) { }
 static inline void futex_exit_release(struct task_struct *tsk) { }
 static inline void futex_exec_release(struct task_struct *tsk) { }
+static inline void futex_exec_done(struct task_struct *tsk) { }
 static inline long do_futex(u32 __user *uaddr, int op, u32 val,
 			    ktime_t *timeout, u32 __user *uaddr2,
 			    u32 val2, u32 val3)
diff --git a/include/linux/hid.h b/include/linux/hid.h
index 47dc0bc89fa4..51b21f98037b 100644
--- a/include/linux/hid.h
+++ b/include/linux/hid.h
@@ -642,6 +642,7 @@ enum hid_battery_status {
  * @max: maximum battery value from HID descriptor
  * @report_type: HID report type (input/feature)
  * @report_id: HID report ID for this battery
+ * @report_offset: bit offset of the capacity field within its report
  * @charge_status: current charging status
  * @status: battery reporting status
  * @capacity: current battery capacity (0-100)
@@ -657,6 +658,7 @@ struct hid_battery {
 	__s32 max;
 	__s32 report_type;
 	__s32 report_id;
+	__s32 report_offset;
 	__s32 charge_status;
 	enum hid_battery_status status;
 	__s32 capacity;
diff --git a/include/linux/io_uring_types.h b/include/linux/io_uring_types.h
index 244392026c6d..f61b6cad229b 100644
--- a/include/linux/io_uring_types.h
+++ b/include/linux/io_uring_types.h
@@ -20,6 +20,14 @@ enum {
 	 * It's also ignored unless IORING_SETUP_DEFER_TASKRUN is set.
 	 */
 	IOU_F_TWQ_LAZY_WAKE			= 1,
+
+	/*
+	 * Set when task_work is queued from a waitqueue wakeup handler, where
+	 * an arbitrary provider waitqueue lock is held. Signaling the CQ ring
+	 * eventfd inline from there can recurse back into that lock through
+	 * epoll, so the eventfd signal must be deferred.
+	 */
+	IOU_F_TWQ_IN_WAKE			= 2,
 };
 
 enum io_uring_cmd_flags {
diff --git a/include/linux/pci-ecam.h b/include/linux/pci-ecam.h
index d930651473b4..044f67ced6ff 100644
--- a/include/linux/pci-ecam.h
+++ b/include/linux/pci-ecam.h
@@ -81,6 +81,9 @@ void __iomem *pci_ecam_map_bus(struct pci_bus *bus, unsigned int devfn,
 /* default ECAM ops */
 extern const struct pci_ecam_ops pci_generic_ecam_ops;
 
+/* default CAM ops */
+extern const struct pci_ecam_ops pci_generic_cam_ops;
+
 #if defined(CONFIG_ACPI) && defined(CONFIG_PCI_QUIRKS)
 extern const struct pci_ecam_ops pci_32b_ops;	/* 32-bit accesses only */
 extern const struct pci_ecam_ops pci_32b_read_ops; /* 32-bit read only */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index ee06cba5c6f5..eaf975138359 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1525,6 +1525,14 @@ struct task_struct {
 
 	/* Collect coverage from softirq context: */
 	unsigned int			kcov_softirq;
+
+	/* Temporary storage for preempting remote coverage collection: */
+	unsigned int			kcov_saved_mode;
+	unsigned int			kcov_saved_size;
+	void				*kcov_saved_area;
+	struct kcov			*kcov_saved_kcov;
+	int				kcov_saved_sequence;
+
 #endif
 
 #ifdef CONFIG_MEMCG_V1
diff --git a/include/linux/wait.h b/include/linux/wait.h
index dce055e6add3..7e215330199c 100644
--- a/include/linux/wait.h
+++ b/include/linux/wait.h
@@ -1228,6 +1228,7 @@ long prepare_to_wait_event(struct wait_queue_head *wq_head, struct wait_queue_en
 void finish_wait(struct wait_queue_head *wq_head, struct wait_queue_entry *wq_entry);
 long wait_woken(struct wait_queue_entry *wq_entry, unsigned mode, long timeout);
 int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key);
+int woken_wake_bit_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key);
 int autoremove_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key);
 
 #define DEFINE_WAIT_FUNC(name, function)					\
diff --git a/include/linux/wait_bit.h b/include/linux/wait_bit.h
index ace7379d627d..553d7b23e3ad 100644
--- a/include/linux/wait_bit.h
+++ b/include/linux/wait_bit.h
@@ -32,6 +32,7 @@ int out_of_line_wait_on_bit_timeout(unsigned long *word, int, wait_bit_action_f
 int out_of_line_wait_on_bit_lock(unsigned long *word, int, wait_bit_action_f *action, unsigned int mode);
 struct wait_queue_head *bit_waitqueue(unsigned long *word, int bit);
 extern void __init wait_bit_init(void);
+extern struct wait_bit_key *__var_wake_key(struct wait_queue_entry *wq_entry, void *arg);
 
 int wake_bit_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *key);
 
diff --git a/io_uring/eventfd.c b/io_uring/eventfd.c
index d656cc2a0b9b..63fe6e5d79ba 100644
--- a/io_uring/eventfd.c
+++ b/io_uring/eventfd.c
@@ -51,9 +51,9 @@ static void io_eventfd_do_signal(struct rcu_head *rcu)
 /*
  * Returns true if the caller should put the ev_fd reference, false if not.
  */
-static bool __io_eventfd_signal(struct io_ev_fd *ev_fd)
+static bool __io_eventfd_signal(struct io_ev_fd *ev_fd, bool defer)
 {
-	if (eventfd_signal_allowed()) {
+	if (!defer && eventfd_signal_allowed()) {
 		eventfd_signal_mask(ev_fd->cq_ev_fd, EPOLL_URING_WAKE);
 		return true;
 	}
@@ -73,7 +73,7 @@ static bool io_eventfd_trigger(struct io_ev_fd *ev_fd)
 	return !ev_fd->eventfd_async || io_wq_current_is_worker();
 }
 
-void io_eventfd_signal(struct io_ring_ctx *ctx, bool cqe_event)
+void io_eventfd_signal(struct io_ring_ctx *ctx, bool cqe_event, bool defer)
 {
 	bool skip = false;
 	struct io_ev_fd *ev_fd;
@@ -113,7 +113,7 @@ void io_eventfd_signal(struct io_ring_ctx *ctx, bool cqe_event)
 		spin_unlock(&ctx->completion_lock);
 	}
 
-	if (skip || __io_eventfd_signal(ev_fd))
+	if (skip || __io_eventfd_signal(ev_fd, defer))
 		io_eventfd_put(ev_fd);
 }
 
diff --git a/io_uring/eventfd.h b/io_uring/eventfd.h
index 400eda4a4165..e965d80d9fdc 100644
--- a/io_uring/eventfd.h
+++ b/io_uring/eventfd.h
@@ -5,4 +5,4 @@ int io_eventfd_register(struct io_ring_ctx *ctx, void __user *arg,
 			unsigned int eventfd_async);
 int io_eventfd_unregister(struct io_ring_ctx *ctx);
 
-void io_eventfd_signal(struct io_ring_ctx *ctx, bool cqe_event);
+void io_eventfd_signal(struct io_ring_ctx *ctx, bool cqe_event, bool defer);
diff --git a/io_uring/futex.c b/io_uring/futex.c
index 9cc1788ef4c6..8c343006bc6b 100644
--- a/io_uring/futex.c
+++ b/io_uring/futex.c
@@ -149,8 +149,21 @@ int io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	    !futex_validate_input(iof->futex_flags, iof->futex_mask))
 		return -EINVAL;
 
-	/* Mark as inflight, so file exit cancelation will find it */
-	io_req_track_inflight(req);
+	return 0;
+}
+
+int io_futex_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
+{
+	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
+	int ret;
+
+	ret = io_futex_prep(req, sqe);
+	if (unlikely(ret))
+		return ret;
+
+	/* inflight tracking only needed for mm private hash */
+	if (!(iof->futex_flags & FLAGS_SHARED))
+		io_req_track_inflight(req);
 	return 0;
 }
 
@@ -168,13 +181,14 @@ static void io_futex_wakev_fn(struct wake_q_head *wake_q, struct futex_q *q)
 
 	io_req_set_res(req, 0, 0);
 	req->io_task_work.func = io_futexv_complete;
-	io_req_task_work_add(req);
+	__io_req_task_work_add(req, IOU_F_TWQ_IN_WAKE);
 }
 
 int io_futexv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 {
 	struct io_futex *iof = io_kiocb_to_cmd(req, struct io_futex);
 	struct io_futexv_data *ifd;
+	unsigned int i;
 	int ret;
 
 	/* No flags or mask supported for waitv */
@@ -199,8 +213,14 @@ int io_futexv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 		return ret;
 	}
 
-	/* Mark as inflight, so file exit cancelation will find it */
-	io_req_track_inflight(req);
+	/* inflight tracking only needed for mm private hash */
+	for (i = 0; i < iof->futex_nr; i++) {
+		if (!(ifd->futexv[i].w.flags & FLAGS_SHARED)) {
+			io_req_track_inflight(req);
+			break;
+		}
+	}
+
 	iof->futexv_unqueued = 0;
 	req->flags |= REQ_F_ASYNC_DATA;
 	req->async_data = ifd;
@@ -217,7 +237,7 @@ static void io_futex_wake_fn(struct wake_q_head *wake_q, struct futex_q *q)
 
 	io_req_set_res(req, 0, 0);
 	req->io_task_work.func = io_futex_complete;
-	io_req_task_work_add(req);
+	__io_req_task_work_add(req, IOU_F_TWQ_IN_WAKE);
 }
 
 int io_futexv_wait(struct io_kiocb *req, unsigned int issue_flags)
diff --git a/io_uring/futex.h b/io_uring/futex.h
index d789fcf715e3..987db3f2c6d9 100644
--- a/io_uring/futex.h
+++ b/io_uring/futex.h
@@ -3,6 +3,7 @@
 #include "cancel.h"
 
 int io_futex_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
+int io_futex_wait_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_futexv_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe);
 int io_futex_wait(struct io_kiocb *req, unsigned int issue_flags);
 int io_futexv_wait(struct io_kiocb *req, unsigned int issue_flags);
diff --git a/io_uring/io-wq.c b/io_uring/io-wq.c
index 2e14880eef92..fa403ed24596 100644
--- a/io_uring/io-wq.c
+++ b/io_uring/io-wq.c
@@ -211,9 +211,12 @@ static void io_worker_cancel_cb(struct io_worker *worker)
 	struct io_wq *wq = worker->wq;
 
 	atomic_dec(&acct->nr_running);
-	raw_spin_lock(&acct->workers_lock);
-	acct->nr_workers--;
-	raw_spin_unlock(&acct->workers_lock);
+	/* create_worker_cb() has not reserved a worker slot yet. */
+	if (worker->create_work.func != create_worker_cb) {
+		raw_spin_lock(&acct->workers_lock);
+		acct->nr_workers--;
+		raw_spin_unlock(&acct->workers_lock);
+	}
 	io_worker_ref_put(wq);
 	clear_bit_unlock(0, &worker->create_state);
 	io_worker_release(worker);
diff --git a/io_uring/io_uring.c b/io_uring/io_uring.c
index 103b6c88f252..52378e715845 100644
--- a/io_uring/io_uring.c
+++ b/io_uring/io_uring.c
@@ -483,7 +483,7 @@ void __io_commit_cqring_flush(struct io_ring_ctx *ctx)
 	if (ctx->int_flags & IO_RING_F_OFF_TIMEOUT_USED)
 		io_flush_timeouts(ctx);
 	if (ctx->int_flags & IO_RING_F_HAS_EVFD)
-		io_eventfd_signal(ctx, true);
+		io_eventfd_signal(ctx, true, false);
 }
 
 static inline void __io_cq_lock(struct io_ring_ctx *ctx)
diff --git a/io_uring/opdef.c b/io_uring/opdef.c
index 34cd320a427b..28262f1c0e63 100644
--- a/io_uring/opdef.c
+++ b/io_uring/opdef.c
@@ -465,7 +465,7 @@ const struct io_issue_def io_issue_defs[] = {
 	},
 	[IORING_OP_FUTEX_WAIT] = {
 #if defined(CONFIG_FUTEX)
-		.prep			= io_futex_prep,
+		.prep			= io_futex_wait_prep,
 		.issue			= io_futex_wait,
 #else
 		.prep			= io_eopnotsupp_prep,
diff --git a/io_uring/poll.c b/io_uring/poll.c
index 0204affdc308..5447a7c24dce 100644
--- a/io_uring/poll.c
+++ b/io_uring/poll.c
@@ -208,9 +208,9 @@ enum {
 	IOU_POLL_REQUEUE = 4,
 };
 
-static void __io_poll_execute(struct io_kiocb *req, int mask)
+static void __io_poll_execute(struct io_kiocb *req, int mask, unsigned tw_flags)
 {
-	unsigned flags = 0;
+	unsigned flags = tw_flags;
 
 	io_req_set_res(req, mask, 0);
 	req->io_task_work.func = io_poll_task_func;
@@ -218,14 +218,15 @@ static void __io_poll_execute(struct io_kiocb *req, int mask)
 	trace_io_uring_task_add(req, mask);
 
 	if (!(req->flags & REQ_F_POLL_NO_LAZY))
-		flags = IOU_F_TWQ_LAZY_WAKE;
+		flags |= IOU_F_TWQ_LAZY_WAKE;
 	__io_req_task_work_add(req, flags);
 }
 
-static inline void io_poll_execute(struct io_kiocb *req, int res)
+static inline void io_poll_execute(struct io_kiocb *req, int res,
+				   unsigned tw_flags)
 {
 	if (io_poll_get_ownership(req))
-		__io_poll_execute(req, res);
+		__io_poll_execute(req, res, tw_flags);
 }
 
 /*
@@ -344,7 +345,7 @@ void io_poll_task_func(struct io_tw_req tw_req, io_tw_token_t tw)
 	if (ret == IOU_POLL_NO_ACTION) {
 		return;
 	} else if (ret == IOU_POLL_REQUEUE) {
-		__io_poll_execute(req, 0);
+		__io_poll_execute(req, 0, 0);
 		return;
 	}
 	io_poll_remove_entries(req);
@@ -383,7 +384,7 @@ static void io_poll_cancel_req(struct io_kiocb *req)
 {
 	io_poll_mark_cancelled(req);
 	/* kick tw, which should complete the request */
-	io_poll_execute(req, 0);
+	io_poll_execute(req, 0, 0);
 }
 
 #define IO_ASYNC_POLL_COMMON	(EPOLLONESHOT | EPOLLPRI)
@@ -392,7 +393,7 @@ static __cold int io_pollfree_wake(struct io_kiocb *req, struct io_poll *poll)
 {
 	io_poll_mark_cancelled(req);
 	/* we have to kick tw in case it's not already */
-	io_poll_execute(req, 0);
+	io_poll_execute(req, 0, IOU_F_TWQ_IN_WAKE);
 	io_poll_remove_waitq(poll);
 	return 1;
 }
@@ -430,7 +431,7 @@ static int io_poll_wake(struct wait_queue_entry *wait, unsigned mode, int sync,
 			else
 				req->flags &= ~REQ_F_SINGLE_POLL;
 		}
-		__io_poll_execute(req, mask);
+		__io_poll_execute(req, mask, IOU_F_TWQ_IN_WAKE);
 	}
 	return 1;
 }
@@ -618,7 +619,7 @@ static int __io_arm_poll_handler(struct io_kiocb *req,
 
 	if (mask && (poll->events & EPOLLET) &&
 	    io_poll_can_finish_inline(req, ipt)) {
-		__io_poll_execute(req, mask);
+		__io_poll_execute(req, mask, 0);
 		return 0;
 	}
 	io_napi_add(req);
@@ -629,7 +630,7 @@ static int __io_arm_poll_handler(struct io_kiocb *req,
 		 * poll was waken up, queue up a tw, it'll deal with it.
 		 */
 		if (atomic_cmpxchg(&req->poll_refs, 1, 0) != 1)
-			__io_poll_execute(req, 0);
+			__io_poll_execute(req, 0, 0);
 	}
 	return 0;
 }
diff --git a/io_uring/rsrc.c b/io_uring/rsrc.c
index 650303626be6..2dfc26233e28 100644
--- a/io_uring/rsrc.c
+++ b/io_uring/rsrc.c
@@ -1332,7 +1332,7 @@ static int io_vec_fill_bvec(int ddir, struct iov_iter *iter,
 				struct iovec *iovec, unsigned nr_iovs,
 				struct iou_vec *vec)
 {
-	unsigned long folio_size = 1 << imu->folio_shift;
+	unsigned long folio_size = 1UL << imu->folio_shift;
 	unsigned long folio_mask = folio_size - 1;
 	struct bio_vec *res_bvec = vec->bvec;
 	size_t total_len = 0;
diff --git a/io_uring/tw.c b/io_uring/tw.c
index 023d5e6bc491..a4d91c5982fe 100644
--- a/io_uring/tw.c
+++ b/io_uring/tw.c
@@ -223,7 +223,7 @@ void io_req_local_work_add(struct io_kiocb *req, unsigned flags)
 	if (!head) {
 		io_ctx_mark_taskrun(ctx);
 		if (data_race(ctx->int_flags) & IO_RING_F_HAS_EVFD)
-			io_eventfd_signal(ctx, false);
+			io_eventfd_signal(ctx, false, flags & IOU_F_TWQ_IN_WAKE);
 	}
 
 	nr_wait = atomic_read(&ctx->cq_wait_nr);
diff --git a/io_uring/uring_cmd.c b/io_uring/uring_cmd.c
index 7b25dcd9d05f..72916a7a91dd 100644
--- a/io_uring/uring_cmd.c
+++ b/io_uring/uring_cmd.c
@@ -38,6 +38,8 @@ static void io_req_uring_cleanup(struct io_kiocb *req, unsigned int issue_flags)
 	if (io_alloc_cache_put(&req->ctx->cmd_cache, ac)) {
 		ioucmd->sqe = NULL;
 		io_req_async_data_clear(req, REQ_F_NEED_CLEANUP);
+	} else {
+		io_vec_free(&ac->vec);
 	}
 }
 
@@ -208,6 +210,8 @@ int io_uring_cmd_prep(struct io_kiocb *req, const struct io_uring_sqe *sqe)
 	ac = io_uring_alloc_async_data(&req->ctx->cmd_cache, req);
 	if (!ac)
 		return -ENOMEM;
+	if (ac->vec.iovec)
+		req->flags |= REQ_F_NEED_CLEANUP;
 	ioucmd->sqe = sqe;
 	return 0;
 }
@@ -269,10 +273,6 @@ int io_uring_cmd(struct io_kiocb *req, unsigned int issue_flags)
 	}
 
 	ret = file->f_op->uring_cmd(ioucmd, issue_flags);
-	if (ioucmd->flags & IORING_URING_CMD_MULTISHOT) {
-		if (ret >= 0)
-			return IOU_ISSUE_SKIP_COMPLETE;
-	}
 	if (ret == -EAGAIN) {
 		ioucmd->flags |= IORING_URING_CMD_REISSUE;
 		return ret;
diff --git a/io_uring/waitid.c b/io_uring/waitid.c
index 32f68fd7fcdd..76af129ba8ca 100644
--- a/io_uring/waitid.c
+++ b/io_uring/waitid.c
@@ -253,7 +253,7 @@ static int io_waitid_wait(struct wait_queue_entry *wait, unsigned mode,
 		return 1;
 
 	req->io_task_work.func = io_waitid_cb;
-	io_req_task_work_add(req);
+	__io_req_task_work_add(req, IOU_F_TWQ_IN_WAKE);
 	return 1;
 }
 
diff --git a/kernel/futex/core.c b/kernel/futex/core.c
index 6b3121c734bb..7ffe6dc79b28 100644
--- a/kernel/futex/core.c
+++ b/kernel/futex/core.c
@@ -44,6 +44,7 @@
 #include <linux/prctl.h>
 #include <linux/mempolicy.h>
 #include <linux/mmap_lock.h>
+#include <linux/wait_bit.h>
 
 #include "futex.h"
 #include "../locking/rtmutex_common.h"
@@ -133,15 +134,6 @@ static bool futex_ref_is_dead(struct futex_private_hash *fph);
 
 enum { FR_PERCPU = 0, FR_ATOMIC };
 
-static inline bool futex_key_is_private(union futex_key *key)
-{
-	/*
-	 * Relies on get_futex_key() to set either bit for shared
-	 * futexes -- see comment with union futex_key.
-	 */
-	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
-}
-
 static bool futex_private_hash_get(struct futex_private_hash *fph)
 {
 	return futex_ref_get(fph);
@@ -149,8 +141,10 @@ static bool futex_private_hash_get(struct futex_private_hash *fph)
 
 void futex_private_hash_put(struct futex_private_hash *fph)
 {
+	struct mm_struct *mm = fph->mm;
+
 	if (futex_ref_put(fph))
-		wake_up_var(fph->mm);
+		wake_up_var(mm);
 }
 
 /**
@@ -1507,14 +1501,12 @@ static void futex_cleanup_begin(struct task_struct *tsk)
 	raw_spin_unlock_irq(&tsk->pi_lock);
 }
 
-static void futex_cleanup_end(struct task_struct *tsk, int state)
+static void futex_cleanup_end(struct task_struct *tsk)
 	__releases(&tsk->futex_exit_mutex)
 {
-	/*
-	 * Lockless store. The only side effect is that an observer might
-	 * take another loop until it becomes visible.
-	 */
-	tsk->futex_state = state;
+	scoped_guard(raw_spinlock_irq, &tsk->pi_lock)
+		tsk->futex_state = FUTEX_STATE_DEAD;
+
 	/*
 	 * Drop the exit protection. This unblocks waiters which observed
 	 * FUTEX_STATE_EXITING to reevaluate the state.
@@ -1522,29 +1514,49 @@ static void futex_cleanup_end(struct task_struct *tsk, int state)
 	mutex_unlock(&tsk->futex_exit_mutex);
 }
 
-void futex_exec_release(struct task_struct *tsk)
+void futex_exit_release(struct task_struct *tsk)
 {
-	/*
-	 * The state handling is done for consistency, but in the case of
-	 * exec() there is no way to prevent further damage as the PID stays
-	 * the same. But for the unlikely and arguably buggy case that a
-	 * futex is held on exec(), this provides at least as much state
-	 * consistency protection which is possible.
-	 */
 	futex_cleanup_begin(tsk);
 	futex_cleanup(tsk);
+	futex_cleanup_end(tsk);
+}
+
+void futex_exec_release(struct task_struct *tsk)
+{
 	/*
-	 * Reset the state to FUTEX_STATE_OK. The task is alive and about
-	 * exec a new binary.
+	 * exec() makes it interesting for futexes because the TID of the task
+	 * stays the same, but from a futex perspective the task has to be
+	 * treated like an exiting task. This is especially important for the
+	 * sanity check for private futexes in attach_to_pi_owner() which
+	 * compares the owner's mm with the waiter's mm.
+	 *
+	 * That check would give the wrong answer if futex_cleanup_end() would
+	 * set the state to FUTEX_STATE_OK as long as the task still has the old
+	 * mm.
+	 *
+	 * After the task has switched to the new mm it sets it to
+	 * FUTEX_STATE_OK again in futex_exec_done().
 	 */
-	futex_cleanup_end(tsk, FUTEX_STATE_OK);
+	futex_exit_release(tsk);
 }
 
-void futex_exit_release(struct task_struct *tsk)
+/*
+ * exec() has switched to the new mm. Futex operations are safe again.
+ */
+void futex_exec_done(struct task_struct *tsk)
 {
-	futex_cleanup_begin(tsk);
-	futex_cleanup(tsk);
-	futex_cleanup_end(tsk, FUTEX_STATE_DEAD);
+	/*
+	 * This store does not have to take tsk::futex::exit_mutex because the
+	 * phase where waiters block on it during state FUTEX_STATE_EXITING has
+	 * been finished when futex_cleanup_end() set the state to
+	 * FUTEX_STATE_DEAD.
+	 *
+	 * This transitions back from FUTEX_STATE_DEAD to FUTEX_STATE_OK. The
+	 * ordering guarantee required here is that the previous store to
+	 * tsk::mm in the calling code cannot be reordered against this store.
+	 */
+	guard(raw_spinlock_irq)(&tsk->pi_lock);
+	tsk->futex_state = FUTEX_STATE_OK;
 }
 
 static void futex_hash_bucket_init(struct futex_hash_bucket *fhb,
@@ -1777,12 +1789,12 @@ static bool futex_pivot_pending(struct mm_struct *mm)
 {
 	struct futex_private_hash *fph;
 
-	guard(rcu)();
+	guard(mutex)(&mm->futex_hash_lock);
 
 	if (!mm->futex_phash_new)
 		return true;
 
-	fph = rcu_dereference(mm->futex_phash);
+	fph = rcu_dereference_raw(mm->futex_phash);
 	return futex_ref_is_dead(fph);
 }
 
@@ -1833,14 +1845,18 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 	}
 
 	if (!mm->futex_ref) {
+		unsigned int __percpu *ref = alloc_percpu(unsigned int);
+
+		if (!ref)
+			return -ENOMEM;
+
 		/*
-		 * This will always be allocated by the first thread and
-		 * therefore requires no locking.
+		 * Tasks sharing the mm can run this concurrently, so take the
+		 * initial reference before publishing the counter.
 		 */
-		mm->futex_ref = alloc_percpu(unsigned int);
-		if (!mm->futex_ref)
-			return -ENOMEM;
-		this_cpu_inc(*mm->futex_ref); /* 0 -> 1 */
+		this_cpu_inc(*ref); /* 0 -> 1 */
+		if (cmpxchg(&mm->futex_ref, NULL, ref))
+			free_percpu(ref);
 	}
 
 	fph = kvzalloc(struct_size(fph, queues, hash_slots),
@@ -1856,11 +1872,35 @@ static int futex_hash_allocate(unsigned int hash_slots, unsigned int flags)
 		futex_hash_bucket_init(&fph->queues[i], fph);
 
 	if (custom) {
+		struct wait_bit_queue_entry __wbq_entry;
+		struct wait_queue_head *__wq_head;
+
 		/*
 		 * Only let prctl() wait / retry; don't unduly delay clone().
 		 */
 again:
-		wait_var_event(mm, futex_pivot_pending(mm));
+		__wq_head = __var_waitqueue(mm);
+		init_wait_var_entry(&__wbq_entry, mm, 0);
+		__wbq_entry.wq_entry.func = woken_wake_bit_function;
+		add_wait_queue(__wq_head, &__wbq_entry.wq_entry);
+
+		/*
+		 * add_wait_queue()		futex_ref_put()
+		 * MB (this)			MB (implied)
+		 * futex_pivot_pending()	wake_up_var()
+		 *                                waitqueue_active()
+		 *
+		 * Notably, it must not be possible to see
+		 * !futex_pivot_pending() && !waitqueue_active().
+		 */
+		smp_mb();
+
+		while (!futex_pivot_pending(mm) &&
+		       wait_woken(&__wbq_entry.wq_entry, TASK_UNINTERRUPTIBLE,
+				  MAX_SCHEDULE_TIMEOUT))
+			/* empty */;
+
+		remove_wait_queue(__wq_head, &__wbq_entry.wq_entry);
 	}
 
 	scoped_guard(mutex, &mm->futex_hash_lock) {
diff --git a/kernel/futex/futex.h b/kernel/futex/futex.h
index 9f6bf6f585fc..65b0b791bd27 100644
--- a/kernel/futex/futex.h
+++ b/kernel/futex/futex.h
@@ -126,6 +126,15 @@ static inline bool should_fail_futex(bool fshared)
 }
 #endif
 
+static inline bool futex_key_is_private(union futex_key *key)
+{
+	/*
+	 * Relies on get_futex_key() to set either bit for shared
+	 * futexes -- see comment with union futex_key.
+	 */
+	return !(key->both.offset & (FUT_OFF_INODE | FUT_OFF_MMSHARED));
+}
+
 /*
  * Hash buckets are shared by all the futex_keys that hash to the same
  * location.  Each key may have multiple futex_q structures, one for each task
diff --git a/kernel/futex/pi.c b/kernel/futex/pi.c
index 643199fdbe62..64874032ee49 100644
--- a/kernel/futex/pi.c
+++ b/kernel/futex/pi.c
@@ -193,6 +193,58 @@ void put_pi_state(struct futex_pi_state *pi_state)
  *     pi_mutex->wait_lock
  *       p->pi_lock
  *
+ * Futex kernel state:
+ *
+ * The kernel tracks the task state in p::futex::state to protect against exit()
+ * and exec(). The states are:
+ *
+ * - FUTEX_STATE_OK when the task is alive and waiters can be attached
+ *
+ * - FUTEX_STATE_EXITING when the task cleans up the robust list and PI
+ *   state. Concurrent waiters cannot attach anymore and have to wait until the
+ *   cleanup is finished to re-evaluate the potential changes caused by the
+ *   robust list and PI state cleanups.
+ *
+ * - FUTEX_STATE_DEAD when the task has cleaned up the robust list. This state
+ *   is set independent of exit() or exec(). In the exit() case the task is
+ *   gone. In the exec() case this ensures that nothing can attach to the task
+ *   after cleaning up the robust list and PI state before it has switched to
+ *   the new mm. From a futex point of view the task is dead until it sets the
+ *   state to FUTEX_STATE_OK again after switching to the new mm.
+ *
+ * The valid state transitions for exit():
+ *
+ *   FUTEX_STATE_OK -> FUTEX_STATE_EXITING -> FUTEX_STATE_DEAD
+ *
+ * The valid state transitions for exec():
+ *
+ *   FUTEX_STATE_OK -> FUTEX_STATE_EXITING -> FUTEX_STATE_DEAD -> FUTEX_STATE_OK
+ *
+ * The state has two related locks:
+ *
+ * 1) p::pi_lock
+ *
+ *    p::pi_lock has to be taken by the waiter when evaluating the state to
+ *    protect against a concurrent exit/exec cleanup by the owner. If the state
+ *    is OK then the waiter can be attached to the owner while still holding
+ *    pi_lock.
+ *
+ *    The cleanup code has to hold it for all state transitions to ensure that
+ *    the stores to the state cannot be reordered against previous stores on
+ *    which the waiter correctness depends on.
+ *
+ * 2) p::futex::exit_mutex
+ *
+ *    The mutex is acquired when the cleanup starts and released at the end. It
+ *    obviously is not serializing the owner's cleanup against itself. It is
+ *    used to avoid a live lock caused by a waiter preempting the owner's
+ *    cleanup. Such a waiter would busy loop forever waiting for the owner to
+ *    finish the cleanup.
+ *
+ *    To prevent this, waiters have to drop all locks when observing
+ *    FUTEX_STATE_EXITING and block on the mutex. When the owner releases the
+ *    mutex after finishing the cleanup the waiters make progress and
+ *    re-evaluate the situation.
  */
 
 /*
@@ -318,18 +370,10 @@ static int attach_to_pi_state(u32 __user *uaddr, u32 uval,
 	return ret;
 }
 
-static int handle_exit_race(u32 __user *uaddr, u32 uval,
-			    struct task_struct *tsk)
+static int handle_exit_race(u32 __user *uaddr, u32 uval)
 {
 	u32 uval2;
 
-	/*
-	 * If the futex exit state is not yet FUTEX_STATE_DEAD, tell the
-	 * caller that the alleged owner is busy.
-	 */
-	if (tsk && tsk->futex_state != FUTEX_STATE_DEAD)
-		return -EBUSY;
-
 	/*
 	 * Reread the user space value to handle the following situation:
 	 *
@@ -427,7 +471,7 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 		return -EAGAIN;
 	p = find_get_task_by_vpid(pid);
 	if (!p)
-		return handle_exit_race(uaddr, uval, NULL);
+		return handle_exit_race(uaddr, uval);
 
 	if (unlikely(p->flags & PF_KTHREAD)) {
 		put_task_struct(p);
@@ -435,34 +479,55 @@ static int attach_to_pi_owner(u32 __user *uaddr, u32 uval, union futex_key *key,
 	}
 
 	/*
-	 * We need to look at the task state to figure out, whether the
-	 * task is exiting. To protect against the change of the task state
-	 * in futex_exit_release(), we do this protected by p->pi_lock:
+	 * We need to look at the task state to figure out whether the task is
+	 * exiting. To protect against the change of the task state from
+	 * FUTEX_STATE_OK to FUTEX_STATE_EXISTING in futex_cleanup_begin() it is
+	 * required to do this protected by p->pi_lock, which prevents the owner
+	 * from concurrently starting the exit cleanup.
+	 *
+	 * If the state is FUTEX_STATE_OK pi_lock must be held until the waiter
+	 * is attached to protect against a concurrent exit()/exec().
 	 */
 	raw_spin_lock_irq(&p->pi_lock);
+
+	/* Validate that the task is ready for futex operations. */
 	if (unlikely(p->futex_state != FUTEX_STATE_OK)) {
 		/*
-		 * The task is on the way out. When the futex state is
-		 * FUTEX_STATE_DEAD, we know that the task has finished
-		 * the cleanup:
+		 * The task is on the way out. When state is FUTEX_STATE_EXITING
+		 * the cleanup is in progress. To avoid a live lock when the
+		 * waiter preempted the owner, store the task pointer in
+		 * @exiting and keep the reference on the task. The calling code
+		 * will drop all locks, block on @p::futex::exit_mutex and wait
+		 * for the owner to finish the cleanup. Once the owner released
+		 * the mutex the waiter drops the reference count and
+		 * re-evaluates the situation.
 		 */
-		int ret = handle_exit_race(uaddr, uval, p);
+		if (p->futex_state == FUTEX_STATE_EXITING) {
+			raw_spin_unlock_irq(&p->pi_lock);
+			*exiting = p;
+			return -EBUSY;
+		}
+
+		int ret = handle_exit_race(uaddr, uval);
 
 		raw_spin_unlock_irq(&p->pi_lock);
+		put_task_struct(p);
+		return ret;
+	}
+
+	if (IS_ENABLED(CONFIG_MMU) && futex_key_is_private(key)) {
 		/*
-		 * If the owner task is between FUTEX_STATE_EXITING and
-		 * FUTEX_STATE_DEAD then store the task pointer and keep
-		 * the reference on the task struct. The calling code will
-		 * drop all locks, wait for the task to reach
-		 * FUTEX_STATE_DEAD and then drop the refcount. This is
-		 * required to prevent a live lock when the current task
-		 * preempted the exiting task between the two states.
+		 * A private futex key holds a pointer to the waiter's mm
+		 * without holding a reference on it. So it must not be attached
+		 * to an owner in a different address space. Otherwise that
+		 * owner's exit cleanup could access the private hash after the
+		 * key's mm is freed.
 		 */
-		if (ret == -EBUSY)
-			*exiting = p;
-		else
+		if (unlikely(p->mm != key->private.mm)) {
+			raw_spin_unlock_irq(&p->pi_lock);
 			put_task_struct(p);
-		return ret;
+			return -EPERM;
+		}
 	}
 
 	__attach_to_pi_owner(p, key, ps);
diff --git a/kernel/kcov.c b/kernel/kcov.c
index f3a5ae960ce5..342bf2925554 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -86,17 +86,12 @@ struct kcov_remote {
 
 static DEFINE_SPINLOCK(kcov_remote_lock);
 static DEFINE_HASHTABLE(kcov_remote_map, 4);
-static struct list_head kcov_remote_areas = LIST_HEAD_INIT(kcov_remote_areas);
+static struct list_head kcov_remote_areas[2] = {
+	LIST_HEAD_INIT(kcov_remote_areas[0]), LIST_HEAD_INIT(kcov_remote_areas[1])
+};
 
 struct kcov_percpu_data {
-	void			*irq_area;
 	local_lock_t		lock;
-
-	unsigned int		saved_mode;
-	unsigned int		saved_size;
-	void			*saved_area;
-	struct kcov		*saved_kcov;
-	int			saved_sequence;
 };
 
 static DEFINE_PER_CPU(struct kcov_percpu_data, kcov_percpu_data) = {
@@ -132,12 +127,13 @@ static struct kcov_remote *kcov_remote_add(struct kcov *kcov, u64 handle)
 }
 
 /* Must be called with kcov_remote_lock locked. */
-static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
+static struct kcov_remote_area *kcov_remote_area_get(unsigned int size, bool irq)
 {
 	struct kcov_remote_area *area;
 	struct list_head *pos;
+	struct list_head *list = &kcov_remote_areas[irq];
 
-	list_for_each(pos, &kcov_remote_areas) {
+	list_for_each(pos, list) {
 		area = list_entry(pos, struct kcov_remote_area, list);
 		if (area->size == size) {
 			list_del(&area->list);
@@ -149,11 +145,11 @@ static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
 
 /* Must be called with kcov_remote_lock locked. */
 static void kcov_remote_area_put(struct kcov_remote_area *area,
-					unsigned int size)
+				 unsigned int size, bool irq)
 {
 	INIT_LIST_HEAD(&area->list);
 	area->size = size;
-	list_add(&area->list, &kcov_remote_areas);
+	list_add(&area->list, &kcov_remote_areas[irq]);
 	/*
 	 * KMSAN doesn't instrument this file, so it may not know area->list
 	 * is initialized. Unpoison it explicitly to avoid reports in
@@ -388,6 +384,12 @@ void kcov_task_init(struct task_struct *t)
 {
 	kcov_task_reset(t);
 	t->kcov_handle = current->kcov_handle;
+	t->kcov_softirq = 0;
+	t->kcov_saved_mode = 0;
+	t->kcov_saved_size = 0;
+	t->kcov_saved_area = NULL;
+	t->kcov_saved_kcov = NULL;
+	t->kcov_saved_sequence = 0;
 }
 
 static void kcov_reset(struct kcov *kcov)
@@ -826,17 +828,16 @@ static inline bool kcov_mode_enabled(unsigned int mode)
 static void kcov_remote_softirq_start(struct task_struct *t)
 	__must_hold(&kcov_percpu_data.lock)
 {
-	struct kcov_percpu_data *data = this_cpu_ptr(&kcov_percpu_data);
 	unsigned int mode;
 
 	mode = READ_ONCE(t->kcov_mode);
 	barrier();
 	if (kcov_mode_enabled(mode)) {
-		data->saved_mode = mode;
-		data->saved_size = t->kcov_size;
-		data->saved_area = t->kcov_area;
-		data->saved_sequence = t->kcov_sequence;
-		data->saved_kcov = t->kcov;
+		t->kcov_saved_mode = mode;
+		t->kcov_saved_size = t->kcov_size;
+		t->kcov_saved_area = t->kcov_area;
+		t->kcov_saved_sequence = t->kcov_sequence;
+		t->kcov_saved_kcov = t->kcov;
 		kcov_stop(t);
 	}
 }
@@ -844,17 +845,15 @@ static void kcov_remote_softirq_start(struct task_struct *t)
 static void kcov_remote_softirq_stop(struct task_struct *t)
 	__must_hold(&kcov_percpu_data.lock)
 {
-	struct kcov_percpu_data *data = this_cpu_ptr(&kcov_percpu_data);
-
-	if (data->saved_kcov) {
-		kcov_start(t, data->saved_kcov, data->saved_size,
-				data->saved_area, data->saved_mode,
-				data->saved_sequence);
-		data->saved_mode = 0;
-		data->saved_size = 0;
-		data->saved_area = NULL;
-		data->saved_sequence = 0;
-		data->saved_kcov = NULL;
+	if (t->kcov_saved_kcov) {
+		kcov_start(t, t->kcov_saved_kcov, t->kcov_saved_size,
+			   t->kcov_saved_area, t->kcov_saved_mode,
+			   t->kcov_saved_sequence);
+		t->kcov_saved_mode = 0;
+		t->kcov_saved_size = 0;
+		t->kcov_saved_area = NULL;
+		t->kcov_saved_sequence = 0;
+		t->kcov_saved_kcov = NULL;
 	}
 }
 
@@ -917,17 +916,17 @@ void kcov_remote_start(u64 handle)
 	sequence = kcov->sequence;
 	if (in_task()) {
 		size = kcov->remote_size;
-		area = kcov_remote_area_get(size);
+		area = kcov_remote_area_get(size, false);
 	} else {
 		size = CONFIG_KCOV_IRQ_AREA_SIZE;
-		area = this_cpu_ptr(&kcov_percpu_data)->irq_area;
+		area = kcov_remote_area_get(size, true);
 	}
 	spin_unlock(&kcov_remote_lock);
 
-	/* Can only happen when in_task(). */
+	/* Allocate new buffer if we can sleep. */
 	if (!area) {
 		local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
-		area = vmalloc(size * sizeof(unsigned long));
+		area = in_task() ? vmalloc(size * sizeof(unsigned long)) : NULL;
 		if (!area) {
 			kcov_put(kcov);
 			return;
@@ -1069,11 +1068,9 @@ void kcov_remote_stop(void)
 		kcov_move_area(kcov->mode, kcov->area, kcov->size, area);
 	spin_unlock(&kcov->lock);
 
-	if (in_task()) {
-		spin_lock(&kcov_remote_lock);
-		kcov_remote_area_put(area, size);
-		spin_unlock(&kcov_remote_lock);
-	}
+	spin_lock(&kcov_remote_lock);
+	kcov_remote_area_put(area, size, !in_task());
+	spin_unlock(&kcov_remote_lock);
 
 	local_unlock_irqrestore(&kcov_percpu_data.lock, flags);
 
@@ -1119,14 +1116,21 @@ static void __init selftest(void)
 
 static int __init kcov_init(void)
 {
-	int cpu;
+	int cpu = num_possible_cpus();
+
+#ifdef CONFIG_PREEMPT_RT
+	/* Allocate some extra buffers in order to prepare for softirq preemption. */
+	cpu = cpu >= 4 ? cpu * 2 : cpu + 4;
+#endif
+	while (cpu--) {
+		void *area = vmalloc(CONFIG_KCOV_IRQ_AREA_SIZE * sizeof(unsigned long));
+		unsigned long flags;
 
-	for_each_possible_cpu(cpu) {
-		void *area = vmalloc_node(CONFIG_KCOV_IRQ_AREA_SIZE *
-				sizeof(unsigned long), cpu_to_node(cpu));
 		if (!area)
 			return -ENOMEM;
-		per_cpu_ptr(&kcov_percpu_data, cpu)->irq_area = area;
+		spin_lock_irqsave(&kcov_remote_lock, flags);
+		kcov_remote_area_put(area, CONFIG_KCOV_IRQ_AREA_SIZE, true);
+		spin_unlock_irqrestore(&kcov_remote_lock, flags);
 	}
 
 	/*
diff --git a/kernel/sched/wait.c b/kernel/sched/wait.c
index 20f27e2cf7ae..d033f600f48c 100644
--- a/kernel/sched/wait.c
+++ b/kernel/sched/wait.c
@@ -5,6 +5,7 @@
  * (C) 2004 Nadia Yvette Chambers, Oracle
  */
 #include "sched.h"
+#include <linux/wait_bit.h>
 
 void __init_waitqueue_head(struct wait_queue_head *wq_head, const char *name, struct lock_class_key *key)
 {
@@ -463,3 +464,17 @@ int woken_wake_function(struct wait_queue_entry *wq_entry, unsigned mode, int sy
 	return default_wake_function(wq_entry, mode, sync, key);
 }
 EXPORT_SYMBOL(woken_wake_function);
+
+int woken_wake_bit_function(struct wait_queue_entry *wq_entry, unsigned mode, int sync, void *arg)
+{
+	struct wait_bit_key *key = __var_wake_key(wq_entry, arg);
+	if (!key)
+		return 0;
+
+	/* Pairs with the smp_store_mb() in wait_woken(). */
+	smp_mb(); /* C */
+	wq_entry->flags |= WQ_FLAG_WOKEN;
+
+	return default_wake_function(wq_entry, mode, sync, key);
+}
+EXPORT_SYMBOL(woken_wake_bit_function);
diff --git a/kernel/sched/wait_bit.c b/kernel/sched/wait_bit.c
index 1088d3b7012c..348f7211b4aa 100644
--- a/kernel/sched/wait_bit.c
+++ b/kernel/sched/wait_bit.c
@@ -167,9 +167,7 @@ wait_queue_head_t *__var_waitqueue(void *p)
 }
 EXPORT_SYMBOL(__var_waitqueue);
 
-static int
-var_wake_function(struct wait_queue_entry *wq_entry, unsigned int mode,
-		  int sync, void *arg)
+struct wait_bit_key *__var_wake_key(struct wait_queue_entry *wq_entry, void *arg)
 {
 	struct wait_bit_key *key = arg;
 	struct wait_bit_queue_entry *wbq_entry =
@@ -177,6 +175,16 @@ var_wake_function(struct wait_queue_entry *wq_entry, unsigned int mode,
 
 	if (wbq_entry->key.flags != key->flags ||
 	    wbq_entry->key.bit_nr != key->bit_nr)
+		return NULL;
+
+	return key;
+}
+
+static int var_wake_function(struct wait_queue_entry *wq_entry, unsigned int mode,
+			     int sync, void *arg)
+{
+	struct wait_bit_key *key = __var_wake_key(wq_entry, arg);
+	if (!key)
 		return 0;
 
 	return autoremove_wake_function(wq_entry, mode, sync, key);
diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
index 040f4e077435..f385a0deb70a 100644
--- a/lib/Kconfig.debug
+++ b/lib/Kconfig.debug
@@ -2247,10 +2247,11 @@ config KCOV_INSTRUMENT_ALL
 config KCOV_IRQ_AREA_SIZE
 	hex "Size of interrupt coverage collection area in words"
 	depends on KCOV
+	range 0x80 0x1000000
 	default 0x40000
 	help
-	  KCOV uses preallocated per-cpu areas to collect coverage from
-	  soft interrupts. This specifies the size of those areas in the
+	  KCOV uses preallocated areas to collect coverage from soft
+	  interrupts. This specifies the size of those areas in the
 	  number of unsigned long words.
 
 config KCOV_SELFTEST
diff --git a/net/bluetooth/hci_event.c b/net/bluetooth/hci_event.c
index 55a2de5c8c8e..5b4c0f61b333 100644
--- a/net/bluetooth/hci_event.c
+++ b/net/bluetooth/hci_event.c
@@ -297,8 +297,10 @@ static u8 hci_cc_reset(struct hci_dev *hdev, void *data, struct sk_buff *skb)
 
 	hdev->ssp_debug_mode = 0;
 
+	hci_dev_lock(hdev);
 	hci_bdaddr_list_clear(&hdev->le_accept_list);
 	hci_bdaddr_list_clear(&hdev->le_resolv_list);
+	hci_dev_unlock(hdev);
 
 	return rp->status;
 }
@@ -3830,8 +3832,10 @@ static u8 hci_cc_le_set_cig_params(struct hci_dev *hdev, void *data,
 	bt_dev_dbg(hdev, "status 0x%2.2x", rp->status);
 
 	cp = hci_sent_cmd_data(hdev, HCI_OP_LE_SET_CIG_PARAMS);
-	if (!rp->status && (!cp || rp->num_handles != cp->num_cis ||
-			    rp->cig_id != cp->cig_id)) {
+	if (!rp->status &&
+	    (!cp || rp->num_handles != cp->num_cis ||
+	     rp->cig_id != cp->cig_id ||
+	     skb->len < array_size(rp->num_handles, sizeof(*rp->handle)))) {
 		bt_dev_err(hdev, "unexpected Set CIG Parameters response data");
 		status = HCI_ERROR_UNSPECIFIED;
 	}
diff --git a/net/bluetooth/hci_sync.c b/net/bluetooth/hci_sync.c
index 41f90d758cd9..e39119bfef64 100644
--- a/net/bluetooth/hci_sync.c
+++ b/net/bluetooth/hci_sync.c
@@ -6291,6 +6291,8 @@ static int hci_pause_discovery_sync(struct hci_dev *hdev)
 static int hci_update_event_filter_sync(struct hci_dev *hdev)
 {
 	struct bdaddr_list_with_flags *b;
+	bdaddr_t *accept_list;
+	size_t i, num_entries = 0;
 	u8 scan = SCAN_DISABLED;
 	bool scanning = test_bit(HCI_PSCAN, &hdev->flags);
 	int err;
@@ -6307,23 +6309,49 @@ static int hci_update_event_filter_sync(struct hci_dev *hdev)
 	/* Always clear event filter when starting */
 	hci_clear_event_filter_sync(hdev);
 
-	list_for_each_entry(b, &hdev->accept_list, list) {
-		if (!(b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP))
-			continue;
+	hci_dev_lock(hdev);
+
+	list_for_each_entry(b, &hdev->accept_list, list)
+		if (b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)
+			num_entries++;
+
+	if (!num_entries) {
+		hci_dev_unlock(hdev);
+		goto update_scan;
+	}
+
+	accept_list = kmalloc_array(num_entries, sizeof(*accept_list),
+				    GFP_KERNEL);
+	if (!accept_list) {
+		hci_dev_unlock(hdev);
+		return -ENOMEM;
+	}
+
+	i = 0;
+	list_for_each_entry(b, &hdev->accept_list, list)
+		if (b->flags & HCI_CONN_FLAG_REMOTE_WAKEUP)
+			bacpy(&accept_list[i++], &b->bdaddr);
+
+	hci_dev_unlock(hdev);
 
-		bt_dev_dbg(hdev, "Adding event filters for %pMR", &b->bdaddr);
+	for (i = 0; i < num_entries; i++) {
+		bt_dev_dbg(hdev, "Adding event filters for %pMR",
+			   &accept_list[i]);
 
-		err =  hci_set_event_filter_sync(hdev, HCI_FLT_CONN_SETUP,
-						 HCI_CONN_SETUP_ALLOW_BDADDR,
-						 &b->bdaddr,
-						 HCI_CONN_SETUP_AUTO_ON);
+		err = hci_set_event_filter_sync(hdev, HCI_FLT_CONN_SETUP,
+						HCI_CONN_SETUP_ALLOW_BDADDR,
+					 &accept_list[i],
+					 HCI_CONN_SETUP_AUTO_ON);
 		if (err)
 			bt_dev_err(hdev, "Failed to set event filter for %pMR",
-				   &b->bdaddr);
+				   &accept_list[i]);
 		else
 			scan = SCAN_PAGE;
 	}
 
+	kfree(accept_list);
+
+update_scan:
 	if (scan && !scanning)
 		hci_write_scan_enable_sync(hdev, scan);
 	else if (!scan && scanning)
diff --git a/net/bluetooth/iso.c b/net/bluetooth/iso.c
index f946ef5f37b3..bf8cedeeede5 100644
--- a/net/bluetooth/iso.c
+++ b/net/bluetooth/iso.c
@@ -1535,6 +1535,7 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 
 	lock_sock(sk);
 
+	memset(sa, 0, sizeof(struct sockaddr_iso));
 	addr->sa_family = AF_BLUETOOTH;
 
 	if (peer) {
@@ -1545,6 +1546,7 @@ static int iso_sock_getname(struct socket *sock, struct sockaddr *addr,
 		sa->iso_bdaddr_type = iso_pi(sk)->dst_type;
 
 		if (hcon && (hcon->type == BIS_LINK || hcon->type == PA_LINK)) {
+			memset(sa->iso_bc, 0, sizeof(struct sockaddr_iso_bc));
 			sa->iso_bc->bc_sid = iso_pi(sk)->bc_sid;
 			sa->iso_bc->bc_num_bis = iso_pi(sk)->bc_num_bis;
 			memcpy(sa->iso_bc->bc_bis, iso_pi(sk)->bc_bis,
@@ -1657,9 +1659,9 @@ static void iso_conn_defer_accept(struct hci_conn *conn)
 	hci_send_cmd(hdev, HCI_OP_LE_ACCEPT_CIS, sizeof(cp), &cp);
 }
 
-static void iso_conn_big_sync(struct sock *sk)
+static int iso_conn_big_sync(struct sock *sk)
 {
-	int err;
+	int err = 0;
 	struct hci_dev *hdev;
 	struct iso_conn *conn;
 	bdaddr_t src, dst;
@@ -1674,7 +1676,7 @@ static void iso_conn_big_sync(struct sock *sk)
 	hdev = hci_get_route(&dst, &src, src_type);
 
 	if (!hdev)
-		return;
+		return -EHOSTUNREACH;
 
 	/* hci_le_big_create_sync requires hdev lock to be held, since
 	 * it enqueues the HCI LE BIG Create Sync command via
@@ -1690,8 +1692,10 @@ static void iso_conn_big_sync(struct sock *sk)
 	 * both before dereferencing conn->hcon.
 	 */
 	conn = iso_pi(sk)->conn;
-	if (!conn || !conn->hcon)
+	if (!conn || !conn->hcon) {
+		err = -ENOTCONN;
 		goto unlock;
+	}
 
 	if (!test_and_set_bit(BT_SK_BIG_SYNC, &iso_pi(sk)->flags)) {
 		err = hci_conn_big_create_sync(hdev, conn->hcon,
@@ -1707,6 +1711,8 @@ static void iso_conn_big_sync(struct sock *sk)
 	release_sock(sk);
 	hci_dev_unlock(hdev);
 	hci_dev_put(hdev);
+
+	return err;
 }
 
 static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
@@ -1731,10 +1737,19 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		case BT_CONNECT2:
 			if (test_bit(BT_SK_PA_SYNC, &pi->flags)) {
 				release_sock(sk);
-				iso_conn_big_sync(sk);
+				err = iso_conn_big_sync(sk);
 				lock_sock(sk);
 
-				sk->sk_state = BT_LISTEN;
+				/* The socket lock was dropped, so the
+				 * connection may have been torn down
+				 * meanwhile and iso_chan_del() may have
+				 * already moved the socket to BT_CLOSED.
+				 * Only move on to BT_LISTEN if the BIG sync
+				 * was actually started and nothing else has
+				 * changed the state.
+				 */
+				if (!err && sk->sk_state == BT_CONNECT2)
+					sk->sk_state = BT_LISTEN;
 			} else {
 				iso_conn_defer_accept(pi->conn->hcon);
 				sk->sk_state = BT_CONFIG;
@@ -1745,10 +1760,11 @@ static int iso_sock_recvmsg(struct socket *sock, struct msghdr *msg,
 		case BT_CONNECTED:
 			if (test_bit(BT_SK_PA_SYNC, &iso_pi(sk)->flags)) {
 				release_sock(sk);
-				iso_conn_big_sync(sk);
+				err = iso_conn_big_sync(sk);
 				lock_sock(sk);
 
-				sk->sk_state = BT_LISTEN;
+				if (!err && sk->sk_state == BT_CONNECTED)
+					sk->sk_state = BT_LISTEN;
 				early_ret = true;
 			}
 
diff --git a/net/bluetooth/mgmt.c b/net/bluetooth/mgmt.c
index 338005d56565..6840760622ac 100644
--- a/net/bluetooth/mgmt.c
+++ b/net/bluetooth/mgmt.c
@@ -2671,6 +2671,14 @@ static int mgmt_hci_cmd_sync(struct sock *sk, struct hci_dev *hdev,
 		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_HCI_CMD_SYNC,
 				       MGMT_STATUS_INVALID_PARAMS);
 
+	/* The HCI command header carries the parameter length in a u8, a
+	 * larger value would be truncated there while the parameters are
+	 * still appended to the frame in full.
+	 */
+	if (le16_to_cpu(cp->params_len) > U8_MAX)
+		return mgmt_cmd_status(sk, hdev->id, MGMT_OP_HCI_CMD_SYNC,
+				       MGMT_STATUS_INVALID_PARAMS);
+
 	hci_dev_lock(hdev);
 	cmd = mgmt_pending_new(sk, MGMT_OP_HCI_CMD_SYNC, hdev, data, len);
 	if (!cmd)
diff --git a/net/bluetooth/rfcomm/core.c b/net/bluetooth/rfcomm/core.c
index 7f7bab2728cb..f8310433c054 100644
--- a/net/bluetooth/rfcomm/core.c
+++ b/net/bluetooth/rfcomm/core.c
@@ -1334,7 +1334,10 @@ static struct rfcomm_session *rfcomm_recv_disc(struct rfcomm_session *s,
 	return s;
 }
 
-void rfcomm_dlc_accept(struct rfcomm_dlc *d)
+/* Must be called with rfcomm_mutex held, so that the session cannot be
+ * unlinked from under us.
+ */
+static void __rfcomm_dlc_accept(struct rfcomm_dlc *d)
 {
 	struct sock *sk = d->session->sock->sk;
 	struct l2cap_conn *conn = l2cap_pi(sk)->chan->conn;
@@ -1356,6 +1359,21 @@ void rfcomm_dlc_accept(struct rfcomm_dlc *d)
 	rfcomm_send_msc(d->session, 1, d->dlci, d->v24_sig);
 }
 
+void rfcomm_dlc_accept(struct rfcomm_dlc *d)
+{
+	rfcomm_lock();
+
+	/* rfcomm_recv_disc() sets the dlc state to BT_CLOSED before calling
+	 * __rfcomm_dlc_close(), so the RFCOMM_DEFER_SETUP handshake there is
+	 * skipped and the session can already be unlinked by the time the
+	 * deferred accept runs from rfcomm_sock_recvmsg().
+	 */
+	if (d->session)
+		__rfcomm_dlc_accept(d);
+
+	rfcomm_unlock();
+}
+
 static void rfcomm_check_accept(struct rfcomm_dlc *d)
 {
 	if (rfcomm_check_security(d)) {
@@ -1368,7 +1386,7 @@ static void rfcomm_check_accept(struct rfcomm_dlc *d)
 			d->state_change(d, 0);
 			rfcomm_dlc_unlock(d);
 		} else
-			rfcomm_dlc_accept(d);
+			__rfcomm_dlc_accept(d);
 	} else {
 		set_bit(RFCOMM_AUTH_PENDING, &d->flags);
 		rfcomm_dlc_set_timer(d, RFCOMM_AUTH_TIMEOUT);
@@ -1956,7 +1974,7 @@ static void rfcomm_process_dlcs(struct rfcomm_session *s)
 					d->state_change(d, 0);
 					rfcomm_dlc_unlock(d);
 				} else
-					rfcomm_dlc_accept(d);
+					__rfcomm_dlc_accept(d);
 			}
 			continue;
 		} else if (test_and_clear_bit(RFCOMM_AUTH_REJECT, &d->flags)) {
diff --git a/net/ipv4/ip_output.c b/net/ipv4/ip_output.c
index ec790bad1679..dcffa5d92884 100644
--- a/net/ipv4/ip_output.c
+++ b/net/ipv4/ip_output.c
@@ -791,6 +791,10 @@ int ip_do_fragment(struct net *net, struct sock *sk, struct sk_buff *skb,
 	 */
 
 	hlen = iph->ihl * 4;
+	if (mtu < hlen + 8) {
+		err = -EMSGSIZE;
+		goto fail;
+	}
 	mtu = mtu - hlen;	/* Size of data space */
 	IPCB(skb)->flags |= IPSKB_FRAG_COMPLETE;
 	ll_rs = LL_RESERVED_SPACE(rt->dst.dev);
diff --git a/net/ipv6/ip6_output.c b/net/ipv6/ip6_output.c
index 634f581e1711..9bbd331d634d 100644
--- a/net/ipv6/ip6_output.c
+++ b/net/ipv6/ip6_output.c
@@ -116,6 +116,8 @@ static int ip6_finish_output2(struct net *net, struct sock *sk, struct sk_buff *
 
 		if (res != LWTUNNEL_XMIT_CONTINUE)
 			return res;
+		hdr = ipv6_hdr(skb);
+		daddr = &hdr->daddr;
 	}
 
 	IP6_UPD_PO_STATS(net, idev, IPSTATS_MIB_OUT, skb->len);
diff --git a/net/mptcp/options.c b/net/mptcp/options.c
index 6c8b214e7659..36517ab14d41 100644
--- a/net/mptcp/options.c
+++ b/net/mptcp/options.c
@@ -1261,7 +1261,7 @@ bool mptcp_incoming_options(struct sock *sk, struct sk_buff *skb)
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ADDADDR);
 			} else {
 				mptcp_pm_add_addr_echoed(msk, &mp_opt.addr);
-				mptcp_pm_del_add_timer(msk, &mp_opt.addr, true);
+				mptcp_pm_announced_del_timer(msk, &mp_opt.addr, true);
 				MPTCP_INC_STATS(sock_net(sk), MPTCP_MIB_ECHOADD);
 			}
 
diff --git a/net/mptcp/pm.c b/net/mptcp/pm.c
index c5f95c251fbf..6273dd075d36 100644
--- a/net/mptcp/pm.c
+++ b/net/mptcp/pm.c
@@ -12,7 +12,7 @@
 
 #define ADD_ADDR_RETRANS_MAX	3
 
-struct mptcp_pm_add_entry {
+struct mptcp_pm_add_addr {
 	struct list_head	list;
 	struct mptcp_addr_info	addr;
 	u8			retrans_times;
@@ -133,11 +133,11 @@ bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 	return false;
 }
 
-static struct mptcp_pm_add_entry *
-mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
-				const struct mptcp_addr_info *addr)
+static struct mptcp_pm_add_addr *
+mptcp_pm_announced_lookup(const struct mptcp_sock *msk,
+			  const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 
 	lockdep_assert_held(&msk->pm.lock);
 
@@ -149,26 +149,26 @@ mptcp_lookup_anno_list_by_saddr(const struct mptcp_sock *msk,
 	return NULL;
 }
 
-bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *addr)
+bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 	bool ret;
 
-	entry = mptcp_pm_del_add_timer(msk, addr, false);
+	entry = mptcp_pm_announced_del_timer(msk, addr, false);
 	ret = entry;
 	kfree_rcu(entry, rcu);
 
 	return ret;
 }
 
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk)
+bool mptcp_pm_announced_has_ssk(struct mptcp_sock *msk, const struct sock *ssk)
 {
-	struct mptcp_pm_add_entry *entry;
+	struct mptcp_pm_add_addr *entry;
 	struct mptcp_addr_info saddr;
 	bool ret = false;
 
-	mptcp_local_address((struct sock_common *)sk, &saddr);
+	mptcp_local_address((struct sock_common *)ssk, &saddr);
 
 	spin_lock_bh(&msk->pm.lock);
 	list_for_each_entry(entry, &msk->pm.anno_list, list) {
@@ -340,8 +340,8 @@ static unsigned int mptcp_adjust_add_addr_timeout(struct mptcp_sock *msk)
 
 static void mptcp_pm_add_timer(struct timer_list *timer)
 {
-	struct mptcp_pm_add_entry *entry = timer_container_of(entry, timer,
-							      add_timer);
+	struct mptcp_pm_add_addr *entry = timer_container_of(entry, timer,
+							     add_timer);
 	struct mptcp_sock *msk = entry->sock;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout = 0;
@@ -365,7 +365,7 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 
 	spin_lock_bh(&msk->pm.lock);
 
-	/* The cancel path (mptcp_pm_del_add_timer()) can race with this
+	/* The cancel path (mptcp_pm_announced_del_timer()) can race with this
 	 * callback. Once cancel updates retrans_times to MAX, suppress further
 	 * retransmissions here. If this callback acquires pm.lock first, one
 	 * final transmit attempt is still possible.
@@ -399,18 +399,18 @@ static void mptcp_pm_add_timer(struct timer_list *timer)
 	sock_put(sk);
 }
 
-struct mptcp_pm_add_entry *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id)
+struct mptcp_pm_add_addr *
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id)
 {
-	struct mptcp_pm_add_entry *entry;
 	struct sock *sk = (struct sock *)msk;
+	struct mptcp_pm_add_addr *entry;
 	bool stop_timer = false;
 
 	rcu_read_lock();
 
 	spin_lock_bh(&msk->pm.lock);
-	entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	entry = mptcp_pm_announced_lookup(msk, addr);
 	if (entry && (!check_id || entry->addr.id == addr->id)) {
 		entry->retrans_times = ADD_ADDR_RETRANS_MAX;
 		stop_timer = true;
@@ -433,17 +433,19 @@ mptcp_pm_del_add_timer(struct mptcp_sock *msk,
 	return entry;
 }
 
-bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr)
 {
-	struct mptcp_pm_add_entry *add_entry = NULL;
+	struct mptcp_pm_add_addr *add_entry = NULL;
 	struct sock *sk = (struct sock *)msk;
 	unsigned int timeout;
 
 	lockdep_assert_held(&msk->pm.lock);
 
-	add_entry = mptcp_lookup_anno_list_by_saddr(msk, addr);
+	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING))
+		return false;
 
+	add_entry = mptcp_pm_announced_lookup(msk, addr);
 	if (add_entry) {
 		if (WARN_ON_ONCE(mptcp_pm_is_kernel(msk)))
 			return false;
@@ -471,9 +473,9 @@ bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
 	return true;
 }
 
-static void mptcp_pm_free_anno_list(struct mptcp_sock *msk)
+static void mptcp_pm_free_announced_list(struct mptcp_sock *msk)
 {
-	struct mptcp_pm_add_entry *entry, *tmp;
+	struct mptcp_pm_add_addr *entry, *tmp;
 	struct sock *sk = (struct sock *)msk;
 	LIST_HEAD(free_list);
 
@@ -740,7 +742,7 @@ void mptcp_pm_add_addr_echoed(struct mptcp_sock *msk,
 
 	spin_lock_bh(&pm->lock);
 
-	if (mptcp_lookup_anno_list_by_saddr(msk, addr) && READ_ONCE(pm->work_pending))
+	if (mptcp_pm_announced_lookup(msk, addr) && READ_ONCE(pm->work_pending))
 		mptcp_pm_schedule_work(msk, MPTCP_PM_SUBFLOW_ESTABLISHED);
 
 	spin_unlock_bh(&pm->lock);
@@ -949,7 +951,7 @@ bool mptcp_pm_add_addr_signal(struct mptcp_sock *msk, unsigned int opt_size,
 	 * let the PM state machine progress.
 	 */
 	if (skip_add_addr) {
-		mptcp_pm_del_add_timer(msk, addr, true);
+		mptcp_pm_announced_del_timer(msk, addr, true);
 		mptcp_pm_subflow_established(msk);
 	}
 	return ret;
@@ -1104,10 +1106,16 @@ void mptcp_pm_worker(struct mptcp_sock *msk)
 
 void mptcp_pm_destroy(struct mptcp_sock *msk)
 {
-	mptcp_pm_free_anno_list(msk);
+	spin_lock_bh(&msk->pm.lock);
+	msk->pm.status |= BIT(MPTCP_PM_DESTROYING);
+	spin_unlock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_is_userspace(msk))
-		mptcp_userspace_pm_free_local_addr_list(msk);
+	mptcp_pm_free_announced_list(msk);
+
+	/* Free the userspace local address list unconditionally: the socket
+	 * can be reused (mptcp_disconnect()) and re-selected to a different PM
+	 */
+	mptcp_userspace_pm_free_local_addr_list(msk);
 }
 
 void mptcp_pm_data_reset(struct mptcp_sock *msk)
diff --git a/net/mptcp/pm_kernel.c b/net/mptcp/pm_kernel.c
index fc818b63752e..0c5f8d3e35a5 100644
--- a/net/mptcp/pm_kernel.c
+++ b/net/mptcp/pm_kernel.c
@@ -370,7 +370,7 @@ static void mptcp_pm_create_subflow_or_signal_addr(struct mptcp_sock *msk)
 		/* If the alloc fails, we are on memory pressure, not worth
 		 * continuing, and trying to create subflows.
 		 */
-		if (!mptcp_pm_alloc_anno_list(msk, &local.addr))
+		if (!mptcp_pm_announced_alloc(msk, &local.addr))
 			return;
 
 		__clear_bit(endp_id, msk->pm.id_avail_bitmap);
@@ -1042,7 +1042,7 @@ int mptcp_pm_nl_add_addr_doit(struct sk_buff *skb, struct genl_info *info)
 	return ret;
 }
 
-static void mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
+static void mptcp_pm_remove_announced(struct mptcp_sock *msk,
 				      const struct mptcp_addr_info *addr,
 				      bool force)
 {
@@ -1051,7 +1051,7 @@ static void mptcp_pm_remove_anno_addr(struct mptcp_sock *msk,
 
 	list.ids[list.nr++] = mptcp_endp_get_local_id(msk, addr);
 
-	announced = mptcp_remove_anno_list_by_saddr(msk, addr);
+	announced = mptcp_pm_announced_remove(msk, addr);
 	if (announced || force) {
 		spin_lock_bh(&msk->pm.lock);
 		if (announced)
@@ -1088,7 +1088,7 @@ static int mptcp_nl_remove_subflow_and_signal_addr(struct net *net,
 
 		lock_sock(sk);
 		remove_subflow = mptcp_lookup_subflow_by_saddr(&msk->conn_list, addr);
-		mptcp_pm_remove_anno_addr(msk, addr, remove_subflow &&
+		mptcp_pm_remove_announced(msk, addr, remove_subflow &&
 					  !(entry->flags & MPTCP_PM_ADDR_FLAG_IMPLICIT));
 
 		list.ids[0] = mptcp_endp_get_local_id(msk, addr);
@@ -1223,7 +1223,7 @@ static void mptcp_pm_flush_addrs_and_subflows(struct mptcp_sock *msk,
 			slist.ids[slist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 
 		if (alist.nr < MPTCP_RM_IDS_MAX &&
-		    mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+		    mptcp_pm_announced_remove(msk, &entry->addr))
 			alist.ids[alist.nr++] = mptcp_endp_get_local_id(msk, &entry->addr);
 	}
 
diff --git a/net/mptcp/pm_userspace.c b/net/mptcp/pm_userspace.c
index db5693262c8c..24d3a91fd68a 100644
--- a/net/mptcp/pm_userspace.c
+++ b/net/mptcp/pm_userspace.c
@@ -54,6 +54,10 @@ static int mptcp_userspace_pm_append_new_local_addr(struct mptcp_sock *msk,
 	bitmap_zero(id_bitmap, MPTCP_PM_MAX_ADDR_ID + 1);
 
 	spin_lock_bh(&msk->pm.lock);
+	if (msk->pm.status & BIT(MPTCP_PM_DESTROYING)) {
+		ret = -EINVAL;
+		goto append_err;
+	}
 	mptcp_for_each_userspace_pm_addr(msk, e) {
 		addr_match = mptcp_addresses_equal(&e->addr, &entry->addr, true);
 		if (addr_match && entry->addr.id == 0 && needs_id)
@@ -231,7 +235,7 @@ int mptcp_pm_nl_announce_doit(struct sk_buff *skb, struct genl_info *info)
 	lock_sock(sk);
 	spin_lock_bh(&msk->pm.lock);
 
-	if (mptcp_pm_alloc_anno_list(msk, &addr_val.addr)) {
+	if (mptcp_pm_announced_alloc(msk, &addr_val.addr)) {
 		msk->pm.add_addr_signaled++;
 		mptcp_pm_announce_addr(msk, &addr_val.addr, false);
 		mptcp_pm_addr_send_ack(msk);
@@ -284,7 +288,7 @@ void mptcp_pm_remove_addr_entry(struct mptcp_sock *msk,
 	int anno_nr = 0;
 
 	/* only delete if either announced or matching a subflow */
-	if (mptcp_remove_anno_list_by_saddr(msk, &entry->addr))
+	if (mptcp_pm_announced_remove(msk, &entry->addr))
 		anno_nr++;
 	else if (!mptcp_lookup_subflow_by_saddr(&msk->conn_list, &entry->addr))
 		return;
diff --git a/net/mptcp/protocol.h b/net/mptcp/protocol.h
index 352d5771de0b..c89be36cd3e8 100644
--- a/net/mptcp/protocol.h
+++ b/net/mptcp/protocol.h
@@ -190,9 +190,10 @@ enum mptcp_pm_status {
 	MPTCP_PM_ESTABLISHED,
 	MPTCP_PM_SUBFLOW_ESTABLISHED,
 	MPTCP_PM_ALREADY_ESTABLISHED,	/* persistent status, set after ESTABLISHED event */
-	MPTCP_PM_MPC_ENDPOINT_ACCOUNTED /* persistent status, set after MPC local address is
-					 * accounted int id_avail_bitmap
-					 */
+	MPTCP_PM_MPC_ENDPOINT_ACCOUNTED, /* persistent status, set after MPC local address is
+					  * accounted int id_avail_bitmap
+					  */
+	MPTCP_PM_DESTROYING,		/* To fence out PM list allocs */
 };
 
 enum mptcp_pm_type {
@@ -1130,16 +1131,16 @@ int mptcp_pm_mp_prio_send_ack(struct mptcp_sock *msk,
 			      struct mptcp_addr_info *addr,
 			      struct mptcp_addr_info *rem,
 			      u8 bkup);
-bool mptcp_pm_alloc_anno_list(struct mptcp_sock *msk,
+bool mptcp_pm_announced_alloc(struct mptcp_sock *msk,
 			      const struct mptcp_addr_info *addr);
-bool mptcp_pm_sport_in_anno_list(struct mptcp_sock *msk, const struct sock *sk);
-struct mptcp_pm_add_entry *
-mptcp_pm_del_add_timer(struct mptcp_sock *msk,
-		       const struct mptcp_addr_info *addr, bool check_id);
+struct mptcp_pm_add_addr *
+mptcp_pm_announced_del_timer(struct mptcp_sock *msk,
+			     const struct mptcp_addr_info *addr, bool check_id);
+bool mptcp_pm_announced_remove(struct mptcp_sock *msk,
+			       const struct mptcp_addr_info *addr);
+bool mptcp_pm_announced_has_ssk(struct mptcp_sock *msk, const struct sock *ssk);
 bool mptcp_lookup_subflow_by_saddr(const struct list_head *list,
 				   const struct mptcp_addr_info *saddr);
-bool mptcp_remove_anno_list_by_saddr(struct mptcp_sock *msk,
-				     const struct mptcp_addr_info *addr);
 int mptcp_pm_nl_set_flags(struct mptcp_pm_addr_entry *local,
 			  struct genl_info *info);
 int mptcp_userspace_pm_set_flags(struct mptcp_pm_addr_entry *local,
diff --git a/net/mptcp/subflow.c b/net/mptcp/subflow.c
index d562e149606f..8e386899ceb9 100644
--- a/net/mptcp/subflow.c
+++ b/net/mptcp/subflow.c
@@ -235,7 +235,7 @@ static int subflow_check_req(struct request_sock *req,
 			pr_debug("syn inet_sport=%d %d\n",
 				 ntohs(inet_sk(sk_listener)->inet_sport),
 				 ntohs(inet_sk((struct sock *)subflow_req->msk)->inet_sport));
-			if (!mptcp_pm_sport_in_anno_list(subflow_req->msk, sk_listener)) {
+			if (!mptcp_pm_announced_has_ssk(subflow_req->msk, sk_listener)) {
 				SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTSYNRX);
 				subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 				return -EPERM;
@@ -926,7 +926,7 @@ static struct sock *subflow_syn_recv_sock(const struct sock *sk,
 				pr_debug("ack inet_sport=%d %d\n",
 					 ntohs(inet_sk(sk)->inet_sport),
 					 ntohs(inet_sk((struct sock *)owner)->inet_sport));
-				if (!mptcp_pm_sport_in_anno_list(owner, sk)) {
+				if (!mptcp_pm_announced_has_ssk(owner, sk)) {
 					SUBFLOW_REQ_INC_STATS(req, MPTCP_MIB_MISMATCHPORTACKRX);
 					subflow_add_reset_reason(skb, MPTCP_RST_EPROHIBIT);
 					goto dispose_child;
diff --git a/net/nfc/digital_technology.c b/net/nfc/digital_technology.c
index ae63c5eb06fa..ae6487c10a25 100644
--- a/net/nfc/digital_technology.c
+++ b/net/nfc/digital_technology.c
@@ -778,6 +778,8 @@ static void digital_in_recv_sensf_res(struct nfc_digital_dev *ddev, void *arg,
 
 	sensf_res = (struct digital_sensf_res *)resp->data;
 
+	resp->len = min_t(unsigned int, resp->len, NFC_SENSF_RES_MAXSIZE);
+
 	memcpy(target.sensf_res, sensf_res, resp->len);
 	target.sensf_res_len = resp->len;
 
diff --git a/net/nfc/llcp_commands.c b/net/nfc/llcp_commands.c
index 291f26facbf3..ca89fe967d6a 100644
--- a/net/nfc/llcp_commands.c
+++ b/net/nfc/llcp_commands.c
@@ -193,7 +193,8 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 			  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -201,9 +202,15 @@ int nfc_llcp_parse_gb_tlv(struct nfc_llcp_local *local,
 		return -ENODEV;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len)
+			return -EINVAL;
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len)
+			return -EINVAL;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
@@ -243,7 +250,8 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 				  const u8 *tlv_array, u16 tlv_array_len)
 {
 	const u8 *tlv = tlv_array;
-	u8 type, length, offset = 0;
+	u8 type, length;
+	u16 offset = 0;
 
 	pr_debug("TLV array length %d\n", tlv_array_len);
 
@@ -251,9 +259,15 @@ int nfc_llcp_parse_connection_tlv(struct nfc_llcp_sock *sock,
 		return -ENOTCONN;
 
 	while (offset < tlv_array_len) {
+		if (offset + 2 > tlv_array_len)
+			return -EINVAL;
+
 		type = tlv[0];
 		length = tlv[1];
 
+		if (offset + 2 + length > tlv_array_len)
+			return -EINVAL;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		switch (type) {
diff --git a/net/nfc/llcp_core.c b/net/nfc/llcp_core.c
index dc65c719f35f..6ae0d64c17b9 100644
--- a/net/nfc/llcp_core.c
+++ b/net/nfc/llcp_core.c
@@ -849,13 +849,16 @@ static struct nfc_llcp_sock *nfc_llcp_sock_get_sn(struct nfc_llcp_local *local,
 static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 {
 	u8 type, length;
-	const u8 *tlv = &skb->data[2];
-	size_t tlv_array_len = skb->len - LLCP_HEADER_SIZE, offset = 0;
+	const u8 *tlv = &skb->data[LLCP_HEADER_SIZE];
+	const u8 *tlv_end = skb_tail_pointer(skb);
 
-	while (offset < tlv_array_len) {
+	while (tlv + 2 < tlv_end) {
 		type = tlv[0];
 		length = tlv[1];
 
+		if (tlv + 2 + length > tlv_end)
+			break;
+
 		pr_debug("type 0x%x length %d\n", type, length);
 
 		if (type == LLCP_TLV_SN) {
@@ -863,7 +866,6 @@ static const u8 *nfc_llcp_connect_sn(const struct sk_buff *skb, size_t *sn_len)
 			return &tlv[2];
 		}
 
-		offset += length + 2;
 		tlv += length + 2;
 	}
 
@@ -1552,6 +1554,11 @@ static void nfc_llcp_rx_work(struct work_struct *work)
 
 static void __nfc_llcp_recv(struct nfc_llcp_local *local, struct sk_buff *skb)
 {
+	if (!pskb_may_pull(skb, LLCP_HEADER_SIZE)) {
+		kfree_skb(skb);
+		return;
+	}
+
 	local->rx_pending = skb;
 	timer_delete(&local->link_timer);
 	schedule_work(&local->rx_work);
diff --git a/net/nfc/nci/ntf.c b/net/nfc/nci/ntf.c
index c96512bb8653..f5c9a8ab7ec1 100644
--- a/net/nfc/nci/ntf.c
+++ b/net/nfc/nci/ntf.c
@@ -440,7 +440,7 @@ void nci_clear_target_list(struct nci_dev *ndev)
 static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 				      const struct sk_buff *skb)
 {
-	struct nci_rf_discover_ntf ntf;
+	struct nci_rf_discover_ntf ntf = {};
 	const __u8 *data;
 	bool add_target = true;
 
@@ -525,15 +525,19 @@ static int nci_rf_discover_ntf_packet(struct nci_dev *ndev,
 
 static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 						 struct nci_rf_intf_activated_ntf *ntf,
-						 const __u8 *data)
+						 const __u8 *data, __u8 data_len)
 {
 	struct activation_params_nfca_poll_iso_dep *nfca_poll;
 	struct activation_params_nfcb_poll_iso_dep *nfcb_poll;
 
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		nfca_poll = &ntf->activation_params.nfca_poll_iso_dep;
 		nfca_poll->rats_res_len = min_t(__u8, *data++, NFC_ATS_MAXSIZE);
+		data_len--;
+		nfca_poll->rats_res_len = min_t(__u8, nfca_poll->rats_res_len, data_len);
 		pr_debug("rats_res_len %d\n", nfca_poll->rats_res_len);
 		if (nfca_poll->rats_res_len > 0) {
 			memcpy(nfca_poll->rats_res,
@@ -542,8 +546,12 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 		break;
 
 	case NCI_NFC_B_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		nfcb_poll = &ntf->activation_params.nfcb_poll_iso_dep;
 		nfcb_poll->attrib_res_len = min_t(__u8, *data++, 50);
+		data_len--;
+		nfcb_poll->attrib_res_len = min_t(__u8, nfcb_poll->attrib_res_len, data_len);
 		pr_debug("attrib_res_len %d\n", nfcb_poll->attrib_res_len);
 		if (nfcb_poll->attrib_res_len > 0) {
 			memcpy(nfcb_poll->attrib_res,
@@ -562,7 +570,7 @@ static int nci_extract_activation_params_iso_dep(struct nci_dev *ndev,
 
 static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 						 struct nci_rf_intf_activated_ntf *ntf,
-						 const __u8 *data)
+						 const __u8 *data, __u8 data_len)
 {
 	struct activation_params_poll_nfc_dep *poll;
 	struct activation_params_listen_nfc_dep *listen;
@@ -570,9 +578,13 @@ static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 	switch (ntf->activation_rf_tech_and_mode) {
 	case NCI_NFC_A_PASSIVE_POLL_MODE:
 	case NCI_NFC_F_PASSIVE_POLL_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		poll = &ntf->activation_params.poll_nfc_dep;
 		poll->atr_res_len = min_t(__u8, *data++,
 					  NFC_ATR_RES_MAXSIZE - 2);
+		data_len--;
+		poll->atr_res_len = min_t(__u8, poll->atr_res_len, data_len);
 		pr_debug("atr_res_len %d\n", poll->atr_res_len);
 		if (poll->atr_res_len > 0)
 			memcpy(poll->atr_res, data, poll->atr_res_len);
@@ -580,9 +592,13 @@ static int nci_extract_activation_params_nfc_dep(struct nci_dev *ndev,
 
 	case NCI_NFC_A_PASSIVE_LISTEN_MODE:
 	case NCI_NFC_F_PASSIVE_LISTEN_MODE:
+		if (data_len < 1)
+			return NCI_STATUS_RF_PROTOCOL_ERROR;
 		listen = &ntf->activation_params.listen_nfc_dep;
 		listen->atr_req_len = min_t(__u8, *data++,
 					    NFC_ATR_REQ_MAXSIZE - 2);
+		data_len--;
+		listen->atr_req_len = min_t(__u8, listen->atr_req_len, data_len);
 		pr_debug("atr_req_len %d\n", listen->atr_req_len);
 		if (listen->atr_req_len > 0)
 			memcpy(listen->atr_req, data, listen->atr_req_len);
@@ -603,6 +619,12 @@ static void nci_target_auto_activated(struct nci_dev *ndev,
 	struct nfc_target *target;
 	int rc;
 
+	/* This is a new target, check if we've enough room */
+	if (ndev->n_targets == NCI_MAX_DISCOVERED_TARGETS) {
+		pr_debug("not enough room, ignoring new target...\n");
+		return;
+	}
+
 	target = &ndev->targets[ndev->n_targets];
 
 	rc = nci_add_new_protocol(ndev, target, ntf->rf_protocol,
@@ -688,7 +710,7 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 					    const struct sk_buff *skb)
 {
 	struct nci_conn_info *conn_info;
-	struct nci_rf_intf_activated_ntf ntf;
+	struct nci_rf_intf_activated_ntf ntf = {};
 	const __u8 *data;
 	int err = NCI_STATUS_OK;
 
@@ -806,12 +828,14 @@ static int nci_rf_intf_activated_ntf_packet(struct nci_dev *ndev,
 		switch (ntf.rf_interface) {
 		case NCI_RF_INTERFACE_ISO_DEP:
 			err = nci_extract_activation_params_iso_dep(ndev,
-								    &ntf, data);
+								    &ntf, data,
+								    ntf.activation_params_len);
 			break;
 
 		case NCI_RF_INTERFACE_NFC_DEP:
 			err = nci_extract_activation_params_nfc_dep(ndev,
-								    &ntf, data);
+								    &ntf, data,
+								    ntf.activation_params_len);
 			break;
 
 		case NCI_RF_INTERFACE_FRAME:
diff --git a/net/nfc/nci/rsp.c b/net/nfc/nci/rsp.c
index 9eeb862825c5..165aa4115166 100644
--- a/net/nfc/nci/rsp.c
+++ b/net/nfc/nci/rsp.c
@@ -336,6 +336,7 @@ static void nci_core_conn_close_rsp_packet(struct nci_dev *ndev,
 			list_del(&conn_info->list);
 			if (conn_info == ndev->rf_conn_info)
 				ndev->rf_conn_info = NULL;
+			devm_kfree(&ndev->nfc_dev->dev, conn_info->dest_params);
 			devm_kfree(&ndev->nfc_dev->dev, conn_info);
 		}
 	}
diff --git a/sound/drivers/dummy.c b/sound/drivers/dummy.c
index 7283f0f18813..41ceeafce824 100644
--- a/sound/drivers/dummy.c
+++ b/sound/drivers/dummy.c
@@ -1017,6 +1017,12 @@ static int snd_dummy_probe(struct platform_device *devptr)
 	int idx, err;
 	int dev = devptr->id;
 
+	if (dev < 0 || dev >= SNDRV_CARDS) {
+		dev_warn(&devptr->dev,
+			 "Invalid card index %d, using default 0\n", dev);
+		dev = 0;
+	}
+
 	err = snd_devm_card_new(&devptr->dev, index[dev], id[dev], THIS_MODULE,
 				sizeof(struct snd_dummy), &card);
 	if (err < 0)
diff --git a/sound/usb/fcp.c b/sound/usb/fcp.c
index ec1ddfa4d0ce..c9fe3d2102b3 100644
--- a/sound/usb/fcp.c
+++ b/sound/usb/fcp.c
@@ -82,6 +82,7 @@ struct fcp_data {
 	struct mutex mutex;         /* serialise access to the device */
 	struct completion cmd_done; /* wait for command completion */
 	struct file *file;          /* hwdep file */
+	struct urb *urb;            /* FCP notification endpoint */
 
 	struct fcp_notify notify;
 
@@ -190,7 +191,7 @@ static int fcp_usb(struct usb_mixer_interface *mixer, u32 opcode,
 	const int max_retries = 5;
 	int err;
 
-	if (!mixer->urb)
+	if (!private->urb)
 		return -ENODEV;
 
 	struct fcp_usb_packet *req __free(kfree) = NULL;
@@ -305,7 +306,7 @@ static int fcp_reinit(struct usb_mixer_interface *mixer)
 {
 	struct fcp_data *private = mixer->private_data;
 
-	if (mixer->urb)
+	if (private->urb)
 		return 0;
 
 	void *step0_resp __free(kfree) =
@@ -901,13 +902,15 @@ static int fcp_hwdep_init(struct usb_mixer_interface *mixer)
 
 static void fcp_cleanup_urb(struct usb_mixer_interface *mixer)
 {
-	if (!mixer->urb)
+	struct fcp_data *private = mixer->private_data;
+
+	if (!private->urb)
 		return;
 
-	usb_kill_urb(mixer->urb);
-	kfree(mixer->urb->transfer_buffer);
-	usb_free_urb(mixer->urb);
-	mixer->urb = NULL;
+	usb_kill_urb(private->urb);
+	kfree(private->urb->transfer_buffer);
+	usb_free_urb(private->urb);
+	private->urb = NULL;
 }
 
 static void fcp_private_free(struct usb_mixer_interface *mixer)
@@ -978,37 +981,37 @@ static int fcp_init_notify(struct usb_mixer_interface *mixer)
 	int err;
 
 	/* Already set up */
-	if (mixer->urb)
+	if (private->urb)
 		return 0;
 
 	if (usb_pipe_type_check(dev, pipe))
 		return -EINVAL;
 
-	mixer->urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!mixer->urb)
+	private->urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!private->urb)
 		return -ENOMEM;
 
 	transfer_buffer = kmalloc(private->wMaxPacketSize, GFP_KERNEL);
 	if (!transfer_buffer) {
-		usb_free_urb(mixer->urb);
-		mixer->urb = NULL;
+		usb_free_urb(private->urb);
+		private->urb = NULL;
 		return -ENOMEM;
 	}
 
-	usb_fill_int_urb(mixer->urb, dev, pipe,
+	usb_fill_int_urb(private->urb, dev, pipe,
 			 transfer_buffer, private->wMaxPacketSize,
 			 fcp_notify, mixer, private->bInterval);
 
-	init_completion(&private->cmd_done);
+	reinit_completion(&private->cmd_done);
 
-	err = usb_submit_urb(mixer->urb, GFP_KERNEL);
+	err = usb_submit_urb(private->urb, GFP_KERNEL);
 	if (err) {
 		usb_audio_err(mixer->chip,
 			      "%s: usb_submit_urb failed: %d\n",
 			      __func__, err);
 		kfree(transfer_buffer);
-		usb_free_urb(mixer->urb);
-		mixer->urb = NULL;
+		usb_free_urb(private->urb);
+		private->urb = NULL;
 	}
 
 	return err;
@@ -1059,6 +1062,7 @@ static int fcp_init_private(struct usb_mixer_interface *mixer)
 		return -ENOMEM;
 
 	mutex_init(&private->mutex);
+	init_completion(&private->cmd_done);
 	init_waitqueue_head(&private->notify.queue);
 	spin_lock_init(&private->notify.lock);
 
diff --git a/sound/usb/mixer.c b/sound/usb/mixer.c
index 142f5ca7a72d..8c70c203145e 100644
--- a/sound/usb/mixer.c
+++ b/sound/usb/mixer.c
@@ -3935,6 +3935,12 @@ int snd_usb_mixer_resume(struct usb_mixer_interface *mixer)
 	struct usb_mixer_elem_list *list;
 	int id, err;
 
+	if (mixer->private_resume) {
+		err = mixer->private_resume(mixer);
+		if (err < 0)
+			return err;
+	}
+
 	/* restore cached mixer values */
 	for (id = 0; id < MAX_ID_ELEMS; id++) {
 		for_each_mixer_elem(list, mixer, id) {
diff --git a/sound/usb/mixer.h b/sound/usb/mixer.h
index 3fa1bd96f858..037b446d8b6f 100644
--- a/sound/usb/mixer.h
+++ b/sound/usb/mixer.h
@@ -18,6 +18,7 @@ struct usb_mixer_interface {
 	struct usb_host_interface *hostif;
 	struct list_head list;
 	unsigned int ignore_ctl_error;
+	/* UAC2 status interrupt endpoint; owned by mixer.c */
 	struct urb *urb;
 	/* array[MAX_ID_ELEMS], indexed by unit id */
 	struct usb_mixer_elem_list **id_elems;
@@ -42,6 +43,7 @@ struct usb_mixer_interface {
 	void *private_data;
 	void (*private_free)(struct usb_mixer_interface *mixer);
 	void (*private_suspend)(struct usb_mixer_interface *mixer);
+	int (*private_resume)(struct usb_mixer_interface *mixer);
 };
 
 #define MAX_CHANNELS	64	/* max logical channels */
diff --git a/sound/usb/mixer_scarlett2.c b/sound/usb/mixer_scarlett2.c
index d7b8c204110c..ff1f93702053 100644
--- a/sound/usb/mixer_scarlett2.c
+++ b/sound/usb/mixer_scarlett2.c
@@ -1292,6 +1292,7 @@ struct scarlett2_data {
 	struct usb_mixer_interface *mixer;
 	struct mutex usb_mutex; /* prevent sending concurrent USB requests */
 	struct completion cmd_done;
+	struct urb *urb;        /* notification endpoint */
 	struct mutex data_mutex; /* lock access to this data */
 	u8 running;
 	u8 hwdep_in_use;
@@ -8313,13 +8314,70 @@ static void scarlett2_notify(struct urb *urb)
 	}
 }
 
-/*** Cleanup/Suspend Callbacks ***/
+/*** Notification URB and Cleanup/Suspend Callbacks ***/
+
+/* Submit a URB to receive notifications from the device */
+static int scarlett2_init_notify(struct usb_mixer_interface *mixer)
+{
+	struct usb_device *dev = mixer->chip->dev;
+	struct scarlett2_data *private = mixer->private_data;
+	unsigned int pipe = usb_rcvintpipe(dev, private->bEndpointAddress);
+	void *transfer_buffer;
+	int err;
+
+	/* Already set up */
+	if (private->urb)
+		return 0;
+
+	if (usb_pipe_type_check(dev, pipe))
+		return -EINVAL;
+
+	private->urb = usb_alloc_urb(0, GFP_KERNEL);
+	if (!private->urb)
+		return -ENOMEM;
+
+	transfer_buffer = kmalloc(private->wMaxPacketSize, GFP_KERNEL);
+	if (!transfer_buffer) {
+		usb_free_urb(private->urb);
+		private->urb = NULL;
+		return -ENOMEM;
+	}
+
+	usb_fill_int_urb(private->urb, dev, pipe,
+			 transfer_buffer, private->wMaxPacketSize,
+			 scarlett2_notify, mixer, private->bInterval);
+
+	reinit_completion(&private->cmd_done);
+
+	err = usb_submit_urb(private->urb, GFP_KERNEL);
+	if (err) {
+		kfree(transfer_buffer);
+		usb_free_urb(private->urb);
+		private->urb = NULL;
+	}
+
+	return err;
+}
+
+static void scarlett2_cleanup_urb(struct usb_mixer_interface *mixer)
+{
+	struct scarlett2_data *private = mixer->private_data;
+
+	if (!private->urb)
+		return;
+
+	usb_kill_urb(private->urb);
+	kfree(private->urb->transfer_buffer);
+	usb_free_urb(private->urb);
+	private->urb = NULL;
+}
 
 static void scarlett2_private_free(struct usb_mixer_interface *mixer)
 {
 	struct scarlett2_data *private = mixer->private_data;
 
 	cancel_delayed_work_sync(&private->work);
+	scarlett2_cleanup_urb(mixer);
 	kfree(private);
 	mixer->private_data = NULL;
 }
@@ -8330,6 +8388,8 @@ static void scarlett2_private_suspend(struct usb_mixer_interface *mixer)
 
 	if (cancel_delayed_work_sync(&private->work))
 		scarlett2_config_save(private->mixer);
+
+	scarlett2_cleanup_urb(mixer);
 }
 
 /*** Initialisation ***/
@@ -8449,11 +8509,13 @@ static int scarlett2_init_private(struct usb_mixer_interface *mixer,
 
 	mutex_init(&private->usb_mutex);
 	mutex_init(&private->data_mutex);
+	init_completion(&private->cmd_done);
 	INIT_DELAYED_WORK(&private->work, scarlett2_config_save_work);
 
 	mixer->private_data = private;
 	mixer->private_free = scarlett2_private_free;
 	mixer->private_suspend = scarlett2_private_suspend;
+	mixer->private_resume = scarlett2_init_notify;
 
 	private->info = entry->info;
 
@@ -8470,40 +8532,6 @@ static int scarlett2_init_private(struct usb_mixer_interface *mixer,
 	return scarlett2_find_fc_interface(mixer->chip->dev, private);
 }
 
-/* Submit a URB to receive notifications from the device */
-static int scarlett2_init_notify(struct usb_mixer_interface *mixer)
-{
-	struct usb_device *dev = mixer->chip->dev;
-	struct scarlett2_data *private = mixer->private_data;
-	unsigned int pipe = usb_rcvintpipe(dev, private->bEndpointAddress);
-	void *transfer_buffer;
-
-	if (mixer->urb) {
-		usb_audio_err(mixer->chip,
-			      "%s: mixer urb already in use!\n", __func__);
-		return 0;
-	}
-
-	if (usb_pipe_type_check(dev, pipe))
-		return -EINVAL;
-
-	mixer->urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!mixer->urb)
-		return -ENOMEM;
-
-	transfer_buffer = kmalloc(private->wMaxPacketSize, GFP_KERNEL);
-	if (!transfer_buffer)
-		return -ENOMEM;
-
-	usb_fill_int_urb(mixer->urb, dev, pipe,
-			 transfer_buffer, private->wMaxPacketSize,
-			 scarlett2_notify, mixer, private->bInterval);
-
-	init_completion(&private->cmd_done);
-
-	return usb_submit_urb(mixer->urb, GFP_KERNEL);
-}
-
 /* Cargo cult proprietary initialisation sequence */
 static int scarlett2_usb_init(struct usb_mixer_interface *mixer)
 {
