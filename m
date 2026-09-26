Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE8FA34DCC7;
	Sat, 26 Sep 2026 17:56:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790445372; cv=none; b=EFs8BKATt9RYdBMAecEJxUF2AJumCcFrzt0sMpuyfbb1M3ooW5nxHLdaTiJYquDyi17oWyLmCG84K8X8Knb35Y5UMv2rUpHuHfbYPTR+UjBr1RMK2lIFh8ortOaOxgfVfyJVl7IXWnz9Tf80dxRGbVWNP9Bm9dgnlbWKciOKDBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790445372; c=relaxed/simple;
	bh=EFbiypjzVoTipvbnxDPJ6ArGIBh4qUyMRv/lBDZxZ80=;
	h=From:Content-Type:Mime-Version:Subject:Message-Id:Date:Cc:To; b=G+reS8LFkavRu2tDDA4pTSs33ym/AJ2ZwfidzB4Mgpie9RPXes5REpbL3BzZXlCB5XBDDUBdXDdgmOvZTTol8VNiZDo/s9bSBDe8IeslnmnFIS8kuppWtZ3W5a5FV5rKhgz1ipsKdJKCqQTkE/O1JQlQxZzNJki8aSG4/MgZim8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn; spf=pass smtp.mailfrom=stu.pku.edu.cn; dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b=WBoGu/dy; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=stu.pku.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=stu.pku.edu.cn header.i=@stu.pku.edu.cn header.b="WBoGu/dy"
Received: from smtpclient.apple (unknown [124.126.139.86])
	by smtp.qiye.163.com (Hmail) with ESMTP id 4f3304f84;
	Sun, 27 Sep 2026 01:55:58 +0800 (GMT+08:00)
From: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
Content-Type: text/plain;
	charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3901.100.1.1.11\))
Subject: [PATCH] afs: Don't flush dirty data when zapping an invalidated vnode
Message-Id: <1DEF91FE-C380-49A4-87C4-2CCB380DD3E3@stu.pku.edu.cn>
Date: Sun, 27 Sep 2026 01:55:48 +0800
Cc: linux-afs@lists.infradead.org,
 linux-kernel@vger.kernel.org,
 stable@vger.kernel.org
To: David Howells <dhowells@redhat.com>,
 Marc Dionne <marc.dionne@auristor.com>
X-Mailer: Apple Mail (2.3901.100.1.1.11)
X-HM-Tid: 0aa0dedc0db503a1kunm880f196318d318
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlDSR5JVk0YTR0ZTUNDGUNNGFYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlKSU9VSklNVUpIQlVDTVlXWRYaDxIVHRRZQVlPS0hVSktJQk
	NDTFVKS0tVS1kG
DKIM-Signature: a=rsa-sha256;
	b=WBoGu/dyhjU+yx36gOoCcSuQGM1RnsVdHo2+CCAu4nx975q1IcM4FWfYEOhH3iIEd7D71moOqe9RONNQFSBnp7+W0B0FHVxMM5N96QMqP6MdmT0bK5fKUOq+wimU8eaxLkSAavIzpq1LP00178U7Uobfy/GeF8rPpuhIlYiuSWM=; c=relaxed/relaxed; s=default; d=stu.pku.edu.cn; v=1;
	bh=+kFEbchyDi4fKjv3RwnDVu48+La/CHtkjA5TZYz19D4=;
	h=date:mime-version:subject:message-id:from;

afs_validate() holds vnode->validate_lock for write while it
revalidates the vnode.  If it determines that the vnode's data must be
zapped, it calls afs_zap_data(), which for a regular file calls
filemap_invalidate_inode() with flush=3Dtrue.  That submits WB_SYNC_ALL
writeback, which re-enters afs_writepages() - and afs_writepages()
takes validate_lock for read before it will write anything back.  The
task thus deadlocks against itself in an uninterruptible sleep and
hangs forever; with the hung-task watchdog set to panic, the kernel
panics:

  Kernel panic - not syncing: hung_task: blocked tasks
  task:repro state:D pid:1
  Call Trace:
   <TASK>
   rwsem_down_read_slowpath+0x4d0/0xde0
   down_read+0xb6/0x220
   afs_writepages+0xb8/0xd0
   do_writepages+0x22c/0x550
   filemap_writeback+0x1dc/0x260
   afs_validate+0xd1d/0xfc0
   afs_fsync+0xcb/0x1d0
   do_fsync+0xac/0x200
   __x64_sys_fsync+0x32/0x50
   entry_SYSCALL_64_after_hwframe+0x77/0x7f
   </TASK>

Trigger: fsync() on a dirty file whose server-side data version
changed (callback break, v_break change or callback expiry) - a normal
concurrency scenario, no malicious server required.  Everything stuck
behind WB_SYNC_ALL (sync(), syncfs, umount, shutdown flush) hangs with
it, and the task cannot be killed.

The read acquisition in afs_writepages() cannot be dropped: it orders
writeback against afs_setattr() truncating the pagecache under the
write lock.  So the flush has to go: invalidate the pages without
flushing, which is what the directory and symlink branches of
afs_zap_data() have always done.  Any queued writes are based on a
stale data version at this point (that is why the zap was judged) and
cannot be stored coherently anyway.

The workload that hangs the unpatched kernel was run on a build of
7.3-rc3-135-g4982d3552a3bf with only this change applied: the fsync()
that used to hang now completes cleanly, and several hundred ordinary
file operations on the same build also completed without a crash.

Fixes: d73065e60dcc8 ("afs: Use alternative invalidation to using =
launder_folio")
Cc: stable@vger.kernel.org
Signed-off-by: Yuanfu Xie <yuanfuxie@stu.pku.edu.cn>
---
 fs/afs/validation.c | 14 +++++++++-----
 1 file changed, 9 insertions(+), 5 deletions(-)

diff --git a/fs/afs/validation.c b/fs/afs/validation.c
index e997563af658b..20d654bbf7e8b 100644
--- a/fs/afs/validation.c
+++ b/fs/afs/validation.c
@@ -372,11 +372,15 @@ static void afs_zap_data(struct afs_vnode *vnode)
=20
 	/* nuke all the non-dirty pages that aren't locked, mapped or =
being
 	 * written back in a regular file and completely discard the =
pages in a
-	 * directory or symlink */
-	if (S_ISREG(vnode->netfs.inode.i_mode))
-		filemap_invalidate_inode(&vnode->netfs.inode, true, 0, =
LLONG_MAX);
-	else
-		filemap_invalidate_inode(&vnode->netfs.inode, false, 0, =
LLONG_MAX);
+	 * directory or symlink.
+	 *
+	 * Don't flush here: we hold validate_lock for write, and =
writeback
+	 * would take validate_lock for read again in afs_writepages(),
+	 * deadlocking against ourselves.  The queued writes are also =
based
+	 * on a stale data version at this point and cannot be stored
+	 * coherently anyway.
+	 */
+	filemap_invalidate_inode(&vnode->netfs.inode, false, 0, =
LLONG_MAX);
 }
=20
 /*
--=20
2.43.0=
