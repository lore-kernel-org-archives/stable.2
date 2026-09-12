Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1CFC41F35E
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:17:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211831; cv=none; b=U8X+0hSk5bbIi/n0O4vAONiXpL6b5CUoHSTj1xTnoHC2B0D1YjfhHkQO3a2PCfWJvAX3rFLcAXefxriTGS8eRslKDx3o0NQRsHDJc9yXxdps8O8CxIPufqlLGnMl8jTT09a7p97SOw8CJ/1Ws3LvWlLAsf9yJd2IWPKhklV5X7I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211831; c=relaxed/simple;
	bh=Wb669/3zg3R0JTrBG36MAppI/iDMr6N3rlMRF+g0Ons=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YOvhXvaRhd0mI0jYcMRarbLFj1aVKV+KbXEPFDSba7LSi+HlK6b+7qMg2Q2piXn6kCpsUvF/duns9wILtAlAGIYlvValAte4/ZOIcr291tsDUcuirRMA5NtIiRB/B3TiOfolS2zFdjxB4JfA3c6kPGdoiQ95mPXoED4mUDMlWBk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MdgSidKS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MdgSidKS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09E2D1F0089B;
	Sat, 12 Sep 2026 11:17:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211830;
	bh=tBCnmmJxTkeSqPDCZkxGHt1sriOz8vL3LAQ7QsNMsXw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MdgSidKSWN6Nf29r3zEUQTz96yHrHEwy4pjBMpKbKIH7umzmu5AAI0C2t5lJK6bul
	 d92moKq13p3xV5DKvgFwRck8TLyCNEdLsg9odgv8Di8dJwx4/FKmSzG/FHyEP8UrUN
	 u8bWuG7CLInQ5h9d0YN1WE+LCZa5eF4as6Nb+udIT3viTojryYAl40l5sPq8oMxuGk
	 uMum6NIiTlWMFosZx+DHVhpprwK64J+Q0cjJZcP4Q+5P7pKX7TDTpln2NEyyAM6BLn
	 SLihKJW9fvNiERVUvaTSD7oAAABLReTlSZ89RPmK9PqWSPKTeDnSR9f078654em/Sw
	 9btEjzan85v6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/6] f2fs: Use a folio in truncate_nodes()
Date: Sat, 12 Sep 2026 07:17:03 -0400
Message-ID: <20260912111706.2282608-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912111706.2282608-1-sashal@kernel.org>
References: <2026090957-spectacle-juniper-fbdf@gregkh>
 <20260912111706.2282608-1-sashal@kernel.org>
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
index 0aff16c5e1b5d..c0de044fac304 100644
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

