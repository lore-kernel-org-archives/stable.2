Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793354764;
	b=2jNMWagEIkh9C+YES7Y7XTF36Hyv16ivbWCq+trqH9zeuQluJfASUizy1raa3BmB9psj
	 kTPqTIR4GadqMmmGSA9ibtIkOCy/px0BOwNUqjhZXNG6207CkgW5MEDPx3IuhdqmVk0dO
	 7V+uecdDSEbA8P+9KdJcZFG6HTJZHJvZcK5FDnnPiNhSQT+al2sW2n2akJ4+XwfDH3vwV
	 9CErpyXMQsfqJEPDfPjg0IsX0+dxzcNLcp/Qz/9aDYMAGEgOwQLr+zlGRc8e7zcIFYbiM
	 l3tEnDagzN3t9d7TnyZN87METapmuDYiLeIyN0gvXM3a0h1nl+C30nlbxP47Kh33CrA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793354764;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=7+KhCK8nbtPPPnxE6PcA8d9mBVnldjGZ8TKiU45jN9I=;
	b=pzkCVYZ8a48s/IdByXdn0KkfjRanmk+WjwSeB6nA6M4VbNCS7X3wDci1TDcym7TmMJb4
	 pUAthbVBl6K+HnJccgTBe39dGLrAfd91ISG2ugdPxvTOqBmTXzkqJSXw0psNxqr/91KxM
	 n8hIomzI14BvThAhJAYUB8ehzf3zMPDuevmM1cFZzbFXJC26BLO2ZI8kVj3Kx747SZvnB
	 qUr9eElft/Fbgjg3kXw5wZDXZlLaUd9bnOTX8lbvFZaRF1eFr1EGEmbntasGgRoHYmwUm
	 kng570ZGSjjFEyzLEXYDDSc/NzjgUWNPMHMziRKGPqYEkJkdkyoVALSvg2w44I4KrPA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e2GJL6qm;
	arc=none smtp.remote-ip=209.85.128.48
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DC87606A325
	for <stable@vger.kernel.org>; Fri, 30 Oct 2026 10:06:04 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 5DC87606A325
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=e2GJL6qm
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-4a140e7405dso5238455e9.3
        for <stable@vger.kernel.org>; Fri, 30 Oct 2026 03:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793354763; x=1793959563; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=7+KhCK8nbtPPPnxE6PcA8d9mBVnldjGZ8TKiU45jN9I=;
        b=e2GJL6qmANVTnlHfA1bxL2NGnZc6wH8XAwqMoR5GLxXV6vUbYQCA9ZvxVgPtbKX42b
         gAdX5mEXx8zPqQ852wU77eEwBVGhv9Qv/680bMJru8zRScXAwfAZft3uO931QgLIOC0z
         F7mcUWoordixAfJxKwR5EP5ZWYog9epQnHzW4kTtHmyepM3AYh4RYJYhXioqI82+dbgL
         xNcGG6/0Xojfm+ie+M/4v8gWEk5R1zf71VyIG02WIrKxmPJU9zz1EWpJv6x87yj/TGkd
         LTiJg5GUtMxPlIDdfVAoXImC9to8J6fir/Ref1HUQIvQ6GUoz3FbGLeZaW6stIl4Htbq
         4jSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793354763; x=1793959563;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=7+KhCK8nbtPPPnxE6PcA8d9mBVnldjGZ8TKiU45jN9I=;
        b=18nwfoGjcbcUQzDo2RzjGLdJ7tbYKEkB7zwQ30Kc2oIcsRnzQWJO2pgG1wKKe2PQ0h
         PRD2TQLNMLID08c+8PlIO6zdQPXM8vM5dMWLojpn7rQEHOQ4rTY9SZ0APrZH9U/4B2qx
         I09yoR7IQOecDefgai9MKfQXhUNiDJAnXZ1OszpRdac5f8Cg4QOLJbnWckAETwszDlI1
         nuYCetaSPWwgfh6hF3V+FJn6Hio8jR6exITl8AuxQU3loEyNxXc8IIZNugwcC+wWPXgj
         r5TTHYwxpO9ZJ5xgneCCIzhHiKZ+VElLr8Zz3BvB9BgxgygjBsWi/W83IOx6IO5YGPnb
         NsiA==
X-Forwarded-Encrypted: i=1; AKwUvBzFBxNQ+QqucE0FH36m8P+/x0X9b9S3tbtqjV3xgbr332fihsrAHTR8wgBUR0pg2MhVxdlCg0A=@vger.kernel.org
X-Gm-Message-State: AFq9FYJ12u1GTkBDAgMvNBcsM9ztanxRmQYUzQwRlj2HdPPsKLxM7IdJ
	cVy5hlcnwPySqesEHGTpYDn8h+s+9kGqtdgqgw7jSfCGKQeeCt3J3n3x
X-Gm-Gg: AYBFou2xIgHb7g+8xJuHweCXwfFy2qA7IU8fv1yQQjWFQPd1yWaG/m6tjmTdMft+h0c
	g9HlOnK6QdP4sfU8Bj7Gy298TaW9DkgoDsYEDvW4bPOvoPEh2D6F1fJHN0Vef8SXfFJTGeU2hhu
	x3vjjQY9iqjsHsADyweqVQM9tLhVI85qvW09ehYY37OmZgYsDxYC9xYSki/4Y45WXTCKm0edMvq
	yTIoaII0T0voe3ut4NCOzuBuoSTYA8MzfM0t7wG4s8KF7H3NWDw0naj3mk814XyuKxUyFwTdLVO
	EF7CN3uQiAhzNXqHscQhhcTREahxtTTqrb3HsHafXQ9vqaQzFk1S8HREbXPz8YIdncD0UdYmOUu
	uVRbAUFBYKdIGsAl7cxk6hrs9/tfwnVFmoDrQ6D0gTpOLUjMrDvIXedEXAh3ZUOuoVvRr4RpbC4
	cKpE/cpIiYXcn2Sjqmv0xFGIucuZGcUy8XHzTCobBnL66Y3I9DHB+ZjrBvpA46HkRljkG5YoH2s
	Fdjejd1hK1/DB8+SyJni1+Z4G6vyyMCkgSE+WGaq/HOi0ziibUiQFKwT4J/HCQji129OL0Zd+T3
	b4anp4Wl+HT628qJQWQfDXyvCH8ku+rgE2z4Qw7oSsi/LPdiDx2KUF7B1KdC1ZRrOuOY8UbtoC+
	/Ir6Lot8=
X-Received: by 2002:a05:600c:8b47:b0:4a2:1960:6db with SMTP id 5b1f17b1804b1-4ac185bc2aemr37877015e9.26.1793354761147;
        Fri, 30 Oct 2026 03:06:01 -0700 (PDT)
Received: from pop-os.. ([51.36.40.122])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4ac0a66caefsm36175695e9.5.2026.10.30.03.05.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Oct 2026 03:05:59 -0700 (PDT)
From: Ahmad AG <ahmadag1001@gmail.com>
To: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
Cc: kuba@kernel.org,
	davem@davemloft.net,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Ahmad AG <ahmadag1001@gmail.com>
Subject: [PATCH net v2] net/packet: account user-triggered allocations to memcg
Date: Fri, 30 Oct 2026 13:05:04 +0300
Message-ID: <20261030100504.23498-1-ahmadag1001@gmail.com>
X-Mailer: git-send-email 2.43.0
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

A packet socket allocates memory for its user that is not charged to
the user's memory cgroup:

- PACKET_RX_RING and PACKET_TX_RING: the ring blocks themselves
  (alloc_one_pg_vec_page(), both the page allocation and the vmalloc
  fallback), the block array (alloc_pg_vec()), the deferred-free work
  of a TX ring, and the rx_owner_map bitmap of a TPACKET_V1/V2 RX ring.
  The size comes from the tpacket_req passed to setsockopt() and has
  no limit other than available memory.
- PACKET_FANOUT: the group created by fanout_add(), about 1 MB per
  group with max_num_members = 65536 (a 512 KB array, rounded up to an
  order-8 allocation) since commit 9c661b0b8544 ("net/packet: make
  packet_fanout.arr size configurable up to 64K"), and the per-socket
  rollover state.
- PACKET_ADD_MEMBERSHIP: one struct packet_mclist per distinct entry
  (packet_mc_add()), with no limit on the number of entries.
- socket(): the per-CPU TX ring pending counter
  (packet_alloc_pending()).

A process with CAP_NET_RAW, which an unprivileged user has in its own
user and network namespace, can therefore pin kernel memory far beyond
the memory.max of its cgroup. With memory.max set to 16M, a test
running as uid 1000 took 525804 KB of system memory with 64 sockets
each mapping an 8 MB TPACKET_V2 RX ring (1 MB blocks) while
memory.current grew by 892 KB; 264640 KB with 256 sockets each
creating a fanout group with max_num_members = 65536 (memory.current
+512 KB); and 46664 KB with 100 sockets holding 2000 PACKET_MR_PROMISC
entries each on lo (memory.current +256 KB).

Allocate all of these with GFP_KERNEL_ACCOUNT, as other allocations a
user can make on demand in the networking stack already do, for
example the AF_XDP rings since commit b0057c68df71 ("xsk: account
ring allocations to memcg"). vzalloc() takes no gfp mask, so the
vmalloc fallback becomes __vmalloc() with __GFP_ZERO. skbs are bounded by
sk_rcvbuf and sk_sndbuf and are left as they are, as is the per-packet
zerocopy state in tpacket_snd(), which lives only as long as its skb.
struct packet_sock itself comes from sk_alloc(), and the
netdev_hw_addr entries that PACKET_MR_MULTICAST and PACKET_MR_UNICAST
add through dev_mc_add() and dev_uc_add() live in net/core; neither
is changed here.

With the change each of the three tests in the 16M cgroup is stopped
by the cgroup's OOM killer. With a higher memory.max the rings charge
525436 KB for 524832 KB of system memory used (1G), the fanout groups
262656 KB for 265128 KB (1G), and the membership entries 26880 KB
(1G). These figures are from a KASAN kernel, which inflates the small
objects; without KASAN the 200000 membership entries are 20480 KB
charged for 26412 KB used.

The missing charges were found by code inspection of net/packet/ with
the help of an LLM and then triggered with a small test program that
creates the sockets, rings, groups and entries and reads
memory.current; the numbers above are from that program. Tested in a
QEMU/KVM guest on this tree (x86_64_defconfig plus kvm_guest.config,
KASAN, MEMCG, PACKET), running the test as uid 1000 in a cgroup v2
memory cgroup. tools/testing/selftests/net/psock_fanout, psock_tpacket
and psock_snd.sh pass before and after.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Assisted-by: Claude Code
Signed-off-by: Ahmad AG <ahmadag1001@gmail.com>
---
v2: cover every user-triggered allocation in net/packet in one patch, as
Willem suggested on v1, and resend with git send-email; the v1 mail had
tabs replaced and lines wrapped by the mail client. v1 changed only the
fanout group allocation.
v1: https://lore.kernel.org/netdev/CAASqGyZ-9hqZGWNJShxnrSiXDO==51SVsQW_x_mk993y1pNO8A@mail.gmail.com/

 net/packet/af_packet.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/net/packet/af_packet.c b/net/packet/af_packet.c
index 823e0911c91..06386db4c8e 100644
--- a/net/packet/af_packet.c
+++ b/net/packet/af_packet.c
@@ -1233,7 +1233,8 @@ static int packet_alloc_pending(struct packet_sock *po)
 {
 	po->rx_ring.pending_refcnt = NULL;
 
-	po->tx_ring.pending_refcnt = alloc_percpu(unsigned int);
+	po->tx_ring.pending_refcnt = alloc_percpu_gfp(unsigned int,
+						      GFP_KERNEL_ACCOUNT);
 	if (unlikely(po->tx_ring.pending_refcnt == NULL))
 		return -ENOBUFS;
 
@@ -1735,7 +1736,7 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
 	if (type == PACKET_FANOUT_ROLLOVER ||
 	    (type_flags & PACKET_FANOUT_FLAG_ROLLOVER)) {
 		err = -ENOMEM;
-		rollover = kzalloc_obj(*rollover);
+		rollover = kzalloc_obj(*rollover, GFP_KERNEL_ACCOUNT);
 		if (!rollover)
 			goto out;
 		atomic_long_set(&rollover->num, 0);
@@ -1778,7 +1779,8 @@ static int fanout_add(struct sock *sk, struct fanout_args *args)
 			/* legacy PACKET_FANOUT_MAX */
 			args->max_num_members = 256;
 		err = -ENOMEM;
-		match = kvzalloc_flex(*match, arr, args->max_num_members);
+		match = kvzalloc_flex(*match, arr, args->max_num_members,
+				      GFP_KERNEL_ACCOUNT);
 		if (!match)
 			goto out;
 		write_pnet(&match->net, sock_net(sk));
@@ -3773,7 +3775,7 @@ static int packet_mc_add(struct sock *sk, struct packet_mreq_max *mreq)
 		goto done;
 
 	err = -ENOBUFS;
-	i = kmalloc_obj(*i);
+	i = kmalloc_obj(*i, GFP_KERNEL_ACCOUNT);
 	if (i == NULL)
 		goto done;
 
@@ -4494,7 +4496,7 @@ static void packet_free_tx_ring(struct sock *sk, struct pgv *pg_vec,
 static char *alloc_one_pg_vec_page(unsigned long order)
 {
 	char *buffer;
-	gfp_t gfp_flags = GFP_KERNEL | __GFP_COMP |
+	gfp_t gfp_flags = GFP_KERNEL_ACCOUNT | __GFP_COMP |
 			  __GFP_ZERO | __GFP_NOWARN | __GFP_NORETRY;
 
 	buffer = (char *) __get_free_pages(gfp_flags, order);
@@ -4502,7 +4504,8 @@ static char *alloc_one_pg_vec_page(unsigned long order)
 		return buffer;
 
 	/* __get_free_pages failed, fall back to vmalloc */
-	buffer = vzalloc(array_size((1 << order), PAGE_SIZE));
+	buffer = __vmalloc(array_size((1 << order), PAGE_SIZE),
+			   GFP_KERNEL_ACCOUNT | __GFP_ZERO);
 	if (buffer)
 		return buffer;
 
@@ -4523,7 +4526,8 @@ static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring
 	struct pgv *pg_vec;
 	int i;
 
-	vec = kzalloc_flex(*vec, pg_vec, block_nr, GFP_KERNEL | __GFP_NOWARN);
+	vec = kzalloc_flex(*vec, pg_vec, block_nr,
+			   GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 	if (unlikely(!vec))
 		return NULL;
 	vec->order = order;
@@ -4532,7 +4536,7 @@ static struct pgv *alloc_pg_vec(struct tpacket_req *req, int order, bool tx_ring
 
 	if (tx_ring) {
 		vec->deferred = kzalloc_obj(*vec->deferred,
-					    GFP_KERNEL | __GFP_NOWARN);
+					    GFP_KERNEL_ACCOUNT | __GFP_NOWARN);
 		if (!vec->deferred)
 			goto out_free_pgvec;
 		vec->deferred->vec = vec;
@@ -4648,7 +4652,7 @@ static int packet_set_ring(struct sock *sk, union tpacket_req_u *req_u,
 		default:
 			if (!tx_ring) {
 				rx_owner_map = bitmap_alloc(req->tp_frame_nr,
-					GFP_KERNEL | __GFP_NOWARN | __GFP_ZERO);
+					GFP_KERNEL_ACCOUNT | __GFP_NOWARN | __GFP_ZERO);
 				if (!rx_owner_map)
 					goto out_free_pg_vec;
 			}

base-commit: c339f4010dea8b0d754f84ace70cd1b089878ef8
-- 
2.43.0

