Received: from m16.mail.163.com (m16.mail.163.com [220.197.31.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A75E42BC56;
	Tue, 11 Aug 2026 10:08:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=220.197.31.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786442909; cv=none; b=lBirYjGvuzkjAJVs/Nmt0XjNUTWL/4P0+SJNR5HUY2S3is50zrN/3E+GNw0dDEofP0TuHTXIo21Pw+Ord6hCaB/su53EUe1PSOqwm0roYpc1/nNyUCc6SwN3J/+WCyr+jv6rM4E0ETcSWuxA9oiqwQUhQrUcu1kN5NQ2fvXoQHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786442909; c=relaxed/simple;
	bh=yspgLwzyKIRU1E+rbCZL7qOYZxkcdNhUHowhi0Fn3cA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KMKpiv60nhY4cHzftGZUC4OeBk3a0Kcq0nV1/AuH+RSa2iMtHJYJ2QNhITpc8g0U/x5pou3+2vafKmkeUJ6jcpz1BS18xawIM8ROnw8euGgdpKO3Ut/3AerL7NxaI3QMC7k9tMF6vZ8DtfOaKe4hr8ASgGCsRx9cS57N9JFq26M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com; spf=pass smtp.mailfrom=163.com; dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b=h7Yk6VAU; arc=none smtp.client-ip=220.197.31.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=163.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=163.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=163.com header.i=@163.com header.b="h7Yk6VAU"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=163.com;
	s=s110527; h=From:To:Subject:Date:Message-ID:MIME-Version; bh=/9
	ROjJgT713LiHSNCuYe1fTDqvbnPEZw3kDfBzSeqzA=; b=h7Yk6VAUB2wdfO3DBo
	4TzAdGTAYSioUDOaVgZxAY/PPXfLO81EGLaGLitEnyExJmP+oSh2gyUgKIlvg9DR
	ktBAYVQGnhzKbxqjzxL3X26NeiRtrYpMz4VLHRW6sf+gz/1PJLqryYfdz/gf4T7c
	XyuSIHsKRnxqO6znUiPfldDdo=
Received: from localhost (unknown [])
	by gzsmtp3 (Coremail) with SMTP id PigvCgAXZJlO9HpqQrD_MQ--.18121S2;
	Tue, 11 Aug 2026 18:07:11 +0800 (CST)
From: Hui Su <sh_def@163.com>
To: juri.lelli@redhat.com,
	peterz@infradead.org,
	mingo@redhat.com
Cc: vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	kprateek.nayak@amd.com,
	longman@redhat.com,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Hui Su <sh_def@163.com>
Subject: [PATCH] sched/deadline: Fix DL server initialization for initially offline CPUs
Date: Tue, 11 Aug 2026 18:06:12 +0800
Message-ID: <20260811100612.1408592-2-sh_def@163.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-CM-TRANSID:PigvCgAXZJlO9HpqQrD_MQ--.18121S2
X-Coremail-Antispam: 1Uf129KBjvJXoWxGr4rKr4rtF1DAryktr13Jwb_yoWrXFyDpr
	W2q3W5Jr1kA34xK348Aay8GFyY9wn3Jw1avrnrArn7AayrAwn8t3Z0yrWa9ryUGr45CFya
	yr4Y93s293yUtaUanT9S1TB71UUUUU7qnTZGkaVYY2UrUUUUjbIjqfuFe4nvWSU5nxnvy2
	9KBjDUYxBIdaVFxhVjvjDU0xZFpf9x0piHa0PUUUUU=
X-CM-SenderInfo: xvkbvvri6rljoofrz/xtbCwQ+J6Gp69E+B4wAA3m

Commit 9f239df55546 ("sched/deadline: Initialize dl_servers after SMP")
moved DL server initialization to sched_init_smp(), assuming that all
CPUs are online after SMP initialization.

That assumption does not hold when CPUs are intentionally left offline
at boot, for example with maxcpus=. sched_init_dl_servers() only walks
online CPUs, so the fair and sched_ext DL servers of an initially
offline CPU never get their default DL parameters configured. Bringing
the CPU online later does not run this initialization again, leaving the
server parameters at zero.

For example, boot a two-vCPU QEMU guest with maxcpus=1 and then bring
CPU1 online:

  # echo 1 > /sys/devices/system/cpu/cpu1/online
  # cat /sys/kernel/debug/sched/fair_server/cpu1/runtime
  0
  # cat /sys/kernel/debug/sched/fair_server/cpu1/period
  0

With a zero runtime the fair server cannot be activated, so fair tasks
on the late-online CPU can be starved when higher-priority tasks
monopolize the CPU, potentially causing user-space workloads to stall.

Initialize DL servers for all possible CPUs instead. For CPUs that are
already online, preserve the existing initialization behavior. For an
initially offline CPU, initialize the server parameters and keep its
bandwidth reservation local to the runqueue, but do not account it to
the root domain until the CPU becomes active. A subsequent root-domain
rebuild then publishes the reservation.

Avoid updating the runqueue clock and setting up the current CBS period
for offline CPUs. The configured runtime and period are initialized at
boot, while the dynamic runtime and absolute deadline are initialized
through the normal CBS wakeup path when the server is first started.

After the fix, the same test reports:

  # cat /sys/kernel/debug/sched/fair_server/cpu1/runtime
  50000000
  # cat /sys/kernel/debug/sched/fair_server/cpu1/period
  1000000000

Fixes: 9f239df55546 ("sched/deadline: Initialize dl_servers after SMP")
Cc: stable@vger.kernel.org
Signed-off-by: Hui Su <sh_def@163.com>
---
 kernel/sched/deadline.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 200300043fa5..0445565ed9bb 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -1845,14 +1845,16 @@ void sched_init_dl_servers(void)
 	struct rq *rq;
 	struct sched_dl_entity *dl_se;
 
-	for_each_online_cpu(cpu) {
+	for_each_possible_cpu(cpu) {
 		u64 runtime =  50 * NSEC_PER_MSEC;
 		u64 period = 1000 * NSEC_PER_MSEC;
+		bool online = cpu_online(cpu);
 
 		rq = cpu_rq(cpu);
 
 		guard(rq_lock_irq)(rq);
-		update_rq_clock(rq);
+		if (online)
+			update_rq_clock(rq);
 
 		dl_se = &rq->fair_server;
 
@@ -1862,7 +1864,8 @@ void sched_init_dl_servers(void)
 
 		dl_se->dl_server = 1;
 		dl_se->dl_defer = 1;
-		setup_new_dl_entity(dl_se);
+		if (online)
+			setup_new_dl_entity(dl_se);
 
 #ifdef CONFIG_SCHED_CLASS_EXT
 		dl_se = &rq->ext_server;
@@ -1873,7 +1876,8 @@ void sched_init_dl_servers(void)
 
 		dl_se->dl_server = 1;
 		dl_se->dl_defer = 1;
-		setup_new_dl_entity(dl_se);
+		if (online)
+			setup_new_dl_entity(dl_se);
 
 		/*
 		 * No BPF scheduler is loaded at boot, so the ext_server has no
@@ -1918,14 +1922,18 @@ int dl_server_apply_params(struct sched_dl_entity *dl_se, u64 runtime, u64 perio
 	guard(raw_spinlock)(&dl_b->lock);
 
 	cpus = dl_bw_cpus(cpu);
-	cap = dl_bw_capacity(cpu);
 
-	if (__dl_overflow(dl_b, cap, old_bw, new_bw))
-		return -EBUSY;
+	if (!init || cpu_active(cpu)) {
+		cap = dl_bw_capacity(cpu);
+
+		if (__dl_overflow(dl_b, cap, old_bw, new_bw))
+			return -EBUSY;
+	}
 
 	if (init) {
 		__add_rq_bw(new_bw, &rq->dl);
-		__dl_add(dl_b, new_bw, cpus);
+		if (cpu_active(cpu))
+			__dl_add(dl_b, new_bw, cpus);
 		dl_se->dl_bw_attached = 1;
 	} else if (dl_se->dl_bw_attached) {
 		__dl_sub(dl_b, dl_se->dl_bw, cpus);
-- 
2.54.0

