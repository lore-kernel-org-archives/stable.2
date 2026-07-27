Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECBC73B42C2
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 15:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785166859; cv=none; b=cDfdkJoSQZeoGyWI5LrXLsUJT49eChsL5QIv6DI2G1U1bVQIL0ddfaetk9pesxzyzGu8inMJGjgcuobDzgAx5HtaoZWVKGEQbh+mjUoVWPTTNGqazzU19mTTHhB5CBe5V7OBN3S/uSsOBKrf3pxG/WN01Bh3BgSgeD1DoMZD+9w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785166859; c=relaxed/simple;
	bh=TJ4y5Bw9Q4fFgkN+wwF1zqGPOXXz1dHvbVUYoTV4WpM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ARgyp5TLh1GF1Ouc91GEMNjY4Fjx3w8siXEJRTVTEclH425inyhOHKLWNpGQ5Ut5DJIUdiBIs/X7bBeuoXQD5JWsourv1aOOrDTV2LuUr2cxJtNIy0pWXO4RtWrOtn6DPlSJ1AFPyLZPUpmeWD5zbg3Sggv9iLwQV3RIzGWO7rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PlCzKsYj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PlCzKsYj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 120A31F00A3D;
	Mon, 27 Jul 2026 15:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785166857;
	bh=dY/XuC/Vna5UUu7RsEII3o8XtpwvWt46txn/0ugDw9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PlCzKsYjyETGCwpwnN6UB2z/8BGOBw+2sP5z4/S/Ih1tPl27mNPCegfHhV8BRLkLB
	 OjEsva/FuIi27Tnu1ABDyPY59xLjCNi6PDvMATqOLl1RFCrWcrGkXQCGxf5hl2l35s
	 tpiSerkUOC0MKRszRAvZHM8AdMKZGVg8JGBLaxY1KobmNhCARWWCUFg88DS6sSBEtY
	 IV44qemOkWO3olNgflEPHwKr0Le6szllQfQ22oyzsD5P8a5i9Y1iYFPtbfJbHKsb+C
	 YC5GmN20f+lZ7olkd1/kDX7z2Ge4FBgLssGkIdDV/xc39duefUF0NvaYyruE3rV766
	 RxCR1CS5wo9Ug==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Benjamin Coddington <ben.coddington@hammerspace.com>,
	Benjamin Coddington <bcodding@hammerspace.com>,
	Claude Sonnet 5 <noreply@anthropic.com>,
	Anna Schumaker <anna.schumaker@hammerspace.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] NFS: Charge unstable writes by request size, not folio size
Date: Mon, 27 Jul 2026 11:40:54 -0400
Message-ID: <20260727154054.1513904-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727154054.1513904-1-sashal@kernel.org>
References: <2026072039-unheard-expand-767d@gregkh>
 <20260727154054.1513904-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Benjamin Coddington <ben.coddington@hammerspace.com>

[ Upstream commit 27934d02cbeb8a957dd11c985a579e58d30c5270 ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nfs/internal.h | 12 +++++++-----
 fs/nfs/pnfs_nfs.c |  2 +-
 fs/nfs/write.c    | 14 ++++++++------
 3 files changed, 16 insertions(+), 12 deletions(-)

diff --git a/fs/nfs/internal.h b/fs/nfs/internal.h
index a76daeaa4a567b..1ab81d639d5c3a 100644
--- a/fs/nfs/internal.h
+++ b/fs/nfs/internal.h
@@ -784,17 +784,19 @@ void nfs_super_set_maxbytes(struct super_block *sb, __u64 maxfilesize)
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
index 698d4d64c6b641..4f343dd1e65bb0 100644
--- a/fs/nfs/pnfs_nfs.c
+++ b/fs/nfs/pnfs_nfs.c
@@ -1226,7 +1226,7 @@ pnfs_layout_mark_request_commit(struct nfs_page *req,
 
 	nfs_request_add_commit_list_locked(req, list, cinfo);
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
-	nfs_folio_mark_unstable(nfs_page_to_folio(req), cinfo);
+	nfs_folio_mark_unstable(req, cinfo);
 	return;
 out_resched:
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
diff --git a/fs/nfs/write.c b/fs/nfs/write.c
index dc57e67cefcd18..85426764017cef 100644
--- a/fs/nfs/write.c
+++ b/fs/nfs/write.c
@@ -933,7 +933,7 @@ nfs_request_add_commit_list(struct nfs_page *req, struct nfs_commit_info *cinfo)
 	mutex_lock(&NFS_I(cinfo->inode)->commit_mutex);
 	nfs_request_add_commit_list_locked(req, &cinfo->mds->list, cinfo);
 	mutex_unlock(&NFS_I(cinfo->inode)->commit_mutex);
-	nfs_folio_mark_unstable(nfs_page_to_folio(req), cinfo);
+	nfs_folio_mark_unstable(req, cinfo);
 }
 EXPORT_SYMBOL_GPL(nfs_request_add_commit_list);
 
@@ -992,10 +992,12 @@ nfs_mark_request_commit(struct nfs_page *req, struct pnfs_layout_segment *lseg,
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
 		wb_stat_mod(&inode_to_bdi(folio_file_mapping(folio)->host)->wb,
@@ -1016,7 +1018,7 @@ static void nfs_clear_request_commit(struct nfs_commit_info *cinfo,
 			nfs_request_remove_commit_list(req, cinfo);
 		}
 		mutex_unlock(&NFS_I(inode)->commit_mutex);
-		nfs_folio_clear_commit(nfs_page_to_folio(req));
+		nfs_folio_clear_commit(req);
 	}
 }
 
@@ -1834,7 +1836,7 @@ void nfs_retry_commit(struct list_head *page_list,
 		req = nfs_list_entry(page_list->next);
 		nfs_list_remove_request(req);
 		nfs_mark_request_commit(req, lseg, cinfo, ds_commit_idx);
-		nfs_folio_clear_commit(nfs_page_to_folio(req));
+		nfs_folio_clear_commit(req);
 		nfs_unlock_and_release_request(req);
 	}
 }
@@ -1902,7 +1904,7 @@ static void nfs_commit_release_pages(struct nfs_commit_data *data)
 		req = nfs_list_entry(data->pages.next);
 		nfs_list_remove_request(req);
 		folio = nfs_page_to_folio(req);
-		nfs_folio_clear_commit(folio);
+		nfs_folio_clear_commit(req);
 
 		dprintk("NFS:       commit (%s/%llu %d@%lld)",
 			nfs_req_openctx(req)->dentry->d_sb->s_id,
-- 
2.53.0

