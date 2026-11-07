Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046702;
	b=ChCz3o5RILBGv/8zHeya4lxchwhANuIXUVOXsynvCGM47ONQ5x4N9/0nEbaCzmw4Cj5F
	 a9AtATABO4IZcDKWOl/6wBUktSdF5BOGZa9fjz2PR7q4XMlC3RSZ37Bcg87Je3s4mvSUN
	 +zuj4KvJepmc8/+R7jdp28Rms0lSSAp7qd2kqeBD5i19eJW/I8kkRd8oj0Kej4zXAwcPG
	 OFjIQfkaTWw38pRZmwelHOlDtis8uBKNfef3eOuFN9b+vU2A/jKEzNvMSDY0LzLQSVpbK
	 Ev76CszwNPqe4jvV4O8JnuFPmw4AFQ3YNSfYdOpVupRydg00OVejmkJHROyjrfijADA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046702;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=yo+ABiY8I1duPEXmpBKxc9oSRH4xMf6/h5bCvsl8QbM=;
	b=vjfy8Ihprw6D8pXNsK/NGMNmnjW01QQ9xGKeiMtidYBzFhVJLMjykgtmfQZqy5MdlOAp
	 i6s8FWslqvZ5aYO/fQM0Yt51B1tmYMk9eRVMemctAcs7m5IeKKkuuNPHB0Gg94vWAL42v
	 6aACFK6fY922qruRHW+jP9TY4ocgsCWcLZT1t3HbSz3f0Ep8ZADf5q1cowzyiIeJ9cgiE
	 1cgmpnzzqH6L3DImRGlDdxbI/LE2BiD3xw1rLINSBSpU1wx2N2y2hO3fxoDFK8YmOyX3e
	 Ph8/VrvjDztjiGbBxTE84sURybIWDv/QPmyHflQxyYnpT/Y5PEcXAWWhcguoZ15+VcQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtHdn1dZ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E05D5606D80A
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XtHdn1dZ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45CFF1F008A2;
	Sat,  7 Nov 2026 10:18:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046701;
	bh=yo+ABiY8I1duPEXmpBKxc9oSRH4xMf6/h5bCvsl8QbM=;
	h=From:To:Cc:Subject:Date;
	b=XtHdn1dZ6oBxoaKVsjhscmxpAjp15j2uyVHYHGOuY5gAY7GHJ672n0zNuNZTRT1G5
	 qbVPx8/ZhZLmUfX2YRgHrL7DONE0mhJnqigBCMMGCa9TNrBAK3DPNshiFxXreqOG/o
	 JTdPp4lXy5ZBiRMecY6En87jEYbkgHN6OCpcUCTWK2jvk69ehZXuBrYAoAqi2XN/h5
	 j7I4kHajciOPMJDDfM5l5wPPSvanf2tjbcY62CagT6GZAUQ661H350UW+r2zO8IQLT
	 HK51LVWWYkKWIUsyqstu3SZ/v6pJNq+gXSBW+xy55+M2fKuHlGt4zLN7YB42usexWE
	 ZBGgmS76nPPTA==
From: Sasha Levin <sashal@kernel.org>
To: konishi.ryusuke@gmail.com,
	wangjianjian3@huawei.com,
	slava@dubeyko.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nilfs2: ignore non-fatal signals during synchronous log write wait" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:20 -0500
Message-ID: <20261107051820-failed-6.12-7131aaa74bcc@kernel.org>
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7131aaa74bcc7c9da1f1d1c8724da75c775557a0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051820-failed-6.12-7131aaa74bcc@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

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




