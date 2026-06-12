Received: from mail-pl1-f176.google.com (mail-pl1-f176.google.com [209.85.214.176])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4686D1EDA0F
	for <stable@vger.kernel.org>; Fri, 12 Jun 2026 07:55:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.176
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781250910; cv=none; b=tgg9FUpGc7b0PdFoEAcI5CLeETZsAbzw00NF99VSh3QkAWmgeJwjdEbZE3NbmXO6OJc+Q5/0J9W9+FqWgsYy/CSQZznYjv2nlsXAKUYpZ2DS+surEjW3PXMPiovt+zDRIfzF+QmdnKDr6/71bF8ThJcyEakj35iU3mgmkpFmwfw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781250910; c=relaxed/simple;
	bh=bK0vXq9qx/UDuyJ5RPAupZKQC3AZDYfG/h0HqYUrmkQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eh0zpKFEb86h6kPNAVnu5IaXDuL5zP1ch+q/+QIwtNnWjCDNA6TdrNUHT7OZ3UNaWWr++8OXt/e4+70o9w4EzkF41VXhl54vZkfjNkOEs0N4sZLVs2lu2zfIIK+8dnfvOFJ7QJ5KtkUQmzsXGgfynBjTJetIleu03AOm8Xnyibw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=dfQvzzYP; arc=none smtp.client-ip=209.85.214.176
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="dfQvzzYP"
Received: by mail-pl1-f176.google.com with SMTP id d9443c01a7336-2bf77d4a4e2so9853565ad.1
        for <stable@vger.kernel.org>; Fri, 12 Jun 2026 00:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1781250904; x=1781855704; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=aICWzbSor3YglIIcIzDbPDsV8rAey0alh+YDWOMY7mI=;
        b=dfQvzzYP44AHH3hoqhXJJ+wJg6YWcJ7JhCA/3uCwIRIt/nekd88OYPi5Na2ew7JFTU
         GGrJj2LS4pYN4xJgnlY5eEjYMH5nuWpPqAhYAIAQq6SlH8V+PeFTMpTD3ZSM2ccbqA7Q
         /pYKOiHX5faLoi8ERm4NRAx642EUPgyt1Cd8tK9jBmefYoIHQO17N1fGLEwGPvChCixu
         4lxjVGFwvBVUnQH9g92zPKQF7PT1Ak+PJleGgMmIkhNJoWyPLaWBvBLKhsgSTnaM5wSO
         u0GjK2iZWI0hy9bMAr5HOlFRyqEEV2tg/mIwBHN5+4SRb+pdAbsmVgvt7JyZjBhVSkR4
         8A2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781250904; x=1781855704;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=aICWzbSor3YglIIcIzDbPDsV8rAey0alh+YDWOMY7mI=;
        b=sjd9nxTbREomnEPvl9D33E/oXLsjpwClW0pGAeZc50Duz9hn0Garoeb9rLthCX4hPY
         gSlIawYpcIjdPY/wOKFa/0U1Su+hDTTPr1i1S7/Vq02WUHJx4/pwkCANHxJK/hUdv69Y
         KWIqh+3dfmMX91/JOgDClb5LYLZV64j4TmT7gTPtMihHaC4vo6qZz+b70tUkEg/UxWTN
         Vse94iMnccczL7YdV1L9pGOiue7ZcqAsiz2W0DkxeI/OhgCRXqZYXE1z4eTzqtGXYN+V
         51NFd14WfhRjMZ/iOhDGHXZvZX3M/AgzI5Aj69llUFfBAgDFjcAU0NJRAooN0nQ+qv6i
         G1lQ==
X-Forwarded-Encrypted: i=1; AFNElJ+JgnnJTyPrc+p9hBP8mqVG0y2xVJzMIqMcPOOh512H876E9rM6qTgW6TDdaGUuXLHX0exGFdo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxvxzw/m2dc/rLX0QpnDFLCQlxf3m05SIbDyPoQfpui8F/+wD4t
	D1geTczzByOncD220M+utwqimj4Y068ts52WshG3bO/8iwGmrzYQB55c
X-Gm-Gg: Acq92OGxDaYivr+mNAvyOmeZltOKxU4DkDA19HUkyWmsH5neQewh6C7kmefwJL5yZAv
	VMyUK29BVsuGtajtTYGQO9ZiHG3Uw4oNV24o9Jz1K5lmFwbfbqME/+NPTFkDraOrjHCqqwAoM6F
	0Oe9Kru7/0SEulnBU41x+eXdiolc5DvHDYB1tpnDphkkfD5FLPU11ZG7X2gb2L+1PWGtiEH8Pzv
	WpDNYqRY/+gzypJvFHKa4MF2Y3mrhjMyMcKR9c8r8HIOZJOBhcJggeRh4oXMeOsg6n0PcqaL1DB
	xKx/9gxOxM1Yhg1b/I9OqO7xh+g3r0AC/N7mYK3fR346zHA3TVZz9UB89ohO94ubhto/KwH4MPM
	2+vMGDELXpAr8jlXFOPJptgjOZIplXzu18fh+EdwqNqe1erRslceJ3qPGZXcbMTRbmFpsAWBPlM
	X1Om2G8ik+eQ4Xs0YX24KqGA9IXcLrVkJUhhxTygC4C8KY2IMyLIEeGMg=
X-Received: by 2002:a17:903:1208:b0:2bd:73f4:8e4f with SMTP id d9443c01a7336-2c429181b81mr14328645ad.0.1781250904384;
        Fri, 12 Jun 2026 00:55:04 -0700 (PDT)
Received: from localhost.localdomain ([116.72.140.90])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2c432d8a039sm11197655ad.62.2026.06.12.00.55.01
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 12 Jun 2026 00:55:04 -0700 (PDT)
From: Piyush Paliwal <piyushthepal@gmail.com>
To: u-boot@lists.denx.de
Cc: joaomarcos.costa@bootlin.com,
	richard.genoud@bootlin.com,
	miquel.raynal@bootlin.com,
	thomas.petazzoni@bootlin.com,
	trini@konsulko.com,
	eric.kilmer@trailofbits.com,
	Piyush Paliwal <piyushthepal@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 1/2] fs/squashfs: bound the inode table walk in sqfs_find_inode()
Date: Fri, 12 Jun 2026 13:24:23 +0530
Message-ID: <20260612075424.83462-2-piyushthepal@gmail.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20260612075424.83462-1-piyushthepal@gmail.com>
References: <20260612075424.83462-1-piyushthepal@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sqfs_find_inode() walks the decompressed inode table advancing
"offset += sqfs_inode_size(base, ...)" with no check that offset stays
within the table (metablks_count * SQFS_METADATA_BLOCK_SIZE). All sizes
come from the on-disk image, including the unbounded extended-directory
(LDIR) index walk and the regular-file block-list term in
sqfs_inode_size(). A crafted image makes base run off the end of the
buffer -> out-of-bounds read / SEGV, reachable simply by listing the
image (ls/sqfsls) or any operation that resolves a path.

The earlier fix 3fb1df1e5 ("squashfs: Check sqfs_find_inode() return
value") only added NULL checks at the call sites; it did not add the
missing internal bound, so the wild read still occurs before the
function can return. c8e929e5 fixed only the symlink case of
sqfs_inode_size(), leaving the LDIR index walk unbounded.

Thread the inode table size from sqfs_read_inode_table() through the
squashfs_dir_stream to sqfs_find_inode(), and:
 - reject an inode whose base header does not fit in the table;
 - pass the remaining byte count to sqfs_inode_size() and validate every
   variable-length read (LDIR index list, REG/LREG block list, symlink,
   device/ipc inodes) against it, with overflow-checked arithmetic;
 - reject an inode whose computed size leaves the table.

Found by fuzzing the sandbox (CONFIG_ASAN) sqfsls/sqfsload with mutated
images. Before: SEGV in sqfs_find_inode (sqfs_inode.c) and in
sqfs_inode_size() LDIR walk. After: malformed images are rejected
cleanly; 2000 fuzz iterations produce no crash and the valid-image path
is unchanged.

Fixes: c51006130370 ("fs/squashfs: new filesystem")
Cc: stable@vger.kernel.org
Signed-off-by: Piyush Paliwal <piyushthepal@gmail.com>
---
 fs/squashfs/sqfs.c            |  26 +++++----
 fs/squashfs/sqfs_filesystem.h |   6 +-
 fs/squashfs/sqfs_inode.c      | 106 +++++++++++++++++++++++++++++-----
 3 files changed, 110 insertions(+), 28 deletions(-)

diff --git a/fs/squashfs/sqfs.c b/fs/squashfs/sqfs.c
index 0768fc4a7b2..3548b5e07e2 100644
--- a/fs/squashfs/sqfs.c
+++ b/fs/squashfs/sqfs.c
@@ -486,7 +486,8 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 	dirsp = (struct fs_dir_stream *)dirs;
 
 	/* Start by root inode */
-	table = sqfs_find_inode(dirs->inode_table, le32_to_cpu(sblk->inodes),
+	table = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
+				le32_to_cpu(sblk->inodes),
 				sblk->inodes, sblk->block_size);
 	if (!table)
 		return -EINVAL;
@@ -543,7 +544,8 @@ static int sqfs_search_dir(struct squashfs_dir_stream *dirs, char **token_list,
 			dirs->dir_header->inode_number;
 
 		/* Get reference to inode in the inode table */
-		table = sqfs_find_inode(dirs->inode_table, new_inode_number,
+		table = sqfs_find_inode(dirs->inode_table,
+					dirs->inode_table_size, new_inode_number,
 					sblk->inodes, sblk->block_size);
 		if (!table)
 			return -EINVAL;
@@ -719,7 +721,7 @@ static int sqfs_get_metablk_pos(u32 *pos_list, void *table, u32 offset,
 	return ret;
 }
 
-static int sqfs_read_inode_table(unsigned char **inode_table)
+static int sqfs_read_inode_table(unsigned char **inode_table, size_t *out_size)
 {
 	struct squashfs_super_block *sblk = ctxt.sblk;
 	u64 start, n_blks, table_offset, table_size;
@@ -773,6 +775,8 @@ static int sqfs_read_inode_table(unsigned char **inode_table)
 		goto free_itb;
 	}
 
+	*out_size = (size_t)metablks_count * SQFS_METADATA_BLOCK_SIZE;
+
 	src_table = itb + table_offset + SQFS_HEADER_SIZE;
 
 	/* Extract compressed Inode table */
@@ -920,6 +924,7 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
 	int j, token_count = 0, ret = 0, metablks_count;
 	struct squashfs_dir_stream *dirs;
 	char **token_list = NULL, *path = NULL;
+	size_t inode_table_size = 0;
 	u32 *pos_list = NULL;
 
 	dirs = calloc(1, sizeof(*dirs));
@@ -933,7 +938,7 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
 	dirs->inode_table = NULL;
 	dirs->dir_table = NULL;
 
-	ret = sqfs_read_inode_table(&inode_table);
+	ret = sqfs_read_inode_table(&inode_table, &inode_table_size);
 	if (ret) {
 		ret = -EINVAL;
 		goto out;
@@ -973,6 +978,7 @@ static int sqfs_opendir_nest(const char *filename, struct fs_dir_stream **dirsp)
 	 * a general solution for the malloc size, since 'i' is a union.
 	 */
 	dirs->inode_table = inode_table;
+	dirs->inode_table_size = inode_table_size;
 	dirs->dir_table = dir_table;
 	ret = sqfs_search_dir(dirs, token_list, token_count, pos_list,
 			      metablks_count);
@@ -1071,8 +1077,8 @@ static int sqfs_readdir_nest(struct fs_dir_stream *fs_dirs, struct fs_dirent **d
 	}
 
 	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
-	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
-			       sblk->block_size);
+	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
+			       i_number, sblk->inodes, sblk->block_size);
 	if (!ipos)
 		return -SQFS_STOP_READDIR;
 
@@ -1430,8 +1436,8 @@ static int sqfs_read_nest(const char *filename, void *buf, loff_t offset,
 	}
 
 	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
-	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
-			       sblk->block_size);
+	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
+			       i_number, sblk->inodes, sblk->block_size);
 	if (!ipos) {
 		ret = -EINVAL;
 		goto out;
@@ -1699,8 +1705,8 @@ static int sqfs_size_nest(const char *filename, loff_t *size)
 	}
 
 	i_number = dirs->dir_header->inode_number + dirs->entry->inode_offset;
-	ipos = sqfs_find_inode(dirs->inode_table, i_number, sblk->inodes,
-			       sblk->block_size);
+	ipos = sqfs_find_inode(dirs->inode_table, dirs->inode_table_size,
+			       i_number, sblk->inodes, sblk->block_size);
 
 	if (!ipos) {
 		*size = 0;
diff --git a/fs/squashfs/sqfs_filesystem.h b/fs/squashfs/sqfs_filesystem.h
index be56498a5e3..6c97b2c3a9c 100644
--- a/fs/squashfs/sqfs_filesystem.h
+++ b/fs/squashfs/sqfs_filesystem.h
@@ -275,6 +275,8 @@ struct squashfs_dir_stream {
 	 * sqfs_opendir() and freed in sqfs_closedir().
 	 */
 	unsigned char *inode_table;
+	/* Size in bytes of the decompressed inode_table buffer */
+	size_t inode_table_size;
 	unsigned char *dir_table;
 };
 
@@ -293,8 +295,8 @@ struct squashfs_file_info {
 	bool comp;
 };
 
-void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
-		      __le32 block_size);
+void *sqfs_find_inode(void *inode_table, size_t table_size, int inode_number,
+		      __le32 inode_count, __le32 block_size);
 
 int sqfs_dir_offset(void *dir_i, u32 *m_list, int m_count);
 
diff --git a/fs/squashfs/sqfs_inode.c b/fs/squashfs/sqfs_inode.c
index ce9a8ff8e2a..20085f8912b 100644
--- a/fs/squashfs/sqfs_inode.c
+++ b/fs/squashfs/sqfs_inode.c
@@ -17,65 +17,122 @@
 #include "sqfs_filesystem.h"
 #include "sqfs_utils.h"
 
-int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
+int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size, size_t max)
 {
-	u16 inode_type = get_unaligned_le16(&inode->inode_type);
+	u16 inode_type;
+
+	/* The smallest possible inode must fit in the remaining bytes */
+	if (max < sizeof(struct squashfs_base_inode))
+		return -EINVAL;
+
+	inode_type = get_unaligned_le16(&inode->inode_type);
 
 	switch (inode_type) {
 	case SQFS_DIR_TYPE:
+		if (max < sizeof(struct squashfs_dir_inode))
+			return -EINVAL;
 		return sizeof(struct squashfs_dir_inode);
 
 	case SQFS_REG_TYPE: {
 		struct squashfs_reg_inode *reg =
 			(struct squashfs_reg_inode *)inode;
-		u32 fragment = get_unaligned_le32(&reg->fragment);
-		u32 file_size = get_unaligned_le32(&reg->file_size);
+		u32 fragment, file_size;
 		unsigned int blk_list_size;
+		int size;
+
+		if (max < sizeof(*reg))
+			return -EINVAL;
+
+		fragment = get_unaligned_le32(&reg->fragment);
+		file_size = get_unaligned_le32(&reg->file_size);
+
+		if (!blk_size)
+			return -EINVAL;
 
 		if (SQFS_IS_FRAGMENTED(fragment))
 			blk_list_size = file_size / blk_size;
 		else
 			blk_list_size = DIV_ROUND_UP(file_size, blk_size);
 
-		return sizeof(*reg) + blk_list_size * sizeof(u32);
+		if (__builtin_mul_overflow(blk_list_size, (unsigned int)sizeof(u32),
+					   &blk_list_size) ||
+		    __builtin_add_overflow((int)sizeof(*reg), (int)blk_list_size,
+					   &size))
+			return -EINVAL;
+
+		return size;
 	}
 
 	case SQFS_LDIR_TYPE: {
 		struct squashfs_ldir_inode *ldir =
 			(struct squashfs_ldir_inode *)inode;
-		u16 i_count = get_unaligned_le16(&ldir->i_count);
+		u16 i_count;
 		unsigned int index_list_size = 0, l = 0;
 		struct squashfs_directory_index *di;
+		size_t consumed;
 		u32 sz;
+		int size;
 
+		if (max < sizeof(*ldir))
+			return -EINVAL;
+
+		i_count = get_unaligned_le16(&ldir->i_count);
 		if (i_count == 0)
 			return sizeof(*ldir);
 
 		di = ldir->index;
+		consumed = sizeof(*ldir);
 		while (l < i_count) {
+			/* The directory index header must stay in bounds */
+			if (consumed + sizeof(*di) > max)
+				return -EINVAL;
 			sz = get_unaligned_le32(&di->size) + 1;
+			if (__builtin_add_overflow(consumed, sizeof(*di) + sz,
+						   &consumed) ||
+			    consumed > max)
+				return -EINVAL;
 			index_list_size += sz;
 			di = (void *)di + sizeof(*di) + sz;
 			l++;
 		}
 
-		return sizeof(*ldir) + index_list_size +
-			i_count * SQFS_DIR_INDEX_BASE_LENGTH;
+		if (__builtin_add_overflow((int)(sizeof(*ldir) + index_list_size),
+					   (int)(i_count * SQFS_DIR_INDEX_BASE_LENGTH),
+					   &size))
+			return -EINVAL;
+
+		return size;
 	}
 
 	case SQFS_LREG_TYPE: {
 		struct squashfs_lreg_inode *lreg =
 			(struct squashfs_lreg_inode *)inode;
-		u32 fragment = get_unaligned_le32(&lreg->fragment);
-		u64 file_size = get_unaligned_le64(&lreg->file_size);
+		u32 fragment;
+		u64 file_size;
 		unsigned int blk_list_size;
+		int size;
+
+		if (max < sizeof(*lreg))
+			return -EINVAL;
+
+		fragment = get_unaligned_le32(&lreg->fragment);
+		file_size = get_unaligned_le64(&lreg->file_size);
+
+		if (!blk_size)
+			return -EINVAL;
 
 		if (fragment == 0xFFFFFFFF)
 			blk_list_size = DIV_ROUND_UP(file_size, blk_size);
 		else
 			blk_list_size = file_size / blk_size;
 
-		return sizeof(*lreg) + blk_list_size * sizeof(u32);
+		if (__builtin_mul_overflow(blk_list_size, (unsigned int)sizeof(u32),
+					   &blk_list_size) ||
+		    __builtin_add_overflow((int)sizeof(*lreg), (int)blk_list_size,
+					   &size))
+			return -EINVAL;
+
+		return size;
 	}
 
 	case SQFS_SYMLINK_TYPE:
@@ -85,6 +142,9 @@ int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
 		struct squashfs_symlink_inode *symlink =
 			(struct squashfs_symlink_inode *)inode;
 
+		if (max < sizeof(*symlink))
+			return -EINVAL;
+
 		if (__builtin_add_overflow(sizeof(*symlink),
 		    get_unaligned_le32(&symlink->symlink_size), &size))
 			return -EINVAL;
@@ -94,15 +154,23 @@ int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
 
 	case SQFS_BLKDEV_TYPE:
 	case SQFS_CHRDEV_TYPE:
+		if (max < sizeof(struct squashfs_dev_inode))
+			return -EINVAL;
 		return sizeof(struct squashfs_dev_inode);
 	case SQFS_LBLKDEV_TYPE:
 	case SQFS_LCHRDEV_TYPE:
+		if (max < sizeof(struct squashfs_ldev_inode))
+			return -EINVAL;
 		return sizeof(struct squashfs_ldev_inode);
 	case SQFS_FIFO_TYPE:
 	case SQFS_SOCKET_TYPE:
+		if (max < sizeof(struct squashfs_ipc_inode))
+			return -EINVAL;
 		return sizeof(struct squashfs_ipc_inode);
 	case SQFS_LFIFO_TYPE:
 	case SQFS_LSOCKET_TYPE:
+		if (max < sizeof(struct squashfs_lipc_inode))
+			return -EINVAL;
 		return sizeof(struct squashfs_lipc_inode);
 	default:
 		printf("Error while searching inode: unknown type.\n");
@@ -114,11 +182,12 @@ int sqfs_inode_size(struct squashfs_base_inode *inode, u32 blk_size)
  * Given the uncompressed inode table, the inode to be found and the number of
  * inodes in the table, return inode position in case of success.
  */
-void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
-		      __le32 block_size)
+void *sqfs_find_inode(void *inode_table, size_t table_size, int inode_number,
+		      __le32 inode_count, __le32 block_size)
 {
 	struct squashfs_base_inode *base;
-	unsigned int offset = 0, k;
+	size_t offset = 0;
+	unsigned int k;
 	int sz;
 
 	if (!inode_table) {
@@ -127,12 +196,17 @@ void *sqfs_find_inode(void *inode_table, int inode_number, __le32 inode_count,
 	}
 
 	for (k = 0; k < le32_to_cpu(inode_count); k++) {
+		/* The base inode header must lie within the inode table */
+		if (offset + sizeof(struct squashfs_base_inode) > table_size)
+			return NULL;
+
 		base = inode_table + offset;
 		if (get_unaligned_le32(&base->inode_number) == inode_number)
 			return inode_table + offset;
 
-		sz = sqfs_inode_size(base, le32_to_cpu(block_size));
-		if (sz < 0)
+		sz = sqfs_inode_size(base, le32_to_cpu(block_size),
+				     table_size - offset);
+		if (sz <= 0 || (size_t)sz > table_size - offset)
 			return NULL;
 
 		offset += sz;
-- 
2.41.0

