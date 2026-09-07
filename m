Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 11D8022A4E1
	for <stable@vger.kernel.org>; Mon,  7 Sep 2026 01:03:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788743002; cv=none; b=e6eauH3apMUKzSfE21dRcJKBKrlsJXwsFK2zdJTBOW1IyYNOKmhhZR7AtJae9uk7xH0P0fNZJaiWNh4/dRAbIZiqVstd0HFd9KR1BpB+7i94PjczeWn8Xmcws2HmQF/lAB/MwYrY4oJEnkjyYWZX1lk8CD9GhWwyXY/7Q4FJcGg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788743002; c=relaxed/simple;
	bh=1qZlYwdwULTlFpV9yCgM8BrCPZAOSPmRukvs2k3V2DQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OHT0e2707OsNg1SxH3z/Jc0gG8tSWegjMf/7V8RQc6cEU+90kaLyUV5y2FitDX5Vq3KJBvhIW2M4+OOAl3jn0mBRLQKlvOolbOIdAUA08DDR4ES9H6pHZETszTCCSOxNUqcb0G+tn8K14EXTz9P9B0EqsQWKFF2b9oAL1R1jBe8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=l3bDueWB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="l3bDueWB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F21B41F00ACF;
	Mon,  7 Sep 2026 01:03:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788743000;
	bh=wiTbXXWExC9Lka5UvDFpsjs1niFycxsQj+5WFGK9YKE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=l3bDueWB6F4VimITaO/aUCqh7MZt4PboVZ6YimCVOL7tJ7rF5Y9IhFFr/srvGIXXk
	 SiosKFT6D5na56Y3VJwkD2LvX8vcjhPQqI7Jdq+frxCff4HvRhQK5/1IiqdbkOWVYj
	 oFJj9gaOStHYx8+MI07Y6waSGVbnFeu1IiwiPjlzFim5uFxXqahSEVHQqoPcRG7u4R
	 14BCen1IkVtwvfbY9LDjoIaWgemVf31cSRlgQcFX7ey0ChRMdq+ue3rNG8hk0AqvrG
	 dYCvndPqDJ3hcWBcYLOqAH57azjQLjvA9GQj3tcUY3Ukb5y7cfRVjnlri5hQ+egerA
	 fuT/ymPdVFkVQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/4] btrfs: move BTRFS_BYTES_TO_BLKS() into fs.h
Date: Sun,  6 Sep 2026 21:03:15 -0400
Message-ID: <20260907010317.1950131-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260907010317.1950131-1-sashal@kernel.org>
References: <2026090330-ferocity-flavorful-f5e4@gregkh>
 <20260907010317.1950131-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a4545b74e2de98989c1d14bc48c52c2f9fa734b6 ]

Currently BTRFS_BYTES_TO_BLKS() is defined in ctree.h but it's not related
at all to the btree data structure, so move it into fs.h.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 15f7c86215e8 ("btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.h | 3 ---
 fs/btrfs/fs.h    | 2 ++
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 1743aa21fa6e5..844e397f22387 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -469,9 +469,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
 }
 
-#define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
-				((bytes) >> (fs_info)->sectorsize_bits)
-
 static inline u64 btrfs_name_hash(const char *name, int len)
 {
        return crc32c((u32)~1, name, len);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index b35aa4556d96f..92fce625158bc 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -861,6 +861,8 @@ static inline u64 btrfs_calc_metadata_size(const struct btrfs_fs_info *fs_info,
 #define BTRFS_MAX_EXTENT_ITEM_SIZE(r) ((BTRFS_LEAF_DATA_SIZE(r->fs_info) >> 4) - \
 					sizeof(struct btrfs_item))
 
+#define BTRFS_BYTES_TO_BLKS(fs_info, bytes) ((bytes) >> (fs_info)->sectorsize_bits)
+
 static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 {
 	return IS_ENABLED(CONFIG_BLK_DEV_ZONED) && fs_info->zone_size > 0;
-- 
2.53.0

