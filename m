Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793616476;
	b=vx6CWva+dAaYDyWlSNp7BFRtiXpIdCmnbPstT/hy2oO3b8LU4MLoSuoPVyUPdv2uL8xz
	 PMpgVPgPWQeEgeZU60iXiz/Hz+eoVAhGYtM1QiZZGItmc+5SCWZUhh/irGLia8w/CJHy1
	 e/5HAQ5nTnMSEixXrvIggs3Df2t/cWCS8mn9HXVsr9Zzxw+ySULIidJn98+6SpBDy8SZ2
	 eSFNBHtS/8awM7V0/srAp6V599RWmlwyivLIgKbMkbprnWHooN/Wf8NBlNLQsBbbDkPhM
	 5kSzQLAIKPyKu4vUTsSzh6al4Y+ejCG+UgnvbWUujKdYlcj2hf4mJg/HntDyVNqjnaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793616476;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=32uiAmsXGnZIPxWXHZTRNgQdPayq77HsJ4uHZ32JPfo=;
	b=uIadK0m1Q1JDVG46OJvL7Rc/oDsy7xRZSqbJs99LSRZhcANOBCvf2j0VLXdO6Q+p8po/
	 c3D7N5FmpH17rR2MmgKpwm/AJNU0V1H9Iawnwb02nWXfrgrSMTohu23RxSPKqpmG93dEp
	 5HxjqS+JRGpYLX/v+ZWkwbGwQmcXSyvE+f765sEga6xHLtrwCIhyeE3CgfOl51cF1zus4
	 QdI3Js2n/fEg+HWxANVeB4iJrINMa5XUy82tSibP8gYIK7tjoZUG+kaTSaddEtoEXtvUB
	 L2PhSoTNTyNfFW7Swnmf9QX0KXMF0fBb3XNLmJmRD8UqJqHEOjLtg1WLHXyCGqGiwXA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Spg6taB4;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 310AE606A326;
	Mon,  2 Nov 2026 10:47:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Spg6taB4
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793616475;
	b=I2i/F3093zMJfH7c5Lw8A3DIkxrtA5b8GauF5irW2ZZsmtJJogptD5bcT0ECYb45iHV6
	 xfJJwY4+eRDoCyOF+qIvtr0mUmIDQR76/UyTAt/ncg4dKXbzevt/+mhwd507Yzv558B+3
	 UEDTMrYgZnnInYsQxB2w1zf+jG4d0mngmzbO5Y1O0TeDJyMUqIp2pgblAiqDEgLMV9k5+
	 8e755jYDBlyQnUx3ciED8QHd+1p1+1AaskFtFvHAKb9yPqkaB4aUlfN/kijSH5WEQWiZ1
	 oCgO4lW7lwAwqTWP/5BMIHONFRqzMieR8xwexoyHcuep3SNdGBZYTna8/3mu0s+d0Ng==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793616475;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=32uiAmsXGnZIPxWXHZTRNgQdPayq77HsJ4uHZ32JPfo=;
	b=AHGAc1Q/QyMUiaggLvdGHrxziqs0xSLumIHXOwSJcyH57U6hT6csxWrGUBheYEAcE5xc
	 jtgCWGt/EPs9rBHwm68e6Z86TjkZDvdGtrK5lPjOLZf8RpLmHK9FU/ixlx7jaDQc0vQTy
	 ypYup5AFLOUsknSS+2VyXY/6cZf0cKMk0XcD3w1smY7miLO3BfVFOCbLjH5+Wtsf7GHGf
	 L52/w6+Ud8A9l4nZdG1jW9c5njqRhvsu8WJPj+4+Z8tMv+qHsBYNx87Ox7Uo5OIsCpQB1
	 F9g/L6HdmcyFzHu/K75lfEGnBAARsiFq5bWd8jK0tIKHoab/2gItdYOFrI05ciYRBlA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 031441F00919;
	Mon,  2 Nov 2026 10:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793616475;
	bh=32uiAmsXGnZIPxWXHZTRNgQdPayq77HsJ4uHZ32JPfo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=Spg6taB48VEEnMXxA2UXrX7SjjHBCLRDer5ciEmWIqcyRMJtoCLCPDrAPdQD7iUCH
	 k7NBzhev0Jy+MRlxy3R6BH/sHb5Fu+PVQgzHo5W9JJwZ0kFSsdAHqJM/Vqgg4SSGHQ
	 ORjfz6SlYYHR93Z4EJvwyekq/1sdqgvdHk8yXycNFb2m3gXYLYvTA4oJWSQEnKAJtZ
	 xSLOccDal0tOJIpufDSaMADaN0unLx8f1DAsIRCgcMEK7ltK/sW90PIt6ablIPoLfs
	 2yNtxCATqBxtfWSFSVyqNdsjpOKOfoQcLz8xNI7bgq/wzUTQG9v/K6oicJUrztMYa1
	 fitl9enYBv1qQ==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 64FDF464A0;
	Mon,  2 Nov 2026 10:47:54 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Mon, 02 Nov 2026 10:58:13 +0100
Subject: [PATCH net v4 1/2] igb: do not let XDP frames span more than one
 Rx buffer
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
Message-Id: <20261102-igb-rx-ts-fix-v4-1-8785124c5d23@aweta.nl>
References: <20261102-igb-rx-ts-fix-v4-0-8785124c5d23@aweta.nl>
In-Reply-To: <20261102-igb-rx-ts-fix-v4-0-8785124c5d23@aweta.nl>
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
 Kurt Kanzenbach <kurt@linutronix.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, bpf@vger.kernel.org, 
 Maciej Fijalkowski <maciej.fijalkowski@intel.com>, Paul Moses <p@1g4.org>, 
 stable@vger.kernel.org, Tjerk Kusters <tkusters@aweta.nl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793616473; l=5817;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=oeKPSFBLrPdgnpDjeb+PUB1eK71EhR4L/FqRyXpHCrM=;
 b=lNhogHtFrSl1tX+7vv+jRZAbbu0JyuYTp3P27fnxY514h5UT6bBIxPcHrMz2EZ/oHYct7OIZZ
 MosTg0j0OnnC45q9wWDlCDpB8I48toks5VIpFW2v1NMBanHsZX8qGHH
X-Developer-Key: i=tkusters@aweta.nl; a=ed25519;
 pk=JYRpYQ3+LrphEabgnxcbiOUpwvNP8WDDMcLzz+cwKsk=
X-Endpoint-Received: by B4 Relay for tkusters@aweta.nl/20260619 with
 auth_id=831
X-Original-From: Tjerk Kusters <tkusters@aweta.nl>
Reply-To: tkusters@aweta.nl
Content-Transfer-Encoding: 7bit

From: Tjerk Kusters <tkusters@aweta.nl>

igb does not support XDP multi-buffer: igb_xdp_setup() only accepts an
MTU whose frame fits in one Rx buffer, and the XDP program only sees
the first buffer of a frame. The maximum receive length is not limited
accordingly, though. RLPML is only lowered when the frame fits a build_skb
buffer on systems with PAGE_SIZE < 8192 and no VFs, and the PF pool limit
in VMOLR is set the same way. Otherwise the MAC still accepts frames of
up to MAX_JUMBO_FRAME_SIZE while XDP is attached, for example at MTU
3000, at any MTU when PAGE_SIZE >= 8192, or when VFs are allocated.

Such frames span several descriptors. When the program does not return
XDP_PASS for the first buffer, no skb is built, and igb_clean_rx_irq()
handles the next buffer of the same frame as the start of a new frame:
it runs the program on it and may pass it to the stack as a bogus frame
made from the middle of the original payload.

Limit the receive length to the configured maximum frame size while XDP
is attached: in RLPML when no VFs are allocated, and in the PF pool's
VMOLR otherwise, as RLPML then has to stay large for the VFs. Larger
frames are dropped by the MAC. Also leave room for the inline Rx
timestamp header when checking that the frame fits in one Rx buffer, on
XDP setup and on MTU change; this lowers the largest MTU accepted with
XDP on 3 KiB buffers by 16 bytes.

Both registers are programmed from igb_set_rx_mode(), which
igb_configure() calls, and attaching or removing an XDP program on a
running interface goes through igb_close() and igb_open(), as does an
MTU change.

This follows the same approach as the igc fix that limits RLPML while
XDP is attached.

Tested on an I350 at MTU 3000 with Rx timestamping on and xdp-filter
dropping all IPv4 from the peer: 8242-byte frames are now dropped by the
MAC (rx_long_length_errors), instead of their last two buffers being
delivered as a separate frame. XDP attach at MTU 3030 still works, at
MTU 3046 it is refused, as is an MTU change from 3030 to 3046 with XDP
attached.

With two VFs allocated, the same frames are counted by the MAC but
dropped by the PF pool limit in VMOLR before they reach the Rx queue;
without this patch their last two buffers are again delivered as a
separate frame.

Link: https://lore.kernel.org/all/20261028083344.3047350-3-p@1g4.org/
Fixes: 9cbc948b5a20 ("igb: add XDP support")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5-5
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ce91dda00ec0..5bf489cd7b06 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -2894,11 +2894,13 @@ static int igb_xdp_setup(struct net_device *dev, struct netdev_bpf *bpf)
 	bool running = netif_running(dev);
 	bool need_reset;
 
-	/* verify igb ring attributes are sufficient for XDP */
+	/* verify igb ring attributes are sufficient for XDP, leaving room
+	 * for the inline Rx timestamp header
+	 */
 	for (i = 0; i < adapter->num_rx_queues; i++) {
 		struct igb_ring *ring = adapter->rx_ring[i];
 
-		if (frame_size > igb_rx_bufsz(ring)) {
+		if (frame_size + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {
 			NL_SET_ERR_MSG_MOD(bpf->extack,
 					   "The RX buffer size is too small for the frame size");
 			netdev_warn(dev, "XDP RX buffer size %d is too small for the frame size %d\n",
@@ -5324,6 +5326,7 @@ static void igb_set_rx_mode(struct net_device *netdev)
 	struct e1000_hw *hw = &adapter->hw;
 	unsigned int vfn = adapter->vfs_allocated_count;
 	u32 rctl = 0, vmolr = 0, rlpml = MAX_JUMBO_FRAME_SIZE;
+	u32 pool_rlpml;
 	int count;
 
 	/* Check for Promiscuous and All Multicast modes */
@@ -5386,6 +5389,12 @@ static void igb_set_rx_mode(struct net_device *netdev)
 			rlpml = IGB_MAX_FRAME_BUILD_SKB;
 	}
 #endif
+	/* XDP does not support frames that span more than one Rx buffer.
+	 * With VFs the global limit stays large and the PF pool is limited
+	 * through VMOLR below.
+	 */
+	if (!adapter->vfs_allocated_count && igb_xdp_is_enabled(adapter))
+		rlpml = min_t(u32, rlpml, adapter->max_frame_size);
 	wr32(E1000_RLPML, rlpml);
 
 	/* In order to support SR-IOV and eventually VMDq it is necessary to set
@@ -5402,15 +5411,18 @@ static void igb_set_rx_mode(struct net_device *netdev)
 	vmolr |= rd32(E1000_VMOLR(vfn)) &
 		 ~(E1000_VMOLR_ROPE | E1000_VMOLR_MPME | E1000_VMOLR_ROMPE);
 
-	/* enable Rx jumbo frames, restrict as needed to support build_skb */
-	vmolr &= ~E1000_VMOLR_RLPML_MASK;
+	/* enable Rx jumbo frames, restrict as needed to support build_skb
+	 * and XDP
+	 */
+	pool_rlpml = MAX_JUMBO_FRAME_SIZE;
 #if (PAGE_SIZE < 8192)
 	if (adapter->max_frame_size <= IGB_MAX_FRAME_BUILD_SKB)
-		vmolr |= IGB_MAX_FRAME_BUILD_SKB;
-	else
+		pool_rlpml = IGB_MAX_FRAME_BUILD_SKB;
 #endif
-		vmolr |= MAX_JUMBO_FRAME_SIZE;
-	vmolr |= E1000_VMOLR_LPE;
+	if (igb_xdp_is_enabled(adapter))
+		pool_rlpml = min_t(u32, pool_rlpml, adapter->max_frame_size);
+	vmolr &= ~E1000_VMOLR_RLPML_MASK;
+	vmolr |= pool_rlpml | E1000_VMOLR_LPE;
 
 	wr32(E1000_VMOLR(vfn), vmolr);
 
@@ -6713,7 +6725,7 @@ static int igb_change_mtu(struct net_device *netdev, int new_mtu)
 		for (i = 0; i < adapter->num_rx_queues; i++) {
 			struct igb_ring *ring = adapter->rx_ring[i];
 
-			if (max_frame > igb_rx_bufsz(ring)) {
+			if (max_frame + IGB_TS_HDR_LEN > igb_rx_bufsz(ring)) {
 				netdev_warn(adapter->netdev,
 					    "Requested MTU size is not supported with XDP. Max frame size is %d\n",
 					    max_frame);

-- 
2.27.0


