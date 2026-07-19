Received: from mail-yx1-f54.google.com (mail-yx1-f54.google.com [74.125.224.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7400E3AB292
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 15:58:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.224.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784476732; cv=none; b=CII/75UeZV2Tly9omqnsQh7yraN1lVlsZz9GT3pdYYyO6pIEUF3qso3igK4EtCxpv47gXdvKoPM18Sag3mhGtzJZXA6/yT4YMjaqPG6mBnO6fPTWMIEnHsUdKAoQbZIgrlRqs9A+eC/JzasBCw3UY/4a+And385qRxjREEfAxQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784476732; c=relaxed/simple;
	bh=2Vp6ZEoGdF2JWiQ5Nva8QA+jE3mhwaAVLPknQBofvd0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pja1nWzpA9lgl0AIf6oUfcO1W32ow617kfqIVjhHybbGQuIvwRDu9lhRU6mM/iXSnHGkAJmNMKZUewaFXxYsSEH7LTOK90iu953g5lbW854sPIERQgDwQi5e3VxXtIjsmDgrnzd4aMgIY0mVmjh3WOh8d9By9ZXUMWsFC+cs1Cc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=IurKo201; arc=none smtp.client-ip=74.125.224.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IurKo201"
Received: by mail-yx1-f54.google.com with SMTP id 956f58d0204a3-664a09bc459so13267693d50.1
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 08:58:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784476728; x=1785081528; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rTXBPoNQjw/poWOMQDZZWXuifJL9LBXIhF26CE3fbu4=;
        b=IurKo201itr+OXdw5oA4cQcQ6F2I523mmx/vo7ki+XeOTtjoJAIx6HoVpTziX7Gv7u
         HU4OSLqs2TRPnTYc3PnV4v4dm9Mdc35iC55QxkqC5ITLervm0lmJ18KUhx6UcwgcImTy
         QsolqcNAJQktY8cw2PFnT7V1nN1ru2OYixUqQ4q1Q65lVbSDL3Dx9xH+L4OPerjv7nWI
         lP8do+p2qZROFPU19TQ/VlBDALRwKdNhMtf92Czz3YsvNCjZsMWOrrGCixAsg7e83lka
         tQwBTp937AouTnLjVS3ypOwWtCv47qd87V3lROC2VJ450pgTWKZlBCGmLFfaH3EYdrZO
         Xp6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784476728; x=1785081528;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=rTXBPoNQjw/poWOMQDZZWXuifJL9LBXIhF26CE3fbu4=;
        b=eMlZAA9drggsTFkhJfatNHQ6j1SWfUlu+AibLymHmn0h3uM7Hva4vtepIE4Gx8ywnp
         ZRpgAi4CE+IM09S6dBj6nZmETUwe2k2bQ3e/Q2wVJQ9ZGm5fX9DHfGcGXwGT1Mjcpni4
         idp6frsKkudmuBuJFJqyaToli7zrONwIZ6RuBUqcOYR73rhq3XJyVB6p9plYlhe4NaKR
         ZxcR5lYhf7ZkXgrc+d7hd9n3Pf/jaMytknsiMypXLkKolI7R2x8hDBEaLwXYMUOMhMXw
         hK2zqzDhEamtdb2CBXQEfPRLBuOaLSJKuRAUIqc12KT3IVeOolIXrUsjmyCxib4XPQFz
         JTvg==
X-Forwarded-Encrypted: i=1; AHgh+RqgCWfdinbgvg65VKDvXZV0+2yyik2DgkgwjrWEVXc2HqDJBRslatzWU7Ql1A8vUICEKjsfSjg=@vger.kernel.org
X-Gm-Message-State: AOJu0YxlHTpyK5f3vWnDENsNhA6Ynhw3L4ojPQyvhRhz1Dlt3sF3nfxn
	FfhImbDyH0Xy5791zPz6EXL7j/hQMU0cPV/kgd4Gei2U8ttfCubG98OB
X-Gm-Gg: AfdE7clC4p5InvxsL72yP6Gky81027dkGh44pBi/FX/psnBMVCgS75hoG1h86s2UWnn
	SpRXaXHJvAiENAs+ZuIJa8uUZxhmtRxALkxLSZGgJcsKsAwALz/oKiZ07YbyINz6+g9RciZnC/L
	Q/9QAAI2HdD0cHHBlSrk8sMCsOQI3uDw8E7R8cadIxNIt2vDPJSthe/4tP/CGbQ3jl+C9ZxOmgx
	4rIWG/81j+diuZszEIX2qL+7dqSq2NARZhk+Tah9jYsNLc5rSjGbV693mosvHihNBOqhM2ScQMT
	16c9e3rv1jLZvR4bRuWaaFU6kF5L/WBqHdad0LEbo5xFhjoReGXNLG40xN8m2Ubyz2/0l9uo6EI
	c5znULVW5WWimKfTyyhmnGCbb0OcWAY0pqp49dskMBln1bXx7bc52SD/2sPgw717DdJy8yVTLaY
	hLCdQWYTkGzW8HLgvneAaLBx+nAULTnOczLQY+fJxPRN2tNFojkr+aSZBAq47bAhLHFDUHEwEU7
	XD2REt21vZMQQ==
X-Received: by 2002:a53:c14e:0:b0:667:db13:bdc1 with SMTP id 956f58d0204a3-6683bbddf95mr2154590d50.9.1784476728324;
        Sun, 19 Jul 2026 08:58:48 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.f7a5e5c3-cab1-4810-bdbb-207cdd06de9e.globalsecureaccess.local ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 956f58d0204a3-6683b8cd3aasm4761234d50.21.2026.07.19.08.58.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jul 2026 08:58:47 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: brauner@kernel.org
Cc: oleg@redhat.com,
	akpm@linux-foundation.org,
	jack@suse.cz,
	avagin@gmail.com,
	ptikhomirov@virtuozzo.com,
	mjguzik@gmail.com,
	include@grrlz.net,
	ebiederm@xmission.com,
	legion@kernel.org,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v3 2/2] pid: fix cad_pid use-after-free race
Date: Sun, 19 Jul 2026 11:58:42 -0400
Message-ID: <20260719155842.7069-2-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260719155842.7069-1-blbllhy@gmail.com>
References: <20260719155842.7069-1-blbllhy@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

proc_do_cad_pid() reads the global cad_pid pointer and passes it to
pid_vnr() without protecting the lifetime of the referenced struct pid.
A concurrent writer can replace cad_pid and drop the final reference to
the old struct pid after the reader has loaded the pointer but before
pid_vnr() has finished dereferencing it, causing a use-after-free.

The sysctl is mode 0600, but access is checked against the owning user
namespace, so an unprivileged user can reach it via userns, pidns, and a
proc mount.

Fix this by treating cad_pid as an RCU-protected pointer at both read
sites and by waiting for a grace period before dropping the old reference
on the write side.

KASAN crash stack:
  kernel/pid.c:545 pid_nr_ns()        # reads freed pid->level
  kernel/pid.c:556 pid_vnr()
  kernel/pid.c:775 proc_do_cad_pid()
  fs/proc/proc_sysctl.c proc_sys_call_handler()
  fs/read_write.c vfs_read()
  fs/read_write.c __x64_sys_pread64()

Fixes: 9ec52099e4b8 ("[PATCH] replace cad_pid by a struct pid")
Reported-by: AutonomousCodeSecurity@microsoft.com
Closes: https://lore.kernel.org/all/20260717210143.4734-1-blbllhy@gmail.com/
Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Reviewed-by: Bradley Morgan <include@grrlz.net>
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v3:
  - Keep kill_cad_pid() inside the RCU read-side critical section
    instead of taking a pid reference, as suggested by Oleg.

v2:
  - Split out kill_cad_pid() deinline into a preparatory patch.
  - Annotate cad_pid as __rcu and use rcu_dereference().
  - Protect kill_cad_pid() by taking a pid reference under RCU.
  - Add a comment explaining why synchronize_rcu() is used instead of
    call_rcu().

 include/linux/sched.h |  2 +-
 init/main.c           |  2 +-
 kernel/pid.c          | 22 +++++++++++++++++++---
 kernel/reboot.c       |  2 +-
 4 files changed, 22 insertions(+), 6 deletions(-)

diff --git a/include/linux/sched.h b/include/linux/sched.h
index 373bcc0598d1..31ce72b1233c 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -1767,7 +1767,7 @@ static inline bool is_lazy_mmu_mode_active(void)
 }
 #endif
 
-extern struct pid *cad_pid;
+extern struct pid __rcu *cad_pid;
 
 /*
  * Per process flags
diff --git a/init/main.c b/init/main.c
index e363232b428b..19a10d0c2760 100644
--- a/init/main.c
+++ b/init/main.c
@@ -1636,7 +1636,7 @@ static noinline void __init kernel_init_freeable(void)
 	 */
 	set_mems_allowed(node_states[N_MEMORY]);
 
-	cad_pid = get_pid(task_pid(current));
+	rcu_assign_pointer(cad_pid, get_pid(task_pid(current)));
 
 	smp_prepare_cpus(setup_max_cpus);
 
diff --git a/kernel/pid.c b/kernel/pid.c
index 234ebee29375..fb7c0d18efa9 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -559,7 +559,13 @@ EXPORT_SYMBOL_GPL(pid_vnr);
 
 int kill_cad_pid(int sig, int priv)
 {
-	return kill_pid(cad_pid, sig, priv);
+	int ret;
+
+	rcu_read_lock();
+	ret = kill_pid(rcu_dereference(cad_pid), sig, priv);
+	rcu_read_unlock();
+
+	return ret;
 }
 
 pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
@@ -773,11 +779,15 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
 		size_t *lenp, loff_t *ppos)
 {
 	struct pid *new_pid;
+	struct pid *old_pid;
 	pid_t tmp_pid;
 	int r;
 	struct ctl_table tmp_table = *table;
 
-	tmp_pid = pid_vnr(cad_pid);
+	rcu_read_lock();
+	tmp_pid = pid_vnr(rcu_dereference(cad_pid));
+	rcu_read_unlock();
+
 	tmp_table.data = &tmp_pid;
 
 	r = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
@@ -788,7 +798,13 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
 	if (!new_pid)
 		return -ESRCH;
 
-	put_pid(xchg(&cad_pid, new_pid));
+	old_pid = unrcu_pointer(xchg(&cad_pid, RCU_INITIALIZER(new_pid)));
+	/*
+	 * Wait for cad_pid readers before put_pid().  We cannot use
+	 * call_rcu() here because free_pid() already owns pid->rcu.
+	 */
+	synchronize_rcu();
+	put_pid(old_pid);
 	return 0;
 }
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index 695c33e75efd..fc191a48c0e9 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -24,7 +24,7 @@
  */
 
 static int C_A_D = 1;
-struct pid *cad_pid;
+struct pid __rcu *cad_pid;
 EXPORT_SYMBOL(cad_pid);
 
 #if defined(CONFIG_ARM)
-- 
2.53.0

