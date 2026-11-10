Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794339697;
	b=DRY538H8e6A3rq7BVAwMqdYkdzTY4DmiVpvyJ+Skwgae0cHRYR14d0duWoDb8Xzpmjxt
	 RoCah6ZBQk2f1VeXJB4wi1Z70qZL1pjwbibIJZnwnxhHTY3c+DP/CP1LnI/SWT7aPzJRb
	 xUvB732yXMTjtu4Weatwwv3Lt2kkxVEZJfsjmFzeOknsHnGbLwgGQenZfOhW26Ekl86kL
	 rcPpfcjoeeqHQz6dhc8/mumMJLwwOx64HKcDNNK/lZ2ua6hwsdhmrbYCT04vmzaHDX9Kk
	 u2U/E3Vhndk7ncOS7wjr+teTKqophIqDM5wXEfync/kHDwiAz/80Fxl+NzHQSHiq4dA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794339697;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=DpmgAT1XZ85JchZmurn/0ljS8KxaszwvT6tzeK0uvJo=;
	b=GvFxqiIZ3qQXrJHwb43ZDaHrBR+eWKlgVVwSBjW9Ww9F1x46beGMgHcbFnQLp1SDBqOF
	 wX3UK6zYzeIE9yKif5BQfbi2pFHqgHLDlxJHk6IgLXjeewL9xhICnaiuenYoGbJOgqouy
	 GAzE7aANb2amvuhK7QDcH4UbXWXc6FJID1lPxnZj9zaWlAGbepIxO3U26Tp6huXjadMfp
	 Ensn9fJGiUgx++UyPsBalY1sjoDlKTOp8ye17UPeOm2Wi4AEiT2oKIMB0/JcU6qtDJn00
	 gGQNF2a+MSE7qREv2EumNTp83Zb35MpoEV/lkddopUH8B6iCnm+nqTAM0fDPISS25ZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="VKudkYB/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A1A6606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:41:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VKudkYB/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DF741F0089F;
	Tue, 10 Nov 2026 19:41:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794339697;
	bh=DpmgAT1XZ85JchZmurn/0ljS8KxaszwvT6tzeK0uvJo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VKudkYB/ImeeyaT07iHoMnUgrfLWuDsi5MlwqWWBCZCXzOrhjTSdD3gt993SwRPd6
	 jsRIgabwBmFbfdpYniQO4OTBnUzugmLRZXYS9qhy7GEYzqjnxLQAjp4lX7nxvBZpvm
	 +Pw7HX2UiHfSAiwx7gljN3FjUcGtK+GfewlKkouZ2lf4vEufHsj7DBrERJuYY0PY/W
	 A8rQRnPZANlqQnaHR5EUy8lOJ+N1Ci6+/wZoYAYLQ+rvDVHGsUvirdeY4Pzh8uamj1
	 H2HkbOj6h3bwcYm1oTU2QD/xfik45P7LCqGSgIDk+or4qvX6jbRE/Tm+PAKtTMbW8y
	 TZ7pOej4qUNMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiaming Zhang <r772577952@gmail.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] nilfs2: force clear dirty state when restoring from the shadow map
Date: Tue, 10 Nov 2026 14:41:34 -0500
Message-ID: <20261110194015.3594251-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052932-failed-6.6-cb6702e63e0a@kernel.org>
References: <20261107052932-failed-6.6-cb6702e63e0a@kernel.org>
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

From: Jiaming Zhang <r772577952@gmail.com>

[ Upstream commit cb6702e63e0a16afd83875294e5ce53becdd1b1f ]

When garbage collection fails, nilfs2 rolls the DAT metadata file's page
cache back to a shadow copy taken before GC started.
nilfs_clear_dirty_pages() drops the dirty state of the folios in the DAT
cache, then nilfs_copy_back_pages() overwrites them with the saved
contents and warns if one is still dirty:

	/* overwrite existing folio in the destination cache */
	WARN_ON(folio_test_dirty(dfolio));

nilfs_clear_dirty_pages() used to clear the dirty state unconditionally,
which is safe here because the rollback runs with the log writer
stopped, so nothing else can dirty the cache while it runs.  The same
helper is also used when writeback finds dirty folios after the
filesystem has degraded to read-only, where it does run concurrently
with the log writer, so commit ca76bb226bf4 ("nilfs2: do not force clear
folio if buffer is referenced") made nilfs_clear_folio_dirty() skip a
folio if any of its buffer heads is busy.  The rollback caller shares
that helper, so its clearing step can now return with a folio still
dirty.

A DAT folio can hold a busy buffer head without anyone modifying the
folio: nilfs_mdt_read_block() submits read-ahead for the blocks
following the one it was asked for and waits only for the first, so the
read-ahead buffers are still locked when it returns.  With a block size
smaller than the page size, a locked read-ahead buffer can share a folio
with a block that GC dirtied and keep the whole folio dirty past the
clearing step.

Add a force flag to nilfs_clear_dirty_pages() and
nilfs_clear_folio_dirty() that skips the busy buffer check, and set it
in the two calls from nilfs_mdt_restore_from_shadow_map().  The
read-only fallback callers keep passing false, so that commit still
protects them and the WARN_ON() is left alone.

Fixes: ca76bb226bf4 ("nilfs2: do not force clear folio if buffer is referenced")
Closes: https://lore.kernel.org/lkml/CANypQFZSYrtcshnUzOPiqatyLd-M8_OReOewQoAi_V5yY0dTtg@mail.gmail.com/
Cc: stable@vger.kernel.org
Suggested-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Assisted-by: Claude Code:claude-opus-5
Signed-off-by: Jiaming Zhang <r772577952@gmail.com>
Acked-by: Ryusuke Konishi <konishi.ryusuke@gmail.com>
Signed-off-by: Viacheslav Dubeyko <slava@dubeyko.com>
[ sashal: adapted nilfs_clear_folio_dirty() to nilfs_clear_dirty_page() while preserving the separate silent argument ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/inode.c |  4 ++--
 fs/nilfs2/mdt.c   |  6 +++---
 fs/nilfs2/page.c  | 51 ++++++++++++++++++++++++++++-------------------
 fs/nilfs2/page.h  |  5 +++--
 4 files changed, 38 insertions(+), 28 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 410da542a3b90..ec5d3e82f52e0 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -162,7 +162,7 @@ static int nilfs_writepages(struct address_space *mapping,
 	int err = 0;
 
 	if (sb_rdonly(inode->i_sb)) {
-		nilfs_clear_dirty_pages(mapping, false);
+		nilfs_clear_dirty_pages(mapping, false, false);
 		return -EROFS;
 	}
 
@@ -185,7 +185,7 @@ static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page, false);
+		nilfs_clear_dirty_page(page, false, false);
 		unlock_page(page);
 		return -EROFS;
 	}
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 75a2ed5ee6e09..c0c1e217bd384 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -411,7 +411,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page, false);
+		nilfs_clear_dirty_page(page, false, false);
 		unlock_page(page);
 		return -EROFS;
 	}
@@ -634,10 +634,10 @@ void nilfs_mdt_restore_from_shadow_map(struct inode *inode)
 	if (mi->mi_palloc_cache)
 		nilfs_palloc_clear_cache(inode);
 
-	nilfs_clear_dirty_pages(inode->i_mapping, true);
+	nilfs_clear_dirty_pages(inode->i_mapping, true, true);
 	nilfs_copy_back_pages(inode->i_mapping, shadow->inode->i_mapping);
 
-	nilfs_clear_dirty_pages(ii->i_assoc_inode->i_mapping, true);
+	nilfs_clear_dirty_pages(ii->i_assoc_inode->i_mapping, true, true);
 	nilfs_copy_back_pages(ii->i_assoc_inode->i_mapping,
 			      NILFS_I(shadow->inode)->i_assoc_inode->i_mapping);
 
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index 2dbf74936a7ed..c664cf867e9d6 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -370,8 +370,10 @@ void nilfs_copy_back_pages(struct address_space *dmap,
  * nilfs_clear_dirty_pages - discard dirty pages in address space
  * @mapping: address space with dirty pages for discarding
  * @silent: suppress [true] or print [false] warning messages
+ * @force: whether to clear the dirty state regardless of busy buffer heads
  */
-void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
+void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent,
+			     bool force)
 {
 	struct folio_batch fbatch;
 	unsigned int i;
@@ -392,7 +394,7 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
 			 * was acquired.  Skip processing in that case.
 			 */
 			if (likely(folio->mapping == mapping))
-				nilfs_clear_dirty_page(&folio->page, silent);
+				nilfs_clear_dirty_page(&folio->page, silent, force);
 
 			folio_unlock(folio);
 		}
@@ -405,13 +407,16 @@ void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent)
  * nilfs_clear_dirty_page - discard dirty page
  * @page: dirty page that will be discarded
  * @silent: suppress [true] or print [false] warning messages
+ * @force: whether to clear the states regardless of busy buffer heads
  *
  * nilfs_clear_dirty_page() clears working states including dirty state for
- * the page and its buffers.  If the page has buffers, clear only if it is
- * confirmed that none of the buffer heads are busy (none have valid
- * references and none are locked).
+ * the page and its buffers.  If the page has buffers and force is false,
+ * clear only if it is confirmed that none of the buffer heads are busy (none
+ * have valid references and none are locked).  If force is true, the states
+ * are cleared unconditionally, the caller should guarantee that the page is
+ * not being modified concurrently.
  */
-void nilfs_clear_dirty_page(struct page *page, bool silent)
+void nilfs_clear_dirty_page(struct page *page, bool silent, bool force)
 {
 	struct inode *inode = page->mapping->host;
 	struct super_block *sb = inode->i_sb;
@@ -429,24 +434,28 @@ void nilfs_clear_dirty_page(struct page *page, bool silent)
 			 BIT(BH_Async_Write) | BIT(BH_NILFS_Volatile) |
 			 BIT(BH_NILFS_Checked) | BIT(BH_NILFS_Redirected) |
 			 BIT(BH_Delay));
-		bool busy, invalidated = false;
+
+		if (!force) {
+			bool busy, invalidated = false;
 
 recheck_buffers:
-		busy = false;
-		bh = head;
-		do {
-			if (atomic_read(&bh->b_count) | buffer_locked(bh)) {
-				busy = true;
-				break;
+			busy = false;
+			bh = head;
+			do {
+				if (atomic_read(&bh->b_count) |
+				    buffer_locked(bh)) {
+					busy = true;
+					break;
+				}
+			} while (bh = bh->b_this_page, bh != head);
+
+			if (busy) {
+				if (invalidated)
+					return;
+				invalidate_bh_lrus();
+				invalidated = true;
+				goto recheck_buffers;
 			}
-		} while (bh = bh->b_this_page, bh != head);
-
-		if (busy) {
-			if (invalidated)
-				return;
-			invalidate_bh_lrus();
-			invalidated = true;
-			goto recheck_buffers;
 		}
 
 		bh = head;
diff --git a/fs/nilfs2/page.h b/fs/nilfs2/page.h
index bff6257ef83bd..bce9a1b5c8f02 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -41,8 +41,9 @@ void nilfs_folio_bug(struct folio *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
-void nilfs_clear_dirty_page(struct page *, bool);
-void nilfs_clear_dirty_pages(struct address_space *, bool);
+void nilfs_clear_dirty_page(struct page *page, bool silent, bool force);
+void nilfs_clear_dirty_pages(struct address_space *mapping, bool silent,
+			     bool force);
 unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
 					    unsigned int);
 unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
-- 
2.53.0

