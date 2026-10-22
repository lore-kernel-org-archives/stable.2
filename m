Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.216.50
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792636005;
	b=hBL4DbUxE+1eDm47aLEBV6mCakOUK4/k8avV37BxKx/YUzB+AgRs84/mSKLsZWzYuk4+
	 9tBOoQ6Q2f2tJ0ELeb7iyfcHlDskf6sRELQai9x0l+qfJXDgPf5cebr18TxKMaTyGD9j/
	 iethEc5xHP6FX+Ko7UZhOFPiFqN2g5Ui1ZsqbD2S6rf0OR8kVF5ZciufKN6v/OZyFGqG+
	 7fViIAlQYrAoePHqtECxe0/kl4HgWBbU4y2XHvyo8Sl3FLqU3zIRBsWF4nOkicCmGigas
	 2/ezPPcAJqvTCtANSba79HCetFBPcmb5AQfz6W2cd12dzzCRWCPB8LOGsVqQff5Bd2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792636005;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=NmZHEWlQZjYjTV2Jiiaxgc5qSyoqK4bbRrly0szFWi8=;
	b=RdXTo0jecnQ6EL6GN6j4s6gcWO0UQ27WWO1+Q2PfqkVMXCoGgVNIWHKKA6AQ+f3vlM8c
	 MWUiJtRmjbLAt8ibdss+nKmQJMImWFRj1iaMSoW9HRpTgTYTBXI+p9U2/SKApLxliQGWi
	 XerykDv//CTAv7v4yIxJpSZVnb3obSLei9Ynbe3waNYCreAq//QzbR/vf49r+eezEDCbw
	 JGwKxYti+76SkqPya29be2V8D51S67DaDHCRxrrPkS6y1ukg8XjgtYCoWDQqDxOsluTtS
	 Gq9oalqPzNjvKCmoLcQpsue/Z1eWCOVz7uiDZ5z1SqOmFDuI6DvI8+wQmfjAvfX26bQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rrxUfOgd;
	arc=none smtp.remote-ip=209.85.216.50
Received: from mail-pj1-f50.google.com (mail-pj1-f50.google.com [209.85.216.50])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF29606A31B
	for <stable@vger.kernel.org>; Thu, 22 Oct 2026 02:26:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6CF29606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=rrxUfOgd
Received: by mail-pj1-f50.google.com with SMTP id 98e67ed59e1d1-3ac677668a9so1407302a91.2
        for <stable@vger.kernel.org>; Wed, 21 Oct 2026 19:26:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792636005; x=1793240805; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=NmZHEWlQZjYjTV2Jiiaxgc5qSyoqK4bbRrly0szFWi8=;
        b=rrxUfOgdd/PL37RrqPELxylj88nYDj3VAUPLHKoPPzQ+MP6R6NzMt5vUV57umIhrGG
         muOt+sfD5Q7rGOxABrbR20O+sTVM5evE66YwnaQj+OUgIk97qADyNcOqo/SupoGLpZpr
         7dozEl2Jk9Sg9PDEwlFHrNou65zuYCXxM2xbqDL0GzUJqVQQcWpt71Vx0W432RcfOk4y
         2omlcbXEB2rM2fhjnNkehPRfxS97qHphcdQVHPYnIhXmVIKsogX5WL1UaZZXM1OwVd1S
         tbLPRnJD7StmnZTTOqLMlUQGvuhOIUP0s0ftOJc5MEgQX01vpw3XJlVt9zOCwHyQa/4m
         g89A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792636005; x=1793240805;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NmZHEWlQZjYjTV2Jiiaxgc5qSyoqK4bbRrly0szFWi8=;
        b=xriNw1cXZ91JdAEQmoROVp1PFPWmnjkMPu+I2EGdUgUDhsSyaeDbL9QuzyR2CL+TDc
         iyt4kQpNOLfRyXkYL1zB4YqzeRvvGCHkQMgHr1aB38whM+EDLFpiDuTxbNTda+muILCM
         nv7CeEa9czmlwWRe2m92PXsgVt13pp8p6RXZZrH5i3+xupsBHkZpbFcoZxXQr6MJqqOE
         6JIat1baUYTfgO5eb19aw6OoL4XTXz07dZR1XxicmUSZk6tthEUDb8Ygrol+gFGkdCFm
         fWgZQ0RQTJRKOdVnRibrrnI1DTZkreBjSTR2Jd0ydqgYfz3dZ9ohUOC7sSrJDGIuGmIO
         KEKA==
X-Forwarded-Encrypted: i=1; AKwUvByMC8feOHhvSaDS618lYzMJC7m7nlIzeB1M8qOj394kg195djuTi00s3G+qdG9jETcF63ZCs+w=@vger.kernel.org
X-Gm-Message-State: AFq9FYKsafLLrwPOzsIkss0CIC9Rc+vHdIIkIfZB7AjO/v10cKATSDv1
	4Ns8xfj0BXdmDQvjDnBvFJBgRoHSsKxWRJDrOKGunubBJ8ZJ0/J8+WHj
X-Gm-Gg: AYBFou3JgmBlWJCYmvKk/JBtM2dMhOpptQQ25wzTOOZvvB4ckTzHHu305Rcz7WsRiq8
	UW8luruLDA/yYU+Zkj9oPbg5X3cdUITptH7l3sZLKy4w3h42TTsA9NqTYhlrR/eJEMhIP/AaY5v
	nEqEpwc7pQShcDs821247E/pPL2IxXut26swx5W8NCG1VK0evLurMESqcxwWSlJgxL7q9lRdbgW
	FBIc0kDj3CLmmRhzRf+dKvwSVTTL9623JyuVs3z8zT8XS06YMD13vnkcgUEPBvcriAEV6FIzI8U
	OgovBDeZbWGFCKK2JutDwoR9NkeAUDRoHk+acM4tvI6Ci3+LIFwlxpJ21pMT1vicwicxeRgpiqW
	QMujJbuFpqRQyNEz5I+bFXB28uwMmLx0BpqQhAsXREhwBbv0qeOC7RMm+ANOuJD00igLaLx0nnq
	t7+UCiGzkhLygrVuzBoNCgx5BigxRk8xu5ETYxCK8UtNJwZBG2ccDtQcSEJHSNC4ru5cdztT/RW
	shibF/FU6SRru4FHCf9PIuGsK2H0n8FYzfk0aonUVt5hYcj0ouKLO1jpbc6pODYxDI=
X-Received: by 2002:a17:90b:1642:b0:3ac:c90a:10d2 with SMTP id 98e67ed59e1d1-3ad86c9041bmr3439757a91.30.1792636004587;
        Wed, 21 Oct 2026 19:26:44 -0700 (PDT)
Received: from TENCENT64.site ([103.7.29.106])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3ada4896c58sm1844518a91.8.2026.10.21.19.26.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Oct 2026 19:26:44 -0700 (PDT)
From: Fourie Zhang <littleddfu@gmail.com>
To: Steffen Klassert <steffen.klassert@secunet.com>,
	Herbert Xu <herbert@gondor.apana.org.au>
Cc: "David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@kernel.org>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	Zhiling Zou <zhilinz@nebusec.ai>,
	TencentOS Corvus AI <corvus@tencent.com>,
	netdev@vger.kernel.org,
	Fourie Zhang <fouriezhang@tencent.com>,
	stable@vger.kernel.org
Subject: [PATCH ipsec v2] xfrm4: use a full socket for local errors
Date: Thu, 22 Oct 2026 10:26:22 +0800
Message-ID: <20261022022627.4132880-1-littleddfu@gmail.com>
X-Mailer: git-send-email 2.43.7
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

From: Fourie Zhang <fouriezhang@tencent.com>

xfrm4_local_error() passes skb->sk to inet_sk() and ip_local_error()
without ensuring it points to a full socket. TCP SYN-ACK skbs can be owned
by TCP_NEW_SYN_RECV request sockets.

xfrm4_tunnel_check_size() already checks sk_fullsock() since commit
1620c88887b1 ("xfrm: Fix the usage of skb->sk"), so iptfs_is_too_big() is
the only remaining IPv4 caller passing a request socket here: the sk it
tests is the listener, while skb->sk is the request socket.

When IP-TFS rejects such an skb because it exceeds its payload MTU, the
local error path treats the request socket as a struct inet_sock. KASAN
reports a slab-out-of-bounds read in ip_local_error() beyond the
request_sock_TCP allocation.

Resolve the skb owner with skb_to_full_sk() before accessing inet_sock
state or reporting the error. This maps a request socket to its listener
and rejects sockets that cannot be used as full sockets, matching what
commit 6973a21ee73c ("ipv6: xfrm: use full sockets in local error paths")
did for xfrm6_local_error().

Fixes: 0e4fbf013fa5 ("xfrm: iptfs: add user packet (tunnel ingress) handling")
Cc: stable@vger.kernel.org
Reported-by: TencentOS Corvus AI <corvus@tencent.com>
Link: https://lore.kernel.org/netdev/20260908224856.1591189-1-kuba@kernel.org/
Reviewed-by: Eric Dumazet <edumazet@kernel.org>
Assisted-by: tencentos-corvus-ai:hy4-preview
Signed-off-by: Fourie Zhang <fouriezhang@tencent.com>
---
v2 (Eric Dumazet):
- Fixes: use the IP-TFS commit
- Note why IP-TFS is the only remaining IPv4 caller
- Reverse xmas tree; add Reviewed-by

v1: https://lore.kernel.org/netdev/20261021101839.3797779-1-fouriezhang@tencent.com/

A KASAN reproducer for this issue is available if requested.

 net/ipv4/xfrm4_output.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/net/ipv4/xfrm4_output.c b/net/ipv4/xfrm4_output.c
index 0ae67d537499..fffa3c4f456e 100644
--- a/net/ipv4/xfrm4_output.c
+++ b/net/ipv4/xfrm4_output.c
@@ -38,9 +38,12 @@ int xfrm4_output(struct net *net, struct sock *sk, struct sk_buff *skb)
 
 void xfrm4_local_error(struct sk_buff *skb, u32 mtu)
 {
+	struct sock *sk = skb_to_full_sk(skb);
 	struct iphdr *hdr;
 
+	if (!sk)
+		return;
+
 	hdr = skb->encapsulation ? inner_ip_hdr(skb) : ip_hdr(skb);
-	ip_local_error(skb->sk, EMSGSIZE, hdr->daddr,
-		       inet_sk(skb->sk)->inet_dport, mtu);
+	ip_local_error(sk, EMSGSIZE, hdr->daddr, inet_sk(sk)->inet_dport, mtu);
 }
-- 
2.43.7

