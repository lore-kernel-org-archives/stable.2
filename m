Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7521634752E
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:16:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211812; cv=none; b=JVWTAxTPM4kNFRmRevE0GQDd8IwjoYkpg8jncIk5/xb2TS+OikM7r81mzpk5zZrVGtCPMTfRabd8yKszJ+h83ZfGbCSKS8OL51haSWnZGOVhjE36EMPG/sS3B4seJQC3RGTOr9c2x98dw03Ke7AHUMCG5cwLtQcW8ySJ0JDbXCE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211812; c=relaxed/simple;
	bh=6NW6bbUD7qweo6uuvwGZBzM2w7o/QXlVWdoan7cgdUc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n9qRBt+Hb9vTXpHMbVN0YVnVxDObnYVfztMxsMO1jXalw1TVtDHnz2EXgaJP0D0qQJhL7MoO82KV/MJ0XM59k4tC5RG658FEHhRAz6UFen++aSv6N9ojLq5sM6UGv8vYeBSC3NCgArCJKxfhmXNrRwjWp0iTcMRMkJUy4zfEhW0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Lez/+5z4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Lez/+5z4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C5751F000FF;
	Sat, 12 Sep 2026 11:16:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211811;
	bh=tGWFcEpW9WTgm276Q1WM6+s/GLBn5vLAmUlZgzmoTHQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Lez/+5z4LmOQ06lwiS0lUiFjB+2fBtfmo/HgZ5Nzng4hFNXUZ/0jfCwb/7ue4ZXtP
	 gq8Biz6UtGhi3L9uhm9L1sh4/bmiovaOWnsqFOl6ZnGkR/MlNKbdg6jRId16Q3ut1m
	 PmG0wXK4d8ZsesDO4GB/H8+Nwxzdsch8LqVXyslcm/1NPKwUPMWJlLItbPJcU+QIoW
	 P5ShTMJw1fznHnQhiPlETGNM9P05nMOWiNSlj78F7QOHDP6ueXReiOQLAjJ2Xnw/i6
	 UJXDWFHzyuT0CPo/hliGXrdQEzjbaEicCi/2X3NN7RivsqFATlGDmk0FV7vyGK6ycw
	 +BoJLRyX5IslA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] f2fs: Convert clear_node_page_dirty() to clear_node_folio_dirty()
Date: Sat, 12 Sep 2026 07:16:48 -0400
Message-ID: <20260912111649.2272406-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090930-constable-bacon-8c5d@gregkh>
References: <2026090930-constable-bacon-8c5d@gregkh>
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
index 586a90643ddd2..3b40ee49b3721 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -125,14 +125,14 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
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
@@ -941,7 +941,7 @@ static int truncate_node(struct dnode_of_data *dn)
 		f2fs_inode_synced(dn->inode);
 	}
 
-	clear_node_page_dirty(dn->node_page);
+	clear_node_folio_dirty(page_folio(dn->node_page));
 	set_sbi_flag(sbi, SBI_IS_DIRTY);
 
 	index = dn->node_page->index;
@@ -1384,7 +1384,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 		inc_valid_inode_count(sbi);
 	return page;
 fail:
-	clear_node_page_dirty(page);
+	clear_node_folio_dirty(page_folio(page));
 	f2fs_put_page(page, 1);
 	return ERR_PTR(err);
 }
@@ -1394,8 +1394,9 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
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
@@ -1457,14 +1458,15 @@ void f2fs_ra_node_page(struct f2fs_sb_info *sbi, nid_t nid)
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
@@ -1476,7 +1478,8 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
-	err = read_node_page(page, 0);
+	folio = page_folio(page);
+	err = read_node_folio(folio, 0);
 	if (err < 0) {
 		goto out_put_err;
 	} else if (err == LOCKED_PAGE) {
@@ -1504,20 +1507,21 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
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
@@ -1526,15 +1530,18 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 
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

