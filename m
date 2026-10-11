Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0F5306764;
	Sun, 11 Oct 2026 15:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791734188; cv=none; b=pB91jhyIgvl2KR+4/fPQJlnqP/WbB9nKQsncB/9fP75mR9UDOUYbbnQ95ax1oju7l1utV5O9Q7dnXa2oGMFqnoC3IfZ2IeMlTO8iIuxjKU5wgrmrLmG3+gu8G0RbL/LRZcxb26PBJtO1Seqc9izhBA3UZvDy+7BAiMZN7UWmOKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791734188; c=relaxed/simple;
	bh=NCxMKFfNLd6wCDwjr1U2ADvPz1Lj6MZ3miPubTPl7p4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=tFV9sAu3asvHBE2LOHhzUT3rAV7+d2r5HB/Hke8OT0LxE3lI0q9bMbQzHXVkKw5GlMN/lRlZ2FiU5v3QeOW/xBRfjwgxhnIoQEKSihDOu/X+JlG58EcGx5EussDmPKPGIRMYTn6M1xemK38gq7JwVFyqZMCHTCM75YglL6xrQsw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O5UxDD4y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O5UxDD4y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2AAE31F0089B;
	Sun, 11 Oct 2026 15:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791734186;
	bh=vDs5YBmu1PEQxKSutM3E4d7DMRGeT4lFUAZb0DpiuYE=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=O5UxDD4yODKqsyRCNS2KTkXu799B+wTLTBq403CXCwkEb50Ff85Y8y0r9SGUMaar2
	 NeOksQSBvAJ6Eb3RkBYVkmFHey3X+Sm0YD6Xqiop5g3qmhNpy3W6VZVHOH+SGhJqT4
	 PkXn1kDqk2AOToDDWMx92eNkoDF+aFpx0ZDb2G69dSv3BI5yVfMVqjSWq4GvZpsRJH
	 KyQicyuPtST7IoEzRiEGWVWizdQ/9ivVXLEQ1N4o8k+fzWLKPUwQm157GTrdfxHW2T
	 9LS1NJIAlCFuZpL3NqnYl0YSd5TqGPMXbGYXW+ZxKINKjnyYTgP5drDEsqU6/P2F9N
	 VXd7o/fRyu9Sw==
From: Christian Brauner <brauner@kernel.org>
Date: Sun, 11 Oct 2026 17:56:06 +0200
Subject: [PATCH 06/15] fserror: don't accept error reports before the
 superblock is born
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261011-work-super-fixes-core-v1-6-c727176c5b53@kernel.org>
References: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
In-Reply-To: <20261011-work-super-fixes-core-v1-0-c727176c5b53@kernel.org>
To: Jan Kara <jack@suse.cz>
Cc: Jens Axboe <axboe@kernel.dk>, Alexander Viro <viro@zeniv.linux.org.uk>, 
 linux-fsdevel@vger.kernel.org, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-3d1b8
X-Developer-Signature: v=1; a=openpgp-sha256; l=3883; i=brauner@kernel.org;
 h=from:subject:message-id; bh=NCxMKFfNLd6wCDwjr1U2ADvPz1Lj6MZ3miPubTPl7p4=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWSd3jj7k+6WC7cqDHfUHYk2u8V76ad3/vMUYaGY7UsKU
 xz+H96U2VHKwiDGxSArpsji0G4SLrecp2KzUaYGzBxWJpAhDFycAjCROD5Ghnf/1PWiQxe+eiSc
 /quR5fmqnpdTLJxrhDRubNJ2CvmcrczIsNpaI6dNvEQ6x/lcnNm6V3MDDQ9w7FPZeCUxoFtc2FW
 YGQA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

alloc_super() biases s_pending_errors for every superblock but
generic_shutdown_super() only drops the bias and waits for pending error
reports if sb->s_root is set. fserror_alloc_event() accepts reports
whenever SB_ACTIVE is set. But xfs sets SB_ACTIVE around log recovery
and f2fs around gc for checkpoint=disable, both while filling the
superblock. If such a mount fails s_root stays NULL, nothing waits for
the queued reports and destroy_super_work() frees the superblock while
fserror_worker() is still pending. The worker holds no reference to the
superblock. It reads s_flags and s_op, puts the inode it pinned and
decrements s_pending_errors:

  BUG: KASAN: slab-use-after-free in fserror_worker (fs/fserror.c:54)
  Read of size 8 at addr ff11000107366060 by task kworker/1:0/25
  ...
  Allocated by task 120:
   __kmalloc_cache_noprof+0x27a/0x650
   sget_fc (fs/super.c:326 [alloc_super()] fs/super.c:874)
   get_tree_bdev_flags (fs/super.c:1479 fs/super.c:1866)
   vfs_get_tree+0x8b/0x2f0
  Freed by task 83:
   kfree+0x1e8/0x5e0
   process_one_work+0x953/0x1700

Nobody can listen for errors of a superblock that isn't born yet.
fanotify marks need a path in the mounted filesystem and the xfs health
monitor is attached through an ioctl on a mounted filesystem as well. So
don't accept reports before SB_BORN is set. A born superblock always has
s_root set when it's shut down so every accepted report is waited for.
Errors during the mount are still logged as lost reports and xfs still
records them in its health state.

Waiting for the reports of a failed mount in generic_shutdown_super()
instead wouldn't be enough. That runs from ->kill_sb() after the error
path of ->fill_super() and xfs and f2fs have already freed state there
that putting a pinned inode needs.

Reproducer, xfs with a dirty log and a bad crc in the refcount btree
root of AG 0. Log recovery reports the corruption while xfs has
SB_ACTIVE set and then the mount fails. The work item normally runs
right away, so a kprobe on queue_work_on() points it at a wrapper that
sleeps until destroy_super_work() has freed the superblock:

  mkfs.xfs -f /dev/vda
  mount /dev/vda /mnt && echo foo > /mnt/foo && sync
  xfs_io -x -c "shutdown -f" /mnt      # flush the log, then shut down
  umount /mnt                           # the log stays dirty
  xfs_db -x -c "agf 0" -c "addr refcntroot" -c "write -c numrecs 7" /dev/vda
  insmod r6_fshold.ko fserror_worker=0x$(awk '$3 == "fserror_worker" { print $1 }' /proc/kallsyms)
  echo 1 > /sys/module/r6_fshold/parameters/armed
  mount /dev/vda /mnt

  XFS (vda): Metadata CRC error detected at xfs_refcountbt_read_verify+0x1e/0x240, xfs_refcountbt block 0x30
  XFS (vda): Failed to recover leftover CoW staging extents, err -117.
  XFS (vda): Error -5 reserving per-AG metadata reserve pool.
  BUG: KASAN: slab-use-after-free in fserror_worker+0x2da/0x310

Not a selftest since the work item has to be held back with a kprobe.

Fixes: 21945e6cb516 ("fs: report filesystem and file I/O errors to fsnotify")
Cc: stable@vger.kernel.org
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/fserror.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/fs/fserror.c b/fs/fserror.c
index d8a800580012..90ce04d58514 100644
--- a/fs/fserror.c
+++ b/fs/fserror.c
@@ -96,6 +96,13 @@ static inline struct fserror_event *fserror_alloc_event(struct super_block *sb,
 		return NULL;
 	if (!(sb->s_flags & SB_ACTIVE))
 		goto out_pending;
+	/*
+	 * xfs and f2fs set SB_ACTIVE while filling the superblock. Nobody can
+	 * listen before the superblock is born and if the mount fails nothing
+	 * waits for the event.
+	 */
+	if (!(sb->s_flags & SB_BORN))
+		goto out_pending;
 
 	event = mempool_alloc(&fserror_events_pool, gfp_flags);
 	if (!event)

-- 
2.53.0

