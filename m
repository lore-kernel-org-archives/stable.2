Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 89FFD324B0A
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:19:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115972; cv=none; b=g7LY1NpmE2hoUttSc8WE73ne0rWExYU3T7fe4qnzQt858Gur3bnbPA4MXwahmOdbjFLfqVfACAxZAbS0vfOXaXV+nZru2WEiOVD/TWzucUffiyRUqadVY5ghk71D539z7tw2iTuFwXjrYB7N+NLczkvk+KGK5I2FyQZk4XWVU3k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115972; c=relaxed/simple;
	bh=safwu6416dkTNs6lEIQQ5B8zsXDNjIO3GwS3k8SDGe4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jNRY1CzXhybRIVGrosHMw0fpotBJpH/MrIzp8khFTQN0XhclwZK63v2cJr48vwBS4zQdX6lGV0PHgcxEJ/6npQP2qnmQnB15KSFDeLT50WeKylOoOuOdjfqxhqxYhjySdy68V9UgrZw8qh/ha4s4T4/MJ7Og854YWr+kbNAP0h4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Z9+R7eHC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Z9+R7eHC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFFF41F00A3E;
	Fri,  7 Aug 2026 15:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115971;
	bh=XCAzUUD8/n5c9N5EnLkJ+XKcOWvG0iPmUnoWsIrLZv8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Z9+R7eHCky/Wu8c/ZpQ4krP/BclSYr+PSZW1fZ3MRZLS/x1rpmJdXGbaT7RXA+r0y
	 nrGK0ecaWPl532+iTfS01xzaVhwMCvguudHA8B3qUFd8UCeYnO5AK1zoTo/PbaUWAS
	 bl3KWbszSEd9QTjWTlzG2OrIk1Pej4Hjg9irN/qWrGJh14a92UGd0+0sx3lqzVxyfc
	 gPXvPJ7voiq0UcJ/Fp43EgYACaFpKvVz83qx3XKuiX6XevushwNxOtkLYgMUXG2Kt0
	 rtAk+sKowVQRlxJYPemF+QK4riR1BpVt/w56iE8y4rxAVyMw0f6GuuFlK+UeeKD+RP
	 K+C4NPoRJF2rg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/5] ceph: Convert writepage_nounlock() to write_folio_nounlock()
Date: Fri,  7 Aug 2026 11:19:25 -0400
Message-ID: <20260807151926.2227006-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807151926.2227006-1-sashal@kernel.org>
References: <2026072946-idiom-facelift-7c9f@gregkh>
 <20260807151926.2227006-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 62171c16da6000811e172a76a1f73d132c4697e8 ]

Remove references to page->index, page->mapping, thp_size(),
page_offset() and other page APIs in favour of their more efficient
folio replacements.

Signed-off-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Link: https://lore.kernel.org/r/20250217185119.430193-6-willy@infradead.org
Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: cbf59617cd71 ("ceph: fix writeback_count leak in write_folio_nounlock()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/addr.c | 67 +++++++++++++++++++++++++-------------------------
 1 file changed, 34 insertions(+), 33 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 78ca5ec4bf23b..72f72ed69723f 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -670,22 +670,23 @@ static u64 get_writepages_data_length(struct inode *inode,
 }
 
 /*
- * Write a single page, but leave the page locked.
+ * Write a folio, but leave it locked.
  *
  * If we get a write error, mark the mapping for error, but still adjust the
- * dirty page accounting (i.e., page is no longer dirty).
+ * dirty page accounting (i.e., folio is no longer dirty).
  */
-static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
+static int write_folio_nounlock(struct folio *folio,
+		struct writeback_control *wbc)
 {
-	struct folio *folio = page_folio(page);
-	struct inode *inode = page->mapping->host;
+	struct page *page = &folio->page;
+	struct inode *inode = folio->mapping->host;
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_fs_client *fsc = ceph_inode_to_fs_client(inode);
 	struct ceph_client *cl = fsc->client;
 	struct ceph_snap_context *snapc, *oldest;
-	loff_t page_off = page_offset(page);
+	loff_t page_off = folio_pos(folio);
 	int err;
-	loff_t len = thp_size(page);
+	loff_t len = folio_size(folio);
 	loff_t wlen;
 	struct ceph_writeback_ctl ceph_wbc;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
@@ -693,27 +694,27 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	bool caching = ceph_is_cache_enabled(inode);
 	struct page *bounce_page = NULL;
 
-	doutc(cl, "%llx.%llx page %p idx %lu\n", ceph_vinop(inode), page,
-	      page->index);
+	doutc(cl, "%llx.%llx folio %p idx %lu\n", ceph_vinop(inode), folio,
+	      folio->index);
 
 	if (ceph_inode_is_shutdown(inode))
 		return -EIO;
 
 	/* verify this is a writeable snap context */
-	snapc = page_snap_context(page);
+	snapc = page_snap_context(&folio->page);
 	if (!snapc) {
-		doutc(cl, "%llx.%llx page %p not dirty?\n", ceph_vinop(inode),
-		      page);
+		doutc(cl, "%llx.%llx folio %p not dirty?\n", ceph_vinop(inode),
+		      folio);
 		return 0;
 	}
 	oldest = get_oldest_context(inode, &ceph_wbc, snapc);
 	if (snapc->seq > oldest->seq) {
-		doutc(cl, "%llx.%llx page %p snapc %p not writeable - noop\n",
-		      ceph_vinop(inode), page, snapc);
+		doutc(cl, "%llx.%llx folio %p snapc %p not writeable - noop\n",
+		      ceph_vinop(inode), folio, snapc);
 		/* we should only noop if called by kswapd */
 		WARN_ON(!(current->flags & PF_MEMALLOC));
 		ceph_put_snap_context(oldest);
-		redirty_page_for_writepage(wbc, page);
+		folio_redirty_for_writepage(wbc, folio);
 		return 0;
 	}
 	ceph_put_snap_context(oldest);
@@ -730,8 +731,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		len = ceph_wbc.i_size - page_off;
 
 	wlen = IS_ENCRYPTED(inode) ? round_up(len, CEPH_FSCRYPT_BLOCK_SIZE) : len;
-	doutc(cl, "%llx.%llx page %p index %lu on %llu~%llu snapc %p seq %lld\n",
-	      ceph_vinop(inode), page, page->index, page_off, wlen, snapc,
+	doutc(cl, "%llx.%llx folio %p index %lu on %llu~%llu snapc %p seq %lld\n",
+	      ceph_vinop(inode), folio, folio->index, page_off, wlen, snapc,
 	      snapc->seq);
 
 	if (atomic_long_inc_return(&fsc->writeback_count) >
@@ -744,32 +745,32 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 				    ceph_wbc.truncate_seq,
 				    ceph_wbc.truncate_size, true);
 	if (IS_ERR(req)) {
-		redirty_page_for_writepage(wbc, page);
+		folio_redirty_for_writepage(wbc, folio);
 		return PTR_ERR(req);
 	}
 
 	if (wlen < len)
 		len = wlen;
 
-	set_page_writeback(page);
+	folio_start_writeback(folio);
 	if (caching)
-		ceph_set_page_fscache(page);
+		ceph_set_page_fscache(&folio->page);
 	ceph_fscache_write_to_cache(inode, page_off, len, caching);
 
 	if (IS_ENCRYPTED(inode)) {
-		bounce_page = fscrypt_encrypt_pagecache_blocks(page,
+		bounce_page = fscrypt_encrypt_pagecache_blocks(&folio->page,
 						    CEPH_FSCRYPT_BLOCK_SIZE, 0,
 						    GFP_NOFS);
 		if (IS_ERR(bounce_page)) {
-			redirty_page_for_writepage(wbc, page);
-			end_page_writeback(page);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_end_writeback(folio);
 			ceph_osdc_put_request(req);
 			return PTR_ERR(bounce_page);
 		}
 	}
 
 	/* it may be a short write due to an object boundary */
-	WARN_ON_ONCE(len > thp_size(page));
+	WARN_ON_ONCE(len > folio_size(folio));
 	osd_req_op_extent_osd_data_pages(req, 0,
 			bounce_page ? &bounce_page : &page, wlen, 0,
 			false, false);
@@ -795,25 +796,25 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		if (err == -ERESTARTSYS) {
 			/* killed by SIGKILL */
 			doutc(cl, "%llx.%llx interrupted page %p\n",
-			      ceph_vinop(inode), page);
-			redirty_page_for_writepage(wbc, page);
-			end_page_writeback(page);
+			      ceph_vinop(inode), folio);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_end_writeback(folio);
 			return err;
 		}
 		if (err == -EBLOCKLISTED)
 			fsc->blocklisted = true;
-		doutc(cl, "%llx.%llx setting page/mapping error %d %p\n",
-		      ceph_vinop(inode), err, page);
+		doutc(cl, "%llx.%llx setting mapping error %d %p\n",
+		      ceph_vinop(inode), err, folio);
 		mapping_set_error(&inode->i_data, err);
 		wbc->pages_skipped++;
 	} else {
 		doutc(cl, "%llx.%llx cleaned page %p\n",
-		      ceph_vinop(inode), page);
+		      ceph_vinop(inode), folio);
 		err = 0;  /* vfs expects us to return 0 */
 	}
-	oldest = detach_page_private(page);
+	oldest = folio_detach_private(folio);
 	WARN_ON_ONCE(oldest != snapc);
-	end_page_writeback(page);
+	folio_end_writeback(folio);
 	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
 	ceph_put_snap_context(snapc);  /* page's reference */
 
@@ -1474,7 +1475,7 @@ ceph_find_incompatible(struct folio *folio)
 		doutc(cl, " %llx.%llx folio %p snapc %p not current, but oldest\n",
 		      ceph_vinop(inode), folio, snapc);
 		if (folio_clear_dirty_for_io(folio)) {
-			int r = writepage_nounlock(&folio->page, NULL);
+			int r = write_folio_nounlock(folio, NULL);
 			if (r < 0)
 				return ERR_PTR(r);
 		}
-- 
2.53.0

