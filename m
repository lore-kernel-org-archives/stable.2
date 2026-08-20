Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A752367B67
	for <stable@vger.kernel.org>; Thu, 20 Aug 2026 04:21:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787199719; cv=none; b=Lx7eUhMAee6unOAZo7ALKNoNP34KYPSKqs6gbKj36IeLXxP9nlEOrn51nLNqBkixgO7RIdlzVYq1Ls05tLu6UgFFFGKgHz+aOPmRBvQQZUhx1m/6PQAIwmyRwEyobJASmGAnhky5GSS0VzgcMrRv0twrjf/d+FGTM571PuRpKg0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787199719; c=relaxed/simple;
	bh=IdLMn1y8nUBb/72xmMofI6HJP3p+LMShwAEOpHhXX7I=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oADULL/RVZxoCUJaSXb9U+GQvHAU66zH8uBt6Gqge8qQy3Ps/S1Pea4g266aE7WHAKbZnDvCTigc6xsopFitGfQvPDP1ubeKOcR8pnZL22htdQHamzzvVMK0GhaV6JPQ7ARqA8JKbYWcvWrFQ5OOHttRAkI1tyq4znw61NjppvI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=erGWLj2b; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="erGWLj2b"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36E361F000E9;
	Thu, 20 Aug 2026 04:21:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787199717;
	bh=BjLVDj33rT1xtrlY8UjmP/Z1gTJO4YkLVYeYNgH1r5k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=erGWLj2b00PVP7mOX6D0gel8Yb7oTww53ERSW4xzxlt3LK9XRuVsEThrMq/BodpGp
	 SxcmQhnu7gBZaU3LJrUkUwvCH/QdLdQjsZBavyBKqrQhg7f02MvdWJglCRA4hRrpro
	 KNTvrAJ8lDzFN7Q05pjgazTFO/ciGAJ14ltAaSEUCNscQLmpHafD9pbQth9RSW96H0
	 gIrAWYylGdoYb8fo9nnehffic4J9VAq2sk03BPu7bjOQiiD1n9VCRpC/LCCuqYPvUe
	 bG5wBk3Cde7j3gseryH5uXCDLNzWz47thjumH1Tj5Qr32py/gam8Cf/6l5PEt6mK/K
	 owFwb6i1i3TFQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Yangyu Chen <cyy@cyyself.name>,
	Sukhdeep Singh <sukhdeeps@marvell.com>,
	Mina Almasry <almasrymina@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] net: atlantic: free stranded TX buffers on ring deinit
Date: Thu, 20 Aug 2026 00:21:55 -0400
Message-ID: <20260820042155.1376960-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026081728-ounce-implicit-0ec5@gregkh>
References: <2026081728-ounce-implicit-0ec5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Yangyu Chen <cyy@cyyself.name>

[ Upstream commit 452636ea5410a96e02ebaaf80b21e3620b98e0dd ]

aq_vec_deinit() drains the TX rings with a single aq_ring_tx_clean()
call, which frees at most AQ_CFG_TX_CLEAN_BUDGET (256) descriptors and
stops at hw_head, which no longer moves once aq_vec_stop() has stopped
the hardware and NAPI. Completed descriptors beyond the budget and
everything still posted in [hw_head, sw_tail) keep their skb or
xdp_frame when the interface goes down: aq_vec_ring_free() then frees
the buffer ring and the references are lost for good.

Today this is a silent memory leak on every interface down under
TX/XDP_TX load. With the conversion of the RX path to page_pool posted
for net-next it becomes much more visible: XDP_TX frames carry fragment
references on the RX ring's page_pool, so a single stranded frame keeps
the pool's inflight count above zero forever. page_pool_destroy() then
never completes, the pool is leaked together with its pages, and
"page_pool_release_retry() stalled pool shutdown" is warned every 60
seconds from that point on, on every ifdown, XDP detach or ring resize
under XDP_TX load.

Bring back aq_ring_tx_deinit() as it was before the removal and use it
for teardown again, with one extension: TX rings can hold xdp_frames
nowadays, so release those too. They are returned with
xdp_return_frame() since this runs in process context.

Fixes: eb36bedf28be ("net: aquantia: remove function aq_ring_tx_deinit")
Cc: stable@vger.kernel.org # v4.11+
Reviewed-by: Sukhdeep Singh <sukhdeeps@marvell.com>
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
Acked-by: Mina Almasry <almasrymina@google.com>
Link: https://patch.msgid.link/tencent_EEDC35FAF2750A3A6A0B39BAE0E2C484860A@qq.com
Signed-off-by: Jakub Kicinski <kuba@kernel.org>
[ Dropped the XDP frame arm from the new teardown loop since `buff->xdpf` and `xdp_return_frame()` don't exist in 5.15, and omitted the `aq_xdp_xmit()` context line in the header hunk. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 25 +++++++++++++++++++
 .../net/ethernet/aquantia/atlantic/aq_ring.h  |  1 +
 .../net/ethernet/aquantia/atlantic/aq_vec.c   |  2 +-
 3 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 4063d4a6f47e1..685fb78846c66 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -314,6 +314,31 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
 	return !!budget;
 }
 
+void aq_ring_tx_deinit(struct aq_ring_s *self)
+{
+	if (!self)
+		return;
+
+	for (; self->sw_head != self->sw_tail;
+		self->sw_head = aq_ring_next_dx(self, self->sw_head)) {
+		struct aq_ring_buff_s *buff = &self->buff_ring[self->sw_head];
+		struct device *ndev = aq_nic_get_dev(self->aq_nic);
+
+		if (buff->is_mapped) {
+			if (buff->is_sop) {
+				dma_unmap_single(ndev, buff->pa, buff->len,
+						 DMA_TO_DEVICE);
+			} else {
+				dma_unmap_page(ndev, buff->pa, buff->len,
+					       DMA_TO_DEVICE);
+			}
+		}
+
+		if (buff->is_eop && buff->skb)
+			dev_kfree_skb_any(buff->skb);
+	}
+}
+
 static void aq_rx_checksum(struct aq_ring_s *self,
 			   struct aq_ring_buff_s *buff,
 			   struct sk_buff *skb)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index 93659e58f1ce1..3be56a4fc5bb0 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -182,6 +182,7 @@ void aq_ring_update_queue_state(struct aq_ring_s *ring);
 void aq_ring_queue_wake(struct aq_ring_s *ring);
 void aq_ring_queue_stop(struct aq_ring_s *ring);
 bool aq_ring_tx_clean(struct aq_ring_s *self);
+void aq_ring_tx_deinit(struct aq_ring_s *self);
 int aq_ring_rx_clean(struct aq_ring_s *self,
 		     struct napi_struct *napi,
 		     int *work_done,
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
index 6ab1f3212d246..2d77554d1b819 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
@@ -270,7 +270,7 @@ void aq_vec_deinit(struct aq_vec_s *self)
 
 	for (i = 0U; self->tx_rings > i; ++i) {
 		ring = self->ring[i];
-		aq_ring_tx_clean(&ring[AQ_VEC_TX_ID]);
+		aq_ring_tx_deinit(&ring[AQ_VEC_TX_ID]);
 		aq_ring_rx_deinit(&ring[AQ_VEC_RX_ID]);
 	}
 
-- 
2.53.0

