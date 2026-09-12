Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4ADDD4BEE57
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176731; cv=none; b=CK6mQiP3gEVBIubI8OKMAuTixQeIobJ2W7t7mDR/XbQZp38f+T/oDuGz4ibK7QhxrDs5DfO8Vnn5IYJhvVLF/67D1CwBNSAd0yrwSjxmkTNDP9kdw1q/dcVJeo1adgoVvKF/Bot7ZtPfxe+Cc3nDaCPaIMSGxrxJfaZ7GXEvUTE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176731; c=relaxed/simple;
	bh=8D3C8ylAr+ihsmz4AQ8QYZGKp1LnlRV2UPu3QgEnXG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CqM0rzRrWUB1tyrVuh7YNoEYJKv1S2YIpGRAdCRmVPDIucq4FGUB2cW6+/Cbpa+MCGfK7sUyDcMzIKPbVSldV978EPgafe7ZB7qak+sO/y3aRkm5kyUtXiDgRTEh7AikUfHiBcaC7wVhxu9VpZlL2gudykROBbGw4dFO1PKKOCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QtPUr0Rx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QtPUr0Rx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62F221F000FF;
	Sat, 12 Sep 2026 01:32:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176730;
	bh=5+uA1JehT8hp235OMqFsOkkrWopy+SaSiCBJPANXH58=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QtPUr0RxoVdDrO2/TWdNxaidFxvO4wVfoCSo2kkZTnLhc3fishvO1+3STX6BKJ4QI
	 PNRRiCA/MgR//EBPlTkZnS79DxhLNXg5dubcF9sT+FnZj0t/lZp6VWKM1yzBpZOKwY
	 9vGpv1B0wI5FC8VA3ZqwnS2QYTd0dpdh/VuEN12ro1SdwYcJHmEb0RU/Iyg7EQ5fSP
	 qxQpNkb2pYwe19Sodn0rhBcxUJVCywoAJcEZ6fIHOpqRLA0yt+hpWiKigYfieq9Zql
	 pCPfghsmlrQoFJiDcCHwZiteIpgvHkRgc5R+Ek5EbBtityoxayCspgHlZQbuT3lokk
	 I6gwsszpLwtOg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] f2fs: Convert clear_node_page_dirty() to clear_node_folio_dirty()
Date: Fri, 11 Sep 2026 21:32:06 -0400
Message-ID: <20260912013207.1759566-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090930-yummy-brim-dc39@gregkh>
References: <2026090930-yummy-brim-dc39@gregkh>
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

Backport to 6.12: retain the page-based node interfaces and pass
page_folio() at the two existing cleanup call sites. Use
F2FS_M_SB(folio->mapping), since this tree has no F2FS_F_SB() helper.

Keep a folio reference in __get_node_page() and convert its existing
uptodate clearing and error reporting to use that folio. This preserves
behavior while allowing the one-line error-path change in upstream
commit 5b86eab84ac8e9289b5afc52ef88ab18ba5bacab to cherry-pick cleanly.
No new functions or wider node-interface conversions are needed.

Stable-dep-of: 5b86eab84ac8 ("f2fs: fix to clear dirty flag on folio in error path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 22 ++++++++++++----------
 1 file changed, 12 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 1f4f68e56d432..fba4e5d085235 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -125,14 +125,14 @@ bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type)
 	return res;
 }
 
-static void clear_node_page_dirty(struct page *page)
+static void clear_node_folio_dirty(struct folio *folio)
 {
-	if (PageDirty(page)) {
-		f2fs_clear_page_cache_dirty_tag(page_folio(page));
-		clear_page_dirty_for_io(page);
-		dec_page_count(F2FS_P_SB(page), F2FS_DIRTY_NODES);
+	if (folio_test_dirty(folio)) {
+		f2fs_clear_page_cache_dirty_tag(folio);
+		folio_clear_dirty_for_io(folio);
+		dec_page_count(F2FS_M_SB(folio->mapping), F2FS_DIRTY_NODES);
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
 
 	index = page_folio(dn->node_page)->index;
@@ -1394,7 +1394,7 @@ struct page *f2fs_new_node_page(struct dnode_of_data *dn, unsigned int ofs)
 		inc_valid_inode_count(sbi);
 	return page;
 fail:
-	clear_node_page_dirty(page);
+	clear_node_folio_dirty(page_folio(page));
 	f2fs_put_page(page, 1);
 	return ERR_PTR(err);
 }
@@ -1476,6 +1476,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 					struct page *parent, int start)
 {
 	struct page *page;
+	struct folio *folio;
 	int err;
 
 	if (!nid)
@@ -1487,6 +1488,7 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	if (!page)
 		return ERR_PTR(-ENOMEM);
 
+	folio = page_folio(page);
 	err = read_node_page(page, 0);
 	if (err < 0) {
 		goto out_put_err;
@@ -1526,11 +1528,11 @@ static struct page *__get_node_page(struct f2fs_sb_info *sbi, pgoff_t nid,
 	f2fs_handle_error(sbi, ERROR_INCONSISTENT_FOOTER);
 	err = -EFSCORRUPTED;
 out_err:
-	ClearPageUptodate(page);
+	folio_clear_uptodate(folio);
 out_put_err:
 	/* ENOENT comes from read_node_page which is not an error. */
 	if (err != -ENOENT)
-		f2fs_handle_page_eio(sbi, page_folio(page), NODE);
+		f2fs_handle_page_eio(sbi, folio, NODE);
 	f2fs_put_page(page, 1);
 	return ERR_PTR(err);
 }
-- 
2.53.0

