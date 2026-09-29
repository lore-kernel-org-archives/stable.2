Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B62A02AD1B
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 17:31:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790703091; cv=none; b=uTNuFS9WRU4dHstvMjf8U5JYNRJMinifiyP4LCjZJH+SVrKHOG49sKHiysIQWljXcSBO5KlWSMLSWwAdxh7VxSuFo/SNMWsKiYEf+NPXVsnNChZhQFI223Ivko/dxLEVuUN7UoLi8G0N76VE5ng5wqcEkRnRNdBmWG8h03RWJU4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790703091; c=relaxed/simple;
	bh=Um4bmgCuQb0aj3vzt1VMTln13YWDpEN+qgKANPM+3Qk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NwLvufYfJU25RVOcc4IYuh0lC9BuS+WzilYxni1JbNiyQuuHeArcOjxBZFomI6wuOz2br/FkO4KJ5YM6DTFsDJeK3Q9NQCYgLOMHtRZqsVjOHB26n6oKtYgAiys+03x7E7m2fWqkn0uvM0AOcNqy8/f9vIvwRhtlO6wAWyQr/xo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R4pUJGrl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R4pUJGrl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CEE71F00898;
	Tue, 29 Sep 2026 17:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790703089;
	bh=VVJgpyVPUyTM0LfTcmII5d90CPTQhG59gloT5/o0ge8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R4pUJGrlr20FDEiUrUBa7NLPsLKuY6kraNpNqKI+O7bu990XzncInXBAY/iaYMO6d
	 y+P6/aCvxvuBzFRc2dt6wlXrbY1CODz9zXRkeDKqRnOz4mj+h/ixTHC3aC4W5afrsE
	 RllmRj7CkaebdKnDMsdtFXMu9eTffPR+MAFXiRgxVMOkLyW3+sr4PtfmyO6HVAzJQs
	 KBqt19/kEfmKbB9Riz4r/xiw2yjC9/rWMPqAuvvyIqzkVGG1hX8FhSlxaHzOnElhho
	 VbSa3hexmxsq4JwezYoxzCfFXFjzvtIMQ0cYQx8CuXqQUIwmW6XA/AxUJzpM0TmuPM
	 vUdT+jl+Rr4zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peiyang He <peiyang_he@smail.nju.edu.cn>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] drm/virtio: fix memory leak of fence event on execbuffer failure
Date: Tue, 29 Sep 2026 13:31:26 -0400
Message-ID: <20260929173126.284476-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929173126.284476-1-sashal@kernel.org>
References: <2026092952-wifi-luster-9ed8@gregkh>
 <20260929173126.284476-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peiyang He <peiyang_he@smail.nju.edu.cn>

[ Upstream commit b74aad23d99b279bb34d135795f39a6d8ecdc075 ]

virtio_gpu_execbuffer_ioctl() reserves a DRM event with
drm_event_reserve_init() when VIRTGPU_EXECBUF_RING_IDX selects a ring that
userspace has enabled polling for. virtio_gpu_init_submit() does this
before the BO handles, the command buffer, the syncobj arrays and the
in-fence are processed, so every later error path runs with the event
already pending, including plain argument validation failures such as an
invalid bo_handle or an in-syncobj that carries no fence.

On those paths, virtio_gpu_cleanup_submit() drops the out-fence without
cancelling the event. The fence is freed without ever having been emitted,
taking the only driver-side pointer to the event with it. Closing the DRM
file does not help. drm_events_release() unlinks pending events but
deliberately leaves the freeing to the driver's later drm_send_event(),
which never runs for an orphaned event, so the allocation is leaked
permanently.

Found when fuzzing the virtio driver with Syzkaller:

	BUG: memory leak
	unreferenced object 0xffff88802c176e80 (size 96):
	comm "syz.1.367", pid 10561, jiffies 4294960122
	hex dump (first 32 bytes):
		00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
		c8 6e 17 2c 80 88 ff ff 00 00 00 00 00 00 00 00  .n.,............
	backtrace (crc e1973c6b):
		kmemleak_alloc_recursive include/linux/kmemleak.h:44 [inline]
		slab_post_alloc_hook mm/slub.c:4597 [inline]
		slab_alloc_node mm/slub.c:4917 [inline]
		__kmalloc_cache_noprof+0x49d/0x6f0 mm/slub.c:5485
		_kmalloc_noprof include/linux/slab.h:988 [inline]
		_kzalloc_noprof include/linux/slab.h:1309 [inline]
		virtio_gpu_fence_event_create drivers/gpu/drm/virtio/virtgpu_submit.c:282 [inline]
		virtio_gpu_init_submit drivers/gpu/drm/virtio/virtgpu_submit.c:398 [inline]
		virtio_gpu_execbuffer_ioctl+0xbbf/0x1aa0 drivers/gpu/drm/virtio/virtgpu_submit.c:505
		drm_ioctl_kernel+0x1f4/0x3e0 drivers/gpu/drm/drm_ioctl.c:817
		drm_ioctl+0x5f4/0xc70 drivers/gpu/drm/drm_ioctl.c:914
		vfs_ioctl fs/ioctl.c:51 [inline]
		__do_sys_ioctl fs/ioctl.c:597 [inline]
		__se_sys_ioctl fs/ioctl.c:583 [inline]
		__x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
		do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
		do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
		entry_SYSCALL_64_after_hwframe+0x77/0x7f

Fix by cancelling and freeing the DRM event on the execbuffer error path
before dropping the fence. Clear the fence's event pointer after
cancellation so it does not retain a dangling pointer.

Fixes: cd7f5ca33585 ("drm/virtio: implement context init: add virtio_gpu_fence_event")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.6-luna
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patch.msgid.link/D320EAB5680C1411+20260908121323.2405044-1-peiyang_he@smail.nju.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 3cad6413cad7e..2b54e0c5e8296 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -295,6 +295,10 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	virtio_gpu_install_out_fence_fd(&submit);
 	virtio_gpu_complete_submit(&submit);
 cleanup:
+	if (ret && submit.out_fence && submit.out_fence->e) {
+		drm_event_cancel_free(dev, &submit.out_fence->e->base);
+		submit.out_fence->e = NULL;
+	}
 	virtio_gpu_cleanup_submit(&submit);
 
 	return ret;
-- 
2.53.0

