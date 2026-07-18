Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BBC822D249E
	for <stable@vger.kernel.org>; Sat, 18 Jul 2026 03:20:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784344812; cv=none; b=GT498YmArLnQ7T/dVDMGA47FGD6amPGnA4dUVMM3tp3qYLItG8akBHoZqobOyiYgeJiPyYdYx7oItWVeFERnNFxmcSdpDFr/CEsWunzzQlOALVJKRpz7jNo0oL7CHB+fJ5NaK75IMA2O6zbX4kx66Cvsq/DAHstKZ5cx5NrC0KA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784344812; c=relaxed/simple;
	bh=nBTVj0RxpmOcH0opGkiRkbiAwqNT/Y/M7FSP+RwVFSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Kdr7ANWAzqu4gx47avaeLr9iEb6CvlPOmiDHZcbBCIhBP2wASJSR4Eso408H4T2DHJHazJfct8sby//pNU5YUvOyk6spxGOIsaAY/BzQR8+AW5mnno+t63FkODUPYUxoRt4m2yrvylEWEPeyEqB5fn8G3rN0YYWhiRGVqn16Lig=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=NdGdASgB; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NdGdASgB"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-38dc69c74b8so6428530a91.0
        for <stable@vger.kernel.org>; Fri, 17 Jul 2026 20:20:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784344810; x=1784949610; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=j2TgCfh9RuuAPFagx/C6kXcDd5mt/kzQZXfzmhuGkxg=;
        b=NdGdASgBhZJI4xofjFwP8gWB8K5dbKbztk4nu5Iz4y4S4BsDJwrIVPFrI8OmO9WKWU
         rvFJMAVF/7S3sOrq51U5Jdfg+Sz9htJkBfwbAMLs+p8MGiNs1YqiFVyonzfdXxubHkMS
         t8sDw7V/iD3vlu0JZjyW9RRoaZlW+4Z1h6TPWT+Jj+2idNgrjmr9eHNpnskxsYaoErQw
         IzVL+dKOaLl90RVDWvbWvHslKyGLmKzzUv4g8LWIOIu8lExpr8SCyfqjYPWf2NoFLWkt
         wh7rTU7oB4VytHvpwtWnITb6FhuTQVTH5L1Wsg+HrPFBSEmNprkSVxdjL6TIlyCYRnsk
         0J8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784344810; x=1784949610;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=j2TgCfh9RuuAPFagx/C6kXcDd5mt/kzQZXfzmhuGkxg=;
        b=alYMd+QaBccHSEgPTOvmzEvto1AwRygR6e8CGiX6UfKH27zAy5bgzTH/goEUpddPVS
         rrEAw4rfqPpgxNTQy8g7RQfkJL7GxXtrkdJBWtmwM3WdAYmKdP/QopFWleMxAZEEN2Ww
         co7D5VRTPlAOOdD713dmhH28t9mN/ytsGRYI393qw+p1li8EGAB85vkBa3EDIjvkGtm9
         jOo4HIwKWLNNaPcasU3pMfvRRugaTVaaLYl74mP4Iip04ul8V5STZ81g5oV5u42rLTao
         td9qoK1Q6UhKlDqaOzLFOwiwJCEIg9m94UXKibBgY+nhwUP4kxAQCybK2DRrXopFgr3d
         O5jQ==
X-Forwarded-Encrypted: i=1; AHgh+RogouBLbRGYcRbvl1U3INRk1vOrTkyi3dIYR2spnoIXtNg8mDSyDgZglO0VPcFULZXVk6FumK8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyrHKU1h3/B1JDBHRfQzVc578WUZqqlXDbtP3qO69d9x39bJL6h
	rzJz+Pzz33zLMPMXk5mitT16JzBoqnM5qoE1SXPl2JNezGVNP9WkE7W8
X-Gm-Gg: AfdE7clSyaikbv/KyJxzaht/OwNheJyw3b5IveqwqQm2S4CkSP0qZTAzE9DtP6C8/VS
	rug9jMY33DURiY1ZzvToHzsyGNATBUcwmI6mRLlD8YUvtCOrwrCNpKi8qoGv6zmyn8z4BLcZWBF
	Cvo9OrHRGvxvo/SmyS/FHxa1dmI8udk1/RLM/1lzD8+u5JSR3GOqsHZrqPkxhMojWiWDyV3/eu1
	KX2SWqNDP218gPW5U4RGSm1D5g7haRl/4Dg0eiLp5kEIjmS/8/4cuhQfZyJX2q0PiL5FvL7K9t5
	f+mnrdXGv5MvC71ByEbCjvW7sPKco5emoyaPRvXOPTKmXbD/JZETBd2gBDdpK6ZoucovBmh8uH/
	x8PkUNglv/2kAwv20slWOCY+ld54YIO/0KMnoTXvmI+0KJdzZuvhvCC67d83OY2XxcIiRPbTNUZ
	hvte8KmYa/gm8VNC/za80=
X-Received: by 2002:a17:90b:224e:b0:37f:9ce0:af36 with SMTP id 98e67ed59e1d1-38e4b5a823bmr5424623a91.33.1784344810035;
        Fri, 17 Jul 2026 20:20:10 -0700 (PDT)
Received: from LAPTOP-83ECOPAB.localdomain ([167.220.148.62])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-38e4afd2dd6sm2035845a91.4.2026.07.17.20.20.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Jul 2026 20:20:09 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: brauner@kernel.org
Cc: oleg@redhat.com,
	akpm@linux-foundation.org,
	jack@suse.cz,
	avagin@gmail.com,
	ptikhomirov@virtuozzo.com,
	mjguzik@gmail.com,
	include@grrlz.net,
	linux-kernel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] pid: fix cad_pid use-after-free race
Date: Fri, 17 Jul 2026 23:20:00 -0400
Message-ID: <20260718032000.9184-2-blbllhy@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260718032000.9184-1-blbllhy@gmail.com>
References: <20260718032000.9184-1-blbllhy@gmail.com>
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
Reviewed-by: Bradley Morgan <include@grrlz.net>
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v2:
  - Split out kill_cad_pid() deinline into a preparatory patch.
  - Annotate cad_pid as __rcu and use rcu_dereference().
  - Protect kill_cad_pid() by taking a pid reference under RCU.
  - Add a comment explaining why synchronize_rcu() is used instead of
    call_rcu().

 include/linux/sched.h |  2 +-
 init/main.c           |  2 +-
 kernel/pid.c          | 26 +++++++++++++++++++++++---
 kernel/reboot.c       |  2 +-
 4 files changed, 26 insertions(+), 6 deletions(-)

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
index 234ebee29375..bffc5f765080 100644
--- a/kernel/pid.c
+++ b/kernel/pid.c
@@ -559,7 +559,17 @@ EXPORT_SYMBOL_GPL(pid_vnr);
 
 int kill_cad_pid(int sig, int priv)
 {
-	return kill_pid(cad_pid, sig, priv);
+	struct pid *pid;
+	int ret;
+
+	rcu_read_lock();
+	pid = get_pid(rcu_dereference(cad_pid));
+	rcu_read_unlock();
+
+	ret = kill_pid(pid, sig, priv);
+	put_pid(pid);
+
+	return ret;
 }
 
 pid_t __task_pid_nr_ns(struct task_struct *task, enum pid_type type,
@@ -773,11 +783,15 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
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
@@ -788,7 +802,13 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
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

