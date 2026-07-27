Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC71536EA84
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 12:19:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785154797; cv=none; b=rDnLnMDSQXpwymmxQr1m26OyHlxtIPSJ7BBCOrng475mgc588tRBiLJkLi5M1B2cfhA/OoNtXZ9OLqNS+Z1ATsCz7t/kRxiEbb33lEZxxSxW1WhWLhNho9vHelTDdmLbSPrTa3j7fahbzdzUhLEZTRuBze5TbZWnONQziaRzN2c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785154797; c=relaxed/simple;
	bh=vbzOqnnSKZwkO+g0HNxTCbTEkZB2n5zym93sIGTjL5k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=p5f+0mJGcjTnPYZSmm51mpKjbEsRczbmqTGgnJAIo3Nlsyf4u2F85Fuj+Jo4k2/B1Sg9YRQR5DJ3DZjjTna32uBQSUv00T87+d31ES7bscdj2yivdQ31+ymLYsIXhy5X+VVeS7nR5LazDYdGwOJfd3G5EaHd8K+SmTq+8J8C1v0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=FA+8f3P1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="FA+8f3P1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C96BB1F00A3A;
	Mon, 27 Jul 2026 12:19:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785154795;
	bh=TROlkfe+HBOtiPc3Lnx2Zd4tRV+fl3Q3+NURD+QuXOc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=FA+8f3P1nt7zBVO0KjN3Fr1QEZcNQzo3EAK4ypb90wCFCAEEmcC3TmnPRkSKIGFcD
	 hnrPQg+iIs86FM5Im16YYxMo87SfVrxLC63Mt1SFlV4pelClEVRxgGFU5TQrBOEry5
	 QohNhefedPX/Tj4+Bl5cR8wQ4BjPpNQJcw6r0gF9SDYuFsbwRe4PwNfT46YMoUQVLx
	 hXvOXVRkS3456XZU+EvP1n4Pmxrtuz6GLRhL6sseMg1ynsLif62WDQG4+M9HR3Bu84
	 bk+j+2PpijWfqQhDvWHbM85XrjVT1DmkGWqR3oxvJLgYgz+W2oHw0rgp4MKjpeySRD
	 26FGJpKccMRkg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Qianyu Luo <qianyuluo3@gmail.com>,
	Yuan Tan <yuantan098@gmail.com>,
	Xin Liu <bird@lzu.edu.cn>,
	Ren Wei <n05ec@lzu.edu.cn>,
	Eyal Birger <eyal.birger@gmail.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/2] xfrm: nat_keepalive: avoid double free on send error
Date: Mon, 27 Jul 2026 08:19:52 -0400
Message-ID: <20260727121952.3778327-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260727121952.3778327-1-sashal@kernel.org>
References: <2026072015-entail-cartload-088d@gregkh>
 <20260727121952.3778327-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Qianyu Luo <qianyuluo3@gmail.com>

[ Upstream commit 226f4a490d1a938fc838d8f8c46a4eca864c0d78 ]

nat_keepalive_send() frees the keepalive skb whenever the IPv4 or IPv6
send helper reports an error.

That cleanup is only correct before the skb is handed to the output
path. Once ip_build_and_send_pkt() or ip6_xmit() takes ownership, the
networking stack may already have consumed the skb before returning an
error, so freeing it again is unsafe.

Handle the pre-handoff failure cases inside nat_keepalive_send_ipv4()
and nat_keepalive_send_ipv6(), where the caller still owns the skb, and
keep nat_keepalive_send() responsible only for family dispatch and the
unsupported-family cleanup path.

Fixes: f531d13bdfe3 ("xfrm: support sending NAT keepalives in ESP in UDP states")
Cc: stable@vger.kernel.org
Reported-by: Yuan Tan <yuantan098@gmail.com>
Reported-by: Xin Liu <bird@lzu.edu.cn>
Signed-off-by: Qianyu Luo <qianyuluo3@gmail.com>
Signed-off-by: Ren Wei <n05ec@lzu.edu.cn>
Reviewed-by: Eyal Birger <eyal.birger@gmail.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_nat_keepalive.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/net/xfrm/xfrm_nat_keepalive.c b/net/xfrm/xfrm_nat_keepalive.c
index 1856beee0149bb..f50b1f48f2ed92 100644
--- a/net/xfrm/xfrm_nat_keepalive.c
+++ b/net/xfrm/xfrm_nat_keepalive.c
@@ -55,8 +55,10 @@ static int nat_keepalive_send_ipv4(struct sk_buff *skb,
 			   ka->encap_sport, sock_net_uid(net, NULL));
 
 	rt = ip_route_output_key(net, &fl4);
-	if (IS_ERR(rt))
+	if (IS_ERR(rt)) {
+		kfree_skb(skb);
 		return PTR_ERR(rt);
+	}
 
 	skb_dst_set(skb, &rt->dst);
 
@@ -101,6 +103,7 @@ static int nat_keepalive_send_ipv6(struct sk_buff *skb,
 	dst = ipv6_stub->ipv6_dst_lookup_flow(net, sk, &fl6, NULL);
 	if (IS_ERR(dst)) {
 		local_unlock_nested_bh(&nat_keepalive_sk_ipv6.bh_lock);
+		kfree_skb(skb);
 		return PTR_ERR(dst);
 	}
 
@@ -118,7 +121,6 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 					sizeof(struct ipv6hdr)) +
 				    sizeof(struct udphdr);
 	const u8 nat_ka_payload = 0xFF;
-	int err = -EAFNOSUPPORT;
 	struct sk_buff *skb;
 	struct udphdr *uh;
 
@@ -140,16 +142,17 @@ static void nat_keepalive_send(struct nat_keepalive *ka)
 
 	switch (ka->family) {
 	case AF_INET:
-		err = nat_keepalive_send_ipv4(skb, ka);
+		nat_keepalive_send_ipv4(skb, ka);
 		break;
 #if IS_ENABLED(CONFIG_IPV6)
 	case AF_INET6:
-		err = nat_keepalive_send_ipv6(skb, ka, uh);
+		nat_keepalive_send_ipv6(skb, ka, uh);
 		break;
 #endif
-	}
-	if (err)
+	default:
 		kfree_skb(skb);
+		break;
+	}
 }
 
 struct nat_keepalive_work_ctx {
-- 
2.53.0

