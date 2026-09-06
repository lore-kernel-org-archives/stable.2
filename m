Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8253E3BD22B
	for <stable@vger.kernel.org>; Sun,  6 Sep 2026 17:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788715148; cv=none; b=N/aXKzVRjrIaa9PDJHA2fJUeN5FI3idAmI5qL6IZ7uSah6thhd9M0usA99vcGnbcRmTKC1w2oE+rMtvQ2DEq4GSLH84yCYJPV54pb7C5isRJFWC8RxPajZzN2Su5xi9qFy4ymJ06Wazp1uVFI+0QmUJfyTKTzPaKyiOjaMHaJN8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788715148; c=relaxed/simple;
	bh=z3vZU6kuk5Ro4FBx+iNDet7WyXfQBVZcdi4aVkQaUfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pC2gfP01swThPX+/LiItGjsK7LKzpKAJ6ZRwqiPoKdzZWSptOjjkCTv349XJwsCxWleqwkkRbAo6RmLnDcYZ6WRvpeqnYlYSykok+nvcp3ZwdJzP1SQRueHHGVdTonsRDvL/lNYBTN2Zhdwys66VMKTgccnBsy0cdBKeI1g/AGg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ZR8AntMy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ZR8AntMy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB36D1F00A3F;
	Sun,  6 Sep 2026 17:19:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788715147;
	bh=nLY8DazAhmFY5o3H2i1dOD01chfvm8BNIcN7OdEHoGQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZR8AntMy4Ywti0fv/MfIyKZkmGgCQHYb4gr668/amlAhPlEjHXcOob1pyvK9xu9Kg
	 RkIaO71uv4P/WdjPFXd4MMKt0FKZXgosGfo2Kj93vKlkC+yy0w3Eae1ytoll0FPpMw
	 2jjLYE3Op6NpWK9zJKSoYnJCPobtjOKcyVz1sbX9OEEataEI0qbcyiUu4O+F2oglDS
	 igkwnzhQpXdmSKiOc2VMAEx33uN0iVZ6i6BqIMoWOmkbQ5fPN0fGDtV8RXKWglylvJ
	 QUOROZOTQTBOIfX3bVo/if6CxZ4xX0dytolMZGwEbsB+PdE8ia6oTLQSJYVpcErpOa
	 QvibIaVmzkDKg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Guanghui Yang <3497809730@qq.com>,
	David Sterba <dsterba@suse.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/5] btrfs: drop recovered reloc root refs on recovery failure
Date: Sun,  6 Sep 2026 13:19:02 -0400
Message-ID: <20260906171902.1684623-5-sashal@kernel.org>
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
index 175ef3c931e70..5caabdeb96a60 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -3738,6 +3738,24 @@ static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
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
@@ -3748,6 +3766,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 {
 	struct btrfs_fs_info *fs_info = root->fs_info;
 	LIST_HEAD(reloc_roots);
+	LIST_HEAD(recovered_roots);
 	struct btrfs_key key;
 	struct btrfs_root *fs_root;
 	struct btrfs_root *reloc_root;
@@ -3856,7 +3875,7 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 			ret = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_end_transaction(trans);
-			goto out_unset;
+			goto out_drop_reloc_refs;
 		}
 
 		ret = __add_reloc_root(reloc_root);
@@ -3865,15 +3884,17 @@ int btrfs_recover_relocation(struct btrfs_root *root)
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
 
@@ -3889,6 +3910,8 @@ int btrfs_recover_relocation(struct btrfs_root *root)
 	ret2 = clean_dirty_subvols(rc);
 	if (ret2 < 0 && !ret)
 		ret = ret2;
+out_drop_reloc_refs:
+	release_recovered_fs_roots(&recovered_roots, true);
 out_unset:
 	unset_reloc_control(rc);
 	free_reloc_control(rc);
-- 
2.53.0

