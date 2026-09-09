Received: from smtpbgbr1.qq.com (smtpbgbr1.qq.com [54.207.19.206])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C50B037F006;
	Wed,  9 Sep 2026 09:11:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.207.19.206
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788945117; cv=none; b=O6y011+KsMIyh8OO+QrcJ9hgbwUNt/VVEjheDQXqptkCIK+p4z0CXLyzBpWQacURAfcvmXI+FWwl2QTmj1weLE3cM053NCw4OBh70JZfQne6WNzamjHgfSSbnIPkmckp6Np/pX3n5gx6loyrbMAjX80sryaS40QVQHJ/qrpyd9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788945117; c=relaxed/simple;
	bh=1wLbBjx0R0JxlU+UMv1TAs5nGm6HEqYp53dkIfZRlzU=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=LJQ4g6nZggi7qQNtEQX9BJno/1tIYxicfaaMpb9Npqnd8C9SKHbltoiwFnDxmCNBuUbufCLnC+Qgqg+At0kUmRPpl0c0TbqszQbkrpBqxW8WD3/tcyQB+cjJRpGEL9SfXX7y5UQ6aTC81Wk3K81EJEXiR0KZGw80DPmvQ4YLYYo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=4Ak/dYKX; arc=none smtp.client-ip=54.207.19.206
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="4Ak/dYKX"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1788945096;
	bh=yw5NGiijZ5YALpYySw4SpwKyTfmc247roOEcNi54jXw=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=4Ak/dYKXNCnci2o1xofVaLbF+zLGCUpnlNk96HuMYPy1mjjs+cpn8LHU9Mpe5zjDj
	 3WnsL77CSsWds2mR3qDAmdOnXtAyEh3AKpCbIRoy2llw9XfhKAozEWFfxrHJeb9ygU
	 PsbKjIjt3rahdA8eR/51CC5FPzvGv2zvaVlhWswE=
X-QQ-mid: zesmtpsz6t1788945079t3aeb69b1
X-QQ-Originating-IP: DI5LWWLOhAhhqOxp8nE4wrAGDVtZXMdzF1lEklLG0UY=
Received: from hepeiyang-vm.wu.lxd ( [114.212.83.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Wed, 09 Sep 2026 17:11:16 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 1
X-BIZMAIL-ID: 12982179329491539308
EX-QQ-RecipientCnt: 13
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: airlied@redhat.com,
	kraxel@redhat.com,
	dmitry.osipenko@collabora.com,
	dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	virtualization@lists.linux.dev,
	gurchetansingh@chromium.org,
	olvaffe@gmail.com,
	maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] drm/virtio: fix NULL pointer dereference on fence allocation failure
Date: Wed,  9 Sep 2026 17:11:14 +0800
Message-ID: <00EFE4BA92889B14+20260909091114.2622550-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: zesmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: ORP1oqzHuvxW1imbPWOGoPtqzqrJQv/7nhd0d5XpM0LEt1fd/4NElgZ2
	YUfsAGeZqnqjgUHkT846YUyr6W4vmNZ+iMpRi+eeO8IT+U+UqIaz5z8YLisTZUFjoxJBH2U
	fEM9I1erxAbirE0Zi7/q8jfJ9JZjRHIUpWGggMUazb/LVjSUWTSTdUn6wH9WAJ5l2EW/8AZ
	3VNZV9l1o8OUaJ1K9ghbt4Bp4UqYzEXeMUDsNnD/onabev4aDW6bWVT4aZN8QDob0SAnSEh
	UWVYq1HCdqooDTYzu4DsrCdeXhHYQURwV8cp0iK/01XOqP7DmFZ/LJpexUf15fj7qEct0B6
	Q0bXz1SyPHNT/WXh7uwl3hnaBVuMrMxgKSbm3zgH9SbKAHOnxUSzPAgaa4MHS9OICYkMGD6
	RDEuq8ju/SYNUVZKuhQv03sFpFYFRvza99OM+a0zawRjYEbTjboV0qCN5ETkhFTON8AmAqG
	/9RxcHV/iN3/pC+GoIivYfZMttXyb17HKs4ag7CTUpzvDzD0iQ/FiJk1ijUQskpUWpEr0ZC
	iCMDF7PzVbfDqK3IiKEUTTVw7gsCm3vRMxBqLfX+FN1U4ek1IlUeM8Gw2lh21Nk+X7jjlBW
	gYN/qJ+BEmfSb9XlaVey5aS9Sanz4Zixj/MRqLD4Gp+7K+wyzEGJT5rjRN/KSADqznty80T
	lT48Wsnf/ZQ/KJsgaKHom/N2X7gKqFhlAj9W16cexGRrp2foRZfHyvGRvSHVETsY6dUItZq
	QKACvYgr1N1AZ7MbMXqZJ/RFLWrP+bLE5SGHAQeGS1XEJiBkTFuzFyu1PXcRWRjq7PQgIOs
	6MkcEuHRMPP7meMjVu4iqDPoUM4Z0cHwl2Kc5tfhCI+JEW7UwIABFPcRYP3qE/g/OJcGdD6
	sgaR+MmvsC3nasPjTT5mTe6NvxcTU0GgBHH9D+KkhwaxogWjcyPIfB3d1L8v52lB2RzZZHi
	+RRjfuPQEOpPVs5ytELmhdZngftt6KtoyqpWlPl1o+EjkQ6vpPrqXcvhXi2Xx00NL2lslqQ
	e37GgUA/NjlU2d2eB/aA+RK7Saf2f+F6aqBB1Yh7K/LRi4CGkEjDQ+i70vCis=
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

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
---
 drivers/gpu/drm/virtio/virtgpu_submit.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/virtio/virtgpu_submit.c b/drivers/gpu/drm/virtio/virtgpu_submit.c
index 32cb1e4aa425..857ed5c5f2a8 100644
--- a/drivers/gpu/drm/virtio/virtgpu_submit.c
+++ b/drivers/gpu/drm/virtio/virtgpu_submit.c
@@ -389,10 +389,13 @@ static int virtio_gpu_init_submit(struct virtio_gpu_submit *submit,
 	if ((exbuf->flags & VIRTGPU_EXECBUF_FENCE_FD_OUT) ||
 	    exbuf->num_out_syncobjs ||
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
2.43.0
