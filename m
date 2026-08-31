Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F17561C5D72
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 12:23:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788179004; cv=none; b=DqrjxwKS5QtgZZ/EBvxOMp7gFe/Moxjud8jycsgi7zRdtsz0snM29aQdSkPbjyMXyvKw4VVEE26M9Lt3czCs7l6ntETvKV/AqLoahVGLyiaU0cCI2HbXToDb2WnJ8JXDCn+t5SP+JUAEW+UsimCe7jNap0a+bMhoNSjyNrGvz4U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788179004; c=relaxed/simple;
	bh=ecor0o1ulVKwPXrDSTFt2xWxWTEdNVVjTU5xbNzTQAY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Mww+fJO1vdLCZBacYyKAPdib1jU6YlbyKojDV06HQOCXv10JGlrYF9jjNxILbXH80ywbjL6vo+197MWClgnDH3OLvCM8NGPv0Q5XJffxNoZBI7EAgHIm27Oko4J9hht/qCXErMCCzn2pLUeOkdZ4KQys+0n88Y51Alzl3YW8PVE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=pNgqSUk9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="pNgqSUk9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3B0A81F000E9;
	Mon, 31 Aug 2026 12:23:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788179002;
	bh=Yoe0sMfFgCs7eZF1T+TSh8XiRflRM58b+ApB+YPK3l4=;
	h=Subject:To:Cc:From:Date;
	b=pNgqSUk9beSOOiyo56kPURRud/EKxntqa09WpVKUSU4lg/6U3SJh268xhEkyVBQdO
	 WAtgpT1U9bP+yT9fK3bCu83qH5Hy7upYkLzuna1snxdafiM9UxwNwYbhefI1PSvBTr
	 gEZANnb2V+8/gr0LfFmEpWbm2vKOcyRhCDqDpD4w=
Subject: FAILED: patch "[PATCH] fuse: fix invalidate lock leak on setattr writeback failure" failed to apply to 5.10-stable tree
To: libaokun@linux.alibaba.com,mszeredi@redhat.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 31 Aug 2026 14:23:19 +0200
Message-ID: <2026083119-surname-nimble-f2a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 9afeca0d569c9fc89d758fe7a9339d1e8afb1546
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026083119-surname-nimble-f2a7@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 9afeca0d569c9fc89d758fe7a9339d1e8afb1546 Mon Sep 17 00:00:00 2001
From: Baokun Li <libaokun@linux.alibaba.com>
Date: Mon, 17 Aug 2026 23:18:00 +0800
Subject: [PATCH] fuse: fix invalidate lock leak on setattr writeback failure
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

fuse_do_setattr() takes filemap_invalidate_lock() for a DAX truncate
(fault_blocked = true) and releases it at the out:/error: labels.  But
when a writeback flush is also needed, a write_inode_now() failure
returns directly and leaks the lock, so any later fault or truncate on
the file stalls on the stale rwsem.

For example, truncate(2) on a setuid file reaches fuse_do_setattr()
with both ATTR_SIZE and ATTR_MODE set:

  truncate(2)
  └─ do_truncate()
     ├─ dentry_needs_remove_privs()         # S_ISUID
     └─ notify_change()                     # KILL_SUID -> ATTR_MODE
        └─ fuse_setattr()                   # no killpriv:
           │                                #   ia_valid |= ATTR_MODE
           └─ fuse_do_setattr()
              ├─ filemap_invalidate_lock()  # IS_DAX && is_truncate
              └─ write_inode_now()          # is_wb && ATTR_MODE
                 └─ if (err)                # e.g. daemon -> -EIO
                    return err              # <- lock leaked

Fix this by adding an unlock label that releases the lock before
returning the error, and use it for the fuse_dax_break_layouts()
failure path as well.

Fixes: 6ae330cad6ef ("virtiofs: serialize truncate/punch_hole and dax fault path")
Cc: stable@vger.kernel.org # v5.10+
Signed-off-by: Baokun Li <libaokun@linux.alibaba.com>
Signed-off-by: Miklos Szeredi <mszeredi@redhat.com>

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index d73e2bf65634..172261bad71e 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -2170,10 +2170,8 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 		filemap_invalidate_lock(mapping);
 		fault_blocked = true;
 		err = fuse_dax_break_layouts(inode, 0, -1);
-		if (err) {
-			filemap_invalidate_unlock(mapping);
-			return err;
-		}
+		if (err)
+			goto unlock;
 	}
 
 	if (attr->ia_valid & ATTR_OPEN) {
@@ -2200,7 +2198,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 			 ATTR_TIMES_SET)) {
 		err = write_inode_now(inode, true);
 		if (err)
-			return err;
+			goto unlock;
 
 		fuse_set_nowrite(inode);
 		fuse_release_nowrite(inode);
@@ -2308,6 +2306,7 @@ int fuse_do_setattr(struct mnt_idmap *idmap, struct dentry *dentry,
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 
+unlock:
 	if (fault_blocked)
 		filemap_invalidate_unlock(mapping);
 	return err;

