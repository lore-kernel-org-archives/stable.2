Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42A263B95F6
	for <stable@vger.kernel.org>; Mon, 10 Aug 2026 23:51:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786405889; cv=none; b=mak6+2LQe1Ted9xEcBnF/jwp6XCZcF36pUVXb5DR7QbmDdkFdJQdO6JCZN2U04mnYYZcUYtZr/c5UYJItYTTb5TPlUHFQsfcAazJs1Wv7wmJ5ZJnCmxV5B/bKeP+vTMpDH9mwSm7jjg9HMkREEemOOY6/nSLZA3k/8/OsPsAEdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786405889; c=relaxed/simple;
	bh=uTz4bPzTyqpqaLSjOMUiLLoJ8sPw78CaaDRbEgMReSk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=i/Za5Ws8QAeGmwNtzP0aIQxXDeynH13x8k5Hvk3GAT2vWCgU3rtbl3D6NfDv29IGzx8/AJVTtwegI7Nlg38VHG8jMOj1o0/jAinR4lkN6OnPvnKr9zT/6spVVQOEW0XQVrOtfq/aINYwQ1NJKZmX7Hro9PTfQCIGTNcW8ZoJUOM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C47bGFat; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C47bGFat"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29AE71F00A3D;
	Mon, 10 Aug 2026 23:51:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786405887;
	bh=mihek7uK9NuCLBIKNhrP21Xbb/XGd70CD4cakE0mR9g=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=C47bGFatlilVK4Y8fzJsZeiMLH9m+AYWKQ0ryJ0tjuUESGc/zImsRoeaCwbQ2/8y3
	 2hIjnu+qlqV4ZSvmH+kuV6+DbwNew8emslIMFEpFIenrHdNJPjCTcmehqn5TVbZk2Y
	 8C6lSJcbj0wb4OOwd9Z7HOW0F6j58CIu82KldJWU4yY2qqZBcOnXb7xnBOoKHB0/If
	 WNKuTwTNkl4wdY7IUuh8rgsfcaa6yqODCMIXGi5r2V+FZvLv9ZAQHEZz/CpdJgw3oQ
	 71zbx/zyv+7xO6hcCXpVl6d/WLAKm8ZpkPJmOTjTkuQUtl1yaz6/p6+0G9uBLu7XPN
	 nVHiDCqXmoswg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Maciej Fijalkowski <maciej.fijalkowski@intel.com>,
	Magnus Karlsson <magnus.karlsson@intel.com>,
	Simon Horman <horms@kernel.org>,
	Chandan Kumar Rout <chandanx.rout@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/7] ice: make ice_vsi_cfg_rxq() static
Date: Mon, 10 Aug 2026 19:51:19 -0400
Message-ID: <20260810235124.3217231-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260810235124.3217231-1-sashal@kernel.org>
References: <2026080500-repeater-crust-fca2@gregkh>
 <20260810235124.3217231-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Maciej Fijalkowski <maciej.fijalkowski@intel.com>

[ Upstream commit 3e5fb691faee1d43ee13d4ce2666b0a05e1555b3 ]

Currently, XSK control path in ice driver calls directly
ice_vsi_cfg_rxq() whereas we have ice_vsi_cfg_single_rxq() for that
purpose. Use the latter from XSK side and make ice_vsi_cfg_rxq() static.

ice_vsi_cfg_rxq() resides in ice_base.c and is rather big, so to reduce
the code churn let us move two callers of it from ice_lib.c to
ice_base.c.

Signed-off-by: Maciej Fijalkowski <maciej.fijalkowski@intel.com>
Acked-by: Magnus Karlsson <magnus.karlsson@intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Chandan Kumar Rout <chandanx.rout@intel.com> (A Contingent Worker at Intel)
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Stable-dep-of: cdc36db204ff ("Bluetooth: hci_sync: Fix advertising data UAFs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_base.c | 58 ++++++++++++++++++++++-
 drivers/net/ethernet/intel/ice/ice_base.h |  3 +-
 drivers/net/ethernet/intel/ice/ice_lib.c  | 56 ----------------------
 drivers/net/ethernet/intel/ice/ice_lib.h  |  4 --
 drivers/net/ethernet/intel/ice/ice_xsk.c  |  2 +-
 5 files changed, 60 insertions(+), 63 deletions(-)

diff --git a/drivers/net/ethernet/intel/ice/ice_base.c b/drivers/net/ethernet/intel/ice/ice_base.c
index 9a0682b05c4ff..cba3ed89860ba 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.c
+++ b/drivers/net/ethernet/intel/ice/ice_base.c
@@ -544,7 +544,7 @@ static unsigned int ice_get_frame_sz(struct ice_rx_ring *rx_ring)
  *
  * Return 0 on success and a negative value on error.
  */
-int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
+static int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 {
 	struct device *dev = ice_pf_to_dev(ring->vsi->back);
 	u32 num_bufs = ICE_RX_DESC_UNUSED(ring);
@@ -637,6 +637,62 @@ int ice_vsi_cfg_rxq(struct ice_rx_ring *ring)
 	return 0;
 }
 
+int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx)
+{
+	if (q_idx >= vsi->num_rxq)
+		return -EINVAL;
+
+	return ice_vsi_cfg_rxq(vsi->rx_rings[q_idx]);
+}
+
+/**
+ * ice_vsi_cfg_frame_size - setup max frame size and Rx buffer length
+ * @vsi: VSI
+ */
+static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi)
+{
+	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags)) {
+		vsi->max_frame = ICE_MAX_FRAME_LEGACY_RX;
+		vsi->rx_buf_len = ICE_RXBUF_1664;
+#if (PAGE_SIZE < 8192)
+	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
+		   (vsi->netdev->mtu <= ETH_DATA_LEN)) {
+		vsi->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
+		vsi->rx_buf_len = ICE_RXBUF_1536 - NET_IP_ALIGN;
+#endif
+	} else {
+		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
+		vsi->rx_buf_len = ICE_RXBUF_3072;
+	}
+}
+
+/**
+ * ice_vsi_cfg_rxqs - Configure the VSI for Rx
+ * @vsi: the VSI being configured
+ *
+ * Return 0 on success and a negative value on error
+ * Configure the Rx VSI for operation.
+ */
+int ice_vsi_cfg_rxqs(struct ice_vsi *vsi)
+{
+	u16 i;
+
+	if (vsi->type == ICE_VSI_VF)
+		goto setup_rings;
+
+	ice_vsi_cfg_frame_size(vsi);
+setup_rings:
+	/* set up individual rings */
+	ice_for_each_rxq(vsi, i) {
+		int err = ice_vsi_cfg_rxq(vsi->rx_rings[i]);
+
+		if (err)
+			return err;
+	}
+
+	return 0;
+}
+
 /**
  * __ice_vsi_get_qs - helper function for assigning queues from PF to VSI
  * @qs_cfg: gathered variables needed for pf->vsi queues assignment
diff --git a/drivers/net/ethernet/intel/ice/ice_base.h b/drivers/net/ethernet/intel/ice/ice_base.h
index b67dca417acb2..4c1f8d33b976b 100644
--- a/drivers/net/ethernet/intel/ice/ice_base.h
+++ b/drivers/net/ethernet/intel/ice/ice_base.h
@@ -6,7 +6,8 @@
 
 #include "ice.h"
 
-int ice_vsi_cfg_rxq(struct ice_rx_ring *ring);
+int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx);
+int ice_vsi_cfg_rxqs(struct ice_vsi *vsi);
 int __ice_vsi_get_qs(struct ice_qs_cfg *qs_cfg);
 int
 ice_vsi_ctrl_one_rx_ring(struct ice_vsi *vsi, bool ena, u16 rxq_idx, bool wait);
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.c b/drivers/net/ethernet/intel/ice/ice_lib.c
index 7aef40b50b898..9f4d1976e34c9 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_lib.c
@@ -1696,27 +1696,6 @@ static void ice_vsi_set_rss_flow_fld(struct ice_vsi *vsi)
 			vsi_num, status);
 }
 
-/**
- * ice_vsi_cfg_frame_size - setup max frame size and Rx buffer length
- * @vsi: VSI
- */
-static void ice_vsi_cfg_frame_size(struct ice_vsi *vsi)
-{
-	if (!vsi->netdev || test_bit(ICE_FLAG_LEGACY_RX, vsi->back->flags)) {
-		vsi->max_frame = ICE_MAX_FRAME_LEGACY_RX;
-		vsi->rx_buf_len = ICE_RXBUF_1664;
-#if (PAGE_SIZE < 8192)
-	} else if (!ICE_2K_TOO_SMALL_WITH_PADDING &&
-		   (vsi->netdev->mtu <= ETH_DATA_LEN)) {
-		vsi->max_frame = ICE_RXBUF_1536 - NET_IP_ALIGN;
-		vsi->rx_buf_len = ICE_RXBUF_1536 - NET_IP_ALIGN;
-#endif
-	} else {
-		vsi->max_frame = ICE_AQ_SET_MAC_FRAME_SIZE_MAX;
-		vsi->rx_buf_len = ICE_RXBUF_3072;
-	}
-}
-
 /**
  * ice_pf_state_is_nominal - checks the PF for nominal state
  * @pf: pointer to PF to check
@@ -1823,14 +1802,6 @@ ice_write_qrxflxp_cntxt(struct ice_hw *hw, u16 pf_q, u32 rxdid, u32 prio,
 	wr32(hw, QRXFLXP_CNTXT(pf_q), regval);
 }
 
-int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx)
-{
-	if (q_idx >= vsi->num_rxq)
-		return -EINVAL;
-
-	return ice_vsi_cfg_rxq(vsi->rx_rings[q_idx]);
-}
-
 int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings, u16 q_idx)
 {
 	struct ice_aqc_add_tx_qgrp *qg_buf;
@@ -1850,33 +1821,6 @@ int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings, u
 	return err;
 }
 
-/**
- * ice_vsi_cfg_rxqs - Configure the VSI for Rx
- * @vsi: the VSI being configured
- *
- * Return 0 on success and a negative value on error
- * Configure the Rx VSI for operation.
- */
-int ice_vsi_cfg_rxqs(struct ice_vsi *vsi)
-{
-	u16 i;
-
-	if (vsi->type == ICE_VSI_VF)
-		goto setup_rings;
-
-	ice_vsi_cfg_frame_size(vsi);
-setup_rings:
-	/* set up individual rings */
-	ice_for_each_rxq(vsi, i) {
-		int err = ice_vsi_cfg_rxq(vsi->rx_rings[i]);
-
-		if (err)
-			return err;
-	}
-
-	return 0;
-}
-
 /**
  * ice_vsi_cfg_txqs - Configure the VSI for Tx
  * @vsi: the VSI being configured
diff --git a/drivers/net/ethernet/intel/ice/ice_lib.h b/drivers/net/ethernet/intel/ice/ice_lib.h
index f24f5d1e6f9c7..10f7debb71f2d 100644
--- a/drivers/net/ethernet/intel/ice/ice_lib.h
+++ b/drivers/net/ethernet/intel/ice/ice_lib.h
@@ -54,12 +54,8 @@ bool ice_pf_state_is_nominal(struct ice_pf *pf);
 
 void ice_update_eth_stats(struct ice_vsi *vsi);
 
-int ice_vsi_cfg_single_rxq(struct ice_vsi *vsi, u16 q_idx);
-
 int ice_vsi_cfg_single_txq(struct ice_vsi *vsi, struct ice_tx_ring **tx_rings, u16 q_idx);
 
-int ice_vsi_cfg_rxqs(struct ice_vsi *vsi);
-
 int ice_vsi_cfg_lan_txqs(struct ice_vsi *vsi);
 
 void ice_vsi_cfg_msix(struct ice_vsi *vsi);
diff --git a/drivers/net/ethernet/intel/ice/ice_xsk.c b/drivers/net/ethernet/intel/ice/ice_xsk.c
index 9a9b8698881b4..6b9b798d04cea 100644
--- a/drivers/net/ethernet/intel/ice/ice_xsk.c
+++ b/drivers/net/ethernet/intel/ice/ice_xsk.c
@@ -252,7 +252,7 @@ static int ice_qp_ena(struct ice_vsi *vsi, u16 q_idx)
 		ice_tx_xsk_pool(vsi, q_idx);
 	}
 
-	err = ice_vsi_cfg_rxq(rx_ring);
+	err = ice_vsi_cfg_single_rxq(vsi, q_idx);
 	if (err)
 		goto free_buf;
 
-- 
2.53.0

