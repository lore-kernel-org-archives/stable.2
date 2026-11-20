Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795173061;
	b=wloPmWadHG1LRV6rwezB73oGFbRdIN4Vr5t6UV/UhJ78sD/SJVsbYgzz9WLC/6JEbsLV
	 KxDrFg5WU+W/9Nu3+ev0halBJ77f7wK/IGGMrw3DscuNP0N9DikYEd/p2JBt+QQoH3SQZ
	 uitKuUfzNFRfOuyFlKq8A7VCs85HmU53RJzTzELkmLTPutvM/YHWlf3O7HFDh2u7nOQW9
	 cvcp24+9THePqcfg16tWlRBGTCSPOUSBARemkvwDvZ8kA383LP48HZ7Z9ZxjM5nawulg6
	 ll2vf1ZZncM3hJAJAJk0JeLgp8PutvZ2V0fDBa54p3+Gq2sXHqZXEg5y7ZI29g9QVIA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173061;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rjmhPAQUcJ00pT5GXd0oyviJCOv5JU8btSzVvZ3FctY=;
	b=bcJu0ZGj5QJHZ2aBGn6pERD2aT+wkKGynimajNhxG4USFyTeb+wFNDgX4BdGE5hcIYOI
	 am6uUpKVOtz+CkomitLQ/3wKxjyT/OBIQAqVmXgPiftfB/9MpVuJCedEa8oq/jRO9KSxP
	 36dFuiJ/kXcQn+CkJG6jwAR2mgskRwRNdoFotUYZ16WnXuiTWu7vOnijfHNl12f9DiiA1
	 xXXqbSyBPrzsMbRku51lGogogJbP6ip4IdUbp+TOusgsWCeOu4w2WObvVSjGIfB0/4oGW
	 oIowlcivsvresxgeWRtkJ4JKmCgrVgADQE6ehE8lfiT1R6u4KsEbTZNIGpAK2CME8Gg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="MF3h/6zp";
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A8DA660A2618;
	Fri, 20 Nov 2026 11:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MF3h/6zp
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795173061;
	b=lboDxmf3pRUF7z//G51WNu9rdGhbNzk2lVd2eKcZAczObK3+hZ5JTXw8qdU0dxi2x+oP
	 xUR23iF9hEZjmdzSj0/H5Cr2nzT9v5iXIXMTwL2OhPG6Pl33ms9wxj6w1ksEmma2mDP7I
	 nI9fi8YnxzQVsbnIQmZ72r4N6UOwYGTh8mZtPxEx5a73QCGizAnwxLiIF3oXzY5PqFGLS
	 XgAbSj6mKJGquYQS44JeKOALrzIIahm//vGhdt+5SWaxOySqdcBErqmVpLkgQ3KXhJ5xZ
	 nPEgm5ZB6f0lZokLNiE+Ul65kc9dTFJ2Y5v+EkWdw330CUZ55zVqztalaR+Qh1tQ7Jg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795173061;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=rjmhPAQUcJ00pT5GXd0oyviJCOv5JU8btSzVvZ3FctY=;
	b=273k4F/lLXABjtLKOuHLA3f4Pnt07mH6wJ1QRY2+EC/58v0FkQKScBBWUIvdw/tPU4Gj
	 qrt5GCO9Dh9Y35c/nOVj86n4klP7lOLIFMT2KXCWCNhxioNASkJro5G5UlM3p/6MONde9
	 8+UPhYNgJsZ2wsOD+gqK+4Ows8mls66d1rA1fP1UEEeUdkDcVOQynp5AWED5NYRCPK2gW
	 bgJkKWIYpz/yNCJkdLwFR3tEP9YrpKOBnD2YupfqzmtBUMK/FKMzlGK3SX5Jpa+/mJnsH
	 iWExP2BXi4P/kz4c63/2VypRs9p1+dFDFqT+oVSvK8WV7a8l19ts4bX0kalGc6UR6gA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 266241F000E1;
	Fri, 20 Nov 2026 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173061;
	bh=rjmhPAQUcJ00pT5GXd0oyviJCOv5JU8btSzVvZ3FctY=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=MF3h/6zpi59sF2vbl2td8jiAN1I5q+d0EtveiUtJfy/2xcmWV0WG0RcOT/hYALtHF
	 1O330xEagurribntwTS9U0y502tz7WKIFMm442HJVSvkhNz+ICdd8XoiMv9mEwVeTo
	 pNNt6hwpJbGV6omnQbscu0oHc/nNSdRlKLxg+TJyVStghwAtbgRPschUR7XUcxEjXl
	 KLW4c7zSQq1NOrOCzDcYBxoX3EEXExwfOpdonFPcbnYBPcSK7fvIFfsK4I3BIUrm4Y
	 nBc4AlLozy/zTFpTch2rIRnj/t7jhw9SE+1Ho5iZblZZEhq38EpYIhzlOKBA0Oqbdg
	 2y5GhNb/+MSGA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id AA99E4983E;
	Fri, 20 Nov 2026 11:10:40 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Fri, 20 Nov 2026 12:10:40 +0100
Subject: [PATCH net v7 3/3] igb: do not split AF_XDP zero-copy frames over
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
Message-Id: <20261120-igb-rx-ts-fix-v7-3-63b03045978e@aweta.nl>
References: <20261120-igb-rx-ts-fix-v7-0-63b03045978e@aweta.nl>
In-Reply-To: <20261120-igb-rx-ts-fix-v7-0-63b03045978e@aweta.nl>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795173039; l=13155;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=4slCG8uUzdzqZmpzeBqfXWC10eLbu/5Bd2ZF7Bmq7PI=;
 b=grX8W0ol8bajKoqPDzMU89XzXJD82CBArquAqfrDYOEsQZ9bSbFe1rdJADqNi01dNNtrL9Ym8
 K4mp4q6n4QkB3uE1gtOCvm9gbaVc/UPrTqmzIIdfP/WCLh+C4BVHvlQ
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

With VFs, the PF keeps a single Tx queue on all MACs, and one Rx queue
on i350 or two on 82576. A pool bound to another queue would lose its
Tx queue, which breaks the socket, and possibly its Rx queue, which the
MTU check then no longer sees. The core refuses ethtool -L in that case
(with -EINVAL). Likewise, refuse to enable VFs with -EBUSY while an XSK
pool is bound to a queue other than 0. igb_enable_sriov() checks this
before it sets up any VF state, so nothing has to be undone on that
error, and holds RTNL until the PF queues are set up again, so that no
pool can be bound in between. For that, igb_sriov_reinit() is split
into a part that runs under RTNL and a wrapper that takes it.
pci_enable_sriov() still runs without RTNL, and disabling VFs is not
refused. The older error paths of igb_enable_sriov(), for a failed queue
setup or a failed pci_enable_sriov(), are not changed.

The real queue counts are only updated when the interface is opened.
After VFs were enabled on a down 82576 PF, a pool could still be bound
to queue 1, which then has no Tx ring, and closing the socket on the
running PF would dereference the missing ring. igb_xsk_pool_enable()
now also checks the PF's Tx queue count.

A queue can also be hidden without such a request, for example when the
driver falls back from MSI-X to MSI and keeps one queue. The MTU check
does not see a pool on that queue, so igb_xsk_pool() checks the frame
size again when the ring is set up, and does not use zero-copy if the
frame does not fit. The socket then receives through the copy path,
and its Tx wakeup fails with EINVAL, until the ring is set up again
with an MTU that fits. __igb_open() sets up the rings before it updates
the queue counts, so a queue that comes back is used in zero-copy mode
again only from the next reconfiguration; that is not changed here.
This path was not tested.

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
queue 0, which the PF keeps, the VFs are enabled. With 31 macvlans on
the PF, which fill all 32 receive address registers, all 31 addresses
stay valid after the refused VF enable, read back from the registers.
With the driver built so that the I350 keeps two Rx queues with VFs, as
an 82576 does, binding a zero-copy socket to queue 1 after VFs were
enabled on the down PF is now refused with EINVAL; before, it was
accepted. The socket was closed while the PF was down, so the missing
ring was not dereferenced.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/
Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
Cc: stable@vger.kernel.org
Suggested-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
 drivers/net/ethernet/intel/igb/igb.h      |  9 ++++
 drivers/net/ethernet/intel/igb/igb_main.c | 76 +++++++++++++++++++++++++++----
 drivers/net/ethernet/intel/igb/igb_xsk.c  | 27 ++++++++++-
 3 files changed, 101 insertions(+), 11 deletions(-)

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
index a59ee6575c56..d3165ae97b00 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -3782,13 +3782,13 @@ static int igb_probe(struct pci_dev *pdev, const struct pci_device_id *ent)
 }
 
 #ifdef CONFIG_PCI_IOV
-static int igb_sriov_reinit(struct pci_dev *dev)
+static int igb_sriov_reinit_locked(struct pci_dev *dev)
 {
 	struct net_device *netdev = pci_get_drvdata(dev);
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	struct pci_dev *pdev = adapter->pdev;
 
-	rtnl_lock();
+	ASSERT_RTNL();
 
 	if (netif_running(netdev))
 		igb_close(netdev);
@@ -3800,7 +3800,6 @@ static int igb_sriov_reinit(struct pci_dev *dev)
 	igb_init_queue_configuration(adapter);
 
 	if (igb_init_interrupt_scheme(adapter, true)) {
-		rtnl_unlock();
 		dev_err(&pdev->dev, "Unable to allocate memory for queues\n");
 		return -ENOMEM;
 	}
@@ -3808,9 +3807,18 @@ static int igb_sriov_reinit(struct pci_dev *dev)
 	if (netif_running(netdev))
 		igb_open(netdev);
 
+	return 0;
+}
+
+static int igb_sriov_reinit(struct pci_dev *dev)
+{
+	int err;
+
+	rtnl_lock();
+	err = igb_sriov_reinit_locked(dev);
 	rtnl_unlock();
 
-	return 0;
+	return err;
 }
 
 static int igb_disable_sriov(struct pci_dev *pdev, bool reinit)
@@ -3856,6 +3864,7 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int old_vfs = pci_num_vf(pdev);
 	struct vf_mac_filter *mac_list;
+	unsigned int q, end;
 	int err = 0;
 	int num_vf_mac_filters, i;
 
@@ -3866,6 +3875,27 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
 	if (!num_vfs)
 		goto out;
 
+	/* With VFs the PF keeps a single Tx queue, see
+	 * igb_set_interrupt_capability(). Refuse VFs while an XSK pool is
+	 * bound to another queue; the core refuses ethtool -L in the same
+	 * case. Check before any VF state is set up, and hold RTNL until the
+	 * queues are set up again, so that no pool can be bound in between.
+	 */
+	if (reinit) {
+		rtnl_lock();
+		end = max(netdev->real_num_rx_queues,
+			  netdev->real_num_tx_queues);
+		for (q = 1; q < end; q++) {
+			if (xsk_get_pool_from_qid(netdev, q)) {
+				dev_err(&pdev->dev,
+					"Cannot change the number of queues, an AF_XDP socket is bound to queue %u\n",
+					q);
+				err = -EBUSY;
+				goto err_unlock;
+			}
+		}
+	}
+
 	if (old_vfs) {
 		dev_info(&pdev->dev, "%d pre-allocated VFs found - override max_vfs setting of %d\n",
 			 old_vfs, max_vfs);
@@ -3880,7 +3910,7 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
 	if (!adapter->vf_data) {
 		adapter->vfs_allocated_count = 0;
 		err = -ENOMEM;
-		goto out;
+		goto err_unlock;
 	}
 
 	/* Due to the limited number of RAR entries calculate potential
@@ -3923,7 +3953,8 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
 	adapter->flags &= ~IGB_FLAG_DMAC;
 
 	if (reinit) {
-		err = igb_sriov_reinit(pdev);
+		err = igb_sriov_reinit_locked(pdev);
+		rtnl_unlock();
 		if (err)
 			goto err_out;
 	}
@@ -3943,6 +3974,11 @@ static int igb_enable_sriov(struct pci_dev *pdev, int num_vfs, bool reinit)
 	kfree(adapter->vf_data);
 	adapter->vf_data = NULL;
 	adapter->vfs_allocated_count = 0;
+	goto out;
+
+err_unlock:
+	if (reinit)
+		rtnl_unlock();
 out:
 	return err;
 }
@@ -4846,9 +4882,13 @@ void igb_setup_srrctl(struct igb_adapter *adapter, struct igb_ring *ring)
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
@@ -6788,6 +6828,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 {
 	struct igb_adapter *adapter = netdev_priv(netdev);
 	int max_frame = new_mtu + IGB_ETH_PKT_HDR_PAD;
+	int i;
 
 	if (igb_xdp_is_enabled(adapter) &&
 	    !igb_xdp_frame_fits(adapter, max_frame)) {
@@ -6801,6 +6842,23 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
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
index ce4a7b58cad2..43b33a536efe 100644
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
@@ -103,13 +117,22 @@ static int igb_xsk_pool_enable(struct igb_adapter *adapter,
 	bool if_running;
 	int err;
 
-	if (qid >= adapter->num_rx_queues)
+	/* the real queue counts are only updated when the interface is
+	 * opened, so also check the PF's own queues, see
+	 * igb_set_interrupt_capability()
+	 */
+	if (qid >= adapter->num_rx_queues ||
+	    qid >= adapter->num_tx_queues)
 		return -EINVAL;
 
 	if (qid >= netdev->real_num_rx_queues ||
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


