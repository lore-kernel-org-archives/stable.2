Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC7ED43784C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:56:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562999; cv=none; b=OeEfJDVeintEiNcjdl47o+lLeQ4JnEIljquHvsESUthTPBj0Rc1CIwRMUsuglYF1eKxYLcvm4Fk2mo1oW7DfpbE//ahJ/a21rS7MaY3BVqLppDQJqL2d7Bu8DFPKwOiZTYFGVVZnoJVVRUaRhEocLWov2A12k+s9hlJhofREA0M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562999; c=relaxed/simple;
	bh=HasdphjNVbddK8oZc2WF38wGlicdVBIgqfjrgUkaYG4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AtjrouQCzAJx6ZqmijTffTzRCsNF4zcNcE2WL4rZvoGA7bIbKpiXpsnNeaUMNeyx2DV92Lxty+cvR2QYeMhJdyDQXeu5Q8tWrVz+wLuZLw9PO5+cpy6C8vNBkAQYlcGBg0mvfOhj1QuFEzeY1duGhp2WAu7iaIGHUsw5Zl/74is=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nn92R9Lw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nn92R9Lw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA3011F00A3D;
	Mon, 20 Jul 2026 15:56:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784562997;
	bh=1njbJg14+I9I/kVa+wgX559lmNelg+YRIoX0Eqjl4sI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Nn92R9LwEz1pZU8KZYrYMqqUxMOPngSea6dZxruB3ZgFZcuEa26LYUSNvBk5NO3AR
	 FpT8mKJktw35lwNif1SWK81cSv1omPciT/Q0YHfkh+XAGBowsVFFDRIhvBv4p0g90n
	 rp/qjzA/S2/StmG+aCBshDqkJbliUjtAguljE2vOmBBW0GEzoRbWQYVt9jsHw0Ovoy
	 AlvAdW5SEoOFPZ/etX3gaYCgtWJk1EpyfslmxRhoR+3WE6DGgw4cxrmHjbB0gx/Sro
	 z7Uj4WpSCgDzaRvlJjpj3LSJFdE3I2ofFz7hWpaASh/bvqXAe958oHoqv3ygiwblfI
	 wDKwfSKki85XQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 1/4] btrfs: concentrate the error handling of submit_one_sector()
Date: Mon, 20 Jul 2026 11:56:32 -0400
Message-ID: <20260720155635.2425597-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071553-kite-shadow-2c30@gregkh>
References: <2026071553-kite-shadow-2c30@gregkh>
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
Stable-dep-of: 66ff4d366e7e ("btrfs: fix false IO failure after falling back to buffered write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 46 +++++++++++++++++++++++++++-----------------
 1 file changed, 28 insertions(+), 18 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 0d50f3063d346d..af5244900adf26 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1417,7 +1417,7 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 
 /*
  * Return 0 if we have submitted or queued the sector for submission.
- * Return <0 for critical errors.
+ * Return <0 for critical errors, and the involved sector will be cleaned up.
  *
  * Caller should make sure filepos < i_size and handle filepos >= i_size case.
  */
@@ -1440,8 +1440,31 @@ static int submit_one_sector(struct btrfs_inode *inode,
 	ASSERT(filepos < i_size);
 
 	em = btrfs_get_extent(inode, NULL, filepos, sectorsize);
-	if (IS_ERR(em))
-		return PTR_ERR_OR_ZERO(em);
+	if (IS_ERR(em)) {
+		/*
+		 * bio_ctrl may contain a bio crossing several folios.
+		 * Submit it immediately so that the bio has a chance
+		 * to finish normally, other than marked as error.
+		 */
+		submit_one_bio(bio_ctrl);
+
+		/*
+		 * When submission failed, we should still clear the folio dirty.
+		 * Or the folio will be written back again but without any
+		 * ordered extent.
+		 */
+		btrfs_folio_clear_dirty(fs_info, folio, filepos, sectorsize);
+		btrfs_folio_set_writeback(fs_info, folio, filepos, sectorsize);
+		btrfs_folio_clear_writeback(fs_info, folio, filepos, sectorsize);
+
+		/*
+		 * Since there is no bio submitted to finish the ordered
+		 * extent, we have to manually finish this sector.
+		 */
+		btrfs_mark_ordered_io_finished(inode, folio, filepos,
+					       fs_info->sectorsize, false);
+		return PTR_ERR(em);
+	}
 
 	extent_offset = filepos - em->start;
 	em_end = extent_map_end(em);
@@ -1559,19 +1582,6 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
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
@@ -1587,8 +1597,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 	 * Here we set writeback and clear for the range. If the full folio
 	 * is no longer dirty then we clear the PAGECACHE_TAG_DIRTY tag.
 	 *
-	 * If we hit any error, the corresponding sector will still be dirty
-	 * thus no need to clear PAGECACHE_TAG_DIRTY.
+	 * If we hit any error, the corresponding sector will have its dirty
+	 * flag cleared and writeback finished, thus no need to handle the error case.
 	 */
 	if (!submitted_io && !found_error) {
 		btrfs_folio_set_writeback(fs_info, folio, start, len);
-- 
2.53.0

