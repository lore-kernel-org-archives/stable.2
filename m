Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793197865;
	b=yHp3Fcw8i1ipAW1GW7fjyG+STH1gbnKf9CgGb7cudGUbO4doPS7dQcke2i/ZgQ+K+3ly
	 1dwcYTt/t64iVES4qQNHRc1OiR5E3Idul+4PUl3cFWDC2QIAP1hWy6pmlHmRfhHSMqvcb
	 ZtAdCOHXNRGSWCltMBcBlr4aLW+9x56u7ztm4PqtLxKF2UbOH1Q+Vao5lTCMNJccDDVzc
	 0LBJzUkXpEH/lx+eFl7lFXXqiUr4Wi0q/LohkR1ALjQ/b2JOW9qS52fqmekaQkmcEpm6y
	 TH4j9CKBX5/wCBiyeYSeKzEbgzO+VPsMwAGv6HsaCwV4V887JnE2+fkipQvDhWcBIrw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793197865;
	h=Received:DKIM-Signature:From:Subject:Date:Message-Id:MIME-Version:
	 Content-Type:Content-Transfer-Encoding:X-B4-Tracking:X-Change-ID:To:
	 Cc:X-Mailer:X-Developer-Signature:X-Developer-Key;
	bh=ESMBCrK+R+S7NiTpN1OIZeRqPKju7V65s3ZpCgR6s24=;
	b=ImbgxcFGKmrn9Yi8xiAPV4h2msAywRXzKnTLg4pMWEtvbHh8HDez4AgX7xQVgijoDfJG
	 +14HCfg+8tIlp/dICEQQ0RmJnnDXvSuEBw/IUe1XXVNSdLwFJZj0RTN7+fRjvCZSiurtO
	 ZI5VYXT3DbgDRiHWYFRY60vlRJxs6Z42e25V09C0ioeXxjjU6EQzOGMFHlYko/JvjqGda
	 rINqvd6wkL3RNfM4PoaIjlqyrut0HwQZo1D4dxXBbMPMKaUKReEkTWkiu+tBA1XmQbhx4
	 8dMUZjJ2CPZuZtf93YLTMExJJuLJcDHbREp1Cijo+ijx/ttVbxHJDiM3xyxh3JFF+2g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MJQrC/5c";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B370E606A31C;
	Wed, 28 Oct 2026 14:31:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MJQrC/5c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB5B91F01825;
	Wed, 28 Oct 2026 14:31:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793197864;
	bh=ESMBCrK+R+S7NiTpN1OIZeRqPKju7V65s3ZpCgR6s24=;
	h=From:Subject:Date:To:Cc;
	b=MJQrC/5cCA1v8JpBCSIArdzVEh0x1p1dbEQYCkJKUP/cnv25NObhnYz1KGSC8AOmN
	 TTwOewTJZwio56M3ZVFWJJBbxl9dY/5ysIlo59L42G5B6Zwe5Pn8fPPKk45NSWv1uY
	 fjjpj66wAcWwZzIiuu6JUeBs30TkrvW0BeGtXUGe0JQFh2w6owiMZD2/l5GeWcCw/m
	 c6OO7M7uwxf5PjNlXa5JjYrnyTFBWE8tZUGzzkimHdzTFtnBOHDPRHeYHHAuQBWwUj
	 i0zfPfMLKyRGDae92o36Z6K0YP2Bk8gqKiZIeZxftMWAkJKwM0ocXPseDE1Z8rhhC1
	 EH6ho0WBkGaYw==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/4] mount: don't reveal overmounted dentries that lost
 their mounts
Date: Wed, 28 Oct 2026 15:30:36 +0100
Message-Id: <20261028-work-mount-trap-b4-v1-0-f20d9d0730d6@kernel.org>
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
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWMQQ6CMBBFr0Jm7RioWtSrGBdtGaQaWzJT0IRwd
 1tZvp//3gJC7EngWi3ANHvxMWRodhW4wYQHoe8yg6qVbmrV4ifyC99xCgkTmxHtEXV7UJeOzk6
 dNGRxZOr99x+93TeWyT7JpVIqD2uE0LIJbijT3Mt+M9b1B5mn0SWSAAAA
X-Change-ID: 20261027-work-mount-trap-b4-67329de8c256
To: linux-fsdevel@vger.kernel.org
Cc: Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 Miklos Szeredi <miklos@szeredi.hu>, NeilBrown <neil@brown.name>, 
 Chris Mason <mason@kernel.org>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-ce4c1
X-Developer-Signature: v=1; a=openpgp-sha256; l=6165; i=brauner@kernel.org;
 h=from:subject:message-id; bh=1GgfrL8blBX3DAPyjTedoyF9pOu0UGPTD9X0JfskRxI=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWQ9Yle56NjzcHq34g2hOr3FlZfm5y27kNumoPV/+w3Gr
 z11DD9PdpSyMIhxMciKKbI4tJuEyy3nqdhslKkBM4eVCWQIAxenAExEVJbhf71g/cmfQQ4PF/Ob
 nr2pY7R8q5qTuVbJHw3RLwv86949mcDI8NxuTaDDvtlall5VgQvVVkr/sJJsU45actzu/eSdIeL
 iLAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

In case you are hoping this is going to be the last patch on this
subject rest assured it won't be.

A name that is a mountpoint in one mount namespace can be removed in
another. unlink(), rmdir() and rename() refuse only a mountpoint in the
caller's own namespace. Since 8ed936b5671b mounts in other mount
namespaces are unmounted lazily.

This allows a host to rm -rf a tree a container has masked bits of with
mounts. This is a "security mechanism"... The premise is that nobody can
reach the name once it is gone.

But alas, a lookup that found the name before it was removed can and can
get access to the covered entry because the mounts are gone.

Here's an example:

  The host has /srv/app with the file secret in it. A container gets
  /srv/app bind-mounted and the runtime hides "secret" from it by
  binding /dev/null on top. The container's mount namespace is owned by
  its user namespace. So the mount is MNT_LOCKED and the container can't
  unmount it:

    host                             container
    ----                             ---------
                                     open("/srv/app/secret") finds the
                                     dentry and goes to sleep in
                                     ->d_revalidate()
    rm /srv/app/secret
      nothing is mounted on it
      here, so the kernel unmounts
      the mask in the container
                                     takes the mount step: nothing is
                                     mounted on the dentry anymore and
                                     the open lands on secret itself

  On a local filesystem that window is a few instructions. A FUSE
  server in the container's path makes it as wide as the server likes it
  to be. The reproducer I have does exactly that.

An earlier attempt I had tried to fix this in refwalk but it was really
brittle. So let's fix this crap in the mount resolution that every
lookup does. We can reuse two existing dentry bits for this.

The remover marks the removed name with DCACHE_CANT_MOUNT before it
detaches anything. Instead of clearing it, the mount detach keeps
DCACHE_MOUNTED on such a dentry. A lookup that found the name keeps
talking the mount step this way.

The lockless walk doesn't need any changes. The unhash invalidates d_seq
and a lockless walk never legitimizes a dentry whose d_seq changed.

That's half the story. The other part of this insane mechanism is that
we can't actually detach all mounts. Take the same container but now the
runtime binds "secret" somewhere first and masks the bind:

    mount --bind /srv/app/secret /run/secret    (P, a bind of the file)
    mount --bind /dev/null /run/secret          (K, the mask on its root)

  P's root and K's mountpoint are both the dentry of secret. Before
  this series the removal of /srv/app/secret took every mount on that
  dentry away including K.

  P stayed, since it is mounted on /run/secret and not on the removed
  name. So /run/secret showed the deleted secret where the mask had
  been. IOW, the removal uncovered it.

The thing is that K isn't reached through the name the host removed. It
is reached by crossing onto P. So K has to stay and so does a cover that
a lazily unmounted bind of the object left on its root for a locked
child.

I've been struggling with this but it is safe from all I can see.
detach_mounts() exists for two reasons:

(1) the removal must not fail with EBUSY because of somebody else's
    mount as this amounts to a DOS.
(2) the mounts must not leak since nobody can reach them once the name
    is gone and they'd dangle until the namespace dies

This change keeps (1) and (2) in tact. K isn't reachable anymore through
the removed name. It is reached through P as before and P was never
reachable through that name either. A bind-mount of an entry keeps
working even after the entry is deleted - like a fd does.

It's root show up as //deleted in mountinfo as it always has. K lives
exactly as long as P.

umount of /run/secret takes K first and P second like any stack. umount
-l of P or of an ancestor takes K along and so does the death of the
namespace. And in the namespace that holds K the removal of the name is
refused with EBUSY as it always was.

Also, nothing new becomes reachable. K sits on the same dentry under the
same parent as before. The only change is that a removal in another
namespace no longer unmounts it. So a removal detaches less than it did
but never more. Every mount reached by the removed name is still
detached.

Verified in qemu with KASAN and lockdep. The reproducers of 528b383dc35d
and 8189ab688f5a, the stacked and self-bind overmounts, the chroot and
".." cases, 150 kselftest binaries, and a CRIU dump and restore of the
kept stack. I also added two selftests that cover the stacked and
self-bind versions of this bug on tmpfs and the LOOKUP_REVAL walk
against a raw fuse server. The reveal cases fail without the trap.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (4):
      namei: make the walk flags a named enum
      namespace: don't reveal overmounted dentries that lost their mounts
      selftests/filesystems: test the removal of a name that is a mountpoint elsewhere
      selftests/filesystems: test walks racing the unlink of covered names

 fs/dcache.c                                        |   5 +-
 fs/namei.c                                         |  57 +-
 fs/namespace.c                                     |  50 +-
 .../testing/selftests/filesystems/fuse/.gitignore  |   1 +
 tools/testing/selftests/filesystems/fuse/Makefile  |   2 +
 .../selftests/filesystems/fuse/unlink_reval_test.c | 617 ++++++++++++++
 .../selftests/filesystems/mount_cycle/.gitignore   |   1 +
 .../selftests/filesystems/mount_cycle/Makefile     |   2 +
 .../filesystems/mount_cycle/detach_mounts_test.c   | 914 +++++++++++++++++++++
 9 files changed, 1620 insertions(+), 29 deletions(-)
---
base-commit: b14fcabd34e02c40f72d3cd1e9bd4fd18df40ff1
change-id: 20261027-work-mount-trap-b4-67329de8c256

