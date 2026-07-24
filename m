Received: from out203-205-221-191.mail.qq.com (out203-205-221-191.mail.qq.com [203.205.221.191])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ABF0F36EAB2;
	Fri, 24 Jul 2026 09:02:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=203.205.221.191
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784883730; cv=none; b=qaL6pFV6OPR8xllyd7nZU7LHT5j5/K5vJsK1tuxas/2T26HkhXUpfsfsxpmKW9584Y3YAVnjTMIhdl7dwt5STI7+mfnX5y0J0cHkfi3Rw5p4J+AlzRS627PrmLCkwyFmxg8RRngyf++7DeoI+gEocelp33WGikgtdGogHVjzThk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784883730; c=relaxed/simple;
	bh=FxCLtBwiJVVCdNZejj8faQeOyMki65SyMA0mwYfgPkQ=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=KZrgP74oIAMgQmdQGioUEWfhOrHb3yHC3ERNA/o80q5qEHBmWm1cHoUBVDcuPVRkhZG16XB/XXNHU1/X84gRhFDT1DeeE9iehPjSiBJqp48Xh7LLa9NlhWRvc+qCqJlOUowoKXD9+bosjUJ6FU5vzaDqvLLy5mamVG/+9cHuQpg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=Kx3D2E/B; arc=none smtp.client-ip=203.205.221.191
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="Kx3D2E/B"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1784883715; bh=QlOJ6gN12LoffzLDHiimPrvvRRM4vY38LnNZ+7hdgQE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Kx3D2E/Bc/Fke/dqNfW7rH0zBq811CaC+mowLqPpcMXEP6JD6tI8WcAxfBBKBD4F7
	 6qo58MbPplFymH8pyatlMx1/HvzhxI8WhwNQi0xwHrLErLLzST3X9YzoJb2JTMJvpE
	 DZw4BwbkI/8uZ+ImvNTULAt8iwn1MO75/DNqORvQ=
Received: from localhost.localdomain ([240e:37c:2242:cf00:265e:beff:fe6a:4da1])
	by newxmesmtplogicsvrszc50-0.qq.com (NewEsmtp) with SMTP
	id 73252E3; Fri, 24 Jul 2026 17:01:51 +0800
X-QQ-mid: xmsmtpt1784883711toansbuh3
Message-ID: <tencent_E5DA048E95B86B31EB21258D8E7CE1825308@qq.com>
X-QQ-XMAILINFO: NDkKyiSMIrpLusbFu0mBP53bBayE3A8GXSvR2M83GLMlGkNntW9D3Fm7pko9r0
	 hKzFz/xhEoRDDhLW0JGTClcK8gRvLQEQqTU8WcPGtZ5GyYZHynQHutJyV0rtF8b7naRLyCa3XfOo
	 azWa2wQ0SqTjyaqufI9KllwOVWBH6igIrRhsE5LiCeIFpaxwXPWwyJERhiV8SSXCJuyhs7Kj83yJ
	 4JYZKUySWI/g13Ls23pL9+aJ8xLPh8GOM6LQXW1qFp55eUv+pQ2LfnX1+vkv1JjkeKvY/1ZySu+C
	 WzHspGZnqms9wK8WBW9467j3Jcpx43a3ldfvlA1RgSmPwQjC1rr+EhkdDJws5qB/IAcWZxLNfY5h
	 kwl4Z5JrUt1ixfBfZmK0hwhgEpXJ2j5+h85nf7wtKEQ+2nqDDoPNr9EBz9xqPZIl9JWP5EmpUVtN
	 NzyFWkEAbF6rQI6brLlurCVvuGL+oR9y/pr5GLotUfakbBsRx52rDsI0FZaI/lgk6IOWd1ZCwP/4
	 FwRucXfodOKzKWkv0nc7FrFsPG9os0UVBgh2Tixv1HOJr5hunfbwHwUCVmzjtABfQPvfEGj8aBMp
	 GnScdS4ll3OOwq7O63Axu66fUX9Mxt6DUl/lfqS7DmycbFQqeJKKVbfc+JfNZa2NuzLzDzWzlTbP
	 RlI7OurOz92rElClSI/stzmVLTByiMxLU2h6P+dR6284Y5mtxISCBc4+dnAcmNUnD0kXnfhKXB4H
	 8Dej+mVdWxK+2+TJ4Yzwx8oAj+1lzttLNL4xIDYHYJkf0HLO2+/SrLx54qTnjU0xMYRyIXhtc39E
	 zcXFWYjQjLRfUrNhkJ5Ckb4AAaAGYIsG3f0llimyEoakd9eYKo67vg+uU7GxtrVpZpdIKNFTOUzi
	 hBpIYKpxWEgeCbAuFlhDUliSRWaEW8BKlizYpgodIjOKOtOGm/m+4g+mraZ6DqIe34zy7dGtgXKH
	 5wuXwwnzSgs7+dQlHHbxEApWIQvuFXZ3I5ow7wNQnrrDD5YezJkX/laiBFsRjsToBm6OX9TALPzt
	 RYf9WYvV432MBltn2C3LbkpanE1v65l1plR78ZElg4YkV5iPQ7pAyx2rSwzfelTpJn6uvPQljkeN
	 ZyxFF2wFa4q2K25B6Shlv7JTZq+9hgne7Q7ssu8gYsJihwELur54bTyePqjhf2gntLVKav
X-QQ-XMRINFO: NI4Ajvh11aEjEMj13RCX7UuhPEoou2bs1g==
From: Yangyu Chen <cyy@cyyself.name>
To: Sukhdeep Singh <sukhdeeps@marvell.com>,
	Andrew Lunn <andrew+netdev@lunn.ch>,
	"David S . Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>
Cc: Mina Almasry <almasrymina@google.com>,
	Jesper Dangaard Brouer <hawk@kernel.org>,
	Richard Cochran <richardcochran@gmail.com>,
	Lino Sanfilippo <LinoSanfilippo@gmx.de>,
	Igor Russkikh <irusskikh@marvell.com>,
	Simon Horman <horms@kernel.org>,
	netdev@vger.kernel.org,
	bpf@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Yangyu Chen <cyy@cyyself.name>
Subject: [PATCH net-next v2 1/3] net: atlantic: free stranded TX buffers on ring deinit
Date: Fri, 24 Jul 2026 17:01:50 +0800
X-OQ-MSGID: <20260724090150.10505-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com>
References: <tencent_1F173E0FC1606D2AC704DC9C98AF10984607@qq.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

aq_vec_deinit() drains the TX rings with a single aq_ring_tx_clean()
call, which frees at most AQ_CFG_TX_CLEAN_BUDGET (256) descriptors and
stops at hw_head, which no longer moves once aq_vec_stop() has stopped
the hardware and NAPI. Completed descriptors beyond the budget and
everything still posted in [hw_head, sw_tail) keep their skb or
xdp_frame when the interface goes down: aq_vec_ring_free() then frees
the buffer ring and the references are lost for good.

Today this is a silent memory leak on every interface down under
TX/XDP_TX load. With the following conversion of the RX path to
page_pool it becomes much more visible: XDP_TX frames carry fragment
references on the RX ring's page_pool, so a single stranded frame
keeps the pool's inflight count above zero forever. page_pool_destroy()
then never completes, the pool is leaked together with its pages, and
"page_pool_release_retry() stalled pool shutdown" is warned every 60
seconds from that point on, on every ifdown, XDP detach or ring resize
under XDP_TX load.

Bring back aq_ring_tx_deinit() as it was before the removal and use it
for teardown again, with one extension: TX rings can hold xdp_frames
nowadays, so release those too. They are returned with
xdp_return_frame() since this runs in process context.

Fixes: eb36bedf28be ("net: aquantia: remove function aq_ring_tx_deinit")
Cc: stable@vger.kernel.org # v4.11+
Assisted-by: Claude:claude-fable-5
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---

Notes:
    Without this fix, converting the RX path to page_pool (last patch of
    this series) turns the stranded XDP_TX frames into leaked page_pool
    fragments, so page_pool_destroy() can never drain and the shutdown
    stalls forever.
    
    Reproduced on an AQC100 with this patch dropped from the series (i.e.
    page_pool applied without the tx-deinit fix):
    
      # reflect received frames back out through XDP_TX
      xdp-bench tx enp99s0                    # or any trivial XDP_TX prog
      # from a peer on the same link, flood RX so frames are in flight, then
      ip link set enp99s0 down
    
    The pool is destroyed with frames still stranded on the TX ring, and
    page_pool_release_retry() warns every 60s with the same id and inflight
    count and a growing age, indefinitely:
    
      [161110.753385] page_pool_release_retry() stalled pool shutdown: id 361, 12 inflight 60 sec
      [161171.170756] page_pool_release_retry() stalled pool shutdown: id 361, 12 inflight 120 sec
      [161231.588685] page_pool_release_retry() stalled pool shutdown: id 361, 12 inflight 181 sec
      [161292.005886] page_pool_release_retry() stalled pool shutdown: id 361, 12 inflight 241 sec
    
    With this patch the stranded buffers are freed at deinit, inflight
    drops to zero and the pool drains cleanly.
    
    v1 -> v2:
     - return early instead of goto to an end-of-function label (Mina)
     - drop the likely()/unlikely() annotations, this is a reconfig
       path (Mina)
     - add Cc: stable with the affected range

 .../net/ethernet/aquantia/atlantic/aq_ring.c  | 29 +++++++++++++++++++
 .../net/ethernet/aquantia/atlantic/aq_ring.h  |  1 +
 .../net/ethernet/aquantia/atlantic/aq_vec.c   |  2 +-
 3 files changed, 31 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
index 8ff07de2bd52..81685a4dc5a6 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.c
@@ -360,6 +360,35 @@ bool aq_ring_tx_clean(struct aq_ring_s *self)
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
+		if (buff->is_eop) {
+			if (buff->skb)
+				dev_kfree_skb_any(buff->skb);
+			else if (buff->xdpf)
+				xdp_return_frame(buff->xdpf);
+		}
+	}
+}
+
 static void aq_rx_checksum(struct aq_ring_s *self,
 			   struct aq_ring_buff_s *buff,
 			   struct sk_buff *skb)
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
index a70b880ada67..6431cc62962f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_ring.h
@@ -202,6 +202,7 @@ void aq_ring_update_queue_state(struct aq_ring_s *ring);
 void aq_ring_queue_wake(struct aq_ring_s *ring);
 void aq_ring_queue_stop(struct aq_ring_s *ring);
 bool aq_ring_tx_clean(struct aq_ring_s *self);
+void aq_ring_tx_deinit(struct aq_ring_s *self);
 int aq_xdp_xmit(struct net_device *dev, int num_frames,
 		struct xdp_frame **frames, u32 flags);
 int aq_ring_rx_clean(struct aq_ring_s *self,
diff --git a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
index 2f9033ceed8c..05814fea0f5f 100644
--- a/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
+++ b/drivers/net/ethernet/aquantia/atlantic/aq_vec.c
@@ -275,7 +275,7 @@ void aq_vec_deinit(struct aq_vec_s *self)
 
 	for (i = 0U; self->tx_rings > i; ++i) {
 		ring = self->ring[i];
-		aq_ring_tx_clean(&ring[AQ_VEC_TX_ID]);
+		aq_ring_tx_deinit(&ring[AQ_VEC_TX_ID]);
 		aq_ring_rx_deinit(&ring[AQ_VEC_RX_ID]);
 	}
 
-- 
2.47.3

