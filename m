Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 584C01531E8
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 13:53:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786283639; cv=none; b=M+hsVsFKxedTlRBebea93KqSRTolxp+UI3D00W+YWSY0a3pKosP52F7AhkoHi7oHWxGpd3NaNRvhYyv2I7YvaOU7zN9pglZFISOTDQYko4Y3Ak11IydEZZ6dCjYann3MP3ZOo0TN4ybKJolFYEfZllprTmaQ9SqfUdJ6dh3XABM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786283639; c=relaxed/simple;
	bh=B0xknYqEWlGS1jCPFlMV0cg8ErveEciie+1ztzD8gs8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GDzAzihW+Vg2TWSug3fcgZGeTWIYXhx1mAEHhlZuSThthuW5pFwdpo86plrJQTZssIq0IKvg1Hhtw1CZ51UyYk7yYA7eWfov060xUdy1OTO7EaA+ngcSaXShEvqAdzZ0cnFBCF1MbQaYoER6wKxfDEInPbgWD6Tf+Zc3HV2x5xc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PNgr+8g8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PNgr+8g8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82B181F000E9;
	Sun,  9 Aug 2026 13:53:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786283638;
	bh=BIQgRy2DOL3l/JsqH/avsR5+Vr7xxPFwD/vXpVeTtxE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PNgr+8g8MT+SP3XOhJJbDwGX96i8azdBGFYXAQc6U2yPEB3v9Erq9WSP7PGFftXco
	 4+O33gRFxjnpUIi+Bih/ONyIBKEOsWP1R4WQ4spgy7jmd/oubZ/gmp5x7v11/E0Cj3
	 0yUltwl+iumQAz7HBS3iXD6Q+IOlv0Q89+mPc92OIqXruRdGuG0Q7E2jxeqdKSDrRW
	 xTlBuNs1wo2/wWgCJgEggmo2QLNGm22CvjtZlMmsTG2rnr+a+TsHWvZHNuGtew3p9Z
	 LbfpBztjXJxOPwRvsa6IjbEtYmPtl57zzOMJq6i8NagRrU1ywdt7qTMzaWKRm7A0fk
	 EuZ9r1glHDSBQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] super: fix emergency thaw deadlock on frozen block devices
Date: Sun,  9 Aug 2026 09:53:55 -0400
Message-ID: <20260809135355.1505429-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072930-pastel-imprecise-0b26@gregkh>
References: <2026072930-pastel-imprecise-0b26@gregkh>
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
index 3d040c09f723f..eb33ea08f472b 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1048,13 +1048,24 @@ void emergency_remount(void)
 
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

