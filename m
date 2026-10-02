Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A7963C9898;
	Fri,  2 Oct 2026 13:53:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790949217; cv=none; b=W0iCh7RJhSrXr5gDqFBpv8sUDy55716IXZhjJwEfMcRKtrAj8IOicOoTVCtSBLn/lGyWvBKROipw/JJgJ2FhgvNFTkr3in5nsKMZB6vLd7Lmm1yWfoCqEVCgMmDBc2QXvdJT5RK2IKw74wC8YnQda0LpR9v6JFWcqfzhlhCBq9A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790949217; c=relaxed/simple;
	bh=Ib2Exxpb6GDQ+ica47E+ivBnH1RE36bOqhtyFLu7+Ck=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=jiQz57X1FPq3rVLDdBzXlaoP6yVlOmiLShE1Ey+8kMFlophz21X9eAR8vE9Iid1+ChK8+9+488Yw8VkrWFMNoHC+wD0g3aOZULk10IipSco3h+biyVVvspM7vpOJtKJkK9qKgyETC5+Ran50a0bYU+dJ//CjJQj/npGcEJ2Iik0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=c9dixHpt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="c9dixHpt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B0FF1F000FF;
	Fri,  2 Oct 2026 13:53:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790949215;
	bh=6QedBmex4n5aliVhPrDMZaYmH+5Us9ELZ/NjmQMJ20c=;
	h=From:Subject:Date:To:Cc;
	b=c9dixHpt1bmNJCW8NRCuKyXlZHerIX2bHFt7Fs9jGINJxpYcu9xWY7AEG/MOFPB5+
	 ZoncibSl0WfJF2EzuART25YHq7MJ63rqS8JrDSlPqcS6TnqhDWwXwRG3PSeOVLBvag
	 hEJPndhXKvL4+14oV4dexFsBBygbkiH69T3kai9ML52y+CozbAnBwMJTIs8ME9dKVv
	 a5P89mTHTemiJDIMLMIjAm2TwMeGXq29fS/gc2UOSkU4gEFuapOJzPlWPR4eheKazM
	 sOxuG0Wnxg24FpvenZ72wgKfJ5bTkRb+1W2RY58H2nsGL/t2+1eQjmlJLdnn79VqI8
	 qKl3w3valJTiQ==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 00/21] mount: more bugfixes, trapped in the Black Lodge
 edition
Date: Fri, 02 Oct 2026 15:52:31 +0200
Message-Id: <20261002-work-mount-fixes-4-v1-0-dd44b89d44ce@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM2w6CMBBEf4Xss0va0ojxV4wPvSxSja3pApIQ/
 t0WH8/MnNmAKQdiuDYbZFoChxQLyFMDbjTxQRh8YVBCnaUQCr8pv/Cd5jjhEFZi1GjVxfded1I
 ogiJ+Mh1V8W73P/Nsn+Sm+lQX1jChzSa6sUbLwNi3uj1uYd9/6A+5vpYAAAA=
X-Change-ID: 20261002-work-mount-fixes-4-b28d7d43102e
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 linux-kernel@vger.kernel.org, Jeff Layton <jlayton@kernel.org>, 
 Jann Horn <jannh@google.com>, Neil Brown <neil@brown.name>, 
 Amir Goldstein <amir73il@gmail.com>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=3862; i=brauner@kernel.org;
 h=from:subject:message-id; bh=Ib2Exxpb6GDQ+ica47E+ivBnH1RE36bOqhtyFLu7+Ck=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWTt3x7BJpueWHbTwGui4gWF3cts/nf8/XRjefzqJaq6H
 FlzvyW/7ihlYRDjYpAVU2RxaDcJl1vOU7HZKFMDZg4rE8gQBi5OAZhIWQHD/7qit/3Nbn/Xq4vO
 mrzy20bbS5aPbnz4Kr6K2dHioTNjuAIjw4RWtvONS1zDbt9c8PuGv8+ucz5v2BLKLJy87m+6dsz
 UmBEA
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

More bugfixes from work in this area:

- unhash a dentry before detaching the mounts on it to avoid leaking
  sensitive data
- don't reveal overmounted entries in refwalk
- refuse F_SET_RW_HINT on an immutable inode
- refuse an automount below a mount that is in no namespace
- handle mount locking for automounts correctly
- don't update the access time on nullfs
- never expire a locked mount
- keep the lock on a mount that a propagated copy is moved beneath
- decide the subtree check under mount_lock
- keep the private nullfs instance in knullfs
- nothing is mounted on or written through knullfs
- let a filesystem refuse fsnotify marks on its objects
- refuse file locks on nullfs
- refuse leases and delegations on nullfs
- take no inode lock on an immutable directory

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (21):
      namespace: unhash a dentry before detaching the mounts on it
      namei: don't reveal overmounted entries in refwalk
      fcntl: refuse F_SET_RW_HINT on an immutable inode
      selftests/filesystems: check that an immutable inode takes no write hint
      namespace: refuse an automount below a mount that is in no namespace
      namespace: handle mount locking for automounts correctly
      nullfs: don't update the access time
      namespace: never expire a locked mount
      namespace: keep the lock on a mount that a propagated copy is moved beneath
      selftests/filesystems: check that a lock lands on the right mount and stays
      selftests/filesystems: check the atime of the empty mount namespace root
      selftests/filesystems: check that an automount below an overlay layer is refused
      fhandle: decide the subtree check under mount_lock
      namespace: keep the private nullfs instance in knullfs
      namespace: nothing is mounted on or written through knullfs
      fsnotify: let a filesystem refuse marks on its objects
      nullfs: refuse file locks
      nullfs: refuse leases and delegations
      readdir: take no inode lock on an immutable directory
      selftests/filesystems: add a helper that holds a readdir in a page fault
      selftests/filesystems: check that reading the root of an empty mount namespace stalls nobody

 fs/fcntl.c                                         |   3 +
 fs/fhandle.c                                       |  20 +-
 fs/mount.h                                         |   1 +
 fs/namei.c                                         |  29 ++
 fs/namespace.c                                     |  78 ++--
 fs/notify/mark.c                                   |   4 +
 fs/nullfs.c                                        |  43 +-
 fs/readdir.c                                       |  13 +-
 include/linux/fs.h                                 |   3 +
 tools/testing/selftests/filesystems/.gitignore     |   1 +
 tools/testing/selftests/filesystems/Makefile       |   2 +-
 .../selftests/filesystems/empty_mntns/.gitignore   |   2 +
 .../selftests/filesystems/empty_mntns/Makefile     |   5 +-
 .../filesystems/empty_mntns/nullfs_atime_test.c    | 129 ++++++
 .../filesystems/empty_mntns/root_readdir_test.c    |  45 +++
 .../selftests/filesystems/overlayfs/.gitignore     |   1 +
 .../selftests/filesystems/overlayfs/Makefile       |   1 +
 .../filesystems/overlayfs/automount_in_layer.c     | 174 +++++++++
 tools/testing/selftests/filesystems/readdir_hold.h | 224 +++++++++++
 tools/testing/selftests/filesystems/rw_hint_test.c | 129 ++++++
 .../filesystems/umount_propagation/Makefile        |   2 +-
 .../umount_propagation/locked_mount_test.c         | 432 +++++++++++++++++++++
 22 files changed, 1305 insertions(+), 36 deletions(-)
---
base-commit: cbade031e2ebb3ca0a423b1804ce87908b27c229
change-id: 20261002-work-mount-fixes-4-b28d7d43102e

