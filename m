Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 720133859DC
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 19:30:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788723053; cv=none; b=WsZpWy81zF31Y0mxcp0qwBvxqEhbXHE6JhHVtL2rA/JoRT8vlYzuDT0tB+jr3msSfTgO6RnKUIxSN6Z7ZUyh9pW+w/typq9SQJS7D+HsVRGKWWIhp0ZGojErO8TL07UAPICfU72Q3Szan7ShNJ+UrnnI4175KXlM1ZGKXQI75vM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788723053; c=relaxed/simple;
	bh=RONv+c4PHawhhk4xfC26/E657vWK0IgZAHM/3qWnRZE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jWpQeTLTN++I+IOAwQTDbSIWlynDlsg1coxZ0fOZNYAEOfvhxmMgj64ByK6f5X4mprAoqEdPg01CZ1+cKD2QWULnsqAjR1SjDlwKDvdTMqGdywGmNfo1AYBvbEhTU3wq4Oj1pUqCofvy0mzff37jJ456ihhZlxY8F73cCdePFFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bXVeeqyA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bXVeeqyA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE491F00A3F;
	Sun,  6 Sep 2026 19:30:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723052;
	bh=LQUH3ohwHqhbI4ZvpGgrQ7AVLWua8G3CJiH6hoqNEzU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bXVeeqyAm3rHM8BnFqAGqVE1BNc3twUI3i0DADaVJi4IqqSXvUOchKmHUqJBwVjLs
	 +sroD9tjIDch5hW1+rt6uSiuTKDWw8gKz5zAB2XhqW/P9ZwGzQNtDiAcOjhSADUlR9
	 I9iE7YnlZt40bK5RKPtIF+0ADLNcAX3KuwWnjFfIu5IRZ/KzP7YMUuPJ1TVJbDqMiu
	 H6HkgZfUp7wdqkhcQ8NIxKit9G24lxXSoY2vhUdIDQM5/M6tpszvCai1WOw+AV4JEY
	 G6lKqswl0umxBwN00m+NGhxPVJBVdd3LGYBwhbUK+ZvDsU3KqFP65CwlgL5tUo4bh6
	 fK5jB3vA1/Y+w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Qu Wenruo <wqu@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/8] btrfs: move btrfs_alloc_write_mask() into fs.h
Date: Sun,  6 Sep 2026 15:30:43 -0400
Message-ID: <20260906193048.1791749-3-sashal@kernel.org>
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

[ Upstream commit 378f25d3fc429ad001fa686f615df5c0f9cd47e1 ]

Currently btrfs_alloc_write_mask() is defined in ctree.h but it's not
related at all to the btree data structure, so move it into fs.h.

Reviewed-by: Qu Wenruo <wqu@suse.com>
Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 15f7c86215e8 ("btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/ctree.h | 6 ------
 fs/btrfs/fs.h    | 6 ++++++
 2 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index 6906b4dd82a81..ced5ac090293b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -7,7 +7,6 @@
 #define BTRFS_CTREE_H
 
 #include "linux/cleanup.h"
-#include <linux/pagemap.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
 #include <linux/mutex.h>
@@ -506,11 +505,6 @@ static inline u32 BTRFS_MAX_XATTR_SIZE(const struct btrfs_fs_info *info)
 	return BTRFS_MAX_ITEM_SIZE(info) - sizeof(struct btrfs_dir_item);
 }
 
-static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
-{
-	return mapping_gfp_constraint(mapping, ~__GFP_FS);
-}
-
 void btrfs_error_unpin_extent_range(struct btrfs_fs_info *fs_info, u64 start, u64 end);
 int btrfs_discard_extent(struct btrfs_fs_info *fs_info, u64 bytenr,
 			 u64 num_bytes, u64 *actual_bytes);
diff --git a/fs/btrfs/fs.h b/fs/btrfs/fs.h
index 3174b45a80b1d..90b104dd38c23 100644
--- a/fs/btrfs/fs.h
+++ b/fs/btrfs/fs.h
@@ -18,6 +18,7 @@
 #include <linux/rwsem.h>
 #include <linux/semaphore.h>
 #include <linux/list.h>
+#include <linux/pagemap.h>
 #include <linux/radix-tree.h>
 #include <linux/workqueue.h>
 #include <linux/wait.h>
@@ -893,6 +894,11 @@ struct btrfs_fs_info {
 #define inode_to_fs_info(_inode) (BTRFS_I(_Generic((_inode),			\
 					   struct inode *: (_inode)))->root->fs_info)
 
+static inline gfp_t btrfs_alloc_write_mask(struct address_space *mapping)
+{
+	return mapping_gfp_constraint(mapping, ~__GFP_FS);
+}
+
 static inline u64 btrfs_get_fs_generation(const struct btrfs_fs_info *fs_info)
 {
 	return READ_ONCE(fs_info->generation);
-- 
2.53.0

