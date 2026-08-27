Received: from mail-pj1-f43.google.com (mail-pj1-f43.google.com [209.85.216.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31A563D9025
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 23:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787872166; cv=none; b=rBgUFEaNzlrdMd0jhF3TmiIp7JaHhCi2vAqS89Qf/nVC1L6LwCEh0IBbYXDLVwvjyLRpqdFbWTjn4mCKSx2f7goAKpNlsvHbaFD5DgsACBpYe2l0V15nAZIQjdJ1svmV31i4OcsxD8unzbJdnmnHFgng5D+7zC4rXS5cLIo1NiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787872166; c=relaxed/simple;
	bh=F2UZJlMMS1z+wb83vDqhiFHVbBPpvdXotCfJmtzy8Ys=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ZKutb43mVUCi/lSOtYLsKuvsxXmNqkq4wauSTOIYCrL21YUsAjdsLp6huYKvumEVr1Syyn+a3ecV8NEYZWxtmQ9/SEKhAM/4lWge4BPwr8CyStjXqIitN0Yyrj+LYQsUkZkBmAbeW9CZtToB/NVmo7nErfBqJmDkD1FVmSqWnfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=0b7IUrIX; arc=none smtp.client-ip=209.85.216.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="0b7IUrIX"
Received: by mail-pj1-f43.google.com with SMTP id 98e67ed59e1d1-383b4a3755fso572559a91.3
        for <stable@vger.kernel.org>; Thu, 27 Aug 2026 16:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787872164; x=1788476964; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=BkcA6upgwNOh6KQOWDQ2Abt6vcWyEOX5gxtQcZYTRGE=;
        b=0b7IUrIXfdwR9/gwBxQ9Z8yUtV5E5a+WJQVNljdJp3gXJxWGp0f4ShgQjRyO8+jte1
         fBVJpL6QAb9m3AtXRUtnN0qwIk3H+sixPmfGn53ZK+5NYnQAVOdGeutwl7sHTdF3dzD+
         BL4cnV124XXCQku/yW329O2BXTWlvmGaDNmSU957iRnJI9561j7iNiTcd1QaZaCOrL8K
         KfjBi38rcpr+UlDVCK1kKb9Ya4EAxcPGLBuA9L9P1DZ28tPtxvTPoUb9/KbjT3D1K/iF
         UlbIZndIzzpJW0YacMlZQaYHI+LWV/Xsfi10Iy8JVp2taYwINTuZy3QYSa1umheNb1f7
         r/jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787872164; x=1788476964;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=BkcA6upgwNOh6KQOWDQ2Abt6vcWyEOX5gxtQcZYTRGE=;
        b=hbYRvNmYi7UqAFbcbYdpvN1b78OGAbfuaf97RMhMjWji/dzOZ+2A9DzQRzB2PF2cet
         hH50JUTw913ZBShfnGFdDbhPx1S6xEE7qZa1Nr7278kNaUxxLsNFuccWbGaiEhmx9dt+
         8Kfw9WZEibS8ZWDQyRps+NqPHSfdlkHFqAqWP0wGqHmNexQCCNjLBF2Wnxeb944JltVJ
         Xn2H3TMxEHoCrFYHQ1sjxPpZdb9dWjUWp6mmQcQVo4/x9OgzrXByym5MoFc/iI3Ll8d1
         oh2dWmCHkrWZrF+4UC3NjuD3tq5DTkW4qGf8BCc65SwSKK8sAxE4WL6dbCh5Q7alClSp
         ZFqQ==
X-Forwarded-Encrypted: i=1; AHgh+RoaUN53ToGHWTDIzNDLKwfniYV9C7KQt2vOjRwNA3zwOfDJvWEohFLrtX5MVZPj+0UDDmuSywY=@vger.kernel.org
X-Gm-Message-State: AFuF++n3ZyzsStItXFVdbB4QSbH2CNdQq2vmR5iLnNwdWrw7R/ykNuBd
	3KF5nmzU8x0kkrsfxe+FsFhPKs22p+UvsK+BRiBF/kwv3qmZxs+pDSJ/WyXAgnd82vo=
X-Gm-Gg: AR+sD10qfZg1nzVPoBYYLW07oSw3Y2SDUsDKNKCXvWoByxSYoa9QqKFQ6jthyrRO6v+
	hKhH5FfS6SXzKjgGEqh0a9WuPiuxQk1EK0hHPUYWV04dT/Vd665Uu+9hxNDbjRxHbtgE40c6erD
	tzr872mkiJAeDnrq4o2oTSbz0FC9EtbGd1zWvdROsK0az4a7ZKBUTagciXwXLdC7D4Wul840nG4
	SuazP6zrRBkcimr4UTEQzkhsPvVoyryJAvpCqm0e9bAsH1WhEja25tY94oGxR6c8VMZEJGf+60p
	vuV59y0YuBkNeKr7/If7s2LHVnj4nV+YywDhTza42viJ5SaCbRlnjLJ05Cy6J9cFUBdmlRSusWs
	E3GJ/iLUXxBWpJRFsFVBeLNFojfQQF+mCRdd32h2+Hi5Pw3MqdPRSuW4EWUiVngtf203Q1ZgUxD
	/L+6vpe3NQA76rNzq48PL+qcSai9BwLdaFx2Sw6zGdhCo=
X-Received: by 2002:a17:90a:fc4e:b0:395:5eec:b932 with SMTP id 98e67ed59e1d1-396d0f8fdbemr5292536a91.11.1787872164320;
        Thu, 27 Aug 2026 16:09:24 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:46::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-396b186809dsm4603303a91.10.2026.08.27.16.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Aug 2026 16:09:23 -0700 (PDT)
From: Joe Damato <joe@dama.to>
To: netdev@vger.kernel.org,
	Michael Chan <michael.chan@broadcom.com>,
	Pavan Chebbi <pavan.chebbi@broadcom.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Joe Damato <joe@dama.to>
Cc: horms@kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH net] bnxt_en: Prevent queue stop with deferred completions
Date: Thu, 27 Aug 2026 16:02:32 -0700
Message-ID: <20260827230233.94878-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the driver receives a burst of packets, it can mark a BD with the
NO_CMPL bit to defer completions. The expectation is that the last
packet in the ring will have this bit unset and the completion generated
by that packet will cleanup that packet and the ones preceding it. This
helps to reduce the number of completions fired.

The suppressed completions are controlled by the driver and the number
of packets with suppressed completions scales with the size of the ring.
SW USO packets, on the other hand, have an upper bound on the maximum
number of BDs which can be consumed which does not scale with the ring
size.

So, for small rings it is possible that: a burst of packets is handed to
the driver, the driver defers completions for all of the packets because
the number of free descriptors stays above the threshold in the driver.
Then, a USO packet arrives, but the number of BDs available is not
enough and the USO code exits early with NETDEV_TX_BUSY.

In this case, you end up in a state where the ring is full of packets
with their completions suppressed, which can cause the queue to stop and
never be restarted.

Assuming default CONFIG_MAX_SKB_FRAGS, this is only possible for small
rings (<= 457 descriptors, below the driver default value) when
a burst of packets fills the ring, followed by a large USO packet that
can't fit. For larger rings, the delta between the completion
suppression threshold and the BDs required for SW USO is large enough
that completions will fire and this case is unreachable.

This issue was pointed out by Sashiko and while it seems fairly unlikely
given that the queue size must be small to trigger this, it is indeed
possible.

Fix this by tracking the last BD which deferred completions. If SW USO
exits early and there is a doorbell pending, enable completions for the
last packet in the ring with disabled completions. This ensures that a
completion will be generated and avoids stopping the queue with no way
to start it again.

Fixes: cc5d90667db8 ("net: bnxt: Implement software USO")
Cc: <stable@vger.kernel.org> # v7.1+: 4e15e89faac9: net: bnxt: ring the doorbell when SW USO exits early
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  1 +
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c | 17 +++++++++++++++--
 3 files changed, 17 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index d59bcca73a2b..8ab5acd5bee6 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -757,6 +757,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 		if (free_size >= bp->tx_wake_thresh)
 			txbd0->tx_bd_len_flags_type |=
 				cpu_to_le32(TX_BD_FLAGS_NO_CMPL);
+		txr->kick_prod = txr->tx_prod - (last_frag + 2);
 		txr->kick_pending = 1;
 	}
 
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index ab894f8addef..e2fa90740d61 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -993,6 +993,7 @@ struct bnxt_tx_ring_info {
 	u16			txq_index;
 	u8			tx_napi_idx;
 	u8			kick_pending;
+	u16			kick_prod;
 	struct bnxt_db_info	tx_db;
 
 	struct tx_bd		*tx_desc_ring[MAX_TX_PAGES];
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index f7e18bea0fb8..f9bf77bffea7 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -69,7 +69,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 	if (unlikely(bnxt_tx_avail(bp, txr) < bds_needed)) {
 		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),
 				   bp->tx_wake_thresh);
-		return NETDEV_TX_BUSY;
+		goto tx_busy;
 	}
 
 	/* BD backpressure alone cannot prevent overwriting in-flight
@@ -77,7 +77,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 	 */
 	if (!netif_txq_maybe_stop(txq, bnxt_inline_avail(txr),
 				  num_segs, num_segs))
-		return NETDEV_TX_BUSY;
+		goto tx_busy;
 
 	if (unlikely(tso_dma_map_init(&map, &pdev->dev, skb, hdr_len)))
 		goto drop;
@@ -235,4 +235,17 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 	dev_kfree_skb_any(skb);
 	dev_core_stats_tx_dropped_inc(bp->dev);
 	return NETDEV_TX_OK;
+
+tx_busy:
+	if (txr->kick_pending) {
+		u16 kick_prod = txr->kick_prod;
+		struct tx_bd *txbd0;
+
+		txbd0 = &txr->tx_desc_ring[TX_RING(bp, kick_prod)]
+					  [TX_IDX(kick_prod)];
+		txbd0->tx_bd_len_flags_type &=
+			cpu_to_le32(~TX_BD_FLAGS_NO_CMPL);
+	}
+
+	return NETDEV_TX_BUSY;
 }

base-commit: e2a6641e3bfde58f2284f9859c2b0fdcc6d1c0da
-- 
2.53.0-Meta

