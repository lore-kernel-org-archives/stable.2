Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9982443800B
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:56:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784562999; cv=none; b=CCV8mHDHQtOZXP0yQ4Cn9dRbOky2jR3zLsZHC12EVhoTRRx9LVa87fCT/DkFDfazxOBj42jXt3nwMpEpohIzQERo5tVTvo6IwiEy8QOh987WsF4bQq0FeYRhcnN4fYpBS0e9z3vOkjXuAOdwGEdJRHgE95nDLIx4DLwitXTEsdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784562999; c=relaxed/simple;
	bh=eHFrCQT7dSNTsT4cclwIz7mIPzdHJj1axUZPCny2lpw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tGrZqjlzEHpKkGnc0UZvyDr1M1I3ujEkcxZdDICkoCgKxUyfX8irj/bJp3uaOOPutnJ/r2jITyRz5WV0E7D4vkxnyX2HhohVM60PN9UnRWgV6pru9l4fNQ8L8tMeFAOZLdWKqCxOXzVjRjuRxvkoOjCMGXIRSa+4Idoroo2sT6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=A4dSllLQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="A4dSllLQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BCECE1F00A3F;
	Mon, 20 Jul 2026 15:56:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784562998;
	bh=YylXKmY/7223UNFbEGcGaKA+smx1n828Ehx3YJkOOAE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=A4dSllLQL6fFbHbPBUxgywIAKA7dvU3zDcjQWJESD8kUqyIv8izFzPX+kQu9Rc9Jz
	 TsK1C4cV5vZlwOR5CQFVmM+DzQK3ZqV838WoHNHcLxLq5O7mWP0H8RR2UV9DQqcHX5
	 e89f3WAUTchtDiGTczHSJB2uVAVbnbyFkUaJvw6Z37NYAaBBRd8Bs6zFCeMEuFCyPX
	 hFL+D+yqcfsOufnkzj5koJARottXjyF3CHNO3R3NUs2EEembjqPHTNrFO9zn8NHOlC
	 PC9Vy4enfIYILjZT1O2dYfKk3MQk39qx1Kuwgv8ow3kTytqjT9TG3amDlImBFRIGbY
	 Hpwvd75h8WYFg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/4] btrfs: replace for_each_set_bit() with for_each_set_bitmap()
Date: Mon, 20 Jul 2026 11:56:33 -0400
Message-ID: <20260720155635.2425597-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720155635.2425597-1-sashal@kernel.org>
References: <2026071553-kite-shadow-2c30@gregkh>
 <20260720155635.2425597-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qu Wenruo <wqu@suse.com>

[ Upstream commit e6698b34fab33867ef3faeeea6feb165f31aae24 ]

Inside extent_io.c, there are several simple call sites doing things
like:

	for_each_set_bit(bit, bitmap, bitmap_size) {
		/* handle one fs block */
	}

The workload includes:

- set_bit()
  Inside extent_writepage_io().

  This can be replaced with a bitmap_set().

- btrfs_folio_set_lock()
- btrfs_mark_ordered_io_finished()
  Inside writepage_delalloc().

  Instead of calling it multiple times, we can pass a range into the
  function with one call.

Reviewed-by: Boris Burkov <boris@bur.io>
Signed-off-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 66ff4d366e7e ("btrfs: fix false IO failure after falling back to buffered write")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index af5244900adf26..4fc116b0e6cd43 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1245,8 +1245,9 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	u64 delalloc_start = page_start;
 	u64 delalloc_end = page_end;
 	u64 delalloc_to_write = 0;
+	unsigned int start_bit;
+	unsigned int end_bit;
 	int ret = 0;
-	int bit;
 
 	/* Save the dirty bitmap as our submission bitmap will be a subset of it. */
 	if (btrfs_is_subpage(fs_info, inode->vfs_inode.i_mapping)) {
@@ -1256,10 +1257,12 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 		bio_ctrl->submit_bitmap = 1;
 	}
 
-	for_each_set_bit(bit, &bio_ctrl->submit_bitmap, blocks_per_folio) {
-		u64 start = page_start + (bit << fs_info->sectorsize_bits);
+	for_each_set_bitrange(start_bit, end_bit, &bio_ctrl->submit_bitmap,
+			      blocks_per_folio) {
+		u64 start = page_start + (start_bit << fs_info->sectorsize_bits);
+		u32 len = (end_bit - start_bit) << fs_info->sectorsize_bits;
 
-		btrfs_folio_set_lock(fs_info, folio, start, fs_info->sectorsize);
+		btrfs_folio_set_lock(fs_info, folio, start, len);
 	}
 
 	/* Lock all (subpage) delalloc ranges inside the folio first. */
@@ -1376,10 +1379,13 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 				fs_info->sectorsize_bits,
 				blocks_per_folio);
 
-		for_each_set_bit(bit, &bio_ctrl->submit_bitmap, bitmap_size)
-			btrfs_mark_ordered_io_finished(inode, folio,
-				page_start + (bit << fs_info->sectorsize_bits),
-				fs_info->sectorsize, false);
+		for_each_set_bitrange(start_bit, end_bit, &bio_ctrl->submit_bitmap,
+				      bitmap_size) {
+			u64 start = page_start + (start_bit << fs_info->sectorsize_bits);
+			u32 len = (end_bit - start_bit) << fs_info->sectorsize_bits;
+
+			btrfs_mark_ordered_io_finished(inode, folio, start, len, false);
+		}
 		return ret;
 	}
 out:
@@ -1539,8 +1545,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		return 1;
 	}
 
-	for (cur = start; cur < end; cur += fs_info->sectorsize)
-		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
+	bitmap_set(&range_bitmap, (start - folio_pos(folio)) >> fs_info->sectorsize_bits,
+		   len >> fs_info->sectorsize_bits);
 	bitmap_and(&bio_ctrl->submit_bitmap, &bio_ctrl->submit_bitmap, &range_bitmap,
 		   blocks_per_folio);
 
-- 
2.53.0

