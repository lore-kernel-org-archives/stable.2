Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8BA9336EC0
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 01:32:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789176738; cv=none; b=iJGXYlypG5qYmObJ0YxH9e60kNQeGKTQTiCwLFle6hOI9UwDX6Gywt7AvL6xG9uvhrallqq5O2WWei5jO38ZvZEKZIf81EvWId9JoWamonJZwRUWlf1Ko6Yet8dU3mQ13sBR+axiuAuZt+nGjzGMrkK1A+f9ndD78zQlAfszYMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789176738; c=relaxed/simple;
	bh=8VzhD1Gg9jIMVc8dBLcf3uI3fmhqMegAFYgBknfcXfQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HBBkPAENT2zEX9hWj7lVOlx3aFE1dNp5iZKZO7si6IfKaz20wNwMgDGCMLCDBRmNq6wcs0zgczOwribjznq0mve/mIhT42A8OS8wS9LFC2RUoWXtV/VAPK8pxz9x0N3ShPoN+sR8XRMMG+mdHlXfcaSuWJHc2kt+bAvtLvii+eU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ApqeUGJV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ApqeUGJV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B74A1F000FF;
	Sat, 12 Sep 2026 01:32:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789176736;
	bh=BxSZVtDMMYeRKJqYf89JqBnFNjxWTGKLU+chwOyzJ9Y=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ApqeUGJVKr7OF6wI2fBtMZ0gpx+97ivHwkbX9St8gxlrXjM0RnXQ1zI7+Dxld67tS
	 ggcIwJ9F2mx9p9DOfDGRrsQIH3BAF+8ffDj0Q9eBM2VxyzJ7BMUyd8V1p3e4WsYaF1
	 vVo12Z0tnDyX+0BeYf+dJLN6pzKjsFE53SGHRIk/UbpM4CTE/1TgBZUwvVdj2sniEt
	 y4CzIiYQyxaeHoYU4I0N5CgW6DGSaNb+kuth1hla9VXdwt7oOEsthW0FSkZOhWZ3ng
	 N6z67bXMjpweGQtWG2lz3U06kLqd1poBEU4Za2Md7QJPdSWhL6SpAGsvN9WQHGDZKH
	 QXbYGdAtPvMwQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Matthew Wilcox (Oracle)" <willy@infradead.org>,
	Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] f2fs: Use a folio in find_in_level()
Date: Fri, 11 Sep 2026 21:32:11 -0400
Message-ID: <20260912013214.1760785-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090949-surpass-emphases-308c@gregkh>
References: <2026090949-surpass-emphases-308c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Matthew Wilcox (Oracle)" <willy@infradead.org>

[ Upstream commit e4ca8ff450c39dd58a6a0d7167e32e80af457507 ]

Get a folio instead of a page and use it throughout.  Removes a
call to compound_head().

Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
Reviewed-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 9ec09d5f4b31 ("f2fs: dirty directory inodes on mtime/ctime update")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/dir.c | 20 ++++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/fs/f2fs/dir.c b/fs/f2fs/dir.c
index 13268d1f8c75a..48073550089fe 100644
--- a/fs/f2fs/dir.c
+++ b/fs/f2fs/dir.c
@@ -164,7 +164,7 @@ static unsigned long dir_block_index(unsigned int level,
 }
 
 static struct f2fs_dir_entry *find_in_block(struct inode *dir,
-				struct page *dentry_page,
+				struct folio *dentry_folio,
 				const struct f2fs_filename *fname,
 				int *max_slots,
 				bool use_hash)
@@ -172,7 +172,7 @@ static struct f2fs_dir_entry *find_in_block(struct inode *dir,
 	struct f2fs_dentry_block *dentry_blk;
 	struct f2fs_dentry_ptr d;
 
-	dentry_blk = (struct f2fs_dentry_block *)page_address(dentry_page);
+	dentry_blk = folio_address(dentry_folio);
 
 	make_dentry_ptr_block(dir, &d, dentry_blk);
 	return f2fs_find_target_dentry(&d, fname, max_slots, use_hash);
@@ -309,7 +309,6 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 	int s = GET_DENTRY_SLOTS(fname->disk_name.len);
 	unsigned int nbucket, nblock;
 	unsigned int bidx, end_block, bucket_no;
-	struct page *dentry_page;
 	struct f2fs_dir_entry *de = NULL;
 	pgoff_t next_pgofs;
 	bool room = false;
@@ -327,31 +326,32 @@ static struct f2fs_dir_entry *find_in_level(struct inode *dir,
 
 	while (bidx < end_block) {
 		/* no need to allocate new dentry pages to all the indices */
-		dentry_page = f2fs_find_data_page(dir, bidx, &next_pgofs);
-		if (IS_ERR(dentry_page)) {
-			if (PTR_ERR(dentry_page) == -ENOENT) {
+		struct folio *dentry_folio;
+		dentry_folio = f2fs_find_data_folio(dir, bidx, &next_pgofs);
+		if (IS_ERR(dentry_folio)) {
+			if (PTR_ERR(dentry_folio) == -ENOENT) {
 				room = true;
 				bidx = next_pgofs;
 				continue;
 			} else {
-				*res_page = dentry_page;
+				*res_page = &dentry_folio->page;
 				break;
 			}
 		}
 
-		de = find_in_block(dir, dentry_page, fname, &max_slots, use_hash);
+		de = find_in_block(dir, dentry_folio, fname, &max_slots, use_hash);
 		if (IS_ERR(de)) {
 			*res_page = ERR_CAST(de);
 			de = NULL;
 			break;
 		} else if (de) {
-			*res_page = dentry_page;
+			*res_page = &dentry_folio->page;
 			break;
 		}
 
 		if (max_slots >= s)
 			room = true;
-		f2fs_put_page(dentry_page, 0);
+		f2fs_folio_put(dentry_folio, false);
 
 		bidx++;
 	}
-- 
2.53.0

