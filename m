Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF0F246EF64
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:10:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140615; cv=none; b=E/vOTNMB7RJP0jZVxhA6+3gbKJ9ugZi5m/3gHnDZ6fUyq705XQ/vJDeJUZWYyYyx0q91i5WFAw8JbGlgWRcyzfyGeNF3PHz/Kl5Ul7xTCSXX0WHZdPzyTrS+mktmlN3texb/4fw30l4ow9JxURehN2QIqoL3kawaxOsg5vy66MY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140615; c=relaxed/simple;
	bh=5OobtIdtstBR0cWtKksFuiPLtLKQR5ikcQ9httlSvlQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SM7MdKgVc92T17ux+zIRGK4hifhehCv7Fts9caPhw0fuuz5UdqCQyciMwGUFs6X9GL9SX4dAyKvBFKWjRHoqDB//gjKVDvJyyBYXwh8ZR/Tfy+SciuxF86UmbFagOZJoSerNiM2GZw01utD6KSFn3osNkOnSOXnOVuQ3uZvzGd0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NBiByX1u; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NBiByX1u"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C78D31F00A3F;
	Fri,  7 Aug 2026 22:10:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140613;
	bh=+LB6Jtdpyoy22m97lGljljfCNYi8wtW4gnwGHp6ygBc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NBiByX1uKrqW/fbg01UgFM8HNi8sM1LP5gSfRHn1DHGzYHjb03dZBoVXx2c6JF/6a
	 MEWvoQKqpAaMfkXge7iuZ9/UkUFwgCDtiyBirUz0ITyQkvN3k3kuS9A6fFjP5qpMUA
	 vQBJmcxKXFPwnWZOWbCqlKN+bncLIpemZbpBLuHbvu9D7eOsCUZFPFzbe3DyCeyP6I
	 hWdT7lWz1K5ALA55dqT6bFkV1v7p9wvk1vnzoDLsOtySuywk4g52W7yuvY0pRLNPLd
	 nfVVJSNm8goZB2FgD5YY/5uCExYUU0BQFFk6fF5nkzU/17Nvcv8AsZWrTyNoe1pb9r
	 JDs5Wfx9VL8yQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/5] ceph: Convert writepage_nounlock() to write_folio_nounlock()
Date: Fri,  7 Aug 2026 18:10:07 -0400
Message-ID: <20260807221008.3785418-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260807221008.3785418-1-sashal@kernel.org>
References: <2026072947-gulp-passivism-4b27@gregkh>
 <20260807221008.3785418-1-sashal@kernel.org>
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
 fs/ceph/addr.c | 63 +++++++++++++++++++++++++-------------------------
 1 file changed, 32 insertions(+), 31 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 9472e9f25dab0..57086663a9bf9 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -652,21 +652,22 @@ static u64 get_writepages_data_length(struct inode *inode,
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
 	struct ceph_snap_context *snapc, *oldest;
-	loff_t page_off = page_offset(page);
+	loff_t page_off = folio_pos(folio);
 	int err;
-	loff_t len = thp_size(page);
+	loff_t len = folio_size(folio);
 	loff_t wlen;
 	struct ceph_writeback_ctl ceph_wbc;
 	struct ceph_osd_client *osdc = &fsc->client->osdc;
@@ -674,25 +675,25 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	bool caching = ceph_is_cache_enabled(inode);
 	struct page *bounce_page = NULL;
 
-	dout("writepage %p idx %lu\n", page, page->index);
+	dout("writepage %p idx %lu\n", folio, folio->index);
 
 	if (ceph_inode_is_shutdown(inode))
 		return -EIO;
 
 	/* verify this is a writeable snap context */
-	snapc = page_snap_context(page);
+	snapc = page_snap_context(&folio->page);
 	if (!snapc) {
-		dout("writepage %p page %p not dirty?\n", inode, page);
+		dout("writepage %p folio %p not dirty?\n", inode, folio);
 		return 0;
 	}
 	oldest = get_oldest_context(inode, &ceph_wbc, snapc);
 	if (snapc->seq > oldest->seq) {
-		dout("writepage %p page %p snapc %p not writeable - noop\n",
-		     inode, page, snapc);
+		dout("writepage %p folio %p snapc %p not writeable - noop\n",
+		     inode, folio, snapc);
 		/* we should only noop if called by kswapd */
 		WARN_ON(!(current->flags & PF_MEMALLOC));
 		ceph_put_snap_context(oldest);
-		redirty_page_for_writepage(wbc, page);
+		folio_redirty_for_writepage(wbc, folio);
 		return 0;
 	}
 	ceph_put_snap_context(oldest);
@@ -709,8 +710,8 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 		len = ceph_wbc.i_size - page_off;
 
 	wlen = IS_ENCRYPTED(inode) ? round_up(len, CEPH_FSCRYPT_BLOCK_SIZE) : len;
-	dout("writepage %p page %p index %lu on %llu~%llu snapc %p seq %lld\n",
-	     inode, page, page->index, page_off, wlen, snapc, snapc->seq);
+	dout("writepage %p folio %p index %lu on %llu~%llu snapc %p seq %lld\n",
+	     inode, folio, folio->index, page_off, wlen, snapc, snapc->seq);
 
 	if (atomic_long_inc_return(&fsc->writeback_count) >
 	    CONGESTION_ON_THRESH(fsc->mount_options->congestion_kb))
@@ -722,32 +723,32 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
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
@@ -771,24 +772,24 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 			wbc = &tmp_wbc;
 		if (err == -ERESTARTSYS) {
 			/* killed by SIGKILL */
-			dout("writepage interrupted page %p\n", page);
-			redirty_page_for_writepage(wbc, page);
-			end_page_writeback(page);
+			dout("writepage interrupted folio %p\n", folio);
+			folio_redirty_for_writepage(wbc, folio);
+			folio_end_writeback(folio);
 			return err;
 		}
 		if (err == -EBLOCKLISTED)
 			fsc->blocklisted = true;
-		dout("writepage setting page/mapping error %d %p\n",
-		     err, page);
+		dout("writepage setting mapping error %d %p\n",
+		     err, folio);
 		mapping_set_error(&inode->i_data, err);
 		wbc->pages_skipped++;
 	} else {
-		dout("writepage cleaned page %p\n", page);
+		dout("writepage cleaned folio %p\n", folio);
 		err = 0;  /* vfs expects us to return 0 */
 	}
-	oldest = detach_page_private(page);
+	oldest = folio_detach_private(folio);
 	WARN_ON_ONCE(oldest != snapc);
-	end_page_writeback(page);
+	folio_end_writeback(folio);
 	ceph_put_wrbuffer_cap_refs(ci, 1, snapc);
 	ceph_put_snap_context(snapc);  /* page's reference */
 
@@ -1437,7 +1438,7 @@ ceph_find_incompatible(struct folio *folio)
 		/* yay, writeable, do it now (without dropping folio lock) */
 		dout(" folio %p snapc %p not current, but oldest\n", folio, snapc);
 		if (folio_clear_dirty_for_io(folio)) {
-			int r = writepage_nounlock(&folio->page, NULL);
+			int r = write_folio_nounlock(folio, NULL);
 			if (r < 0)
 				return ERR_PTR(r);
 		}
-- 
2.53.0

