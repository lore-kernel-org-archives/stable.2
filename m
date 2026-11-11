Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794411676;
	b=vVCg0rdyEGmoaJI2AF8Hm81x+peFwJaackVeh5B/TBnCZUwyFSQ21PIogrBUieyTYbS+
	 z1cQNgPEbrk+ok0idhHdDsGJyhD+qxdk1376KErOn0G56eNjbX/vCMBPVmaF+4wE8AxlJ
	 KNLsT3UKhDj+VuqwytLD/dJhKpRU1ChJz8Wxo0sLQDkGHkdAUEAzHizXLyLvUrSCfg47l
	 M/zb6aL2FKEto8TS9iCKBjJ7FFSTmhYdHcKTS4WSHPIcXSgRU2kL4mi0EY+T0Hnq7gL6b
	 7gQkB3izQPDrJd5+QyjjJJvOm1xz+p1o+bXbtwJ8fj0YbBy7AP5LTM3YG5QzGW4u+/Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794411676;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=r1IIVwixJGnc0mvZUjplokKbyPRGgwVFs835hpB2eB4=;
	b=K4+1oaGnfWVlEnQkdvuTNvANBaRIcVVIOf6z9iyD668c7eh2rt4mdfCt9XU44tUSfh9S
	 Isa0sKywNdHOEob8UJS7elX8jr09IFT37tM5NHDXbXbS72ttNXpQ/LxrRPiMOgb9ttgiS
	 mrktMT3h+/HSsyPFF7dLFlxapjY8ttmBFAEPGZyHP0dGUkHtw5GWKSKP2u/5oWbhpoZ3Y
	 NDElSfqN/f0ySzawU/KY1CYw9EUwtqqQMrFycpTCorSagubOa9BFh4FtgDKaUKuT7BQC5
	 PhALkkOrTkyH3lYJkoYS2/bJE+fAppL8P5PA7DFCPSYJXuewjS5XV8W+BgBl8ZjvHEg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQNcyP3a;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DE33606A886
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 15:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQNcyP3a
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BDB7A1F00A06;
	Wed, 11 Nov 2026 15:41:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794411676;
	bh=r1IIVwixJGnc0mvZUjplokKbyPRGgwVFs835hpB2eB4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FQNcyP3aq1wvY2EZ15iyoikEzjG5aC8gMe2NwF0rxdFl02Y+v18v+aUB5QBDLmaAu
	 5Npm0EQHUdUydQkUSUhE5bBpyxOXgtQVjjPb0UVQ9EIrakQ5+lnyG+04/2WwGvCnhN
	 l2iwggMymYAT/npvwjVlkyOkFVhrmg/+WICMDum6Lc4CunbQWwv77sTDsAuDP6lT+E
	 BxfO6EzzPmEOdEqBii1GolF21M9doqg6NY0arQGT+EQGwYDtf2+QdbYMA0HgVGa41E
	 niV4BOwIe7IFTEgDus5FBz9Lsb1riyzGeGC79IAuuWYWNOoV2aBWbeyViCQ/do21gY
	 tXaECO1G83rsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jaegeuk Kim <jaegeuk@kernel.org>,
	Chao Yu <yuchao0@huawei.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/4] f2fs: use new conversion functions between blks and bytes
Date: Wed, 11 Nov 2026 10:41:11 -0500
Message-ID: <20261111154005.2482659-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111154005.2482659-1-sashal@kernel.org>
References: <20261107062516-failed-5.10-6d1f622b9c06@kernel.org>
 <20261111154005.2482659-1-sashal@kernel.org>
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

[ Upstream commit 43b9d4b4d91c02ca1159507d46e3687d98b4cb8f ]

This patch cleans up blks and bytes conversions.

Reviewed-by: Chao Yu <yuchao0@huawei.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 6d1f622b9c06 ("f2fs: fix submit accounting for IPU writeback")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 46 +++++++++++++++++++++-------------------------
 1 file changed, 21 insertions(+), 25 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index e681ff67d63ef..e033c8dfb0348 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1802,6 +1802,16 @@ bool f2fs_overwrite_io(struct inode *inode, loff_t pos, size_t len)
 	return true;
 }
 
+static inline u64 bytes_to_blks(struct inode *inode, u64 bytes)
+{
+	return (bytes >> inode->i_blkbits);
+}
+
+static inline u64 blks_to_bytes(struct inode *inode, u64 blks)
+{
+	return (blks << inode->i_blkbits);
+}
+
 static int __get_data_block(struct inode *inode, sector_t iblock,
 			struct buffer_head *bh, int create, int flag,
 			pgoff_t *next_pgofs, int seg_type, bool may_write)
@@ -1810,7 +1820,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	int err;
 
 	map.m_lblk = iblock;
-	map.m_len = bh->b_size >> inode->i_blkbits;
+	map.m_len = bytes_to_blks(inode, bh->b_size);
 	map.m_next_pgofs = next_pgofs;
 	map.m_next_extent = NULL;
 	map.m_seg_type = seg_type;
@@ -1820,7 +1830,7 @@ static int __get_data_block(struct inode *inode, sector_t iblock,
 	if (!err) {
 		map_bh(bh, inode->i_sb, map.m_pblk);
 		bh->b_state = (bh->b_state & ~F2FS_MAP_FLAGS) | map.m_flags;
-		bh->b_size = (u64)map.m_len << inode->i_blkbits;
+		bh->b_size = blks_to_bytes(inode, map.m_len);
 	}
 	return err;
 }
@@ -1860,16 +1870,6 @@ static int get_data_block_bmap(struct inode *inode, sector_t iblock,
 						NO_CHECK_TYPE, create);
 }
 
-static inline u64 bytes_to_blks(struct inode *inode, u64 bytes)
-{
-	return (bytes >> inode->i_blkbits);
-}
-
-static inline u64 blks_to_bytes(struct inode *inode, u64 blks)
-{
-	return (blks << inode->i_blkbits);
-}
-
 static int f2fs_xattr_fiemap(struct inode *inode,
 				struct fiemap_extent_info *fieinfo)
 {
@@ -2105,8 +2105,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 					bool is_readahead)
 {
 	struct bio *bio = *bio_ret;
-	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocksize = 1 << blkbits;
+	const unsigned blocksize = blks_to_bytes(inode, 1);
 	sector_t block_in_file;
 	sector_t last_block;
 	sector_t last_block_in_file;
@@ -2115,8 +2114,8 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 
 	block_in_file = (sector_t)page_index(page);
 	last_block = block_in_file + nr_pages;
-	last_block_in_file = (f2fs_readpage_limit(inode) + blocksize - 1) >>
-							blkbits;
+	last_block_in_file = bytes_to_blks(inode,
+			f2fs_readpage_limit(inode) + blocksize - 1);
 	if (last_block > last_block_in_file)
 		last_block = last_block_in_file;
 
@@ -2229,8 +2228,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 	struct bio *bio = *bio_ret;
 	unsigned int start_idx = cc->cluster_idx << cc->log_cluster_size;
 	sector_t last_block_in_file;
-	const unsigned blkbits = inode->i_blkbits;
-	const unsigned blocksize = 1 << blkbits;
+	const unsigned blocksize = blks_to_bytes(inode, 1);
 	struct decompress_io_ctx *dic = NULL;
 	struct bio_post_read_ctx *ctx;
 	bool for_verity = false;
@@ -2239,8 +2237,8 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
 
 	f2fs_bug_on(sbi, f2fs_cluster_is_empty(cc));
 
-	last_block_in_file = (f2fs_readpage_limit(inode) +
-					blocksize - 1) >> blkbits;
+	last_block_in_file = bytes_to_blks(inode,
+			f2fs_readpage_limit(inode) + blocksize - 1);
 
 	/* get rid of pages beyond EOF */
 	for (i = 0; i < cc->cluster_size; i++) {
@@ -4068,7 +4066,6 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	struct inode *inode = mapping->host;
 	unsigned blocks_per_page;
 	unsigned long page_no;
-	unsigned blkbits;
 	sector_t probe_block;
 	sector_t last_block;
 	sector_t lowest_block = -1;
@@ -4079,8 +4076,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	if (PAGE_SIZE == F2FS_BLKSIZE)
 		return check_swap_activate_fast(sis, swap_file, span);
 
-	blkbits = inode->i_blkbits;
-	blocks_per_page = PAGE_SIZE >> blkbits;
+	blocks_per_page = bytes_to_blks(inode, PAGE_SIZE);
 
 	/*
 	 * Map all the blocks into the extent list.  This code doesn't try
@@ -4088,7 +4084,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 	 */
 	probe_block = 0;
 	page_no = 0;
-	last_block = i_size_read(inode) >> blkbits;
+	last_block = bytes_to_blks(inode, i_size_read(inode));
 	while ((probe_block + blocks_per_page) <= last_block &&
 			page_no < sis->max) {
 		unsigned block_in_page;
@@ -4128,7 +4124,7 @@ static int check_swap_activate(struct swap_info_struct *sis,
 			}
 		}
 
-		first_block >>= (PAGE_SHIFT - blkbits);
+		first_block >>= (PAGE_SHIFT - inode->i_blkbits);
 		if (page_no) {	/* exclude the header page */
 			if (first_block < lowest_block)
 				lowest_block = first_block;
-- 
2.53.0

