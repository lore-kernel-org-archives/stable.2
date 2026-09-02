Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79123537C8
	for <stable@vger.kernel.org>; Wed,  2 Sep 2026 01:57:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788314247; cv=none; b=JiUiFt516cidbH155opmZTaNBKUi8VJOTH5Y9z5cjkl5EIkNRlhOSOo49THvmnrxtF9sHY9ck+6lx6iBbHyCnDwNdXHOvV3L3EmYpZL6qZHykyhYfhZc+Vbwxd37z93cmGe7mqdyqK+uLKNZcqY3YmZO2OevplvMSMqFh5KZyxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788314247; c=relaxed/simple;
	bh=bMFLT2hd1hgF7+PT38bLPmDwKJnBhytafbJhxitvRbU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cutkUdg5PFBFqGCA/ATIwvPJhgysdDncd3c8OSZKBjYdOkYsZkHtZTCQSm3BpX1OAsPvRk3LFZPNKJldpNSC7bfyFdI158FKzzQJ1gowRJ6K7yELuhBQRI80JjT8KFwbaHH2g81e61Ahtq3Q0FM7IlLVmPu0mGijLiKGq2vOOcY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=hnlTxdUa; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="hnlTxdUa"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-cc1e1ff659bso582067a12.0
        for <stable@vger.kernel.org>; Tue, 01 Sep 2026 18:57:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1788314237; x=1788919037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=24B4a/9ThhnK86I6tiKZdFQ0uGyx0+7AN1IThAG1aFQ=;
        b=hnlTxdUaTABgt+Dr91k5xaxbTnzqZ8WafnMaUN5j3D3qizjd31MAQm/cw9uxXbxZr9
         Dv4pc4BmOA6csckTPVE3NnGxDZlMuG1kPiJhto7zK6f6YBfDmMcJZk494afI4uMtuX4o
         JH00h785k62lgBIG+IpZwFLZ2tfkfgefsvqPCUUjj8nRLOapdFWTumTHctueqhk4kWgz
         uaL0V/46xdxs0Ia6jp3Z+zPhT+atgmyn0sovgZA8lhCxjlx6cDWcKeATaQ2lt5XEAwAX
         cbBQ4jty4Vq3HjI4s6ArUCZuOXLgIzM+DVpY5XcG0bXAB5CF06Jn6WIZO5UPbBz7O7ej
         gjrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788314237; x=1788919037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=24B4a/9ThhnK86I6tiKZdFQ0uGyx0+7AN1IThAG1aFQ=;
        b=Tmg1u/Tp03AIiOFxSJOoZSLUCxW+ws277xTXrDSHqGxIFsl1ZG5D9LB5Z6y7dEVfU4
         1k65hBR/1GeK0IBB0/WgB3xgTIJ5RnouQB2Zt0uAyhfoPVeBgEQ08vfXqxaI/wFFMdCE
         ZhXKK1YvtOr+x4IGl8Pwmzo7WxYAgXZz2IiTeRql5H0biqhtXka3Uz+N0znRAPUxryOA
         AQdWH1X35O8MXDDHkdiVE+xvF0FvzkYxQGD+R1jMIfWsmX1Bzsi06l9btTYJMY6TE5Eu
         DZbCK5cOxB2WLmVOR7ihO+WPC+y3SEExzPUG+ZhkRlU+O9qET45DyIssUmXw8o0tgT7h
         qB+w==
X-Forwarded-Encrypted: i=1; AKwUvBxvH4qWJv40l63uhmO2tcCm05PLIZoXQLv/KwA2JYZTZmGYxLIwB8w3fkH1mBqdtiUINPC+kM0=@vger.kernel.org
X-Gm-Message-State: AFuF++mPmrSlhEprJeX190D1yRuulV5Pl/+Ou8k7Tvkua3XOUuIblLDP
	sUS1b6nT6XY4VRcMt4Jv5Z1mfMVOfyKgZdTCxqhtHS48wvosod/dntqH/oyBuCnRnH8=
X-Gm-Gg: AYBFou1Ky9jkrci3caFRml+BzJIjY+lckWuDqymww8t/MDcxvyE0aC1edhWAmC2lRBT
	gstqnIMjIlLRd9S0lC/ICxH2wjJZx2Uzj3HAStg1rTFWHFPHZKmB58usjIxgozsO/BVgS0aL1Ya
	MILeg4PYLIHYeGwiBRiivY7Gfvxn34pqzOf431+Pl+eJ7jWjEZLuV47dwm8udhZ1yeyafx9wlj3
	IhM7oSkVJ6wsxSyWyfYn+naoRW557qLQ+iPF5jHqQFGIn5aeslxN7h+8w3FUqZwCy1M8D/YE24g
	3W5CUA7Q5WDREJU7M+LmUAX9caoYpv6N5w44dmks1+xEC41OP6a75+1l9T1zz50bUq1z1U1INoO
	wSvLFV9uvHj4uR1HXGd4/2RAcvnUorzW6VB908yZX4BnyifL/gWuZ37IdMuryxrKHUnFIKeYOQP
	+NeCTPgnPpwbaVZMrjPJhgl3rY/vWsQD14Y38Yl/KbiA==
X-Received: by 2002:a17:90b:4b89:b0:398:c3ca:1ebc with SMTP id 98e67ed59e1d1-39aee105a46mr1643584a91.18.1788314237407;
        Tue, 01 Sep 2026 18:57:17 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:5a::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39ae0dfeff4sm2473024a91.4.2026.09.01.18.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2026 18:57:16 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	David Wei <dw@davidwei.uk>
Cc: horms@kernel.org,
	kalesh-anakkur.purayil@broadcom.com,
	colin.winegarden@broadcom.com,
	rukhsana.ansari@broadcom.com,
	linux-kernel@vger.kernel.org,
	raphaelcf@meta.com,
	Joe Damato <joe@dama.to>,
	Sashiko <sashiko-bot+sashiko@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH net v5 3/6] bnxt_en: Propagate TPA buffer allocation failures in bnxt_queue_mem_alloc()
Date: Tue,  1 Sep 2026 18:56:46 -0700
Message-ID: <20260902015652.2421609-4-joe@dama.to>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260902015652.2421609-1-joe@dama.to>
References: <20260902015652.2421609-1-joe@dama.to>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

bnxt_alloc_one_tpa_info_data() returns -ENOMEM as soon as one allocation
fails. This leaves the remaining rxr->rx_tpa[] entries zeroed.

bnxt_queue_mem_alloc() discards that return value, so the partially
initialized ring is installed by bnxt_queue_start().

Since the agg_id is picked by the hardware and bnxt_alloc_agg_idx maps
it to a SW index in rxr->rx_tpa[], it is possible that an uninitialized
slot can be chosen which would hand a zero DMA address to the device.

Fix this by checking the return value of bnxt_alloc_one_tpa_info_data
and unwinding, freeing the ring buffers.

Fixes: bd649c5cc958 ("bnxt_en: handle tpa_info in queue API implementation")
Reported-by: Sashiko <sashiko-bot+sashiko@kernel.org>
Link: https://netdev-ai.bots.linux.dev/sashiko/#/patchset/20260828190900.1767611-1-joe%40dama.to
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index f44a23c8a590..3755a30f8d40 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -16378,11 +16378,16 @@ static int bnxt_queue_mem_alloc(struct net_device *dev,
 	bnxt_alloc_one_rx_ring_skb(bp, clone, idx);
 	if (bp->flags & BNXT_FLAG_AGG_RINGS)
 		bnxt_alloc_one_rx_ring_netmem(bp, clone, idx);
-	if (bp->flags & BNXT_FLAG_TPA)
-		bnxt_alloc_one_tpa_info_data(bp, clone);
+	if (bp->flags & BNXT_FLAG_TPA) {
+		rc = bnxt_alloc_one_tpa_info_data(bp, clone);
+		if (rc)
+			goto err_free_rx_ring_skbs;
+	}
 
 	return 0;
 
+err_free_rx_ring_skbs:
+	bnxt_free_one_rx_ring_skbs(bp, clone);
 err_free_tpa_info:
 	bnxt_free_one_tpa_info(bp, clone);
 err_free_rx_agg_ring:
-- 
2.53.0-Meta

