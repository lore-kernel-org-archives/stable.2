Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC79D46D545
	for <stable@vger.kernel.org>; Fri, 31 Jul 2026 16:30:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785515410; cv=none; b=S6UaHhbfcBH3fGVHzRKMSIi40AwermUrrnwRQh4O3d4mnKRp2HEw0L2Yh4Q5kPWLjaIxI7i7PHTCB71SgX4DkzMXg/V0iQQW3KP1k1DSEYrfQG9tua9vJlF6k06jT6pebIwaLvzxfzgGzkliMza2Oh2NhCSAGUhJ13oALVTOzfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785515410; c=relaxed/simple;
	bh=d4Elc0FJNwnEWar8LEmWvP86R1HhatWbN5H2kEJVhN8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RwPpWmPljpVr2wy5/fCM/LldmF9wwZWUAYtFBpZeuLAno6PoNso5RAvdSChHvoF0MwGFHnRJ5LZ+vGEhoGYHfq8ncYVBqWCBiM6DP5AGMgcCwyAXf4HEHo5WYuF6i+IFMseHCz/kUAv1udxf3LU92Wp1rHWt/uMCQwtHqQej2dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kXqicaGZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kXqicaGZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D89F1F00ACF;
	Fri, 31 Jul 2026 16:30:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785515408;
	bh=FKZJHFkQeiGv1JT2KBCBp11m6OSYCVyDCfoPOjaszjY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kXqicaGZqoUX7J0H0lsWKuwCz4DV3TR/XPmB7dHubnSOnP6BkOARw9ba+Mmpa112z
	 Kg7TyzkHtEzHKOeuLA9BXR2yeUvM0tqMB9NH5TmkGzdQFYGFZWJjKwo6gluxIQstvz
	 JLzXYxF5dE18eCzYGNUKcD7gdFbEmQYehDSw8Kk86wdZTqpMWp7UGNsbW+xZNUKuEx
	 Pwl/JscgPI8ph1u2391eE0vRnUfO0vCI/gd80DsQM+GRjAmZY+NhG7tB2Ik3c4Lpjf
	 s44VxK2RZ6siNKhNVfpiNsKnAMMlyUZgOBmecFUoc7pe0b7EdQmddgHjFVZNjbkDmo
	 a06re3omR82iw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Deepanshu Kartikey <kartikey406@gmail.com>,
	syzbot+72bd3dd3a5d5f39a0271@syzkaller.appspotmail.com,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/2] drm/virtio: use uninterruptible resv lock for plane updates
Date: Fri, 31 Jul 2026 12:30:05 -0400
Message-ID: <20260731163005.805250-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731163005.805250-1-sashal@kernel.org>
References: <2026072938-nearby-drab-19c2@gregkh>
 <20260731163005.805250-1-sashal@kernel.org>
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
 drivers/gpu/drm/virtio/virtgpu_plane.c |  5 ++++-
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_drv.h b/drivers/gpu/drm/virtio/virtgpu_drv.h
index 55c34b4fc3e9..7c4f721621f3 100644
--- a/drivers/gpu/drm/virtio/virtgpu_drv.h
+++ b/drivers/gpu/drm/virtio/virtgpu_drv.h
@@ -259,6 +259,7 @@ virtio_gpu_array_from_handles(struct drm_file *drm_file, u32 *handles, u32 nents
 void virtio_gpu_array_add_obj(struct virtio_gpu_object_array *objs,
 			      struct drm_gem_object *obj);
 int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs);
+int virtio_gpu_lock_one_resv_uninterruptible(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_unlock_resv(struct virtio_gpu_object_array *objs);
 void virtio_gpu_array_add_fence(struct virtio_gpu_object_array *objs,
 				struct dma_fence *fence);
diff --git a/drivers/gpu/drm/virtio/virtgpu_gem.c b/drivers/gpu/drm/virtio/virtgpu_gem.c
index 8502400b2f9c..2fb41be0f3c9 100644
--- a/drivers/gpu/drm/virtio/virtgpu_gem.c
+++ b/drivers/gpu/drm/virtio/virtgpu_gem.c
@@ -217,6 +217,23 @@ int virtio_gpu_array_lock_resv(struct virtio_gpu_object_array *objs)
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
index e6de62734269..e782b804301c 100644
--- a/drivers/gpu/drm/virtio/virtgpu_plane.c
+++ b/drivers/gpu/drm/virtio/virtgpu_plane.c
@@ -260,7 +260,10 @@ static void virtio_gpu_cursor_plane_update(struct drm_plane *plane,
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

