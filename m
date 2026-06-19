Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 170A333ADA8;
	Fri, 19 Jun 2026 07:14:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781853288; cv=none; b=l6ITHURz4I7qiHnM5CnDb6rZ2XgfM7e+6xwXVdE9YilfFuecyKjRyzsGuXdBiudJw60CmsDAZomo/8X0zYbe86JomFTrW8XdcckRgXFkWG5rCQYE3vHwQTU7BN/1Mf2FzWdkl5AtmgwFJwxCajUvBEScczfWfP//1NsrbLRK+qg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781853288; c=relaxed/simple;
	bh=nKL6fTOWwY6Hg51AnU7XaHSMtjptIchNEHMyb2ZXzTk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=DLiK/E+infp9pmihAmuMGz8HVvIaYKKbP4n1zfC/NW2g87DYHKPQakHXsPLFFW8NJb10MgLgLMaOyiNB1+iPojVZEptYEnbt29PPlGGA/OYmHmehVbu0C6lUfP60kgydH5YhFGXrzUOynDO/5ZrkypD10puHrfU1MNL1Z6ievws=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ds5vPXkc; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ds5vPXkc"
Received: by smtp.kernel.org (Postfix) with ESMTPS id C0865C2BCB4;
	Fri, 19 Jun 2026 07:14:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1781853287;
	bh=nKL6fTOWwY6Hg51AnU7XaHSMtjptIchNEHMyb2ZXzTk=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=ds5vPXkcqAhs3tK7398CUaBYYhJVO8S6p2m0lNFBB7nacTaIIEkQbidu1Cv3REnYv
	 GkAEmNWA01A17+O+X47UNz5mQ+0gXV8EtJdOPChciIkI+5708Bl7ZxpCEPNVAKelgG
	 7pgneeKiasgTaMfPyZJ8IVeIIXg3B3EikHdHB0cLG1n1dx1gYidv75qCo3iYSfaYCF
	 V6mkD41gtXZTLF5rSy9rUys279tl9brwD1rJEYBJ7zKVBABd/b+F4L874yrtySmsfg
	 700KfEqUsP9GupvbyeEiBQ96pBfIFF9Pak5BrSAAl1nG0kXRAp/CtcHq+3ekFwFdCD
	 zmPlEsew6Hzag==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A504ACD98F8;
	Fri, 19 Jun 2026 07:14:47 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Fri, 19 Jun 2026 09:14:44 +0200
Subject: [PATCH net v2] igb: only strip Rx timestamp header on the first
 buffer of a frame
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260619-igb-rx-ts-fix-v2-1-d3b8d605ca62@aweta.nl>
X-B4-Tracking: v=1; b=H4sIAGPsNGoC/yWMywrCMBQFf6WctRfSlMbHr4gLmx7rdRElN0qh9
 N8bdTkDMwuMWWk4NQsyP2r6TBX8rkG8X9NE0bEyvPPBhfYoOg2SZykmN50ljnvXH3qyawNq88q
 s+vc7I7Hg8pf2Hh6M5XvCum7/AMrddgAAAA==
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
 Tjerk Kusters <tkusters@aweta.nl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1781853286; l=3623;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=pmAEYror60wCpEvmPM789DYVzXqwCNs6uz+fXRtY1nI=;
 b=EPtIwt2TBPCz6NMGbTjzfttUjar17h7wguSFerhCZOC/fKnwEY4M0GEmdJgTBJ2nSlJGQA1Kv
 yQfBwVYve/FA9DdCxq6hAH0LbuHDS8c62xJWNKPgNjGRpcC8A/HQMaU
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
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
Changes in v2:
 - resend via b4 (v1 was sent with a mail client)
 - use full author name "Tjerk Kusters" (Jacob Keller)
 - add Reviewed-by from Kurt Kanzenbach
 - no functional change

Link to v1: https://lore.kernel.org/all/PAWPR05MB1069106D52F4E17F1EDB99C67B9182@PAWPR05MB10691.eurprd05.prod.outlook.com/
---
 drivers/net/ethernet/intel/igb/igb_main.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index ce91dda00ec0..abb55cd589a9 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9061,7 +9061,8 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
 		pktbuf = page_address(rx_buffer->page) + rx_buffer->page_offset;
 
 		/* pull rx packet timestamp if available and valid */
-		if (igb_test_staterr(rx_desc, E1000_RXDADV_STAT_TSIP)) {
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


