Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82A7F40910A;
	Wed,  8 Jul 2026 09:18:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783502329; cv=none; b=jcKECJLJO9H2cuKUdA2a468UQexJ/JtIWbw23almkIQkZ9VYZYbQXD4MUbWbfvrp2u+ipLGCWKpS93/DK0PeVc4iOU65L5N+Ve7K3k49VoXhpPCntNHQhXob64J6b3TcXrg1mwCmqiRsAt93m0XWWdqeNkr4noY9B2XabdBFwms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783502329; c=relaxed/simple;
	bh=+uBP9PtDhwXEi7TsSznUgZBVMjhLfvVFuXzlaIOWAVo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UwHNbtJseqmOvGvde3w8tNZ/Ot6tgHPXa7e33T2Tbjmhj9zPrxOtYVP4ZZPn/FvWWRe3Ut2zKw2VZQKtFnp+eOj0xfvB8j0bthFGTR0g3IJSSTXCNXbKHKGMtNAZOnQWhH1SYVjuoDSvLCMygyww2+oaijV1663qkskS47n/2JY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=HUkddEM8; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="HUkddEM8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1783502322;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=GKgYyF6RXM0vULAsGu0pR6G/eWYQjyyVfdhlWFhcPgw=;
	b=HUkddEM8pEutJmcLkpywE8+mpQeIi/PvNIrVE8Upos6kAjOAWvwWfatriY4PCC8kdqNOak
	V56lj8QMFitkVs/13GOAPIdB6wUcNidS9EZAmH1LR8XLuIEKukrqShJEM37iCqihTCcrOB
	PgrtdFlGRVAeu8qrefZv+FOorz7FiGM3sFtfki5fOoTHOunJRVDxV0ZInahNR5xyJHXCT9
	pBXyk4KgZ0gRDf8vXymiZ5L3CFn9E3wvwyx3RsbMoGseGq5RJhk9JJwN7cwQjFxcNoPp88
	IoTAsX4AIDx9WIaPY7PvG39LUiGssE2ihF3MXQVWLv/f/352pe6xL784l/lurQ==
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
Subject: [PATCH net 6/9] batman-adv: frag: free unfragmentable packet
Date: Wed,  8 Jul 2026 11:18:18 +0200
Message-ID: <20260708091821.314516-7-sw@simonwunderlich.de>
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

The caller of batadv_frag_send_packet() assume that the skb provided to the
function are always consumed. But the pre-check for an empty payload or the
zero fragment size returned an error without any further actions.

A failed pre-check must use the same error handling code as the rest of the
function.

Cc: stable@vger.kernel.org
Fixes: ee75ed88879a ("batman-adv: Fragment and send skbs larger than mtu")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/fragmentation.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/net/batman-adv/fragmentation.c b/net/batman-adv/fragmentation.c
index 8a006a0473a87..13d4689d332dc 100644
--- a/net/batman-adv/fragmentation.c
+++ b/net/batman-adv/fragmentation.c
@@ -518,8 +518,10 @@ int batadv_frag_send_packet(struct sk_buff *skb,
 	mtu = min_t(unsigned int, mtu, BATADV_FRAG_MAX_FRAG_SIZE);
 	max_fragment_size = mtu - header_size;
 
-	if (skb->len == 0 || max_fragment_size == 0)
-		return -EINVAL;
+	if (skb->len == 0 || max_fragment_size == 0) {
+		ret = -EINVAL;
+		goto free_skb;
+	}
 
 	num_fragments = (skb->len - 1) / max_fragment_size + 1;
 	max_fragment_size = (skb->len - 1) / num_fragments + 1;
-- 
2.47.3

