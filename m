Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793709433;
	b=4aTvRok+7QJvdWVJkoI5WzWyZqcB3gNmSBiAJvFPpnsnW/NfGjiWgRXDkg6VdaGyc1kr
	 Xf4W+ckHTn1gLFFfk6xuqCV1o4Ac3VGpMjwBIDOAhAynOMzkkirZMu29y9u0LNgWHbEl+
	 urHrXmkwGRxxOyTZdTMl1v9Npx64XSVisAquYK5PrkanHYdcZYtZ7Mws2FgmOJb9TJdce
	 VyQQydgS398U1ZRva/6eYStS+gsc9Tcl4ECMdYJZCHLvxkIkpDNnZ3+KoKPtDSmFSBd0x
	 4PeE06JD73R3ztvO/V5/UFt4XB9UKXfgPv0z7KXNgO6HDysim52k+6tIq++xiDThaKA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793709433;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=M38PHJGddKhWcgSxOZbB5TqGsLrylp8RQ/fJbUUCJIY=;
	b=00G6O4nebiS25w3t0TmxvEMqYcqTj9onTwi7vlbPXwY+A3Nx0zTW8LiIVhA/Bh9tZ6cN
	 wzODog19+GCja6+Vz7zFOS7EqLv2vcpxIqWkACLje4Z5HS4f9ZwubHfOCSNPVtrhYijMI
	 azpoFZqVgXZhAK3Dh1KLumd9ItulKru1hfLb/Os1InLfZhz3fgPlGZUaY/OK3zieqmBW1
	 64Rof1rpSHbdbkIYWEo10Z5eIjnbwZyAyJp34TJxPLx4gctAwGF+KkjvMMej8AGnNliFH
	 B2HNrGteMTJi3L/hSr860x7aAw9XlJC1MWNJ9Cy2Tz8fhaK7ue3StEVpiPtk4kqysjA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndM8nzVJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6DDF8606A32E
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 12:37:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ndM8nzVJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B6351F000C1;
	Tue,  3 Nov 2026 12:37:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793709433;
	bh=M38PHJGddKhWcgSxOZbB5TqGsLrylp8RQ/fJbUUCJIY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ndM8nzVJP6B8Ib+ygM+ZQw2iuVOO6ksknPmUL1YCBDmQAtjl2p8Nn+ngoQGmL1GwU
	 sDFNvecLwL7QAoJvd9jx8Pbg440GWfgXHgZK+qL0ljH3vAd9Muxv+WX425qvURjrbZ
	 nFdkVjwrl26C+9DkFenmWF96XvBgeLT0TpitajpZ2GPA8yUxWR4WO+CRdijxCdkFTO
	 hh6Pu5DTKd4dzpopX4rfOvotI+2mgG8b0CM1ltUFGTjJ1wPzqizfruifeycP0q7czs
	 y+6EEHqkz4rjcbidXhQ55CG0Q5rux066yVrzRRTYD8eYabsARmy7EK1zbgITq+ILr/
	 bPQbdyQSCY8Qg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fredric Cover <fredric.cover.lkernel@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] smb: client: fix early procfs exposure race
Date: Tue,  3 Nov 2026 07:37:11 -0500
Message-ID: <20261103123630.3819520-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110229-brunette-gutless-b90c@gregkh>
References: <2026110229-brunette-gutless-b90c@gregkh>
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
[ sashal: adjusted context to match existing CIFS initialization and teardown code ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/cifs/cifsfs.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/cifs/cifsfs.c b/fs/cifs/cifsfs.c
index e3572c30be4f9..7b0255c600c3a 100644
--- a/fs/cifs/cifsfs.c
+++ b/fs/cifs/cifsfs.c
@@ -1590,7 +1590,6 @@ static int __init
 init_cifs(void)
 {
 	int rc = 0;
-	cifs_proc_init();
 	INIT_LIST_HEAD(&cifs_tcp_ses_list);
 /*
  *  Initialize Global counters
@@ -1633,10 +1632,8 @@ init_cifs(void)
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
@@ -1709,19 +1706,22 @@ init_cifs(void)
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
@@ -1753,8 +1753,6 @@ init_cifs(void)
 	destroy_workqueue(decrypt_wq);
 out_destroy_cifsiod_wq:
 	destroy_workqueue(cifsiod_wq);
-out_clean_proc:
-	cifs_proc_clean();
 	return rc;
 }
 
@@ -1764,6 +1762,7 @@ exit_cifs(void)
 	cifs_dbg(NOISY, "exit_smb3\n");
 	unregister_filesystem(&cifs_fs_type);
 	unregister_filesystem(&smb3_fs_type);
+	cifs_proc_clean();
 	cifs_dfs_release_automount_timer();
 	exit_cifs_idmap();
 #ifdef CONFIG_CIFS_SWN_UPCALL
@@ -1784,7 +1783,6 @@ exit_cifs(void)
 	destroy_workqueue(decrypt_wq);
 	destroy_workqueue(fileinfo_put_wq);
 	destroy_workqueue(cifsiod_wq);
-	cifs_proc_clean();
 }
 
 MODULE_AUTHOR("Steve French");
-- 
2.53.0

