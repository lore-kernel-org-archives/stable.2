Received: from out-177.mta1.migadu.com (out-177.mta1.migadu.com [95.215.58.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A17B2459C5
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 03:05:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=95.215.58.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785294342; cv=none; b=Hq+Nk0xO1Z15iQbo1f0+GsvYsMzXUiIemhY1s+5K/GCZ/d0ygZBq9wKTxvoraKHLDA/AsMeqztw9MJo5R0UAlUsEs28RUQewnf+8XcB/C7oRdUxQxgbVBNLO5LBcgJBAoGNeZSIyvht/0hlHAm2MJfDxHLdVWISfppZbscYj1j8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785294342; c=relaxed/simple;
	bh=S0XTdxd9EFqAiIpzY2h7/y6Zhp+VWToFWz2QLG0RQm0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version:Content-Type; b=VFvDf/yFdfbiSbRzlUZzCG5HcT+R3vP525ti6pgRczR3MFYlizol1hat3OxVnwSAIjQF4p5jKlE4A5OZpRSGRpyc+PJsqJYSBMI3XZ9mH31WGnF4iwOe1idZGJNH+odk8/GQj1G9bM08Hz4VNpH3Ih8BAd36DNDKy8a6kohCtTU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev; spf=pass smtp.mailfrom=linux.dev; dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b=hOoYWPtQ; arc=none smtp.client-ip=95.215.58.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.dev
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.dev header.i=@linux.dev header.b="hOoYWPtQ"
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
	t=1785294328;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding;
	bh=ycGUdLr9mOIF6EQhnDtROfAy1DDOIbnzkSJgNj+BXSE=;
	b=hOoYWPtQhGhxr5OdGHu0TLydzVR1hMQu9NPP/SUkh745ub1cfnCwnopyMA2HG17w+Vj0Ij
	O76Wjp35lxnqp3ttzikoiO//T7AEr9+XrIIWu/nhfew3XLLBjflaFp7wVPI+shy6IyVk8c
	zPKgai6+cs093+LXnZNWd373GmFM8i0=
From: Yi Cong <cong.yi@linux.dev>
To: andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: jackychou@asix.com.tw,
	netdev@vger.kernel.org,
	linux-usb@vger.kernel.org,
	Yi Cong <yicong@kylinos.cn>,
	stable@vger.kernel.org
Subject: [PATCH net-next] net: usb: ax88179_178a: fix skb leak in ax88179_tx_fixup()
Date: Wed, 29 Jul 2026 11:04:36 +0800
Message-Id: <20260729030436.3420477-1-cong.yi@linux.dev>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT

From: Yi Cong <yicong@kylinos.cn>

When the interface has NETIF_F_SG enabled and skb_linearize() fails in
ax88179_tx_fixup(), the function returns NULL without freeing the skb.

usbnet_start_xmit() treats a NULL return from tx_fixup() as a drop
(info->flags does not set FLAG_MULTI_PACKET for this driver), jumping
to the "drop" label where it does `if (skb) dev_kfree_skb_any(skb)`.
Because tx_fixup() returned NULL, the local skb variable in
usbnet_start_xmit() is NULL, so the original skb is never freed — a
memory leak on every TX frame whose linearization fails (i.e. under
memory pressure).

Free the skb before returning, matching the error handling already used
for the pskb_expand_head() failure path in the same function.

Fixes: 16b1c4e01c89 ("net: usb: ax88179_178a: add TSO feature")
Cc: stable@vger.kernel.org
Signed-off-by: Yi Cong <yicong@kylinos.cn>
---
 drivers/net/usb/ax88179_178a.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/net/usb/ax88179_178a.c b/drivers/net/usb/ax88179_178a.c
index 98f899ea2e94..81d8412ce8e2 100644
--- a/drivers/net/usb/ax88179_178a.c
+++ b/drivers/net/usb/ax88179_178a.c
@@ -1487,8 +1487,10 @@ ax88179_tx_fixup(struct usbnet *dev, struct sk_buff *skb, gfp_t flags)
 
 	headroom = skb_headroom(skb) - 8;
 
-	if ((dev->net->features & NETIF_F_SG) && skb_linearize(skb))
+	if ((dev->net->features & NETIF_F_SG) && skb_linearize(skb)) {
+		dev_kfree_skb_any(skb);
 		return NULL;
+	}
 
 	if ((skb_header_cloned(skb) || headroom < 0) &&
 	    pskb_expand_head(skb, headroom < 0 ? 8 : 0, 0, GFP_ATOMIC)) {
-- 
2.25.1

