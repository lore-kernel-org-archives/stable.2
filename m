Received: from mta0.migadu.com (out-227.mta0.migadu.com [91.218.175.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE1217C203
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 19:16:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788635798; cv=none; b=A0e0/FHdNyjs+q1O6rE55ZoBcwYebvApNobrGN1IhqMnwLB+YaZ1Y4L2DOTqiLtIemZf0jieYnSdXc+2wq8IJt5ezIfA50x5S1K0RJgskLAR7mzYX4wNsWEQbuJ4QlMeYB1msJIpu3H5/S6pboUgNeeI6X3lj9JgufMv1l4oSes=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788635798; c=relaxed/simple;
	bh=cGmV+/3nJC8/nassXpZyq+BiguCr6AKUYC9cG846EPM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q5aASRIuv9pQqMhn2rpfd/CceMXoo37XNVf3NSMZ8hlj0ATc2NO7fXL8mqu2oGIFhKcmnM3aQT4Ee5PL5b7ohPdfjteIvkiz3Dic9cpFDAZofIZUnu8uvlD+NFfVw9t6Q7hyUDU7bLochfNTkQGasWC1srUEk85CxRpXjhHgsro=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=ayzvBrmn; arc=none smtp.client-ip=91.218.175.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="ayzvBrmn"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=cGmV+/3nJC8/nassXpZyq+BiguCr6AKUYC9cG846EPM=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788635794; v=1; x=1789240594;
 b=ayzvBrmn/I6m526ojzaJbb/XU5tGL5O1WFhMXy85B2DULTpEg9avLLHv3L7unmSFVeghSuYG
 5mIw97orW9PURoxfxZQxfLu6lqD5kEi3uOKsBj29Z6JKMCBaac68zecwUzaPlybYIC3uK4qeYbO
 3MkEUD45YCfca0pgNGIx5ysE=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id ed91021f9d781103;
	Sat, 05 Sep 2026 19:16:34 +0000
X-Mizu-Trace-ID: ed91021f9d781103
X-Migadu-Flow: FLOW_OUT
From: Shakeel Butt <shakeel.butt@linux.dev>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Tejun Heo <tj@kernel.org>,
	Christian Brauner <christian@brauner.io>
Cc: Meta kernel team <kernel-team@meta.com>,
	linux-kselftest@vger.kernel.org,
	driver-core@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 3/4] kernfs: don't lose IN_DELETE_SELF when decoding a file handle
Date: Sat,  5 Sep 2026 12:16:12 -0700
Message-ID: <20260905191613.3143937-4-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260905191613.3143937-1-shakeel.butt@linux.dev>
References: <20260905191613.3143937-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__kernfs_remove() clears i_nlink on a node's inodes and finds them with
ilookup().  A decode that has pinned the node but not yet hashed its
inode is invisible to that pass:

  CPU0                                    CPU1
  open_by_handle_at()
    kernfs_find_and_get_node_by_id()
      pins the node, still active
                                          rmdir()
                                            marks the subtree removing
                                            ilookup() finds no inode
    kernfs_get_inode()
      hashes an inode with i_nlink 1

Nothing fixes it later: kernfs_refresh_inode() never touches i_nlink for
a file and skips it for a directory being removed.  The inode keeps the
1 it was born with, and dentry_unlink_inode() sends IN_DELETE_SELF only
at 0, so a watcher never learns the node went away.

The other callers of kernfs_get_inode() are safe: those in fs/kernfs
hold kernfs_rwsem, and cgroup_may_write() is covered by cgroup_mutex,
which cgroup_destroy_locked() holds across kernfs_remove().
__kernfs_fh_to_dentry() has held nothing since exportfs support was
added.

Take kernfs_rwsem for reading, as ->get_parent already does, and cover
the lookup as well as kernfs_get_inode().  __kernfs_remove() deactivates
the whole subtree under the write lock, so under the read lock either
the lookup refuses the node, or the inode is hashed before the ilookup()
pass runs.  The same holds for ->fh_to_parent, since a node cannot be
active while an ancestor is being removed.

Reproduced with a 300ms delay between the lookup and kernfs_get_inode(),
decoding a handle for a file in a cgroup directory while another task
rmdir()s it: st_nlink is 1 without this patch and 0 with it.

->get_parent still has a window of its own.  It takes the same lock but
has no active check, so reconnect_path() can build an inode for an
ancestor that is already gone.  That needs the active test rather than a
lock, and changes what ->get_parent returns, so it is left to the series
that reworks these paths.

Fixes: eea5d2bb34ba ("kernfs: Send IN_DELETE_SELF and IN_IGNORED")
Cc: stable@vger.kernel.org
Acked-by: Tejun Heo <tj@kernel.org>
Assisted-by: LLM
Signed-off-by: Shakeel Butt <shakeel.butt@linux.dev>
---
 fs/kernfs/mount.c | 32 +++++++++++++++++++++-----------
 1 file changed, 21 insertions(+), 11 deletions(-)

diff --git a/fs/kernfs/mount.c b/fs/kernfs/mount.c
index f183a96778b9..c15ba6357162 100644
--- a/fs/kernfs/mount.c
+++ b/fs/kernfs/mount.c
@@ -124,22 +124,32 @@ static struct dentry *__kernfs_fh_to_dentry(struct super_block *sb,
 		return NULL;
 	}
 
-	kn = kernfs_find_and_get_node_by_id(info->root, id);
-	if (!kn)
-		return ERR_PTR(-ESTALE);
+	/*
+	 * Hold kernfs_rwsem across the lookup as well as kernfs_get_inode().
+	 * __kernfs_remove() deactivates the subtree and clears i_nlink on its
+	 * inodes under the write lock, so under the read lock either
+	 * kernfs_find_and_get_node_by_id() refuses the node, or the inode is
+	 * in the inode hash before the ilookup() pass goes looking for it.
+	 */
+	scoped_guard(rwsem_read, &info->root->kernfs_rwsem) {
+		kn = kernfs_find_and_get_node_by_id(info->root, id);
+		if (!kn)
+			return ERR_PTR(-ESTALE);
 
-	if (get_parent) {
-		struct kernfs_node *parent;
+		if (get_parent) {
+			struct kernfs_node *parent;
 
-		parent = kernfs_get_parent(kn);
+			parent = kernfs_get_parent(kn);
+			kernfs_put(kn);
+			kn = parent;
+			if (!kn)
+				return ERR_PTR(-ESTALE);
+		}
+
+		inode = kernfs_get_inode(sb, kn);
 		kernfs_put(kn);
-		kn = parent;
-		if (!kn)
-			return ERR_PTR(-ESTALE);
 	}
 
-	inode = kernfs_get_inode(sb, kn);
-	kernfs_put(kn);
 	return d_obtain_alias(inode);
 }
 
-- 
2.53.0-Meta

