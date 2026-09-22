Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C1D648F82A
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 18:40:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790102448; cv=none; b=TvIgypYY9d4VHsHHUeCxNf4uW22CNNUuKUGx58Qnk3fLbf7XEHgEqdDcnPEEnhMWXuhBZcjDwoB6xxnK409Ox6BWUw3Y7GzNuIUNcldnfO2Wy/dOVN3RRMI/5m1MgbAta2aIxz2GjAxo9oDFHkpdCe526yh7h7UTTdfry42VhC4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790102448; c=relaxed/simple;
	bh=EgWxUQDYP5VkNDRaG2h0uFc0RFkC+HgdCQptCFe+5MA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hW/Y44aJGabZc7SfOX9Yp+a1GEgWK8afXjer7rYcF1REep1Ao6WiWMJgRLq7U01F6KtDRAef6IuCslanbVRpM6Ugso5N8TZDTD2qsqfKINMWVJ6LeY4gVa4IMYw3hrJzyXBgBXRJtRqj0AZcZLHCBUsdSqNji9347lqopIfPZRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=levKgbuk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="levKgbuk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6B4071F00898;
	Tue, 22 Sep 2026 18:40:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790102446;
	bh=vFplzZgDTYi0sPunBJBh3UxiGfoaT3CTo2Qxb9TuEdk=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=levKgbukuizYbEY8aLsYYDcmON0WnT9Oz8C4S0v2qdKN0euz2zlsQFDvIGQtS7DWl
	 u3v/EJRr3KjY1HKofLP3vRXf50YBWDHH9ZzTG6E9Q2Ua4BoPe3QBALO1l7st7/uiTW
	 ewK8WrdyvsSjyUTEB26Nt3kBLW333OgneN6LAEJ/XW1tuHzjqjVoSYMZkJK5P/4058
	 XnNEPjy1tPf0bNLI2khpRbXOEULjuJJRjUMyxArNMLxrNQIHWv32f6q6dXlWMX+Lv9
	 QHXOs9nIFuMTSaRHBfauRkXZGn6c6radbqaRVQUqpz76tpKLS/SA1mtGWyGZ4uDWbp
	 46Ptd57fwuGuw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jianbo Liu <jianbol@nvidia.com>,
	Cosmin Ratiu <cratiu@nvidia.com>,
	Steffen Klassert <steffen.klassert@secunet.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/4] xfrm: hold device only for the asynchronous decryption
Date: Tue, 22 Sep 2026 14:40:40 -0400
Message-ID: <20260922184043.3743838-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092229-tuition-manmade-0086@gregkh>
References: <2026092229-tuition-manmade-0086@gregkh>
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
index 7a2d7048a4911..0e8850455bc14 100644
--- a/net/xfrm/xfrm_input.c
+++ b/net/xfrm/xfrm_input.c
@@ -503,6 +503,7 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
 		/* An encap_type of -1 indicates async resumption. */
 		if (encap_type == -1) {
 			async = 1;
+			dev_put(skb->dev);
 			seq = XFRM_SKB_CB(skb)->seq.input.low;
 			goto resume;
 		}
@@ -642,18 +643,18 @@ int xfrm_input(struct sk_buff *skb, int nexthdr, __be32 spi, int encap_type)
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

