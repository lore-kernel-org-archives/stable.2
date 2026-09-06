Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BC0903B9931
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 17:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715148; cv=none; b=MS5xIUFWc0Od+d8fzFJb3ksCBfmeCMFkB8jICjIA0mc/sq4/O+z3Z9D7J1lCmILjsL7X1NY/mSGF9n58RFrCLsdN0ocDg+LWCaQwUQjpPOe2rZ5Bu6S2238F7msHR5+Zlw6j3YR86+alP2qjaZV5TdiL7oAhSJ25uzT5gIOHkVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715148; c=relaxed/simple;
	bh=cW6At06wOm7qqR3i9DJE2Ix8rgu8q/LENAP/k9GY1dY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Szqy4aoB8sFSqrxhcXjpRu8QDAe7POLAXcuGcJStjt3K1Dp1VljCIs90jvO+Yewz7ATX/kpwkIFNxwoZ8bB67N9CEwadhWwGzSXNzTvQiXALCp7iQSp9XRsClz4eJHfiLscbnJEYHCSpa0a9QadxICsqvV22m/pTKI9D1OcJNmk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=W6MCNxsY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="W6MCNxsY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A2FC1F00AC4;
	Sun,  6 Sep 2026 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788715146;
	bh=vwU/v5JvwPCchStvl9o1dKStBer3ZRUb3vOqq4npmWk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=W6MCNxsY+1Mg1ja97LbFC3u7IB8Sj/5stRpIM/HTbEvS/VXfl2VBRImbse85Jpb8T
	 FnAGi8q06AYKScUiD26rA5ceqFNdeRJGJoVS9J4ambTO/QRM8Etud6VjVrDrzQmarL
	 0sgCFOxo1psdJcmK3SZSyfmtUTYybt9BxZvZm0RO76vJj+Ukz7Dhj7k5bn6hxdTKJC
	 AGKGVH//o0gRhgb4SQ98owR/t8kRhWQk/He9YejIxZCf0udmEwGPejuleVN1SrOptr
	 COWYU7JJK62VBrwczwcdjNp/05Zp/ADAfNTd6EOsal27rQJlqBW6azv5K9B9RNutxm
	 RTI/BGpq5cySw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 4/5] btrfs: rename ret to err in btrfs_recover_relocation()
Date: Sun,  6 Sep 2026 13:19:01 -0400
Message-ID: <20260906171902.1684623-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906171902.1684623-1-sashal@kernel.org>
References: <2026090300-visible-upwind-24ae@gregkh>
 <20260906171902.1684623-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Anand Jain <anand.jain@oracle.com>

[ Upstream commit ba69f42af2a568f30904a11dc257eb892c5e8c0e ]

In the function btrfs_recover_relocation(), currently the variable 'err'
carries the return value and 'ret' holds the intermediary return value.
However, in some lines, we don't need this two-step approach; we can
directly use 'err'. So, optimize them, which requires reinitializing 'err'
to zero at two locations.

This is a preparatory patch to fix the code style by renaming 'err'
to 'ret'.

Signed-off-by: Anand Jain <anand.jain@oracle.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Stable-dep-of: 6d8ba4572922 ("btrfs: drop recovered reloc root refs on recovery failure")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 52 ++++++++++++++++++++-----------------------
 1 file changed, 24 insertions(+), 28 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0442cfe70b323..175ef3c931e70 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3755,8 +3755,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	struct extent_buffer *leaf;
 	struct reloc_control *rc = NULL;
 	struct btrfs_trans_handle *trans;
-	int ret;
-	int err = 0;
+	int ret2;
+	int ret = 0;
 
 	path = btrfs_alloc_path();
 	if (!path)
@@ -3770,15 +3770,14 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	while (1) {
 		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
 					path, 0, 0);
-		if (ret < 0) {
-			err = ret;
+		if (ret < 0)
 			goto out;
-		}
 		if (ret > 0) {
 			if (path->slots[0] == 0)
 				break;
 			path->slots[0]--;
 		}
+		ret = 0;
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		btrfs_release_path(path);
@@ -3789,7 +3788,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 		reloc_root = btrfs_read_tree_root(root, &key);
 		if (IS_ERR(reloc_root)) {
-			err = PTR_ERR(reloc_root);
+			ret = PTR_ERR(reloc_root);
 			goto out;
 		}
 
@@ -3801,15 +3800,12 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 					reloc_root->root_key.offset, false);
 			if (IS_ERR(fs_root)) {
 				ret = PTR_ERR(fs_root);
-				if (ret != -ENOENT) {
-					err = ret;
+				if (ret != -ENOENT)
 					goto out;
-				}
 				ret = mark_garbage_root(reloc_root);
-				if (ret < 0) {
-					err = ret;
+				if (ret < 0)
 					goto out;
-				}
+				ret = 0;
 			} else {
 				btrfs_put_root(fs_root);
 			}
@@ -3827,7 +3823,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	rc = alloc_reloc_control(fs_info);
 	if (!rc) {
-		err = -ENOMEM;
+		ret = -ENOMEM;
 		goto out;
 	}
 
@@ -3837,7 +3833,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_unset;
 	}
 
@@ -3857,15 +3853,15 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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
@@ -3875,8 +3871,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		btrfs_put_root(fs_root);
 	}
 
-	err = btrfs_commit_transaction(trans);
-	if (err)
+	ret = btrfs_commit_transaction(trans);
+	if (ret)
 		goto out_unset;
 
 	merge_reloc_roots(rc);
@@ -3885,14 +3881,14 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
 	trans = btrfs_join_transaction(rc->extent_root);
 	if (IS_ERR(trans)) {
-		err = PTR_ERR(trans);
+		ret = PTR_ERR(trans);
 		goto out_clean;
 	}
-	err = btrfs_commit_transaction(trans);
+	ret = btrfs_commit_transaction(trans);
 out_clean:
-	ret = clean_dirty_subvols(rc);
-	if (ret < 0 && !err)
-		err = ret;
+	ret2 = clean_dirty_subvols(rc);
+	if (ret2 < 0 && !ret)
+		ret = ret2;
 out_unset:
 	unset_reloc_control(rc);
 	free_reloc_control(rc);
@@ -3901,14 +3897,14 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 
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

