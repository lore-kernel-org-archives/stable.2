Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D862431A5C
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 17:27:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784568457; cv=none; b=BF+BIXfHCQJRZnRd42YeHExCGqTqwfvDcjoxgciwhO9JIlZBf5wadlS50VcqKdgzbQq0InRNPV8nrFk99dRUasjqDjVFbz/WvJrDel+Cp6+YGVl9TCMmkLOQsiL7vSTE/jy1KCgO7YBmvvFMyVQ3s90ldL768U6UUncySVc0kUo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784568457; c=relaxed/simple;
	bh=DEypDGrIpIQykJL55B0ZwsPIG9lZhl28AWUELnedaZo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nD76ZWGTTWgr2IfBShzSwqgHXA7hoGz41xGLr7a0J0Lz7P7Ye98H9YPh5uoNmKJ018CnPCXP/KMZZD4Oqqfo+v6xHkI21vM4SzaRW9CsPPMWZH6hZ575t00fmqoHpJiYCVDeb7Dq2/J9YUNUnPvTqGFwqUvtnpUvpiN59oT0GAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IYvIu3uv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IYvIu3uv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C9171F00A3A;
	Mon, 20 Jul 2026 17:27:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784568453;
	bh=Bd1gett8woYYIq+wgfnnly30/qu0ZT+iG1Fhm0sIDKk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IYvIu3uv5UyQahMv6dCoMYBMBNlhe+vQmDaaaeo6CFeS2GwzC3nJ8aMN2N6/fsxDK
	 ISWLH7wW2poiS9GfxxodfWNYiYly68IqF4eKUkz6TP/GY3/xvrZmCzMAPg2ddVSSZ7
	 IA0YLTBohu1M8ZuJjT0jyBXqYIC6/X9U8UncueZJoAmHOY7Cdr/jCQQtMZpIRapMiC
	 3x/eVUesOtKPqTbrSaom19QDcPyFsjPyXqhLeDhniJOSfiIycJjnddt6vB9Jt0+79I
	 FsLfylW4nt1L+Z2zE/VgRFM5g0tWDcq+Z7qfvPdm8bNxDYjukIeBZwnT5km7KJiKdM
	 +eqOBMNE4tx/Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/5] btrfs: replace for_each_set_bit() with for_each_set_bitmap()
Date: Mon, 20 Jul 2026 13:27:27 -0400
Message-ID: <20260720172730.2757976-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720172730.2757976-1-sashal@kernel.org>
References: <2026071509-recess-egomaniac-9782@gregkh>
 <20260720172730.2757976-1-sashal@kernel.org>
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

