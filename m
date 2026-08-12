Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7584B2E8B9B
	for <stable@vger.kernel.org>; Wed, 12 Aug 2026 00:15:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786493743; cv=none; b=a8F6Yeck+XpyOiPO3MinrhHuIvuKWDFIhlNVcqqtfxk7TY1FEbtYZoaLvzdEXz/Ujy5z19xxhNqyalzhDrtj9wXVq08RmC+jDTCy42tLXmDXGSQmVUasiBkUVImywXH03Pia2Lt8L65etFYlq5RchlwW8/Jxxp6GhO54IYJg3kQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786493743; c=relaxed/simple;
	bh=B6oONh2mJTjcz/nCtT6ovayxuc04Vo0ptIOVKvmEsT8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=iPbScG6RvgKQt5lk3nDBcZEH7EYwkvSyeCV28836maC1cPZv3NzG+bP70kJJmMZOmZZ2lVlEQYgidJaZgOP4uMwEfEjP5TJ1gvXAjMcLZjKWnRq/f/y31s+joFDFmdDfVP6DOFCOu6hg0LmtcPAZxGwiFziUTvnGFK1XsbVGUrM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=b5H3+i2T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="b5H3+i2T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A1471F000E9;
	Wed, 12 Aug 2026 00:15:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786493742;
	bh=THqi92dOjmKDTRWADy/2qgZIKVfvNZ/+2tKl1QWgBoQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=b5H3+i2T0y/3wP3qUV1ZDyIfKtHKUWF0fTHIYTgmwy9vUb4393fRZxU+zCD0ouVSR
	 lOfKvFwG2+dTZBCtAAKX2a2HmLaGHneoERrISCZih5rlBRiiOyrCSQg9eJoPRsoM4o
	 le9MWvXOXLI8idVJoqu5lOTu5ixaxLX7eTa7H0auXU+A+4l784zY5VvKZ4HXw1fIv1
	 MdobLTuvxKNR3WfBDE9FGwlz5LqP37A2LyM9qs+N/wlMEW3acB6KKs7rpjafLCpFLn
	 2i6aFX3Qh5/7Pn2AM5CuseqZIGomgFhm1rUvDP3ja3CuWeKLdpkbsPI4Y71TVKQKGk
	 8ImMnLl6CQWLA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Dawid Osuchowski <dawid.osuchowski@linux.intel.com>,
	Vladimir Medvedkin <vladimir.medvedkin@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Simon Horman <horms@kernel.org>,
	Patryk Holda <patryk.holda@intel.com>,
	Tony Nguyen <anthony.l.nguyen@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] ice: fix VF interrupts cleanup
Date: Tue, 11 Aug 2026 20:15:39 -0400
Message-ID: <20260812001539.4180728-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026080514-crunching-caretaker-77b9@gregkh>
References: <2026080514-crunching-caretaker-77b9@gregkh>
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
[ changed the file path for the `ice_vf_ena_rxq_interrupt` hunk from `ice/virt/queues.c` to `ice_virtchnl.c`, which predates the upstream directory split ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/net/ethernet/intel/ice/ice_vf_lib.c   | 27 +++++++++++++++++++
 .../ethernet/intel/ice/ice_vf_lib_private.h   |  1 +
 drivers/net/ethernet/intel/ice/ice_virtchnl.c | 21 +++++++++++++++
 3 files changed, 49 insertions(+)

diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib.c b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
index fe4a641ce70dc..4bca813ceac28 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib.c
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib.c
@@ -832,6 +832,30 @@ static void ice_notify_vf_reset(struct ice_vf *vf)
 			      NULL);
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
+void ice_reset_interrupts(struct ice_vsi *vsi)
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
@@ -914,6 +938,9 @@ int ice_reset_vf(struct ice_vf *vf, u32 flags)
 
 	ice_dis_vf_qs(vf);
 
+	/* cleanup interrupt registers */
+	ice_reset_interrupts(vsi);
+
 	/* Call Disable LAN Tx queue AQ whether or not queues are
 	 * enabled. This is needed for successful completion of VFR.
 	 */
diff --git a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
index 5392b04049862..321d29c25b7c1 100644
--- a/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
+++ b/drivers/net/ethernet/intel/ice/ice_vf_lib_private.h
@@ -26,6 +26,7 @@
 void ice_initialize_vf_entry(struct ice_vf *vf);
 void ice_deinitialize_vf_entry(struct ice_vf *vf);
 void ice_dis_vf_qs(struct ice_vf *vf);
+void ice_reset_interrupts(struct ice_vsi *vsi);
 int ice_check_vf_init(struct ice_vf *vf);
 enum virtchnl_status_code ice_err_to_virt_err(int err);
 struct ice_port_info *ice_vf_get_port_info(struct ice_vf *vf);
diff --git a/drivers/net/ethernet/intel/ice/ice_virtchnl.c b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
index 61c40219de1a0..fb4744f97143b 100644
--- a/drivers/net/ethernet/intel/ice/ice_virtchnl.c
+++ b/drivers/net/ethernet/intel/ice/ice_virtchnl.c
@@ -1215,6 +1215,24 @@ static void ice_vf_ena_rxq_interrupt(struct ice_vsi *vsi, u32 q_idx)
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
@@ -1408,6 +1426,8 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 			goto error_param;
 		}
 
+		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF)
+			ice_vf_dis_rxq_interrupt(vsi, vf_q_id);
 		bitmap_zero(vf->rxq_ena, ICE_MAX_RSS_QS_PER_VF);
 	} else if (q_map) {
 		for_each_set_bit(vf_q_id, &q_map, ICE_MAX_RSS_QS_PER_VF) {
@@ -1428,6 +1448,7 @@ static int ice_vc_dis_qs_msg(struct ice_vf *vf, u8 *msg)
 				goto error_param;
 			}
 
+			ice_vf_dis_rxq_interrupt(vsi, vf_q_id);
 			/* Clear enabled queues flag */
 			clear_bit(vf_q_id, vf->rxq_ena);
 		}
-- 
2.53.0

