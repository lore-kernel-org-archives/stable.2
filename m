Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7691F4A4EF4
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:45:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106350; cv=none; b=jRC8FhFZgNn3uI5rNo03/SYzoOcY51udUr+U5+YIHHBYWZEk8y7bDGDz6EKGy74j7KC761roU+1NtAfvWE86cFuD7RJmNdT0j33vbn1NHRPLWWJgE3OUOd3wCv0y4zbupXzmvJZ3sug38m0TYEd3z7D3koLD0pGLyDFMufcxumo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106350; c=relaxed/simple;
	bh=qIMCCaTvSWDTxA3XuP5WL1+WB8BXmmqRBAoCppkztHc=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=ZcvaKHm660xa4B4Wvw5AMRZINj5wDBSNEiS3YPiBJ0QIeD1a7MMbpawWc8k8m1klTKSOlIfqxPhd3cTLCv/DFgNiZraHiSYuQrnzb7Or9PIS7SOBCeEue4a1qHW75VoYPJAj1+z3a1CuNIDgLfxhocQKXXNlQ92jZbadhYBHxVY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bow9y9QX; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bow9y9QX"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cc72777faa2so222151a12.1
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790106348; x=1790711148; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=UvcRcnpVi8ICqxsH8+8hVW6wZ840sbPSq2HiKDG88Is=;
        b=bow9y9QXxCzVs4du4wnN39XFgYuKSSzS3X6x33Uy979X5SXJv0Z3aGzqhGVXqBAJ6M
         2TtpmiMPG0qRM3RsI88AkZ7mykZbovbziTzSR/7pqU8xPEKq09fpmmbVG+XNvCY8PV9N
         Ww9rocpZMlbukhmRDxDn1IQo4jLd7qqwpZPFYr2nY5ShZoKbZUxAfNFmbATN5qEtcv4e
         PqzFQ0h3BG68xqNT8phsNwojJxjfxro8vleS5/lTaNVpQ/LNcNoSe+5RYg7sJFcHoeMU
         Kxs7LOsGbInTfiUQfm5P3YpivvR33xp0+wpany3oBkUHO6Q73yjTCamCP87hzFPrycpE
         krnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106348; x=1790711148;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=UvcRcnpVi8ICqxsH8+8hVW6wZ840sbPSq2HiKDG88Is=;
        b=pwpSkPF3UD/Ac6bYGfMZ8Ar7ecQAQE+Q9S6d6+pSCQiXVLi1ty7cGNRk/DMzyD1Imy
         Y9a44tjuq7DEMP+drr8AhD1/yXOpy3LUxq3XOXUnBJHw2uKv025g2xfkY+x39GDZ30JV
         WH0sBJzlJsIS2bEDBD+lQhxXPjhsuzTNXZlEs15265OGCogr3SEgcWW+7Ww5szNiB3iT
         tCfmE9JptNPQVJ+InjKP2rYpwPOqQMAPU0Kb1ufXqY6L0i3E3ABGkraL6FMxL4xpx+dD
         VQsTe+n+hOPqu0m+LL9HtVTgH3VkkSR8uQhVZSinRD5STMKLCHNSQDwDb4NPkCNK8dfH
         PpLg==
X-Forwarded-Encrypted: i=1; AKwUvBxvhRoRPKVum9jkwCj5anXfsJ/xsVBqZNXvpXEmBrYwH5v4HY2wgX3LFvu4WhBAmX67r9Hitnc=@vger.kernel.org
X-Gm-Message-State: AFuF++kN8NvXf8zktS6FQhs6YT0nYpBiFTW1vbVz54kL9kbprtGUdSvs
	QT+RtctY8sz1C4fojG+IfZ0oQBl7S9yL3vh5IFaF+D8fqWhOCxD2pRSkQkEOUVawwqmcngpkqAw
	vCeiG53TCPBY8GQ==
X-Received: from pfbfu12.prod.google.com ([2002:a05:6a00:610c:b0:84a:251a:a85e])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a20:939d:b0:3dd:e2e3:30fc with SMTP id adf61e73a8af0-3ddf82fa284mr499447637.49.1790106347525;
 Tue, 22 Sep 2026 12:45:47 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:45:29 -0700
In-Reply-To: <20260922194533.631387-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922194533.631387-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922194533.631387-6-joshwash@google.com>
Subject: [PATCH net v2 5/9] gve: fix napi_disable deadlock when attempting to
 disable XSK pools
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
	Jesper Dangaard Brouer <hawk@kernel.org>, John Fastabend <john.fastabend@gmail.com>, 
	Stanislav Fomichev <sdf@fomichev.me>, Jordan Rhee <jordanrhee@google.com>, 
	Willem de Bruijn <willemb@google.com>, Tim Hostetler <thostet@google.com>, Ankit Garg <nktgrg@google.com>, 
	Eddie Phillips <eddiephillips@google.com>, Praveen Kaligineedi <pkaligineedi@google.com>, 
	Jeroen de Borst <jeroendb@google.com>, linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
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
index b9bcdc7619b2..3712ff364cbd 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1706,17 +1706,17 @@ static int gve_xsk_pool_disable(struct net_device *dev,
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
2.55.0.1082.g2b9226bbc0-goog

