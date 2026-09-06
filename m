Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27C17334692
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 19:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788723056; cv=none; b=hKE4eE9PvYrWyjTOwaO9rp6A1vl3dPmWKS5KEadHPKndesa/yq9zKrL8abTCItAJs11+dw92N9j0D3NMCZv7ag/EI1e4lW/PP92wG57NHSkrF7HXGWiHpOwk2rqaMLH0qMZLBgJNuE8c2Q+d8YJVqyn2+tFShm6aGRLYXRMSA2E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788723056; c=relaxed/simple;
	bh=LGkec2a5RuAs4D7KO3hKhuSNops7Hqr7OsGHkrQQjfU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BKxnBdAPJjJuqzvpafaNBW4K2AO3cHSgKH5vuP52RUndv3bQfL11nzAiOTo/cPmwsFDjsXw8jExbXOQPTbzMbY9o1hgtZ2l70YyDu7WGJQec0BGsRK7QQFM3KPnauEICtqy/cEUPRb+T9FQKpwn+8UZZpho9PHj0vYm0bv4lIaI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MuYqwu3+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MuYqwu3+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 523BF1F00A3A;
	Sun,  6 Sep 2026 19:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788723053;
	bh=b1SmoEtGidtcWp6wy0td8WXmcaENszZXR6kQM5me7H0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MuYqwu3+/fO4+o3WYkzB7ol/kkUn3p6iaxC1WdOM1Dq18a9QYVeF7Ky5fjWkQejou
	 j++uyz3Lia8s+zrb67BqcUYrsUsNMdKLS1VTMGOMsJcHioA3kICytfSu8IKxyvAmon
	 7NMz4Si/pegEAPs/i3WKwdvWwFxQxTfuGfZ6MZ4rv/yCJH7Mh740jUdv/TXy14mvzj
	 vI6YVEwmMwHRR9+P+X5SOMmIml9WuORgK1Di5yYj12HtO367qw6JF94qxu+omvmgiS
	 Rkel9CmrAT6wH0kgn/s/nmLvPdrXL9zoG4YRYzWQX2RHQRLsZBrUoj2t+4PY/Uufjh
	 DZDeKcKBgnQnw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 5/8] btrfs: update include and forward declarations in headers
Date: Sun,  6 Sep 2026 15:30:45 -0400
Message-ID: <20260906193048.1791749-5-sashal@kernel.org>
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

From: David Sterba <dsterba@suse.com>

[ Upstream commit 6149c82bdaff63203e58a4910d9245468d281f39 ]

Pass over all header files and add missing forward declarations,
includes or fix include types.

Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 15f7c86215e8 ("btrfs: do not overwrite NODATASUM flag when removing NODATACOW flag")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/accessors.h        | 1 +
 fs/btrfs/acl.h              | 2 ++
 fs/btrfs/ctree.h            | 2 +-
 fs/btrfs/delayed-ref.h      | 2 ++
 fs/btrfs/dir-item.h         | 1 +
 fs/btrfs/direct-io.h        | 2 ++
 fs/btrfs/discard.h          | 1 +
 fs/btrfs/extent-tree.h      | 1 -
 fs/btrfs/file-item.h        | 2 ++
 fs/btrfs/file.h             | 2 ++
 fs/btrfs/fs.c               | 1 -
 fs/btrfs/ioctl.h            | 2 ++
 fs/btrfs/locking.c          | 1 -
 fs/btrfs/ordered-data.h     | 1 +
 fs/btrfs/print-tree.h       | 2 ++
 fs/btrfs/props.h            | 1 +
 fs/btrfs/qgroup.h           | 3 +++
 fs/btrfs/raid-stripe-tree.h | 1 +
 fs/btrfs/send.c             | 1 -
 fs/btrfs/space-info.c       | 2 +-
 fs/btrfs/subpage.c          | 1 -
 fs/btrfs/sysfs.h            | 1 +
 fs/btrfs/volumes.h          | 4 ++++
 fs/btrfs/xattr.h            | 2 ++
 24 files changed, 32 insertions(+), 7 deletions(-)

diff --git a/fs/btrfs/accessors.h b/fs/btrfs/accessors.h
index 7a7e0ef69973a..15ea6348800b0 100644
--- a/fs/btrfs/accessors.h
+++ b/fs/btrfs/accessors.h
@@ -12,6 +12,7 @@
 #include <linux/string.h>
 #include <linux/mm.h>
 #include <uapi/linux/btrfs_tree.h>
+#include "extent_io.h"
 
 struct extent_buffer;
 
diff --git a/fs/btrfs/acl.h b/fs/btrfs/acl.h
index 48b9ddae4a46a..0458cd51ed489 100644
--- a/fs/btrfs/acl.h
+++ b/fs/btrfs/acl.h
@@ -3,6 +3,8 @@
 #ifndef BTRFS_ACL_H
 #define BTRFS_ACL_H
 
+#include <linux/types.h>
+
 struct posix_acl;
 struct inode;
 struct btrfs_trans_handle;
diff --git a/fs/btrfs/ctree.h b/fs/btrfs/ctree.h
index ced5ac090293b..937f32e5ad72b 100644
--- a/fs/btrfs/ctree.h
+++ b/fs/btrfs/ctree.h
@@ -6,7 +6,7 @@
 #ifndef BTRFS_CTREE_H
 #define BTRFS_CTREE_H
 
-#include "linux/cleanup.h"
+#include <linux/cleanup.h>
 #include <linux/spinlock.h>
 #include <linux/rbtree.h>
 #include <linux/mutex.h>
diff --git a/fs/btrfs/delayed-ref.h b/fs/btrfs/delayed-ref.h
index 352921e76c742..032c8e2c5be29 100644
--- a/fs/btrfs/delayed-ref.h
+++ b/fs/btrfs/delayed-ref.h
@@ -14,6 +14,8 @@
 #include <linux/spinlock.h>
 #include <linux/slab.h>
 #include <uapi/linux/btrfs_tree.h>
+#include "fs.h"
+#include "messages.h"
 
 struct btrfs_trans_handle;
 struct btrfs_fs_info;
diff --git a/fs/btrfs/dir-item.h b/fs/btrfs/dir-item.h
index 5f6dfafc91f1f..518f947acc299 100644
--- a/fs/btrfs/dir-item.h
+++ b/fs/btrfs/dir-item.h
@@ -10,6 +10,7 @@ struct fscrypt_str;
 struct btrfs_fs_info;
 struct btrfs_key;
 struct btrfs_path;
+struct btrfs_inode;
 struct btrfs_root;
 struct btrfs_trans_handle;
 
diff --git a/fs/btrfs/direct-io.h b/fs/btrfs/direct-io.h
index 3dc3ea926afe2..df5d45ee6de7a 100644
--- a/fs/btrfs/direct-io.h
+++ b/fs/btrfs/direct-io.h
@@ -5,6 +5,8 @@
 
 #include <linux/types.h>
 
+struct kiocb;
+
 int __init btrfs_init_dio(void);
 void __cold btrfs_destroy_dio(void);
 
diff --git a/fs/btrfs/discard.h b/fs/btrfs/discard.h
index dddb0f9101ba9..2c5e85394092f 100644
--- a/fs/btrfs/discard.h
+++ b/fs/btrfs/discard.h
@@ -3,6 +3,7 @@
 #ifndef BTRFS_DISCARD_H
 #define BTRFS_DISCARD_H
 
+#include <linux/types.h>
 #include <linux/sizes.h>
 
 struct btrfs_fs_info;
diff --git a/fs/btrfs/extent-tree.h b/fs/btrfs/extent-tree.h
index 2ad51130c037e..82c054dbc3691 100644
--- a/fs/btrfs/extent-tree.h
+++ b/fs/btrfs/extent-tree.h
@@ -4,7 +4,6 @@
 #define BTRFS_EXTENT_TREE_H
 
 #include <linux/types.h>
-#include "misc.h"
 #include "block-group.h"
 #include "locking.h"
 
diff --git a/fs/btrfs/file-item.h b/fs/btrfs/file-item.h
index 0e13661a71f3b..6181a70ec3efb 100644
--- a/fs/btrfs/file-item.h
+++ b/fs/btrfs/file-item.h
@@ -3,8 +3,10 @@
 #ifndef BTRFS_FILE_ITEM_H
 #define BTRFS_FILE_ITEM_H
 
+#include <linux/blk_types.h>
 #include <linux/list.h>
 #include <uapi/linux/btrfs_tree.h>
+#include "ctree.h"
 #include "accessors.h"
 
 struct extent_map;
diff --git a/fs/btrfs/file.h b/fs/btrfs/file.h
index 912254e653cf9..c3a59b4d506c9 100644
--- a/fs/btrfs/file.h
+++ b/fs/btrfs/file.h
@@ -9,6 +9,8 @@ struct file;
 struct extent_state;
 struct kiocb;
 struct iov_iter;
+struct inode;
+struct folio;
 struct page;
 struct btrfs_ioctl_encoded_io_args;
 struct btrfs_drop_extents_args;
diff --git a/fs/btrfs/fs.c b/fs/btrfs/fs.c
index e2b2b0f4c770f..1993be818b2a5 100644
--- a/fs/btrfs/fs.c
+++ b/fs/btrfs/fs.c
@@ -1,7 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
 #include "messages.h"
-#include "ctree.h"
 #include "fs.h"
 #include "accessors.h"
 
diff --git a/fs/btrfs/ioctl.h b/fs/btrfs/ioctl.h
index 0ea9f7beee336..389a9bf6fc1ed 100644
--- a/fs/btrfs/ioctl.h
+++ b/fs/btrfs/ioctl.h
@@ -9,6 +9,8 @@ struct file;
 struct dentry;
 struct mnt_idmap;
 struct fileattr;
+struct inode;
+struct io_uring_cmd;
 struct btrfs_fs_info;
 struct btrfs_ioctl_balance_args;
 
diff --git a/fs/btrfs/locking.c b/fs/btrfs/locking.c
index 6a0b7abb5bd9a..11ceb50a8527e 100644
--- a/fs/btrfs/locking.c
+++ b/fs/btrfs/locking.c
@@ -9,7 +9,6 @@
 #include <linux/page-flags.h>
 #include <asm/bug.h>
 #include <trace/events/btrfs.h>
-#include "misc.h"
 #include "ctree.h"
 #include "extent_io.h"
 #include "locking.h"
diff --git a/fs/btrfs/ordered-data.h b/fs/btrfs/ordered-data.h
index a1a9f8d46e10e..436a748da491a 100644
--- a/fs/btrfs/ordered-data.h
+++ b/fs/btrfs/ordered-data.h
@@ -17,6 +17,7 @@
 struct inode;
 struct page;
 struct extent_state;
+struct btrfs_block_group;
 struct btrfs_inode;
 struct btrfs_root;
 struct btrfs_fs_info;
diff --git a/fs/btrfs/print-tree.h b/fs/btrfs/print-tree.h
index 8504bf1702c7a..d0e620bf5f5a6 100644
--- a/fs/btrfs/print-tree.h
+++ b/fs/btrfs/print-tree.h
@@ -6,6 +6,8 @@
 #ifndef BTRFS_PRINT_TREE_H
 #define BTRFS_PRINT_TREE_H
 
+#include <linux/types.h>
+
 /* Buffer size to contain tree name and possibly additional data (offset) */
 #define BTRFS_ROOT_NAME_BUF_LEN				48
 
diff --git a/fs/btrfs/props.h b/fs/btrfs/props.h
index 63546d0a9444f..86849d4e7938c 100644
--- a/fs/btrfs/props.h
+++ b/fs/btrfs/props.h
@@ -6,6 +6,7 @@
 #ifndef BTRFS_PROPS_H
 #define BTRFS_PROPS_H
 
+#include <linux/types.h>
 #include <linux/compiler_types.h>
 
 struct inode;
diff --git a/fs/btrfs/qgroup.h b/fs/btrfs/qgroup.h
index c229256d6fd51..c516bd60d05cc 100644
--- a/fs/btrfs/qgroup.h
+++ b/fs/btrfs/qgroup.h
@@ -22,6 +22,9 @@ struct btrfs_ioctl_quota_ctl_args;
 struct btrfs_trans_handle;
 struct btrfs_delayed_ref_root;
 struct btrfs_inode;
+struct btrfs_transaction;
+struct btrfs_block_group;
+struct btrfs_qgroup_swapped_blocks;
 
 /*
  * Btrfs qgroup overview
diff --git a/fs/btrfs/raid-stripe-tree.h b/fs/btrfs/raid-stripe-tree.h
index 1ac1c21aac2f9..251137d067bf5 100644
--- a/fs/btrfs/raid-stripe-tree.h
+++ b/fs/btrfs/raid-stripe-tree.h
@@ -9,6 +9,7 @@
 #include <linux/types.h>
 #include <uapi/linux/btrfs_tree.h>
 #include "fs.h"
+#include "accessors.h"
 
 #define BTRFS_RST_SUPP_BLOCK_GROUP_MASK    (BTRFS_BLOCK_GROUP_DUP |		\
 					    BTRFS_BLOCK_GROUP_RAID1_MASK |	\
diff --git a/fs/btrfs/send.c b/fs/btrfs/send.c
index 2fa577d4a232d..4db1ec30de3e1 100644
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@ -17,7 +17,6 @@
 #include <linux/compat.h>
 #include <linux/crc32c.h>
 #include <linux/fsverity.h>
-
 #include "send.h"
 #include "ctree.h"
 #include "backref.h"
diff --git a/fs/btrfs/space-info.c b/fs/btrfs/space-info.c
index 402eb3b54fb1e..662fdd91d9ebf 100644
--- a/fs/btrfs/space-info.c
+++ b/fs/btrfs/space-info.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0
 
-#include "linux/spinlock.h"
+#include <linux/spinlock.h>
 #include <linux/minmax.h>
 #include "misc.h"
 #include "ctree.h"
diff --git a/fs/btrfs/subpage.c b/fs/btrfs/subpage.c
index 7e5ecc12b732a..9e4eb2c97b1c2 100644
--- a/fs/btrfs/subpage.c
+++ b/fs/btrfs/subpage.c
@@ -2,7 +2,6 @@
 
 #include <linux/slab.h>
 #include "messages.h"
-#include "ctree.h"
 #include "subpage.h"
 #include "btrfs_inode.h"
 
diff --git a/fs/btrfs/sysfs.h b/fs/btrfs/sysfs.h
index ec834a4af2e5d..613450e8985d1 100644
--- a/fs/btrfs/sysfs.h
+++ b/fs/btrfs/sysfs.h
@@ -7,6 +7,7 @@
 #include <linux/compiler_types.h>
 #include <linux/kobject.h>
 
+struct block_device;
 struct btrfs_fs_info;
 struct btrfs_device;
 struct btrfs_fs_devices;
diff --git a/fs/btrfs/volumes.h b/fs/btrfs/volumes.h
index 4481575dd70f3..a2863d2583fb5 100644
--- a/fs/btrfs/volumes.h
+++ b/fs/btrfs/volumes.h
@@ -7,6 +7,7 @@
 #define BTRFS_VOLUMES_H
 
 #include <linux/blk_types.h>
+#include <linux/blkdev.h>
 #include <linux/sizes.h>
 #include <linux/atomic.h>
 #include <linux/sort.h>
@@ -18,14 +19,17 @@
 #include <linux/completion.h>
 #include <linux/rbtree.h>
 #include <uapi/linux/btrfs.h>
+#include <uapi/linux/btrfs_tree.h>
 #include "messages.h"
 #include "rcu-string.h"
+#include "extent-io-tree.h"
 
 struct block_device;
 struct bdev_handle;
 struct btrfs_fs_info;
 struct btrfs_block_group;
 struct btrfs_trans_handle;
+struct btrfs_transaction;
 struct btrfs_zoned_device_info;
 
 #define BTRFS_MAX_DATA_CHUNK_SIZE	(10ULL * SZ_1G)
diff --git a/fs/btrfs/xattr.h b/fs/btrfs/xattr.h
index 8dc4cf49f6f06..0ce10e4ec8367 100644
--- a/fs/btrfs/xattr.h
+++ b/fs/btrfs/xattr.h
@@ -6,6 +6,8 @@
 #ifndef BTRFS_XATTR_H
 #define BTRFS_XATTR_H
 
+#include <linux/types.h>
+
 struct dentry;
 struct inode;
 struct qstr;
-- 
2.53.0

