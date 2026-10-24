Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.44
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844859;
	b=qPYRBeXMQWV63Z1j/8fVMAylHjaEGSwL2g0lUjWBf5dT6fsENDpLlV7NpYnVQXxLwwW2
	 UHG897KhTM37tHZHf3l+E910nQxiyLnc8AQOP1wImM/Ng86jpRwfghxlA4+aASXUEKM4X
	 hXL3TWX/lAYguETuM6Ggh7jRE8O8tGvo6RFFg8i4KZt11lwLi0Su/tdAYjbLTA2xwQvEZ
	 4gRucFvzvGHl9CM9UEHFp0GH1oPSfzSC0LsXMqY1A8An5YpenY4jPzMjnlHjBB10Qh91Z
	 xuwOPKhNUIblvq2hp960yr+iIZQ4vS8zCtGuBZ0LpstWcBTX1hjuryL0RIr4a8MjEQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844859;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=Pa/1V+GO9rou0gVbCQu+AiBiS7eZ3WU8igP5ouCt7qE=;
	b=4deEcmcudcC5+Zx9sh9Ab/fcmuqPYb7FZ70P2lQOyaLpbG4RjWxnBj4TwbtpY/+jN2tN
	 pJd5lKqgxTHROVPo8BTcykEQd7WssYtcbR7QEI4A8XkjqstWKBKfqlgM7MrVvdYGIse7a
	 Ddn+Hw/KBy6eQYTbbIvpgU79Y1x1NeEvpVofci4DKAPlF66IiLpQXcpjonDhoR1vJvPF/
	 39/YScKC5IciS3AwIaJTYOUl3JoYpY8e5erxSux3RWHq60CaGz8hwXBCtWX/IzMXyTM4w
	 CzIRERK0O2Xcljv4V8mc5SLWDZEHd0ZY2ODH8F/ODKPbL5Vyh2YueOFFfOHLMCzOfPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MQnxro0o;
	arc=none smtp.remote-ip=74.125.82.44
Received: from mail-dl1-f44.google.com (mail-dl1-f44.google.com [74.125.82.44])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B3D91606A323
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 12:27:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B3D91606A323
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MQnxro0o
Received: by mail-dl1-f44.google.com with SMTP id a92af1059eb24-15dd124bbe7so226888c88.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 05:27:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792844858; x=1793449658; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Pa/1V+GO9rou0gVbCQu+AiBiS7eZ3WU8igP5ouCt7qE=;
        b=MQnxro0oGBthFhUK5Vksh2mi/1+JKRy3rIclsnydZaqg9cfKaRJWINRWCptpU2L55D
         s96kJT27co2uwN1DZsEKQjaqCI+Xhq++n+P+QCLZq7Bd4Y1HOHlY0jI/CESjQB4dpS/A
         qTvDbzw9ctQs78NHb8O4UcYQn39TnM90GxJjntjsXN+vhJai09WJC93eKPMozXdgRZPE
         01mbaUmusv9Iu/OZbFdN14T07/EndkDf/PQOc/pIWe86OK8B8RHAYtFgz+aZ42BSaVU/
         NjE1trbsebev2C+VM6uUuaSFziR+cxMgCJCSusKpQVOX1TcQySuYWmukvLqJd3TqSpp9
         MkCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792844858; x=1793449658;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=Pa/1V+GO9rou0gVbCQu+AiBiS7eZ3WU8igP5ouCt7qE=;
        b=b+rbg//ELtf1zFTA2dlDcZ80gDCz+3kNggwsK13BaFGK0/Xs4c6lND77TtoZVX7EcB
         bjB1jQUmvMYdlk3xaQCBVtVIi6wq9YdHUh2xVCiXFbnrvZhaMjKw0lrvNufe+twnHJfN
         nKxPBCnn7vQSICr4M2k4gOUlVuNaMbszbcwa06yquxxIiz0NZf4gEqlbgjq4mmV2ZWy3
         wHTZBG6CKZarWPaubeEU0REb95l6PYsYMrrTkwNCObBOHw2k/9+ZuoA51yDdebQTNOEO
         NSz1mtj9OEHX/FHWdnsWOU+oonpzfO8kmxvMdbmM+PhYDbbcnnMdsxkyyxMuvv1mkV2y
         Yzog==
X-Gm-Message-State: AFq9FYIU6ccllqm7y5I5Q/Nc7BGwHE7XgbmlaW5kaHwSHsbswlehBhTb
	SrQIqA/BCIBLZw+rge+BO9zoRZkRm5ZYWwTr6UbVPtZ6QIjGNb34qo0wCNIpwrJTIoM=
X-Gm-Gg: AYBFou1wwuACe+1W3ARXf+cDiqe30vAmsZiXrCwPv/L6ALtK0l+IeSIfe9ZYZX1mLZC
	NJafrPswqlzpg02TWpCuN+YDM2A8uTIrXnqp9DH3zsRc5GIjluxfOfBj+zlimHK26e9vrx4FdIC
	Si5+KkgmDtA4Steqmi56Vy46ITP6cg2nDB6H2DTSbcakau2HTakYZrj/qjHZGzmZp4LpD79Ssl8
	t0pMATZ+7mpEeMFVMUpUKHoeynqp8Cm184Nx6asjzQryRRsiaHLTDAT18H56iIfwZSN3oWC+NDc
	5+G2j17nrHx/Zap6mtvEYPtJ/l9xLhVrWdAGVs5U3OhPOh6sWED8ezg3PLlIG72gHaaM8NaR7iZ
	DGVEpsOXniyx65W0VpSqTiily3xjvP2bFikoIexWJLrc9dW0ntUqaplkbYzmyrX/h6bmeAY/XxP
	i53prA1odMSfCEbqT1DQoeYAjbLNFvw+Uk31MKzDckEuiN9qCQtb20ge7KD3iPojJWTkDFquBsw
	AhIP3ary/dnukSkvgGNuJ2Amwjwu6/DiF1VKOJn5FDkMPxl+KktIN1I9++XkPKawfPvjmQzJ8qa
	A8GFtb3/5CNx0RVBCfqLlA3Noki6vU9skeQA1LilMwXX4SJfu3rp9SbuuCjKMSP3tZONs3Be0NK
	D4rI46OeNiNW5n5oC97f6C/MwZOt08pil3R5XBZ7PdqMY+RZtzRFycbBMkYB5X26qfudQJu80ED
	Tr/1ZTyrkqKtZQYqQ16mehonZxc5ki669IddT2EnXwR61Bhz1EHDM6OdJO
X-Received: by 2002:a05:7022:8d:b0:199:7dff:f9cc with SMTP id a92af1059eb24-1997e002523mr2647656c88.42.1792844857710;
        Sat, 24 Oct 2026 05:27:37 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-198a2a5a515sm6119705c88.19.2026.10.24.05.27.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:27:37 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.10.y] net: gso: limit recursive IP-in-IP segmentation
Date: Sat, 24 Oct 2026 20:27:31 +0800
Message-ID: <20261024122731.685-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100308-enquirer-overlabor-d9db@gregkh>
References: <2026100308-enquirer-overlabor-d9db@gregkh>
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
[ Ting-Han: this tree predates include/net/gso.h and net/core/gso.c, so
  the skb_gso_cb change and gso_recursion_inc_test() go into
  include/linux/skbuff.h and the reset into __skb_gso_segment() in
  net/core/dev.c. IP_TUNNEL_RECURSION_LIMIT was added upstream by
  6f1a9140ecda ("net: add xmit recursion limit to tunnel xmit
  functions"), which is not in this tree, so define it (same value, 5)
  in ip_tunnels.h ]
Signed-off-by: Ting-Han Hou <ue081723@gmail.com>
---
Tested on top of v5.10.272. The patch also applies on top of the
current 5.10 queue (stable-queue fa04d3db75), with an 8 line offset in
skbuff.h.

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

 include/linux/skbuff.h   | 8 ++++++++
 include/net/ip_tunnels.h | 3 +++
 net/core/dev.c           | 1 +
 net/ipv4/af_inet.c       | 3 +++
 net/ipv6/ip6_offload.c   | 4 ++++
 5 files changed, 19 insertions(+)

diff --git a/include/linux/skbuff.h b/include/linux/skbuff.h
index 0a7b1a7f1ae10..4f830c4813eb6 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4492,10 +4492,18 @@ struct skb_gso_cb {
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
diff --git a/include/net/ip_tunnels.h b/include/net/ip_tunnels.h
index fa81285ab723f..cbfb33f2225f2 100644
--- a/include/net/ip_tunnels.h
+++ b/include/net/ip_tunnels.h
@@ -24,6 +24,9 @@
 #include <net/ip6_route.h>
 #endif
 
+/* Maximum nesting depth for recursive IP tunnel processing */
+#define IP_TUNNEL_RECURSION_LIMIT	5
+
 /* Keep error state on tunnel for 30 sec */
 #define IPTUNNEL_ERR_TIMEO	(30*HZ)
 
diff --git a/net/core/dev.c b/net/core/dev.c
index 4fcc2857c7db0..b39f31890fce2 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3415,6 +3415,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->recursion_counter = 0;
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index b4b791888e320..221f58e5fc15d 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1351,6 +1351,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int id;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
 		goto out;
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index c145be2fd6e42..bc04c4bffae95 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -15,6 +15,7 @@
 #include <net/inet_common.h>
 #include <net/tcp.h>
 #include <net/udp.h>
+#include <net/ip_tunnels.h>
 
 #include "ip6_offload.h"
 
@@ -86,6 +87,9 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;

base-commit: aca95a35f1bcc0626c4fa4d1252bf2d4c990a1a2
-- 
2.53.0

