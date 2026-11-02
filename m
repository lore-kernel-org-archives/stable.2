Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793633430;
	b=VhXJSDlyCz2vdSSHqO+JEH6OFhW56Khuuip8cNCwf+qktzRt+///careTQVvsa7qjrhH
	 MGJTTpvIjU/4/IxrnMKgG0rOWb70SH94s6e62wuzpFK+T7hUvry5d16dnSa4IvRbjOEzG
	 H2oHk9S879qgBfmJT5rLdiVdu2odyrotLG/dn3OdrjJBnUn9HJXuexrfaqIQrGCUf2mqw
	 6UobsM0sSVA212hdhmFrrK7D7oAMm4qpBt2lqe8H5vwnooEX3SYm38EdzcGoN6JgPOptd
	 dxDYoj55K+Oa9PN4uvtZUQE3gVeXGyLDX8f1xxQb2JVajl7h3De5kkoLNjQicMeFYng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793633430;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=G/OG59v8N/i/e5SexocK2Na/1Z9K6o0PPIIDzjmGEd4=;
	b=nQy1HMjhRbqDoaesK9+x22TINKm2FdPMIWrlJq88TR9+awsi5Bp+0dsh7GhMFIXDgZE3
	 uAhKvPEWM6lqm7iGKL/QMAeUdJe3fo4dgIP07KQOGuqKNozzPpY0C1tJVqoK8tZ+XLJjZ
	 NFyFI5dsi2t9ebVJL9q60ir4fJR/drQMppx1KXM0kyfJ/FJ2VeOh1yM3mgR0sDVSvDvON
	 mBzlsravvzzWOEEQv9wW00ZybY4tVDR0RKQOMSo3nfOz+9ILLnC2wM1Yg21UJD+oTd7sx
	 Lw1J4MHeonR6LCSGTfz+uN2FVFbhbWsUmpRLttJoAqGIuNUoPpcGtouo6zczXfS3+1w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=e6ikSB7Z;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ED2EC606A33A
	for <stable@vger.kernel.org>; Mon,  2 Nov 2026 15:30:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=e6ikSB7Z
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C9FE1F00A21;
	Mon,  2 Nov 2026 15:30:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793633429;
	bh=G/OG59v8N/i/e5SexocK2Na/1Z9K6o0PPIIDzjmGEd4=;
	h=Subject:To:Cc:From:Date;
	b=e6ikSB7ZgoF43L5Gg9lAuJfu6gUd2ze0MAPaqyKnpBT888ddoxpH749zvKYKRbMWl
	 a7wXcmyMb1QLiA005wdq2Ryray6Kh5ne+eSxpaoV1pq41FfFs0gjqMx2h+TdmfJDYO
	 fC90FY/o/+z7wzPLXLKVDdbxNo4slKWpEkwq0yAQ=
Subject: FAILED: patch "[PATCH] smb: client: fix early procfs exposure race" failed to apply to 6.12-stable tree
To: fredric.cover.lkernel@gmail.com,pc@manguebit.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 02 Nov 2026 16:30:27 +0100
Message-ID: <2026110227-triumph-worry-bc74@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7b1afb631395c958993cda4631002258ef4151ea
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110227-triumph-worry-bc74@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7b1afb631395c958993cda4631002258ef4151ea Mon Sep 17 00:00:00 2001
From: Fredric Cover <fredric.cover.lkernel@gmail.com>
Date: Thu, 22 Oct 2026 21:55:06 +0000
Subject: [PATCH] smb: client: fix early procfs exposure race

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

diff --git a/fs/smb/client/cifsfs.c b/fs/smb/client/cifsfs.c
index 576155caf888..bf199a5ca084 100644
--- a/fs/smb/client/cifsfs.c
+++ b/fs/smb/client/cifsfs.c
@@ -2019,7 +2019,6 @@ init_cifs(void)
 	if (rc)
 		return rc;
 
-	cifs_proc_init();
 	INIT_LIST_HEAD(&cifs_tcp_ses_list);
 /*
  *  Initialize Global counters
@@ -2068,10 +2067,8 @@ init_cifs(void)
 	cifsiod_wq = alloc_workqueue("cifsiod",
 				     WQ_FREEZABLE | WQ_MEM_RECLAIM | WQ_PERCPU,
 				     0);
-	if (!cifsiod_wq) {
-		rc = -ENOMEM;
-		goto out_clean_proc;
-	}
+	if (!cifsiod_wq)
+		return -ENOMEM;
 
 	/*
 	 * Consider in future setting limit!=0 maybe to min(num_of_cores - 1, 3)
@@ -2162,19 +2159,22 @@ init_cifs(void)
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
@@ -2210,8 +2210,6 @@ init_cifs(void)
 	destroy_workqueue(decrypt_wq);
 out_destroy_cifsiod_wq:
 	destroy_workqueue(cifsiod_wq);
-out_clean_proc:
-	cifs_proc_clean();
 	return rc;
 }
 
@@ -2221,6 +2219,7 @@ exit_cifs(void)
 	cifs_dbg(NOISY, "exit_smb3\n");
 	unregister_filesystem(&cifs_fs_type);
 	unregister_filesystem(&smb3_fs_type);
+	cifs_proc_clean();
 	cifs_release_automount_timer();
 	exit_cifs_idmap();
 #ifdef CONFIG_CIFS_SWN_UPCALL
@@ -2243,7 +2242,6 @@ exit_cifs(void)
 	destroy_workqueue(serverclose_wq);
 	destroy_workqueue(cfid_put_wq);
 	destroy_workqueue(cifsiod_wq);
-	cifs_proc_clean();
 }
 
 MODULE_AUTHOR("Steve French");

