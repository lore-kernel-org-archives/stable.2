Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54CEA18DB2A
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199699; cv=none; b=RPpTfpEedwAbRj6nS2m0PCdXy9ri0RIpt728/V7gh4d91/ev/Y5SjuM2ejmR7/11NAgR31yrHU/33b/b2GwPJ3LRXTDkLP1oMuYGAbganEGslyysjtoJnTcb5TfvG17J/S95nSyVPDe6/b373piOd2A4ohV1IJR86f1tc7jO/IE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199699; c=relaxed/simple;
	bh=1/lktrcl1mUaNF0RcdF7Vz03qhvFhAKK9sAjhkh5l6o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=a3s1JS8tOd0L0hdQNJKJeOLY3wBfljrQQeOUAT+AJZhQHywIJKILksJEfIk3CcfcbJp2uyHur5QpmaJlzAzn9fn3Sb9qqCXc5vio07wig+c/AZvzxwWYBQY25pE4elO55ukHiRi6k5xBB1dLo3GCOPYuhG/gctv3Jj1HwmUamwI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Oy8ufg6O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Oy8ufg6O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 819C21F000E9;
	Thu, 20 Aug 2026 04:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787199698;
	bh=iFuZUtKE/rtt7WSYUQlaJiisrDQORmeo9IajeLDhmq4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Oy8ufg6ObZu5aNCEnrOLNcd8sZGXxxAvfDSD7USdjEORI2SlttciQvyjUUl4VcCxS
	 XByqLGQ8ZQeCHedXI1j2CYpjst8cXAXPQ4AKUBKnBv+gYlYEO8i+k787JgKQLOp1ub
	 XLPM3bE/mOio1j43XPZK5ig7WUwQa0SDA5L98W+Hd/evan1xPhyfZywG4QFmIF1uLt
	 UIJD1522hftOFtYy7GxzxR7jtUFeNpsAhFoXVspkAKtphgTLMyejVlc62sOKobyMqv
	 PVqXv6s3ALK5pHfayumn+njxUj6k09mWaffy68JTbq+Ja+IMCgKkcA3TZsHR7gNvM2
	 vR2HqL/eJNnAQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/5] net: add a couple of helpers for iph tot_len
Date: Thu, 20 Aug 2026 00:21:31 -0400
Message-ID: <20260820042135.1376434-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081754-splendid-scabby-9156@gregkh>
References: <2026081754-splendid-scabby-9156@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Xin Long <lucien.xin@gmail.com>

[ Upstream commit 058a8f7f73aae1cc22b53fcefec031b9e391b54d ]

This patch adds three APIs to replace the iph->tot_len setting
and getting in all places where IPv4 BIG TCP packets may reach,
they will be used in the following patches.

Note that iph_totlen() will be used when iph is not in linear
data of the skb.

Signed-off-by: Xin Long <lucien.xin@gmail.com>
Reviewed-by: David Ahern <dsahern@kernel.org>
Reviewed-by: Eric Dumazet <edumazet@google.com>
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
Stable-dep-of: 8a7ed561671a ("net/sched: act_ct: fix sk_buff leak when the header checks reject a packet")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/linux/ip.h  | 21 +++++++++++++++++++++
 include/net/route.h |  3 ---
 2 files changed, 21 insertions(+), 3 deletions(-)

diff --git a/include/linux/ip.h b/include/linux/ip.h
index 3d9c6750af627..d11c25f5030a0 100644
--- a/include/linux/ip.h
+++ b/include/linux/ip.h
@@ -35,4 +35,25 @@ static inline unsigned int ip_transport_len(const struct sk_buff *skb)
 {
 	return ntohs(ip_hdr(skb)->tot_len) - skb_network_header_len(skb);
 }
+
+static inline unsigned int iph_totlen(const struct sk_buff *skb, const struct iphdr *iph)
+{
+	u32 len = ntohs(iph->tot_len);
+
+	return (len || !skb_is_gso(skb) || !skb_is_gso_tcp(skb)) ?
+	       len : skb->len - skb_network_offset(skb);
+}
+
+static inline unsigned int skb_ip_totlen(const struct sk_buff *skb)
+{
+	return iph_totlen(skb, ip_hdr(skb));
+}
+
+/* IPv4 datagram length is stored into 16bit field (tot_len) */
+#define IP_MAX_MTU	0xFFFFU
+
+static inline void iph_set_totlen(struct iphdr *iph, unsigned int len)
+{
+	iph->tot_len = len <= IP_MAX_MTU ? htons(len) : 0;
+}
 #endif	/* _LINUX_IP_H */
diff --git a/include/net/route.h b/include/net/route.h
index 39be632a9822d..717579169d573 100644
--- a/include/net/route.h
+++ b/include/net/route.h
@@ -35,9 +35,6 @@
 #include <linux/cache.h>
 #include <linux/security.h>
 
-/* IPv4 datagram length is stored into 16bit field (tot_len) */
-#define IP_MAX_MTU	0xFFFFU
-
 #define RTO_ONLINK	0x01
 
 #define RT_CONN_FLAGS(sk)   (RT_TOS(inet_sk(sk)->tos) | sock_flag(sk, SOCK_LOCALROUTE))
-- 
2.53.0

