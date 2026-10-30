Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=23.88.38.48
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793368279;
	b=hsXxZi78ceO1w5vXStJ4g7hTIlIF6OoeP4XghP53+v0QIYgIm0Z7tb0cSvwMykkN9a6s
	 ZfjwEr95bUrf4GM4Nl2CC9bmU1EwnJYryMQClO+UmbjIqHEJXzWGkFzhCPZ/nOvnFaFwq
	 0nAYI4cQyinunJG/q3w48vPwbRO3zxuzM/4tgbIFEcVhGlzDEN1HZPpHBOrVnlWSXkjWg
	 nE29hZ8D5cvbx/drxDmMC6Sk2MkSM51znOw+VQ1IStQR+e+5LtvVDIDVwakLRzIjUhgyn
	 HgYhyKzbY/r932XaMKhejPIPB0y6x2ISJNsORwbdbgdfikVkR/fraKarJiOBQH0oGJw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793368279;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=X26JA/MFDFcPSUPChPCfILHIVeZni1u9oAU8sdS5v+w=;
	b=u815fBYTgFTYP13+hX/Kc3WHv+Nf8ahBvadU9dAYaZ7r80Zn38CTiHJxFhXVMEJ/YUBJ
	 9HnjShzs+4pt1zy9Z2PjqkciaGn5CuvoH3e2sEJSPR8/bKBS6to2L7dsHh+R26V17szns
	 xtSZGZ6VJG7brtJv8MHKFZBP7qvfOPtHgx59IZm+h5AwpHfD5T1dbf5+gLWshxvQrE/vY
	 Xuvjnc7M8INrEyxbIBvYptvszCsc+lIzysT06o+j1AkNbVYbv+5/OfoKq8l8v7CQmqtDx
	 2qFMLk2nNmJtRTsQCpCSHt1TyI353/pS8aU8vXX8y1igX3CqVXZ3OVKg44RlciYljrw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=simonwunderlich.de;
	spf=pass smtp.mailfrom=simonwunderlich.de;
	dkim=pass header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=TS7fKDiH;
	arc=none smtp.remote-ip=23.88.38.48
Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3EDDF606A326;
	Fri, 30 Oct 2026 13:51:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3EDDF606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.a=rsa-sha256 header.s=09092022 header.b=TS7fKDiH
Received: from kero.packetmixer.de (p200300C597124Fd839580C360D3eD6F6.dip0.t-ipconnect.de [IPv6:2003:c5:9712:4fd8:3958:c36:d3e:d6f6])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 2D12FFA093;
	Fri, 30 Oct 2026 14:51:10 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1793368270;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=X26JA/MFDFcPSUPChPCfILHIVeZni1u9oAU8sdS5v+w=;
	b=TS7fKDiHF1ScreJ3I+cqnzV0iAfeyl0+hAM+AdpeX3RqwJnifQSXx0Z602jp7wmZHCxtL4
	NUhIS7aVA+RHyNBm3WF6Eb3PmpYPWVe59R2M8q0QIJbbDFzDpgB+oxzn/NdQGEcjXWTuog
	PLfM9x6qtcPGxR2PEDR/pSJDCRRy0A+Ba2yw6h4HB5sTtsH58y4/aiXFJkyKtFWJ2kj2zf
	MppZJzS3sZEXlTaz7/fSEgz16PseGshCm1+ThRKC/doCTueH+YruSPNSKdwzzjTpINUaIW
	OBu6c0Hj0XYGy2n3r+tSaTRJjKjCOEhRJM9K5gRflxCmTSwyzw6l+bz4fjGC1Q==
From: Simon Wunderlich <sw@simonwunderlich.de>
To: netdev@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Simon Horman <horms@kernel.org>,
	b.a.t.m.a.n@lists.open-mesh.org,
	Kyle Zeng <kylebot@openai.com>,
	stable@vger.kernel.org,
	Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net 03/14] batman-adv: mcast: validate tracker padding before forwarding
Date: Fri, 30 Oct 2026 14:50:54 +0100
Message-ID: <20261030135105.2555887-4-sw@simonwunderlich.de>
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

From: Kyle Zeng <kylebot@openai.com>

A multicast tracker with an even number of destinations needs two
padding bytes after its destination list. batadv_mcast_forw_packet()
currently only checks that the count field and the addresses fit in
the tracker TVLV.

If an unpadded even tracker is compacted to an odd number of
destinations, batadv_mcast_forw_shrink_update_headers() includes those
missing padding bytes in the amount to remove. The subsequent memmove
can then write two bytes past the old packet tail. With no tailroom,
this corrupts skb_shared_info.

Include the required padding in the existing tracker length check.
This rejects the malformed tracker before either received or locally
generated packets can reach the compactor.

Fixes: 2dfe644a1ce0 ("batman-adv: mcast: shrink tracker packet after scrubbing")
Cc: stable@vger.kernel.org
Signed-off-by: Kyle Zeng <kylebot@openai.com>
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast_forw.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index ac97cd8b81dc9..9ffed1f237b6b 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -950,8 +950,11 @@ static int batadv_mcast_forw_packet(struct batadv_priv *bat_priv,
 
 	dest = (u8 *)mcast_tracker + sizeof(*mcast_tracker);
 
-	/* check if full tracker tvlv is within skb length */
+	/* check if full tracker tvlv, including padding, is within skb length */
 	tvlv_len = sizeof(*mcast_tracker) + ETH_ALEN * num_dests;
+	if (!(num_dests % 2))
+		tvlv_len += 2;
+
 	if (tvlv_len > skb_network_header_len(skb))
 		return -EINVAL;
 
-- 
2.47.3

