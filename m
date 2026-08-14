Received: from mail-yw1-f173.google.com (mail-yw1-f173.google.com [209.85.128.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 302B4343D72
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 04:09:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786680593; cv=none; b=BzKnGgQImhSJ2IYRMCpSn+bjN7WJhSrjAWooYWTFt9Io3xnTJlrHBn6GR51QYfmxT87Sc8nJQYpfqz9/wdsJOz3E+MQkEOqO9MQUpz7+1dm4ukW791ZlNp0Umt2ftFpLrAgwxyusW/Liwtf5tkdiuj7O/oJnwRaxqzCV+f704dI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786680593; c=relaxed/simple;
	bh=4CdgSOYs2iEn7dzlAYJ0RuY4AhdkRPII76Y3IrpesBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=djS/Zp3ByILXfyQi8NDMGrahHkCBaIzUSXUMfOcf7dDUpre7QfPAZTiuXDlTvQnLuH/DdXbV4Ld7P+asfzX8ZjLXiy5LFqIACnhjDB1R47q/pSkV1XVhLSwJ9CzDvjLYrba+bXobNR6HIo0lr4qI5x7koRtLLuVyufCIAoLTA4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=chTaX+B1; arc=none smtp.client-ip=209.85.128.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="chTaX+B1"
Received: by mail-yw1-f173.google.com with SMTP id 00721157ae682-836c4474028so6671097b3.0
        for <stable@vger.kernel.org>; Thu, 13 Aug 2026 21:09:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786680591; x=1787285391; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p86XR0IwNusJRzPgLE1JQiJp3QEv5rxXdiBVcpat7NU=;
        b=chTaX+B15UTW7p90MKoCsi68G/rxPmdjwGRwlqBA6+JmBzW9+ykqmCu8Bv+SqLxwNB
         /gmT/aRNOoQfkf6AEkPXqfQCFGCJyLW/bzqqetjEH+yZibI3Gx4st7GhD43m8AgMBEzZ
         KisL/WbfTGe87o9HVirwoPwjR/Nd60k8I8HeNcRkdtOlSzpXSUc1+eTJZ9m72OrZo4VH
         ++/JJ5J9+fnIr1q6XzhdonWvA2u9IzYiMWuBWd2Od8vO11yVFRkyUqUj5Ir8F8RAx5F7
         /Lkvc8B1lYGzu3DeiHh7lBcGonf0PiynZPgfmodj/nDV5hsKzrDiAaFLDnBXwBaBrx4I
         D8kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786680591; x=1787285391;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p86XR0IwNusJRzPgLE1JQiJp3QEv5rxXdiBVcpat7NU=;
        b=U1Livu0N5cu5EK+AkGNCpgOWVT3+Yhvc3AEyNehLU6Dj25/tWgMFRUSogLSXDVJDPH
         kxEGPfM1ZDl83bYQSgro4qoqGNquIvjB+HwS65RpRj/JVqZfoNGMm3yv3P5XOsWNDbrS
         5DSsJH8lhWFbmDdN8nGf43SU3Tz9SU0O0cCP01HrqDEgoeMoakMJTzG9+7xz6cFyGEAp
         WbxMZQXLi3lOoNN+A5u8aLS1HlYex4vESdzjuScU1LK+UWJr0rx+InxHIcsyWxFL/Bhr
         zEyc+EmlJpD0aa1YzHiLnrmKnRWLQx2bSRhAM/R0LnRc3Ee2YahXg3h1fXxQ737mAYYX
         jI1g==
X-Forwarded-Encrypted: i=1; AHgh+RryJi21ZR2c/tT2OFEhEd+eCV91tsP0gLW55tFWZe0nWJtuFfAVbfhxdgteZX10PWMaWbpu+jo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyoYymymPh1kTHqVUzlw6+htlghoR/IdRFgZgSvu8q8tmYXLgV/
	2odFXIHPuTFcBkWIOyhBD0zRMVyAlE5ALp9ef0vymDt5cPJ2bHNwOWZz
X-Gm-Gg: AR+sD12OIDm9yBbKkA6Ey2exfY8Z/KjrodGTaZSZhGB/YO8vJfp0Rk/sqHmeHENO0zP
	I4YFI0dSwpw87gdPue7i/GrDwPQjy6a4BJpijhvo0j93uCAixE4isQTOtpfPxq+9mnsQkyxoaX1
	fYEFL2tMpA7JV7RfLFNaEmm+4nlo4lpDGHLU8xabpJTPV4w10O9KRE/fhVroKY1tGWNh3muFbFR
	fCDdDxA7vk0ECkkbaEhRoCmYHmU2GanoaHBbG7xL6ptNJ0OLFqKe/YS1jrA2xXnOK6fGFbYkN5n
	U+sy5j/9ucPTdy0PFSI7l3NdAE3sphzmaLtir5FI9zPB/LltqS/n6AXRfZUUHT6fTS28InAupVT
	7Sk+R4pU6iKqWbTNVJ/Kw9qdwvaGMRhKwpv/T8416b0JIzXjpGLxaX3bpWgWg+tfzdHlKb+sAF0
	/Pk5GOgKCOGw63ifjG6CiQAauBS24dTqZRtP1NTfO5++nkU0OwGGSVOoYadZrAvp/D1iEMrZPAx
	sNXyQ==
X-Received: by 2002:a05:690c:7487:b0:7e9:9f7e:9e0 with SMTP id 00721157ae682-8370c93d30fmr15168547b3.3.1786680591049;
        Thu, 13 Aug 2026 21:09:51 -0700 (PDT)
Received: from mac.lan ([136.55.173.105])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-836c290820csm8156627b3.40.2026.08.13.21.09.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Aug 2026 21:09:50 -0700 (PDT)
From: "Cen Zhang (Microsoft)" <blbllhy@gmail.com>
To: joel.granados@kernel.org,
	kees@kernel.org
Cc: brauner@kernel.org,
	oleg@redhat.com,
	mingo@redhat.com,
	peterz@infradead.org,
	akpm@linux-foundation.org,
	jack@suse.cz,
	avagin@gmail.com,
	ptikhomirov@virtuozzo.com,
	mjguzik@gmail.com,
	include@grrlz.net,
	ebiederm@xmission.com,
	legion@kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fsdevel@vger.kernel.org,
	AutonomousCodeSecurity@microsoft.com,
	tgopinath@linux.microsoft.com,
	kys@microsoft.com,
	blbllhy@gmail.com,
	stable@vger.kernel.org
Subject: [PATCH v4] reboot: fix cad_pid use-after-free race
Date: Fri, 14 Aug 2026 00:09:44 -0400
Message-ID: <20260814040944.16561-1-blbllhy@gmail.com>
X-Mailer: git-send-email 2.52.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

cad_pid is a single kernel-wide struct pid pointer. proc_do_cad_pid()
reads it and passes it to pid_vnr() without protecting the lifetime of
the referenced struct pid. A concurrent writer can replace cad_pid and
drop the final reference to the old struct pid after the reader has
loaded the pointer but before pid_vnr() has finished dereferencing it,
causing a use-after-free.

kill_cad_pid() has the same lifetime race when it passes cad_pid to
kill_pid().

At the time this issue was reported, an unprivileged user could reach the
sysctl through user and PID namespaces because cad_pid was registered in
pid_table[]. Moving cad_pid back to the global reboot sysctl table
corrected that namespace and permission mismatch, but did not fix the
underlying lifetime race.

Fix this by treating cad_pid as an RCU-protected pointer at both read
sites and by waiting for a grace period before dropping the old reference
on the write side.

call_rcu(&old_pid->rcu, ...) cannot be used here because free_pid()
also queues pid->rcu; queueing the same rcu_head twice can corrupt the
RCU callback list.

Original KASAN crash stack:
  kernel/pid.c:545 pid_nr_ns()        # reads freed pid->level
  kernel/pid.c:556 pid_vnr()          # calls pid_nr_ns()
  kernel/pid.c:775 proc_do_cad_pid()  # calls pid_vnr(cad_pid)

Fixes: 9ec52099e4b8 ("[PATCH] replace cad_pid by a struct pid")
Reported-by: AutonomousCodeSecurity@microsoft.com
Closes: https://lore.kernel.org/all/20260717210143.4734-1-blbllhy@gmail.com/
Link: https://lore.kernel.org/all/alz5ZYLE4kaq_v2P@redhat.com/
Link: https://lore.kernel.org/all/al4ICz9biJKtdZc4@redhat.com/
Suggested-by: Mateusz Guzik <mjguzik@gmail.com>
Suggested-by: Bradley Morgan <include@grrlz.net>
Suggested-by: Oleg Nesterov <oleg@redhat.com>
Suggested-by: Eric W. Biederman <ebiederm@xmission.com>
Suggested-by: Pavel Tikhomirov <ptikhomirov@virtuozzo.com>
Cc: stable@vger.kernel.org
Signed-off-by: Cen Zhang (Microsoft) <blbllhy@gmail.com>
---
v4:
 - Rebase on sysctl-next after Oleg's cad_pid sysctl placement change.
 - Fold the two-patch v3 series into a single lifetime fix.
 - Move kill_cad_pid() implementation to kernel/signal.c.
 - Export kill_cad_pid() and stop exporting the raw cad_pid pointer.
 - Update proc_do_cad_pid() in kernel/reboot.c.
 - Add explicit includes for the RCU API and kill_cad_pid().
 - Preserve the original unprivileged impact context while noting that
   the namespace permission path has been fixed separately.

v3:
 - Keep kill_cad_pid() inside the RCU read-side critical section
   instead of taking a pid reference, as suggested by Oleg.

v2:
 - Split out kill_cad_pid() deinline into a preparatory patch.
 - Annotate cad_pid as __rcu and use rcu_dereference().
 - Protect kill_cad_pid() by taking a pid reference under RCU.
 - Add a comment explaining why synchronize_rcu() is used instead of
   call_rcu().

 include/linux/sched.h        |  2 +-
 include/linux/sched/signal.h |  5 +----
 init/main.c                  |  2 +-
 kernel/reboot.c              | 19 +++++++++++++++----
 kernel/signal.c              | 12 ++++++++++++
 5 files changed, 30 insertions(+), 10 deletions(-)

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
diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
index 584ae88b435e..d45a5476b97d 100644
--- a/include/linux/sched/signal.h
+++ b/include/linux/sched/signal.h
@@ -562,10 +562,7 @@ static inline sigset_t *sigmask_to_save(void)
 	return res;
 }
 
-static inline int kill_cad_pid(int sig, int priv)
-{
-	return kill_pid(cad_pid, sig, priv);
-}
+int kill_cad_pid(int sig, int priv);
 
 /* These can be the second arg to send_sig_info/send_group_sig_info.  */
 #define SEND_SIG_NOINFO ((struct kernel_siginfo *) 0)
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
 
diff --git a/kernel/reboot.c b/kernel/reboot.c
index f070c5c1103a..d177d89fcc33 100644
--- a/kernel/reboot.c
+++ b/kernel/reboot.c
@@ -13,7 +13,9 @@
 #include <linux/kexec.h>
 #include <linux/kmod.h>
 #include <linux/kmsg_dump.h>
+#include <linux/rcupdate.h>
 #include <linux/reboot.h>
+#include <linux/sched/signal.h>
 #include <linux/suspend.h>
 #include <linux/syscalls.h>
 #include <linux/syscore_ops.h>
@@ -24,8 +26,7 @@
  */
 
 static int C_A_D = 1;
-struct pid *cad_pid;
-EXPORT_SYMBOL(cad_pid);
+struct pid __rcu *cad_pid;
 
 #if defined(CONFIG_ARM)
 #define DEFAULT_REBOOT_MODE		= REBOOT_HARD
@@ -1371,10 +1372,14 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
 {
 	struct ctl_table tmp_table = *table;
 	struct pid *new_pid;
+	struct pid *old_pid;
 	pid_t tmp_pid;
 	int r;
 
-	tmp_pid = pid_vnr(cad_pid);
+	rcu_read_lock();
+	tmp_pid = pid_vnr(rcu_dereference(cad_pid));
+	rcu_read_unlock();
+
 	tmp_table.data = &tmp_pid;
 
 	r = proc_dointvec(&tmp_table, write, buffer, lenp, ppos);
@@ -1385,7 +1390,13 @@ static int proc_do_cad_pid(const struct ctl_table *table, int write, void *buffe
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
 
diff --git a/kernel/signal.c b/kernel/signal.c
index 9c2b32c4d755..464732c44554 100644
--- a/kernel/signal.c
+++ b/kernel/signal.c
@@ -1891,6 +1891,18 @@ int kill_pid(struct pid *pid, int sig, int priv)
 }
 EXPORT_SYMBOL(kill_pid);
 
+int kill_cad_pid(int sig, int priv)
+{
+	int ret;
+
+	rcu_read_lock();
+	ret = kill_pid(rcu_dereference(cad_pid), sig, priv);
+	rcu_read_unlock();
+
+	return ret;
+}
+EXPORT_SYMBOL(kill_cad_pid);
+
 #ifdef CONFIG_POSIX_TIMERS
 /*
  * These functions handle POSIX timer signals. POSIX timers use

base-commit: 8d75c338f0bcecaa6c9af67f86c176b67b6acf3e
-- 
2.43.0

