Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793672545;
	b=jj/Wl1bRwWwqrikAFaB2agwHQXlVquh8Xsc+8/DnG1B8KEKIkD3V3GthVUXseHCFMFJQ
	 4vK18G0KSzIWC0xzIR3zwWA97v7Aov4UhHgCC8m9jFzJIdW+SXoBDNQRsPnIfzwXF9JdH
	 goZWqkHABklh3lMA7jmVooHo4ogirfIlUBKYHlLh6m3TCjniahN2GBg9+LQyt6Q4LwQS5
	 AmGv1Yr+RO01lXBBHRdVO7+dvtYqtSw/UVUOJ6SKkPQBbPmEUYo2d9Bnan9OJn3Zs5bvJ
	 ZzyVotbncO+rUj11+M3i6lhUBB/zkj14sse+0OAPvg55ZbQTfgTa9hiyLeoZ2aLLh+A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793672545;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=NUUpVkuu2VvZEInR5XBa9ztNnNOfurmbvcEuNADRsb4=;
	b=o9dYzRwXhOzrnUM1BTgDdzkDfoRqyE6PAZHelU27X+a6uNZMPLBsD+/3fgBS05Dlkind
	 g3TwQMdHRXfyWP80rqYDtXljmUB57/apZTqAQYrmtZEegpFkjCq1IjpD6Ii6dU87CbEuB
	 qYWjixsd4ScpNBhl+SOfVk+JmiXh8+hbiV3WeLeSWmceE3BgeAXPXv3fzKLZisFV6H4xW
	 ZLJ9EMdrP57dHWy0Run0isI2kJDhpO/XthGJGZ5Rv6D7OMlx9YWBFzlVdzcrkgn5br3U0
	 EScdh33cEIRzLNYcDHV4x+NEq3imbLYPthhOcwsRuCYmF7QjPGx8g0+WMI72I7UdN4g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljmFsSAB;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CEA4606A32D
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 02:22:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ljmFsSAB
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C559E1F00A15;
	Tue,  3 Nov 2026 02:22:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793672545;
	bh=NUUpVkuu2VvZEInR5XBa9ztNnNOfurmbvcEuNADRsb4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ljmFsSABl5CLi2hbY8vLTh6taqvG0YXmKByTTLtQ6PhA42bs0brK0H2E1Ajonu/Wk
	 Pd2nwY0pb8TvTG5MrPg2RE7vU3sxnshGPOxJTeVwUqMruQAy/mq1YRCeGUSBoUj6d4
	 A2o42Ecc6zNFCxkXRgLTrRZqr5v3L7j9fKUsyRKSDMqlmtijQeHJnhwdZjzSVBnPbm
	 24SJSwyuNzdrebCyGDRfy6N8fYiasHMZigKOSi6i//spUxCegMPrFzmZpIjfV62kyX
	 Sf6tuyPVw12gCwCHpP9e5Hua8W5QEy04UNUAvv3iiNEgHAG0vTBNlRpCemEOW8SMHB
	 bfWPoyTbHRABQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fredric Cover <fredric.cover.lkernel@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] smb: client: fix early procfs exposure race
Date: Mon,  2 Nov 2026 21:22:23 -0500
Message-ID: <20261103020041.2820524-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110229-bath-sphere-8a84@gregkh>
References: <2026110229-bath-sphere-8a84@gregkh>
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
[ sashal: Adjusted context to fit the existing CIFS initialization and teardown code while preserving upstream’s added and removed lines. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index d369528532c39..60ec559e0b6da 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1842,7 +1842,6 @@ static int __init
 init_cifs(void)
 {
 	int rc = 0;
-	cifs_proc_init();
 	INIT_LIST_HEAD(&cifs_tcp_ses_list);
 /*
  *  Initialize Global counters
@@ -1885,10 +1884,8 @@ init_cifs(void)
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
@@ -1964,19 +1961,22 @@ init_cifs(void)
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
@@ -2008,8 +2008,6 @@ init_cifs(void)
 	destroy_workqueue(decrypt_wq);
 out_destroy_cifsiod_wq:
 	destroy_workqueue(cifsiod_wq);
-out_clean_proc:
-	cifs_proc_clean();
 	return rc;
 }
 
@@ -2019,6 +2017,7 @@ exit_cifs(void)
 	cifs_dbg(NOISY, "exit_smb3\n");
 	unregister_filesystem(&cifs_fs_type);
 	unregister_filesystem(&smb3_fs_type);
+	cifs_proc_clean();
 	cifs_dfs_release_automount_timer();
 	exit_cifs_idmap();
 #ifdef CONFIG_CIFS_SWN_UPCALL
@@ -2039,7 +2038,6 @@ exit_cifs(void)
 	destroy_workqueue(fileinfo_put_wq);
 	destroy_workqueue(serverclose_wq);
 	destroy_workqueue(cifsiod_wq);
-	cifs_proc_clean();
 }
 
 MODULE_AUTHOR("Steve French");
-- 
2.53.0

