Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794452911;
	b=ZsKq4fTUgkW/UrISkdl5Y4KDRrJz4iQSlkqFjpk15bSPLqx6Z0xbJFmnTV2cA+Rz5i7r
	 DBuyF3ffjeGo6zIFRwCdPl5XlTBhOgWmBtjQS/S4q1wfbPnp0IImgEi7kR8cTT3p1c3FY
	 aV/Vu2SHdRHWxhz6wpjaY+/MsdOTNPWab3AaH7yjUdyOM8w1fjp4Gh9iSG7Lgl9MgcKoI
	 3gai5XK+T8loMxNY8RdeBPyDOFrqJACoSlrUDEIbkQdrjg6EJMl3bUrl8nEnZjMejowrV
	 G19jAPV3p6/HRDQZa5pZLbF/Vi+Vz+24o3mi0fCCUYvJ1Ucr/rd/Fo/4iMPlsOCqADA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794452911;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=GyyT0WVWHd4LNlKM1nh8zbqlGdY7aLHBjvI/LxA2IyY=;
	b=2DY21Mz5Eel3Cg/1QFwmgoh87lJhNIGgXYcj93J6fyLk2MSEp7IGS8h6kJ8Jb7r/XUUm
	 v8Si/tMMSqv95cpe3Bg41zxj+An076tgoxO/QYKHVjVxSTYb5UNZecNGpKLHlMxGSa+vI
	 2FB9RjYOqIsHLPyPZSp/h3e6VNKKypoKfaKFJVQ+05cJZVE7BwMWM2XZ2Z7lzb/maXofV
	 ZsVYSmo9fNazvMXjJppORJ9EG22ls8D0+eMSclZ0PoEtfD5lWI5bEEeFABUvz/It7uCgR
	 mO2cFBcO+Ju/nKnSTETJ1LzJiOnZbr4xjeK7qHwg+nJyKBa3O79mp6Wdpv3LfUY2KmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoDYaxgh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABC34606A323
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 03:08:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DoDYaxgh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 915041F00A05;
	Thu, 12 Nov 2026 03:08:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794452911;
	bh=GyyT0WVWHd4LNlKM1nh8zbqlGdY7aLHBjvI/LxA2IyY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DoDYaxghL1qlZFXPxiZD/zm9KsRx0NmigF9bHSyceYVo7CQFutkj1wZwT6VUPTAlu
	 g4vwY0+X+H//p+NTTzhTNljvB3ke8sUB3ePb34y8NZPScaq68w0OjUXQHSfF/mUzmB
	 3l+1lRN4zwbQNfWkMsVnjxO8sEyzHtus5HqOaGrJgXxmoFHeb37kEASVdIP0mGhy3x
	 Fnv3Mby4Tk2T18OhMfNlCSRKlPlt2BOSfHH06JHtOYFV3NCD6e4phKCX0R4XZYteHV
	 MeLpuBQwKkBGt0b0+T//JTqK5luCGPSx0uo4GbdezCwoBNY2JAzUf/i4LzOxqJGmM/
	 qF+wqaDEQj9Zg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Xin Long <lucien.xin@gmail.com>,
	David Ahern <dsahern@kernel.org>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] net: add a couple of helpers for iph tot_len
Date: Wed, 11 Nov 2026 22:08:27 -0500
Message-ID: <20261112030822.1482543-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261109202621-failed-5.10-1f1f8e8c5176@kernel.org>
References: <20261109202621-failed-5.10-1f1f8e8c5176@kernel.org>
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
Stable-dep-of: 1f1f8e8c5176 ("cipso: fix optlen corruption in cipso_v4_delopt()")
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
index 584b6171e3130..cba21c51ef3fc 100644
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

