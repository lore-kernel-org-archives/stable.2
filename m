Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com [209.85.214.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60907522EEB
	for <stable@vger.kernel.org>; Wed, 30 Sep 2026 21:47:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790804867; cv=none; b=VjBVkaa5JfbNDPI5So93KGNty4rGUWaOuzCFaopLWpc2Sp8gDqL3+TcNhpmawbxDXrRu33cbpBvfLSerQ539hHUhsG1MVb/dnZ4fsvx1zB+Elw8DMSkYuSAaYn8wgUxOe2xU7Z+LrBezyRVaKh0hqZPv4YdFxxjw1TtQ9Y8Eyi4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790804867; c=relaxed/simple;
	bh=fmRUv0rgYENilBBqlQb0+ODvj/lHolbV7pwBrCOH7eY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ABmFQXa6phTlc7RqmQ7Z9XQ7gNQUE33Iz2pHIdfVxReZn+bEBafq5igz+Q4D+RTzOZXQzYWLjLyqnJYBmQMDipBiJGFQiQ8LgBpnJkY7I62x7RnISRvFyiaRIr+Z9LpZvMEihyZT8c1j+Nbg1U73GYKyxg0pb2PbO3sGnHariEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=s0omM5Ys; arc=none smtp.client-ip=209.85.214.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="s0omM5Ys"
Received: by mail-pl1-f200.google.com with SMTP id d9443c01a7336-2cee1ec30f2so55435025ad.3
        for <stable@vger.kernel.org>; Wed, 30 Sep 2026 14:47:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790804866; x=1791409666; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=sie3jAJkujJ1GxkZsQETdrfF4K98ZdkI7DVnUVfTI68=;
        b=s0omM5Ysoeasn2f9ISMTlm/fgQPvQ/G+q8jiHwS+nbh1ALyjD4zedYiCQdi4ZxKZYC
         tC1P49RyiI5Edq25KM5l+bQhJICuCcqQRdLbH+WG9zyXJMQtsCcMnBjtBX0V7HPSyd5O
         OtbQXT1l9aDqHIvx3sItxiYP3y8OwWxSZ3QWMkjJ6Y3JyfSNntSLA1J21plGBlYLSiOJ
         BOwtM6BPo+T2QrP+y7zaXwJ8Dy9GUuvuT1VgsvLMON0gsf5/7Zu1jJpDpFQ+VAeAkx5P
         0Ugdf1IBxmtJTdyFjnQ069wsmi6FpPyKpYZrFoasXJz/yT7bto1fevOmH662znR1V6mO
         I4Ig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790804866; x=1791409666;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=sie3jAJkujJ1GxkZsQETdrfF4K98ZdkI7DVnUVfTI68=;
        b=MM9tbpq0+a5Cs9FToQi4zYm4ncWaLz743TEfmBU7eZpykUeNjTbett1vJoMu/t5w4B
         8KQ3eCyvTEzBZyJ6aGTbLadh74azBDSVmp9paUbz5iFYbAMXiLzbPJlPZwvOOobqJCK/
         Y65dyEzg47xSte5+ojFsOq22q/A7O5CJnCZTgCRVm2d3DdM+hedhAXH9KUVA1YawizdC
         43D7EN3vDXRS9EMGhp9o3GeqF/ItXarZDQaCe8laVJkEYIJSHPXgWP0CzKPVW1pGZFIy
         vRnrXNCBhvqUV20ndZyILbVUublSzAaEk6fPMpGvWAtScch+Q3bjk6kYYozQkHaq21Me
         z1Hw==
X-Forwarded-Encrypted: i=1; AKwUvBwzTL/6I3UNW1KwJDZFTTUUtwUKHOKMj52vp6Qcx9QIstjCkmkBd+FjJk0NlXIlGMNM5D/2OtI=@vger.kernel.org
X-Gm-Message-State: AFq9FYInMdSqupCUwyXgZd/Qd3AMKzb5OjhI7ddSU/hmrs/Pa+iK+q4+
	l9Cn0ViAisZeu9PBDNLXmqDWAncKr7MQNivSB2vQvtFFB1Drd7d7JV74tBhO7KoifhiM8UGv9K9
	vp86P5piK/L+KDg==
X-Received: from pleb19.prod.google.com ([2002:a17:902:d413:b0:2dd:5303:f008])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a17:90a:e7c9:b0:3a4:85c4:68fc with SMTP id 98e67ed59e1d1-3a4d1545a03mr2457426a91.29.1790804865442;
 Wed, 30 Sep 2026 14:47:45 -0700 (PDT)
Date: Wed, 30 Sep 2026 14:47:35 -0700
In-Reply-To: <20260930214735.3288780-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260930214735.3288780-1-joshwash@google.com>
X-Mailer: git-send-email 2.56.0.rc1.315.gc6ed9934b7-goog
Message-ID: <20260930214735.3288780-4-joshwash@google.com>
Subject: [PATCH net v3 3/3] gve: fix napi_disable deadlock when attempting to
 disable XSK pools
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Willem de Bruijn <willemb@google.com>, Jordan Rhee <jordanrhee@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
	stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

When disabling XSK pools, GVE calls the unlocked versions of
napi_disable and napi_enable. However, the netdev lock has already been
acquired before ndo_bpf is called because GVE supports queue management
ops. Calling the unlocked versions of napi_disable/enable results in a
deadlock when attempting to disable XSK pools, as the thread attempts to
re-acquire a lock it already holds.

Update the NAPI calls to use the locked versions.

Fixes: 606048cbd834 ("net: designate XSK pool pointers in queues as "ops protected"")
Cc: stable@vger.kernel.org
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 9cc343a16271..a6c18e2431cc 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1708,17 +1708,17 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	}
 
 	napi_rx = &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
-	napi_disable(napi_rx); /* make sure current rx poll is done */
+	napi_disable_locked(napi_rx); /* make sure current rx poll is done */
 
 	tx_qid = gve_xdp_tx_queue_id(priv, qid);
 	napi_tx = &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
-	napi_disable(napi_tx); /* make sure current tx poll is done */
+	napi_disable_locked(napi_tx); /* make sure current tx poll is done */
 
 	gve_unreg_xsk_pool(priv, qid);
 	smp_mb(); /* Make sure it is visible to the workers on datapath */
 
-	napi_enable(napi_rx);
-	napi_enable(napi_tx);
+	napi_enable_locked(napi_rx);
+	napi_enable_locked(napi_tx);
 	if (gve_is_gqi(priv)) {
 		if (gve_rx_work_pending(&priv->rx[qid]))
 			napi_schedule(napi_rx);
-- 
2.56.0.rc1.315.gc6ed9934b7-goog

