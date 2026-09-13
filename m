Received: from smtpbguseast2.qq.com (smtpbguseast2.qq.com [54.204.34.130])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CAF739A07C;
	Sun, 13 Sep 2026 08:58:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=54.204.34.130
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789289904; cv=none; b=dIlbPwiRSJpUPoctJm4sSVy8O5pfXWORzw6HNABHBCIi7DvcYbGbrt5oDFhBX4eGQSt3dgrU8bLHUMFqcQwEM8VoJgbm3GxLYX6pIxeCIrGjKY9Rt12+wDQ3OXaAf+GYd/xizb/slS5kvG5VcRmBcWXOdQ7RUMITD/jN/VK6AZo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789289904; c=relaxed/simple;
	bh=BmyCItM5WT6YjztKKIxx46xWDPHVg6vDmwqFcfBYf54=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eYwgKgGAvRLDiJQQs/TFYLlvAeR107vbSXNxPpSjr8gl4krempeUxHnMKuhutMn7dRCG1r4rhhdIArmDJPiBAQ05oqXXGvQqhn+1N6ete75Gd6DBtxNjmJ02mVHcCsD3WqIFLVVvO8mq/c7bCPEzJKmF3nN4KjrCB5tIDVSsB8k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn; spf=pass smtp.mailfrom=smail.nju.edu.cn; dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b=yOL0XNA/; arc=none smtp.client-ip=54.204.34.130
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=smail.nju.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=smail.nju.edu.cn header.i=@smail.nju.edu.cn header.b="yOL0XNA/"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=smail.nju.edu.cn;
	s=iohv2404; t=1789289847;
	bh=cky0TXjGvM51Hf7vqI6ldPP0ng3vfqkW6QwQ4SwL/oY=;
	h=From:To:Subject:Date:Message-ID:MIME-Version;
	b=yOL0XNA/ypSZ3iwnEjfr8S9gaxzwUavn7Lja4WOrQ3T2aBlEZYHc2x83CYkvHbz9J
	 Rjeo5YBQp79Uxo/7+juKXNZmZZj9W2FjP8/IUGCVtxZ/9xwscbUlc01pYiejMfFpRj
	 oPNmTRgiSZ9v7+OK5bnTkPLg9ESnq1+wIr+7I4pw=
X-QQ-mid: esmtpsz19t1789289841t89f2a43b
X-QQ-Originating-IP: NKsJ08/P3I6EGnonoGZEtRnQACCPRrAiGuvmiG6+b1c=
Received: from hepeiyang-vm.wu.lxd ( [114.212.83.113])
	by bizesmtp.qq.com (ESMTP) with 
	id ; Sun, 13 Sep 2026 16:57:18 +0800 (CST)
X-QQ-SSF: 0000000000000000000000000000000
X-QQ-GoodBg: 0
X-BIZMAIL-ID: 5805435411194586382
EX-QQ-RecipientCnt: 10
From: Peiyang He <peiyang_he@smail.nju.edu.cn>
To: gregkh@linuxfoundation.org,
	arve@android.com,
	tkjos@android.com,
	brauner@kernel.org,
	cmllamas@google.com,
	aliceryhl@google.com
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	viro@zeniv.linux.org.uk,
	Peiyang He <peiyang_he@smail.nju.edu.cn>
Subject: [PATCH] binderfs: fix UAF write in binder_add_device
Date: Sun, 13 Sep 2026 16:56:45 +0800
Message-ID: <F6EF5FB778E87C98+20260913085645.1639558-1-peiyang_he@smail.nju.edu.cn>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: esmtpsz:smail.nju.edu.cn:qybglogicsvrsz:qybglogicsvrsz4b-0
X-QQ-XMAILINFO: NNgTDNpHPdfoCQkP5ZTocy+K0N79p5EcPgq7LwZMA0kozDtke5HhVG+U
	j7UxY/Jib6V6cQapCcTzdPd6IQXt1Z1F7DzaWG27IeOvCrpg//v6m9xAScv/8fDYWkSsJYZ
	zzCM/CQUJzlHNA+vRcGuPnf8TGbeJZg95Tbc3aW6sWwZvuB9VxCaGAIenDwvOkfkGcRPJRl
	KUQb7WXH+H1vwCo5hMzzSPDTHCutf1PhC7pK8CcMrUqRp/DHQHDAMVs0ducTO8ISYX7tE8W
	xzumO63haTYOp2Fg2taF2ic5c+UckOb5xPq9kSBHnrc+RlQ96zx3RenPxAmnYegqDod3mMr
	O4B0NsDiKs4CUVfqRihJuAJgJHvsmSfcxLWWE2xvcCxXf/1BUvlAtugGvL3GdBCRjgt4MOQ
	XwQVfqnoJcQ8Y4aaDfw+k7VPxIzMcvx2Ixr8pcGCaBHkz+ki/uKV+nU6Q1WwftSE0rcDUyV
	jTmbkQkaRK/hDmojEtF5Aser1ePZf7cnLEE7YCQmzLCX4VlQ/8V8AjMBV4G1MO1hL0K8gTD
	Mp2yvtMr57M0FcM8LEce63P9ly8aAtt+FnnqTTMagkn7UaM3dSkEUl6vcCu1HO70Rt3eumJ
	Br57julkzobK0VNJcJ5dKv4lU71ZY8tCVRYy7xpWn9DPL+HxOSyzW4GIsVI47matzLNzEui
	f/BeLTNlkkexByZAsUxjhEakRg7jD4+aHzj/ZgKkYdbMYIm1rbxdL+kLbk6juYg+12HwU74
	bcsnqYAm26+78quS2L7CJGty5ZEG72YUcTwsG1/IF5Rjc31nBWX3OGTFNh5Dcf4ZMchDsew
	mv6tAfO8Z0P+8qb43cg2H7AKzYeNpx/n7wy2yCvK2NCDrkfrrdLIN696CUnDd/hDB8lYKmu
	hw4Dz6Q2ECT6sLyZ3CkJnqFfRhyzbny53/Pf2T29ruMNWQReJiuBT2qhAcOHkasyPQsGUWo
	hLJTHKmUTPBNqQPq9qzbg5UMg4nGcRMSQZUqFA63lGi0p6TVjOs/LLATIEdx+g4iGhidO49
	HaXvmq21gF6Z+PIMdVxCdmcLqKZZqck/vBdXqAWg==
X-QQ-XMRINFO: OWPUhxQsoeAVwkVaQIEGSKwwgKCxK/fD5g==
X-QQ-RECHKSPAM: 0

binderfs_binder_device_create() publishes the new dentry with
d_make_persistent() and then calls simple_done_creating(), which drops
the parent directory lock and the creator's dentry reference. It then
calls binder_add_device() to register the device in the global
binder_devices list.

After simple_done_creating() releases the parent directory lock, a
concurrent unlinkat() can remove the new device entry. Dropping the
creator's dentry reference can then trigger binderfs_evict_inode(),
freeing the device. binder_add_device() later accesses the freed
object, causing UAF write.

Found by a modified Syzkaller:

	BUG: KASAN: slab-use-after-free in hlist_add_head include/linux/list.h:1073 [inline]
	BUG: KASAN: slab-use-after-free in binder_add_device+0xa9/0xc0 drivers/android/binder.c:7068
	Write of size 8 at addr ffff88805b340c00 by task syz.1.532/11389

	CPU: 0 UID: 0 PID: 11389 Comm: syz.1.532 Not tainted 7.2.0 #4 PREEMPT(full) 
	Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
	Call Trace:
	<TASK>
	__dump_stack lib/dump_stack.c:94 [inline]
	dump_stack_lvl+0x10e/0x1f0 lib/dump_stack.c:120
	print_address_description mm/kasan/report.c:378 [inline]
	print_report+0xf7/0x600 mm/kasan/report.c:482
	kasan_report+0xe4/0x120 mm/kasan/report.c:595
	hlist_add_head include/linux/list.h:1073 [inline]
	binder_add_device+0xa9/0xc0 drivers/android/binder.c:7068
	binderfs_binder_device_create.isra.0+0x724/0x990 drivers/android/binderfs.c:196
	binder_ctl_ioctl+0x186/0x1b0 drivers/android/binderfs.c:241
	vfs_ioctl fs/ioctl.c:51 [inline]
	__do_sys_ioctl fs/ioctl.c:597 [inline]
	__se_sys_ioctl fs/ioctl.c:583 [inline]
	__x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
	do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
	do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
	entry_SYSCALL_64_after_hwframe+0x77/0x7f
	RIP: 0033:0x7ff9027a833d
	Code: ff c3 66 2e 0f 1f 84 00 00 00 00 00 90 f3 0f 1e fa 48 89 f8 48 89 f7 48 89 d6 48 89 ca 4d 89 c2 4d 89 c8 4c 8b 4c 24 08 0f 05 <48> 3d 01 f0 ff ff 73 01 c3 48 c7 c1 b0 ff ff ff f7 d8 64 89 01 48
	RSP: 002b:00007ff903674018 EFLAGS: 00000246 ORIG_RAX: 0000000000000010
	RAX: ffffffffffffffda RBX: 00007ff902a35fa0 RCX: 00007ff9027a833d
	RDX: 0000200000000500 RSI: 00000000c1086201 RDI: 0000000000000004
	RBP: 00007ff902850733 R08: 0000000000000000 R09: 0000000000000000
	R10: 0000000000000000 R11: 0000000000000246 R12: 0000000000000000
	R13: 00007ff902a36038 R14: 00007ff902a35fa0 R15: 00007ffd7166bfa0
	</TASK>

	Allocated by task 11389:
	kasan_save_stack+0x33/0x60 mm/kasan/common.c:57
	kasan_save_track+0x14/0x30 mm/kasan/common.c:78
	poison_kmalloc_redzone mm/kasan/common.c:398 [inline]
	__kasan_kmalloc+0xaa/0xb0 mm/kasan/common.c:415
	kasan_kmalloc include/linux/kasan.h:263 [inline]
	__kmalloc_cache_noprof+0x2e4/0x6f0 mm/slub.c:5489
	_kmalloc_noprof include/linux/slab.h:988 [inline]
	_kzalloc_noprof include/linux/slab.h:1309 [inline]
	binderfs_binder_device_create.isra.0+0x17a/0x990 drivers/android/binderfs.c:148
	binder_ctl_ioctl+0x186/0x1b0 drivers/android/binderfs.c:241
	vfs_ioctl fs/ioctl.c:51 [inline]
	__do_sys_ioctl fs/ioctl.c:597 [inline]
	__se_sys_ioctl fs/ioctl.c:583 [inline]
	__x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
	do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
	do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
	entry_SYSCALL_64_after_hwframe+0x77/0x7f

	Freed by task 11389:
	kasan_save_stack+0x33/0x60 mm/kasan/common.c:57
	kasan_save_track+0x14/0x30 mm/kasan/common.c:78
	kasan_save_free_info+0x3b/0x60 mm/kasan/generic.c:584
	poison_slab_object mm/kasan/common.c:253 [inline]
	__kasan_slab_free+0x5f/0x80 mm/kasan/common.c:285
	kasan_slab_free include/linux/kasan.h:235 [inline]
	slab_free_hook mm/slub.c:2677 [inline]
	slab_free mm/slub.c:6377 [inline]
	kfree+0x2fc/0x6e0 mm/slub.c:6692
	binderfs_evict_inode+0x1e8/0x260 drivers/android/binderfs.c:268
	evict+0x3c2/0xad0 fs/inode.c:825
	iput_final fs/inode.c:2019 [inline]
	iput fs/inode.c:2068 [inline]
	iput+0x79a/0xd30 fs/inode.c:2031
	dentry_unlink_inode+0x27f/0x460 fs/dcache.c:479
	dentry_kill+0x25d/0xc20 fs/dcache.c:826
	finish_dput fs/dcache.c:1001 [inline]
	dput.part.0+0xce/0x230 fs/dcache.c:1042
	dput+0x1f/0x30 fs/dcache.c:1037
	end_dirop+0x7d/0xa0 fs/namei.c:2956
	binderfs_binder_device_create.isra.0+0x71c/0x990 drivers/android/binderfs.c:194
	binder_ctl_ioctl+0x186/0x1b0 drivers/android/binderfs.c:241
	vfs_ioctl fs/ioctl.c:51 [inline]
	__do_sys_ioctl fs/ioctl.c:597 [inline]
	__se_sys_ioctl fs/ioctl.c:583 [inline]
	__x64_sys_ioctl+0x18e/0x210 fs/ioctl.c:583
	do_syscall_x64 arch/x86/entry/syscall_64.c:63 [inline]
	do_syscall_64+0x116/0x800 arch/x86/entry/syscall_64.c:94
	entry_SYSCALL_64_after_hwframe+0x77/0x7f

	The buggy address belongs to the object at ffff88805b340c00
	which belongs to the cache kmalloc-512 of size 512
	The buggy address is located 0 bytes inside of
	freed 512-byte region [ffff88805b340c00, ffff88805b340e00)

Fix by calling binder_add_device() before d_make_persistent(),
while the parent directory lock is still held and the dentry
cannot be discarded.

Cc: stable@vger.kernel.org
Fixes: b89aa544821d ("convert binderfs")
Signed-off-by: Peiyang He <peiyang_he@smail.nju.edu.cn>
Assisted-by: Codex:gpt-5.5
---
The root cause of this UAF is not the same as this Syzbot report:
	https://syzkaller.appspot.com/bug?extid=7015dcf45953112c8b45

 drivers/android/binderfs.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/android/binderfs.c b/drivers/android/binderfs.c
index 361d69f756f5..1ca31b9a0583 100644
--- a/drivers/android/binderfs.c
+++ b/drivers/android/binderfs.c
@@ -189,12 +189,11 @@ static int binderfs_binder_device_create(struct inode *ref_inode,
 		goto err;
 	}
 	inode->i_private = device;
+	binder_add_device(device);
 	d_make_persistent(dentry, inode);
 	fsnotify_create(root->d_inode, dentry);
 	simple_done_creating(dentry);
 
-	binder_add_device(device);
-
 	return 0;
 
 err:
-- 
2.43.0
