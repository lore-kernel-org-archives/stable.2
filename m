Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.70.43.100
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795437098;
	b=AZeVP7j1gIPQtX9X+9TLo6LxMxMz1TsIjihZAfCmYSRT8e34PlOvMUEuuk6AzTdGsJnx
	 RZtqvNewivj0qnAPkJc8bZ9W8bfbDN0aWMfI7HPuB7OhN1nuRZHc7bC3ESl4gFT0P5wcB
	 Qhrx9JuMPu6j8XEnSmeK+FucceB9UktNXeQo1WfyhRIg1gsXA0SdCHw+5dxuoBOAMt1A9
	 3Cq/GkNikdaBvBc0Y8VlV2YNkOxXD/dcsX89/GOkf9urcRcjjbK9RPJQArZuol5XVebSJ
	 njjCMQ+YZskdrUCRqQb0kSF+Iu4JpV/d2goIHyDjMuOv8rg78MS5CRvXpx3zF2UVR9A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795437098;
	h=DMARC-Filter:DKIM-Signature:Date:To:From:Cc:Subject:Message-ID:
	 In-Reply-To:References:Feedback-ID:X-Pm-Message-ID:MIME-Version:
	 Content-Type;
	bh=L2yPIhyBQV7RPo2ReCzKyh/mpAYLjnCAGbEpJpcII3U=;
	b=AQzC7TlQjhwLLMjSGCqsYhezWKBZokPcIfEj/oT3/LF7a9Gm/h89+ByefpKgQdVA3iMY
	 PIuIJaz4tQ4utTKjXRXyu1vvdBdj5C+1sbMg7VZYf+LofdwXUea+slXX3GFY8vp0fAa+J
	 stK96ye1HzYzmNB2lUtjBP1+o/OVV430U0M1f0+AUZ09sdwEmvIo+5dyEGWsnJkNRaZxL
	 Eak0A+TnL3ORNLP7H8cGAMNgpa6OUHFTJEtMGS4CRBTVkC1DOFB1z5QHXhWpQ3otl/8im
	 WhdODznyuL2xxUqiqb2v8NPc9VgFzFVQCA3lONqC9Laqypxxhm8gNse0xZuXWIHYNKA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=pm.me;
	spf=pass smtp.mailfrom=pm.me;
	dkim=pass header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=orGAHYfC;
	arc=none smtp.remote-ip=185.70.43.100
Received: from mail-43100.protonmail.ch (mail-43100.protonmail.ch [185.70.43.100])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C52B606A31F
	for <stable@vger.kernel.org>; Mon, 23 Nov 2026 12:31:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2C52B606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=pm.me
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pm.me
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pm.me header.i=@pm.me header.a=rsa-sha256 header.s=protonmail3 header.b=orGAHYfC
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pm.me;
	s=protonmail3; t=1795437095; x=1795696295;
	bh=L2yPIhyBQV7RPo2ReCzKyh/mpAYLjnCAGbEpJpcII3U=;
	h=Date:To:From:Cc:Subject:Message-ID:In-Reply-To:References:
	 Feedback-ID:From:To:Cc:Date:Subject:Reply-To:Feedback-ID:
	 Message-ID:BIMI-Selector;
	b=orGAHYfCAh/lZAMNLANfqkImnJkAZx7I0N2gPUn2w43PmkCvXmNgS2NxjuYIsmrz0
	 mzVF5+F9yLgu7pAxg4kOFIlMKMkt6Pg1F/0qu9Kfkhw9yiKci+BN8/KulgDJYBk5Ii
	 Q7xAd4061oaXr8nu7hDsbqhRe9YSvcQ2E4vJPGxhIVs4g1so9xhGhjqytp5vXpC3QO
	 mQi4azq0ihr9qSuRJc3VBJBz8pgMXAqDOZTE6f4CijtDLw+RYA/RawTa2FdbCyfzwc
	 byOjDRU4ptYNlLyAD/63tpSEz8QK5S4JVdRr2urb9XsD3dOyPX+CStsVM5r1mch4tG
	 Kzk30t+OP8SVg==
Date: Mon, 23 Nov 2026 12:31:31 +0000
To: Jiaming Fan <fan.jiaming@hotmail.com>
From: fadouse <fadouse@pm.me>
Cc: "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowangio@gmail.com>, =?utf-8?Q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, Linfeng Sun <linfeng.sun.dev@gmail.com>, Fang Xieyan <fangxy@xiaopeng.com>, kvm@vger.kernel.org, virtualization@lists.linux.dev, netdev@vger.kernel.org, linux-kernel@vger.kernel.org, stable@vger.kernel.org
Subject: Re: [PATCH] vhost: mask the in-order used-ring log cursor
Message-ID: <UyUECMkza3HsE8hlpqg49_Lm19szdV5Hc9zB7OETazRoRNW-HGoOQBwhufIzmdCbvO8WNSuWqN6mL1cZHGDY_keWvbNqVZI3H9MA1dYzBJM=@pm.me>
In-Reply-To: <OS3PR01MB10251C7A76A9ED480E3C497FEE7452@OS3PR01MB10251.jpnprd01.prod.outlook.com>
References: <20261122-b4-06-vhost-in-order-log-oob-v1-35efdba8fbab-v1-1-fc1253d60351@pm.me> <OS3PR01MB10251C7A76A9ED480E3C497FEE7452@OS3PR01MB10251.jpnprd01.prod.outlook.com>
Feedback-ID: 173252840:user:proton
X-Pm-Message-ID: 5cf0a3bb38be6b505433c93e8bf104a4c41df515
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pgp-signature"; micalg=pgp-sha512; boundary="------131195ce22d4e3494741ac7e4a8fcd905c43f07926a9b8163a5d63b446f9ad82"; charset=utf-8

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--------131195ce22d4e3494741ac7e4a8fcd905c43f07926a9b8163a5d63b446f9ad82
Content-Type: multipart/mixed;boundary=---------------------db2a6f9e247f33a80a9db7509317076d

-----------------------db2a6f9e247f33a80a9db7509317076d
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;charset=utf-8

Hi Jiaming,

> The mask looks right to me. What I don't follow is how `nheads[0]`
> gets to 64 on a 32-entry queue. Those buffers haven't been returned to
> the driver yet, so what can it put back on the ring? Can this happen
> with a conforming driver, or does the test guest reuse descriptors
> that are still in flight?

It is a non-conforming guest reusing in-flight ring slots; a conforming
driver would not advance avail->idx past last_used_idx + vq->num.

vhost accepts this because vhost_get_avail_idx() checks against
vq->last_avail_idx rather than vq->last_used_idx:

  if (unlikely((u16)(avail_idx - vq->last_avail_idx) > vq->num))

With vq->num =3D 32 and an 8180-byte frame (+ 12B vnet hdr =3D 64 x 128B
buffers) followed by a 64-byte frame (1 buffer):

  1. Guest publishes avail->idx =3D 32 and kicks.  get_rx_bufs() runs dry
     at 32 buffers and calls vhost_discard_vq_desc(), rewinding
     last_avail_idx to 0 while leaving vq->avail_idx =3D 32 cached.
  2. Guest advances avail->idx to 64 and kicks again.
     vhost_get_vq_desc_n() consumes cached 0..31 (last_avail_idx -> 32,
     last_used_idx still 0), then refreshes avail->idx =3D 64:
     (u16)(64 - 32) =3D=3D 32 <=3D vq->num passes, so get_rx_bufs() collec=
ts
     32..63 into the same frame (nheads[0] =3D 64).
  3. The test polls buf0[12] (with pages 1..31 dropped via
     madvise(MADV_DONTNEED) to widen the copy window) and tries to
     publish avail->idx =3D 65 during the frame-0 copy so handle_rx() can
     pick up the 1-buffer frame and flush both in a single
     vhost_add_used_n_in_order() batch (count =3D 2, nheads =3D {64, 1}).

(Minor correction to my commit message: without VIRTIO_RING_F_EVENT_IDX
the used ring is 260 bytes at [0x7ef8, 0x7ffc) rather than 262 bytes;
vq_log_used_access_ok() still validates only log_base[0], and the
unmasked flush logs [0x7ffc, 0x8004) into log_base[1].)

> Could you share the RX test program you used?

Build with `gcc -O2 -Wall -Wextra test_vhost_inorder.c -o test_vhost_inord=
er`
and run as root (exit 2 =3D bug reproduced, 0 =3D fixed, 3 =3D timing retr=
y):

----8<----
// SPDX-License-Identifier: GPL-2.0
#include <arpa/inet.h>
#include <errno.h>
#include <fcntl.h>
#include <linux/if_tun.h>
#include <linux/vhost.h>
#include <linux/virtio_config.h>
#include <linux/virtio_net.h>
#include <linux/virtio_ring.h>
#include <net/if.h>
#include <netpacket/packet.h>
#include <stdint.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <sys/eventfd.h>
#include <sys/ioctl.h>
#include <sys/mman.h>
#include <sys/socket.h>
#include <unistd.h>

#define GUEST_MEM_SIZE	(16UL * 1024 * 1024)
#define IOVA_DESC	0x0000
#define IOVA_AVAIL	0x1000
#define IOVA_USED	0x7ef8
#define BUF_IOVA_BASE	0x20000
#define VQ_NUM		32
#define BUF_LEN		128
#define FRAME0_LEN	8180	/* + 12B vnet hdr =3D 64 * 128B */
#define FRAME1_LEN	64
#define NHEADS0		64
#define TOTAL_AVAIL	65

typedef uint8_t  u8;
typedef uint16_t u16;
typedef uint64_t u64;

static void die(const char *msg)
{
	fprintf(stderr, "%s: %s\n", msg, strerror(errno));
	exit(1);
}

static void publish_avail(struct vring_avail *avail, u16 v)
{
	__atomic_store_n(&avail->idx, v, __ATOMIC_RELEASE);
}

static void kick(int efd)
{
	u64 one =3D 1;

	if (write(efd, &one, sizeof(one)) !=3D sizeof(one))
		die("kick");
}

int main(void)
{
	int vfd, tfd, pkt, sock, kick_fd, call_fd, ifindex;
	struct ifreq ifr =3D {};
	struct vring_desc *desc;
	struct vring_avail *avail;
	struct vring_used *used;
	struct sockaddr_ll sll =3D {};
	unsigned char frame0[FRAME0_LEN], frame1[FRAME1_LEN];
	struct {
		struct vhost_memory m;
		struct vhost_memory_region r[1];
	} memtable =3D {
		.m =3D { .nregions =3D 1 },
		.r =3D { { .guest_phys_addr =3D 0, .memory_size =3D GUEST_MEM_SIZE } },
	};
	struct vhost_vring_state vs =3D {};
	struct vhost_vring_addr va =3D {};
	struct vhost_vring_file vf =3D {};
	u64 features, log_base_ptr;
	void *guest_mem;
	unsigned char *log_base;
	u8 *buf0;

	guest_mem =3D mmap(NULL, GUEST_MEM_SIZE, PROT_READ | PROT_WRITE,
			 MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
	if (guest_mem =3D=3D MAP_FAILED)
		die("mmap guest_mem");
	log_base =3D mmap(NULL, 4096, PROT_READ | PROT_WRITE,
			MAP_PRIVATE | MAP_ANONYMOUS | MAP_POPULATE, -1, 0);
	if (log_base =3D=3D MAP_FAILED)
		die("mmap log_base");

	desc  =3D (struct vring_desc *)((u8 *)guest_mem + IOVA_DESC);
	avail =3D (struct vring_avail *)((u8 *)guest_mem + IOVA_AVAIL);
	used  =3D (struct vring_used *)((u8 *)guest_mem + IOVA_USED);
	buf0  =3D (u8 *)guest_mem + BUF_IOVA_BASE;

	for (int i =3D 0; i < VQ_NUM; i++) {
		desc[i] =3D (struct vring_desc){
			.addr  =3D BUF_IOVA_BASE + 4096 * i,
			.len   =3D BUF_LEN,
			.flags =3D VRING_DESC_F_WRITE,
		};
		avail->ring[i] =3D i;
	}
	for (int i =3D 1; i < VQ_NUM; i++)
		madvise((u8 *)guest_mem + BUF_IOVA_BASE + 4096 * i,
			4096, MADV_DONTNEED);

	tfd =3D open("/dev/net/tun", O_RDWR);
	if (tfd < 0)
		die("open /dev/net/tun");
	ifr.ifr_flags =3D IFF_TAP | IFF_NO_PI | IFF_VNET_HDR;
	snprintf(ifr.ifr_name, IFNAMSIZ, "vh%d", getpid() % 1000);
	if (ioctl(tfd, TUNSETIFF, &ifr))
		die("TUNSETIFF");
	{
		int hdr_sz =3D 12;

		if (ioctl(tfd, TUNSETVNETHDRSZ, &hdr_sz))
			die("TUNSETVNETHDRSZ");
	}
	{
		char path[128];
		int fd;

		snprintf(path, sizeof(path),
			 "/proc/sys/net/ipv6/conf/%s/disable_ipv6",
			 ifr.ifr_name);
		fd =3D open(path, O_WRONLY);
		if (fd >=3D 0) {
			if (write(fd, "1", 1) < 0) {}
			close(fd);
		}
	}

	sock =3D socket(AF_INET, SOCK_DGRAM, 0);
	if (sock < 0)
		die("socket");
	if (ioctl(sock, SIOCGIFFLAGS, &ifr))
		die("SIOCGIFFLAGS");
	ifr.ifr_flags |=3D IFF_UP | IFF_RUNNING;
	if (ioctl(sock, SIOCSIFFLAGS, &ifr))
		die("SIOCSIFFLAGS");
	if (ioctl(sock, SIOCGIFINDEX, &ifr))
		die("SIOCGIFINDEX");
	ifindex =3D ifr.ifr_ifindex;
	ifr.ifr_mtu =3D 9000;
	if (ioctl(sock, SIOCSIFMTU, &ifr))
		die("SIOCSIFMTU");

	pkt =3D socket(AF_PACKET, SOCK_RAW, htons(ETH_P_ALL));
	if (pkt < 0)
		die("socket packet");
	sll.sll_family =3D AF_PACKET;
	sll.sll_protocol =3D htons(ETH_P_ALL);
	sll.sll_ifindex =3D ifindex;
	if (bind(pkt, (struct sockaddr *)&sll, sizeof(sll)))
		die("bind");

	vfd =3D open("/dev/vhost-net", O_RDWR);
	if (vfd < 0)
		die("open /dev/vhost-net");
	if (ioctl(vfd, VHOST_SET_OWNER, 0))
		die("VHOST_SET_OWNER");
	memtable.r[0].userspace_addr =3D (u64)guest_mem;
	if (ioctl(vfd, VHOST_SET_MEM_TABLE, &memtable))
		die("VHOST_SET_MEM_TABLE");
	log_base_ptr =3D (u64)log_base;
	if (ioctl(vfd, VHOST_SET_LOG_BASE, &log_base_ptr))
		die("VHOST_SET_LOG_BASE");

	features =3D (1ULL << VIRTIO_NET_F_MRG_RXBUF) |
		   (1ULL << VIRTIO_F_IN_ORDER) |
		   (1ULL << VHOST_F_LOG_ALL);
	if (ioctl(vfd, VHOST_SET_FEATURES, &features))
		die("VHOST_SET_FEATURES");

	kick_fd =3D eventfd(0, 0);
	call_fd =3D eventfd(0, 0);
	if (kick_fd < 0 || call_fd < 0)
		die("eventfd");

	vs.num =3D VQ_NUM;
	if (ioctl(vfd, VHOST_SET_VRING_NUM, &vs))
		die("VHOST_SET_VRING_NUM");
	vs.num =3D 0;
	if (ioctl(vfd, VHOST_SET_VRING_BASE, &vs))
		die("VHOST_SET_VRING_BASE");

	va.flags =3D 1U << VHOST_VRING_F_LOG;
	va.desc_user_addr =3D (u64)desc;
	va.avail_user_addr =3D (u64)avail;
	va.used_user_addr =3D (u64)used;
	va.log_guest_addr =3D IOVA_USED;
	if (ioctl(vfd, VHOST_SET_VRING_ADDR, &va))
		die("VHOST_SET_VRING_ADDR");

	vf.fd =3D kick_fd;
	if (ioctl(vfd, VHOST_SET_VRING_KICK, &vf))
		die("VHOST_SET_VRING_KICK");
	vf.fd =3D call_fd;
	if (ioctl(vfd, VHOST_SET_VRING_CALL, &vf))
		die("VHOST_SET_VRING_CALL");
	vf.fd =3D tfd;
	if (ioctl(vfd, VHOST_NET_SET_BACKEND, &vf))
		die("VHOST_NET_SET_BACKEND");

	memset(frame0, 0xAB, sizeof(frame0));
	memset(frame1, 0xCD, sizeof(frame1));
	frame0[12] =3D frame1[12] =3D 0x08;
	frame0[13] =3D frame1[13] =3D 0x00;
	if (sendto(pkt, frame0, sizeof(frame0), 0, NULL, 0) !=3D sizeof(frame0))
		die("sendto frame0");
	if (sendto(pkt, frame1, sizeof(frame1), 0, NULL, 0) !=3D sizeof(frame1))
		die("sendto frame1");

	publish_avail(avail, VQ_NUM);
	kick(kick_fd);
	usleep(100 * 1000);
	publish_avail(avail, NHEADS0);
	kick(kick_fd);

	for (int i =3D 0; i < 5000000 && *(volatile u8 *)(buf0 + 12) =3D=3D 0; i+=
+)
		;
	publish_avail(avail, TOTAL_AVAIL);

	for (int i =3D 0; i < 30 && used->idx < TOTAL_AVAIL; i++)
		usleep(100 * 1000);

	printf("avail->idx=3D%u used->idx=3D%u log_base[0]=3D0x%02x log_base[1]=3D=
0x%02x\n",
	       avail->idx, used->idx, log_base[0], log_base[1]);
	if (used->idx !=3D TOTAL_AVAIL)
		return 3;
	return log_base[1] ? 2 : 0;
}
---->8----

unpatched: avail->idx=3D65 used->idx=3D65 log_base[0]=3D0x80 log_base[1]=3D=
0x01 (exit 2)
patched:   avail->idx=3D65 used->idx=3D65 log_base[0]=3D0x80 log_base[1]=3D=
0x00 (exit 0)

Thanks,
YanXin
-----------------------db2a6f9e247f33a80a9db7509317076d
Content-Type: application/pgp-keys; filename="publickey - fadouse@pm.me - 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="publickey - fadouse@pm.me - 0x99485AA3.asc"; name="publickey - fadouse@pm.me - 0x99485AA3.asc"

LS0tLS1CRUdJTiBQR1AgUFVCTElDIEtFWSBCTE9DSy0tLS0tCgp4ak1FYVV1T01SWUpLd1lCQkFI
YVJ3OEJBUWRBdG5ZbFN6SFRMSEEySXp1TkUxQXk4SnJLVUN4NmhQKy8KdGM0TERYQ25yZXpOSFda
aFpHOTFjMlZBY0cwdWJXVWdQR1poWkc5MWMyVkFjRzB1YldVK3dzQVJCQk1XCkNnQ0RCWUpwUzQ0
eEF3c0pCd2tRdVoxZ3QrWG0yWFJGRkFBQUFBQUFIQUFnYzJGc2RFQnViM1JoZEdsdgpibk11YjNC
bGJuQm5jR3B6TG05eVp6bTBCcDNlRVhSV2tuSWdDbFd3dmR4Wm1vMVhuVmI2RmthalhUVk0KMUIv
akF4VUtDQVFXQUFJQkFoa0JBcHNEQWg0QkZpRUVtVWhhbzNaL0FuQkk0TEJZdVoxZ3QrWG0yWFFB
CkFMcTJBUUQ3OEs2cGVkU1gzbGROeXFkM09IMXVNak8zdjdMWU1oTytsN2NuU0xXckVBRCtPQ1Nx
MTFTZQphS29ic1ZHckxlalRNc21Nc1BCOGpueGZpZDNoQ04rcGV3VE9PQVJwUzQ0eEVnb3JCZ0VF
QVpkVkFRVUIKQVFkQXdYZHpWSXFFSC94OEhaalIvUE90MkFpRmJFbTZZcVhYMmoydjJpS0RzUU1E
QVFnSHdyNEVHQllLCkFIQUZnbWxMampFSkVMbWRZTGZsNXRsMFJSUUFBQUFBQUJ3QUlITmhiSFJB
Ym05MFlYUnBiMjV6TG05dwpaVzV3WjNCcWN5NXZjbWRkS05RWURGV2NFVmQzeE9IZVFwNnN5bjc5
TkZwTnFrSHoraXpwSUxCblVnS2IKREJZaEJKbElXcU4yZndKd1NPQ3dXTG1kWUxmbDV0bDBBQUR6
UWdEL2NJSjA4OUprbm9nVHM2dnZRWitKCjNMUklEYUk5K1FtK1Q1cU9tTms0eVhFQkFMUElsSkNT
OGFoNWRCWVphOUwrSHFqYkRtZVNnRG81OHVTeAoraVd3KzZVTAo9TXVzVAotLS0tLUVORCBQR1Ag
UFVCTElDIEtFWSBCTE9DSy0tLS0tCg==
-----------------------db2a6f9e247f33a80a9db7509317076d--

--------131195ce22d4e3494741ac7e4a8fcd905c43f07926a9b8163a5d63b446f9ad82
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----

wrsEARYKAG0FgmsEMhIJELmdYLfl5tl0RRQAAAAAABwAIHNhbHRAbm90YXRp
b25zLm9wZW5wZ3Bqcy5vcmc6DEGO4FmydXLK4uX6uT4FRrKSW2K1NE7sPXWB
4r0ZfBYhBJlIWqN2fwJwSOCwWLmdYLfl5tl0AAAuIAD+IvChTnLjCRfefwKS
b63Mi/ku38U3TMyguYNcYTi1BaIBAMhH95MbkJJJj8oAiazsDvCQCM3kkQSL
smpgMmWhnawI
=yU1D
-----END PGP SIGNATURE-----


--------131195ce22d4e3494741ac7e4a8fcd905c43f07926a9b8163a5d63b446f9ad82--

