Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79DE041B8CA;
	Wed, 23 Sep 2026 12:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790166497; cv=none; b=icm3jZMpS5ZDp94RIJ867wCXZXb8XfQ3cp7bpKcEoxOsgwurRpeGuhmgimX7BtegOmUOnslA1stXdtfkqz3c/w7UEoMKfgJ2maOGe7izbHN6ur8fchiXyjN7av20vIz9zIDFdsWT+zLfwyW1ZclUfVBhPCqu4oXSjcTvozg87xQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790166497; c=relaxed/simple;
	bh=0Hd3XZaFVuSejGdy0w11S2DgNKwVgyhUOfn6Q2MxHEY=;
	h=From:Subject:Date:Message-Id:MIME-Version:Content-Type:To:Cc; b=PaGc9ugUrPt+1TFTMXmGnbkX5och0vhqx894O6oEYo45lqfF+n3AkenSdGiv9dzIIumFxji00ohaPPoHoOmVF0RUJlIj19mVzEZ3Nv7jENWBHYpwwd8yy0PgOrIXx6LZqb9CbGGKvMXspNjKX7Ta+5wpbSoR3XG71mwTDkfNQyg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MexNZgLc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MexNZgLc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE8791F000FF;
	Wed, 23 Sep 2026 12:28:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790166496;
	bh=/3d/hQi7NRIqT8f/OXN6KqZziYFPXJtZSIg/QdPyn0Y=;
	h=From:Subject:Date:To:Cc;
	b=MexNZgLcC9jTipp2qUqYqnbYBujAMMmUgCPBU0bAaWxwahmZ+rL4ZCc66yW1N3t8/
	 3on8OYPZc71eJqlc0tIA0lfsYhI5DMm+Fh6HlxX3utyCxEToSSUnToWpwSH1eJlRXZ
	 MNoKrVhek3HKr1z8LA4jdfRLY0YuoOWFb0fOGoOwpWEmlSMihaHPeLntdy26TWoZgR
	 Y9Yb7gLZiiocX/iCvszwV8FIG60VjsrvRdgzMXBb+mNlx1ky+0C9gbXWrQZ9/bndpd
	 xFLpzdzCekcmCK0gdMO3pNFeNpRkPmzrvoYyzhRATqOI22IMG+g6qawnPnxmd5UGFt
	 atUpokjKL2crA==
From: Christian Brauner <brauner@kernel.org>
Subject: [PATCH 0/8] mount: a few gnarly fixes
Date: Wed, 23 Sep 2026 14:27:52 +0200
Message-Id: <20260923-work-mount-fixes-v1-0-f424cf8d3242@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yWM0Q7CIAxFf2XpsyUbLkb8FeMDxeLQCIZuarLs3
 wV8PL09ZwXhHFjg1K2Q+R0kpFhg2HXgJhtvjOFaGHSvD73Re/yk/MBnWuKMPnxZ0Bk/GE/jcWS
 Cor0yt6FY58ufZaE7u7l26gdZYaRso5vqqRZVK6omqrrDtv0A+/SYT5wAAAA=
X-Change-ID: 20260923-work-mount-fixes-c9f19fb484eb
To: linux-fsdevel@vger.kernel.org
Cc: Linus Torvalds <torvalds@linux-foundation.org>, 
 Alexander Viro <viro@zeniv.linux.org.uk>, Jan Kara <jack@suse.cz>, 
 "Christian Brauner (Amutable)" <brauner@kernel.org>, stable@vger.kernel.org
X-Mailer: b4 0.17-dev-db0b7
X-Developer-Signature: v=1; a=openpgp-sha256; l=2554; i=brauner@kernel.org;
 h=from:subject:message-id; bh=0Hd3XZaFVuSejGdy0w11S2DgNKwVgyhUOfn6Q2MxHEY=;
 b=owGbwMvMwCU28Zj0gdSKO4sYT6slMWRtPnrnFlep2n67H9mran751h0tKT4cqBX6h/+N5jqzA
 geJzrulHaUsDGJcDLJiiiwO7Sbhcst5KjYbZWrAzGFlAhnCwMUpABP5Hs7IcPde0afomdbmh6Qm
 tymf2+4v9feawUaGRa9KbpifLrx90JPhN1vGG/bT7p1qzGpuk57bJTsnLFvL57I0QONJGNvcsMW
 tDAA=
X-Developer-Key: i=brauner@kernel.org; a=openpgp;
 fpr=4880B8C9BD0E5106FC070F4F7B3C391EFEA93624

Hey,

A short while ago I received a bug report about problematic behavior in
the mount code and that let me to review and model a few corner cases
including reference counting. The result is the following set of fixes:

- Ensure that copies of unbindable mounts remain unbindable
- Ensure that MOVE_MOUNT_SET_GROUP doesn't operate on unbindable mounts
  so we don't create an undefined state where a mount is both unbindable
  and a slave mount.
- Ensure that we don't silently unmount busy mounts. This is nasty
  because it's an old bug from v4.13 where calculation of whether a
  synchronous (non-MNT_DETACH) umount would succeed drifted apart from
  the actual codepath that did the unmount.
- Ensure that we don't silently unmount busy mounts. Same class,
  different mechanism. There's a race between the reference count check
  in propagate_mount_busy() (summing up per-cpu counters) and mntget().

Fixes and test for all. No test for the mntget() race because that needs
aritifical delays.

And fwiw, I think I another vomitorious series in the pipes.

Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>
---
Christian Brauner (8):
      mount: keep a copied mount unbindable
      selftests/filesystems: check that a copied mount namespace keeps unbindable
      mount: refuse MOVE_MOUNT_SET_GROUP on an unbindable mount
      selftests/move_mount_set_group: check that an unbindable target is refused
      fs: don't silently unmount busy mounts
      selftests/filesystems: check that a busy propagated copy blocks a synchronous umount
      fs: don't let a migrating task hide its reference from do_umount()
      docs: update the unmount propagation rule

 Documentation/filesystems/sharedsubtree.rst        |  20 +-
 fs/mount.h                                         |   3 +-
 fs/namespace.c                                     |  51 +++--
 fs/pnode.c                                         | 108 ++++++++--
 tools/testing/selftests/Makefile                   |   2 +
 .../filesystems/mntns_unbindable/Makefile          |   6 +
 .../mntns_unbindable/mntns_unbindable_test.c       | 227 +++++++++++++++++++++
 .../filesystems/umount_propagation/Makefile        |   6 +
 .../umount_propagation/umount_propagation_test.c   | 226 ++++++++++++++++++++
 .../move_mount_set_group_test.c                    |  74 ++++++-
 10 files changed, 673 insertions(+), 50 deletions(-)
---
base-commit: 2d2a2d7aa98741b58f54cacc99b52024e4d865f9
change-id: 20260923-work-mount-fixes-c9f19fb484eb

