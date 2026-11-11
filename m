Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.227
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794362278;
	b=UC5WkOpS1EN8E/y+G12Sl8idRnQ9n5aeDveoL+SmA8XwEf6SAY4UppWnUuYdMMy3L0al
	 qDdeoSRrtMXwVzacaB2NNFes+pniuh849jNyEOSTNdekvcB35VohMkr+Au3g0BSTiuoS8
	 uBuitWxA4lZ9Dap+hsHG1BU9Cs4u18xeoiW0K3DH9p3AS5osDmjrF34k2WjjQBmjMBEL1
	 YrvVQEUPVekO9uBaoU4Dq51nGtDP3NLYlJl/qh+a7PJ6Pn01qVtOnF2eEcjjr+iDPjquV
	 GwePLaO1LcyL8tmBJMSKylj7s0wzhVbYoO/E+Naj3+9t1kYZD5q8Q0K1GkUbtbTEmJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794362278;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=GIeqgOY/hV3rqp+wmVv6tRmfkrHrGjE6fkF66Xde2/4=;
	b=Dpd7hGHmJJlnxcscfWgELDbD/n+bnPmn4yf6vTYtEVUEt8nqCAaH+pFW4CEcnBIk2oUX
	 XLvx1VUQVVv2E62cgX2QOKAT192upb3XrPip597SDTGDjBdymw1S4cEhXnjCmBG+YK1s4
	 55BPaKo17M7RiyKsjPfrBNBxDWHWTjblBk2DrVJ6GGF0NSHbDKrZ0vaNW3L6sv9lyCk1i
	 Biyf1rzFceyBqVSItv4iwNGg10PXs3/mtkkki5tz5upi/xrL93s4u9dNYtvrZBgMWsBck
	 trF47Epw6ypy6aAReexRi9O/LiiEaWgyrRll/dFNBg6oBcME95Po9MdumNwlhlH73jQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=N8yU1PbC;
	arc=none smtp.remote-ip=113.46.200.227
Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D1FC606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:57:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D1FC606A32E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=N8yU1PbC
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=GIeqgOY/hV3rqp+wmVv6tRmfkrHrGjE6fkF66Xde2/4=;
	b=N8yU1PbCAi7vh4c6YQP7baRzKNnMPGl44PNCmfw8SmvmoCvQsWhK3wRWhfmSrGv7rSDdCK7rL
	iVbxrkpBIxaX4EX58YbQw9IE2/py6Sz3LJ1oXyeAQgMt7/cw7tN33Fk00cyZ7L/+YmJoUv8WPPY
	6QvDC7mSpCWrP82qJhBpSZM=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4jPRVt31WRznTVm;
	Wed, 11 Nov 2026 09:57:58 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id 651B740578;
	Wed, 11 Nov 2026 09:57:53 +0800 (CST)
Received: from huawei.com (10.113.213.244) by kwepemf200016.china.huawei.com
 (7.202.181.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 11 Nov
 2026 09:57:52 +0800
From: Wang Jianjian <wangjianjian3@huawei.com>
To: <stable@vger.kernel.org>
CC: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	<syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com>, Wang Jianjian
	<wangjianjian3@huawei.com>, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 6.1.y] nilfs2: ignore non-fatal signals during synchronous log write wait
Date: Wed, 11 Nov 2026 09:55:26 +0800
Message-ID: <20261111015526.590711-1-wangjianjian3@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107054332-failed-6.1-7131aaa74bcc@kernel.org>
References: <20261107054332-failed-6.1-7131aaa74bcc@kernel.org>
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
Content-Type: text/plain
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
 kwepemf200016.china.huawei.com (7.202.181.9)

From: Ryusuke Konishi <konishi.ryusuke@gmail.com>

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
(cherry picked from commit 7131aaa74bcc7c9da1f1d1c8724da75c775557a0)
---
 fs/nilfs2/ioctl.c    |  2 +-
 fs/nilfs2/recovery.c |  4 ++--
 fs/nilfs2/segment.c  | 14 +++++++-------
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 4e964549bc4c..cbbe49bb4926 100644
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
index ce30b51ac593..249be54f7732 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -744,14 +744,14 @@ static void nilfs_abort_roll_forward(struct the_nilfs *nilfs)
  * Return Value: On success, 0 is returned.  On error, one of the following
  * negative error code is returned.
  *
+ * %-EINTR - Interrupted.
+ *
  * %-EINVAL - Inconsistent filesystem state.
  *
  * %-EIO - I/O error
  *
  * %-ENOSPC - No space left on device (only in a panic state).
  *
- * %-ERESTARTSYS - Interrupted.
- *
  * %-ENOMEM - Insufficient memory available.
  */
 int nilfs_salvage_orphan_logs(struct the_nilfs *nilfs,
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index a412abdfbbf3..2355ed02045c 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2236,7 +2236,7 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
 	wake_up(&sci->sc_wait_daemon);
 
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_KILLABLE);
 
 		/*
 		 * Synchronize only while the log writer thread is alive.
@@ -2250,11 +2250,11 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
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
@@ -2289,14 +2289,14 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err, bool force)
  * Return Value: On success, 0 is returned. On errors, one of the following
  * negative error code is returned.
  *
+ * %-EINTR - Interrupted.
+ *
  * %-EROFS - Read only filesystem.
  *
  * %-EIO - I/O error
  *
  * %-ENOSPC - No space left on device (only in a panic state).
  *
- * %-ERESTARTSYS - Interrupted.
- *
  * %-ENOMEM - Insufficient memory available.
  */
 int nilfs_construct_segment(struct super_block *sb)
@@ -2324,14 +2324,14 @@ int nilfs_construct_segment(struct super_block *sb)
  * Return Value: On success, 0 is returned. On errors, one of the following
  * negative error code is returned.
  *
+ * %-EINTR - Interrupted.
+ *
  * %-EROFS - Read only filesystem.
  *
  * %-EIO - I/O error
  *
  * %-ENOSPC - No space left on device (only in a panic state).
  *
- * %-ERESTARTSYS - Interrupted.
- *
  * %-ENOMEM - Insufficient memory available.
  */
 int nilfs_construct_dsync_segment(struct super_block *sb, struct inode *inode,
-- 
2.34.1

