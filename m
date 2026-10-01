Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.19])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 067D6443E40;
	Thu,  1 Oct 2026 22:24:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=192.198.163.19
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790893502; cv=none; b=ZoXy4xoTnYek1Vhuyn4zG75MN9REiDBSi49gF2oNmHmT0LoSTbVDanazYZK5KhJBDfCwmN1NwOx4vQPERrefPKjpnns9FJsQNmAKEJfCF+peEuB/LwrW0jIm0AU5FIucT2AdTa2r31LIvb27XLC7kTyquiO2axPvWg3AcXtDmuQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790893502; c=relaxed/simple;
	bh=OtpwEJP8cA/bi8goC9l4C0DZftzdoD9aZwBjvEPnNlY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=usgka+OSzyvLNQjNm7+0HuhhG2132mI229h0DLccuayRIit+rLXuh7Pn6bkdB67O0vZDCMTpiG4DdDM1u56E75eFpBm35nO9wirj00FcLgcQShSlMCF/JsywddSKVUapFIBCcnuB2llbIzeMt2qnTTdVYueJMIJEtnTH1putUQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com; spf=pass smtp.mailfrom=intel.com; dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b=JK+U7wmS; arc=none smtp.client-ip=192.198.163.19
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=intel.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=intel.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.b="JK+U7wmS"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1790893500; x=1822429500;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=OtpwEJP8cA/bi8goC9l4C0DZftzdoD9aZwBjvEPnNlY=;
  b=JK+U7wmS7C7Q6ek5pvP2kY8j9VuwmUbIfmhtVqS5I2iB4X+3cbt7lA3f
   wACG0qSgJAprJ1M8V7h4MqLVnc6V1w1AG/fae+GDqp+cwcxLqRW3ZmEYK
   Xf2qJ5qKb+kyBVO1oknaGjORzmcB3926Vch9pKpzSO+U7Ppe3WiefrfzQ
   doXreJqxQuODGnEqv/hV0pLaAShFNPpaWJOUzc3JEJsvSH0dPu89bO157
   RnvnMV1NIx0NS1CMeothPoY+fkpO6OM0b3TlRDPfFzL5UB/1x8yialFi+
   sJj9r+wmjv3xSWc8n87wFn7D7jtOEWJW0K899xDOgYtUHZfvIzsjYpcxG
   w==;
X-CSE-ConnectionGUID: RQSDpRWmSDO3qlOBWiRGdQ==
X-CSE-MsgGUID: lZzPfHp7TWqGpKU+9BVQhQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11922"; a="90567682"
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="90567682"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
  by fmvoesa113.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Oct 2026 15:24:58 -0700
X-CSE-ConnectionGUID: kZRpaGbTS0+e0xNc1mCUlg==
X-CSE-MsgGUID: CugmOTrMQKOCnu/6Rf6Csg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,135,1787036400"; 
   d="scan'208";a="279863762"
Received: from anguy11-upstream.jf.intel.com ([10.166.9.133])
  by orviesa005.jf.intel.com with ESMTP; 01 Oct 2026 15:24:58 -0700
From: Tony Nguyen <anthony.l.nguyen@intel.com>
To: davem@davemloft.net,
	kuba@kernel.org,
	pabeni@redhat.com,
	edumazet@kernel.org,
	andrew+netdev@lunn.ch,
	netdev@vger.kernel.org
Cc: Ding Meng <meng.ding@siemens.com>,
	anthony.l.nguyen@intel.com,
	florian.bezdeka@siemens.com,
	p@1g4.org,
	tkusters@aweta.nl,
	jiayuan.chen@linux.dev,
	pulehui@huawei.com,
	vinicius.gomes@intel.com,
	maciej.fijalkowski@intel.com,
	magnus.karlsson@intel.com,
	ast@kernel.org,
	daniel@iogearbox.net,
	hawk@kernel.org,
	john.fastabend@gmail.com,
	sdf@fomichev.me,
	bpf@vger.kernel.org,
	richardcochran@gmail.com,
	dima.ruinskiy@intel.com,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [PATCH net 1/6] igc: Fix RX HW timestamp reporting when NET_RX_BUSY_POLL is disabled
Date: Thu,  1 Oct 2026 15:24:34 -0700
Message-ID: <20261001222443.3500206-2-anthony.l.nguyen@intel.com>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
References: <20261001222443.3500206-1-anthony.l.nguyen@intel.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Ding Meng <meng.ding@siemens.com>

When CONFIG_NET_RX_BUSY_POLL is deactivated, fetching RX HW timestamps
from the NIC no longer works as expected, often resulting in incorrect
or negative values such as "HW raw -121948.050407424".

This occurs because disabling CONFIG_NET_RX_BUSY_POLL disables the
SKB NAPI mapping in __skb_mark_napi_id(). Consequently, get_timestamp()
fails to perform its driver lookup, and the igc driver's struct
net_device_ops::ndo_get_tstamp is never invoked.

Instead, get_timestamp() falls back to use shhwtstamps(skb)->hwtstamp,
a field that the driver has not populated. This results in incorrect
timestamps.

Fix this by populating the hwtstamp field with the correct timestamp
in the default timer when CONFIG_NET_RX_BUSY_POLL is disabled.
The "igc_adapter" is passed to igc_construct_skb() to enable
igc_ptp_rx_pktstamp() to access the necessary adapter details for
adjusting the timestamp.

Test case:
 Disable CONFIG_NET_RX_BUSY_POLL.
 Sender:
 # tools/testing/selftests/net/timestamping en0 \
        SOF_TIMESTAMPING_TX_HARDWARE PTPV2 IP_MULTICAST_LOOP
 Receiver:
 # tools/testing/selftests/net/timestamping en0 \
        SOF_TIMESTAMPING_RX_HARDWARE SOF_TIMESTAMPING_RAW_HARDWARE PTPV2

Before patch, receiver prints
 HW raw -121948.050407424
After patch, receiver prints
 HW raw 1760648763.746974064

Fixes: 069b142f5819 ("igc: Add support for PTP .getcyclesx64()")
Cc: stable@vger.kernel.org
Co-developed-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Florian Bezdeka <florian.bezdeka@siemens.com>
Signed-off-by: Ding Meng <meng.ding@siemens.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Signed-off-by: Tony Nguyen <anthony.l.nguyen@intel.com>
---
 drivers/net/ethernet/intel/igc/igc_main.c | 41 ++++++++++++++++-------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 1fb5f3cbe93c..95f7747b347b 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1989,7 +1989,29 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
 	return skb;
 }
 
-static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
+static void igc_construct_skb_timestamps(struct igc_adapter *adapter,
+					 struct sk_buff *skb,
+					 struct igc_xdp_buff *ctx)
+{
+#ifndef CONFIG_NET_RX_BUSY_POLL
+	struct igc_inline_rx_tstamps *tstamps;
+#endif
+
+	if (!ctx->rx_ts)
+		return;
+
+#ifndef CONFIG_NET_RX_BUSY_POLL
+	tstamps = ctx->rx_ts;
+	skb_hwtstamps(skb)->hwtstamp = igc_ptp_rx_pktstamp(adapter,
+							   tstamps->timer0);
+#else
+	skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
+	skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
+#endif
+}
+
+static struct sk_buff *igc_construct_skb(struct igc_adapter *adapter,
+					 struct igc_ring *rx_ring,
 					 struct igc_rx_buffer *rx_buffer,
 					 struct igc_xdp_buff *ctx)
 {
@@ -2010,10 +2032,7 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 	if (unlikely(!skb))
 		return NULL;
 
-	if (ctx->rx_ts) {
-		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
-		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
-	}
+	igc_construct_skb_timestamps(adapter, skb, ctx);
 
 	/* Determine available headroom for copy */
 	headlen = size;
@@ -2683,7 +2702,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		else if (ring_uses_build_skb(rx_ring))
 			skb = igc_build_skb(rx_ring, rx_buffer, &ctx.xdp);
 		else
-			skb = igc_construct_skb(rx_ring, rx_buffer, &ctx);
+			skb = igc_construct_skb(adapter, rx_ring, rx_buffer, &ctx);
 
 		/* exit if we failed to retrieve a buffer */
 		if (!xdp_res && !skb) {
@@ -2735,7 +2754,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 	return total_packets;
 }
 
-static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
+static struct sk_buff *igc_construct_skb_zc(struct igc_adapter *adapter,
+					    struct igc_ring *ring,
 					    struct igc_xdp_buff *ctx)
 {
 	struct xdp_buff *xdp = &ctx->xdp;
@@ -2757,10 +2777,7 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
 		__skb_pull(skb, metasize);
 	}
 
-	if (ctx->rx_ts) {
-		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
-		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
-	}
+	igc_construct_skb_timestamps(adapter, skb, ctx);
 
 	return skb;
 }
@@ -2772,7 +2789,7 @@ static void igc_dispatch_skb_zc(struct igc_q_vector *q_vector,
 	struct igc_ring *ring = q_vector->rx.ring;
 	struct sk_buff *skb;
 
-	skb = igc_construct_skb_zc(ring, ctx);
+	skb = igc_construct_skb_zc(q_vector->adapter, ring, ctx);
 	if (!skb) {
 		ring->rx_stats.alloc_failed++;
 		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &ring->flags);
-- 
2.47.1

