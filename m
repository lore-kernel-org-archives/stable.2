Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 472AC269CE7
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559673; cv=none; b=MSub7UoNGdQXC2+rcapCWvtPhSeEhBoWiU0NooY5pmtChzwsUIAs6OMb5dzno82zWmjecclCS4rezWIk3uNEn2I2wndxb9OYZ7G8c0yVv9LMQWY1DWAsaUP4PYEGrBEBFMonZlig28OTHSq6p9LBUHzvijgkAK/3IoUXRnQdquI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559673; c=relaxed/simple;
	bh=DaAmDfxjEdBNv8POHi0MjBYEM9VqA+dPNsixAU1LgDs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HxQuwiMdTzvBZNi9qArYmSJeCKtIg6ohB3kkA9P9bPsuzjH7jcyU/0fUWiZ4sETiPo69+2QgV+YzSrZQK/qzp3P8VPcBGSkRSSNHcoumXv4HYb4sda0OAFx/iG8Z6tK+7E5SuyDyIj1DhbiNIyWcRJ/B8s5AlKGsV9mTLR/s2UA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RPqSMzuP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RPqSMzuP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53FE91F000E9;
	Mon, 20 Jul 2026 15:01:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559671;
	bh=xRM4k3khD/UuC9ZPaWGqRnEyegaAAN/izZ0Lmio43OQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RPqSMzuPUy871HwDs1AlKmToDQAWyruQu8iJ8c9EvPBxI2k+TSxNYdWnTJquipHao
	 UxB5HTa+kZTzSCT+DPJydgEEEa5Doz0Z6ETtQx/L5wWJwtVCCwmT08fUnU5iMil7fE
	 jxmi/Vt0XIKYA76EXOjDwQhnoo1/14rH1ysTvdrzPZa7cr7BDGVaKN5OpyLjl1G/I7
	 oXOhDY98obTN0JDojsazj4pKh+Boc11L5B1lIKMZBnA2IRWb2mzsgbBwdh7+lY0ngy
	 sa+47ur6S27WXd/NOHk7Uu8wxEOXvT96uqELHmH1XJjgPO1dh2xgXGg2F4Db/J+FaU
	 LWQBWYNweP7sw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/4] btrfs: concentrate the error handling of submit_one_sector()
Date: Mon, 20 Jul 2026 11:01:06 -0400
Message-ID: <20260720150109.1921272-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071553-esophagus-underpass-0b42@gregkh>
References: <2026071553-esophagus-underpass-0b42@gregkh>
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

