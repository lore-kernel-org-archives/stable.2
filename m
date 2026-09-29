Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7CEB3D5661
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:47:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707629; cv=none; b=m4RsyXAyDiB7f9C6youJgMf/pNzij7hk7+jD1JjnjKS65mp5fBDo+/ZN7xmkKjWkjvjVcfPQVtrdmCLD6amY6gyNvYvNgjDbiHxbw9idlGNoHPHEA7bvwEUldxbV8xT8dmw6XPsEdCVeIQN644oYuwAxnhnaLGXiLyN5aB2kT0w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707629; c=relaxed/simple;
	bh=8tNmGxcs68Qr3786GIH5CEAEsr/l0ECVLSXC5f67yR4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Np66bqzI+N+5nMCJVZayfw+7ftZEYU8z0DYI31MUgr2ZxfQlTwaI4I/WPGwzX0d+z6JUYOqdtyJc2WlyABhbgMRG85FwBx5Qxr1ZoPHsr+pTms3oSbLhQMfCGxtisIdGG1TEHGNMG6QrWraBZgmXg2d938fFNzVy65VSQ52kLcE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K86LF0u8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K86LF0u8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A4861F000FF;
	Tue, 29 Sep 2026 18:47:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707627;
	bh=GLsK9j8oULK7prLTQWprxVfIU8D19hXSQMGm0l+UcSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=K86LF0u8eBIoDsRWrBPOLDuM/l+Kn7btUDCfL1tjINwqNPDqERKUqGiMfy630SuG/
	 H0E25z4DF1jPGWo4NGGvplRaWips31jnhvzDX0Bd1IO/5i7XnsXr2ZYdQAH9yK8PRJ
	 +u0Z156T3Lc5Op3vp8woRylilzRU3QL3jbuH52smySu9NIy8cOY7J19Ep5oJVO948S
	 25KP/MhwK9WpoooXQdpGxOf8dfGaTHx3DvPJJ+E41CCYC898Ib22bdkDvgPCrFQUxL
	 s+5LiHSY9ONMMR7rQn3wJNt15D+rso3kYr51qLn4QhGsoyZoHcWA3v/x5RR+a/ulO2
	 Hk5o86u+8TasQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Rob Clark <robdclark@gmail.com>,
	Emil Velikov <emil.velikov@collabora.com>,
	Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] drm/virtio: Refactor and optimize job submission code path
Date: Tue, 29 Sep 2026 14:47:04 -0400
Message-ID: <20260929184705.522628-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092904-roundness-islamic-e935@gregkh>
References: <2026092904-roundness-islamic-e935@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dmitry Osipenko <dmitry.osipenko@collabora.com>

[ Upstream commit e4812ab8e6b142e1ce19b50fcf744e20ea9adfe3 ]

Move virtio_gpu_execbuffer_ioctl() into separate virtgpu_submit.c file,
refactoring and optimizing the code along the way to ease addition of new
features to the ioctl.

The optimization is done by using optimal ordering of the job's submission
steps, reducing code path from the start of the ioctl to the point of
pushing job to virtio queue. Job's initialization is now performed before
in-fence is awaited and out-fence setup is made after sending out job to
virtio.

Reviewed-by: Rob Clark <robdclark@gmail.com>
Reviewed-by: Emil Velikov <emil.velikov@collabora.com>
Tested-by: Pierre-Eric Pelloux-Prayer <pierre-eric.pelloux-prayer@amd.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patchwork.freedesktop.org/patch/msgid/20230416115237.798604-2-dmitry.osipenko@collabora.com

[6.1 dependency adaptation for 846b3c64fe3e:
Move the existing execbuffer ioctl and fence-event helper into
virtgpu_submit.c without introducing new functions or the upstream submit
helper split. Preserve the conditional fence allocation and explicit-ring
event gating already backported as 98d3e7c5f7575.

Allocate the fence and event after the in-fence wait but before reserving
an output FD, acquiring BO references, copying commands, or locking BOs.
This makes the target's direct -ENOMEM return safe. Rename the ioctl's
local error variable to match the target's patch context. Release the
fence and cancel any pending event on subsequent initialization failures;
keep the existing successful submission reference release and 64-bit
fence-context comparison. Syncobj support is absent from this tree and
is not introduced.

Only the relocation, build wiring, and initialization/cleanup adaptations
are retained; the broader upstream helper and submission-order refactor
is omitted.]

Stable-dep-of: 846b3c64fe3e ("drm/virtio: fix NULL pointer dereference on fence allocation failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/Makefile         |   2 +-
 drivers/gpu/drm/virtio/virtgpu_drv.h    |   4 +
 drivers/gpu/drm/virtio/virtgpu_ioctl.c  | 188 ---------------------
 drivers/gpu/drm/virtio/virtgpu_submit.c | 215 ++++++++++++++++++++++++
 4 files changed, 220 insertions(+), 189 deletions(-)
 create mode 100644 drivers/gpu/drm/virtio/virtgpu_submit.c

diff --git a/drivers/gpu/drm/virtio/Makefile b/drivers/gpu/drm/virtio/Makefile
index b99fa4a73b68e..d2e1788a82270 100644
--- a/drivers/gpu/drm/virtio/Makefile
+++ b/drivers/gpu/drm/virtio/Makefile
@@ -6,6 +6,6 @@
 virtio-gpu-y := virtgpu_drv.o virtgpu_kms.o virtgpu_gem.o virtgpu_vram.o \
 	virtgpu_display.o virtgpu_vq.o \
 	virtgpu_fence.o virtgpu_object.o virtgpu_debugfs.o virtgpu_plane.o \
-	virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o
+	virtgpu_ioctl.o virtgpu_prime.o virtgpu_trace_points.o virtgpu_submit.o
 
 obj-$(CONFIG_DRM_VIRTIO_GPU) += virtio-gpu.o
diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 1dc92ee7fbdb7..abfeed6252685 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -492,4 +492,8 @@ void virtio_gpu_vram_unmap_dma_buf(struct device *dev,
 				   struct sg_table *sgt,
 				   enum dma_data_direction dir);
 
+/* virtgpu_submit.c */
+int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file);
+
 #endif
diff --git a/drivers/gpu/drm/virtio/virtgpu_ioctl.c b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
index bc8c1e9a845fd..b24b11f25197d 100644
--- a/drivers/gpu/drm/virtio/virtgpu_ioctl.c
+++ b/drivers/gpu/drm/virtio/virtgpu_ioctl.c
@@ -38,32 +38,6 @@
 				    VIRTGPU_BLOB_FLAG_USE_SHAREABLE | \
 				    VIRTGPU_BLOB_FLAG_USE_CROSS_DEVICE)
 
-static int virtio_gpu_fence_event_create(struct drm_device *dev,
-					 struct drm_file *file,
-					 struct virtio_gpu_fence *fence,
-					 uint32_t ring_idx)
-{
-	struct virtio_gpu_fence_event *e = NULL;
-	int ret;
-
-	e = kzalloc(sizeof(*e), GFP_KERNEL);
-	if (!e)
-		return -ENOMEM;
-
-	e->event.type = VIRTGPU_EVENT_FENCE_SIGNALED;
-	e->event.length = sizeof(e->event);
-
-	ret = drm_event_reserve_init(dev, file, &e->base, &e->event);
-	if (ret)
-		goto free;
-
-	fence->e = e;
-	return 0;
-free:
-	kfree(e);
-	return ret;
-}
-
 /* Must be called with &virtio_gpu_fpriv.struct_mutex held. */
 static void virtio_gpu_create_context_locked(struct virtio_gpu_device *vgdev,
 					     struct virtio_gpu_fpriv *vfpriv)
@@ -104,168 +78,6 @@ static int virtio_gpu_map_ioctl(struct drm_device *dev, void *data,
 					 &virtio_gpu_map->offset);
 }
 
-/*
- * Usage of execbuffer:
- * Relocations need to take into account the full VIRTIO_GPUDrawable size.
- * However, the command as passed from user space must *not* contain the initial
- * VIRTIO_GPUReleaseInfo struct (first XXX bytes)
- */
-static int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
-				 struct drm_file *file)
-{
-	struct drm_virtgpu_execbuffer *exbuf = data;
-	struct virtio_gpu_device *vgdev = dev->dev_private;
-	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
-	struct virtio_gpu_fence *out_fence;
-	bool drm_fence_event;
-	int ret;
-	uint32_t *bo_handles = NULL;
-	void __user *user_bo_handles = NULL;
-	struct virtio_gpu_object_array *buflist = NULL;
-	struct sync_file *sync_file;
-	int out_fence_fd = -1;
-	void *buf;
-	uint64_t fence_ctx;
-	uint32_t ring_idx;
-
-	fence_ctx = vgdev->fence_drv.context;
-	ring_idx = 0;
-
-	if (vgdev->has_virgl_3d == false)
-		return -ENOSYS;
-
-	if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
-		return -EINVAL;
-
-	if ((exbuf->flags & VIRTGPU_EXECBUF_RING_IDX)) {
-		if (exbuf->ring_idx >= vfpriv->num_rings)
-			return -EINVAL;
-
-		if (!vfpriv->base_fence_ctx)
-			return -EINVAL;
-
-		fence_ctx = vfpriv->base_fence_ctx;
-		ring_idx = exbuf->ring_idx;
-	}
-
-	virtio_gpu_create_context(dev, file);
-	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_IN) {
-		struct dma_fence *in_fence;
-
-		in_fence = sync_file_get_fence(exbuf->fence_fd);
-
-		if (!in_fence)
-			return -EINVAL;
-
-		/*
-		 * Wait if the fence is from a foreign context, or if the fence
-		 * array contains any fence from a foreign context.
-		 */
-		ret = 0;
-		if (!dma_fence_match_context(in_fence, fence_ctx + ring_idx))
-			ret = dma_fence_wait(in_fence, true);
-
-		dma_fence_put(in_fence);
-		if (ret)
-			return ret;
-	}
-
-	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) {
-		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
-		if (out_fence_fd < 0)
-			return out_fence_fd;
-	}
-
-	if (exbuf->num_bo_handles) {
-		bo_handles = kvmalloc_array(exbuf->num_bo_handles,
-					    sizeof(uint32_t), GFP_KERNEL);
-		if (!bo_handles) {
-			ret = -ENOMEM;
-			goto out_unused_fd;
-		}
-
-		user_bo_handles = u64_to_user_ptr(exbuf->bo_handles);
-		if (copy_from_user(bo_handles, user_bo_handles,
-				   exbuf->num_bo_handles * sizeof(uint32_t))) {
-			ret = -EFAULT;
-			goto out_unused_fd;
-		}
-
-		buflist = virtio_gpu_array_from_handles(file, bo_handles,
-							exbuf->num_bo_handles);
-		if (!buflist) {
-			ret = -ENOENT;
-			goto out_unused_fd;
-		}
-		kvfree(bo_handles);
-		bo_handles = NULL;
-	}
-
-	buf = vmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
-	if (IS_ERR(buf)) {
-		ret = PTR_ERR(buf);
-		goto out_unused_fd;
-	}
-
-	if (buflist) {
-		ret = virtio_gpu_array_lock_resv(buflist);
-		if (ret)
-			goto out_memdup;
-	}
-
-	if ((exbuf->flags & VIRTGPU_EXECBUF_RING_IDX) &&
-	    (vfpriv->ring_idx_mask & BIT_ULL(ring_idx)))
-		drm_fence_event = true;
-	else
-		drm_fence_event = false;
-
-	if ((exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) ||
-	    exbuf->num_bo_handles ||
-	    drm_fence_event)
-		out_fence = virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
-	else
-		out_fence = NULL;
-
-	if (drm_fence_event) {
-		ret = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
-		if (ret)
-			goto out_unresv;
-	}
-
-	if (out_fence_fd >= 0) {
-		sync_file = sync_file_create(&out_fence->f);
-		if (!sync_file) {
-			dma_fence_put(&out_fence->f);
-			ret = -ENOMEM;
-			goto out_unresv;
-		}
-
-		exbuf->fence_fd = out_fence_fd;
-		fd_install(out_fence_fd, sync_file->file);
-	}
-
-	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
-			      vfpriv->ctx_id, buflist, out_fence);
-	dma_fence_put(&out_fence->f);
-	virtio_gpu_notify(vgdev);
-	return 0;
-
-out_unresv:
-	if (buflist)
-		virtio_gpu_array_unlock_resv(buflist);
-out_memdup:
-	kvfree(buf);
-out_unused_fd:
-	kvfree(bo_handles);
-	if (buflist)
-		virtio_gpu_array_put_free(buflist);
-
-	if (out_fence_fd >= 0)
-		put_unused_fd(out_fence_fd);
-
-	return ret;
-}
-
 static int virtio_gpu_getparam_ioctl(struct drm_device *dev, void *data,
 				     struct drm_file *file)
 {
diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
new file mode 100644
index 0000000000000..0314602a04c13
--- /dev/null
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -0,0 +1,215 @@
+// SPDX-License-Identifier: MIT
+/*
+ * Copyright (C) 2015 Red Hat, Inc.
+ * All Rights Reserved.
+ *
+ * Authors:
+ *    Dave Airlie
+ *    Alon Levy
+ */
+
+#include <linux/file.h>
+#include <linux/sync_file.h>
+#include <linux/uaccess.h>
+
+#include <drm/drm_file.h>
+#include <drm/virtgpu_drm.h>
+
+#include "virtgpu_drv.h"
+
+static int virtio_gpu_fence_event_create(struct drm_device *dev,
+					 struct drm_file *file,
+					 struct virtio_gpu_fence *fence,
+					 uint32_t ring_idx)
+{
+	struct virtio_gpu_fence_event *e = NULL;
+	int ret;
+
+	e = kzalloc(sizeof(*e), GFP_KERNEL);
+	if (!e)
+		return -ENOMEM;
+
+	e->event.type = VIRTGPU_EVENT_FENCE_SIGNALED;
+	e->event.length = sizeof(e->event);
+
+	ret = drm_event_reserve_init(dev, file, &e->base, &e->event);
+	if (ret)
+		goto free;
+
+	fence->e = e;
+	return 0;
+free:
+	kfree(e);
+	return ret;
+}
+
+/*
+ * Usage of execbuffer:
+ * Relocations need to take into account the full VIRTIO_GPUDrawable size.
+ * However, the command as passed from user space must *not* contain the initial
+ * VIRTIO_GPUReleaseInfo struct (first XXX bytes)
+ */
+int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
+				struct drm_file *file)
+{
+	struct drm_virtgpu_execbuffer *exbuf = data;
+	struct virtio_gpu_device *vgdev = dev->dev_private;
+	struct virtio_gpu_fpriv *vfpriv = file->driver_priv;
+	struct virtio_gpu_fence *out_fence;
+	bool drm_fence_event;
+	int err;
+	uint32_t *bo_handles = NULL;
+	void __user *user_bo_handles = NULL;
+	struct virtio_gpu_object_array *buflist = NULL;
+	struct sync_file *sync_file;
+	int out_fence_fd = -1;
+	void *buf;
+	uint64_t fence_ctx;
+	uint32_t ring_idx;
+
+	fence_ctx = vgdev->fence_drv.context;
+	ring_idx = 0;
+
+	if (vgdev->has_virgl_3d == false)
+		return -ENOSYS;
+
+	if ((exbuf->flags & ~VIRTGPU_EXECBUF_FLAGS))
+		return -EINVAL;
+
+	if ((exbuf->flags & VIRTGPU_EXECBUF_RING_IDX)) {
+		if (exbuf->ring_idx >= vfpriv->num_rings)
+			return -EINVAL;
+
+		if (!vfpriv->base_fence_ctx)
+			return -EINVAL;
+
+		fence_ctx = vfpriv->base_fence_ctx;
+		ring_idx = exbuf->ring_idx;
+	}
+
+	virtio_gpu_create_context(dev, file);
+	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_IN) {
+		struct dma_fence *in_fence;
+
+		in_fence = sync_file_get_fence(exbuf->fence_fd);
+
+		if (!in_fence)
+			return -EINVAL;
+
+		/*
+		 * Wait if the fence is from a foreign context, or if the fence
+		 * array contains any fence from a foreign context.
+		 */
+		err = 0;
+		if (!dma_fence_match_context(in_fence, fence_ctx + ring_idx))
+			err = dma_fence_wait(in_fence, true);
+
+		dma_fence_put(in_fence);
+		if (err)
+			return err;
+	}
+
+	if ((exbuf->flags & VIRTGPU_EXECBUF_RING_IDX) &&
+	    (vfpriv->ring_idx_mask & BIT_ULL(ring_idx)))
+		drm_fence_event = true;
+	else
+		drm_fence_event = false;
+
+	if ((exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) ||
+	    exbuf->num_bo_handles ||
+	    drm_fence_event)
+		out_fence = virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
+	else
+		out_fence = NULL;
+
+	if (drm_fence_event) {
+		err = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
+		if (err)
+			goto out_unused_fd;
+	}
+
+	if (exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) {
+		out_fence_fd = get_unused_fd_flags(O_CLOEXEC);
+		if (out_fence_fd < 0) {
+			err = out_fence_fd;
+			goto out_unused_fd;
+		}
+	}
+
+	if (exbuf->num_bo_handles) {
+		bo_handles = kvmalloc_array(exbuf->num_bo_handles,
+					    sizeof(uint32_t), GFP_KERNEL);
+		if (!bo_handles) {
+			err = -ENOMEM;
+			goto out_unused_fd;
+		}
+
+		user_bo_handles = u64_to_user_ptr(exbuf->bo_handles);
+		if (copy_from_user(bo_handles, user_bo_handles,
+				   exbuf->num_bo_handles * sizeof(uint32_t))) {
+			err = -EFAULT;
+			goto out_unused_fd;
+		}
+
+		buflist = virtio_gpu_array_from_handles(file, bo_handles,
+							exbuf->num_bo_handles);
+		if (!buflist) {
+			err = -ENOENT;
+			goto out_unused_fd;
+		}
+		kvfree(bo_handles);
+		bo_handles = NULL;
+	}
+
+	buf = vmemdup_user(u64_to_user_ptr(exbuf->command), exbuf->size);
+	if (IS_ERR(buf)) {
+		err = PTR_ERR(buf);
+		goto out_unused_fd;
+	}
+
+	if (buflist) {
+		err = virtio_gpu_array_lock_resv(buflist);
+		if (err)
+			goto out_memdup;
+	}
+
+	if (out_fence_fd >= 0) {
+		sync_file = sync_file_create(&out_fence->f);
+		if (!sync_file) {
+			err = -ENOMEM;
+			goto out_unresv;
+		}
+
+		exbuf->fence_fd = out_fence_fd;
+		fd_install(out_fence_fd, sync_file->file);
+	}
+
+	virtio_gpu_cmd_submit(vgdev, buf, exbuf->size,
+			      vfpriv->ctx_id, buflist, out_fence);
+	dma_fence_put(&out_fence->f);
+	virtio_gpu_notify(vgdev);
+	return 0;
+
+out_unresv:
+	if (buflist)
+		virtio_gpu_array_unlock_resv(buflist);
+out_memdup:
+	kvfree(buf);
+out_unused_fd:
+	kvfree(bo_handles);
+	if (buflist)
+		virtio_gpu_array_put_free(buflist);
+
+	if (out_fence_fd >= 0)
+		put_unused_fd(out_fence_fd);
+
+	if (out_fence) {
+		if (out_fence->e) {
+			drm_event_cancel_free(dev, &out_fence->e->base);
+			out_fence->e = NULL;
+		}
+		dma_fence_put(&out_fence->f);
+	}
+
+	return err;
+}
-- 
2.53.0

