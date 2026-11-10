Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794317691;
	b=0ncIignCi5e//0s0jf6HJMZbd9z3FmqMvOfdoOXi9GkCZYCiXdNYTZAjzxtBxyUEkuoq
	 zjHE80s6jF15YFlkSzYDeDjf7xM3O1mm9yVJFlhWlL6mMFAfsyN90QJPUOApB8HhxPTQb
	 AaeIQ+o4URXDmi7d61uDN6nNnUZXBdJpF8IBgjKPBj8KC5nGePMud0nLAjEr/7i1KoeJy
	 CSV5dlz+wR9MHt+IIlBiKiH9p0EpRdsYBysuFOkk71YVcIopnwMr5ZWaEUHkJWuAm72AU
	 dHdBGWHtmRpxRiniKwYgIq4bdPWXM1X+F2G6UmexLHn/YbChMAEfjQXDrpqHMebpVWw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794317691;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=B/hkSPVYb069JnuauaaLCHP9Gm8Fu2aOM4Z1WIG/I4c=;
	b=kVKgZWf69uWly6DainQki+b+oZx5WwEHUTLMee70JuTx88nvUMDf4gTiD03LHUlTE3kz
	 NYCRsc8YUmCrjsu2FlbUNKBPeJnFJed8zwlKQQGR9m72EHpY4JaXvFk+r/SptyDQc2wOX
	 UJRgCv+E3WnvxP6XluVJPvTMxAOBFQc2C9C4dS/eaEriivMw9ycgzj1M087r7F5EUg2G2
	 m/zcHu5faHj7oPUIaH3PeU5YgdGIUb6RLtf0EaXyd3RDjkOOL9hPviP5ZRYScVMWy7vW3
	 5k4/wxVarZme1IQewehBoXsuDsDe3agMDenr7BY9yDW/fy93eN5S+kpeSnET4onb6aA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOZR89xP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF071606A330
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 13:34:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aOZR89xP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD6481F0089F;
	Tue, 10 Nov 2026 13:34:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794317690;
	bh=B/hkSPVYb069JnuauaaLCHP9Gm8Fu2aOM4Z1WIG/I4c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aOZR89xPSVGynzm9H6Q8OZ3ymHE5sATrk5IgohHK+eDu2IaHv/vR5awwztShznHKU
	 HwugvlV2MxSWjAT57NGSRreDOeltk+ut9rZyPYmaSRXZ57SnG8bPwDcUFEmnM8/P66
	 FDG7fMzOexslv5EHnxX2wgATYncsFrN0GmtlTdgZ7L1PLm1hYp31VwLzx+tVTXlrDi
	 K8lln7va4yIaLiCArv6VR2ffXQEFei684Ke5yIDAqY7kUAtIwC40BPW44WwJ2JCa2C
	 sO0Owk7rlXLef7XkK1trEavlh4GTonpABla03FJ3ubsTXpPkMdTNxoH04RGJ/2eguk
	 0UeSU1BHekDEw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	syzbot+f6c7e1f1809f235eeb90@syzkaller.appspotmail.com,
	Wang Jianjian <wangjianjian3@huawei.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] nilfs2: ignore non-fatal signals during synchronous log write wait
Date: Tue, 10 Nov 2026 08:34:48 -0500
Message-ID: <20261110133432.1746883-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061747-failed-5.10-7131aaa74bcc@kernel.org>
References: <20261107061747-failed-5.10-7131aaa74bcc@kernel.org>
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
[ sashal: preserved the older return-code comment layout instead of upstream's reformatted lists ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/ioctl.c    |  2 +-
 fs/nilfs2/recovery.c |  2 +-
 fs/nilfs2/segment.c  | 10 +++++-----
 3 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/nilfs2/ioctl.c b/fs/nilfs2/ioctl.c
index 9f10a9cec3e0a..e6db5b8190e3c 100644
--- a/fs/nilfs2/ioctl.c
+++ b/fs/nilfs2/ioctl.c
@@ -1011,7 +1011,7 @@ static int nilfs_ioctl_clean_segments(struct inode *inode, struct file *filp,
  *
  * %-ENOSPC - No space left on device (only in a panic state).
  *
- * %-ERESTARTSYS - Interrupted.
+ * %-EINTR - Interrupted.
  *
  * %-ENOMEM - Insufficient memory available.
  *
diff --git a/fs/nilfs2/recovery.c b/fs/nilfs2/recovery.c
index 33c4a97519de8..bf64a9eff4d15 100644
--- a/fs/nilfs2/recovery.c
+++ b/fs/nilfs2/recovery.c
@@ -750,7 +750,7 @@ static void nilfs_abort_roll_forward(struct the_nilfs *nilfs)
  *
  * %-ENOSPC - No space left on device (only in a panic state).
  *
- * %-ERESTARTSYS - Interrupted.
+ * %-EINTR - Interrupted.
  *
  * %-ENOMEM - Insufficient memory available.
  */
diff --git a/fs/nilfs2/segment.c b/fs/nilfs2/segment.c
index 18964331ee3d9..cc12f4dd2eee2 100644
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
@@ -2295,7 +2295,7 @@ static void nilfs_segctor_wakeup(struct nilfs_sc_info *sci, int err, bool force)
  *
  * %-ENOSPC - No space left on device (only in a panic state).
  *
- * %-ERESTARTSYS - Interrupted.
+ * %-EINTR - Interrupted.
  *
  * %-ENOMEM - Insufficient memory available.
  */
@@ -2332,7 +2332,7 @@ int nilfs_construct_segment(struct super_block *sb)
  *
  * %-ENOSPC - No space left on device (only in a panic state).
  *
- * %-ERESTARTSYS - Interrupted.
+ * %-EINTR - Interrupted.
  *
  * %-ENOMEM - Insufficient memory available.
  */
-- 
2.53.0

