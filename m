Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F6763B2FFC
	for <stable@vger.kernel.org>; Mon, 17 Aug 2026 12:44:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786970691; cv=none; b=q8xj0L8Vitq52adI29LzBgpBbVOsVWcIupetr93rYrWBov63kIGhEU0wE5RQQUSMAVFnIR7e3lzE2+RkwzHaotCuWVXEFs2gV4eK4cUCS6xLFbxsMFL9BeSDoleK/f9SIlMHm2VHk2hrlAefgiBh6be1NEGKjwaykubLWtkeXGo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786970691; c=relaxed/simple;
	bh=zZ+N6KkSSpSFge86zxqQ4XFOcyI+uqJnMXVjHKJWiPs=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=AU0Pm4qe2Pcdb9nAyybV/1cSU5es0C6cLeSf2BDX3JK8u3AmNw7rVo6exIjX/fUgaRlCC+SJfAiM3Lh5/dDem1fEbS95E4zG3xgeC9pMEcBIynACfCiVQLI1n7Lv+203r3jz0FIH8WSry/81meY93lVXqKkE8eHkKL1OLpUYBvE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=YPEbZ0ed; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="YPEbZ0ed"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D53F91F000E9;
	Mon, 17 Aug 2026 12:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1786970690;
	bh=EwEC1yisF2EkEfn3XareHkSBpjAmcuYNtshfdB7CJXc=;
	h=Subject:To:Cc:From:Date;
	b=YPEbZ0edGaYqiA+zViaBBfKJjpfg50XnQ09VkaFW84jo3dxsca9Bmj+Oquylm9kvf
	 p6W81HNRuZGUK8TxDL5syeE0xbxR9O8XVd6EJTbPbA6UlCEqR5GHAwLvWDTR+PSGu/
	 BVl8Bh2D2cWa/zeWBvuyuWk5WvFW3xhmyQMrf6cA=
Subject: FAILED: patch "[PATCH] net: atlantic: free stranded TX buffers on ring deinit" failed to apply to 5.15-stable tree
To: cyy@cyyself.name,almasrymina@google.com,kuba@kernel.org,sukhdeeps@marvell.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 17 Aug 2026 14:43:29 +0200
Message-ID: <2026081728-ounce-implicit-0ec5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 452636ea5410a96e02ebaaf80b21e3620b98e0dd
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026081728-ounce-implicit-0ec5@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 452636ea5410a96e02ebaaf80b21e3620b98e0dd Mon Sep 17 00:00:00 2001
From: Yangyu Chen <cyy@cyyself.name>
Date: Sun, 2 Aug 2026 23:46:00 +0800
Subject: [PATCH] net: atlantic: free stranded TX buffers on ring deinit

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
 

