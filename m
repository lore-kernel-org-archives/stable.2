Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795173056;
	b=foVG9YXRQ6iVI8PFkMtbTmwQ19NAlwSjTQJ9Q4YzTyBs04rxw5qwiTtBvFeyZCGQjdVx
	 8KqIB3UvyedbwcpnAXzrXRB0JJQmOn5IOELykZf59c37rjCZEqLcaQzPCgZGqPV+H5E/w
	 lND4IQZMQc/QMqJUWjhNSNJnvBwsdQ3f4l1wMAaByX1YrgT3K+bysNQ/3vPI+DHP/z60R
	 sm0NkvfMfZbs+dsP4p+1pwa+8FOj42YHHylCavmgVRPtvmlWi82ouXAJScXudfblKJcp3
	 FzQJhp4lIYZOZtLo7ncITBTZ3ilg4VsA7ufrCsOM/PgDHWy6IkSxSNTSX/k/idiLsiw==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795173056;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZalYcQYCzRi9sIxhbRnp0bHlYxYvz0VqIZWtxK4/xBA=;
	b=UyaZMPnFKFglLUcdIg4X/mRpOR14xymksi/fgSKw7LrgNB1RFogIiezzkgNh7lYnDXUA
	 aPtZSBxnifTF1xiiptIxf+0qVB1rYXBTrxwIZlhUwcT0W0PAGquKT/83szetaTI6du8u4
	 gkvEbZ0OPHd19DAtuTjbpuVe3MyEJ1MsLFdIq3LBEhnxd7/sar4OB3XhquWF1JPPzkmY9
	 tFxeY9vpqb3qIGHeXTdSw01TQVrdYbv4diHlYxIrpA0g1z9lrQ0/q12bSjJzlAi25jdRk
	 4MyTfLJl4jPqu950X85odacMw/UH7WKidF6ULa+NTF9789NKB7jMfWYIiEJKJofeDtA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyLxsBvK;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3342160A2606;
	Fri, 20 Nov 2026 11:10:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gyLxsBvK
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795173055;
	b=AMAi8Cygcoi9uZe/TT5lLvO1tq4VX+2weaf0jd1OEmoulVGPKLNwz6lEBSD+hysTC9M9
	 WGF/+VCcY/KAtPjHFsv3xB0oT/0toRZhRvC+eILaSJUoz3guOgHd3PtJsgJqeGqvkkCnr
	 G7r8MJatJ0SYs/K4ibKddPnRtYq5dWoamShe6o4j1VJn5OV+DCwGDTMOWXr6MZ0fjFP/v
	 oo8lGigsnnYbZ0VEI8fmpzUskO0f4T23oImGwnyaifa9300FQSXh1qW0mK74PJerlH2XY
	 zkXDI0VbwziNpaSC0PHhosepf1Tv1NDPDG6fWs1Ph04R2UXxOf0Z67OWP7IhSovuSkg==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795173055;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=ZalYcQYCzRi9sIxhbRnp0bHlYxYvz0VqIZWtxK4/xBA=;
	b=msQ+8ahhco6e/bc4udN/J/7PGq4LGJ+OF4MEr4qmAotMCFIUSyb4ZawmJ36nXa3PUMx3
	 LNn00J3fU8RuPjtytvHQjteQ53ltnDaeH/tYqFsb8J2p9ZWZcsibU1uGgq7yc+3VE+3pi
	 ATYYTap/xeZwSOcWqDdMv0w8+JdXXaOYrH16JKycU7MQYvi3lPnUKnzjIoSYJbnX+RY95
	 ApbYbRktk3i3XSChT42S2wpl3mQ8cGhzs0H5ApE4kHR2JsTn06lfb5WPhxl47Co2d44JI
	 htg9zcaZXsBl0l/7rOmiaG00sb45yKGqz5tsBX2VbtjczZR/R184c/nWBHeOgCOnxjQ==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 119931F000CF;
	Fri, 20 Nov 2026 11:10:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795173055;
	bh=ZalYcQYCzRi9sIxhbRnp0bHlYxYvz0VqIZWtxK4/xBA=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=gyLxsBvKqRwCm/c9e3MQnpGTD+KCUGQwa+NfA86ADpP56Oj2tPL5S5RuI8XT1vq9x
	 cyqiWFkr2I0cmQawx3J3mPp1IgsZk102fo8tCY+eYBOTSft0zGoi9CVqwrOOSW7lNq
	 OrqCLiBTGuD4K3bBwWh7pdGktwHMBkNvldVc6/AhmABy5FT4t11IJ+1y9iWbI/Ep0o
	 OvgnoBz2/98ZjsSzsbO0KUNY24DxT6I2d839UQdJ6//DQGJyawgoy6lGxRFIrP3qlM
	 N5y2khYGsjGOI2X4pPOPE0zheo2RjIwkVKx+q25OTMFzqdqsaqJU0/BN7Q3DRz/SaZ
	 HelBBHVzZ+XLw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id 941894983A;
	Fri, 20 Nov 2026 11:10:40 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Fri, 20 Nov 2026 12:10:39 +0100
Subject: [PATCH net v7 2/3] igb: only strip Rx timestamp header on the
 first buffer of a frame
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
Message-Id: <20261120-igb-rx-ts-fix-v7-2-63b03045978e@aweta.nl>
References: <20261120-igb-rx-ts-fix-v7-0-63b03045978e@aweta.nl>
In-Reply-To: <20261120-igb-rx-ts-fix-v7-0-63b03045978e@aweta.nl>
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
 stable@vger.kernel.org, Piotr Kwapulinski <piotr.kwapulinski@intel.com>, 
 Aleksandr Loktionov <aleksandr.loktionov@intel.com>, 
 Alexander Nowlin <alexander.nowlin@intel.com>, 
 Tjerk Kusters <tkusters@aweta.nl>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795173039; l=4403;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=UtweYThC/f0Qx2w0Elc+jEl894+yZSIODmNIWsXcYHE=;
 b=zo4fWZqK6OqLBYe0qtLmwELP5b28z9U6XlZZrxUYtobdOIVTVlZMKac9XSRgafCT8kf9cUqq8
 G3Uqjg4ryQFDIW4e9KsiHhMYXIdgzbmslh6baVpe+kc7DivDyxmRT3z
X-Developer-Key: i=tkusters@aweta.nl; a=ed25519;
 pk=JYRpYQ3+LrphEabgnxcbiOUpwvNP8WDDMcLzz+cwKsk=
X-Endpoint-Received: by B4 Relay for tkusters@aweta.nl/20260619 with
 auth_id=831
X-Original-From: Tjerk Kusters <tkusters@aweta.nl>
Reply-To: tkusters@aweta.nl
Content-Transfer-Encoding: 7bit

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
returns IGB_TS_HDR_LEN, and the caller reduces that buffer's size by 16.
igb_add_rx_frag() adds a continuation buffer from its original offset, so
the buffer loses its last 16 bytes and the data of the next buffer
follows directly. A frame spanning N buffers loses 16 bytes per affected
continuation buffer, in the middle of the payload when N > 2. If the last
buffer of a frame holds 8 to 15 bytes, all zero, the unsigned size wraps
and a fragment of about 4 GiB is added to the skb. The sender chooses the
frame length and content, so this can be triggered remotely.

This is easily triggered by a GigE Vision camera streaming dark frames
(mostly 0x00 pixel data) over jumbo UDP with PTP active on the receiver:
the all-zero frames are dropped as truncated while frames with non-zero
content are fine. The driver reports no error; only the IP layer counts
the frames in IpExtInTruncatedPkts.

No content-based check can reliably tell a continuation buffer that begins
with zero bytes from a real timestamp header, because both are all zero.
Fix it structurally instead: only attempt the strip on the first buffer of
a frame, which is the only buffer that can contain a timestamp header. In
igb_clean_rx_irq() skb is NULL until the first buffer has been processed,
so guarding the strip with !skb restricts it to the first buffer
regardless of payload content.

This relies on the previous patch. Without it, an XDP program that does
not return XDP_PASS for the first buffer of a multi-buffer frame leaves
skb NULL for the rest of that frame. With the receive length limited
while XDP is attached, such frames no longer reach the XDP path.

igc has the same bug; Paul Moses' igc series, linked below, fixes it the
same way.

Link: https://lore.kernel.org/all/20261028083344.3047350-2-p@1g4.org/
Fixes: 5379260852b0 ("igb: Fix XDP with PTP enabled")
Cc: stable@vger.kernel.org
Reviewed-by: Piotr Kwapulinski <piotr.kwapulinski@intel.com>
Reviewed-by: Aleksandr Loktionov <aleksandr.loktionov@intel.com>
Reviewed-by: Kurt Kanzenbach <kurt@linutronix.de>
Tested-by: Alexander Nowlin <alexander.nowlin@intel.com>
Signed-off-by: Tjerk Kusters <tkusters@aweta.nl>
---
 drivers/net/ethernet/intel/igb/igb_main.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/net/ethernet/intel/igb/igb_main.c b/drivers/net/ethernet/intel/igb/igb_main.c
index 5f1a5e2240e6..a59ee6575c56 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9135,8 +9135,11 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
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

-- 
2.27.0


