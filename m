Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 925CE51A14A
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 18:01:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790791308; cv=none; b=tFKeY1pitmmOQ2DGbov5xKPz4lsiSlmLGVn+zSopjDR8740KSZECqyf3tbxY9eabaRwS8u0llqySPzoD/8gA8lw8LGIcS1oXyLS+lYjqupz4wzWUJO2pEL1Rv3HS4xCBSZr0yS81Q3e3YDaZnJ6aMwnbQIEy2cYGGFDjlrGu4OY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790791308; c=relaxed/simple;
	bh=8Pj4Ef0YaIxVpDXpOcUqy6hfxtttJdEBl2MTDL+SG7k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OpZXVHzxsf3Xgv47FKpzeKVBMcNFszGLbQLMLXawu7w4hdHRw5aVhdP3xODaPnCiBF5Okix+KuYl0fFltB0Y4f4mz1bZpzmOf7FglgbkXDQ/YtfDPkkN4iFz4gt5W7OnNOjuxl0r88Ir2/PINQbN2VztZ9CuFLDAzHJYNeQ9kIc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cnViZoxB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cnViZoxB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDB691F0089A;
	Wed, 30 Sep 2026 18:01:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790791306;
	bh=0xUG3f5jlkhHSN80SssKyuQLpQlTMndcPH7jfiP3XXU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cnViZoxBfRaqA/VKugRBy946dbcr+RmhaZ5P+QyQPWRWgS8w9WA0ccm/kt6Lc16ug
	 GCWaJ8QWakfQJC+c5myooxEJ7Zsf6QVq0FTxnTWsmE+Y2tZl9XxxA2ZOI6PZ7g38BL
	 b8BrMwx2/moButrBGrFvGh6qDXGTJ3EeV8v/oz520b0i2soZtXQfwgmddlALEVttt3
	 FJdCyLY9zBdL5Z6YfHJkzUO9BneP6xn11Z/Yfh93/tXECh5yv0tW9OlmGEGwyNZmi2
	 U8snxXb+7BgtJOpEYdMciLpHJbC54ZbQGnDHbhNX4phsJWaAOSxz3nS+7Zr1JcTIbO
	 hUA5ID54AkC9g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Paulo Alcantara <pc@manguebit.com>,
	Steve French <stfrench@microsoft.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 2/3] smb: client: fix use-after-free in smb2_query_info_compound()
Date: Wed, 30 Sep 2026 14:01:42 -0400
Message-ID: <20260930180143.3974994-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260930180143.3974994-1-sashal@kernel.org>
References: <2026092902-hacksaw-legwork-e770@gregkh>
 <20260930180143.3974994-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Paulo Alcantara <pc@manguebit.com>

[ Upstream commit 5c86919455c1edec99ebd3338ad213b59271a71b ]

The following UAF was triggered when running fstests generic/072 with
KASAN enabled against Windows Server 2022 and mount options
'multichannel,max_channels=2,vers=3.1.1,mfsymlinks,noperm'

  BUG: KASAN: slab-use-after-free in smb2_query_info_compound+0x423/0x6d0 [cifs]
  Read of size 8 at addr ffff888014941048 by task xfs_io/27534

  CPU: 0 PID: 27534 Comm: xfs_io Not tainted 6.6.0-rc7 #1
  Hardware name: QEMU Standard PC (Q35 + ICH9, 2009), BIOS
  rel-1.16.2-3-gd478f380-rebuilt.opensuse.org 04/01/2014
  Call Trace:
   dump_stack_lvl+0x4a/0x80
   print_report+0xcf/0x650
   ? srso_alias_return_thunk+0x5/0x7f
   ? srso_alias_return_thunk+0x5/0x7f
   ? __phys_addr+0x46/0x90
   kasan_report+0xda/0x110
   ? smb2_query_info_compound+0x423/0x6d0 [cifs]
   ? smb2_query_info_compound+0x423/0x6d0 [cifs]
   smb2_query_info_compound+0x423/0x6d0 [cifs]
   ? __pfx_smb2_query_info_compound+0x10/0x10 [cifs]
   ? srso_alias_return_thunk+0x5/0x7f
   ? __stack_depot_save+0x39/0x480
   ? kasan_save_stack+0x33/0x60
   ? kasan_set_track+0x25/0x30
   ? ____kasan_slab_free+0x126/0x170
   smb2_queryfs+0xc2/0x2c0 [cifs]
   ? __pfx_smb2_queryfs+0x10/0x10 [cifs]
   ? __pfx___lock_acquire+0x10/0x10
   smb311_queryfs+0x210/0x220 [cifs]
   ? __pfx_smb311_queryfs+0x10/0x10 [cifs]
   ? srso_alias_return_thunk+0x5/0x7f
   ? __lock_acquire+0x480/0x26c0
   ? lock_release+0x1ed/0x640
   ? srso_alias_return_thunk+0x5/0x7f
   ? do_raw_spin_unlock+0x9b/0x100
   cifs_statfs+0x18c/0x4b0 [cifs]
   statfs_by_dentry+0x9b/0xf0
   fd_statfs+0x4e/0xb0
   __do_sys_fstatfs+0x7f/0xe0
   ? __pfx___do_sys_fstatfs+0x10/0x10
   ? srso_alias_return_thunk+0x5/0x7f
   ? lockdep_hardirqs_on_prepare+0x136/0x200
   ? srso_alias_return_thunk+0x5/0x7f
   do_syscall_64+0x3f/0x90
   entry_SYSCALL_64_after_hwframe+0x6e/0xd8

  Allocated by task 27534:
   kasan_save_stack+0x33/0x60
   kasan_set_track+0x25/0x30
   __kasan_kmalloc+0x8f/0xa0
   open_cached_dir+0x71b/0x1240 [cifs]
   smb2_query_info_compound+0x5c3/0x6d0 [cifs]
   smb2_queryfs+0xc2/0x2c0 [cifs]
   smb311_queryfs+0x210/0x220 [cifs]
   cifs_statfs+0x18c/0x4b0 [cifs]
   statfs_by_dentry+0x9b/0xf0
   fd_statfs+0x4e/0xb0
   __do_sys_fstatfs+0x7f/0xe0
   do_syscall_64+0x3f/0x90
   entry_SYSCALL_64_after_hwframe+0x6e/0xd8

  Freed by task 27534:
   kasan_save_stack+0x33/0x60
   kasan_set_track+0x25/0x30
   kasan_save_free_info+0x2b/0x50
   ____kasan_slab_free+0x126/0x170
   slab_free_freelist_hook+0xd0/0x1e0
   __kmem_cache_free+0x9d/0x1b0
   open_cached_dir+0xff5/0x1240 [cifs]
   smb2_query_info_compound+0x5c3/0x6d0 [cifs]
   smb2_queryfs+0xc2/0x2c0 [cifs]

This is a race between open_cached_dir() and cached_dir_lease_break()
where the cache entry for the open directory handle receives a lease
break while creating it.  And before returning from open_cached_dir(),
we put the last reference of the new @cfid because of
!@cfid->has_lease.

Besides the UAF, while running xfstests a lot of missed lease breaks
have been noticed in tests that run several concurrent statfs(2) calls
on those cached fids

  CIFS: VFS: \\w22-root1.gandalf.test No task to wake, unknown frame...
  CIFS: VFS: \\w22-root1.gandalf.test Cmd: 18 Err: 0x0 Flags: 0x1...
  CIFS: VFS: \\w22-root1.gandalf.test smb buf 00000000715bfe83 len 108
  CIFS: VFS: Dump pending requests:
  CIFS: VFS: \\w22-root1.gandalf.test No task to wake, unknown frame...
  CIFS: VFS: \\w22-root1.gandalf.test Cmd: 18 Err: 0x0 Flags: 0x1...
  CIFS: VFS: \\w22-root1.gandalf.test smb buf 000000005aa7316e len 108
  ...

To fix both, in open_cached_dir() ensure that @cfid->has_lease is set
right before sending out compounded request so that any potential
lease break will be get processed by demultiplex thread while we're
still caching @cfid.  And, if open failed for some reason, re-check
@cfid->has_lease to decide whether or not put lease reference.

Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara (SUSE) <pc@manguebit.com>
Signed-off-by: Steve French <stfrench@microsoft.com>

Stable dependency adaptation for d2ff5fb93ea8:

The preceding stable dependency already preserves the caller reference
through concurrent lease-break cleanup using an explicit cache-ownership
flag and close_cached_dir(). Keep that lifetime model and the current
error-returning smb2_parse_contexts() API.

Retain the rejected-response error handling: fail a CREATE without a
lease, a lease without read caching, or a short FILE_ALL_INFO result.
Restore success only after the directory has been fully cached. Route
prefix-path errors through common reference cleanup, bypassing the
request buffers that have not yet been initialized.

Omit early lease publication and the associated lookup/dentry and
cleanup rewrites. This branch clears has_lease in deferred lease-break
work, so testing that flag alone cannot establish ownership of the lease
reference. The existing cache-ownership tracking must not be replaced by
the upstream unconditional free path. No functions are added, and the
compound-response and final cleanup context is kept for the target.

Move the existing smb2status.h unchanged from client/ to common/ and
adjust its seven existing users. The target includes the common path,
which does not exist in this stable tree; without this preparation the
target applies cleanly but fails to compile. This relocates definitions
only and does not import the newer status-table implementation.

Stable-dep-of: d2ff5fb93ea8 ("smb: client: clean up failed cached directory opens")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cached_dir.c             | 8 ++++++--
 fs/smb/client/smb2file.c               | 2 +-
 fs/smb/client/smb2inode.c              | 2 +-
 fs/smb/client/smb2maperror.c           | 2 +-
 fs/smb/client/smb2misc.c               | 2 +-
 fs/smb/client/smb2ops.c                | 2 +-
 fs/smb/client/smb2pdu.c                | 2 +-
 fs/smb/client/smb2transport.c          | 2 +-
 fs/smb/{client => common}/smb2status.h | 0
 9 files changed, 13 insertions(+), 9 deletions(-)
 rename fs/smb/{client => common}/smb2status.h (100%)

diff --git a/fs/smb/client/cached_dir.c b/fs/smb/client/cached_dir.c
index f6c72c6567f9d..d7cab84644a45 100644
--- a/fs/smb/client/cached_dir.c
+++ b/fs/smb/client/cached_dir.c
@@ -182,8 +182,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	npath = path_no_prefix(cifs_sb, path);
 	if (IS_ERR(npath)) {
 		rc = PTR_ERR(npath);
-		kfree(utf16_path);
-		return rc;
+		goto out;
 	}
 
 	/*
@@ -273,6 +272,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 
 	if (o_rsp->OplockLevel != SMB2_OPLOCK_LEVEL_LEASE) {
 		spin_unlock(&cfids->cfid_list_lock);
+		rc = -EINVAL;
 		goto oshr_free;
 	}
 
@@ -283,6 +283,7 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	spin_unlock(&cfids->cfid_list_lock);
 	if (rc)
 		goto oshr_free;
+	rc = -EINVAL;
 	if (!(oplock & SMB2_LEASE_READ_CACHING_HE))
 		goto oshr_free;
 	qi_rsp = (struct smb2_query_info_rsp *)rsp_iov[1].iov_base;
@@ -310,12 +311,15 @@ int open_cached_dir(unsigned int xid, struct cifs_tcon *tcon,
 	cfid->has_lease = true;
 	cached = true;
 	spin_unlock(&cfids->cfid_list_lock);
+	/* At this point the directory handle is fully cached */
+	rc = 0;
 
 oshr_free:
 	SMB2_open_free(&rqst[0]);
 	SMB2_query_info_free(&rqst[1]);
 	free_rsp_buf(resp_buftype[0], rsp_iov[0].iov_base);
 	free_rsp_buf(resp_buftype[1], rsp_iov[1].iov_base);
+out:
 	spin_lock(&cfids->cfid_list_lock);
 	if (rc && !cfid->has_lease) {
 		if (cfid->on_list) {
diff --git a/fs/smb/client/smb2file.c b/fs/smb/client/smb2file.c
index 2d0dd87dae0dd..4bf62a2487bb7 100644
--- a/fs/smb/client/smb2file.c
+++ b/fs/smb/client/smb2file.c
@@ -20,7 +20,7 @@
 #include "cifs_unicode.h"
 #include "fscache.h"
 #include "smb2proto.h"
-#include "smb2status.h"
+#include "../common/smb2status.h"
 
 static struct smb2_symlink_err_rsp *symlink_data(const struct kvec *iov)
 {
diff --git a/fs/smb/client/smb2inode.c b/fs/smb/client/smb2inode.c
index 452a60e09cbed..9dc7b1877a75b 100644
--- a/fs/smb/client/smb2inode.c
+++ b/fs/smb/client/smb2inode.c
@@ -24,7 +24,7 @@
 #include "smb2pdu.h"
 #include "smb2proto.h"
 #include "cached_dir.h"
-#include "smb2status.h"
+#include "../common/smb2status.h"
 
 static void
 free_set_inf_compound(struct smb_rqst *rqst)
diff --git a/fs/smb/client/smb2maperror.c b/fs/smb/client/smb2maperror.c
index 194799ddd3828..4c63d3439bf4f 100644
--- a/fs/smb/client/smb2maperror.c
+++ b/fs/smb/client/smb2maperror.c
@@ -12,7 +12,7 @@
 #include "cifs_debug.h"
 #include "smb2pdu.h"
 #include "smb2proto.h"
-#include "smb2status.h"
+#include "../common/smb2status.h"
 #include "smb2glob.h"
 #include "trace.h"
 
diff --git a/fs/smb/client/smb2misc.c b/fs/smb/client/smb2misc.c
index cd00bf48c9a56..c67b77c4858f4 100644
--- a/fs/smb/client/smb2misc.c
+++ b/fs/smb/client/smb2misc.c
@@ -13,7 +13,7 @@
 #include "smb2proto.h"
 #include "cifs_debug.h"
 #include "cifs_unicode.h"
-#include "smb2status.h"
+#include "../common/smb2status.h"
 #include "smb2glob.h"
 #include "nterr.h"
 #include "cached_dir.h"
diff --git a/fs/smb/client/smb2ops.c b/fs/smb/client/smb2ops.c
index 2b38e8e7efd4e..fbd9f7f03fdfc 100644
--- a/fs/smb/client/smb2ops.c
+++ b/fs/smb/client/smb2ops.c
@@ -21,7 +21,7 @@
 #include "cifsproto.h"
 #include "cifs_debug.h"
 #include "cifs_unicode.h"
-#include "smb2status.h"
+#include "../common/smb2status.h"
 #include "smb2glob.h"
 #include "cifs_ioctl.h"
 #include "smbdirect.h"
diff --git a/fs/smb/client/smb2pdu.c b/fs/smb/client/smb2pdu.c
index 98d6fcdf22365..9ea286d20f88a 100644
--- a/fs/smb/client/smb2pdu.c
+++ b/fs/smb/client/smb2pdu.c
@@ -30,7 +30,7 @@
 #include "cifs_unicode.h"
 #include "cifs_debug.h"
 #include "ntlmssp.h"
-#include "smb2status.h"
+#include "../common/smb2status.h"
 #include "smb2glob.h"
 #include "cifspdu.h"
 #include "cifs_spnego.h"
diff --git a/fs/smb/client/smb2transport.c b/fs/smb/client/smb2transport.c
index 3a69f3500acde..797a147366851 100644
--- a/fs/smb/client/smb2transport.c
+++ b/fs/smb/client/smb2transport.c
@@ -24,7 +24,7 @@
 #include "cifsproto.h"
 #include "smb2proto.h"
 #include "cifs_debug.h"
-#include "smb2status.h"
+#include "../common/smb2status.h"
 #include "smb2glob.h"
 
 static int
diff --git a/fs/smb/client/smb2status.h b/fs/smb/common/smb2status.h
similarity index 100%
rename from fs/smb/client/smb2status.h
rename to fs/smb/common/smb2status.h
-- 
2.53.0

