Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345548;
	b=hV/uRpyXsRkEZn4i2xnohCsLc3sWM6uk44AbYk9zmVlzk1EQyK3wzx6I4Q2y0BmyfDqA
	 dyhGTzxDsMeTjbjCsk2f29TaprVGOoemVyaslLvjTTnWNSxVKUexO9Gdmt5fAKtW16E9H
	 +hwjNRUNENT7Iy9LR3aOAbLg77ngFB0flDT9ZcfEq8YwoidSloJrSH+dpQ16Kk3MmpR74
	 HRkCbK0RIp3EKLgmUBqKSnrAGUdMByfGVqpKPC4wSlTGOfDj+b19ktMFQyRmBQ8kLzw7p
	 zViv+Cvx9zu94X3OH0TS7ozKIdMXIWjZQGm+G45+OM0aWVAp59qLKPag0q/a+cFZomg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345548;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=mJGblFU8oV84cfY4+DryzOGu3bCbb0WNgO1lTOXVWrU=;
	b=uE+is31Tdr+lL670Z9/SbVb2P0aAGL98gOSlGOUWiQdI7UwrRPwJIWCghCJJtRPi4xt6
	 +KHeP3tU78HU9kB5uwCXc0YgysR7AyE8F24y8unqXQD00I7GIrBDz995ARjnCDnnUWOjr
	 dJtB03Ktv9mxozpM2XujrNJIOZfELp8C5toI4al6yQAu8R0zgSEnWK8up8z7BwbLRh33g
	 yev/TyvJSUVjSdDs5Pcj2WyYrckMLyDc05dAjRqjGGQhwt2DRlFOgLSrvnH9wI4EJDMkD
	 wVqu3J6F3fAfqXIoYZtQwJgHqYodrY+JmDd7z/Kp8V2STPSDYaPvLQkZU22WHdB6Yow==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7sevrJf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 20EDC606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:19:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=h7sevrJf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35FF31F0089F;
	Tue, 10 Nov 2026 21:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794345547;
	bh=mJGblFU8oV84cfY4+DryzOGu3bCbb0WNgO1lTOXVWrU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=h7sevrJfz2zqZMurhXhif6StPeXRvzPdcy+vqVI3XUhjK5y/4XPfpfT2ImxfBxG/0
	 ZI0UOTdGOyGvc5kASuDv+L8w9cbApUvpWzqL/I2/vqeWQXnGiTeVl6WNZPnbMF6fD0
	 mq6nSl4VkBQwqft+/WrOH68kGN4ZqPmEYibOrEDwJGC8uALGn5opk16doE9cxLshEu
	 RAIs7GH9kuiU+w6NmQ3Gd+6WrTGyCUft42Wbia50aSbn/AiChKmLg1K1eFz1/Bbcvt
	 MvWloo0sEGyAPmt75OXKkEeARKVaxmKVqjDsBA6r79CmKXS6uJhm4MZ9LGDC7IHega
	 OL1RnfjPf5HIA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kevin Mitchell <kevmitch@arista.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] netfilter: conntrack: skip verification of zero UDP checksum
Date: Tue, 10 Nov 2026 16:19:05 -0500
Message-ID: <20261110211836.3899141-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107060821-failed-5.15-73a73d442f99@kernel.org>
References: <20261107060821-failed-5.15-73a73d442f99@kernel.org>
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

From: Kevin Mitchell <kevmitch@arista.com>

[ Upstream commit 4f9bd53084d18c2f9f1ec68fa56587b99a2cef00 ]

The checksum is optional for UDP packets. However nf_reject would
previously require a valid checksum to elicit a response such as
ICMP_DEST_UNREACH.

Add some logic to nf_reject_verify_csum to determine if a UDP packet has
a zero checksum and should therefore not be verified.

Signed-off-by: Kevin Mitchell <kevmitch@arista.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
Stable-dep-of: 73a73d442f99 ("netfilter: nf_reject: initialize IPCB at inet ingress")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/net/netfilter/nf_reject.h   | 21 +++++++++++++++++----
 net/ipv4/netfilter/nf_reject_ipv4.c | 10 +++++++---
 net/ipv6/netfilter/nf_reject_ipv6.c |  4 ++--
 3 files changed, 26 insertions(+), 9 deletions(-)

diff --git a/include/net/netfilter/nf_reject.h b/include/net/netfilter/nf_reject.h
index 9051c3a0c8e77..7c669792fb9ce 100644
--- a/include/net/netfilter/nf_reject.h
+++ b/include/net/netfilter/nf_reject.h
@@ -5,12 +5,28 @@
 #include <linux/types.h>
 #include <uapi/linux/in.h>
 
-static inline bool nf_reject_verify_csum(__u8 proto)
+static inline bool nf_reject_verify_csum(struct sk_buff *skb, int dataoff,
+					  __u8 proto)
 {
 	/* Skip protocols that don't use 16-bit one's complement checksum
 	 * of the entire payload.
 	 */
 	switch (proto) {
+		/* Protocols with optional checksums. */
+		case IPPROTO_UDP: {
+			const struct udphdr *udp_hdr;
+			struct udphdr _udp_hdr;
+
+			udp_hdr = skb_header_pointer(skb, dataoff,
+						     sizeof(_udp_hdr),
+						     &_udp_hdr);
+			if (!udp_hdr || udp_hdr->check)
+				return true;
+
+			return false;
+		}
+		case IPPROTO_GRE:
+
 		/* Protocols with other integrity checks. */
 		case IPPROTO_AH:
 		case IPPROTO_ESP:
@@ -19,9 +35,6 @@ static inline bool nf_reject_verify_csum(__u8 proto)
 		/* Protocols with partial checksums. */
 		case IPPROTO_UDPLITE:
 		case IPPROTO_DCCP:
-
-		/* Protocols with optional checksums. */
-		case IPPROTO_GRE:
 			return false;
 	}
 	return true;
diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index ddfb4e2b779d6..89f52751355bf 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -102,6 +102,7 @@ struct sk_buff *nf_reject_skb_v4_unreach(struct net *net,
 	struct iphdr *niph;
 	struct icmphdr *icmph;
 	unsigned int len;
+	int dataoff;
 	__wsum csum;
 	u8 proto;
 
@@ -125,10 +126,11 @@ struct sk_buff *nf_reject_skb_v4_unreach(struct net *net,
 	if (pskb_trim_rcsum(oldskb, ntohs(ip_hdr(oldskb)->tot_len)))
 		return NULL;
 
+	dataoff = ip_hdrlen(oldskb);
 	proto = ip_hdr(oldskb)->protocol;
 
 	if (!skb_csum_unnecessary(oldskb) &&
-	    nf_reject_verify_csum(proto) &&
+	    nf_reject_verify_csum(oldskb, dataoff, proto) &&
 	    nf_ip_checksum(oldskb, hook, ip_hdrlen(oldskb), proto))
 		return NULL;
 
@@ -338,6 +340,7 @@ EXPORT_SYMBOL_GPL(nf_send_reset);
 void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 {
 	struct iphdr *iph = ip_hdr(skb_in);
+	int dataoff = ip_hdrlen(skb_in);
 	u8 proto = iph->protocol;
 
 	if (iph->frag_off & htons(IP_OFFSET))
@@ -346,12 +349,13 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 	if (!skb_valid_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
 		return;
 
-	if (skb_csum_unnecessary(skb_in) || !nf_reject_verify_csum(proto)) {
+	if (skb_csum_unnecessary(skb_in) ||
+	    !nf_reject_verify_csum(skb_in, dataoff, proto)) {
 		icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0);
 		return;
 	}
 
-	if (nf_ip_checksum(skb_in, hook, ip_hdrlen(skb_in), proto) == 0)
+	if (nf_ip_checksum(skb_in, hook, dataoff, proto) == 0)
 		icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0);
 }
 EXPORT_SYMBOL_GPL(nf_send_unreach);
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 099740342f70f..c5c8962088f2c 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -32,7 +32,7 @@ static bool nf_reject_v6_csum_ok(struct sk_buff *skb, int hook)
 	if (thoff < 0 || thoff >= skb->len || (fo & htons(~0x7)) != 0)
 		return false;
 
-	if (!nf_reject_verify_csum(proto))
+	if (!nf_reject_verify_csum(skb, thoff, proto))
 		return true;
 
 	return nf_ip6_checksum(skb, hook, thoff, proto) == 0;
@@ -413,7 +413,7 @@ static bool reject6_csum_ok(struct sk_buff *skb, int hook)
 	if (thoff < 0 || thoff >= skb->len || (fo & htons(~0x7)) != 0)
 		return false;
 
-	if (!nf_reject_verify_csum(proto))
+	if (!nf_reject_verify_csum(skb, thoff, proto))
 		return true;
 
 	return nf_ip6_checksum(skb, hook, thoff, proto) == 0;
-- 
2.53.0

