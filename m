Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795628820;
	b=2MyNRI0W4qQlGo64ZcdNDR6SyxXzIi8R9pMRu32CMa2lH2yPOYsvVS2Mo8wLGlSw4O/r
	 MHCtGAlaCIPCUdyzfV8JpwVcKvRCQLGlEWyuygkEPfT7rqIJs9rsLdRAXhE/JFXfgG43O
	 6WQZ3+Khv7E1+jG5lDIiDXm7DIGW1zBUj+EUlCfV/Hq5bG/IWmm7yCQQArnioqBDt8MQO
	 cvmimGb+HS5bFmrCHL3c8zJXIhOwvhQKQrSQdKUSPcVNNlzGXptFVj9l3KRrT2cc4tNnv
	 c08Xu8hnY0jU7Dh3ax+p2ZBsGDkggnt9ookS3j+va1dDJIdCFwTmN+wYbFJi+j6x3Gw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795628820;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=8c+LyVlFKvyZF0fsgWxE5CfeuYTsKpQvZnUC0csZPoM=;
	b=2eh2rUF2xERG1TUQ9zFhTnTpVh82j01CXbUB0K0IPmszA/jYKkNyMezBl97f07V5cH7/
	 Xp93A4b5STFWal6oFAMEXnzJrSpD028Mud8MaSVazm2Fub3VU61Cel6m8XUnbWeID50oh
	 F1Ubczto9IgWgjWyGh+hAiOKE2nnz8X6TMyh8JEtMGZf4GU/oTsT12ZmQrRZpQMy739V/
	 4WWkLoRht9/SL1AHVIwE6O/waqisZv90bCHmPcYD8BrUlJtw6RBFVsPp+R67MQOUfPzCf
	 QUByMYpQUVYm6Ns/VL9NW3vg/xwnk8M7MPMRyUtby7VgUplwB70xFJ28SZfy6o1GqqA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LF+ClB+U;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0447A606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LF+ClB+U
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF7D91F000D0;
	Wed, 25 Nov 2026 17:46:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795628819;
	bh=8c+LyVlFKvyZF0fsgWxE5CfeuYTsKpQvZnUC0csZPoM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LF+ClB+UjNByNg7f3jLGTEdS7B+9+1bjQI08cljY62yo4TjiBVC/qXK9VNlml5AW1
	 qy5dYnzEbG7Xo4OloqsUJpo46TwXuhu866kxR98on5a3ZSaTTWhKmq66qtsRi881h6
	 ScMRrjbshYXPPcc3eduZQJDdzYgknnaX4UGh5t8Xpai4x3VpcJPKrYyKQjKw/iohhu
	 vvE7LUiiKReRAFFhb3QgWQFkh/E3MBaC8sRPC3MWqM9XiYDG7UsfmfFBRcXnKIyi0b
	 xrl/D5layRcC3TDZyFdpLX5/FR/gSmjk0TRINHqG0kZsF++eFMKYMnY84TzGao8q59
	 YXKrYJNMx7K1g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] sched/deadline: Fix spurious -EPERM for migration-disabled tasks
Date: Wed, 25 Nov 2026 12:46:57 -0500
Message-ID: <20261125174639.1040396-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112550-bobbed-rectified-568c@gregkh>
References: <2026112550-bobbed-rectified-568c@gregkh>
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
[ sashal: adapted the hunk to the older layout, where the code lives in kernel/sched/core.c's static __sched_setscheduler() instead of kernel/sched/syscalls.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4e9fac7507a9..981338aeda46b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7499,7 +7499,7 @@ static int __sched_setscheduler(struct task_struct *p,
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

