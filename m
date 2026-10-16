Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E014550DAA;
	Fri, 16 Oct 2026 17:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792170648; cv=none; b=PUgziZgsdNud/SZM+qAN0RjX6lQbQIHm1zKRj+hIU8Fvsm3VJtJMvKNWbPgyBy6MeQBJpFwv+VkQrfN36D8kLLM6Y9KSAcA7mVPe+sIX/nOeIQ/GZ7AZRD6UPqMzN5IB1WR0N305C8FS2BEdpctQkGZ7l/DUagiqo6kyjo+/9nM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792170648; c=relaxed/simple;
	bh=ClWatQNDLxiU3ylwVIvGAKjZ9bslSf25aw2Yg91ytsc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=qv3bY1LR8Gg53B7WmYw2ccBzGGvFhkBcg+UeAocZxtLIfctPuJpc2cWtcqmKLHp/ZiU4AXvtwV7dp++UPbCY+1VuQTq3on4sBy7mWfntaMADEcwz45F87PkP9pIBIvm/4TFvbz1EdASYLSdD8zU9pq72KQtJ6tlgljmVvF1YUkg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jfrIXKL+; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jfrIXKL+"
Received: by smtp.kernel.org (Postfix) with ESMTPS id B2AA6C2BCF4;
	Fri, 16 Oct 2026 17:10:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1792170647;
	bh=ClWatQNDLxiU3ylwVIvGAKjZ9bslSf25aw2Yg91ytsc=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=jfrIXKL+oSsRQgoTLmCeJBgiFENWK3IivvN+1MoVxL1yPFErDwZLUqSu0W+mwoqUI
	 CoZ0XkfN/teQkxmluWYZHawnug6+qmQaRihr6xxg7A5Ci7UsnpEEOgF1efE8E9K7Id
	 hgh1yNz3SIfgxo3vuBCnYmhJ0bHa+XrxG/HzMgQlHFFBJHm/m8kGTHLQVK79GCJJUl
	 8rkUwXcDnpw9p0u8i+w5oKVDGWRUeDMc6m5SkCsLsO9Nfd6DVzoP24VGHO4frX/BUB
	 o9EoH6RlNhDxO9YIJtCX5A9BiQ+ZzEFYS3+bicAIZyDHz2Sg33KMwRyIa3Wl845PvT
	 imJ3U/DN9w3zw==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C04FCCA462;
	Fri, 16 Oct 2026 17:10:47 +0000 (UTC)
From: Pierre-Yves Le Borgne via B4 Relay <devnull+pylaterreur.gmail.com@kernel.org>
Date: Fri, 16 Oct 2026 18:10:47 +0100
Subject: [PATCH net] net: gso: complete partial checksums of fraglist
 segments
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261016-fraglist-csum-v1-1-93945be7bb5d@gmail.com>
X-B4-Tracking: v=1; b=H4sIAJZa0moC/yWMQQqDMBQFryJv3YCJNWivUlzY9Ed/sWnJjyKId
 2+qyxmY2SAUmQS3YkOkhYU/IYO+FHBjHwZS/MwMUxqrS22Vj/0wsSTlZH6rtqm1r2rjbXVFbr6
 RPK/H745ACd0pZX68yKX/Cfv+A3VL7rV2AAAA
X-Change-ID: 20261016-fraglist-csum-9851f352f634
To: "David S. Miller" <davem@davemloft.net>, 
 Eric Dumazet <edumazet@kernel.org>, Jakub Kicinski <kuba@kernel.org>, 
 Paolo Abeni <pabeni@redhat.com>, Simon Horman <horms@kernel.org>, 
 Neal Cardwell <ncardwell@google.com>, Kuniyuki Iwashima <kuniyu@google.com>, 
 Steffen Klassert <steffen.klassert@secunet.com>, 
 Willem de Bruijn <willemb@google.com>, Felix Fietkau <nbd@nbd.name>, 
 David Ahern <dsahern@kernel.org>
Cc: Alice Mikityanska <alice.kernel@fastmail.im>, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Pierre-Yves Le Borgne <pylaterreur@gmail.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1792170647; l=8691;
 i=pylaterreur@gmail.com; s=20261016; h=from:subject:message-id;
 bh=+6s2T+CDmwwAnHYG9GYCPGRzPJ9RBMWkgGA4q3senVk=;
 b=kZzQ4Q7JYQK/iQAX86QuOUaPz9n59cwbCQvw5z16j8UbmaSVTVaLDxCwzAcBN2BDJwUW0C3bn
 h+ruCMlV2a6BIR0Eh5Wb13xnichnsrpVhlyQ+5GOhXeZIE3t1VctYFW
X-Developer-Key: i=pylaterreur@gmail.com; a=ed25519;
 pk=ji67AkgYQ74oEk6yXWqtaQNCkT8ZDb7Jmi6SF/Neu7g=
X-Endpoint-Received: by B4 Relay for pylaterreur@gmail.com/20261016 with
 auth_id=1214
X-Original-From: Pierre-Yves Le Borgne <pylaterreur@gmail.com>
Reply-To: pylaterreur@gmail.com

From: Pierre-Yves Le Borgne <pylaterreur@gmail.com>

Since commit f0b8c3034556 ("udp: do not transition UDP GRO fraglist
partial checksums to unnecessary"), fraglist GRO keeps CHECKSUM_PARTIAL
on the packets it aggregates, and skb_segment_list() gives every segment
the ip_summed of the head. Before it, UDP fraglist GRO turned them into
CHECKSUM_UNNECESSARY, which left their checksums unfinished whatever the
output device. Packets arrive with CHECKSUM_PARTIAL from veth, or from
virtio-net when the host sets VIRTIO_NET_HDR_F_NEEDS_CSUM, which it does
for packets that the host itself or another VM on the same bridge sent
with checksum offload.

validate_xmit_skb() completes CHECKSUM_PARTIAL checksums only for packets
that need no segmentation, and relies on the GSO callbacks for the
others: skb_segment() computes the checksums of its segments when the
device can't. The fraglist path doesn't, so when the output device has no
checksum offload, e.g. a tun device without TUN_F_CSUM, the segments leave
with only the pseudo-header sum in their TCP or UDP checksum field and are
dropped by the receiver. Only the packets that GRO aggregated are hit, so
sparse traffic gets through while bulk transfers stall.

This was seen with OpenWrt running as a VM, as OpenWrt turns rx-gro-list
on by default: WireGuard packets from the host, which the VM routed into
a VPN tun device, reached the VPN peer with unfinished UDP checksums, all
with the same value. TCP is affected the same way.

Complete the checksums of the segments once the protocol code has fixed
their headers up, as validate_xmit_skb() does for unsegmented packets.
skb_segment_list() itself is too early for UDP, as
__udp_gso_segment_list() restores the length in the head's UDP header
only after it. Segments that are GSO packets themselves, which TCP
fraglist GRO can chain, are left as they were: skb_checksum_help()
refuses GSO packets.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
Cc: stable@vger.kernel.org
Closes: https://github.com/Ysurac/openmptcprouter/issues/4402
Assisted-by: LLM
Signed-off-by: Pierre-Yves Le Borgne <pylaterreur@gmail.com>
---
Tested on net/main 191aa41548b2 in UML: frames written with
VIRTIO_NET_HDR_F_NEEDS_CSUM to a tap opened with IFF_NAPI | IFF_VNET_HDR
(virtio_net_hdr_to_skb() and napi_gro_receive(), as on virtio-net RX),
rx-gro-list on, routed with and without SNAT to a tun device read
without vnet header. Packets that left the tun with the bare
pseudo-header sum as checksum, with 2000 frames written per case:

                    UDPv4  TCPv4  UDPv6  TCPv6
  without, no NAT    1030    836   1106   1424
  without, SNAT       250    721    683    196
  with, either          0      0      0      0

With rx-gro-list off, both kernels complete every checksum. TCP from a
TSO veth sender through a router with rx-gro-list on, out of a veth with
and without tx checksum offload, still works. The error path was
exercised by injecting failures into 1 in 8 checksummed segments, under
KASAN, kmemleak and lockdep. The same reproducer showed the problem, and
an earlier version of this fix working, on an OpenWrt 6.18 kernel in a
VM.

Callers of skb_gso_segment() that pass no offload features (xfrm,
nfnetlink_queue, wireguard, ovpn) now get completed checksums from the
fraglist path too, as they already do from skb_segment().

Not done: allyesconfig and full allmodconfig builds (not enough disk
here); the changed objects build without new warnings on x86_64
allmodconfig with W=1 and sparse (GCC 15). No selftest: the
reproducer needs a NAPI tap fed with virtio_net_hdr frames and a tun
reader that checks checksums, about 300 lines of C. I can turn it into
one under tools/testing/selftests/net if that is wanted.

This patch was developed with an LLM coding agent (Claude Code). It was
asked to find out why forwarded WireGuard traffic got bad UDP checksums
in the OpenMPTCProuter report linked above, then to fix that and test
the fix; it did the analysis, wrote the fix and this changelog, and ran
the tests above.
---
 include/linux/skbuff.h   |  2 ++
 net/core/skbuff.c        | 40 ++++++++++++++++++++++++++++++++++++++++
 net/ipv4/tcp_offload.c   |  4 +++-
 net/ipv4/udp_offload.c   |  6 ++++--
 net/ipv6/tcpv6_offload.c |  4 +++-
 5 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index a3ff380d43f0..9c3dbbeb1e6e 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4288,6 +4288,8 @@ void skb_scrub_packet(struct sk_buff *skb, bool xnet);
 struct sk_buff *skb_segment(struct sk_buff *skb, netdev_features_t features);
 struct sk_buff *skb_segment_list(struct sk_buff *skb, netdev_features_t features,
 				 unsigned int offset);
+struct sk_buff *skb_segment_list_csum_help(struct sk_buff *segs,
+					   netdev_features_t features);
 struct sk_buff *skb_vlan_untag(struct sk_buff *skb);
 int skb_ensure_writable(struct sk_buff *skb, unsigned int write_len);
 int skb_ensure_writable_head_tail(struct sk_buff *skb, struct net_device *dev);
diff --git a/net/core/skbuff.c b/net/core/skbuff.c
index 41beaf625421..be3fa938e1da 100644
--- a/net/core/skbuff.c
+++ b/net/core/skbuff.c
@@ -4782,6 +4782,46 @@ struct sk_buff *skb_segment_list(struct sk_buff *skb,
 }
 EXPORT_SYMBOL_GPL(skb_segment_list);
 
+/**
+ * skb_segment_list_csum_help - finish the checksums of fraglist segments
+ * @segs: segments built by skb_segment_list(), with their final headers
+ * @features: features of the output path
+ *
+ * The segments built by skb_segment_list() all have the ip_summed of the
+ * GRO head. If the aggregated packets were CHECKSUM_PARTIAL, e.g. received
+ * from virtio-net or veth, compute the checksums that the output device
+ * can't offload, as skb_segment() does for the segments it builds.
+ * Segments that are GSO packets themselves (TCP fraglist GRO can chain
+ * those) are left alone, as skb_checksum_help() can't handle them.
+ *
+ * Return: @segs, or an error pointer after freeing the segments.
+ */
+struct sk_buff *skb_segment_list_csum_help(struct sk_buff *segs,
+					   netdev_features_t features)
+{
+	struct sk_buff *seg;
+	int err;
+
+	if (segs->ip_summed != CHECKSUM_PARTIAL)
+		return segs;
+
+	for (seg = segs; seg; seg = seg->next) {
+		if (skb_is_gso(seg))
+			continue;
+
+		err = skb_csum_hwoffload_help(seg, features);
+		if (err) {
+			kfree_skb_list(segs->next);
+			segs->next = NULL;
+			/* drop the extra reference skb_segment_list() took */
+			kfree_skb(segs);
+			return ERR_PTR(err);
+		}
+	}
+
+	return segs;
+}
+
 /**
  *	skb_segment - Perform protocol segmentation on skb.
  *	@head_skb: buffer to segment
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index e74d99ca9fac..0bb73e7eeff0 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -92,7 +92,9 @@ static struct sk_buff *__tcp4_gso_segment_list(struct sk_buff *skb,
 	if (IS_ERR(skb))
 		return skb;
 
-	return __tcpv4_gso_segment_list_csum(skb);
+	skb = __tcpv4_gso_segment_list_csum(skb);
+
+	return skb_segment_list_csum_help(skb, features);
 }
 
 static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cf07c3c6611a..4a90cdb1a9eb 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -473,9 +473,11 @@ static struct sk_buff *__udp_gso_segment_list(struct sk_buff *skb,
 	udp_set_len_short(udp_hdr(skb), sizeof(struct udphdr) + mss);
 
 	if (is_ipv6)
-		return __udpv6_gso_segment_list_csum(skb);
+		skb = __udpv6_gso_segment_list_csum(skb);
 	else
-		return __udpv4_gso_segment_list_csum(skb);
+		skb = __udpv4_gso_segment_list_csum(skb);
+
+	return skb_segment_list_csum_help(skb, features);
 }
 
 struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index eec3778855eb..e664904020e7 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -162,7 +162,9 @@ static struct sk_buff *__tcp6_gso_segment_list(struct sk_buff *skb,
 	if (IS_ERR(skb))
 		return skb;
 
-	return __tcpv6_gso_segment_list_csum(skb);
+	skb = __tcpv6_gso_segment_list_csum(skb);
+
+	return skb_segment_list_csum_help(skb, features);
 }
 
 static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,

---
base-commit: 191aa41548b2d2b6af534a6d5cf84a552435c74c
change-id: 20261016-fraglist-csum-9851f352f634

Best regards,
--  
Pierre-Yves Le Borgne <pylaterreur@gmail.com>


