Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341740;
	b=xF+9UAOsnzCANyfkWfA5/IwWvoFAITtPGYnengPaLu1EHFBsyjEi64K//zI9+zhddv3D
	 t72USBUgW40PvV+nxhgrs3tHguENJeCmAgxIRSjRBotgSWYYWZudvlGgx79Y97OJBwWCN
	 FyWiqx95BDnaQrJo0Cgr2ZOMaoPSchwBG8CTJNQZ2ANmOTylkYjOJAx+9hOqiAc41EroY
	 mQsqI8Bn03TOkpqiO0IfZIGtKSVvQR+PVVJAM4flEv+UOTPRKJnYTbrEzyXccQh27TVlf
	 G48I5BzmOpdq5vOPwShq4BpKVZsZaVlE7k5004GSi2iIljjwDAE2Sd4H2dI9hTA+FiA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341740;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vczfgf+2qd+jV8rWb1z5den8UTxn8X5vJoYyx5SQ9x0=;
	b=W3DZkUkbhDwmRs94MRDrTKlheKqehhfDnU/q6FzHKtHyxa/cIAwPewpYG2B89s2Wy2gd
	 q4kMrGLqcVB2bisTes72U7vLZTdQSw2KqQsAVvizz9NDIBPPUR5Y0plvqCQZnuTMpf9zT
	 CObtMyCnXVcOOxd/Fm8KIyjqn8Hj/cj6o7clbBqXRah7mgfK5t5nSnJALTI6wLvInfQQL
	 M8qjgRPF2EBspoTogN/tlt7TbsSpGSTzKXGGQtR2+0279X1r+yFn/blUAdxE8fwIqmF9B
	 +yUY2Ku9zkjqbaZs1mz6sNPpiP/wNH7M7pYKHfJ2ytnALxWTsGcGxgpgH+RpV+/pv5A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEOmdy+2;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0BFA1606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:15:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aEOmdy+2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 268261F008A1;
	Tue, 10 Nov 2026 20:15:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794341739;
	bh=vczfgf+2qd+jV8rWb1z5den8UTxn8X5vJoYyx5SQ9x0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aEOmdy+2MDDIj9+V4gKTNc7oGIFuD6DL5u4y3Z8tLTiBRe1O9oSxeJXk22CrqUNx7
	 Qj77WSjKtYEkOu4jMnxBkAwVNUFzs5O3ZxonLfaneT2FFsmY3z5twggx8nNIdeqQko
	 RUDEDCJP9bucbCGoTY2VBUdbwoY1bZPK8Qt5ztzuKXU8f87Pt/vZwOx2Kuy6Wsrjxk
	 vKTVP9W6eetACopPYsFVt9EQ7EuFzWeIfIiUvcISfYoeX7PPD22XEJ2SiWrk4yXjt/
	 upZslHFRseoS4aJ5ew7WaNwVP/uEGmMTsiRnvLQ5U4IYa9Ln+5r8ukmdQ0FxOqWGfH
	 wgto4Rlr43+Kw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiaming Zhang <r772577952@gmail.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] nilfs2: force clear dirty state when restoring from the shadow map
Date: Tue, 10 Nov 2026 15:15:37 -0500
Message-ID: <20261110201512.3716489-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055906-failed-5.15-cb6702e63e0a@kernel.org>
References: <20261107055906-failed-5.15-cb6702e63e0a@kernel.org>
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
[ sashal: Adapted folio-based changes to page helpers, with false passed by the older nilfs_writepage() caller. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/inode.c |  4 ++--
 fs/nilfs2/mdt.c   |  6 +++---
 fs/nilfs2/page.c  | 50 +++++++++++++++++++++++++++--------------------
 fs/nilfs2/page.h  |  4 ++--
 4 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index ee082c2c6e896..3bba978abd29b 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -162,7 +162,7 @@ static int nilfs_writepages(struct address_space *mapping,
 	int err = 0;
 
 	if (sb_rdonly(inode->i_sb)) {
-		nilfs_clear_dirty_pages(mapping);
+		nilfs_clear_dirty_pages(mapping, false);
 		return -EROFS;
 	}
 
@@ -185,7 +185,7 @@ static int nilfs_writepage(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page);
+		nilfs_clear_dirty_page(page, false);
 		unlock_page(page);
 		return -EROFS;
 	}
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 8156d2b5ec6ce..bd3e0f9144ff0 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -410,7 +410,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page);
+		nilfs_clear_dirty_page(page, false);
 		unlock_page(page);
 		return -EROFS;
 	}
@@ -632,10 +632,10 @@ void nilfs_mdt_restore_from_shadow_map(struct inode *inode)
 	if (mi->mi_palloc_cache)
 		nilfs_palloc_clear_cache(inode);
 
-	nilfs_clear_dirty_pages(inode->i_mapping);
+	nilfs_clear_dirty_pages(inode->i_mapping, true);
 	nilfs_copy_back_pages(inode->i_mapping, shadow->inode->i_mapping);
 
-	nilfs_clear_dirty_pages(ii->i_assoc_inode->i_mapping);
+	nilfs_clear_dirty_pages(ii->i_assoc_inode->i_mapping, true);
 	nilfs_copy_back_pages(ii->i_assoc_inode->i_mapping,
 			      NILFS_I(shadow->inode)->i_assoc_inode->i_mapping);
 
diff --git a/fs/nilfs2/page.c b/fs/nilfs2/page.c
index ce5947cf4bd51..55dfd243cda0e 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -354,8 +354,9 @@ void nilfs_copy_back_pages(struct address_space *dmap,
 /**
  * nilfs_clear_dirty_pages - discard dirty pages in address space
  * @mapping: address space with dirty pages for discarding
+ * @force: whether to clear the dirty state regardless of busy buffer heads
  */
-void nilfs_clear_dirty_pages(struct address_space *mapping)
+void nilfs_clear_dirty_pages(struct address_space *mapping, bool force)
 {
 	struct pagevec pvec;
 	unsigned int i;
@@ -376,7 +377,7 @@ void nilfs_clear_dirty_pages(struct address_space *mapping)
 			 * was acquired.  Skip processing in that case.
 			 */
 			if (likely(page->mapping == mapping))
-				nilfs_clear_dirty_page(page);
+				nilfs_clear_dirty_page(page, force);
 
 			unlock_page(page);
 		}
@@ -388,13 +389,16 @@ void nilfs_clear_dirty_pages(struct address_space *mapping)
 /**
  * nilfs_clear_dirty_page - discard dirty page
  * @page: dirty page that will be discarded
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
-void nilfs_clear_dirty_page(struct page *page)
+void nilfs_clear_dirty_page(struct page *page, bool force)
 {
 	BUG_ON(!PageLocked(page));
 
@@ -405,24 +409,28 @@ void nilfs_clear_dirty_page(struct page *page)
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
index a5b9b5a457ab2..be2d089748d8c 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -41,8 +41,8 @@ void nilfs_page_bug(struct page *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
-void nilfs_clear_dirty_page(struct page *page);
-void nilfs_clear_dirty_pages(struct address_space *mapping);
+void nilfs_clear_dirty_page(struct page *page, bool force);
+void nilfs_clear_dirty_pages(struct address_space *mapping, bool force);
 void nilfs_mapping_init(struct address_space *mapping, struct inode *inode);
 unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
 					    unsigned int);
-- 
2.53.0

