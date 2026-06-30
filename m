Received: from mta-64-226.siemens.flowmailer.net (mta-64-226.siemens.flowmailer.net [185.136.64.226])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9ADE407CD1
	for <stable@vger.kernel.org>; Tue, 30 Jun 2026 12:02:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.64.226
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782820948; cv=none; b=rGb56mDbXFHcr2FokrWUWn/cR34Ig3QQWz8LHlYkuK66z9OZ/NLpfEEyEvp6UTX0rGLC+jcUCwNs0tUiwBMVJn2N0XUPiyRFKnjESy08iJxVO46k9PBkFUXilentWu3WJdxXssHgmXTmM9BSwchGWB22LBpJ9Q/tf1rS1M4lOgg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782820948; c=relaxed/simple;
	bh=4ZSwZymhBMoMS7e9yAqoDjInucyag5+dMxp9MPkaiY0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ApHp0sJoFH1li+Am1baFN5iNRSOTDgy8gQj3GQe0OMkZCC9DmghCYSx7R22+OQUxMDDd3LVV0GIO6NXL2GwFIq+lS0XVDA1KPu3CYSRExr52phqtX7oVW4bLjonmjabjohdvENhPLjxnVavEJINxObNUMxKWrnlpBbMZvYJv3ZQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=meng.ding@siemens.com header.b=au27Z8Yj; arc=none smtp.client-ip=185.136.64.226
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=meng.ding@siemens.com header.b="au27Z8Yj"
Received: by mta-64-226.siemens.flowmailer.net with ESMTPSA id 2026063011220030542f7d77000207d6
        for <stable@vger.kernel.org>;
        Tue, 30 Jun 2026 13:22:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=meng.ding@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=FGWjX5Iw+idjzBCUjhnqRS4MmD5hoBNLO0VdMjNcb0g=;
 b=au27Z8YjSO7lrdMiXMKZKX04axUjx3tCBcFn/n1iVduzZQwpYpn1MMDv3JXmUT35/VG1nZ
 muiVJZ9oa28547LGKhhcioH4cLarvCqcVCeULc1MIYDKoMg/tsspDJYrLs5agqoM3Wd6nmzV
 uWt5dJ3z9uyDhixiGcY6khTLwWraKKUYJNf5wicZaEBMfi8C75m8rC+w/9qM6cHt+vBV7j6z
 i7Sz1wK9qXAFdZQf3+Vq02+VIRgvywuG/EjTl+riq+DSvgLzQvwumxPQ6wJjAjI8qO2PKlji
 ZKijyupNhmCSt8qaljxIxGPu9lD+MvbnaanfmIHM4eOqjUWuq6NEYtqQ==;
From: Ding Meng <meng.ding@siemens.com>
To: anthony.l.nguyen@intel.com,
	przemyslaw.kitszel@intel.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	jan.kiszka@siemens.com,
	florian.bezdeka@siemens.com
Cc: intel-wired-lan@lists.osuosl.org,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	meng.ding@siemens.com,
	wq.wang@siemens.com,
	pmenzel@molgen.mpg.de,
	stable@vger.kernel.org,
	Aleksandr Loktionov <aleksandr.loktionov@intel.com>,
	Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Subject: [Intel-wired-lan] [PATCH net v2] igc: Fix RX HW timestamp reporting when NET_RX_BUSY_POLL is disabled
Date: Tue, 30 Jun 2026 19:15:23 +0800
Message-ID: <20260630112056.885071-1-meng.ding@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-1335312:519-21489:flowmailer

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
---
V2:
  - update commit message(suggested by Paul Menzel):
      add error log
      explain why need to pass igc_adapter
      add test case
  - move variable declarations on top of the function
  - Cc stable@vger.kernel.org
V1: https://lore.kernel.org/intel-wired-lan/20260622041718.6106-1-meng.ding@siemens.com/
---
 drivers/net/ethernet/intel/igc/igc_main.c | 41 ++++++++++++++++-------
 1 file changed, 29 insertions(+), 12 deletions(-)

diff --git a/drivers/net/ethernet/intel/igc/igc_main.c b/drivers/net/ethernet/intel/igc/igc_main.c
index 8ac16808023..5c4beb8b5d4 100644
--- a/drivers/net/ethernet/intel/igc/igc_main.c
+++ b/drivers/net/ethernet/intel/igc/igc_main.c
@@ -1992,7 +1992,29 @@ static struct sk_buff *igc_build_skb(struct igc_ring *rx_ring,
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
@@ -2013,10 +2035,7 @@ static struct sk_buff *igc_construct_skb(struct igc_ring *rx_ring,
 	if (unlikely(!skb))
 		return NULL;
 
-	if (ctx->rx_ts) {
-		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
-		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
-	}
+	igc_construct_skb_timestamps(adapter, skb, ctx);
 
 	/* Determine available headroom for copy */
 	headlen = size;
@@ -2686,7 +2705,7 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 		else if (ring_uses_build_skb(rx_ring))
 			skb = igc_build_skb(rx_ring, rx_buffer, &ctx.xdp);
 		else
-			skb = igc_construct_skb(rx_ring, rx_buffer, &ctx);
+			skb = igc_construct_skb(adapter, rx_ring, rx_buffer, &ctx);
 
 		/* exit if we failed to retrieve a buffer */
 		if (!xdp_res && !skb) {
@@ -2738,7 +2757,8 @@ static int igc_clean_rx_irq(struct igc_q_vector *q_vector, const int budget)
 	return total_packets;
 }
 
-static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
+static struct sk_buff *igc_construct_skb_zc(struct igc_adapter *adapter,
+					    struct igc_ring *ring,
 					    struct igc_xdp_buff *ctx)
 {
 	struct xdp_buff *xdp = &ctx->xdp;
@@ -2760,10 +2780,7 @@ static struct sk_buff *igc_construct_skb_zc(struct igc_ring *ring,
 		__skb_pull(skb, metasize);
 	}
 
-	if (ctx->rx_ts) {
-		skb_shinfo(skb)->tx_flags |= SKBTX_HW_TSTAMP_NETDEV;
-		skb_hwtstamps(skb)->netdev_data = ctx->rx_ts;
-	}
+	igc_construct_skb_timestamps(adapter, skb, ctx);
 
 	return skb;
 }
@@ -2775,7 +2792,7 @@ static void igc_dispatch_skb_zc(struct igc_q_vector *q_vector,
 	struct igc_ring *ring = q_vector->rx.ring;
 	struct sk_buff *skb;
 
-	skb = igc_construct_skb_zc(ring, ctx);
+	skb = igc_construct_skb_zc(q_vector->adapter, ring, ctx);
 	if (!skb) {
 		ring->rx_stats.alloc_failed++;
 		set_bit(IGC_RING_FLAG_RX_ALLOC_FAILED, &ring->flags);

base-commit: 4549871118cf616eecdd2d939f78e3b9e1dddc48
-- 
2.47.3

