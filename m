Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794322131;
	b=pDQDtmgKLpmGuFV7EIxuMOj5sSlqIDdw5t8vvospjBKBIcexZPQZ9fhhj9VaNkFvsfh1
	 J8A1HCLVZD+ngfq+75/MDNgIO6rskRL0W80m22Fk3jtVrPArQpDVRHhAWaRKXM2xfwVJo
	 qOY290FXNOSKs01mq2u8K27T4SWvDGXUIjqI9UT9GrZytpeSUymDWBbeZHxCYcCCsmxJ/
	 Tl8mlK2RjSin1GekgV8nqWBDGf62HmPtCoD2LGp0cKS9pfwXur9Mp1GP8yBxazQ3oncQ+
	 6N/ebvBNvwRVzFEYz+rHgUiWc5BSBOvMJwnm2XMpLowBiCvF7ir7wKgwfNfxeMnB/oQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794322131;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GAdKhpxoZetgR39oRCJSrGXBT1+uQiY2f4/4aVJ/P80=;
	b=1jEH/bE16tbaNwCd3PHKdWltMJfLatFcylF1Puw5ihEQN3gRiRqW+fVPRCP7E5qGEmrl
	 /QAjrGEBEhNg0C/39h+8NtVF2ohjKm0LSC9ApT6vtrQrbpn7r3iWr+oxt7nLIwFz4Hit8
	 Xt+3y8VCmPB+9B+hFJTxlmrrVy1h/WnIMBISAAgblN0zHkQDKtrncCtbAsX3ZKvtgW/3W
	 Nd7oLXRDUt0ngJFZl2jS/pmYQGqMUZvoXQTCqrLET08e29SXSe+1eCOLlFq+11Xnh40DN
	 ZxX5EDKkt7B/a1EgnboEgBVeVktAaL1G3B7YnHyVo0hL8KKxNGI/v3hvQhjmGA08Sxw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBnqIs7L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CFA760A2603
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:48:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UBnqIs7L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72D231F008A1;
	Tue, 10 Nov 2026 14:48:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794322131;
	bh=GAdKhpxoZetgR39oRCJSrGXBT1+uQiY2f4/4aVJ/P80=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=UBnqIs7LudQvieSQDrGeeAsgj+JyuWDPpVGwWNwMGdDoRUMWkA5TnB+GWxFdFtXk2
	 nu5hjJk+fsrWSzYHVwHElzZSgbPcTduXyJyBWfkIuOYJAiTF6tvXOECiqe/usYhZU+
	 i1xSKpCM6EnuVEoioFVxlUlH9tv111RR1bzCXLXS+2vHipV9pEAPaW2gsBiST1fsCE
	 fRhg+5Sx+MT8kNsMXwrrBO3O1DT4z9gnR8wiPnWxs0XYlQqb8Mp5Oa9m2lPnyeM8cH
	 j+1mTdNI6vccWvq3d4R7QZa0bQwr4EzSb3XpMm9v9S8fOjvZJDMLnia7RiT6obpcTB
	 qDGdGTxcJYdeg==
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
Subject: [PATCH 5.10.y] ext4: fix ABBA deadlock in ext4_rmdir()
Date: Tue, 10 Nov 2026 09:48:49 -0500
Message-ID: <20261110144832.1991777-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061952-failed-5.10-19e16597f9ba@kernel.org>
References: <20261107061952-failed-5.10-19e16597f9ba@kernel.org>
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
[ sashal: used the existing CONFIG_UNICODE preprocessor guard instead of an IS_ENABLED(CONFIG_UNICODE) condition. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/ext4/namei.c | 11 ++++++-----
 1 file changed, 6 insertions(+), 5 deletions(-)

diff --git a/fs/ext4/namei.c b/fs/ext4/namei.c
index b220d5ca7fd08..b95671649484a 100644
--- a/fs/ext4/namei.c
+++ b/fs/ext4/namei.c
@@ -3275,6 +3275,11 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	ext4_fc_track_unlink(handle, dentry);
 	retval = ext4_mark_inode_dirty(handle, dir);
 
+end_rmdir:
+	brelse(bh);
+	if (handle)
+		ext4_journal_stop(handle);
+
 #ifdef CONFIG_UNICODE
 	/* VFS negative dentries are incompatible with Encoding and
 	 * Case-insensitiveness. Eventually we'll want avoid
@@ -3282,14 +3287,10 @@ static int ext4_rmdir(struct inode *dir, struct dentry *dentry)
 	 * negative dentries at ext4_lookup(), when it is better
 	 * supported by the VFS for the CI case.
 	 */
-	if (IS_CASEFOLDED(dir))
+	if (!retval && IS_CASEFOLDED(dir))
 		d_invalidate(dentry);
 #endif
 
-end_rmdir:
-	brelse(bh);
-	if (handle)
-		ext4_journal_stop(handle);
 	return retval;
 }
 
-- 
2.53.0

