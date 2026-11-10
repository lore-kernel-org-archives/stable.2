Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331098;
	b=J3PIzxJSBDiILcDrf7YvTv6Ds+MR4WkpsNHsCcB1DHLD5dNCsqrcSn6vnuHHJOnEZFur
	 xKMG+MJDTDnakQ08BqfTlJl7oY+tjaTkqPIchaRQ4QysWz8bHnQizxO05FM/e+HzUOGUx
	 8HOFrVClo2jSH8TA1DG4nbWtscw5Pd/PsGeaPMqj69klUx01e2TVxdihlOg1Oonf2/VMo
	 Izkev2B6/sxYTla57NRLzJs8gGcm6lbYo4zad0wyZGAEnYoBemfjIEHMU2/EK6D4Fu86v
	 wpOmSzAyC281c1Kzigl6LzMMSN/MTzUmFVAprNnP7d8rSOng4eh4rz45GdiKQ4yBcYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331098;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=x5BKTfs1juxzg2ZhemytwYa3xX7q5sJvIxyiJDcoGcg=;
	b=YGwsq++elJr/flTzS7L6rwt7Vdi9p7fGGn5t87MMW2lTiEwO6qlUK4AiOAp6MAo5mfo9
	 GJSTwkN+2aXf2H3NQjwVlX7VXzE57qSmqJIZXCLlYdhjFDc5YLy7endXrEY+zuBPnuQYr
	 3KWp2NcPa/MowekSm0TYqhpF6Lv56HpdpI+9he/ZRE/WEmxlnthCKvZqYKuawR1lq58Iy
	 uPpniHGh+rYfS+D+zQoLoc+IYIO1e+3/bppG2tNu4sBuF0OGv6eCSbMhYIw+ntly9fcLV
	 8/+wSqw/pJkSnIL9HLIYpdkpSP/UQgtRj7dc4VKdO/j4KyMKY8MGprEbgL/OaAcbVkQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Kve7q/sW";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CEA34606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Kve7q/sW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05B5A1F008A4;
	Tue, 10 Nov 2026 17:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331097;
	bh=x5BKTfs1juxzg2ZhemytwYa3xX7q5sJvIxyiJDcoGcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kve7q/sWpWOUcPUHFgxeFhL7ROrfhgoh5+RepgwzVLzvWw/gFC6l6qo1JKsOJqvjn
	 +jKZL2rdHnd9A3Eldcn8H4rodHBDFNyr0cwAIbPSzKmHRDyuqiYNiXs7BCwY9Y7IUV
	 TbiutMjB3cLjA/IH8Fp2vn4nHeQaqDdvDsxtu1LszB1uTH31QhIzDyQP3mUylcAoiW
	 VmF1+fdSgCXx4BNd9QvBqEN8OwkRHHRlVQFAtkR0u6z4uKsPH536cQu68aL7NkP0L1
	 Ro7nSSN54PZxyHXtTQ6aCT4BAoLgehgz8bOElA29VRASjR8GDiNy7JYuIb0EUDiIOD
	 yrnsjpFqq2Lgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] f2fs: convert f2fs_read_single_page() to use folio
Date: Tue, 10 Nov 2026 12:18:13 -0500
Message-ID: <20261110171210.2630515-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110171210.2630515-1-sashal@kernel.org>
References: <20261107053437-failed-6.6-b3c984358925@kernel.org>
 <20261110171210.2630515-1-sashal@kernel.org>
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

[ Upstream commit ed54eed355675f79d9322c07d92f38037fc6b514 ]

Convert f2fs_read_single_page() to use folio and related
functionality.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: b3c984358925 ("f2fs: remove mappedtodisk flag usage in mmap write path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 27 ++++++++++++++-------------
 1 file changed, 14 insertions(+), 13 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 3cb822e799be8..e1c66f64aff38 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2089,7 +2089,7 @@ static inline loff_t f2fs_readpage_limit(struct inode *inode)
 	return i_size_read(inode);
 }
 
-static int f2fs_read_single_page(struct inode *inode, struct page *page,
+static int f2fs_read_single_page(struct inode *inode, struct folio *folio,
 					unsigned nr_pages,
 					struct f2fs_map_blocks *map,
 					struct bio **bio_ret,
@@ -2102,9 +2102,10 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	sector_t last_block;
 	sector_t last_block_in_file;
 	sector_t block_nr;
+	pgoff_t index = folio_index(folio);
 	int ret = 0;
 
-	block_in_file = (sector_t)page_index(page);
+	block_in_file = (sector_t)index;
 	last_block = block_in_file + nr_pages;
 	last_block_in_file = bytes_to_blks(inode,
 			f2fs_readpage_limit(inode) + blocksize - 1);
@@ -2135,7 +2136,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 got_it:
 	if ((map->m_flags & F2FS_MAP_MAPPED)) {
 		block_nr = map->m_pblk + block_in_file - map->m_lblk;
-		SetPageMappedToDisk(page);
+		folio_set_mappedtodisk(folio);
 
 		if (!f2fs_is_valid_blkaddr(F2FS_I_SB(inode), block_nr,
 						DATA_GENERIC_ENHANCE_READ)) {
@@ -2146,15 +2147,15 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 		}
 	} else {
 zero_out:
-		zero_user_segment(page, 0, PAGE_SIZE);
-		if (f2fs_need_verity(inode, page->index) &&
-		    !fsverity_verify_page(page)) {
+		folio_zero_segment(folio, 0, folio_size(folio));
+		if (f2fs_need_verity(inode, index) &&
+		    !fsverity_verify_folio(folio)) {
 			ret = -EIO;
 			goto out;
 		}
-		if (!PageUptodate(page))
-			SetPageUptodate(page);
-		unlock_page(page);
+		if (!folio_test_uptodate(folio))
+			folio_mark_uptodate(folio);
+		folio_unlock(folio);
 		goto out;
 	}
 
@@ -2164,14 +2165,14 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	 */
 	if (bio && (!page_is_mergeable(F2FS_I_SB(inode), bio,
 				       *last_block_in_bio, block_nr) ||
-		    !f2fs_crypt_mergeable_bio(bio, inode, page->index, NULL))) {
+		    !f2fs_crypt_mergeable_bio(bio, inode, index, NULL))) {
 submit_and_realloc:
 		f2fs_submit_read_bio(F2FS_I_SB(inode), bio, DATA);
 		bio = NULL;
 	}
 	if (bio == NULL) {
 		bio = f2fs_grab_read_bio(inode, block_nr, nr_pages,
-				is_readahead ? REQ_RAHEAD : 0, page->index,
+				is_readahead ? REQ_RAHEAD : 0, index,
 				false);
 		if (IS_ERR(bio)) {
 			ret = PTR_ERR(bio);
@@ -2186,7 +2187,7 @@ static int f2fs_read_single_page(struct inode *inode, struct page *page,
 	 */
 	f2fs_wait_on_block_writeback(inode, block_nr);
 
-	if (bio_add_page(bio, page, blocksize, 0) < blocksize)
+	if (!bio_add_folio(bio, folio, blocksize, 0))
 		goto submit_and_realloc;
 
 	inc_page_count(F2FS_I_SB(inode), F2FS_RD_DATA);
@@ -2454,7 +2455,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 read_single_page:
 #endif
 
-		ret = f2fs_read_single_page(inode, &folio->page, max_nr_pages, &map,
+		ret = f2fs_read_single_page(inode, folio, max_nr_pages, &map,
 					&bio, &last_block_in_bio, rac);
 		if (ret) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
-- 
2.53.0

