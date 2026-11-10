Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794338953;
	b=YQ9Lkud/AXWsqslKQSEeElyKsN80ZKbBkANkYrXc6djhrke4pIP5wlRXQZY7YdqS+6ZE
	 L5rZ6Fbpz50ff9kSnC/YNotl1QfoYrOlKqj4k3UkKmlicFEfy51JOTHR1Slf4Om0pKIPc
	 3RxRQBrQc3XOomv8KoFcHKyrH0Ogpdbz2fltRRAtg8sCfLS+/5T2G+1XGcJcGq4AdDvcm
	 B5LQH7LDB15eTAEPZYWgFKww6YCcP/xunYXBmKjylPm6CmaFG0pVf4Ncm6k5EapPM4DEq
	 pBfBICwtnuQX0XmYr4WHAoDEOe814f72zv/GhqxIe/99tN3WaIkdYPQIy8sMa77PHhw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794338953;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=2TNzIW54SauXSHaa0U31xdEo1BlCgGCBv/37wGAZMfQ=;
	b=rAVkROOdZKP7MZTG+RLmR5pMxzVZQ4BZMbwBIBH4tpPXjl6M1WdITP5hqtSMxO3TlvfG
	 JY/UOXhqR+iNkhY2NWi2wfnfVFJiFC+EmCf+A62zDa7O9PW+s1aMeITJdEVglop7z2QbS
	 AMGQqdjDi+JPzYyFeJyGWreSwlh59oc6BAsckIsnWbN+IH5Zs5cjFrOM7kMmRuMSHZhA1
	 icF/GSe29PuoVriWAgpHlYRAd2FdJmsRYwN0eMKG3deZRIOO2dVa9/oofMLuuOeS+aVdS
	 htQH5cOn2Pp1cQ8UkbZIdrc9fgp6JN5wwk3FCw0QnoGwmlNNQ0GbJF7YrUM+DvQutlA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJuI8EKf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32601606A32E
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:29:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cJuI8EKf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A067F1F008A7;
	Tue, 10 Nov 2026 19:29:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794338952;
	bh=2TNzIW54SauXSHaa0U31xdEo1BlCgGCBv/37wGAZMfQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cJuI8EKfri5eCkbfT+nKjYD0Dj5h5rFhfmYk/JpI0Juew1YsPsSsg5ZfoOGW4Q3g2
	 PYbd1r3mZamN36nBZXpAp9F6vXtkQ04CMChPXLCa4t1hD/BWdvUwWU13cQBi0VHLlZ
	 FRN86BqpB7WlbVNSiSi1IBQ3Jce38AKyIz3B2ljoVvX1rRzvKMcvbkyw0nq66xUdv2
	 zmjyrp53s0lVpZEovllJ0V/dcx95dKBmcKtsTm/gGyU5Dhyf1ToliKaLZs/+DXrVxN
	 QcCbToTBOhWpLcvx/OSO+28h78Ve5IFPQyh/ZXsSbFQvr29CGIzAiqertHglYTSXuK
	 7zHiHQH6TrgRA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiaming Zhang <r772577952@gmail.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] nilfs2: force clear dirty state when restoring from the shadow map
Date: Tue, 10 Nov 2026 14:29:07 -0500
Message-ID: <20261110192816.3526676-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110192816.3526676-1-sashal@kernel.org>
References: <20261107051714-failed-6.12-cb6702e63e0a@kernel.org>
 <20261110192816.3526676-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/inode.c |  2 +-
 fs/nilfs2/mdt.c   |  6 +++---
 fs/nilfs2/page.c  | 50 +++++++++++++++++++++++++++--------------------
 fs/nilfs2/page.h  |  4 ++--
 4 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index dcae6745ccd29..f8d15292ab051 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -159,7 +159,7 @@ static int nilfs_writepages(struct address_space *mapping,
 	int err = 0;
 
 	if (sb_rdonly(inode->i_sb)) {
-		nilfs_clear_dirty_pages(mapping);
+		nilfs_clear_dirty_pages(mapping, false);
 		return -EROFS;
 	}
 
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 2db6350b5ac2a..8e66f2c13ad65 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -410,7 +410,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 		 * have dirty folios that try to be flushed in background.
 		 * So, here we simply discard this dirty folio.
 		 */
-		nilfs_clear_folio_dirty(folio);
+		nilfs_clear_folio_dirty(folio, false);
 		folio_unlock(folio);
 		return -EROFS;
 	}
@@ -637,10 +637,10 @@ void nilfs_mdt_restore_from_shadow_map(struct inode *inode)
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
index 012ade1714e60..2fc49a26d0b05 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -371,8 +371,9 @@ void nilfs_copy_back_pages(struct address_space *dmap,
 /**
  * nilfs_clear_dirty_pages - discard dirty pages in address space
  * @mapping: address space with dirty pages for discarding
+ * @force: whether to clear the dirty state regardless of busy buffer heads
  */
-void nilfs_clear_dirty_pages(struct address_space *mapping)
+void nilfs_clear_dirty_pages(struct address_space *mapping, bool force)
 {
 	struct folio_batch fbatch;
 	unsigned int i;
@@ -393,7 +394,7 @@ void nilfs_clear_dirty_pages(struct address_space *mapping)
 			 * was acquired.  Skip processing in that case.
 			 */
 			if (likely(folio->mapping == mapping))
-				nilfs_clear_folio_dirty(folio);
+				nilfs_clear_folio_dirty(folio, force);
 
 			folio_unlock(folio);
 		}
@@ -405,13 +406,16 @@ void nilfs_clear_dirty_pages(struct address_space *mapping)
 /**
  * nilfs_clear_folio_dirty - discard dirty folio
  * @folio: dirty folio that will be discarded
+ * @force: whether to clear the states regardless of busy buffer heads
  *
  * nilfs_clear_folio_dirty() clears working states including dirty state for
- * the folio and its buffers.  If the folio has buffers, clear only if it is
- * confirmed that none of the buffer heads are busy (none have valid
- * references and none are locked).
+ * the folio and its buffers.  If the folio has buffers and force is false,
+ * clear only if it is confirmed that none of the buffer heads are busy (none
+ * have valid references and none are locked).  If force is true, the states
+ * are cleared unconditionally, the caller should guarantee that the folio is
+ * not being modified concurrently.
  */
-void nilfs_clear_folio_dirty(struct folio *folio)
+void nilfs_clear_folio_dirty(struct folio *folio, bool force)
 {
 	struct buffer_head *bh, *head;
 
@@ -424,24 +428,28 @@ void nilfs_clear_folio_dirty(struct folio *folio)
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
index 136cd1c143c9c..c3ba3468af5cb 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -41,8 +41,8 @@ void nilfs_folio_bug(struct folio *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
-void nilfs_clear_folio_dirty(struct folio *folio);
-void nilfs_clear_dirty_pages(struct address_space *mapping);
+void nilfs_clear_folio_dirty(struct folio *folio, bool force);
+void nilfs_clear_dirty_pages(struct address_space *mapping, bool force);
 unsigned int nilfs_page_count_clean_buffers(struct folio *folio,
 		unsigned int from, unsigned int to);
 unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
-- 
2.53.0

