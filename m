Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1792782075;
	b=jm2V7Vs+fFlsArjswCqpWGuJuFfhcYsLNN1xp/iypthK6EnM2W0KtoZ20SGAS/hbsyHe
	 S4D5tysbTK2V5Qu1plKOaCQnVvZtFu3W2icQJGaTOeYTU/Al4UppfZiSE9QPGporJ3D2y
	 iFT7XM1HV+7eFEh5QN+mWi3Q+n1uPVZOwV21pF3/jgm18Az74jUcQsW3/qkH+unt4HOTd
	 4kexelSaD7PwKePeoMGPiK7dPH0qplK2OqUY/qlp4akGhTN6ydppq4aVA9LyVkpZl8YhZ
	 NipKPXeBgTOydCLn7Ggm78sMM25ZF/gjO0WZpccMsc9p/dIGgMu/AXshOzQTXY9rdTw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792782075;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nGYCPsfcbMly9Cdl3agj4uCtl9UA26S8HQ99NyRIlkY=;
	b=41c8IO0lBLF5YmWuP7VazTcKdeFYy99zkfxotTXj+Jd8xp3uV9lF2wIzCVKYIhMWE/5v
	 uIs181J+AfAU2ZE42KxTZ0MXOmKDVXTKzYVm5INSwEs9OhGGHnIvF5bgiuVknwoF8V6SE
	 FAenKqunvcTXs04ojjlLgB5UIYCwmMfcn4+yoKGyvenBaYxOwsl4pxjFlBs2hyNVFmvam
	 9y/Abn6i9ybxIXju466iGAErLR7TD1yfGEQhqUT+4sPLafdkmP07n/3eA+hlZuwMShAcS
	 l/pwguKqWub/68oZ46Ya4F2c/28GLUieMLGYehbxGYPyTuiTYPKzCsHVPzpJE3oYbEw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGu+ek8H;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F335606A321;
	Fri, 23 Oct 2026 19:01:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QGu+ek8H
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1792782075;
	b=fbnMe8BK/37wfiniUgE1niUR2tjqonK/Q659z12p5W0HT5MVKiZ1JcsaAD6ng0V6XejT
	 xFAlWDRsc3KUh9eGsySS6Ai8Qm8NOTpCZQzxjeYOxxPXv7lvdkBlPYgmHa4RFe13M7u5h
	 NkfCqmTeJsR1zClkW1ZbqnjZk4F3qZptRNho4/pY/MofiIRIvxSkPGu9VqmJeP4F4MQOZ
	 EGFT0D1U4oKDqCd8VxM5MaKUbuitBtKhCmcHAZIVBWYNckND4QiKSKFA19AXGuRRkEzZH
	 zakQS+DdsFRGHJthG96Q+0b1SvzZrFY4k+qdMlnozb5lkJi2oZfXMpRsK/JaILEG1KQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1792782075;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:X-Change-ID:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=nGYCPsfcbMly9Cdl3agj4uCtl9UA26S8HQ99NyRIlkY=;
	b=Qj1kt1krx3H7Wt6vjgZl7WHxHqytrkNPEN8IPnwCkRvq3L8569PeMwQtREqOPfta7lN3
	 4CB+iwLnmht9eRMN04uC5isrevjF3weU5rD3I06UmCpofPu3ZYfYsWNWzk1aRcAfDApg2
	 u8QxMmEO56dEktvZzgh6oAoL02W6qrMOrVyp6IbQulIm9C6GaUASz1G/VISKYxtM6POpm
	 zmlkK1ejifii1CheWtjulj7MAvdp4/Tntc81lviyCAvNmthg4tngci/QHupyVwfjpTiM5
	 Rp1BDuxn+hIO4YUZjX52Z5vckRoO56OjrNUvm1Aao36oeUf33WiUJJsHMruDwpnCjGQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 78F0E1F01825;
	Fri, 23 Oct 2026 19:01:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792782075;
	bh=nGYCPsfcbMly9Cdl3agj4uCtl9UA26S8HQ99NyRIlkY=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=QGu+ek8HTZyJPrCcSM57xS/678ni00NxRMfPIIo4gZ+NT3pbRCfHQO8kXM2N67yGd
	 BKWaBFjEEoeY4WZSYfZiAb3zAnqcPsgBVvzCWWTCRQzJjiJBx4HNHKuuHgV0l1aTyX
	 P0ZvvLS8FEH2GDDl+cejPQdwDs7ceiEjmU9oS/iJgMyJE/74hOsOvUs01I62RTn26h
	 FMzpxP9weA3jFDqo3KRisDEOHr3BcCyG68cJeS+yYNFvdwkhV/5tRw455AU795a4OW
	 rkUlQ05hECGZO0qmdC3gmsghtK0VcrDtvYvToGcq5YoOdf2dQBeFiWGnR5JhOiVMMM
	 oSkRx9jaCVuVA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id F1694445C4;
	Fri, 23 Oct 2026 19:01:13 +0000 (UTC)
From: In-Ho Yi via B4 Relay <devnull+chajath.gmail.com@kernel.org>
Date: Fri, 23 Oct 2026 12:01:14 -0700
Subject: [PATCH] ceph: drop local lock records on unlock when the inode is
 shut down
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
Message-Id: <20261023-b4-ceph-lock-shutdown-v1-1-f9b1fd9ec026@gmail.com>
X-B4-Tracking: v=1; b=H4sIAPmu22oC/yXMQQ6CMBBA0auQWTsJHYiiVzEsShnoqGlJB5SEc
 HerLN/i/w2Uk7DCrdgg8VtUYsgwpwKct2FklD4bqKSzKanCrkbHk8dXdE9Uv8x9/AQkso1tqsF
 cLwS5nRIPsv6/9/awLt2D3fybwb5/AVnniR95AAAA
X-Change-ID: 20261023-b4-ceph-lock-shutdown-22a8a83f1972
To: Ilya Dryomov <idryomov@gmail.com>, Alex Markuze <amarkuze@redhat.com>, 
 Viacheslav Dubeyko <slava@dubeyko.com>
Cc: Jeff Layton <jlayton@kernel.org>, Chuck Lever <cel@kernel.org>, 
 ceph-devel@vger.kernel.org, linux-fsdevel@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 In-Ho Yi <chajath@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792782073; l=7346;
 i=chajath@gmail.com; s=20261023; h=from:subject:message-id;
 bh=+pvZYq2uetz94bDu77OTApmOEKJmxic7xGUKyuCGZsU=;
 b=Rqo6VGr6IO5+tAuvi9T5578N78QGo8tFgPEsuDl7JtEauaFcqQtha9MP9taxnpE4knYG/8vC9
 rG5H1YuhaT+DIH6Nii0T9ateBSVKSomKTY2UWhzvqJUxh8bRP0EUg3F
X-Developer-Key: i=chajath@gmail.com; a=ed25519;
 pk=4pEtHrGeq+cVNkwaKkqXc/36aMjHqHRtQSsE85awtG0=
X-Endpoint-Received: by B4 Relay for chajath@gmail.com/20261023 with
 auth_id=1295
X-Original-From: In-Ho Yi <chajath@gmail.com>
Reply-To: chajath@gmail.com
Content-Transfer-Encoding: 7bit

From: In-Ho Yi <chajath@gmail.com>

ceph_lock() and ceph_flock() return -ESTALE as soon as
ceph_inode_is_shutdown() is true. That refuses unlocks too, so the lock
record the VFS keeps for the inode is never removed.

On close, locks_remove_posix() and locks_remove_flock() send an F_UNLCK
through ->lock and ->flock and ignore the result: the filesystem has to
drop its local records whether or not the server can be told. nfs and
cifs do so, and ceph itself does when CEPH_I_ERROR_FILELOCK is set. On a
shut-down inode, __fput() only warns "Leaked POSIX lock" or "Leaked
FLOCK lock" and frees the file. The record stays on the inode's lock
list and on the global file_lock_list with flc_file pointing at the
freed file. It also keeps the inode reference taken by
ceph_fl_copy_lock(), so the final unmount reports "VFS: Busy inodes
after unmount of ceph", and nothing ever frees the record.

The next read of /proc/locks follows the stale flc_file. Once the
file's memory has been reused, lock_get_status() faults on the inode
pointer it reads from it, with file_rwsem held for write and
blocked_lock_lock held by locks_start(). After that oops every flock(),
fcntl() lock and /proc/locks read on the machine hangs:

  BUG: unable to handle page fault for address: 0000006600667248
  RIP: 0010:lock_get_status+0x124/0x340
  Call Trace:
   locks_show+0xaa/0x140
   seq_read_iter+0x2ce/0x4a0
   proc_reg_read_iter+0x5c/0xb0
   vfs_read+0x270/0x3a0

A mount is shut down by umount -f (ceph_umount_begin() runs even when
the unmount then fails with EBUSY), while a recover_session=clean
reconnect runs, and on CEPH_MOUNT_FENCE_IO; a single inode is shut down
when its async create fails. We hit this after the MDS blocklisted a
client: recovery ran umount -f on the dead mount while processes still
held flock() locks on it, and they closed their files later. The kernel
logged six "Leaked FLOCK lock" warnings after three such remounts.

Drop the local record for unlock requests before returning -ESTALE, as
the CEPH_I_ERROR_FILELOCK path already does.

Fixes: 5d6451b1489a ("ceph: shut down access to inode when async create fails")
Cc: stable@vger.kernel.org
Signed-off-by: In-Ho Yi <chajath@gmail.com>
---
We hit this on a CephFS kernel client running Ubuntu's 7.0.0-38 kernel,
whose fs/ceph/locks.c and fs/locks.c are identical to v7.0.

The MDS evicted and blocklisted the client. Our recovery ran umount -f
on the dead mount (it was busy, so it fell back to umount -l) while
processes on it still held flock() locks: the kernel logged "Leaked
FLOCK lock" six times, 25 to 45 minutes after each of three such
remounts (Oct 14, 15 and 16), on the three remounted superblocks
(dev 0x0:0x3c, 0x42, 0x43). Six days later the old
superblock's last user exited: "umount timed out", then "VFS: Busy
inodes after unmount of ceph". Seven hours after that, an awk reading
/proc/locks oopsed in lock_get_status() while holding file_rwsem and
blocked_lock_lock, and every file lock operation on the machine hung
until a power cycle.

In that build, lock_get_status+0x124 loads inode->i_sb, with inode =
flc->flc_file->f_inode read from freed and reused memory: a lock record
was still on file_lock_list after its file had been freed. The commit
message explains how ceph leaves it there. Since 5d6451b1489a,
ceph_lock() and ceph_flock() refuse unlocks with -ESTALE once the mount
is shut down, and the VFS ignores the result on close. The fix does
what the CEPH_I_ERROR_FILELOCK branch already does: drop the local
record, then return the error.

Testing: reproduced and verified in an arm64 VM on Ubuntu's
7.0.0-38-generic kernel (fs/ceph/locks.c and fs/locks.c as in v7.0),
with the kernel client on a single-node Ceph 19.2.3 (squid) cluster.
The steps were: take an flock() and an fcntl() write lock on CephFS,
run umount -f (it fails with EBUSY), kill the holders, run umount -l,
then read /proc/locks.

Without the patch (both the stock ceph.ko and a rebuild from the same
source), unlocks after umount -f fail with ESTALE. Each close logs
"Leaked FLOCK lock" or "Leaked POSIX lock", and the records stay in
/proc/locks under the dead owners' pids. Once their struct file slots
are reused, the records report other files' dev:ino. umount -l then
warns "VFS: Busy inodes after unmount of ceph". The next /proc/locks
read oopsed in lock_get_status(). Before the file memory was reused,
it faulted on the poisoned i_sb (dead000000000105). After churning the
filp slab, it faulted loading i_sb through a garbage f_inode, as in
our crash. Each time file locking then hung machine-wide. On a
KASAN + SLUB_RCU_DEBUG build of the same source, the first /proc/locks
read after the holders exited reported "slab-use-after-free in
lock_get_status": an 8-byte read of f_inode from a filp object freed
by the holder's __fput().

With the patch, the unlocks still return ESTALE but drop the records.
Nothing is leaked, /proc/locks stays clean under the same churn,
umount -l gives no busy inodes, and ceph.ko unloads cleanly (four
runs, plus one on the KASAN build with no report). Lock contention,
F_GETLK, unlock and close on a normal mount behave the same with and
without the patch. It also builds without warnings (W=1) for x86_64
on mainline 734bef548a96, but has not been run on x86_64.

The patch is against mainline 734bef548a96. It conflicts trivially with
the ceph_blog_exit() calls in ceph-client's testing branch; I have a
version against testing if that is easier to apply.

Jeff, Chuck: Cc'd for file locking, and Jeff as the author of
5d6451b1489a. locks_remove_file() already finds such leftover records
(that is what prints "Leaked ... lock") but leaves them linked to a
file that is about to be freed. Would you want it to unlink them as a
safety net? I can send that separately.
---
 fs/ceph/locks.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/fs/ceph/locks.c b/fs/ceph/locks.c
index 677221bd64e..a4c1e3e5112 100644
--- a/fs/ceph/locks.c
+++ b/fs/ceph/locks.c
@@ -259,8 +259,17 @@ int ceph_lock(struct file *file, int cmd, struct file_lock *fl)
 	if (!(fl->c.flc_flags & FL_POSIX))
 		return -ENOLCK;
 
-	if (ceph_inode_is_shutdown(inode))
+	if (ceph_inode_is_shutdown(inode)) {
+		/*
+		 * The MDS can't be told any more, but an unlock must still
+		 * drop the local lock record: on close the VFS ignores our
+		 * return value and frees the file, and a record left behind
+		 * would keep pointing at it from the global lock list.
+		 */
+		if (!IS_GETLK(cmd) && lock_is_unlock(fl))
+			posix_lock_file(file, fl, NULL);
 		return -ESTALE;
+	}
 
 	doutc(cl, "fl_owner: %p\n", fl->c.flc_owner);
 
@@ -328,8 +337,12 @@ int ceph_flock(struct file *file, int cmd, struct file_lock *fl)
 	if (!(fl->c.flc_flags & FL_FLOCK))
 		return -ENOLCK;
 
-	if (ceph_inode_is_shutdown(inode))
+	if (ceph_inode_is_shutdown(inode)) {
+		/* See ceph_lock(): an unlock must drop the local record. */
+		if (lock_is_unlock(fl))
+			locks_lock_file_wait(file, fl);
 		return -ESTALE;
+	}
 
 	doutc(cl, "fl_file: %p\n", fl->c.flc_file);
 

---
base-commit: 734bef548a96e8774d6eef5dfa2026c6edc4e80b
change-id: 20261023-b4-ceph-lock-shutdown-22a8a83f1972

Best regards,
--  
In-Ho Yi <chajath@gmail.com>


