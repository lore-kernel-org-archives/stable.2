Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FDE345CBE
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 19:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788723052; cv=none; b=BDY5WMizDpJbrhuqXMPIeT5Ei32a83HtpnQzaOcQot8eXnnWtKNsC+KM1QKTlsiDNjUCo1fGniuwTryugYFfk1+SjP9nsP0lTLeb7PLF9ikoMPTKfoNXE2B5eeklKcvloT7AnfcLIgVpkj/dXl9iQlSo+TNNw1YY5uf9RL44y28=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788723052; c=relaxed/simple;
	bh=jxQ8YhPLw7VLxzggEh7MAJzDXTfex+y12HoorWG/gIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bT87P1zPZtmbmVZzdHH3HZQYMcUaDyTDLjkKzn+oLATWnYNEzbwcuMfIegcwAxpObwnRSoVQBKa5SH+bb64N6hSsGnT8wHTdxGeeO144OyzLvu9kBI3SSiKeZcCZNV5qEe2plORh/F9KqqtAa1vGTWobIMelqr31Po/8P8d9rPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LvYV0OA0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LvYV0OA0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C22C01F00A3D;
	Sun,  6 Sep 2026 19:30:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723051;
	bh=oQ6hku8TZTRdhqRrgTJmuDmI/dmm7Dd5d+VIfSEiu2I=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LvYV0OA0KR/4qWYxa6rIXMiA1CQ6F/6ALGcNmFTMNaf1BzEExNHglAUQFvidCaVPg
	 gyUZO1gNmAw63cfkWn7i2F9BakBvC1HAiPbQpwcSG+zxrwGqljhWbaf9w7nG4tCiT/
	 HelPADZ7k1M1vQ4+xP3cPqEUFMKp+jJ7AtDUPBegAaWKZUNCT0PEstffVGEX64WEUg
	 jt3UDz8t4rFUlVyzcPtWNwPM3vrK1ELmoh1SMc9zVQMtyJuPFOpTnl0qFcXrQFsLdD
	 oPlSqTfBkOCy84kToVqg77vsgrWYRC6sgkmFwFn87FLK77qRxLwxr8dWyN+R+YSZSI
	 kKk+RJxDroNsg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/8] btrfs: move BTRFS_BYTES_TO_BLKS() into fs.h
Date: Sun,  6 Sep 2026 15:30:42 -0400
Message-ID: <20260906193048.1791749-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906193048.1791749-1-sashal@kernel.org>
References: <2026090330-nappy-discharge-0af0@gregkh>
 <20260906193048.1791749-1-sashal@kernel.org>
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
index 2034d37108333..6906b4dd82a81 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -506,9 +506,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
 }
 
-#define BTRFS_BYTES_TO_BLKS(fs_info, bytes) \
-				((bytes) >> (fs_info)->sectorsize_bits)
-
 static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
 {
 	return mapping_gfp_constraint(mapping, ~__GFP_FS);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 63e1ffac5d9b5..3174b45a80b1d 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -959,6 +959,8 @@ static inline u64 btrfs_calc_metadata_size(const struct btrfs_fs_info *fs_info,
 #define BTRFS_MAX_EXTENT_ITEM_SIZE(r) ((BTRFS_LEAF_DATA_SIZE(r->fs_info) >> 4) - \
 					sizeof(struct btrfs_item))
 
+#define BTRFS_BYTES_TO_BLKS(fs_info, bytes) ((bytes) >> (fs_info)->sectorsize_bits)
+
 static inline bool btrfs_is_zoned(const struct btrfs_fs_info *fs_info)
 {
 	return IS_ENABLED(CONFIG_BLK_DEV_ZONED) && fs_info->zone_size > 0;
-- 
2.53.0

