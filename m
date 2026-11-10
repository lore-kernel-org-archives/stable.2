Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794320625;
	b=G38gLaa/PlE48i1n0/NkwIJz0FMxMKk+l7YNSlR0PlIGzSfw4dFLaQq7kkjqOeIuU/2V
	 MKw35ge++8ln4BIc+cvZHQo5A9pWXwHdQZY5jAYdeM1xpxkuDodrGqXImlnC+vS23dSk8
	 m9CRnllaSMNtELJuV8anoMw6QTtw7vT1PGfIKuyEBwIvy+MbmmjqfWY86esQXEGByX53q
	 /CXJY/Xt8zMd0pPBwzBEnhGuxysjS/Xv0QoM5lGA5zzHPxmF2bUE1bBs2AY07XJEjb5U+
	 IhOgBZW1fUqJKH/XDaznTkiAjTb7Pr0A61ainKPOXoHlsm+VoJ5He5j6ngwxN4FyMDg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794320625;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MFHhV6JV3duPdWlAwTgNl2405AjB2zbzyR5W6vvdjbs=;
	b=Jto6mZHL4YOBgiOG6AZ/hwNDuPr4DFnfbasq7O7j72zipcRNFtB//LawgFxq9/6cc29k
	 /3hqRTuR0yu6voa10GMbLaxq8GejY2hFEnDUDxxuaXZ7ln9eeb7IO2Y/j565aU8CxJAMa
	 zIFqxwwS/QsmJhSbbkEoM3gbKwTQdloMMD1mipmVY9h1JeXt3TL5Easft84ZTvHo+KYNq
	 3Qrb+j5t0U0USTouPH4gv26NsGib6p0tNdIuyOOSWKCAhwEQwQsR6lUXkFm9EbMiKPx9j
	 wNxRJjaLpjjgea1fw5Cpb5uExj2qB1iOZkl8FRd+Aw4289J0PHJeezE3l/d+Lvd/q+g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CA6hh4Nn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3239606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:23:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=CA6hh4Nn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 845061F008A4;
	Tue, 10 Nov 2026 14:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794320624;
	bh=MFHhV6JV3duPdWlAwTgNl2405AjB2zbzyR5W6vvdjbs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CA6hh4Nn3sB9vdG6FQ2j4ZkZ+X0EcdUeRHyjEy5IOQDWDz5sf+deVAdp9mITVWfM2
	 JNuAiV1lJDGMWOCuJi7iPImpSghMtUkKplIaIlux4X1kq8pBc0dW1HpftRaG2nvTNW
	 83ISg7MGVCAmLRo7nc0SaGpJZJbJ966Cq1s/S9YHHYeyBE+mlBMRxgSxpReRm28Znk
	 KLCX1QziEsWoqvfk1xu5pNkn1tL84xJrh/O13+8CdX1aeIHBg46hnB68nzo57+z7cl
	 yNMS9Exy6OmRqF3zpE4fOOap5vlkK6bLyLC8Eo1nZZ8W0WJJ7U+LvtFqPIlws/6wUO
	 2aLMOtreAxpZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Sergey Senozhatsky <senozhatsky@chromium.org>,
	stable@kernel.org,
	Sarthak Kukreti <sarthakkukreti@google.com>,
	Jan Kara <jack@suse.cz>,
	Baokun Li <libaokun@linux.alibaba.com>,
	Zhang Yi <yi.zhang@huawei.com>,
	Theodore Ts'o <tytso@mit.edu>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] ext4: fix ABBA deadlock in ext4_rmdir()
Date: Tue, 10 Nov 2026 09:23:41 -0500
Message-ID: <20261110142328.1870404-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110142328.1870404-1-sashal@kernel.org>
References: <20261107053253-failed-6.6-19e16597f9ba@kernel.org>
 <20261110142328.1870404-1-sashal@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sergey Senozhatsky <senozhatsky@chromium.org>

[ Upstream commit 19e16597f9baf1b5719a3a6c710486446f6808fd ]

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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/namei.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index c77a18ce76bc7..b30ddb3750fd4 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3259,19 +3259,20 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
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

