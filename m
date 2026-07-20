Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2CA743305E
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:09:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784560190; cv=none; b=n8wGy3OAoKLHAr5U4O70z7SOaOSSLjlM23EPrOC05XSAiWpfTw6wY5uFkJB78Xn1HtJIZIS/hdH2DGFoDATdLqo0++3HO+wQbqEmood9qj2sPgSRHQhHKxzsKcjgIq38SOWxtvIWXVAAHebjGoJsT0KHNBdBHgqSZyi1CRzZLUs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784560190; c=relaxed/simple;
	bh=msLZtkXKPFzF7mw0N2KavaZtfFYv1rBcjyDaHvwlFLg=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=F3gD6Pr3XtaMpLy8iHHmd2bSifJbdTlSOtnJtb8Vo2+f95/JCtKtoSvl2wXNGRl/7hz3crZ/N1PLvi8dGQD401vG5U0oktq5ENT+bLuTrQc39uD89EBSsO/E0bblMU5WR8v5Ca0SlOXp4zDijd1qBxUerC1Lham3KsuTKmzlPdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=l4yfbu/3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="l4yfbu/3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B8EA1F00A3A;
	Mon, 20 Jul 2026 15:09:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784560188;
	bh=BA2jxhy32SFGBlOT3iqhj3deJS7CKsM6LNRGwWRivn0=;
	h=Subject:To:Cc:From:Date;
	b=l4yfbu/3rSNrM4pVOuFqps6anemiwncbnzrtTsnNq4ZDo7iWi+VJC6fgQtH01OciH
	 gk30/xUstjsNE76lP5eIGRmekkLaIJaJF4q90EcuvefWYww6FLlUwxMutvU2ym3GH6
	 990R5Oju9YvwtYXqwWsn9UKtaZra0MErsTOgoutw=
Subject: FAILED: patch "[PATCH] NFS: Charge unstable writes by request size, not folio size" failed to apply to 6.6-stable tree
To: ben.coddington@hammerspace.com,anna.schumaker@hammerspace.com,bcodding@hammerspace.com,noreply@anthropic.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 20 Jul 2026 17:09:39 +0200
Message-ID: <2026072039-unheard-expand-767d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 27934d02cbeb8a957dd11c985a579e58d30c5270
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026072039-unheard-expand-767d@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 27934d02cbeb8a957dd11c985a579e58d30c5270 Mon Sep 17 00:00:00 2001
From: Benjamin Coddington <ben.coddington@hammerspace.com>
Date: Tue, 7 Jul 2026 11:07:16 -0400
Subject: [PATCH] NFS: Charge unstable writes by request size, not folio size

nfs_folio_mark_unstable() and nfs_folio_clear_commit() charge and
uncharge NR_WRITEBACK/WB_WRITEBACK by folio_nr_pages(folio) once per
*request* added to or removed from a commit list. This is correct only
when a folio has a single associated request. When pg_test splits a
folio into N sub-folio requests (e.g. pNFS flexfiles striping with a
stripe unit smaller than the folio size, or plain wsize-limited
splitting), each of the N requests independently charges the whole
folio's page count, inflating the accounting by a factor of N per
folio. With large folios and small stripe units this reaches multiple
orders of magnitude: a 2 MiB folio split into 512 4 KiB requests can
charge up to 512x its real size, pushing global dirty+writeback
accounting past the system's dirty threshold and forcing every
buffered writer on the host into the hard-throttle path, including
unrelated in-kernel NFS server threads sharing the box.

Charge each request only for the pages it actually covers.

Fixes: 0c493b5cf16e ("NFS: Convert buffered writes to use folios")
Cc: stable@vger.kernel.org
Signed-off-by: Benjamin Coddington <bcodding@hammerspace.com>
Assisted-By: Claude Sonnet 5 <noreply@anthropic.com>
Signed-off-by: Anna Schumaker <anna.schumaker@hammerspace.com>

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index acaeff7ddfdf..e4533f583632 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -851,17 +851,19 @@ void nfs_super_set_maxbytes(struct super_block *sb, __u64 maxfilesize)
 }
 
 /*
- * Record the page as unstable (an extra writeback period) and mark its
- * inode as dirty.
+ * Record the request's range as unstable (an extra writeback period) and
+ * mark its inode as dirty.
  */
-static inline void nfs_folio_mark_unstable(struct folio *folio,
+static inline void nfs_folio_mark_unstable(struct nfs_page *req,
 					   struct nfs_commit_info *cinfo)
 {
+	struct folio *folio = nfs_page_to_folio(req);
+
 	if (folio && !cinfo->dreq) {
 		struct inode *inode = folio->mapping->host;
-		long nr = folio_nr_pages(folio);
+		long nr = DIV_ROUND_UP(req->wb_bytes, PAGE_SIZE);
 
-		/* This page is really still in write-back - just that the
+		/* This range is really still in write-back - just that the
 		 * writeback is happening on the server now.
 		 */
 		node_stat_mod_folio(folio, NR_WRITEBACK, nr);
diff --git a/fs/nfs/pnfs_nfs.c b/fs/nfs/pnfs_nfs.c
index 0ff43dbcb7cd..648c95b78eea 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -1199,7 +1199,7 @@ pnfs_layout_mark_request_commit(struct nfs_page *req,
 
 	nfs_request_add_commit_list_locked(req, list, cinfo);
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
-	nfs_folio_mark_unstable(nfs_page_to_folio(req), cinfo);
+	nfs_folio_mark_unstable(req, cinfo);
 	return;
 out_resched:
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index fcffb8c9e9df..d2b03ceaeb4f 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -807,7 +807,7 @@ nfs_request_add_commit_list(struct nfs_page *req, struct nfs_commit_info *cinfo)
 	mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
 	nfs_request_add_commit_list_locked(req, &cinfo->mds->list, cinfo);
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
-	nfs_folio_mark_unstable(nfs_page_to_folio(req), cinfo);
+	nfs_folio_mark_unstable(req, cinfo);
 }
 EXPORT_SYMBOL_GPL(nfs_request_add_commit_list);
 
@@ -866,10 +866,12 @@ nfs_mark_request_commit(struct nfs_page *req, struct pnfs_layout_segment *lseg,
 	nfs_request_add_commit_list(req, cinfo);
 }
 
-static void nfs_folio_clear_commit(struct folio *folio)
+static void nfs_folio_clear_commit(struct nfs_page *req)
 {
+	struct folio *folio = nfs_page_to_folio(req);
+
 	if (folio) {
-		long nr = folio_nr_pages(folio);
+		long nr = DIV_ROUND_UP(req->wb_bytes, PAGE_SIZE);
 
 		node_stat_mod_folio(folio, NR_WRITEBACK, -nr);
 		bdi_wb_stat_mod(folio->mapping->host, WB_WRITEBACK, -nr);
@@ -889,7 +891,7 @@ static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
 			nfs_request_remove_commit_list(req, cinfo);
 		}
 		mutex_unlock(&NFS_I(inode)->commit_mutex);
-		nfs_folio_clear_commit(nfs_page_to_folio(req));
+		nfs_folio_clear_commit(req);
 	}
 }
 
@@ -1741,7 +1743,7 @@ void nfs_retry_commit(struct list_head *page_list,
 		req = nfs_list_entry(page_list->next);
 		nfs_list_remove_request(req);
 		nfs_mark_request_commit(req, lseg, cinfo, ds_commit_idx);
-		nfs_folio_clear_commit(nfs_page_to_folio(req));
+		nfs_folio_clear_commit(req);
 		nfs_unlock_and_release_request(req);
 	}
 }
@@ -1813,7 +1815,7 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 		req = nfs_list_entry(data->pages.next);
 		nfs_list_remove_request(req);
 		folio = nfs_page_to_folio(req);
-		nfs_folio_clear_commit(folio);
+		nfs_folio_clear_commit(req);
 
 		dprintk("NFS:       commit (%s/%llu %d@%lld)",
 			nfs_req_openctx(req)->dentry->d_sb->s_id,

