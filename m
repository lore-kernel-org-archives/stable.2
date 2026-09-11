Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4A2839CCF7
	for <stable@vger.kernel.org>; Fri, 11 Sep 2026 22:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789164030; cv=none; b=EGYah3y4OAd1cy0BS2j/zuMVrF/dFXROAq9aRJKSeyJfwaXHicUz6hKBWLO7FHPDtYbcM41D29/Pq4+UWd/ov/vDGYkxjT43QiY2FiJMEoUNvhO5gn7O7LfTkC1I7rBkpUaakP9ow4VeH1jmZuoOX9lXbBd0DBZDIrslhBBw2JM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789164030; c=relaxed/simple;
	bh=fZvsZ2Lq6YN1E14oh5KuUWFjyd+XTXUKlqffNVuSCqU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M7u4oVyGgb/DvZE9RyzQTqTSbH3IEqc5tE27daE8AVkQJ56Ecig4VP+4lvmT2SWA4uFY7wZLGwo65Uamth01QzzdVyH+R3+pwhEi9iLzLMZks+ROcQOHly/iTGQZ6hcRo8c/ma3LBEeT60mDdNWwDfGAjpS6L8nlKgWwMc+ZUYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cSg8CiJs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cSg8CiJs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FC81F00893;
	Fri, 11 Sep 2026 22:00:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789164028;
	bh=Aw98sVT3mdGE7ka7hdAbLAl3/pRUpjv7IJgmxgXeghE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cSg8CiJsxuEepuFrbReF24y+vyvR6tVX7eLpLaLIRjhh9T+Kpb4Tv4si2m5qbue58
	 uEGbat1eBR41ojWaCAhOx0f0n1DuoJDHfiw1HV82zn4Dc7ItCwGXqyg9aPpsWMa1lg
	 wL/cKvdsKUBc9DxRQPz+7JBJZkQQ1tQkRdaGSznrb5CpA+YGWG5YPuVSbaX0/4BJub
	 JUaZM6+8vfYes22UKT3tuICX6UzQcwmgvBepAkNgIcFRRTP3/CEAug4X3zpbaa+A24
	 fTrSkG3aFGMWq2YJRD+DBZHiKXczpGQi4/U2ReevALymrQTJ9QRRuSl2iau1ogGxWc
	 Zur35U/+ZJKCA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chao Yu <chao@kernel.org>,
	Zhiguo Niu <zhiguo.niu@unisoc.com>,
	Jaegeuk Kim <jaegeuk@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] f2fs: fix to handle segment allocation failure correctly
Date: Fri, 11 Sep 2026 18:00:23 -0400
Message-ID: <20260911220025.1624949-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260911220025.1624949-1-sashal@kernel.org>
References: <2026090946-clumsily-stuck-0ea2@gregkh>
 <20260911220025.1624949-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Chao Yu <chao@kernel.org>

[ Upstream commit 7d009e048d7cfcc21d400f2aba4c8bacbdebbd47 ]

If CONFIG_F2FS_CHECK_FS is off, and for very rare corner case that
we run out of free segment, we should not panic kernel, instead,
let's handle such error correctly in its caller.

Signed-off-by: Chao Yu <chao@kernel.org>
Tested-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
Stable-dep-of: 8ec06f50ddd8 ("f2fs: fix to migrate all curseg types during free_segment_range")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/f2fs/data.c    |  7 +++++--
 fs/f2fs/f2fs.h    |  2 +-
 fs/f2fs/file.c    |  7 ++++++-
 fs/f2fs/gc.c      |  7 ++++++-
 fs/f2fs/segment.c | 46 +++++++++++++++++++++++++++++++++++++++-------
 5 files changed, 57 insertions(+), 12 deletions(-)

diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index d068111436d79..51b31dcf9ec6b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -1453,8 +1453,11 @@ static int __allocate_data_block(struct dnode_of_data *dn, int seg_type)
 
 	set_summary(&sum, dn->nid, dn->ofs_in_node, ni.version);
 	old_blkaddr = dn->data_blkaddr;
-	f2fs_allocate_data_block(sbi, NULL, old_blkaddr, &dn->data_blkaddr,
-				&sum, seg_type, NULL);
+	err = f2fs_allocate_data_block(sbi, NULL, old_blkaddr,
+				&dn->data_blkaddr, &sum, seg_type, NULL);
+	if (err)
+		return err;
+
 	if (GET_SEGNO(sbi, old_blkaddr) != NULL_SEGNO)
 		f2fs_invalidate_internal_cache(sbi, old_blkaddr);
 
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 7ad3c976a773f..629b1e5d2f6ca 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -3762,7 +3762,7 @@ void f2fs_replace_block(struct f2fs_sb_info *sbi, struct dnode_of_data *dn,
 			block_t old_addr, block_t new_addr,
 			unsigned char version, bool recover_curseg,
 			bool recover_newaddr);
-void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
+int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 			block_t old_blkaddr, block_t *new_blkaddr,
 			struct f2fs_summary *sum, int type,
 			struct f2fs_io_info *fio);
diff --git a/fs/f2fs/file.c b/fs/f2fs/file.c
index d321a42f97c89..41f50236a058f 100644
--- a/fs/f2fs/file.c
+++ b/fs/f2fs/file.c
@@ -2363,8 +2363,11 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 	case F2FS_GOING_DOWN_METASYNC:
 		/* do checkpoint only */
 		ret = f2fs_sync_fs(sb, 1);
-		if (ret)
+		if (ret) {
+			if (ret == -EIO)
+				ret = 0;
 			goto out;
+		}
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_SHUTDOWN);
 		break;
 	case F2FS_GOING_DOWN_NOSYNC:
@@ -2380,6 +2383,8 @@ int f2fs_do_shutdown(struct f2fs_sb_info *sbi, unsigned int flag,
 		set_sbi_flag(sbi, SBI_IS_DIRTY);
 		/* do checkpoint only */
 		ret = f2fs_sync_fs(sb, 1);
+		if (ret == -EIO)
+			ret = 0;
 		goto out;
 	default:
 		ret = -EINVAL;
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index ac21950f53cd2..ec68bc87ef008 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1397,8 +1397,13 @@ static int move_data_block(struct inode *inode, block_t bidx,
 	set_summary(&sum, dn.nid, dn.ofs_in_node, ni.version);
 
 	/* allocate block address */
-	f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
+	err = f2fs_allocate_data_block(fio.sbi, NULL, fio.old_blkaddr, &newaddr,
 				&sum, type, NULL);
+	if (err) {
+		f2fs_put_page(mpage, 1);
+		/* filesystem should shutdown, no need to recovery block */
+		goto up_out;
+	}
 
 	fio.encrypted_page = f2fs_pagecache_get_page(META_MAPPING(fio.sbi),
 				newaddr, FGP_LOCK | FGP_CREAT, GFP_NOFS);
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 9c27353f384be..66eeb1c6a349b 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -416,6 +416,9 @@ int f2fs_commit_atomic_write(struct inode *inode)
  */
 void f2fs_balance_fs(struct f2fs_sb_info *sbi, bool need)
 {
+	if (f2fs_cp_error(sbi))
+		return;
+
 	if (time_to_inject(sbi, FAULT_CHECKPOINT))
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_FAULT_INJECT);
 
@@ -2669,7 +2672,7 @@ static int is_next_segment_free(struct f2fs_sb_info *sbi,
  * Find a new segment from the free segments bitmap to right order
  * This function should be returned with success, otherwise BUG
  */
-static void get_new_segment(struct f2fs_sb_info *sbi,
+static int get_new_segment(struct f2fs_sb_info *sbi,
 			unsigned int *newseg, bool new_sec, bool pinning)
 {
 	struct free_segmap_info *free_i = FREE_I(sbi);
@@ -2744,6 +2747,7 @@ static void get_new_segment(struct f2fs_sb_info *sbi,
 		f2fs_stop_checkpoint(sbi, false, STOP_CP_REASON_NO_SEGMENT);
 		f2fs_bug_on(sbi, 1);
 	}
+	return ret;
 }
 
 static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
@@ -2752,6 +2756,10 @@ static void reset_curseg(struct f2fs_sb_info *sbi, int type, int modified)
 	struct summary_footer *sum_footer;
 	unsigned short seg_type = curseg->seg_type;
 
+	/* only happen when get_new_segment() fails */
+	if (curseg->next_segno == NULL_SEGNO)
+		return;
+
 	curseg->inited = true;
 	curseg->segno = curseg->next_segno;
 	curseg->zone = GET_ZONE_FROM_SEG(sbi, curseg->segno);
@@ -2816,7 +2824,10 @@ static int new_curseg(struct f2fs_sb_info *sbi, int type, bool new_sec)
 		write_sum_page(sbi, curseg->sum_blk, GET_SUM_BLOCK(sbi, segno));
 
 	segno = __get_next_segno(sbi, type);
-	get_new_segment(sbi, &segno, new_sec, pinning);
+	if (get_new_segment(sbi, &segno, new_sec, pinning)) {
+		curseg->segno = NULL_SEGNO;
+		return -ENOSPC;
+	}
 	if (new_sec && pinning &&
 	    !f2fs_valid_pinned_area(sbi, START_BLOCK(sbi, segno))) {
 		__set_free(sbi, segno);
@@ -3461,7 +3472,7 @@ static void f2fs_randomize_chunk(struct f2fs_sb_info *sbi,
 		get_random_u32_inclusive(1, sbi->max_fragment_hole);
 }
 
-void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
+int f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 		block_t old_blkaddr, block_t *new_blkaddr,
 		struct f2fs_summary *sum, int type,
 		struct f2fs_io_info *fio)
@@ -3478,6 +3489,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	mutex_lock(&curseg->curseg_mutex);
 	down_write(&sit_i->sentry_lock);
 
+	if (curseg->segno == NULL_SEGNO)
+		goto out_err;
+
 	if (from_gc) {
 		f2fs_bug_on(sbi, GET_SEGNO(sbi, old_blkaddr) == NULL_SEGNO);
 		se = get_seg_entry(sbi, GET_SEGNO(sbi, old_blkaddr));
@@ -3539,6 +3553,9 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 				change_curseg(sbi, type);
 			stat_inc_seg_type(sbi, curseg);
 		}
+
+		if (curseg->segno == NULL_SEGNO)
+			goto out_err;
 	}
 
 skip_new_segment:
@@ -3578,8 +3595,15 @@ void f2fs_allocate_data_block(struct f2fs_sb_info *sbi, struct page *page,
 	}
 
 	mutex_unlock(&curseg->curseg_mutex);
-
 	f2fs_up_read(&SM_I(sbi)->curseg_lock);
+	return 0;
+out_err:
+	*new_blkaddr = NULL_ADDR;
+	up_write(&sit_i->sentry_lock);
+	mutex_unlock(&curseg->curseg_mutex);
+	f2fs_up_read(&SM_I(sbi)->curseg_lock);
+	return -ENOSPC;
+
 }
 
 void f2fs_update_device_state(struct f2fs_sb_info *sbi, nid_t ino,
@@ -3617,8 +3641,16 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 	if (keep_order)
 		f2fs_down_read(&fio->sbi->io_order_lock);
 
-	f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
-			&fio->new_blkaddr, sum, type, fio);
+	if (f2fs_allocate_data_block(fio->sbi, fio->page, fio->old_blkaddr,
+			&fio->new_blkaddr, sum, type, fio)) {
+		if (fscrypt_inode_uses_fs_layer_crypto(fio->page->mapping->host))
+			fscrypt_finalize_bounce_page(&fio->encrypted_page);
+		if (PageWriteback(fio->page))
+			end_page_writeback(fio->page);
+		if (f2fs_in_warm_node_list(fio->sbi, fio->page))
+			f2fs_del_fsync_node_entry(fio->sbi, fio->page);
+		goto out;
+	}
 	if (GET_SEGNO(fio->sbi, fio->old_blkaddr) != NULL_SEGNO)
 		f2fs_invalidate_internal_cache(fio->sbi, fio->old_blkaddr);
 
@@ -3626,7 +3658,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 	f2fs_submit_page_write(fio);
 
 	f2fs_update_device_state(fio->sbi, fio->ino, fio->new_blkaddr, 1);
-
+out:
 	if (keep_order)
 		f2fs_up_read(&fio->sbi->io_order_lock);
 }
-- 
2.53.0

