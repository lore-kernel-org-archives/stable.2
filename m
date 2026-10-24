Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.52
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844853;
	b=y1e3kCBVTeX/mL0gkunLLhmPNgDEdkTtdHVAXh5UZy/zn+0PW3EEF12Q+OSztZPHtsIM
	 q8dI7Ki8t0Vm3xE2m6stgHWS8GlbZ+J/ytaf2WW1apMNiv6qOyGSqWK3mXYZGW0lVDdkj
	 NlkZey1wXv7yOh87bt3GxPfYFU8UKg39MEzsgWLXinlKf6hhXatoyj6Bi5DAXWK2XHbU0
	 7CYb7F+2E51XCJG5yjX6LxVMSGZRuGkePE8HTX6njsgzzAZAgCHv7hEy0xxMTMZUnHD9/
	 nxj+yq/uDt9j6ZWSbOONwhU0DGEn+Oeb8oMsKu3Tv5+nvrG3nACZOlmMvzhuPqcxR4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844853;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=A99AeOsepyhZYrb6tBKH+cPw7yxwp3F2mAugchfooPM=;
	b=mvw85h+sx6TIGFn1lBtYuUTiOWMmvK4gePYYKR+2Vymfb4jrFh4QobCWiZzzCXWy3+Bv
	 WLOotGA0y8ZFQyoS8JHF29CvKpkF+OjChZgqNkCbYKc/hSpuFnoo4iTJdSKndedLIRmhh
	 IiNRjyNzEjiacPfA6ga8DD3/F/NMUBdI/N+Ta2S65BgT9kj6XpUvZkCK6nq7WWsIj4m2Q
	 9OCK3lcA/aN9Og717HgtA44wW7qewPYgw5v0NNImrMA1De8ovI3q0tmKlcvXxaXs893j2
	 LpVcEZ3MRXH/u2k0gh5fXrUbhZMOJ/NbWyqKYfppBe/risjtme2/2MNsClJQMByGZtw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TBsyoe57;
	arc=none smtp.remote-ip=209.85.216.52
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3D22F606A31B
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 12:27:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3D22F606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TBsyoe57
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-3ac78f4c10bso813725a91.1
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 05:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792844852; x=1793449652; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=A99AeOsepyhZYrb6tBKH+cPw7yxwp3F2mAugchfooPM=;
        b=TBsyoe57scG+7gChcsIza1CJQ/ThfKdm3ZYQ6bVo4LpohsJCVh5SAUUeHEQfFwCZf9
         VxShVxq2DxMi6f+JFvioMGa4IdpOQVKLUNrnX8CpkpCYuIbLtYFrhnEOg+ZJLXR/vtQ3
         iKwZ+L2sURLnKhysqX1/KLMnthCuwIj7eD8yfBDvreszdmnHzLRBBxZZwUGqhzqJnEek
         oBnKy6QETwZAJw6zpnUMTpoHHdCFzjfJBGg76mEtYGWB4Xiev7nSBhI0OGi3BOYGKL4C
         y3u9X6GDvdvEtX8NaY1sWwNy1ra8JpYFrU00MuNnFljs8cUWrXSQRnO1R/fTUXeSIp1x
         yWDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792844852; x=1793449652;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=A99AeOsepyhZYrb6tBKH+cPw7yxwp3F2mAugchfooPM=;
        b=kSYV8E1EbiiFN+97y4BLYmlTQBqhRuooFWxSyH0ffHDOqAapgHRmDNfhnOFbt/u1Ih
         E85jT32fcm8ZuZ/PZ5LGE9QOTTukkDiJfB50dmmfDpQQk60tx2neOSlK6qh3yE2xrnX2
         uu2Yi28gGzB5d9YBwx09DhIThst+4yV4RarRmM3L/SPol322dnECjpG2+5cKU74b1jRR
         5Q4R2Q6hGUuJ1iyXnUNhsZ7G74cWQMI/Hl3qFxuOSQGu8stHExaRGOeNLR70oye2fbnV
         WXrVJexXDgOPo56bl7EeHrNDsWiY5e1/b+hYyxUrujOuIMdNn3JPsky1JJni9dynGRWD
         dj6w==
X-Gm-Message-State: AFq9FYJhxdihRE9jtcD4MQRdS+ExIe4eSy3pN9AOk9+mAMd/KmD1o500
	SC/5CtqH2xxSQLI1ai2WYdmYE9OLY39gqezRVtyKFmoia2/Yjw9jmAPCZzlHuKk+9Xw=
X-Gm-Gg: AYBFou2qQ6z0ytB05HBwm4LjEklsXR5jy7LHDq3U0SBy2v7GcfKm2/Z744alIkKGvC4
	bsFeaaeKVeXLIUGZvBNfs+qdIS/tDDZzzsgbHEFHxHC5YD2rCvqLCggXew6U/1tCvvB/TS6GxQ+
	WTZd+HeI1Kx77EMsD9LuFLMmjxYOABWghGux+KZoHCWI5r8//pfBxS+lc4qlqwek7aRryco3iE5
	eiFkfU4saIHrZQZOqZC6aDz4ZOpFhUEftXh6Rsl3wXaY4z1ESamFvJp+uH+nwIzUefRQFz8g2DY
	prxajDQ9Dldy/O3fQjZjVxvcIxy/rPrTPtFXmndNQUwxffJlZ7zMyOBfNrDvjyVV2AivZFw854B
	wspjfmHmaTyRdux3GQbXXjWJbF0RNfawcErIqb+sKSN2AFkbmvs2JZUYjoq+kqJVya8E1Bq7lx9
	pFZVS6uElUGXyerVarrTB9Q3vLfll/9Hm/Fon4IR0PbcmISpE83m5dnuFjz+SZhqkGIFoWs2cRq
	sY+/VhSX/gIhibMT87fIscaXcFYB3wG71vVlQ523Mk7ZU0zcWQRGjwVpnT08M2YUZpqwh3A8DEe
	7j3ZheS0FG/qIt1yOg/M1rRCo/MdmzWj8nn5fxX4uAD4sQuHDANrlIv4/q2BMXNAyAv0Aw4KY0R
	fzI88Y8q47XzslZv51op2MqaEJH/BQMPUjIMU38mLzrvvxMXqN/LFLOF42nys5ecfDBSRDzbtaA
	cdfDuKeq8h24FJ9vpml0zsRnoelspLjwha8qxIHFcmljUI9cm9KCp7pEI3
X-Received: by 2002:a17:90a:c883:b0:3ab:ab5a:ef06 with SMTP id 98e67ed59e1d1-3adead43634mr1557455a91.12.1792844852520;
        Sat, 24 Oct 2026 05:27:32 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3adebae0094sm2814271a91.10.2026.10.24.05.27.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:27:31 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 5.15.y] net: gso: limit recursive IP-in-IP segmentation
Date: Sat, 24 Oct 2026 20:27:25 +0800
Message-ID: <20261024122726.663-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100308-overspend-conduit-cc1e@gregkh>
References: <2026100308-overspend-conduit-cc1e@gregkh>
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
Tested on top of v5.15.223. The patch also applies on top of the
current 5.15 queue (stable-queue fa04d3db75), with an 8 line offset in
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
index 24ceeab1b509f..402d5cbacbf1d 100644
--- a/include/linux/skbuff.h
+++ b/include/linux/skbuff.h
@@ -4649,10 +4649,18 @@ struct skb_gso_cb {
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
index 231700508d3cf..2b368392f6e60 100644
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
index 7197b18b052df..f7867bc188242 100644
--- a/net/core/dev.c
+++ b/net/core/dev.c
@@ -3475,6 +3475,7 @@ struct sk_buff *__skb_gso_segment(struct sk_buff *skb,
 
 	SKB_GSO_CB(skb)->mac_offset = skb_headroom(skb);
 	SKB_GSO_CB(skb)->encap_level = 0;
+	SKB_GSO_CB(skb)->recursion_counter = 0;
 
 	skb_reset_mac_header(skb);
 	skb_reset_mac_len(skb);
diff --git a/net/ipv4/af_inet.c b/net/ipv4/af_inet.c
index cbb1bf83a3a27..894bd396270b5 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1358,6 +1358,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
 	int id;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*iph))))
 		goto out;
diff --git a/net/ipv6/ip6_offload.c b/net/ipv6/ip6_offload.c
index 0de54467ee845..218894a70df3d 100644
--- a/net/ipv6/ip6_offload.c
+++ b/net/ipv6/ip6_offload.c
@@ -16,6 +16,7 @@
 #include <net/tcp.h>
 #include <net/udp.h>
 #include <net/gro.h>
+#include <net/ip_tunnels.h>
 
 #include "ip6_offload.h"
 
@@ -87,6 +88,9 @@ static struct sk_buff *ipv6_gso_segment(struct sk_buff *skb,
 	bool gso_partial;
 
 	skb_reset_network_header(skb);
+	if (unlikely(gso_recursion_inc_test(skb,
+					   IP_TUNNEL_RECURSION_LIMIT)))
+		goto out;
 	nhoff = skb_network_header(skb) - skb_mac_header(skb);
 	if (unlikely(!pskb_may_pull(skb, sizeof(*ipv6h))))
 		goto out;

base-commit: 792fbe1537d8daeca9bd1917e84078b5432aadc2
-- 
2.53.0

