Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317242;
	b=G8LAyBiWYays1QhJxFVrayzkLWT/PiG93txcivJP5dG8ydZzk/CC20LcwtnqNLOTg1Cb
	 FLaIPiBoUjd0E4gsGFvOzwgnXCZdCB1gm7Q5dt4jVygDqd0vxIrsJ2IfvoRYn9zmU+6Po
	 HBHva/wwWQjP/GoREDI4lQCh2YduFGMcyhRKvyLnfiqyFNptnL5uB6TJJDb5l/2I+KBxC
	 lynuy3MK5+bdNIr2iUgC/a7T5QoOP03gBrbcq3j0cMkCaC61aE4d5GqfyD3zWGvdZQwQC
	 5eWEaUM1fYauE+43bPBLFJ/dpIHeJUBA7nuZffve3ACcMf+HfwrH7u1uEtpKYyhXANw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317242;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=edaLXm6QCGx2QuvsaZzcl5Q80kfX+oQWzIkVBROPALw=;
	b=VPq6dJSOwdBMqmetcgEa04XoKPCPbHdxif8vHauwpuO9LGQYtVb7oPFTpQ2Dk+JaCzfN
	 /GeaorG4FbqUfryBcfjzXQzgiiM4M+48a5TpXM20a3KQLhK2MYMX/OPUk/FqijMH2wXcJ
	 GeKfPKGVvn29UI0rtrUKc2Gu+JxF5dMp94qJKA/Z/ARi84RnVfsITNj+L4qQFM7SioPsy
	 umE0PQfun4sHHrRL0QHZ8m52ajIDQS/4wcPAsJJUq51WjUFpOKcwdy2pUtTGZZEU95Q/6
	 ACvXd1pQe+7WywqZBmvIthPtGASvw41ZvsYTR5E/bBFNpQCnWD4UZGJYzQWHm/RjZkg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbKWgYdH;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9B22F606A9CF
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:27:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QbKWgYdH
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 878001F0089F;
	Tue, 10 Nov 2026 13:27:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317242;
	bh=edaLXm6QCGx2QuvsaZzcl5Q80kfX+oQWzIkVBROPALw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QbKWgYdHnxz8JsCLfxCOT/8EmiPF4mIDQIfSviU2oRMMQTBomJFJPCjqrBE+g70eD
	 3LXYEloQM2VIoVCoKPsVNXjYEfGuzHkx6AqAS61PFAH5oeDEgp8qYIjlWlRc2zFulk
	 k8wI7GU0VSAVIWRYgO390J9DgNxFgnGuuJmHrd7LJTYRD7ScaI3ZTn92XzsI9m1rGc
	 1EFYfhythGe79xlbX3QEWRAY3EcJtxeN0my+pVuACbzLZ1NXS9cX1ILw9hPvJy1Xye
	 9Z4Jx1i5pzyz/xhuCfaSP+98XjRbZmn/rbQI7qTlCFHn1ckbM56j6Kake8bQ52c2Ri
	 ppQiPYKLgseuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com,
	Wang Jianjian <wangjianjian3@huawei.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] nilfs2: ignore non-fatal signals during synchronous log write wait
Date: Tue, 10 Nov 2026 08:27:19 -0500
Message-ID: <20261110132713.1736389-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110132713.1736389-1-sashal@kernel.org>
References: <20261107060105-failed-5.15-7131aaa74bcc@kernel.org>
 <20261110132713.1736389-1-sashal@kernel.org>
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

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

[ Upstream commit 7131aaa74bcc7c9da1f1d1c8724da75c775557a0 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/ioctl.c    |  2 +-
 fs/nilfs2/recovery.c |  2 +-
 fs/nilfs2/segment.c  | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index baa43a13b7a87..3f3909b77bcdf 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -960,10 +960,10 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
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
index 10c59d2c83447..0f5161df0709b 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -743,11 +743,11 @@ static void nilfs_abort_roll_forward(struct the_nilfs *nilfs)
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
index a1a091a20d041..3efadc2c6a031 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2234,7 +2234,7 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
 	wake_up(&sci->sc_wait_daemon);
 
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_KILLABLE);
 
 		/*
 		 * Synchronize only while the log writer thread is alive.
@@ -2248,11 +2248,11 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
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
@@ -2286,10 +2286,10 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err, bool force)
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
@@ -2318,10 +2318,10 @@ int nilfs_construct_segment(struct super_block *sb)
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

