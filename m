Received: from mail-pg1-f197.google.com (mail-pg1-f197.google.com [209.85.215.197])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 208794A92D7
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 19:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.197
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790106352; cv=none; b=aQlARZ9um9+0YMZb/qDMcZRpAOmuiuETOki587Gp3yhc93q4C+etAmrthT5pKGoBRa/nCC9gNInax6P5MgY/nNmORVNl2OSSfWJrIVZXOLHh0W5WdTDrdBcxX0je8XHDfKOWdH3nHYd2dDv/MBLVcbjYcoz+7cIzr7a/sUIQigc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790106352; c=relaxed/simple;
	bh=FfCctRadccrhbBiciGBmKdfV1QGWKniOCykBzuPatXA=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=CxH9d6J0m5X5R4hPnWb9gVKrnrRlp1bSXPcdTuWKCwr8ILgqMTXfffvHeteH4gplIbbAp7/hVY2oGK0hTfaaBlxqu27TreoSmKzgsD6KFofpJLKyat5HvfxvXpp+y7KTRaICNQck5eQswWIiyQPpSQTj5nhChzMJNvhdIsQLj38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=eS9JzGm9; arc=none smtp.client-ip=209.85.215.197
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="eS9JzGm9"
Received: by mail-pg1-f197.google.com with SMTP id 41be03b00d2f7-cbb92868263so208562a12.2
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 12:45:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1790106349; x=1790711149; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=2Tr6UXn84setH0JvzM0Q9v+ToB161JXMxDfH+vSeors=;
        b=eS9JzGm9ku21iXaAxvGUZkvoVI71CdlJS7yaaOUt5Frfy7T20LOAPNcxFcgHCMbcCR
         WVjbKD5+4ofgWsDDTGAziq9ciWIH9if8lAX4hj2uE9H17E+W3cW0PlJTQtpEm9kr4Y3/
         9169SDpdBo1ZmodBnr7AqXSb8x70MpeE4+lbObZB3zEBFAbtXqJ5bpiio8CYLCtgX5/j
         +HI0wRIEOVEVOzqSoUONgXq0lbkVofLZbZkj+bLweZpdJ8zfKt8Ptu9gVutNUK+SRwj3
         AH1FOHijiJa6Qw3MeMrNAbHboQNSoWJa5YBYsGBuWB+KV2kPQpwo3LpX5Q09Mhom2Lmo
         QEGA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790106349; x=1790711149;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=2Tr6UXn84setH0JvzM0Q9v+ToB161JXMxDfH+vSeors=;
        b=uIYVeZ4Pz+K6M4wgkPJ7g4+bauQ/S1r95yTgMtDKKxyZTk3zpbFmv67Ir1nlBjDYhj
         xel7LdlvfZxzpWmgVrJiVPkaiddZBwymZxBcbnvz6t22/hZVaMLvJAoCta9HqxFdr+3P
         BUqQi0YEkLueKAgHl+eB+GJaqK0gUL7TRHbOBHyzFPkThDbO5vGxYtYwfSXNnqb0uJGx
         hX9xlaFJDT6vv271dKpjtVKOFVrkq1VmTW5Tm8GkhAmEgMD5kCY1KCYMlhp5jgoAZ/Q8
         3Vq3PlK5EzsXgz3ZG7VxfxPq/RsBRGaO3efNV4zryr23o71lsH1iRDhBstEjIQ1zlQ59
         cjcA==
X-Forwarded-Encrypted: i=1; AKwUvBwnzKIL2qW+o4Mcqus+oUoQBnZSAR97/LTgI0Qbln2F0ciDNizrQowjONg4uUjUT1+ytqP4VPE=@vger.kernel.org
X-Gm-Message-State: AFuF++m2ZiH7rrkQsSBdGgim9rppzUmfgvXrkwR+rorxFTrSgR+R2tUz
	RLpNsiit+m8KJJP11cZkvnFBsF/jabw6b5XD8HPGzR8phA6KFIfKNoaLwmqoaGEmwuZgAa2dDfu
	+gL+tQ3HE2RVvlQ==
X-Received: from pgp27-n2.prod.google.com ([2002:a05:6a02:62db:20b0:cc7:521e:d606])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a21:9101:b0:3dd:a00a:7ac6 with SMTP id adf61e73a8af0-3ddf82c1e03mr444531637.51.1790106349298;
 Tue, 22 Sep 2026 12:45:49 -0700 (PDT)
Date: Tue, 22 Sep 2026 12:45:30 -0700
In-Reply-To: <20260922194533.631387-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260922194533.631387-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
Message-ID: <20260922194533.631387-7-joshwash@google.com>
Subject: [PATCH net v2 6/9] gve: fix NULL dereference from premature XSK pool
 DMA unmap
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
 drivers/net/ethernet/google/gve/gve_main.c | 25 ++++++++++++----------
 1 file changed, 14 insertions(+), 11 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index 3712ff364cbd..49ae2b8c6a27 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1681,22 +1681,18 @@ static int gve_xsk_pool_disable(struct net_device *dev,
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
2.55.0.1082.g2b9226bbc0-goog

