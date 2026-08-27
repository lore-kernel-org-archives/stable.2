Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com [209.85.222.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67C1230DECB
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 06:08:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787810904; cv=none; b=O5/Ni+l8k86hOBib/+EIz1TXiI2RoycUoSAm0YKOOCmmLEaOtScMoNQL8yr6L7RLm87Yx0vXfNKPERwvRKVBy6kvXFCrm7yl/QyOACfY4FP4sAFhqRzGxcvuTJbWA1/bPrdCrrdRWCBnUGeR/h/HCqxtqJfrn/C9W5ye124oLlg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787810904; c=relaxed/simple;
	bh=JjeV6SBxpTEvPk4yf54OpOKenr/0yhaA7f6S2rHJ1sQ=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=GXPQMTyrfO0oIkCYRwZbn9yVnAmFhptJq1hxCwfl8waxhgY/kIVzECECLU8el1Pr12HYdDa4y/PDzQEwkxf0u8fOjJjW+Qq+/zlh3KSdpAUMNum6wOe0l9QQSrme4RwCf1aUHSNjG2WcvPBhXtDh4jvyJuOaMZw8rUuqibdKoYY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=AIRi4BXQ; arc=none smtp.client-ip=209.85.222.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--edumazet.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="AIRi4BXQ"
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-92e62e3459fso163069185a.0
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 23:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1787810902; x=1788415702; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:mime-version:date:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=/iiOyDOkD+5yeEIfVUarugFT3BFykOT3O/N/YLpxQ+0=;
        b=AIRi4BXQldp8RWyWLmFiAH8xSAn2z1EehQlC9YKmmxPOivtUZvLcGzQLMxhxo7fM1w
         jV11F/1t3IcSOY+qTIp7dqKuMqxT3PMNOTGZdTKDSMuEP9oBVc6oo2jRgxW0UXy2lFFe
         D/BBoOqzCpLApPrV6KTrSyN4zwXuWeWISBkmBOCENeX0cjuVCfq1ACkgodBVwLF0SV0C
         o028sz7Lm8MlN9xpZK+1Ygvtmx7WemEbP76+ZsU3laTT4nUKxkIAZq+yLVjSHqsasgvG
         GS/7JsG2SiHs61LdaHdUjLIHV4xe9HknKZuGjJgvqRdT5sm3QOYSDxRGMZHpfefIsnlx
         yiYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787810902; x=1788415702;
        h=content-type:cc:to:from:subject:message-id:mime-version:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=/iiOyDOkD+5yeEIfVUarugFT3BFykOT3O/N/YLpxQ+0=;
        b=SD0qTvGqoRkNV8ctcuWytA9h6Tgutq6FbL4NylB8DCD6+pomCR6tbzizEGjNCfOk1O
         UT5xfo6wgtiTNKEh2rHIEdRIQlHQGIb4X1Z1eTo3MXdF1wViBgrVJdC2v0du/fAQlS5t
         +gpPdEStw8guyg7MOWKSWa943HL4VlXTJE5mWX8McZEI8+DbwI3YOa9JqtkczT4EqrI5
         84vCgGRU+6jqbP+MOd+x9xnLnJRqKyEacY+k0nXU8DI1pPJRTxXADlxA+hs4pzw+6BoC
         tqClJ8QwyGHuBVGPrbwvfOgxHqgA3X3IQwPTvOyR0EO22C04J9G6VREwpxmkOp0TcG2X
         qv7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqTj3BUJ71WwNy+TpLaUilA3ftk7yxlSw0A5jHUJwptAiXeFd02evOO1i2RKPd82va/v0j7//w=@vger.kernel.org
X-Gm-Message-State: AFuF++nq872yXxR4IBK9DPdbS/iFegm9yShJmJkWvmCTPw2Mmo57MyjM
	+LHknadHdwalMu9vDaXWPqvO76yBe/cuDOyDbb3AT325jnLRSbFfGDfyAcXOtnDUeOGFl4anwN1
	paAGq3EbfqdLx0g==
X-Received: from qkbt7.prod.google.com ([2002:a05:620a:1287:b0:92e:5eda:6273])
 (user=edumazet job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:620a:4396:b0:937:2f3c:fed6 with SMTP id af79cd13be357-937801054bfmr1185869885a.5.1787810901759;
 Wed, 26 Aug 2026 23:08:21 -0700 (PDT)
Date: Thu, 27 Aug 2026 06:08:01 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.55.0.887.g758fc8c411-goog
Message-ID: <20260827060801.229990-1-edumazet@google.com>
Subject: [PATCH] net: gro: properly validate BIG TCP aggregation criteria
From: Eric Dumazet <edumazet@google.com>
To: Greg KH <gregkh@linuxfoundation.org>, Jakub Kicinski <kuba@kernel.org>, 
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>, eric.dumazet@gmail.com, 
	Eric Dumazet <edumazet@google.com>, Sam Dlinn <sledge@meta.com>, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When GRO attempts to aggregate packets beyond GRO_LEGACY_MAX_SIZE (64KB),
BIG TCP should only be permitted for plain IPv4 TCP and plain IPv6 TCP
(with sufficient MAC header room to insert the temporary HBH jumbo header).

However, commit b1a78b9b9886 ("net: add support for ipv4 big tcp")
loosened the check in skb_gro_receive(), leading to several issues:

1. skb_gro_receive() checked skb_headroom(p) instead of the actual space
   before the MAC header (p->mac_header). Because skb_headroom(p) includes
   mac_len, crafted frames (e.g. injected via AF_PACKET) can pass the check
   with p->mac_header < 8 bytes. When ipv6_gro_complete() inserts the
   temporary HBH jumbo header, the memmove() starts before skb->head,
   causing an out-of-bounds write and wrapping skb->mac_header.
2. It allowed non-IP protocols such as software VLAN (ETH_P_8021Q /
   ETH_P_8021AD) to aggregate beyond 64KB because
   p->protocol != ETH_P_IPV6 was true.
3. It checked p->encapsulation instead of NAPI_GRO_CB(skb)->encap_mark,
   allowing encapsulated flows (e.g. SIT / IPv6-in-IPv4) to aggregate
   beyond 64KB.

Fix skb_gro_receive() to strictly enforce:
- NAPI_GRO_CB(skb)->proto == IPPROTO_TCP
- Not encapsulated (!NAPI_GRO_CB(skb)->encap_mark && !p->encapsulation)
- Protocol must be either ETH_P_IP or ETH_P_IPV6
- If ETH_P_IPV6, p->mac_header must be at least
  sizeof(struct hop_jumbo_hdr)

Returning -E2BIG from skb_gro_receive() ensures that packets which cannot
become BIG TCP are cleanly flushed at <= 64KB and delivered intact without
dropping.

This issue does not exist in mainline (7.0+) because the subsystem was
rewritten in commit 81be30c1f5f2 ("net/ipv6: Drop HBH for BIG TCP on RX
side"), making this fix relevant only for older stable branches like
6.18.y.

Fixes: 0fe79f28bfaf ("net: allow gro_max_size to exceed 65536")
Fixes: b1a78b9b9886 ("net: add support for ipv4 big tcp")
Reported-by: Sam Dlinn <sledge@meta.com>
Cc: stable@vger.kernel.org
Signed-off-by: Eric Dumazet <edumazet@google.com>
---
 net/core/gro.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/core/gro.c b/net/core/gro.c
index 70770f9f9c45bdebbf09c00815ca21bc50a09ac1..252d7851d1aee55a8a65f656224a98da1140916d 100644
--- a/net/core/gro.c
+++ b/net/core/gro.c
@@ -118,9 +118,12 @@ int skb_gro_receive(struct sk_buff *p, struct sk_buff *skb)
 
 	if (unlikely(p->len + len >= GRO_LEGACY_MAX_SIZE)) {
 		if (NAPI_GRO_CB(skb)->proto != IPPROTO_TCP ||
+		    NAPI_GRO_CB(skb)->encap_mark ||
+		    p->encapsulation ||
 		    (p->protocol == htons(ETH_P_IPV6) &&
-		     skb_headroom(p) < sizeof(struct hop_jumbo_hdr)) ||
-		    p->encapsulation)
+		     p->mac_header < sizeof(struct hop_jumbo_hdr)) ||
+		    (p->protocol != htons(ETH_P_IPV6) &&
+		     p->protocol != htons(ETH_P_IP)))
 			return -E2BIG;
 	}
 
-- 
2.55.0.887.g758fc8c411-goog

