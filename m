Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 314F14854F6;
	Wed,  9 Sep 2026 09:03:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788944614; cv=none; b=XnE8I1mmUYGGBnvlcvM4Dcb4SDHg8FwBipRmbtbq/QWepnjiitGk0Yfc9rXy8rBjOEz0ik0sh7htyaYTuv3TLBopiQTiMYmq55SAy0I7q5tgNKE30eXeFl9s0nF3sfOephUlJEu42er3hXWQUpft5XbMh9sndfeT9zc1/X38z08=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788944614; c=relaxed/simple;
	bh=dAW4XFaHnXuRRusbMK+XhLRVSHDX62pvCW3fTPDkR5k=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=dnHNHfhhQf9yahdacaNuHP12VPumampaz04rWx7qifJ/vI9Jr6+8OuPj4xKpPLSLkZQofcVCd1KupG30MfcAZu4g/tm0dLLDnwdkQ3+5Z/vdHSyBW5a7HfrxyU0lc/vjh1HugxCz67DeKTZ/kNKeVTlIFqYzEo53hqvh4z3AQmc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=HaDw5ez+; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="HaDw5ez+"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C95341F00A3A;
	Wed,  9 Sep 2026 09:03:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788944612;
	bh=ad/uP/9BUaKeqL2yxjxogEEVcG1H43vsLZmR0rGjAt0=;
	h=From:Date:Subject:To:Cc;
	b=HaDw5ez+b3XDVV1tsv1rTrXGgu6ItNNHZ8tcUgGcAwWdpRhMeb4e3XmIUx5LK56bR
	 jOhxSv+JWhRrp9IvCp4urd7bzztMmsnoY1gL1kKanHFAFxIhgMH/JUIda1MxwYq6qd
	 aL703p8YlTOtOq2yNIrxGxyBP5xJi9b73ySNRvelwqfNG2GRHAL7MQ+9u717rNSYpV
	 6JhHZSarC7WTW99XV6CGeu+XnkwT/BVqVe8kpjQBE4o2iNUDpLTrQ2Gh7uXluXPLyG
	 9xLVFLSoaVtukFd29sQjsFgh9AE3T+rbmQPWCwBdsguRw5k+GxJgDbL5s8Ucz3507+
	 OP7CWwQulK8kg==
From: Christian Brauner <brauner@kernel.org>
Date: Wed, 09 Sep 2026 11:03:18 +0200
Subject: [PATCH] fs/ntfs3: use d_instantiate_new() in ntfs_create_inode()
 and murder syzbot's "WARNING in do_new_mount" saga
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260909-work-ntfs3-d_instantiate_new-v1-1-2db697162ce8@kernel.org>
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/2XM0QqCQBCF4VeRuW5F1wjtVSJk3B1zCsbY2TIQ3
 71du+zyPxy+FZQCk8K5WCHQm5VnSVEfCnATyo0M+9RgK3uquqozyxweRuKojfE9i0aUyBipF1p
 MWx/RN7UnbC0k4hlo5M/OX66/1tdwJxezmR8DKpkhoLgpT1kvd73808v8hW37AiUt2920AAAA
X-Change-ID: 20260909-work-ntfs3-d_instantiate_new-814ad31dea82
To: Konstantin Komarov <almaz.alexandrovich@paragon-software.com>, 
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>, 
 Clark Williams <clrkwllms@kernel.org>, linux-fsdevel@vger.kernel.org
Cc: Steven Rostedt <rostedt@goodmis.org>, jack@suse.cz, 
 syzkaller-bugs@googlegroups.com, viro@zeniv.linux.org.uk, 
 ntfs3@lists.linux.dev, linux-kernel@vger.kernel.org, 
 linux-rt-devel@lists.linux.dev, stable@vger.kernel.org, 
 syzbot+2a13ad6914e6fcec716c@syzkaller.appspotmail.com, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=4049; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dAW4XFaHnXuRRusbMK+XhLRVSHDX62pvCW3fTPDkR5k=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQtVLj/9sFvEWUe4bbrxud3z5gYcdVcXign9IOE/pfOQ
 l25evZ1HaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABMJOsHwh9+b+cCqz9xKuzVv
 qPk66T2+kX/bVFqmz3GfiJF8fFauFcP/qM1fX/P+80gvnrja76j4olk7dqamLzEV+NFkINWZo+r
 MBwA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

ntfs_create_inode() creates a new inode via ntfs_new_inode(). It hashes
it with insert_inode_locked() and so it's marked as I_NEW until
unlock_new_inode().

ntfs 3 calls d_instantiate() in between though... Since the dentry was
already hashed by the lookup before the create any path walk finds it
without touching the parent's i_rwsem and so can lock the inode.

If the inode is a directory unlock_new_inode() calls
lockdep_annotate_inode_mutex_key() and marks i_rwsem with the
i_mutex_dir_key class.

That resets the count and the owner of a lock somebody else may already
hold by now...

syzbot has been spamming us with the same godforsaken bug

  "WARNING in do_new_mount"

since 2023. I can't take it anymore so I went looking. Afaict, syzbot's
executor chdirs into a freshly mounted ntfs3 image, creates a
directory and then mounts some pseudofs on it. Everytime the mkdir()
takes longer than syzbot waits mount() runs concurrently:

  mkdir("./sys")                        mount(NULL, "./sys", "sysfs")
  ntfs_create_inode()
    d_instantiate()
                                        user_path_at() finds the dentry
                                        do_lock_mount()
                                          inode_lock(inode)
                                          namespace_lock()
    unlock_new_inode()
      lockdep_annotate_inode_mutex_key()
        init_rwsem(&inode->i_rwsem)
                                        unlock_mount()
                                          inode_unlock(inode)

The mount side then releases a lock that according to the rwsem nobody
holds:

  DEBUG_RWSEMS_WARN_ON((rwsem_owner(sem) != current) && ...):
  count = 0x0, magic = 0xffff888043a854e8, owner = 0x0,
  curr 0xffff888000244880, list empty
  WARNING: CPU: 0 PID: 5346 at kernel/locking/rwsem.c:1368 __up_write
  Call Trace:
   inode_unlock include/linux/fs.h:877 [inline]
   unlock_mount fs/namespace.c:2892 [inline]
   do_new_mount_fc fs/namespace.c:3828 [inline]
   do_new_mount+0x777/0xa40 fs/namespace.c:3887

On PREEMPT_RT the same thing shows up as

  DEBUG_LOCKS_WARN_ON(rt_mutex_owner(lock) != current)
  WARNING: kernel/locking/rtmutex_common.h:193 at rt_mutex_slowunlock

The up_write() underflows the reset count. A following inode_lock() on
that directory then never returns. A path walk into the new directory
racing with the mkdir() corrupts the lock the same way via
inode_lock_shared() in lookup_slow().

Switch to d_instantiate_new() and drop the trailing unlock_new_inode().
All error paths bail out before that point with I_NEW still set and
keep using discard_new_inode().

May we never see this fscking bug report again.

Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Cc: stable@vger.kernel.org # v5.15+
Reported-by: syzbot+2a13ad6914e6fcec716c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/6a9beced.a5e650b3.26d8a.000b.GAE@google.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/ntfs3/inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index 56b4f6469a28..4ac26c80bd34 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1866,10 +1866,10 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 		goto out6;
 
 	/*
-	 * Call 'd_instantiate' after inode->i_op is set
+	 * Call 'd_instantiate_new' after inode->i_op is set
 	 * but before finish_open.
 	 */
-	d_instantiate(dentry, inode);
+	d_instantiate_new(dentry, inode);
 
 	/* Set original time. inode times (i_ctime) may be changed in ntfs_init_acl. */
 	inode_set_atime_to_ts(inode, ni->i_crtime);
@@ -1917,9 +1917,6 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	if (!fnd)
 		ni_unlock(dir_ni);
 
-	if (!err)
-		unlock_new_inode(inode);
-
 	return err;
 }
 

---
base-commit: 893e11787f78e43b534e252249ac3fff4d1333f8
change-id: 20260909-work-ntfs3-d_instantiate_new-814ad31dea82

