Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17AAF36E477
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 16:12:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788711122; cv=none; b=gGMX+9lsL55wVGgrZcmel+bQOouyBvKCzYSQm2I5B6giuOk7VvW5mHLaUIcC/TgsGuMCdmwNlnYPc3bf2FiaXPqvr6+TswiRpslAXhjLm54AQ2oTGiRKNIU7cPzqM3kjRTY6sG/k6GKMoZQqkzrqXtkW7hvNAEMtZ///ffnMIYU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788711122; c=relaxed/simple;
	bh=aDjA6lBgGR0b7XhD/cHdSoNnSfZ/Tx78pjvL/H8JiI0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sGbHHaK2ZdItcY9/7QwhI0CBeIdfd5Xl8UlKjGR0Lz+D+NKTXRUDIiigPTBPron6n30Nm5ZjxAJp9YLvGF1xZ/yFyOJeYykkTmQpFQVOeLtuw+kycnJiCL7J3SsbEUYmvnB5PavQl4YP10q48pbbD4U7FXjBf+zMNMAUTx74p8M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ajJ8N7E3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ajJ8N7E3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B09A81F00ACA;
	Sun,  6 Sep 2026 16:11:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788711120;
	bh=KpGjRysMRHgQLQY2bizg4BEICrN4H8PE6alZOI1cwUM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ajJ8N7E39CoRUdosY3Flb0Qk2g9w+lzt5yCPd2W/W6+QdK6nQ2aezXnQ1TtoytDbH
	 vBIDSCRmYd1jVlo2TLJBQhosMBaC2Sf98JZ6Zv3KHBq2JdBDGK6CVRs/nBpeQKtE+x
	 IqcHPqMWGLFI/AeQilImvReUKT5SHCynf3VqJDbUK7kdtXUo+RbTUUc+v2KHxUEEji
	 qiaOzJf468eg29VxcBiKaF2f2VtYJpQnp7IfVEfBlVDJyPC3P7mPfvg/jz/l7PqA2H
	 EL7Ehjd+QexulG1OcWZUDGjHd/P77ME4EQ9d9To0VIwW7hSSTzP9QIwayjF/0fxFS0
	 yEMmxx7qIe3VQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guanghui Yang <3497809730@qq.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 4/4] btrfs: drop recovered reloc root refs on recovery failure
Date: Sun,  6 Sep 2026 12:11:56 -0400
Message-ID: <20260906161156.1545411-4-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260906161156.1545411-1-sashal@kernel.org>
References: <2026090359-float-gamma-d28d@gregkh>
 <20260906161156.1545411-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Guanghui Yang <3497809730@qq.com>

[ Upstream commit 6d8ba4572922e336f0b59a80751b018e1e135164 ]

During relocation recovery, each fs root gets a reference to its relocation
root. If loading or adding a later root fails, or if the first transaction
commit fails, btrfs_recover_relocation() jumps to out_unset before
merge_reloc_roots() and clean_dirty_subvols().

put_reloc_control() drops the list-owned relocation root references, but it
does not clear fs_root->reloc_root or drop the references owned by those
pointers. Mount cleanup only drops them when BTRFS_FS_ERROR is set, so an
error such as -ENOMEM while processing a later root can leave references
behind.

Keep temporary references to the fs roots associated during recovery. On
failure, clear their reloc_root pointers and drop the corresponding
references. Once the first transaction commit succeeds, drop only the
temporary fs root references and let the normal merge and cleanup paths
handle the relocation roots.

Fault injection on a pending-relocation image confirmed the cleanup gap.
With an injected first-commit failure, 25 fs roots had reloc_root set with
fs_error=0. With this fix, the same failure path drops that count to 0
before mount fails.

Fixes: f44deb7442ed ("btrfs: hold a ref on the root->reloc_root")
CC: stable@vger.kernel.org
Signed-off-by: Guanghui Yang <3497809730@qq.com>
Reviewed-by: David Sterba <dsterba@suse.com>
Signed-off-by: David Sterba <dsterba@suse.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/btrfs/relocation.c | 31 +++++++++++++++++++++++++++----
 1 file changed, 27 insertions(+), 4 deletions(-)

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index 8ec3f03605e4b..613b00a99d76b 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -4205,6 +4205,24 @@ static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
 	return ret;
 }
 
+static void release_recovered_fs_roots(struct list_head *roots, bool drop_reloc_refs)
+{
+	struct btrfs_root *root;
+	struct btrfs_root *next;
+
+	list_for_each_entry_safe(root, next, roots, reloc_dirty_list) {
+		list_del_init(&root->reloc_dirty_list);
+		if (drop_reloc_refs) {
+			struct btrfs_root *reloc_root = root->reloc_root;
+
+			ASSERT(reloc_root);
+			root->reloc_root = NULL;
+			btrfs_put_root(reloc_root);
+		}
+		btrfs_put_root(root);
+	}
+}
+
 /*
  * recover relocation interrupted by system crash.
  *
@@ -4214,6 +4232,7 @@ static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
 int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 {
 	LIST_HEAD(reloc_roots);
+	LIST_HEAD(recovered_roots);
 	struct btrfs_key key;
 	struct btrfs_root *fs_root;
 	struct btrfs_root *reloc_root;
@@ -4326,7 +4345,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 			ret = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_end_transaction(trans);
-			goto out_unset;
+			goto out_drop_reloc_refs;
 		}
 
 		ret = __add_reloc_root(reloc_root);
@@ -4335,15 +4354,17 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_put_root(fs_root);
 			btrfs_end_transaction(trans);
-			goto out_unset;
+			goto out_drop_reloc_refs;
 		}
+		ASSERT(list_empty(&fs_root->reloc_dirty_list));
 		fs_root->reloc_root = btrfs_grab_root(reloc_root);
-		btrfs_put_root(fs_root);
+		list_add_tail(&fs_root->reloc_dirty_list, &recovered_roots);
 	}
 
 	ret = btrfs_commit_transaction(trans);
 	if (ret)
-		goto out_unset;
+		goto out_drop_reloc_refs;
+	release_recovered_fs_roots(&recovered_roots, false);
 
 	merge_reloc_roots(rc);
 
@@ -4359,6 +4380,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	ret2 = clean_dirty_subvols(rc);
 	if (ret2 < 0 && !ret)
 		ret = ret2;
+out_drop_reloc_refs:
+	release_recovered_fs_roots(&recovered_roots, true);
 out_unset:
 	unset_reloc_control(rc);
 	reloc_chunk_end(fs_info);
-- 
2.53.0

