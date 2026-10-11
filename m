Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 306A933B970;
	Sun, 11 Oct 2026 15:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734179; cv=none; b=TPO3UtWryn4EsxeWACR9oLu66vkocwmRM5ECdcH5jVV058GWhzRWirEYfbkCiFwM7hqCPAMGjCUYTqarc9218YWXudAWZKcwJ4019XXl/gDfFeeriSWkhGlDrmk3GYSqzs0CFZuevnKoZcNwGnd4fQsPbXjBG+z/2rMNdgpXiFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734179; c=relaxed/simple;
	bh=yaUn5RAqlkPm33bHpdiCaIaRUuNOWWz6M/sxZNfR0fY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=P7nzGIV4g0P6+L573E05LZLljGQlzY7atSB47Lu0yJRiNCAfEg8u75dKMItmncpCGES34OofPPSwJqcxTS66948acYagvcCZD8VMlUHmaTQDcf0vtWZcnG5ttCL7QLp/rs00x9Dvnkh543uH9VqVIQi0eXTcgvTiSQmorL2cdEk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bWULgN57; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bWULgN57"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89E291F0089C;
	Sun, 11 Oct 2026 15:56:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734177;
	bh=xDPtuZu205fp/5iX1ngjmF6wKrwu3uPdmynjeUTeQmU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=bWULgN57X2FZAKljatSqkqz3fXY6AcuIFm3I2LiZrGCPteYWVGpU10zGoHkM29Xvv
	 XCcjyz5LqGZMv/DRx/gX+ShYMo7Pejm2i+zz/VZY/aKRYmKZFzkoDXfi/Krle7Gca6
	 zkaBN0v0TgAMovmBcI7t9WwCcv8YBcl8qAMYP4jyHHXOO6sKCM7NmOAajpNNHO5/r4
	 XeJpyBcbOVtGfabI2PEKy2GraBUQgT8/TCUxhr4lEMKBLoih5sqEtfnmcl4Z9nBqJJ
	 vl2fx8L51KKFUGfQskEs32/hSdG9e7wcUvshxQThveexMxVhkZBcfpL0JtnoJlKLNS
	 TywPxKCfqT9qw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:01 +0200
Subject: [PATCH 01/15] super: don't put the remount context under s_umount
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-1-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=4448; i=brauner@kernel.org;
 h=from:subject:message-id; bh=yaUn5RAqlkPm33bHpdiCaIaRUuNOWWz6M/sxZNfR0fY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jh7mqMLMxfrBKX0De5ttQUrjH3Pnz4leifLNOZZt
 xBrhUBGRykLgxgXg6yYIotDu0m43HKeis1GmRowc1iZQIYwcHEKwEQSVRgZfpnnP/045x6DykXG
 zoPyB49Mri641Spuwy7yWGWLtJvDPkaGhQUerH0ydhw3vDw/1+m1zU2/c22S+rPLbZHLNzDK8r1
 gAAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

do_emergency_remount_callback() is called from __iterate_supers() with
s_umount held exclusively. It creates a reconfigure context for the
superblock and fs_context_for_reconfigure() takes an active reference
for it. put_fs_context() drops that reference via deactivate_super()
while s_umount is still held.

The iterator itself only holds a passive reference. So if the
filesystem is unmounted while reconfigure_super() runs, the umount drops
the mount's active reference without ever taking s_umount because
atomic_add_unless() in deactivate_super() sees the context's reference.
Now the context holds the last active reference and we're fscked:
put_fs_context() ends up in deactivate_super() which tries to take
s_umount again and the kworker deadlocks on itself:

  WARNING: possible recursive locking detected
  kworker/1:1/53 is trying to acquire lock:
  (&type->s_umount_key#26){+.+.}-{4:4}, at: deactivate_super+0x6f/0x90
  but task is already holding lock:
  (&type->s_umount_key#26){+.+.}-{4:4}, at: super_lock+0x188/0x3a0
  ...
   down_write+0x90/0x1e0
   deactivate_super+0x6f/0x90
   put_fs_context+0xb1/0x7d0
   __iterate_supers+0x33d/0x410
   do_emergency_remount+0x20/0x40

"Emergency Remount complete" is never printed and the superblock's
s_umount stays held forever. Everything that needs it hangs after that,
including sync(2) and thus the clean reboot that usually follows a
sysrq-u. The window is all of reconfigure_super(), i.e., syncing a
read-write filesystem, so an umount racing with sysrq-u hits this
easily.

Iterate without holding s_umount and take it in the callback instead.
The context's active reference keeps the superblock alive while we hold
s_umount and we only drop it after we released s_umount again. If it is
the last reference deactivate_super() takes s_umount and shuts the
filesystem down, just as the umount would have done.

Reproducer. sysrq-u remounts every block filesystem read-only, so use a
throwaway VM. It needs CONFIG_SCSI_DEBUG and CONFIG_MAGIC_SYSRQ. The
scsi_debug delay keeps reconfigure_super() busy writing back the dirty
data long enough for the umount to land in the window:

  modprobe scsi_debug dev_size_mb=256
  dev=/dev/sda        # the scsi_debug disk
  mkfs.ext4 -q $dev
  mount $dev /mnt
  dd if=/dev/zero of=/mnt/dirty bs=1M count=32
  echo 20 > /sys/bus/pseudo/drivers/scsi_debug/delay
  echo u > /proc/sysrq-trigger
  sleep 1
  umount /mnt
  # lockdep: possible recursive locking detected in
  # do_emergency_remount(), "Emergency Remount complete" never shows up
  # and sync hangs.

Without the fix this reproduces on the first run on v7.3-rc6. With the
fix the remount completes and the kworker shuts the filesystem down.

Fixes: 8d0347f6c3a9 ("convert do_remount_sb() to fs_context")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 1d5ccf540a9b..15ecfbeb92ab 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1158,23 +1158,34 @@ int reconfigure_super(struct fs_context *fc)
 
 static void do_emergency_remount_callback(struct super_block *sb, void *unused)
 {
-	if (sb->s_bdev && !sb_rdonly(sb)) {
-		struct fs_context *fc;
+	struct fs_context *fc = NULL;
+
+	if (!super_lock_excl(sb))
+		return;
 
+	/* Make sure no reference put under s_umount is the last one. */
+	atomic_inc(&sb->s_active);
+	if (sb->s_bdev && !sb_rdonly(sb)) {
 		fc = fs_context_for_reconfigure(sb->s_root,
 					SB_RDONLY | SB_FORCE, SB_RDONLY);
-		if (!IS_ERR(fc)) {
-			if (parse_monolithic_mount_data(fc, NULL) == 0)
-				(void)reconfigure_super(fc);
-			put_fs_context(fc);
-		}
+		if (!IS_ERR(fc) && parse_monolithic_mount_data(fc, NULL) == 0)
+			(void)reconfigure_super(fc);
 	}
+	super_unlock_excl(sb);
+
+	/*
+	 * Our active reference may be the last one by now, so only drop it
+	 * after s_umount has been released.
+	 */
+	if (!IS_ERR_OR_NULL(fc))
+		put_fs_context(fc);
+	deactivate_super(sb);
 }
 
 static void do_emergency_remount(struct work_struct *work)
 {
 	__iterate_supers(do_emergency_remount_callback, NULL,
-			 SUPER_ITER_EXCL | SUPER_ITER_REVERSE);
+			 SUPER_ITER_UNLOCKED | SUPER_ITER_REVERSE);
 	kfree(work);
 	printk("Emergency Remount complete\n");
 }

-- 
2.53.0

