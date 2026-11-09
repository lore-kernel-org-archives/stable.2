Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794216545;
	b=iVqVraTlcMEWQdPkOW50lTQR2vetedogCQGaS3YCvuUSES2YVC6NlDA74Byish+MWdet
	 9P1UKvrMmBGYE0neyK8F9LqGTZwfpKaZ83d0npBWLmPDP7HIXV3LpE5EISrbFYkmp438g
	 txSDaSPX1Ieezl0DBMDBwvvxql37G+Rfilce+GaKA4rs6Rtd++alDaQLEx/7Yue3ZwD36
	 EojzpS3YgZOMqQViV/VM8n3C8rZ2xxbLvbKxsKP7QKrBgRpbemIEn7QGo4AbC5ZGHvdwc
	 s/LDHewCqpd8Usoqr90BNGBEI6HP6H6WlFF3s6areOhtzcpjsGsCgoi2PnGO6qMTclQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794216545;
	h=DMARC-Filter:Date:DKIM-Signature:DKIM-Signature:From:Sender:Reply-to:
	 To:Subject:Cc:In-Reply-To:References:MIME-Version:Message-ID:Robot-ID:
	 Robot-Unsubscribe:Precedence:Content-Type:Content-Transfer-Encoding;
	bh=Sa1td0rCt1lLV7O1f8BLy+9KXYJIgGhFJNgo6A6IutY=;
	b=aqLXUtVRL6xZh99Pnai0FIHwwBbmKpmhevmeI75BY2i3Cyfbkowzu5x0KK6bMfpD22sW
	 grbJ0QFOwfzBA6uQwH09KvPHEAXffV3+huQlWniqIirVsqQymHy9rUcpHFku+r0XE4cl3
	 EL1KkMowkDeLI2TdIaf1IpCshrg3NaMoRA1kFAdJUswxuopfqO75Xn2tOeujuuVqkIZSo
	 vjP20EFz/xu2ukYDDVGwRxWfdPFuKItsdaplp98YiBn4v4eN3GnwfrLOAAu7+bKtgu3zi
	 bXeBVwAgTH2AEvDd5yZepETmXk5ZpfGcHRl/4mgT1N+L8C9swou4D/kF6lblrdQXJWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linutronix.de;
	spf=pass smtp.mailfrom=linutronix.de;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b="Ow2C6L/T";
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=8bBmyiFj;
	arc=none smtp.remote-ip=193.142.43.55
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C326460A381B;
	Mon,  9 Nov 2026 09:29:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org C326460A381B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Ow2C6L/T;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=8bBmyiFj
Date: Mon, 09 Nov 2026 09:29:01 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1794216543;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sa1td0rCt1lLV7O1f8BLy+9KXYJIgGhFJNgo6A6IutY=;
	b=Ow2C6L/Tg8g7GzVGLtEVMct4IqP2fv6ez4r+Jz488raiXLsXsIKtXsPAh0fJSqHxfCuZc2
	I5ZBt+eTFx8ErUaycNWu7xcFyw4MATCasnNEqQ5t7WEpIeNz9/nTNgZiuOPYiJST7xL5Fl
	BCJECRDCGaSlQDaNiXRlj5V6DNkjlRLy7dH3LWnCSjIg7b44gt0i8SExbMWMlyYy2xX4cn
	xrySwBD+FnhqTVp+5iRs2TzzjwwhbDQHOth/7D9j1MhpfV2jX8xefUsBC/eRUucp6LQWU1
	FnpdOYYaPrHxNugnGRb8XRRl1Ln/2WdYAlvbNER7ooV+njoJGIIM4nUaLssMTQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1794216543;
	h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
	 message-id:message-id:to:to:cc:cc:mime-version:mime-version:
	 content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Sa1td0rCt1lLV7O1f8BLy+9KXYJIgGhFJNgo6A6IutY=;
	b=8bBmyiFjnld/l39mBWcmIKWttu21Tv6cLMSM1MlghrD+EkrPnB4O9ysG5J+Mnx7OxJ1J1m
	CZpOR+EVifcGZaBQ==
From: "tip-bot2 for Andrea Parri" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To: linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/deadline: Fix spurious -EPERM for
 migration-disabled tasks
Cc: Andrea Parri <parri.andrea@gmail.com>,
 "Peter Zijlstra (Intel)" <peterz@infradead.org>,
 Ingo Molnar <mingo@kernel.org>,
 Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
 Juri Lelli <juri.lelli@redhat.com>, stable@vger.kernel.org, x86@kernel.org,
 linux-kernel@vger.kernel.org
In-Reply-To: <20261102135420.244745-1-parri.andrea@gmail.com>
References: <20261102135420.244745-1-parri.andrea@gmail.com>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Message-ID: <179421654135.2093942.2082186434797343921.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe:
 Contact <mailto:tglx@kernel.org> to get blacklisted from these emails
Precedence: bulk
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     6616bffa9b52da1338cf8bff9882404e02b9e361
Gitweb:        https://git.kernel.org/tip/6616bffa9b52da1338cf8bff9882404e02b=
9e361
Author:        Andrea Parri <parri.andrea@gmail.com>
AuthorDate:    Mon, 02 Nov 2026 14:54:19 +01:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Mon, 09 Nov 2026 10:08:59 +01:00

sched/deadline: Fix spurious -EPERM for migration-disabled tasks

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
      a.size =3D sizeof(a);
      return syscall(SYS_sched_setattr, target, &a, 0);
  }

  static void *worker(void *arg)
  {
      struct sock_filter f[INSNS + 1];
      struct sock_fprog prog =3D { .len =3D INSNS + 1, .filter =3D f };
      int i;

      /* Reading the arguments keeps seccomp from caching the result */
      for (i =3D 0; i < INSNS; i++)
          f[i] =3D (struct sock_filter)
              BPF_STMT(BPF_LD | BPF_W | BPF_ABS,
                       offsetof(struct seccomp_data, args));
      f[INSNS] =3D (struct sock_filter)
          BPF_STMT(BPF_RET | BPF_K, SECCOMP_RET_ALLOW);
      syscall(SYS_seccomp, SECCOMP_SET_MODE_FILTER, 0, &prog);

      target =3D syscall(SYS_gettid);
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
      long refused =3D 0;
      int i;

      pthread_create(&t[0], NULL, worker, NULL);
      while (!target)
          usleep(100);
      for (i =3D 1; i < 9; i++)
          pthread_create(&t[i], NULL, hog, NULL);
      for (i =3D 0; i < REQUESTS; i++) {
          /* SCHED_DEADLINE, 2us every 1s */
          if (set((struct attr){ .policy =3D 6, .runtime =3D 2000,
                                 .deadline =3D 1000000000,
                                 .period =3D 1000000000 }) && errno =3D=3D EP=
ERM)
              refused++;
          set((struct attr){ .policy =3D 0 }); /* SCHED_OTHER */
      }
      stop =3D 1;
      for (i =3D 0; i < 9; i++)
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
---
 kernel/sched/syscalls.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/kernel/sched/syscalls.c b/kernel/sched/syscalls.c
index 45a127d..fb8f332 100644
--- a/kernel/sched/syscalls.c
+++ b/kernel/sched/syscalls.c
@@ -628,7 +628,7 @@ change:
 			 * the entire root_domain to become SCHED_DEADLINE. We
 			 * will also fail if there's no bandwidth available.
 			 */
-			if (!cpumask_subset(span, p->cpus_ptr) ||
+			if (!cpumask_subset(span, &p->cpus_mask) ||
 			    rq->rd->dl_bw.bw =3D=3D 0) {
 				retval =3D -EPERM;
 				goto unlock;
