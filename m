Received: from mail-pf1-f199.google.com (mail-pf1-f199.google.com [209.85.210.199])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03C7A3E314A
	for <stable@vger.kernel.org>; Fri, 14 Aug 2026 23:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.199
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786751365; cv=none; b=c8uePj/8ogy+J36/50rDRf2TtbXosdYsfhsmZ+nZDzGNgnqqbaoNStQgRC8febVG7mRnuoMNe6sT66M4Ql/1LkEFTiyIBsCEn43gAEeajqrxxY90znNuRCFfk93wdjnnF04Pk0UnZtMlPhBWcjvuX30wCd0/gN0J9onpdl01ljI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786751365; c=relaxed/simple;
	bh=/ECkwXTcbS/nrl8o0PNyBOTEnaTt4kJMaOMMUVKH7IE=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=LI2RtLde6QXN2aQcCw7cT36+Y0qTzxKVHtEOhFcj9PSkT829Nc4Pelcp7VwgON9eZ6pafKWVOPrTCCXPYystRmdvl+sdAKmCxgHzMjRtfikM4ZZS3nYG9asurbD7hkduCTJSLVZXflEcS2q2oeJf+QqpcIIGHf2eyzEwMnil6/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=tgDEd7KH; arc=none smtp.client-ip=209.85.210.199
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--joshwash.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="tgDEd7KH"
Received: by mail-pf1-f199.google.com with SMTP id d2e1a72fcca58-8485d853b08so2261129b3a.1
        for <stable@vger.kernel.org>; Fri, 14 Aug 2026 16:49:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1786751359; x=1787356159; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=Nj+GAK80Vf0LtjqMeVaepRws/HUe3sjBCweZwIjqkZ0=;
        b=tgDEd7KHYjeQu+VsJLq06dlX9H1wiZaOhcJChoNHiN+02KEUdrayjaa12rNbt2erZm
         gY5hbxKLmkdcKoS813c+PjztaccHq6biPGAlx/jNtKzmABLDE8c7WcNOXQZC/ni7hBPO
         pU3u/pgQOipyU79vhH/I8fQntF8ZYYc7+/C3QCG9juag2Uz7kyp3rXRy55QNjW2hQQZt
         rxDNA3miGierylYJeiCRsSmXdXzQSmCsh6mKzZifprkqliPkTBDwnv8Upc88axtHDyVY
         KKEEJfWU81MzHJ7JJPu4+XuJRWdSRPHPUeI9UuTn9MDiIPQ9bUNKvgGp2i62SLKmSoiq
         ZZVg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786751359; x=1787356159;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=Nj+GAK80Vf0LtjqMeVaepRws/HUe3sjBCweZwIjqkZ0=;
        b=Ubjb+oHJG8d5RdOWbd7ZVd8AQBlwo4xxhd6kjCiluAX/B4RMEGSsQfdt4jyvE1HHbr
         mqx3SlpSDRolcrjY8zpjjdsZ0jScWu88r+7Vc+7C5GNG2wXM5vDID56qo8CXHFFB8qZz
         EU/eUoHSXZIH6/Wld+Q6iKDrdH80Hss4xl9H8ivb6f9bTRy3YyJn5WHIJvVXM9pTZ5CU
         kGRXOZUR2LIU56o8z2NqaMqYqGCkg2hgqkINCV1a+RH2EOZN4etrH10ihNki4y9uy7dX
         mbsUHeD4LMsOY28zmn07JsZxLnUXavFiU43zGxxXp7SRDXkNDkruLXuqIJdgl2lKPsIY
         Iw+Q==
X-Forwarded-Encrypted: i=1; AHgh+Rr2vH8LRX9Bb7a0Myr3M9Q5L3DkKowskSQCBiAPdqVdBECEt6RRiIPl7VqbmINPFdaIa4Ai1zo=@vger.kernel.org
X-Gm-Message-State: AOJu0YyPf7zcTV86fGEZgx82XIfh9kDUs+DXVy63spWrslRnsenhAzt9
	AlaUrO4hf+BBy1hEX1savPFXmbGvFc3iUeB6iSSA4vjbLw3kvp3Z+/cUhaSiOu7A3E9KaVYGzfz
	dWBCt6gUle82KPw==
X-Received: from pfes10.prod.google.com ([2002:aa7:8d4a:0:b0:848:4642:f1d3])
 (user=joshwash job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:6a00:3ccf:b0:845:40d1:87fa with SMTP id d2e1a72fcca58-84fde20e2a4mr9752920b3a.25.1786751359066;
 Fri, 14 Aug 2026 16:49:19 -0700 (PDT)
Date: Fri, 14 Aug 2026 16:48:43 -0700
In-Reply-To: <20260814234845.773189-1-joshwash@google.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260814234845.773189-1-joshwash@google.com>
X-Mailer: git-send-email 2.55.0.691.gc56d675ccc-goog
Message-ID: <20260814234845.773189-5-joshwash@google.com>
Subject: [PATCH net 4/6] gve: don't register xsk pool on pre-existing queues
 in RDA mode
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

When XSK pools are enabled after an XDP program has already been loaded,
XSK pools are registered on pre-existing queues before queues are
re-created with the XSK pool fully registered in DQ RDA mode.

This can lead to a race condition between the RX NAPI and the control
plane thread wherein a pre-existing queue sees the live XSK pool and
attempts to use recycled buffers not backed by XSK buffs for AF_XDP ZC
traffic. This causes the following kernel panic to occur when attempting
to DMA map a NULL XSK buffer:

BUG: kernel NULL pointer dereference, address: 0000000000000050
...
RIP: 0010:gve_rx_post_buffers_dqo+0x99/0x190 [gve]
...
Call Trace:
 <TASK>
 gve_rx_poll_dqo+0x4d9/0xf10 [gve]
 gve_napi_poll_dqo+0x76/0x170 [gve]
 __napi_poll+0x28/0x160
 net_rx_action+0x2a0/0x350
 handle_softirqs+0xd4/0x280
 ? sort_range+0x20/0x20
 run_ksoftirqd+0x2d/0x40
 smpboot_thread_fn+0xd5/0x1d0
 kthread+0xd7/0x100
 ? kthread_complete_and_exit+0x20/0x20
 ret_from_fork+0x1f/0x30
 </TASK>

The XSK pool should only be registered with current queues if XSK
buffers are allocated on-the-fly, as is the case in QPL mode.

Fixes: c1fffc5d66a7 ("gve: implement DQO RX datapath and control path for AF_XDP zero-copy")
Cc: stable@vger.kernel.org
Reviewed-by: Jordan Rhee <jordanrhee@google.com>
Reviewed-by: Tim Hostetler <thostet@google.com>
Signed-off-by: Joshua Washington <joshwash@google.com>
---
 drivers/net/ethernet/google/gve/gve_main.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/google/gve/gve_main.c b/drivers/net/ethernet/google/gve/gve_main.c
index e4d78ae52daf..453b304016b6 100644
--- a/drivers/net/ethernet/google/gve/gve_main.c
+++ b/drivers/net/ethernet/google/gve/gve_main.c
@@ -1654,20 +1654,18 @@ static int gve_xsk_pool_enable(struct net_device *dev,
 	if (!priv->xdp_prog || !netif_running(dev))
 		return 0;
 
-	err = gve_reg_xsk_pool(priv, dev, pool, qid);
-	if (err)
-		goto err_xsk_pool_dma_mapped;
-
-	/* Stop and start RDA queues to repost buffers. */
-	if (!gve_is_qpl(priv)) {
+	if (gve_is_qpl(priv)) {
+		err = gve_reg_xsk_pool(priv, dev, pool, qid);
+		if (err)
+			goto err_xsk_pool_dma_mapped;
+	} else {
+		/* Stop and start RDA queues to repost buffers. */
 		err = gve_configure_rings_xdp(priv, priv->rx_cfg.num_queues);
 		if (err)
-			goto err_xsk_pool_registered;
+			goto err_xsk_pool_dma_mapped;
 	}
 	return 0;
 
-err_xsk_pool_registered:
-	gve_unreg_xsk_pool(priv, qid);
 err_xsk_pool_dma_mapped:
 	clear_bit(qid, priv->xsk_pools);
 	xsk_pool_dma_unmap(pool,
-- 
2.55.0.691.gc56d675ccc-goog

