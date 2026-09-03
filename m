Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E724AF68B
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 13:47:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788443253; cv=none; b=edQOTazN2y2X0OoM+cHt2JtcHqbmgOgGMRVlXy9+C1aCxbc3YN+FmUv2BQrOGLJZLf3YEuhzG9/SCWR8TGBZ8VnwVuB4eq/wh2O5/IBpgra3s1BbfOICCAP64EDgUvH0ZhFE98foeVEnMSdG0zeqQbUJz8wdOf5lILnQdUDIBIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788443253; c=relaxed/simple;
	bh=ajZ9uevSJ+RMJrCKfiqWT/DNai3c9TmZhOIn5zELYao=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=TUZgNEtSteKXKiNNkfurG5sYiTxE1DlqQQxlC7l5hIlWw4ksRLfvPCmnmKxHSm9pWAdxgvQSN9SHhJPdTbVf/Bg60y+ZcTQ90UTF8V8RPV9A6jNHDw/LlwfMSZNAcJekEkVYZQYSQlYeie8mF49nv4zylWGTMWIKkc8cw3Ph1N8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=o+sj18EB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="o+sj18EB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD0AB1F00A3D;
	Thu,  3 Sep 2026 13:47:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788443242;
	bh=TthsSjyIfnI0X6foYJtyc5BRlUsciYNwOTaRyERioXE=;
	h=Subject:To:Cc:From:Date;
	b=o+sj18EBAmjDUMj6rOWIf1BDuGr1vwOjvvHVlxX+huEhAsmAfWxgt67Erm67+GsEg
	 2qiLPdk+jnNl1AJvfgRnCIjB63AF0eiHUzKj9zyKjo0z7lqCgU97CGQspt/n5tfbV3
	 fXfKz4UeLWk0zuSVKn0rI8d+v218PIIM/SNBTaGE=
Subject: FAILED: patch "[PATCH] btrfs: drop recovered reloc root refs on recovery failure" failed to apply to 5.15-stable tree
To: 3497809730@qq.com,dsterba@suse.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 03 Sep 2026 15:23:59 +0200
Message-ID: <2026090359-pebble-underpaid-4ffa@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 6d8ba4572922e336f0b59a80751b018e1e135164
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090359-pebble-underpaid-4ffa@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 6d8ba4572922e336f0b59a80751b018e1e135164 Mon Sep 17 00:00:00 2001
From: Guanghui Yang <3497809730@qq.com>
Date: Sun, 12 Jul 2026 04:22:32 +0000
Subject: [PATCH] btrfs: drop recovered reloc root refs on recovery failure

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

diff --git a/fs/btrfs/relocation.c b/fs/btrfs/relocation.c
index f14bb4158d8d..da54db75e7a9 100644
--- a/fs/btrfs/relocation.c
+++ b/fs/btrfs/relocation.c
@@ -5593,6 +5593,24 @@ static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
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
@@ -5602,6 +5620,7 @@ static noinline_for_stack int mark_garbage_root(struct btrfs_root *root)
 int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 {
 	LIST_HEAD(reloc_roots);
+	LIST_HEAD(recovered_roots);
 	struct btrfs_key key;
 	struct btrfs_root *fs_root;
 	struct btrfs_root *reloc_root;
@@ -5718,7 +5737,7 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 			ret = PTR_ERR(fs_root);
 			list_add_tail(&reloc_root->root_list, &reloc_roots);
 			btrfs_end_transaction(trans);
-			goto out_unset;
+			goto out_drop_reloc_refs;
 		}
 
 		ret = __add_reloc_root(reloc_root, rc);
@@ -5727,15 +5746,17 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
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
 
 	ret = merge_reloc_roots(rc);
 	if (ret)
@@ -5753,6 +5774,8 @@ int btrfs_recover_relocation(struct btrfs_fs_info *fs_info)
 	ret2 = clean_dirty_subvols(rc);
 	if (ret2 < 0 && !ret)
 		ret = ret2;
+out_drop_reloc_refs:
+	release_recovered_fs_roots(&recovered_roots, true);
 out_unset:
 	unset_reloc_control(rc);
 	reloc_chunk_end(fs_info);

