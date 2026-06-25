Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 90B2D17D2;
	Thu, 25 Jun 2026 05:24:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782365050; cv=none; b=CjpZ5/eJtXZGTI92sKWKHghnqswTb0/ZNdm42nyeu3De/MhKxwok52vSU+33dK9JwZySh2OjtDYJvJpOP943uMPmxSMR4RNpGZAcIJiSVOQJLnaSwLQ7TFysv88XBN9UHZnTYaTVuSofig5MAkYOGmVriLUiI668Bw8oeDN9vK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782365050; c=relaxed/simple;
	bh=aW1/nKWCMH/ml7XFGrgw6NSHQMxG+oaTKC0rssB3PYs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=hy1GZy0fap/bo9e/QzIQx8ZNCizuKkfiFz/YilQqvLJMBJjJfsM2b6g5MNjcgNFo3aGBQgjBtLVgh1fnXezQ5sErcUCxdyzx4zh8LMQnvpDXL53FhsPYNhXZRXcPHKup8j5UU2GWIxCFvd5Sv4gXsCPf5TVNBvm+nBO+ySa3xHU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ba1gn6eR; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ba1gn6eR"
Received: by smtp.kernel.org (Postfix) with ESMTPS id 025D7C2BCB4;
	Thu, 25 Jun 2026 05:24:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1782365050;
	bh=aW1/nKWCMH/ml7XFGrgw6NSHQMxG+oaTKC0rssB3PYs=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ba1gn6eRVrGAuQMhwb1ugbbzHx9avhVpmWneoDc3R6LqmxWR/ZaDKLEmH0SIHvA5U
	 ShjJA2hwFh6wRcO9hUjj8NnkXjM7LnYVz+sR9vRLepoXuYj7OMv+xA5lhIcQk+VlcM
	 wozNfjMotGzkVuTAdSMzCwuHhKjO1VarjSWcvUoWU/Ai7Ep641svvew7Ngvcjr4QSm
	 TZbrdr/D0ro7F4dO3nqYWk+QPHdoqmEpHLmzeDicqRO7btkC+CoW7+L0zLFR/tKLBl
	 pc+g/GB92K3ifhcBXxju0CAM2yR7U95GEMw3uZRtgJkI3LgFgF1O8/z0s+hrUNWurp
	 gFs7kVpSxrhkg==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D99F7CDB47F;
	Thu, 25 Jun 2026 05:24:09 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Thu, 25 Jun 2026 07:24:06 +0200
Subject: [PATCH net v3] igb: only strip Rx timestamp header on the first
 buffer of a frame
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260625-igb-rx-ts-fix-v3-1-99b3efa08dca@aweta.nl>
X-B4-Tracking: v=1; b=H4sIAHW7PGoC/3WNwQ6CMBBEf4Xs2TWlhIqe/A/DobQrrDGFtBUxp
 P9uwbPHmbx5s0IgzxTgUqzgaebAo8uhOhRgBu16QrY5gxRSCVWekfsO/YIx4J0XNPYk6qYmqko
 FeTN5yvXuu4GjCO2vDK/uQSZupg0bOMTRf/bXWe7wn4NZYom26hqrRG20klf9pqiP7gltSukL1
 xF4scAAAAA=
X-Change-ID: 20260619-igb-rx-ts-fix-cd70585ee316
To: Tony Nguyen <anthony.l.nguyen@intel.com>, 
 Przemek Kitszel <przemyslaw.kitszel@intel.com>, 
 Andrew Lunn <andrew+netdev@lunn.ch>, 
 "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
 Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, 
 Richard Cochran <richardcochran@gmail.com>, 
 Jesper Dangaard Brouer <hawk@kernel.org>, 
 Kurt Kanzenbach <kurt@linutronix.de>
Cc: intel-wired-lan@lists.osuosl.org, netdev@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Tjerk Kusters <tkusters@aweta.nl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1782365048; l=4324;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=QXi/sQ73rXUilm750LFxDKqWGpv73iTpHTzOn0DFvnk=;
 b=bhY0yP8fX23eKVecpe+7M7mHyZD21AUKMLaA4/ynXISYboagzoNyKWC8WpxhwgUp9rsyUdirz
 4tShZ6rbyvlBXmYZ6K3uGLNTm8ViMvhk66Pf4SWdIGfWB0rI947+p7u
X-Developer-Key: i=tkusters@aweta.nl; a=ed25519;
 pk=JYRpYQ3+LrphEabgnxcbiOUpwvNP8WDDMcLzz+cwKsk=
X-Endpoint-Received: by B4 Relay for tkusters@aweta.nl/20260619 with
 auth_id=831
X-Original-From: Tjerk Kusters <tkusters@aweta.nl>
Reply-To: tkusters@aweta.nl

From: Tjerk Kusters <tkusters@aweta.nl>

When Rx hardware timestamping is enabled (e.g. ptp4l, which configures
HWTSTAMP_FILTER_ALL), the NIC prepends a 16-byte timestamp header to the
first Rx buffer of every received frame. igb_clean_rx_irq() strips this
header inside its per-buffer loop:

	if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
		ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,
						 pktbuf, &timestamp);
		pkt_offset += ts_hdr_len;
		size -= ts_hdr_len;
	}

For a frame that spans more than one Rx buffer (e.g. a jumbo frame), this
block runs once per buffer. The timestamp header only exists at the start
of the first buffer, but igb_ptp_rx_pktstamp() is called for every buffer.

On a continuation buffer the data is packet payload, not a timestamp
header. igb_ptp_rx_pktstamp() already has two guards against acting on a
non-header buffer: it returns 0 if PTP is disabled, and returns 0 if the
reserved dwords (the first 8 bytes) are non-zero. Neither is sufficient
here: PTP is enabled, and a continuation buffer whose payload happens to
begin with 8 zero bytes passes the reserved-dword check. In that case the
payload is mistaken for a valid timestamp header and igb_ptp_rx_pktstamp()
returns IGB_TS_HDR_LEN, so the caller strips 16 bytes of real data from
that buffer. A frame spanning N buffers whose continuation buffers start
with zero bytes therefore loses 16 * (N - 1) bytes from its tail.

This is easily triggered by a GigE Vision camera streaming dark frames
(mostly 0x00 pixel data) over jumbo UDP with PTP active on the receiver:
the all-zero frames arrive truncated while frames with non-zero content
are fine. There is no error indication.

No content-based check can reliably tell a continuation buffer that begins
with zero bytes from a real timestamp header, because both are all zero.
Fix it structurally instead: only attempt the strip on the first buffer of
a frame, which is the only buffer that can contain a timestamp header. In
igb_clean_rx_irq() skb is NULL until the first buffer has been processed,
so guarding the strip with !skb restricts it to the first buffer
regardless of payload content.

Fixes: 5379260852b0 ("igb: Fix XDP with PTP enabled")
Cc: stable@vger.kernel.org
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
Changes in v3:
- update the rx-timestamp comment to note it only applies to the first
  buffer of a frame (Piotr Kwapulinski)
- add Reviewed-by from Aleksandr Loktionov and Piotr Kwapulinski
- no functional change
- Link to v2: https://patch.msgid.link/20260619-igb-rx-ts-fix-v2-1-d3b8d605ca62@aweta.nl

igb: only strip Rx timestamp header on the first buffer of a frame

Changes in v2:
 - resend via b4 (v1 was sent with a mail client)
 - use full author name "Tjerk Kusters" (Jacob Keller)
 - add Reviewed-by from Kurt Kanzenbach
 - no functional change

Link to v1: https://lore.kernel.org/all/PAWPR05MB1069106D52F4E17F1EDB99C67B9182@PAWPR05MB10691.eurprd05.prod.outlook.com/
---
 drivers/net/ethernet/intel/igb/igb_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ce91dda00ec0..539bf5389a24 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9060,8 +9060,11 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 		rx_buffer = igb_get_rx_buffer(rx_ring, size, &rx_buf_pgcnt);
 		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
 
-		/* pull rx packet timestamp if available and valid */
-		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
+		/* pull rx packet timestamp if available and valid; it is only
+		 * present on the first buffer of a frame
+		 */
+		if (!skb &&
+		    igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
 			int ts_hdr_len;
 
 			ts_hdr_len = igb_ptp_rx_pktstamp(rx_ring->q_vector,

---
base-commit: 2d3090a8aeb596a26935db0955d46c9a5db5c6ce
change-id: 20260619-igb-rx-ts-fix-cd70585ee316

Best regards,
--  
Tjerk Kusters <tkusters@aweta.nl>


