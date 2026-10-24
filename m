Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.46
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844829;
	b=5ozwWweylYm/dgMHt+K3MOtWicKIKk9WNKSNTVX0QSGIWuwmbKXp1UxLSjL+zgMatNoc
	 6HMlskfGhtcY+3xlzkNkSwZXjpJkgtZO9Fya5jsGY4X2IT1Z/e9oB0eJcboA2SQv6/Ggd
	 SukZpA7mmUGVTlD8iww0yq3yEVilt0fBUCyt5ref/zmedcST6TDCtlk6Hqb3GLz5Rn1Xo
	 UAi7fKR5rClYmgTijWP1avEe9a8YSF+ifuCbz4fyW8keQoCSDI7Jcbs9p5fk3vOtwlh1H
	 lEOi05qtjArqL8qrRl5/wEZsQEgg5ErPg6U1Wbf81a3TKee1xodI504PW6l1N7xQK7g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844829;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=OyOVbbIu+ztDbRePHn0fSa4I3/kVW7mRxxVSOKbiLiM=;
	b=J57JxaYz/PLf/DzRuTqCX9uVCpQJxC60RkngvI2/Q7Z9fqJ7qX41/p1gKCIbZ1H+ieDs
	 XRF3PyX9Z0eHk8SaE94T3AS5ZK27+C4LVnG8KaTfBJWA5ys1tpuWOOlHWa8q8y/QVEQLq
	 7C1TUpNf/5Duo49KWuUhQ//f27DhN8KwWLWB8bqkfP94Zb0yc3dIintC1aQBzc6JHvsz+
	 nR5lrzZiNYIymPh5rSWoBJ4Ht5CRVLdK0Ti3DMfbF7ze2dW9a5mPNvNCch4lFakjua+A4
	 4qBssQ5JhCavzhdEuNNsPFoXg+iLYU8kfe+HiMryuKba0M2bnEM/gtmHRHrTPK9m4JQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ih9GxqTb;
	arc=none smtp.remote-ip=209.85.216.46
Received: from mail-pj1-f46.google.com (mail-pj1-f46.google.com [209.85.216.46])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 74B05606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 12:27:09 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 74B05606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ih9GxqTb
Received: by mail-pj1-f46.google.com with SMTP id 98e67ed59e1d1-3adf5f6833cso179589a91.0
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 05:27:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792844829; x=1793449629; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OyOVbbIu+ztDbRePHn0fSa4I3/kVW7mRxxVSOKbiLiM=;
        b=Ih9GxqTbUdSuAn7iBKJhmoIlr7BKHSQ/47iP6fi8bVd/XtegGHPkBskzvGehYDgx0P
         1Ice9YJMt9ludA8F9f6Za71v5A43htN0phUKu+r3kNyC6WJsOFoq2xgcHRMipCwK+2t+
         h3FYxKU4AOaySsQk3TbHAf9bp8NZn0OySxnvNYtiTtcugSxV8ItIsdGfo1oDI2blYkHu
         dNv0ORM6TTfh7kDSdB6CwZ71QXZtv49w233UUqSHBp6grBJ48H6E2I5AYvb4zpdrhXDD
         YXIlesuXTj1gQnd4eZY9R5UUwqh/1mSZeNkhMFdMeQlvYU7g5cjDwdL+c7E4jP/CVGTi
         whkQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792844829; x=1793449629;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OyOVbbIu+ztDbRePHn0fSa4I3/kVW7mRxxVSOKbiLiM=;
        b=vM5dEnRzksHta6nxtpQ4ddq5bnhak2B+EoIi3WfZBF5oxTFnzE6lqkBNfATbmeOPVw
         qaglDbAmcU+CXod6uFChHvr7cKEq/Redfv8PF+YlSvo0VcZ/SrtZfN4tlXqm4BL+N4sp
         e3JMBGuwOmzphWSoJTibaxefF81Ovv9mK9ETdOJWO7ulBSBbRUspPWDXeE2p78BVZgnS
         JnpkMMOSqrqz2gOok5UzTE5qKCQJp5LOksVQoR86ENG2pVLaKvWdKzA/HWYVirHRzCk1
         8RMiohaP9H6d4lDq9YD4DmKx9mdIvSjA8gWHZXmjvMsBoHbim1u344hu3eoqPt+o2CBr
         AJ/A==
X-Gm-Message-State: AFq9FYJphmqcVr77uhhmCgjjGv/iXYcMGHxEhysB3ANdNeFEGidDP7oY
	JtSaQLZnGW4PVeSAXcQxlUgl/oMATxVgIgoLP2UdNWFpVZq692afUrq85r8h4F4b
X-Gm-Gg: AYBFou3cPnrddWpssoFSVc2kuIWE3eXrWtoL6pPSye3pP8ZMQWduH0oim75fG5cqfyG
	52dtt0gORyxhrpQOcBzqUbL+L9ckRRTI1Typd1FivSBKqk8FW/IT34EAnDP+qiycK1XbRa7kI1r
	jgU8f3nD2aATm9pEz+oNAqaOu1Wf9J1ASEd65Z6y1ESET09/i4USb+QW94rTSJSLG6X63+N/uhH
	9EHAS5xtWJie7yL1dMruIX8ULInpFyrH8mNbFCGDsdKg+381InJDsIt/BJAwzUN2zdPrQz8dydn
	9PR5d1tWwdBqup4C7afVtN1EuhrC3I2/eFH/tS99LZl9C4V63GZeefBeKP9thx/1qlPAHwLhjVv
	9pvusi2NnQ87CFl8Nty9Gv205a0aovewC0wF2BxdguDYzfmITGqL4KN4x7u+yU6EBqYwohVWVg0
	V+EIm00oMhdAB5pe8B1yGAXh+se7VrV6phjVNAysa4z7soA3cq5NAsDN57f6HVRdvadAFu0SFji
	GZfY1Tq+5DyjgJSJ5Y2F2UolKcQCfU/FntuMhSWc7JLVpatpqVjikP68e/wcLT0w2xxGDwhlQrB
	0kZ5fOKeJbnjm4lzo/aLqohsgoTHVaH/3y4s2ip/ExpDjCe0gtqSeCqef4grWwzmQrgHHi8euFP
	fZLjNRYkP/1XdIHDV5hNjghMitnTjD8dmYiJuFZOGseQRZwMBolE06FnZGLy7QYzj78y7iwu8iq
	VTKJAJkGcQRo3hIcAGyPwtdRPSPrQRFTrQ7GiUs/KpcnVz6P648rvqtzUJ
X-Received: by 2002:a17:90b:3b41:b0:3ac:7c52:fb04 with SMTP id 98e67ed59e1d1-3adeae7b8f9mr1658747a91.44.1792844828803;
        Sat, 24 Oct 2026 05:27:08 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adeb83b408sm1719129a91.0.2026.10.24.05.27.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:27:08 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.18.y] net: gso: limit recursive IP-in-IP segmentation
Date: Sat, 24 Oct 2026 20:27:01 +0800
Message-ID: <20261024122701.554-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100305-credible-reference-2a7c@gregkh>
References: <2026100305-credible-reference-2a7c@gregkh>
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

From: Zihan Xi <zihanx@nebusec.ai>

[ Upstream commit 006c8b834aed8b02bd8fb9fb05e9e7ead37d1763 ]

IP-in-IP GSO can re-enter inet_gso_segment() or ipv6_gso_segment()
for each nested IP header. encap_level tracks header bytes, not callback
depth, so a deep chain can exhaust the kernel stack. Making
inet_gso_segment() stackable introduced unbounded IPv4 nesting; IPIP
GSO/TSO later made the path reachable. The IPv6 stackable path was
introduced separately and uses the same guard.

Count IPv4 and IPv6 GSO handler entries in skb_gso_cb, initialized once
per top-level GSO operation and preserved across GRE/UDP context changes.
Use the existing IP_TUNNEL_RECURSION_LIMIT for both handlers. The first
five entries pass, and the sixth returns -EINVAL before dispatching
another GSO callback.

Fixes: 3347c9602955 ("ipv4: gso: make inet_gso_segment() stackable")
Cc: stable@vger.kernel.org
Reported-by: Vega <vega@nebusec.ai>
Closes: https://lore.kernel.org/all/cover.1790157745.git.zihanx@nebusec.ai/
Assisted-by: LLM
Co-developed-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Luxing Yin <root@tr0jan.top>
Signed-off-by: Zihan Xi <zihanx@nebusec.ai>
Reviewed-by: Willem de Bruijn <willemb@google.com>
Link: https://patch.msgid.link/20260924051521.32568-2-zihanx@nebusec.ai
Signed-off-by: Paolo Abeni <pabeni@redhat.com>
[ Ting-Han: ipv6_gso_segment() still calls ipv6_hopopt_jumbo_remove()
  right after skb_reset_network_header() in this version; keep the new
  recursion check directly after skb_reset_network_header() as upstream
  does, before the jumbo removal ]
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
Tested on top of v6.18.58. The patch also applies cleanly on top of
the current 6.18 queue (6.18.59-rc1).

x86_64 defconfig + kvm_guest.config with KASAN, PROVE_LOCKING,
DEBUG_ATOMIC_SLEEP, DEBUG_LIST and UBSAN, built with and without the
patch and booted in QEMU/KVM. The guest sends 32 MiB of TCP over a
veth pair, over one ipip tunnel, over one ip6ip6 tunnel and over ipip
in ipip, with tx-ipxip4/6-segmentation turned off on the veth pair so
that the tunnel GSO packets are segmented in software. With and
without the patch all data arrives intact, there are no drops or
kernel warnings, and kprobes show two inet_gso_segment() or
ipv6_gso_segment() calls per __skb_gso_segment() call in the tunnel
cases, so these packets reach a count of 2 in the new check. No new
W=1 or sparse warnings in the changed .c files.

Not tested: the deep nesting reproducer from the upstream report, so
the -EINVAL path itself was not exercised.

Tool use: this backport was prepared with an LLM coding assistant
(Claude Code with Claude Opus 5.5), asked to backport 006c8b834aed to
the stable trees it failed to apply to and to test it. It resolved
the conflicts, wrote the note in the changelog and this text, wrote
the test scripts and the guest init, and ran the builds and QEMU tests
above. I reviewed the patch and the test results before sending.

 include/net/gso.h      | 8 ++++++++
 net/core/gso.c         | 1 +
 net/ipv4/af_inet.c     | 3 +++
 net/ipv6/ip6_offload.c | 4 ++++
 4 files changed, 16 insertions(+)

diff --git a/include/net/gso.h b/include/net/gso.h
index 29975440cad51..0749230d414ec 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -19,10 +19,18 @@ struct skb_gso_cb {
 	int	encap_level;
 	__wsum	csum;
 	__u16	csum_start;
+	/* Number of IPv4/IPv6 GSO handler entries for this packet. */
+	u8	recursion_counter;
 };
 #define SKB_GSO_CB_OFFSET	32
 #define SKB_GSO_CB(skb) ((struct skb_gso_cb *)((skb)->cb + SKB_GSO_CB_OFFSET))
 
+static inline bool gso_recursion_inc_test(struct sk_buff *skb,
+					  unsigned int limit)
+{
+	return ++SKB_GSO_CB(skb)->recursion_counter > limit;
+}
+
 static inline int skb_tnl_header_len(const struct sk_buff *inner_skb)
 {
 	return (skb_mac_header(inner_skb) - inner_skb->head) -
diff --git a/net/core/gso.c b/net/core/gso.c
index bcd156372f4df..e96ef63500648 100644
--- a/net/core/gso.c
+++ b/net/core/gso.c
@@ -117,6 +117,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->recursion_counter = 0;
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index 1d1a03fad1f9f..5f6f6019b298e 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1364,6 +1364,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int id;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
 		goto out;
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index fce91183797a6..db71d557d6f5a 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -17,6 +17,7 @@
 #include <net/udp.h>
 #include <net/gro.h>
 #include <net/gso.h>
+#include <net/ip_tunnels.h>
 
 #include "ip6_offload.h"
 
@@ -120,6 +121,9 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	err = ipv6_hopopt_jumbo_remove(skb);
 	if (err)
 		return ERR_PTR(err);

base-commit: 2926d88bb7fc4608fd942453d929c39e4e5ec006
-- 
2.53.0

