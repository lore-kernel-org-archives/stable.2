Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0FA62D8DDF
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 15:48:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786204139; cv=none; b=EMAUKvYKsJ+1Vuta4choB91HPaOnsOcGsMMvxysge/afTYC04nkaTAZ2XRSaGGHXXluTn2592uCn1GP5TaIhRAgORhV6mGWi1Y/wvDJl20WyF5lZ2AToUYwOqz+NNnRzgBMZ3g6NUs1v/EelR3HW0DarThuZaTlqgATnjBnOMm0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786204139; c=relaxed/simple;
	bh=8JXoHkfIs44Yqm9pxVpr7qnqm1iv1BwgjMCBprOMeOo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rb9RsHKHkjM4mUrw44vZEpKRbkrj8w8bAeDQtYkYGESStblp4IZN5aqm3cUR50zfx6PpQVbfms4FHpCEgrOBUCr28Y/ZkzukqHWMplaNT0InmwAk0/3pWYD07ZpESvAWwurvsEoYUDN2hNRhjGiLVw2V3j7dTwxD4l8w7Q25GwM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=db6OcLhj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="db6OcLhj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4913B1F00A3E;
	Sat,  8 Aug 2026 15:48:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786204137;
	bh=qqQMWyxmd2Y7Xvg+EN5XahtFLVDyS7Dp/P/baOwLh1A=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=db6OcLhjMLE0UJU7yfu5lX5M4ZzW4miTPpwysA9EIaj95bEvB3Yn1XQNsXc3OuFYn
	 OGkGQYdA2B+qUfqP0LRPOay/WyrlfelS22fz+edI+FTZ2wz1FnJ3gMjh92IpGLg0cj
	 e+QM/ehA/LzoAK0iyKrewtHoG1+iU3woluSgSSXf29mM8KUqC6jP9NQM9iT5vtFEGQ
	 czb2lN42OcchC0BOzbY8r5RNwe7iLAbX4bBV4wv3d1RCqFl09Lt8oaQXPLRsCkNhWq
	 JSAe46tjXQLUXTIqWRuwr7k2ncVG9KtL8qVMw7Efc3tjGuJaKJJe+5kcVYlSm0Yr28
	 b5ZW2xeTO2xlA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chen Changcheng <chenchangcheng@kylinos.cn>,
	"Christian Brauner (Amutable)" <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/6] fs/super: fix emergency thaw double-unlock of s_umount
Date: Sat,  8 Aug 2026 11:48:51 -0400
Message-ID: <20260808154852.370323-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260808154852.370323-1-sashal@kernel.org>
References: <2026072927-mom-flyover-909f@gregkh>
 <20260808154852.370323-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chen Changcheng <chenchangcheng@kylinos.cn>

[ Upstream commit 503d67fbaec6fdeaba391cb497675071db9d16ea ]

do_thaw_all() iterates over all superblocks via __iterate_supers()
with SUPER_ITER_EXCL, which acquires s_umount exclusively before
calling the callback and releases it afterwards. However, the
callback do_thaw_all_callback() calls thaw_super_locked() which
unconditionally releases s_umount on every code path. This results
in a second unlock attempt in __iterate_supers() that corrupts the
rwsem state, triggering a DEBUG_RWSEMS warning:

[  182.601148] sysrq: Emergency Thaw of all frozen filesystems
[  182.601865] ------------[ cut here ]------------
[  182.602375] DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && !rwsem_test_oflags(sem, RWSEM_NONSPINNABLE)): count = 0x0, magic = 0xffff99b1011e5870, owner = 0x0, curr 0xffff99b101b06c80, list not empty
[  182.603817] WARNING: kernel/locking/rwsem.c:1412 at up_write+0xa3/0x170, CPU#2: kworker/2:1/53
[  182.604578] Modules linked in:
[  182.604864] CPU: 2 UID: 0 PID: 53 Comm: kworker/2:1 Not tainted 7.2.0-rc4-00001-gbd3bd93ea98a-dirty #4 PREEMPT(lazy)
[  182.605711] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.13.0-1kylin1 04/01/2014
[  182.606417] Workqueue: events do_thaw_all
[  182.606750] RIP: 0010:up_write+0xaf/0x170
[  182.607076] Code: 19 3a 92 48 0f 44 c2 48 8b 55 08 48 8b 55 00 4c 8b 45 08 48 8b 55 00 48 8d 3d ad 91 e0 01 48 8b 4d 20 50 48 c7 c6 f0 8c 26 92 <67> 48 0f b9 3a e8 d7 93 4e 00 58 eb 81 48 83 7f 18 00 48 c7 c2 8d
[  182.608563] RSP: 0018:ffffb670001d7e08 EFLAGS: 00010246
[  182.609007] RAX: ffffffff92349e8d RBX: 0000000000000000 RCX: ffff99b1011e5870
[  182.609595] RDX: 0000000000000000 RSI: ffffffff92268cf0 RDI: ffffffff92914d10
[  182.610283] RBP: ffff99b1011e5870 R08: 0000000000000000 R09: ffff99b101b06c80
[  182.610847] R10: ffff99b10139a808 R11: fefefefefefefeff R12: 0000000000000000
[  182.611414] R13: ffffffff90cf74d0 R14: 0000000000000000 R15: ffff99b1011e5800
[  182.612009] FS:  0000000000000000(0000) GS:ffff99b1eaaee000(0000) knlGS:0000000000000000
[  182.612670] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  182.613146] CR2: 00000000005c631c CR3: 00000000013ee000 CR4: 00000000000006f0
[  182.613722] Call Trace:
[  182.613946]  <TASK>
[  182.614130]  __iterate_supers+0x128/0x150
[  182.614463]  do_thaw_all+0x1b/0x30
[  182.614759]  process_scheduled_works+0xbb/0x3f0
[  182.615150]  ? __pfx_worker_thread+0x10/0x10
[  182.615499]  worker_thread+0x129/0x270
[  182.615816]  ? __pfx_worker_thread+0x10/0x10
[  182.616201]  kthread+0xe2/0x120
[  182.616469]  ? __pfx_kthread+0x10/0x10
[  182.616792]  ret_from_fork+0x15b/0x240
[  182.617115]  ? __pfx_kthread+0x10/0x10
[  182.617426]  ret_from_fork_asm+0x1a/0x30
[  182.617761]  </TASK>
[  182.617968] ---[ end trace 0000000000000000 ]---
[  182.618412] Emergency Thaw complete

Fix this by switching to SUPER_ITER_UNLOCKED and acquiring s_umount
in the callback via super_lock_excl() before calling
thaw_super_locked(). This matches the locking pattern expected by
thaw_super_locked() and eliminates the double unlock.

While at it, remove the dead 'return;' at the end of
do_thaw_all_callback().

Fixes: 2992476528ae ("super: use a common iterator (Part 1)")
Cc: stable@vger.kernel.org
Signed-off-by: Chen Changcheng <chenchangcheng@kylinos.cn>
Link: https://patch.msgid.link/20260721064140.152305-1-chenchangcheng@kylinos.cn
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Stable-dep-of: 749d7aa0377a ("super: fix emergency thaw deadlock on frozen block devices")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/super.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index adfaee9e20297..fb047959526fd 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1144,16 +1144,19 @@ void emergency_remount(void)
 
 static void do_thaw_all_callback(struct super_block *sb, void *unused)
 {
+	if (!super_lock_excl(sb))
+		return;
+
 	if (IS_ENABLED(CONFIG_BLOCK))
 		while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
 			pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
+
 	thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE);
-	return;
 }
 
 static void do_thaw_all(struct work_struct *work)
 {
-	__iterate_supers(do_thaw_all_callback, NULL, SUPER_ITER_EXCL);
+	__iterate_supers(do_thaw_all_callback, NULL, SUPER_ITER_UNLOCKED);
 	kfree(work);
 	printk(KERN_WARNING "Emergency Thaw complete\n");
 }
-- 
2.53.0

