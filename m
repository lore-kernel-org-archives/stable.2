Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047374;
	b=Utkax+3IflTH8eCClnGBsfj/L6zGpX0cmV8NF/vak5c/dprK+SzrfeK57l8o3NKP8LMP
	 i+p4dIlJOeZxel63ybq4Bj0ejHcok80LJw/q/aRPlLwHl2qD2oQRvm3HuyJ7VVxYRrtjn
	 012riC+BAMItcla+uBAIm/qjKJDiWeHUu813879olRbuL9CJBKHpTBgkqzo+iG5pAaKLl
	 OBQ1sQFJ57hB90jXhApaSHTwksfdDy5xmjOPKPIZoSJnNlTs7T4s2oVBySXYRwCaGFcMz
	 dbjQFBukqsIECxTD17LIHiAskg+5ErNH6RLrNGkIhBqeuZ+6L21CQr7S4jaWq+b1JXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047374;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=YBmndWmowyZWwRrLg78TCeTSeqD+fu6eBYBQmkxBiz4=;
	b=HurN3vIWzXdbbK7WkDbcdEl09cHk/7Nk4juw6dq+qcmeZRbtDVbQOWL4wsv/JCMg5mME
	 2nEaDEvTb7A2XjnaeoeKS6S+jJjgOQfs/tQ06PYB8cG58jkWMgVH5xEfu6C546cnfDhWt
	 E40mXrd/Jd3AT7is/wfJMU/15KU7XOHBvOg757IrKm5OSMIYEyVHe74pjM26cNzaMEWtD
	 gi/+1p5BIjfpFdeu7NalPDMftm5rkOuQEh/m6aXSJf/wR4D7Eta0CLDkX6zEc15fVe9Ub
	 YRD5ploe+bAFrW0biTKPZcyjIpVfmGr7fXaHBd9+EAkRZ1gHtrqPdyFhfNULrlXDFWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWKaeFBo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE5F606A32E
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:29:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LWKaeFBo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A754B1F0089F;
	Sat,  7 Nov 2026 10:29:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047374;
	bh=YBmndWmowyZWwRrLg78TCeTSeqD+fu6eBYBQmkxBiz4=;
	h=From:To:Cc:Subject:Date;
	b=LWKaeFBorvIF5aur4kpypDBXAuOsweGgc0UnFEk4CWTJ7M13Uqgom3TCWym5Rf505
	 FQZ+Iij51AIsu/TRTUXb0LKu2m7pSeVPwjm7XN36ciBeYIGNhRjjkE6E0ETG9VZLf1
	 yG44Ro6tQmcPDzsJ/ggE3xODhMRIEHuy9WF3rzYCbE1PQEXZlrKzlsAYVbAgVSL31V
	 HRr24LK+/CIj0T+ps7Hug/meQdIiFj40Dt4x35LIydqs8MLy/UndswQxqJBns+fW9x
	 sEmzh38g4HfdZcY70OBOoqSYhwiMvZgz+tlj0DIViINItbY0JWDlovBqMdXt1pcElZ
	 QVH+mSsrXUInA==
From: Sasha Levin <sashal@kernel.org>
To: r772577952@gmail.com,
	konishi.ryusuke@gmail.com,
	slava@dubeyko.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] nilfs2: force clear dirty state when restoring from the shadow map" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:29:32 -0500
Message-ID: <20261107052932-failed-6.6-cb6702e63e0a@kernel.org>
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

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x cb6702e63e0a16afd83875294e5ce53becdd1b1f
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107052932-failed-6.6-cb6702e63e0a@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From cb6702e63e0a16afd83875294e5ce53becdd1b1f Mon Sep 17 00:00:00 2001
From: Jiaming Zhang <r772577952@gmail.com>
Date: Wed, 2 Sep 2026 19:21:21 +0800
Subject: [PATCH] nilfs2: force clear dirty state when restoring from the
 shadow map

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
---
 fs/nilfs2/inode.c |  2 +-
 fs/nilfs2/mdt.c   |  6 +++---
 fs/nilfs2/page.c  | 50 +++++++++++++++++++++++++++--------------------
 fs/nilfs2/page.h  |  4 ++--
 4 files changed, 35 insertions(+), 27 deletions(-)

diff --git a/fs/nilfs2/inode.c b/fs/nilfs2/inode.c
index 778274203f4ca..cc2f67eca0562 100644
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@ -163,7 +163,7 @@ static int nilfs_writepages(struct address_space *mapping,
 	int err = 0;
 
 	if (sb_rdonly(inode->i_sb)) {
-		nilfs_clear_dirty_pages(mapping);
+		nilfs_clear_dirty_pages(mapping, false);
 		return -EROFS;
 	}
 
diff --git a/fs/nilfs2/mdt.c b/fs/nilfs2/mdt.c
index 2a435349fd219..b50c88b651839 100644
--- a/fs/nilfs2/mdt.c
+++ b/fs/nilfs2/mdt.c
@@ -405,7 +405,7 @@ static int nilfs_mdt_write_folio(struct folio *folio,
 		 * have dirty folios that try to be flushed in background.
 		 * So, here we simply discard this dirty folio.
 		 */
-		nilfs_clear_folio_dirty(folio);
+		nilfs_clear_folio_dirty(folio, false);
 		folio_unlock(folio);
 		return -EROFS;
 	}
@@ -648,10 +648,10 @@ void nilfs_mdt_restore_from_shadow_map(struct inode *inode)
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
index cf4f1c6798f5e..857926da9f21d 100644
--- a/fs/nilfs2/page.c
+++ b/fs/nilfs2/page.c
@@ -369,8 +369,9 @@ void nilfs_copy_back_pages(struct address_space *dmap,
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
@@ -391,7 +392,7 @@ void nilfs_clear_dirty_pages(struct address_space *mapping)
 			 * was acquired.  Skip processing in that case.
 			 */
 			if (likely(folio->mapping == mapping))
-				nilfs_clear_folio_dirty(folio);
+				nilfs_clear_folio_dirty(folio, force);
 
 			folio_unlock(folio);
 		}
@@ -403,13 +404,16 @@ void nilfs_clear_dirty_pages(struct address_space *mapping)
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
 
@@ -422,24 +426,28 @@ void nilfs_clear_folio_dirty(struct folio *folio)
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




