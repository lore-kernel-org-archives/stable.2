Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 507F7403138
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 09:11:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786525898; cv=none; b=nomh8IPJig7fhUfICEpXts1ISJcJ1rLrRYzmHMSD+MhVqFAvvXgJzD1VQUN1gmPdQjo/urqcauf5beXT/xlbOutLpFGAUi1+whi/012/jqdD0WJEmueajJkjGjaF36JNPaNGDaAmODFeEBD46eE/3oLtARrCiZPYxC1mp/LGRN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786525898; c=relaxed/simple;
	bh=3D06h8UW9gn72jJzR42kzb24onvpH27DoLIT23jGTwY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PjNuHw/70dQRPNPe1J0tt8Q1gJy2omch9hwoPnxHenDDQlXb1h2LnvlrFSqFnzp1yoy9Q3/xAJidNAasmNKDf73QPAfgNKAV4aQy4AhcrognL7QucihQUjaZ7MDLX5LSNCDaJWAAA94ApAZ/TCJQOAQTmv/ngbTqF4F4oJDm68k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OSjQKH9x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OSjQKH9x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9C2B1F00A3A;
	Wed, 12 Aug 2026 09:11:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786525895;
	bh=0YyKOi7tTR6JW230AbrSX0J6nAI32FeKHr6rWu94kp8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OSjQKH9xT7OwNbeaLu6MRHgkABcyxbZVDZDMbHyfa4pKwvOQWCcJrztm2iwDj0OSF
	 XUS1EB96iSnANAGvbxb1kKXoxBEzmnO5OQGX1m8K4hPNada9OVihh5q/fRtuXLlzqR
	 DFqgjJ3NZXhGnLXlgCpnMR+gVYdbVGyS++a6qu2Sc/txJXhD1uIm4yOyf9t6uNpSIs
	 0EHV4AAncOdh+QQANn5hjVbzxn9fJZSjMDVnU3/QuU2SLiMlsmK5YWt1novyLRNB4o
	 uj4fdB9sSsblNIujDvPjrytFIbimbqMhwMd3xW3SzSLTbOpCDtGh+LGc78kEkVgqGm
	 R4N2tlJw2DMkw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Patryk Holda <patryk.holda@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] ice: fix VF interrupts cleanup
Date: Wed, 12 Aug 2026 05:11:33 -0400
Message-ID: <20260812091133.1349855-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080514-dexterous-registry-f915@gregkh>
References: <2026080514-dexterous-registry-f915@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>

[ Upstream commit fb096882095e5a8d6b5159e43793d4a38a0c5b1f ]

When a virtual function sends an IRQ map command, the PF will set up
interrupts according to that request. However, because these interrupts are
never reset, the next time Virtual Function initializes, the interrupts are
still enabled for a given VF, which leads to performance degradation in
certain cases due to interrupts being unexpectedly enabled and thus causing
interrupt floods.

Cc: stable@vger.kernel.org
Fixes: 1071a8358a28 ("ice: Implement virtchnl commands for AVF support")
Suggested-by: Vladimir Medvedkin <vladimir.medvedkin@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>
Reviewed-by: Simon Horman <horms@kernel.org>
Tested-by: Patryk Holda <patryk.holda@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 .../net/ethernet/intel/ice/ice_virtchnl_pf.c  | 48 +++++++++++++++++++
 1 file changed, 48 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
index f93551ee3cb4f..da40c8a3b72b4 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl_pf.c
@@ -1587,6 +1587,30 @@ static bool ice_is_vf_disabled(struct ice_vf *vf)
 		test_bit(ICE_VF_STATE_DIS, vf->vf_states));
 }
 
+/**
+ * ice_reset_interrupts - clear all queue interrupt configuration for a VSI
+ * @vsi: the VSI whose interrupt registers should be cleared
+ *
+ * Zero the QINT_RQCTL and QINT_TQCTL registers for all allocated queues
+ * in the VSI. This clears the entire register including MSIX_INDX, ITR_INDX,
+ * CAUSE_ENA and NEXTQ fields, unlike ice_vf_dis_rxq_interrupt() which only
+ * clears the CAUSE_ENA bit.
+ */
+static void ice_reset_interrupts(struct ice_vsi *vsi)
+{
+	struct ice_pf *pf = vsi->back;
+	struct ice_hw *hw = &pf->hw;
+	int i;
+
+	ice_for_each_alloc_rxq(vsi, i)
+		wr32(hw, QINT_RQCTL(vsi->rxq_map[i]), 0);
+
+	ice_for_each_alloc_txq(vsi, i)
+		wr32(hw, QINT_TQCTL(vsi->txq_map[i]), 0);
+
+	ice_flush(hw);
+}
+
 /**
  * ice_reset_vf - Reset a particular VF
  * @vf: pointer to the VF structure
@@ -1630,6 +1654,9 @@ bool ice_reset_vf(struct ice_vf *vf, bool is_vflr)
 
 	ice_dis_vf_qs(vf);
 
+	/* cleanup interrupt registers */
+	ice_reset_interrupts(vsi);
+
 	/* Call Disable LAN Tx queue AQ whether or not queues are
 	 * enabled. This is needed for successful completion of VFR.
 	 */
@@ -3167,6 +3194,24 @@ static void ice_vf_ena_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx)
 	wr32(hw, QINT_RQCTL(pfq), reg | QINT_RQCTL_CAUSE_ENA_M);
 }
 
+/**
+ * ice_vf_dis_rxq_interrupt - disable Rx queue interrupt via QINT_RQCTL
+ * @vsi: VSI of the VF to configure
+ * @q_idx: VF queue index used to determine the queue in the PF's space
+ */
+static void ice_vf_dis_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx)
+{
+	struct ice_hw *hw = &vsi->back->hw;
+	u32 pfq = vsi->rxq_map[q_idx];
+	u32 reg;
+
+	reg = rd32(hw, QINT_RQCTL(pfq));
+	reg &= ~QINT_RQCTL_CAUSE_ENA_M;
+	wr32(hw, QINT_RQCTL(pfq), reg);
+
+	ice_flush(hw);
+}
+
 /**
  * ice_vc_ena_qs_msg
  * @vf: pointer to the VF info
@@ -3336,6 +3381,8 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 			goto error_param;
 		}
 
+		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF)
+			ice_vf_dis_rxq_interrupt(vsi, vf_q_id);
 		bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
 	} else if (q_map) {
 		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
@@ -3356,6 +3403,7 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 				goto error_param;
 			}
 
+			ice_vf_dis_rxq_interrupt(vsi, vf_q_id);
 			/* Clear enabled queues flag */
 			clear_bit(vf_q_id, vf->rxq_ena);
 		}
-- 
2.53.0

