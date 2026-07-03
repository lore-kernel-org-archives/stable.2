Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06F773D953A
	for <stable@vger.kernel.org>; Fri,  3 Jul 2026 13:31:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783085472; cv=none; b=uwp4BwGgNx95VBE5a1afj70btw7tMtZhGpWMhc1hAtQkv6YX5aP2tzq1R6xWgNvU1/dco3FOhKwTh8jDKkKKix4JdpQazMGZ83M/oyN5i566v9wd+TlLTqXm9RUA5wa/Wv97RsR+vmRvbePEl6fORhKB+e8cWQVawOEbDAc6W7g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783085472; c=relaxed/simple;
	bh=JGXScCGR/di1wN3+WrnxQlTdSeITPuH+DPhBODnBL7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=h5VhZIoWePFzolkBhuT7N+UNknE8ZcQpM8EEvd8HV/qAwEMJMGjdZ/0xKCnITefVOJvsoO4mNYysbM02XETFQbG3C4xoCP7q51ssmu+elefzJnfH9u+XzmTjGu4I6gISJoAlw5mXwCt+o1ou3kYgk737wBOIsYns43LqOC6LM+Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Rnldnqgy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Rnldnqgy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A81B61F00A3A;
	Fri,  3 Jul 2026 13:31:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783085468;
	bh=cHo8D9lpmhGiBjRS93yYrKGR+wPZJvsnx7ZJZ+67+SI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RnldnqgyZ9B3DAauwvVWGx6NYdR3bwHCBYrNKskol1ayXP27zSoJNF2aIJZQ/mBcm
	 U5PIQr1TBDsjUxY5tisx0YrtknEFLF+rOrRO175w3kSN5pvjTfZyqjiWx/UKfvdM4I
	 mxpkFGYABhDf0xrMEs6sED0PhTfyDB1yh7KinTG87AFATD1qgdnylujDIyjw5jNupX
	 in6uRJLevZufKT2jCVytGv+ALFOz9KtkHgTiblty1reJBYSbgIl6SAPI67UfFfHAGn
	 Hg7ulaQjtiXkhXuzXsKdO4JGGNOnrlP8Je2X1XRHF2ExpzKmsgxCjdhxN2FxlBElSH
	 sbaahceOiVemQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	stable@kernel.org,
	Daeho Jeong <daehojeong@google.com>,
	Sunmin Jeong <s_min.jeong@samsung.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] f2fs: atomic: fix UAF issue on f2fs_inode_info.atomic_inode
Date: Fri,  3 Jul 2026 09:31:04 -0400
Message-ID: <20260703133105.4123725-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026070242-unbridle-scallop-a9c6@gregkh>
References: <2026070242-unbridle-scallop-a9c6@gregkh>
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
index 5654608a119235..ac21950f53cd27 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1173,8 +1173,8 @@ static bool is_alive(struct f2fs_sb_info *sbi, struct f2fs_summary *sum,
 static int ra_data_block(struct inode *inode, pgoff_t index)
 {
 	struct f2fs_sb_info *sbi = F2FS_I_SB(inode);
-	struct address_space *mapping = f2fs_is_cow_file(inode) ?
-				F2FS_I(inode)->atomic_inode->i_mapping : inode->i_mapping;
+	struct address_space *mapping = inode->i_mapping;
+	struct inode *atomic_inode = NULL;
 	struct dnode_of_data dn;
 	struct page *page;
 	struct f2fs_io_info fio = {
@@ -1189,9 +1189,22 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	};
 	int err;
 
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
 	page = f2fs_grab_cache_page(mapping, index, true);
-	if (!page)
-		return -ENOMEM;
+	if (!page) {
+		err = -ENOMEM;
+		goto out_iput;
+	}
 
 	if (f2fs_lookup_read_extent_cache_block(inode, index,
 						&dn.data_blkaddr)) {
@@ -1250,11 +1263,16 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
 	f2fs_update_iostat(sbi, inode, FS_DATA_READ_IO, F2FS_BLKSIZE);
 	f2fs_update_iostat(sbi, NULL, FS_GDATA_READ_IO, F2FS_BLKSIZE);
 
+	if (atomic_inode)
+		iput(atomic_inode);
 	return 0;
 put_encrypted_page:
 	f2fs_put_page(fio.encrypted_page, 1);
 put_page:
 	f2fs_put_page(page, 1);
+out_iput:
+	if (atomic_inode)
+		iput(atomic_inode);
 	return err;
 }
 
@@ -1265,8 +1283,8 @@ static int ra_data_block(struct inode *inode, pgoff_t index)
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
@@ -1288,10 +1306,23 @@ static int move_data_block(struct inode *inode, block_t bidx,
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
 	page = f2fs_grab_cache_page(mapping, bidx, false);
-	if (!page)
-		return -ENOMEM;
+	if (!page) {
+		err = -ENOMEM;
+		goto out_iput;
+	}
 
 	if (!check_valid_map(F2FS_I_SB(inode), segno, off)) {
 		err = -ENOENT;
@@ -1413,6 +1444,9 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	f2fs_put_dnode(&dn);
 out:
 	f2fs_put_page(page, 1);
+out_iput:
+	if (atomic_inode)
+		iput(atomic_inode);
 	return err;
 }
 
diff --git a/fs/f2fs/inode.c b/fs/f2fs/inode.c
index db80b6cad325cf..354960b1ae958c 100644
--- a/fs/f2fs/inode.c
+++ b/fs/f2fs/inode.c
@@ -837,10 +837,15 @@ void f2fs_evict_inode(struct inode *inode)
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

