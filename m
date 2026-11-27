Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795789558;
	b=dHTp2HqhxZL1K6+tANF2FIHPG6liRHf92ryiGbFSNU1RKNir0IalcmyQyEIKW57XrUmd
	 WfTTMz9RbS5NtzbiqMSoQzosqA5o+5kaYwvv8KRUQ58d8t/UFvSTVNAqFkHNF8LjqbzZi
	 ucywg3bv7uDE1Mq3WskCTeTLJDbWPxIlj2d6LEr37D5cEstWuEx2kCmJOXYyMUAbRniKM
	 KHXqJRmwkI/qWHyx6Sj8xKvEAkZdbJaor57k0BN8861lmpYeHk7T0IDidg3qkmdiHBltO
	 esyKIAY5faQc8hjvn4zEnsq87fMcDtRwfc4ntGYJOhrtYMiHVOgaP8b2SgAqD//2IPQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795789558;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=CUYUcZ8zVrccdQp8eylc+qilfxVX7jnZyDSPYCH5vsQ=;
	b=4VqVdjzsyYTefFW75AMsyvUFF/yUM1C8mugvKuzmmapzAQXvLjLaF9G7zvN7ZQZyonIi
	 WemRzGrJAMD1fIJuElDu8nUiN5+fd5W8tOHyEiKDjdnt47DAFy10fbGpbOTL1bRKpMRqc
	 pdmQdupmNF/iDIeQGEby33I9f0NqLDCSmegvP6BZ4bd7gGdxdYGAOjg6gDLhVy5Urd8Lr
	 6kbGHf6lC41Wqdo/eMxFJ9vVc/YrR9v0VzntcwKYj2rQQ7yqrNaEln8klR5DVbuBIfk9G
	 M4CdU6PUC8v6dyyQrf63s40Xun7ZAer54v1Zpm1xMiwL3xvTc1Bv5WbGDGS7QpzZBPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=cloudlinux.com;
	spf=pass smtp.mailfrom=cloudlinux.com;
	dkim=pass header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=PNoPGUYd;
	arc=none smtp.remote-ip=209.85.216.41
Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C51A606C73A
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 14:25:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8C51A606C73A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cloudlinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=cloudlinux.com header.i=@cloudlinux.com header.a=rsa-sha256 header.s=google header.b=PNoPGUYd
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-3b51a9606e8so1137539a91.3
        for <stable@vger.kernel.org>; Fri, 27 Nov 2026 06:25:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cloudlinux.com; s=google; t=1795789557; x=1796394357; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=CUYUcZ8zVrccdQp8eylc+qilfxVX7jnZyDSPYCH5vsQ=;
        b=PNoPGUYd72bdVRNz6j5xAK9fj1N/kgvqWgnVi+dggqk/FcbIEE3jmb3pEonFHHWsQI
         7TjQT8NVt2gY+sd52p5CjR07Wt8Mw7WRm5WiIUoT3i9eLTw5wYHp8ZxvOxbDJkBwi/8d
         cF/urv3guhCw71osZosrgSwWuTHFwLD8s9sqb404M+SqyeGfnPfShOlb1XHsskrjbCAZ
         xTE94+issUodeM8Ea44WxzBe8LFNVXPIqZxL6zyUP4BoIYW2Mom7a3rdjVDtjpcCo4Eu
         OWovmwPB/T1z3kVlKyWj0BGfl9hYXgekn3omCY8LR3ZM7tJ1dRq/OO2v4mtrXma8jfel
         Rh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1795789557; x=1796394357;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=CUYUcZ8zVrccdQp8eylc+qilfxVX7jnZyDSPYCH5vsQ=;
        b=IMeD+ZE4sINoMXtwX/tH2Po02f19rmNujLY/JpubDftrKQXdtyp6Y8KfhYq0LNxD3C
         667VuYnSnNqQXYmir6qOrio3LApM72FeCO+U7Ttq+LxDrVIRzmFWTeBIboIgDDLCLPww
         c5Sr6tcro1iXP18LzihE1nHbJMRjbQiaWnW8fT1onHlGKPbnO3ypUyYWwyDNh02brzbF
         ggnNdYKg+lXjE7uDLq3cLphHXTsOKG1n8iNRy58YqWLDsli480lziCW77Xff0u9grDdA
         cFLjJa+JBjWfuW/nt42xcXEQL0cesjg99hXpww0UqTP83m3GSDTJsixGUkhD28JMUyhN
         qlOQ==
X-Forwarded-Encrypted: i=1; AL+hErENMVrmJsC3hCu4dR8414Yw8ETMiORhUgjryQIdAysdTZTSShN8DCZnOzosAziDehEg2RLTMC4=@vger.kernel.org
X-Gm-Message-State: APuU4Z/Z9kM68K76X+LApjfVjQ15FtuQBEA9/B2bVDvIPbbyGjY8cgGV
	9FAz/NZGrh6t/WCINiW3q05iNZD5W4f3k971zBFir9FbcGT1xwFBJk5vxqfO0ohi15k=
X-Gm-Gg: AZFdTZfnFc3n0woJ/SbXifKC4qWTzY6RvzO8od5tP2lbetWLXVy3S4mQbzAze0hIHPI
	8lHFcQPRAOxBTQKLYOXRVYWuMiTLe2T7VAIaL38Gd+t6uBxS+Xh++84peWxFq52g+CKNBqhsqeV
	FULLmL88uh5p+kyL/KnCLZ0Zi8KUR16vKAepjNarHEjLDoorEBMBAwEABB4QBeoZoTDeBFfTfFM
	j+Vjly4qc8hEfOVYOK5Zfy2a0odmG9UZymCuqVfM1Cnl/LSQEx5wzcrSCjADhOx/ayFWk3n1XVT
	wGmY7p5BH8bmbl+HJAE+FyAg0K+g0rS7ptSygZXMbng034AWtTZBRhtAyV3IMyog4fhLWyYe11U
	tPRgOtgZUtyVtMQm9ewTKoNbTr3ITNY6t4cQ8HhvkvwRJpIBOfYNVhpEyWTRzBhnE8J/cflkvG7
	wYZ4me/oTwbvL8NEEQuHYw04siEuCXkTe/ZC9y2xA6d19Tg30NQdXM4oCdLR7wIIthRMUNLjyFA
	4dLuzFO5ylsqXGOyai/deOJklHeb60LV+dKlXUYRaRwcqOEpcObGMA9b4+UofYpyehN5cCxlqnG
	YmJfZUa7FDnGvwp/vbH/gh0ulivfUqigB9C6j35jEe0JGPgPYL70CulFdg==
X-Received: by 2002:a17:90b:4b86:b0:3b5:35eb:5e94 with SMTP id 98e67ed59e1d1-3b535eb5ff2mr2981408a91.41.1795789556690;
        Fri, 27 Nov 2026 06:25:56 -0800 (PST)
Received: from rmustafin-laptop ([27.79.41.63])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3b4dfbe54a2sm18324629a91.17.2026.11.27.06.25.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 27 Nov 2026 06:25:56 -0800 (PST)
From: Rustam Mustafin <rmustafin@cloudlinux.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>
Cc: Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Willem de Bruijn <willemb@google.com>,
	Simon Horman <horms@kernel.org>,
	Christian Hopps <chopps@labn.net>,
	netdev@vger.kernel.org,
	ipsec@lists.linux.dev,
	linux-kernel@vger.kernel.org,
	Rustam Mustafin <rmustafin@cloudlinux.com>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH ipsec] xfrm: iptfs: report the too big error to the frame's own socket
Date: Fri, 27 Nov 2026 21:25:50 +0700
Message-ID: <20261127142550.66326-1-rmustafin@cloudlinux.com>
X-Mailer: git-send-email 2.52.0
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

iptfs_is_too_big() calls xfrm_local_error() when its sk argument is set,
but xfrm_local_error() reports to skb->sk and dereferences it. vxlan
passes its tunnel socket as sk for a forwarded frame that has no
skb->sk, so an oversized forwarded frame on an IP-TFS SA with dont-frag
oopses:

  KASAN: null-ptr-deref in range [0x0000000000000010-0x0000000000000017]
  RIP: 0010:xfrm_local_error+0x92/0x190
  Call Trace:
   iptfs_output_collect+0x2c2/0x1170
   udp_tunnel6_xmit_skb+0x713/0xd90
   vxlan_xmit_one+0x1ebc/0x3490
   ip6_forward+0x1573/0x35c0

Check the frame's own full socket instead, as xfrm4_tunnel_check_size()
does, so a forwarded frame gets the ICMP error. Drop the now unused sk
argument.

Reproduced on a KASAN kernel with vxlan forwarding over an IP-TFS SA;
with the fix the oops is gone and an ICMPv6 Packet Too Big is sent. The
xfrm_state.sh, xfrm_policy.sh, xfrm_policy_add_speed.sh,
vrf-xfrm-tests.sh, pmtu.sh and ipsec selftests pass with and without the
fix.

Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handling")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/179551712630.3135.52212996809224784@kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Rustam Mustafin <rmustafin@cloudlinux.com>
---
Assisted by Claude Opus 5.5 (claude-opus-5-5).

A KASAN reproducer (single VM, vxlan forwarding over an IP-TFS SA) is
available on request.

 net/xfrm/xfrm_iptfs.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/net/xfrm/xfrm_iptfs.c b/net/xfrm/xfrm_iptfs.c
index 0313a43aa8a9..ccdde630a825 100644
--- a/net/xfrm/xfrm_iptfs.c
+++ b/net/xfrm/xfrm_iptfs.c
@@ -1813,7 +1813,7 @@ static int iptfs_get_cur_pmtu(struct xfrm_state *x, struct xfrm_iptfs_data *xtfs
 	return pmtu;
 }
 
-static int iptfs_is_too_big(struct sock *sk, struct sk_buff *skb, u32 pmtu)
+static int iptfs_is_too_big(struct sk_buff *skb, u32 pmtu)
 {
 	if (skb->len <= pmtu)
 		return 0;
@@ -1824,7 +1824,7 @@ static int iptfs_is_too_big(struct sock *sk, struct sk_buff *skb, u32 pmtu)
 	if (skb->dev)
 		XFRM_INC_STATS(dev_net(skb->dev), LINUX_MIB_XFRMOUTERROR);
 
-	if (sk)
+	if (skb_to_full_sk(skb))
 		xfrm_local_error(skb, pmtu);
 	else if (ip_hdr(skb)->version == 4)
 		icmp_send(skb, ICMP_DEST_UNREACH, ICMP_FRAG_NEEDED, htonl(pmtu));
@@ -1908,7 +1908,7 @@ static int iptfs_output_collect(struct net *net, struct sock *sk, struct sk_buff
 		/* If the user indicated no iptfs fragmenting check before
 		 * enqueue.
 		 */
-		if (xtfs->cfg.dont_frag && iptfs_is_too_big(sk, skb, pmtu)) {
+		if (xtfs->cfg.dont_frag && iptfs_is_too_big(skb, pmtu)) {
 			trace_iptfs_too_big(skb, xtfs, pmtu, was_gso);
 			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
 			continue;
-- 
2.52.0

