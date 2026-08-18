Received: from mail-pl1-f179.google.com (mail-pl1-f179.google.com [209.85.214.179])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49BEA2D0614
	for <stable@vger.kernel.org>; Tue, 18 Aug 2026 21:15:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.179
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787087752; cv=none; b=BmRUCF9cuWAo8N+lLDSo+6BNerGgp948rYjQgfjRdcD75p4PDvGde+Q1ldMmGOyXr/gEzUvHmiTOD7A3YuHR2L12IU2fWP7pUgyYq5MYIbD0gT7c9lCOOztRv59yNh4BvPE6GxtWpcAmTaQ0pEUvVahNr8FpXM318ELrhvhoXec=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787087752; c=relaxed/simple;
	bh=zzohzy9JWobljyd6RsmmbQ2VwiVvckUNzXlvTlatJfM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XIRw7HmGSa0p/pUugZ5cgXpFBHiegCmjnB+xQyh8kOySopWvsZttB9/1pfc0S2qrLdwe6KTI/+S/MeYwTdBwpa9gDbydaY0tl39SWEbk2QdLBOUy5Swe8O5pLr3AZ3xmzwql53gMbeT1mQEjrOv/ADgJsegFJsKgOlxFNDoT7p4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to; spf=none smtp.mailfrom=dama.to; dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b=mOGSbzKq; arc=none smtp.client-ip=209.85.214.179
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=dama.to
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=dama.to
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=dama-to.20251104.gappssmtp.com header.i=@dama-to.20251104.gappssmtp.com header.b="mOGSbzKq"
Received: by mail-pl1-f179.google.com with SMTP id d9443c01a7336-2cc61541f8cso17345915ad.0
        for <stable@vger.kernel.org>; Tue, 18 Aug 2026 14:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dama-to.20251104.gappssmtp.com; s=20251104; t=1787087749; x=1787692549; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=shTsftA/wYts9OPD5P3iDM+SEC7l1+GSIH4cvo8toIA=;
        b=mOGSbzKq3b1fKLfHAT7GR9mh1XP1b6xZiUDSa+TnccN6JHvy06Kgps9mnhVBTgMyDe
         z/MpNkU/8X7N0OZOLM1tums5PG3/HqxUq8WfxjK0lj0gE2+ioz+5uStH/QotByXUxcU3
         lihV2pRjPmJQGzHJsfyvs+QyWiPOB38KcZAY12hH+PR2BnVszdzjwd0Wh5n4NxeI2hLO
         Red7pQN30tudoMYc7b6mavbydXDOjSz5MIPLR9cs+v0DDnWBbqsmAnrXnII5bM6kwG2v
         Dj8bwzxwTavRIP1a0/8MC0R2imeNvBXiOC+njypk8l7K6meH3S998QV7w3maOorgIgMz
         LlXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787087749; x=1787692549;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=shTsftA/wYts9OPD5P3iDM+SEC7l1+GSIH4cvo8toIA=;
        b=KDcL5OMpN1CRnCsACg0ZDZ9iBLRfAa7W0Jw/OZchZQXsdVNfdIU5Nm93IXDHau1BZQ
         3v9l1yvbwE/Vjmsq/zHjFLmnth0zqHejMxvpy5pbpEyMqelStj82BZdbt1d2qQx7T8hh
         p7eVGo9jilrNOIBIRu//pGWbE5ev9SYArRshTv1G+FeTsDO8Dj+kzxily5ySxWF8fBH2
         GLWWrrE6x9muDoDtzV8GXgyi/ppjraR8oSAYcnz5pCabiV6dO/+GR8MfUNt8yqyfUKMW
         v6niE08PWrbNH2herHik15K5agYGfC4fB/TWEZHoct/5DlBoRBaflW/qWItDHsDj3kbB
         NQEQ==
X-Forwarded-Encrypted: i=1; AHgh+RpwTuwcyeFle9YrWdqWP9S6bnlhdGLHN+Mee2UR4TpNCn1L37ZxyOJgxZvSyEyRKCxcjNgxdu0=@vger.kernel.org
X-Gm-Message-State: AOJu0Yys08a5lJ0HccwiUC1hdSBRnH7AumIf3PF8jcn1auLhC176O+gZ
	fNSa/4pZ0+1GqFPqzP4aeXBaQX6rtTpNE5KMkfRAs7GqiHTJPbVjY2qEAwMMXSepHvs=
X-Gm-Gg: AR+sD13sissB1ftou7D3O3NXMLO0LQ5gpC3lwnWyKcUc+o+/q5iCnLLlgGgKQDEXa18
	UhxH0b3QFHaR7k5WbtDsXi+YVI6UMfjIfmqAnKrJZ4bsgDO47bOf9UBXUtwPrfzrtMe0gQAp3j/
	9IPw97enXszMebmT2EZ9dW4w60doFRMynGqxBVeO3LImvHAXrr21T76t0CHuNbUTjxgd1B6K1/P
	Z+5OaKZN2k/PWny7EvfPj3QuxVa8bGz2ny24Z5diOqXUxj4isNzKzjp/bcPFFtgDaNV//o+k2cw
	T2Iyw3fTx5tiFTVyPj6sQZSf9VFpmt4fFXa1EpS4Q7V1o6RxKiZLslN/d2RkS990i2TODPNNSjZ
	6W1bOZecwt2YHwDfD2JO90ftL0PpuZwlgFfyqryCPbVox+1o5mrnSA//OSi1GSF9jrkKJ08pKjY
	RrdhthSJ3LQpP9nnk/EBeLSqe3O0tXMbNT/QLYpCEQpw==
X-Received: by 2002:a17:90b:5630:b0:38e:42f5:d096 with SMTP id 98e67ed59e1d1-3957f68f7bcmr272542a91.0.1787087749324;
        Tue, 18 Aug 2026 14:15:49 -0700 (PDT)
Received: from localhost ([2a03:2880:2ff:59::])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3957f96cb6bsm71220a91.2.2026.08.18.14.15.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Aug 2026 14:15:48 -0700 (PDT)
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
Subject: [PATCH net] net: bnxt: ring the doorbell when SW USO exits early
Date: Tue, 18 Aug 2026 14:15:39 -0700
Message-ID: <20260818211540.2991183-1-joe@dama.to>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When a burst of packets is handed down to the driver, the driver defers
the doorbell to the end by setting txr->kick_pending = 1. The normal TX
path handles this, but the SW USO path can miss it if it returns
early.

If bnxt_sw_udp_gso_xmit runs but returns early with NETDEV_TX_BUSY and
txr->kick_pending was previously set to 1, then the TX queue can
stall because the driver wrote some BDs but never wrote the doorbell.
The device won't know to do the TX which would generate the completion
that would wake the queue back up.

Fix the success case of bnxt_sw_udp_gso_xmit by clearing
txr->kick_pending when writing the doorbell. When bnxt_sw_udp_gso_xmit
returns, check txr->kick_pending and write the doorbell if
bnxt_sw_udp_gso_xmit returned early and a doorbell is pending.

This TX queue stall was observed on a production system with a netdev TX
watchdog informing about the queue stall.

Fixes: cc5d90667db8 ("net: bnxt: Implement software USO")
Cc: stable@vger.kernel.org
Signed-off-by: Joe Damato <joe@dama.to>
---
 drivers/net/ethernet/broadcom/bnxt/bnxt.c     | 17 +++++++++++++----
 drivers/net/ethernet/broadcom/bnxt/bnxt.h     |  2 ++
 drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c |  4 +---
 3 files changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.c b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
index bc7b37cb74a7..b6cc755f7a04 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.c
@@ -459,8 +459,7 @@ u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb)
 	return md_dst->u.port_info.port_id;
 }
 
-static void bnxt_txr_db_kick(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
-			     u16 prod)
+void bnxt_txr_db_kick(struct bnxt *bp, struct bnxt_tx_ring_info *txr, u16 prod)
 {
 	/* Sync BD data before updating doorbell */
 	wmb();
@@ -485,6 +484,7 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 	struct bnxt_sw_tx_bd *tx_buf;
 	__le32 lflags = 0;
 	skb_frag_t *frag;
+	netdev_tx_t ret;
 
 	i = skb_get_queue_mapping(skb);
 	if (unlikely(i >= bp->tx_nr_rings)) {
@@ -510,8 +510,17 @@ static netdev_tx_t bnxt_start_xmit(struct sk_buff *skb, struct net_device *dev)
 #endif
 	if (skb_is_gso(skb) &&
 	    (skb_shinfo(skb)->gso_type & SKB_GSO_UDP_L4) &&
-	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP))
-		return bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
+	    !(bp->flags & BNXT_FLAG_UDP_GSO_CAP)) {
+		/* if the USO code exits early (for example, it returns
+		 * NETDEV_TX_BUSY) make sure we ring any outstanding doorbells
+		 * for any BDs in the ring before returning.
+		 */
+		ret = bnxt_sw_udp_gso_xmit(bp, txr, txq, skb);
+		if (txr->kick_pending)
+			bnxt_txr_db_kick(bp, txr, txr->tx_prod);
+
+		return ret;
+	}
 
 	free_size = bnxt_tx_avail(bp, txr);
 	if (unlikely(free_size < skb_shinfo(skb)->nr_frags + 2)) {
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt.h b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
index dc8ec5e5733e..60fbe3cabcf9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt.h
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt.h
@@ -3009,6 +3009,8 @@ int bnxt_reserve_rings(struct bnxt *bp, bool irq_re_init);
 void bnxt_tx_disable(struct bnxt *bp);
 void bnxt_tx_enable(struct bnxt *bp);
 u16 bnxt_xmit_get_cfa_action(struct sk_buff *skb);
+void bnxt_txr_db_kick(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
+		      u16 prod);
 void bnxt_sched_reset_txr(struct bnxt *bp, struct bnxt_tx_ring_info *txr,
 			  u16 curr);
 void bnxt_report_link(struct bnxt *bp);
diff --git a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
index f317f60414e8..3c58b1d94ac9 100644
--- a/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
+++ b/drivers/net/ethernet/broadcom/bnxt/bnxt_gso.c
@@ -223,9 +223,7 @@ netdev_tx_t bnxt_sw_udp_gso_xmit(struct bnxt *bp,
 	netdev_tx_sent_queue(txq, skb->len);
 
 	WRITE_ONCE(txr->tx_prod, prod);
-	/* Sync BDs before doorbell */
-	wmb();
-	bnxt_db_write(bp, &txr->tx_db, prod);
+	bnxt_txr_db_kick(bp, txr, prod);
 
 	if (unlikely(bnxt_tx_avail(bp, txr) <= bp->tx_wake_thresh))
 		netif_txq_try_stop(txq, bnxt_tx_avail(bp, txr),

base-commit: e2466392a0b8496000e12181cb1ee1535eb0da25
-- 
2.53.0-Meta

