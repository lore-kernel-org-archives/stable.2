Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFEB13D1A81
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 13:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790688690; cv=none; b=qQTM3oxj4xF4arxki1tQcLb8268uDTaNMCMC5ai3PanukCpJ2EQxXmAl+uqR2ByALYjhFBKuJhJEKkLPkdHp+Ric2a/MMYkiQEhFGXccR9/h4BjoHquK1CzkLHxe/vaMkE2Q1GbyaPMbyTWQ/7SR8g1hMA+vMa2WVxqObtXoHHw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790688690; c=relaxed/simple;
	bh=V81gmM8uvUMNBKXcoMJ9bpYRTA+bqVIW+2XZBDyj73U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pdB7TiaclJQz7RKP+GYzp3pE58Ug2J7ERTlGX7RosD6u//ISdOiv1f9LXtmgTSfHkeKB3pJSSxSuum4BCxSmLWgDqjXYDBUvm3gn3/TVmCTedL4X61O44WcQxp2rc4S2x152JRgbxfR2B+OF8HIo4R+V1DHXRXs4ghCTN3j5Two=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Aytt4wO2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Aytt4wO2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D488F1F00899;
	Tue, 29 Sep 2026 13:31:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790688687;
	bh=xFY3jdmhk/qhtV7RY1kthI/tlt3TH7i4ysbZjhpUaLg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Aytt4wO2cRzD1/nu745z60nkPEAcygtZ6JLEqKi1K//+ohT0bN+Z824tO7HciUv6s
	 YccYoGAbBx/m2WRkT0gXMUZC4zUgWeDi5LAmm4Nf2IAQPxukRirOx37UeBywnMlBjv
	 CkxIDq+k3QLvKQswVJZfpCLcPqaZPfmtFQ29aEdYaR4vaJyVe3eZOnQX7Nusv8b5x2
	 Z3dmhQY4pJ+JFCBVF9fTyGZAoaEbdVjIsnXowXrK882TCyOEZHXZ4/x7UA1G0h84gx
	 gOtlS7p89EfLR6fG7TbIl6wnfnPlRrYiEWCqvVeUmuPrJEGjthhtuhY1K446AyCrB1
	 K78a2Z+eFm6zQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Christian Brauner <brauner@kernel.org>,
	Jan Kara <jack@suse.cz>,
	syzbot+2a13ad6914e6fcec716c@syzkaller.appspotmail.com,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 3/3] fs/ntfs3: use d_instantiate_new() in ntfs_create_inode() and murder syzbot's "WARNING in do_new_mount" saga
Date: Tue, 29 Sep 2026 09:31:24 -0400
Message-ID: <20260929133124.3504204-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260929133124.3504204-1-sashal@kernel.org>
References: <2026092904-porthole-attire-bdfd@gregkh>
 <20260929133124.3504204-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Christian Brauner <brauner@kernel.org>

[ Upstream commit 1abd643f3783ea8f8e273c18697ff0413aa92dc7 ]

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

Link: https://patch.msgid.link/20260909-work-ntfs3-d_instantiate_new-v1-1-2db697162ce8@kernel.org
Fixes: 82cae269cfa9 ("fs/ntfs3: Add initialization of super block")
Reviewed-by: Jan Kara <jack@suse.cz>
Cc: stable@vger.kernel.org # v5.15+
Reported-by: syzbot+2a13ad6914e6fcec716c@syzkaller.appspotmail.com
Closes: https://lore.kernel.org/6a9beced.a5e650b3.26d8a.000b.GAE@google.com
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ntfs3/inode.c | 7 ++-----
 1 file changed, 2 insertions(+), 5 deletions(-)

diff --git a/fs/ntfs3/inode.c b/fs/ntfs3/inode.c
index e4cf4e647d037..aa27ca70ee5b2 100644
--- a/fs/ntfs3/inode.c
+++ b/fs/ntfs3/inode.c
@@ -1700,10 +1700,10 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
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
@@ -1751,9 +1751,6 @@ int ntfs_create_inode(struct mnt_idmap *idmap, struct inode *dir,
 	if (!fnd)
 		ni_unlock(dir_ni);
 
-	if (!err)
-		unlock_new_inode(inode);
-
 	return err;
 }
 
-- 
2.53.0

