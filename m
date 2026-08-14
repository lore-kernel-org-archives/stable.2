Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com [209.85.210.200])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65D6E3BCD15
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 23:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.200
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751366; cv=none; b=lXNT27vIn3/Qc4VQCnOZk3rMPSldvo9CgOdUEw7+nI1439Wxy2LAw2Jdm0BL1WsYx1QxM/hd0/3i7n3gc2BzYnTPzwdsS6znmzPsNVxMTs9isYamHjTAS52tbZAG9oBxV5kMJZEuvTdjsGYpx//TdwnN5uiTqgLFy3Z7Brx5wJ4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751366; c=relaxed/simple;
	bh=bkqjE8H5yLsZzATIYsHOfEIXGXzmrV039SYCCUNAerQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CEfSsSuwie5+h4mAcAMWKsZBqNXFVRGAy0SN+HreFchxYaHRE90DZnXMBJpAe7KYLRWkLZe6NbhAi06qDqhLP9KTCJ+pvRH9AqEq/urRfeDTe+mXPL2aJYz+oZj/es/hqqabJzdInJ9K90c8sR1iTbIF2sLvwRjxnnJFFwCnI7E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=bHCdyhQW; arc=none smtp.client-ip=209.85.210.200
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="bHCdyhQW"
Received: by mail-pf1-f200.google.com with SMTP id d2e1a72fcca58-84fb5376cb8so1799177b3a.2
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 16:49:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786751363; x=1787356163; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=QIhn3gnxRLM65UuEQqpJlwUN/Y3dZ7RL7buNA7bnsTY=;
        b=bHCdyhQWUHNaZY9a4NHf1W+9G4LZ9K1zlVlUQ69CxObm+rBVovJAhrkGgxUVPjp4g8
         0wxFcvrIDdt4xYdBTUxUOlHtQATM6EGBtLSkmi3FfQ29wY2H330eDl3UPqYdspOX31HW
         xi3tSxYqI1tKwZniUI1f6OuieboWS52NdUPZLpUwt6CMt/nyu6zC0thUdHiMUqC4t4UK
         b2EEUiOFY01J7XoQbHGn8yuauXrD2mJt5PhJ0DQJ+idibY93rGJm+K+MRlh5t5ncajuE
         37DPaoJIOBlS83R8wPPnQhiKWBMNtKeVgqyE+1pIVQwQWKA0Rb8wyBtgipk6trlfuDLJ
         ILrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751363; x=1787356163;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=QIhn3gnxRLM65UuEQqpJlwUN/Y3dZ7RL7buNA7bnsTY=;
        b=FT9xz7pG7vvz4JPdFhumqPtiQ6OOIJke1zCuZPxH3P7zl4iCwLF8bNMNvVlgDnus3n
         PcYZgYKZOR/L6yZiQalKfXmEq5mI4aWddbdFnwH6EfDvxQBInJjwpxKj9gElXUJMhasC
         u0zuFPwZA/XTF2kBzuCVAuCBwvcURQd8QqkeSBdbcJy97eGNd95QWb8dGvpaxxsCgfKg
         OS26k+ieHeDbmhjickR1B9CIbixpXLesc7WEIOf9+gy9bKNe+JlI7c1noze5DQkSc2ER
         MguAVZz13ziVyPNO33Xfd8J5GzqoR03kSPEh9AlUmzX1LbXsgbQKgtDTBcOF0HoAeeQh
         DU8w==
X-Forwarded-Encrypted: i=1; AHgh+RqFaZADqBfEID5nuldwbzmbmbVkLstHJSYKGIQDoas+UgiPpNhgv4VZ7+5Y1fayYpydpSU5PaQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yyw3lDimUrHBptAkJ+t7Iu8aibd2al+i6ugkr3raVuJ+IRtorTW
	hqpDKijPvJcPkVeYZxgmey4PuT0dTImXLFrrd+XkEby9JjYXNz3FWRQA7PsgmP5fJ8nqxMUVjso
	13EKeo+kw0qsZbA==
X-Received: from pfbfq10.prod.google.com ([2002:a05:6a00:60ca:b0:84a:3bc9:3bcd])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:2d86:b0:848:2c6c:dfe3 with SMTP id d2e1a72fcca58-84fde00dea1mr8295276b3a.17.1786751362579;
 Fri, 14 Aug 2026 16:49:22 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:45 -0700
In-Reply-To: <20260814234845.773189-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814234845.773189-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814234845.773189-7-joshwash@google.com>
Subject: [PATCH net 6/6] gve: fix NULL dereference from premature XSK pool DMA unmap
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

To ensure that XSK pools are DMA unmapped in all scenarios, GVE performs
the unmapping before validating if the interface is up and early
returning.

However, if rings are up, this introduces a race between the RX NAPI and
the control plane. As part of DMA unmapping the XSK pool, the kernel
sets pool->dev to NULL. Because xsk_buff_dma_sync_for_cpu() relies on
pool->dev, this results in a kernel panic:

BUG: kernel NULL pointer dereference, address: 000000000000030c
...
RIP: 0010:gve_rx_poll_dqo+0x2e2/0x13b0 [gve]
...
Call Trace:
 <IRQ>
 gve_napi_poll_dqo+0x88/0x170 [gve]
 __napi_poll+0x30/0x210
 net_rx_action+0x210/0x410
 ? dst_destroy_rcu+0x12/0x20
 handle_softirqs+0xe4/0x310
 __irq_exit_rcu+0x10e/0x130
 irq_exit_rcu+0xe/0x20
 common_interrupt+0xb6/0xe0
 </IRQ>

Leave the XSK pool DMA mapped until after rings are guaranteed to no
longer rely on the pool.

Fixes: d57ae093c887 ("gve: deduplicate xdp info and xsk pool registration logic")
Cc: stable@vger.kernel.org
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 27 ++++++++++++----------
 1 file changed, 15 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index e084b367a92d..ccaf5f86a1e6 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1681,28 +1681,24 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 	struct napi_struct *napi_rx;
 	struct napi_struct *napi_tx;
 	struct xsk_buff_pool *pool;
+	int err = 0;
 	int tx_qid;
-	int err;
 
-	if (qid >= priv->rx_cfg.num_queues)
-		return -EINVAL;
+	if (qid >= priv->rx_cfg.num_queues) {
+		err = -EINVAL;
+		goto unmap_and_return;
+	}
 
 	clear_bit(qid, priv->xsk_pools);
 
-	pool = xsk_get_pool_from_qid(dev, qid);
-	if (pool)
-		xsk_pool_dma_unmap(pool,
-				   DMA_ATTR_SKIP_CPU_SYNC |
-				   DMA_ATTR_WEAK_ORDERING);
-
 	if (!netif_running(dev) || !priv->tx_cfg.num_xdp_queues)
-		return 0;
+		goto unmap_and_return;
 
 	/* Stop and start RDA queues to repost buffers. */
 	if (!gve_is_qpl(priv) && priv->xdp_prog) {
 		err = gve_configure_rings_xdp(priv, priv->rx_cfg.num_queues);
 		if (err)
-			return err;
+			goto unmap_and_return;
 	}
 
 	napi_rx = &priv->ntfy_blocks[priv->rx[qid].ntfy_id].napi;
@@ -1725,7 +1721,14 @@ static int gve_xsk_pool_disable(struct net_device *dev,
 			napi_schedule(napi_tx);
 	}
 
-	return 0;
+unmap_and_return:
+	pool = xsk_get_pool_from_qid(dev, qid);
+	if (pool)
+		xsk_pool_dma_unmap(pool,
+				   DMA_ATTR_SKIP_CPU_SYNC |
+				   DMA_ATTR_WEAK_ORDERING);
+
+	return err;
 }
 
 static int gve_xsk_wakeup(struct net_device *dev, u32 queue_id, u32 flags)
-- 
2.55.0.691.gc56d675ccc-goog

