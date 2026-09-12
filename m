Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F05A4766BB
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 11:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789212090; cv=none; b=H5YkidpuV1ZBxW9jH4ZRtIcXOX5p1C14ZWjPNNwSjzTqeC357UwgwACnbi1x27H3t+QurGhL7QT+k3VIvFsBt/F1NV9OztlNjjUbCOEHaiSyXNxoIL88bxgjIyGvUT5qNx6ch/g1aMFstKIXF9XU79dKrYAGuJ7hFxDn+kl5HyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789212090; c=relaxed/simple;
	bh=7yb10EzJSCOOJj4xNT91h7kjoxGDOj9BT70ZDWoK278=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=aNbkTP/LjAsHwbzcyRE7kme8odeZDjmcPycGU+13QvqhtYUunJ0ivymEnvY5yjyDiMeWHbttjNbd4pD5p3Mb7U2+QwO1CInYOuFP29Q82I0GNpcEY2ot8+gO1e/NOEy1SQHgge3vgWEWU89h4+i7nwVffLbxFBaNIFzDAEHcv14=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bDMLmUYJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bDMLmUYJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F19441F0089B;
	Sat, 12 Sep 2026 11:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789212089;
	bh=eOgR8CwEvnY64q1hojtEndzP/4pUEQ+3/kalgMXn6AI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bDMLmUYJsWHWj0zv+Rs2r/oGknT7jpi+e5e9oOQPEp3woaEnYZ7fV29XPlwVwOvF7
	 +Q9q0rXfsqpO0mOZAoypYW8pfoaVx7DvwuGuRzpXJi1j+BpHrhdmSmV2NMojOtk1qA
	 4qs8qluyGou6ge1DYbukoKJe4R/1EVAyWVrWh3J0tJW/Rq+GfrG+T3Jr6GkESvMYIa
	 jCyZMQzBN6c9Uj3erWEFVbJ/88M617n9TU0te+uB05r/mDz0UcvwdKKbbCub1gXuoP
	 kvhlDuEPgbFSzkZiWppuU24XSFM+u2c5CJ86hXlaUd2Lrn031MJ4BaFT7f27zCrjv6
	 Vj12Idf8VmvYw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/6] f2fs: Use folios in truncate_partial_nodes()
Date: Sat, 12 Sep 2026 07:21:22 -0400
Message-ID: <20260912112124.2312624-4-sashal@kernel.org>
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
index 236f4644f62e0..9df3e8fb23089 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -1052,7 +1052,7 @@ static int truncate_nodes(struct dnode_of_data *dn, unsigned int nofs,
 static int truncate_partial_nodes(struct dnode_of_data *dn,
 			struct f2fs_inode *ri, int *offset, int depth)
 {
-	struct page *pages[2];
+	struct folio *folios[2];
 	nid_t nid[3];
 	nid_t child_nid;
 	int err = 0;
@@ -1066,45 +1066,45 @@ static int truncate_partial_nodes(struct dnode_of_data *dn,
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

