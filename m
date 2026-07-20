Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C94C13BB137
	for <stable@vger.kernel.org>; Mon, 20 Jul 2026 15:01:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784559673; cv=none; b=B+q6GM+n7zsY6c7pKO+fw2W5F7927PIQcXad+TGB9J9q6Cw1Fzdmxx4UcSIyJfMqMejxPj/clYqiZI9b2VOoeHch0IVSkFTBXI/C1ZwORY5JWhdiSQD5Eww74Tt938jLqS3LWUhpkxKU341Rjz2UjtANJtodT+TkQXuptZU5XFQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784559673; c=relaxed/simple;
	bh=PPdEq7fLzaMuNE7eD37QisheUUw84MdodSra8SRyjis=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BchX4V2ayQiFYhUux984Ox07wBLAP3Q7rQDHJ3eUAJ8ep55blmGmXsMUQ6QB6X6/ZHADhZv34ZldXjxf26rzPaNUM3qGVXxYVdXiRz7O0QS+eMIw6th9QiuQFmSv3Y4h0Daz5w9waW/5RlEpwg2x7+FBErHEWxAzsMwP/pKHFPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gsYRhLOx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gsYRhLOx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 289C51F00A3D;
	Mon, 20 Jul 2026 15:01:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784559672;
	bh=iOZncpqlXbL3V1PQ7EbHMMpafQcDNeJyW+MVTcpvWiE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gsYRhLOxA+9tXKnDOo3pFeBFHSZ/8v3Ge6CBV4h7m4OyMVaqb84PBLYIm40sSDkP9
	 fD25yElH1KZwMjr2yF3Jy+joVgvM4qFcfEW4Ft9Y0R6A8ue5mMGk1MMegi8sRwLdZk
	 /Q7CO+uSObypW7WCkB7Gtw9ldux91uU3s6CjGGrk6DUi927cEC+X6FJOokBa5FUhg0
	 kjLs8CGFlMMiODCp1nB0+/4K+hGg30p1d6nKyG5ByH9UwI7p0CM0s9lGMXGKqAt1t5
	 ytScv1hliEo+otR+JTAzQitlVjdCRNrgLeWjUeoqgHDQqGSvAQNgsgjTYr1zV2g1GE
	 Q8t9aAMWj5GKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qu Wenruo <wqu@suse.com>,
	Boris Burkov <boris@bur.io>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 2/4] btrfs: replace for_each_set_bit() with for_each_set_bitmap()
Date: Mon, 20 Jul 2026 11:01:07 -0400
Message-ID: <20260720150109.1921272-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260720150109.1921272-1-sashal@kernel.org>
References: <2026071553-esophagus-underpass-0b42@gregkh>
 <20260720150109.1921272-1-sashal@kernel.org>
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

