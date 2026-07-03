Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFFEE3C5523
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 12:33:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783082017; cv=none; b=Cw05hm0AY7Pt+7QV8RiYIqn7sjMq85uqFhHpquFvaPMqUNEPglz/XjRidumxbFNkI1Z61NMmyKrqPUSAhycWR2WUIllIDJvclxZtHsxPt83BrMg5b5g7xvv4IYpx2H4jQIuKNBM1WvAFOelJ2SttUg+K07KgX9wkQd3WhxMrpHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783082017; c=relaxed/simple;
	bh=8Q7lPcvzXq3XH8qEMWzJnt52+wBMYE6AYrsebzY1JnU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PEwKDS6S5Q+/G1Citep7C10TrrFO0Xb4IvXk8HkeUdnRDfk1O6jH1Bwgz7ihj+1AT+r1ZALSP3plaahnZQ4EPoNayJ6pYE1BpY5eqI853sgUZ3H4qDfR8NFPlnQiehtMULmBf69cGOFC5bhF6yZQCxNNouvCkyJI+lsakQhKMVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ont3fm3v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ont3fm3v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0106F1F00A3D;
	Fri,  3 Jul 2026 12:33:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783082013;
	bh=uWyjN92ZwFB1ReJcQgBl8BLImoLkxgzzySN9kFzgp7k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ont3fm3v+CU/2s95vMdEDZ+KHz1G2RbRqYTqIeaW20ujZeDe9lVsPtwnUGla6IHz8
	 jzR+IXIQRqEiSBRFlyykXSOFMXKaj/342gYmqGDyx10FJq7debn8HGPDrdsJCkXYvw
	 sBoWRfKsy4+vTNicSx2MkT41PLvpuRdTvBJfE7AKuifirg6Iy764zJ3lYIS84DxvDo
	 vGd45iQj1n3y0atlNP+7hwPOZ6PZw7TSjVDjbZsetlC3JPeIJS25pMZ5xv3HBhDy4f
	 OpwyZJIwp2oMInrUu4LyNXU8qgCsE81r0MDNMVc7Y1UM8NwBFfLWVjmhIAnobd7AUY
	 SM67LSCezRZEg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/2] f2fs: atomic: fix UAF issue on f2fs_inode_info.atomic_inode
Date: Fri,  3 Jul 2026 08:33:30 -0400
Message-ID: <20260703123330.3944793-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260703123330.3944793-1-sashal@kernel.org>
References: <2026070242-refusing-previous-82e3@gregkh>
 <20260703123330.3944793-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit e0288584baa5dc41df4a829a023c4c1b33fe53d7 ]

- ioctl(F2FS_IOC_GARBAGE_COLLECT_RANGE)		- shrink
 - f2fs_gc
  - gc_data_segment
   - ra_data_block(cow_inode)
    - mapping = F2FS_I(inode)->atomic_inode->i_mapping
    : f2fs_is_cow_file(cow_inode) is true
						 - f2fs_evict_inode(atomic_inode)
						  - clear_inode_flag(fi->cow_inode, FI_COW_FILE)
						  - F2FS_I(fi->cow_inode)->atomic_inode = NULL
						  ...
						  - truncate_inode_pages_final(atomic_inode)
    - f2fs_grab_cache_folio(mapping)
    : create folio in atomic_inode->mapping
						  - clear_inode(atomic_inode)
						   - BUG_ON(atomic_inode->i_data.nrpages)

We need to add a reference on fi->atomic_inode before using its mapping
field during garbage collection, otherwise, it will cause UAF issue.

Cc: stable@kernel.org
Cc: Daeho Jeong <daehojeong@google.com>
Cc: Sunmin Jeong <s_min.jeong@samsung.com>
Fixes: 3db1de0e582c ("f2fs: change the current atomic write way")
Fixes: f18d00769336 ("f2fs: use meta inode for GC of COW file")
Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/gc.c    | 50 +++++++++++++++++++++++++++++++++++++++++--------
 fs/f2fs/inode.c | 11 ++++++++---
 2 files changed, 50 insertions(+), 11 deletions(-)

diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index c7f6312cbb1016..7219a87955b208 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1208,8 +1208,8 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 static int ra_data_block(struct inode *inode, pgoff_t index)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct address_space *mapping = f2fs_is_cow_file(inode) ?
-				F2FS_I(inode)->atomic_inode->i_mapping : inode->i_mapping;
+	struct address_space *mapping = inode->i_mapping;
+	struct inode *atomic_inode = NULL;
 	struct dnode_of_data dn;
 	struct folio *folio, *efolio;
 	struct f2fs_io_info fio = {
@@ -1224,9 +1224,22 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	};
 	int err = 0;
 
+	f2fs_down_read(&F2FS_I(inode)->i_sem);
+	if (f2fs_is_cow_file(inode)) {
+		atomic_inode = igrab(F2FS_I(inode)->atomic_inode);
+		if (!atomic_inode) {
+			f2fs_up_read(&F2FS_I(inode)->i_sem);
+			return -EBUSY;
+		}
+		mapping = atomic_inode->i_mapping;
+	}
+	f2fs_up_read(&F2FS_I(inode)->i_sem);
+
 	folio = f2fs_grab_cache_folio(mapping, index, true);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+	if (IS_ERR(folio)) {
+		err = PTR_ERR(folio);
+		goto out_iput;
+	}
 
 	if (f2fs_lookup_read_extent_cache_block(inode, index,
 						&dn.data_blkaddr)) {
@@ -1287,11 +1300,16 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO, F2FS_BLKSIZE);
 	f2fs_update_iostat(sbi, NULL, FS_GDATA_READ_IO, F2FS_BLKSIZE);
 
+	if (atomic_inode)
+		iput(atomic_inode);
 	return 0;
 put_encrypted_page:
 	f2fs_put_page(fio.encrypted_page, 1);
 put_folio:
 	f2fs_folio_put(folio, true);
+out_iput:
+	if (atomic_inode)
+		iput(atomic_inode);
 	return err;
 }
 
@@ -1302,8 +1320,8 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 static int move_data_block(struct inode *inode, block_t bidx,
 				int gc_type, unsigned int segno, int off)
 {
-	struct address_space *mapping = f2fs_is_cow_file(inode) ?
-				F2FS_I(inode)->atomic_inode->i_mapping : inode->i_mapping;
+	struct address_space *mapping = inode->i_mapping;
+	struct inode *atomic_inode = NULL;
 	struct f2fs_io_info fio = {
 		.sbi = F2FS_I_SB(inode),
 		.ino = inode->i_ino,
@@ -1325,10 +1343,23 @@ static int move_data_block(struct inode *inode, block_t bidx,
 				(fio.sbi->gc_mode != GC_URGENT_HIGH) ?
 				CURSEG_ALL_DATA_ATGC : CURSEG_COLD_DATA;
 
+	f2fs_down_read(&F2FS_I(inode)->i_sem);
+	if (f2fs_is_cow_file(inode)) {
+		atomic_inode = igrab(F2FS_I(inode)->atomic_inode);
+		if (!atomic_inode) {
+			f2fs_up_read(&F2FS_I(inode)->i_sem);
+			return -EBUSY;
+		}
+		mapping = atomic_inode->i_mapping;
+	}
+	f2fs_up_read(&F2FS_I(inode)->i_sem);
+
 	/* do not read out */
 	folio = f2fs_grab_cache_folio(mapping, bidx, false);
-	if (IS_ERR(folio))
-		return PTR_ERR(folio);
+	if (IS_ERR(folio)) {
+		err = PTR_ERR(folio);
+		goto out_iput;
+	}
 
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off)) {
 		err = -ENOENT;
@@ -1461,6 +1492,9 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	folio_unlock(folio);
 	folio_end_dropbehind(folio);
 	folio_put(folio);
+out_iput:
+	if (atomic_inode)
+		iput(atomic_inode);
 	return err;
 }
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index 49470f4c9362a0..5fca8e689b545e 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -848,10 +848,15 @@ void f2fs_evict_inode(struct inode *inode)
 	f2fs_abort_atomic_write(inode, true);
 
 	if (fi->cow_inode && f2fs_is_cow_file(fi->cow_inode)) {
-		clear_inode_flag(fi->cow_inode, FI_COW_FILE);
-		F2FS_I(fi->cow_inode)->atomic_inode = NULL;
-		iput(fi->cow_inode);
+		struct inode *cow_inode = fi->cow_inode;
+
+		f2fs_down_write(&F2FS_I(cow_inode)->i_sem);
+		clear_inode_flag(cow_inode, FI_COW_FILE);
+		F2FS_I(cow_inode)->atomic_inode = NULL;
 		fi->cow_inode = NULL;
+		f2fs_up_write(&F2FS_I(cow_inode)->i_sem);
+
+		iput(cow_inode);
 	}
 
 	trace_f2fs_evict_inode(inode);
-- 
2.53.0

