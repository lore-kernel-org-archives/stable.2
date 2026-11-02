Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793660458;
	b=yVBqXjM4a9sSd06JHJBvxnihHI9qM+gSFDBgzKxI5cLsD9whY/QyAODn5ORl/iGJ6C4k
	 64z+FHii9d7147BZCSBcGRwR9Cm6hFNH7MTyuscWY4pTzzLHQhFMUzFLvBjhWVZf6IL+E
	 gKGH+2hK4E69OEIEdCk8S4tHTS+ZWWzHxeOaoverggcqZvRcC7MYZSKDbXNzB9dCY4kAM
	 zAhQJ3kR/LBsvay03Ephd9Ss3Y3+AjjceC4OwEgRPI0xvO8P3GoIoGLXhUYml5NMB1joD
	 l7uzUxi2vXN+9xtRfQHMV32eOY1cPQnPDmAjJRklM2V9DoqQBA7SmcTjYMMPjyaI1CA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793660458;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=v9FoiQ0Bda4AOHHLTuZWnGDukyDMUCFy7/0BGVhTX3c=;
	b=eO6iJk+JremMOFASMaoCK9XYAleAiwnIvWt5OCNlK9evPGBGpgl8EJJ6mNz+xGLFpNgr
	 LDSgRm1Ui7t0tg2nylIGUU9o2irCuP3Qgqiif+nYnDW0jCPLU8h2KNpe2FHYvcE0Or1xw
	 hq9ychv4/MmUEAAvqHRCQjn68PQ+rVF8sTE4rDtVadqtMz0jgDKTRJk8Ut1xs+OdNkppV
	 bTgULEHly2b+XPtPgsn9pUEX8dc6CTliLIpLAV7SuriT2aGqfNbVvgAnuTb6snQWx/+Kp
	 guA2yCvHiE0gYHoUowy8vM5pvdaWK46Pd2wvMwe2lhP/WOz2ndpVhKiGkpcbOLMFUig==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5qqVcRR;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 280A3606A326
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 23:00:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Y5qqVcRR
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 290E21F00A16;
	Mon,  2 Nov 2026 23:00:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793660457;
	bh=v9FoiQ0Bda4AOHHLTuZWnGDukyDMUCFy7/0BGVhTX3c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y5qqVcRRMvYLXBarndxslkTMxmRbLi0ynatcrY+C3eel70HvT7i/jM5vijtb8wH6z
	 +MqNP41mN+L+IrgEjzH3Z1HBZVN1AIlAp1/W/0GyDtSndh/pwkclBqBtQddLPcPyX3
	 0ZGka5EA5HlJqDmmFseFhDOdYgNpJGPap5RVstueW1+0MP2GaOAFk6Hr2QD1Yl2Ae9
	 ZVV1tZAZ/17XEUI1LxMaIIknS7PpYyfJHdRH7DjEDkrcC+qYYhd4EUG+q5OgcQePtS
	 oUvcUMBJENFLo4StuSPBlliWGp0oHQH6EHGYDl6n81Hc7KV8gpBEHsjZt8ZTEZ0Q1Y
	 EbFpP2FTtblBA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Fredric Cover <fredric.cover.lkernel@gmail.com>,
	Paulo Alcantara <pc@manguebit.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] smb: client: fix early procfs exposure race
Date: Mon,  2 Nov 2026 18:00:55 -0500
Message-ID: <20261102223800.2124716-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110227-triumph-worry-bc74@gregkh>
References: <2026110227-triumph-worry-bc74@gregkh>
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
[ sashal: Adjusted context for absent maperror initialization calls and a workqueue declaration without WQ_PERCPU. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 fs/smb/client/cifsfs.c | 20 +++++++++-----------
 1 file changed, 9 insertions(+), 11 deletions(-)

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 65bf11f606ed4..cfe950e3fb9cf 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -1916,7 +1916,6 @@ static int __init
 init_cifs(void)
 {
 	int rc = 0;
-	cifs_proc_init();
 	INIT_LIST_HEAD(&cifs_tcp_ses_list);
 /*
  *  Initialize Global counters
@@ -1965,10 +1964,8 @@ init_cifs(void)
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
@@ -2055,19 +2052,22 @@ init_cifs(void)
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
@@ -2103,8 +2103,6 @@ init_cifs(void)
 	destroy_workqueue(decrypt_wq);
 out_destroy_cifsiod_wq:
 	destroy_workqueue(cifsiod_wq);
-out_clean_proc:
-	cifs_proc_clean();
 	return rc;
 }
 
@@ -2114,6 +2112,7 @@ exit_cifs(void)
 	cifs_dbg(NOISY, "exit_smb3\n");
 	unregister_filesystem(&cifs_fs_type);
 	unregister_filesystem(&smb3_fs_type);
+	cifs_proc_clean();
 	cifs_release_automount_timer();
 	exit_cifs_idmap();
 #ifdef CONFIG_CIFS_SWN_UPCALL
@@ -2136,7 +2135,6 @@ exit_cifs(void)
 	destroy_workqueue(serverclose_wq);
 	destroy_workqueue(cfid_put_wq);
 	destroy_workqueue(cifsiod_wq);
-	cifs_proc_clean();
 }
 
 MODULE_AUTHOR("Steve French");
-- 
2.53.0

