Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794047575;
	b=KLzrbz2eNB/SGo5sLX1rLY9nHZNkm3Av9u4GO65w5fdH4NvdWtusLBEQRv2mY2f7dhMC
	 5de+qA9knJk5m0EJpUrBnukU4vSCVSjHstEuULvCgHx/ZnvFkVrZ929TX21AObaGvKmP4
	 QaqF3KvEk/i+3bwkjNtro+duZ4J32NVKmmAZdJyE1hdIUgwuuU+v/EsXn4j3U0A2nD+he
	 M4gxGsHAv4TtW0IlRbpw9wKsypv3M1mlbCh+r0vdjbo2q09DzMN+k+agglEsa/OJw9m4f
	 OOBRk502cYsV4xJb5BgDTGtz8QXZPzKQn+2+JTL/oPbt4508N4ddi+Xnk8/tU32705A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794047575;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CHi1xo0GGVPu90e87f2bsf4rNNkXhpkGYQCa6ed6v9c=;
	b=pkfgApFKho1gnrRSkLmOwIUMyyv2GLSoEja2Zk4YKEOwYegmyIF1FJpq5vX+7KYOuuYG
	 vrrXUTZrdj6mQzSAhBqe/6zJBArmhIVPAefnh8P0bxyMGVctG/Ef69nRo5shIzeNs4kvf
	 9MVIohhSU76ArgeWV4aCyqegsjlOU/V4bgOrRqRWX1XRsfyXq6GXRym55a8XxKLDTde3G
	 2TLXATM+d97AMrbhFHSffqVVs0To3POUQdxlpY46x73jrNFt0C4wAZSR8fSuK5m0XI1bE
	 SHbym0yZL9RfgSu/wLjVRjGF28gb6DIX2xf1usGVcfSuUKg5BXrWPPNIfOpQLI2T0/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBAeN46N;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B95C606A32D
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gBAeN46N
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 702871F0089F;
	Sat,  7 Nov 2026 10:32:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794047575;
	bh=CHi1xo0GGVPu90e87f2bsf4rNNkXhpkGYQCa6ed6v9c=;
	h=From:To:Cc:Subject:Date;
	b=gBAeN46NJjtLSXbkOs+9cORYC3NNgCnbeADGBR9FQmP5idati2ZkeFgpmBs9SLYx0
	 LNLtRe19xJW17wFLbVCt/viHTraF5xvhk9fe9LvBIsbuFAEXKU6FCSj12lGQnIZ0TM
	 thWZ519lwIZhP7cOev9mt4makrDRZpR7z/RBS2nCrBbYTOBqCjbR4G7naOYUlzKhfT
	 tzvK0gAlVlsjY4BH7l1tqCRoeW8HohszQyYm2ZvqM4t2k5QEmtYAzBUQfE9mejPKCS
	 B8Se3yBXgC8ABB0uq8+21QpTZTC126Syp28aE7rWB66eC7Ta2lLzFjJ37GgGGRBcQ6
	 yL56QYfez8Ugw==
From: Sasha Levin <sashal@kernel.org>
To: senozhatsky@chromium.org,
	sarthakkukreti@google.com,
	jack@suse.cz,
	libaokun@linux.alibaba.com,
	yi.zhang@huawei.com,
	tytso@mit.edu
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] ext4: fix ABBA deadlock in ext4_rmdir()" failed to apply to 6.6-stable tree
Date: Sat,  7 Nov 2026 05:32:53 -0500
Message-ID: <20261107053253-failed-6.6-19e16597f9ba@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 19e16597f9baf1b5719a3a6c710486446f6808fd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107053253-failed-6.6-19e16597f9ba@kernel.org' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 19e16597f9baf1b5719a3a6c710486446f6808fd Mon Sep 17 00:00:00 2001
From: Sergey Senozhatsky <senozhatsky@chromium.org>
Date: Thu, 27 Aug 2026 21:50:20 +0900
Subject: [PATCH] ext4: fix ABBA deadlock in ext4_rmdir()

We observe the following ABBA deadlock (casefolding enabled):

 INFO: task jbd2/dm-13-8:447 blocked for more than 720 seconds.
 task:jbd2/dm-13-8    state:D stack:0     pid:447   tgid:447   ppid:2
 Call Trace:
  <TASK>
  __schedule+0xc2c/0xe60
  schedule+0x40/0xe0
  jbd2_journal_wait_updates+0x8f/0xf0
  jbd2_journal_commit_transaction+0x321/0x1850
  kjournald2+0xa9/0x230
  kthread+0x226/0x2a0
  ret_from_fork+0x101/0x1e0
  ret_from_fork_asm+0x1a/0x30

 INFO: task Thread-10:4161 blocked for more than 720 seconds.
 task:Thread-10       state:D stack:0     pid:4161  tgid:3848  ppid:540
 Call Trace:
  <TASK>
  __schedule+0xc2c/0xe60
  schedule+0x40/0xe0
  wait_transaction_locked+0x8c/0xd0
  start_this_handle+0x252/0x870
  jbd2__journal_start+0x120/0x280
  __ext4_journal_start_sb+0x11a/0x250
  ext4_evict_inode+0x208/0x760
  iput+0x222/0x5c0
  dput+0x293/0x690
  ____fput+0x145/0x2b0
  task_work_run+0x7a/0xb0
  exit_to_user_mode_loop+0xc0/0xd0
  do_syscall_64+0x14b/0xf10
  entry_SYSCALL_64_after_hwframe+0x76/0x7e

 NMI backtrace for cpu 0
 CPU: 0 UID: 1010216 PID: 4160 Comm: Thread-7
 RIP: 0010:d_walk+0x0/0x290
[..]
 Call Trace:
 <TASK>
  shrink_dcache_parent+0xb2/0x100
  d_invalidate+0x50/0x110
  ext4_rmdir+0x3a2/0x3d0
  vfs_rmdir+0x9d/0x1d0
  do_rmdir+0xf0/0x330
  __x64_sys_unlinkat+0x34/0x50
  do_syscall_64+0x61/0xf10

The problem is that ext4_rmdir() calls d_invalidate() before stopping
the jbd2 transaction handle.  Because d_invalidate() traverses child
dentries it can encounter dying or in-use dentries.  If a concurrent
thread executing __dentry_kill() on a child dentry invokes ext4_evict_inode(),
it requests a new transaction handle via ext4_journal_start(), which
waits for all running handles to close.  However, the thread executing
ext4_rmdir() still holds its active transaction handle while looping
in shrink_dcache_parent() waiting for the dying child dentry to complete
eviction.

Stop transaction handle in ext4_rmdir() before calling d_invalidate().

Cc: stable@kernel.org
Fixes: b886ee3e778e ("ext4: Support case-insensitive file name lookups")
Co-developed-by: Sarthak Kukreti <sarthakkukreti@google.com>
Signed-off-by: Sarthak Kukreti <sarthakkukreti@google.com>
Signed-off-by: Sergey Senozhatsky <senozhatsky@chromium.org>
Reviewed-by: Jan Kara <jack@suse.cz>
Reviewed-by: Baokun Li <libaokun@linux.alibaba.com>
Reviewed-by: Zhang Yi <yi.zhang@huawei.com>
Link: https://patch.msgid.link/20260827125158.4030598-1-senozhatsky@chromium.org
Signed-off-by: Theodore Ts'o <tytso@mit.edu>
---
 fs/ext4/namei.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index a6386c1d237f1..231a274b814ec 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3209,19 +3209,20 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	ext4_fc_track_unlink(handle, dentry);
 	retval = ext4_mark_inode_dirty(handle, dir);
 
+end_rmdir:
+	brelse(bh);
+	if (handle)
+		ext4_journal_stop(handle);
+
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
 	 * invalidating the dentries here, alongside with returning the
 	 * negative dentries at ext4_lookup(), when it is better
 	 * supported by the VFS for the CI case.
 	 */
-	if (IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
+	if (!retval && IS_ENABLED(CONFIG_UNICODE) && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
 
-end_rmdir:
-	brelse(bh);
-	if (handle)
-		ext4_journal_stop(handle);
 	return retval;
 }
 
-- 
2.53.0




