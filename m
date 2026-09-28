Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1FC0503913;
	Mon, 28 Sep 2026 23:04:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=198.175.65.13
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790636688; cv=none; b=Bsc8uvvS0XzBcAZuVsBvxrKXrT42LzEAMVTvihPs/UBSSXLaS5mUPJkXAZc8ySbyEDFVRB4RjHbx9JkbIDYvFhU04qGu01sVc+9wVyt4i1XLxbvSdYM+K2mIlTcVvFLoHxC8xZV1agkesDP40ZVCn6LNqDO8/0TrfEXcpsjnMNU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790636688; c=relaxed/simple;
	bh=LhISRdCeYQaV8oZZw1JSrz3A6VTN+dthxINB9wuVqDI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rvAfQAFu8sylkzAQd2BojVe62SjY+WZ7Xus2S7zX54gqryEquemnqhNxkP8r5F8+OWJsxz0XXeCt+wxDjuCddY0TP3qvUKmQgjCkQ1VX/zz67F/cPSFXiAyvQ2T8oDPA+WpqPlrh7tagSz1cKXdZyt/Bq1r17tfMJchjY/qP8pE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=B1hVruV8; arc=none smtp.client-ip=198.175.65.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="B1hVruV8"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790636687; x=1822172687;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LhISRdCeYQaV8oZZw1JSrz3A6VTN+dthxINB9wuVqDI=;
  b=B1hVruV87wuKbt0UjsExusphN02vRzHUK4h2FWL9wgcnxScPYzqZbnld
   k/5pynbU8HZDJ+b37dSaj7MFm+pPVH/VcsTHvaVkHDnfdF/FAYirAW5Ks
   /zxpp9WRN2OmAAPc+g53/16OgXOjXAZk4dyCGLHNMSGFcheggbgj2M8/L
   c2hd/2q5ejmtK3G2T4QB8v1SiCsdIsX7+YWdmesMAMu/5PK8PrbZtRDBM
   R3FUVsXpf280utheYxHQlU+kdgvDaPPVIHKOMlHqm+KWpHFPGX0SfA2d1
   Y/9AyU1B3pdn3+FcveEMwqJgGQfkWpI9sNnD/VUUYN+f6tHxBnBW+7Z3t
   g==;
X-CSE-ConnectionGUID: /Inz3CFiSPaT1DIb9j+4pw==
X-CSE-MsgGUID: jlurji/FSVynQ97pE57j9A==
X-IronPort-AV: E=McAfee;i="6800,10657,11919"; a="101513300"
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="101513300"
Received: from orviesa010.jf.intel.com ([10.64.159.150])
  by orvoesa105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2026 16:04:43 -0700
X-CSE-ConnectionGUID: Ovb8QxAYQ2CIs5mLNQqdcA==
X-CSE-MsgGUID: QZCiRPGrQ1S9W0dPeW2koQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,129,1787036400"; 
   d="scan'208";a="273317698"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa010.jf.intel.com with ESMTP; 28 Sep 2026 16:04:43 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Dave Butler <david.butler@appgate.com>,
	anthony.l.nguyen@intel.com,
	emil.s.tantilov@intel.com,
	luoxuanqiang@kylinos.cn,
	bryan.fraschetti@canonical.com,
	tristan@talencesecurity.com,
	tomasz.lichwala@linux.intel.com,
	horms@kernel.org,
	aleksander.lobakin@intel.com,
	stable@vger.kernel.org,
	Jacob Keller <jacob.e.keller@intel.com>,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Subject: [PATCH net 6/6] iavf: cap advertised max_pkt_size at the single-buffer HW limit
Date: Mon, 28 Sep 2026 16:04:27 -0700
Message-ID: <20260928230429.495442-7-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
References: <20260928230429.495442-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Dave Butler <david.butler@appgate.com>

Since commit 5fa4caff59f2 ("iavf: switch to Page Pool")
iavf_configure_queues() advertises max_pkt_size to the PF as:

	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);
	max_frame = min_not_zero(adapter->vf_res->max_mtu, max_frame);

LIBIE_MAX_RX_FRM_LEN (16382) is the multi-descriptor scatter/gather frame
ceiling, not a single-queue value, and it exceeds the E810 MAC frame size
maximum of 9728. Per the E810 datasheet (613875-009 section 13.2.2.17.1)
the Tx frame-size register PRTDCB_TDPUC.MAX_TXFRAME has a maximum of
0x2600 (9728); larger frames are discarded. The in-tree ice driver encodes
the same value as ICE_AQ_SET_MAC_FRAME_SIZE_MAX (== LIBIE_MAX_RX_BUF_LEN ==
9728), and the VF clamped max_frame to IAVF_MAX_RXBUFFER (9728) before this
commit.

When the PF advertises vf_res->max_mtu as 0, min_not_zero() leaves
max_frame at 16382. The Linux ice PF advertises max_mtu = port MAC frame
size (<= 9728), so a VF behind ice never sends more than that. The ESXi
"icen" PF on E810 advertises max_mtu as 0, so the VF sends
max_pkt_size = 16382, which icen rejects while programming the queue
context for VIRTCHNL_OP_CONFIG_VSI_QUEUES (opcode 6):

	icen_ConfigureTxQueue: VSI 8: Failed to set LAN Tx queue context for
	                       absolute Tx queue 64, Error: ICE_ERR_PARAM
	indrv_SendMsgToVf: VF 0: Failed opcode 6, Error -5

	iavf 0000:03:00.0: PF returned error -5 (IAVF_ERR_PARAM) to our request 6
	iavf 0000:03:00.0 ethX: NETDEV WATCHDOG: transmit queue N timed out

The VF's queues never come up; under SR-IOV passthrough the mis-programmed
queue can also trigger a fatal IOMMU fault in the guest. Forcing only
max_pkt_size back to 9728 (and leaving the Page Pool rx_buf_len/
databuffer_size untouched) makes the VF come up; databuffer_size is not
involved. This was confirmed on two E810 NVM revisions (3.00 and 4.51) and
two icen versions (1.14.2.0 and the latest 2.3.3.0): all reject the
unpatched VF and accept the patched one, so the trigger is the icen PF
behaviour, not the firmware or icen revision. Reported by several users on
E810 + ESXi icen with v6.10+ guests:

Link: https://community.intel.com/t5/Ethernet-Products/E810-C-iavf-driver-issue-on-Linux-6-12/m-p/1737490
Link: https://access.redhat.com/solutions/6973766
Link: https://knowledge.broadcom.com/external/article/404315/sriov-enabled-vms-network-adaptor-goes-d.html

Cap max_frame at the single-buffer hardware limit, restoring the
pre-Page-Pool behaviour while keeping the Page Pool rx_buf_len unchanged.

Cc: stable@vger.kernel.org # v6.10+
Fixes: 5fa4caff59f2 ("iavf: switch to Page Pool")
Signed-off-by: Dave Butler <david.butler@appgate.com>
Acked-by: Jacob Keller <jacob.e.keller@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/iavf/iavf_virtchnl.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
index ec234cc8bd9d..680a28a739bf 100644
--- a/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
+++ b/drivers/net/ethernet/intel/iavf/iavf_virtchnl.c
@@ -382,6 +382,14 @@ void iavf_configure_queues(struct iavf_adapter *adapter)
 
 	max_frame = LIBIE_MAX_RX_FRM_LEN(adapter->rx_rings->pp->p.offset);
 	max_frame = min_not_zero(adapter->vf_res->max_mtu, max_frame);
+	/* The PF programs max_pkt_size into the per-queue Rx context "rxmax".
+	 * LIBIE_MAX_RX_FRM_LEN is the multi-descriptor (S/G) frame ceiling
+	 * (16382), but that exceeds the E810 max MAC frame size (9728); some
+	 * PFs reject the out-of-range value with VIRTCHNL_STATUS_ERR_PARAM.
+	 * Cap it at the single-buffer HW limit (== the MAC frame max),
+	 * restoring the pre-Page-Pool behaviour.
+	 */
+	max_frame = min(max_frame, LIBIE_MAX_RX_BUF_LEN);
 
 	if (adapter->current_op != VIRTCHNL_OP_UNKNOWN) {
 		/* bail because we already have a command pending */
-- 
2.47.1

