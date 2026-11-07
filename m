Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046008;
	b=2+vqZTEvwKkpiEPDmMDElCKEYczYTBUT9KPno9m429njBtvdw611mUoTAOyyJvgCWt0S
	 8J8SPBpw6Qfj/4MCE5Kmos45XEPwDNInrA6dY0Y7QC14mT52L9jIM52lLq4zdmsZDVkMw
	 3vdckoe3KT/dIjYf81SRODfIus9/KatwOvPdsFRM/MTvGeH/GJqS/6x9xWm3sviYS+kD7
	 MgTeev51twir4fy7I8KQ9DLDmWZ4QK7aLX3lqiHcSTNv176ItfRLGF5crDlXxyvHYSvcL
	 CAOSZcyQNP8e7EQPYVF4pjJhNETYzJN9fhNkXTKuIIwD8zamtrHZD2OI6QNybBkyW5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046008;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=f0QCsmTJQMxaDq8g7oF1t+2BP5YTPGeZG02wn3w818g=;
	b=hAtXqwnMVxG3Kzk9xqEL+Kqxhtd+KT3pCsToPrArKcFPjOhut0nuIfjimSwx8eWwPf60
	 oTwObUt4UB9HsvhgVsXebG8O2+QUSimXweDWI6BSYLEOzn95lW0Di0c//3oCtYUQICYDA
	 GO94HCmcUtHrrY2QyDsyWRKze0CR0Ne4Nk9aRthiGy6LDc34lwDtxYb7tO9QljyRac4dt
	 eIhB9cCDdu346KmomcgRCEiKvG5cYVDmRJR3hQAxYkTZM/8p+ik6bgAhIXYZCo9I7vrF6
	 NZGb2lzNtHb0tOsXPB0otwuWJ9KbfOHfHm214hmHlGNo7gWB3vdNDhzjpYB6+UEizZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hD1SsmmW;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3C324606A326
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:06:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hD1SsmmW
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A6D51F0089F;
	Sat,  7 Nov 2026 10:06:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046008;
	bh=f0QCsmTJQMxaDq8g7oF1t+2BP5YTPGeZG02wn3w818g=;
	h=From:To:Cc:Subject:Date;
	b=hD1SsmmWwXbbEDGml3wljUuC817W3WcFELVoszBXFduMCSGv+xCfABppIWuiiP2qO
	 AVrrSaJGOYFwvpc+WUK8VXSzJUL0HLEOwDpXUnRGdf3/E4euO7ZIXyLxIn5iqXCGzx
	 OXoM+wAz22tESzqJ1K1zV1k/bYU6Zkl81kJZDLaO/fQcjFMg09DOvZ1PtZaYNuRpuF
	 yzP4VwdCO7ce6Rpjd+ZLJgRAJMkEmA6Qsx74n7+6waxqVmsJcbXKjHaFDlmNhDbpzX
	 D8eAZbDgIbsSRNeCMpnK0iZaPCScodgWdDpM1/utohWokRMvMhcq8oruziXWMa0dtZ
	 4QhQHg/iHB7qw==
From: Sasha Levin <sashal@kernel.org>
To: chao@kernel.org,
	zhiguo.niu@unisoc.com,
	jaegeuk@kernel.org
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] f2fs: fix to avoid folio->mapping dereference in is_{meta, node}_folio()" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:06:46 -0500
Message-ID: <20261107050646-failed-6.18-b5a71253c5c7@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x b5a71253c5c7e1139eab2f3e1e13e0bf2cbcaac7
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050646-failed-6.18-b5a71253c5c7@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From b5a71253c5c7e1139eab2f3e1e13e0bf2cbcaac7 Mon Sep 17 00:00:00 2001
From: Chao Yu <chao@kernel.org>
Date: Thu, 10 Sep 2026 02:20:26 +0000
Subject: [PATCH] f2fs: fix to avoid folio->mapping dereference in is_{meta,
 node}_folio()

Otherwise, it may cause NULL pointer dereference in race condition:

Thread A			Thread B
				- f2fs_setattr
				 - f2fs_truncate
				  - f2fs_truncate_blocks
			    	   - f2fs_do_truncate_blocks
				    - f2fs_truncate_inode_blocks
				     - truncate_dnode
				      - truncate_node
				       - invalidate_mapping_pages
				        - folio->mapping = NULL
- folio_lock
- is_node_folio
 - F2FS_F_SB(folio): dereference on folio->mapping

Cc: stable@kernel.org
Fixes: 019a8912425e ("f2fs: introduce is_{meta,node}_folio")
Reported-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Closes: https://lore.kernel.org/linux-f2fs-devel/c5d29b31-e764-4782-9639-be84b1b2bfc2@kernel.org
Signed-off-by: Chao Yu <chao@kernel.org>
Reviewed-by: Zhiguo Niu <zhiguo.niu@unisoc.com>
Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>
---
 fs/f2fs/checkpoint.c |  4 ++--
 fs/f2fs/data.c       |  7 ++++---
 fs/f2fs/f2fs.h       | 10 +++++-----
 fs/f2fs/gc.c         |  2 +-
 fs/f2fs/node.c       | 22 +++++++++++-----------
 fs/f2fs/segment.c    |  2 +-
 6 files changed, 24 insertions(+), 23 deletions(-)

diff --git a/fs/f2fs/checkpoint.c b/fs/f2fs/checkpoint.c
index dffd63eedea89..e95cd2118750f 100644
--- a/fs/f2fs/checkpoint.c
+++ b/fs/f2fs/checkpoint.c
@@ -291,7 +291,7 @@ static struct folio *__get_meta_folio(struct f2fs_sb_info *sbi, pgoff_t index,
 	f2fs_update_iostat(sbi, NULL, FS_META_READ_IO, F2FS_BLKSIZE(sbi));
 
 	folio_lock(folio);
-	if (unlikely(!is_meta_folio(folio))) {
+	if (unlikely(!is_meta_folio(sbi, folio))) {
 		f2fs_folio_put(folio, true);
 		goto repeat;
 	}
@@ -638,7 +638,7 @@ long f2fs_sync_meta_pages(struct f2fs_sb_info *sbi, long nr_to_write,
 
 			folio_lock(folio);
 
-			if (unlikely(!is_meta_folio(folio))) {
+			if (unlikely(!is_meta_folio(sbi, folio))) {
 continue_unlock:
 				folio_unlock(folio);
 				continue;
diff --git a/fs/f2fs/data.c b/fs/f2fs/data.c
index 87010db21bc9f..a3b02c067e89b 100644
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@ -172,7 +172,8 @@ static void f2fs_finish_read_bio(struct bio *bio, bool in_task)
 			dec_page_count(F2FS_F_SB(folio), __read_io_type(folio));
 
 		if (bio->bi_status == BLK_STS_OK &&
-			F2FS_F_SB(folio)->node_inode && is_node_folio(folio) &&
+			F2FS_F_SB(folio)->node_inode &&
+			is_node_folio(F2FS_F_SB(folio), folio) &&
 			f2fs_sanity_check_node_footer(F2FS_F_SB(folio),
 				folio, folio->index, NODE_TYPE_REGULAR, true))
 			bio->bi_status = BLK_STS_IOERR;
@@ -359,12 +360,12 @@ static void f2fs_write_end_bio(struct bio *bio)
 			}
 		}
 
-		if (is_node_folio(folio)) {
+		if (is_node_folio(sbi, folio)) {
 			f2fs_sanity_check_node_footer(sbi, folio,
 				folio->index, NODE_TYPE_REGULAR, true);
 			f2fs_bug_on(sbi, folio->index != nid_of_node(sbi, folio));
 		}
-		if (f2fs_in_warm_node_list(folio))
+		if (f2fs_in_warm_node_list(sbi, folio))
 			f2fs_del_fsync_node_entry(sbi, folio);
 
 		dec_page_count(sbi, type);
diff --git a/fs/f2fs/f2fs.h b/fs/f2fs/f2fs.h
index 66443d770a6c4..6b40a74448ebf 100644
--- a/fs/f2fs/f2fs.h
+++ b/fs/f2fs/f2fs.h
@@ -2371,14 +2371,14 @@ static inline struct address_space *NODE_MAPPING(struct f2fs_sb_info *sbi)
 	return sbi->node_inode->i_mapping;
 }
 
-static inline bool is_meta_folio(struct folio *folio)
+static inline bool is_meta_folio(struct f2fs_sb_info *sbi, struct folio *folio)
 {
-	return folio->mapping == META_MAPPING(F2FS_F_SB(folio));
+	return folio->mapping == META_MAPPING(sbi);
 }
 
-static inline bool is_node_folio(struct folio *folio)
+static inline bool is_node_folio(struct f2fs_sb_info *sbi, struct folio *folio)
 {
-	return folio->mapping == NODE_MAPPING(F2FS_F_SB(folio));
+	return folio->mapping == NODE_MAPPING(sbi);
 }
 
 static inline bool is_sbi_flag_set(struct f2fs_sb_info *sbi, unsigned int type)
@@ -4063,7 +4063,7 @@ enum node_type;
 
 int f2fs_check_nid_range(struct f2fs_sb_info *sbi, nid_t nid);
 bool f2fs_available_free_memory(struct f2fs_sb_info *sbi, int type);
-bool f2fs_in_warm_node_list(struct folio *folio);
+bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct folio *folio);
 void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi);
 void f2fs_del_fsync_node_entry(struct f2fs_sb_info *sbi, struct folio *folio);
 void f2fs_reset_fsync_node_info(struct f2fs_sb_info *sbi);
diff --git a/fs/f2fs/gc.c b/fs/f2fs/gc.c
index aedb45c8ee4a1..c70deac9f1a31 100644
--- a/fs/f2fs/gc.c
+++ b/fs/f2fs/gc.c
@@ -1431,7 +1431,7 @@ static int move_data_block(struct inode *inode, block_t bidx,
 						F2FS_BLKSIZE(fio.sbi));
 
 		folio_lock(mfolio);
-		if (unlikely(!is_meta_folio(mfolio) ||
+		if (unlikely(!is_meta_folio(fio.sbi, mfolio) ||
 			     !folio_test_uptodate(mfolio))) {
 			err = -EIO;
 			f2fs_folio_put(mfolio, true);
diff --git a/fs/f2fs/node.c b/fs/f2fs/node.c
index 8c150d4966e54..f16144b75d119 100644
--- a/fs/f2fs/node.c
+++ b/fs/f2fs/node.c
@@ -332,10 +332,10 @@ static unsigned int __gang_lookup_nat_set(struct f2fs_nm_info *nm_i,
 							start, nr);
 }
 
-bool f2fs_in_warm_node_list(struct folio *folio)
+bool f2fs_in_warm_node_list(struct f2fs_sb_info *sbi, struct folio *folio)
 {
-	return is_node_folio(folio) && IS_DNODE(F2FS_F_SB(folio), folio) &&
-					is_cold_node(F2FS_F_SB(folio), folio);
+	return is_node_folio(sbi, folio) && IS_DNODE(sbi, folio) &&
+					is_cold_node(sbi, folio);
 }
 
 void f2fs_init_fsync_node_info(struct f2fs_sb_info *sbi)
@@ -1296,7 +1296,7 @@ int f2fs_truncate_inode_blocks(struct inode *inode, pgoff_t from)
 			goto fail;
 		if (offset[1] == 0 && get_nid(sbi, folio, offset[0], true)) {
 			folio_lock(folio);
-			BUG_ON(!is_node_folio(folio));
+			BUG_ON(!is_node_folio(sbi, folio));
 			set_nid(sbi, folio, offset[0], 0, true);
 			folio_unlock(folio);
 		}
@@ -1612,7 +1612,7 @@ static struct folio *__get_node_folio(struct f2fs_sb_info *sbi, pgoff_t nid,
 
 	folio_lock(folio);
 
-	if (unlikely(!is_node_folio(folio))) {
+	if (unlikely(!is_node_folio(sbi, folio))) {
 		f2fs_folio_put(folio, true);
 		goto repeat;
 	}
@@ -1731,7 +1731,7 @@ static struct folio *last_fsync_dnode(struct f2fs_sb_info *sbi, nid_t ino)
 
 			folio_lock(folio);
 
-			if (unlikely(!is_node_folio(folio))) {
+			if (unlikely(!is_node_folio(sbi, folio))) {
 continue_unlock:
 				folio_unlock(folio);
 				continue;
@@ -1841,7 +1841,7 @@ static bool __write_node_folio(struct folio *folio, bool atomic, bool do_fsync,
 				f2fs_need_dentry_mark(sbi, ino_of_node(sbi, folio)));
 
 	/* should add to global list before clearing PAGECACHE status */
-	if (f2fs_in_warm_node_list(folio)) {
+	if (f2fs_in_warm_node_list(sbi, folio)) {
 		seq = f2fs_add_fsync_node_entry(sbi, folio);
 		if (seq_id)
 			*seq_id = seq;
@@ -1965,7 +1965,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 
 			folio_lock(folio);
 
-			if (unlikely(!is_node_folio(folio))) {
+			if (unlikely(!is_node_folio(sbi, folio))) {
 continue_unlock:
 				folio_unlock(folio);
 				continue;
@@ -2023,7 +2023,7 @@ int f2fs_fsync_node_pages(struct f2fs_sb_info *sbi, struct inode *inode,
 		f2fs_debug(sbi, "Retry to write fsync mark: ino=%u, idx=%lx",
 			   ino, last_folio->index);
 		folio_lock(last_folio);
-		if (unlikely(!is_node_folio(last_folio))) {
+		if (unlikely(!is_node_folio(sbi, last_folio))) {
 			f2fs_folio_put(last_folio, true);
 			ret = -EAGAIN;
 			goto out;
@@ -2101,7 +2101,7 @@ void f2fs_flush_inline_data(struct f2fs_sb_info *sbi)
 
 			folio_lock(folio);
 
-			if (unlikely(!is_node_folio(folio)))
+			if (unlikely(!is_node_folio(sbi, folio)))
 				goto unlock;
 			if (!folio_test_dirty(folio))
 				goto unlock;
@@ -2173,7 +2173,7 @@ int f2fs_sync_node_pages(struct f2fs_sb_info *sbi,
 			else if (!folio_trylock(folio))
 				continue;
 
-			if (unlikely(!is_node_folio(folio))) {
+			if (unlikely(!is_node_folio(sbi, folio))) {
 continue_unlock:
 				folio_unlock(folio);
 				continue;
diff --git a/fs/f2fs/segment.c b/fs/f2fs/segment.c
index 0b6267d0354e8..ffdd2c510b3cc 100644
--- a/fs/f2fs/segment.c
+++ b/fs/f2fs/segment.c
@@ -4161,7 +4161,7 @@ static void do_write_page(struct f2fs_summary *sum, struct f2fs_io_info *fio)
 			__func__, fio->ino, folio->index, type,
 			fio->old_blkaddr, fio->new_blkaddr, err);
 		folio_end_writeback(folio);
-		if (f2fs_in_warm_node_list(folio))
+		if (f2fs_in_warm_node_list(fio->sbi, folio))
 			f2fs_del_fsync_node_entry(fio->sbi, folio);
 		f2fs_bug_on(fio->sbi, !is_set_ckpt_flags(fio->sbi,
 							CP_ERROR_FLAG));
-- 
2.53.0




