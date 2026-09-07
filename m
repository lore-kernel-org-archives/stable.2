Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7893495537
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 11:47:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788781660; cv=none; b=p1H90NOi+AQ7/RClaTad0YXxY+hnGxgiopuNvFC6HE31+kvz/CeVtZcIMkegB58L5reAWms7BMwGnzg2nKmNR/9dA7hZusfix7cleM0A+kswUS24yvi0bXmbCzrRfkBg8r0sLwRvE/TjGoHWnjqRigqM121OuNKddHGwnO9oMGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788781660; c=relaxed/simple;
	bh=aIRQahJbRq4PA7siTV1rmbjC28arJkqEFAlIIKr0Spc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=LuhVhypjc1R6qncd6INNf4CHq0LnE5PG8oU1m0M9PQGRFW71vDR1AIdSOL3p3ryAqQJftjcqu6RCkIsiSikjYoss4kkSbTddK7ImE5hx9gYdFQ6xQgWRRHdrD4MiklxjkdBdioQlHtEWg5/aGfMX3lyC0xhDz6fRTUIqubaN5Zs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ef3QQOCu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ef3QQOCu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B46771F00A3A;
	Mon,  7 Sep 2026 11:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788781658;
	bh=FnCwqdGQ1oCoRo417IKk8VCCVmXwCSmL0FKlKr7pyfE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ef3QQOCunA5S9LaT3fuxaoLhTFdTwoPbclR+fPsHgxKTtz8iEz1w9hJ/MYXUt4Ash
	 jNE5ADj8riDQZFSS82pszZsE9hgCJkR1zh1gRS+f3fS7eYmZM4eqXK6QdDLUm4kdv1
	 i6fDPo+MJNZYAE9VaKco/0RdW1ylDlsVf0Wj0Gt8onYhM3fZcGsnIBkctMSqKceD2/
	 pCuEcyP0rU0U1CQkMAsDSsdgaAPCDe/zDg5WQZS6BQzITB7Qk9BoXifD1DA8vr0Cxt
	 LSk40U/QEDnjzi6/5FGyBJun1mloFaFTdJgK7ilB3DhubVvoNwIPD3W9pw0e568tzZ
	 4i1r8fiSziABQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] btrfs: prepare btrfs_punch_hole_lock_range() for large data folios
Date: Mon,  7 Sep 2026 07:47:33 -0400
Message-ID: <20260907114735.2871157-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090310-catchy-recollect-7ab5@gregkh>
References: <2026090310-catchy-recollect-7ab5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 1e5773e0bab761c853eaf7286394905a544ef02d ]

The function btrfs_punch_hole_lock_range() needs to make sure there is
no other folio in the range, thus it goes with filemap_range_has_page(),
which works pretty fine.

But if we have large folios, under the following case
filemap_range_has_page() will always return true, forcing
btrfs_punch_hole_lock_range() to do a very time consuming busy loop:

        start                            end
        |                                |
  |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
   \         /                         \   /
    Folio A                            Folio B

In the above case, folio A and B contain our start/end indexes, and there
are no other folios in the range.  Thus we do not need to retry inside
btrfs_punch_hole_lock_range().

To prepare for large data folios, introduce a helper,
check_range_has_page(), which will:

- Shrink the search range towards page boundaries
  If the rounded down end (exclusive, otherwise it can underflow when @end
  is inside the folio at file offset 0) is no larger than the rounded up
  start, it means the range contains no other pages other than the ones
  covering @start and @end.

  Can return false directly in that case.

- Grab all the folios inside the range

- Skip any large folios that cover the start and end indexes

- If any other folios are found return true

- Otherwise return false

This new helper is going to handle both large folios and regular ones.

Reviewed-by: Filipe Manana <fdmanana@suse.com>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 3f950867c307 ("btrfs: fix extent map leak in NOCOW direct I/O write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/file.c | 67 +++++++++++++++++++++++++++++++++++++++++--------
 1 file changed, 56 insertions(+), 11 deletions(-)

diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index 0970ec776ff8e..407bce7a37ec8 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -2204,11 +2204,29 @@ static int find_first_non_hole(struct btrfs_inode *inode, u64 *start, u64 *len)
 	return ret;
 }
 
-static void btrfs_punch_hole_lock_range(struct inode *inode,
-					const u64 lockstart,
-					const u64 lockend,
-					struct extent_state **cached_state)
+/*
+ * Check if there is no folio in the range.
+ *
+ * We cannot utilize filemap_range_has_page() in a filemap with large folios
+ * as we can hit the following false positive:
+ *
+ *        start                            end
+ *        |                                |
+ *  |//|//|//|//|  |  |  |  |  |  |  |  |//|//|
+ *   \         /                         \   /
+ *    Folio A                            Folio B
+ *
+ * That large folio A and B cover the start and end indexes.
+ * In that case filemap_range_has_page() will always return true, but the above
+ * case is fine for btrfs_punch_hole_lock_range() usage.
+ *
+ * So here we only ensure that no other folios is in the range, excluding the
+ * head/tail large folio.
+ */
+static bool check_range_has_page(struct inode *inode, u64 start, u64 end)
 {
+	struct folio_batch fbatch;
+	bool ret = false;
 	/*
 	 * For subpage case, if the range is not at page boundary, we could
 	 * have pages at the leading/tailing part of the range.
@@ -2219,17 +2237,45 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 	 *
 	 * And do not decrease page_lockend right now, as it can be 0.
 	 */
-	const u64 page_lockstart = round_up(lockstart, PAGE_SIZE);
-	const u64 page_lockend = round_down(lockend + 1, PAGE_SIZE);
+	const u64 page_lockstart = round_up(start, PAGE_SIZE);
+	const u64 page_lockend = round_down(end + 1, PAGE_SIZE);
+	const pgoff_t start_index = page_lockstart >> PAGE_SHIFT;
+	const pgoff_t end_index = (page_lockend - 1) >> PAGE_SHIFT;
+	pgoff_t tmp = start_index;
+	int found_folios;
+
+	/* The same page or adjacent pages. */
+	if (page_lockend <= page_lockstart)
+		return false;
+
+	folio_batch_init(&fbatch);
+	found_folios = filemap_get_folios(inode->i_mapping, &tmp, end_index, &fbatch);
+	for (int i = 0; i < found_folios; i++) {
+		struct folio *folio = fbatch.folios[i];
 
+		/* A large folio begins before the start. Not a target. */
+		if (folio->index < start_index)
+			continue;
+		/* A large folio extends beyond the end. Not a target. */
+		if (folio->index + folio_nr_pages(folio) > end_index)
+			continue;
+		/* A folio doesn't cover the head/tail index. Found a target. */
+		ret = true;
+		break;
+	}
+	folio_batch_release(&fbatch);
+	return ret;
+}
+
+static void btrfs_punch_hole_lock_range(struct inode *inode,
+					const u64 lockstart, const u64 lockend,
+					struct extent_state **cached_state)
+{
 	while (1) {
 		truncate_pagecache_range(inode, lockstart, lockend);
 
 		lock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
 			    cached_state);
-		/* The same page or adjacent pages. */
-		if (page_lockend <= page_lockstart)
-			break;
 		/*
 		 * We can't have ordered extents in the range, nor dirty/writeback
 		 * pages, because we have locked the inode's VFS lock in exclusive
@@ -2240,8 +2286,7 @@ static void btrfs_punch_hole_lock_range(struct inode *inode,
 		 * locking the range check if we have pages in the range, and if
 		 * we do, unlock the range and retry.
 		 */
-		if (!filemap_range_has_page(inode->i_mapping, page_lockstart,
-					    page_lockend - 1))
+		if (!check_range_has_page(inode, lockstart, lockend))
 			break;
 
 		unlock_extent(&BTRFS_I(inode)->io_tree, lockstart, lockend,
-- 
2.53.0

