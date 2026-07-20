Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A38B840EBB4
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 16:51:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784566280; cv=none; b=KaPy57WWsa5x/1RPOtJllQHi0JtZtGuJU4g7qb4v+r/jzTTzXQ3Ei32ohENPLNcm0OjI5DDVPuxodOD8FNYz3dyDIT6JrLDge4xalCsPVtxg3ZQZDiNVssunIUYauO0ek7EIgGpT9lShQxS02AIOZZAnUvz7m7F6nPZNHaE2iNo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784566280; c=relaxed/simple;
	bh=7pEMBcUBxFB6dkKSSD2HgqnwVVWHQ7s0QMPKC7Ipv30=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pLiYRSW+Eej3SwrSTlI//sg2+OqSe8EEGCW9qITOBQ7sphmz6rG3y2rFPXhgs9TXOqVE/ktMBHUtoT93Ju5cexsPqgN1IHVnz/cA2EXXyxMpFuWIFWXZ/Umcqx405eLEMDwKXamyHMBqfxeKRonJ6DMz5gBnpeq3qwKkQY3AD1A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=exExoJL0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="exExoJL0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C1AB31F00A3D;
	Mon, 20 Jul 2026 16:51:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784566279;
	bh=6ztfSg0fmB5Q4j5y4Oh1yOC4bpgNuIUqnRQJ2GJMaOE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=exExoJL0GEMFidTYlADa7id8wE3CNTutf3cfhbzwBEToU9WTg/ULiC0hiSsLPe/0D
	 5kXYo1JKSEtHgGg7evTw9rWdSZUWlApWJKTIxCZI/r2fnIW5Ywchf74/Oe9eZfypFi
	 vHQ4Atzw8I3Hv/C3xXxVGkL+xalAazn4wFLpsCY9iKqveQjbG/SYO33kWeeR//mUfk
	 4Qq9ey+4OfUOKDnzMLkwOmWG3Oyl0XpmCjGYXgJpf6dIdLPJdEvzVwtsRr1AaFvGl+
	 B+GaSGYMZprKSsw6R4TquqSinN8WK6Wak/h6LdL5m/3Nm5QATignXqJ+zrPaLCa206
	 JSbzZp8m6nj6g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/5] btrfs: replace for_each_set_bit() with for_each_set_bitmap()
Date: Mon, 20 Jul 2026 12:51:12 -0400
Message-ID: <20260720165115.2527045-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720165115.2527045-1-sashal@kernel.org>
References: <2026071509-driveway-had-c0ca@gregkh>
 <20260720165115.2527045-1-sashal@kernel.org>
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
Stable-dep-of: ff66fe666233 ("btrfs: fix incorrect buffered IO fallback for append direct writes")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/extent_io.c | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index b8e2b605d52c1e..88b5581df7dc16 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -1427,8 +1427,9 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
 	u64 delalloc_start = page_start;
 	u64 delalloc_end = page_end;
 	u64 delalloc_to_write = 0;
+	unsigned int start_bit;
+	unsigned int end_bit;
 	int ret = 0;
-	int bit;
 
 	/* Save the dirty bitmap as our submission bitmap will be a subset of it. */
 	if (btrfs_is_subpage(fs_info, folio)) {
@@ -1438,10 +1439,12 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
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
@@ -1558,10 +1561,13 @@ static noinline_for_stack int writepage_delalloc(struct btrfs_inode *inode,
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
@@ -1727,8 +1733,8 @@ static noinline_for_stack int extent_writepage_io(struct btrfs_inode *inode,
 		return ret;
 	}
 
-	for (cur = start; cur < end; cur += fs_info->sectorsize)
-		set_bit((cur - folio_start) >> fs_info->sectorsize_bits, &range_bitmap);
+	bitmap_set(&range_bitmap, (start - folio_pos(folio)) >> fs_info->sectorsize_bits,
+		   len >> fs_info->sectorsize_bits);
 	bitmap_and(&bio_ctrl->submit_bitmap, &bio_ctrl->submit_bitmap, &range_bitmap,
 		   blocks_per_folio);
 
-- 
2.53.0

