Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.173
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794435124;
	b=mEY2c2L8pbEglCscSX5LbHwrHvVghvGAq1FmWdRyK+AJE0oSXF8KZYoIdTTROtfSqHrW
	 sD6HaLBOqLotOOmWeZvUfsJhmJXP7KWFIiGxwFChqGm29/dJqrzW1DHIUK917ib1HA8G3
	 VelAV0qKvvZiK6OGNdacmMOsUsw1tBU8icQgmC9zPXpRqbwOJvUWAQ5P5BcRmVYqCk5iO
	 FicgRCPfj9vsDT3eX1QZQzWV+5kMhJ+lXniW7ItXc+xr97N38B/O/m5ZBMnumePqWa6tS
	 Vx129oK2wcRv1nzMd3zOkWJN2EFggkf6YAmdriI03+Fo8dPqYElR/1X+7gVHJFHZ/nw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794435124;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=YusQ8PlgAGqBdQdfglodyV3rGnWf6b61Lk1KvehKD9M=;
	b=fr6fFxG7MldObiUdAv+LWYK6WSWVkgvD7CCSiqUxV1U+sEPfbtvuNuDk9TDx2eByRDue
	 H4d0Ru0TrQKC7FtJRKhQ8b/M4eZvb3G7u+V9xQL4HKg4BF93QTlGQ7+kSoZyxv4+g9mkn
	 cz6uCwuHSMojHLV2u1Eu3eclCM4IOqbGOq9lhlGLyd2iYCPL0FLpE9Iu+8XuGp5iD8fGJ
	 ZhZzKVDz72wael9tf4KC7GxBJAuIz/ByQt3O+G79AQ97BYJ0MbngYMGpboPe014LLHrHm
	 inD6C7SPR6TCqvc5TbdSwmcqKNsHjHDH0T5YhfErxMkolQG1i7p36RmmCTwJTcSNflg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJEf4wzt;
	arc=none smtp.remote-ip=209.85.221.173
Received: from mail-vk1-f173.google.com (mail-vk1-f173.google.com [209.85.221.173])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDCA9606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 22:12:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org CDCA9606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=OJEf4wzt
Received: by mail-vk1-f173.google.com with SMTP id 71dfb90a1353d-5ec20398b05so2112480e0c.1
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 14:12:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794435122; x=1795039922; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=YusQ8PlgAGqBdQdfglodyV3rGnWf6b61Lk1KvehKD9M=;
        b=OJEf4wztHUDi7BsM+plgvShXgiwGdHpEG1KE3uG7ykCHYPZL5IiAAVx6WqM5iCKL8U
         R5i11xbcLBqsKEhUFhL+OMGX3pHekqxWS3pUbMl2l/rv6BztG/W8kKaReZasPQQLhMDR
         ckJyLrtSwnh2T9/qp4XANIelY3ZQqsdcYGHnajZ+0aUvSoZ4rPXgwgy/nTjvgXY5378b
         7SCCFsStYL+nAhLdIsQj1TCaCtGSxpzllIPOKBiesqpT22x2XYYh+6nQiycyDSE/9e8j
         EdZZ87yii8NxbypcCI79bdxXEvLIwb1dSYPfAwmjSrqbdMlswsSuJU/hVXrBTrKypP1+
         8/FQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794435122; x=1795039922;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=YusQ8PlgAGqBdQdfglodyV3rGnWf6b61Lk1KvehKD9M=;
        b=zeIMF/bGTsksJLPbxRO6BU4ssQvP3WSkxtsgKi1mlgUwqsapLT6T/o3C6Uv9UfNPfd
         vlFKRsW8cYooLlBnfH510uC9q/ryBG1PuKVp2Ci1CXUExeLEpSEmBgjKAVl29s8SgTgF
         qlvusaaGEyECvIAI7V4LsEW3+87D1CY3OljCyimTRFbEQMg3Y3DnPWEqJsN44ACalQEs
         jXgE9io0P1RTuAw5DcbPwWCqckQOwKimtqOkBUvTgV1KiIeZumPCditfhfqM0LwM8Gxc
         7L7ON419vMop29agEb1d1vs4TArSw8/NIWilunZmcCzudKmAQzqErtLF2KmUEB04va5z
         Ztew==
X-Forwarded-Encrypted: i=1; AL+hErHvtE+GuhQLVfyAlj2WHFRC8vg/HKdZmlgxucOm82++hEv78dPSH8Y0AbPC+appr2QplRZ+8QQ=@vger.kernel.org
X-Gm-Message-State: APuU4Z+sBnQ8oppRjboY9hGM9EMQr0I7e+xpoF/r+IwjoziPAlp2/1mc
	BNvKnA/jR73UxuaL89DOn5Y7T/lGaDR5n0wnvT/vtb4sWUeisTJlgV9c
X-Gm-Gg: AYBFou2cRNZnDDA3qczBe+x2+cMbAXHX3n/JDiuBTOdhpq1rQO029mrhg7MOoJv7+rZ
	n+hEE39xrYXJEbqFM60faP9UXfUnbHFW6DZop0Fsp8i0oUi5wmgeW2tWPHWY8lK0cDmnVQUSMVL
	TyWRs1o7A/4zNVVOgHgGloiwk6by6ZuOEwOafCypAH2a0xbfa+MPF1G8cuXQHs8KSfGITlBupcX
	YVfu4VYS+vcJeKo66PDUV6JFq8Mu+ElTd1gWZDc9djIaGYih5P96D2MMSireQq3mFgY3ZyTuAXH
	C8Pbh77+1Ia7qDc979Iu2tsd3Zl9azN5SUwJ0PyMhG10jPJqaOZH8OGPv/KwDs8LOUgniDcIXoo
	4W4LRLgMtzoGPKtGUMJFkc2PHQxP6AhaeGrsgrQ5wL0TYFjP5hUdyVd/OAdbYExO1y5GqJTOo2g
	zDTTI639wJLWMmF1v9jES+3kWMR/2oFTAPHEr4O/e4RjWyKfL8YEEVhRv8W8s7y7g91G/AvAWGg
	yIZqUdorTYeEuWKmgh/w4GcFM2noVyKSvrsZMZtAnz5nCwuVezfqt6oAKOOfM4tY51pMWY40uod
	FCho1IHOiTACI/acA38JbtStjRLpSbD1omSV4WQ+Xkxeg5Lz/7+vSZ3TarlWloC6fbQokL3oAxj
	DJNaHMoNKSWevly6rB91PQOL7bcPBb03bUx+94bsBGZVRpzCuTAkC4s9bIEuPh/GX+N8lRDpvzb
	TWGvZNV9hYd0A=
X-Received: by 2002:a05:6122:62e6:b0:5ea:c11b:431a with SMTP id 71dfb90a1353d-5ee1c408083mr1682066e0c.9.1794435122563;
        Wed, 11 Nov 2026 14:12:02 -0800 (PST)
Received: from willemb.c.googlers.com.com (15.60.86.34.bc.googleusercontent.com. [34.86.60.15])
        by smtp.gmail.com with ESMTPSA id 71dfb90a1353d-5ee27570155sm436357e0c.12.2026.11.11.14.12.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 14:12:02 -0800 (PST)
From: Willem de Bruijn <willemdebruijn.kernel@gmail.com>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	edumazet@kernel.org,
	pabeni@redhat.com,
	horms@kernel.org,
	steffen.klassert@secunet.com,
	Willem de Bruijn <willemb@google.com>,
	stable@vger.kernel.org,
	Hassan Sultan <hassansultan@google.com>
Subject: [PATCH net] net: gso: fall back to skb_segment when fraglist cannot satisfy checksum
Date: Wed, 11 Nov 2026 17:10:33 -0500
Message-ID: <20261111221129.829218-1-willemdebruijn.kernel@gmail.com>
X-Mailer: git-send-email 2.56.0.567.gdb80ae8cd5-goog
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

skb_segment_list() keeps the original transport headers and checksum
state of its frag_list members. It ignores the checksum bits in features
and does not initialize the SKB_GSO_CB() checksum state. This breaks in
two cases:

1. Outer tunnel checksums. __skb_udp_tunnel_segment() and
   gre_gso_segment() compute them with gso_make_checksum(), which
   reads SKB_GSO_CB() fields that hold stale skb->cb contents. The
   outer checksum also needs the inner payload sum, which
   skb_segment_list() does not compute.

2. CHECKSUM_PARTIAL packets, for example from veth or tun, sent to a
   device that cannot checksum them. skb_segment_list() does not fix
   this up, unlike skb_segment().

Fall back to more generic skb_segment() in these cases, as already done
for modified geometry and SKB_GSO_DODGY. Expand to when

- skb->encapsulation is set (IPIP, ESP)
- skb_tnl_header_len() is non-zero (UDP, GRE and MPLS tunnels)
- the features cannot checksum a CHECKSUM_PARTIAL packet.

skb_segment is a strict superset of skb_segment_list functionality.
This is always safe.

This also moves encapsulated packets that were handled correctly, such
as those in tunnels without outer checksums, to the slower
skb_segment() path. Fraglist GRO is off by default.

Discovered through analysis by an LLM. Reproduced on an unmodified
kernel and verified with LLM-generated reproducers in virtme-ng.

Fixes: 9fd1ff5d2ac7 ("udp: Support UDP fraglist GRO/GSO.")
Fixes: bee88cd5bd83 ("net: add support for segmenting TCP fraglist GSO packets")
Cc: stable@vger.kernel.org
Reported-by: Hassan Sultan <hassansultan@google.com>
Signed-off-by: Willem de Bruijn <willemb@google.com>
---
 net/ipv4/tcp_offload.c   | 5 ++++-
 net/ipv4/udp_offload.c   | 7 ++++++-
 net/ipv6/tcpv6_offload.c | 6 +++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/net/ipv4/tcp_offload.c b/net/ipv4/tcp_offload.c
index b84fcd07c723..127035ba4faa 100644
--- a/net/ipv4/tcp_offload.c
+++ b/net/ipv4/tcp_offload.c
@@ -108,7 +108,10 @@ static struct sk_buff *tcp4_gso_segment(struct sk_buff *skb,
 		struct tcphdr *th = tcp_hdr(skb);
 
 		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
-		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
+		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY) &&
+		    !skb->encapsulation && !skb_tnl_header_len(skb) &&
+		    (skb->ip_summed != CHECKSUM_PARTIAL ||
+		     can_checksum_protocol(features, htons(ETH_P_IP))))
 			return __tcp4_gso_segment_list(skb, features);
 
 		skb->ip_summed = CHECKSUM_NONE;
diff --git a/net/ipv4/udp_offload.c b/net/ipv4/udp_offload.c
index cd9d7426b227..8e9610d35083 100644
--- a/net/ipv4/udp_offload.c
+++ b/net/ipv4/udp_offload.c
@@ -516,7 +516,12 @@ struct sk_buff *__udp_gso_segment(struct sk_buff *gso_skb,
 	if (skb_shinfo(gso_skb)->gso_type & SKB_GSO_FRAGLIST) {
 		 /* Detect modified geometry and pass those to skb_segment. */
 		if ((skb_pagelen(gso_skb) - sizeof(*uh) == skb_shinfo(gso_skb)->gso_size) &&
-		    !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY))
+		    !(skb_shinfo(gso_skb)->gso_type & SKB_GSO_DODGY) &&
+		    !gso_skb->encapsulation && !skb_tnl_header_len(gso_skb) &&
+		    (gso_skb->ip_summed != CHECKSUM_PARTIAL ||
+		     can_checksum_protocol(features,
+					   is_ipv6 ? htons(ETH_P_IPV6) :
+						     htons(ETH_P_IP))))
 			return __udp_gso_segment_list(gso_skb, features, is_ipv6);
 
 		ret = __skb_linearize(gso_skb);
diff --git a/net/ipv6/tcpv6_offload.c b/net/ipv6/tcpv6_offload.c
index eec3778855eb..5b830d244660 100644
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
@@ -180,7 +181,10 @@ static struct sk_buff *tcp6_gso_segment(struct sk_buff *skb,
 		struct tcphdr *th = tcp_hdr(skb);
 
 		if ((skb_pagelen(skb) - th->doff * 4 == skb_shinfo(skb)->gso_size) &&
-		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY))
+		    !(skb_shinfo(skb)->gso_type & SKB_GSO_DODGY) &&
+		    !skb->encapsulation && !skb_tnl_header_len(skb) &&
+		    (skb->ip_summed != CHECKSUM_PARTIAL ||
+		     can_checksum_protocol(features, htons(ETH_P_IPV6))))
 			return __tcp6_gso_segment_list(skb, features);
 
 		skb->ip_summed = CHECKSUM_NONE;
-- 
2.56.0.567.gdb80ae8cd5-goog

