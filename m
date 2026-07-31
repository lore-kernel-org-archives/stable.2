Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E892E445AC8
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 15:49:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785513003; cv=none; b=TU3kOXuWOvb13coDkGC1wgGav7N4rdYhuVTGnfjIxnblrmAOBz47OQFzaxNn/2yjKqmzFhEmP7emA+xc5mjQRjulmV5uJ5Q2ECgjPr57b/nGUkqZ9+ZT8kzdEHvf8HZapXXQiYm6V1hbRkd2eXNZ0zapYbzvmL+RZdUkM9KSsCo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785513003; c=relaxed/simple;
	bh=iwxgYjQFQxXn+gO+KiuFamay4chMA+oSnckjqDw67hw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IarU7h/SI0249HCzPMWOoLd503YR0IBtqyVZpVE5jjhSGoRcq+m2dZgYzJPOBzWI5cPKrd/bJ5Xs6LMw9kg5Dl26TjFBPGo9fD+nA+/085eeGIw8BkzJn8guy7gHwmfnMezEcua1lUwMbTIeKCov5JXaBwu8MBuihvTB42GlqdU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AFDzs8XT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AFDzs8XT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E35BE1F00A3D;
	Fri, 31 Jul 2026 15:49:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785512998;
	bh=Xw9UCz5iSAbJ96wxljCUMN3iAV9bwCzFNOpd0NBxb+M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=AFDzs8XTZIfWXKDCnnXNkqk2eOZAt5EfGzalGHhnrU5jMRhIj0Bbb9M3pfm1vNyU3
	 mgsHwg3AZ6rSaY0apEFHQNWpoP8LHyVGq9KIbZHUvzoIhBK1p5C7xpyNfMjSSSTFJF
	 8fyOcSFZNMMbcH90xuEKgK4AV/NKC4Dc8CF6fgW0uG4UMUyalsX8qY5UQRYsPPRkTZ
	 8VH/PrICliHlrW871v43s9WESdfd3F4bxi/HghCBJR1axE1MmLOrRInlhS05AztPIk
	 FbHVIaICw4ioYdm8zVPuhJdbDBSLMsEw8trq1ASlgH/zhQhzdnlzxb2NEXMCo4A6y7
	 BQ1atb1ush+hQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] drm/virtio: use uninterruptible resv lock for plane updates
Date: Fri, 31 Jul 2026 11:49:55 -0400
Message-ID: <20260731154955.602576-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731154955.602576-1-sashal@kernel.org>
References: <2026072937-showplace-silt-1cf7@gregkh>
 <20260731154955.602576-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Deepanshu Kartikey <kartikey406@gmail.com>

[ Upstream commit a48bbcc7ac739e93562d6148c6fa504c2e9f22f8 ]

virtio_gpu_cursor_plane_update() and virtio_gpu_resource_flush() lock
the framebuffer BO's dma_resv via virtio_gpu_array_lock_resv() and
ignore its return value. The function can fail with -EINTR from
dma_resv_lock_interruptible() (signal during lock wait) or with
-ENOMEM from dma_resv_reserve_fences() (fence slot allocation),
leaving the resv lock not held. The queue path then walks the object
array and calls dma_resv_add_fence(), which requires the lock held;
with lockdep enabled this trips dma_resv_assert_held():

  WARNING: drivers/dma-buf/dma-resv.c:296 at dma_resv_add_fence+0x71e/0x840
  Call Trace:
   virtio_gpu_array_add_fence
   virtio_gpu_queue_ctrl_sgs
   virtio_gpu_queue_fenced_ctrl_buffer
   virtio_gpu_cursor_plane_update
   drm_atomic_helper_commit_planes
   drm_atomic_helper_commit_tail
   commit_tail
   drm_atomic_helper_commit
   drm_atomic_commit
   drm_atomic_helper_update_plane
   __setplane_atomic
   drm_mode_cursor_universal
   drm_mode_cursor_common
   drm_mode_cursor_ioctl
   drm_ioctl
   __x64_sys_ioctl

Beyond the WARN, mutating the dma_resv fence list without the lock
races with concurrent readers/writers and can corrupt the list.

Both call sites run inside the .atomic_update plane callback, which
DRM atomic helpers do not allow to fail (by the time it runs, the
commit has been signed off to userspace and there is no clean
rollback path). Moving the lock acquisition to .prepare_fb was
rejected because the broader lock scope deadlocks against other BO
locking paths in the same atomic commit.

Introduce virtio_gpu_lock_one_resv_uninterruptible() that uses
dma_resv_lock() instead of dma_resv_lock_interruptible(). This
eliminates the -EINTR failure mode -- the realistic syzbot trigger
-- without extending the lock hold across the commit. The helper
locks a single BO and rejects nents > 1 with -EINVAL; both fix
sites lock exactly one BO.

Use it from virtio_gpu_cursor_plane_update() and
virtio_gpu_resource_flush(); check the return value to handle the
remaining -ENOMEM case from dma_resv_reserve_fences() by freeing
the objs and skipping the plane update for that frame. The
framebuffer BOs touched here are not shared with other contexts
and lock contention is expected to be brief, so the loss of
signal-interruptibility is acceptable.

Other callers of virtio_gpu_array_lock_resv() (the ioctl paths)
continue to use the interruptible variant.

The bug was reported by syzbot, triggered via fault injection
(fail_nth) on the DRM_IOCTL_MODE_CURSOR path, which forces the
-ENOMEM branch in dma_resv_reserve_fences().

Reported-by: syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=72bd3dd3a5d5f39a0271
Fixes: 5cfd31c5b3a3 ("drm/virtio: fix virtio_gpu_cursor_plane_update().")
Cc: stable@vger.kernel.org
Signed-off-by: Deepanshu Kartikey <kartikey406@gmail.com>
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patch.msgid.link/20260519082247.34470-1-kartikey406@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_drv.h   |  1 +
 drivers/gpu/drm/virtio/virtgpu_gem.c   | 17 +++++++++++++++++
 drivers/gpu/drm/virtio/virtgpu_plane.c | 10 ++++++++--
 3 files changed, 26 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index d4e610a44e12..1e7f16864225 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -288,6 +288,7 @@ virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents
 void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
 			      struct drm_gem_object *obj);
 int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs);
+int virtio_gpu_lock_one_resv_uninterruptible(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
 				struct dma_fence *fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 1820ca6cf673..419e29de5fa3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -234,6 +234,23 @@ int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
 	return ret;
 }
 
+int virtio_gpu_lock_one_resv_uninterruptible(struct virtio_gpu_object_array *objs)
+{
+	int ret;
+
+	if (objs->nents != 1)
+		return -EINVAL;
+
+	dma_resv_lock(objs->objs[0]->resv, NULL);
+
+	ret = dma_resv_reserve_fences(objs->objs[0]->resv, 1);
+	if (ret) {
+		virtio_gpu_array_unlock_resv(objs);
+		return ret;
+	}
+	return 0;
+}
+
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs)
 {
 	if (objs->nents == 1) {
diff --git a/drivers/gpu/drm/virtio/virtgpu_plane.c b/drivers/gpu/drm/virtio/virtgpu_plane.c
index 7e8cbcee1722..37cfd8115101 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -147,7 +147,10 @@ static void virtio_gpu_resource_flush(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_lock_one_resv_uninterruptible(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_resource_flush(vgdev, bo->hw_res_handle, x, y,
 					      width, height, objs, vgfb->fence);
 		virtio_gpu_notify(vgdev);
@@ -314,7 +317,10 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
 		if (!objs)
 			return;
 		virtio_gpu_array_add_obj(objs, vgfb->base.obj[0]);
-		virtio_gpu_array_lock_resv(objs);
+		if (virtio_gpu_lock_one_resv_uninterruptible(objs)) {
+			virtio_gpu_array_put_free(objs);
+			return;
+		}
 		virtio_gpu_cmd_transfer_to_host_2d
 			(vgdev, 0,
 			 plane->state->crtc_w,
-- 
2.53.0

