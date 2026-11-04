Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793774409;
	b=GUDVMiMYJ766hjscBVfolzyVYTjqkxVJs7Pfw0M2XkbPZyC1LqQHsq/39adj9Sw6ncHR
	 mtBgabcyJg/1mZWKlGqJ1XXuGizxF3bb3X3kMAcdjK9VeNHCFyPe5DXBg9Ny8nJmqcs62
	 mrByTrChsG4kmMre/vT1+M2W7oBuEAHIBCSPCUqrCQXA5LlZEHb3IsF5OHwte/qqsSquh
	 BBNkU5LMj082C/xktdD/ARU3npqJdr11RcA+0SxgTfZNcu72ykXWgxft1nmJcwSXCjmOd
	 NUfxLvbATquxKZJItnL+TRXzA4SXK2siVFjhQOEJljBhS9ZYy0cM+pPAgU3xlI0o9DA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774409;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QM0NVH0cM+4ZpfVNA+64ursRYzC14LgzNdyXgZtFgX0=;
	b=3OICLb2eaT+46nRA+4bqq6UL8HycaciH1QXjUGB/TaSCBwL311u4H+CKde6ltPaSU3Y6
	 vgJejgo6BkRHMuE4ZULc78fgB+Had43k58lqQkx5XJlLP+A7uhDHgItGUU7586rcQ8eYJ
	 qc7+MyrzragQQxDGCYkAqISgYnQoHFF8nFRSJTtkE5hlvPzQ6hCA8bknDFsu5RRqoUsZL
	 b2tCVTR4VK7Cre4O7rAMWkazqquYCm0lHTV4KiMdnwnd7UgHTkL+sUR3/KZFvkBho57rV
	 RJYuzNKUEAthNTseandFQV5quETWRsdJTjeXDQeIL3mxcEp70m+/5aGRLkmNvkuEpQw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEjRnMMW;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5E3F606A336;
	Wed,  4 Nov 2026 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEjRnMMW
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793774408;
	b=r9O6Fx43/LLVgssO05rPAKbz60SE7M5MBIOrpgACq4hygau/S6ovDyY/xqmF2dLVTzHr
	 OLrTcrMMWdDl30ld43cwJU58ZHn2oqQj3jOx6QOwIVbkJxlbmBIVjviJJvhaVVZJdDQsL
	 b0ArSLWlF7tix2FEbC7hyl639wSAEHDIKA5DoUQ98owA0cI63Yk8HtmZQ651FtL9JzfJM
	 ShCGwZ1x4E83Nf9oelebO6C2B/U0DhbjorIR9jyQrV2DogYmUGn6puhnV2CRb70NUbjPE
	 mKX28Z0/Bemfte5HFhjv28wxP3/1PTiJTFTAC/Ikdt5L1FxB0+FNDav9FDUwcB8QjzA==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793774408;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=QM0NVH0cM+4ZpfVNA+64ursRYzC14LgzNdyXgZtFgX0=;
	b=NRZHG+H2eLDKirNnnEBnRiPESXnZmPEC3NQK81fnMgOIWbdjNAhkX7OVR+oW+pXDRAaK
	 87YwWAnPgSy1C+2XPYtd4moi3nrmTYeqm1n39f/1Furjx8i5uPzS62lRZNzzw6pfRLG2o
	 btHLn3yA/RAJHhmsY92q+yzHM4lOFqlHZqu6FE5Ex9tgHPa/K1Wt9idcU5WpCcIKyns99
	 hwF6RfbF2NLHA9eGlN0hhGsv8X4xwkNS6FgtLKt06LzJLbHovOZAiHqqIIgBD8dHEKMAK
	 /f2gl8ZxMNm2u8UYUOR4qxp0yZfIyKh8Hsy9ajfxzUvPOZaoA+uJwJbFXYF4by0KjEg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 72AED1F00A15;
	Wed,  4 Nov 2026 06:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793774408;
	bh=QM0NVH0cM+4ZpfVNA+64ursRYzC14LgzNdyXgZtFgX0=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=XEjRnMMW6Uv0bRCEO9oFy9u/vnjqj/DGLg6d/F4Wl3rhkWhrSQKmcvNmvppb+8SQ+
	 kQDy38HoGhteblPbut1+U4TYg98GgtHjsPbd/DZO6dY8o/qIragCkugg7VouygYqKF
	 4coEjDb7AnPGUeGHxLPrBS0WHe1J/xQXEM862jAGiu4vN1AjafkM+4y1qv80hjJdCH
	 fOdl3HqmxA3Z3GmZ4kg/BF/GQvmrOFTf0Idg7hX8dJh+EeCn9vbb/ds9tgQ7148tIp
	 5OLsWTDUVt1wEU/K0QmG8pU2Em2VkeUeIf9CQHd5qB8YMM4MKU+/qtnoarbZ08tTNW
	 mYn1lTWVN/13w==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 041ED46CC7;
	Wed,  4 Nov 2026 06:40:06 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Wed, 04 Nov 2026 07:40:05 +0100
Subject: [PATCH net v5 4/4] igb: drop AF_XDP zero-copy frames that span
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
Message-Id: <20261104-igb-rx-ts-fix-v5-4-bf4b4367129a@aweta.nl>
References: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
In-Reply-To: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793774404; l=3174;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=MkRF1V1g+97bXmg40zLUInt45xqgM/uhRHUJw6aF5q4=;
 b=5tLdWEbOPlIseyGjFHZUz7pLUptV5ZFvFzMDviMEiMJn7X3oDd3o1LhwK8jL8bbyqnyzYkk/Z
 +2nppyaYkr/DjOJt/1/Vjo80CY3L4/Yrb5INyDj9uCuW0SVnCsbshDK
X-Developer-Key: i=tkusters@aweta.nl; a=ed25519;
 pk=JYRpYQ3+LrphEabgnxcbiOUpwvNP8WDDMcLzz+cwKsk=
X-Endpoint-Received: by B4 Relay for tkusters@aweta.nl/20260619 with
 auth_id=831
X-Original-From: Tjerk Kusters <tkusters@aweta.nl>
Reply-To: tkusters@aweta.nl
Content-Transfer-Encoding: 7bit

From: Tjerk Kusters <tkusters@aweta.nl>

igb_clean_rx_irq_zc() handles every descriptor as a complete frame and
strips the inline Rx timestamp header from each of them. If a frame
spans several descriptors, the AF_XDP socket gets its later buffers as
separate packets without headers. If such a buffer is shorter than the
header, the size wraps and the XDP program sees data past data_end. On
XDP_PASS, igb_construct_skb_zc() then fails to allocate an skb, and the
queue can stall on that descriptor.

The previous patches make sure that frames fit in one buffer while XDP
is attached. As ixgbe does, also drop any frame that still spans several
descriptors instead of passing its buffers on: free the buffers without
EOP, and the EOP buffer that ends such a frame. The state is kept in a
ring flag, as a frame can be split over two NAPI polls.

This depends on the previous patch. Without it, every full-size frame
on 2 KiB chunks spans two buffers and would be dropped.

Not reproduced on hardware, as with the previous patches the I350 no
longer splits frames in zero-copy mode.

Fixes: 2c6196013f84 ("igb: Add AF_XDP zero-copy Rx support")
Cc: stable@vger.kernel.org
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
 drivers/net/ethernet/intel/igb/igb.h     |  1 +
 drivers/net/ethernet/intel/igb/igb_xsk.c | 23 +++++++++++++++++++++++
 2 files changed, 24 insertions(+)

diff --git a/drivers/net/ethernet/intel/igb/igb.h b/drivers/net/ethernet/intel/igb/igb.h
index 0495c02544d6..6613ea0eedb8 100644
--- a/drivers/net/ethernet/intel/igb/igb.h
+++ b/drivers/net/ethernet/intel/igb/igb.h
@@ -393,6 +393,7 @@ enum e1000_ring_flags_t {
 	IGB_RING_FLAG_TX_DETECT_HANG,
 	IGB_RING_FLAG_TX_DISABLED,
 	IGB_RING_FLAG_RX_ALLOC_FAILED,
+	IGB_RING_FLAG_RX_XSK_DISCARD,
 };
 
 #define ring_uses_large_buffer(ring) \
diff --git a/drivers/net/ethernet/intel/igb/igb_xsk.c b/drivers/net/ethernet/intel/igb/igb_xsk.c
index fb04df82272a..7b098069fff2 100644
--- a/drivers/net/ethernet/intel/igb/igb_xsk.c
+++ b/drivers/net/ethernet/intel/igb/igb_xsk.c
@@ -269,6 +269,8 @@ void igb_clean_rx_ring_zc(struct igb_ring *rx_ring)
 	u16 ntc = rx_ring->next_to_clean;
 	u16 ntu = rx_ring->next_to_use;
 
+	clear_bit(IGB_RING_FLAG_RX_XSK_DISCARD, &rx_ring->flags);
+
 	while (ntc != ntu) {
 		struct xdp_buff *xdp = rx_ring->rx_buffer_info_zc[ntc];
 
@@ -390,6 +392,27 @@ int igb_clean_rx_irq_zc(struct igb_q_vector *q_vector,
 		dma_rmb();
 
 		xdp = rx_ring->rx_buffer_info_zc[ntc];
+
+		/* A frame should never span several buffers here, see
+		 * igb_xsk_frame_fits(). If one does, drop all its buffers.
+		 */
+		if (unlikely(!igb_test_staterr(rx_desc, E1000_RXD_STAT_EOP) ||
+			     test_bit(IGB_RING_FLAG_RX_XSK_DISCARD,
+				      &rx_ring->flags))) {
+			if (igb_test_staterr(rx_desc, E1000_RXD_STAT_EOP))
+				clear_bit(IGB_RING_FLAG_RX_XSK_DISCARD,
+					  &rx_ring->flags);
+			else
+				set_bit(IGB_RING_FLAG_RX_XSK_DISCARD,
+					&rx_ring->flags);
+
+			xsk_buff_free(xdp);
+			ntc++;
+			if (ntc == rx_ring->count)
+				ntc = 0;
+			continue;
+		}
+
 		xsk_buff_set_size(xdp, size);
 		xsk_buff_dma_sync_for_cpu(xdp);
 

-- 
2.27.0


