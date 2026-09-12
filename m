Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BAB47124F
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212090; cv=none; b=XKm+e+/CNa9i0uxJedSIgL7ikyzv162ilXgZgTRqdmtoKLwpbiDFYzDqvPRG/eBStGu6SIUPKyq6x3YZDm0ol86DT/jBGQTEOnqqgc9ZpfLnGYyVd9Rv7y6EAo7PC9dq1zaK53eM9Ahv8zocGZ6HybDV6RdiZ3CDPWr8MZS21ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212090; c=relaxed/simple;
	bh=1avB98ErffPu1kuNhj9x5w+qBJufN+eTlhMWwxpROpA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TEbRDsn7ibuys85NFHxWYf0/8iq8tLh8GcHjAkbeb2oP8oA9HhgmK1iM6+FJo1XprXVgp69DnnGDIL/KtJm0EK71dblsc0RvxEzgJr4f74h0dVdeZ3LflR0uGJr15asoTXMxBbAhhAhiGEfR+yhBiqo8d4/fxMy8cnoQNvzWujY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hHiouUmI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hHiouUmI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21CD61F00893;
	Sat, 12 Sep 2026 11:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789212088;
	bh=V5dkz5AqOTDROGuEde/U/NseKVLR+j9HfXGB1KYrpJw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hHiouUmIgxvP8pFo5JfZY4Lhkx4R1pqR9IBdsFKSZ3/dtwuBCcTnWzBAEKBtt4EaL
	 QH8YXJ2RlKAqHV/dJNl6LySYTs+OZ5XUd7qeGB1XV2eNjl43CpbzAy505eZNbVgQXN
	 MkbrY19oZ+k//jf3QxMXTgq2r/ga0wcdTYoIUgs/D1LlJncJTsxD/ZA75xbDPASgUC
	 b2sKhyXuzxuLUykQwcGmzihAiUMAdwVuftqY/6MOxnW8dtis+yGaoMuvqvfxxjYXeK
	 HEo1EhcYX99NOSs3QZEmc7d6Ogut17/qRLsl+kibjBA0+80xza62BXzUIsM8tAYpGj
	 GjCBy/8imb9xg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 3/6] f2fs: Use a folio in truncate_nodes()
Date: Sat, 12 Sep 2026 07:21:21 -0400
Message-ID: <20260912112124.2312624-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260912112124.2312624-1-sashal@kernel.org>
References: <2026090958-headband-sturdy-0f93@gregkh>
 <20260912112124.2312624-1-sashal@kernel.org>
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
index c7696b7ad4dce..236f4644f62e0 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -976,7 +976,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 						int ofs, int depth)
 {
 	struct dnode_of_data rdn = *dn;
-	struct page *page;
+	struct folio *folio;
 	struct f2fs_node *rn;
 	nid_t child_nid;
 	unsigned int child_nofs;
@@ -988,15 +988,15 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 
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
@@ -1006,7 +1006,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			ret = truncate_dnode(&rdn);
 			if (ret < 0)
 				goto out_err;
-			if (set_nid(page, i, 0, false))
+			if (set_nid(&folio->page, i, 0, false))
 				dn->node_changed = true;
 		}
 	} else {
@@ -1020,7 +1020,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 			rdn.nid = child_nid;
 			ret = truncate_nodes(&rdn, child_nofs, 0, depth - 1);
 			if (ret == (NIDS_PER_BLOCK + 1)) {
-				if (set_nid(page, i, 0, false))
+				if (set_nid(&folio->page, i, 0, false))
 					dn->node_changed = true;
 				child_nofs += ret;
 			} else if (ret < 0 && ret != -ENOENT) {
@@ -1032,19 +1032,19 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 
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

