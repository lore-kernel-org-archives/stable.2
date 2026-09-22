Received: from mail-pf1-f198.google.com (mail-pf1-f198.google.com [209.85.210.198])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19FB84AA588
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.198
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106362; cv=none; b=HIixP2Z3KdquOLM5PyHBNybrp/aM+bPy09qVHtP9/JNCgoRMzkQ9B1a53BREciSY5JuK7QDK1bF7F7GSXm5K8nIYaUAA+YTDmNyKMsSa0lmXR1jd4shpkGo3MIT3OqCUdLQB0hy0flTd+z2gMEoulh82JrX+qRsfBgMCkt+F+kk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106362; c=relaxed/simple;
	bh=1EJkBF60HcU/pLER8OktBdGOFBFfB6U9QISFMdwHHNY=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Qw7TvgDN1yUNth4wC4eA9uWOuk+na72dlzvewbPymllPUsvxFfKAIbPLImUuUr6JVUwSJYdYcRRge5eObU8PCBu36VJYk1dB/fleKcMBnW+W2/yZfAA3LM7QTmXHy3BjDRo5fSldXa4SXXECFfGB3N89+brVjXuTjNEYNVnNRg4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=GF2W7ZMe; arc=none smtp.client-ip=209.85.210.198
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GF2W7ZMe"
Received: by mail-pf1-f198.google.com with SMTP id d2e1a72fcca58-86a2639398cso427613b3a.3
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:45:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790106351; x=1790711151; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=lE/2nZUBQE5y8bltkgjlYIgZWN2LasehNWmZI4UlYBI=;
        b=GF2W7ZMeAwEiZhP3ksEcJ62yH4pS4zP1EEIK0gf8m4g04RRqZIVM/71EkmeGSYDXzn
         JpfybL+tDDEYlk82YRhhijL4zqQPD+H7i2pjrJ+BVGu77P2Ho32cdToYBFF1FOsbCVoZ
         46tutafUzUNry0eudlN+6E3LP8sSMIP94cJmddekjYQ0q1V5us2cdgtMoQxQW5AlLUvk
         FNDDQhxt4EXWDsq41yJMd7+bv7LT1Dmd0LE+/j76/+Rk1zoDWZHPkP6uH9C8CdpWK3qB
         jOCMFpOJ0p89eiv7l8Y0Jcj/Pxn0lFIJ85asdFImCLxVgytiNtO24ylqVL6INSwsAbm6
         yzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106351; x=1790711151;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=lE/2nZUBQE5y8bltkgjlYIgZWN2LasehNWmZI4UlYBI=;
        b=T28rhM9S0ZHep4I2IZSqqvRHJN070LTafMhAEM5r4He4KwWknEJ3V+7IY9nPBkAdJe
         nYng/R/4fV0Vx5dzioRVXWZuBCzI3+8XcaX8h6BtmFpr3DsODHELE0TCR1wVaE3hetAW
         tC7O5O4DXaqmmSxiZXK3U11uHGEYUNHCE601QYi//MlgdbWcowtOTu35XtMbfbBsVZF0
         BHbtQtOwc1JOB725SJdGt61uGgpgzuseVZ5SSLwmghX5Ef+S7t667bygrYmgIto4nHf0
         XRO8yCIFf7yysPikGWdso4fSpT1qEiqyistOpy+mOaIASXoFL5NoJO9aArnprucV+SKh
         8oQg==
X-Forwarded-Encrypted: i=1; AKwUvBxb7rpnGfJ0JcXC7UxNS8An6pryhr74kYtHbZAF/WtLTLEFPFKyeEIKW9JVRDHPAqY9+JcPQ78=@vger.kernel.org
X-Gm-Message-State: AFuF++lwWbvi5xsEKMrO4z/R8Z0EPsWUBTARaXinX0IDqjz6+4wKU3gT
	MpRYvAgTTTKf5+l4e70lrMFtWYmAaj7lJ5QqfI1rLMUUNOaq2Uf2KClHqUhcQ7prNyULr0jlk5n
	pVhj5uvwan4F43Q==
X-Received: from pfqy13.prod.google.com ([2002:aa7:9e0d:0:b0:848:5540:2ad5])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:1911:b0:87d:430:1578 with SMTP id d2e1a72fcca58-87d1b8a0852mr683603b3a.29.1790106351015;
 Tue, 22 Sep 2026 12:45:51 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:45:31 -0700
In-Reply-To: <20260922194533.631387-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922194533.631387-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922194533.631387-8-joshwash@google.com>
Subject: [PATCH net v2 7/9] gve: disable NAPI when registering XSK pools in
 QPL mode
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

As a result of QPL modes not posting XSK buffers directly to the NIC,
they do not need to recreate queues or re-post DMA buffers.

However, traffic should still be quiesced because both the driver and
the XDP redirect stack must have the same knowledge about whether a
given packet is being processed with AF_XDP zero-copy enabled or not.
GVE in QPL mode does not current respect this, which could lead to a
race condition between packet processing and the XSK_BUFF_POOL memory
model registration.

Quiesce traffic by disabling the NAPI while the XSK_BUFF_POOL memory
model is being registered with the kernel.

Fixes: fd8e40321a12 ("gve: Add AF_XDP zero-copy support for GQI-QPL format")
Cc: stable@vger.kernel.org
Reviewed-by: Harshitha Ramamurthy <hramamurthy@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
v2:
- newly introduced
---
 drivers/net/ethernet/google/gve/gve_main.c | 41 ++++++++++++++++++++++
 1 file changed, 41 insertions(+)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 49ae2b8c6a27..f2bd4011de23 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1626,6 +1626,40 @@ static int gve_xdp_xmit(struct net_device *dev, int n,
 	return -EOPNOTSUPP;
 }
 
+static void gve_disable_xsk_napis(struct gve_priv *priv, u16 qid)
+{
+	struct napi_struct *napi_rx, *napi_tx;
+	u16 tx_qid;
+
+	napi_rx = &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
+	napi_disable_locked(napi_rx);
+
+	tx_qid = gve_xdp_tx_queue_id(priv, qid);
+	napi_tx = &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
+	napi_disable_locked(napi_tx);
+}
+
+static void gve_enable_xsk_napis(struct gve_priv *priv, u16 qid)
+{
+	struct napi_struct *napi_rx, *napi_tx;
+	u16 tx_qid;
+
+	napi_rx = &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
+	napi_enable_locked(napi_rx);
+
+	tx_qid = gve_xdp_tx_queue_id(priv, qid);
+	napi_tx = &priv->ntfy_blocks[priv->tx[tx_qid].ntfy_id].napi;
+	napi_enable_locked(napi_tx);
+
+	if (gve_is_gqi(priv)) {
+		if (gve_rx_work_pending(&priv->rx[qid]))
+			napi_schedule(napi_rx);
+
+		if (gve_tx_clean_pending(priv, &priv->tx[tx_qid]))
+			napi_schedule(napi_tx);
+	}
+}
+
 static int gve_xsk_pool_enable(struct net_device *dev,
 			       struct xsk_buff_pool *pool,
 			       u16 qid)
@@ -1655,7 +1689,14 @@ static int gve_xsk_pool_enable(struct net_device *dev,
 		return 0;
 
 	if (gve_is_qpl(priv)) {
+		gve_disable_xsk_napis(priv, qid);
+
 		err = gve_reg_xsk_pool(priv, dev, pool, qid);
+		/* Make sure it is visible to the workers on datapath */
+		smp_mb();
+
+		gve_enable_xsk_napis(priv, qid);
+
 		if (err)
 			goto err_xsk_pool_dma_mapped;
 	} else {
-- 
2.55.0.1082.g2b9226bbc0-goog

