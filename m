Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795776980;
	b=N9uvWGqsO3sEYlbtP3Zjdy4AfH0RHSobSd6vbIrVB7JTPL/WEnvNR8eXZDmIkWeyMd3q
	 yNpHC/+hTMXE0TyQzPtAo+VO5KVVNG3t4ZizQpCqbgzJH/+b0dCloIsDRgq2o7KZfk3xg
	 CkqUn21od4DTfTLz/tsawFltBxnMkm85nIBm4m8bTXN7OtwG8qxapbc2BtwdOQfpey08t
	 ROIUt5huPv0K3hLWjYEMTEK0bqZtj1UwG/BJL2CepofSAHG1Jj7EvPIMCb5UH3L/AHwKL
	 92+q/1E+lkXp0EbkxpTI0ilw5YeFKXGGuEx+veIgkCj8mDm5VFb9Cs/Mv5YhRaQYCtg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795776980;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=QAh84q6dLbI/ZquU3Mza3G28fl4mzR7JeprffGBtWYo=;
	b=xHIGroufvPcrFqf8xyF0qR8bpSVRQrzUca5k6uUTIMBgzobvLBZ7omtRr4sozt2HF5qN
	 ino/vJjNwU6yYzTf5NmWjT31HNO3/LZsdtXM2yYZIPTyCblm4iNgdu0r7r/RNZa+IFeZe
	 pULNTrZcXaNycpRqVzsEqeNOjziEWKkvJDz0YAZUymrVcx0lfGxPNPOoQKzW4kvPXXJ9A
	 lH2i2Cmnhhx6QJPZWt9QujdRi8sjt9aiM9wC3vtZniuF5lzs2W0SZZvRA453FHEYgNAzN
	 mE0twRWvIpoMOc0nvVyW9RMyWqWEb4j+pLUTwKRCC6+u91TIuUoum7A91YdMX88DPxg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="IHzHn/Ug";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 442D4606A338;
	Fri, 27 Nov 2026 10:56:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IHzHn/Ug
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01BC21F00926;
	Fri, 27 Nov 2026 10:56:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795776979;
	bh=QAh84q6dLbI/ZquU3Mza3G28fl4mzR7JeprffGBtWYo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IHzHn/UgRN1GswdchlZznL5F3U6pEHEuSM0sjGOXNlX12egXX+zbmjSOTTUURNZC4
	 FR1qFVVmxVCMGpy77lUC3UAGiHS/+Z5AnacISl+bYe7zew4vccqxOwPvs2PxA2na5x
	 8huf30WCu/wphxOfjgywezVXfWWYUGk7u/NwQpysXgEIMfRwMDQg31/amaWSF+laRr
	 wx+wlncehZeJRR1XKgQ4ghOic8yoSUba9iaR/9hm8ENH8qFzttgqYj8QwzXQuihbgA
	 N9rnepDV/MLj2xilr4j2TQ2sqxTkMiXQUp01rOPgCKOYud3jhjGV/pSLas0qg7XzaE
	 XJH77sG8heSqQ==
From: Chao Yu <chao@kernel.org>
To: jaegeuk@kernel.org
Cc: linux-f2fs-devel@lists.sourceforge.net,
	linux-kernel@vger.kernel.org,
	Chao Yu <chao@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v2 4/7] f2fs: fix to truncate stale meta cache entry on in-place update
Date: Fri, 27 Nov 2026 10:56:11 +0000
Message-ID: <20261127105608.537148-11-chao@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127105608.537148-8-chao@kernel.org>
References: <20261127105608.537148-8-chao@kernel.org>
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

From: Chao Yu <chao@kernel.org>

GC migrates data blocks of the inode which requires meta inode GC via
meta cache, and it trusts an uptodate entry w/o reading the block from
disk again, in both ra_data_block() and move_data_block().

However, in-place update paths only truncate the entry if the inode
requires meta inode GC at the time of writing:
- f2fs_inplace_write_data() checks fio->meta_gc
- f2fs_wait_on_block_writeback_range() for DIO checks
f2fs_meta_inode_gc_required()

f2fs_meta_inode_gc_required() returns true for atomic and COW files,
which is a temporary state, so an entry cached during atomic write, or
cached before the block was donated by F2FS_IOC_MOVE_RANGE, can survive
in-place update once the owner does not require meta inode GC, then GC
will migrate stale data from the entry once the owner requires meta
inode GC again, resulting in overwriting valid data.

Case #1: atomic write

- App (file F)				- GC
- ioctl(F2FS_IOC_START_ATOMIC_WRITE)
 : f2fs_meta_inode_gc_required(F) is true
- write F[k], k != j
					- gc_data_segment() phase 3
					 - ra_data_block(F, j)
					  : cache F[j] in META[P]
- ioctl(F2FS_IOC_COMMIT_ATOMIC_WRITE)
 - f2fs_commit_atomic_write()
  - f2fs_down_write(i_gc_rwsem[WRITE])
					- gc_data_segment() phase 4
					 - f2fs_down_write_trylock(i_gc_rwsem[WRITE])
					 : fail, skip F[j]
  - __f2fs_commit_atomic_write()
  : only F[k] is replaced, F[j] is still mapped to P
  - f2fs_up_write(i_gc_rwsem[WRITE])
 - f2fs_abort_atomic_write()
  - clear_inode_flag(FI_ATOMIC_FILE)
- write F[j] w/ new data, fdatasync()
 - f2fs_inplace_write_data()
 : fio->meta_gc is false, META[P] becomes stale
- ioctl(F2FS_IOC_START_ATOMIC_WRITE)
					- gc_data_segment() phase 3
					 - ra_data_block(F, j)
					 : META[P] is uptodate, skip reading
					- gc_data_segment() phase 4
					 - move_data_block(F, j)
					 : META[P] is uptodate, skip reading
					  - memcpy(tentry, sentry)
					  - f2fs_update_data_blkaddr(newaddr)
					 : F[j] was rolled back to old data

Case #2: F2FS_IOC_MOVE_RANGE

- Thread A (src)			- GC			- Thread B (dst)
- write src[i], P is not checkpointed
- ioctl(F2FS_IOC_START_ATOMIC_WRITE)
					- gc_data_segment() phase 3
					 - ra_data_block(src, i)
					 : cache src[i] in META[P]
					- gc_data_segment() phase 4
					 : fail to lock i_gc_rwsem, skip src[i]
- ioctl(F2FS_IOC_ABORT_ATOMIC_WRITE)
 - f2fs_abort_atomic_write()
  - clear_inode_flag(FI_ATOMIC_FILE)
- ioctl(F2FS_IOC_MOVE_RANGE, src[i] -> dst[j])
 - f2fs_move_file_range()
  - __exchange_data_block()
   - __read_out_blkaddrs()
   : P is not checkpointed, do not invalidate it
   - __clone_blkaddrs()
    - f2fs_replace_block(dst[j], P)
									- write dst[j] w/ new data, fdatasync()
									 - f2fs_inplace_write_data()
									 : fio->meta_gc is false, META[P] becomes stale
									- ioctl(F2FS_IOC_START_ATOMIC_WRITE)
					- gc_data_segment()
					 - ra_data_block(dst, j)
					 - move_data_block(dst, j)
					 : migrate stale data in META[P]
					 : dst[j] was overwritten w/ src[i]'s old data

DIO overwrite has the same issue, since f2fs_map_blocks() w/
F2FS_GET_BLOCK_DIO calls f2fs_wait_on_block_writeback_range() for the
block which will be overwritten in place.

Before commit 570e2ccc7cb3 ("f2fs: avoid reading already updated pages
during GC"), ra_data_block() always read the block from disk, then the
stale entry would be updated before move_data_block() used it.

Let's always truncate the meta cache entry in f2fs_inplace_write_data()
and f2fs_wait_on_block_writeback_range() regardless of current state of
the inode, and only wait for writeback of the cache entry when the inode
requires meta inode GC.

Cc: stable@vger.kernel.org
Fixes: b40a2b003709 ("f2fs: use meta inode for GC of atomic file")
Signed-off-by: Chao Yu <chao@kernel.org>
---
v2:
- rebase to the latest dev-test branch.

 fs/f2fs/segment.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 73dc88aa6dde..1bfe1802f7dd 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4305,8 +4305,13 @@ int f2fs_inplace_write_data(struct f2fs_io_info *fio)
 		goto drop_bio;
 	}
 
-	if (fio->meta_gc)
-		f2fs_truncate_meta_caches(sbi, fio->new_blkaddr, 1);
+	/*
+	 * GC may have cached this block in meta cache while its owner was in
+	 * atomic write or before it was donated by F2FS_IOC_MOVE_RANGE, so
+	 * truncate it regardless of fio->meta_gc to avoid that GC migrates
+	 * stale data from meta cache later.
+	 */
+	f2fs_truncate_meta_caches(sbi, fio->new_blkaddr, 1);
 
 	stat_inc_inplace_blocks(fio->sbi);
 
@@ -4494,12 +4499,16 @@ void f2fs_wait_on_block_writeback_range(struct inode *inode, block_t blkaddr,
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
 	block_t i;
 
-	if (!f2fs_meta_inode_gc_required(inode))
-		return;
-
-	for (i = 0; i < len; i++)
-		f2fs_wait_on_block_writeback(inode, blkaddr + i);
+	if (f2fs_meta_inode_gc_required(inode)) {
+		for (i = 0; i < len; i++)
+			f2fs_wait_on_block_writeback(inode, blkaddr + i);
+	}
 
+	/*
+	 * GC may have cached these blocks in meta cache while their owner
+	 * required meta inode GC, truncate them regardless of current state
+	 * of the inode, since DIO may overwrite them in place.
+	 */
 	f2fs_truncate_meta_caches(sbi, blkaddr, len);
 }
 
-- 
2.49.0

