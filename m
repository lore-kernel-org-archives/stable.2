Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1843D383333
	for <stable@vger.kernel.org>; Mon, 31 Aug 2026 21:09:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788210590; cv=none; b=UmXMWqM4DrmgR+soWEvQj9HNnTX4ocNI1p4uLWKa1Czw1GCBviTuothtQmYrbUE3Kww6uIg0cIa++MDGNcWctbO+pe1U5rHbZ6guSs0uETPTmvniejBVfoTaIDJOCnar0eDNYWDP6VdGBsjTimBc5lewcM1N6rIqTwvpGPCXUHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788210590; c=relaxed/simple;
	bh=vkCqt8mSgoDljan4xP5OLRXdPZMWnCccCLHMmlYxflc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=mOxccCqIgOeQGXy8gPnCv6V9xer8wf7DrCegB12BQBvgmdzlxx4PqGVlDwWFi2OMPeD8lezHICvJAnZK4oGQA5QVtmNLBhEQ+TnY4BNXoXWq0FTepwg6/StiWXHIqRcsn9xmn4QZD4mXV9GZYpII4gLsvqvAFQvta1PxcfqF3Wk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hvUCIdJp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hvUCIdJp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75F361F000E9;
	Mon, 31 Aug 2026 21:09:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788210589;
	bh=04gSYx42Z9t1RC0wNSJeZi99m4FYQ+qlOEnUVci+N64=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hvUCIdJpamzyElIg6YLalln2yOV+4SNbNuq6ReWjBUNgrMrit5K/iWZQXWWwGV43k
	 Xqiq6SFRgopgFTjIBGN2eBUa5oalAFQtyBRLX7MCgso8neu4JgFvZObzpFerhYjS9f
	 oTJ5bSOjXIoeyPTU6jB1COnqn+iB/r5JQUIQC2kp4/ieVzMlHbp2OE0kkdbBVc/f4L
	 +bI5r3Crjg7P/Lc85PchBCyHbYRcfZPyS2u5gkoD1SBqXUmQ70+/EfwZTIWID26KJ+
	 DXpSl7SwoiEn03m/n1BWbP5GD3yhMB9LtesKKYPPLd+AoulL853jUcv9Ru0YIYL+Yo
	 w0h8iodQu5pZQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Baokun Li <libaokun@linux.alibaba.com>,
	Miklos Szeredi <mszeredi@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] fuse: fix invalidate lock leak on setattr writeback failure
Date: Mon, 31 Aug 2026 17:09:46 -0400
Message-ID: <20260831210946.1798411-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026083119-surname-nimble-f2a7@gregkh>
References: <2026083119-surname-nimble-f2a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Baokun Li <libaokun@linux.alibaba.com>

[ Upstream commit 9afeca0d569c9fc89d758fe7a9339d1e8afb1546 ]

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
[ replaced up_write(&fi->i_mmap_sem) locking and (inode, 0, 0) call site instead of the mainline filemap_invalidate_lock/(inode, 0, -1) forms ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/fuse/dir.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/fs/fuse/dir.c b/fs/fuse/dir.c
index 4488a53a192dc..d475d19193848 100644
--- a/fs/fuse/dir.c
+++ b/fs/fuse/dir.c
@@ -1651,10 +1651,8 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 		down_write(&fi->i_mmap_sem);
 		fault_blocked = true;
 		err = fuse_dax_break_layouts(inode, 0, 0);
-		if (err) {
-			up_write(&fi->i_mmap_sem);
-			return err;
-		}
+		if (err)
+			goto unlock;
 	}
 
 	if (attr->ia_valid & ATTR_OPEN) {
@@ -1681,7 +1679,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 			 ATTR_TIMES_SET)) {
 		err = write_inode_now(inode, true);
 		if (err)
-			return err;
+			goto unlock;
 
 		fuse_set_nowrite(inode);
 		fuse_release_nowrite(inode);
@@ -1768,6 +1766,7 @@ int fuse_do_setattr(struct dentry *dentry, struct iattr *attr,
 
 	clear_bit(FUSE_I_SIZE_UNSTABLE, &fi->state);
 
+unlock:
 	if (fault_blocked)
 		up_write(&fi->i_mmap_sem);
 	return err;
-- 
2.53.0

