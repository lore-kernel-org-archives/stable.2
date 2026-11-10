Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340792;
	b=jB7ZMQDnOfUQu/DmpYlEk+SUKlleG+PqXCYfOjKXVur1i1WvNO/tX8eROj0s1UwMJKIL
	 d9HI1zf1ieRlRU/AwlC9LF3Gvqi/29BvL3IvQ8zOoG9qSN9tyUx1WqxINsV1V1abNaepN
	 E8rJgg4zOH5A0EhSEqfe111+0y6QrURRWoq9vHUN+MVI+O6NjZ5P5qAcC5LUocBwKL2TP
	 oa0t6vE05LSU5SxU61i8kPrnXOtlLBjbyPjDqjFuJ/IROvmJL8snZIYnAP8R9zI7k9EBC
	 vzR3dC9uYn6qJV3N1isnHy1iiTcOQBoYWW3wVsuCuZgPxKcWB11mXyXjhTV+KlASxkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340792;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=x+2CLNyHymFpK9gLBX1cnF+xwtanizdDf20EwtpXHJE=;
	b=AQWsC+SMBL5vFjN2bQ8l71sacmlhLTvaKbGWX9MB/bIb2noGPG8YaVMq6W8zV7bVQoy+
	 pKrJ5rCkZxvRh2I1n8IxlvpSFXgUNosjLxqx7HmnTqmu41Nkj8v1IC3tCWKx7I3kOOIP/
	 NLhsweW/rEK2oSbFNU+Rn7DXtU4Pxzx+NGBXXFAY/6DuSvvkIIE+yceFwOaxOGYJv0E0Q
	 MM5sv+hy3LNlivDtOKrOP4tsElaR+ABnAuIcNYwupme88JzJeRDRy5V3gcTfjWN8+gsyh
	 ixvV9chFRPBbNvb0GY1PtqVo5fz/JLjjKk1tKtdHhNPwK1KZxBQ8LXr7YG7iqpqDNdw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pjs9liJm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41796606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:59:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pjs9liJm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 38DED1F0089F;
	Tue, 10 Nov 2026 19:59:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794340791;
	bh=x+2CLNyHymFpK9gLBX1cnF+xwtanizdDf20EwtpXHJE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pjs9liJmLbYAMlUEpwVie5VNzn/A3vFLUnFHyWHLZYn3l9XxiXPiBu9RCGiu8Zrdd
	 JrE++QlgREc6BjK5YtXCSUzV4PnLv8/l0IC0LDFrUnEqwX26JqmD06dxQPfYCgWKj+
	 s1ZddfbVFL7O4cSABP65wn2+pWkTs5fQRtP0aDfLHHIN0J+NYeihZGtJja8+RpYI4G
	 91i5lzFrPTNK70Hm9+UZE9DvtViWRGWxxD10xA5zeQwjJNUK8HUUmSgssmJvH5KDYY
	 oUK79zGalX+iY03Ogl81u6Lhy1SaKtWxa1ZTd6sPK6350wM1r68uezsJcO4oTOwWh8
	 D1ERjc/IkTixw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiaming Zhang <r772577952@gmail.com>,
	Ryusuke Konishi <konishi.ryusuke@gmail.com>,
	Viacheslav Dubeyko <slava@dubeyko.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] nilfs2: force clear dirty state when restoring from the shadow map
Date: Tue, 10 Nov 2026 14:59:49 -0500
Message-ID: <20261110195825.3646235-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054214-failed-6.1-cb6702e63e0a@kernel.org>
References: <20261107054214-failed-6.1-cb6702e63e0a@kernel.org>
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
[ sashal: adapted folio-based changes to page APIs, including the retained nilfs_writepage() caller’s new argument ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/nilfs2/inode.c |  4 ++--
 fs/nilfs2/mdt.c   |  6 +++---
 fs/nilfs2/page.c  | 50 +++++++++++++++++++++++++++--------------------
 fs/nilfs2/page.h  |  4 ++--
 4 files changed, 36 insertions(+), 28 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index a20d52951f1ef..4a6da06d3286c 100644
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
index 233954e224487..d0808953296ac 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -411,7 +411,7 @@ nilfs_mdt_write_page(struct page *page, struct writeback_control *wbc)
 		 * have dirty pages that try to be flushed in background.
 		 * So, here we simply discard this dirty page.
 		 */
-		nilfs_clear_dirty_page(page);
+		nilfs_clear_dirty_page(page, false);
 		unlock_page(page);
 		return -EROFS;
 	}
@@ -634,10 +634,10 @@ void nilfs_mdt_restore_from_shadow_map(struct inode *inode)
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
index 89cd1510bf715..a49ca08b9fcc2 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -367,8 +367,9 @@ void nilfs_copy_back_pages(struct address_space *dmap,
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
@@ -389,7 +390,7 @@ void nilfs_clear_dirty_pages(struct address_space *mapping)
 			 * was acquired.  Skip processing in that case.
 			 */
 			if (likely(page->mapping == mapping))
-				nilfs_clear_dirty_page(page);
+				nilfs_clear_dirty_page(page, force);
 
 			unlock_page(page);
 		}
@@ -401,13 +402,16 @@ void nilfs_clear_dirty_pages(struct address_space *mapping)
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
 
@@ -418,24 +422,28 @@ void nilfs_clear_dirty_page(struct page *page)
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
index f5432f6a2fb6f..1cf9f03ef725a 100644
--- a/fs/nilfs2/page.h
+++ b/fs/nilfs2/page.h
@@ -41,8 +41,8 @@ void nilfs_page_bug(struct page *);
 
 int nilfs_copy_dirty_pages(struct address_space *, struct address_space *);
 void nilfs_copy_back_pages(struct address_space *, struct address_space *);
-void nilfs_clear_dirty_page(struct page *page);
-void nilfs_clear_dirty_pages(struct address_space *mapping);
+void nilfs_clear_dirty_page(struct page *page, bool force);
+void nilfs_clear_dirty_pages(struct address_space *mapping, bool force);
 unsigned int nilfs_page_count_clean_buffers(struct page *, unsigned int,
 					    unsigned int);
 unsigned long nilfs_find_uncommitted_extent(struct inode *inode,
-- 
2.53.0

