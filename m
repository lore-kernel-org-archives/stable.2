Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC6E30DD22
	for <stable@vger.kernel.org>; Sun,  9 Aug 2026 14:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786286889; cv=none; b=bJES4EEhfM95/hZRGXzWLIdj+wZnEnpeksl2vSGd/EvOmkpiW/JR4e7CvmwXFZlxSmCSbbW8z/mYeh+am33HrTMHJbiCwXQ7axbk8RxufANfWfWPYaDixMw3ps1v8uBpl39NFNpXLN0uTnBkzJoOzOMWVt0AoLceYnw2FSvnv/Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786286889; c=relaxed/simple;
	bh=O4Gq3qUcYmQO19Z8++ndT+e3pQ2kDsjBtJ9sYM1uGQ4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R8lQlQvHlmX7we+Vu5kKN8+lkWj/4SpSHmsMxBccTqJOpw7RdJPGOFQwDjiipPPfRQ90/P+gKNpK1vIURNxSAzl1R/35c9geVRCE9u7rvzUd+FQg5RbH7m/si0pOthZ9gQrKbDodw7T0WG/CLJTJYjufv9F67GgJ9iSBM7a8u6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=IQeF2E+l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="IQeF2E+l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599161F00A3D;
	Sun,  9 Aug 2026 14:48:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786286885;
	bh=UoPA7kBtZDug/QwlDhfMO2M22Nwl/4XhJlWk94dOKR4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=IQeF2E+lXxj166VgPc282Fqm/8mV7Qj4UFH0dwQ+l37s5bkZranppLI0DoAzjIvO5
	 BJimBc31DNWcE55UeuBY3sxg5moc/O3282Sx2ISVvjW8EsMmQtUgsmBi7w+/MEQEGi
	 +7nygaeJE3n/IjZ2K+6Rqi+XmNfzSYF4DnIPvDvNJ9OW0jPkJHMfHkQKNR+HAskDGL
	 StZgImtQayhY7baa838tz9qYG68nOp/sNaxQQ2IHrqE/Tp/wjwJp20Mlm09NmcRmkw
	 MnqIbnPILCVFGijBD7YIQ+RmOPXzPMHQQppZN0P7IXP7zDpIg2ITaKBvQ0qibVfDmi
	 6YglXoQmYNyVw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Filipe Manana <fdmanana@suse.com>,
	Johannes Thumshirn <johannes.thumshirn@wdc.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/4] btrfs: remove fs_info argument from btrfs_zoned_activate_one_bg()
Date: Sun,  9 Aug 2026 10:48:00 -0400
Message-ID: <20260809144801.1787109-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260809144801.1787109-1-sashal@kernel.org>
References: <2026080520-punk-economist-e412@gregkh>
 <20260809144801.1787109-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Filipe Manana <fdmanana@suse.com>

[ Upstream commit a232ff90d14657c8637c6e94b606bb5d700a2ecb ]

We don't need it since we can grab fs_info from the given space_info.
So remove the fs_info argument.

Reviewed-by: Johannes Thumshirn <johannes.thumshirn@wdc.com>
Signed-off-by: Filipe Manana <fdmanana@suse.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 8bc4d7209611 ("btrfs: zoned: fix missing chunk metadata reservation")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/block-group.c | 4 ++--
 fs/btrfs/zoned.c       | 5 ++---
 fs/btrfs/zoned.h       | 6 ++----
 3 files changed, 6 insertions(+), 9 deletions(-)

diff --git a/fs/btrfs/block-group.c b/fs/btrfs/block-group.c
index a40814eb121b3..2e7351bbd23cc 100644
--- a/fs/btrfs/block-group.c
+++ b/fs/btrfs/block-group.c
@@ -3092,7 +3092,7 @@ int btrfs_inc_block_group_ro(struct btrfs_block_group *cache,
 	 * We have allocated a new chunk. We also need to activate that chunk to
 	 * grant metadata tickets for zoned filesystem.
 	 */
-	ret = btrfs_zoned_activate_one_bg(fs_info, space_info, true);
+	ret = btrfs_zoned_activate_one_bg(space_info, true);
 	if (ret < 0)
 		goto out;
 
@@ -4350,7 +4350,7 @@ static void reserve_chunk_space(struct btrfs_trans_handle *trans,
 			 * We have a new chunk. We also need to activate it for
 			 * zoned filesystem.
 			 */
-			ret = btrfs_zoned_activate_one_bg(fs_info, info, true);
+			ret = btrfs_zoned_activate_one_bg(info, true);
 			if (ret < 0)
 				return;
 
diff --git a/fs/btrfs/zoned.c b/fs/btrfs/zoned.c
index d9c26f4be6634..16f88e76ca30a 100644
--- a/fs/btrfs/zoned.c
+++ b/fs/btrfs/zoned.c
@@ -2821,10 +2821,9 @@ int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 	return ret < 0 ? ret : 1;
 }
 
-int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
-				struct btrfs_space_info *space_info,
-				bool do_finish)
+int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info, bool do_finish)
 {
+	struct btrfs_fs_info *fs_info = space_info->fs_info;
 	struct btrfs_block_group *bg;
 	int index;
 
diff --git a/fs/btrfs/zoned.h b/fs/btrfs/zoned.h
index f7171ab6ed71e..224e1889dc823 100644
--- a/fs/btrfs/zoned.h
+++ b/fs/btrfs/zoned.h
@@ -93,8 +93,7 @@ bool btrfs_zoned_should_reclaim(const struct btrfs_fs_info *fs_info);
 void btrfs_zoned_release_data_reloc_bg(struct btrfs_fs_info *fs_info, u64 logical,
 				       u64 length);
 int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info);
-int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
-				struct btrfs_space_info *space_info, bool do_finish);
+int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info, bool do_finish);
 void btrfs_check_active_zone_reservation(struct btrfs_fs_info *fs_info);
 #else /* CONFIG_BLK_DEV_ZONED */
 
@@ -258,8 +257,7 @@ static inline int btrfs_zone_finish_one_bg(struct btrfs_fs_info *fs_info)
 	return 1;
 }
 
-static inline int btrfs_zoned_activate_one_bg(struct btrfs_fs_info *fs_info,
-					      struct btrfs_space_info *space_info,
+static inline int btrfs_zoned_activate_one_bg(struct btrfs_space_info *space_info,
 					      bool do_finish)
 {
 	/* Consider all the block groups are active */
-- 
2.53.0

