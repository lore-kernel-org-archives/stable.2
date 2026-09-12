Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADCFC337BBD
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176748; cv=none; b=E8Ywq30dCdj9T5l6uTWq1xJow6dimCs1lvgBO5stOPG0BxRRKtNzR/g1gxvM8nKbMvjH37TvzgAdkQ33WrXugzjMG3mxHNNZrlpD9iDhASNXOS1ASd95s4CjZWJeBPcLL5+EgUYMOuEZdPFDuBE9sr8spP+3a+NrfgqqPfNjBKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176748; c=relaxed/simple;
	bh=Bkyf17tsZrcwHE9ERya5S2PIMbVoayhJgKTPthHM0OE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tn5DW6zexD3Bv7SUsNS3I8o2ONRovw71P1kbL8V6D8ROW57/Unh/wdW+9i20cMbuOx3evE9bbXAbXgFl+Ol+Ut8criTNs59irIP93OAQbCoqCUOTAoAyi92cEVGzpavkeNDPmybJvoi4PZFLvPzhn5FxAFnact3PeLB4uZjYZKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LU9Yhz2w; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LU9Yhz2w"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B2281F000FF;
	Sat, 12 Sep 2026 01:32:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176747;
	bh=39IcuwOQyzyBVWWi43PkaMrx5IIN6nLEpBCkfpTHbxM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LU9Yhz2wkR6RB3d6dMAqiZma1hthhqN9hZySh5nwbIH7B+dxd15Z0mnj+Q3PtcGga
	 A8zMRiFMIfkbh7SRJzhhj09mzakanZ0XhCMamzoPSn+/8tnBFf1dKznHakIDWPZXG5
	 Y4bdof1U/48jiDoqkXUFwvhr6lXGjdO7vuX82U+QesfzuMOx0pNx4YNQJ5L6vcAlKK
	 zNZKd91fuT43m/s98ixpmpiXZhCKUvGxjTXxnoZ9DGMvjvLdVoNZSN2kpUi7BGOl1Q
	 tmvg0I+lp+dCj3hIn9k6QLwCcZWoSU49vlZSANdYxn5TXV0MnnIN5/+1ZhlXymPOmf
	 cBm3BxL19cJ6Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/7] f2fs: Use folios in truncate_partial_nodes()
Date: Fri, 11 Sep 2026 21:32:20 -0400
Message-ID: <20260912013222.1762882-5-sashal@kernel.org>
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

[ Upstream commit d68833a0b74e46edc678340cdff5ad22782c6609 ]

Removes two calls to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: ce366bfa821e ("f2fs: fix to avoid potential deadloop in f2fs_fsync_node_pages()")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/node.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 5fe77be55998d..1463488fcd832 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1074,7 +1074,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 static int truncate_partial_nodes(struct dnode_of_data *dn,
 			struct f2fs_inode *ri, int *offset, int depth)
 {
-	struct page *pages[2];
+	struct folio *folios[2];
 	nid_t nid[3];
 	nid_t child_nid;
 	int err = 0;
@@ -1088,45 +1088,45 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
 	/* get indirect nodes in the path */
 	for (i = 0; i < idx + 1; i++) {
 		/* reference count'll be increased */
-		pages[i] = f2fs_get_node_page(F2FS_I_SB(dn->inode), nid[i]);
-		if (IS_ERR(pages[i])) {
-			err = PTR_ERR(pages[i]);
+		folios[i] = f2fs_get_node_folio(F2FS_I_SB(dn->inode), nid[i]);
+		if (IS_ERR(folios[i])) {
+			err = PTR_ERR(folios[i]);
 			idx = i - 1;
 			goto fail;
 		}
-		nid[i + 1] = get_nid(pages[i], offset[i + 1], false);
+		nid[i + 1] = get_nid(&folios[i]->page, offset[i + 1], false);
 	}
 
-	f2fs_ra_node_pages(pages[idx], offset[idx + 1], NIDS_PER_BLOCK);
+	f2fs_ra_node_pages(&folios[idx]->page, offset[idx + 1], NIDS_PER_BLOCK);
 
 	/* free direct nodes linked to a partial indirect node */
 	for (i = offset[idx + 1]; i < NIDS_PER_BLOCK; i++) {
-		child_nid = get_nid(pages[idx], i, false);
+		child_nid = get_nid(&folios[idx]->page, i, false);
 		if (!child_nid)
 			continue;
 		dn->nid = child_nid;
 		err = truncate_dnode(dn);
 		if (err < 0)
 			goto fail;
-		if (set_nid(pages[idx], i, 0, false))
+		if (set_nid(&folios[idx]->page, i, 0, false))
 			dn->node_changed = true;
 	}
 
 	if (offset[idx + 1] == 0) {
-		dn->node_page = pages[idx];
+		dn->node_page = &folios[idx]->page;
 		dn->nid = nid[idx];
 		err = truncate_node(dn);
 		if (err)
 			goto fail;
 	} else {
-		f2fs_put_page(pages[idx], 1);
+		f2fs_folio_put(folios[idx], true);
 	}
 	offset[idx]++;
 	offset[idx + 1] = 0;
 	idx--;
 fail:
 	for (i = idx; i >= 0; i--)
-		f2fs_put_page(pages[i], 1);
+		f2fs_folio_put(folios[i], true);
 
 	trace_f2fs_truncate_partial_nodes(dn->inode, nid, depth, err);
 
-- 
2.53.0

