Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=113.46.200.217
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794361857;
	b=TbR7VaUAyGfeva4J5STqDWBRIbLN8uURmkpXlPM7d1XtM/IEFXVjjHAr/noD5eLFfQkb
	 8tPzNwAAFc5xY4XhOZeZONdKJulk/TZW9PerY+LJxrNq4mJrkgIXjoAfse4uGWj6fOkn3
	 iNgVexjgTr+J5kdt8TGFApQAX74rip/TBKXAK7H0EEfHNvHbhGk3xoaqhlATeubbBwSpg
	 uBhIoQjJiVNC2EF/OXgcTQuPMkLOCFCpHF6ele8c8LQEdhE9lUdzsDOAkynyQRpzxfuyq
	 BAaCFE83LlkUbyCIo0kAAY2bGgq1GL1JkclRvJ2VaPL/2ERk22b0K4Q+DM3tEqOg4GA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794361857;
	h=DMARC-Filter:dkim-signature:Received:Received:Received:From:To:CC:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:Content-Type:X-Originating-IP:
	 X-ClientProxiedBy;
	bh=T9rLydvHm6qk1ej1Vxxodze997ocqSQCGobHTzm/HAs=;
	b=yhP3CnmYU3X0pN8hvtyXusflEevhCyEcGmwM1f74qE30Sdjhx8owJ7ziJ470NU8Gc+aH
	 nHp0i45AmPJV9IvLXHhWqoWBzc4uYLqEAxiH44ceIQ3G2+dANG93HB/1ZYi1eRRmnfNIe
	 w69grSk/8jv/mia5owUH93JsBrIJZkoaTA1nbTlUsZASKiBPJP7qbuuXv159Xhs9PFVqX
	 FYDOL2oyXlNXbc+BbJcH7VUB96vocY638cBfmvrk9s5tKUkBkuzBBlFe3JVQQ/vqu78gy
	 TVI/mijE3mYt0RYgzIQ8UrSoXLs8nfd3RT2il46ezDX/QsWFle0fmVm+FQPuuG653Dg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=huawei.com;
	spf=pass smtp.mailfrom=huawei.com;
	dkim=pass header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=MZg8npyt;
	arc=none smtp.remote-ip=113.46.200.217
Received: from canpmsgout02.his.huawei.com (canpmsgout02.his.huawei.com [113.46.200.217])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35229606A321
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 01:50:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 35229606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.a=rsa-sha256 header.s=dkim header.b=MZg8npyt
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=T9rLydvHm6qk1ej1Vxxodze997ocqSQCGobHTzm/HAs=;
	b=MZg8npytXlgU8aLjaddPjvykTiQXWOib/o6ue3UYwm6jYohVWiuS89e5FxEVHo0Kk8vGQGnz2
	0tnf3BYTWcqKr1HG9MkDxhOrugpWOjT90Ej/N1ei+PBOXF1eBJQQo5rjoNg3nMvC4lij332dLyC
	kT6/0Tf9I7Py8Npa7mvHS/8=
Received: from mail.maildlp.com (unknown [172.19.162.140])
	by canpmsgout02.his.huawei.com (SkyGuard) with ESMTPS id 4jPRKy4B62zcbRg;
	Wed, 11 Nov 2026 09:50:14 +0800 (CST)
Received: from kwepemf200016.china.huawei.com (unknown [7.202.181.9])
	by mail.maildlp.com (Postfix) with ESMTPS id A4973202E6;
	Wed, 11 Nov 2026 09:50:53 +0800 (CST)
Received: from huawei.com (10.113.213.244) by kwepemf200016.china.huawei.com
 (7.202.181.9) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Wed, 11 Nov
 2026 09:50:53 +0800
From: Wang Jianjian <wangjianjian3@huawei.com>
To: <stable@vger.kernel.org>
CC: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	<syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com>, Wang Jianjian
	<wangjianjian3@huawei.com>, Viacheslav Dubeyko <slava@dubeyko.com>
Subject: [PATCH 6.6.y] nilfs2: ignore non-fatal signals during synchronous log write wait
Date: Wed, 11 Nov 2026 09:48:27 +0800
Message-ID: <20261111014827.561987-1-wangjianjian3@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261107053051-failed-6.6-7131aaa74bcc@kernel.org>
References: <20261107053051-failed-6.6-7131aaa74bcc@kernel.org>
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
index f8c53a411d54..d15d88571fe2 100644
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
index be6730482520..be774d69ae23 100644
--- a/fs/nilfs2/segment.c
+++ b/fs/nilfs2/segment.c
@@ -2245,7 +2245,7 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
 	wake_up(&sci->sc_wait_daemon);
 
 	for (;;) {
-		set_current_state(TASK_INTERRUPTIBLE);
+		set_current_state(TASK_KILLABLE);
 
 		/*
 		 * Synchronize only while the log writer thread is alive.
@@ -2259,11 +2259,11 @@ static int nilfs_segctor_sync(struct nilfs_sc_info *sci)
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
@@ -2298,14 +2298,14 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err, bool force)
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
@@ -2333,14 +2333,14 @@ int nilfs_construct_segment(struct super_block *sb)
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

