Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 69D2E3B42C1
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 11:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784891106; cv=none; b=GfBoQN52y9YDesVfwHPb5QWAwAGfD91Lf3gV0sL7p5V0FzQYGbWj7yqlDpHiJZkkDpJOxy2A3gAHU+xzVve8fCpxRtm09PXzc8awGlWG5EuqV/c4OfxgI3YlxErD/xI/sf6uFdnX1mr3F5XjXidUmQt4r4yCLeRTh3L//RJvwBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784891106; c=relaxed/simple;
	bh=k9Aja8B3EF6r2nbE8S0nkwVk7JFxiOQgAXeyHRa7FJ8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Dtbxhjza/U4MLbdsBc+vtNGdAllyoqFlCt/f8ssLEsGxcOVU51F5qVelcVfHYQGH3aAJDqKibI+EALX4HUCZfIGluJTVRoVyngrX5kNnTFapXG6aiALEBYeKC568JkIE0Xst7LKpHuj8qgdfrooEyB4XZ66TXYlDCjzM6eXttWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i76mDywO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i76mDywO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03BAD1F031CC;
	Fri, 24 Jul 2026 11:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784891103;
	bh=cNJH54wzmBcFeKjuY5sFnI1j3oMPETX4+cATFmO6lg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=i76mDywOlWDnECvGyOl5vRFEC23BSkS2ROGnKlouJJm69QnT314xfqKSh88qBMklE
	 Y0Fa4/mF4vojSWMfqCBUahaGfo/c8VAUj/pecGP0A1WMi/B46cezswmcVqXt1+AFKs
	 5iDoPbCgTc2vKZDhifFP1KaE3UXH0g/OdSQEL+gZSMand7nlLGmH05VWPOHhWA/7/x
	 tXNxuNJtfv9CQ0MZgPk4vQZGlFMAPDqtgoxMjurdIYqKAY7HS7kEjI3ZEDgxpDcney
	 rqvofEes0qW14s0ZLLkm4WWhHaTk4C2GO7A6gC00zti8Asb9Yi/RWR+vfT8Mz/cnic
	 /us+7PuLmqKlw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] fs/ntfs3: Undo critial modificatins to keep directory consistency
Date: Fri, 24 Jul 2026 07:00:57 -0400
Message-ID: <20260724110058.3984551-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026072049-legroom-strode-957e@gregkh>
References: <2026072049-legroom-strode-957e@gregkh>
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
index b0aa5cc63b5079..80fc3f61f81484 100644
--- a/fs/ntfs3/index.c
+++ b/fs/ntfs3/index.c
@@ -1803,10 +1803,11 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
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
@@ -1839,6 +1840,13 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
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
@@ -1871,7 +1879,7 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	hdr_insert_head(hdr2, de_t, to_copy);
 
 	/* Remove all entries (sp including) from hdr1. */
-	used = le32_to_cpu(hdr1->used) - to_copy - sp_size;
+	used = used1 - to_copy - sp_size;
 	memmove(de_t, Add2Ptr(sp, sp_size), used - le32_to_cpu(hdr1->de_off));
 	hdr1->used = cpu_to_le32(used);
 
@@ -1901,8 +1909,6 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
 	if (!level) {
 		/* Insert in root. */
 		err = indx_insert_into_root(indx, ni, up_e, NULL, ctx, fnd, 0);
-		if (err)
-			goto out;
 	} else {
 		/*
 		 * The target buffer's parent is another index buffer.
@@ -1910,12 +1916,20 @@ indx_insert_into_buffer(struct ntfs_index *indx, struct ntfs_inode *ni,
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
@@ -1974,16 +1988,12 @@ int indx_insert_entry(struct ntfs_index *indx, struct ntfs_inode *ni,
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

