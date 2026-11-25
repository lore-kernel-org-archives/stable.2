Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628457;
	b=wp/3rGh8Ix6pM1chiyLJpgX5icc4cpRbwRZa85AtK/KwjV8u3DErK9nA2fFie445zHGA
	 FDgd2cx6dD+3LinHGbHsc58cTl1M9sDmdy6NJSVO33vQAmqQXfvUYG9nOmBsdqKqRT8ft
	 qR0t6qVYWCiZpXngW/AB5w8zztQKSOWo5x/xm3AK9+1ovHIFlwVYiHCOgMQbXLhdpgBLj
	 YGYcTcMT5XjZRnGsE+YAyWe7uTvJ/xYd92yG/or/R9kZHkUvKUNhqKN2q9j7DlEuDlxTG
	 8XdhB8pGCCKAt1qNmJp8HPUdJsHY0C6X0Ox9pP+bCbfh40zvNEzb4tQXoxhZSZdToYA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628457;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8SEVkZyGP0rkOlzp40DlRjAYIrZvFr/9Eh9FnVFrVrE=;
	b=2+F2jlyO1EAD3hYBbmzbb1BYnF4+cQC5H/D4XhylDHzk52NKQDj0MX3UHPE3EOrz1J2p
	 RhqBz4SuxT7FT2o9ry842Z6hmMKbzZ6Vain9tVSvIPuqw0FKuaTnodQbwwoMENuuG9LKy
	 hWTLFYn5agMiHLtUL5Dic60lAArDoKEeqsWSKZJODeyUPVhxVzg2ZpUTlz5LASTgeFm7b
	 SlxSQVnwRWsY/IoT0qajYSZN5HWMomyHw5YQrzT8SAyjlEGd+FX/yVFA9isOoM4Qje5sj
	 FhGK+n+3ahRTs75tvGmFzV0nBrGnY6mWT80iPAhpcBShCo1hDhlMPC1H3BGMRY2hr+w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPex2r+M;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5423606A33B
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:40:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iPex2r+M
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9C0861F00AE3;
	Wed, 25 Nov 2026 17:40:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628457;
	bh=8SEVkZyGP0rkOlzp40DlRjAYIrZvFr/9Eh9FnVFrVrE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iPex2r+MtyjEEONPm6UvKyzyhPU6+5njWAJreXJ275oB2boN0JyN7TYMwqmOpzU/a
	 p7UxOwkMuwyr8ZEKlHqpO+liefWCl49frT/yWrR3/fno09bGZEyrRdwwuEC57Af3R4
	 AwAa9p4VoB8Qgrryi6Sxu/fYreg3+9exFyAOuVHTjwQa2rWye2Kii+WxnuI8al297H
	 bUApLUPdeESp8nQC3pfMrlAsr6z0RHx3iqnSqpTIgP6+g7ghyHYlv6ta+mzWnMw7mq
	 1nFW9ZS/E7mWjvAIbRiaSfPAHpa44sSErr0UrF700jOP365StVJGkGdoRwYpDXds7M
	 1Qma+ies1ixUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] sched/deadline: Fix spurious -EPERM for migration-disabled tasks
Date: Wed, 25 Nov 2026 12:40:55 -0500
Message-ID: <20261125174037.1007354-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112548-gutless-blizzard-1ebb@gregkh>
References: <2026112548-gutless-blizzard-1ebb@gregkh>
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

From: Andrea Parri <parri.andrea@gmail.com>

[ Upstream commit 6616bffa9b52da1338cf8bff9882404e02b9e361 ]

sched_setattr() can refuse to make a task SCHED_DEADLINE with -EPERM,
even though the task's affinity covers the whole root domain. A retry
can succeed, but the error blames an affinity the task does not have.

__sched_setscheduler() tests p->cpus_ptr, which is not always the task's
affinity. When a task is scheduled out inside a migrate_disable() section,
migrate_disable_switch() points p->cpus_ptr at the current CPU until
migrate_enable(). On PREEMPT_RT every spinlock_t holder is in such a
section, so ordinary kernel work opens the window. Elsewhere, seccomp
filters run in one.

Test p->cpus_mask instead, which keeps the task's affinity and is what
sched_getaffinity() reports. This should be safe because an admitted
task's cpus_mask covers the root domain, so set_cpus_allowed_dl() moves
no bandwidth when migrate_enable() restores p->cpus_ptr.

The following program, run as root, had 553679, 453720 and 424623 of its
1000000 requests refused on three boots of a 4-CPU PREEMPT_RT guest, and
236182, 217174 and 237183 without PREEMPT_RT. With this applied the count
is 0, also with lockdep, and a task pinned to one CPU is still refused:

  #define _GNU_SOURCE
  #include <errno.h>
  #include <linux/filter.h>
  #include <linux/seccomp.h>
  #include <pthread.h>
  #include <stddef.h>
  #include <stdint.h>
  #include <stdio.h>
  #include <sys/syscall.h>
  #include <unistd.h>

  #define REQUESTS 1000000
  #define INSNS 300

  struct attr {
      uint32_t size, policy;
      uint64_t flags;
      int32_t nice;
      uint32_t prio;
      uint64_t runtime, deadline, period;
  };

  static volatile int stop;
  static volatile pid_t target;

  static long set(struct attr a)
  {
      a.size = sizeof(a);
      return syscall(SYS_sched_setattr, target, &a, 0);
  }

  static void *worker(void *arg)
  {
      struct sock_filter f[INSNS + 1];
      struct sock_fprog prog = { .len = INSNS + 1, .filter = f };
      int i;

      /* Reading the arguments keeps seccomp from caching the result */
      for (i = 0; i < INSNS; i++)
          f[i] = (struct sock_filter)
              BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
                       offsetof(struct seccomp_data, args));
      f[INSNS] = (struct sock_filter)
          BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW);
      syscall(SYS_seccomp, SECCOMP_SET_MODE_FILTER, 0, &prog);

      target = syscall(SYS_gettid);
      while (!stop)
          syscall(SYS_getppid);
      return arg;
  }

  static void *hog(void *arg)
  {
      while (!stop)
          ;
      return arg;
  }

  int main(void)
  {
      pthread_t t[9];
      long refused = 0;
      int i;

      pthread_create(&t[0], NULL, worker, NULL);
      while (!target)
          usleep(100);
      for (i = 1; i < 9; i++)
          pthread_create(&t[i], NULL, hog, NULL);
      for (i = 0; i < REQUESTS; i++) {
          /* SCHED_DEADLINE, 2us every 1s */
          if (set((struct attr){ .policy = 6, .runtime = 2000,
                                 .deadline = 1000000000,
                                 .period = 1000000000 }) && errno == EPERM)
              refused++;
          set((struct attr){ .policy = 0 }); /* SCHED_OTHER */
      }
      stop = 1;
      for (i = 0; i < 9; i++)
          pthread_join(t[i], NULL);
      printf("%ld of %d requests refused\n", refused, REQUESTS);
      return 0;
  }

An LLM helped find this bug and write this patch and its test.

Fixes: af449901b84c ("sched: Add migrate_disable()")
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
Link: https://patch.msgid.link/20261102135420.244745-1-parri.andrea@gmail.com
[ sashal: Applied the same one-line cpus_mask change in __sched_setscheduler() in kernel/sched/core.c, since the syscalls.c file it targets upstream doesn't exist in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ae06385109049..67b5b44a5ccb3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7797,7 +7797,7 @@ static int __sched_setscheduler(struct task_struct *p,
 			 * the entire root_domain to become SCHED_DEADLINE. We
 			 * will also fail if there's no bandwidth available.
 			 */
-			if (!cpumask_subset(span, p->cpus_ptr) ||
+			if (!cpumask_subset(span, &p->cpus_mask) ||
 			    rq->rd->dl_bw.bw == 0) {
 				retval = -EPERM;
 				goto unlock;
-- 
2.53.0

