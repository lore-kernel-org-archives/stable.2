Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794345549;
	b=KbJWx2oidMTVAUrFcY1ZLusauJRjQ/8RMAXRBug3TvAeP8wy0utU/CnCbTIC3+DqBwrL
	 zLljTOVQZKsxPz59BgbIuV/eQZnTBJR5JxaZwD3Rmj9hD3cVIVbG2qWpJMBgtMn+b++FE
	 i2qA3RCGTySeVXA/G9ESWH706+PzynEOv0NQd+Ol+sGGQpl/B0aS0/gCfRvgV0cgjZg47
	 UJmgnaYEoLUn/1Uhq/VijeV6bzrBdrLmljSthBEo9ZaOHzJfUBvnFMD0L3cqvMVc8Z5ie
	 3AedOHTKiUYAIeg2XepC/Rc6vTRSORwp2rIdYJEQLQcMOh9QGrcsECCoZZ0XgPlaRvA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794345549;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=xOy2UsXSseqUI/sahTtL9ojnmP9HiehqxJuf4TKMSbo=;
	b=njg24qwgK9PXguvJzub9aoRXf92IDcRsUtvkragjexLwp/42iGhn7RAPz2mLodVW4GZF
	 QnN8EXSmSP4/nWGkegZxDk+R0+7G7hEHeEjJHIYcJd7TrzOooA9sFe1IDjZzLdLZ+igcK
	 6D13uPdk3CQjbCVSB1JeRubmp0QZeHShmY+vS5oI6qakWhxNaAQYB8LS1PJr+hpfDAOVU
	 Tmu0mNQwLxU+sFwJybd46Ob5pRaYQTHX5fJYbUfyRgQ2N78dgo1OSEUn0qsvp+ZZcQuWn
	 dVfgpN34doIuIM48DtO9M8FS2wDe/4LTgzYxTfA+DGVzoAm2+UawamFbq8PPNy1ur9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QmKYMekm;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6731606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 21:19:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QmKYMekm
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EED121F008A1;
	Tue, 10 Nov 2026 21:19:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794345548;
	bh=xOy2UsXSseqUI/sahTtL9ojnmP9HiehqxJuf4TKMSbo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QmKYMekmZiwpJTsxyzQz1DbSC/4F6LVxz3dU07oIM8N/RSxU8LhKTIhQSbRB0b4fg
	 235jXTP63XhzlGXXvWMx7MX2cphcXOgsPeqlR0HqwTzHpogYb5ZKRTR2Kyq4hkfO5G
	 zBAWv894wx22WIXEFWOC3LX5qnHL+PGfMVmFQbUjWmORPrup+kjrhvLWF3FY7LkdMu
	 irHDSNHiDIK2XMERiHKyoWP0UkCC+7BKbnJbfPdMir1I+Zd03seUgOHrraMZiToK0L
	 +Hs+eKpN+xcwO5v7pp69z20WopBxgJycL1Vdr/yD/vvU4xIZOwwh3hP84ItNtRCxiJ
	 ymat48Xug71ng==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Kyle Zeng <kylebot@openai.com>,
	David Lee <david.lee@trailofbits.com>,
	Pablo Neira Ayuso <pablo@netfilter.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/2] netfilter: nf_reject: initialize IPCB at inet ingress
Date: Tue, 10 Nov 2026 16:19:06 -0500
Message-ID: <20261110211836.3899141-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110211836.3899141-1-sashal@kernel.org>
References: <20261107060821-failed-5.15-73a73d442f99@kernel.org>
 <20261110211836.3899141-1-sashal@kernel.org>
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
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/ipv4/netfilter/nf_reject_ipv4.c | 5 +++++
 net/ipv6/netfilter/nf_reject_ipv6.c | 5 +++++
 2 files changed, 10 insertions(+)

diff --git a/net/ipv4/netfilter/nf_reject_ipv4.c b/net/ipv4/netfilter/nf_reject_ipv4.c
index 89f52751355bf..ba5b6cb42e70b 100644
--- a/net/ipv4/netfilter/nf_reject_ipv4.c
+++ b/net/ipv4/netfilter/nf_reject_ipv4.c
@@ -349,6 +349,11 @@ void nf_send_unreach(struct sk_buff *skb_in, int code, int hook)
 	if (!skb_valid_dst(skb_in) && nf_reject_fill_skb_dst(skb_in) < 0)
 		return;
 
+	if (hook == NF_INET_INGRESS) {
+		memset(IPCB(skb_in), 0, sizeof(*IPCB(skb_in)));
+		IPCB(skb_in)->iif = skb_in->skb_iif;
+	}
+
 	if (skb_csum_unnecessary(skb_in) ||
 	    !nf_reject_verify_csum(skb_in, dataoff, proto)) {
 		icmp_send(skb_in, ICMP_DEST_UNREACH, code, 0);
diff --git a/net/ipv6/netfilter/nf_reject_ipv6.c b/net/ipv6/netfilter/nf_reject_ipv6.c
index c5c8962088f2c..3372658e6d125 100644
--- a/net/ipv6/netfilter/nf_reject_ipv6.c
+++ b/net/ipv6/netfilter/nf_reject_ipv6.c
@@ -428,6 +428,11 @@ void nf_send_unreach6(struct net *net, struct sk_buff *skb_in,
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

