Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFB5734BA50
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 16:11:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711120; cv=none; b=SgiQNaJQKRmkYsSf4wyXwnPBvwOGqCXVUmaDxZ2nV4nOd6owvHwmKP/apadR4IvkXPhvtNGi6sqE348SPQip34Riyv9HS65jjqziGc/SZWwCyjliIucGN77Zn/S1RYrXshWgCYtVDiFcXrJx9rNUQLb5NkvnmO82lmv5C0eRkWY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711120; c=relaxed/simple;
	bh=uizrGdJanHuPNek3Q7NbR2WaNQQbsV4Y+p3OyvQ9QWI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Tt6QrQUoXfHCOBcNrp2Cw+gO5+cuujJZxjyqOZHzJ+nVAPDxn39SPQAe79QMD3r6r5zUigOic8IFJzAjf+y8NignHpw3UYpguu3lft4KcN9o+BwMGicvCm64h0RZVkOsEVB5zFaI+ctwsUjfoZKYiJpf2WtEHSj3uy+FJ55ruTo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lxHO+ky1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lxHO+ky1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DC091F00A3D;
	Sun,  6 Sep 2026 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788711118;
	bh=YRRANn9jmpvTCKwvrekDEgno5G51mtdzcMmmvbE7wNE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=lxHO+ky1JLaD3JkSEZHQdSVRBqK0KzLUajXgZfxtj8FXepkjLmFzfkax9P91X6Bi+
	 a25pMYPAkKRc2XKk+bqFy2mgdoPZkKCFrnf1lYRNagsuD9ULGvQ1pd2cJcwoEFQDKe
	 ixQ/ckgeRS9AeWrsyUp2h197Ex5deXIGEwJ81iOolk56KTzAxFSKRwGlzh7MkIb/+M
	 wKRRlCjdZPRIG24mzpVzw55MWIo/SACjd5suif2HMGoR6jpq4Ethzc36JnNsmf59VQ
	 ij+x/Z1m2Bqi5z4f5G8au+nvop6GoEDc8LtWLHarax3eoZJpj1Wwh25AjcC0vWa+ut
	 dhu5LFzhoLO3A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Anand Jain <anand.jain@oracle.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/4] btrfs: rename ret to err in btrfs_recover_relocation()
Date: Sun,  6 Sep 2026 12:11:53 -0400
Message-ID: <20260906161156.1545411-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090359-float-gamma-d28d@gregkh>
References: <2026090359-float-gamma-d28d@gregkh>
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
index d37904a806d6a..7034bbd007106 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4234,17 +4234,16 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
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
@@ -4266,16 +4265,13 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
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
@@ -4297,11 +4293,9 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
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

