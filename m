Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795731164;
	b=RpK8kHJoTvXQDxMkCk0PnG4VtoqeXiFCKqI4Uk/NoOqIZkhwO+zqryQPCQywsZdD0RYY
	 NzhMBnoNf63Qj3YvVzNvrpEWmLP0yc1WskF7sfICmpyoS2BDgoe9/P0syTJbmv2UryFQd
	 os1DNc4vXqUjtpPn4u7ievDoRDtOpHfKm5km2OKwagbbLAgJ4oCa6esYTk63I0NtQ3/3P
	 eg1FbrY2RV9CNBregW/jlBPXUZhXEGRTiYKubFKgktwrDwsFnSN4K01upoIHYn38JHPIa
	 0+glAsJcf7JYidnkxvzxU1IPU+bpa9HqraqtSbRfaEf6Qv2hnjiP/+3ctHOzrjOiUlA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795731164;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=EqDf286+LrX47m0DFMHqQFfG1PgixQWmbe5/LpoP+Js=;
	b=Vp5/cn5HQR0k/xZD4v4pZtPGIclfqTYIUyvOpAofJR19QUMh5M6Qn/zTmm1snESKO3kz
	 0/ERaexIfTmtSO+Jh+nPKeOioNNNGM7475kXU8BZjoYlvMDGA/7fQUaOBBWCSX2A2XBMW
	 stxSfvvuDEDwYsP5zJMc4bWNQLiI15V1u2eCyW+0BliVR/d6214kXGU0JFnwBDrrm6MPE
	 pYGacp5FNK7WcJDz8ClbBM8QMQWjJ03LjDVrU8/NZZ1bjIS2n4hENorUWVsD2zKJuM58M
	 6SGDk/OsK4a028ckBbJI0iulqGTOgvdrUdlYN0ARvEjpVPXDzFPNg8WJBT7IXbZBq9Q==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHC9+Keg;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0ECC606A31C;
	Thu, 26 Nov 2026 22:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fHC9+Keg
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795731164;
	b=fpFQiBWtIWh1haJqKj/KKLj4ZJBs6Z/4plJbY+nnKhC8qZPA22IfqY02Nkln/B3AYOdG
	 T+w8KveEBq4G6xoBhQLm80zmFm/nwIhe5hBk72i1ROK+NQJCH9vybyFaOeGn00yfNTYRh
	 Hz2BctakV8mHocHfEP0O8YSujVmx9mMRRQXg8QaqS7ffqDj44Dtz6asq5uYuvdjNr9rX7
	 GbHd7gY3gK2T+Q5+9rJ6N/B4X+tR33oF7Zzc39gQ5EkSNsOyPj4UwhYuvgCWw5YQP682N
	 G4btDAgoUyjeQMbLZ7rJI5CKe3J7sLAsY34PzR1PkIqgu9Bw8ewVqi4kk/zjS3HYdHQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795731164;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=EqDf286+LrX47m0DFMHqQFfG1PgixQWmbe5/LpoP+Js=;
	b=UgeUyWfH2m4zlH63DrV54dFwRo+4wFav3U7KFhcw1Sbv3IS7wcIcrlU3mYDbSQuCr8N2
	 5n+BDPNSbtB4ubrpP3PkgWIc/6zJurR9AtDQwv4g8ofTv9MaOpEUHzYqOIRin1xNKEggO
	 8BgxwZVSt0cWMxvPPqA44EyM/iNBofntEx5KSqlDFv+jbs/J65LvwIR/mq7nEJSLSCfw8
	 fsB4c1eV4kgM1UQcOgyvaB05DdVuLrHxbG2/2+dcmepcQS5DLy2rT/mfrZYtD5XTeg98z
	 RZI7MrQoGN0DGHFWECGMB8zYSbR8YseMCxkoQsy0zsb3X1FLN1AU9TFY1fbP8DuUEkQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 6CE141F000C1;
	Thu, 26 Nov 2026 22:12:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795731164;
	bh=EqDf286+LrX47m0DFMHqQFfG1PgixQWmbe5/LpoP+Js=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=fHC9+KegDe5hSRUpRLBKXCc3ongN1xZa6GhGgg9mUp7DgXNySchSMWu0V0WQbNrrr
	 E/oFY7K9+QKTZVTtHY7r+CD0kK89uNSS9INrd5JmczXjLEEWusM4wzfYgcWA0tRpMr
	 Qg2ykTx170xrEFApqEC8zcj6cPSXcvg7GRtt/HHpzB0r37lhcdqgdjYVpPLqYe+IuA
	 MDSrCJjVtpam9P9UsNo6Tw+kkXUJ2HL5Mfp6uUUiIELi7HXcI5eX0DLDKMAFmONibK
	 ipXJ3Nn2W7nMB7YtDm1cH4RzG02DsxUHSVBJyxLC2wkzEvhuzPSdiFK2Im95a+zyEj
	 VqvV3nKbxfZ6w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id B57DA4D847;
	Thu, 26 Nov 2026 22:12:40 +0000 (UTC)
From: Mostafa Amin via B4 Relay <devnull+mostafa.amin.windriver.com@kernel.org>
Date: Thu, 26 Nov 2026 17:12:39 -0500
Subject: [PATCH] fs/ntfs3: serialize size changes with
 mapping->invalidate_lock
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261126-fix-krn-ntfs3-inline-read-v1-1-30d32e60a4f5@windriver.com>
X-B4-Tracking: v=1; b=H4sIANauCGsC/x2MQQqAMAzAviI9W3CbDvQr4kFmp0Wp0okI4t8dH
 gNJHkikTAm64gGlixPvksGUBYRllJmQp8xgK+uNsR4j37iqoJwxOWTZWAiVxglb52NT2RBq00D
 uD6Us/+9+eN8P3b/+DGsAAAA=
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Cc: ntfs3@lists.linux.dev, 
 syzbot+079e16bc964fb91acb4a@syzkaller.appspotmail.com, 
 linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org, 
 stable@vger.kernel.org, Mostafa Amin <mostafa.amin@windriver.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795731160; l=5919;
 i=mostafa.amin@windriver.com; s=20261126; h=from:subject:message-id;
 bh=XmeI61S+G6pjD7VI+NxHnOwVHDxsLsOyxgnSQMrMyvQ=;
 b=OLuKjlFUHKqs6hefA7Vlu5Qxgeab18KkjBAxvZuyo37JMXNgduh/qVX8CwXSwvIwMG+i6yYFD
 DzrpjlndoJ+AyE2G2+A/wicLzLl4Cd/yNp9zfU/KIcTvnha5KzNEQEK
X-Developer-Key: i=mostafa.amin@windriver.com; a=ed25519;
 pk=miyC6GYBn9SqytJ6Cgwe1MLT98rhnwuFEIO8ErmAetY=
X-Endpoint-Received: by B4 Relay for mostafa.amin@windriver.com/20261126
 with auth_id=1656
X-Original-From: Mostafa Amin <mostafa.amin@windriver.com>
Reply-To: mostafa.amin@windriver.com
Content-Transfer-Encoding: 7bit

From: Mostafa Amin <mostafa.amin@windriver.com>

syzbot reported a WARNING in iomap_read_inline_data() ("size >
iomap->length") triggered by concurrent ftruncate() and mmap() page
faults on a resident NTFS3 file:

  CPU0 (filemap_fault)               CPU1 (ntfs_setattr / write_iter)
  --------------------               --------------------------------
  filemap_invalidate_lock_shared()
  ntfs_read_folio()
    ntfs_iomap_begin()
      attr_data_get_block()
        iomap->length = 5
                                     truncate_setsize(inode, 20)
                                       i_size_write(inode, 20)
                                     ntfs_set_size(inode, 20)
    iomap_read_inline_data()
      size = i_size_read(inode) = 20
      WARN_ON_ONCE(20 > 5) -> -EIO

iomap_read_inline_data() copies i_size_read(inode) - iomap->offset bytes
out of iomap->inline_data and warns with -EIO if that exceeds
iomap->length.  In ntfs3, attr_data_get_block_locked() snapshots a
resident $DATA attribute into an allocated page under ni_lock and sets
iomap->length to res.data_size, dropping ni_lock before returning from
ntfs_iomap_begin().

Meanwhile, ntfs_setattr() updates inode->i_size via truncate_setsize()
before ntfs_set_size() grows res.data_size and without holding
mapping->invalidate_lock.  Extending writes in ntfs_file_write_iter()
and preallocation in ntfs_fallocate() likewise resize the attribute and
inode->i_size via ntfs_set_size() without mapping->invalidate_lock,
allowing a concurrent page fault or buffered read to observe the new
inode->i_size against an inline iomap built from the old resident size.

Serialize regular-file size and resident/non-resident layout changes
against pagecache readers and faults with filemap_invalidate_lock():

  - In ntfs_setattr(), hold mapping->invalidate_lock across ATTR_SIZE
    updates; when extending, truncate any stray pagecache beyond oldsize
    and run ntfs_set_size() before pagecache_isize_extended() so i_size
    never leads res.data_size or transiently changes on error.
  - In ntfs_file_write_iter(), reject extending IOCB_NOWAIT writes with
    -EAGAIN and hold mapping->invalidate_lock around ntfs_set_size().
  - In ntfs_fallocate(), hold mapping->invalidate_lock across all modes,
    including default preallocation which converts resident files to
    non-resident and extends i_size.

Fixes: 099ef9ab9203 ("fs/ntfs3: implement iomap-based file operations")
Reported-by: syzbot+079e16bc964fb91acb4a@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=079e16bc964fb91acb4a
Cc: stable@vger.kernel.org
Signed-off-by: Mostafa Amin <mostafa.amin@windriver.com>
---
Tested on v7.4-rc4 (x86_64 QEMU/KVM, 4 vCPUs, CONFIG_KASAN=y,
CONFIG_PROVE_LOCKING=y, CONFIG_UBSAN=y, CONFIG_DEBUG_ATOMIC_SLEEP=y,
CONFIG_DEBUG_KMEMLEAK=y, panic_on_warn=1):
  - syzbot C reproducer (ftruncate vs mmap + MADV_DONTNEED): 3/3
    crashes before fix, 0/10 crashes after fix, 3/3 crashes with fix
    reverted.
  - Extending pwrite + fsync + POSIX_FADV_DONTNEED race and
    resident-to-nonresident data-integrity suite: 1/1 crash before
    fix, 0/3 after fix.
  - W=1 build of fs/ntfs3/ on debug (CONFIG_NTFS3_FS=y) and
    allmodconfig (CONFIG_NTFS3_FS=m): 0 warnings.

Not tested: sparse/smatch/coccinelle, non-x86_64 runtime, full xfstests.
---
 fs/ntfs3/file.c | 34 ++++++++++++++++++++++++----------
 1 file changed, 24 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/file.c b/fs/ntfs3/file.c
index 6c84a3e1c7fe..33fb6dd91503 100644
--- a/fs/ntfs3/file.c
+++ b/fs/ntfs3/file.c
@@ -518,12 +518,9 @@ static long ntfs_fallocate(struct file *file, int mode, loff_t vbo, loff_t len)
 		goto out;
 	}
 
-	if (mode & (FALLOC_FL_PUNCH_HOLE | FALLOC_FL_COLLAPSE_RANGE |
-		    FALLOC_FL_INSERT_RANGE)) {
-		inode_dio_wait(inode);
-		filemap_invalidate_lock(mapping);
-		map_locked = true;
-	}
+	inode_dio_wait(inode);
+	filemap_invalidate_lock(mapping);
+	map_locked = true;
 
 	if (mode & FALLOC_FL_PUNCH_HOLE) {
 		u32 frame_size;
@@ -736,15 +733,25 @@ int ntfs_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 			goto out;
 		}
 		inode_dio_wait(inode);
+		filemap_invalidate_lock(inode->i_mapping);
 		oldsize = i_size_read(inode);
 		newsize = attr->ia_size;
 
 		if (newsize != oldsize) {
-			truncate_setsize(inode, newsize);
-
-			err = ntfs_set_size(inode, newsize);
+			if (newsize > oldsize) {
+				truncate_pagecache(inode, oldsize);
+				err = ntfs_set_size(inode, newsize);
+				if (!err)
+					pagecache_isize_extended(inode, oldsize,
+								 newsize);
+			} else {
+				truncate_setsize(inode, newsize);
+				err = ntfs_set_size(inode, newsize);
+				if (err)
+					i_size_write(inode, oldsize);
+			}
 			if (err) {
-				i_size_write(inode, oldsize);
+				filemap_invalidate_unlock(inode->i_mapping);
 				goto out;
 			}
 
@@ -753,6 +760,7 @@ int ntfs_setattr(const struct mnt_idmap *idmap, struct dentry *dentry,
 			inode_set_mtime_to_ts(inode,
 					      inode_set_ctime_current(inode));
 		}
+		filemap_invalidate_unlock(inode->i_mapping);
 	}
 
 	setattr_copy(idmap, inode, attr);
@@ -1288,11 +1296,17 @@ static ssize_t ntfs_file_write_iter(struct kiocb *iocb, struct iov_iter *from)
 	endbyte = vbo + ret;
 
 	if (endbyte > inode->i_size) {
+		if (iocb->ki_flags & IOCB_NOWAIT) {
+			ret = -EAGAIN;
+			goto out;
+		}
 		/*
 		 * Normal files: increase file size, allocate space.
 		 * Sparse/Compressed: increase file size. No space allocated.
 		 */
+		filemap_invalidate_lock(inode->i_mapping);
 		ret = ntfs_set_size(inode, endbyte);
+		filemap_invalidate_unlock(inode->i_mapping);
 		if (ret)
 			goto out;
 	}

---
base-commit: b6a9fa34ce4187cb69d3c588a4bbffc31ce5db8f
change-id: 20261126-fix-krn-ntfs3-inline-read-936f502cc415

Best regards,
-- 
Mostafa Amin <mostafa.amin@windriver.com>


