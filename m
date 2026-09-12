Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1543F471D03
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:17:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789211833; cv=none; b=qvKtoyH7M+JNkKY0VOMjGJ14liRWEBFOe2SC+5Bvk/58i+/3lT7huDz+iyB5IYQ8+iaRSr1IZB81lFAkT3U3bhFbAnKGkDO26cbS0sf/lgCXDaq/wo7oTrTyn5jrD/d9oEj1Vc/iUh+YiHzokMguzsHMY3UGRlspk95i0F6OBrY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789211833; c=relaxed/simple;
	bh=9TeHeI71b3vmnTzGPR5ZI5wyv1dfHjk8ImBGGzjhhCg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h0KynMQ/MRfvnASOqtO6LOvTevn8NWH7eatQvAlZx1TCttz0EQm35fnkTjbkVziQJvORx7mhm7xABeQRJr8uRNLIX4RfpgmsDwsm2mzoK9IC9iSf+HeHdnmQWm+QNsO+lAxHNeyNv/h5yB3IksUORV7Yb6QtqvJAbWOulIS02cQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RRxzfWWx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RRxzfWWx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA67C1F00893;
	Sat, 12 Sep 2026 11:17:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789211831;
	bh=g9GAzUI/RrAZp7jTb78MmVaKj4uehWZjXmDER5QnoDQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RRxzfWWxYVdnQZT6nBgi+BseN0xPRrIbd1yzsCd8XhIpAr3Bv6QYABY6E0vrcd2Wu
	 x1OsajZ8lbDe/D2k+gG+jUom9dVMrmAUSXtkWitO2y/ZabTwMaDJN/3RiO9rz7GsD7
	 aQ4dJn57nhe+p0hFSFEdALThDb59bohwES8QLBJYiprk7hk+vlSOret9zaehBkyUcm
	 IZ7ZKJ/iwRW/Uf15USCq5XhMx+qOC00F9XotS4/VBTWP8FhrKDTcJPoH8fJjvMBytB
	 mTpQC6Yl3DVCxm62puwrg9JueurNjBIRUQ1O6PduumtaUDxwqxkafv6VPSJuJHxFvX
	 BzCOQwoXf00DQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 4/6] f2fs: Use folios in truncate_partial_nodes()
Date: Sat, 12 Sep 2026 07:17:04 -0400
Message-ID: <20260912111706.2282608-4-sashal@kernel.org>
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
index c0de044fac304..b6a57d3706722 100644
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

