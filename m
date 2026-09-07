Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A37685C613
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 01:03:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788742994; cv=none; b=NB6riazSdcBSDPy+VCHRAIhZ4LzRy/6PyIl2EYaYLqXmCO7F0+dux+rrZF2BuUvlHodzg8cA+IhlSGbPXYkFRgt7ajOIfpOv61GWhagYmhoWXfNeJqbscLMvYm1mkkIcFhcNz3bbyomrwDttbNUQ322pXbvbgbiuD41pJ/1lO6E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788742994; c=relaxed/simple;
	bh=RZRS7ptX26EuYrA024ACI4dtw3HDrwB/8M0dBzSZkeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZRDPFeXJWEuK+gnh18awdNfuDODR5hR73BZam2XvYRZV+V/b86m4aXY2mmf/lVeOLvby58Fb11OkkJzCGNmFNdV3Fca6qNwObwBQjaoMwia5Meisov5raNkPNO3+UDOIm0UudNyThJobFv1R9cAO+gY9WAJLGTR5klbB1x161kI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OrdCbEaO; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OrdCbEaO"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16E561F00A3D;
	Mon,  7 Sep 2026 01:03:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788742992;
	bh=geX879bQ2Yj7OpsiLdtNMtopI5XeWeUeRKG6h+3G+GY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OrdCbEaO1clrBZ/iyK7Z+LfZQznfV8Q/zs+j+ICbkmnUnJJ5Feh3Os5qgh6TSkEQ2
	 sdWv9lUWlRkBI4Fj+MlkvkyVo42DEFGN6Pfiom1XWXO3gnPs5KbeE8DQVq2AuTWLHb
	 KU5DyqO1NV9WplmkaURn7u1imRDzw8XJJ1FuCrEdfq71HwwjdurGk6leJWBBBifVE/
	 eZNvrlmy6ooUbhE1il1hVLsw0vvYzzcyEIzgqJeD3DitwsXv4QfouvzXW9cLxRASTA
	 CWxXv0IJ1emny3BIc93/JLbIfOQDcT8ZOnneWQG7NLl4gwONJ92wBOEV/0St9/Trxe
	 NfkhkN1uH/aHA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] btrfs: allow folios to be released while ordered extent is finishing
Date: Sun,  6 Sep 2026 21:03:08 -0400
Message-ID: <20260907010309.1949749-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907010309.1949749-1-sashal@kernel.org>
References: <2026090310-yeah-payday-4448@gregkh>
 <20260907010309.1949749-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit 32c523c578e8489f55663ce8a8860079c8deb414 ]

When the release_folio callback (from struct address_space_operations) is
invoked we don't allow the folio to be released if its range is currently
locked in the inode's io_tree, as it may indicate the folio may be needed
by the task that locked the range.

However if the range is locked because an ordered extent is finishing,
then we can safely allow the folio to be released because ordered extent
completion doesn't need to use the folio at all.

When we are under memory pressure, the kernel starts writeback of dirty
pages (folios) with the goal of releasing the pages from the page cache
after writeback completes, however this often is not possible on btrfs
because:

  * Once the writeback completes we queue the ordered extent completion;

  * Once the ordered extent completion starts, we lock the range in the
    inode's io_tree (at btrfs_finish_one_ordered());

  * If the release_folio callback is called while the folio's range is
    locked in the inode's io_tree, we don't allow the folio to be
    released, so the kernel has to try to release memory elsewhere,
    which may result in triggering more writeback or releasing other
    pages from the page cache which may be more useful to have around
    for applications.

In contrast, when the release_folio callback is invoked after writeback
finishes and before ordered extent completion starts or locks the range,
we allow the folio to be released, as well as when the release_folio
callback is invoked after ordered extent completion unlocks the range.

Improve on this by detecting if the range is locked for ordered extent
completion and if it is, allow the folio to be released. This detection
is achieved by adding a new extent flag in the io_tree that is set when
the range is locked during ordered extent completion.

Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>

[ sashal: Reduced backport -- upstream 32c523c578e84 touches 4 file(s), this
  backport carries 4. Not backported here:
  fs/btrfs/extent-io-tree.c
  This note is generated from the file lists only; see the resolution record
  for the reasoning. ]

Stable-dep-of: 3f950867c307 ("btrfs: fix extent map leak in NOCOW direct I/O write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent-io-tree.h |  5 +++++
 fs/btrfs/extent_io.c      | 16 +++++++++++-----
 fs/btrfs/file.c           |  1 +
 fs/btrfs/inode.c          |  4 +++-
 4 files changed, 20 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/extent-io-tree.h b/fs/btrfs/extent-io-tree.h
index 28c23a23d1210..8b25fe2d6094f 100644
--- a/fs/btrfs/extent-io-tree.h
+++ b/fs/btrfs/extent-io-tree.h
@@ -30,6 +30,11 @@ enum {
 	 * that is left for the ordered extent completion.
 	 */
 	ENUM_BIT(EXTENT_DELALLOC_NEW),
+	/*
+	 * Mark that a range is being locked for finishing an ordered extent.
+	 * Used together with EXTENT_LOCKED.
+	 */
+	ENUM_BIT(EXTENT_FINISHING_ORDERED),
 	/*
 	 * When an ordered extent successfully completes for a region marked as
 	 * a new delalloc range, use this flag when clearing a new delalloc
diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 536c400e5964f..2ae9e953658f1 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -2352,18 +2352,24 @@ static int try_release_extent_state(struct extent_io_tree *tree,
 	u64 end = start + PAGE_SIZE - 1;
 	int ret = 1;
 
-	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL)) {
+	/*
+	 * We can release the page if it's locked only for ordered extent
+	 * completion, since that doesn't require using the page.
+	 */
+	if (test_range_bit(tree, start, end, EXTENT_LOCKED, 0, NULL) &&
+	    !test_range_bit(tree, start, end, EXTENT_FINISHING_ORDERED, 0,
+			    NULL)) {
 		ret = 0;
 	} else {
 		u32 clear_bits = ~(EXTENT_LOCKED | EXTENT_NODATASUM |
 				   EXTENT_DELALLOC_NEW | EXTENT_CTLBITS |
-				   EXTENT_QGROUP_RESERVED);
+				   EXTENT_QGROUP_RESERVED |
+				   EXTENT_FINISHING_ORDERED);
 
 		/*
 		 * At this point we can safely clear everything except the
-		 * locked bit, the nodatasum bit and the delalloc new bit.
-		 * The delalloc new bit will be cleared by ordered extent
-		 * completion.
+		 * locked, nodatasum, delalloc new and finishing ordered bits.
+		 * The delalloc new bit will be cleared by ordered extent completion.
 		 */
 		ret = __clear_extent_bit(tree, start, end, clear_bits, NULL, NULL);
 
diff --git a/fs/btrfs/file.c b/fs/btrfs/file.c
index bd389a1ae29dc..bcdc852f7d008 100644
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@ -5,6 +5,7 @@
 
 #include <linux/fs.h>
 #include <linux/pagemap.h>
+#include <linux/pagevec.h>
 #include <linux/time.h>
 #include <linux/init.h>
 #include <linux/string.h>
diff --git a/fs/btrfs/inode.c b/fs/btrfs/inode.c
index e843531201bef..23918e72a71f6 100644
--- a/fs/btrfs/inode.c
+++ b/fs/btrfs/inode.c
@@ -3144,8 +3144,10 @@ int btrfs_finish_one_ordered(struct btrfs_ordered_extent *ordered_extent)
 		goto out;
 	}
 
-	clear_bits |= EXTENT_LOCKED;
+	clear_bits |= EXTENT_LOCKED | EXTENT_FINISHING_ORDERED;
 	lock_extent(io_tree, start, end, &cached_state);
+	set_extent_bit(io_tree, start, end, EXTENT_FINISHING_ORDERED,
+		       &cached_state);
 
 	if (freespace_inode)
 		trans = btrfs_join_transaction_spacecache(root);
-- 
2.53.0

