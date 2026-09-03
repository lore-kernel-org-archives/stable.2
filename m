Received: from mta0.migadu.com (out-42.mta0.migadu.com [91.218.175.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 425253655E9
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 04:03:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788408233; cv=none; b=t5yUqQ9kldr2bSLw6aXiagSWFUeD8I+uPlHAkjaZ9hLxBwylURYT6hBeTGTD9xcQcuH0W7feGPOx0GHrdSAHubolwYsJny4kYx5dovE5nW6x78hL3DpCsnvmZnjLGcBELB8jLKA7SiXTd2/cTDpjvOSahxGVtLRM9x9s6iMsHxI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788408233; c=relaxed/simple;
	bh=/Cx+kQIoXQn4f56wMN2TAMtu+h068kTZbFYbYyLO0HE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bgoZRAqY/akM5afgdjAsrjf5PuE75bwcr3jC627KLBqbMjXhj6xANkYXsb1iYN/DspqPlFLB4QVW9T48SSmrMsCNjZeNka/KEFS8N9HTrm4UFi/BnUCgZf3RY49ovu4uvpRuxoabLv/Mf7uBMx1aAVFCrJaF9wUXnvnFULu8y08=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=MdDMt0F6; arc=none smtp.client-ip=91.218.175.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="MdDMt0F6"
X-Envelope-To: stable@vger.kernel.org
DKIM-Signature: a=rsa-sha256; bh=/Cx+kQIoXQn4f56wMN2TAMtu+h068kTZbFYbYyLO0HE=;
 c=simple/simple; d=linux.dev;
 h=from:to:subject:date:message-id:mime-version:content-type; s=key1;
 t=1788408229; v=1; x=1789013029;
 b=MdDMt0F6Sn82OrNSECBXHyv1ujwPZvQDqRZymovSMo0kiGSP6UG6zfpLdQHFQt9+rdNnHaAd
 3QWyWwBL8A+bYwuv8qT5zEfl8V1Cl6BWBf6v6fjBP2JzPs5uS6nEyMoZmFpy/vgRO0cykIFURBQ
 192ndQuRhQrkI9I7+ZA//p2s=
X-Envelope-To: stable@vger.kernel.org
Received: by smtp.migadu.com with ESMTPS id 7fbf072aebaeb1e4;
	Thu, 03 Sep 2026 04:03:49 +0000
X-Mizu-Trace-ID: 7fbf072aebaeb1e4
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
Subject: [PATCH 2/3] kernfs: don't lose IN_DELETE_SELF when decoding a file handle
Date: Wed,  2 Sep 2026 21:02:52 -0700
Message-ID: <20260903040253.670020-2-shakeel.butt@linux.dev>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260903040253.670020-1-shakeel.butt@linux.dev>
References: <20260903040253.670020-1-shakeel.butt@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

__kernfs_remove() clears i_nlink on the inode each superblock holds for
the node, and finds those inodes with ilookup().  A lookup that has
pinned the node but has not put its new inode in the inode hash yet is
invisible to that pass:

  CPU0                                    CPU1
  open_by_handle_at()
    kernfs_find_and_get_node_by_id()
      pins the node, still active
                                          rmdir()
                                            marks the subtree removing
                                            ilookup() finds no inode
    kernfs_get_inode()
      hashes an inode with i_nlink 1

Nothing corrects it afterwards, because kernfs_refresh_inode() skips
set_nlink() for a directory being removed and never touches i_nlink for
a file.  The inode keeps the i_nlink of 1 that inode_init_always() gave
it, and dentry_unlink_inode() only sends IN_DELETE_SELF when i_nlink is
0, so a watcher is never told the node went away.

kernfs_rwsem keeps the other callers of kernfs_get_inode() in fs/kernfs
out of that window, and the one outside it, cgroup_may_write(), is kept
out by cgroup_mutex, which cgroup_destroy_locked() holds across its
kernfs_remove().  __kernfs_fh_to_dentry() has neither; it has created
inodes without a lock ever since exportfs support was added.

Take kernfs_rwsem for reading, as ->get_parent already does.  It has to
cover the lookup by id as well, not just kernfs_get_inode():
__kernfs_remove() marks and deactivates the whole subtree under the write
lock before kernfs_drain() first drops it, so under the read lock an
active node is one that is not going away, and the lookup returns NULL
for the rest.  The other outcome, that CPU0 takes the lock first, leaves
the inode in the hash before the ilookup() pass runs, so the pass finds
it.

The same argument covers ->fh_to_parent, since a node cannot be active
while an ancestor is being removed.

Reproduced with a 300ms delay in __kernfs_fh_to_dentry(), between the
lookup by id and kernfs_get_inode(): one task decodes a handle for a
file in a cgroup directory while another rmdir()s that directory.  The
result has st_nlink 1 without this patch and 0 with it.

->get_parent keeps a window of its own that this does not close.  It
already holds the same lock, but it has no active check, so
reconnect_path() can still build an inode for an ancestor whose removal
has finished, on the very open_by_handle_at() that got here.  Closing
that wants the active test rather than another lock, and it changes what
->get_parent returns for a node that is already gone, so it is left to
the series that reworks these paths.

Fixes: eea5d2bb34ba ("kernfs: Send IN_DELETE_SELF and IN_IGNORED")
Cc: stable@vger.kernel.org
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

