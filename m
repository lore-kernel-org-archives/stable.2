Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793363928;
	b=X1igFZWEkClpQ46XXOpNsilPkybQUXulL/P3X4dCPchjqcY1bwnrf0CQuObHfACrfItk
	 08G9iIvsEbFViAQk5lqVanAc7ijpqXpBGdMpRqRYToOe0RV88oI3xx12Mcjvsry7RqivH
	 44YhWMODfD+PMb2hYNMBp2u+6p5yphOx2tAvdwnl1iidv0/7pjWL+hzwwqvoT+i9kOvZx
	 TYnC+nIVam9F+vr8zgMXZlMPykipjWsraIbj9UhT7d1xxHH41TGDkwnqQOufS8VQUY4Je
	 g63mbjrIdHPJa8AzE9S4rFnQZSbIfknWqjpPlXL/rMCwsNmZ++aOWbVdT+5zcb0M5qw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793363928;
	h=Received:DKIM-Signature:From:Date:Subject:MIME-Version:Content-Type:
	 Content-Transfer-Encoding:Message-Id:References:In-Reply-To:To:Cc:
	 X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ziOfu0jPUaZe3izXGQ3C/gcI8fjlmmUUDSSBtGTjLaU=;
	b=zJIxj/KYQz82/Q1ag9wvLjPUmKP0brthl5ZobHOp0OhdTUB9q68G9bc14XGUgmzq4EuT
	 HDK4Vy446MXvEIC627h9f/TRz6GlqiKxpXFapIbwm6/pyrKSSf3udpyhkVgSaOnYDisJ6
	 9MHau7YN65lWAFmKSrv/yIKB51n/2YCbdh3RHAeo/nq11wkN16NUbpNMUfHuO7DttSvR8
	 0V3kRFk6EtrANAeFucVQl9BPlXWEtFmIjeBcOLYe0EsuyhClP58YOWNaoHmEBnwx2yx6z
	 Id8YaNcvohM20peQXNKxV+++NYXGG+t6MtPJ652fgGA0P1Aw2rNLwKI4nmCJM6mmyBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Vkg6mU/s";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71C82606A322;
	Fri, 30 Oct 2026 12:38:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vkg6mU/s
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0D2EE1F000C1;
	Fri, 30 Oct 2026 12:38:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793363927;
	bh=ziOfu0jPUaZe3izXGQ3C/gcI8fjlmmUUDSSBtGTjLaU=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc;
	b=Vkg6mU/sQduW1pOzDPWBIxAZuuXKm8Ocu4QNqoNruX6lmN6XhzjmLaoKmSpMz/BbM
	 5VUpcZG/a2F6r4fF0d6qOL81515OP74UsqPC1dGJ9KSt+29+Vs6QilaELofkBZ+KIF
	 5XE/GBdoDdZPVjlTlNl23T2kxZV9VCpiKzP82T2Zt+k1h6z8jsRGCRTbboZbydbhfA
	 7UfuYXbai5SwwbvXV20NM2NQww1SO1rWmel3BzaBiZ+ozxaNYwmDs/B4MoG1l0sUJL
	 hBMga8dls553lq0cZS3RkCLRG3kQ3eTmInD++vDzZ/osR3x8UpWGi2tHGNnTBQdbEx
	 4A63tc7mSN6og==
From: Christian Brauner <brauner@kernel.org>
Date: Fri, 30 Oct 2026 13:38:23 +0100
Subject: [PATCH 2/3] dcache: wait for a racing eviction of a secondary root
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261030-work-dcache-ai-v1-2-cd6b86e0ccc7@kernel.org>
References: <20261030-work-dcache-ai-v1-0-cd6b86e0ccc7@kernel.org>
In-Reply-To: <20261030-work-dcache-ai-v1-0-cd6b86e0ccc7@kernel.org>
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Karl Mehltretter <kmehltretter@gmail.com>, 
 Chris Mason <mason@kernel.org>, Josef Bacik <josef@toxicpanda.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2975; i=brauner@kernel.org;
 h=from:subject:message-id; bh=dnyoa6CFYP5zOXTYJQjMp7VrCxTByWk2uIxJCf0Q1fI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ96T93oacxtzQ4c1crG5Oz39T73XtC18Z/Z5O6wnV+2
 vzW/96JHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABNJr2T4n1LRtGNt6NFLX79o
 +W/9JjAlOyNW7eh+Hn2nmvQ9AffCTjMyHE7s+3b4XPbhJiu2q6/rIlg231mwSfYZx59XckfmpL3
 uZQEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

From: Josef Bacik <josef@toxicpanda.com>

Commit e9895609cb7f ("wind ->s_roots via ->d_sib instead of ->d_hash")
keeps a secondary root on ->s_roots until dentry_unlist() so that
shrink_dcache_for_umount() can find one that another thread is evicting
and wait for it. But do_one_tree() takes every root off the list before
its dput() which breaks that:

  thread A                              umount
  dentry_kill(root), refcount is 0
    lock_for_kill()
      spin_trylock(->i_lock) fails
      spin_unlock(->d_lock)
                                        shrink_dcache_for_umount()
                                          dget_dlock(root)
                                          do_one_tree(root)
                                            unlink_secondary_root(root)
      spin_lock(->i_lock)
                                            dput(root), refcount is 0
                                              lock_for_kill()
                                                trylock fails, waits
      spin_lock(->d_lock)
      refcount is 0 again, go on
    lockref_mark_dead()
    dentry_unlink_inode()
      drops both locks
                                                root is dead, give up
                                          ->s_roots is empty, done
                                        evict_inodes()
                                        "Busy inodes after unmount"
      iput()

Thread A evicts without pinning the superblock. namespace_unlock() does
that for old mountpoints after dropping namespace_sem, and a secondary
root goes with its last child.

So only take busy roots off the list. Leave the others to
dentry_unlist() so that shrink_dcache_for_umount() finds them and waits
for an eviction in progress. A root that becomes busy after the check is
picked up again and taken off the list then.

Fixes: 78db93943210 ("dcache: keep shrink_dcache_for_umount() making progress on busy roots")
Cc: stable@vger.kernel.org # v7.2+
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
 fs/dcache.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/fs/dcache.c b/fs/dcache.c
index 72b8e0adab0d..c1d8b398b2d1 100644
--- a/fs/dcache.c
+++ b/fs/dcache.c
@@ -1817,8 +1817,13 @@ static void do_one_tree(struct dentry *dentry)
 	d_walk(dentry, dentry, umount_check);
 	spin_lock(&dentry->d_lock);
 	__d_drop(dentry);
-	/* A busy root survives the dput() below so don't leave it on ->s_roots. */
-	if (unlikely(!hlist_unhashed(&dentry->d_sib)))
+	/*
+	 * A busy root survives the dput() below so don't leave it on ->s_roots.
+	 * An idle one stays until dentry_unlist() so that umount can wait for
+	 * a racing eviction, see lock_for_kill().
+	 */
+	if (unlikely(dentry->d_lockref.count > 1 &&
+		     !hlist_unhashed(&dentry->d_sib)))
 		unlink_secondary_root(dentry);
 	spin_unlock(&dentry->d_lock);
 	dput(dentry);

-- 
2.53.0

