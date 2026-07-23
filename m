Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B7233426EB7;
	Thu, 23 Jul 2026 09:37:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784799433; cv=none; b=eDRXd1PESVlP9HhYhtTNstcr1WW1Zyx04lklmPA2y6v3oi6L2aumQlSWinJzWsNi681yQfSiiK12wz2DhCopAsmMZG5Ial79UkIeyp9jCz9eKAE2nQ8O6HbZkwDBE4ioUjiqAtL+PBlLcrzQokd9Zp5qOBl6zFBWMYG+N1cJOas=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784799433; c=relaxed/simple;
	bh=E21bKndicXb9nPqWpks3wCDr/RIfVKji5HgRH+1eRTM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=U2E1f+NAd1vjZ1+ExTFsP6QGKLB3XDUinF8hGGxa7IGWzvYZwukNjQz6ADQMKxIgzkJjsxX0Ym7OdYJtDIzag/pott8BE+yyD3f3EaHn2lS0u+8amQTDKlbLnZFdU/sgOkZAxOvcz2MLoHUpKZ0Ig2nhIohG4zSu/AhkoqPy3Mw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=efGx2Sdv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="efGx2Sdv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09EFE1F000E9;
	Thu, 23 Jul 2026 09:37:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784799431;
	bh=wS0B+J/0UPbtNMEW1T7fiql3q14N46+fo1IxT8HkylQ=;
	h=From:Date:Subject:To:Cc;
	b=efGx2SdvaHNjZvUP0CcEnWZg4SVpukzeSQ6hG3wlyyQ+JWW1gZpLvZ8I1bf4YF8yR
	 VNPgi6mPu+iWszAfrD8nXXDuqi0N4huP5adD4l2IGK3cfxI0OaZFFEYar5u9quaLK9
	 zCJq3co/cJIIP6e9wrK4W9w3DyOfAHzftUxxASwPV7TpAT23TZbPbph+v5exkWFDYo
	 3SlZKocv/l8Pb9FXd0qBiwlS9JXaBrfrPSbR/zgVd+0W55Y84TpgC57HC8Hw2gb+zy
	 BNn6JExZei8GtZjDLhObSLX26MO26zcM64gMDbNGi41O/JjH9NpEdwP7v0G5sn5pzE
	 X0w0Fk7BJPb0w==
From: Christian Brauner <brauner@kernel.org>
Date: Thu, 23 Jul 2026 11:37:05 +0200
Subject: [PATCH] super: fix emergency thaw deadlock on frozen block devices
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260723-work-super-emergency_thaw-v1-1-7c315c600245@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMDgYWoC/yWM2wrCMBAFf6Xk2ZU2QSX+iojksm2imJbdXpTSf
 zexj3M4M6tgpIgsrtUqCOfIsU8ZmkMlXDCpQ4g+s5C1PNcXqWDp6QU8DUiAb6QOk/s+xmAWMEq
 ftLdead+I7A+Ebfz827f7zjzZJ7qxBMvDGkawZJILZZpbPu7Gtv0AEyiUFJkAAAA=
X-Change-ID: 20260723-work-super-emergency_thaw-a3959dbd39d1
To: Jan Kara <jack@suse.cz>
Cc: linux-fsdevel@vger.kernel.org, Mateusz Guzik <mguzik@redhat.com>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, 
 Christian Brauner <brauner@kernel.org>, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org
X-Mailer: b4 0.16-dev-0e65f
X-Developer-Signature: v=1; a=openpgp-sha256; l=5206; i=brauner@kernel.org;
 h=from:subject:message-id; bh=E21bKndicXb9nPqWpks3wCDr/RIfVKji5HgRH+1eRTM=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQlPjiafpd/aup0Fa4nexfzXry29tyL0vhFpgozTf6F6
 4Qkzjl3qaOUhUGMi0FWTJHFod0kXG45T8Vmo0wNmDmsTCBDGLg4BWAi52Yx/OF3y+hdW3CuTWGC
 2oSZ9ewyx9/u+xDxevq9dYKHzsu53+Fl+MmYXur6oP3AvVWH/5xWf2itwGRa8mBFxPcqjjl3Vpj
 cfscAAA==
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

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
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 70dcb07e7fa5..ffdcc6a2e0de 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1082,16 +1082,30 @@ void emergency_remount(void)
 	}
 }
 
+static inline bool get_active_super(struct super_block *sb)
+{
+	bool active = false;
+
+	if (super_lock_excl(sb)) {
+		active = atomic_inc_not_zero(&sb->s_active);
+		super_unlock_excl(sb);
+	}
+	return active;
+}
+
 static void do_thaw_all_callback(struct super_block *sb, void *unused)
 {
-	if (!super_lock_excl(sb))
+	if (!get_active_super(sb))
 		return;
 
+	/* fs_bdev_thaw() acquires s_umount so it must not be held here */
 	if (IS_ENABLED(CONFIG_BLOCK))
 		while (sb->s_bdev && !bdev_thaw(sb->s_bdev))
 			pr_warn("Emergency Thaw on %pg\n", sb->s_bdev);
 
-	thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE, NULL);
+	if (super_lock_excl(sb))
+		thaw_super_locked(sb, FREEZE_HOLDER_USERSPACE, NULL);
+	deactivate_super(sb);
 }
 
 static void do_thaw_all(struct work_struct *work)
@@ -1117,17 +1131,6 @@ void emergency_thaw_all(void)
 	}
 }
 
-static inline bool get_active_super(struct super_block *sb)
-{
-	bool active = false;
-
-	if (super_lock_excl(sb)) {
-		active = atomic_inc_not_zero(&sb->s_active);
-		super_unlock_excl(sb);
-	}
-	return active;
-}
-
 static const char *filesystems_freeze_ptr = "filesystems_freeze";
 
 static void filesystems_freeze_callback(struct super_block *sb, void *freeze_all_ptr)

---
base-commit: c4fd59e777f64a23778ea199937ac1e32a5a1bc2
change-id: 20260723-work-super-emergency_thaw-a3959dbd39d1

