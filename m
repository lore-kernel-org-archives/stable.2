Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 475F4351C10
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:24:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789003462; cv=none; b=Zx8tEi62k8uauWOAKi6TJRPh7pBOr168DfOmKpG1FHGllPpnSGAdmtebWLS5BH05lWp8qqfBsjjc/ikQ8lLgjsDXYpHU+q4vR+xAay9/wXDlMQaPZy630Gg10RutpRx3iKUksR4JKNkL3/qNMY3U6JRFeCvsnpsqYRpqXcjTJNI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789003462; c=relaxed/simple;
	bh=M60fb7rpnLJZw3/6zAvMxA6Sj8zOFl1Anj5z3Ptrj4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dCFJswb+bBQBdiKJ+ruH9cjxlb9y01mCYmDye5bGv4r2miKOL9MZT7rVIY5tBkcQCvqXiu2s0E+yfgVmwLNeed6HerjPrTmd5tzsslhwxJMCkKENUQi8UzfOM/vftsHitycvRARwAr7uZo/cEXUK6pY64XiqZQ5496BJ5B/iTMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UVUIcyX3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UVUIcyX3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10C51F000FF;
	Thu, 10 Sep 2026 01:24:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789003461;
	bh=0RWSQMmDtkemS0RNAEy2lG1tWwAlJS2sUMNtFtDr480=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UVUIcyX3W7nZMakhu6y56MqHLrYFnL7qew6zdm6D+nhPn7CShf9cLpCQijLiCGhhX
	 4cFlqQ3i630m7ZBwfeR63/FeIIEdURwUAstsr/ZeCIACysWyOaK84R+67c/lt1dsX9
	 JjW7Kt5Pprt/B8v0XOdeRjiYP2SAwUcfplAQQDr89464jgDMwQRldkSDwBTL0DtwRB
	 /uQdp0Z3hvjHVkFB+DUlO7RSOQHgyPTQiVI5N/Di5SVGC70Lw6GlXOk2s5Dc6jWIKr
	 G0SIoTAIpA23/lrReqlPZaE5cv+mPcpbWkvlcePneuHu9juBP3MLA5RinVh8BCfLGB
	 gyDsj8111fN/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/2] udf: Move udf_map_block() up
Date: Wed,  9 Sep 2026 21:24:18 -0400
Message-ID: <20260910012419.3856710-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090408-obliged-concert-25ca@gregkh>
References: <2026090408-obliged-concert-25ca@gregkh>
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
index 2513816c48f55..6c559c343fc51 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -330,65 +330,6 @@ const struct address_space_operations udf_aops = {
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
 
@@ -449,6 +390,65 @@ static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
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

