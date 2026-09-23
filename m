Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF97235B12B
	for <stable@vger.kernel.org>; Wed, 23 Sep 2026 03:25:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790133929; cv=none; b=Te5Sny98rzlGTbGPfYj/fppu2hr0c5SXK8DBk3U0UX0pY7eDw6IXoPx9GGPbM4ZJK75rL1fv7Thhq3KjiJPjCYx/DtLIOTAd60Kgu6auXN0yr2lHg71lAs/67rXRAgJ6abdvG0FMQjX6IINBhzkXtJ+u1jGJZL/3xbQ5gYOSTz0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790133929; c=relaxed/simple;
	bh=Zt8mLoDNZWawgRiHx8R/i9/D8eeGe9UUEreQiE7BP2Y=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XhEjH1uvSbSmq9Q8Ezk9OWt9tWG9h3U3/urxIk6tzbqgFPbOw9MwlajHUwIdVWtD5a9hw2YjrEYv0gln0wNt4DB7g+S99EF84a5j9MKMXn70U+ctCY0ekmXUMXXD3mwUgb6NeTmyAhRFCDlW+5rg8D6qWmr0pSe9lnJ/8Ne4Zc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Oq3kkF5/; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Oq3kkF5/"
Received: by mail-pj2-f13.google.com with SMTP id 98e67ed59e1d1-39dec5de01eso93922a91.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 20:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790133928; x=1790738728; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=dCfOYO2NRyZaR3nhyn2Vwjg5Pm9GGu3IlToVcEbkF0E=;
        b=Oq3kkF5/uwk6wiyADKE59Kvk8FU30j/j66HV5eZpUxgaPMAnFJQkWl/znxhqymFQdy
         7pT0d7Ad4+hhpE9jXSNcmfDiUHdOFTkVDEnjAIuTk+mNiMDv1BJoL3fmLxmOwkTEX31B
         yBtTpQ61bM73YxRg4Md/StkhNQg0WpkNRsu/BNJhsfcSz7l54MMmY04Y7V2M4j24d/tQ
         2riXqebu6ePUIuh9SQbYk7LRmm4TPMKeSU9pu8vxdiUxqM0hnm3z8BUSpcQV6zzqiFBa
         1z0WlzmQyYsYGNzQ0JtYsIRDlhunNHOdwaZ61wOmFCjSqIXeAu8zg288c+32J6YxQIuc
         MP9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790133928; x=1790738728;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=dCfOYO2NRyZaR3nhyn2Vwjg5Pm9GGu3IlToVcEbkF0E=;
        b=xJl/wZzfL6X33Buft2qGZZzOjUVecLQ1ZtpstVBR2yfUygiS0KqVe3SpzoBEhHjJPn
         wqD0kXPllPR4JCeT+UpDDxgt8pOPvYcVJx8DzkFmhdAFnMTXNnrszq4h0pT9EM5OpKy3
         svNTdS0fNuZk2z3vyGc6sHDffxYQLAcQj77ABYnr0KZlE2BxrYt5qJUICaF+gcYnOHAB
         50ms4CMW52VvBfzBbiyg8Jdkje9I3l72gbsOL8ISwFKkoNb7VAzPBqLj6XHxRLI8H7l8
         Zv6S//8Lp0gmQ7TayD/iQpm6FJ5z85hgeUOMpjz6SFlp5xPpgFAZXrIEO3WNLkC5db8V
         gpaw==
X-Forwarded-Encrypted: i=1; AKwUvByWYZ62Oz/ilyobc/UcaNV6dE3zrgZAjeQ6XCjXizoaB/ylp3qTMM4qVEQhTgdic5PnmbD91pc=@vger.kernel.org
X-Gm-Message-State: AFuF++mHhtkcR8Ysy4cCEm3kJXNuNWO9WrZyAa6sfqPkgmJjL1Utg8XV
	rSwfT1VWo8NkMTrLnQXUzxAh/+8HnkShoFaBKn/0ucGiQ706JQuPfDo3
X-Gm-Gg: AYBFou3mdLD9kv28910C5yyAbNrN9/TdOTnPrqDpsEmEvTlGASuxG1sSHnmpCSokzxo
	bepv7z55NikW5w8yMZNUnZ1QxwCRr+SHqq97Co6S+rZe60/t1yH2nl7gRUdV+Rtq12AUN27fDBp
	hATG5aXEBK22WQep0fGwmFV0oESKFhMh4opPygviZMSwezJ2H4UGIgUQuB25d+PBqY9bwa6lsnH
	ArplPl8v2SNXWqIw9t6KA4A1M8dGLx/m8I86qAu/rhI8ZHQ0qkJ1Nzl+4T7/bbYBnvY5wOiArg7
	PlZT95e6K69BKZNIcmsNhA7WSFvf+7pxN4MpkzWHy4mkbowaVT2M1419tQYA/Uhz0bXBb/M4dF1
	BnqyRodZLbShzijOCHaHrf+uewJHcs2+A5pEmlZ3N2qZ2z68js8STXx5X2c2RL2Vc1rd8MU+YT4
	YW+bJTmVEfYPzYSwaumECxyqmJE37+5l5So2WSsETZs8KyRIkaEoZCN1g1DP40jAVGNGjLJ60xe
	O1RKoo3+YReZIFzgopA4vKw1fmS2hWAakbHmsk/+Qyf2S+RnKIgPIf3D92nxHpiXxmjHl6k
X-Received: by 2002:a17:90b:4fca:b0:398:bad2:c10 with SMTP id 98e67ed59e1d1-3a07e773d26mr1868461a91.6.1790133927959;
        Tue, 22 Sep 2026 20:25:27 -0700 (PDT)
Received: from localhost.localdomain ([139.159.170.91])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3a07dc32086sm2261602a91.13.2026.09.22.20.25.22
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 22 Sep 2026 20:25:27 -0700 (PDT)
From: Qihang <q.h.hack.winter@gmail.com>
To: netdev@vger.kernel.org
Cc: steffen.klassert@secunet.com,
	herbert@gondor.apana.org.au,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	stable@vger.kernel.org
Subject: [PATCH net v3] xfrm: interface: validate the IP header on xmit
Date: Wed, 23 Sep 2026 11:24:56 +0800
Message-ID: <20260923032456.45814-1-q.h.hack.winter@gmail.com>
X-Mailer: git-send-email 2.54.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Packets injected into an xfrm interface (e.g. AF_PACKET on an xfrmi
device) reach the xfrm output path without IP header validation, but
xfrm4_transport_output() uses iph->ihl for __skb_pull() and memmove()
and expects the header to be valid.

vti_tunnel_xmit() already calls pskb_inet_may_pull() before handing
packets to the xfrm output path.  Do the same in xfrmi_xmit() and also
reject malformed IPv4 header lengths.

Fixes: f203b76d7809 ("xfrm: Add virtual xfrm interfaces")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Qihang <q.h.hack.winter@gmail.com>
---
Changes since v2: validate at the xfrmi_xmit() entry point instead of
inside xfrm4_transport_output().

 net/xfrm/xfrm_interface_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/net/xfrm/xfrm_interface_core.c b/net/xfrm/xfrm_interface_core.c
index 688306b..5cc906a 100644
--- a/net/xfrm/xfrm_interface_core.c
+++ b/net/xfrm/xfrm_interface_core.c
@@ -531,6 +531,9 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 
 	memset(&fl, 0, sizeof(fl));
 
+	if (!pskb_inet_may_pull(skb))
+		goto tx_err;
+
 	switch (skb->protocol) {
 	case htons(ETH_P_IPV6):
 		memset(IP6CB(skb), 0, sizeof(*IP6CB(skb)));
@@ -548,6 +551,9 @@ static netdev_tx_t xfrmi_xmit(struct sk_buff *skb, struct net_device *dev)
 		}
 		break;
 	case htons(ETH_P_IP):
+		if (ip_hdr(skb)->ihl < 5 ||
+		    !pskb_network_may_pull(skb, ip_hdr(skb)->ihl * 4))
+			goto tx_err;
 		memset(IPCB(skb), 0, sizeof(*IPCB(skb)));
 		xfrm_decode_session(dev_net(dev), skb, &fl, AF_INET);
 		if (!dst) {
-- 
2.46.0
