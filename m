Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794050269;
	b=ANULh/fsKWZYrEPO60FHEqcbC5+KzHm/jbbg6be4NWcA6aLRkkSptR1wAojbmTXsflAX
	 LZ7SQ0jsJBZf/aw1Ospbr6d3R6697bDHVjTCC4H5+ikiqvPk1BJZJzv52GehOdBXkBxoD
	 j7Y6HXPHbQGRg2gCLcjH+8Mnrz20Yfn1oiLR0Uj0YHC3fNoBiEOPyACSdLKN6/cqQmgUu
	 dcs//zfuir1r1JBz1VexdntFIxkbFj3Yg9taAokU9b094t2vQSzaX73IBQZ2bGatjzoIX
	 kkJgeZODu1veG6nru0bEVFmJmzZjjcaucqu2Sy+sVYFhdLk9F92nlHoBM8BZIZj8lWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794050269;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=bzcmIwOixN73XHqaktd7GhhqPMnS1WHEgdnAwk4E8Yc=;
	b=KxjuDu6W0Yq3KJWs5D3ajgMuTh0vKr4aXsoeXO924w9M4EdEKNyWamfFbQvOX7n1srKW
	 oYc9SxVlWsgQbhEFVvfbwiD06VjWQhyPvsapjz0XKhaxI6eusHhm1S15MLkkWZRyTj/D4
	 YAEEZLKcrWbSAfbzsLQ3xJyjRWzQ8UVT28H9vsdB/rXXvG5YZd1+D4o8qXRKLOq2jtpGC
	 prFKlY5p1/tF+QDL9Q+V2NHBUu7btLG25bAU+qvIk9SVvcxW6tnmHjb9ms7/DQ8xRBx8c
	 BqWaKbmYV7mxLmNxQ22w7nIUrWiE8J9wnp4jzrO6Na0CO1y7Zj6Nn96NilJZiYZlSGQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1TKZ26f;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43B26606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 11:17:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=K1TKZ26f
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3AF01F0089F;
	Sat,  7 Nov 2026 11:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794050269;
	bh=bzcmIwOixN73XHqaktd7GhhqPMnS1WHEgdnAwk4E8Yc=;
	h=From:To:Cc:Subject:Date;
	b=K1TKZ26fIlqq524z43O7cx4gjW/yX9n7XQUf4WxRSRJ3h9iJM8rLqHyk2tDDnIUIr
	 KONYjlYB904D2Hoyzd0X3R+RcE7EEnQC2fNtc3Hvg0wY1oXqgZ+7IhwV3VD+S92Slt
	 R05RdyVKRa3x8qzKOM2Z8C+wW6WZWNopJ3yg86T5zN8/DZxyLqoiQ7tlUvl2YaoWDI
	 YwhfbJGyqAaYMPkqa8OyjqlG0LkR4iZR76J1q285M7xicDKZ1a3BbCh293lF6eUxOb
	 GOvhEqP7yx/750xdjwy0cEDw53ajhpQ/0kKK5n098Yn3DYgfOzeatrOsv7CYEJ+Z5f
	 HiKqlEmLqEDww==
From: Sasha Levin <sashal@kernel.org>
To: konishi.ryusuke@gmail.com,
	wangjianjian3@huawei.com,
	slava@dubeyko.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nilfs2: ignore non-fatal signals during synchronous log write wait" failed to apply to 5.10-stable tree
Date: Sat,  7 Nov 2026 06:17:47 -0500
Message-ID: <20261107061747-failed-5.10-7131aaa74bcc@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7131aaa74bcc7c9da1f1d1c8724da75c775557a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107061747-failed-5.10-7131aaa74bcc@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7131aaa74bcc7c9da1f1d1c8724da75c775557a0 Mon Sep 17 00:00:00 2001
From: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Date: Wed, 30 Sep 2026 03:26:54 +0900
Subject: [PATCH] nilfs2: ignore non-fatal signals during synchronous log write
 wait

Based on a syzbot report, Wang Jianjian pointed out that following a
successful directory operation in nilfs_rename(), a synchronous write
requested within nilfs_transaction_commit(), triggered by a sync flag
set by nilfs_commit_chunk(), could be interrupted by a user signal.
This interruption leaves in-memory metadata updates intact while
returning an error, causing inconsistency with the VFS dentry cache and
ultimately triggering a kernel warning.

According to "signal(7)", local disks are not classified as "slow
devices" (such as terminals, FIFOs, or pipes) and their I/O operations
on disk devices are not interrupted by signals.  In kernel space,
waiting for such disk I/O should therefore not be aborted by ordinary
(non-fatal) signals.

Suppress this issue by modifying nilfs_segctor_sync(), which waits for
the log writer thread to complete synchronous writes, to catch only
fatal signals via fatal_signal_pending() and return -EINTR rather than
-ERESTARTSYS.  To complement this change and prevent the wait loop from
busy-looping when schedule() returns immediately due to a pending
non-fatal signal, switch the wait state from TASK_INTERRUPTIBLE to
TASK_KILLABLE.

This serves as an effective interim stabilization measure without
structural changes until a comprehensive fix for metadata consistency
is implemented.

Reported-by: syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f6c7e1f1809f235eeb90
Fixes: 9ff05123e3bf ("nilfs2: segment constructor")
Tested-by: syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com
Cc: Wang Jianjian <wangjianjian3@huawei.com>
Cc: stable@vger.kernel.org
Signed-off-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/nilfs2/ioctl.c    |  2 +-
 fs/nilfs2/recovery.c |  2 +-
 fs/nilfs2/segment.c  | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 01a04080ef704..b2b67d6a1f097 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -965,10 +965,10 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
  * Return: 0 on success, or one of the following negative error codes on
  * failure:
  * * %-EFAULT		- Failure during execution of requested operation.
+ * * %-EINTR		- Interrupted.
  * * %-EIO		- I/O error.
  * * %-ENOMEM		- Insufficient memory available.
  * * %-ENOSPC		- No space left on device (only in a panic state).
- * * %-ERESTARTSYS	- Interrupted.
  * * %-EROFS		- Read only filesystem.
  */
 static int nilfs_ioctl_sync(struct inode *inode, struct file *filp,
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 9a70c28ec94c1..abe4101f7550c 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -790,11 +790,11 @@ static void nilfs_abort_roll_forward(struct the_nilfs *nilfs)
  *
  * Return: 0 on success, or one of the following negative error codes on
  * failure:
+ * * %-EINTR		- Interrupted.
  * * %-EINVAL		- Inconsistent filesystem state.
  * * %-EIO		- I/O error.
  * * %-ENOMEM		- Insufficient memory available.
  * * %-ENOSPC		- No space left on device (only in a panic state).
- * * %-ERESTARTSYS	- Interrupted.
  */
 int nilfs_salvage_orphan_logs(struct the_nilfs *nilfs,
 			      struct super_block *sb,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 2f0e59847d026..af0c3560444f5 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2259,7 +2259,7 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
 	wake_up(&sci->sc_wait_daemon);
 
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_KILLABLE);
 
 		/*
 		 * Synchronize only while the log writer thread is alive.
@@ -2273,11 +2273,11 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
 			err = wait_req.err;
 			break;
 		}
-		if (!signal_pending(current)) {
+		if (!fatal_signal_pending(current)) {
 			schedule();
 			continue;
 		}
-		err = -ERESTARTSYS;
+		err = -EINTR;
 		break;
 	}
 	finish_wait(&sci->sc_wait_request, &wait_req.wq);
@@ -2311,10 +2311,10 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err, bool force)
  *
  * Return: 0 on success, or one of the following negative error codes on
  * failure:
+ * * %-EINTR		- Interrupted.
  * * %-EIO		- I/O error (including metadata corruption).
  * * %-ENOMEM		- Insufficient memory available.
  * * %-ENOSPC		- No space left on device (only in a panic state).
- * * %-ERESTARTSYS	- Interrupted.
  * * %-EROFS		- Read only filesystem.
  */
 int nilfs_construct_segment(struct super_block *sb)
@@ -2341,10 +2341,10 @@ int nilfs_construct_segment(struct super_block *sb)
  *
  * Return: 0 on success, or one of the following negative error codes on
  * failure:
+ * * %-EINTR		- Interrupted.
  * * %-EIO		- I/O error (including metadata corruption).
  * * %-ENOMEM		- Insufficient memory available.
  * * %-ENOSPC		- No space left on device (only in a panic state).
- * * %-ERESTARTSYS	- Interrupted.
  * * %-EROFS		- Read only filesystem.
  */
 int nilfs_construct_dsync_segment(struct super_block *sb, struct inode *inode,
-- 
2.53.0




