Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795454993;
	b=BFHHvqH7QITjwbB8iAlnFpLq/7hQOPUGYNNhSg12ZiUODzo0K3Tak5qcyQI3J7TEFw/C
	 OGJcG40FYf5pVLi5N3sFfDS6IeFXkvH/dHCwWjxgaipQP1y+J5AN5uJ9JPpMsIEfqr6d0
	 cvxW3YXKQ34TDHbKsDfL7B93D+nNTEADK0+6wlTkyjSyo669NkVKXEt9I6M0MGA1F5viY
	 g0/PTKDB96124KXoE/pMNejuVpXV3vt1ztdRvfekWa1SCbACD+ioybpZM60idF16JP4jp
	 j6vR9lP/aMitOq7bgr9s/cepfeA7PyEbK4W+zpcIqGvvDkgHlYoSaCmVOds0y6fvM4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795454993;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=P7Nne5ji9F4bYhC6KrYcAqIhYijl8pxHpY3INoGZQk0=;
	b=mSPcMSe0t+dUam12gKUqcYxQ0s9YKZBTuIkZnDfm2fcTi41bBr2elimYOn4coDAt1fhJ
	 tGN4m/gghJaqQ1ig3GnFH9iIsL7s5fO1xeS2P8bG/2dT6iyyzYcUrVbSB9X2/n4LizeWv
	 JJSNagyjstBL5o4HmE4AZBistseAF5yzTs9+HSls4z50n5fn0tTL/Qw1Se10m6RDL8y+h
	 oK29O7G+/J4OKo7mmA4AaX0hRkRjJxUcWlRbjSi45au7L279SwcR0i8gqLKvcbVRohacA
	 XTyyaxfL3g7Yq+Dnlvd5pJr85Z0YhhI8WJ/abjYZaQI+3SdoU96j2GiU8F6HKiBHHQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w7hm4+LN;
	arc=none smtp.remote-ip=209.85.128.52
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF7ED606A31E
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 17:29:51 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DF7ED606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=w7hm4+LN
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4bb70074ab2so37522815e9.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 09:29:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795454990; x=1796059790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=P7Nne5ji9F4bYhC6KrYcAqIhYijl8pxHpY3INoGZQk0=;
        b=w7hm4+LN5fPT+lPHeN+Pd1qlDmizClPSVuPvglSoPGeKJTBGsmiMXPdY6qYaPtU4K7
         iTjGQnTEoGCtJEBLYztxRH6behZf9WBrMr+9x+zmNjU3WCuHJc1X0Ju+fN4ovrWB6Ade
         JxtmMyysijUudXYO/m3LL71e+hfH5bsR+mX45WtlyyGP+0PYCAedihbGLgJu7yp/hkJM
         NmS7QR1dwftYSrgfT3l8DxsCzBQYfAgHY/bfuz75kLCJ1zfPHxDe745HaAVXXE1MI1oO
         fGi7FbddhY+fig+yQhoaFAZUJmOpS+8+qjUpdXe68rKICR5OXHMBCg9D7l6lo0runOQz
         yltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795454990; x=1796059790;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=P7Nne5ji9F4bYhC6KrYcAqIhYijl8pxHpY3INoGZQk0=;
        b=uQOZADvcl9KiqIOrtw389t5Eb5NKGkYBVnO5JPfYG36fD3ZAzDY11Y1NkKvSmcQYqT
         YhrBdVX1Rhz3awa3L34zy9Na3R+E5/cHOLfjF1ALPWyx/LqrFxI/fkZdAiODQQHsHt8+
         dBIGTJo/JSuZpfBIHRSjqgidmCFNGciOv7+zq6cBN4dxu0NsgaPGwKRlgJE/cCNXyYQZ
         2/eRJSt9qlnEaqrYrr3Ji98YRi6V6I5ptIKBS+DWv2TssvUECwbGsCmyBJAZGAuurvx2
         k53yvwWGujV2SBWJfTeXUtBj2zG/Odu71WfxwbGjjbDHT0RdZhYcyF1ROpfmjT8xHSl3
         nEwA==
X-Forwarded-Encrypted: i=1; AL+hErH5TEO8MdKWw1XQphd4iLfa3f+hQQpRZPMviOSOMzzSjaFMrio5vb70GkRLGKrpCum+Twb7bHg=@vger.kernel.org
X-Gm-Message-State: APuU4Z8m2L0kAil4iEnCGxxbIMbE/8/Of9ogN/kxkm2uNHuLkMR8aLiw
	n73uEbAMELeDIsI90kZiW+Jd4tM9LhNpDQuJl4YzbIspBd4imjh2GjKF
X-Gm-Gg: AZFdTZdF/NjL3QnRfok5daY0F7mQnYhhyiyn5CKArfX49EguMVQGvtNm0d837ilyRXf
	RZsAwVhF2crkXtxGRsBhJdYgmpCx+ITPpyv2Du4LpaG7E3yrXt5pjbKLZ0b9b9GgZBA8cPw9CZZ
	RglwiuCMmM/oFDHFBbYULRxrclPaYaSuz5nVX/LKWLrNg7YlGARhPt1QdBp4+7YAD43OFTQj63n
	WsVCu4k22ZoL4EufxSxfDPI0YTL8l9E2HDRha0FUEYByZzCv7Durlmcm6Q8SjtQ0ksVC+DpSgsQ
	32pVOJnET1ssS6et1avBUUpdeC9d9pPTahEsUnHRbor9D/q0QQUsIJ1tj4zjFptnpjNCQHnd239
	VkB/ldYZFsPJFvE6O5W/HdhGtNK87xnG7e44RIzZwhijstF2ZJubHCURuyZ31CUwMQf4QY93QR6
	PTcyQcJnspfP0MsqAD9itDYoNGglJhphfWt9zdhSjZ+kcSASV1z8vb9SuB7fL3pqvwDt3VxJMzP
	2aVKGJsLY/RLgJqzUXh/1w4qIkN8T15ffvRlExTQ1dJXD1jAv0RXJ8B+GRD6EOm5mGSxs67K4wD
	ez7VchNp+02LAMdrNVrycvIR+w01+8AQiAhg51uz/+tjkvAkTK7+iY5v
X-Received: by 2002:a05:600c:4e0d:b0:4a5:e6fd:65e5 with SMTP id 5b1f17b1804b1-4bb88922a67mr247745395e9.31.1795454990125;
        Mon, 23 Nov 2026 09:29:50 -0800 (PST)
Received: from DESKTOP-V28CTA4.localdomain ([103.125.177.105])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4bb906cdcc1sm180101075e9.2.2026.11.23.09.29.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 09:29:49 -0800 (PST)
From: Arbab Haider <arbabhaider649@gmail.com>
To: Theodore Ts'o <tytso@mit.edu>
Cc: Andreas Dilger <adilger.kernel@dilger.ca>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Jan Kara <jack@suse.cz>,
	Ojaswin Mujoo <ojaswin@linux.ibm.com>,
	Ritesh Harjani <ritesh.list@gmail.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	linux-ext4@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Arbab Haider <arbabhaider649@gmail.com>
Subject: [PATCH v3] ext4: fix inline data conversion races when !EXT4_STATE_MAY_INLINE_DATA
Date: Mon, 23 Nov 2026 22:28:57 +0500
Message-ID: <20261123172856.100887-2-arbabhaider649@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Commit ef09ed5d37b8 ("ext4: fix bug_on in ext4_writepages") attempted to
prevent ext4_convert_inline_data() from racing with delayed-allocation
inline data conversion by calling filemap_flush() when
EXT4_STATE_MAY_INLINE_DATA is already cleared.

However, filemap_flush() is asynchronous (WB_SYNC_NONE) and can return 0
while folio 0 is locked by a concurrent buffered write and
ext4_has_inline_data(inode) is still true.  ext4_convert_inline_data()
then proceeds to ext4_convert_inline_data_nolock() even though
EXT4_STATE_MAY_INLINE_DATA is already cleared (meaning
ext4_da_convert_inline_data_to_extent() has already moved the data into
dirty folio 0).  This causes multiple bugs:

1. If ext4_convert_inline_data_nolock() succeeds, it copies stale
   on-disk inline data into the newly allocated block instead of the
   newer dirty data in folio 0.
2. If ext4_map_blocks() fails (e.g. -ENOSPC or a corrupted block
   bitmap), ext4_destroy_inline_data_nolock() has temporarily cleared
   EXT4_INODE_INLINE_DATA and set EXT4_INODE_EXTENTS before
   ext4_restore_inline_data() restores EXT4_INODE_INLINE_DATA and
   unconditionally re-sets EXT4_STATE_MAY_INLINE_DATA.  This races with
   ext4_do_writepages() and triggers:

     kernel BUG at fs/ext4/inode.c:2949!
     RIP: 0010:ext4_do_writepages+0x25c0/0x39a0
     Call Trace:
      ext4_writepages+0x285/0x500
      do_writepages+0x205/0x520
      filemap_writeback+0x1a6/0x250
      file_write_and_wait_range+0x8c/0x150
      ext4_sync_file+0x2cf/0x950
      ext4_buffered_write_iter+0x428/0x5d0
      ext4_file_write_iter+0x7cb/0x1450

3. A concurrent ext4_da_convert_inline_data_to_extent() can also clear
   EXT4_STATE_MAY_INLINE_DATA between the initial check in
   ext4_convert_inline_data() and acquiring ext4_write_lock_xattr().

In addition, ext4_inline_data_truncate() mishandles inodes that are
already in the delayed-allocation transition (!EXT4_STATE_MAY_INLINE_DATA):

- When truncated to i_size == 0, truncate_pagecache() drops dirty folio 0
  and ext4_es_remove_extent() removes delayed extents, but
  EXT4_INODE_INLINE_DATA was left set with !EXT4_STATE_MAY_INLINE_DATA and
  no dirty pages, causing subsequent synchronous writeback in
  ext4_convert_inline_data() to leave EXT4_INODE_INLINE_DATA set.
- When truncated to 0 < i_size <= inline_size, ext4_inline_data_truncate()
  removed delayed extents starting from block 0 (instead of last_block)
  when i_size < inline_size and skipped removal when i_size == inline_size,
  evicting block 0's delayed extent while dirty folio 0 remained in the
  page cache and triggering WARN_ON_ONCE(!err) in ext4_do_writepages().

Fix both functions so that EXT4_STATE_MAY_INLINE_DATA transitions are
strictly monotonic and ext4_convert_inline_data_nolock() is never called
with !EXT4_STATE_MAY_INLINE_DATA:

- In ext4_convert_inline_data():
  * Use synchronous filemap_write_and_wait() instead of filemap_flush()
    when !EXT4_STATE_MAY_INLINE_DATA.
  * If ext4_has_inline_data(inode) is still true after writeback, return
    ext4_emergency_state(inode->i_sb) or -EIO instead of falling through
    to ext4_convert_inline_data_nolock().
  * Re-check EXT4_STATE_MAY_INLINE_DATA under ext4_write_lock_xattr()
    and retry via filemap_write_and_wait() if it was cleared concurrently.
- In ext4_inline_data_truncate():
  * When !EXT4_STATE_MAY_INLINE_DATA and inode->i_size == 0, remove all
    delayed extents and finish converting the empty inode out of inline
    data via ext4_destroy_inline_data_nolock().
  * Otherwise when !EXT4_STATE_MAY_INLINE_DATA, remove only delayed
    extents from last_block onward so block 0's delayed extent is
    preserved while dirty folio 0 remains in the page cache.

Tested locally in QEMU (x86_64, 4 CPUs, KASAN+UBSAN+PROVE_LOCKING) with:
- A 14-case inline_data torture suite covering delalloc -> fallocate/mmap,
  delalloc -> ftruncate(0/16/60) -> fallocate/mmap, 1KB blocksize, ENOSPC
  recovery, 2-CPU ftruncate(0) vs fsync races, and 4-thread concurrent
  write/ftruncate/fallocate/mmap torture (all passed, 0 errors/lockdep).
- A multi-mount concurrent mmap + O_SYNC write reproducer on a corrupted
  inline_data image: hit kernel BUG at fs/ext4/inode.c:2949 on mount #1
  before the patch, and completed 30 fresh mounts with zero BUG, WARNING,
  KASAN, or lockdep reports after the patch.

Fixes: ef09ed5d37b8 ("ext4: fix bug_on in ext4_writepages")
Cc: stable@vger.kernel.org
Signed-off-by: Arbab Haider <arbabhaider649@gmail.com>
---
Changes in v3:
- Address Sashiko v2 review feedback: in ext4_inline_data_truncate(), when
  !EXT4_STATE_MAY_INLINE_DATA and inode->i_size == 0, destroy inline data
  via ext4_destroy_inline_data_nolock() so truncating a delalloc-pending
  inline file to 0 does not leave an orphaned !MAY_INLINE state that would
  cause spurious -EIO in ext4_convert_inline_data().
- In ext4_inline_data_truncate(), remove delayed extents starting from
  last_block (rather than 0) when !EXT4_STATE_MAY_INLINE_DATA and
  i_size > 0, preserving block 0's delayed extent for dirty folio 0.
- Simplify ext4_convert_inline_data() retry/error handling using
  ext4_emergency_state().

Changes in v2:
- Address Sashiko v1 review feedback: prevent ext4_convert_inline_data()
  from calling ext4_convert_inline_data_nolock() when
  !EXT4_STATE_MAY_INLINE_DATA (using filemap_write_and_wait() and
  re-checking under xattr_sem).
 fs/ext4/inline.c | 62 ++++++++++++++++++++++++++++++++++++++----------
 1 file changed, 49 insertions(+), 13 deletions(-)

diff --git a/fs/ext4/inline.c b/fs/ext4/inline.c
index ceee69a66..a74054961 100644
--- a/fs/ext4/inline.c
+++ b/fs/ext4/inline.c
@@ -1890,6 +1890,25 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 	if ((err = ext4_orphan_add(handle, inode)) != 0)
 		goto out;
 
+	/*
+	 * If the file was already moved to delayed allocation
+	 * (!EXT4_STATE_MAY_INLINE_DATA) and is now truncated to zero,
+	 * truncate_pagecache() has already dropped dirty folio 0. Finish
+	 * converting the empty inode out of inline data here instead of
+	 * leaving EXT4_INODE_INLINE_DATA set with !EXT4_STATE_MAY_INLINE_DATA
+	 * and no dirty pages.
+	 */
+	if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA) &&
+	    inode->i_size == 0) {
+		down_write(&EXT4_I(inode)->i_data_sem);
+		EXT4_I(inode)->i_disksize = 0;
+		ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
+		up_write(&EXT4_I(inode)->i_data_sem);
+
+		err = ext4_destroy_inline_data_nolock(handle, inode);
+		goto out;
+	}
+
 	if ((err = ext4_get_inode_loc(inode, &is.iloc)) != 0)
 		goto out;
 
@@ -1898,16 +1917,21 @@ int ext4_inline_data_truncate(struct inode *inode, int *has_inline)
 	inline_size = ext4_get_inline_size(inode);
 	EXT4_I(inode)->i_disksize = i_size;
 
-	if (i_size < inline_size) {
-		/*
-		 * if there's inline data to truncate and this file was
-		 * converted to extents after that inline data was written,
-		 * the extent status cache must be cleared to avoid leaving
-		 * behind stale delayed allocated extent entries
-		 */
-		if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA))
-			ext4_es_remove_extent(inode, 0, EXT_MAX_BLOCKS);
+	/*
+	 * If this file was moved to delayed allocation (EXT4_STATE_MAY_INLINE_DATA
+	 * cleared), remove delayed extents beyond the new i_size while keeping
+	 * block 0 if i_size > 0 (folio 0 is still dirty in the page cache).
+	 */
+	if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
+		ext4_lblk_t last_block =
+			(inode->i_size + i_blocksize(inode) - 1) >>
+			inode->i_blkbits;
 
+		ext4_es_remove_extent(inode, last_block,
+				      EXT_MAX_BLOCKS - last_block);
+	}
+
+	if (i_size < inline_size) {
 		/* Clear the content in the xattr space. */
 		if (inline_size > EXT4_MIN_INLINE_DATA_SIZE) {
 			if ((err = ext4_xattr_ibody_find(inode, &i, &is)) != 0)
@@ -1977,6 +2001,7 @@ int ext4_convert_inline_data(struct inode *inode)
 	handle_t *handle;
 	struct ext4_iloc iloc;
 
+retry:
 	if (!ext4_has_inline_data(inode)) {
 		ext4_clear_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA);
 		return 0;
@@ -1984,14 +2009,18 @@ int ext4_convert_inline_data(struct inode *inode)
 		/*
 		 * Inode has inline data but EXT4_STATE_MAY_INLINE_DATA is
 		 * cleared. This means we are in the middle of moving of
-		 * inline data to delay allocated block. Just force writeout
-		 * here to finish conversion.
+		 * inline data to delay allocated block. Force synchronous
+		 * writeout here to finish conversion.
 		 */
-		error = filemap_flush(inode->i_mapping);
+		error = filemap_write_and_wait(inode->i_mapping);
 		if (error)
 			return error;
 		if (!ext4_has_inline_data(inode))
 			return 0;
+		error = ext4_emergency_state(inode->i_sb);
+		if (error)
+			return error;
+		return -EIO;
 	}
 
 	needed_blocks = ext4_chunk_trans_extent(inode, 1);
@@ -2008,8 +2037,15 @@ int ext4_convert_inline_data(struct inode *inode)
 	}
 
 	ext4_write_lock_xattr(inode, &no_expand);
-	if (ext4_has_inline_data(inode))
+	if (ext4_has_inline_data(inode)) {
+		if (!ext4_test_inode_state(inode, EXT4_STATE_MAY_INLINE_DATA)) {
+			ext4_write_unlock_xattr(inode, &no_expand);
+			ext4_journal_stop(handle);
+			brelse(iloc.bh);
+			goto retry;
+		}
 		error = ext4_convert_inline_data_nolock(handle, inode, &iloc);
+	}
 	ext4_write_unlock_xattr(inode, &no_expand);
 	ext4_journal_stop(handle);
 out_free:
-- 
2.53.0

