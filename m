Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793852974;
	b=C5MDSvtC/9905mTL/pkLjJ4oc3UKNhsvjNaGUxN4YXsi9QS7nDxTXfn/0FQ2KeVwcn5I
	 +bzgBOR1pmNAe8+839U/4gsovfTMOPvNPb5hv/9cse3FSS4D1zvdO7hQ4JvGf5NG17O/z
	 +FvUTXmpvKuGuBxm2qOiH9GAaOb1pP1daTOwbJpimJ30CdCyUpqFyBw0iodoPmBiyQq+G
	 ZxBwyMKtXBhIRId/TDksOuqczBssY57Jz5FKCBtHGwFe+crRqSiWBEge0A08vgm1kxZ3H
	 19i0b1oNkWWUaEDNVnyyRbzjmFZ0hydIJb+ZVMvMskn3NhkrzEIRN6401eZE5rJ/2BQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793852974;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1Q2IGNun9HG9qNSOHoCJ4AG7heKs5L51Qrg6JixMLi0=;
	b=4NfP6J8NOFo80OpFQXeTJck8ZZCZRu7FzczcoF6PB2P5BXrj6MxD6bF9h7YD3z0Hc+1Y
	 XfpfX8BA5DKoPqL9qvxP61+dXH62MXox44R7NnvLVI17/8IlZt/Ok7JeoCzKUlIM/VfBN
	 ymu+Npj+bVir02gg3wWUFJxcHNF5PVHpx+np6BfHM2Z4b9OxoHqc+lHB0S1HyTRJQ0m8U
	 1jTBiLSJReJE4bg6PS8QFxxLSIXuBtH0ezNb+6vVCJjlbTnb/VCRFJn6uO4mM2BNMQ5wE
	 Dp/SJqqT8bhRQJoJqQZTD6HWn2Ci6qwBTq1yjdMcNprxDL53uldCeMIZBlYJTMxM52A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="vWWzuw/G";
	arc=none smtp.remote-ip=74.125.82.46
Received: from mail-dl1-f46.google.com (mail-dl1-f46.google.com [74.125.82.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18834606A326
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 04:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18834606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=vWWzuw/G
Received: by mail-dl1-f46.google.com with SMTP id a92af1059eb24-1abaaf33a56so38757c88.1
        for <stable@vger.kernel.org>; Wed, 04 Nov 2026 20:29:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793852973; x=1794457773; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1Q2IGNun9HG9qNSOHoCJ4AG7heKs5L51Qrg6JixMLi0=;
        b=vWWzuw/GacEXC6rPvKdZzeklFeJrllOHFOIbblqO4oQeWluT7G5iN/CoutV20rXhEb
         lnOsMpsqK4t/PknL0InAsiMdShvb5NdQ6LEUwHicMFZ+zkLYj/LlTV4jA0MPu7Suk5UQ
         8OvZX2j48Pduv5LdYxbwr+sX+t49cYqwyyBKKqZPuEfUh4zbve615rgXTeQ1BzdTKRdC
         UvTOal4RLUNzD7UeLtfu+/cjFJUxpHOI5tyqBWnFxsoTNDhJQQDsIpANGCO7h9pAYzCs
         8MJdfcAzLpC9q6kVBjOaiNHb1IpinyYVTVQMm6V7YKSc0h1+Qt6rUiB3kvVBrH1il+Ta
         jf6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793852973; x=1794457773;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1Q2IGNun9HG9qNSOHoCJ4AG7heKs5L51Qrg6JixMLi0=;
        b=oNqPJmUrTxYbN++yeiYkktdK9U12NGT9ydwZMy/K4UeuWiA8mK5NCPyG0hgThKsBVG
         QgygYnK1uUWUw8xL3ObFIUadkoaG68rXctf8bEhdZzGV8vxK1SoGQcMXyu6iC6PTMaz7
         50yJ8dwHLQuyxYJvRz9pG4iwG8Ho+yxraCCMpmbVVAW7nuQS7WB/7GZZge3ufv4tBMc0
         1LKte7hxqL9WhvtbLRtCGEAWJ6AymAVB4z8EshxvPzG3egYKXIc1HG3hqZvSGv5BFkQb
         zIDXCKRyhstej86je6TOciY9O7+90KrfEcKkJsw/jY8vIciGAd0Yi4+2as/Odk6rddbB
         dctg==
X-Forwarded-Encrypted: i=1; AKwUvBwksG1j+WvxR1t9x+cizmZGiEzUw8CWEMzrhHL3QPgXiU5bNJff7vgRoUidphjq9TjGEpBR/ss=@vger.kernel.org
X-Gm-Message-State: APuU4Z9y9ycUKQfmch/kwMnvI9rcLC+1xdvFZ+Xu4JfFy5jTvjBwBRu6
	VqJeQa9E9bJbHgZUWw7cfwJ3xe7s61EPDyNnB25xjGz6MGVP9BEGwNaA
X-Gm-Gg: AYBFou3csbDqRMsXk9oiEhfPzgrE6e5zyH0vYwbyb1JAATpTdGClHgzMHQ2NIgFgnV9
	jENQISkcCGN6RBUeh0cUW0BIwBfscKnD0Ng/euWGm4haaw12XaOO8+a4xJcNfTA7rNlhaK764ba
	QC9RgtL/k9Q+IFEe8MPISajV/XhSEKlpwZyC4/zdQMD8K+c51QJ5FCXXpzLxCWUcn4F+AVEGhgJ
	tpXbTvZvvzjZ+cmJ1M8aP5KCG1F1nMbMKxR3HFx9am6viiSat2l++vBYtwNl3Bi6o6YH3EWdvHj
	IgFanR/7i9snJFp8aFj9T8CxJDHef9eSY30G3056pu/tRBMPHfUOiXqdpesY7kzdw92oXqvG/Bd
	nOmwosgI+8L2TY456X4YWdDN4rVY17Swt5Tz3NPc/n1j2cGumfBEzUOzbpZUPSU+FOCd0iGHy1Z
	bVySsoHbmsrwUMP84dmmoJ+rQ73Llsx8wto0CpSjYwvk297XeU9ZPaYHlsvt0UADd+wmxK1cfzZ
	9gzy5TCGV0XQptSPVmaVETJrtoyO0yErJaCL3x7m0AfgEx6BsfUxiBLT42Ecsm8X5j00Hl6QCtc
	aZZu/YlnmBY6Sih9ueYOEX1vhkck5DhnlO1pHbwnsQ==
X-Received: by 2002:a05:701b:2302:b0:183:d275:cf76 with SMTP id a92af1059eb24-1ac59dd0e2emr37777545c88.2.1793852972948;
        Wed, 04 Nov 2026 20:29:32 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b245c4f83fsm18403998c88.17.2026.11.04.20.29.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Nov 2026 20:29:32 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: leon@kernel.org
Cc: jgg@ziepe.ca,
	linux-rdma@vger.kernel.org,
	stable@vger.kernel.org,
	Chengyu Liu <lui2012qwq@gmail.com>
Subject: [PATCH v3] RDMA/ipoib: cancel the AH reaper synchronously on teardown
Date: Thu,  5 Nov 2026 12:29:22 +0800
Message-Id: <20261105042922.14733-1-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
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

ipoib_stop_ah_reaper() uses cancel_delayed_work(), which cannot stop a
callback that is already running.  ipoib_reap_ah() re-arms itself after
an unlocked test_bit(IPOIB_STOP_REAPER) check, so a callback that has
passed the check but has not re-armed yet still queues the delayed work
after the "stop":

  CPU0 (reaper)                     CPU1 (stop/teardown)
  test_bit(STOP_REAPER) == 0
                                    set_bit(STOP_REAPER)
                                    cancel_delayed_work()  (no-op)
                                    ... destroy_workqueue(priv->wq)
  queue_delayed_work(priv->wq, ...)  <- delayed work sits on the timer

destroy_workqueue() cannot see a delayed work that is pending on the
timer wheel, so the re-armed work fires after the workqueue is
destroyed and priv is freed: both the queueing onto the dead queue and
the callback's container_of() on freed memory are use-after-free.

Use cancel_delayed_work_sync(), which waits for a running callback and
swallows its re-arm while the stop is in flight.  Note that
ipoib_stop_ah_reaper() also runs on ndo_stop and on the stop/open cycle
of a heavy flush, so the work must be left enabled for
ipoib_start_ah_reaper() to re-arm it on the next open;
cancel_delayed_work_sync() re-enables on the way out, unlike
disable_delayed_work_sync() which would kill the reaper for good.

The comment above claims ipoib_reap_dead_ahs() "ensures the work is
really stopped", but it never touches the work item - it only walks
the dead_ahs list under priv->lock.  The stop guarantee comes from the
cancel; fix the comment along with it.

Found by static analysis.  Reproduced on a KASAN build running stock
ib_ipoib on a Soft-RoCE transport (rxe): when a running reaper callback
escapes the stop and re-arms, the timer fires one second later in
__run_timer_base() on the destroyed workqueue (slab-use-after-free).

Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
v3:
  - back to cancel_delayed_work_sync(): ipoib_stop_ah_reaper() also runs
    on ndo_stop and on the heavy-flush stop/open cycle, so the work must
    be left enabled (sashiko review); disable_delayed_work_sync() would
    kill the reaper on the next open

v2: https://lore.kernel.org/r/20261104181753.1245369-1-lui2012qwq@gmail.com
  - add reproducer on stock ib_ipoib over rxe
  - switch to disable_delayed_work_sync() (superseded by v3)

v1: https://lore.kernel.org/r/20261103170703.1600310-1-lui2012qwq@gmail.com


Reproducer (harness summary; full driver scripts and the timing trigger
below):

    QEMU has no IB hardware, so the stock ib_ipoib driver runs over a
    Soft-RoCE (rxe) transport presented as an IB port.  Harness shims,
    all below ib_ipoib (the driver itself is unmodified):

      * rxe_verbs.c: report link layer INFINIBAND and cap flags
        PROT_IB|IB_MAD|AF_IB from rxe_get_link_layer() /
        rxe_port_immutable(); skip ib_get_eth_speed() for the flipped
        port in rxe_query_port(); set dev.parent before
        ib_register_device().
      * sa_query.c: answer ib_sa_path_rec_get() locally (async via
        system_wq) when the device has no SA.
      * multicast.c: complete ib_sa_join_multicast() locally (async);
        tag the synthetic object (comp_mask bit 63) so
        ib_sa_free_multicast() frees it.
      * ipoib_ib.c (witness only, no behavior change): trace_printk()
        timing in ipoib_reap_ah(), and an ESCAPED-ARM line when the
        callback re-arms after IPOIB_STOP_REAPER was set.

    With ~500 AH entries churned into dead_ahs, the reaper's walk
    measures 20-160us once a second; the teardown (RDMA netlink
    DELLINK of the rxe device) reaches ipoib_stop_ah_reaper() ~3.9ms
    after the syscall enters.  The stock test->queue window is the
    handful of instructions between the lockless test_bit() and the
    queue_delayed_work(); to hit it deterministically the PoC kernel
    widens it to 200us with a module parameter.  On a hit the witness
    logs

        ipoib_stop_ah_reaper: reap_ah: ib0 STOP at=531116547240
        ipoib_reap_ah: reap_ah: ib0 ESCAPED-ARM after stop

    and one second later the escaped timer fires on the destroyed
    workqueue (trimmed):

        BUG: KASAN: use-after-free in __run_timer_base.part.0+0x80c/0x900
        Write of size 8 at addr ffff888021088628 by task swapper/0/0
        Call Trace:
         <IRQ>
         kasan_report+0x96/0xd0
         __run_timer_base.part.0+0x80c/0x900
         tmigr_handle_remote_up+0x38b/0x830
         ...
         handle_softirqs+0x184/0x5c0
         irq_exit_rcu+0x6e/0x150
         sysvec_apic_timer_interrupt+0x70/0x80
         </IRQ>

    with the workqueue core reporting, right before the splat:

        workqueue: cannot queue ipoib_reap_ah on wq ipoib_wq


------------------------- reproducer: trigger.c -------------------------
// SPDX-License-Identifier: GPL-2.0
/*
 * trigger.c - F-026 teardown timing trigger.
 *
 * Watches the PoC kernel's ipoib_reap_ah() witness lines on trace_pipe
 * ("reap_ah: ib0 start=<ns> walk_ns=<ns>"), predicts the next reaper run
 * (~1s period, jiffy-aligned) and deletes the rxe device via RDMA netlink
 * (RDMA_NLDEV_CMD_DELLINK, the real teardown path: ib unregister -> ipoib
 * remove -> stop_ah_reaper -> destroy_workqueue -> free) at
 *
 *      next_start + walk_ns + offset
 *
 * which is the callback's test_bit->queue_delayed_work gap.
 *
 * usage: trigger <rxe_dev> <ib_dev> <offset_ns>
 */
#define _GNU_SOURCE
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <fcntl.h>
#include <time.h>
#include <errno.h>
#include <linux/netlink.h>
#include <sys/socket.h>

#ifndef NETLINK_RDMA
#define NETLINK_RDMA 20
#endif

#define RDMA_NL_NLDEV		5
#define RDMA_NL_GET_TYPE(c, o)	(((c) << 10) + (o))
#define RDMA_NLDEV_CMD_GET	1
#define RDMA_NLDEV_CMD_DELLINK	4
#define RDMA_NLDEV_ATTR_DEV_INDEX	1
#define RDMA_NLDEV_ATTR_DEV_NAME	2

static const char *TRACE_PIPE = "/sys/kernel/tracing/trace_pipe";

static unsigned long long now_ns(void)
{
	struct timespec ts;
	clock_gettime(CLOCK_MONOTONIC, &ts);
	return (unsigned long long)ts.tv_sec * 1000000000ull + ts.tv_nsec;
}

static void wait_until(unsigned long long deadline_ns)
{
	while (now_ns() < deadline_ns)
		;
}

static int nla_put(char *buf, int *off, int type, const void *data, int len)
{
	struct nlattr *na = (struct nlattr *)(buf + *off);
	na->nla_type = type;
	na->nla_len = NLA_HDRLEN + len;
	memcpy(buf + *off + NLA_HDRLEN, data, len);
	*off += NLA_ALIGN(na->nla_len);
	return 0;
}

/* dump all rdma links, return the index of `name` (0 if not found) */
static int rdma_dev_index(int fd, const char *name)
{
	char buf[4096];
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	int found = -1;
	struct timeval tv = { .tv_sec = 2, .tv_usec = 0 };

	setsockopt(fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
	memset(buf, 0, sizeof(buf));
	nlh->nlmsg_len = NLMSG_LENGTH(0);
	nlh->nlmsg_type = RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_GET);
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_DUMP;
	nlh->nlmsg_seq = 1;
	if (send(fd, buf, nlh->nlmsg_len, 0) < 0)
		return 0;

	for (;;) {
		ssize_t len = recv(fd, buf, sizeof(buf), 0);
		struct nlmsghdr *m;
		if (len <= 0)
			break;
		for (m = (struct nlmsghdr *)buf; NLMSG_OK(m, len);
		     m = NLMSG_NEXT(m, len)) {
			struct nlattr *a;
			int rem, idx = -1;
			char nm[64] = "";

			if (m->nlmsg_type == NLMSG_DONE)
				goto out;
			if (m->nlmsg_type == NLMSG_ERROR) {
				struct nlmsgerr *e = NLMSG_DATA(m);
				fprintf(stderr, "[dbg] dump err=%d\n", e->error);
				goto out;
			}
			a = (struct nlattr *)NLMSG_DATA(m);
			rem = m->nlmsg_len - NLMSG_HDRLEN;
			for (; rem > 0 && (int)a->nla_len <= rem;
			       rem -= NLA_ALIGN(a->nla_len),
			       a = (struct nlattr *)((char *)a + NLA_ALIGN(a->nla_len))) {
				if (a->nla_type == RDMA_NLDEV_ATTR_DEV_INDEX)
					idx = *(unsigned int *)((char *)a + NLA_HDRLEN);
				else if (a->nla_type == RDMA_NLDEV_ATTR_DEV_NAME)
					snprintf(nm, sizeof(nm), "%s",
						 (char *)a + NLA_HDRLEN);
			}
			if (idx >= 0 && !strcmp(nm, name))
				found = idx;
			else if (idx == 0 && !strcmp(nm, name))
				found = 0;
		}
	}
out:
	return found;
}

static int rdma_dellink(int fd, int index)
{
	char buf[256];
	struct nlmsghdr *nlh = (struct nlmsghdr *)buf;
	int off = NLMSG_LENGTH(0);

	memset(buf, 0, sizeof(buf));
	nlh->nlmsg_len = 0;
	nlh->nlmsg_type = RDMA_NL_GET_TYPE(RDMA_NL_NLDEV, RDMA_NLDEV_CMD_DELLINK);
	nlh->nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	nlh->nlmsg_seq = 2;
	nla_put(buf, &off, RDMA_NLDEV_ATTR_DEV_INDEX, &index, sizeof(index));
	nlh->nlmsg_len = off;

	if (send(fd, buf, off, 0) < 0)
		return -1;
	/* read the ACK */
	if (recv(fd, buf, sizeof(buf), 0) > 0) {
		struct nlmsghdr *m = (struct nlmsghdr *)buf;
		if (m->nlmsg_type == NLMSG_ERROR) {
			struct nlmsgerr *e = NLMSG_DATA(m);
			return e->error ? -1 : 0;
		}
	}
	return 0;
}

int main(int argc, char **argv)
{
	const char *ifname = argv[1];	/* rxe device, e.g. rxe0 */
	const char *ibname = argv[2];	/* ipoib iface, e.g. ib0 */
	char tname[80];
	long long offset_ns = atoll(argv[3]);
	FILE *f;
	char line[512];
	unsigned long long start = 0, walk = 0, period = 0, prev_start = 0;
	int nlfd;

	snprintf(tname, sizeof(tname), "reap_ah: %s ", ibname);

	nlfd = socket(AF_NETLINK, SOCK_RAW, NETLINK_RDMA);
	if (nlfd < 0) {
		perror("socket NETLINK_RDMA");
		return 1;
	}

	f = fopen(TRACE_PIPE, "r");
	if (!f) {
		perror("open trace_pipe");
		return 1;
	}

	fprintf(stderr, "[*] trigger: dev=%s offset=%lldns\n", ifname, offset_ns);

	while (fgets(line, sizeof(line), f)) {
		char *s, *w;
		if (!strstr(line, tname))
			continue;
		s = strstr(line, "start=");
		w = strstr(line, "walk_ns=");
		if (!s || !w)
			continue;
		start = strtoull(s + 6, NULL, 10);
		walk = strtoull(w + 8, NULL, 10);
		if (!start || !walk)
			continue;
		if (prev_start)
			period = start - prev_start;
		prev_start = start;
		if (!period || !walk)
			continue;

		unsigned long long fire = start + period + walk + offset_ns;
		unsigned long long t0 = now_ns();
		if (fire <= t0)
			continue;
		fprintf(stderr, "[*] next gap in %llu ns (period %llu, walk %llu)\n",
			fire - t0, period, walk);
		wait_until(fire);
		unsigned long long fired = now_ns();
		int idx = rdma_dev_index(nlfd, ifname);
		int rc = idx >= 0 ? rdma_dellink(nlfd, idx) : -1;
		fprintf(stderr, "[+] fired DELLINK idx=%d rc=%d at=%llu drift=%lldns\n",
			idx, rc, fired, (long long)(fired - fire));
		fflush(stderr);

		/* closed-loop: read the trace buffer, find the gap_enter and
		 * STOP the del produced, report how far off we landed */
		usleep(1500000);
		FILE *tf = fopen("/sys/kernel/tracing/trace", "r");
		if (tf) {
			char l2[512];
			unsigned long long ge = 0, stop = 0;
			while (fgets(l2, sizeof(l2), tf)) {
				char *p;
				if (strstr(l2, tname) && (p = strstr(l2, "gap_enter=")))
					ge = strtoull(p + 10, NULL, 10);
				if (strstr(l2, tname) && (p = strstr(l2, "STOP at=")))
					stop = strtoull(p + 8, NULL, 10);
			}
			fclose(tf);
			if (ge && stop) {
				long long miss = (long long)(stop - ge);
				fprintf(stderr, "[=] MISS-BY=%lld (stop-gap_enter, want 0..200000)\n", miss);
				printf("%lld\n", miss);	/* stdout for the driver */
			}
		}
		return rc != 0;
	}
	return 1;
}

------------------------- guest scripts -------------------------

----- setup.sh -----
#!/bin/bash
# setup.sh - F-026 guest setup: two rxe endpoints presenting as IB, ipoib up.
# NICs: enp0s3 = slirp (ssh/internet); enp0s4+enp0s5 = same L2 hub (ipoib pair).
set -x
mount -t configfs none /sys/kernel/config 2>/dev/null
mount -t tracefs none /sys/kernel/tracing 2>/dev/null

ip link set enp0s4 up
ip link set enp0s5 up

rdma link add rxe0 type rxe netdev enp0s4
rdma link add rxe1 type rxe netdev enp0s5
sleep 1

ip addr add 10.99.0.1/24 dev ib0
ip link set ib0 up
ip addr add 10.99.0.2/24 dev ib1
ip link set ib1 up
sleep 1
ip -brief addr show ib0
ip -brief addr show ib1

ping -c2 -W2 10.99.0.2 -I ib0 && echo PING-OK
ip neigh show dev ib0
echo SETUP-DONE

----- churn3.sh -----
#!/bin/bash
# churn3.sh - fast AH churn on ib0 (static PERMANENT neighs + one UDP each,
# then explicit neigh del -> AHs to dead_ahs).  ib0 must have a /16 alias.
N=${1:-500}
LOOPS=${2:-9999}

ip addr add 10.99.0.1/16 dev ib0 2>/dev/null	# widen the on-link subnet

mklladdr() {
	local i=$1
	printf '80:00:00:10:52:54:00:12:%02x:%02x:00:00:00:00:00:00:00:%02x:%02x:01' \
		$(( (i >> 8) & 255 )) $(( i & 255 )) $(( (i >> 8) & 255 )) $(( i & 255 ))
}

for l in $(seq 1 $LOOPS); do
	for i in $(seq 1 $N); do
		a=10.99.$(( i >> 8 )).$(( i & 255 ))
		ip neigh replace $a lladdr $(mklladdr $i) dev ib0 2>/dev/null
	done
	/root/churn_send16 $N 2>/dev/null || /root/churn_send16 $N
	for i in $(seq 1 $N); do
		ip neigh del 10.99.$(( i >> 8 )).$(( i & 255 )) dev ib0 2>/dev/null
	done
	echo "loop $l done ($(date +%T))"
done

----- churn_send16.c -----
// SPDX-License-Identifier: GPL-2.0
/*
 * churn_send16.c - one UDP datagram at each 10.99.Hi.Lo neighbor on ib0
 * so ipoib creates a real AH per neighbor (path lookup -> SA shim -> rxe AH).
 *
 * usage: churn_send16 <count>
 */
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>
#include <arpa/inet.h>
#include <sys/socket.h>

int main(int argc, char **argv)
{
	int n = argc > 1 ? atoi(argv[1]) : 500;
	int fd = socket(AF_INET, SOCK_DGRAM, 0);
	char buf[64] = "f026";
	struct sockaddr_in sa;
	int i, sent = 0;

	if (fd < 0) {
		perror("socket");
		return 1;
	}

	memset(&sa, 0, sizeof(sa));
	sa.sin_family = AF_INET;
	sa.sin_port = htons(9999);

	for (i = 1; i <= n; i++) {
		char ip[32];
		snprintf(ip, sizeof(ip), "10.99.%d.%d", (i >> 8) & 255, i & 255);
		inet_pton(AF_INET, ip, &sa.sin_addr);
		if (sendto(fd, buf, sizeof(buf), 0,
			   (struct sockaddr *)&sa, sizeof(sa)) >= 0)
			sent++;
	}
	close(fd);
	printf("churn_send16: fired %d datagrams\n", sent);
	return 0;
}

----- race.sh -----
#!/bin/bash
# race.sh - F-026 closed-loop sweep: trigger prints MISS-BY (where the
# teardown's stop landed vs the reaper gap), we steer the next offset to
# land 100us into the 200us widened gap.
IF=ib0
off=-4000000	# first guess: syscall latency is ~3.9ms
MAX=${1:-300}

for i in $(seq 1 $MAX); do
	rdma link del rxe0 2>/dev/null; sleep 0.5
	rdma link add rxe0 type rxe netdev enp0s4; sleep 1
	ip addr add 10.99.0.1/16 dev $IF 2>/dev/null; ip link set $IF up; sleep 1
	echo > /sys/kernel/tracing/trace
	/root/churn3.sh 300 1 >/dev/null 2>&1

	miss=$(/root/trigger rxe0 $IF $off 2>/dev/null | tail -1)
	case "$miss" in ''|*[!0-9-]*)
		echo "shot $i: off=$off no-measurement"
		continue ;;
	esac
	echo "shot $i: off=$off miss=$miss"
	off=$(( off - miss + 100000 ))

	if grep -q 'ESCAPED-ARM' /sys/kernel/tracing/trace || dmesg | grep -qE 'BUG: KASAN|Oops'; then
		echo "=== HIT at off=$off (shot $i) ==="
		grep -E 'reap_ah|ESCAPED' /sys/kernel/tracing/trace | tail -20
		dmesg | grep -E 'KASAN|Oops|Call Trace|RIP' | tail -30
		echo "HIT-OFFSET=$off shot=$i" > /root/HIT
		poweroff -f
	fi
done
echo "done $MAX shots, no hit"

 drivers/infiniband/ulp/ipoib/ipoib_ib.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/infiniband/ulp/ipoib/ipoib_ib.c b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
index 81bbb3f7c113..5ed4f709cb40 100644
--- a/drivers/infiniband/ulp/ipoib/ipoib_ib.c
+++ b/drivers/infiniband/ulp/ipoib/ipoib_ib.c
@@ -736,11 +736,11 @@ static void ipoib_start_ah_reaper(struct ipoib_dev_priv *priv)
 static void ipoib_stop_ah_reaper(struct ipoib_dev_priv *priv)
 {
 	set_bit(IPOIB_STOP_REAPER, &priv->flags);
-	cancel_delayed_work(&priv->ah_reap_task);
+	cancel_delayed_work_sync(&priv->ah_reap_task);
 	/*
 	 * After ipoib_stop_ah_reaper() we always go through
-	 * ipoib_reap_dead_ahs() which ensures the work is really stopped and
-	 * does a final flush out of the dead_ah's list
+	 * ipoib_reap_dead_ahs() which does a final flush out of the
+	 * dead_ah's list
 	 */
 }
 
-- 
2.25.1

