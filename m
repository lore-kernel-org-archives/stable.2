Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C24A018FDDE
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176745; cv=none; b=DYywqvPUUOb0Zu7L3CMJ5zjjEcHt+mUJJLz/rxXRLmlX4fjEmKEjOhfCk5j2MTddj76fCdMaKSIbUb6lzIaKKh2z39sY/7+dH6nw2t1gOBc21gqTsCZ2Ji27RG9sW5E3qYU2+2Uob0BemA/Oc0ZcWSMZ9rzw65DSkUiw5g1Pk8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176745; c=relaxed/simple;
	bh=A07KNAgBS7SrMhGbnlnriC/5BiIlPDZkdYvKgoMkK3A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HEZbkBlRl8mbsdSnBsc67IsFfYCDxyWo/JEKnEEnRrM4g3L/vsNBK5jmymcVVTnXAnrMbxkJRjOICF8SHSnPT5y6ucaVryB6ZZSu8K6+wEbbzG9tLMm4qcI6cWubcUGeZfeby9DFUpv52ybWN4eT6h+8m+6Ea8vWO+xUIlhSVXA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J4NpWw2m; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J4NpWw2m"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B90641F000FF;
	Sat, 12 Sep 2026 01:32:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176744;
	bh=4RZx/dEGfA2IOtiN2B/otJTxBkMC+AhNEXUJottkV4I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J4NpWw2mt92Ktck3Cvdelgy+2OmNm3kQBo9CjyQji2BKTPyccST1Y1Xt5n7YKYAJ7
	 gg+ch+TBxn/31mY3bwT9AB4AvAQ1J0aUipqU3DEpUGzgLy+QfeFLt03c9WsLvM/gy4
	 R7w/4/8fccs5ZQcW14qMg3gMKPCU6ZRZY1YpcXwJWVZNOqicrpgMkmrbO7PM+X3pHm
	 X75c0m0dbbcpr605werWRIN0ZPSN1ICENmK5Y5BOdqNJNKHvDxEn3iSsY41RaU1b78
	 7mcVc3dW7TgW+MLOjaEOyLTpb2qtc5EWCaWXzSb7SjXLLq+JgMx1sXRbUT4t63Vd56
	 WrpEoMybbCC6w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/7] f2fs: Use a folio in move_data_block()
Date: Fri, 11 Sep 2026 21:32:16 -0400
Message-ID: <20260912013222.1762882-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090957-stoke-condense-f9b1@gregkh>
References: <2026090957-stoke-condense-f9b1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit c14b4562bc9bd7cb57dbb95eae73fc3f24cdfadc ]

Fetch a folio from the pagecache instead of a page and operate on it
throughout.  Removes eight calls to compound_head() and an access to
page->mapping.

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: ce366bfa821e ("f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index b8a9412ca1dc8..fbd246b3e550a 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1336,7 +1336,8 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	struct dnode_of_data dn;
 	struct f2fs_summary sum;
 	struct node_info ni;
-	struct page *page, *mpage;
+	struct page *page;
+	struct folio *mfolio;
 	block_t newaddr;
 	int err = 0;
 	bool lfs_mode = f2fs_lfs_mode(fio.sbi);
@@ -1401,20 +1402,20 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	if (lfs_mode)
 		f2fs_down_write(&fio.sbi->io_order_lock);
 
-	mpage = f2fs_grab_cache_page(META_MAPPING(fio.sbi),
+	mfolio = f2fs_grab_cache_folio(META_MAPPING(fio.sbi),
 					fio.old_blkaddr, false);
-	if (!mpage) {
-		err = -ENOMEM;
+	if (IS_ERR(mfolio)) {
+		err = PTR_ERR(mfolio);
 		goto up_out;
 	}
 
-	fio.encrypted_page = mpage;
+	fio.encrypted_page = folio_file_page(mfolio, fio.old_blkaddr);
 
-	/* read source block in mpage */
-	if (!PageUptodate(mpage)) {
+	/* read source block in mfolio */
+	if (!folio_test_uptodate(mfolio)) {
 		err = f2fs_submit_page_bio(&fio);
 		if (err) {
-			f2fs_put_page(mpage, 1);
+			f2fs_folio_put(mfolio, true);
 			goto up_out;
 		}
 
@@ -1423,11 +1424,11 @@ static int move_data_block(struct inode *inode, block_t bidx,
 		f2fs_update_iostat(fio.sbi, NULL, FS_GDATA_READ_IO,
 							F2FS_BLKSIZE);
 
-		lock_page(mpage);
-		if (unlikely(mpage->mapping != META_MAPPING(fio.sbi) ||
-						!PageUptodate(mpage))) {
+		folio_lock(mfolio);
+		if (unlikely(mfolio->mapping != META_MAPPING(fio.sbi) ||
+			     !folio_test_uptodate(mfolio))) {
 			err = -EIO;
-			f2fs_put_page(mpage, 1);
+			f2fs_folio_put(mfolio, true);
 			goto up_out;
 		}
 	}
@@ -1438,7 +1439,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	err = f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
 				&sum, type, NULL);
 	if (err) {
-		f2fs_put_page(mpage, 1);
+		f2fs_folio_put(mfolio, true);
 		/* filesystem should shutdown, no need to recovery block */
 		goto up_out;
 	}
@@ -1447,15 +1448,15 @@ static int move_data_block(struct inode *inode, block_t bidx,
 				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
 	if (!fio.encrypted_page) {
 		err = -ENOMEM;
-		f2fs_put_page(mpage, 1);
+		f2fs_folio_put(mfolio, true);
 		goto recover_block;
 	}
 
 	/* write target block */
 	f2fs_wait_on_page_writeback(fio.encrypted_page, DATA, true, true);
 	memcpy(page_address(fio.encrypted_page),
-				page_address(mpage), PAGE_SIZE);
-	f2fs_put_page(mpage, 1);
+				folio_address(mfolio), PAGE_SIZE);
+	f2fs_folio_put(mfolio, true);
 
 	f2fs_invalidate_internal_cache(fio.sbi, fio.old_blkaddr);
 
-- 
2.53.0

