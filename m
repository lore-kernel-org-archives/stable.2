Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1C2922EC09B
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:21:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212088; cv=none; b=OLKrh6NugHHtgCC2DwN+K2KOjmL6DPoxfBZRdQprGjXYyhnVEFuw6Lkcep7W6RKrT20T7DJOkoTwQ+/E4XUp9o3YVbtQz9eLWadR60vAOeJQT686YRFYXkaU7oGNb0yPos0sM6DJrUbXxHGO/IE0sUFvI+XciJud2iWpSBpY5uc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212088; c=relaxed/simple;
	bh=oUPl754T+MepPzCw0/8x/csJdeNZE/p0suRxKKNFwIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RofXJHCclH4qfSeho4nR0EQFX119yeerf7qQiQ0ybCSHP6nyP9DxVN2OzK9rU0NqMh+d6KEXpOZHNoGfg5MtGePVGcWLpjOnpwM00hFXOq0neapCW2IZGdMHV77cvgI5neczR4g6ISZdJL457Wl4QbhAH2uK3jLP0K/l/iLUseA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QDD6NVuT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QDD6NVuT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 684DB1F0089A;
	Sat, 12 Sep 2026 11:21:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789212087;
	bh=LYcqRXQ3BY8Sb5IlPahX8zHFSKF9lDWg8/x+IB3xVRA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QDD6NVuTBk50jgtbDNr7FvvGrrCtgeAWzXZ5NvT0z1ZWGQ8tjOeY++sjeBsBqp+C0
	 YPuFWWl/l5ECFP+TrJLdCJFyyfk7hBXgYy14jmiSPGFV3wV1r8GTlbVvgyd1JOC8ZK
	 HR74T77HWCuhJxErNH0kUds47OCpmXx/uQyvSv1TQivz3VRbbfe0dXuAYJEQQFRdAN
	 iaI/cVS4sgUFrVQiC+JDtY0WEdSoHk2yZ3X8/SU43M1tXEhGeNtC4eM40At8NC0BJT
	 GeIGe4uiS9RB1HDH6D9tz2edYBkf3hWzzLLfVBOfzEXc1SXHCHq15cWzrzgQkv32fg
	 hrqGew79zqqDA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/6] f2fs: Add f2fs_new_node_folio()
Date: Sat, 12 Sep 2026 07:21:19 -0400
Message-ID: <20260912112124.2312624-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090958-headband-sturdy-0f93@gregkh>
References: <2026090958-headband-sturdy-0f93@gregkh>
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
index cbf4032b5b7ee..4afc0cc6e588d 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3595,7 +3595,7 @@ int f2fs_wait_on_node_pages_writeback(struct f2fs_sb_info *sbi,
 bool f2fs_nat_bitmap_enabled(struct f2fs_sb_info *sbi);
 int f2fs_remove_inode_page(struct inode *inode);
 struct page *f2fs_new_inode_page(struct inode *inode);
-struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs);
+struct folio *f2fs_new_node_folio(struct dnode_of_data *dn, unsigned int ofs);
 void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid);
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid);
 struct page *f2fs_get_node_page_ra(struct page *parent, int start);
@@ -3624,6 +3624,12 @@ void f2fs_destroy_node_manager(struct f2fs_sb_info *sbi);
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
index 8d2e5d3910c59..3f003cfe055a6 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1304,19 +1304,19 @@ struct page *f2fs_new_inode_page(struct inode *inode)
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
@@ -1342,12 +1342,12 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
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
@@ -1355,10 +1355,10 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 
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

