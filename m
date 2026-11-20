Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.217.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795150061;
	b=Bc0mcSPnxWj6c7UpuqVqgbrVGgVdMp/24Kp/C8ZqtubYAuFGOt8W6e9lzZqgDxkUwtUq
	 bREE4Bd2IKOABXbDS5FvsEChJRpJC872AJIl4OA6Hazz7Sc0VuRxWlwLloZk+gZZNyCFN
	 uXzB9r/oPRijWf0VkwSOY4wVy9mRmPtOrfyEgoLJRU6tozixqGPa4hawXDB9ezwpRupyR
	 NMehf3RqlWS/vJqf+Vx3eMgH1oHMiAOJTlCgyYlQJ8i3NDEqx3VwNAHYDo2q0Sk78FiIW
	 h60Qwzgfxqqg1zI3tgxoFA6VayYLolOwhNMM/x0GEL9R3lBU9HjBiZMXNgBsDh3a8GQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795150061;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=0Dbq0OftwgQ34TazviunYALXf3whbrl1E7GgWxSH2CM=;
	b=nInh+ibSq17QGpF7cSB0hfNTyYR2MOxDf2c7ResHK+ZtvHLeSj724PGWsZNs8YAlPWJ8
	 WVcL9/lhEF1nITaRhTfh8hLY4lTaA9oOX2BgiI9350gDp2ZiV1Im4I+sw0IqFieRLImsz
	 q/Wpfye6TjA3R0yqulvcsNSHHdPKa+JBYD+J5PfbTLjPKlYpHEp0bpk/68l/SAyspcLq8
	 cdVuThXPKY1LFv2s6by8nzoG2C//HWKTvrvRnqj1H/9TJNTRfI4KjPcOXobBbD+2gpazN
	 PdnYeGqe1JEoEzGB1LgyrsTlEOL2paxYM/xVO2QtJkzp8fvSQXQLxg/wkksMXFXQGRg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b="NpQBk/bP";
	arc=none smtp.remote-ip=209.85.217.49
Received: from mail-vs1-f49.google.com (mail-vs1-f49.google.com [209.85.217.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9383F60A2613
	for <stable@vger.kernel.org>; Fri, 20 Nov 2026 04:47:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 9383F60A2613
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=NpQBk/bP
Received: by mail-vs1-f49.google.com with SMTP id ada2fe7eead31-7d2ccd3c7a2so175917137.0
        for <stable@vger.kernel.org>; Thu, 19 Nov 2026 20:47:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1795150058; x=1795754858; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=0Dbq0OftwgQ34TazviunYALXf3whbrl1E7GgWxSH2CM=;
        b=NpQBk/bPFyAoyifff8Y3lUh9ltTSbHuXPlEFnA03Bvxh/H29BwSig8VG2apfymDedN
         /CYusUZf9L/wIamya4mlXtKNQ+XH3ULrc8Y4atiDRKM1J6XrsndkTniolWlDlH+l9EJ2
         evz5wzs0/xr2BwKqGLn0L/+cWzR3tzpbH1d6aOWY9SJ7AzyvFPx1V0OUCZYaChT95Nm+
         jj7Td5WWox+EhpRrjrSFaLT4v28Ks6RVKTV+ac4KcHXZcNqgnUq2aSG5pAZ/z6LdRf/Q
         yi3NxSjqHIIR9lmNe84LctiSB0SheNWgTjmWJt/jl8wVGwNdKU2uFFAHnMhUPBYo03J8
         xDhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795150058; x=1795754858;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=0Dbq0OftwgQ34TazviunYALXf3whbrl1E7GgWxSH2CM=;
        b=pqDwM5+RUJ/ljPLn1Syc81/IzIFvrcbA8J+N+NWM6rurNxL3eS8+UE9zpBcbSP7xLf
         D9RxHg2NCsJi45WPPiO2mdy41pWhGP/uw0wsE2syXFtQF37VZV+P5NOpF4fu8sH3zXiI
         kIDcGqTLYiSS+xyzINrQHyf8jfsGOXuIfiO5PE/yd6irFuwmbYtAQR/yJlqM+Kl1kcIS
         RYdQVhptsoFPVke48NYYuhv8IfM3W0Dlo6aLM2WuKJORxxJTf7NxdhvRx8BEqoDoykrt
         DN6ei9KhwOBVDVja4uIu81Z/M0WTAoQVT93rgueEzKru4r5UCdhXjW6Jta5g4m+ZQE64
         VsDQ==
X-Forwarded-Encrypted: i=1; AL+hErGQX5HLwLD1ZKIOAbqOyFTPVuEyx3UuTOg/VmwJcpMORyFKmlu/U5ozdYHWcCnUEtuq0ZYz/sk=@vger.kernel.org
X-Gm-Message-State: APuU4Z8DAgbq3Y4vHR4xxGjE0QKzbuYsknctJB/X+ooU2Ve4mpozYAjA
	C2zLOnnD/YZIg6i6npXyefl7svVhiYt8QLain2vJIxso8ULDr1DgcUf3
X-Gm-Gg: AZFdTZcCRS+hvUwi+iQF2YDNjGIrS5WDQlH5Tq+atiq9z2xgWjic7DsVJnc2VJNIe5W
	qq5DQ7/nMsf/m6k1el6Frizd7Sggls219azzL40xbOnShUpbfpH2q9lqir6L6l81v1wK6l9hfLs
	YllYi0PhBDFy+lBS+YeSEnpHmA8xfpxps9ka/klr1kFrUdmgYJLz/RjLB1xKO2HrlGxwCJ6zi3O
	zJgjSaqI9E9rniy0At0BAU+xlg2VqyOyXoaVc3NG53DU1IosKXmgUhiVkiRZDzVdQe1GENIWjNU
	YCYlSdEAx2oVGisSYBRZqhNTgpncLgV8o5gCFS669QBn5FJcXXM2kSWdNWRs6pdlD7M1j3DTAcz
	44XwZi86gTMsQ8MKoZDsH14HbXxl2DnuJqydLgh6wuosXMXDkg/uWenbln+CiSF1tS/uqi94kWl
	ibpuon1krNVm1iNDb+Y7+Rpx3rB4m/R5ezlI1i7owFrTgefXJ+r950GKw6xnIc2jrCDAj9dHTsF
	Af3T38YfU6e8cdk1DlonKg1x700V2lfP5EzRd8GbiZiE2CEOSoFpZ/e1aa/E9bfj0tEyzUT4oM5
	AWgBxHelOERAzaZIP2jyNU4qco0BMWtUrnC9aZXrfCW7PQ0GaYkqEOE0q3dX/wodK8msQgoXXpr
	GKFhFYlUYd7efdkSPx+w5PJ7YpUAUifQJ4M84j7o2Qdv+lF3itP6kgGtk8ycwcq/C8MGU2t+TZj
	b7GNIAj+dK5g==
X-Received: by 2002:a05:6102:292a:b0:7a6:d11b:16ea with SMTP id ada2fe7eead31-7d73935fb84mr699060137.6.1795150058439;
        Thu, 19 Nov 2026 20:47:38 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7d6e7f92680sm1966811137.5.2026.11.19.20.47.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Nov 2026 20:47:38 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org,
	Hassan Sultan <hassansultan@google.com>
Subject: [PATCH net v2 2/2] net: gso: fall back to skb_segment when fraglist cannot satisfy checksum
Date: Thu, 19 Nov 2026 23:46:40 -0500
Message-ID: <20261120044733.222627-3-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261120044733.222627-1-willemdebruijn.kernel@gmail.com>
References: <20261120044733.222627-1-willemdebruijn.kernel@gmail.com>
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

From: Willem de Bruijn <willemb@google.com>

skb_segment_list() keeps the original headers and checksum state of the
frag_list members. It ignores the checksum features and does not set up
the SKB_GSO_CB() checksum state. This breaks:

1. Outer tunnel checksums. __skb_udp_tunnel_segment() and
   gre_gso_segment() compute these with gso_make_checksum(), which
   reads stale SKB_GSO_CB() state, and needs an inner payload sum that
   skb_segment_list() does not compute.

2. CHECKSUM_PARTIAL packets, e.g., from veth or tun, sent to a device
   without checksum offload. Unlike skb_segment(), skb_segment_list()
   does not resolve these.

Extend the existing fallback to skb_segment() for modified geometry and
SKB_GSO_DODGY, from
commit 17bd3bd82f9f ("net: gso: fix tcp fraglist segmentation after pull
from frag_list"), to when:

- skb_tnl_header_len() is non-zero: UDP, GRE and MPLS tunnels (case 1).
- the features cannot checksum a CHECKSUM_PARTIAL packet (case 2).
- skb->encapsulation is set: encapsulations not seen by
  skb_tnl_header_len(). For example, ESP with xfrm offload in transport
  mode, as skb_segment_list() does not copy the ESP header and IV to
  the frag_list members. IPIP and SIT are excluded too, for simplicity.

Share this test between TCP and UDP in skb_gso_fraglist_ok().

This moves some correctly handled tunnel traffic to the slower
skb_segment(). Fraglist GRO is off by default.

Discovered through analysis by an LLM. Reproduced on an unmodified
kernel and verified with LLM-generated reproducers in virtme-ng.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
Cc: stable@vger.kernel.org
Reported-by: Hassan Sultan <hassansultan@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 include/net/gso.h        | 33 +++++++++++++++++++++++++++++++++
 net/ipv4/tcp_offload.c   |  5 ++---
 net/ipv4/udp_offload.c   |  5 +++--
 net/ipv6/tcpv6_offload.c |  6 +++---
 4 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/include/net/gso.h b/include/net/gso.h
index 119fc4c170e1..6cf6a6dee234 100644
--- a/include/net/gso.h
+++ b/include/net/gso.h
@@ -3,6 +3,7 @@
 #ifndef _NET_GSO_H
 #define _NET_GSO_H
 
+#include <linux/netdevice.h>
 #include <linux/skbuff.h>
 
 /* Keeps track of mac header offset relative to skb->head.
@@ -39,6 +40,38 @@ static inline int skb_tnl_header_len(const struct sk_buff *inner_skb)
 		SKB_GSO_CB(inner_skb)->mac_offset;
 }
 
+/**
+ * skb_gso_fraglist_ok - test whether skb_segment_list() can segment an skb
+ * @skb: SKB_GSO_FRAGLIST skb to segment
+ * @features: features for the output path
+ * @hdrlen: transport header length
+ * @proto: network protocol, for checksum offload
+ *
+ * Return: false if the skb must be passed to the more general skb_segment().
+ */
+static inline bool skb_gso_fraglist_ok(const struct sk_buff *skb,
+				       netdev_features_t features,
+				       unsigned int hdrlen, __be16 proto)
+{
+	/* Geometry modified, e.g., by a pull from frag_list */
+	if (skb_pagelen(skb) - hdrlen != skb_shinfo(skb)->gso_size)
+		return false;
+
+	if (skb_shinfo(skb)->gso_type & SKB_GSO_DODGY)
+		return false;
+
+	/* Tunnel headers and outer checksums are not rebuilt */
+	if (skb->encapsulation || skb_tnl_header_len(skb))
+		return false;
+
+	/* Checksums are not resolved in software */
+	if (skb->ip_summed == CHECKSUM_PARTIAL &&
+	    !can_checksum_protocol(features, proto))
+		return false;
+
+	return true;
+}
+
 static inline int gso_pskb_expand_head(struct sk_buff *skb, int extra)
 {
 	int new_headroom, headroom;
diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index 520778c5ca7f..7691be01da4d 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -105,11 +105,10 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
 		return ERR_PTR(-EINVAL);
 
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
-		struct tcphdr *th = tcp_hdr(skb);
 		int err;
 
-		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
-		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
+		if (skb_gso_fraglist_ok(skb, features, tcp_hdrlen(skb),
+					htons(ETH_P_IP)))
 			return __tcp4_gso_segment_list(skb, features);
 
 		err = skb_cow_head(skb, 0);
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index b77ae2f00c62..243bd75302d8 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -519,8 +519,9 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 		 * the frag_list skbs still have the IP family we segment for,
 		 * as their network headers are not rebuilt.
 		 */
-		if ((skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size) &&
-		    !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY) &&
+		if (skb_gso_fraglist_ok(gso_skb, features, sizeof(*uh),
+					is_ipv6 ? htons(ETH_P_IPV6) :
+						  htons(ETH_P_IP)) &&
 		    ip_hdr(skb_shinfo(gso_skb)->frag_list)->version == (is_ipv6 ? 6 : 4))
 			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
 
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index 0914f95f100c..71feb92aeac2 100644
--- a/net/ipv6/tcpv6_offload.c
+++ b/net/ipv6/tcpv6_offload.c
@@ -9,6 +9,7 @@
 #include <linux/skbuff.h>
 #include <net/inet6_hashtables.h>
 #include <net/gro.h>
+#include <net/gso.h>
 #include <net/protocol.h>
 #include <net/tcp.h>
 #include <net/ip6_checksum.h>
@@ -177,11 +178,10 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
 		return ERR_PTR(-EINVAL);
 
 	if (skb_shinfo(skb)->gso_type & SKB_GSO_FRAGLIST) {
-		struct tcphdr *th = tcp_hdr(skb);
 		int err;
 
-		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
-		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
+		if (skb_gso_fraglist_ok(skb, features, tcp_hdrlen(skb),
+					htons(ETH_P_IPV6)))
 			return __tcp6_gso_segment_list(skb, features);
 
 		err = skb_cow_head(skb, 0);
-- 
2.56.1.750.gf70dc682cf-goog

