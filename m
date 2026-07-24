Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDFFF42376B
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 10:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784890155; cv=none; b=FSqvAnx8afoClrKpebzMS+a5i6np9nTfVvdtH+kfZku2GMkYVt/yBdayotISpJBdtxPuHyPd0Ivqq4vQh+HgAHrC7odp4DSWRqJYtcod3LPj7X/pOZ37LVgVMbRgJKR9X6twmONUcoOdJjoRA06KK7MIH9IIsHM3szl8oCbOyk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784890155; c=relaxed/simple;
	bh=ntZbjpQkuKbwb0+LW1GtnHGAe2WsRRHeaXC5rGkd6yQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=E8ydwtABEt0YU/aSPuP+9O+t7hIIBS6XDlb6d4dQPqfLvYbdjyC8eZD5isY6i98GJBskbX9MheGVBW/MnJUJRSfqzsWLSjC/0TlSoVs4/pKePOZIe8NdpxyRSB1jKPtqc37vA+4F81pzBWdGJun6nS7CSxamLAfKH++4WHzDi0M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ti3enx4B; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ti3enx4B"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26C701F00A3D;
	Fri, 24 Jul 2026 10:49:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784890153;
	bh=kFnbIgpqVojG+69ZopYmlBCnGwaDoF5mbIKj5W++fk4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Ti3enx4BSjdywIpUIKyUjcYvngM8GuutGV77UpAXoH6O6s1ZriYgnOgrES9pSKRB5
	 1ACjfZ16oA7Peh1BdGaPB44PYQjd8uQlilR2J5aT7Dq9ek9GkpB2BwDCNelAiPdzFF
	 0EKxLygiK70iFeJnCC/gU4Xy2FXRlOwKN3Eo0G19Nme55B7tgPiU03kpq0b7xYbujB
	 D5I3jfFHOFgQ0Bys/iTZVK5BQhVVb7qxTZWwHlOTGkMTMd+ypcuMjeUlCqLW4r7Zyg
	 pmY9vQqtXHX35LDWgODKKX3BUV6uSlMHw/j3LaQ7O8eczyk0wO/BFWLuUpHoJF6eEy
	 Uzcg3Xm/Wf+fw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] fs/ntfs3: Undo critial modificatins to keep directory consistency
Date: Fri, 24 Jul 2026 06:49:10 -0400
Message-ID: <20260724104911.3974416-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072048-smudge-reselect-d44b@gregkh>
References: <2026072048-smudge-reselect-d44b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>

[ Upstream commit 63e92a0c5a0d5816803907a3e30a91ef72c903a5 ]

Affect xfstest 320.

Signed-off-by: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>
Stable-dep-of: f1df9d771df4 ("ntfs3: validate split-point offset in indx_insert_into_buffer")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/index.c | 30 ++++++++++++++++++++----------
 1 file changed, 20 insertions(+), 10 deletions(-)

diff --git a/fs/ntfs3/index.c b/fs/ntfs3/index.c
index 8ceef90ee5a50a..e801bf16854de9 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1796,10 +1796,11 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	struct indx_node *n1 = fnd->nodes[level];
 	struct INDEX_HDR *hdr1 = &n1->index->ihdr;
 	struct INDEX_HDR *hdr2;
-	u32 to_copy, used;
+	u32 to_copy, used, used1;
 	CLST new_vbn;
 	__le64 t_vbn, *sub_vbn;
 	u16 sp_size;
+	void *hdr1_saved = NULL;
 
 	/* Try the most easy case. */
 	e = fnd->level - 1 == level ? fnd->de[level] : NULL;
@@ -1832,6 +1833,13 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		return -ENOMEM;
 	memcpy(up_e, sp, sp_size);
 
+	used1 = le32_to_cpu(hdr1->used);
+	hdr1_saved = kmemdup(hdr1, used1, GFP_NOFS);
+	if (!hdr1_saved) {
+		err = -ENOMEM;
+		goto out;
+	}
+
 	if (!hdr1->flags) {
 		up_e->flags |= NTFS_IE_HAS_SUBNODES;
 		up_e->size = cpu_to_le16(sp_size + sizeof(u64));
@@ -1864,7 +1872,7 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	hdr_insert_head(hdr2, de_t, to_copy);
 
 	/* Remove all entries (sp including) from hdr1. */
-	used = le32_to_cpu(hdr1->used) - to_copy - sp_size;
+	used = used1 - to_copy - sp_size;
 	memmove(de_t, Add2Ptr(sp, sp_size), used - le32_to_cpu(hdr1->de_off));
 	hdr1->used = cpu_to_le32(used);
 
@@ -1894,8 +1902,6 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (!level) {
 		/* Insert in root. */
 		err = indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd, 0);
-		if (err)
-			goto out;
 	} else {
 		/*
 		 * The target buffer's parent is another index buffer.
@@ -1903,12 +1909,20 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 */
 		err = indx_insert_into_buffer(indx, ni, root, up_e, ctx,
 					      level - 1, fnd);
-		if (err)
-			goto out;
+	}
+
+	if (err) {
+		/*
+		 * Undo critical operations.
+		 */
+		indx_mark_free(indx, ni, new_vbn >> indx->idx2vbn_bits);
+		memcpy(hdr1, hdr1_saved, used1);
+		indx_write(indx, ni, n1, 0);
 	}
 
 out:
 	kfree(up_e);
+	kfree(hdr1_saved);
 
 	return err;
 }
@@ -1967,16 +1981,12 @@ int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
 		 */
 		err = indx_insert_into_root(indx, ni, new_de, fnd->root_de, ctx,
 					    fnd, undo);
-		if (err)
-			goto out;
 	} else {
 		/*
 		 * Found a leaf buffer, so we'll insert the new entry into it.
 		 */
 		err = indx_insert_into_buffer(indx, ni, root, new_de, ctx,
 					      fnd->level - 1, fnd);
-		if (err)
-			goto out;
 	}
 
 out:
-- 
2.53.0

