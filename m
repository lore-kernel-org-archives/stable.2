Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 837AA52D2B3;
	Tue,  8 Sep 2026 12:16:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788869790; cv=none; b=S5JH2Gxq010X6VOgfOhUiAkBCOe5ehd+JIaqHnzwD+DguCoJbSq+6M0TWEu3lLWwRdoj2uTxRD/5mOlxKqKtoZ1kdQTj5O/Lz/uYhbY52DNQAqeaN27243Nvyw5Ldxj2wyOiChWpv/eEKaR6Wl2jE0XRwMYM8eezqaS+r1COX/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788869790; c=relaxed/simple;
	bh=kE6e9md14D+FOdB2WmJgAW7jR/hNortrL82vwlwO6uY=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=flCFCwiHtqdL/lmec+qFswFTEC/106SpN1xNvml0tpl4jkrp4iC8lK5+RExB4FiQv1zuhG3pbywI+YLbYgL41FdQRBYBEeaRJIjqpepz6Ie04itOu9uYXBuTM/deZh/dNr+NiDcZut+Pwp4qeQdik8ECZCGFLsSYkcn626fvd5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=AbMwDCKf; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="AbMwDCKf"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1788869637;
	bh=OU42xnYgBuQIIGsbiQd3edAdK/2WUQRNb9zNrW3eZIk=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=AbMwDCKfU7zk36Plc4V9yxvCA5fXKOr7w0hLfKKDF5+Y/PNPsRGRtuYlDhRLuTe+J
	 Jpb/JGZbU3tvpUzaybyMuUjGfWfxrXDYdFLjeJIErSaEFojVkcwNpgVeKQyZasVvyP
	 Q3OEmY1RWQHzH73bC5FpM/wekdeAL3JGzTSZm9aQ=
X-QQ-mid: zesmtpgz8t1788869631t68f93279
X-QQ-Originating-IP: NNglehT6aMwsIV0lPfkuSjfZJOylKUr5I3iD3JMVzh0=
Received: from hepeiyang-vm.wu.lxd ( [36.152.24.145])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Tue, 08 Sep 2026 20:13:27 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 13790185854937703597
EX-QQ-RecipientCnt: 9
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev,
	gurchetansingh@chromium.org,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] drm/virtio: fix memory leak of fence event on execbuffer failure
Date: Tue,  8 Sep 2026 20:13:23 +0800
Message-ID: <D320EAB5680C1411+20260908121323.2405044-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpgz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: Nl7eTg5yGHnwHFfuMYie3uzOH+MV3o3VNn8RrdTFB4ddVof9TNOenLKy
	5geAAIaZpZaD3SEX4AXEKg05EuqffXN5kgL34njDKfni45tyESJ6aoQC1tq1Fu54s+T1IH1
	HBUAZ5TIkJyIis/G6wiVzjbc1/2WKDnJZtwRV3bM+vik95YFvQcw2sey+OccaFT0jZ2NVmv
	C/XoMsche5idT4i0G+6lJ88RU1xJLuuc/YrutbUj/rwZaZy8OQaxc3CF3PusEWwZS3srwPK
	FclHF/RMrdZaOxWXP6kwglkUg6myeIEjaztV1cvb8DVDqcL94Oyr+Jfeh7UQoBlxDidw8JF
	ytd0yJ8lVGvT2Oin9qQ//u1Q6m74C1sbxkEa5SZMj0ozXNAvM+CcTsWNHO966spDN6ttGYB
	KTdL6+djaQHvdhS8ASXXq6Cb5fKG+v4mQetenb6zZ7lFPNa/xNEVHvn5R0Q2kyprsOxZFu6
	AcfDqMfWFmTF+AyUYAkB532MEXafLSkVU972qJF9IjJmv6FUdrmpSECgpXlNfDP003TxiJk
	h28lIdaZhAELPUcpDf3T6102/eYKiKWgOPGBrGE1+a5Xk2ELPBDVyzwpzAuQDFWE8EEkGc9
	Ud3a29fUI4YFBFeyEkl5ixQCa10iveeMDix9n2eFwp4lRPk+n/dNOwiUVqLkuLJPWTAkOuW
	z8dsR1/JJSWrHijlIW98XXWwPcKrfQHFim+r/XNJnM+V1zOaCVQeFfBhCtqkJvQHvPthdhw
	3/qzdQpcLShtcL2VS0W3MjUP7BKeteV9+/IIOMvzome4CPvYQ2Ljz1VicPgypbp/knyl5L2
	tTsYejBehq3Jxk7RZJqJpY/nIaoSQcGcSRy15q1bVdydxSPN3Jfx74KxD/r16BrN6cU6V+g
	NOOK2PYXk18vTP/nn6nV3aiyOENmTKt1T0WDeuke9TdH6So0p/xCGTSezMizjXHY7XEQe5P
	PY+jPaeOKUhteVvEmNW9YBFYV1Xr7eEe34YkZiCOba0e90Cwln+QHppRfP4zdFa/svkd870
	RarM7pukCiReRagDHEJsYf3eOb3E7UgRwTOiszFWmh0shZB/DNeS3GHERGX4I=
X-QQ-XMRINFO: M/715EihBoGS47X28/vv4NpnfpeBLnr4Qg==
X-QQ-RECHKSPAM: 0

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
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 4 ++++
 1 file changed, 4 insertions(+)

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
-- 
2.43.0
