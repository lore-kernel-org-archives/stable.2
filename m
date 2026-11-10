Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794349281;
	b=VCr7HdVzdPt2PJrRR8q4Pi0XzOtJYf4fPlMv0DzYS0nHrn7J0/NaBZk7kJHqpHbOxqSA
	 A+vJ2yTcninwiEHpN3uW5TaBhAP/LVQNdBBbkBhwXEecfQNmioyFHl9xpLgEaanKLdsuI
	 WPRVF1eC9pV9H69LRXgYUzgsGoqGmZkfsHqtA8m6O6IlcojsMuRxHAgARM3F/0YZo0316
	 fNd/t2YV1e5HCFzJHVhPUoLzalrPmg+nyQhWhvbJzUa7pLC7lJLK2FmTa8vXIMdEzQNW/
	 UmKtSl8ONEeiOex3f/F9c7hRAkJt42gDi+QrFtBle7KyBig60I0Iii0b6Qtk0/JaCGw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794349281;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=hc9IOh65fuGiA+jIKYNgnkoq/K5I20FuA1u15ABusGE=;
	b=HX5KQIeZRIB3mpvehoalAojbGOKwtdonrj1Upf1keJICOhR+WOoVA/9L0/wnC3tqB4C9
	 dAH1UoU6b1sH71ljkwYU3eCwY7Q4r2C6Ah60ye9lZmsRmYvibv3fOBGPDy31K0w2J2qki
	 0Htw4Ue+86H1Ij7NNAdvFtxvwscskueRCT/sdjyGmQxQOuLqPhGSvoR5oOu5F4ZRRu0L1
	 JEzjfItsHecg19tIUFpOpOiaO33HU8N5ohTp3jNfkPQOR3QmmVsH33ciA4064iV0rXlHs
	 JuI4VaO2s8xofpQ8PV6EpdToE+FmIUeNuxu4nuFaIkox8CzGEzU+fKtgR0AP3t9XxEQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="jwg/Rc7t";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC02606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 22:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jwg/Rc7t
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F6071F008A2;
	Tue, 10 Nov 2026 22:21:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794349280;
	bh=hc9IOh65fuGiA+jIKYNgnkoq/K5I20FuA1u15ABusGE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jwg/Rc7teE5AJo0eZHNZi2LGSnY9fxQMrSdoMzux+G7YAHgZu0PKt2pRzVqe+/VZY
	 uvNybd8Sq1Borrgqym1s5Nl3xzYZ30NyMQHGD1SK7ipfwmkfpcrASZZd33mTR4N0kL
	 0Ezxyd4IqBDlq87bfoPCSgdXKCvaqEfBFIn90fdkW35Dmv3+Injcct3pzN5RquHxlG
	 tpEXuDvY5P9JVeIvx1Marn61Udi9oaHH3E/MwaExrw3febUWopqa8V8SXyemeAH7R7
	 N5bOxbQy0jNEgln2Hx0aNUtNMqO07dHPvAyOJYoKRxTh1LdHcjUyzUxH4L91AgnUIL
	 eHH/B0kaxfIog==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	David Lee <david.lee@trailofbits.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] netfilter: nf_reject: initialize IPCB at inet ingress
Date: Tue, 10 Nov 2026 17:21:18 -0500
Message-ID: <20261110221952.3928581-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107062513-failed-5.10-73a73d442f99@kernel.org>
References: <20261107062513-failed-5.10-73a73d442f99@kernel.org>
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

From: Kyle Zeng <kylebot@openai.com>

[ Upstream commit 73a73d442f9986353fe284bd1b504d0313d0f153 ]

The inet ingress hook runs before ip_rcv_core() and ip6_rcv_core(), so
neither IPCB nor IP6CB has been initialized when nft_reject_inet passes
a packet to nf_send_unreach() or nf_send_unreach6(). skb->cb can
therefore retain metadata from an earlier protocol layer.

For IPv4, icmp_send() treats IPCB(skb)->opt as parsed IPv4 options.
Stale option offsets can make __ip_options_echo() copy an
attacker-controlled length into its 40-byte reply option buffer and
overflow the stack. On an unpatched v7.2-rc5 kernel, the IPv4
reproducer produced:

  BUG: KASAN: stack-out-of-bounds in __ip_options_echo()
  Write of size 255

For IPv6, icmpv6_send() consumes IP6CB(skb) as parsed IPv6 metadata. It
always uses iif for source selection and, when MIP6 is enabled, uses
dsthao as an extension-header offset. These fields must not be stale.

For NF_INET_INGRESS, clear the address-family-specific control block and
restore its input interface before constructing the ICMP error.  This
matches similar initialization normally performed by ip_rcv_core() and
ip6_rcv_core().

Fixes: 117ca1f8920c ("netfilter: nft_reject_inet: allow to use reject from inet ingress")
Cc: stable@vger.kernel.org
Assisted-by: Codex:gpt-5.6-sol Codex:gpt-5.5-cyber
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Co-developed-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: David Lee <david.lee@trailofbits.com>
Signed-off-by: Pablo Neira Ayuso <pablo@netfilter.org>
[ sashal: Adjusted IPv4 patch context to preserve the existing one-argument nf_reject_verify_csum(proto) call. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/netfilter/nf_reject_ipv4.c | 5 +++++
 net/ipv6/netfilter/nf_reject_ipv6.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 48dcb2f0794fd..db2c4bbc641db 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -198,6 +198,11 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 	if (!skb_valid_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
 		return;
 
+	if (hook == NF_INET_INGRESS) {
+		memset(IPCB(skb_in), 0, sizeof(*IPCB(skb_in)));
+		IPCB(skb_in)->iif = skb_in->skb_iif;
+	}
+
 	if (skb_csum_unnecessary(skb_in) || !nf_reject_verify_csum(proto)) {
 		icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0);
 		return;
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index 4d8cfb7ae6e3e..a538f878ba332 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -263,6 +263,11 @@ void nf_send_unreach6(struct net *net, struct sk_buff *skb_in,
 	if (hooknum == NF_INET_LOCAL_OUT && skb_in->dev == NULL)
 		skb_in->dev = net->loopback_dev;
 
+	if (hooknum == NF_INET_INGRESS) {
+		memset(IP6CB(skb_in), 0, sizeof(*IP6CB(skb_in)));
+		IP6CB(skb_in)->iif = skb_in->skb_iif;
+	}
+
 	if (!skb_valid_dst(skb_in) && nf_reject6_fill_skb_dst(skb_in) < 0)
 		return;
 
-- 
2.53.0

