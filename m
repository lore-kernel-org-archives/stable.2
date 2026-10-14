Received: from mail-pg1-f181.google.com (mail-pg1-f181.google.com [209.85.215.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0132331A63
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 03:47:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791949643; cv=none; b=d2yhBJcVvw/8IoKABTEa0qwS4MYN0iuAdFh+ckl2o+W0dWVNrgh8UC9ONcJ9P5Phl+QXBntyTGMXSR0JC5vEStyzchcmXRCQ1kpZqY7z4af4rbiDm25mZsAfseem7dpvWFRyETPi6sDPX9lF9waZBOOarWAmgy/TaDrk9/8PP2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791949643; c=relaxed/simple;
	bh=HS1wHWsDOr6aHX0hoYpK3rAOrYOi2Hl0QD71HWWO310=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=Pq90zl5Vqo25q0TTvD1luQflhQHd6ekbYIaEyj/i1ntfFOtXk7OAHDxJ1SY/Um3lpUQmN0uj/trtcBVf/G2wNsadc/pS8Ll1dDJwB0UVOv683klpYiwP3glyoF+bthvnIKoBq3D+cU+GYzb5krZTrwZ2O49/NEulytgukTv9Cu4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=X6DJaF9n; arc=none smtp.client-ip=209.85.215.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="X6DJaF9n"
Received: by mail-pg1-f181.google.com with SMTP id 41be03b00d2f7-cd5c9e52398so1567294a12.1
        for <stable@vger.kernel.org>; Tue, 13 Oct 2026 20:47:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791949641; x=1792554441; darn=vger.kernel.org;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=hg3Ib/3SZ5QgDJKkzlM/abstX2kfUMwhE6cPvMDLrDw=;
        b=X6DJaF9nWEsn71527cRQxCyyjQH78bNPywvztZP9KnObx22NfvGFblmCv6lDLZEyUq
         5as9hyZb8OTboiaW2YqGA7CLZTlZaij58ckPAA2FZhEpF4R9Q2LQYNKkGCqhB4iSbD69
         wGMk16L37TwEH6ihrGSgQ1WrMWKwP/qVJpsHmVJYMZlVuOrqYiJZ3R5+hF4Nhn3xWAlP
         3V0SMhCMbRhK636SD5FmlL0/mB3+etJBjaTX2t5o1YgoPLZkwTLIfwU/9RgGRzoO+72U
         KIeclRceaKlgq6ZLu8526/KAna6GJulGBPA5Sr8S8o5tHYkeae4+v5fOYIyQaWlhWuUZ
         71jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791949641; x=1792554441;
        h=content-transfer-encoding:content-type:mime-version:message-id:date
         :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=hg3Ib/3SZ5QgDJKkzlM/abstX2kfUMwhE6cPvMDLrDw=;
        b=VsltebCE9BZ2bjihgXyapAJXe3sR7ERrwr6rdXiBzPyYmDsRe4GhFvUWpe583qkWRK
         vR5gjqZgAGA01Eiubn7uP+37Ud5ffRNzN1tAc6HifEOeeT8HzKzsOFNczqGURwMdQxLO
         Oc6ajsazLDMJ3qEJClK24ZiYcbBBESyUyiYBeusOxcV8LG9pFNgdy9ZUG8TqGFMLG5c2
         +onAgoxRTstAaRQnm4anOwj4PjbqZ7meId7Bojf2231jFEjp16cGsoCNAdte+1B8dy63
         CPiNIdejCY9r+mRvoDG9q9pN0Em+CZOKfZ2FrokmZv8pYsofhfDDBUUMVPvgVWqvIC0X
         1D1Q==
X-Forwarded-Encrypted: i=1; AKwUvBzQU9OYcaUeSo97t7PYUnwyOtwJCdkDQj/aCbCPaMyPWaF3rUd4VA5oVZ0gJ+SXnZrsp+kc5OM=@vger.kernel.org
X-Gm-Message-State: AFq9FYLnU3UizVc1Z8Ea6f1RL1LOnvAPe1EzzrOmGJZYHWj8g6c51IfR
	od9IQhCxu4gjtq1b91hSJnCklH57XEwemBsHZ/HAHPEDRah3qqTlgNWo
X-Gm-Gg: AYBFou3gavSdjYNYtIgdNlBjYxdxCB0ytp08IC0OZpO2V0Y81u6hBMeQ2YY6fe8c8vI
	WxWCbTp+0lvlHg8KfqHWEBTeRnb5CmxnX4mjSOO+fyX6UvQb1vLzXz0JQpPzS1T4+FQWb6PIvmK
	8ioVIhPjxtnV+HmvSfphzwp16ApQG0yCsEdqz2Zttizfvjveq5VZGhEvJk9yY/jwEyum9LQpU0v
	kizHDSFKH/7Zg0jKGyzbiqH73ZALzWJQgleeJ9rPdF/fNvbEZxns87rWnDrxLlVwctfl9lMqck9
	1d0/L5S1QFMU1TBCwAf46wyxr3DPWjtbyzSx3yZjw/AX4c6lkKFHw6uOlHGEXwto95rW/UTd3fQ
	utXpm67p4gjxazogNuMqmOnPdk8uBVXFXxhX6tKBAfv9LiHFGxjdyqnQmFPl2p+8LX+/jFZsz8D
	XQrO51Dz/K7Sj9fBZPPDZGt77rJnXwVVbkfItTAce2UGbDUse5wD4n2OWdN+pY1lMuCw==
X-Received: by 2002:a17:90b:1e49:b0:3ab:e588:c29a with SMTP id 98e67ed59e1d1-3abe588faf0mr7144466a91.6.1791949641023;
        Tue, 13 Oct 2026 20:47:21 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ac5f24af99sm2423518a91.8.2026.10.13.20.47.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Oct 2026 20:47:20 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com,
	heming.zhao@suse.com,
	tao.ma@oracle.com
Cc: ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ocfs2: Pin refcount trees before dropping the lookup lock
Date: Wed, 14 Oct 2026 11:47:15 +0800
Message-Id: <pm-ocfs2-objects-candidate-0037-v4-9f1a261dfbc341721689@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

A refcount tree returned to ocfs2_lock_refcount_tree() must stay alive
until that caller releases its operation reference. However,
ocfs2_get_refcount_tree() returns the cached pointer after dropping
osb_lock, and the caller only takes its kref afterwards. The registry
reference does not protect this gap from concurrent removal.

This can happen when another node frees a refcount root and reuses its
block with a different generation while this mount retains the old
cached tree. Two local operations on different inodes sharing the new
root, such as data CoW and an external xattr update, can then look up
the same stale tree. Their inode locks are independent, and both the
REFCOUNT DLM lock and rf_sem are acquired after the first operation
reference.

The following ordering is possible, with no other operation references:

  Data CoW                         Xattr update
  --------                         ------------
  Look up the old tree under
    osb_lock, then drop osb_lock
                                   Look up the same tree and take a kref
                                   Acquire the tree locks and read the
                                     new on-disk generation
                                   Erase the old tree under osb_lock
                                   Unlock and drop the operation kref
                                   Drop the registry kref, freeing tree
  Take a kref through the
    freed tree pointer

The final kref_get() accesses freed rf_getcnt storage, and subsequent
accesses in ocfs2_lock_refcount_tree() also use the freed allocation.

Take the operation reference in ocfs2_get_refcount_tree() before
releasing osb_lock, including when an insertion loses to another lookup.
Removal must acquire the same lock, so it cannot drop the registry
reference before the lookup has pinned the tree. Keep the existing
unlock and error path puts. The two callers that already hold the
refcount tree lock keep their borrowed lookup behavior and do not
acquire an extra reference.

KASAN report as below:

    BUG: KASAN: slab-use-after-free in ocfs2_lock_refcount_tree+0x94a/0x9b0
    Read of size 4 at addr ffff888117212820 by task python3/497

[Kernel and hardware identification omitted.]

    Call Trace:
     <TASK>
     dump_stack_lvl+0x93/0xd0
     print_report+0xce/0x630
     ? ocfs2_lock_refcount_tree+0x94a/0x9b0
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __virt_addr_valid+0x20e/0x420
     ? ocfs2_lock_refcount_tree+0x94a/0x9b0
     kasan_report+0xe0/0x110
     ? ocfs2_lock_refcount_tree+0x94a/0x9b0
     ocfs2_lock_refcount_tree+0x94a/0x9b0
     ? __pfx_ocfs2_lock_refcount_tree+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? ocfs2_refcount_cow+0x3b6/0xd90
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __kmalloc_cache_noprof+0x28d/0x610
     ? ocfs2_refcount_cow+0x3b6/0xd90
     ocfs2_refcount_cow+0x410/0xd90
     ? __pfx_ocfs2_refcount_cow+0x10/0x10
     ? __pfx___might_resched+0x10/0x10
     ? down_write+0x11a/0x1f0
     ? __pfx_down_write+0x10/0x10
     ? ocfs2_inode_unlock+0x1a9/0x260
     ? __pfx_ocfs2_inode_unlock+0x10/0x10
     ? ocfs2_file_write_iter+0x1413/0x1d30
     ocfs2_file_write_iter+0x157b/0x1d30
     ? __pfx_ocfs2_file_write_iter+0x10/0x10
     ? lock_acquire+0x190/0x300
     ? __x64_sys_pwrite64+0x1b7/0x220
     ? __pfx___might_resched+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? security_file_permission+0x26/0x80
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_is_held_type+0x8f/0x100
     vfs_write+0x639/0x1010
     ? __pfx_ocfs2_file_write_iter+0x10/0x10
     ? lock_vma_under_rcu+0x154/0x4a0
     ? __pfx_vfs_write+0x10/0x10
     ? lock_release+0x121/0x290
     ? srso_alias_return_thunk+0x5/0xfbef5
     __x64_sys_pwrite64+0x1b7/0x220
     ? __pfx___x64_sys_pwrite64+0x10/0x10
     ? irqentry_exit+0xbe/0x820
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? trace_hardirqs_on_prepare+0x11d/0x150
     ? srso_alias_return_thunk+0x5/0xfbef5
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

[Register dump omitted.]

     </TASK>

    Allocated by task 491:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     __kasan_kmalloc+0xaa/0xb0
     __kmalloc_cache_noprof+0x28d/0x610
     ocfs2_allocate_refcount_tree+0x49/0x1a0
     ocfs2_create_refcount_tree+0x5d7/0x1630
     ocfs2_attach_refcount_tree+0x57d/0x1100
     __ocfs2_reflink.isra.0+0x1c4/0x1940
     ocfs2_reflink+0x501/0x9b0
     ocfs2_reflink_ioctl+0x6b2/0x920
     ocfs2_ioctl+0x538/0x640
     __x64_sys_ioctl+0x163/0x1d0
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    Freed by task 498:
     kasan_save_stack+0x33/0x60
     kasan_save_track+0x14/0x30
     kasan_save_free_info+0x3b/0x60
     __kasan_slab_free+0x5f/0x80
     kfree+0x308/0x580
     ocfs2_lock_refcount_tree+0x672/0x9b0
     ocfs2_xattr_set+0x72c/0x2530
     ocfs2_xattr_user_set+0xaf/0xf0
     __vfs_setxattr+0x143/0x1b0
     __vfs_setxattr_noperm+0x112/0x5b0
     __vfs_setxattr_locked+0xfe/0x2b0
     vfs_setxattr+0x13c/0x370
     do_setxattr+0x128/0x170
     filename_setxattr+0x147/0x190
     path_setxattrat+0x1ac/0x260
     __x64_sys_setxattr+0xcb/0x140
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f

    The buggy address belongs to the object at ffff888117212800
     which belongs to the cache kmalloc-1k of size 1024
    The buggy address is located 32 bytes inside of
     freed 1024-byte region [ffff888117212800, ffff888117212c00)

[Page and memory dumps omitted.]

Fixes: 374a263e790c ("ocfs2: Add refcount tree lock mechanism.")
Cc: <stable@vger.kernel.org>
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>
Assisted-by: LLM

---
diff --git a/fs/ocfs2/refcounttree.c b/fs/ocfs2/refcounttree.c
index 3e9cccf06e48..4f13b5a6faa7 100644
--- a/fs/ocfs2/refcounttree.c
+++ b/fs/ocfs2/refcounttree.c
@@ -375,8 +375,10 @@ ocfs2_allocate_refcount_tree(struct ocfs2_super *osb, u64 rf_blkno)
 	return new;
 }
 
+/* Callers without the refcount tree lock must request a reference. */
 static int ocfs2_get_refcount_tree(struct ocfs2_super *osb, u64 rf_blkno,
-				   struct ocfs2_refcount_tree **ret_tree)
+				   struct ocfs2_refcount_tree **ret_tree,
+				   bool get_ref)
 {
 	int ret = 0;
 	struct ocfs2_refcount_tree *tree, *new = NULL;
@@ -433,6 +435,8 @@ static int ocfs2_get_refcount_tree(struct ocfs2_super *osb, u64 rf_blkno,
 	new = NULL;
 
 out:
+	if (get_ref)
+		ocfs2_refcount_tree_get(tree);
 	*ret_tree = tree;
 
 	osb->osb_ref_tree_lru = tree;
@@ -506,14 +510,12 @@ int ocfs2_lock_refcount_tree(struct ocfs2_super *osb,
 	struct ocfs2_refcount_block *rb;
 
 again:
-	ret = ocfs2_get_refcount_tree(osb, ref_blkno, &tree);
+	ret = ocfs2_get_refcount_tree(osb, ref_blkno, &tree, true);
 	if (ret) {
 		mlog_errno(ret);
 		return ret;
 	}
 
-	ocfs2_refcount_tree_get(tree);
-
 	ret = __ocfs2_lock_refcount_tree(osb, tree, rw);
 	if (ret) {
 		mlog_errno(ret);
@@ -2355,7 +2357,8 @@ int ocfs2_decrease_refcount(struct inode *inode,
 		goto out;
 	}
 
-	ret = ocfs2_get_refcount_tree(OCFS2_SB(inode->i_sb), ref_blkno, &tree);
+	ret = ocfs2_get_refcount_tree(OCFS2_SB(inode->i_sb), ref_blkno,
+				      &tree, false);
 	if (ret) {
 		mlog_errno(ret);
 		goto out;
@@ -2590,7 +2593,7 @@ int ocfs2_prepare_refcount_change_for_del(struct inode *inode,
 	BUG_ON(!ocfs2_is_refcount_inode(inode));
 
 	ret = ocfs2_get_refcount_tree(OCFS2_SB(inode->i_sb),
-				      refcount_loc, &tree);
+				      refcount_loc, &tree, false);
 	if (ret) {
 		mlog_errno(ret);
 		goto out;
