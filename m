Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411675;
	b=hxp25Ro/PmHMoP/GKkx7CPAJVHw5SjZPI1WQlqO93i5A3hi1VYjM5AbGuQv71C8LhrXO
	 YlETwcw4d75/yvoSHpAepXITwDFROs2ZBAeHS5/PLdPDvfz/16+vRy3LMJPaGxeeIa3Ui
	 dkT+oflLBUh+RAJxD9UthQF7fm5KLwRq212nul6ALcHdScjuMn8sBKPi2sMtM3C0HrEP0
	 OxQwMTj4KICibhhLJzky3eJmdwvv7wV7to1R9oFqiPo/G5McS8/TesimO8TLBxIgyA7Bz
	 wGx9X9vauKkF61jLLw0Vo59RTlinLiv6JNBue1sTzhPgqt+3htmrjsB5QJAU9O/zP+g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411675;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/VSJkDkO366Oxfep5VPoTHJBNZnWhVzT2KAUcTMVMZI=;
	b=3dXLIjYvCwR2ferVtf2INzzBxCLlz3nmHN02cMtqlDt3POuDfIDLG8oH/M2kQUsbY/Hf
	 k5lNbJAxAFQ87KK+QBf/vqkede6n8AT9ImNyVhIpoHB5HkJI7I0clx7K36+DawblVSQ8w
	 yKZrNLLNFH1XWVqeDuG05Ch7ALBAysOxk0rYtaP6cyHD210NfLKQhW52yTqiabpMlrhCp
	 klW2Pa92KvRM8kunu6AAOeK0TaJAoi9H/zrKekM95qm/vdy8Y4TppYi4byEKyhTlh3ABS
	 OtOM3g4F2mmUTdmScaq8osYGYFVUSBl87LJ766cUauO8VhvWF4Z3A1bFivDOpXrUJ5g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jezJE02N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A0D9E606A32E
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:41:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jezJE02N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AC3C1F00A05;
	Wed, 11 Nov 2026 15:41:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411675;
	bh=/VSJkDkO366Oxfep5VPoTHJBNZnWhVzT2KAUcTMVMZI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jezJE02N7tuPOJdGqhopNdbkcxqcoaeh9CvXbPjUo/ig8UY+J35Nkyx5iuNaAZD1z
	 /yAvLSdwWC2sgqVjawHKEdSPADdf1XG8UyfseDlN9YNf0QcJTVida91nO0aRtlPzit
	 kfWZ0BbO/uRK1vhwApW+Umm3Te9sxrzjLvQJ+vRlS1JeaC8cSlj7J3b3mU3/LCEEAP
	 9bUsmhiZAAGR7SJy6Lee+MfTz+yZ6rNkKmK0b4oTQ50lCMAhvPyqURt3olZ1+qvPYb
	 fNfpYzW7kOXlNpjHKr9Fx4dijj/SE89aIwPrT40pnCD2tA5dn4wTFVnJzYnfsFr/Zy
	 tgI0MWq3EaraQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <yuchao0@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] f2fs: rename logical_to_blk and blk_to_logical
Date: Wed, 11 Nov 2026 10:41:10 -0500
Message-ID: <20261111154005.2482659-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062516-failed-5.10-6d1f622b9c06@kernel.org>
References: <20261107062516-failed-5.10-6d1f622b9c06@kernel.org>
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

From: Jaegeuk Kim <jaegeuk@kernel.org>

[ Upstream commit 6cbfcab5ff51491e67c75fd8d672cff97127fd55 ]

This patch renames two functions like below having u64.
 - logical_to_blk to bytes_to_blks
 - blk_to_logical to blks_to_bytes

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 6d1f622b9c06 ("f2fs: fix submit accounting for IPU writeback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 40 ++++++++++++++++++++--------------------
 1 file changed, 20 insertions(+), 20 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 2933b32032e79..e681ff67d63ef 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1860,14 +1860,14 @@ static int get_data_block_bmap(struct inode *inode, sector_t iblock,
 						NO_CHECK_TYPE, create);
 }
 
-static inline sector_t logical_to_blk(struct inode *inode, loff_t offset)
+static inline u64 bytes_to_blks(struct inode *inode, u64 bytes)
 {
-	return (offset >> inode->i_blkbits);
+	return (bytes >> inode->i_blkbits);
 }
 
-static inline loff_t blk_to_logical(struct inode *inode, sector_t blk)
+static inline u64 blks_to_bytes(struct inode *inode, u64 blks)
 {
-	return (blk << inode->i_blkbits);
+	return (blks << inode->i_blkbits);
 }
 
 static int f2fs_xattr_fiemap(struct inode *inode,
@@ -1895,7 +1895,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 			return err;
 		}
 
-		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
+		phys = blks_to_bytes(inode, ni.blk_addr);
 		offset = offsetof(struct f2fs_inode, i_addr) +
 					sizeof(__le32) * (DEF_ADDRS_PER_INODE -
 					get_inline_xattr_addrs(inode));
@@ -1927,7 +1927,7 @@ static int f2fs_xattr_fiemap(struct inode *inode,
 			return err;
 		}
 
-		phys = (__u64)blk_to_logical(inode, ni.blk_addr);
+		phys = blks_to_bytes(inode, ni.blk_addr);
 		len = inode->i_sb->s_blocksize;
 
 		f2fs_put_page(page, 1);
@@ -1997,18 +1997,18 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 			goto out;
 	}
 
-	if (logical_to_blk(inode, len) == 0)
-		len = blk_to_logical(inode, 1);
+	if (bytes_to_blks(inode, len) == 0)
+		len = blks_to_bytes(inode, 1);
 
-	start_blk = logical_to_blk(inode, start);
-	last_blk = logical_to_blk(inode, start + len - 1);
+	start_blk = bytes_to_blks(inode, start);
+	last_blk = bytes_to_blks(inode, start + len - 1);
 
 next:
 	memset(&map_bh, 0, sizeof(struct buffer_head));
 	map_bh.b_size = len;
 
 	if (compr_cluster)
-		map_bh.b_size = blk_to_logical(inode, cluster_size - 1);
+		map_bh.b_size = blks_to_bytes(inode, cluster_size - 1);
 
 	ret = get_data_block(inode, start_blk, &map_bh, 0,
 					F2FS_GET_BLOCK_FIEMAP, &next_pgofs);
@@ -2019,7 +2019,7 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 	if (!buffer_mapped(&map_bh)) {
 		start_blk = next_pgofs;
 
-		if (blk_to_logical(inode, start_blk) < blk_to_logical(inode,
+		if (blks_to_bytes(inode, start_blk) < blks_to_bytes(inode,
 						max_inode_blocks(inode)))
 			goto prep_next;
 
@@ -2045,9 +2045,9 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		compr_cluster = false;
 
 
-		logical = blk_to_logical(inode, start_blk - 1);
-		phys = blk_to_logical(inode, map_bh.b_blocknr);
-		size = blk_to_logical(inode, cluster_size);
+		logical = blks_to_bytes(inode, start_blk - 1);
+		phys = blks_to_bytes(inode, map_bh.b_blocknr);
+		size = blks_to_bytes(inode, cluster_size);
 
 		flags |= FIEMAP_EXTENT_ENCODED;
 
@@ -2065,14 +2065,14 @@ int f2fs_fiemap(struct inode *inode, struct fiemap_extent_info *fieinfo,
 		goto prep_next;
 	}
 
-	logical = blk_to_logical(inode, start_blk);
-	phys = blk_to_logical(inode, map_bh.b_blocknr);
+	logical = blks_to_bytes(inode, start_blk);
+	phys = blks_to_bytes(inode, map_bh.b_blocknr);
 	size = map_bh.b_size;
 	flags = 0;
 	if (buffer_unwritten(&map_bh))
 		flags = FIEMAP_EXTENT_UNWRITTEN;
 
-	start_blk += logical_to_blk(inode, size);
+	start_blk += bytes_to_blks(inode, size);
 
 prep_next:
 	cond_resched();
@@ -4003,7 +4003,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 	 * to be very smart.
 	 */
 	cur_lblock = 0;
-	last_lblock = logical_to_blk(inode, i_size_read(inode));
+	last_lblock = bytes_to_blks(inode, i_size_read(inode));
 	len = i_size_read(inode);
 
 	while (cur_lblock <= last_lblock && cur_lblock < sis->max) {
@@ -4025,7 +4025,7 @@ static int check_swap_activate_fast(struct swap_info_struct *sis,
 			goto err_out;
 
 		pblock = map_bh.b_blocknr;
-		nr_pblocks = logical_to_blk(inode, map_bh.b_size);
+		nr_pblocks = bytes_to_blks(inode, map_bh.b_size);
 
 		if (cur_lblock + nr_pblocks >= sis->max)
 			nr_pblocks = sis->max - cur_lblock;
-- 
2.53.0

