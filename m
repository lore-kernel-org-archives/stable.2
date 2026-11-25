Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795629071;
	b=wV4PMETjRfeIpJxcfDD4V56/llRiO2jMZJWpnmsHlHzlkbD5C9ySa/E2TwndYwisoiEj
	 4VYjBxsXiAg1Vix96qGoLoqD3vizJeUj1fDEUTDIuU0Vn2c+/o9CIZOt3aNKXT1/W89rL
	 XB1E8F7JMr6W1eNOaFITgbuqVCODSxoIh1CfvWgUiqmNV/90+HD9+H2aBolJTvZs+80xx
	 GauVFXdBeZ4zx9Ja/6QZHzBqLNxCAXVyE8TBKKVzYyU980Aj2fBhsxV7e0kH7CQpOpZLC
	 PyknxhiEtkB1dursh77xnkKBtak8S/yQFApE5Pem9GZk+RqlWjFY2qO8YaCTRii9nTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795629071;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vBLkp9ptqEp123yZn2iXEws2HyWozrKsSC3LV6+y6RI=;
	b=QIa0s+syfdDV7YrF+xMdeCLiKoZDC/ibEy/LCglK7Rf27RRCLWT3+kItfzalDkhAudpE
	 AXvV8wrUG57G5dkt4zgaYfAOpF3Hxtx1bfKzW8ihApYDrX5uK6c0gXlvFw1sGUnI9DI8a
	 qjTRpt7c8y0GqKPyp9G0ncfWF8iPvzg2mFuwEGsfFFK0kJroqB+Fr446RfKMEt8M35vKs
	 9Gqwql+c54wj0/+JEHJwbXf2/GvcEZ2fHFScXP309iHUAZleF0rC6R9+5wLhTWXp+nVMD
	 Sz+VPDe6Wfb7Ky1HbgC9UrtY+504VU1nvBHCGD1r3oXYWpVPDGABKEfW35YIWZA2hMg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hO2bQqln;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27D5C606A330
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 17:51:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hO2bQqln
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC8831F00A03;
	Wed, 25 Nov 2026 17:51:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795629070;
	bh=vBLkp9ptqEp123yZn2iXEws2HyWozrKsSC3LV6+y6RI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hO2bQqlnys54XbGkoc7TEOXQR4f2Yk9Enix+Osc6mTMEG9ww+jjMSsgH4jbYkfb/+
	 frapAbyBsSShmisn1rRFQCkddOiQ5mFKrlyTmS6nnWueeb5/KGqWfRu02My7L5ifhw
	 fUPDXxDtkXjoJq+7vSz1PX1cXi2A5LbcIsOi9ilCr2HyIRbuvb7IHC+U4ZCb1op7E0
	 drKhHklhf7jvC24WKH7zWJd4CALc8HVdC5Be40CkNaT/+DuFptLu4L5AiJgsjKsq5z
	 Cs0ahLNA0RZg0GNaYn3qDZ7qwkQtnSXpUtKGKXm7GyyB/vf7AeayDpugUGEa6TDQkl
	 o5Yc38Wv34LZA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrea Parri <parri.andrea@gmail.com>,
	Sashiko <sashiko-bot@kernel.org>,
	"Peter Zijlstra (Intel)" <peterz@infradead.org>,
	Ingo Molnar <mingo@kernel.org>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] sched/uclamp: Reject clamp values above SCHED_CAPACITY_SCALE
Date: Wed, 25 Nov 2026 12:51:08 -0500
Message-ID: <20261125175054.1050736-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112505-zigzagged-widget-9e48@gregkh>
References: <2026112505-zigzagged-widget-9e48@gregkh>
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
[ sashal: Applied the change to uclamp_validate() in the older core scheduler file, since the function hasn't yet moved to its separate syscalls file there. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 kernel/sched/core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ae06385109049..6f7269a6921de 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -1898,8 +1898,8 @@ static int sysctl_sched_uclamp_handler(struct ctl_table *table, int write,
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

