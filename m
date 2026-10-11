Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A88E33B970;
	Sun, 11 Oct 2026 15:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734192; cv=none; b=C3VB4PlEzyoh/7bxRMTrwobnms3Fy+8DctxumxW5AWTfDwd0CLrZzyBPDIfLATvy9Lr0kyiAjAgErMZR03/CWJL1ixQ1F4+x03QJwWt5PjsZPjOODEJCSR3O4/SdfGFH1rZrL6lGVhzKxcEhOTVLFel5yH/5QQcTVoFXuNRvXTI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734192; c=relaxed/simple;
	bh=PPaT6K8Wl0BVJCSdHhe7Zn15eMVRq8dkuypI1J2/XSk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jLHj1QV77X+LCq4IsQ1O4D6QQ4k7Q8pMqtf5DU473lp6I88bafr+oQ3i1aTD7NHHUnaZm8CYmxIQXl5XVZtd+z4vASlP34tTYaZB2G0GOLR6dtT/J9iPEJHnsKyk8+UBKdyRfxl1HD+gT9THg2AA+vBd9YAFag7+k91pe3G70jw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZTFUyTYm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZTFUyTYm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA49A1F0089C;
	Sun, 11 Oct 2026 15:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734188;
	bh=B8dG7vVEdrpWOTSTB3yVvTEwK6tQI9if5a8/+Cs3bMY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=ZTFUyTYm6tfVt1m2DPYlcP4+yIHLRCAr4evwxKUZnpeyRw79NIOfdpPxMrVw1kirW
	 2iTjy0+kQIfJSYlJarzmNrdwQYp2nySYtEIPOnsQvbd5ctMV91kDndHoET+6X2788I
	 Jd5HSjIF4CQH2mDyxPSaziULEkqkdTatab9cse4x9yXWbVOT1vdqkZEPpXrqF4XFE8
	 jXm+aa9pld9tKxe+pILOHUqK0B3g24ex/OMGrsWx8SLMxHZJRcvaf1EqiNQIzBroZR
	 wVSdbHZZVsxIumd/ueZAGtYfZFxxJ4CQchUtve7t+nVvi/hnBfumXf7yKKvEK8OvCf
	 SYHB1zQx2mlYA==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:07 +0200
Subject: [PATCH 07/15] fs: don't fail fs_bdev_freeze() once a superblock is
 frozen
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-7-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3897; i=brauner@kernel.org;
 h=from:subject:message-id; bh=PPaT6K8Wl0BVJCSdHhe7Zn15eMVRq8dkuypI1J2/XSk=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jgnR9Yo7m02y85NK43OeE1Tmm+XLr7+6VX2b6z3d
 KWPle1c3VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjAR3nZGhulLzxzg3vvxf+2q
 Kd/bI3b4BFYGOi7Qie/ScrvAumtKghcjw+aJUZHuYe2eC+K5Ay6zXZ91aOqTxa1+m30VO2a5Tdn
 ZwAwA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

fs_bdev_freeze() freezes the superblocks on the device and then returns
the error of sync_blockdev(). But bdev_freeze() takes an error from
->freeze() to mean that nothing is frozen and drops bd_fsfreeze_count
again. Its callers act accordingly. dm's lock_fs() doesn't set
DMF_FROZEN and the shutdown ioctls just return. So nobody ever calls
bdev_thaw() and the superblock stays frozen until someone thaws it by
hand. Until then every writer blocks in sb_start_write().

freeze_super() only syncs sb->s_bdev and fails cleanly if that reports
an error. So the sync in fs_bdev_freeze() is the first to see a
writeback error on any other device of the filesystem, an external log
or journal device or a realtime device. It also is the first sync for a
read-only superblock since freeze_super() doesn't sync those at all.

I made fs_bdev_freeze() return that error in fbcb8f39e96d ("bdev:
surface the error from sync_blockdev()") without thinking about what it
means for the superblocks that are already frozen at that point. Don't
report a failed sync once a superblock was frozen. The device is frozen
and the regular bdev_thaw() undoes it. The error isn't lost either. It
stays recorded in the errseq of the mapping so fsync() on the device
still reports it. A device without any live superblock still reports
the error of the sync, just like bdev_freeze() does for a device without
holder ops.

Reproducer, xfs with an external log on dm-linear, a stale writeback
error on the log device, then a dm suspend:

  mkfs.xfs -f -l logdev=/dev/vdb,size=64m /dev/vda     # vdb is 128M
  dmsetup create log --table "0 $(blockdev --getsz /dev/vdb) linear /dev/vdb 0"
  mount -o logdev=/dev/mapper/log /dev/vda /mnt
  echo 1 > /sys/kernel/debug/fail_make_request/times
  echo 100 > /sys/kernel/debug/fail_make_request/probability
  echo 1 > /sys/block/dm-0/make-it-fail
  xfs_io -c "pwrite 100m 4k" -c "sync_range -w 100m 4k" /dev/mapper/log
  echo 0 > /sys/block/dm-0/make-it-fail
  dmsetup suspend log          # fails with -EIO, the device stays active
  touch /mnt/foo               # hangs until fsfreeze --unfreeze /mnt

  Buffer I/O error on dev dm-0, logical block 25600, lost async page write
  device-mapper: suspend ioctl on log  failed: Input/output error
  INFO: task touch:117 blocked for more than 30 seconds.
   percpu_rwsem_wait+0x203/0x500
   mnt_want_write+0x28f/0x2f0
   lookup_open+0x135/0x1b20

The selftest in the next patch covers the read-only case.

Fixes: fbcb8f39e96d ("bdev: surface the error from sync_blockdev()")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/super.c | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/fs/super.c b/fs/super.c
index 2dc4ec2e8014..82290d094c03 100644
--- a/fs/super.c
+++ b/fs/super.c
@@ -1555,7 +1555,8 @@ static void fs_bdev_sync(struct block_device *bdev)
  *
  * Return: 0, or the error from the one superblock on a single-fs device.  When
  *         several superblocks share @bdev a per-superblock failure is swallowed
- *         (see below), but a sync_blockdev() failure is always reported.
+ *         (see below).  A sync_blockdev() failure is only reported if no
+ *         live superblock uses @bdev.
  */
 static int fs_bdev_freeze(struct block_device *bdev)
 {
@@ -1586,8 +1587,17 @@ static int fs_bdev_freeze(struct block_device *bdev)
 	 */
 	if (error && count > 1)
 		error = 0;
-	if (!error)
-		error = sync_blockdev(bdev);
+	if (error)
+		return error;
+
+	/*
+	 * An error tells bdev_freeze() that nothing is frozen and nobody would
+	 * ever thaw a superblock frozen above. So only report a failed sync if
+	 * no superblock uses the device.
+	 */
+	error = sync_blockdev(bdev);
+	if (count)
+		error = 0;
 	return error;
 }
 

-- 
2.53.0

