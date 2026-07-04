Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8726E3C1090
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 13:01:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783170072; cv=none; b=cHk39frMtJnw6w7fYQ8aNWfg6p1sfO2GIhiOpwA4RIwWaax4p9M8HA3zPFRnK6Yej1AwoqXmF1owU1tpZUtqSqk5+aQsIZyeikepJTLjc62Gq6R7Ubye2/ry5uOYLdKbzpADi7guEqxIkSyekvd3Fqi+p3rGgE9tvH4P6kxIXWE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783170072; c=relaxed/simple;
	bh=a9V/JPcvBqvePkdaMvSsBuYQjRAbIFXJgwrFmfF3aso=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=poZvLNOwstq/qP0qAbjkLi49S4M9OddwMCfI8DnX9aP51hQQD+6iXLI4mONGyjEgnqXfQVhhBA/Fp6uZzoLWqgcbVfM4CDipkpUjIFHVorc7NapTje2Yp+jyaBWrSZerWtzzI0AXu4NQjGQDi2seljkrgoWauqoWAIEF7P6b5vU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YzfpZVxe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YzfpZVxe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D3F501F00A3A;
	Sat,  4 Jul 2026 13:01:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783170071;
	bh=k5b8x32VmGjMOkLod0KV6qaPrD91tGyRAF8OyNJOapg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=YzfpZVxe8uxg0Glzhie+rCoC+tCRDhlBPZLUafrBBGs5VNokFu7S/kIZ2YTXOiEMw
	 VpUdoN0tpW0kouY8IDNnGtaIjBlTvWiaja61vBo0t7Cdzq26ByY+NIEL94Z5/3FMEb
	 3ZAwuA64kTKdfSRTT6UITM+BpLcvzNiOZD0dE+BdSPjH2LbO7gO+H+X7tAislcuJ7F
	 InVd+6sl6IQQ9PqnJitwWIQmpvbwPvmX+qEq2Jfw9Hy1UMMJFKWMJMfj0RI+pkKwlh
	 ML6fzn8ABjVhrPw5aTicP0e60M0rwqwGBp+PtPvpll7EBWkyNS6wTOWNUe3KFXAovk
	 WMkW3BuYFPIsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Denis Arefev <arefev@swemel.ru>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] block: Avoid mounting the bdev pseudo-filesystem in userspace
Date: Sat,  4 Jul 2026 09:01:09 -0400
Message-ID: <20260704130109.829039-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070222-ducking-flanked-b10f@gregkh>
References: <2026070222-ducking-flanked-b10f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Denis Arefev <arefev@swemel.ru>

[ Upstream commit f73aa66dffcb8e61e78f01b56163ec16a15d06d2 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 block/bdev.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/block/bdev.c b/block/bdev.c
index ce7c20c2661793..e015fea1521e2b 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -459,16 +459,12 @@ EXPORT_SYMBOL_GPL(blockdev_superblock);
 
 void __init bdev_cache_init(void)
 {
-	int err;
 	static struct vfsmount *bd_mnt;
 
 	bdev_cachep = kmem_cache_create("bdev_cache", sizeof(struct bdev_inode),
 			0, (SLAB_HWCACHE_ALIGN|SLAB_RECLAIM_ACCOUNT|
 				SLAB_MEM_SPREAD|SLAB_ACCOUNT|SLAB_PANIC),
 			init_once);
-	err = register_filesystem(&bd_type);
-	if (err)
-		panic("Cannot register bdev pseudo-fs");
 	bd_mnt = kern_mount(&bd_type);
 	if (IS_ERR(bd_mnt))
 		panic("Cannot create bdev pseudo-fs");
-- 
2.53.0

