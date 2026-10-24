Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.215.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792844836;
	b=u4Jmyybi6+YpVOGOK432fZIqBIDnNVhUJVmfd85Y+4vwb61W7p0NI7uCE1dnnkNRuCGP
	 A0n2UfIVZ865BAxfbumH6aswM6AvELP9UFo+ft7J6z8OwFIImBGiwxfDK8hbyzrfQxLer
	 yJQTxuxA1CW6pZ4HXeCGtNTqapstWBdNWnK0Bw4EXaDfAAD6kp9hdx4oQmuT3BWviH2P+
	 a/gi2Y6PM6eitr0lcM0y71j050V7R/oGCfz4ILwlyVL1HMzpx2o8Bd9qEAcikAE+4ElrS
	 CnjM5xiDKSd9Ftu22aF5gYSTEkP25C+s+CcdI45OmyyKvDRpl2RJj/etcuIKRr207Zw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792844836;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Gm-Message-State:X-Gm-Gg:X-Received:Received:From:To:Cc:Subject:
	 Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=dC76N5Ln0rNHOX7RlGPetCEM3CDaxZU/FdlijHkqlFU=;
	b=im4oa5Y3Mdbd7ZILzejr1ogijog/JAMUlnkSMXyBMwOAHUTci+ZxoGUgwZ1EHzHip2ui
	 Rb/1nSBP4c989RoKL+I9MI0s7eQgHftsZ1B6rodVGslx0CNV4uaWm0Tr+IvXZA4IEQjVU
	 fXh5BeKTG08m8MRWqe3PdsmItLbPf2KU9d7LTrfNN6IfVb+cnPrP3RYGuVe0paiUdepQz
	 F0UVO6ag5xASC0pNu6n5OTomDVcb9hDTBylZOQeoCgiS4fyZDb09A10QPCMn9QqOAyLBH
	 1bdqsC/4YfVlkzprAa9Mit6Q+OnzKVWfTbyPdMLOXt5CPESggjrunv+F+ZKqyPW+nzA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=obpTvdV9;
	arc=none smtp.remote-ip=209.85.215.171
Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CA3C606A32F
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 12:27:15 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2CA3C606A32F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=obpTvdV9
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-cd69954c755so1173116a12.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 05:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792844835; x=1793449635; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dC76N5Ln0rNHOX7RlGPetCEM3CDaxZU/FdlijHkqlFU=;
        b=obpTvdV9Dn94siwUyt7hoJ2e2Q2aJuSuUhXlKOfUwkwxRSna2+M+y94LVqhgr4O7eo
         rW4H5Gf8wdCVVY7ImnSNvUSrZU4h4j7QlAzajNQn9idYjQi+yG1Mll0ens7O69oNysO0
         TsueMcXPk4DBSRVJxHQ7rmeVJPrumC0xducaGsSq9ck/0/o4mHZlj8Y+3aYA8mZ2Pdil
         jAC9+GHRPLeQpz85BzgtcR+AjmdTPbnLPf9DHQoDoLusVPsIySm+EXqVaQ44oxk5foLN
         1hktYqMmt1G/qfpVauRNIHVzkgqZsYQkCxMEevBMSGmCgTaIUWCjTFYt7Uqx/bfAMYAA
         cxpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792844835; x=1793449635;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=dC76N5Ln0rNHOX7RlGPetCEM3CDaxZU/FdlijHkqlFU=;
        b=rtrJB1Ie8IuNiAt3cB7dn9ddlfCiABhtM4x+wGMhbU1uODVsmHE/jYjpXGnjjUv9T4
         yrse41nifCzUxyZT9mS9Wex+4Eh6m46zHxw6JXpdzFCEhuEa4FPhbmjUuCcKzk9MFmQd
         8Fbq+rIeo8ml4BFf7Oz7IoYLoWZRj7mqO5aStGTaNuR1/Eo8PWyxRteW2HCDD9GTtBfX
         0yWN18hZFWM+NMRTCzESD9TFUrchXQ1Q4QaarKuYCqMMr8PwI2qmx4SCCH50p7Q8ZT4r
         Kbnpv8GrouDmMFi2HX0+n1C3i6A9lhMq6lMHDuI5H2w2TfO9KgtNuce/+13PjX3o9V8U
         kH7A==
X-Gm-Message-State: AFq9FYJebo08pdooS+pgcPITVXu87cIxlWB7ofnmYB/tihhxsRjevdQy
	9lUne0Tf9FBX6D0QiRki4TAzy0jCwLoo63lky/ExREsrqL7pUG1xY84lscjFPULZjHc=
X-Gm-Gg: AYBFou3bW6rpJLr8nnWTvxG6a73kY5GyuupWYEmMQjcMbjAnevwKauKz45k3h49x9eV
	8B916gjp7P0nRgzPAxUnkLlo5BW10lk67xEMq7qiYmy5UEZ4FR4CSl/tzsGmCAfv5ChB+/GNzjy
	I2ma4WzOokz7B4rFRV5c44BDhogW+SexGq0F8k8Gkios4nLynhPic9H0TnJy9WHHqYf6eeQsgtd
	zlD27k+TebHD7wZ3x3VucLUi+JxQuSS3kVkQVRn4M4oOKOWITiC8HZUBKww3IpPQmD12lEQYfbs
	RrgFMIhhVQqYEouLwJdmlvcfnFdM3qSkFdD6A8SuWW+sjskIPRxyfw6UDYJmAZ3duVhxHc3xVe3
	0cQmYWoJxoTgTMV0OwEmkSKcsAOjFpCb8W3B9XxjebmyfjnaaLACGrVH+Y3/RVR3mC1WsMLG7p9
	oqBARQKLbhf5wbzp4QlTu9SRGtRSIatneu6DNZZh8QyB9z1G1dWgVsEA01bDYSvI/UrLpI3n0E9
	G/ANmKgG0eoJV3VgTqwN2ynTmTCFdtBQQtwqJK6kPIfj8XaOWlRDzJzJmbx1TJWdrqFOAP4m8gX
	Q7nZmlVpHTslza+vOBm6UFqmZjIreng1qmcJRcJDcF+jWlB+mixZByF9fieuGXaTNU778WoQl4d
	LwWilD0HOsLSPcpNdhukiNwk9BrszjXYd1oixPZOXfszaIMAbfKmQ6w60sHkCMIphFuTX8SJfME
	YeZQDwFhIFG46g7lGcUpHBdG3p/OLTvFoSBT715pqRIY8QZVCZIvjL3y81
X-Received: by 2002:a05:6300:6bdc:b0:3e2:97d7:bf3f with SMTP id adf61e73a8af0-3e7bfbdbc24mr1514660637.23.1792844835354;
        Sat, 24 Oct 2026 05:27:15 -0700 (PDT)
Received: from desktophank.localdomain (111-242-220-176.dynamic-ip.hinet.net. [111.242.220.176])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8a36c1f5084sm391670b3a.47.2026.10.24.05.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 05:27:14 -0700 (PDT)
From: Ting-Han Hou <ue081723@gmail.com>
To: stable@vger.kernel.org
Cc: Zihan Xi <zihanx@nebusec.ai>,
	Vega <vega@nebusec.ai>,
	Luxing Yin <root@tr0jan.top>,
	Willem de Bruijn <willemb@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Subject: [PATCH 6.12.y] net: gso: limit recursive IP-in-IP segmentation
Date: Sat, 24 Oct 2026 20:27:08 +0800
Message-ID: <20261024122708.582-1-ue081723@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100305-stillness-plexiglas-1e85@gregkh>
References: <2026100305-stillness-plexiglas-1e85@gregkh>
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
Tested on top of v6.12.114. The patch also applies cleanly on top of
the current 6.12 queue (stable-queue fa04d3db75).

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
index c310a60760f34..b67c20019978a 100644
--- a/net/ipv4/af_inet.c
+++ b/net/ipv4/af_inet.c
@@ -1380,6 +1380,9 @@ struct sk_buff *inet_gso_segment(struct sk_buff *skb,
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

base-commit: 85d82e0d7c2dfd3e75d34f35b7ebbf41f45c9c4e
-- 
2.53.0

