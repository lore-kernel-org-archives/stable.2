Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793365208;
	b=NjEfEf50stXjboVx+wIEjejasSQkqB2ZnC7RFLOSsKn0jFs9vsWqvXXTUEgBSHWvoWFU
	 TpFZwpJ75wjsmn+DgbclSlU+tcPk5QEPQjDqoBq1rm61aWrc5f/EP6PuPxKBdqJ/MWrTn
	 WM12wNnB3lVuOU1uB/nXseQBxdme9maH80ag07wTuhGTse4KiHrpAdOuo/sA1oHbIjEEq
	 h47RzAB7+ssy1kj1lG20XAZkulS57jkLmVO3FBj8zwSSZa2n+3tL+h4czBuv27b9cs+GN
	 DD+ebqigVzABXhYp0CifBTatzFztOCn2tPd9Ui1rtxc3v+7k5Vo9Hcn66iikjGbyIpw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793365208;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nH54Ozn9lZF+FVBrx7lei5cOZ6E8IORtKLKEiQ1jZr4=;
	b=gz+KO86R6UBUZS5tevXaOuYTckJEHFEugdpHXBe1ObqK8kHCVHh6LjPRCLwYhXNZY27g
	 5PKBvCjct7Ou2nCBb0X2aSUD2Xn5387rt+12azWh0lc5UxEPpsNQ9TPUV9//cEyNyQX8S
	 vZOgwHKHQsIxgaDyZawCBnoxC/WjVcXgDBpZSLdyJEFiKmo4m1nI8KHQ1N01gicKxdGWM
	 WYqrhZoWu5XUjxFkvX1PZIDetjgvsM5iUH0omT5CEYJTPtMBXvRPl/oSEixmFczVhvXey
	 5bvpKVY2TCtdyFyoumoPuD+/qZSTdq0Q1E+XCICwuYy5Cw5X5c/6ND+f9lp4LuKgOlg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYNgY22r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8280F606A31A;
	Fri, 30 Oct 2026 13:00:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FYNgY22r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 418DE1F0093A;
	Fri, 30 Oct 2026 13:00:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793365208;
	bh=nH54Ozn9lZF+FVBrx7lei5cOZ6E8IORtKLKEiQ1jZr4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FYNgY22re7rYvE39NgS16wGpTSJosu69m+/0r06rmL1AWbhBKTG40sHuB/xPVYUq3
	 0xv2m101YAbdNXa2uU5UyYMGBYBe/Vg0y7LXLL8iWpdP3UaSnsUyxj4JC+OSSKL3gz
	 Hwut5cv/G+0rX2HfQruhQpkUHNwa34DmJBhMXVxNAPu3aKBtd0GrNbIveb49uH1v7W
	 nxh31qJQkABaZ7uh14aQq2D/4NWaISfTTzm7wrN9txyyngxZWVeOBOeMGELrxssiOn
	 MKxpgUYcl6/Y4e8IAcG1n/XYsjGCbZQyPvGvaOI/Qbia2gPYchunlSWinBAG7WhIrQ
	 RjOKdBG+tEj2g==
From: Eric Dumazet <edumazet@kernel.org>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	edumazet@kernel.org,
	Willem de Bruijn <willemb@google.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Tom Herbert <tom@herbertland.com>,
	Cen Zhang <cenzhang@linux.microsoft.com>,
	AutonomousCodeSecurity@microsoft.com,
	stable@vger.kernel.org,
	Taesoo Kim <tsgatesv@gmail.com>
Subject: [PATCH net v2 2/2] net: gro: invalidate frag0 after a pull
Date: Fri, 30 Oct 2026 13:59:55 +0100
Message-ID: <20261030125955.3107383-3-edumazet@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261030125955.3107383-1-edumazet@kernel.org>
References: <20261030125955.3107383-1-edumazet@kernel.org>
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

Since commit bd56a29c7a4e ("net: gro: change skb_gro_network_header()"),
skb_gro_header_slow() no longer invalidates NAPI_GRO_CB(skb)->frag0
after pskb_may_pull(). skb_gro_may_pull() keeps comparing against the
frag0_len value set in skb_gro_reset_offset(), assuming that after a
slow pull, all later accesses are beyond frag0_len.

This is not true:

- udp4_gro_receive() and udp6_gro_receive() read the network header
  with skb_gro_network_header() after udp_gro_udphdr() pulled the
  UDP header.

- vxlan_gro_receive() calls skb_gro_remcsum_cleanup() at a lower
  offset after the inner handlers pulled their headers.

- skb_gro_remcsum_process() can pull beyond the inner Ethernet header
  before eth_gro_receive() reads it.

- napi_frags_skb() calls __skb_pull(skb, ETH_HLEN) after a slow pull,
  so frag0 still points to the Ethernet header.

If the pull consumed the first page fragment, __skb_pull_tail() released
it. If the head had to grow, pskb_expand_head() freed the old one.
These reads, and the 2-byte write in skb_gro_remcsum_cleanup(), then
access memory the skb no longer holds a reference on.

esp4_gro_receive(), esp6_gro_receive(), skb_gro_receive_list() and
udp_gro_receive_segment() also pull directly and never invalidated
frag0.

Add skb_gro_frag0_invalidate(), which only clears frag0_len, and call
it before each of these pulls. This is a single store in the slow path,
and frag0 stays non NULL, so skb_gro_network_header() does not need
a NULL test.

frag0 must be invalidated even if the pull fails: __pskb_pull_tail()
can return NULL after pskb_expand_head() freed the old head, for
instance if a frag_list member has to be cloned or pulled.

Fixes: bd56a29c7a4e ("net: gro: change skb_gro_network_header()")
Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Cc: stable@vger.kernel.org
Reported-by: Taesoo Kim <tsgatesv@gmail.com>
Reported-by: Cen Zhang <cenzhang@linux.microsoft.com>
Tested-by: Cen Zhang <cenzhang@linux.microsoft.com>
Signed-off-by: Eric Dumazet <edumazet@kernel.org>
---
 include/net/gro.h       | 10 ++++++++++
 net/core/gro.c          |  1 +
 net/ipv4/esp4_offload.c |  1 +
 net/ipv4/udp_offload.c  |  1 +
 net/ipv6/esp6_offload.c |  1 +
 5 files changed, 14 insertions(+)

diff --git a/include/net/gro.h b/include/net/gro.h
index 00b49b6b9e74..6f6affc8ab91 100644
--- a/include/net/gro.h
+++ b/include/net/gro.h
@@ -160,9 +160,19 @@ static inline bool skb_gro_may_pull(const struct sk_buff *skb,
 	return likely(hlen <= NAPI_GRO_CB(skb)->frag0_len);
 }
 
+/* A pull can release the page fragment frag0 points to, or reallocate
+ * skb->head, even if it fails. Call this before the pull, to make sure later
+ * skb_gro_header() and skb_gro_network_header() calls no longer use frag0.
+ */
+static inline void skb_gro_frag0_invalidate(struct sk_buff *skb)
+{
+	NAPI_GRO_CB(skb)->frag0_len = 0;
+}
+
 static inline void *skb_gro_header_slow(struct sk_buff *skb, unsigned int hlen,
 					unsigned int offset)
 {
+	skb_gro_frag0_invalidate(skb);
 	if (!pskb_may_pull(skb, hlen))
 		return NULL;
 
diff --git a/net/core/gro.c b/net/core/gro.c
index 1b033855a20d..bc88652e353a 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -238,6 +238,7 @@ int skb_gro_receive_list(struct sk_buff *p, struct sk_buff *skb)
 		     NAPI_GRO_CB(skb)->flush))
 		return -E2BIG;
 
+	skb_gro_frag0_invalidate(skb);
 	if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
 		NAPI_GRO_CB(skb)->flush = 1;
 		return -ENOMEM;
diff --git a/net/ipv4/esp4_offload.c b/net/ipv4/esp4_offload.c
index abd77162f5e7..2309468cfc3d 100644
--- a/net/ipv4/esp4_offload.c
+++ b/net/ipv4/esp4_offload.c
@@ -37,6 +37,7 @@ static struct sk_buff *esp4_gro_receive(struct list_head *head,
 	__be32 seq;
 	__be32 spi;
 
+	skb_gro_frag0_invalidate(skb);
 	if (!pskb_pull(skb, offset))
 		return NULL;
 
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cf07c3c6611a..cd9d7426b227 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -743,6 +743,7 @@ static struct sk_buff *udp_gro_receive_segment(struct list_head *head,
 			pp = p;
 		} else {
 			if (NAPI_GRO_CB(skb)->is_flist) {
+				skb_gro_frag0_invalidate(skb);
 				if (!pskb_may_pull(skb, skb_gro_offset(skb))) {
 					NAPI_GRO_CB(skb)->flush = 1;
 					return NULL;
diff --git a/net/ipv6/esp6_offload.c b/net/ipv6/esp6_offload.c
index 22895521a57d..ca947cb94fb7 100644
--- a/net/ipv6/esp6_offload.c
+++ b/net/ipv6/esp6_offload.c
@@ -64,6 +64,7 @@ static struct sk_buff *esp6_gro_receive(struct list_head *head,
 	if (NAPI_GRO_CB(skb)->proto == IPPROTO_UDP)
 		encap_type = UDP_ENCAP_ESPINUDP;
 
+	skb_gro_frag0_invalidate(skb);
 	if (!pskb_pull(skb, offset))
 		return NULL;
 
-- 
2.53.0

