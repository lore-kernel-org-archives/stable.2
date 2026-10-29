Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=83.149.199.84
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793317173;
	b=hLaWoVmVziSuZu/FRxJqjyA20MBYa9jP0xgtlUEiTuYnNZq8vwu9S0sQo0y9sZGIhlSO
	 gPAkxGjn8wJmTfOGDRwvEUpzDhy6024uzaHUa7P2KjIUB7Kg3iuw2xgg/rOmDX8cFM2bQ
	 7sXItHZ0kAypwAF8h1a8x5FIfMKlcm4KKKDNF51wzCLGqu4cwiyKr1Jqf5y97Q0hwYb3Y
	 mbMz1WJTWi5zGycILkM1rYM86WvE5McHU9PMEmrIg3aXruMNCVNo25wHfZJojrdGo2qtW
	 CAuX+sN5T1HvI5SVmNww1BAE5EarJI8Sfnsp2gcKT1iE8ohkO2g6qSXPELyqiUwMSpg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793317173;
	h=DMARC-Filter:Received:DKIM-Filter:DKIM-Signature:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding;
	bh=HB9cSEdTJ/amGnN05Zpv8snyk4ZodBeLBtG1ryxGhPM=;
	b=PlejHMRaYNWeWq3VVHhfoCf3abGreiibdJcc7HcTbM6V7GiOJGOKVKHFkg7Jq7Nf/Ud5
	 synvjPI0bYzJThti1446baY6XldnfHHSp2UDztwmz4+vTwsrKS6DdMqTygkaoHTcDoJzf
	 3V8rPzhuKe27LiHPmWMZ8WtiP2qCchuUJ6jr96aHwlQIZlmLP6OdhQSz7i8dczVPWB/KC
	 ZrnsYZ7Zu6BUBc0bhG04UgwpLrRWtZhW3A7O5l9PwLWbSj4Js+Br8bEAgSBX9RQy2E+X4
	 R15Fet/SXVn8IRxgqoQxcFlckjUEEze0EVf4TxOFZMOakLYjlCCqZOndAkw+GJDScCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=ispras.ru;
	spf=pass smtp.mailfrom=ispras.ru;
	dkim=pass header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256 header.s=default header.b="Y/ExHUet";
	arc=none smtp.remote-ip=83.149.199.84
Received: from mail.ispras.ru (mail.ispras.ru [83.149.199.84])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3AF05606A321;
	Thu, 29 Oct 2026 23:39:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3AF05606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=ispras.ru
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=ispras.ru
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ispras.ru header.i=@ispras.ru header.a=rsa-sha256 header.s=default header.b=Y/ExHUet
Received: from fedora (unknown [92.101.175.163])
	by mail.ispras.ru (Postfix) with ESMTPSA id BBD90400E775;
	Thu, 29 Oct 2026 23:30:22 +0000 (UTC)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.ispras.ru BBD90400E775
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ispras.ru;
	s=default; t=1793316623;
	bh=HB9cSEdTJ/amGnN05Zpv8snyk4ZodBeLBtG1ryxGhPM=;
	h=From:To:Cc:Subject:Date:From;
	b=Y/ExHUetr4KFG1a35xqFGdy8aiOTGimmlgRB2O5YrLPXkjrIEV0Ht9G6mYIUunRbX
	 0aGr/oBKsWw2ddqujlW3oqJcuEvL5dUIE06/CulJXBrEvOICnAcrRZRSvtnON0P3yV
	 ocd7c0FxzW4+DGSd2LCtTHx4gErFpV87okSEfx5E=
From: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
To: stable@vger.kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexey Velichayshiy <a.velichayshiy@ispras.ru>,
	Mark Fasheh <mark@fasheh.com>,
	Joel Becker <jlbec@evilplan.org>,
	Joseph Qi <joseph.qi@linux.alibaba.com>,
	ocfs2-devel@oss.oracle.com,
	linux-kernel@vger.kernel.org,
	lvc-project@linuxtesting.org
Subject: [PATCH 5.10] ocfs2: add fl->fl_type check in ocfs2_flock() to fix use-after-free in lock_get_status
Date: Fri, 30 Oct 2026 02:26:31 +0300
Message-ID: <20261029232633.165310-1-a.velichayshiy@ispras.ru>
X-Mailer: git-send-email 2.56.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

No upstream commit exists for this patch.

The KASAN-reported issue described below is no longer reproduced after
upstream commit f7e33bdbd6d1 ("fs: remove mandatory file locking support"),
but that commit removes kernel functionality altogether and is therefore
not suitable for stable branches.

In ocfs2_flock() the __mandatory_lock(inode) check is performed without
taking the lock type into account. In the reproducer an FLOCK is first
taken on the file while its mode is 0100755, so the inode is not
mandatory-locked yet. Then chmod() changes the mode to 0106743 (S_ISGID
set, S_IXGRP cleared), which makes the inode mandatory-locked. Finally,
close() triggers a repeated call into ocfs2_flock() with
fl_type = F_UNLCK (0x2) and fl_flags = 0x42 to release the lock. By that
point __mandatory_lock() returns true, so the call is rejected
with -ENOLCK before reaching the unlock path. The FLOCK lock is therefore
left leaked (as reported by "Leaked FLOCK lock ..."), and a later read of
/proc/locks dereferences the already freed inode in lock_get_status(),
producing the use-after-free.

ocfs2: Mounting device (7,0) on (node local, slot 0) with ordered data mode.
Leaked FLOCK lock on dev=0x7:0x0 ino=0x4322  fl_owner=00000000d09f0d4d fl_flags=0x2 fl_type=0x1 fl_pid=1111
==================================================================
BUG: KASAN: use-after-free in lock_get_status+0x947/0x9e0 fs/locks.c:2930

CPU: 2 PID: 1116 Comm: syz-executor141 Not tainted 5.10.260-syzkaller #0
Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-debian-1.17.0-1 04/01/2014
Call Trace:
 __dump_stack lib/dump_stack.c:77 [inline]
 dump_stack+0x107/0x167 lib/dump_stack.c:118
 print_address_description.constprop.0+0x1c/0x220 mm/kasan/report.c:377
 __kasan_report mm/kasan/report.c:537 [inline]
 kasan_report.cold+0x1f/0x37 mm/kasan/report.c:554
 file_inode include/linux/fs.h:1343 [inline]
 lock_get_status+0x947/0x9e0 fs/locks.c:2930
 locks_show+0x178/0x270 fs/locks.c:3005
 seq_read_iter+0x50e/0x1230 fs/seq_file.c:230
 proc_reg_read_iter+0x20a/0x2e0 fs/proc/inode.c:310
 call_read_iter include/linux/fs.h:2042 [inline]
 do_iter_readv_writev+0x574/0x750 fs/read_write.c:738
 do_iter_read+0x2fc/0x760 fs/read_write.c:801
 vfs_readv+0xf0/0x160 fs/read_write.c:921
 do_preadv fs/read_write.c:1013 [inline]
 __do_sys_preadv fs/read_write.c:1063 [inline]
 __se_sys_preadv fs/read_write.c:1058 [inline]
 __x64_sys_preadv+0x235/0x310 fs/read_write.c:1058
 do_syscall_64+0x33/0x40 arch/x86/entry/common.c:46
 entry_SYSCALL_64_after_hwframe+0x67/0xd1

Following the pattern used by other __mandatory_lock() call sites (in
particular, the changes made for ocfs2_lock() in commit ee860b6a6503
("[PATCH] Skip check for mandatory locks when unlocking")), add
a lock-type check to ocfs2_flock(). With the patch applied, the KASAN
report is no longer reproduced.

Found by Linux Verification Center (linuxtesting.org) with Syzkaller.

Fixes: 53fc622b9e82 ("[PATCH 2/2] ocfs2: cluster aware flock()")
Signed-off-by: Alexey Velichayshiy <a.velichayshiy@ispras.ru>
---
 fs/ocfs2/locks.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ocfs2/locks.c b/fs/ocfs2/locks.c
index 7edc4e5c7c2c..1712f99ed120 100644
--- a/fs/ocfs2/locks.c
+++ b/fs/ocfs2/locks.c
@@ -103,7 +103,7 @@ int ocfs2_flock(struct file *file, int cmd, struct file_lock *fl)
 
 	if (!(fl->fl_flags & FL_FLOCK))
 		return -ENOLCK;
-	if (__mandatory_lock(inode))
+	if (__mandatory_lock(inode) && fl->fl_type != F_UNLCK)
 		return -ENOLCK;
 
 	if ((osb->s_mount_opt & OCFS2_MOUNT_LOCALFLOCKS) ||
-- 
2.55.0

