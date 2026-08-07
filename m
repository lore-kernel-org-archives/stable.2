Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B9F3E3557F3
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 15:19:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786115972; cv=none; b=tGN/Fg0tfAOQnjg4YRcCw7a/jVKVAa9NOSdby3qq6GpoMpjqX/+0J+f13cq4isOl3BQUe0+0PdYEaQZzHr56IopgnIiJzioilQuWb04zeldXQv/svRmWC+TfeDyuOsOkWsKUlXRW9LCDRh7euna9DgpFWRTiW2dVmhB2JYqVWmo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786115972; c=relaxed/simple;
	bh=gEsBRnwSU6lrvUo+sbK3+q30NS6gfa0ru44Tq1kYGuc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XHksEA/emUUxXRt9yuoG6gbj/R/E54xNGbXdwJ8LK/8bM6zur01Roczh6tdvX+zPr2+A/V+9tOYpt66sMIw3mAqic2kjn0BEqoz1IbC+sPX+XQwTVr/yuMRDY3bR0AgdRhra7SzMMNjRuqZK0/i1s8CNYJl2h8VtD08ecpqueBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BuUjq05Q; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BuUjq05Q"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DB21F00A3D;
	Fri,  7 Aug 2026 15:19:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786115970;
	bh=+pJg+5yH5Cggnv1uqAFtzuGvMWr/b3OCwX5MVnsXtko=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BuUjq05QZevMz3d/4gF7Vb5bW2p7ou0fNVGmrZ82f5HDgwphtIFwJDMRsdr8BgCCF
	 CGaLGrSNtBcd/FQr7GqIYnqzM4brmND/d7PKXxF2ftSlr3RRJeDgjZYPS0y8H/c57Z
	 cMkufbxyl/lzr1rlN9rgkJMVAZsNSeAMgacqH/NpVmLf+4SiILK1Aw0VOcCyTZwmzY
	 ZSfCjoLyokgruH1Z3sf5d/gks0yoEDVBciVMQum4yRN9+XGH+PT2a7v/7SNMfKah0Z
	 fg5VlYUkJvnBmEzJ49ozApgH7VqqHjUCFuyT3KykAG5Of0JBF8ruoD6piSBuRJ/u4T
	 b+fXbWvW/eksQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/5] ceph: Convert ceph_find_incompatible() to take a folio
Date: Fri,  7 Aug 2026 11:19:24 -0400
Message-ID: <20260807151926.2227006-3-sashal@kernel.org>
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

[ Upstream commit f9707a8b5b9d0a631e0a64eab5c3d2bb6d43758c ]

Both callers already have the folio.  Pass it in and use it throughout.
Removes some hidden calls to compound_head() and a reference to
page->mapping.

Signed-off-by: "Matthew Wilcox (Oracle)" <willy@infradead.org>
Link: https://lore.kernel.org/r/20250217185119.430193-4-willy@infradead.org
Tested-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Reviewed-by: Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>
Signed-off-by: Christian Brauner <brauner@kernel.org>
Stable-dep-of: cbf59617cd71 ("ceph: fix writeback_count leak in write_folio_nounlock()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ceph/addr.c | 38 +++++++++++++++++++-------------------
 1 file changed, 19 insertions(+), 19 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index d03cf2473b326..78ca5ec4bf23b 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1425,56 +1425,56 @@ static int context_is_writeable_or_written(struct inode *inode,
 
 /**
  * ceph_find_incompatible - find an incompatible context and return it
- * @page: page being dirtied
+ * @folio: folio being dirtied
  *
- * We are only allowed to write into/dirty a page if the page is
+ * We are only allowed to write into/dirty a folio if the folio is
  * clean, or already dirty within the same snap context. Returns a
  * conflicting context if there is one, NULL if there isn't, or a
  * negative error code on other errors.
  *
- * Must be called with page lock held.
+ * Must be called with folio lock held.
  */
 static struct ceph_snap_context *
-ceph_find_incompatible(struct page *page)
+ceph_find_incompatible(struct folio *folio)
 {
-	struct inode *inode = page->mapping->host;
+	struct inode *inode = folio->mapping->host;
 	struct ceph_client *cl = ceph_inode_to_client(inode);
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	if (ceph_inode_is_shutdown(inode)) {
-		doutc(cl, " %llx.%llx page %p is shutdown\n",
-		      ceph_vinop(inode), page);
+		doutc(cl, " %llx.%llx folio %p is shutdown\n",
+		      ceph_vinop(inode), folio);
 		return ERR_PTR(-ESTALE);
 	}
 
 	for (;;) {
 		struct ceph_snap_context *snapc, *oldest;
 
-		wait_on_page_writeback(page);
+		folio_wait_writeback(folio);
 
-		snapc = page_snap_context(page);
+		snapc = page_snap_context(&folio->page);
 		if (!snapc || snapc == ci->i_head_snapc)
 			break;
 
 		/*
-		 * this page is already dirty in another (older) snap
+		 * this folio is already dirty in another (older) snap
 		 * context!  is it writeable now?
 		 */
 		oldest = get_oldest_context(inode, NULL, NULL);
 		if (snapc->seq > oldest->seq) {
 			/* not writeable -- return it for the caller to deal with */
 			ceph_put_snap_context(oldest);
-			doutc(cl, " %llx.%llx page %p snapc %p not current or oldest\n",
-			      ceph_vinop(inode), page, snapc);
+			doutc(cl, " %llx.%llx folio %p snapc %p not current or oldest\n",
+			      ceph_vinop(inode), folio, snapc);
 			return ceph_get_snap_context(snapc);
 		}
 		ceph_put_snap_context(oldest);
 
-		/* yay, writeable, do it now (without dropping page lock) */
-		doutc(cl, " %llx.%llx page %p snapc %p not current, but oldest\n",
-		      ceph_vinop(inode), page, snapc);
-		if (clear_page_dirty_for_io(page)) {
-			int r = writepage_nounlock(page, NULL);
+		/* yay, writeable, do it now (without dropping folio lock) */
+		doutc(cl, " %llx.%llx folio %p snapc %p not current, but oldest\n",
+		      ceph_vinop(inode), folio, snapc);
+		if (folio_clear_dirty_for_io(folio)) {
+			int r = writepage_nounlock(&folio->page, NULL);
 			if (r < 0)
 				return ERR_PTR(r);
 		}
@@ -1489,7 +1489,7 @@ static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_snap_context *snapc;
 
-	snapc = ceph_find_incompatible(folio_page(*foliop, 0));
+	snapc = ceph_find_incompatible(*foliop);
 	if (snapc) {
 		int r;
 
@@ -1749,7 +1749,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 			break;
 		}
 
-		snapc = ceph_find_incompatible(&folio->page);
+		snapc = ceph_find_incompatible(folio);
 		if (!snapc) {
 			/* success.  we'll keep the folio locked. */
 			folio_mark_dirty(folio);
-- 
2.53.0

