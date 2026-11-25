Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629302;
	b=HoIq2fhY9HUydDrRpvxvUxmJ2ml33EfU1ZXUjAl+FuQMmFTILNK074FSaA+ghaCFv951
	 uFz03+ya8ALSzx/kutoJ4S2oT5SbwDrx08VSbt6k1YfMio+jtWOI9XSPeB10g0j+dPT/R
	 X7gF5tde9eR6QFQXzbR4s/DuTZ3ajYf2PIJi7lt1jHbxlKMlFwXOjb3yCiKRm4gyo0vaJ
	 CNFV04G2Cj9LHzOPATNpSYBsLJgc/QjXqU+BuFKyNvcsCiaUakBT0av0A9DEh4DLdE8a4
	 fx19bPbwj7QLvFBPECqE+Cso58M5llEc3s31MEGx7r8FGSjOm/8gqR+a/+9njyxUuUQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629302;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=kA0wqtebmk8BBeO1GPBHX9/msV+pGITxo+ot7fhtOuc=;
	b=x8RdFhY0JJPYGpt2TD9ZT7HewdGKdgbstvO0wVybQ8VhjgKdqUI9Baw8vXoCcJ+hQ2JX
	 G6n4PQ4rFfmNdDBNixqSWESZBQVo5kRnnYH7C9SUGzLgoa9HDeg6cJlZnnlkR9e/RT9rp
	 NuZHmz8de0N7VKnpyAcP2o9JNCQIEvHF6K+xm/po24QjEtDVoH0/635wNYbrouwMAmvlw
	 7vb6vt7UNaoBnv9aXjemT19flhdPLjenDca9/pfgY62LZ5MAWq55fIJcIlZwo5L5LrVtw
	 sCTtOZuxP8UdlMPUJf+7kiGmMrZh1amUdPfHPp5cyiVIk945fqDwfwSD9+ZVVrp9lMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzsq50Xe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1481606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bzsq50Xe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCA11F000C0;
	Wed, 25 Nov 2026 17:54:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629301;
	bh=kA0wqtebmk8BBeO1GPBHX9/msV+pGITxo+ot7fhtOuc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bzsq50XeMg55I9Gl8yqB7RdA3ju6cSg3w0BbDa3pdT70TRQbJsye+MoqNSsUfBjEe
	 Ey9Bu/DNuCpMVreQrOKe2/D4+FJ+E3b3O/uqZEtTVCq/8daa1u5xjB0khXAINUcGp8
	 QFlxaeVWVgzNiAPvFdECIWIDONgzV6Nl1nQ0wQNQKwvgGZVqRuag90jiYaiDUIjQ6F
	 Qgmpy+6I1+W6hXkKe0hyPX2NW+CJxKYB/Ziy5k2NDJgtVnzztLoYT+61/xyeJQfIAu
	 4lnKyEQBhYibwc+LO/Cne0hdR+q8BPgoBwPeyYDipHMwC3Om6roL9j7Is8HY4m6uZ5
	 olxgNQ8IwIH0w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Kayra Cizmeci <kayracizmeci@gmail.com>,
	Juri Lelli <juri.lelli@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] sched/core: Fix cpuset_mutex double unlock in __sched_setscheduler()
Date: Wed, 25 Nov 2026 12:54:57 -0500
Message-ID: <20261125175439.1088645-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112526-fragrant-alienable-bd3d@gregkh>
References: <2026112526-fragrant-alienable-bd3d@gregkh>
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

[ Upstream commit f7141257dd67d4936f906a6cfd1d0007721f6898 ]

A sched_setattr() with SCHED_FLAG_KEEP_POLICY on a SCHED_DEADLINE task
unlocks cpuset_mutex twice if the task's policy changes concurrently:

  WARNING: bad unlock balance detected!
  7.4.0-rc1 #1 Not tainted
  -------------------------------------
  repro/126 is trying to release lock (cpuset_mutex) at:
  [<ffffffff9a17cacc>] __sched_setscheduler+0x9cc/0xc40
  but there are no more locks to release!
  ...
  Call Trace:
   print_unlock_imbalance_bug.part.0+0xfb/0x110
   lock_release+0x286/0x2e0
   __mutex_unlock_slowpath+0x1a/0x400
   __sched_setscheduler+0x9cc/0xc40
   __x64_sys_sched_setattr+0xa3/0x1b0
   do_syscall_64+0x106/0x5f0
   entry_SYSCALL_64_after_hwframe+0x77/0x7f

__sched_setscheduler() samples p->policy before taking any lock, and
restarts from the recheck label if p->policy differs under the rq lock.
The restart drops cpuset_mutex but leaves cpuset_locked set, so a pass
that no longer needs the mutex still unlocks it on its way out:

  CPU 1                                CPU 2
  __sched_setscheduler(KEEP_POLICY)
    policy = p->policy /* DEADLINE */
                                       __sched_setscheduler(SCHED_OTHER)
                                         p->policy = SCHED_OTHER
    cpuset_locked = true
    cpuset_lock()
    rq = task_rq_lock(p)
    oldpolicy != p->policy
      cpuset_unlock()
      goto recheck
    /* no cpuset_lock() this time */
    ...
    if (cpuset_locked)
      cpuset_unlock()

Without CONFIG_DEBUG_MUTEXES, or CONFIG_DEBUG_RT_MUTEXES on PREEMPT_RT,
nothing warns. The second unlock still clears the owner field regardless
of who holds the mutex, so another task can lose cpuset_mutex inside its
critical section. Entering SCHED_DEADLINE needs CAP_SYS_NICE, but a
racing caller that owns the task does not need it if it samples a policy
other than SCHED_DEADLINE.

Clear cpuset_locked when dropping the mutex for the restart. This should be
safe because the flag is only tested on the paths leaving the next pass,
after that pass has set it again if it took the mutex.

The following program, run as root, reproduces the splat, which no longer
appears with this applied. On PREEMPT_RT it crashes the kernel within
seconds, which this also fixes:

  #define _GNU_SOURCE
  #include <pthread.h>
  #include <stdint.h>
  #include <sys/syscall.h>
  #include <unistd.h>

  struct attr {
      uint32_t size, policy;
      uint64_t flags;
      int32_t nice;
      uint32_t prio;
      uint64_t runtime, deadline, period;
  };

  static volatile int stop;
  static volatile pid_t target;

  static void set(struct attr a)
  {
      a.size = sizeof(a);
      syscall(SYS_sched_setattr, target, &a, 0);
  }

  static void *sleeper(void *arg)
  {
      target = syscall(SYS_gettid);
      while (!stop)
          usleep(1000);
      return arg;
  }

  static void *switcher(void *arg)
  {
      while (!stop) {
          /* SCHED_DEADLINE, 2us every 1s */
          set((struct attr){ .policy = 6, .runtime = 2000,
                             .deadline = 1000000000,
                             .period = 1000000000 });
          set((struct attr){ .policy = 0 }); /* SCHED_OTHER */
      }
      return arg;
  }

  static void *racer(void *arg)
  {
      /* KEEP_POLICY | KEEP_PARAMS */
      while (!stop)
          set((struct attr){ .flags = 0x18 });
      return arg;
  }

  int main(void)
  {
      pthread_t t[5];
      int i;

      pthread_create(&t[0], NULL, sleeper, NULL);
      while (!target)
          usleep(100);
      pthread_create(&t[1], NULL, switcher, NULL);
      for (i = 2; i < 5; i++)
          pthread_create(&t[i], NULL, racer, NULL);
      sleep(30);
      stop = 1;
      for (i = 0; i < 5; i++)
          pthread_join(t[i], NULL);
      return 0;
  }

An LLM helped find the PREEMPT_RT crash and write this patch and its test.

Fixes: 111cd11bbc54 ("sched/cpuset: Bring back cpuset_mutex")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Waiman Long <longman@redhat.com>
Reviewed-by: Kayra Cizmeci <kayracizmeci@gmail.com>
Reviewed-by: Juri Lelli <juri.lelli@redhat.com>
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20261016062629.2102883-1-sh_def%40163.com
Link: https://patch.msgid.link/20261102134606.242743-1-parri.andrea@gmail.com
[ sashal: adjusted the file path and function context from kernel/sched/syscalls.c to kernel/sched/core.c, where __sched_setscheduler() is static in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index cf470ac63af72..9a338369262b5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7673,8 +7673,10 @@ static int __sched_setscheduler(struct task_struct *p,
 	if (unlikely(oldpolicy != -1 && oldpolicy != p->policy)) {
 		policy = oldpolicy = -1;
 		task_rq_unlock(rq, p, &rf);
-		if (cpuset_locked)
+		if (cpuset_locked) {
 			cpuset_unlock();
+			cpuset_locked = false;
+		}
 		goto recheck;
 	}
 
-- 
2.53.0

