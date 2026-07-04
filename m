Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9C8C3AFAE6
	for <stable@vger.kernel.org>; Sat,  4 Jul 2026 12:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783168276; cv=none; b=XHKgEa3vlYarVHWidxped4QZf0uFkOmhBomsUl7qCLBMil2a0GlBdC06MyNlEb0idpLpieOo+U0BuOGfBC6gslLoMI1u6SPgFl4pZYobdopbe25+6oJr8g/lyRjX9mgCP+5F65RxexGccGepB7LkGR000G2PT7jzAWwZaeLbHU0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783168276; c=relaxed/simple;
	bh=wFHsUcuj0VqkCQFM+xGPAwlp0SYUCL4iUGnz1tUEqu8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Jz/1yr078vkoNCq32ipLmuBrQsjC1yEaQQOktwtwQ4lwG9rHaX99HwuJosHw9mCwGiRJ+dBqeFYvS8KoNthMHXuXL1YIJc1pgTYiFuyFCRxxpGkEPvu0SPE6eJh19vqCSPlam2Wq0xCOTOcz0jrrvGO33/EclV4gHDsS/wkvufE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Xw2LDtSi; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Xw2LDtSi"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A8C41F000E9;
	Sat,  4 Jul 2026 12:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783168266;
	bh=3xlku6rIC4hFVZMnCKou2q1JCu+M3EDN62PS8LPHO6s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Xw2LDtSiH4ionzFis694PmB9i5QeckadKTqyrf4gAtvnTKkNGqzq9owDA1ZS0aZSK
	 Jv42iUSleWIPE6RFoffih3obDR6U7z2hYQN4Mj6OsbuRahexM+s3trezwq8z644mIX
	 zcynVI6dldfuklYWdlvJFniOAjYcnF9D2YwONrnkgpe96BTwglbINp3ACGYNFK347L
	 ZLOV66NZTsN7lHyKFiS43I6C3SlWV5nMFmRQGL4+rMPl6ldWqnP0ad50ihoM8GZBW7
	 MGJVAUCqAdc0OSRJOPrAKfrmS7Eu8UzJ92vR8PJ4E/4az1Xdp+deC4sNm7d2ki6pM7
	 eMdDCiLW1cPag==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Denis Arefev <arefev@swemel.ru>,
	Christoph Hellwig <hch@lst.de>,
	Jens Axboe <axboe@kernel.dk>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] block: Avoid mounting the bdev pseudo-filesystem in userspace
Date: Sat,  4 Jul 2026 08:31:04 -0400
Message-ID: <20260704123104.731912-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070221-hazing-urban-0aef@gregkh>
References: <2026070221-hazing-urban-0aef@gregkh>
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
index 5a631a0ca46a81..fe4848c77127cf 100644
--- a/block/bdev.c
+++ b/block/bdev.c
@@ -478,16 +478,12 @@ EXPORT_SYMBOL_GPL(blockdev_superblock);
 
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

