Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.224.47
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795131680;
	b=c5AGWkmpaFvzQImJUTRvYfIm7IKFBW/kGt2GMYVygVP5s/g8z2hdUUrhj5ifI7BzgnyH
	 FM68p15xh2q4XQaXV4rDv+MOgVF1l/2cOBM2m08jthtVjbJi+QX4lOsp8sCRsXg9qY62h
	 4/m8tSQ1cZOJVSHRgO+g9ttzv0qdS5u1N5CXTMWmyi+Go+taDpPvwrSCO90+NTf9M4zI4
	 MfcSj9XqZ2KopaoVLWejH1sWL7hr7dCaadlxOsbjjh6IAKNgXdNObpQKTNEGXtjVwgjoD
	 u7TsozdRWqW6ZObi82NH8sZ2fELy5gI1b40HmtUlWRxqUBKcu5WjIYzBt4atgtK9ljg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795131680;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=AoD75E4XjAQHTfFHYDSfA+HbjnEiz4bmLY1RO2qIAxM=;
	b=vagR3J0b9lVWJJbb9gmxLCs4Ue79SIG00Y2lcJgmICcypbgfM9huBijKRrEdlvnoqWXA
	 OJc2DYhQZyk2SdTIUYUqH6+vl+1zyK3H7yGqYGY7ckr6r10458cs7odbaE8bznLDlhgS3
	 nkUHFrxHR99chWeVbzmJwSNGFYL91pft3/3rm+FJCC86bqTUAKTBed8tzHrijsyzty0oS
	 K8QXEB51ndvhdXqeMxXC63jSGMZle1hGTGkWQuo5bjwvKPDcezrd2H+DNOw3h9urbCTWL
	 nuGUggRIjM/MSqhxT31Nuqf+fSDvf822W4uxxo/eO0eb5fAYywE+z574oqQGEs2fUBA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=dubeyko.com;
	spf=pass smtp.mailfrom=dubeyko.com;
	dkim=pass header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gHqw6+Q7;
	arc=none smtp.remote-ip=74.125.224.47
Received: from mail-yx1-f47.google.com (mail-yx1-f47.google.com [74.125.224.47])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A84E606A338
	for <stable@vger.kernel.org>; Thu, 19 Nov 2026 23:41:19 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1A84E606A338
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=dubeyko.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dubeyko-com.20260707.gappssmtp.com header.i=@dubeyko-com.20260707.gappssmtp.com header.a=rsa-sha256 header.s=20260707 header.b=gHqw6+Q7
Received: by mail-yx1-f47.google.com with SMTP id 956f58d0204a3-67c6a0abc2eso503009d50.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 15:41:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dubeyko-com.20260707.gappssmtp.com; s=20260707; t=1795131679; x=1795736479; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=AoD75E4XjAQHTfFHYDSfA+HbjnEiz4bmLY1RO2qIAxM=;
        b=gHqw6+Q7uGEPvjm/SC/4rQO10zqaMXzgtZNuUHNJeY7YdA9vh6Af+tUZfpjLjKFO/g
         E+5kfFi5MyT+oes0JIKYbL6rEcmfhUybKOHMVLONo+V10fr7MXGZR/SriIsRsyDIPvd7
         Cu6VBKy4JVqkOcGPiA4HLwmpfYzg8jk8yeGKLtkMT5lJfqI8d8GcogQGX/FZYDMKBM64
         VRB12GX67nUHv9zyScalfaj7V4hhaU1zQ+HbNQfyGM9Hsii7GgOK4dHSGuzTbu1QDkPU
         /5uEEqKqqmt+1G6OMZcIFGxRsPsnMq+oYsdFfPd+DAdwjS948GuUy5ZuN4MZtHA1WUxZ
         rGsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795131679; x=1795736479;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=AoD75E4XjAQHTfFHYDSfA+HbjnEiz4bmLY1RO2qIAxM=;
        b=Rxd0FNFKsd6BKJ0cML62iOTF2KZrzF1x9w0OytXtl+/qiaYvi1tCBtrmnbYsR2v1Ux
         qvB1DLbMPfRRk3AF7oR8/IhWHqCtqQnAkq9Xn4c85YLLs1P/dUX+fSB7OiB+6geqwHN5
         iiYYMcy4rnxharPwD3j+M4CCOh2ioDcfMmO2MW9z5oGrnFA4icXOO6JMi3KVJhUL6oNi
         myXAJmrIcHT1uiPkkkMYgb54/yP8taCLkhYCkBlmYwBnAG4wJMn64FxsvcSTNFggmI1C
         aZk2Pd2IsIcOMbrY84tW+ZR37yX58iU72HgD54JH4EiAjZtai9mnF5EHu/XFFk93q8hV
         fBuw==
X-Forwarded-Encrypted: i=1; AL+hErGebhJaD+EzAGmCuaHuRIuzbsBxY98zZvQHVqDRDM8zARRHRH492CdaBSu5tAOc3Z+CVnGU9Vk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+K9/8yQ/SETh173agaFcN4oBNo1KldsPIyBWQj4+ZbOy5X2zjF
	/C4yMzpQzbyNQHZi0v3xGSYa67Rdyt6TFyPd8ZdhssA3fSffh9AAYmecDocOYRQFlkk=
X-Gm-Gg: AZFdTZfc8Iwa8wzoR7ckjYSK8cAX77eNyK8b3R0DzNAWsNkrS9D6bY/tNmfpGNUt1hx
	b76YZME+84NmdYrX8bbKwPHys2HZFWHomG5kcuee9Uyfax0ytJjZbjXx+F0NQGSlViD2lHpLxoL
	W1KaWSkOJm/e4QHmxRl8zIXHCHVfCNJmLzQ2H3x5kJHUOVrqD1MfSRS+MD0Fba9SltZh1jwxz26
	BB4BMwbo54Vs896v7flFN+eoCCP0fdgZQXwk8rrT2E3sjOWiaUt5yZvwb2Xg4uUiNIveFh5/bPV
	ErK7bDSjNXPDuDn+N33QRCcV/Yxt7xw68tVTTR0Q6cL9FGg6UC3BfL7dW80F5ijbb4yVyMPCtdi
	CjCv4Yn15APJTvg70wwAtrCnF5PE8slcwDC5D09GHWhyz6DwmedeMqPUZI4ElE1PWvhqb3K/JRR
	t4Fbq0QAkCl03eHm+p7tC6BAua3EZEOnJd1ae6qAuSPhqLMmGQSR/3bNoO+FaZ+jTwYgFbAwQq0
	83ePua+Ev+XpxWouiKASiFXVPL+WqsSWJoecWYPDQbzwONcYd9wyvCjav/Py7RiGlNjVES5V3F1
	oCu+GLALEWlTkqqHwSRjHw6Yxd1zhYKH6+q2l1FLCleqfmuHvLavF9o6Wz/yzUs0kHeGZxHgA4B
	/FabnAWNiMknrwub5EY3D6LsWj7eS9lAMyCIHEZ2sJiNiAMHViuQmoLgVr3q2GXFunFXKVbw=
X-Received: by 2002:a05:690e:4394:b0:679:8db9:517c with SMTP id 956f58d0204a3-67df42c4560mr244599d50.6.1795131678920;
        Thu, 19 Nov 2026 15:41:18 -0800 (PST)
Received: from system76-laptop.attlocal.net ([2600:1700:6476:1430:1932:ad09:1827:11fb])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-67df338e8fesm796893d50.16.2026.11.19.15.41.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 15:41:18 -0800 (PST)
From: Viacheslav Dubeyko <slava@dubeyko.com>
To: glaubitz@physik.fu-berlin.de,
	frank.li@vivo.com
Cc: linux-fsdevel@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	vdubeyko@coreweave.com,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Zheng Zheng <fengaojigui88@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 2/5] hfsplus: map the allocation file without the extents B-tree
Date: Thu, 19 Nov 2026 15:41:09 -0800
Message-ID: <20261119234112.720963-3-slava@dubeyko.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261119234112.720963-1-slava@dubeyko.com>
References: <20261119234112.720963-1-slava@dubeyko.com>
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

hfsplus_block_allocate() and hfsplus_block_free() read the allocation
bitmap through the allocation file with sbi->alloc_mutex held. When the
bitmap page is not cached and lies beyond the allocation file's extents
in the volume header, hfsplus_get_block() takes the allocation file's
extents_lock and looks the block up in the extents B-tree under its
tree_lock.

Growing the extents B-tree does the opposite: hfs_bmap_reserve() is
called with the B-tree's tree_lock held and extends the B-tree file,
which allocates blocks under alloc_mutex. If the bitmap page needed
there is not cached and is mapped by an extent record of the
allocation file, the task tries to take the tree_lock it already holds
and deadlocks:

  WARNING: possible recursive locking detected
  dd/1404 is trying to acquire lock:
  (&tree->tree_lock/1){+.+.}-{4:4}, at: hfsplus_find_init
  but task is already holding lock:
  (&tree->tree_lock/1){+.+.}-{4:4}, at: hfsplus_find_init
  ...
   hfsplus_find_init
   hfsplus_ext_read_extent
   hfsplus_get_block
   block_read_full_folio
   ...
   read_cache_page
   hfsplus_block_allocate
   hfsplus_file_extend
   hfsplus_bmap_reserve
   __hfsplus_ext_write_extent
   hfsplus_ext_read_extent
   hfsplus_file_extend
   hfsplus_get_block
   ...
   hfsplus_write_begin

The writer, the flusher and the superblock commit work then hang. Two
tasks can also deadlock on the same pair of locks taken in opposite
order.

The same lookup is behind the lockdep report from syzkaller in which
truncating an unlinked file takes the allocation file's extents_lock
inside its own (hfsplus_file_truncate() -> hfsplus_free_extents() ->
hfsplus_block_free() -> read_cache_page() -> hfsplus_get_block()).
Syzkaller reached it with a corrupted image, which the previous patch
rejects at mount.

The allocation file cannot grow or shrink while the volume is mounted.
Read its extent records from the extents B-tree once at mount time and
map its blocks beyond the volume header's extents from them, so that
reading the bitmap takes neither the allocation file's extents_lock nor
the extents B-tree's tree_lock. The extents read are kept in the new
struct hfsplus_overflow_extents, which sbi->alloc_file now holds
together with the allocation file's inode as struct hfsplus_alloc_file.
A missing or inconsistent extent record now fails the mount instead of
failing the bitmap reads later.

Tested on a KASAN and lockdep kernel: the reproducer completes without
a lockdep report and fsck.hfsplus reports the volume as OK, also after
allocating blocks whose bitmap page is mapped by the extent record; a
volume whose extent record of the allocation file starts at the wrong
block is rejected at mount; generic/001, 002, 013, 075 and 112 pass,
generic/091 fails as it does without this change.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: Zheng Zheng <fengaojigui88@gmail.com>
Closes: https://lore.kernel.org/linux-fsdevel/CAO-4RZ1a46EoJY7x6euiS+7aTOb-T9X62E9nGyToRcyvKU+eHg@mail.gmail.com/
Cc: stable@vger.kernel.org
cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
cc: Yangtao Li <frank.li@vivo.com>
cc: linux-fsdevel@vger.kernel.org
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
---
 fs/hfsplus/bitmap.c     |   4 +-
 fs/hfsplus/extents.c    | 136 ++++++++++++++++++++++++++++++++++++----
 fs/hfsplus/hfsplus_fs.h |  14 ++++-
 fs/hfsplus/inode.c      |   4 +-
 fs/hfsplus/super.c      |  18 ++++--
 5 files changed, 153 insertions(+), 23 deletions(-)

diff --git a/fs/hfsplus/bitmap.c b/fs/hfsplus/bitmap.c
index 30178ea47362..62c39849e381 100644
--- a/fs/hfsplus/bitmap.c
+++ b/fs/hfsplus/bitmap.c
@@ -33,7 +33,7 @@ int hfsplus_block_allocate(struct super_block *sb, u32 size,
 
 	hfs_dbg("size %u, offset %u, len %u\n", size, offset, len);
 	mutex_lock(&sbi->alloc_mutex);
-	mapping = sbi->alloc_file->i_mapping;
+	mapping = sbi->alloc_file.inode->i_mapping;
 	page = read_mapping_page(mapping, offset / PAGE_CACHE_BITS, NULL);
 	if (IS_ERR(page)) {
 		start = size;
@@ -192,7 +192,7 @@ int hfsplus_block_free(struct super_block *sb, u32 offset, u32 count)
 		return -ENOENT;
 
 	mutex_lock(&sbi->alloc_mutex);
-	mapping = sbi->alloc_file->i_mapping;
+	mapping = sbi->alloc_file.inode->i_mapping;
 	pnr = offset / PAGE_CACHE_BITS;
 	page = read_mapping_page(mapping, pnr, NULL);
 	if (IS_ERR(page))
diff --git a/fs/hfsplus/extents.c b/fs/hfsplus/extents.c
index 924941440066..da6ab85a64ae 100644
--- a/fs/hfsplus/extents.c
+++ b/fs/hfsplus/extents.c
@@ -53,7 +53,7 @@ static u32 hfsplus_ext_find_block(struct hfsplus_extent *ext, u32 off)
 	int i;
 	u32 count;
 
-	for (i = 0; i < 8; ext++, i++) {
+	for (i = 0; i < HFSPLUS_FORK_EXTENT_COUNT; ext++, i++) {
 		count = be32_to_cpu(ext->block_count);
 		if (off < count)
 			return be32_to_cpu(ext->start_block) + off;
@@ -68,17 +68,18 @@ static int hfsplus_ext_block_count(struct hfsplus_extent *ext)
 	int i;
 	u32 count = 0;
 
-	for (i = 0; i < 8; ext++, i++)
+	for (i = 0; i < HFSPLUS_FORK_EXTENT_COUNT; ext++, i++)
 		count += be32_to_cpu(ext->block_count);
 	return count;
 }
 
 static u32 hfsplus_ext_lastblock(struct hfsplus_extent *ext)
 {
+	int last_index = HFSPLUS_FORK_EXTENT_COUNT - 1;
 	int i;
 
-	ext += 7;
-	for (i = 0; i < 7; ext--, i++)
+	ext += last_index;
+	for (i = 0; i < last_index; ext--, i++)
 		if (ext->block_count)
 			break;
 	return be32_to_cpu(ext->start_block) + be32_to_cpu(ext->block_count);
@@ -225,6 +226,102 @@ static int hfsplus_ext_read_extent(struct inode *inode, u32 block)
 	return res;
 }
 
+/*
+ * The allocation bitmap is read through the allocation file with
+ * sbi->alloc_mutex held, sometimes by a task that holds the extents
+ * B-tree's tree_lock because it is growing the B-tree. So mapping a
+ * block of the allocation file must not search the extents B-tree.
+ *
+ * The allocation file is not resized while the volume is mounted, so
+ * read the extents of it that are not in the volume header once, at
+ * mount time, and map its blocks from them.
+ */
+int hfsplus_ext_load_alloc_file(struct super_block *sb)
+{
+	struct hfsplus_sb_info *sbi = HFSPLUS_SB(sb);
+	struct hfsplus_alloc_file *alloc_file = &sbi->alloc_file;
+	struct inode *inode = alloc_file->inode;
+	struct hfsplus_inode_info *hip = HFSPLUS_I(inode);
+	struct hfsplus_extent *ext = NULL, *new;
+	struct hfs_find_data fd;
+	u32 block = hip->first_blocks;
+	u32 nr = 0;
+	int res;
+
+	if (block >= hip->alloc_blocks)
+		return 0;
+
+	res = hfs_find_init(sbi->ext_tree, &fd);
+	if (res)
+		return res;
+
+	while (block < hip->alloc_blocks) {
+		hfsplus_extent_rec rec;
+		u32 start_block, count;
+		u32 rest_blocks;
+
+		res = __hfsplus_ext_read_extent(&fd, rec, inode->i_ino, block,
+						HFSPLUS_TYPE_DATA);
+		if (res)
+			goto fail;
+
+		start_block = be32_to_cpu(fd.key->ext.start_block);
+		count = hfsplus_ext_block_count(rec);
+		rest_blocks = hip->alloc_blocks - block;
+
+		if (start_block != block || count == 0 || count > rest_blocks) {
+			res = -EIO;
+			goto fail;
+		}
+
+		new = krealloc_array(ext, nr + ARRAY_SIZE(rec), sizeof(*ext),
+				     GFP_KERNEL);
+		if (!new) {
+			res = -ENOMEM;
+			goto fail;
+		}
+
+		ext = new;
+		memcpy(ext + nr, rec, sizeof(rec));
+		nr += ARRAY_SIZE(rec);
+		block += count;
+	}
+
+	hfs_find_exit(&fd);
+	alloc_file->overflow.extents = ext;
+	alloc_file->overflow.count = nr;
+	return 0;
+
+fail:
+	hfs_find_exit(&fd);
+	kfree(ext);
+	pr_err("can't read the allocation file extents at block %u: %d\n",
+	       block, res);
+	return res == -ENOENT ? -EIO : res;
+}
+
+/*
+ * Map @ablock of the allocation file, which lies beyond its extents in
+ * the volume header. Returns 0 if it is not allocated.
+ */
+static u32 hfsplus_ext_alloc_file_block(struct super_block *sb, u32 ablock)
+{
+	struct hfsplus_alloc_file *alloc_file = &HFSPLUS_SB(sb)->alloc_file;
+	struct hfsplus_overflow_extents *overflow = &alloc_file->overflow;
+	u32 off = ablock - HFSPLUS_I(alloc_file->inode)->first_blocks;
+	u32 start_block, count;
+	u32 i;
+
+	for (i = 0; i < overflow->count; i++) {
+		start_block = be32_to_cpu(overflow->extents[i].start_block);
+		count = be32_to_cpu(overflow->extents[i].block_count);
+		if (off < count)
+			return start_block + off;
+		off -= count;
+	}
+	return 0;
+}
+
 /* Get a block at iblock for inode, possibly allocating if create */
 int hfsplus_get_block(struct inode *inode, sector_t iblock,
 		      struct buffer_head *bh_result, int create)
@@ -258,9 +355,22 @@ int hfsplus_get_block(struct inode *inode, sector_t iblock,
 		goto done;
 	}
 
-	if (inode->i_ino == HFSPLUS_EXT_CNID)
+	switch (inode->i_ino) {
+	case HFSPLUS_EXT_CNID:
 		return -EIO;
 
+	case HFSPLUS_ALLOC_CNID:
+		dblock = hfsplus_ext_alloc_file_block(sb, ablock);
+		if (!dblock)
+			return -EIO;
+		else
+			goto done;
+
+	default:
+		/* continue logic */
+		break;
+	}
+
 	mutex_lock(&hip->extents_lock);
 
 	/*
@@ -303,7 +413,7 @@ static void hfsplus_dump_extent(struct hfsplus_extent *extent)
 	int i;
 
 	hfs_dbg("extent   ");
-	for (i = 0; i < 8; i++)
+	for (i = 0; i < HFSPLUS_FORK_EXTENT_COUNT; i++)
 		hfs_dbg(" start_block %u, block_count %u",
 			be32_to_cpu(extent[i].start_block),
 			be32_to_cpu(extent[i].block_count));
@@ -317,7 +427,7 @@ static int hfsplus_add_extent(struct hfsplus_extent *extent, u32 offset,
 	int i;
 
 	hfsplus_dump_extent(extent);
-	for (i = 0; i < 8; extent++, i++) {
+	for (i = 0; i < HFSPLUS_FORK_EXTENT_COUNT; extent++, i++) {
 		count = be32_to_cpu(extent->block_count);
 		if (offset == count) {
 			start = be32_to_cpu(extent->start_block);
@@ -347,7 +457,7 @@ static int hfsplus_free_extents(struct super_block *sb,
 	int err = 0;
 
 	hfsplus_dump_extent(extent);
-	for (i = 0; i < 8; extent++, i++) {
+	for (i = 0; i < HFSPLUS_FORK_EXTENT_COUNT; extent++, i++) {
 		count = be32_to_cpu(extent->block_count);
 		if (offset == count)
 			goto found;
@@ -405,7 +515,7 @@ int hfsplus_free_fork(struct super_block *sb, u32 cnid,
 		return 0;
 
 	blocks = 0;
-	for (i = 0; i < 8; i++)
+	for (i = 0; i < HFSPLUS_FORK_EXTENT_COUNT; i++)
 		blocks += be32_to_cpu(fork->extents[i].block_count);
 
 	res = hfsplus_free_extents(sb, fork->extents, blocks, blocks);
@@ -445,11 +555,11 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	u32 start, len, goal;
 	int res;
 
-	if (sbi->alloc_file->i_size * 8 <
+	if (sbi->alloc_file.inode->i_size * 8 <
 	    sbi->total_blocks - sbi->free_blocks + 8) {
 		/* extend alloc file */
 		pr_err_ratelimited("extend alloc file! (%llu,%u,%u)\n",
-				   sbi->alloc_file->i_size * 8,
+				   sbi->alloc_file.inode->i_size * 8,
 				   sbi->total_blocks, sbi->free_blocks);
 		return -ENOSPC;
 	}
@@ -517,7 +627,7 @@ int hfsplus_file_extend(struct inode *inode, bool zeroout)
 	if (!res) {
 		hip->alloc_blocks += len;
 		mutex_unlock(&hip->extents_lock);
-		hfsplus_mark_inode_dirty(HFSPLUS_SB(sb)->alloc_file,
+		hfsplus_mark_inode_dirty(HFSPLUS_SB(sb)->alloc_file.inode,
 					 HFSPLUS_I_ALLOC_DIRTY);
 		hfsplus_mark_inode_dirty(inode, HFSPLUS_I_ALLOC_DIRTY);
 		return 0;
@@ -637,7 +747,7 @@ void hfsplus_file_truncate(struct inode *inode)
 	hip->fs_blocks = (inode->i_size + sb->s_blocksize - 1) >>
 		sb->s_blocksize_bits;
 	inode_set_bytes(inode, hip->fs_blocks << sb->s_blocksize_bits);
-	hfsplus_mark_inode_dirty(HFSPLUS_SB(sb)->alloc_file,
+	hfsplus_mark_inode_dirty(HFSPLUS_SB(sb)->alloc_file.inode,
 				 HFSPLUS_I_ALLOC_DIRTY);
 	hfsplus_mark_inode_dirty(inode, HFSPLUS_I_ALLOC_DIRTY);
 }
diff --git a/fs/hfsplus/hfsplus_fs.h b/fs/hfsplus/hfsplus_fs.h
index dd88053cc9b3..9a304d946297 100644
--- a/fs/hfsplus/hfsplus_fs.h
+++ b/fs/hfsplus/hfsplus_fs.h
@@ -109,6 +109,17 @@ struct hfs_bnode {
 struct hfsplus_vh;
 struct hfs_btree;
 
+/* Extents of a special file that are not in the volume header */
+struct hfsplus_overflow_extents {
+	struct hfsplus_extent *extents;
+	u32 count;
+};
+
+struct hfsplus_alloc_file {
+	struct inode *inode;
+	struct hfsplus_overflow_extents overflow;
+};
+
 struct hfsplus_sb_info {
 	void *s_vhdr_buf;
 	struct hfsplus_vh *s_vhdr;
@@ -118,7 +129,7 @@ struct hfsplus_sb_info {
 	struct hfs_btree *cat_tree;
 	struct hfs_btree *attr_tree;
 	atomic_t attr_tree_state;
-	struct inode *alloc_file;
+	struct hfsplus_alloc_file alloc_file;
 	struct inode *hidden_dir;
 	struct nls_table *nls;
 
@@ -440,6 +451,7 @@ extern const struct file_operations hfsplus_dir_operations;
 int hfsplus_ext_cmp_key(const hfsplus_btree_key *k1,
 			const hfsplus_btree_key *k2);
 int hfsplus_ext_write_extent(struct inode *inode);
+int hfsplus_ext_load_alloc_file(struct super_block *sb);
 int hfsplus_get_block(struct inode *inode, sector_t iblock,
 		      struct buffer_head *bh_result, int create);
 int hfsplus_free_fork(struct super_block *sb, u32 cnid,
diff --git a/fs/hfsplus/inode.c b/fs/hfsplus/inode.c
index 8073fb99217d..e231da2d8a2b 100644
--- a/fs/hfsplus/inode.c
+++ b/fs/hfsplus/inode.c
@@ -410,9 +410,9 @@ int hfsplus_file_fsync(struct file *file, loff_t start, loff_t end,
 	}
 
 	if (test_and_clear_bit(HFSPLUS_I_ALLOC_DIRTY,
-				&HFSPLUS_I(sbi->alloc_file)->flags)) {
+				&HFSPLUS_I(sbi->alloc_file.inode)->flags)) {
 		clear_bit(HFSPLUS_I_ALLOC_DIRTY, &hip->flags);
-		error2 = filemap_write_and_wait(sbi->alloc_file->i_mapping);
+		error2 = filemap_write_and_wait(sbi->alloc_file.inode->i_mapping);
 		if (!error)
 			error = error2;
 	}
diff --git a/fs/hfsplus/super.c b/fs/hfsplus/super.c
index 33594e1f8367..e568a5508b5e 100644
--- a/fs/hfsplus/super.c
+++ b/fs/hfsplus/super.c
@@ -298,7 +298,7 @@ static int hfsplus_sync_fs(struct super_block *sb, int wait)
 		if (!error)
 			error = error2;
 	}
-	error2 = filemap_write_and_wait(sbi->alloc_file->i_mapping);
+	error2 = filemap_write_and_wait(sbi->alloc_file.inode->i_mapping);
 	if (!error)
 		error = error2;
 
@@ -325,7 +325,7 @@ static void delayed_sync_fs(struct work_struct *work)
 	sbi->work_queued = 0;
 	spin_unlock(&sbi->work_lock);
 
-	err = hfsplus_sync_fs(sbi->alloc_file->i_sb, 1);
+	err = hfsplus_sync_fs(sbi->alloc_file.inode->i_sb, 1);
 	if (err)
 		pr_err("delayed sync fs err %d\n", err);
 }
@@ -399,7 +399,8 @@ static void hfsplus_put_super(struct super_block *sb)
 	if (!sb_rdonly(sb) && sbi->s_vhdr)
 		hfsplus_commit_clean_volume_header(sb);
 
-	iput(sbi->alloc_file);
+	iput(sbi->alloc_file.inode);
+	kfree(sbi->alloc_file.overflow.extents);
 	iput(sbi->hidden_dir);
 	hfs_btree_close(sbi->attr_tree);
 	hfs_btree_close(sbi->cat_tree);
@@ -754,7 +755,11 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 		err = PTR_ERR(inode);
 		goto out_close_attr_tree;
 	}
-	sbi->alloc_file = inode;
+	sbi->alloc_file.inode = inode;
+
+	err = hfsplus_ext_load_alloc_file(sb);
+	if (err)
+		goto out_put_alloc_file;
 
 	/* Load the root directory */
 	root = hfsplus_iget(sb, HFSPLUS_ROOT_CNID);
@@ -816,7 +821,10 @@ static int hfsplus_fill_super(struct super_block *sb, struct fs_context *fc)
 	dput(sb->s_root);
 	sb->s_root = NULL;
 out_put_alloc_file:
-	iput(sbi->alloc_file);
+	iput(sbi->alloc_file.inode);
+	kfree(sbi->alloc_file.overflow.extents);
+	sbi->alloc_file.overflow.extents = NULL;
+	sbi->alloc_file.overflow.count = 0;
 out_close_attr_tree:
 	hfs_btree_close(sbi->attr_tree);
 out_close_cat_tree:
-- 
2.53.0

