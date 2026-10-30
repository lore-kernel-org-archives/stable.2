Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368279;
	b=L6B/JsiBFlBaXbaLkVz6gvLMeGRw5qlQ77nBNiZBRTRH/TPv3EUIpfBhidXHaiuOzgXC
	 mu/OIMWgnbjmG8HnJlhAOqJFdbFzICJ3+Zp1x2ap6mbpIegvRH0GU6e8TGofj6TNEktlg
	 hRraAAMuERj607I0HqeCja6+WySfbqeuqKhJ75iWk8DG2uWCOv8iRwwNVv8Czi6cjiC5W
	 +gZT0THZFtZNAmj1PrgV7K5zb+ctbhO4WxnHwXyxFadpkFCYdDnYdpyjrL+1lF/HjGO8G
	 1NdkkzFuKK6IkD28xG6e8QmTekf/EXRFG/l23Iq3hrGZDzKH2tw5DuZWw+0K1Ksmx2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368279;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=MN8z/mlRHPV44mj1rD2L1TistCnF9IQ3ZHZlaq5saXc=;
	b=VCg+4X51PvY4vVLwY9+czh/oEqBiK/yQEP80EhWbQeKel4tRPIs1F7Ge7g0g/UJ+OtDh
	 d0oT0LN/UaXKppR35+m7OZB3C44lBwqWCJ0C+hDN//mw2ePf0TLn64vS9imY2IcL+7gvC
	 3apQsWoBqT7SxlQqJK4/2O7mvxu8+5h0UWVCQ26UjnYKDbMhI4c9s3YZ3b09Bpl/05T1L
	 yTC7skWQtLsXMrw6pz0wQdSg6f7JUIMWcvULd3cdfSW3XMt80JNCACl4sSxITSShWFKds
	 mKyhPKfV2MOgwabttw+alCYewlZVLl7CFI2Y0iaIMu2iSNsx3TF8Eo9b96kwRHy8ctg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=URx5qU17;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 70C01606A332;
	Fri, 30 Oct 2026 13:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70C01606A332
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=URx5qU17
Received: from kero.packetmixer.de (p200300c597124Fd839580c360D3ED6F6.dip0.t-ipconnect.de [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 80F8CFA1BF;
	Fri, 30 Oct 2026 14:51:14 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368274;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MN8z/mlRHPV44mj1rD2L1TistCnF9IQ3ZHZlaq5saXc=;
	b=URx5qU17hWFzI5EDnjEk7CwCJw3sng7NjxHdv6MfYpTKfQHL/XEBv19itM7VCUyk5Nd9pm
	rlLoBHWuST4nePgWSxFFzD5JGrIJE05lmBwV895nizIP7xM/q8kdlyoBuOy11zwaJNXIn3
	NPL5vSKgpKqVzr6Srbk961dOuzSxDW3QTQMYFYhTZCN4knwMdV/u05RKi8VRoc6sNOnnrM
	IOMDH3wJTkclipjnv9RZMZ/AkFDRWjE00hw+DwdizDqmCGJNLwzhbXRF8bhJ1axER/Vjvu
	nefrrdNLJdToPhhuohsk0u9wD7IQNkT/569kEf5uUnoxFM6ATXPoXQx3OEQpQQ==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Sven Eckelmann <sven@narfation.org>,
	stable@vger.kernel.org,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 06/14] batman-adv: fix skb leak when hard_iface is being released
Date: Fri, 30 Oct 2026 14:50:57 +0100
Message-ID: <20261030135105.2555887-7-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261030135105.2555887-1-sw@simonwunderlich.de>
References: <20261030135105.2555887-1-sw@simonwunderlich.de>
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

From: Sven Eckelmann <sven@narfation.org>

batadv_batman_skb_recv() owns the skb it is given. When the hard_iface
refcount already dropped to zero, the function jumped to err_out, which
only returned NET_RX_DROP and skipped the kfree_skb() under err_free.

To avoid a leak, free the skb before returning in this case.

Cc: stable@vger.kernel.org
Fixes: 4fe56e60ac1b ("batman-adv: Check hard_iface refcnt when receiving skb")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 6c54a8d4be3ec..ced76942f33c5 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -484,8 +484,10 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	 * shut down otherwise the packet may trigger de-reference errors
 	 * further down in the receive path.
 	 */
-	if (!kref_get_unless_zero(&hard_iface->refcount))
-		goto err_out;
+	if (!kref_get_unless_zero(&hard_iface->refcount)) {
+		kfree_skb(skb);
+		return NET_RX_DROP;
+	}
 
 	skb = skb_share_check(skb, GFP_ATOMIC);
 
@@ -541,7 +543,6 @@ int batadv_batman_skb_recv(struct sk_buff *skb, struct net_device *dev,
 	kfree_skb(skb);
 err_put:
 	batadv_hardif_put(hard_iface);
-err_out:
 	return NET_RX_DROP;
 }
 
-- 
2.47.3

