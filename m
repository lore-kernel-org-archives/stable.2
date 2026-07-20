Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919253E3145
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:51:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566279; cv=none; b=VVsBF8Dt4lXJBeQ7zsWZ82Mbd/JrGrb9t15NBJii8IJYvP2DuUe9JmK74OE+0c7g37MrJxDjPkJxi/UU55JCLW1zZozmkWTZGl05fBWrVZBWOM3LR4zjhmuW4XaWZ80MO9JJ9f700vpxnQJvqQDPmLOSng9vsYhRXd36fbGYZKI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566279; c=relaxed/simple;
	bh=LHA5uvzjMLz+r1nyQqEd95t8eJ082//bFwB0F2eer5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=VTp7q07GpvJKQ8Uwr/ma14mc/zdDuvAzBawx/oZzjNrlLwlaarY3HUjpt2TzuPSwbQhMr/frAvTGhjyAMvQGqowFgY+9M/6WxYWOD5VKQH6jQP5PGh7ZFm6lHQBicry2d543iGvqsAMkwP9hIWMnV4yWLfSqVvy2M94ih1VEN+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Vq6+s48r; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Vq6+s48r"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1DEF1F000E9;
	Mon, 20 Jul 2026 16:51:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784566278;
	bh=aJw5vJOPjOa18VUmnnO2Bj3QrOlgCybrNQET/ApCFlk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Vq6+s48rw7zv5C4sGCQ5BwgAk09wze8mgqWoOVLD8G1XTrAMUKRth91vd4rVUS4xL
	 O52xF9oHo+vjJVnDNkuas1ZY+0iCtWp0AOUE27s/k/nuj71X+oNKsRWX8dAgTfRL3S
	 dt7LgUe302jflcZsgFqnlzch/PvC0WxbLFRrt7qWXtDB/NKUweWsMgTjyqdADYLqMw
	 aRrDupBbUj4Z1HIdbPsyQfKbdLQ303slxvfcCbBmfDl1qxB/r4/Q4esQ+1S617SAEp
	 5F9v/g3CWhHTSgM/xxqIkDVHguIqTwaMCWhrtHeCFlGoWKWR7N4x9QSFa1qaunmHpR
	 p2fJqCcnjejnA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/5] btrfs: concentrate the error handling of submit_one_sector()
Date: Mon, 20 Jul 2026 12:51:11 -0400
Message-ID: <20260720165115.2527045-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071509-driveway-had-c0ca@gregkh>
References: <2026071509-driveway-had-c0ca@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit 44820d80026e0b509007d41c83d42f1213ee8589 ]

Currently submit_one_sector() has only one failure path from
btrfs_get_extent().

However the error handling is split into two parts, one inside
submit_one_sector(), which clears the dirty flag and finishes the
writeback for the fs block.

The other part is to submit any remaining bio inside bio_ctrl and mark
the ordered extent finished for the fs block.

There is no special reason that we must split the error handling, let's
just concentrate all the error handling into submit_one_sector().

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: ff66fe666233 ("btrfs: fix incorrect buffered IO fallback for append direct writes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 29 +++++++++++++++--------------
 1 file changed, 15 insertions(+), 14 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 4b2bd3cc3ed33e..b8e2b605d52c1e 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1599,7 +1599,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 /*
  * Return 0 if we have submitted or queued the sector for submission.
- * Return <0 for critical errors, and the sector will have its dirty flag cleared.
+ * Return <0 for critical errors, and the involved sector will be cleaned up.
  *
  * Caller should make sure filepos < i_size and handle filepos >= i_size case.
  */
@@ -1623,6 +1623,13 @@ static int submit_one_sector(struct btrfs_inode *inode,
 
 	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
 	if (IS_ERR(em)) {
+		/*
+		 * bio_ctrl may contain a bio crossing several folios.
+		 * Submit it immediately so that the bio has a chance
+		 * to finish normally, other than marked as error.
+		 */
+		submit_one_bio(bio_ctrl);
+
 		/*
 		 * When submission failed, we should still clear the folio dirty.
 		 * Or the folio will be written back again but without any
@@ -1631,6 +1638,13 @@ static int submit_one_sector(struct btrfs_inode *inode,
 		btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
 		btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
 		btrfs_folio_clear_writeback(fs_info, folio, filepos, sectorsize);
+
+		/*
+		 * Since there is no bio submitted to finish the ordered
+		 * extent, we have to manually finish this sector.
+		 */
+		btrfs_mark_ordered_io_finished(inode, folio, filepos,
+					       fs_info->sectorsize, false);
 		return PTR_ERR(em);
 	}
 
@@ -1756,19 +1770,6 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		}
 		ret = submit_one_sector(inode, folio, cur, bio_ctrl, i_size);
 		if (unlikely(ret < 0)) {
-			/*
-			 * bio_ctrl may contain a bio crossing several folios.
-			 * Submit it immediately so that the bio has a chance
-			 * to finish normally, other than marked as error.
-			 */
-			submit_one_bio(bio_ctrl);
-			/*
-			 * Failed to grab the extent map which should be very rare.
-			 * Since there is no bio submitted to finish the ordered
-			 * extent, we have to manually finish this sector.
-			 */
-			btrfs_mark_ordered_io_finished(inode, folio, cur,
-						       fs_info->sectorsize, false);
 			if (!found_error)
 				found_error = ret;
 			continue;
-- 
2.53.0

