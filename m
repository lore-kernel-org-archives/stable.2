Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 753113BB9EB
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102086; cv=none; b=PUOaic1za/zAl7kAZRneROr/uQXzeo6+Glg/tqeoC6jc2CFWMvD7fWKIEyvO0Kzhytk8asx2/WG7OEDfE0+8qUDlWjB3bp59sM9Swoy3mwwdlHYczXJ0Jp6fPxng/z4ShVbWs1nAclCu75g/h74qPchDnAHajJAlgmHb2/aOhnc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102086; c=relaxed/simple;
	bh=evebabmJlyRbKMxIfCId3DRDcdee3CeXwT8pvyExX1s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=itQIakIpMH7j9TWNY4QLaL5xW8nBvOtnWX10fm/1AOqWC0ZT8x0Yy24M8SsEmslbjX/RWrDSxzetDY3xpPqVcr254fZYbzIcaz+MUrP/9pcSPls4hmEeVVFTZ5tueR09ve/PYDgfm+qzHclNfEpktQKqeOY240QTTELYCt/NDaU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hpeeJUSJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hpeeJUSJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72A561F000FF;
	Tue, 22 Sep 2026 18:34:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102085;
	bh=LdRoJ1zAtY+CsY0xSEfU/kzMluqXoUFvLgEI/+eV69c=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hpeeJUSJxkOty1d5ssWtvPdr4Oz1s3os/dxWW+em+dTKbAMb67a7Nbfypaaw0Wk7c
	 eurw0BM56uXkKcnCnm4iv1CSi/F7k4FE+UUqb77FbtPH9k0bwpQH/kkY73fjWZYqYD
	 XCg12nhccxSR4aiefufH0SGwTY7iDTkLfLQ0t3cswglV7njQ7ulqzDSLTn+PSFhbyz
	 rew/4A29Vt2TcVQuJQIx0Dg3g36rz9N/AUTSly6u19DR5RPjYawy6V4krMIu6MlI8M
	 elNyqIta6JssTuo0+ZOiB6tQbZNC3FB0BMmF6UdlRF8qb2GNtaqd98Fr8Kp9TQP7fz
	 IoaRs961xmGgg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/4] xfrm: hold device only for the asynchronous decryption
Date: Tue, 22 Sep 2026 14:34:39 -0400
Message-ID: <20260922183442.3692649-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092228-detective-absolute-febb@gregkh>
References: <2026092228-detective-absolute-febb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Jianbo Liu <jianbol@nvidia.com>

[ Upstream commit b05d42eefac737ce3cd80114d3579111023941b8 ]

The dev_hold() on skb->dev during packet reception was originally
added to prevent the device from being released prematurely during
asynchronous decryption operations.

As current hardware can offload decryption, this asynchronous path is
not always utilized. This often results in a pattern of dev_hold()
immediately followed by dev_put() for each packet, creating
unnecessary reference counting overhead detrimental to performance.

This patch optimizes this by skipping the dev_hold() and subsequent
dev_put() when asynchronous decryption is not being performed.

Signed-off-by: Jianbo Liu <jianbol@nvidia.com>
Reviewed-by: Cosmin Ratiu <cratiu@nvidia.com>
Signed-off-by: Steffen Klassert <steffen.klassert@secunet.com>
Stable-dep-of: 3cf5cdecd99c ("xfrm: save input state data before secpath resets")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/xfrm/xfrm_input.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/net/xfrm/xfrm_input.c b/net/xfrm/xfrm_input.c
index 6ab0b2166a595..31a677073fd3a 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -504,6 +504,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
+			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
 			goto resume;
 		}
@@ -643,18 +644,18 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		XFRM_SKB_CB(skb)->seq.input.low = seq;
 		XFRM_SKB_CB(skb)->seq.input.hi = seq_hi;
 
-		dev_hold(skb->dev);
-
-		if (crypto_done)
+		if (crypto_done) {
 			nexthdr = x->type_offload->input_tail(x, skb);
-		else
+		} else {
+			dev_hold(skb->dev);
+
 			nexthdr = x->type->input(x, skb);
+			if (nexthdr == -EINPROGRESS)
+				return 0;
 
-		if (nexthdr == -EINPROGRESS)
-			return 0;
+			dev_put(skb->dev);
+		}
 resume:
-		dev_put(skb->dev);
-
 		spin_lock(&x->lock);
 		if (nexthdr < 0) {
 			if (nexthdr == -EBADMSG) {
-- 
2.53.0

