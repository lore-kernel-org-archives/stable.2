Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629500;
	b=moAB2kaOGzvZdrOFSlwrsmFLEEBQ2y4h4mcKTlIhszNLPXm9LGq6waFbAZjcl7KuNEUC
	 2XloiFkeEdcghiWv9NdxNEkX5AAwtJCxreKYEfB3LOscmB7IEcoHu2AtIfAXHxHzMcC9M
	 j9w5HIxzIowfzoF/N1bKNb7BVZbxIncN8GWbHdbXWbTlF7QiaEi6rnerbSotH2ZxnEXGu
	 EchYkGSJ2fVgWW8iwX4t9CPuBUBv+ngtjz+3TrPkK7zr3tgpvYKMS0pWyAKTA6JuZ7ndH
	 rSBOk7xVF48T/TPyuPpu6lFB7lYwFJ4qzEclHx5bzyWF6Lak2FeVDEyv7B0a5N/RTww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629500;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=7MtD9MbhsLEHX7/577XnA5UWZzNOv5RRcsgMsU6d2QY=;
	b=RoiCkji4zkoQ4Eaxg5QTiy5lDR5J147+5s39kpNFsgy5wBN5SigiMaZJbd7oNLx1aSsq
	 iAl7ig3n/tvHg5GmAZ69COaIQaVUD3Ci7UjhPWUddDorBUJ6K0M7qw2JJq957u1n3Hizg
	 ymEYepBZyvA9GIi8ZuWH/34yhrZbRae2S5YWRnl6F1N2GXVNc0HxLHLqeFHqaiStnmZXZ
	 x8sMUFmEu0E8ytqXgVm4Hea5Wr+c9QbXHy0ZTon97YpP/xgHxoxQbb09RQMSLKznc/tMf
	 +xlUI7fZxHJoDgqU/D5jL0tHO25myTqBLWcGkPN7FlgT42Ok0Ojnh8FdXJ4SqGdQ8mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="D67S/r3/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8DAF0606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:58:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D67S/r3/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0216A1F000CA;
	Wed, 25 Nov 2026 17:58:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629500;
	bh=7MtD9MbhsLEHX7/577XnA5UWZzNOv5RRcsgMsU6d2QY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=D67S/r3//xUuOHpmJHc4gso6rGDD6Hz94jOFBobSds5E2sNjDJq06YiAMTUmfs31m
	 6mBgYmmHYbNzkmvR7SSmIY7E4zXmFzKeFsmaO470jvMVcI3oNXprRjXcqjDY75OH2a
	 XtXfAeBHqdIjcsx77NcL29D2JY90o7M5jM3NNFRrtvv77yQCJMS0qd+ypfalgWlNE/
	 DkQ6XZJidIX8RJt+woaiiq18TaUId36dZLzcBrcNbWcEHoO046lBn1pR4UggHacTjN
	 SbK8KQ+a6HjFCNSNuI85rq55Kdcoztjga6vOf9oa3aBKmq+n2Zw4MGWfoACPbcwF3l
	 usnykNzRNY7Pw==
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
Subject: [PATCH 5.15.y] sched/core: Fix cpuset_mutex double unlock in __sched_setscheduler()
Date: Wed, 25 Nov 2026 12:58:17 -0500
Message-ID: <20261125175801.1104189-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112527-fruit-graph-9946@gregkh>
References: <2026112527-fruit-graph-9946@gregkh>
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
[ sashal: Adapted the hunk to the older file layout, where the function is a static __sched_setscheduler() in kernel/sched/core.c instead of kernel/sched/syscalls.c. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4e9fac7507a9..18576be033364 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -7512,8 +7512,10 @@ static int __sched_setscheduler(struct task_struct *p,
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

