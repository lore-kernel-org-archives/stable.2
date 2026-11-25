Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629470;
	b=NOKUCcKU4FSroK4aC5Ch0LnkfJHPRKiP0rKduqfHgmkEXkhva2X5RyLREG2aflt4vhOe
	 Sd2Bm8dd7reEJuUPWzYBf3BJFQufz46a/9Q2NsSSXp9MYotC53b6jmNOfJq+Ea2xJxjz+
	 ZWm6gdhDgMspviBRCK8Yd2J7u2bEDjKWEoV2zJ1XFrFIrKhJpl7ls6o1Nd6jAC7NZ3HHF
	 fjTB/s9lQVggawHxBs0AyizRUlutBbq3TnN4xH9MCySNnTUlP5hI0adW+wfwG/TJfTwoY
	 bGDoMXOEfWvRQP2+X0+ldYk3XObPgbju00cyVsgFX6LHjeTV0IorBnEzSv4EjmsDqDA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629470;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=MiolkA3WvJfO9LN5uhlROVal7yTXoyAGs/zfpKl8Vhw=;
	b=cUQYN5YKmEIsA+bEWz2/xQZ7GR0H5T2NVaxaqhXqMCGI3YUzk0bzM8QH2r4W8jih7uVI
	 DNxXyIUaewdGjWykm1dCRMLyUiFy5jlpNdWn/f03VfuPDOJUnjkw17J+rwtGdRlA5iqG1
	 zA7bukrAm2dHNfF++j3VMR0O1QOyopG0g7srZv5MndW1R/BPCz84mcrm92ur3o6c7bw0Y
	 MEgDWJaMp+sOhgQ75CHF5DCLvw+mJxfIniOx7uMJtGtdR3i22NwMsk5zgM7Cl1+AfUJH5
	 qqrvUCDVg802r6wbr8tX5iPnwGQV6NjpqLmJA7mMrRplZisTyabWCZUd5zYfFelfqKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuPUsLqA;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68F95606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:57:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EuPUsLqA
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 031471F000D0;
	Wed, 25 Nov 2026 17:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629469;
	bh=MiolkA3WvJfO9LN5uhlROVal7yTXoyAGs/zfpKl8Vhw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EuPUsLqARQUtd4jJZ9KT8nyskZ6x5Tq7lXizwhhN0x4Y3ixAMvXI+IIw5kH4Ew+uR
	 q667sr2n//fnQtKKOvcX8OQdayH0H8aRbxwxmU5gwLJEYku+50+r7iudSag4JHXqg3
	 tm19bpRupRMY0xtroPHqANuMNP7KNDHycTv2ATb1rj5qfaZUrR056Jpf9TLM7kX5IQ
	 qVSQhPZlDUWY/ilKcmp86t4VuXb4f66+M6K3lUI3crApjMGJx1Lg0Dli7P3hLCa/Av
	 XYkacfsXK1CQRlGI5o+nq2obyUXaKmoyvAqg667orm/usbxuWEGGRIg0H1jdFJSsNJ
	 07ZYEvrWY9jsw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] sched/uclamp: Reject clamp values above SCHED_CAPACITY_SCALE
Date: Wed, 25 Nov 2026 12:57:47 -0500
Message-ID: <20261125175731.1098115-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112507-ungodly-humorous-49be@gregkh>
References: <2026112507-ungodly-humorous-49be@gregkh>
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

[ Upstream commit 8127ec8458df29bd702db602473042ccb9e619b9 ]

sched_setattr() accepts sched_util_min and sched_util_max values that do
not fit in uclamp_se::value. A single thread can do:

  sched_setattr(max = 800)		returns 0
  sched_setattr(min = 0xfffffffe)	returns 0
  sched_getattr()			min=2046 max=800

which leaves the minimum above both SCHED_CAPACITY_SCALE and the task's own
maximum.

The range check in uclamp_validate() relies on the + 1 wrapping -1, the
reset value, to 0:

	if (util_min + 1 > SCHED_CAPACITY_SCALE + 1)

That only works for an unsigned type. util_min and util_max are int and
SCHED_CAPACITY_SCALE is a long, so every negative value passes the check,
and so does INT_MAX, whose + 1 wraps.

uclamp_se_set() then truncates what got through to the 11 bits of
uclamp_se::value, but computes the bucket from the full value. A minimum
of 0xfffff800 is stored as 0 in the top bucket, where uclamp_rq_max_value()
takes it for the highest active clamp once a higher value leaves the rq.
The rq clamp falls below what the remaining tasks requested, and emptying
their bucket trips the WARN_ON_ONCE() in uclamp_rq_dec_id(), without any
privilege:

  WARNING: kernel/sched/core.c:1862 at dequeue_task+0x2a3/0x2b0, CPU#0: repro/126
  Call Trace:
   __schedule+0x933/0x1320
   schedule+0x36/0x100
   do_nanosleep+0x61/0x190
   hrtimer_nanosleep+0xb5/0x1d0

Make util_min and util_max unsigned int, so that -1 is the only value that
wraps. The pair check below is unaffected, since it skips -1 explicitly and
anything else is at most SCHED_CAPACITY_SCALE by then.

Requests that were only accepted because of this now fail with -EINVAL.

The following program triggers the warning when run by any user outside
a child cpu cgroup. With this applied, its 0xfffff800 request fails with
-EINVAL and the warning no longer appears:

  #define _GNU_SOURCE
  #include <pthread.h>
  #include <sched.h>
  #include <stdint.h>
  #include <sys/syscall.h>
  #include <time.h>
  #include <unistd.h>

  struct attr {
      uint32_t size, policy;
      uint64_t flags;
      int32_t nice;
      uint32_t prio;
      uint64_t runtime, deadline, period;
      uint32_t util_min, util_max;
  };

  static volatile int stop;

  static void set_min(uint32_t v)
  {
      /* KEEP_POLICY | KEEP_PARAMS | UTIL_CLAMP_MIN */
      struct attr a = { .size = sizeof(a), .flags = 0x38, .util_min = v };

      syscall(SYS_sched_setattr, 0, &a, 0);
  }

  static void burn(long us)
  {
      struct timespec s, n;

      clock_gettime(CLOCK_MONOTONIC, &s);
      do
          clock_gettime(CLOCK_MONOTONIC, &n);
      while ((n.tv_sec - s.tv_sec) * 1000000 +
             (n.tv_nsec - s.tv_nsec) / 1000 < us);
  }

  static void *bogus(void *arg)
  {
      set_min(0xfffff800);
      while (!stop)
          burn(1000);
      return arg;
  }

  static void *worker(void *arg)
  {
      long v = (long)arg;

      set_min(v);
      while (!stop) {
          burn(v == 800 ? 300 : 1500);
          usleep(100);
      }
      return arg;
  }

  int main(void)
  {
      pthread_t t[3];
      cpu_set_t c;
      int i;

      CPU_ZERO(&c);
      CPU_SET(0, &c);
      sched_setaffinity(0, sizeof(c), &c);
      pthread_create(&t[0], NULL, bogus, NULL);
      usleep(50000);
      pthread_create(&t[1], NULL, worker, (void *)500L);
      pthread_create(&t[2], NULL, worker, (void *)800L);
      sleep(15);
      stop = 1;
      for (i = 0; i < 3; i++)
          pthread_join(t[i], NULL);
      return 0;
  }

An LLM helped find the warning and write this patch and its tests.

Fixes: 480a6ca2dc6e ("sched/uclamp: Allow to reset a task uclamp constraint value")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Signed-off-by: Andrea Parri <parri.andrea@gmail.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Cc: stable@vger.kernel.org
Link: https://sashiko.dev/#/patchset/20261016062629.2102883-1-sh_def%40163.com
Link: https://patch.msgid.link/20261102134831.243255-1-parri.andrea@gmail.com
[ sashal: Moved the uclamp_validate() hunk from kernel/sched/syscalls.c to kernel/sched/core.c, where the function lives in this tree; the code change itself is unchanged. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index c4e9fac7507a9..246d3f5e889f5 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1781,8 +1781,8 @@ int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
 static int uclamp_validate(struct task_struct *p,
 			   const struct sched_attr *attr)
 {
-	int util_min = p->uclamp_req[UCLAMP_MIN].value;
-	int util_max = p->uclamp_req[UCLAMP_MAX].value;
+	unsigned int util_min = p->uclamp_req[UCLAMP_MIN].value;
+	unsigned int util_max = p->uclamp_req[UCLAMP_MAX].value;
 
 	if (attr->sched_flags & SCHED_FLAG_UTIL_CLAMP_MIN) {
 		util_min = attr->sched_util_min;
-- 
2.53.0

