Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C95830BF6B
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 16:18:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711505; cv=none; b=khb/Hh6V4wJoTDuznhvo6xq/Vn4Vk6dZqzsQeGFA7jtXTvsFbug4UXyvnQHUixNZNbol2CeqUeHzBa/zM2hzWgTn5VKTD920itVQsGY0KkJ73XWXMAYYBc7RugmaVfYct0Sg+fQzhV7i5fRqMzVZYPM6Imc/Zj/QAlNetBfGkBw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711505; c=relaxed/simple;
	bh=4ZxgkDQh03nwbPc+vYLNijD37TPsLBhZwAuIyRCtuuw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nR5y7gY2II/sMoNyr1pqlBTIf7sk5Yf1QfZdCxiiBFYxhvoTv4T3R/N2vRvT0WoD+I6WcB0fVfj8+kLKDqRJ9a3YHOslT2plgubgT6ncMDu1SHKZweQP1qotVv/cuCWZvHk0x3pnWBVGo6yprKeG9YmhkZqGNjc9OUdzAsAA6KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MTtNtc7D; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MTtNtc7D"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 577C91F00A3A;
	Sun,  6 Sep 2026 16:18:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788711503;
	bh=1uAqthBh2fnNiK1eNiLkF/kyKqYQhNZLrqC8sSjqBYg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MTtNtc7DsNcHVj+u5MMH+DVOJb/glEDZ6R4EsuxWcMGCRi3ZZdEyr5WL94AZsllZH
	 6Xn8nQ1hVLzv+YbYl237fIiKlKZWN6JU+SvmkKu+XqchudUBcPylTpUWs5M5CnRbme
	 PaxqDoVov1Tlp2f1JHTBXFnd7Hcnufynyy1XlOlu1tRZ2F2vqCj1VR9lWPbaF48TG5
	 5O+drZHqeKDpRppRb0YCn/6FhmBvXeR5136nDnmVN66A+5R/oser8GzGTfFz6QfYiZ
	 YZgJfUFJcTI3VePbmbl56dNrghAYn0JvUSCtOyvmaT7sCqLSTCL6lJ7JDypyKqZLM1
	 FYR8pfdu3IQAA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] btrfs: rename ret to err in btrfs_recover_relocation()
Date: Sun,  6 Sep 2026 12:18:18 -0400
Message-ID: <20260906161821.1555270-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090359-pebble-underpaid-4ffa@gregkh>
References: <2026090359-pebble-underpaid-4ffa@gregkh>
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
index 06cf946834017..8e465849c26c3 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4220,17 +4220,16 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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
@@ -4252,16 +4251,13 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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
@@ -4283,11 +4279,9 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 		goto out;
 	}
 
-	ret = reloc_chunk_start(fs_info);
-	if (ret < 0) {
-		err = ret;
+	err = reloc_chunk_start(fs_info);
+	if (err < 0)
 		goto out_end;
-	}
 
 	rc->extent_root = fs_info->extent_root;
 
-- 
2.53.0

