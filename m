Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B50533C1AD
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 16:18:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711506; cv=none; b=uWmtdbKmdEVYfdexJCuD+y6oQSxZ6GMp5z9yAcpu6f1Ip49uITSymp1QHtOmsOkxxLnafW95eP2f5O0o5SQfs68W8hXS80QXqPHvJKwbGXyAc1w+n0pqp6vBdHjT8o68LFVOY4PqMkN0iIBLoJGhXurKyKKNSMx+a/EMam3Apjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711506; c=relaxed/simple;
	bh=AL2QTHh4zmS+Lk1+ebQzMZ6NCqyWvt7RBsGz29ts/34=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bUUsTuQNmI8C0mBtRdhZOaSWlVCFWvCfJZn4UEoyVGU9rQqB7lZqaGNU0tooH5GmrxTc5K+Nhco/PyWJpPrlbUfeHma4W2p5MLLSsNJOIE98yt4xBrOv3AzVAW3el9rB/IiBfNYKIBP5y0YiH34q1gTuwee96tp+vWDTo/hgodM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kCEOGfjH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kCEOGfjH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9B051F00A3E;
	Sun,  6 Sep 2026 16:18:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788711505;
	bh=tZlGHVRtY84RbiBq7x7qNG9fG7y4H3tZvpD+zJF+Ucs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=kCEOGfjHCQSKhSFm/YSBg/k4n6BR0sFkYcClUzD5FS4LLzjiptXeyC3pbDmRsSGcO
	 cm7s+APLQur3saXMnGZU2JALgEClQ5lqklDkpVgqd+nSZc9+EWK9c79JMoMam0dM5k
	 tmaOn3qKbilkBQ7d+ry8bKGXLm5kvGzcSIB2+3j8ZYzHJkL1bEjNjz/TnOiSU3jaOr
	 0x/ZTKRrTLRBktZHGRCotHF6P6ycnLNxnBkqS2ksel56BYmLR5zHhluberYUwFEfts
	 DtgeyI5LgCwlGTHXMQMZiIsc170cE4o1peVpljsNqq9uSlMIHQpSeot2BRpKu9uf7W
	 DZ7S3lgdaMJvQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 3/4] btrfs: rename err to ret in btrfs_recover_relocation()
Date: Sun,  6 Sep 2026 12:18:20 -0400
Message-ID: <20260906161821.1555270-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906161821.1555270-1-sashal@kernel.org>
References: <2026090359-pebble-underpaid-4ffa@gregkh>
 <20260906161821.1555270-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit ced1b1bd214fab463f35438c63d9bc6b1a743cae ]

Fix coding style: rename the return variable to 'ret' in the function
btrfs_recover_relocation instead of 'err'.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 6d8ba4572922 ("btrfs: drop recovered reloc root refs on recovery failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 56 +++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 7aeb3ece89bc8..d2efa2c26b1ab 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4208,7 +4208,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	struct reloc_control *rc = NULL;
 	struct btrfs_trans_handle *trans;
 	int ret2;
-	int err = 0;
+	int ret = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -4220,16 +4220,16 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	key.offset = (u64)-1;
 
 	while (1) {
-		err = btrfs_search_slot(NULL, fs_info->tree_root, &key,
+		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
 					path, 0, 0);
-		if (err < 0)
+		if (ret < 0)
 			goto out;
-		if (err > 0) {
+		if (ret > 0) {
 			if (path->slots[0] == 0)
 				break;
 			path->slots[0]--;
 		}
-		err = 0;
+		ret = 0;
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		btrfs_release_path(path);
@@ -4240,7 +4240,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 		reloc_root = btrfs_read_tree_root(root, &key);
 		if (IS_ERR(reloc_root)) {
-			err = PTR_ERR(reloc_root);
+			ret = PTR_ERR(reloc_root);
 			goto out;
 		}
 
@@ -4251,13 +4251,13 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 			fs_root = btrfs_get_fs_root(fs_info,
 					reloc_root->root_key.offset, false);
 			if (IS_ERR(fs_root)) {
-				err = PTR_ERR(fs_root);
-				if (err != -ENOENT)
+				ret = PTR_ERR(fs_root);
+				if (ret != -ENOENT)
 					goto out;
-				err = mark_garbage_root(reloc_root);
-				if (err < 0)
+				ret = mark_garbage_root(reloc_root);
+				if (ret < 0)
 					goto out;
-				err = 0;
+				ret = 0;
 			} else {
 				btrfs_put_root(fs_root);
 			}
@@ -4275,12 +4275,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	rc = alloc_reloc_control(fs_info);
 	if (!rc) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
-	err = reloc_chunk_start(fs_info);
-	if (err < 0)
+	ret = reloc_chunk_start(fs_info);
+	if (ret < 0)
 		goto out_end;
 
 	rc->extent_root = fs_info->extent_root;
@@ -4289,7 +4289,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_unset;
 	}
 
@@ -4309,15 +4309,15 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		fs_root = btrfs_get_fs_root(fs_info, reloc_root->root_key.offset,
 					    false);
 		if (IS_ERR(fs_root)) {
-			err = PTR_ERR(fs_root);
+			ret = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_end_transaction(trans);
 			goto out_unset;
 		}
 
-		err = __add_reloc_root(reloc_root);
-		ASSERT(err != -EEXIST);
-		if (err) {
+		ret = __add_reloc_root(reloc_root);
+		ASSERT(ret != -EEXIST);
+		if (ret) {
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_put_root(fs_root);
 			btrfs_end_transaction(trans);
@@ -4327,8 +4327,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		btrfs_put_root(fs_root);
 	}
 
-	err = btrfs_commit_transaction(trans);
-	if (err)
+	ret = btrfs_commit_transaction(trans);
+	if (ret)
 		goto out_unset;
 
 	merge_reloc_roots(rc);
@@ -4337,14 +4337,14 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_clean;
 	}
-	err = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
 out_clean:
 	ret2 = clean_dirty_subvols(rc);
-	if (ret2 < 0 && !err)
-		err = ret2;
+	if (ret2 < 0 && !ret)
+		ret = ret2;
 out_unset:
 	unset_reloc_control(rc);
 	reloc_chunk_end(fs_info);
@@ -4355,14 +4355,14 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	btrfs_free_path(path);
 
-	if (err == 0) {
+	if (ret == 0) {
 		/* cleanup orphan inode in data relocation tree */
 		fs_root = btrfs_grab_root(fs_info->data_reloc_root);
 		ASSERT(fs_root);
-		err = btrfs_orphan_cleanup(fs_root);
+		ret = btrfs_orphan_cleanup(fs_root);
 		btrfs_put_root(fs_root);
 	}
-	return err;
+	return ret;
 }
 
 /*
-- 
2.53.0

