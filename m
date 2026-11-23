Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.227.133
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795421642;
	b=i2tnnT9gxQx4bavhwHv7tTq8Abo5to+ZaxaGkIEdypJKNMOEJK7u4HWLSgusfoVXVYH2
	 P/vlTtCBGzpcTvGctAR6YBYKucewUE/bmLeHBh+u9DlyzV9q1X4gnER6A3bC5dP2txuXD
	 tiahFezYyZ0T0nSU80tGpG6XhSQZyWAYYRXVTHeCAJe4KovSAlUTi9pD2OtC//52igLJ8
	 XQUNSBqbBmNiFs/zTgL+c0rgYkMJQVSR3oZ8BYn7w12QNWdJgfFcahPcF+k31FVo6lKp8
	 Q3eUm5eKgLhqhfgMeikGJSnjRryvkJ4ru5kK0vGZ22l4KQreaNz3Y6SMbP5EPRcgRwg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795421642;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9lbGMQbqskhDEKZSTwjg1vaUlLvZgaoFI65yAtcZ0YY=;
	b=K5cclSBeX2q+3ZOVklollJMfXuHbicm1Lh9pGf6PxmLmGTOx97kZbAv2K8fvo/NUxDtN
	 bkWK3gMZrdHwp5J2umTwBKFIVRrw0+8mht8o+ANBLrmmFbNcthUz7A5WoTyN0Po1evvft
	 YC2GhcNbAtkxB+PEb8x0KkAQKwuwSw9bla0IN9NQrz9jRWSP/61adYRmOsGM1yut7eXxU
	 qadEFiXLad03vtlY9ixOVRCZ+aforIPqldtXMMz27Gh7hGHVw9l1mLhh0vBO5Kx8s7oRl
	 EyI2kzU7EsN6g53SnIX+0Ow+Re+sEEunxREyurSrbo310JvvB22ypVbA3PoZd+k8lgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="BjD8Sw/b";
	arc=none smtp.remote-ip=74.125.227.133
Received: from mail-pj2-f5.google.com (mail-pj2-f5.google.com [74.125.227.133])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A60D606A31A
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 08:14:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 4A60D606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=BjD8Sw/b
Received: by mail-pj2-f5.google.com with SMTP id d9443c01a7336-2f04158d3cbso10902185ad.0
        for <stable@vger.kernel.org>; Mon, 23 Nov 2026 00:14:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795421641; x=1796026441; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9lbGMQbqskhDEKZSTwjg1vaUlLvZgaoFI65yAtcZ0YY=;
        b=BjD8Sw/b2rAU/ErTCTCvZIesPsLIQStPziB+D6b2gfzre3ohmjHSB84hfghwxMN+eW
         UdvPN/AZsDZweQyyvTLYeF5LiagL0ZVHtJ18Gt7UEM1BKQRM3DAGIvZlNobRiPRbULIE
         6TXhEmbZ0350cq2jrb/H5SS9WyngMpygfK8PYNgPci9eiEMrIqQ3DCDv11yPbBG2EPpH
         m7pbKfL+iY3K1TkJt0bzlMUjS+iU3ldPIXMKD8Mvju+Y8BjevxDJnA9HPT6VFErxWEup
         BsXaBHkm5qesFFonJczGyjDwMHJy03vWyxgZUQflCnt4wtaevbCDT111yYiKeELHM/IH
         0eRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795421641; x=1796026441;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9lbGMQbqskhDEKZSTwjg1vaUlLvZgaoFI65yAtcZ0YY=;
        b=ERJNvlBo+I0Ggezd49VTUd7KUQcqgWzwhkFPTAigxN1Blk3Wy+dVxGJfi0YiKAuTYm
         EmRMvTmtOhvzQBjzRHf1JgkAR4rDSydPdMukjsmssmJywEEf1KBjQIXM7AYeOCcXNPva
         F1yeNuV44M7dFm4KLIf8cBdBdEVn2ibHtIR7GknFIl/xPOcVd+PKaAb+cHo8sDZgwpgf
         lj2ALYZK/tVitnr0U1tefMSrqRdXD0H0p6Ik6DfpoeInSpCYZhQVM3QoUbFD27b+bg1d
         KsvZCLHkThpkONYy35bgNnduh6uen9FAHdgODRIAMIR76OML/K3oPaSkH20EonVSl1Zn
         f8gw==
X-Forwarded-Encrypted: i=1; AL+hErFBNZ6xiWdy9DI274LQHat16l2m9VhNTFERpYOb4t+hpJ7vPCxXVJCG47KfpT3X/DS6DxhnN9g=@vger.kernel.org
X-Gm-Message-State: APuU4Z/NBNuBB7T30OqLg7Hk3C9tfOOX7NeQB8yR3JuvcVRXQ1+NkEJy
	xUqPOJASLaCAPbzTgs9ht9ugPRDQp4kRLOKpKMxVJJGtwtiJvjQnakGW
X-Gm-Gg: AZFdTZcT/l7z8QUZ9xz5rO3NTgaXsviL8VaoapcP3YigS3fdkyEy9v69Lxv9k4WaE3T
	f5+GSU8kUAS+vQlCdS8LpdImLebVSwpz2sOzePkFA5LU4rApQCN/UQADu/kvmmIQ7KzaGgXZwrb
	QYna8lJn/lkLQRXVKkDSPhYTM60lfHEeAuEBzYtX2k3eHcr/OBKt0Vurz9DRCECcUre4t3DQ8GI
	cIxEeiyGnaRyoRU68tMAJwCiws480p+kFmv12yZB1Z8A6gjeYvTWzvvUETvMOcbhDNWKAcW3bWJ
	4eQYSktAKei16PAXn6Kw/J9CgeYuf7S+Qa6K1XI9+jxgq2rnk8Gv3gXb8U2+vRW7LWeXugsCzKb
	TaR8acBY9LCEod9xQ++4kbB+lPoIAugK4HM6xBe4l3uwwhfaLlVHSxUyS4Sv3sCHOP4MSr9FZWT
	qYjr0QFkgF/JBugFMAnZAjEabI9WTXb5k9Z4efUW4+X6XKfkyUHFADh5doo6LJVDYB+iv9qKMil
	NlkNQTnhLm/Ara8iu2WajHI6hbzFPFUeQzOGZ8aCmjvg50fnS7QhlD+urUR/2ffKXvSIzu0BCpY
	E3TddrZTXv7YjygOqVHIGFSyi4ecc+rHqS1Cs+cdTbFRUp3WtzXxkWTgOOCD+OYTS+QxG6BrLqQ
	=
X-Received: by 2002:a17:903:b4b:b0:2e5:4604:c375 with SMTP id d9443c01a7336-2f03f1b6f40mr103618765ad.48.1795421640608;
        Mon, 23 Nov 2026 00:14:00 -0800 (PST)
Received: from BSDHENRYMA-PC1.localdomain ([43.132.141.13])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2f07d6d4bddsm20290285ad.62.2026.11.23.00.13.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Nov 2026 00:14:00 -0800 (PST)
From: Henry Martin <bsdhenrymartin@gmail.com>
To: Peter Zijlstra <peterz@infradead.org>,
	Ingo Molnar <mingo@redhat.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>
Cc: Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,
	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,
	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,
	Zhang Qiao <zhangqiao22@huawei.com>,
	Tejun Heo <tj@kernel.org>,
	linux-kernel@vger.kernel.org,
	Henry Martin <bsdhenrymartin@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] sched/autogroup: Fix task_group use-after-free when fork races autogroup_move_group()
Date: Mon, 23 Nov 2026 16:13:52 +0800
Message-ID: <20261123081352.3570164-1-bsdhenrymartin@gmail.com>
X-Mailer: git-send-email 2.53.0
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

sched_cgroup_fork() reads signal->autogroup->tg without ->siglock, before
the new thread is linked into signal->thread_head.  A concurrent
autogroup_move_group() misses it in for_each_thread(), drops the last
kref of the old autogroup and frees its task_group, which the new thread
then keeps enqueueing into:

BUG: KASAN: slab-use-after-free in enqueue_task_fair+0x1075/0x33b0
Write of size 8 at addr ffff888101007940 by task poc/20125
CPU: 2 UID: 1000 PID: 20125 Comm: poc
Call Trace:
 kasan_check_range+0x100/0x1b0
 enqueue_task_fair+0x1075/0x33b0
 enqueue_task+0x70/0x170
 ttwu_do_activate+0xe9/0x590
 try_to_wake_up+0x69e/0x1110
 hrtimer_wakeup+0x39/0x50
Allocated by task 20119:
 sched_create_group+0x1a/0x90
 sched_autogroup_create_attach+0x5e/0x310
 ksys_setsid+0x2f6/0x410
Freed by task 0:
 kmem_cache_free+0x1dc/0x3c0
 rcu_core+0x570/0x1850
Second to last potentially related work creation:
 autogroup_move_group+0x2ac/0x3d0
 sched_autogroup_create_attach+0x167/0x310

Re-sync the new thread right after it is linked into thread_head, while
->siglock is still held: a concurrent move_group() then either already
installed the new autogroup, which the re-sync picks up, or is still
blocked on ->siglock and will see this thread in its for_each_thread()
sweep.  The re-sync compares pointers only; p->sched_task_group may
already be freed and must not be dereferenced.

This issue was discovered by Tencent CodeBuddy Security.

Cc: stable@vger.kernel.org
Fixes: 4ef0c5c6b5ba ("kernel/sched: Fix sched_fork() access an invalid sched_task_group")
Signed-off-by: Henry Martin <bsdhenrymartin@gmail.com>
---
 include/linux/sched/autogroup.h |  4 ++++
 kernel/fork.c                   |  1 +
 kernel/sched/core.c             | 29 +++++++++++++++++++++++++++++
 3 files changed, 34 insertions(+)

diff --git a/include/linux/sched/autogroup.h b/include/linux/sched/autogroup.h
index 704391cc1d20..edb1d5c022b2 100644
--- a/include/linux/sched/autogroup.h
+++ b/include/linux/sched/autogroup.h
@@ -6,11 +6,13 @@ struct signal_struct;
 struct task_struct;
 struct task_group;
 struct seq_file;
+struct kernel_clone_args;
 
 #ifdef CONFIG_SCHED_AUTOGROUP
 extern void sched_autogroup_create_attach(struct task_struct *p);
 extern void sched_autogroup_detach(struct task_struct *p);
 extern void sched_autogroup_fork(struct signal_struct *sig);
+extern void sched_cgroup_fork_sync(struct task_struct *p, struct kernel_clone_args *kargs);
 extern void sched_autogroup_exit(struct signal_struct *sig);
 extern void sched_autogroup_exit_task(struct task_struct *p);
 #ifdef CONFIG_PROC_FS
@@ -21,6 +23,8 @@ extern int proc_sched_autogroup_set_nice(struct task_struct *p, int nice);
 static inline void sched_autogroup_create_attach(struct task_struct *p) { }
 static inline void sched_autogroup_detach(struct task_struct *p) { }
 static inline void sched_autogroup_fork(struct signal_struct *sig) { }
+static inline void sched_cgroup_fork_sync(struct task_struct *p,
+					  struct kernel_clone_args *kargs) { }
 static inline void sched_autogroup_exit(struct signal_struct *sig) { }
 static inline void sched_autogroup_exit_task(struct task_struct *p) { }
 #endif
diff --git a/kernel/fork.c b/kernel/fork.c
index 5efceb8d58a7..da6a59a260a0 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -2574,6 +2574,7 @@ __latent_entropy struct task_struct *copy_process(
 			task_join_group_stop(p);
 			list_add_tail_rcu(&p->thread_node,
 					  &p->signal->thread_head);
+			sched_cgroup_fork_sync(p, args);
 		}
 		attach_pid(p, PIDTYPE_PID);
 		nr_threads++;
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 5ed660f099a5..3d911ae0f147 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4975,6 +4975,35 @@ int sched_cgroup_fork(struct task_struct *p, struct kernel_clone_args *kargs)
 	return scx_fork(p, kargs);
 }
 
+#ifdef CONFIG_SCHED_AUTOGROUP
+/*
+ * sched_cgroup_fork() pinned @p to the autogroup that signal->autogroup
+ * pointed at back then, without ->siglock.  A concurrent
+ * autogroup_move_group() that ran before @p became visible in thread_head
+ * could not see it in for_each_thread() and destroyed that autogroup,
+ * leaving @p->sched_task_group dangling.
+ *
+ * Now that @p is visible, such a move_group() either already ran (and
+ * missed @p) or is serialized behind the ->siglock its sweep needs.  In the
+ * former case @p is still tied to the destroyed task_group and must be
+ * re-synced.  @p->sched_task_group is only compared here, never
+ * dereferenced: it may already be freed.
+ */
+void sched_cgroup_fork_sync(struct task_struct *p,
+			    struct kernel_clone_args *kargs)
+{
+	struct task_group *tg = p->sched_task_group;
+
+	/* Only the autogroup path can leave @p on a destroyed task_group. */
+	if (kargs->cset->subsys[cpu_cgrp_id] != &root_task_group.css)
+		return;
+	if (tg == &root_task_group || tg == p->signal->autogroup->tg)
+		return;
+
+	sched_move_task(p, true);
+}
+#endif /* CONFIG_SCHED_AUTOGROUP */
+
 void sched_cancel_fork(struct task_struct *p)
 {
 	scx_cancel_fork(p);
-- 
2.53.0

