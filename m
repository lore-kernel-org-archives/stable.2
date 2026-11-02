Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793663403;
	b=dxLF7GWqDnoO1j+zAedCS6/SsbapP33z5IxOOZ4rsKoNVWUc4cm2402imuYdlY92LVfh
	 eV+erWQ1yjEhLX9j0z3NAeuP0osnwQ+sQpo0VDnkwBNNPgezzeraf1lDXRPZbZbcMO9/G
	 yNxB118F6zcXiKCeFIm+QIBwqJ/qeBrS8Fi7l3qsAEuIbztE6usIjjMGOkmqakTxmQUlx
	 10Xq2MzL09QpBVpTWcwxCOQcrFBdnw4ka0nnHgoSU6SPna8oahdWDfIepCuuAoOLs8QVS
	 camIEJXjzPHLsbyvOYkv8qtC5mqIKH3B+igicWnRyWbNqAjSLmcZsQbVVimTErjSASw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793663403;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=/wXgkfJ4QQYFajApB1Bfjjp05dvHcixqbWmk/1JD90M=;
	b=oGVzBUtlvmyNRNScUnp62gwEdqigmKBNGQ4IvOHlUza73taTWKgr379g/9Gq3e5EsqJE
	 eFnt7+Q+cs3rDk2sQc55sc7fbyAPWumm1mbOWe2J2WD3ktOxmVXi1BQVxaVZZX1fHIHTA
	 /mEWoc5hTRE3iRMp7k+pbjKfDbjNDkFSkD3IMVJxC98isutwREFZmUVnOuSRahnbW7ZcQ
	 UHMuDCMSHYO+9QNZB9/q8th8bQi5bzskF6LPa6zKticW0cCT3zLlkooZHBhtFbf+umpJn
	 HNfj29AnFbha6LITh5QnXR87iXVLi59/QZ8pf34cFKlMpMsR4o6qxREH15+oCX4UpFA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKtww8X6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6751B606A33B
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:50:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=PKtww8X6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B99FC1F00A16;
	Mon,  2 Nov 2026 23:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793663403;
	bh=/wXgkfJ4QQYFajApB1Bfjjp05dvHcixqbWmk/1JD90M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=PKtww8X6d6kBwEBKiRdUyF9L/e5E1iFqgFkNon/TQ2vRs0vLy72ZZK+vvOEnr62DB
	 SpvizCPhdeVCjcjWL56FqlwIK1XTNqYg88OwWlaxgAFHPzVL4ScRwqy7Dn5WJWBQT/
	 UPWm+IU7CUAGsrDvDiXDaHA58R8G6lQBUY1+7d4HBpHnM5QTqweW2zMAn78K0L90gl
	 Ui9q6pUvi+KaSVRvl3j0diO8wMzmIVd2QRVc0E2TimAuFTdRqEKxL5iYtbwBJiVKlZ
	 hGbOo9HBdqKk6QCcsYPNUxkZQKwlI9idI/kmeiCdEjn8mgVLwcu4H03KcvQ3GfP1ei
	 ZVd0BOUYuM9Pg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fredric Cover <fredric.cover.lkernel@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] smb: client: fix early procfs exposure race
Date: Mon,  2 Nov 2026 18:50:01 -0500
Message-ID: <20261102234411.2558907-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110228-badge-squeak-7e20@gregkh>
References: <2026110228-badge-squeak-7e20@gregkh>
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

From: Fredric Cover <fredric.cover.lkernel@gmail.com>

[ Upstream commit 7b1afb631395c958993cda4631002258ef4151ea ]

Currently, init_cifs() calls cifs_proc_init() near the beginning of
the function, before INIT_LIST_HEAD, leading to a momentarily
uninitialized, but exposed, procfs. If a userspace process reads this
empty procfs, iterating over a zeroed list_head leads to a NULL
pointer dereference and a kernel oops/panic.

For example, if a delay is added between cifs_proc_init() and
INIT_LIST_HEAD, and a userspace process is polling
/proc/fs/cifs/DebugData, the following oops occurs:

BUG: kernel NULL pointer dereference, address: 0000000000000608
Oops: Oops: 0000 [#1] SMP PTI
CPU: 0 UID: 0 PID: 3477 Comm: cat Not tainted
7.3.0-02212-g4df4d2a577db-dirty #6 PREEMPT(lazy)
RIP: 0010:cifs_debug_data_proc_show+0x103/0xd80 [cifs]
Call Trace:
<TASK>
 ? seq_read_iter+0x86/0x400
 ? seq_read_iter+0x86/0x400
 seq_read_iter+0x183/0x400
 proc_reg_read_iter+0x62/0x90
 copy_splice_read+0x215/0x310
 splice_file_to_pipe+0xec/0x1c0
 do_splice+0x4b8/0x780
 __se_sys_splice+0x18f/0x250
 do_syscall_64+0x109/0x330
 entry_SYSCALL_64_after_hwframe+0x77/0x7f
</TASK>

Fix this by moving cifs_proc_init() down in init_cifs(), ensuring it runs
only after all internal lists, locks, counters, and workqueues are fully
ready, but before registering the filesystem. Update the error cleanup
ladder and exit_cifs() to maintain proper LIFO order.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Signed-off-by: Fredric Cover <fredric.cover.lkernel@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Paulo Alcantara <pc@manguebit.org>
[ sashal: adjusted init_cifs() context for different initialization code and workqueue allocation without WQ_PERCPU ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 3154b21bfe8a2..37929590b77c4 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1848,7 +1848,6 @@ static int __init
 init_cifs(void)
 {
 	int rc = 0;
-	cifs_proc_init();
 	INIT_LIST_HEAD(&cifs_tcp_ses_list);
 /*
  *  Initialize Global counters
@@ -1897,10 +1896,8 @@ init_cifs(void)
 	}
 
 	cifsiod_wq = alloc_workqueue("cifsiod", WQ_FREEZABLE|WQ_MEM_RECLAIM, 0);
-	if (!cifsiod_wq) {
-		rc = -ENOMEM;
-		goto out_clean_proc;
-	}
+	if (!cifsiod_wq)
+		return -ENOMEM;
 
 	/*
 	 * Consider in future setting limit!=0 maybe to min(num_of_cores - 1, 3)
@@ -1983,19 +1980,22 @@ init_cifs(void)
 	if (rc)
 		goto out_cifs_swn_init;
 
+	cifs_proc_init();
+
 	rc = register_filesystem(&cifs_fs_type);
 	if (rc)
-		goto out_init_cifs_idmap;
+		goto out_clean_proc;
 
 	rc = register_filesystem(&smb3_fs_type);
 	if (rc) {
 		unregister_filesystem(&cifs_fs_type);
-		goto out_init_cifs_idmap;
+		goto out_clean_proc;
 	}
 
 	return 0;
 
-out_init_cifs_idmap:
+out_clean_proc:
+	cifs_proc_clean();
 	exit_cifs_idmap();
 out_cifs_swn_init:
 #ifdef CONFIG_CIFS_SWN_UPCALL
@@ -2029,8 +2029,6 @@ init_cifs(void)
 	destroy_workqueue(decrypt_wq);
 out_destroy_cifsiod_wq:
 	destroy_workqueue(cifsiod_wq);
-out_clean_proc:
-	cifs_proc_clean();
 	return rc;
 }
 
@@ -2040,6 +2038,7 @@ exit_cifs(void)
 	cifs_dbg(NOISY, "exit_smb3\n");
 	unregister_filesystem(&cifs_fs_type);
 	unregister_filesystem(&smb3_fs_type);
+	cifs_proc_clean();
 	cifs_release_automount_timer();
 	exit_cifs_idmap();
 #ifdef CONFIG_CIFS_SWN_UPCALL
@@ -2061,7 +2060,6 @@ exit_cifs(void)
 	destroy_workqueue(serverclose_wq);
 	destroy_workqueue(cfid_put_wq);
 	destroy_workqueue(cifsiod_wq);
-	cifs_proc_clean();
 }
 
 MODULE_AUTHOR("Steve French");
-- 
2.53.0

