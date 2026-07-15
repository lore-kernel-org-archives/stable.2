Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9943D3988E3
	for <stable@vger.kernel.org>; Wed, 15 Jul 2026 14:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784126929; cv=none; b=H6HQ8PwDGYD4/yORFKfaRnu5IB587XmGe8LqpEXhGX4MDdfYSDqddsrwHnS0CC4nNmPTu51HVO8cDhOx9fGCYSh0zCyPXYwJj4qffs4wItsPTfchDIBb7ff90I8mY9fOZdgYJ9BelnQKCi07zR07K7QXcKnZflKhwsULfeT2hh0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784126929; c=relaxed/simple;
	bh=/527jZQGPxzDZuVDMsDvvNPFKm7wt6EVXxYiui5uI/g=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AmQmETSbeoKQunx0mB5j07+owFwQgmVBTuFomNhynx4MGZWMRdZGuz9y0oCGyQXNs9DFmzcz79WA/OeFLffoNOLsOuGXmpdJX9Hq2lOzwL+XYaAbDsTG+qPr+Y+WHaw2kW4UsuQw3jsCJBeuhKxn1Z30PbJVStVjbd3tsOA1ERk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mnCnTbRf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mnCnTbRf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4F01F000E9;
	Wed, 15 Jul 2026 14:48:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1784126923;
	bh=fbu3uNu3ZqweWnuU01rr/3TIdw7hviX2b/ZKwxbi5L4=;
	h=Subject:To:Cc:From:Date;
	b=mnCnTbRfyEPZeWuQlKrSTuSl+4iMi6cp6VevRyN8GV58AO767+mk4++8ThW7dqXnp
	 +HOz4yj09fR8Q0c4nymnZR0bo7Qdc8zGwWi0qKr66+hJZN/tZWV8Bo+1zXI6/sr05m
	 WWj7gM5pp/RBVUazrlrdgfWZQnl4rWF6hPr6DPGU=
Subject: FAILED: patch "[PATCH] mm: do file ownership checks with the proper mount idmap" failed to apply to 6.1-stable tree
To: pfalcato@suse.de,akpm@linux-foundation.org,brauner@kernel.org,david@kernel.org,jack@suse.cz,jannh@google.com,liam@infradead.org,stable@vger.kernel.org,vbabka@kernel.org,viro@zeniv.linux.org.uk,willy@infradead.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 15 Jul 2026 16:48:36 +0200
Message-ID: <2026071536-clobber-subdivide-b287@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x e187bc02f8fa4226d62814592cf064ee4557c470
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026071536-clobber-subdivide-b287@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From e187bc02f8fa4226d62814592cf064ee4557c470 Mon Sep 17 00:00:00 2001
From: Pedro Falcato <pfalcato@suse.de>
Date: Thu, 25 Jun 2026 16:38:53 +0100
Subject: [PATCH] mm: do file ownership checks with the proper mount idmap

Ever since idmapped mounts were introduced, inode ownership checks (for
side-channel protection) in mincore() and madvise(MADV_PAGEOUT) were done
against the nop_mnt_idmap, which completely ignores the file's mount's
idmap.  This results in odd edgecases like:

1) mount/bind-mount with an idmap userA:userB:1
2) userB runs an owner_or_capable() check on file that is owned by userA
on-disk/in-memory, but owned by userB after idmap translation
3) owner_or_capable() mysteriously fails as the correct idmap wasn't supplied

In the case of mincore/madvise MADV_PAGEOUT, this is usually benign,
because file_permission(file, MAY_WRITE) will probably succeed, as it uses
the proper idmap internally, but it does not need to be the case on e.g a
0444 file where even the owner itself doesn't have permissions to write to
it.

Since this is clearly not trivial to get right, introduce a
file_owner_or_capable() that can carry the correct semantics, and switch
the various users in mm to it.

The issue was found by manual code inspection & an off-list discussion
with Jan Kara.

Link: https://lore.kernel.org/20260625153853.913949-1-pfalcato@suse.de
Fixes: 9caccd41541a ("fs: introduce MOUNT_ATTR_IDMAP")
Signed-off-by: Pedro Falcato <pfalcato@suse.de>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Christian Brauner (Amutable) <brauner@kernel.org>
Acked-by: David Hildenbrand (Arm) <david@kernel.org>
Cc: Al Viro <viro@zeniv.linux.org.uk>
Cc: Jann Horn <jannh@google.com>
Cc: Liam R. Howlett <liam@infradead.org>
Cc: Matthew Wilcox (Oracle) <willy@infradead.org>
Cc: Vlastimil Babka <vbabka@kernel.org>
Cc: <stable@vger.kernel.org>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>

diff --git a/include/linux/fs.h b/include/linux/fs.h
index d10897b3a1e3..50ce731a2b78 100644
--- a/include/linux/fs.h
+++ b/include/linux/fs.h
@@ -2444,6 +2444,11 @@ static inline struct mnt_idmap *file_mnt_idmap(const struct file *file)
 	return mnt_idmap(file->f_path.mnt);
 }
 
+static inline bool file_owner_or_capable(const struct file *file)
+{
+	return inode_owner_or_capable(file_mnt_idmap(file), file_inode(file));
+}
+
 /**
  * is_idmapped_mnt - check whether a mount is mapped
  * @mnt: the mount to check
diff --git a/mm/filemap.c b/mm/filemap.c
index 5af62e6abca5..58eb9d240643 100644
--- a/mm/filemap.c
+++ b/mm/filemap.c
@@ -4704,7 +4704,7 @@ static inline bool can_do_cachestat(struct file *f)
 {
 	if (f->f_mode & FMODE_WRITE)
 		return true;
-	if (inode_owner_or_capable(file_mnt_idmap(f), file_inode(f)))
+	if (file_owner_or_capable(f))
 		return true;
 	return file_permission(f, MAY_WRITE) == 0;
 }
diff --git a/mm/madvise.c b/mm/madvise.c
index cd9bb077072c..77552b03d318 100644
--- a/mm/madvise.c
+++ b/mm/madvise.c
@@ -336,8 +336,7 @@ static inline bool can_do_file_pageout(struct vm_area_struct *vma)
 	 * otherwise we'd be including shared non-exclusive mappings, which
 	 * opens a side channel.
 	 */
-	return inode_owner_or_capable(&nop_mnt_idmap,
-				      file_inode(vma->vm_file)) ||
+	return file_owner_or_capable(vma->vm_file) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 
diff --git a/mm/mincore.c b/mm/mincore.c
index 296f2e3922b5..c8757c5085bf 100644
--- a/mm/mincore.c
+++ b/mm/mincore.c
@@ -227,8 +227,7 @@ static inline bool can_do_mincore(struct vm_area_struct *vma)
 	 * for writing; otherwise we'd be including shared non-exclusive
 	 * mappings, which opens a side channel.
 	 */
-	return inode_owner_or_capable(&nop_mnt_idmap,
-				      file_inode(vma->vm_file)) ||
+	return file_owner_or_capable(vma->vm_file) ||
 	       file_permission(vma->vm_file, MAY_WRITE) == 0;
 }
 

