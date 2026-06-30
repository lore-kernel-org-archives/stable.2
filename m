Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54112175A7C;
	Tue, 30 Jun 2026 13:44:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782827084; cv=none; b=WkVivrx6PTyo/MDOJfzLl75h0Nbz0An90sMys4zrDRaxLZphiNtgFRaVwRNCItB90XsC+5UUmJilSNp8LTdMsqanhZTW1sdeSHizhnM3SzHcqP3akNk6g42tDRZueaSBh1bT1ZzyDM+9S/DuJktBF8iHcNZdCYOLqBx3Dl9uMmk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782827084; c=relaxed/simple;
	bh=hqI/UOz8hqPgfUNojjrUVWsn2MvlBJirsuJnZzeSBeI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oWlqDytMwyKOJoPwoLB8WD4OK1WSDUp4pqZy+4ZMhcIpAkiKol/9KO70rQ91JHSNQHc1LUk82sxSKAiCB44ybCEcEk74IwSKSXOvA4kU7wJ97gvFnofk5kexi28qT0Sx2rHGGwCVaDDa5vuLNpmx9opUsGHp0kOHGht3shGKPTY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=YyjZHLMS; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="YyjZHLMS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1782827075;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=UONHzAgMDnGAqgV001hktCRBsTNwdlIvzqeiepXYuTc=;
	b=YyjZHLMScOcXHooP1WAl/NiqDz1zr5JAK22e1P6TuqE+S+n6XYytAGOK6LY5NQP7zYy+ha
	FTVK+AERmm/PfH+tJmuVur5FWus5o+NVXZ7Iqa93QHMTotDS7WN+Phk5T9YLqefHGtP/LM
	oKjQfCknbYChfCtTAjLMqVturhtdntUDNQ+kOIO9qyHh1v6UAnSfeQdhLucYse4kBha0gO
	XO+X55x6JWWxxEup8DzJtH+TjhOJlZYSHjgtiA47aFIxa/HnaNu0rGnF89/LOcJ/4+8T50
	DfHlWsgn1i1UPKZZ8dRpyezt/aOZY5MLuTJyTxK5nF/Qykcl4iEW2WCX7zLjgQ==
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
Subject: [PATCH net 5/6] batman-adv: bla: reacquire gw address after skb realloc
Date: Tue, 30 Jun 2026 15:44:29 +0200
Message-ID: <20260630134430.85786-6-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260630134430.85786-1-sw@simonwunderlich.de>
References: <20260630134430.85786-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

The pskb_may_pull() called by batadv_bla_is_backbone_gw() could reallocate
the buffer behind the skb. Variables which were pointing to the old buffer
need to be reassigned to avoid an use-after-free.

Cc: stable@vger.kernel.org
Fixes: 9e794b6bf4a2 ("batman-adv: drop unicast packets from other backbone gw")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/routing.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/routing.c b/net/batman-adv/routing.c
index 2cc2307a41702..bbd40fe3a8e59 100644
--- a/net/batman-adv/routing.c
+++ b/net/batman-adv/routing.c
@@ -1029,6 +1029,7 @@ int batadv_recv_unicast_packet(struct sk_buff *skb,
 							  hdr_size);
 			batadv_orig_node_put(orig_node_gw);
 			if (is_gw) {
+				orig_addr_gw = eth_hdr(skb)->h_source;
 				batadv_dbg(BATADV_DBG_BLA, bat_priv,
 					   "%s(): Dropped unicast pkt received from another backbone gw %pM.\n",
 					   __func__, orig_addr_gw);
-- 
2.47.3

