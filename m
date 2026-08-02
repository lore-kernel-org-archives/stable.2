Received: from out162-62-57-87.mail.qq.com (out162-62-57-87.mail.qq.com [162.62.57.87])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E5E4A392C29;
	Sun,  2 Aug 2026 15:46:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=162.62.57.87
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785685595; cv=none; b=Mlza6a8yeRxGrUnqua0h4EVlAL04f8hjbuC2LuxSOpcxB6Uj6pm2t6xl0mSVmP45/S2I/W7OcOHV5LGfp3lsfL2rZeNucT90KteyBJePEG1A6Ie0o+no9/Tl/wKNtCknQkaEIvLjq1XaTlPcdD6f7toDO+fKiVSN7UItAoFFYRA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785685595; c=relaxed/simple;
	bh=nQSJrDA/fmQdX1iZpaXtdzjlm5bLhXj9XQZqYVDT85Q=;
	h=Message-ID:From:To:Cc:Subject:Date:In-Reply-To:References:
	 MIME-Version; b=VYf69gcVczbNXSUxv+jv0Ak+SHQskGnuJc8Doyp1tKaxAYnAwAKZytWiNiTgnoR0MRcMV9sFdTEHyDdO+BJqVU39TdCbyz9YCzpPAvOvJ2oL1+WMUwKGw/5SRti1vkdrAPCyKW/+CEYhE7XrQEAvUbAZ+zwMC5ExSAZmdBQ13/c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name; spf=pass smtp.mailfrom=cyyself.name; dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b=wQ3SpEkk; arc=none smtp.client-ip=162.62.57.87
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=cyyself.name
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=cyyself.name
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=qq.com header.i=@qq.com header.b="wQ3SpEkk"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qq.com; s=s201512;
	t=1785685579; bh=WPlcpJoLTcSVOaV+8nxaAkEHLcTeJTsMz0suLveR/fA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=wQ3SpEkk05/dk4AZ2JDNTlFvcoAaS5vNxOwi3MOp9LECcJrbkM3VZ/ZDOe0ERR5YC
	 qPLGY1NI8y5v1TpqhPxjKebNKbbIc8Km1a8smxNOSW3k5Q+vCo3E9Rkjfp4q3iyw3/
	 27kyI0w4Uy9zLo8LP8+8Bwxrw1HpiL4vlX3STlM0=
Received: from halo.lan ([240e:379:2238:cc00:262b:8ebc:c000:80a0])
	by newxmesmtplogicsvrszc56-0.qq.com (NewEsmtp) with SMTP
	id B839CE89; Sun, 02 Aug 2026 23:46:03 +0800
X-QQ-mid: xmsmtpt1785685563td6zh1djc
Message-ID: <tencent_EEDC35FAF2750A3A6A0B39BAE0E2C484860A@qq.com>
X-QQ-XMAILINFO: MllZffuBkEb5a60sLct7sviH/uCQPly28gt+lxpw9k7QY4hZCCpkRSKQagg/gn
	 kx8OmEyoVAAayqY5GsXo/jDI8Ittpmff+H38A/aBJ2004Un/B2kwUJViVa+uVBOICitpkpQcZ1ap
	 HIMUQANo5o+Cj80FOaIZJmFZg4M2KsjzH+F//gqdiO54IAzOsREvuhw1Sp7YPMAkRUofpnxVxCYx
	 93YxA6ROMAbG/I8dngZDsyXCThVmP8eSv/Gc2CrvgOJ+sU1jUeT8OwhRCoyyy12rWvYC8GR1PJRq
	 mq/I600Um5w5XV4GzPF9CtR4HGjT6hyL4tXiZLsuTHWfPpOsOYdoLbmUL0K+CGLfe9QGghUj41WZ
	 sOazhbMTGuQ0KrJ73Oofckfa3KuR2bcdXZjwZUDxgzWHtst7ybLGdTVOmVe2UsrvbqcsOAfiTBFI
	 H/xCI1eCLnhem3qN7wY+bRwnTsq8QCYJ53xHS0KnmvRa4LiUcflPqhNrNrOXlOPJfs3gL2A/J1Ly
	 1jI+wkddORAxt7wbUy/AwRo/nT2MwmXvnux36EPL6RXDnKlrGsam/kIo7+jfT769H5ALaN6bT1pf
	 rTrzNorKqiWmoUcWcLI1b87hkAJ+z2nnKmj8by2eWxPqZ4W6dlbmLaHWvhHscCLI4+ipZK6jiv33
	 WT13+ZHnucahLOIlp/X0uUjUZ8O8EiDBGRO6aSNXfAEpggKDz6QzQpeIF1/Ss1kwsbtZIPVTKOGh
	 uOF7w3v9QE7i1KL/NKg3jsorBYE5a8x7lTKQ16IJngHdTRhqess7nq7YQL85iH8G7lA+THfkN16H
	 19IJe7+iRYFSRMIfDchDH6F7C/xObT31BPwTUVGbA2g554HZ/R5B05tFeSBxnMLUnXoeuk5f68Ns
	 ShBak8vn8VWeHrNLXzPOw1vc9ohfHKka3Hul7a/fVQxcSPAhJ+XvoK+Bl9S+OqanNYPbs4NTSWdm
	 Knn0W9hcQ+kWwssekGDPIDEpoxZde41Vf1xw3vYFvAYqCI2t8UZKPuS4zimEWuKPA7niMiOarMVt
	 n/xzNB5RdmP6Sh+Hjri1n1eaa2rJYhZXMqXdDjQvLDk8RoVKNZj5jv4AzeoHyvwgHYeCubLhlPwR
	 4gybf/icBXKQSnlowdXpFZg/QBAg==
X-QQ-XMRINFO: NS+P29fieYNwqS3WCnRCOn9D1NpZuCnCRA==
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
Subject: [PATCH net 1/2] net: atlantic: free stranded TX buffers on ring deinit
Date: Sun,  2 Aug 2026 23:46:00 +0800
X-OQ-MSGID: <20260802154600.39228-1-cyy@cyyself.name>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <tencent_29B860317921D68DE77C718242DA418EB608@qq.com>
References: <tencent_29B860317921D68DE77C718242DA418EB608@qq.com>
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
Assisted-by: Claude:claude-fable-5
Signed-off-by: Yangyu Chen <cyy@cyyself.name>
---

Notes:
    Without this fix, converting the RX path to page_pool (posted
    separately for net-next) turns the stranded XDP_TX frames into leaked page_pool
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
 

base-commit: af39eb111ce6b5eba9c08513b62c4868eb7e7fd5
-- 
2.47.3

