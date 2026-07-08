Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 001E1407CD3;
	Wed,  8 Jul 2026 09:25:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502738; cv=none; b=a1Kz8KZjS7WB3NyTNxmKMt5yhNuC2zmn0LKlPJhQc9tfeaQnH4bDoOV5O6Lprtp08TeUw2DgWXwUgEthsum8rldn0vX4I8LadxCtAFAavE1fPyaccCxLRfu8HuBsA9g8VqXWa8rHzpjeq8jqidFo8N+lOtEVb2/g7oy1imjrcdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502738; c=relaxed/simple;
	bh=ZyOHC+XlSbYcmggV/wyB/7gLKiYlGOSn1jgsbJrnOxY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e+iXtyFeeZ61rjY8YWUOQ1H6iXVZ6ni2xdqqA0sHYUImhBXv3GeXlRMjMg/qjhMzg7fiNY/yfu8f4KIAe1w6PMzbG8KjYF9+zDSl+OFGlM9J+8uczHJ+zpB/zm7+1tJVcrh+0bjMp1/0S1nm0YgYI2Pj1YOVfU+4kWqLtqbyLdw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=yR0X5FCa; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="yR0X5FCa"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=iKVr6k89o6c2SMn62B3acIsRyxHbKZyCo6kVHh2xDwU=;
	b=yR0X5FCaJ/Pz0v6Ak83gzmOdsOjnN4BYXXJ0lzqjd1nym7vRWHa/cmSCaM/nJ3KPulJ7A8
	nIGLvaOlOLOqxCR2DcVUypCBUN5xAIqLlhshWNy/tDcDdy+I9h8uqazQwuzXd/x2SdHSSq
	ZWu8Zs/qypEas5HNpN07N77oqv2AVXpLgEB213NnBtCdkB6ZmG3VZgzrZLV3E5L+B+uUzp
	bgngvfjJBK1Kj/d4cJr0kC3eJAtv04tlZJ+k6VG5hzZvXTU/CJ7xDfnrUCDpdKcyPw1W5P
	hca30uz/2LYvg8NkKYYMMYPXIASjODIC4aH2a0IZWFQfb1qhSKhoFtftKOvIhA==
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
Subject: [PATCH net 2/9] batman-adv: fix VLAN priority offset
Date: Wed,  8 Jul 2026 11:18:14 +0200
Message-ID: <20260708091821.314516-3-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260708091821.314516-1-sw@simonwunderlich.de>
References: <20260708091821.314516-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The batadv_skb_set_priority() receives an SKB with the inner ethernet
header at position "offset". When it tries to extract the IPv4 and IPv6
header, it needs to skip the ethernet header to get access to the IP
header.

But for VLAN header, it performs the access with the struct vlan_ethhdr.
This struct contains both both the ethernet header and the VLAN header. It
is therefore incorrect to skip over the whole vlan_ethhdr size to get
access to the vlan_ethhdr.

Cc: stable@vger.kernel.org
Fixes: c54f38c9aa22 ("batman-adv: set skb priority according to content")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/main.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/main.c b/net/batman-adv/main.c
index 4d3807a645b78..8844e40e6a803 100644
--- a/net/batman-adv/main.c
+++ b/net/batman-adv/main.c
@@ -368,7 +368,7 @@ void batadv_skb_set_priority(struct sk_buff *skb, int offset)
 
 	switch (ethhdr->h_proto) {
 	case htons(ETH_P_8021Q):
-		vhdr = skb_header_pointer(skb, offset + sizeof(*vhdr),
+		vhdr = skb_header_pointer(skb, offset,
 					  sizeof(*vhdr), &vhdr_tmp);
 		if (!vhdr)
 			return;
-- 
2.47.3

