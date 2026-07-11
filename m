Received: from mail-qk1-f171.google.com (mail-qk1-f171.google.com [209.85.222.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 650E1285068
	for <stable@vger.kernel.org>; Sat, 11 Jul 2026 15:06:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783782414; cv=none; b=VG9ObLyxWXDTYO2RxIlfdV8aigRgbC6wqEow7kEOMxwUArnTGSM+c8oQNjO3HVgKqcQHcylZHjDXdpZ/OCYG18YfGC0qGnrTsKa2OxTwYApOKfrFjpO0gjCQdrSXVvQMNuo2s3oUURV3oKIKcApza/IFRUUFOC6lw4v6SK736Ss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783782414; c=relaxed/simple;
	bh=eXimup/rS3zaRoVPDBO/BpRgrc2vA3jesXZPxz7A1HE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=F/PG5ScDtrDGn3QpfPPKVBBEvpzncmACOoxoWW4+SOuUoHERtpaw7MA/+ErtuiNJf/RcVUWJSqx5XY6ZPDQQ2ja0omtNB5bWYpfmQG+sKVUB1uNadj7E+toE50+Ziau/aU1ati6+6aBiqHXYeb3DXCK7ufirjCiEPuCrFfwLdgg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WsfjzUZY; arc=none smtp.client-ip=209.85.222.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsfjzUZY"
Received: by mail-qk1-f171.google.com with SMTP id af79cd13be357-92edb12cdf2so107276285a.3
        for <stable@vger.kernel.org>; Sat, 11 Jul 2026 08:06:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783782412; x=1784387212; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pylLKBo48mUBwphkQfLVRDh8jr+L260t0Ip5RKicSNk=;
        b=WsfjzUZYCa4FgDfamw1gCIbpGpsUknnqziHhs4anv/fmI43rc8JpYykMoEfC0l1N13
         VeE4P0PcX4JJOvNFlaku49Xzw4jtdY309mV30LBVxnOioEKoy8j+VjgWz7CRniUNoCKA
         HV6Op2W7i2thGkTWgzvZWjl1zOeqiKYsrygvzO554E9OKhCvXnLsm+J/k9Z7wdsx4Eyu
         3TZQT7l3A4cIJMIpc6nCeoBU5M2cixoA0LEdgwPWGtFuTwHWE5J2smz9qeaLdeFbNkMO
         dhKRP6pznvHbvo3Pkno1oGE76Y3VUVDMsBWbZHMRJPlXRZyS5vzAO5dJ9pdPm0m+Wi0+
         z6bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783782412; x=1784387212;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pylLKBo48mUBwphkQfLVRDh8jr+L260t0Ip5RKicSNk=;
        b=EYYiELqBr6wDcvS/OaItl3xvQ/1pWl/14iDAaCTf2/dh6vyZ4t3bRu/BEjqMxPceTV
         rAlcNacuF/YE4pUUYpbKiORMzqk4ApXYD/JYJ03A/rR2HL+og6veCJLjQJvZ0qa+hYIq
         yfW7UvPvVlDIYzCV+WkDrqE/lzH8izCHE5bAGYssFosu1QIMzEp7AQ/9a4pDkgbWpIjU
         Mgpr4Xsg9QWFOtGhHdffccqYQ1NMne26tXsX+d6xHjaj0wqL4LXtE6oBDrAZ8Qk3VO8C
         QUTMEACsCseLAh1m7/TJJWixSh8i3fHc7Zr62oj5lU/BS2aSnloeYOUkMXrnHk+NAv7M
         SIxg==
X-Forwarded-Encrypted: i=1; AHgh+RpNY4gB7xdY0BHoWSl+rmKYb5bg1J30nBdkvh2/YBW1Tj987CfM2iPCrsx39CXX+m2EcF/vOnw=@vger.kernel.org
X-Gm-Message-State: AOJu0YxuUlzQwuPA6EOuc3GATNBJBUSCBTBCtjOXk0vbUeydFujRo2UQ
	xd1vP49ULw4LTEmYGt/y/WsNPnYhbDSpTji7yhzMwutuuqYkFdW+WlGI
X-Gm-Gg: AfdE7clhkMISy6xPwqq1C2ZDBIYSf2AdwjToCjI7miKCxSUYDZEs1kGtTFS/UUoEVsU
	6rnGcMwIUTIEpdX1lzjBzFC0nYfTeUMJ7UIVyAtobrzuKCi88ljfkeRxmrbwT8mn792pWb83IPi
	yjBdxdHAvcxPda4uK8i+7JmaQTpjNp2GuCQ8GSfO038sMLHaQ6aV/aDne0oyltvYCOehSBvS2Vs
	B/Lc+7BDpU88pOAicg92E6PvzhC9iK0f5j5BURsZ/OWwSTDWlbO8XFyQ865ftpVMW1fIFKi7r1z
	9SfeJ7WBQKB9KzA/AfWJKTCkXo2614UvxxZLB3t9Jh9vEy3vQDQAGV5UjlwLZJHgVubanMoPowN
	9/DtAaQmxSSNt9Q3k5z94SiczDpgsBKp5eW4kBJ8aV36CccR8QbqwPML4OzsvhXSs+SBaVX0cgy
	wBk29ejr6UslqRe6eqyOv6O302t2/B23daaNKd6TaGXfjRjtJVIiprKkoQSWmTAHsui0zD5QMGm
	+Q982rGqg==
X-Received: by 2002:a05:620a:3952:b0:92e:c116:bf00 with SMTP id af79cd13be357-92ef2f8a31fmr317346685a.93.1783782412224;
        Sat, 11 Jul 2026 08:06:52 -0700 (PDT)
Received: from server0 (c-68-48-65-54.hsd1.mi.comcast.net. [68.48.65.54])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5b4920asm463219685a.4.2026.07.11.08.06.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 11 Jul 2026 08:06:51 -0700 (PDT)
From: Michael Bommarito <michael.bommarito@gmail.com>
To: "David S . Miller" <davem@davemloft.net>,
	Jakub Kicinski <kuba@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] ila: reload IPv6 header after pskb_may_pull in checksum adjust
Date: Sat, 11 Jul 2026 11:06:48 -0400
Message-ID: <20260711150648.2915106-1-michael.bommarito@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit

ila_csum_adjust_transport() caches ip6h = ipv6_hdr(skb) before calling
pskb_may_pull(). On a non-linear skb whose transport header sits in a page
fragment, pskb_may_pull() can call __pskb_pull_tail() / pskb_expand_head()
and free the old skb head, leaving ip6h dangling; the following
get_csum_diff(ip6h, p) then reads freed memory. ila_update_ipv6_locator()
has the same pattern and additionally writes the new locator through the
stale destination-address pointer.

Impact: a remote IPv6 packet routed through a configured ILA
csum-adjust-transport route or receive-side mapping triggers a
slab-use-after-free in ila_update_ipv6_locator() (KASAN). The route or
mapping requires CAP_NET_ADMIN to configure, but trigger packets are
unauthenticated once it exists.

Reload ip6h (and the derived iaddr) after each pskb_may_pull() before use,
matching the transport-header reload the code already performs.

Fixes: 33f11d16142b ("ila: Create net/ipv6/ila directory")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4-8
Signed-off-by: Michael Bommarito <michael.bommarito@gmail.com>
---
 net/ipv6/ila/ila_common.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/ipv6/ila/ila_common.c b/net/ipv6/ila/ila_common.c
index e71571455c8a0..acedc5a84e4d7 100644
--- a/net/ipv6/ila/ila_common.c
+++ b/net/ipv6/ila/ila_common.c
@@ -85,6 +85,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 			struct tcphdr *th = (struct tcphdr *)
 					(skb_network_header(skb) + nhoff);
 
+			ip6h = ipv6_hdr(skb);
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&th->check, skb,
 							diff, true, true);
@@ -96,6 +97,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 					(skb_network_header(skb) + nhoff);
 
 			if (uh->check || skb->ip_summed == CHECKSUM_PARTIAL) {
+				ip6h = ipv6_hdr(skb);
 				diff = get_csum_diff(ip6h, p);
 				inet_proto_csum_replace_by_diff(&uh->check, skb,
 								diff, true, true);
@@ -110,6 +112,7 @@ static void ila_csum_adjust_transport(struct sk_buff *skb,
 			struct icmp6hdr *ih = (struct icmp6hdr *)
 					(skb_network_header(skb) + nhoff);
 
+			ip6h = ipv6_hdr(skb);
 			diff = get_csum_diff(ip6h, p);
 			inet_proto_csum_replace_by_diff(&ih->icmp6_cksum, skb,
 							diff, true, true);
@@ -151,6 +154,9 @@ void ila_update_ipv6_locator(struct sk_buff *skb, struct ila_params *p,
 		break;
 	}
 
+	ip6h = ipv6_hdr(skb);
+	iaddr = ila_a2i(&ip6h->daddr);
+
 	/* Now change destination address */
 	iaddr->loc = p->locator;
 }
-- 
2.53.0

