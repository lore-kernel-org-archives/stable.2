Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AAEC2E229F
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 04:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786249186; cv=none; b=buhnsP7Z9nwG1nurVv0EPkkyD/hYTN7s1fFp8n9oM/gU/yHju4dGrHDViZeXpThw5QO6N85Rqrb0aODK+llAmyEzU8HabLSfMyaCS3JOy4infp1UaKlk0d5wBReKvWJNFLBhJqUArmXAoEfXJgc0DW+YaOJIg3qmWhgC7dL0gFg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786249186; c=relaxed/simple;
	bh=FYrkRfguOKp+MKRajF2w3nwLlh4/Qrg8RdHhswbf0Nk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jRu7K6Bf85MnSTLrGbzUbA8PXqp+qODQWqkQ4tyUQ4507ehOmQq9d8KZ1ALF/Q7T+8Xo3+WJXmWP/1ITQc/9z/mCJBkEAXGzLdhciiAQySGCjUrWNcmkSzXmpz2kaLJrLLhWg7OQ94KdiOadr6mgT/DU8d/bsYRgZMj1Ztxyzxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=B5jNpV+4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="B5jNpV+4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D02CC1F000E9;
	Sun,  9 Aug 2026 04:19:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786249185;
	bh=KlkzNf52h+qxswnAR6e12zy/TKs09uXi02+th9QMTs0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=B5jNpV+48KD0gF0Vg5amNBAezLUqsViTGpawsdIjPyuickrIkAoW9X7NZsLy7a/Sy
	 GaRa8pD5pwOFMOtBDk3syV59dCXo8EZcf4D7zF2Z/JEepiZnHjIkyWtaBDBmhIpup3
	 LswuwIFboWUbHHKf9t2s2Qmdl+BZm+nFETaIBX9BeVCvHZtAhLUqT2iJR5OlYF2fGk
	 5TJ4lbd7SXoO2s2DyA+xFzBeva2aC6mEcSLU4FnWcdxwa2nuIpK8HsAA2DHWTaFOIV
	 uhvWxaXQ/k9qRNfAw6JgotCb7ysG9iL0lx1rdBvbUm8XP/v7AqUJJ+e4yCZ+zmVui4
	 Wf/uIApcWVjsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] super: fix emergency thaw deadlock on frozen block devices
Date: Sun,  9 Aug 2026 00:19:43 -0400
Message-ID: <20260809041943.1092620-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072928-camcorder-hamlet-7841@gregkh>
References: <2026072928-camcorder-hamlet-7841@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 749d7aa0377aae32af8c0a4ad43371e7bf830ab5 ]

do_thaw_all_callback() calls bdev_thaw() while holding sb->s_umount
exclusively. If the block device was frozen via bdev_freeze() dropping
the last block layer freeze reference calls fs_bdev_thaw() which
reacquires s_umount:

  do_thaw_all_callback(sb)
    super_lock_excl(sb)                     # holds sb->s_umount
    bdev_thaw(sb->s_bdev)
      mutex_lock(&bdev->bd_fsfreeze_mutex)
      # bd_fsfreeze_count drops 1 -> 0
      bd_holder_ops->thaw == fs_bdev_thaw
        get_bdev_super(bdev)
          bdev_super_lock(bdev, true)
            super_lock(sb, true)
              down_write(&sb->s_umount)     # same task: deadlock

The emergency thaw worker deadlocks against itself holding both
s_umount and bd_fsfreeze_mutex. That fscks any subsequent unmount,
freeze, or thaw of that filesystem and block device.

  [   81.878470] sysrq: Show Blocked State
  [   81.880140] task:kworker/0:1     state:D stack:0     pid:11    tgid:11    ppid:2      task_flags:0x4208060 flags:0x00080000
  [   81.884876] Workqueue: events do_thaw_all
  [   81.886656] Call Trace:
  [   81.887759]  <TASK>
  [   81.888763]  __schedule+0x579/0x1420
  [   81.890372]  schedule+0x3a/0x100
  [   81.891794]  schedule_preempt_disabled+0x15/0x30
  [   81.893848]  rwsem_down_write_slowpath+0x1ea/0x900
  [   81.895191]  ? __pfx_do_thaw_all_callback+0x10/0x10
  [   81.896528]  down_write+0xbd/0xc0
  [   81.897505]  super_lock+0x91/0x180
  [   81.898457]  ? __mutex_lock+0xa99/0x1140
  [   81.900748]  ? __mutex_unlock_slowpath+0x1f/0x400
  [   81.902069]  bdev_super_lock+0x5b/0x150
  [   81.903132]  get_bdev_super+0x10/0x60
  [   81.904042]  fs_bdev_thaw+0x23/0xf0
  [   81.904755]  bdev_thaw+0x82/0x100
  [   81.905484]  do_thaw_all_callback+0x2c/0x50
  [   81.906298]  __iterate_supers+0x5d/0x130
  [   81.907067]  do_thaw_all+0x20/0x40
  [   81.907739]  process_one_work+0x206/0x5e0
  [   81.908545]  worker_thread+0x1e2/0x3c0
  [   81.909339]  ? __pfx_worker_thread+0x10/0x10
  [   81.910171]  kthread+0xf4/0x130
  [   81.910799]  ? __pfx_kthread+0x10/0x10
  [   81.911528]  ret_from_fork+0x2e2/0x3b0
  [   81.912259]  ? __pfx_kthread+0x10/0x10
  [   81.913010]  ret_from_fork_asm+0x1a/0x30
  [   81.913806]  </TASK>

bdev_super_lock() even documents the violated requirement with
lockdep_assert_not_held(&sb->s_umount).

Acquiring bd_fsfreeze_mutex under s_umount also inverts the
bd_fsfreeze_mutex vs. s_umount ordering established by
bdev_{freeze,thaw}() and can thus ABBA against a concurrent block-layer
freeze even when the recursive path isn't hit.

Fix this by not holding s_umount around the bdev_thaw() loop at all. Pin
the superblock with an active reference instead as
filesystems_freeze_callback() does. The active reference keeps the
superblock from being shut down and so ->s_bdev stays valid without
holding s_umount. The block-layer-held freeze is dropped by
fs_bdev_thaw() with FREEZE_MAY_NEST | FREEZE_HOLDER_USERSPACE exactly as
a regular unfreeze would and thaw_super_locked() handles
filesystem-level freezes as before.

The emergency thaw path has deadlocked like this in one form or
another for a long long time but the current exclusively-held
shape dates back to commit [1] where thaw_bdev() already ended in
thaw_super() with s_umount held by do_thaw_all_callback().

Fixes: 08fdc8a0138a ("buffer.c: call thaw_super during emergency thaw") [1]
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20260723-work-super-emergency_thaw-v1-1-7c315c600245@kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/super.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index b116f72cd122a..87838f342d3dc 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1045,13 +1045,24 @@ void emergency_remount(void)
 
 static void do_thaw_all_callback(struct super_block *sb)
 {
+	bool active = false;
+
 	down_write(&sb->s_umount);
-	if (sb->s_root && sb->s_flags & SB_BORN) {
-		emergency_thaw_bdev(sb);
+	if (sb->s_root && sb->s_flags & SB_BORN)
+		active = atomic_inc_not_zero(&sb->s_active);
+	up_write(&sb->s_umount);
+	if (!active)
+		return;
+
+	/* thaw_bdev() acquires s_umount so it must not be held here */
+	emergency_thaw_bdev(sb);
+
+	down_write(&sb->s_umount);
+	if (sb->s_root && sb->s_flags & SB_BORN)
 		thaw_super_locked(sb);
-	} else {
+	else
 		up_write(&sb->s_umount);
-	}
+	deactivate_super(sb);
 }
 
 static void do_thaw_all(struct work_struct *work)
-- 
2.53.0

