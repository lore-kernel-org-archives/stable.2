Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA6EB361969
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:59:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005581; cv=none; b=hi37Q59ei697S2dh0VSpF108xX8zZEGfGLv3oAsW8xycRuAaNJiT5IXnrVpyK8LO6zpVV80tLn7VISZzZ2rxosjiOfRHnW9Ewl6Bl8rjSXyAD0/OlwxyGa78z9vjVQ5pbQygU2giOlvpHFpXAEor9hrVgvfMMajb2AR3loS2eqk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005581; c=relaxed/simple;
	bh=V1hgo0GHSAtDMVSwqAbF67qxXo4iqXuu78ge/biEWqA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qx2QGGkBhGjZ/Cqe7VfncxWM2s3xjYDnhuwPaHDVyxvrk5QKDBnUhDz+JcJiSm/+r97UDROvafnlaDgIsG1FlbaIHwEvuDKtOhSYx+1vlMYTKCgEdVqzBm3ZvtMwxaJZSUdS3YKqBt9oT4rd8+vMIiKJ+w3zySyJMoPkEKFnOv8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cL89oYPh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cL89oYPh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 033B71F00893;
	Thu, 10 Sep 2026 01:59:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005579;
	bh=Mmx/d9Dll8EoG5sFENuQFQO8dCjZHTz1yF6zTDT1sfY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cL89oYPhz9ZMrMB4mDRAqvux7Xa3C4sNtViO7AZasMgUDYVTxIl5q3NjA1FvVBcpa
	 AXk1LXMSGabWp2tCjMNKXUj6HPF/sNSdTxFKmcdu8kBWaOjq9cZyoxrJYKgqrrxdA4
	 uOen/uve/A4p9tsK5A1j721MbdKpCL7PnBvYvLUIVTOrKD/YxCkPHRamyaZLyqL67N
	 qJts9N2J95sbiUQiMP13F012vpvOmnoSyCIHyyfkg+0w+yNIIacOT2tgGvx5/BDJ8e
	 Cj/MxvS88wYgBB7XZjG01fTOv7BZE7mCNj1Sz+7f8eBPxubWx1a2G2Z/Sywi0QZcuD
	 cVjyk7TnK/2hg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jan Kara <jack@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] udf: Fix data loss when converting inline inodes to out of line
Date: Wed,  9 Sep 2026 21:59:37 -0400
Message-ID: <20260910015937.3953397-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090409-transpire-dyslexic-70b4@gregkh>
References: <2026090409-transpire-dyslexic-70b4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Jan Kara <jack@suse.cz>

[ Upstream commit 62333e480d12ab186f89fe2725b372d12f72d5eb ]

When udf_expand_file_adinicb() converts file from inline format to out
of line, we use filemap_fdatawrite() to writeout the data to the new
blocks. However since 36580ed08776 ("udf: Do not allocate blocks on page
writeback") the writeback actually doesn't allocate the new block and
the folio dirty bit is just silently cleared. Thus unless the file is
written to after the conversion (as it can easily happen in case of
truncate up), the data is just lost. Fix the problem by explicitely
allocating the block underlying the data before starting writeback.

Fixes: 36580ed08776 ("udf: Do not allocate blocks on page writeback")
CC: stable@vger.kernel.org
Link: https://patch.msgid.link/20260730104232.4086759-4-jack@suse.cz
Signed-off-by: Jan Kara <jack@suse.cz>
[ adjusted mapping declarations to accommodate the branch’s older udf_map_block() function order. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/udf/inode.c | 42 ++++++++++++++++++++++++++----------------
 1 file changed, 26 insertions(+), 16 deletions(-)

diff --git a/fs/udf/inode.c b/fs/udf/inode.c
index 848c46c5e9d3c..11792768594c8 100644
--- a/fs/udf/inode.c
+++ b/fs/udf/inode.c
@@ -48,13 +48,25 @@
 #define FE_DELETE_PERMS	(FE_PERM_U_DELETE | FE_PERM_G_DELETE | \
 			 FE_PERM_O_DELETE)
 
-struct udf_map_rq;
+#define UDF_MAP_CREATE		0x01	/* Mapping can allocate new blocks */
+#define UDF_MAP_NOPREALLOC	0x02	/* Do not preallocate blocks */
+
+#define UDF_BLK_MAPPED	0x01	/* Block was successfully mapped */
+#define UDF_BLK_NEW	0x02	/* Block was freshly allocated */
+
+struct udf_map_rq {
+	sector_t lblk;
+	udf_pblk_t pblk;
+	int iflags;		/* UDF_MAP_ flags determining behavior */
+	int oflags;		/* UDF_BLK_ flags reporting results */
+};
 
 static umode_t udf_convert_permissions(struct fileEntry *);
 static int udf_update_inode(struct inode *, int);
 static int udf_sync_inode(struct inode *inode);
 static int udf_alloc_i_data(struct inode *inode, size_t size);
 static int inode_getblk(struct inode *inode, struct udf_map_rq *map);
+static int udf_map_block(struct inode *inode, struct udf_map_rq *map);
 static int udf_insert_aext(struct inode *, struct extent_position,
 			   struct kernel_lb_addr, uint32_t);
 static void udf_split_extents(struct inode *, int *, int, udf_pblk_t,
@@ -343,6 +355,10 @@ int udf_expand_file_adinicb(struct inode *inode)
 {
 	struct folio *folio;
 	struct udf_inode_info *iinfo = UDF_I(inode);
+	struct udf_map_rq map = {
+		.lblk = 0,
+		.iflags = UDF_MAP_CREATE,
+	};
 	int err;
 
 	WARN_ON_ONCE(!inode_is_locked(inode));
@@ -372,20 +388,27 @@ int udf_expand_file_adinicb(struct inode *inode)
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_SHORT;
 	else
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_LONG;
+	up_write(&iinfo->i_data_sem);
+
+	/* Allocate the block underlying the data */
+	err = udf_map_block(inode, &map);
+	if (err < 0)
+		goto restore;
+
 	folio_mark_dirty(folio);
 	folio_unlock(folio);
-	up_write(&iinfo->i_data_sem);
 	err = filemap_fdatawrite(inode->i_mapping);
 	if (err) {
 		/* Restore everything back so that we don't lose data... */
 		folio_lock(folio);
+restore:
 		down_write(&iinfo->i_data_sem);
 		memcpy_from_folio(iinfo->i_data + iinfo->i_lenEAttr,
 				folio, 0, inode->i_size);
-		folio_unlock(folio);
 		iinfo->i_alloc_type = ICBTAG_FLAG_AD_IN_ICB;
 		iinfo->i_lenAlloc = inode->i_size;
 		up_write(&iinfo->i_data_sem);
+		folio_unlock(folio);
 	}
 	folio_put(folio);
 	mark_inode_dirty(inode);
@@ -393,19 +416,6 @@ int udf_expand_file_adinicb(struct inode *inode)
 	return err;
 }
 
-#define UDF_MAP_CREATE		0x01	/* Mapping can allocate new blocks */
-#define UDF_MAP_NOPREALLOC	0x02	/* Do not preallocate blocks */
-
-#define UDF_BLK_MAPPED	0x01	/* Block was successfully mapped */
-#define UDF_BLK_NEW	0x02	/* Block was freshly allocated */
-
-struct udf_map_rq {
-	sector_t lblk;
-	udf_pblk_t pblk;
-	int iflags;		/* UDF_MAP_ flags determining behavior */
-	int oflags;		/* UDF_BLK_ flags reporting results */
-};
-
 static int udf_map_block(struct inode *inode, struct udf_map_rq *map)
 {
 	int ret;
-- 
2.53.0

