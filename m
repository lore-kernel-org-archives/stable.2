Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794379870;
	b=rXqxtH2bc79ElD2xAlQfqzFU8Ok2x7Wdo7iod1L7UeEq4RHt1J+DsZgYloDqextTPXHt
	 kqV3LX1urufbZHrtGnTZ4zOVTJpzhaQAa8MaI3RV4NZCe5/uZrU/pSCU/pDJBY0muf7D9
	 ad6VXeDrotnbQ5GiDRNCdjd3Zexg5ane1U5wsWkJuSovcFBd1Cm3mIGdI2jdv2C+8Vyzh
	 Z2fCz+eoOCigEuIEIoKJQJo3cK8KAX9Xzy2DWWLz8aqKZ3Ii63RZkC3XoCyRAmIlTiXaF
	 7KQpBAKJfXVC1EaV/SfsA97VLSJ/VHkfwyPkcppLK5Gg1yyjtC/X/Xn7NQebP8NP4Mw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379870;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mHgwMER+DCiZRpfiUjtz9irQ4xjpinLqB1a1cCYsOLM=;
	b=UU1EvXnXxp3laWIKZVBAsGNJpFdpYVMEswENbn5XUbmb2p4vn7ovOQGaHgXRWS3kFZXz
	 5gdUkvHP7Sv5DppH9WKw9b3uWQIEgfb5s6JxJDeJ4vmRGsLfTLssT7M9zYpoDXKzQJHAI
	 SN17aOzxPc+WVevR51eDpTjfnRbENsjrYv47WViCGJ2viP+DSFTV9DK1yn6tqsbK3F0Zo
	 DvkBJCRd5lIQPnv4jToxYINIuCSLKW79DuZ73ofc0ep/YQ3yfwD6zz5/uqktc7y6phpwR
	 HbXW26SXU1wsipxxbomK7PNb9sRC1mmA4aYqYsuJGLNWgXR9bPbjz6AeM0TIw3xhpjA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BqJn27De;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CD51606A99E;
	Wed, 11 Nov 2026 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BqJn27De
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794379870;
	b=hE+kJbzPKD6AZpFWvtnTchdhXxIvqnPODivhycpXmFMdHPxErEdI8HKf162h0Qma6yOx
	 XqAYC37Gk5YfvC7Vm6kgbs9C1jAVeHC42nrjA8q8UnPkkNl/VSTsHxOcZCDv0Yva3T9Xs
	 wRmOlYctzUSST3skj9ZDqWmf1OZCwJVe9M21bBrw3WKCoTdga4pwqYPzOJ0FqK5HBREIs
	 qAINnQixZ+XH1RfHIRu6MV00ViHa1oW7M8BgGh3UPQzPDApi7WEUMBVTP8Dsj4OwAvJ33
	 p/CIr7P5gZU8t+F8gFoZxQ0nGmxwoWqjAlKDWXdTobSsCkCB1hb0n0VGwyMIQ1Oaj1Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794379870;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=mHgwMER+DCiZRpfiUjtz9irQ4xjpinLqB1a1cCYsOLM=;
	b=1b6b8hLnmaAg3GEbrApI8mjH5D7ueour47x+iOnlUOz0t/SiXevHSsmEAojXx4t4WA9A
	 hij2AIIWZLKAdGkEMJ1mcigvz8h2nPakqMJrRVVH9FJwyTvTuGdoimEdXt670/IgVxm6a
	 jAMDSkhL3oiUXPbWyH/E57d2+xfrQhyS4sGDRIWIP49P7fOjeOhHr/N/uXjAqsQZOGVy9
	 r+Y/SqVMXZvQIEjJq94/paxLe8gqlUjoMbjJtDroR5eTqtqj2DizY2IoKcw2Jnr7CuFas
	 V3ANrq4oejzU+NEWKcJfAK59n8b63zyVPDVM8PjIe3OtW1TWjZFVfxewL/Y80r4xXwg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 5E9751F00A08;
	Wed, 11 Nov 2026 06:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794379870;
	bh=mHgwMER+DCiZRpfiUjtz9irQ4xjpinLqB1a1cCYsOLM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=BqJn27De/7pPd+Q+NI65nZBAT3GYNuN/R4iFJSBBBq6KhN9+pLtPONqMc4VFJQGDF
	 st6uzUuOyHtZcKqH7uG4JzjqShNvqqlj5Dz7vCPGkBNyIDce9RhgtUoe02NiUKcI2g
	 lnUvqi1sx4k1IihmSqDZraVxziul5rQ+z46szDRsnCTzPtMqf8TIAvPDzjpAOKnh0B
	 caspSGprRgXGynp1dnuVXFU3kgnreIpQ/BUt9W0y85rI8v/gMB3ARXQ/6S02YyRMh3
	 GxPf6V1hTbWOpVOifYMvUAh/2ZljUdZ+Hus7ZZ62K4auqHGtU2KkMDwb3UOYzFNdv/
	 uTBmFnKEV0wRg==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DE62348E31;
	Wed, 11 Nov 2026 06:51:07 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Wed, 11 Nov 2026 07:51:06 +0100
Subject: [PATCH net v6 3/3] igb: do not split AF_XDP zero-copy frames over
 several Rx buffers
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261111-igb-rx-ts-fix-v6-3-ba5b9903859c@aweta.nl>
References: <20261111-igb-rx-ts-fix-v6-0-ba5b9903859c@aweta.nl>
In-Reply-To: <20261111-igb-rx-ts-fix-v6-0-ba5b9903859c@aweta.nl>
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 John Fastabend <john.fastabend@gmail.com>, 
 Stanislav Fomichev <sdf@fomichev.me>, 
 Sven Auhagen <sven.auhagen@voleatech.de>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Kurt Kanzenbach <kurt@linutronix.de>, 
 Sriram Yagnaraman <sriram.yagnaraman@ericsson.com>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Paul Moses <p@1g4.org>, 
 stable@vger.kernel.org, Tjerk Kusters <tkusters@aweta.nl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794379866; l=10051;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=VQt7HbFJgAlErx/4xWS+KQx2cWrxuz8U19GwH9gf/h4=;
 b=tLqusoWKPqjDFu5n5ESQX+eWSb6JNZIautgKBcPupZGD8D1j85bUlOL5o3TySZj+W7sAD2v7V
 L5VCWyZdNPeBmXW6v464tGsgGDeCSHnN0YBY/mhjuDcrCmHHNkgppR5
X-Developer-Key: i=tkusters@aweta.nl; a=ed25519;
 pk=JYRpYQ3+LrphEabgnxcbiOUpwvNP8WDDMcLzz+cwKsk=
X-Endpoint-Received: by B4 Relay for tkusters@aweta.nl/20260619 with
 auth_id=831
X-Original-From: Tjerk Kusters <tkusters@aweta.nl>
Reply-To: tkusters@aweta.nl
Content-Transfer-Encoding: 7bit

From: Tjerk Kusters <tkusters@aweta.nl>

SRRCTL.BSIZEPKT has a granularity of 1 KiB. For AF_XDP zero-copy rings,
igb_setup_srrctl() programs xsk_pool_get_rx_frame_size(), which is
rounded down. With 2 KiB UMEM chunks and the default headroom this is
1792 bytes, so the hardware buffer becomes 1 KiB and a full-size frame
spans two Rx buffers. igb_clean_rx_irq_zc() handles every descriptor as
a complete frame, so the AF_XDP socket gets such a frame as two
packets, the second one without headers. With Rx timestamping enabled,
the timestamp header is also stripped from the second buffer, and a
short final buffer makes the size wrap.

Program the same buffer size as for the other rings, 2 KiB or 3 KiB.
This depends on "igb: do not let XDP frames span more than one Rx
buffer": the receive length limit set there while XDP is attached keeps
the hardware from writing more than the frame plus the timestamp header
into the larger buffer. Without it, the hardware can write past the XSK
frame.

Refuse an XSK pool whose frame size cannot hold that, and an MTU change
that would no longer fit a bound pool, also while no XDP program is
attached. The current MTU is checked rather than the largest XDP MTU,
as igb allows XDP up to MTU 3030 and that would rule out 2 KiB chunks.
With VFs, the PF keeps a single Tx queue, and one Rx queue on i350 or
two on 82576. A pool bound to a queue above that would lose its Rx
queue, which the MTU check then no longer sees, or its Tx queue, which
breaks the socket. The core refuses ethtool -L in that case (with
-EINVAL). Likewise, refuse to enable VFs with -EBUSY while an XSK pool
is bound to a queue the PF would lose. On that error, igb_enable_sriov()
also restores the DMA coalescing flag it cleared. The MAC filter
entries it reserved for the VFs before the check stay reserved until
the next reset.

A queue can also be hidden without such a request, for example when the
driver falls back from MSI-X to MSI and keeps one queue. The MTU check
does not see a pool on that queue, so igb_xsk_pool() checks the frame
size again when the ring is set up, and does not use zero-copy if the
frame does not fit. The socket then receives through the copy path,
and its Tx wakeup fails with EINVAL, until the ring is set up again
with an MTU that fits. This path was not tested.

This is the igb counterpart of the igc XSK buffer change.

Tested on an I350 with xdpsock from bpf-examples in rxdrop zero-copy
mode on one queue, Rx timestamping on and 1514-byte frames from the
peer. With 2 KiB chunks, the receive descriptors went from about two
per frame to one per frame; 98-byte frames and 4 KiB chunks were one
per frame with and without this patch. At MTU 3000, 4 KiB chunks
receive 3014-byte frames in one buffer. A 2 KiB chunk pool at MTU 3000
was refused by the new check on the 6.14.9 test kernel; current kernels
already refuse it in xp_assign_dev(). There, with 2 KiB chunks and the
default headroom, the new check refuses MTU 1751 to 1766, which the core
accepts.

On 7.3.1, with xdpsock bound to queue 1 of an I350, enabling two VFs is
now refused with EBUSY and the socket keeps its queue; with the socket on
queue 0, which the PF keeps, the VFs are enabled. The 82576 case, with
two Rx queues and one Tx queue for the PF, was checked with the driver
built so that the I350 keeps two Rx queues with VFs: with the socket on
queue 1, the VF enable is refused as well. Only the refusal was checked.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/
Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
Cc: stable@vger.kernel.org
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
 drivers/net/ethernet/intel/igb/igb.h      |  9 ++++++
 drivers/net/ethernet/intel/igb/igb_main.c | 51 +++++++++++++++++++++++++++++--
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 20 +++++++++++-
 3 files changed, 76 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 0fff1df81b7b..0495c02544d6 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -856,6 +856,15 @@ int igb_add_mac_steering_filter(struct igb_adapter *adapter,
 int igb_del_mac_steering_filter(struct igb_adapter *adapter,
 				const u8 *addr, u8 queue, u8 flags);
 
+/* XDP does not support frames that span more than one Rx buffer, so a
+ * frame plus the inline Rx timestamp header must fit in one XSK buffer.
+ */
+static inline bool igb_xsk_frame_fits(struct xsk_buff_pool *pool,
+				      int max_frame)
+{
+	return max_frame + IGB_TS_HDR_LEN <= xsk_pool_get_rx_frame_size(pool);
+}
+
 struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
 				   struct igb_ring *ring);
 int igb_xsk_pool_setup(struct igb_adapter *adapter,
diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index e787095d3cdb..c9351a8c4f5e 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3777,9 +3777,29 @@ static int igb_sriov_reinit(struct pci_dev *dev)
 	struct net_device *netdev = pci_get_drvdata(dev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct pci_dev *pdev = adapter->pdev;
+	unsigned int i, rxq, txq, end;
 
 	rtnl_lock();
 
+	/* With VFs the PF gets fewer Rx queues and a single Tx queue, see
+	 * igb_set_interrupt_capability(). Refuse that while an XSK pool is
+	 * bound to a queue the PF would lose; the core refuses ethtool -L in
+	 * the same case.
+	 */
+	rxq = min_t(unsigned int, igb_get_max_rss_queues(adapter),
+		    num_online_cpus());
+	txq = adapter->vfs_allocated_count ? 1 : rxq;
+	end = max(netdev->real_num_rx_queues, netdev->real_num_tx_queues);
+	for (i = min(rxq, txq); i < end; i++) {
+		if (xsk_get_pool_from_qid(netdev, i)) {
+			rtnl_unlock();
+			dev_err(&pdev->dev,
+				"Cannot change the number of queues, an AF_XDP socket is bound to queue %u\n",
+				i);
+			return -EBUSY;
+		}
+	}
+
 	if (netif_running(netdev))
 		igb_close(netdev);
 	else
@@ -3844,6 +3864,7 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
 {
 	struct net_device *netdev = pci_get_drvdata(pdev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
+	bool dmac = adapter->flags & IGB_FLAG_DMAC;
 	int old_vfs = pci_num_vf(pdev);
 	struct vf_mac_filter *mac_list;
 	int err = 0;
@@ -3933,6 +3954,8 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
 	kfree(adapter->vf_data);
 	adapter->vf_data = NULL;
 	adapter->vfs_allocated_count = 0;
+	if (dmac)
+		adapter->flags |= IGB_FLAG_DMAC;
 out:
 	return err;
 }
@@ -4836,9 +4859,13 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
 	u32 srrctl = 0;
 	u32 buf_size;
 
-	if (ring->xsk_pool)
-		buf_size = xsk_pool_get_rx_frame_size(ring->xsk_pool);
-	else if (ring_uses_large_buffer(ring))
+	/* SRRCTL.BSIZEPKT has a 1 KiB granularity, so programming the XSK
+	 * frame size would round it down and split frames over several
+	 * buffers. XSK rings use the same buffer size as the other rings.
+	 * While XDP is attached, the receive length limit keeps frames
+	 * within the XSK frame, see igb_xsk_frame_fits().
+	 */
+	if (ring_uses_large_buffer(ring))
 		buf_size = IGB_RXBUFFER_3072;
 	else
 		buf_size = IGB_RXBUFFER_2048;
@@ -6778,6 +6805,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int max_frame = new_mtu + IGB_ETH_PKT_HDR_PAD;
+	int i;
 
 	if (igb_xdp_is_enabled(adapter) &&
 	    !igb_xdp_frame_fits(adapter, max_frame)) {
@@ -6791,6 +6819,23 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 	if (max_frame < (ETH_FRAME_LEN + ETH_FCS_LEN))
 		max_frame = ETH_FRAME_LEN + ETH_FCS_LEN;
 
+	/* the frame must fit the buffers of a bound XSK pool, also while no
+	 * XDP program is attached, as attaching one does not check it again
+	 */
+	for (i = 0; i < adapter->num_rx_queues; i++) {
+		struct xsk_buff_pool *pool = xsk_get_pool_from_qid(netdev, i);
+
+		if (!pool || !pool->dev)
+			continue;
+
+		if (!igb_xsk_frame_fits(pool, max_frame)) {
+			netdev_warn(adapter->netdev,
+				    "Requested MTU size is not supported with AF_XDP. Frame size is %d\n",
+				    max_frame);
+			return -EINVAL;
+		}
+	}
+
 	while (test_and_set_bit(__IGB_RESETTING, &adapter->state))
 		usleep_range(1000, 2000);
 
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index ce4a7b58cad2..7f99e834c1ed 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -91,7 +91,21 @@ struct xsk_buff_pool *igb_xsk_pool(struct igb_adapter *adapter,
 	if (!igb_xdp_is_enabled(adapter))
 		return NULL;
 
-	return (pool && pool->dev) ? pool : NULL;
+	if (!pool || !pool->dev)
+		return NULL;
+
+	/* igb_change_mtu() does not see a pool on a queue that is hidden, for
+	 * example after a fallback from MSI-X to MSI. The hardware buffer can
+	 * be larger than the XSK frame, so check again when the ring is set up.
+	 */
+	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size)) {
+		netdev_warn_once(adapter->netdev,
+				 "XSK frame size is too small for the MTU, queue %d is not used in zero-copy mode\n",
+				 qid);
+		return NULL;
+	}
+
+	return pool;
 }
 
 static int igb_xsk_pool_enable(struct igb_adapter *adapter,
@@ -110,6 +124,10 @@ static int igb_xsk_pool_enable(struct igb_adapter *adapter,
 	    qid >= netdev->real_num_tx_queues)
 		return -EINVAL;
 
+	/* checked again on MTU changes and when the ring is set up */
+	if (!igb_xsk_frame_fits(pool, adapter->max_frame_size))
+		return -EOPNOTSUPP;
+
 	err = xsk_pool_dma_map(pool, &adapter->pdev->dev, IGB_RX_DMA_ATTR);
 	if (err)
 		return err;

-- 
2.27.0


