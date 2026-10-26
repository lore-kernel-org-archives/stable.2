Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.179
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793026951;
	b=DMdgMFLNfIVjKu1D68qUO2JkjVP5Ma58ZgYM+FD4r0m/cnFsf9Wl0VQGCZ4c0bXh8ulD
	 JlhZUajS5uMx7n4VSK4qi9WxAeGegQu3g+vgmVcIVhJKqP68A6KLXgLH+iypBzxLTfXFt
	 LoziIRnTdneR2eQ9ILH2bMqIH6icyObSjWa+U0WJ9wdw71IPNrEP+fYnPmpVY843I8bcU
	 qjwf/J3p/cP9PrvNlB27AF1rCnOYS2VZLd0ObAL4/UAMax0X8rkRVxXjY+gklJDKnjkjg
	 iNFHN+YDi3NYd6tDka4b2Y2eeYy7ZaP4kmjarcAyrjdXrNxqVwdxlxzab9lcMd+duFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793026951;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=51fg6U2SlDMs9QfFDrf96+937Pgq73X2qQwa/pimzEc=;
	b=nU8ovnjP4q0gSl1UPTKF18FBk3S/5OCPR1Ot5wyRDjI/UEobN4t3VShS3wtGB4tQ0VK2
	 mF07x+rrpoq1Drg1QSfoF6ABgVCYatn25MXjY68axvGarz2Rq3cnHQgKNybWGUEVYFf78
	 mhqGJVB78w9TVPAdMEo91ZWp4l3y/mwFcnQQ8BwZEUMR8IbeiXPPpogSRhnyuvfR5eo6u
	 iPW2Sj73M+G3GsFYMFFBkaohtfD2Zq6LcyOUAc+IAMhj8G7hS92TT2rcn5UleoiG2Ox2n
	 NhPSLRMgqThN/oB3dNoaLxC6B+zXpspxUotSjLRLr1NTsCP/EO+5mA+1YIiLwz9vCDQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a7Y38MES;
	arc=none smtp.remote-ip=209.85.215.179
Received: from mail-pg1-f179.google.com (mail-pg1-f179.google.com [209.85.215.179])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0613F606A31A
	for <stable@vger.kernel.org>; Mon, 26 Oct 2026 15:02:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0613F606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=a7Y38MES
Received: by mail-pg1-f179.google.com with SMTP id 41be03b00d2f7-cd60c5da24cso1697538a12.0
        for <stable@vger.kernel.org>; Mon, 26 Oct 2026 08:02:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1793026950; x=1793631750; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=51fg6U2SlDMs9QfFDrf96+937Pgq73X2qQwa/pimzEc=;
        b=a7Y38MESxaFz9zz+OhoTXHcNBnMEsXW/d8HmxlsY/TYv3QatH2P9z2JcbzAESHbGfa
         h0VQeH7K0Fw1qZA0kADkhswOPByAmbkUiIZoIREByqpbhswdpIdh0yQOYDWU/9sxwqaP
         xze0IlbWpGq7PRDe2Ti44/QdgQZEWFF9u7WNuGNtHDty28mp0vD6kd7J5nT7tIRBwf6V
         CWpAbaDrSxcAcnCOt/v1m/Xsqig0+8xgESwYe1vpyg7DYkYaO6LYvK9XVW62SJ2zxA0u
         DqxGHiMLzTo/UMneEIkwJk3hp+K2gUrzYqUD5VRiVO/FkF1+bw/FIX4bxGp4QcSB56Mo
         3LmQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793026950; x=1793631750;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=51fg6U2SlDMs9QfFDrf96+937Pgq73X2qQwa/pimzEc=;
        b=key9fII6fTmKwW39YD5h9Yj+BNySr879xL6sl4W/lIVtq2X1Q8GofOC6kGm0c2YdvD
         RsWTSToqLsrlENdbySBfAfZ7s9rsb8laLTlKk9BvQdM6byNtyywB7C0pTOaGEyetLV2Q
         gZliJGWwNOKZNlyGH4OzYgUFqfjIrhVqCT4UOQxf7qUi4Xgyh9Aw8B9PGKRFTM/nmnTK
         vC2R3OdrFBtDz3dH0NoMMnSQ5R7KRCT2G2ZqXhe8y/BMl8PtXuIfuC0u5kBGG54mzbut
         Vh2xnXbs/XNROHN/JEH/4VCpQPfaJRTXfYPjsYSWgRjI0awecU/bFTFWT9KVVbZDCEsG
         8phg==
X-Forwarded-Encrypted: i=1; AKwUvBxLN2HE9JzUiW9NlQhyQwOj1VpC0GlLr6aqSznIvqQj90dKnJQOU8chS5l8Xg8hp2qt+dLcYio=@vger.kernel.org
X-Gm-Message-State: AFq9FYIjheZG28F881oYZyPZX72N1YstcmmqQa+vgUhOYh+Cl46Ax0R4
	SNE5WJ6cwbjFG3ig9onId102CfAgqoiEUR3vvpEkqzVokyQQilReZOk0
X-Gm-Gg: AYBFou1OM9P15iYCPUn2sUCgcjkIiDLp00Bx6FOxOxvZcKdt41SaA7wDuOK0dLNPRmJ
	jw8QKGhwZftrQV5UcHRKCyNMVpcehZV0V/MtbNB1RL9t8FgjBX1V+FwMWHcts16yeZEazRFXMwk
	MFBfchXrEEgoID+P8Bh0DENU0CcUGUa6o89zYx+jaLeGlelHYLKYYu+IsyO+7PqW78YLDtKKevc
	BXVLkhJ3PKmgicF6odeUMooZX4tsHwde1KB9Cu3+7bUoC71adApx8HQsi7IQwdYHzEmvhGUOcF1
	tKHMAS+kwXclQvOmWMKRn+r3OlB7CXFbYIY9dmfAbjiLQ2ByWQt57mXo/y0Cv3Ib5hriATiwx3P
	3cAb7JgBis8d/5vtmveg246DUMNCGznwLqsP/cGzeWl6RmHTdqpJuJSkSwdMMy1uV7I7hW1w3Kt
	rmg29qtMyqMQ3lVspbaGSYb4R0LZtABOQBRsh26xz1HcxeQ2ab0b+nCXWrLhKfIZgrocf6NugZB
	KLPFNtN649w6oJV+p0IUb57orkaWxarz/i6eTINxNuS1JWNQ+w=
X-Received: by 2002:a05:6a20:db8e:b0:3dd:85a9:55ab with SMTP id adf61e73a8af0-3e7cd52c0a5mr6393833637.36.1793026950156;
        Mon, 26 Oct 2026 08:02:30 -0700 (PDT)
Received: from localhost ([111.228.63.84])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36acadf0dsm1461671b3a.13.2026.10.26.08.02.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Oct 2026 08:02:28 -0700 (PDT)
From: Cen Zhang <zzzccc427@gmail.com>
To: mark@fasheh.com,
	jlbec@evilplan.org,
	joseph.qi@linux.alibaba.com
Cc: heming.zhao@suse.com,
	ocfs2-devel@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	baijiaju1990@gmail.com,
	jjzuming@gmail.com,
	zzzccc427@gmail.com
Subject: [PATCH] ocfs2: keep locking_state within the cluster connection lifetime
Date: Mon, 26 Oct 2026 23:02:21 +0800
Message-Id: <pm-ocfs2-objects-candidate-0011-v6-14cf2458f4fc90780f76@gmail.com>
X-Mailer: git-send-email 2.34.1
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

The locking_state reader calls ocfs2_dlm_lvb() through the selected
cluster stack. Its debug-object reference keeps the tracking list alive,
but does not keep that stack selected without a cluster connection.

DLM initialization publishes the file before establishing its connection.
On later mount failure, ocfs2_mount_volume() also disconnects before
ocfs2_fill_super() removes the debugfs subtree:

  Mount error unwind                  Debugfs reader
  ------------------                  --------------
  ocfs2_mount_volume(): out_dlm
    disconnect last cluster
      clear active_stack
                                      read locking_state
                                        ocfs2_dlm_seq_show()
                                          ocfs2_dlm_lvb()
                                            dereference active_stack
  fill_super(): out_debugfs
    remove debugfs subtree

Publish the debug files only after the connection and mount lock resources
are initialized. Failed DLM initialization then has no debug reference to
drop. Remove locking_state in the mount error path before disconnecting,
while its parent directory is still present. Keep normal unmount subtree
removal separate; it can already run before DLM shutdown, so looking up a
child from the common DLM shutdown helper would use a removed parent.

KASAN report as below:

    Oops: general protection fault, probably for non-canonical address 0xdffffc0000000001: 0000 [#1] SMP KASAN NOPTI
    KASAN: null-ptr-deref in range [0x0000000000000008-0x000000000000000f]
    CPU: 0 UID: 0 PID: 557 Comm: python3 Not tainted 7.3.0-rc4-next-20260921-pmb-ocfs2-functional-v1+ #1 PREEMPT(lazy) 
    Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
    RIP: 0010:ocfs2_dlm_lvb+0x38/0xf0
    Code: 89 fb e8 9b c5 b3 fe eb 5a e8 94 c5 b3 fe 48 8b 2d 8d e8 be 09 48 b8 00 00 00 00 00 fc ff df 48 8d 7d 08 48 89 fa 48 c1 ea 03 <80> 3c 02 00 0f 85 9d 00 00 00 48 b8 00 00 00 00 00 fc ff df 48 8b
    RSP: 0018:ffff88810b12fa80 EFLAGS: 00010212
    RAX: dffffc0000000000 RBX: ffff888116aca2c0 RCX: ffffffff82d2c4ec
    RDX: 0000000000000001 RSI: 0000000000000000 RDI: 0000000000000008
    RBP: 0000000000000000 R08: 0000000000000001 R09: 0000000000000001
    R10: ffffffff8965795f R11: 0000000000000001 R12: 0000000000000000
    R13: ffff888116aca3a8 R14: 0000000000000000 R15: ffff888116aca200
    FS:  00007f7bfa66e780(0000) GS:ffff8881fd4da000(0000) knlGS:0000000000000000
    CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
    CR2: 0000000000494c6d CR3: 0000000106c8a005 CR4: 0000000000770ef0
    PKRU: 55555554
    Call Trace:
     <TASK>
     ocfs2_dlm_seq_show+0x36a/0xb70
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? _raw_spin_unlock+0x23/0x40
     seq_read_iter+0x480/0x1110
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? lock_release+0xc8/0x290
     ? srso_alias_return_thunk+0x5/0xfbef5
     seq_read+0x362/0x5a0
     ? __pfx_seq_read+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? _copy_to_user+0x7b/0x90
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? selinux_file_permission+0x11d/0x540
     full_proxy_read+0x11f/0x180
     ? __pfx_full_proxy_read+0x10/0x10
     vfs_read+0x1a0/0xc20
     ? __pfx_vfs_read+0x10/0x10
     ? srso_alias_return_thunk+0x5/0xfbef5
     ? __do_sys_newfstat+0xa6/0x100
     ? __pfx___mutex_unlock_slowpath+0x10/0x10
     ? __pfx___do_sys_newfstat+0x10/0x10
     ksys_read+0x111/0x200
     ? __pfx_ksys_read+0x10/0x10
     ? full_proxy_llseek+0x11e/0x170
     do_syscall_64+0x114/0x620
     entry_SYSCALL_64_after_hwframe+0x77/0x7f
    RIP: 0033:0x7f7bfa702687
    Code: 48 89 fa 4c 89 df e8 58 b3 00 00 8b 93 08 03 00 00 59 5e 48 83 f8 fc 74 1a 5b c3 0f 1f 84 00 00 00 00 00 48 8b 44 24 10 0f 05 <5b> c3 0f 1f 80 00 00 00 00 83 e2 39 83 fa 08 75 de e8 23 ff ff ff
    RSP: 002b:00007ffc0334de10 EFLAGS: 00000202 ORIG_RAX: 0000000000000000
    RAX: ffffffffffffffda RBX: 00007f7bfa66e780 RCX: 00007f7bfa702687
    RDX: 0000000000002000 RSI: 000000002b8dc700 RDI: 0000000000000003
    RBP: 0000000000000000 R08: 0000000000000000 R09: 0000000000000000
    R10: 0000000000000000 R11: 0000000000000202 R12: 00007f7bfa66e700
    R13: 0000000000002000 R14: 00007f7bfa388500 R15: 0000000000a55b98
     </TASK>
    Modules linked in:
    ---[ end trace 0000000000000000 ]---

Fixes: 286eaa95c5c5 ("ocfs2: Break out stackglue into modules.")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Cen Zhang <zzzccc427@gmail.com>

---
 fs/ocfs2/dlmglue.c | 5 ++---
 fs/ocfs2/super.c   | 2 ++
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/fs/ocfs2/dlmglue.c b/fs/ocfs2/dlmglue.c
index 88d946466083..3660da6e4e24 100644
--- a/fs/ocfs2/dlmglue.c
+++ b/fs/ocfs2/dlmglue.c
@@ -3370,8 +3370,6 @@ int ocfs2_dlm_init(struct ocfs2_super *osb)
 		goto local;
 	}
 
-	ocfs2_dlm_init_debug(osb);
-
 	/* launch downconvert thread */
 	osb->dc_task = kthread_run(ocfs2_downconvert_thread, osb, "ocfs2dc-%s",
 			osb->uuid_str);
@@ -3411,9 +3409,10 @@ local:
 	ocfs2_orphan_scan_lock_res_init(&osb->osb_orphan_scan.os_lockres, osb);
 
 	osb->cconn = conn;
+	if (conn)
+		ocfs2_dlm_init_debug(osb);
 bail:
 	if (status < 0) {
-		ocfs2_dlm_shutdown_debug(osb);
 		if (osb->dc_task)
 			kthread_stop(osb->dc_task);
 	}
diff --git a/fs/ocfs2/super.c b/fs/ocfs2/super.c
index 0af2245ae303..fef666a3a8d3 100644
--- a/fs/ocfs2/super.c
+++ b/fs/ocfs2/super.c
@@ -1795,6 +1795,8 @@ out_system_inodes:
 out_super_lock:
 	ocfs2_super_unlock(osb, 1);
 out_dlm:
+	/* Drain readers before the mount-error path releases the stack. */
+	debugfs_lookup_and_remove("locking_state", osb->osb_debug_root);
 	ocfs2_dlm_shutdown(osb, 0);
 out:
 	return status;
-- 
2.43.0

