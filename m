Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF4F745D1A8
	for <stable@vger.kernel.org>; Fri,  7 Aug 2026 22:10:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786140614; cv=none; b=EbnOgf4MnX4GgBm50hAiTkoLj6zvLu0D0vMWk2lt6ApBdpXbeAdyxL4kTW8Z3QAE2x8VkDrxogqNTSHpRcoP4EGebPucwP/NaWftboVerixltJMKgBUIYUapPjC1C5UDyjdboXyK835qy4+44ZoFEdKDlUbK4FSVMzMKPuI0QpI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786140614; c=relaxed/simple;
	bh=7fqDTrrjZX93yGNwLrDviXzKVKy00+mQjTjGaOo62Fc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HvwhlEHjDfDcCF8b0jYmdHxyCmsYQu061G8UX34P2+EChbiVRiNxbhlTu4fJ6wJe+rACk4Mi0aB7V6WnjA+JZIsUlopJ3MOFaLxL5IzW712Z+nUUpIvytsTjDZpCXtNjvUBWjexH5rkIegOOBa/pwavMdZ0cXUZvfRkI8Z1fmII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EmB7QMiZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EmB7QMiZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F33491F00A3E;
	Fri,  7 Aug 2026 22:10:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786140612;
	bh=ZulngKFgQRBTGVcdtCw7Yozm394gkhxF/vNbWoV8g8E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EmB7QMiZ+kND42UsTRokOs46NpWqpqVa6T8t+HnOeOcd23PVBj0kI5i7oR1uw92Cj
	 iMRbLEdsvxFaxoIwUgjnKnhCp77nQsUH3V0Xw5hlBtUyWRUXSn4wRljyUnBPhyKQ00
	 fd1gKe18Wvv2G5/PwflJseFk6XotWX/K5M5eNl2/K8zhql+sdjId4uY9czDipquVta
	 oMIz2gQsyKSvlAL6xOY358fGkVa31YXvgpgZBcRMSHLHZhQCPPVZGo1rgWFqKvGASg
	 uDlTI5iYz68MpQDWa7PtR82yMXJeb6eb+8F8gWBvKQVfgUFH7wQGDX94a24pC5gQ9p
	 9dVXcQqz2K6HA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Viacheslav Dubeyko <Slava.Dubeyko@ibm.com>,
	Christian Brauner <brauner@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/5] ceph: Convert ceph_find_incompatible() to take a folio
Date: Fri,  7 Aug 2026 18:10:06 -0400
Message-ID: <20260807221008.3785418-3-sashal@kernel.org>
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
 fs/ceph/addr.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 95b3e6b1c11aa..9472e9f25dab0 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -1391,23 +1391,23 @@ static int context_is_writeable_or_written(struct inode *inode,
 
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
 	struct ceph_inode_info *ci = ceph_inode(inode);
 
 	if (ceph_inode_is_shutdown(inode)) {
-		dout(" page %p %llx:%llx is shutdown\n", page,
+		dout(" folio %p %llx:%llx is shutdown\n", folio,
 		     ceph_vinop(inode));
 		return ERR_PTR(-ESTALE);
 	}
@@ -1415,29 +1415,29 @@ ceph_find_incompatible(struct page *page)
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
-			dout(" page %p snapc %p not current or oldest\n", page, snapc);
+			dout(" folio %p snapc %p not current or oldest\n", folio, snapc);
 			return ceph_get_snap_context(snapc);
 		}
 		ceph_put_snap_context(oldest);
 
-		/* yay, writeable, do it now (without dropping page lock) */
-		dout(" page %p snapc %p not current, but oldest\n", page, snapc);
-		if (clear_page_dirty_for_io(page)) {
-			int r = writepage_nounlock(page, NULL);
+		/* yay, writeable, do it now (without dropping folio lock) */
+		dout(" folio %p snapc %p not current, but oldest\n", folio, snapc);
+		if (folio_clear_dirty_for_io(folio)) {
+			int r = writepage_nounlock(&folio->page, NULL);
 			if (r < 0)
 				return ERR_PTR(r);
 		}
@@ -1452,7 +1452,7 @@ static int ceph_netfs_check_write_begin(struct file *file, loff_t pos, unsigned
 	struct ceph_inode_info *ci = ceph_inode(inode);
 	struct ceph_snap_context *snapc;
 
-	snapc = ceph_find_incompatible(folio_page(*foliop, 0));
+	snapc = ceph_find_incompatible(*foliop);
 	if (snapc) {
 		int r;
 
@@ -1712,7 +1712,7 @@ static vm_fault_t ceph_page_mkwrite(struct vm_fault *vmf)
 			break;
 		}
 
-		snapc = ceph_find_incompatible(&folio->page);
+		snapc = ceph_find_incompatible(folio);
 		if (!snapc) {
 			/* success.  we'll keep the folio locked. */
 			folio_mark_dirty(folio);
-- 
2.53.0

