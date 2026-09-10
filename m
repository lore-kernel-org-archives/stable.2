Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 040373624A9
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:17:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003044; cv=none; b=oXbhcNCV8iaKevL8i/WrggV2S+PzKhpexxwoOMCOOl1lx47tlu23EgtQNoonTgJt/ZAqipPMJrYPqmfLmkYSLdtxQs3jSNWNKAbcCqzYoACvIG6R4XP0hSf5q/KQ3ZLFB5oTJNCpDTV316AoWWC1TAau6GESKSpLRP6w2c+wywc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003044; c=relaxed/simple;
	bh=/EP5vB3k6tI+ECNLhY0TjnbY5Ng4zYR3B8ZQZMlw82o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=m5gf312LQJNH4dujchk7loxjfj2a5pdPWGKLdhkAGSYf06OGc1dfJ8S6Uh5xvIqG4lRzfkqL9hzGe7bKiE7ypmg1fLvXnTdCPMVkMgkbV5zP5Ha5iR7CV3xaoBrscEc3aT2sKTMbiiOrOFB92gNAHTXHiNj/TbRUzW1qgWnjAYg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nwgHe46Z; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nwgHe46Z"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E31851F000FF;
	Thu, 10 Sep 2026 01:17:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003037;
	bh=pKv0TAfsKaV/ghU4vTIlA9PWe6eWdM60ACL8dEXbVKI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nwgHe46Z7ULflxIIT3aKdjuOZziy7IBosWaBg3SopR/Q6njFiq/D3ZXa+1/+pBJsG
	 bUIOLYvHQfMw+7XOTyArPHE96epD0wNM9SN7+knSoiOjXsacDnEkY8x2OHUmVLmncq
	 eEUXnwEqrCaxH84GndW4qYE7gUkgh8f6j8Fpu8wxs4f8cvmUp+QUlKNzLlGZYVhUCV
	 jVtG177NGtDTGqEuihPqUx6scY9g3M3OIeSZSSObh4PCL/lZFv0d62NogicjQo7uPC
	 aMFMybYt4YvAQBtaDTC7kSiEGufyjaqUWwrsf4JXHUz69opHJbGQuT1eSPp5quQJ2K
	 yrRstIFsOH0Jw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.2.y 1/2] udf: Move udf_map_block() up
Date: Wed,  9 Sep 2026 21:17:14 -0400
Message-ID: <20260910011715.3832181-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090407-drool-bonehead-8d81@gregkh>
References: <2026090407-drool-bonehead-8d81@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 97e9d759a4193eabe4d8b6ecac093aac664c16e3 ]

Move udf_map_block() in the file to avoid forward declarations.

Link: https://patch.msgid.link/20260730104232.4086759-3-jack@suse.cz
Signed-off-by: Jan Kara <jack@suse.cz>
Stable-dep-of: 62333e480d12 ("udf: Fix data loss when converting inline inodes to out of line")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c | 118 ++++++++++++++++++++++++-------------------------
 1 file changed, 59 insertions(+), 59 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index c519644acfd7d..074ee35ef3c29 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -336,65 +336,6 @@ const struct address_space_operations udf_aops = {
 	.migrate_folio	= buffer_migrate_folio,
 };
 
-/*
- * Expand file stored in ICB to a normal one-block-file
- *
- * This function requires i_mutex held
- */
-int udf_expand_file_adinicb(struct inode *inode)
-{
-	struct folio *folio;
-	struct udf_inode_info *iinfo = UDF_I(inode);
-	int err;
-
-	WARN_ON_ONCE(!inode_is_locked(inode));
-	if (!iinfo->i_lenAlloc) {
-		down_write(&iinfo->i_data_sem);
-		if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
-			iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
-		else
-			iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
-		up_write(&iinfo->i_data_sem);
-		mark_inode_dirty(inode);
-		return 0;
-	}
-
-	folio = __filemap_get_folio(inode->i_mapping, 0,
-			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_KERNEL);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
-
-	if (!folio_test_uptodate(folio))
-		udf_adinicb_read_folio(folio);
-	down_write(&iinfo->i_data_sem);
-	memset(iinfo->i_data + iinfo->i_lenEAttr, 0x00,
-	       iinfo->i_lenAlloc);
-	iinfo->i_lenAlloc = 0;
-	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
-		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
-	else
-		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
-	folio_mark_dirty(folio);
-	folio_unlock(folio);
-	up_write(&iinfo->i_data_sem);
-	err = filemap_fdatawrite(inode->i_mapping);
-	if (err) {
-		/* Restore everything back so that we don't lose data... */
-		folio_lock(folio);
-		down_write(&iinfo->i_data_sem);
-		memcpy_from_folio(iinfo->i_data + iinfo->i_lenEAttr,
-				folio, 0, inode->i_size);
-		folio_unlock(folio);
-		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
-		iinfo->i_lenAlloc = inode->i_size;
-		up_write(&iinfo->i_data_sem);
-	}
-	folio_put(folio);
-	mark_inode_dirty(inode);
-
-	return err;
-}
-
 #define UDF_MAP_CREATE		0x01	/* Mapping can allocate new blocks */
 #define UDF_MAP_NOPREALLOC	0x02	/* Do not preallocate blocks */
 
@@ -455,6 +396,65 @@ static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
 	return ret;
 }
 
+/*
+ * Expand file stored in ICB to a normal one-block-file
+ *
+ * This function requires i_mutex held
+ */
+int udf_expand_file_adinicb(struct inode *inode)
+{
+	struct folio *folio;
+	struct udf_inode_info *iinfo = UDF_I(inode);
+	int err;
+
+	WARN_ON_ONCE(!inode_is_locked(inode));
+	if (!iinfo->i_lenAlloc) {
+		down_write(&iinfo->i_data_sem);
+		if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
+			iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
+		else
+			iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
+		up_write(&iinfo->i_data_sem);
+		mark_inode_dirty(inode);
+		return 0;
+	}
+
+	folio = __filemap_get_folio(inode->i_mapping, 0,
+			FGP_LOCK | FGP_ACCESSED | FGP_CREAT, GFP_KERNEL);
+	if (IS_ERR(folio))
+		return PTR_ERR(folio);
+
+	if (!folio_test_uptodate(folio))
+		udf_adinicb_read_folio(folio);
+	down_write(&iinfo->i_data_sem);
+	memset(iinfo->i_data + iinfo->i_lenEAttr, 0x00,
+	       iinfo->i_lenAlloc);
+	iinfo->i_lenAlloc = 0;
+	if (UDF_QUERY_FLAG(inode->i_sb, UDF_FLAG_USE_SHORT_AD))
+		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
+	else
+		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
+	folio_mark_dirty(folio);
+	folio_unlock(folio);
+	up_write(&iinfo->i_data_sem);
+	err = filemap_fdatawrite(inode->i_mapping);
+	if (err) {
+		/* Restore everything back so that we don't lose data... */
+		folio_lock(folio);
+		down_write(&iinfo->i_data_sem);
+		memcpy_from_folio(iinfo->i_data + iinfo->i_lenEAttr,
+				folio, 0, inode->i_size);
+		folio_unlock(folio);
+		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
+		iinfo->i_lenAlloc = inode->i_size;
+		up_write(&iinfo->i_data_sem);
+	}
+	folio_put(folio);
+	mark_inode_dirty(inode);
+
+	return err;
+}
+
 static int __udf_get_block(struct inode *inode, sector_t block,
 			   struct buffer_head *bh_result, int flags)
 {
-- 
2.53.0

