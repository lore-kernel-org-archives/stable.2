Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C6F430E85B
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176746; cv=none; b=CK4QBc6C3pimusxOIyWyKivaG8LtV++CTsPcS4tg10hAs6fy1RqxuD1Pf4fOnuiqzSMHYy3/4ZiFE24cBF9zxh7E2wfL5XCVRi8Sa0OIJmuPIeqBhLHVjd+BZ9y+Cb8g8le6BKo0HFlIG8l5ChzsPO5z/0pSGk4blMvmqaK3LRs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176746; c=relaxed/simple;
	bh=ktKtnZuwooi74N4tFVRktY86ik4QdbUS0jTdVNHSaXI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MFPg25i4mDOJ7CEpa7owwpgOzA39XQ9N6wOVQSjt0TkEw4prebDQXfb/WEnTPE2tBmx6lXC/USxdy7gQNC8nAW9lh48WLAEiZb7suj3FJBNwGdRYnuSo/jvL3zLqj5vHivqffUZHzjX3JW+h5FQcCeJaWcqQ/FNf2OnUQ8oEWXM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BNIWa98r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BNIWa98r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 914C51F00898;
	Sat, 12 Sep 2026 01:32:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176745;
	bh=nLB8KK3aBRg+MtWkf4kKhxHl4iNwV1GKTC4ABxv5DSY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BNIWa98rzvCSTZennmk94NQJljxnlvI7aEe5hdAW/zcFHYnTnwvPRmrRbdqfafUCi
	 T8fHoMZGhlx2PD0g4Dg9jlfH9CG2/ExsktSAagSQB/gHGving7d94Zup+bPb9mS/O5
	 k7t+4kGPGwNEllF3Gze9KVsO8u6fVNzLCoe7tXoBafuzFtB8rbYs5aseiKM1PUQiWG
	 QvLosWFNPFRPS39dOgHTImn/19h1At59n61IBwn7vGWeDuMJY8XRJMucJHrDWahM84
	 Ok/gpQDrAcrbZUGlCIaYteWXHd/5P8LQ6dwC5tZStJj79FA7+BTjkOAfMN6mlq9eQZ
	 QY99wn+Ql2iYg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/7] f2fs: Add f2fs_new_node_folio()
Date: Fri, 11 Sep 2026 21:32:17 -0400
Message-ID: <20260912013222.1762882-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912013222.1762882-1-sashal@kernel.org>
References: <2026090957-stoke-condense-f9b1@gregkh>
 <20260912013222.1762882-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit cfa809146f8223c2953e7553f830c0877921f9de ]

Convert f2fs_new_node_page() to f2fs_new_node_folio() and add
a compatibility wrapper.  Removes five hidden calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: ce366bfa821e ("f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/f2fs.h |  8 +++++++-
 fs/f2fs/node.c | 28 ++++++++++++++--------------
 2 files changed, 21 insertions(+), 15 deletions(-)

diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index e1cbd3917b9d9..713d8907859a8 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3740,7 +3740,7 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 					unsigned int seq_id);
 int f2fs_remove_inode_page(struct inode *inode);
 struct page *f2fs_new_inode_page(struct inode *inode);
-struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
+struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs);
 void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct page *f2fs_get_node_page_ra(struct page *parent, int start);
@@ -3768,6 +3768,12 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
 int __init f2fs_create_node_manager_caches(void);
 void f2fs_destroy_node_manager_caches(void);
 
+static inline
+struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
+{
+	return &f2fs_new_node_folio(dn, ofs)->page;
+}
+
 /*
  * segment.c
  */
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1f4f68e56d432..6989e5afea551 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1336,19 +1336,19 @@ struct page *f2fs_new_inode_page(struct inode *inode)
 	return f2fs_new_node_page(&dn, 0);
 }
 
-struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
+struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(dn->inode);
 	struct node_info new_ni;
-	struct page *page;
+	struct folio *folio;
 	int err;
 
 	if (unlikely(is_inode_flag_set(dn->inode, FI_NO_ALLOC)))
 		return ERR_PTR(-EPERM);
 
-	page = f2fs_grab_cache_page(NODE_MAPPING(sbi), dn->nid, false);
-	if (!page)
-		return ERR_PTR(-ENOMEM);
+	folio = f2fs_grab_cache_folio(NODE_MAPPING(sbi), dn->nid, false);
+	if (IS_ERR(folio))
+		return folio;
 
 	if (unlikely((err = inc_valid_node_count(sbi, dn->inode, !ofs))))
 		goto fail;
@@ -1379,12 +1379,12 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 	new_ni.version = 0;
 	set_node_addr(sbi, &new_ni, NEW_ADDR, false);
 
-	f2fs_wait_on_page_writeback(page, NODE, true, true);
-	fill_node_footer(page, dn->nid, dn->inode->i_ino, ofs, true);
-	set_cold_node(page, S_ISDIR(dn->inode->i_mode));
-	if (!PageUptodate(page))
-		SetPageUptodate(page);
-	if (set_page_dirty(page))
+	f2fs_folio_wait_writeback(folio, NODE, true, true);
+	fill_node_footer(&folio->page, dn->nid, dn->inode->i_ino, ofs, true);
+	set_cold_node(&folio->page, S_ISDIR(dn->inode->i_mode));
+	if (!folio_test_uptodate(folio))
+		folio_mark_uptodate(folio);
+	if (folio_mark_dirty(folio))
 		dn->node_changed = true;
 
 	if (f2fs_has_xattr_block(ofs))
@@ -1392,10 +1392,10 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 
 	if (ofs == 0)
 		inc_valid_inode_count(sbi);
-	return page;
+	return folio;
 fail:
-	clear_node_page_dirty(page);
-	f2fs_put_page(page, 1);
+	clear_node_page_dirty(&folio->page);
+	f2fs_folio_put(folio, true);
 	return ERR_PTR(err);
 }
 
-- 
2.53.0

