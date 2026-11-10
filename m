Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794331097;
	b=m5tgmmW0rgvhN547/H4Q8sEmAiwStQGhZgNtWKVEWupd13z7MRLiAHPfVjuNHweBoxkA
	 hec1/3W1BgH4f0nIFp9Z0jEmHINCAMDN30wVZxEKH5PxfTRUpQqRdOkD7426iztN39dpE
	 pxD0dVNkzlrWpvSM+hMTsHLDN7pvCsMBV5eHQSZ0zNBS9gBV7BtzXm2En5nNP3nr6uAVH
	 tE79YqENXmf1lBKebLSVsmCmEN0AdW04/CWpXRpNBpItE60OmRqlbT2LIVRDaRJIqEno0
	 bVvQB71KbaQqv6eB/og1VF4pg6+UKUzaWSscrMzJ5Z5OpROA6iwZF8xvNznutBD2B3Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794331097;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9bx3ajom1jOcvAH8OA38jwM/1pQeH7lmDO/bOSvLBNk=;
	b=0OGsJUIOCgJRpeWp5QILtIcwM2LtSPncPays1kzTZecnJmJMJcpznmrEnRjny5p7caQA
	 yssnxD+D8Pc+IJl+cdiZaFQZRYPYYP8pZOdSrX71n7RQqrVfqTkXeKj6EIdIzktESKAnj
	 EG2qxHEDez/tFz7JeV+Z2yWVW/oirkHVrkKPp5abEjQnbmf1IeSeTKEThOd80A1CmMBmi
	 YDROg/XMYjn7X6h9ePkJEBJ4UOEdzNQreH3zbTqSYa/q0LkkUEG46moeM70UOtWtv7q1O
	 IZhyDTOY5/WDOmTpm7XttWMhOdmv1XEGUZft9DVUWXxyPGCKk0jSsEuV9XXtUpNWiCg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Folr+IM2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BED0606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 17:18:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Folr+IM2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25F3B1F008A2;
	Tue, 10 Nov 2026 17:18:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794331096;
	bh=9bx3ajom1jOcvAH8OA38jwM/1pQeH7lmDO/bOSvLBNk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Folr+IM2B2jdB0Q3OzoQPwU0Qa4D/xQBPv3Ycb2yv3Mi/zvDA5jmygRLvICrwu06a
	 6MLPnb1CRpQgDEbJWqedTTPtudApJVpBNl55ILGJyp8TaizXdrwd/exe+DS4xIfaAw
	 4VWkvbTv8l93Q8/HCf8ZJpk3T8at5gCfZDpBC1ftB1sLysHidj3dsDOo0Z1RYM3nAQ
	 J1/HGucP7ZAoM1+oiJBy0Wqvce/R3GbOBJkiq2X4qi5MPV/T46fsJ3s3mIENqnm1Wz
	 D6tIDGFkbOp4maiFCny1URdAIf/A26GY3BN0m1WfE7tCuiknBBaMNtB1sqJjX5C2cM
	 Nk8wt7fO9aapw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/3] f2fs: convert f2fs_mpage_readpages() to use folio
Date: Tue, 10 Nov 2026 12:18:12 -0500
Message-ID: <20261110171210.2630515-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053437-failed-6.6-b3c984358925@kernel.org>
References: <20261107053437-failed-6.6-b3c984358925@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit db92e6c729d87e6f5b0f467f01a96dbf1e452106 ]

Convert f2fs_mpage_readpages() to use folio and related
functionality.

Signed-off-by: Chao Yu <chao@kernel.org>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: b3c984358925 ("f2fs: remove mappedtodisk flag usage in mmap write path")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c | 80 +++++++++++++++++++++++++-------------------------
 1 file changed, 40 insertions(+), 40 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index b0c633c5deb75..3cb822e799be8 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -2375,7 +2375,7 @@ int f2fs_read_multi_pages(struct compress_ctx *cc, struct bio **bio_ret,
  * Major change was from block_size == page_size in f2fs by default.
  */
 static int f2fs_mpage_readpages(struct inode *inode,
-		struct readahead_control *rac, struct page *page)
+		struct readahead_control *rac, struct folio *folio)
 {
 	struct bio *bio = NULL;
 	sector_t last_block_in_bio = 0;
@@ -2395,6 +2395,7 @@ static int f2fs_mpage_readpages(struct inode *inode,
 #endif
 	unsigned nr_pages = rac ? readahead_count(rac) : 1;
 	unsigned max_nr_pages = nr_pages;
+	pgoff_t index;
 	int ret = 0;
 
 	map.m_pblk = 0;
@@ -2408,64 +2409,63 @@ static int f2fs_mpage_readpages(struct inode *inode,
 
 	for (; nr_pages; nr_pages--) {
 		if (rac) {
-			page = readahead_page(rac);
-			prefetchw(&page->flags);
+			folio = readahead_folio(rac);
+			prefetchw(&folio->flags);
 		}
 
-#ifdef CONFIG_F2FS_FS_COMPRESSION
-		if (f2fs_compressed_file(inode)) {
-			/* there are remained compressed pages, submit them */
-			if (!f2fs_cluster_can_merge_page(&cc, page->index)) {
-				ret = f2fs_read_multi_pages(&cc, &bio,
-							max_nr_pages,
-							&last_block_in_bio,
-							rac != NULL, false);
-				f2fs_destroy_compress_ctx(&cc, false);
-				if (ret)
-					goto set_error_page;
-			}
-			if (cc.cluster_idx == NULL_CLUSTER) {
-				if (nc_cluster_idx ==
-					page->index >> cc.log_cluster_size) {
-					goto read_single_page;
-				}
-
-				ret = f2fs_is_compressed_cluster(inode, page->index);
-				if (ret < 0)
-					goto set_error_page;
-				else if (!ret) {
-					nc_cluster_idx =
-						page->index >> cc.log_cluster_size;
-					goto read_single_page;
-				}
+		index = folio_index(folio);
 
-				nc_cluster_idx = NULL_CLUSTER;
-			}
-			ret = f2fs_init_compress_ctx(&cc);
+#ifdef CONFIG_F2FS_FS_COMPRESSION
+		if (!f2fs_compressed_file(inode))
+			goto read_single_page;
+
+		/* there are remained compressed pages, submit them */
+		if (!f2fs_cluster_can_merge_page(&cc, index)) {
+			ret = f2fs_read_multi_pages(&cc, &bio,
+						max_nr_pages,
+						&last_block_in_bio,
+						rac != NULL, false);
+			f2fs_destroy_compress_ctx(&cc, false);
 			if (ret)
 				goto set_error_page;
+		}
+		if (cc.cluster_idx == NULL_CLUSTER) {
+			if (nc_cluster_idx == index >> cc.log_cluster_size)
+				goto read_single_page;
 
-			f2fs_compress_ctx_add_page(&cc, page);
+			ret = f2fs_is_compressed_cluster(inode, index);
+			if (ret < 0)
+				goto set_error_page;
+			else if (!ret) {
+				nc_cluster_idx =
+					index >> cc.log_cluster_size;
+				goto read_single_page;
+			}
 
-			goto next_page;
+			nc_cluster_idx = NULL_CLUSTER;
 		}
+		ret = f2fs_init_compress_ctx(&cc);
+		if (ret)
+			goto set_error_page;
+
+		f2fs_compress_ctx_add_page(&cc, &folio->page);
+
+		goto next_page;
 read_single_page:
 #endif
 
-		ret = f2fs_read_single_page(inode, page, max_nr_pages, &map,
+		ret = f2fs_read_single_page(inode, &folio->page, max_nr_pages, &map,
 					&bio, &last_block_in_bio, rac);
 		if (ret) {
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 set_error_page:
 #endif
-			zero_user_segment(page, 0, PAGE_SIZE);
-			unlock_page(page);
+			folio_zero_segment(folio, 0, folio_size(folio));
+			folio_unlock(folio);
 		}
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 next_page:
 #endif
-		if (rac)
-			put_page(page);
 
 #ifdef CONFIG_F2FS_FS_COMPRESSION
 		if (f2fs_compressed_file(inode)) {
@@ -2502,7 +2502,7 @@ static int f2fs_read_data_folio(struct file *file, struct folio *folio)
 	if (f2fs_has_inline_data(inode))
 		ret = f2fs_read_inline_data(inode, page);
 	if (ret == -EAGAIN)
-		ret = f2fs_mpage_readpages(inode, NULL, page);
+		ret = f2fs_mpage_readpages(inode, NULL, folio);
 	return ret;
 }
 
-- 
2.53.0

