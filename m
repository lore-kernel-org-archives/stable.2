Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EF89478846
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212089; cv=none; b=Riuqn0QPoJ9PcVA25lHnVq4wZk2mHkpXOQnsSKGvvY8wIyzdHYl9BgnOfw4+yzyytdxbe5wjnoNOzAYTdBy9NlMe+2AEGQYrW7Crgv5NEBFDfUSdmBW3q4qQOxIzTKWtBsf42gpw4cMjkNW0k6KlbSq0/wCLnjd6bGbz7cBmgSw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212089; c=relaxed/simple;
	bh=btPBfyy5PgjFqe6Tc3nq1MI/qgBunqiKMeBX6kLJGTU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=byfJu0FBTz4LloMByxNTeOdsCDF8nsrJjWpRmN8yNJMEip2VyJkORq5sHYdBI7FutY5lOnZalmudmoOY8XGEaR5T3idQu2gjQTIxTytVZav3BHBVKF9pJNFafmZjleHZcc+gtL/qxZBuNdNk3ZBVFx0iqi2vzVGWOYriBRBrS4w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WgoOxKTB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WgoOxKTB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8A521F000FF;
	Sat, 12 Sep 2026 11:21:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789212088;
	bh=61zvq2qXTQj/UW4ScEo8AZGB2N5HeXxElIvZdeo09R4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=WgoOxKTBjkqLaidJCprODDddEUI4SyNcymzDzrcUAFqHRgkkf8S+t/XVOnuyO6I3V
	 Ir7YK+Oe2zV8vZb95/nCd2aXRkfDfqWX5OejC3YZtvbCfhuL5t0ZcEUHyNmsLJr2hm
	 b50XgtHI4cng0SA+EzNCn17Y7tTDQ9rTXxZy/fjBrhz0glGfktrUb9Ui+41A7v4PUe
	 9D1XKIMjnba04mjBarYP0fOHkM2DtD6HXapitd1dN2hkyTlQlN50i12Ez0l7Ey29Bk
	 lQHToMYmH01KS4HamVqEQDbkT/FMTZsE7htiz9YZXFD7dbU7usa2YfgcTwgLrFzKFD
	 j4dkIMxwozqfQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] f2fs: Convert clear_node_page_dirty() to clear_node_folio_dirty()
Date: Sat, 12 Sep 2026 07:21:25 -0400
Message-ID: <20260912112126.2312794-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090930-scallion-geometry-8ab1@gregkh>
References: <2026090930-scallion-geometry-8ab1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit f16ebe0de73274fd1cf885b30cc4fe42d2a1821a ]

Both callers have a folio so pass it in, removing five calls to
compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Backport notes for 6.6:
The stable callers and F2FS dirty-tag/superblock helpers still use pages.
Convert the existing dirty-node helper to folios, using page_folio() at
its callers and the folio's page for the existing F2FS interfaces.

Prepare the existing node-read helpers for the follow-up error-path fix:
read_node_folio() accepts a folio, __get_node_folio() returns one, and the
public node-page getters retain their page interfaces and error pointers.
Keep the stable footer validation inline and arrange its success return
and error labels to match the target patch. This preserves the existing
validation, locking and reference handling without adding functions or
importing the wider upstream node-folio conversion.

Stable-dep-of: 5b86eab84ac8 ("f2fs: fix to clear dirty flag on folio in error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 53 ++++++++++++++++++++++++++++----------------------
 1 file changed, 30 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8d2e5d3910c59..8099e56e7ac22 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -123,14 +123,14 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 	return res;
 }
 
-static void clear_node_page_dirty(struct page *page)
+static void clear_node_folio_dirty(struct folio *folio)
 {
-	if (PageDirty(page)) {
-		f2fs_clear_page_cache_dirty_tag(page);
-		clear_page_dirty_for_io(page);
-		dec_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
+	if (folio_test_dirty(folio)) {
+		f2fs_clear_page_cache_dirty_tag(&folio->page);
+		folio_clear_dirty_for_io(folio);
+		dec_page_count(F2FS_P_SB(&folio->page), F2FS_DIRTY_NODES);
 	}
-	ClearPageUptodate(page);
+	folio_clear_uptodate(folio);
 }
 
 static struct page *get_current_nat_page(struct f2fs_sb_info *sbi, nid_t nid)
@@ -929,7 +929,7 @@ static int truncate_node(struct dnode_of_data *dn)
 		f2fs_inode_synced(dn->inode);
 	}
 
-	clear_node_page_dirty(dn->node_page);
+	clear_node_folio_dirty(page_folio(dn->node_page));
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 
 	index = dn->node_page->index;
@@ -1357,7 +1357,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 		inc_valid_inode_count(sbi);
 	return page;
 fail:
-	clear_node_page_dirty(page);
+	clear_node_folio_dirty(page_folio(page));
 	f2fs_put_page(page, 1);
 	return ERR_PTR(err);
 }
@@ -1367,8 +1367,9 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
  * 0: f2fs_put_page(page, 0)
  * LOCKED_PAGE or error: f2fs_put_page(page, 1)
  */
-static int read_node_page(struct page *page, blk_opf_t op_flags)
+static int read_node_folio(struct folio *folio, blk_opf_t op_flags)
 {
+	struct page *page = &folio->page;
 	struct f2fs_sb_info *sbi = F2FS_P_SB(page);
 	struct node_info ni;
 	struct f2fs_io_info fio = {
@@ -1430,14 +1431,15 @@ void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
 	if (!apage)
 		return;
 
-	err = read_node_page(apage, REQ_RAHEAD);
+	err = read_node_folio(page_folio(apage), REQ_RAHEAD);
 	f2fs_put_page(apage, err ? 1 : 0);
 }
 
-static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
+static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 					struct page *parent, int start)
 {
 	struct page *page;
+	struct folio *folio;
 	int err;
 
 	if (!nid)
@@ -1449,7 +1451,8 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
-	err = read_node_page(page, 0);
+	folio = page_folio(page);
+	err = read_node_folio(folio, 0);
 	if (err < 0) {
 		goto out_put_err;
 	} else if (err == LOCKED_PAGE) {
@@ -1477,20 +1480,21 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 		goto out_err;
 	}
 page_hit:
-	if (likely(nid == nid_of_node(page)))
-		return page;
-
-	f2fs_warn(sbi, "inconsistent node block, nid:%lu, node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
+	if (unlikely(nid != nid_of_node(page))) {
+		f2fs_warn(sbi, "inconsistent node block, nid:%lu, node_footer[nid:%u,ino:%u,ofs:%u,cpver:%llu,blkaddr:%u]",
 			  nid, nid_of_node(page), ino_of_node(page),
 			  ofs_of_node(page), cpver_of_node(page),
 			  next_blkaddr_of_node(page));
-	set_sbi_flag(sbi, SBI_NEED_FSCK);
-	f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
-	err = -EFSCORRUPTED;
+		set_sbi_flag(sbi, SBI_NEED_FSCK);
+		f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
+		err = -EFSCORRUPTED;
+	}
+	if (!err)
+		return folio;
 out_err:
-	ClearPageUptodate(page);
+	folio_clear_uptodate(folio);
 out_put_err:
-	/* ENOENT comes from read_node_page which is not an error. */
+	/* ENOENT comes from read_node_folio which is not an error. */
 	if (err != -ENOENT)
 		f2fs_handle_page_eio(sbi, page->index, NODE);
 	f2fs_put_page(page, 1);
@@ -1499,15 +1503,18 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 
 struct page *f2fs_get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid)
 {
-	return __get_node_page(sbi, nid, NULL, 0);
+	struct folio *folio = __get_node_folio(sbi, nid, NULL, 0);
+
+	return IS_ERR(folio) ? ERR_CAST(folio) : &folio->page;
 }
 
 struct page *f2fs_get_node_page_ra(struct page *parent, int start)
 {
 	struct f2fs_sb_info *sbi = F2FS_P_SB(parent);
 	nid_t nid = get_nid(parent, start, false);
+	struct folio *folio = __get_node_folio(sbi, nid, parent, start);
 
-	return __get_node_page(sbi, nid, parent, start);
+	return IS_ERR(folio) ? ERR_CAST(folio) : &folio->page;
 }
 
 static void flush_inline_data(struct f2fs_sb_info *sbi, nid_t ino)
-- 
2.53.0

