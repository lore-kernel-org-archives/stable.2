Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA8313939B9
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 15:57:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788710230; cv=none; b=rUiVVVEZbbNhgTLO2yZJ3K/PYuqaQuJpxlSOxTNhadUcBDtOgzUO9NjuWY8Yfqfp5kqoQHYuaexPBDMalPSk8RxJMp2z2+WV1qDEdIdq6Ab4vhPgoDEDIjEvm6WKmBZgWgnUQ8ZsNeSt1BB/ql6OuqLa93kt/3TNY9GMGmEIf0g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788710230; c=relaxed/simple;
	bh=3VMqVx3BKwaeyIDGn3/GPyXSlRhwmpgEdyzo6ILA03Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JMaOwMllCkdOW8qZ3yZUg7uqu9PZVyw7jzln2AkmrP1gU3bCNjl8zEny/UiV/2Oh1XR7LLJsZ2zkeRxLae1dhxckIHa8zOLxW0/xU3UZXGYN3cY429pRikJ7dq+WCe9RpdOCcppJxo5QVsReOIWBo/0uX3dBzducMRlc2SidlLc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nRv2dUpI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nRv2dUpI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42D961F00A3A;
	Sun,  6 Sep 2026 15:57:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788710225;
	bh=yHmG/EqmQJFkKXb6NwOc2aCUYc8nd68vqBV/Fl8wX94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=nRv2dUpI3RwBZAGwSKtXqJY7uIcprqcbxrjB3A9NvucbtCSZgk5Va2FWCyR5dn6gC
	 NnW6QYmGVRgdqZK4vG08+NtRhUFBpaQoQsLSvVzulXMlj6AtxtT9l9siTwQvoaxI0I
	 7RCifU2bLUtbMK90+hKPpFImleWs182SuRDBbvYx+Ofrftzt60fuFscpsc5rgi3tvz
	 CP9c5TtPkEY4eYWji7oihfmlv5OdmqlNwW4beMiAbyB1jlAAzwh7nzvZkXtOVHSmDZ
	 zlpxNJFoczhv9EE4H3tszYbI6EYcvsZaTpQbbF110VfifPBFRlJuTFFA7SN3Rd2GHO
	 Hd+d7iERHACzw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/4] btrfs: rename ret to err in btrfs_recover_relocation()
Date: Sun,  6 Sep 2026 11:57:00 -0400
Message-ID: <20260906155703.1520234-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090358-pursuit-extruding-d750@gregkh>
References: <2026090358-pursuit-extruding-d750@gregkh>
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
 fs/btrfs/relocation.c | 28 +++++++++++-----------------
 1 file changed, 11 insertions(+), 17 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 0b7a4b9005369..625142d8ede43 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4194,17 +4194,16 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	key.offset = (u64)-1;
 
 	while (1) {
-		ret = btrfs_search_slot(NULL, fs_info->tree_root, &key,
+		err = btrfs_search_slot(NULL, fs_info->tree_root, &key,
 					path, 0, 0);
-		if (ret < 0) {
-			err = ret;
+		if (err < 0)
 			goto out;
-		}
-		if (ret > 0) {
+		if (err > 0) {
 			if (path->slots[0] == 0)
 				break;
 			path->slots[0]--;
 		}
+		err = 0;
 		leaf = path->nodes[0];
 		btrfs_item_key_to_cpu(leaf, &key, path->slots[0]);
 		btrfs_release_path(path);
@@ -4226,16 +4225,13 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 			fs_root = btrfs_get_fs_root(fs_info,
 					reloc_root->root_key.offset, false);
 			if (IS_ERR(fs_root)) {
-				ret = PTR_ERR(fs_root);
-				if (ret != -ENOENT) {
-					err = ret;
+				err = PTR_ERR(fs_root);
+				if (err != -ENOENT)
 					goto out;
-				}
-				ret = mark_garbage_root(reloc_root);
-				if (ret < 0) {
-					err = ret;
+				err = mark_garbage_root(reloc_root);
+				if (err < 0)
 					goto out;
-				}
+				err = 0;
 			} else {
 				btrfs_put_root(fs_root);
 			}
@@ -4257,11 +4253,9 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 		goto out;
 	}
 
-	ret = reloc_chunk_start(fs_info);
-	if (ret < 0) {
-		err = ret;
+	err = reloc_chunk_start(fs_info);
+	if (err < 0)
 		goto out_end;
-	}
 
 	rc->extent_root = btrfs_extent_root(fs_info, 0);
 
-- 
2.53.0

