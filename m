Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 36277429CC1
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 18:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790707629; cv=none; b=c909v/1MS6x9pOXmnAA4HQCoOmwL+ODMVjnmIVYoZlqKUFCj8m4RfjyKb6mguZBXHkXT1vsYOHZ28SOI4AY7tA2CcwZdwsyDRhcEzKuNDmMaimPlv2M9hBgaxpEJUg3jxW6VMglRKtLcNG25ICjkYGCTgOAf/0X8UjMrWYDdy48=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790707629; c=relaxed/simple;
	bh=zjN0MghGA7fs+AP9Y6ckqVYrRVxa8IF/TsGg5Z8X5C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=smWv/QJbdGJG9VHjD7Bp57nAn1vNmyr0B8Ti8DkorzlwhPXNk5QBjNgBGeR6Urd5dDFgkW4xt461BMwRftFiVIOyNc9Q3BxqKZ0qIerDhmpIPhLmKkmB3JZlWFNMoI8bPgCmMzvhAZz1AiVP7GNd4jOyxkC16LVKXlXTQtGXSps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtSCD9dr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtSCD9dr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7667B1F00893;
	Tue, 29 Sep 2026 18:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790707628;
	bh=YUvAoGsIi5hyxt9wxuLvkL+vgijb6rwdxtDIdvZCGXA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QtSCD9drRh6c18eRdT5dxkJH3QYRyHtyqZBJQlsYKUK6dGjunuiNh3CGUJIBUjOIO
	 2HvILP6eiArdY7TwLjR2ExYV61K/dNOZ0MW3XdrCPBn3iCpuqFd+eS0xDTjabgOmaj
	 b0v73Z/BL0Vyxiaa2PLUZeEK8bqTJ3VWKWvlk+diudjXSKTC/EXXp5H6ZrwYKwHPr6
	 Tk1IsswXMzL+CRlJPxdPQqQk2xPlSLua4EYmKldfrJLssQRPQeaJq8lz3h8oi033uh
	 J318VIIOlhO2mFWddL/KH/8/j3YE4CPrdKFw1C4KCbEtJFM78fCKY6Pj/Qr4PxdLr7
	 I/vuIvLaHSvDw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Peiyang He <peiyang_he@smail.nju.edu.cn>,
	Dmitry Osipenko <dmitry.osipenko@collabora.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/2] drm/virtio: fix NULL pointer dereference on fence allocation failure
Date: Tue, 29 Sep 2026 14:47:05 -0400
Message-ID: <20260929184705.522628-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929184705.522628-1-sashal@kernel.org>
References: <2026092904-roundness-islamic-e935@gregkh>
 <20260929184705.522628-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Peiyang He <peiyang_he@smail.nju.edu.cn>

[ Upstream commit 846b3c64fe3e77d9db20a7e3e62dbbb637c773e1 ]

virtio_gpu_fence_alloc() can fail due to memory pressure and return NULL,
but its caller like virtio_gpu_init_submit() never checks it. Later,
virtio_gpu_init_submit() passes the NULL fence to
virtio_gpu_fence_event_create(), which unconditionally dereferences it.

Found when fuzzing the virtio driver with Syzkaller:

	Oops: general protection fault, probably for non-canonical address 0xdffffc0000000012: 0000 [#1] SMP KASAN NOPTI
	KASAN: null-ptr-deref in range [0x0000000000000090-0x0000000000000097]
	CPU: 1 UID: 0 PID: 9991 Comm: syz.0.121 Not tainted 7.2.0 #4 PREEMPT(full)
	Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS rel-1.17.0-0-gb52ca86e094d-prebuilt.qemu.org 04/01/2014
	RIP: 0010:virtio_gpu_fence_event_create drivers/gpu/drm/virtio/virtgpu_submit.c:295 [inline]
	RIP: 0010:virtio_gpu_init_submit drivers/gpu/drm/virtio/virtgpu_submit.c:398 [inline]
	RIP: 0010:virtio_gpu_execbuffer_ioctl+0xc78/0x1aa0 drivers/gpu/drm/virtio/virtgpu_submit.c:505
	Code: 85 ed 0f 85 21 09 00 00 e8 05 5a c9 fb 48 8b 44 24 10 48 8d b8 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 9a 0d 00 00 48 8b 44 24 10 4c 89 b0 90 00 00 00
	RSP: 0018:ffffc900039dfad0 EFLAGS: 00010216
	RAX: dffffc0000000000 RBX: ffffc900039dfdd8 RCX: ffffffff85f6fd3d
	RDX: 0000000000000012 RSI: ffffffff85f6fd4b RDI: 0000000000000090
	RBP: 0000000000000000 R0virtio_gpu_virgl_process_cmd: ctrl 0x102, error 0x1203
	R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880132c4000
	R13: 0000000000000000 R14: ffff888073b6c700 R15: 000000000000003b
	FS:  00007fab480b96c0(0000) GS:ffff8880eb6e9000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 00007effbf5e55a8 CR3: 0000000048d19000 CR4: 0000000000350ef0
	Call Trace:
	<TASK>
	drm_ioctl_kernel+0x1f4/0x3e0 drivers/gpu/drm/drm_ioctl.c:817
	drm_ioctl+0x5f4/0xc70 drivers/gpu/drm/drm_ioctl.c:914
	vfs_ioctl fs/ioctl.c:51 [inline]
	__do_sys_ioctl fs/ioctl.c:597 [inline]
	__se_sys_ioctl fs/ioctl.c:583 [inline]
	__x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
	do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
	do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
	entry_SYSCALL_64_after_hwframe+0x77/0x7f
	RIP: 0033:0x7fab471a82bd
	Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
	RSP: 002b:00007fab480b9018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
	RAX: ffffffffffffffda RBX: 00007fab47435fa0 RCX: 00007fab471a82bd
	RDX: 00002000000000c0 RSI: 00000000c0406442 RDI: 0000000000000003
	RBP: 00007fab480b9080 R08: 0000000000000000 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000001
	R13: 00007fab47436038 R14: 00007fab47435fa0 R15: 00007ffe85ab0740
	</TASK>
	Modules linked in:
	---[ end trace 0000000000000000 ]---
	RIP: 0010:virtio_gpu_fence_event_create drivers/gpu/drm/virtio/virtgpu_submit.c:295 [inline]
	RIP: 0010:virtio_gpu_init_submit drivers/gpu/drm/virtio/virtgpu_submit.c:398 [inline]
	RIP: 0010:virtio_gpu_execbuffer_ioctl+0xc78/0x1aa0 drivers/gpu/drm/virtio/virtgpu_submit.c:505
	Code: 85 ed 0f 85 21 09 00 00 e8 05 5a c9 fb 48 8b 44 24 10 48 8d b8 90 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 9a 0d 00 00 48 8b 44 24 10 4c 89 b0 90 00 00 00
	RSP: 0018:ffffc900039dfad0 EFLAGS: 00010216
	RAX: dffffc0000000000 RBX: ffffc900039dfdd8 RCX: ffffffff85f6fd3d
	RDX: 0000000000000012 RSI: ffffffff85f6fd4b RDI: 0000000000000090
	RBP: 0000000000000000 R08: 0000000000000005 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000000 R12: ffff8880132c4000
	R13: 0000000000000000 R14: ffff888073b6c700 R15: 000000000000003b
	FS:  00007fab480b96c0(0000) GS:ffff888098ae9000(0000) knlGS:0000000000000000
	CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
	CR2: 00007f24c3759000 CR3: 0000000048d19000 CR4: 0000000000350ef0
	----------------
	Code disassembly (best guess):
	0:	85 ed                	test   %ebp,%ebp
	2:	0f 85 21 09 00 00    	jne    0x929
	8:	e8 05 5a c9 fb       	call   0xfbc95a12
	d:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
	12:	48 8d b8 90 00 00 00 	lea    0x90(%rax),%rdi
	19:	48 b8 00 00 00 00 00 	movabs $0xdffffc0000000000,%rax
	20:	fc ff df
	23:	48 89 fa             	mov    %rdi,%rdx
	26:	48 c1 ea 03          	shr    $0x3,%rdx
	* 2a:	80 3c 02 00          	cmpb   $0x0,(%rdx,%rax,1) <-- trapping instruction
	2e:	0f 85 9a 0d 00 00    	jne    0xdce
	34:	48 8b 44 24 10       	mov    0x10(%rsp),%rax
	39:	4c 89 b0 90 00 00 00 	mov    %r14,0x90(%rax)

Fix by checking virtio_gpu_fence_alloc() in virtio_gpu_init_submit() and
returning -ENOMEM before any later code can dereference the NULL fence.

Fixes: 70d1ace56db6 ("drm/virtio: Conditionally allocate virtio_gpu_fence")
Cc: stable@vger.kernel.org
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.5
Signed-off-by: Dmitry Osipenko <dmitry.osipenko@collabora.com>
Link: https://patch.msgid.link/00EFE4BA92889B14+20260909091114.2622550-1-peiyang_he@smail.nju.edu.cn
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 0314602a04c13..04490268ccab4 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -117,10 +117,13 @@ int virtio_gpu_execbuffer_ioctl(struct drm_device *dev, void *data,
 
 	if ((exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) ||
 	    exbuf->num_bo_handles ||
-	    drm_fence_event)
+	    drm_fence_event) {
 		out_fence = virtio_gpu_fence_alloc(vgdev, fence_ctx, ring_idx);
-	else
+		if (!out_fence)
+			return -ENOMEM;
+	} else {
 		out_fence = NULL;
+	}
 
 	if (drm_fence_event) {
 		err = virtio_gpu_fence_event_create(dev, file, out_fence, ring_idx);
-- 
2.53.0

