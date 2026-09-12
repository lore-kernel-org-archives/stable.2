Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA0A9336EC0
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176748; cv=none; b=TKE3wOe5KqOHOze/Limm+tlrhb5RiIYEhUXGCNGC5h1rr30n5a5tS8fwe3IVQMI5KeI6lMSEnRa8T/+7LSJkfDL9KC29jSkhrxuzNqvo1lkP1TR+WFb26EU1diRUQponRsGTMNaqqjj93/re2e5sWzDsXeLMn5zemQeH4UUj/5k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176748; c=relaxed/simple;
	bh=mKZ7Uu4Ax66iH3nMP1oiqwFDEqTCxuUq5c5foeiIUPs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UyPl2aT6tAmOtOm9d/PiPrn4Qz/DpfG71IsDckLjgSIwZNgdL/R3dqdAuCA1v0Gsd8WqAAcoX7NfOXX1dGSnWNNIseDHbOF1ZsrL+LqTFYTr7VD2z9kXoHupedltBjFb2eLyxB0/OAShFvHkwjCzeWe+Z/NBLhVKIS6YAaOJgYE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dorLpDz+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dorLpDz+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36EC71F0089A;
	Sat, 12 Sep 2026 01:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176746;
	bh=yl89cJlow2xgfbd3LcmrMYP1G+6hFv457GymtUKt2T4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=dorLpDz+/ZJNugRsLcEx+ZjtHQtLDHd32Mz7PW1Z/XjVwapIqj3CEceoj+rYdB0Oq
	 FF5CjgoBzdo+sDqykpdbu9zuMnzJ2y0SxDSh+wR6Fm++pkK8la8UBfwdNoatwaL6Sc
	 SFg50ga62EYoeMas9JE5HtSjdNxavCF79BtxX3F5tim+XHAAFJ7mITr7+Z6zAaI1Ak
	 Id3j7RdOh5g9bZcz51l83zEmCPDDT37y2Qc2l+YdaY4mJWJa1PCD/Al17pDkb72O9k
	 pRsyP5EtrId79+jWPSP7IqPjmSDCn9QGDJ2ghdW48TMlcztsl5IOyqGhghxP4/ihML
	 SI2GqB5ukg0lg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 4/7] f2fs: Use a folio in truncate_nodes()
Date: Fri, 11 Sep 2026 21:32:19 -0400
Message-ID: <20260912013222.1762882-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912013222.1762882-1-sashal@kernel.org>
References: <2026090957-stoke-condense-f9b1@gregkh>
 <20260912013222.1762882-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit 878a05b09c0c578b679956431cd2be5cc3689403 ]

Remove two calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: ce366bfa821e ("f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index cce67bfbac59d..5fe77be55998d 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -998,7 +998,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 						int ofs, int depth)
 {
 	struct dnode_of_data rdn = *dn;
-	struct page *page;
+	struct folio *folio;
 	struct f2fs_node *rn;
 	nid_t child_nid;
 	unsigned int child_nofs;
@@ -1010,15 +1010,15 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 
 	trace_f2fs_truncate_nodes_enter(dn->inode, dn->nid, dn->data_blkaddr);
 
-	page = f2fs_get_node_page(F2FS_I_SB(dn->inode), dn->nid);
-	if (IS_ERR(page)) {
-		trace_f2fs_truncate_nodes_exit(dn->inode, PTR_ERR(page));
-		return PTR_ERR(page);
+	folio = f2fs_get_node_folio(F2FS_I_SB(dn->inode), dn->nid);
+	if (IS_ERR(folio)) {
+		trace_f2fs_truncate_nodes_exit(dn->inode, PTR_ERR(folio));
+		return PTR_ERR(folio);
 	}
 
-	f2fs_ra_node_pages(page, ofs, NIDS_PER_BLOCK);
+	f2fs_ra_node_pages(&folio->page, ofs, NIDS_PER_BLOCK);
 
-	rn = F2FS_NODE(page);
+	rn = F2FS_NODE(&folio->page);
 	if (depth < 3) {
 		for (i = ofs; i < NIDS_PER_BLOCK; i++, freed++) {
 			child_nid = le32_to_cpu(rn->in.nid[i]);
@@ -1028,7 +1028,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			ret = truncate_dnode(&rdn);
 			if (ret < 0)
 				goto out_err;
-			if (set_nid(page, i, 0, false))
+			if (set_nid(&folio->page, i, 0, false))
 				dn->node_changed = true;
 		}
 	} else {
@@ -1042,7 +1042,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			rdn.nid = child_nid;
 			ret = truncate_nodes(&rdn, child_nofs, 0, depth - 1);
 			if (ret == (NIDS_PER_BLOCK + 1)) {
-				if (set_nid(page, i, 0, false))
+				if (set_nid(&folio->page, i, 0, false))
 					dn->node_changed = true;
 				child_nofs += ret;
 			} else if (ret < 0 && ret != -ENOENT) {
@@ -1054,19 +1054,19 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 
 	if (!ofs) {
 		/* remove current indirect node */
-		dn->node_page = page;
+		dn->node_page = &folio->page;
 		ret = truncate_node(dn);
 		if (ret)
 			goto out_err;
 		freed++;
 	} else {
-		f2fs_put_page(page, 1);
+		f2fs_folio_put(folio, true);
 	}
 	trace_f2fs_truncate_nodes_exit(dn->inode, freed);
 	return freed;
 
 out_err:
-	f2fs_put_page(page, 1);
+	f2fs_folio_put(folio, true);
 	trace_f2fs_truncate_nodes_exit(dn->inode, ret);
 	return ret;
 }
-- 
2.53.0

