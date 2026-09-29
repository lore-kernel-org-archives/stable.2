Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C0D93A382F
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 08:25:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790670359; cv=none; b=QB8A4mGzwsM95sZoP4eNXOAvwjTDRVo00nfO5U1t3KkjjuUljEMLr0VBwtjpv/qQ7yIwf2BPtHrskkQBg3KrhlHJSUMTlas5UO0mPUSKWcZozRz0Ycy3E+5MirUZoAdKoue9m2JtRzfEGiJF0yyKmMMUnwQfuInWUck432fSZb8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790670359; c=relaxed/simple;
	bh=E0qm4nHWXfbh4/s09evSSzSlVlv1g80BsQTuwODi4ak=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HkC8W7So6krCKOlltut1f7UBtWtGidx+GAwHJaeYwSFY7OPFzxthqC0HsWqa/gkhjET8n6pvPSHV7MoexEb6nMALuhNmdokbcn8DCcyjkbLVr4VfXG3a+PuKqxxHoKv8uLCISYTm8/7TnKbf7xFZU36Lrqaq2LYcJAsx35clveI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wg3PoFPW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wg3PoFPW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E1641F000FF;
	Tue, 29 Sep 2026 08:25:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790670357;
	bh=M+NsL7IunsQ7AEUeWbRYpcQrBHE+N/WfnKx+DK6Tb40=;
	h=Subject:To:Cc:From:Date;
	b=wg3PoFPWkTmiYJLIcLoqHPwPd6WOb6MuMYhBJ/5ZCht2ehy5lkW+3U+4qxdKWH3C4
	 y+0EtQusLFRZ+H0tTrlFs49btDPuTBOjrOQ+0aZpSBxKopjX2HYjTpb8f/QLW3Ml+b
	 dDm8H379lfhVeXC0swYCifU3fwFWft7W/DPsCVfg=
Subject: FAILED: patch "[PATCH] drm/virtio: fix memory leak of fence event on execbuffer" failed to apply to 6.1-stable tree
To: peiyang_he@smail.nju.edu.cn,dmitry.osipenko@collabora.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 10:25:52 +0200
Message-ID: <2026092952-wifi-luster-9ed8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x b74aad23d99b279bb34d135795f39a6d8ecdc075
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092952-wifi-luster-9ed8@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From b74aad23d99b279bb34d135795f39a6d8ecdc075 Mon Sep 17 00:00:00 2001
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
Date: Tue, 8 Sep 2026 20:13:23 +0800
Subject: [PATCH] drm/virtio: fix memory leak of fence event on execbuffer
 failure

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

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 32cb1e4aa425..734b1e976a75 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -538,6 +538,10 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 	virtio_gpu_process_post_deps(&submit);
 	virtio_gpu_complete_submit(&submit);
 cleanup:
+	if (ret && submit.out_fence && submit.out_fence->e) {
+		drm_event_cancel_free(dev, &submit.out_fence->e->base);
+		submit.out_fence->e = NULL;
+	}
 	virtio_gpu_cleanup_submit(&submit);
 
 	return ret;

