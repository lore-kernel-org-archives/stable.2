Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 394C039B958
	for <stable@vger.kernel.org>; Thu,  2 Jul 2026 13:12:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782997952; cv=none; b=d8anUrRp3HI07dDIBR/HnWfz5Ar8vW5YChXrbYYyBByyqHpQvK2QHYOYMLTv51qK18rI894Q19AvmgyFpt5oU5HRsVLKupEQZXB2Qlr6M/VzWSfCiwFQK+PelZqVxPUwqMH7ItDVLtLHyEqM1uBNvmVmXtMt+SC/L6PFrpC14wA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782997952; c=relaxed/simple;
	bh=q2XEBSs/uADiFntEK2U0K2NL8q+1M5+f7SC/ZJX/FnU=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=D8CVYzG4EwnTzT+E/F1U84lbM7ITLooc/sr+rLePyD8k8STlkgq/376VkcRxlQhA5HAnXNJyaCQRfVrKjG3NHhriZnPCHZGmumNBXklgUGNZ5ALFHD3TQFwJriv9wrTZoMw0GTvUVLnxZMG3wXDovdv0XYqNUqtc+smr4S5wmK8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nVYfEZ/P; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nVYfEZ/P"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 675CF1F000E9;
	Thu,  2 Jul 2026 13:12:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1782997950;
	bh=VZSOo7DkDObX3PtB0Qtw9yUugo7kgMtNGRHadz2vpqg=;
	h=Subject:To:Cc:From:Date;
	b=nVYfEZ/PNvcHKOycu7qSEOfZ4Fjq8yT8L/BZICcUbwGtinPlgwucxif/YI8Ad6LL7
	 BRfl+3tMroXe2nd0wLJkFhiejeB9U/DMaeTQumFjb4b3sumTEcvEBySi7+cAoetXhk
	 7oHJclyp4+ZXC9RpYGAk8ruy8t5feQiIUWkZU4rQ=
Subject: FAILED: patch "[PATCH] block: Avoid mounting the bdev pseudo-filesystem in userspace" failed to apply to 6.1-stable tree
To: arefev@swemel.ru,axboe@kernel.dk,hch@lst.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 02 Jul 2026 15:12:21 +0200
Message-ID: <2026070221-hazing-urban-0aef@gregkh>
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
git cherry-pick -x f73aa66dffcb8e61e78f01b56163ec16a15d06d2
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026070221-hazing-urban-0aef@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From f73aa66dffcb8e61e78f01b56163ec16a15d06d2 Mon Sep 17 00:00:00 2001
From: Denis Arefev <arefev@swemel.ru>
Date: Thu, 21 May 2026 10:28:56 +0300
Subject: [PATCH] block: Avoid mounting the bdev pseudo-filesystem in userspace

The bdev pseudo-filesystem is an internal kernel filesystem with which
userspace should not interfere. Unregister it so that userspace cannot
even attempt to mount it.

This fixes a bug [1] that occurs when attempting to access files,
because the system call move_mount() uses pointers declared in the
inode_operations structure, which for the bdev pseudo-filesystem
are always equal to 0. `inode->i_op = &empty_iops;`

[1]

 BUG: kernel NULL pointer dereference, address: 0000000000000000
 #PF: supervisor instruction fetch in kernel mode
 #PF: error_code(0x0010) - not-present page
 PGD 23380067 P4D 23380067 PUD 23381067 PMD 0
 Oops: 0010 [#1] PREEMPT SMP KASAN NOPTI
 CPU: 2 PID: 17125 Comm: syz-executor.0 Not tainted 6.1.155-syzkaller-00350-g84221fde2681 #0
 Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.12.0-1 04/01/2014
 RIP: 0010:0x0

 Call Trace:
 <TASK>
 lookup_open.isra.0+0x700/0x1180 fs/namei.c:3460
 open_last_lookups fs/namei.c:3550 [inline]
 path_openat+0x953/0x2700 fs/namei.c:3780
 do_filp_open+0x1c5/0x410 fs/namei.c:3810
 do_sys_openat2+0x171/0x4d0 fs/open.c:1318
 do_sys_open fs/open.c:1334 [inline]
 __do_sys_openat fs/open.c:1350 [inline]
 __se_sys_openat fs/open.c:1345 [inline]
 __x64_sys_openat+0x13c/0x1f0 fs/open.c:1345
 do_syscall_x64 arch/x86/entry/common.c:51 [inline]
 do_syscall_64+0x35/0x80 arch/x86/entry/common.c:81
 entry_SYSCALL_64_after_hwframe+0x6e/0xd8

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Link: https://lore.kernel.org/all/20131010004732.GJ13318@ZenIV.linux.org.uk/T/#
Cc: stable@vger.kernel.org
Signed-off-by: Denis Arefev <arefev@swemel.ru>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Link: https://patch.msgid.link/20260521072857.5078-1-arefev@swemel.ru
Signed-off-by: Jens Axboe <axboe@kernel.dk>

diff --git a/block/bdev.c b/block/bdev.c
index e44a73903201..85ce57bd2ae4 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -446,15 +446,10 @@ EXPORT_SYMBOL_GPL(blockdev_superblock);
 
 void __init bdev_cache_init(void)
 {
-	int err;
-
 	bdev_cachep = kmem_cache_create("bdev_cache", sizeof(struct bdev_inode),
 			0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
 				SLAB_ACCOUNT|SLAB_PANIC),
 			init_once);
-	err = register_filesystem(&bd_type);
-	if (err)
-		panic("Cannot register bdev pseudo-fs");
 	blockdev_mnt = kern_mount(&bd_type);
 	if (IS_ERR(blockdev_mnt))
 		panic("Cannot create bdev pseudo-fs");

