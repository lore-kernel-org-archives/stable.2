Received: from mail.simonwunderlich.de (mail.simonwunderlich.de [23.88.38.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7CEA83AA1BA;
	Tue, 28 Jul 2026 13:39:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=23.88.38.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785245973; cv=none; b=t+NH97+mILUlhRlCdhdzl8RsSEvXtr7b2Yo7cAtNobETAc02c82UBhu8xYDDON1nzyI8yZmgKBzObxmCSp1P0syIT4x4deYk2ekFv/XKMXxiIhkwbffoN4NHyLdwxA/iCA7bPrpiCGVHpZm0sL1dp+1hcINONtWHkNEtXlFJKTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785245973; c=relaxed/simple;
	bh=Xx8yPwQD/Alqj2i71S3lOfCCOPcIpzZjyOsLXn3d2C4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hpv1YnAixFQM11GCHWi7admASv+UdHN9pGJ37NPijv/fgE9iHgaAgLT4m1eYMaTcAijK6ABk1/Rh7lNyhdXEi++xnTiIHlEAXl6tP+dxxjW3qI3qCofVJV057HrAIX9cMekeHxVs02Mqmq7j/j3uKIib2dTex+oakw/lg7Wjc/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de; spf=pass smtp.mailfrom=simonwunderlich.de; dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b=GRoo2jn7; arc=none smtp.client-ip=23.88.38.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=simonwunderlich.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=simonwunderlich.de header.i=@simonwunderlich.de header.b="GRoo2jn7"
Received: from kero.packetmixer.de (p200300C59717EAd808F168c97E5563A8.dip0.t-ipconnect.de [IPv6:2003:c5:9717:ead8:8f1:68c9:7e55:63a8])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.simonwunderlich.de (Postfix) with ESMTPSA id B2D32FA129;
	Tue, 28 Jul 2026 15:39:24 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=simonwunderlich.de;
	s=09092022; t=1785245964;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SMHpUeEpOQHgX43yYtxGHEC46IOieRNzzQbS8u0iOlk=;
	b=GRoo2jn7JLs0g33QjIk5i2gjtt+h2rJwlG35BUNI9USJx6GhBZqGe4OChaykObc6lYP892
	+U45rRGRvIxmZl92xAFpC3nC1aUi7wGc/QInTBfaD1mSq3AvHQdrDWdNICdYPkF5nEqO4k
	RoAgII+gDqxU/nyawAPegj3k6Rc1ztqGi9r5vkBoEAflmRuB5dGxdksqojimhcxG/6qOcU
	N+f9ucYFVDWQMbLHLg8i64RJx1c4Elw4vLyLaq7l+/oAzzcsnRoM+loWWrK1lqNFlXsU8p
	9JXk5ojJFZN2VQ187KjyAlM3gbQivqmFwbfQ0FSR+BkczoxI4f6oYAGA1SgTzQ==
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
	Sashiko <sashiko-bot@kernel.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH net-next 07/15] batman-adv: mcast: linearize skbuff for packet generation
Date: Tue, 28 Jul 2026 15:39:10 +0200
Message-ID: <20260728133918.643267-8-sw@simonwunderlich.de>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260728133918.643267-1-sw@simonwunderlich.de>
References: <20260728133918.643267-1-sw@simonwunderlich.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sven Eckelmann <sven@narfation.org>

batadv_mcast_forw_packet() and batadv_mcast_forw_packet() is not only
called by the unsharing+linearizing batadv_recv_mcast_packet() handler.
When it is called by batadv_mcast_forw_mcsend() then it will be unshared
but not linearized. The SKB_LINEAR_ASSERT() can therefore cause a fatal
BUG().

The linearization should happen during the expansion of the head because
the call chain because the scrape function can be hit already during the
initial batadv_mcast_forw_mode() selection code:

* batadv_interface_tx
* batadv_mcast_forw_mode
* batadv_mcast_forw_mode_by_count()
* batadv_mcast_forw_push()
  -> calls batadv_mcast_forw_expand_head() before everything else
* batadv_mcast_forw_push_tvlvs()
* batadv_mcast_forw_push_dests()
* batadv_mcast_forw_push_adjust_padding()
* batadv_mcast_forw_scrape()

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Fixes: 07afe1ba288c ("batman-adv: mcast: implement multicast packet reception and forwarding")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/multicast_forw.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/net/batman-adv/multicast_forw.c b/net/batman-adv/multicast_forw.c
index 240ed7380cb0f..c99579dc1ca98 100644
--- a/net/batman-adv/multicast_forw.c
+++ b/net/batman-adv/multicast_forw.c
@@ -1103,6 +1103,10 @@ static int batadv_mcast_forw_expand_head(struct batadv_priv *bat_priv,
 	if (skb_cow(skb, hdr_size) < 0)
 		return -ENOMEM;
 
+	/* batadv_mcast_forw_scrape() + batadv_mcast_forw_packet() require linearized skb */
+	if (skb_linearize(skb) < 0)
+		return -ENOMEM;
+
 	return 0;
 }
 
-- 
2.47.3

