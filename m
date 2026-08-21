Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A0F144D685;
	Fri, 21 Aug 2026 09:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787305719; cv=none; b=nBiBPRJhWDKR+46PTjCNH+16tqpvbdtjtxYv+grI+QPI0WOEro7o9PxYLwdip/alC7l9NqSa5XNMX7e2BbFWyMPvynFiXBS5nmCtQtqZ8MFYKLYsCLA6UM2IdKq5aOZAPsrwe8NG3OJPT6QT3ayPFgAoWq3ywvjsdIqdCHRLCCk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787305719; c=relaxed/simple;
	bh=NUO2o3WMWA82O8AE3rgUbZYFDavFNlsmJcarzbifqcI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ftXHoPmWNsN4GOM8liUHnQJQhet2j9vBwgH3TzRWj7LFGLiIAqLOWOrBBeSPY4MAMAjn7X7vTpj7Z7NPM/4JqN5/cjckjLA6TeGzXgIRbh6B4W/73xFzDBlWDq8RzaEzVfSFJeLoJZpf+sj3KAoMSEcHQJXNJKTnQpJJOGhic04=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=NZxP1Dmy; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="NZxP1Dmy"
Received: from kero.packetmixer.de (p200300c59714FcD8EC8C87C354003fed.dip0.t-ipconnect.de [IPv6:2003:c5:9714:fcd8:ec8c:87c3:5400:3fed])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with UTF8SMTPSA id 2C00DFA13B;
	Fri, 21 Aug 2026 11:48:22 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1787305702;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cJU+08rDDPXtarsKtPKGdOhWgwl9lWau1A8lhrBxiOM=;
	b=NZxP1Dmyr7ema6sj1yTef1bFHcaonieAJ7dwPBlAjmTYBTLhkm6QGxtolyIJTC4oCgFJgE
	V7jwfa+lTtkIKPI9zGg1hxkvSND4s8IAzHeM808JeE2FWLXjjyR+QI1a1ocjdnNNZMbAWW
	FIJ42IcLuUR6Ih99QotLQufOP5OgwORGeG8uQdqwuwBeNCYz54zHiqSur8fxQggn1xI/5J
	kfkf9hJ81ct4/HKhL23n3kODZ/0jGS0xxLP7mk7NYdlnmsWNUZ3b2Rk4DNUsnf1yUFluiF
	sJhHTUl5ljcUAR1vzAzkjyQn9e2KDM/wo63dlAacpq8UIsyfRBJ6SSsZ4JyFQQ==
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
Subject: [PATCH net 7/9] batman-adv: mcast: ensure unshared skb for multicast packets
Date: Fri, 21 Aug 2026 11:48:11 +0200
Message-ID: <20260821094813.201800-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260821094813.201800-1-sw@simonwunderlich.de>
References: <20260821094813.201800-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

When a packet is transmitted via a batman-adv interface and has already
enough room for the header then nothing will make sure that the skbuff is
unshared. But it is not allowed to modify a currently shared skbuff.

Always make sure that the pskb_expand_head() is not only called for a too
small header but also for shared skbuffs.

Cc: stable@vger.kernel.org
Fixes: 90039133221e ("batman-adv: mcast: implement multicast packet generation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast_forw.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index bae2a81109767..3927d28dcbb89 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1105,8 +1105,7 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
 		return -EINVAL;
 	}
 
-	if (skb_headroom(skb) < hdr_size &&
-	    pskb_expand_head(skb, hdr_size, 0, GFP_ATOMIC) < 0)
+	if (skb_cow(skb, hdr_size) < 0)
 		return -ENOMEM;
 
 	return 0;
-- 
2.47.3

