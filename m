Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com [209.85.215.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EDEE3E51F9
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 23:49:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751365; cv=none; b=kdXsqsExB6HLB3os1Mqhomem4SYYWkhnPsQ+YV8B42wurI/HHCxyV4CAHuPOAJLSfymikuI6nMe2dfb+/2AIHGoq+BdMY7A3MzNXXF1dZp4KTHjY07JKJCX+Mtti+aNz3XalR8CeYF5QCkgTFIolPJ2Xx6TaiW+FkFLTxFOCsbo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751365; c=relaxed/simple;
	bh=KmaIFs7Rsf1wuaaVKDkIGKBAJHwoNkoAEaDWZtWjD3U=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CfJ6ZkfHfb46bM6qqXSZiNVQv0zW4Lk6qKaFK01XB2e0XtdbOiezeY+BdiwXDx3OnafCqzdEUJNSlzzCCv0aOud4VTCgEG32UC5md2d2csCC9yHLVUUsVKj3i4LVORTsZTvvcZ+oFFGMMnGTWWfP0Dv3x5wkw4qLkjfAcNlEfMQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=UVaaoPbs; arc=none smtp.client-ip=209.85.215.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UVaaoPbs"
Received: by mail-pg1-f198.google.com with SMTP id 41be03b00d2f7-cbef7b172easo3145290a12.0
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 16:49:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786751361; x=1787356161; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QlrIN2FE+vOMvXseiBIppZAdIzkDPz9iddK1/8i1Wos=;
        b=UVaaoPbsqrV5ch0ZVmXBRc+6nwn8OWS97VXQgVgCHyRF1es8O5mvIp80nCjIhUXpi2
         Kjo77kNN0L+w8iz1WjyR7lxcYokrQtEgj3R4R1n6Hr4DE4XCrqGzfKCLkwZB+xQwWuH1
         9+HMJlKuRW4fPc2DxC+EnpnBGrrrRlGrxCuOtXzjlqSchzQn3iGdMWcONKg/xV9XxNs/
         ePccmBWTFjwkNA8ydXi2gV9IxgXapuS8WwolD4FV3EU/3xVuJXPGauTVFzjipmQ6gLuf
         kphBUOPAmr1ayp55feEGIlSylEO5xN8pZbfTDXGBgrrD6fDlm43tmFEs+zk+osPhpw+z
         2otA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751361; x=1787356161;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QlrIN2FE+vOMvXseiBIppZAdIzkDPz9iddK1/8i1Wos=;
        b=G0IR71s2aslhYcjcAMy5JIETMjVu77der7NpDWO/AaEmWIxh1Rh/d3f7fskNv99w0e
         7wwCvsXCXByLT5xGyGkWl0barIZPOw2F4ChsBFnXwR11e8Ggy7GMVDYCdTW9GX1fW38q
         cjdNLzMUc0CRXMK4c+1UwFndBEowD41hynLu5m6N5JNKydlRTYwNfUhsoVTyRrYQU1o7
         bI4ks2zZvBBiSmReJaXpf7Spiif0cE4X+yWw5dMdw4rfmXncLdEhdKIjy3404HElitaU
         5YF/ULzMv9RZRXnSjAyrUYwr7suVvFr+Ak2hSPiu0jmnCbbtilZ0PPitg/bGIWvP0t3A
         at3g==
X-Forwarded-Encrypted: i=1; AHgh+RqTe0tdGPWKOqSUlnzhu9Vd4aWFlV5q0TORbVU9Qg9qIOcngGAqj2Q2EkZKRpZdEdp1dcTi4Yw=@vger.kernel.org
X-Gm-Message-State: AOJu0YzIyllJSf/s6AxNyKnrEyBSACtjsN/lhrlZA/Af2VCtOXumX8kc
	XixnOY2aNWNhR/ZO1P7eX6I+N9aaqSN9VCwUR3dT7k2qImYqiUsnCUvOndH94v/cg6WlTyudyGd
	WljCBaS3oolZvkA==
X-Received: from pgcm29.prod.google.com ([2002:a63:711d:0:b0:cbe:ddc9:c670])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:350f:b0:3c3:724d:ae7a with SMTP id adf61e73a8af0-3cc71a2975amr12638942637.9.1786751360785;
 Fri, 14 Aug 2026 16:49:20 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:44 -0700
In-Reply-To: <20260814234845.773189-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814234845.773189-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814234845.773189-6-joshwash@google.com>
Subject: [PATCH net 5/6] gve: fix napi_disable deadlock when attempting to
 disable XSK pools
From: Joshua Washington <joshwash@google.com>
To: netdev@vger.kernel.org
Cc: Joshua Washington <joshwash@google.com>, Harshitha Ramamurthy <hramamurthy@google.com>, 
	Andrew Lunn <andrew+netdev@lunn.ch>, "David S. Miller" <davem@davemloft.net>, 
	Eric Dumazet <edumazet@google.com>, Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
	Jordan Rhee <jordanrhee@google.com>, Willem de Bruijn <willemb@google.com>, 
	Ankit Garg <nktgrg@google.com>, Tim Hostetler <thostet@google.com>, 
	Praveen Kaligineedi <pkaligineedi@google.com>, Jeroen de Borst <jeroendb@google.com>, 
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
index 453b304016b6..e084b367a92d 100644
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
2.55.0.691.gc56d675ccc-goog

