Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.160.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793475538;
	b=OUFYmcw/MTiQlD7vVKpEs1tx8PtFAMszj7+SEMP4Jj1XOBI5tQ80S7+Br6I1vqCtAhY+
	 2qDpsVMYn8BB+giV55uWb7sXt3xjUsm4Dqo5tfcDmPXWZY3keNgFnnXydwZQePXD0b0Bx
	 K8qq2ghYYqWjnunDRYaJNLOYhsv5VNqhU8+SniU1FaUVkQ8ZwHAHjkHUseNeMaBfkhX8G
	 vOlKFXK7tpn/9bMGLft70TRZFEddOqpb1rImI3TKUG6YV4p5iit3x53kesv08YY/9DZLG
	 The9kQwk2VA3YhnsEBV+5M8ADp0UN6EaviAeJ15+++25FAR2PdsQwgWjTk36pIfnZ3A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793475538;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=bQgrellhBss/UuVF8iWJXrXw5PzovFu/NGuBFfL7ORU=;
	b=XD82jxMqCsn7ArIrvR8dtWuNRkedjJpNGxNeaDtnQe1b7WA8m695UrCmB9mn2te67D5M
	 r8xTfBPx2qDkxe+wLZv0RWAel4iS2u/w/dmRyGH93DRUmdIeLvFJkneUA2lgn/fQ+J8nF
	 JwAaJfvUf4uh76cF1ydKzBpfERFmKhbXw673sMTmkOEdJWjj83rhTP3QYCe0QYgmWyPSP
	 Nc9mkVpdT6C0oYKExh/Li64jn+JgQSSQM7JKSCLsonDTLTXXArOTzDaca5ZC+Ltxk8yOG
	 R2Dt2xdF3czi9MvPD7tst5jO/UMhgzmzsAX76a4B4Fiou3bJIEC7+x6GZx1NpRUWO+Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=mojatatu.com;
	spf=none smtp.mailfrom=mojatatu.com;
	dkim=pass header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=djtcKBBB;
	arc=none smtp.remote-ip=209.85.160.170
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E14C2606A31A
	for <stable@vger.kernel.org>; Sat, 31 Oct 2026 19:38:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E14C2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mojatatu.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=mojatatu.com header.i=@mojatatu.com header.a=rsa-sha256 header.s=google header.b=djtcKBBB
Received: by mail-qt1-f170.google.com with SMTP id d75a77b69052e-5365b48238dso16769671cf.0
        for <stable@vger.kernel.org>; Sat, 31 Oct 2026 12:38:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=mojatatu.com; s=google; t=1793475537; x=1794080337; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=bQgrellhBss/UuVF8iWJXrXw5PzovFu/NGuBFfL7ORU=;
        b=djtcKBBBOn+WVZLjii7ZcxViiQUURHCSkc0IPNwbqDRia+Whlq9TL2HsXmtlnvTVOq
         QREPlWkWCrR6JCi2fuqIDkPdsdhSKfW5OWhmalzlr947MlpFKjWRAUiupsxMcu4oSDpw
         NyDdrC12mHwYaWbaxPGy9j0sh6OLNYBoZDcH4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793475537; x=1794080337;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bQgrellhBss/UuVF8iWJXrXw5PzovFu/NGuBFfL7ORU=;
        b=jYXie1Ax4qlnw6Rk/4FMRjWbH132mCmlr9GYiN0tWV9O33d6WklDcqrXceY+NdN0sq
         3zyFpSLzmkUyhWByJkWzXxdHWN5uzOBH/9W9IX9TA0XOb4faaGqXMLQW86JrOQ8L03sV
         m+5W/WP9bF+p3ic6FORWLeCW0yCaYZKtK/L/GDBrXc4vhdVQO5cfVxZaAZ32YcvgNGU7
         e3IV19L0thGrUQ7RwWz9IIERmtWAH5IL9VR13rF3UIpFaPqJt/uTFqHEsop8NapjFbhP
         0P2iDKYkDTUhhP/btic/kcg8E4dtL3Ltk2yVGHggscSlcG0NdGSRlxtN/20HNmYgOGZ8
         w3RQ==
X-Forwarded-Encrypted: i=1; AKwUvBxp67M/xPlyvDYAMHmBulPYy14lgehoSIGmZpxwLELyGVPCo7IxJDLR/y7IGF9aqqssKQYj/z4=@vger.kernel.org
X-Gm-Message-State: AFq9FYLLXH+G4r0hDilL2WXv1a5PWHeusYYi+Yj4pjl+ai9+v4CRtOWu
	67rjMQcNAqk3vVV/2c2GHrKzqd/+lmAkUXRvIcA0FZj5AAv5dtSW1WKmHfulzIjIhA==
X-Gm-Gg: AYBFou0I+1lF3f6jNWz0oxN0kUhVyivbHIRBm4A2S/95xVpF3fiEmQxdvRCfX+X81xO
	fP2utK0cKY0TklvUPTSER/llnqVQcceq9J2VY/9YJ+YyEh/JO2cmZZvLjUBGYgmAtXR96XjwG8k
	NAWRBc0FXV0TlkhL/n1udGdKdozApXlz4zUUqXgxuDmGIxVealpfhxNYFngQPqMB7g7Z2cjCIa5
	YIgbV2B3l+jMawWtigwNVA9GLL5DsofhaTP50DmwStc3dC6Hts2q6QoTJxLTKXZxiIX0nUYJ+cy
	3R9AoTcT2nWgBaHsdigxmWPEnSlj+xHieyKV0xWx7fm5BOK95vZD3kqI8Dtkb5TdI/OxiPxFZT5
	5FnVvTGK+iCK9xOEuzVSN5ZX/j77lVkPqMgbHUKP6QxVIc1DAhuy0dsAni0cwOkzpeuYkMLOmgq
	umRcBmPYaaM5C2m6JkIEraX+h5zmrDFTFK9RsKlI1TlcJPx8TyveA3gzs8qLQwNuBVBoRrOCKUB
	5v7vLw9vQSGbzgj/yI1WdfGA4xsU/HdokXOtZ3V4edUySsELj+9oOn/vkDQCiseJwCVHBixzX/v
	p73C00RAAf2/PmPWHw37SbmrBbDQRfCEWbiL2s8TQvHLOmpro2h52fc49XG+FHD4GGLdwJtljQK
	RgcMu2hcBmIThZkQ=
X-Received: by 2002:a05:622a:138f:b0:533:8b99:fcd2 with SMTP id d75a77b69052e-542b7048954mr101358611cf.40.1793475536764;
        Sat, 31 Oct 2026 12:38:56 -0700 (PDT)
Received: from mbili.tail33bf8.ts.net ([64.203.83.2])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91ca8082914sm47802206d6.42.2026.10.31.12.38.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 31 Oct 2026 12:38:56 -0700 (PDT)
From: Jamal Hadi Salim <jhs@mojatatu.com>
To: bpf@vger.kernel.org,
	netdev@vger.kernel.org
Cc: Jamal Hadi Salim <jhs@mojatatu.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,
	Martin KaFai Lau <kafai@fb.com>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,
	Jiri Olsa <jolsa@kernel.org>,
	Emil Tsalapatis <emil@etsalapatis.com>,
	Ihor Solodrai <ihor.solodrai@linux.dev>,
	John Fastabend <john.fastabend@gmail.com>,
	Stanislav Fomichev <sdf@fomichev.me>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	David Ahern <dsahern@gmail.com>,
	Jiri Pirko <jiri@resnulli.us>,
	Victor Nogueira <victor@mojatatu.com>,
	stable@vger.kernel.org
Subject: [PATCH bpf v3] bpf: Fix skb_pull() BUG in __bpf_redirect_neigh()
Date: Sat, 31 Oct 2026 15:38:52 -0400
Message-Id: <bpf_redirect_neigh_short_linear.v3.r0.20261031153053-1@mojatatu.com>
X-Mailer: git-send-email 2.34.1
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

The issue:
This is a follow-up to the short link-layer header fixes from Eric.
After vlan pop_eth, a privileged SCHED_ACT BPF program can call
bpf_skb_change_head(skb, 1, 0) and then bpf_redirect_neigh().

__bpf_redirect_neigh() calls skb_pull(skb, sizeof(*ethh)) after checking
only that mac_header < network_header.  Nothing verifies that the MAC
header is long enough, that it is linear, or that the IP header the
redirect goes on to read is linear either.

A SCHED_ACT BPF program can do:

    bpf_skb_change_head(skb, 1, 0);
    bpf_redirect_neigh(lo, NULL, 0, 0);

after vlan pop_eth.  The skb then has mac_len == 1 and only one byte of
linear data; skb_pull(ETH_HLEN) trips the skb->len < skb->data_len BUG in
__skb_pull():

    kernel BUG at ./include/linux/skbuff.h:2839!
    RIP: skb_pull+0x40/0x50
    Call Trace: skb_do_redirect -> packet_xmit -> packet_sendmsg
    Kernel panic - not syncing: Fatal exception in interrupt

The v4 and v6 paths read ip_hdr() and ipv6_hdr() as soon as the MAC
header is gone.  On the AF_PACKET frame below that leaves headlen == 0
after the pull, so the network header sits at skb->tail and the route
lookup reads ip4h->protocol, ip4h->saddr and ip4h->daddr past the linear
area.

The Fix:
Use skb_network_offset(), which is the MAC header span, instead of
skb->mac_len.  mac_len is zero for locally generated tc egress and netkit
packets, while the span still rejects the one-byte header produced by
pop_eth + bpf_skb_change_head(skb, 1, 0).  The single check also covers
the mac_header >= network_header test it replaces.

Use pskb_may_pull() to make the Ethernet header linear before it is read
or pulled, and to make the IP header linear in both the v4 and the v6
path before ip_hdr()/ipv6_hdr() is read.  The header pointers are taken
after the pull, since pskb_may_pull() may reallocate skb->head.

Conditions to recreate the bug:
On x86-64 with 4 KiB pages, enable CONFIG_PACKET, CONFIG_BPF_SYSCALL,
CONFIG_NET_SCH_INGRESS, CONFIG_NET_CLS_MATCHALL, CONFIG_NET_ACT_VLAN and
CONFIG_NET_ACT_BPF.  Run as root with BPF loading, network administration
and raw-packet privileges.  Bring lo up and attach a SCHED_ACT program
that calls bpf_skb_change_head(skb, 1, 0), then returns
bpf_redirect_neigh(skb->ifindex, NULL, 0, 0):

  ip link set lo up
  tc qdisc add dev lo clsact
  tc filter add dev lo egress matchall action vlan pop_eth pipe \
      action bpf object-file neigh_chghead.o section action

Send an untagged ETH_P_IP frame of ETH_HLEN + 8192 bytes through an
AF_PACKET/SOCK_RAW socket bound to lo, without PACKET_VNET_HDR or
PACKET_QDISC_BYPASS.  Use a unicast destination MAC.  The sender's skb
has a 14-byte linear Ethernet prefix and a fragmented payload; pop_eth
removes that prefix and change_head restores only one linear byte.
The unfixed neighbor redirect then tries to pull 14 bytes and BUGs.

Sending the same frame without pop_eth and change_head leaves the IP
header in the frags, which is the route lookup reading past skb->tail.

Fixes: b4ab31414970 ("bpf: Add redirect_neigh helper as redirect drop-in")
Link: https://lore.kernel.org/netdev/20261027082604.1485903-1-edumazet@kernel.org/
Link: https://lore.kernel.org/all/2a0f5ff1d8db81b07fc4b344b8e68e3505fcbf36f72a471d1678b2f1cecd881b@mail.kernel.org/
Link: https://lore.kernel.org/netdev/DMII4JGTEUEG.2WRJPT6ODT6J0@gmail.com/
Cc: stable@vger.kernel.org
Reviewed-by: Victor Nogueira <victor@mojatatu.com>
Signed-off-by: Jamal Hadi Salim <jhs@mojatatu.com>
---
v3:
- linearize the IP header in the v4 and v6 paths with pskb_may_pull()
  before ip_hdr()/ipv6_hdr() is read; the Ethernet check alone left the
  route lookup reading past skb->tail
- collapsed the MAC-header check to skb_network_offset(), which also
  covers the offset test it replaces (Alexei)
- dropped the tc-egress: it cannot hit the BUG (Alexei)
- retarget to the bpf tree

v2:
- use skb_mac_header_len() instead of mac_len; mac_len is zero for
  locally generated tc egress and netkit packets
- add tc-egress coverage to tc_redirect_neigh
- document the nonlinear AF_PACKET reproduction conditions
---
 net/core/filter.c | 21 ++++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/net/core/filter.c b/net/core/filter.c
index 09c60a58c82a..303c0c44dc2c 100644
--- a/net/core/filter.c
+++ b/net/core/filter.c
@@ -2290,9 +2290,13 @@ static int bpf_out_neigh_v6(struct net *net, struct sk_buff *skb,
 static int __bpf_redirect_neigh_v6(struct sk_buff *skb, struct net_device *dev,
 				   struct bpf_nh_params *nh)
 {
-	const struct ipv6hdr *ip6h = ipv6_hdr(skb);
 	struct net *net = dev_net(dev);
 	int err, ret = NET_XMIT_DROP;
+	const struct ipv6hdr *ip6h;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ip6h))))
+		goto out_drop;
+	ip6h = ipv6_hdr(skb);
 
 	if (!nh) {
 		struct dst_entry *dst;
@@ -2399,9 +2403,13 @@ static int bpf_out_neigh_v4(struct net *net, struct sk_buff *skb,
 static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 				   struct bpf_nh_params *nh)
 {
-	const struct iphdr *ip4h = ip_hdr(skb);
 	struct net *net = dev_net(dev);
 	int err, ret = NET_XMIT_DROP;
+	const struct iphdr *ip4h;
+
+	if (unlikely(!pskb_may_pull(skb, sizeof(*ip4h))))
+		goto out_drop;
+	ip4h = ip_hdr(skb);
 
 	if (!nh) {
 		struct flowi4 fl4 = {
@@ -2451,15 +2459,14 @@ static int __bpf_redirect_neigh_v4(struct sk_buff *skb, struct net_device *dev,
 static int __bpf_redirect_neigh(struct sk_buff *skb, struct net_device *dev,
 				struct bpf_nh_params *nh)
 {
-	struct ethhdr *ethh = eth_hdr(skb);
-
-	if (unlikely(skb->mac_header >= skb->network_header))
+	if (unlikely(skb_network_offset(skb) < ETH_HLEN ||
+		     !pskb_may_pull(skb, ETH_HLEN)))
 		goto out;
 	bpf_push_mac_rcsum(skb);
-	if (is_multicast_ether_addr(ethh->h_dest))
+	if (is_multicast_ether_addr(eth_hdr(skb)->h_dest))
 		goto out;
 
-	skb_pull(skb, sizeof(*ethh));
+	skb_pull(skb, ETH_HLEN);
 	skb_unset_mac_header(skb);
 	skb_reset_network_header(skb);
 
-- 
2.43.0

