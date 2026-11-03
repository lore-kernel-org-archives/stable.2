Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.69
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793732904;
	b=dickYeNBRWD5JRFkWisMtbykJTVEaebpdw9UZWsJAtFktchrcf6e0ChEP7VEvFJI9Yv7
	 QwYeMrmCKyXBj9Qt+zj/BDwcvq5akPPG8hfEfo4c8iYE4D1Baux3joEuRhhcWdIrgKM5G
	 pTwX0rQYGU4xULxMmlJirmprZT5yAK+o0wngpdjJbPnEAsBrB+/Zn2B/B1rllb7XGQXfI
	 lcjuPt/MCTT6faNyFObDURZ1yeEYiGxuMeLpnzY5r+a7VO+VVLtnlDZUtu93AEI8KQb24
	 /H2OVcnX9+LRzsrOU9+tBZKOF5A2q4pvP+rvMvoQ/WrQmwt6AqE539Lev79KrDk/ZSQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793732904;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Received:Date:Mime-Version:X-Mailer:Message-ID:
	 Subject:From:To:Cc:Content-Type;
	bh=IxD8yh34NPGaNP8ew9kHc7SiNkT4kaFRl3q2ZiG2UR4=;
	b=4M3xbh5atBo3nOj7acNwyHWCa3ZYoA1iyQENgc8R1c0vpsVysjtj6QdhXm76AxY2o69s
	 wLg13S0Zig0n44RQ/2PIbRLVcIBCxt8wDdXz+p00RdA7FEJ5YPsOIebSHAkqyuYbQhrnw
	 7dQ0bUvZ4w0sNQvXw8zecQuCBK68pk4o15VbAzzX3g4pIx0QWUftAmBU11HDqGXxPToVw
	 oM9dP7DS5E/meiFKpZTiggyfZcdHIPL9WvlFh8W20AVJkNEsH8qEe9TSJezBMCY6Brtzg
	 0PRDSi2sOSyyQ3Gyw82jH1aJyDtMRFxc2Tum8gyKIgAdbbLIpbRS1tH2eGCf7f6aBgg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=google.com;
	spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com;
	dkim=pass header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BTvYhbp2;
	arc=none smtp.remote-ip=209.85.221.69
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com [209.85.221.69])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23F2A606A332
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 19:08:24 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 23F2A606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--jpiecuch.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20260707 header.b=BTvYhbp2
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-48b02d63407so3515117f8f.0
        for <stable@vger.kernel.org>; Tue, 03 Nov 2026 11:08:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20260707; t=1793732902; x=1794337702; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=IxD8yh34NPGaNP8ew9kHc7SiNkT4kaFRl3q2ZiG2UR4=;
        b=BTvYhbp23CpMOgiWEWCKr7McZqBXZPOdBtUEtX//vd9+O7U6addvxgD3dFrV+Bnq9Z
         bd9wMnjVYdafU/XCTkXTDg1f5KjEEtXy2F9FE/LPujZGU4mTZvnoDKnRdJzIhWaS+HO9
         PjCenKazyfmzyeY+Ovu3kRvwddEqQ2OjOJmUqeHBbBYVg25OLlvZUfihV1hNOi1T+lRm
         HEcBbxfcK93d5AZHXbLfJVuWSMQyj7JFvXQkUpbxQsnojjln9xX3ew2/WQhKSnD+Z7VA
         jYvljCk6LG6jW6YqtPSUfAA9v885K9wmvYmN7p9f7sBrwnlcG3q63CX0nrzqkRHcNkQK
         lz0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793732902; x=1794337702;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=IxD8yh34NPGaNP8ew9kHc7SiNkT4kaFRl3q2ZiG2UR4=;
        b=ZbGYA4WjnVRNm4DhzYZkaEt4N7OSQfLLzGIWmChMEzPs/WnWcYQnSoRFxTeWM/FWLj
         FRZnABPGDP//8R6AVnq3B7JkfLinCNanNE7PTM4d0jNOjw3eex/5wD/X2qHVuwP3/l36
         vhxt+2/N+oLppsUICMsJrwNdw1x+zv/uPDb+At+BShbrIBUyoGfS1o8zmOclb+IJbQ6C
         xXywnEnv7UQuIUHWipj/9Il248Qu/0GSZIz1p/lLkMvDEAf4qBucsO9FDpTRwhu2qSCW
         D7DrtSlFYm5QNd5k5SJX03ltyMESqN/+NEJ0VJseK6grs3NrgD20+PuP1ilDnjpOc1aE
         nwGw==
X-Gm-Message-State: APuU4Z8iqODULseP+tnNeZVSQh4z0t5rVPsMrAsDC4+zsjchw+V4Ohl/
	XJfeeqMzw86iMsMYvrW0mWNByNOo6xyTdBxMDhQ/1Em54utYtkU1bSC8zx4cbAq6HsBPbtcsiD5
	OJHIHf3MlveQBmUCgFLqP0CUhG5QSr3hddvl7Aj7WSG/MBlwGPnKrJJ/Vkc1iUPnjTla4oGkGk1
	iLSD5ytnAj+Iv45LmlIF7w92XDCutuJfUBlcHKFsKW0yEdVf0=
X-Received: from wrxg10.prod.google.com ([2002:a05:6000:118a:b0:48b:593:62ae])
 (user=jpiecuch job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:1d07:b0:4a2:18d4:f9e0 with SMTP id 5b1f17b1804b1-4ac18c735b3mr324456175e9.25.1793732902362;
 Tue, 03 Nov 2026 11:08:22 -0800 (PST)
Date: Tue,  3 Nov 2026 19:07:47 +0000
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
Mime-Version: 1.0
X-Mailer: git-send-email 2.56.0.398.g882cbad275-goog
Message-ID: <20261103190805.3487350-1-jpiecuch@google.com>
Subject: [PATCH 6.18.y 0/2] sched_ext: Fix bpf_scx_unreg() teardown race
From: Kuba Piecuch <jpiecuch@google.com>
To: stable@vger.kernel.org
Cc: Kuba Piecuch <jpiecuch@google.com>, Tejun Heo <tj@kernel.org>, Andrea Righi <arighi@nvidia.com>, 
	Richard Cheng <icheng@nvidia.com>, Cheng-Yang Chou <yphbchou0911@gmail.com>, 
	Sasha Levin <sashal@kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
	sched-ext@lists.linux.dev, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

6.18-stable commit f786e6652b93 ("sched_ext: Reorganize enable/disable
path for multi-scheduler support", upstream dbd542a8fac7, v6.18.46) made
scx_disable() queue disable_work only if it wins scx_claim_exit(). If
scx_vexit() has already claimed the exit and error_irq_work has not yet
queued disable_work, kthread_flush_work() in bpf_scx_unreg() is a no-op
and the last sch->kobj reference is dropped while the scheduler is still
enabled:

  CPU A                          CPU B
  -----                          -----
  scx_vexit()
    scx_claim_exit() -> true
    irq_work_queue()
  scx_error_irq_workfn()
    scx_dump_state()
                                 bpf_scx_unreg()
                                   scx_disable()
                                     scx_claim_exit() -> false
                                   kthread_flush_work() // no-op
                                   kobject_put(&sch->kobj)
    kthread_queue_work()
  scx_disable_workfn()
    scx_root_disable()
      kobject_del(&sch->kobj)

kobject_put() has already done __kobject_del(), so the second
kobject_del() drops another scx_kset reference and frees
/sys/kernel/sched_ext. The next attach then hits:

  BUG: KASAN: slab-use-after-free in kobject_get+0xcb/0xe0
  ...
  Freed by task 210:
   kfree
   kobject_put
   __kobject_del
   kobject_del
   scx_root_disable.cold
   scx_disable_workfn

Returning early also lets the struct_ops maps be freed while ops can still
be called, which is how mainline hit the same race (see patch 1).

Mainline fixed this with 510a27055446 and d99f7a32f09d. They didn't reach
6.18.y because they fix f4a6c506d118, which 6.18.y doesn't have. This
series backports them, with error_irq_work in place of disable_irq_work:
bpf_scx_unreg() and the enable error path now wait until exit_kind is
SCX_EXIT_NONE or SCX_EXIT_DONE.

I didn't revert f786e6652b93: that also fixes the reproducer, but brings
back scx_disable() acting on scx_root rather than the link's scheduler.
Detaching the leftover link of a scheduler whose ops.init() failed would
then disable a scheduler loaded after it.

Tested in vng with KASAN:
- v6.18.60: KASAN slab-use-after-free on re-attach, 3/3 runs.
- v6.18.60 + this series: reproducer passes 5/5, no warnings;
  sched_ext selftests 23/23 pass.

Reproducer: a syscall prog calls scx_bpf_error() on CPU 1, ops.dump()
spins to hold error_irq_work, CPU 0 detaches the link, then the
scheduler is attached again.

  bpftool btf dump file vmlinux format c > vmlinux.h
  clang -O2 -g -target bpf -D__TARGET_ARCH_x86 -c repro.bpf.c
  bpftool gen skeleton repro.bpf.o > repro.skel.h
  cc -O2 repro.c -o repro -lbpf
  vng -r arch/x86/boot/bzImage --user root --cpus 4 -e ./repro

---8<--- repro.bpf.c ---
// SPDX-License-Identifier: GPL-2.0
#define BPF_NO_KFUNC_PROTOTYPES
#include "vmlinux.h"
#include <bpf/bpf_helpers.h>
#include <bpf/bpf_tracing.h>

char _license[] SEC("license") = "GPL";

void scx_bpf_error_bstr(char *fmt, unsigned long long *data,
			u32 data__sz) __ksym;

volatile __u32 dump_entered, unreg_done, exit_called;

SEC("syscall")
int trigger_err(void *ctx)
{
	static char msg[] = "repro";
	unsigned long long param[1] = {};

	scx_bpf_error_bstr(msg, param, sizeof(param));
	return 0;
}

/* Hold scx_error_irq_workfn() before it queues disable_work. */
SEC("struct_ops/repro_dump")
void BPF_PROG(repro_dump, struct scx_dump_ctx *dctx)
{
	u64 start = bpf_ktime_get_ns();
	u32 i;

	dump_entered = 1;
	bpf_for(i, 0, 8000000)	/* bpf_iter_num caps at BPF_MAX_LOOPS */
		if (unreg_done || bpf_ktime_get_ns() - start > 500000000ULL)
			break;
}

SEC("struct_ops.s/repro_exit")
void BPF_PROG(repro_exit, struct scx_exit_info *ei)
{
	exit_called = 1;
}

SEC(".struct_ops.link")
struct sched_ext_ops repro_ops = {
	.dump	= (void *)repro_dump,
	.exit	= (void *)repro_exit,
	.flags	= SCX_OPS_SWITCH_PARTIAL,
	.name	= "repro",
};
---8<--- repro.c ---
// SPDX-License-Identifier: GPL-2.0
#define _GNU_SOURCE
#include <pthread.h>
#include <sched.h>
#include <stdio.h>
#include <unistd.h>
#include <bpf/bpf.h>
#include <bpf/libbpf.h>
#include "repro.skel.h"

static void pin(int cpu)
{
	cpu_set_t set;

	CPU_ZERO(&set);
	CPU_SET(cpu, &set);
	sched_setaffinity(0, sizeof(set), &set);
}

static void *err_fn(void *arg)
{
	LIBBPF_OPTS(bpf_test_run_opts, opts);

	pin(1);
	bpf_prog_test_run_opts(*(int *)arg, &opts);
	return NULL;
}

int main(void)
{
	struct repro_bpf *skel;
	struct bpf_link *link;
	pthread_t tid;
	int fd, exited;

	pin(0);
	skel = repro_bpf__open_and_load();
	if (!skel)
		return 1;
	link = bpf_map__attach_struct_ops(skel->maps.repro_ops);
	if (!link)
		return 1;

	/* CPU 1: claim the exit and enter ops.dump() from error_irq_work */
	fd = bpf_program__fd(skel->progs.trigger_err);
	pthread_create(&tid, NULL, err_fn, &fd);
	while (!skel->bss->dump_entered)
		sched_yield();

	/* CPU 0: unregister while disable_work is not yet queued */
	bpf_link__destroy(link);
	exited = skel->bss->exit_called;
	skel->bss->unreg_done = 1;
	pthread_join(tid, NULL);
	usleep(350000);
	repro_bpf__destroy(skel);

	/* re-attach touches scx_kset, freed on buggy kernels */
	skel = repro_bpf__open_and_load();
	if (skel) {
		link = bpf_map__attach_struct_ops(skel->maps.repro_ops);
		bpf_link__destroy(link);
		repro_bpf__destroy(skel);
	}

	printf("%s: ops.exit() %s before unreg returned\n",
	       exited ? "PASS" : "FAIL", exited ? "ran" : "did not run");
	return !exited;
}
---8<---

Cheng-Yang Chou (1):
  sched_ext: Fix scx_flush_disable_work() UAF race

Richard Cheng (1):
  sched_ext: sync disable_irq_work in bpf_scx_unreg()

 kernel/sched/ext.c | 23 +++++++++++++++++++++--
 1 file changed, 21 insertions(+), 2 deletions(-)

-- 
2.56.0.385.gac671c819a-goog
