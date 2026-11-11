Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794379870;
	b=iAes5GURY0CFh/ajSuXzF3qumdyXIsT7a8Q/PUcI3H9HXB+bWtUFekDKX9SmeHwjmwLH
	 SvR3rKWfVFZERRQWLyEYLjtZpBjy2izdqDmv9F1Is3UtYwQyWfhBKmplQ+JtpPiYMY3sz
	 +/R16hrm0RpPVlzMbRV5b1SQ3eJ8uBh64smfoJDHPrmxSDSOaq8n14hOhDlvpsuaTWPZC
	 6K442ySb/vRNTWCnodKARLRQTlAUe27wF61Zo4TUuJwHYa1n+3skyTf65p4SjOhpnSlGc
	 fyxKLimDY+wLjl0vwwVD4ATTAXBiJkK/rsajpyTROaia+K59VgBaYixza4zUfbd4uaA==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794379870;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XVUVGyYUi2sHoGg8fzW351wDvGL0ueJvYei6N+nJ2PM=;
	b=FXlgiystOjzWbn4u4/MrzpjKiu1E7kkKynv089fG5vhrtVHh44bbUp114feHvPyvR1r4
	 bt0Z5Vk8BRiHsqIAXFyxOwDQ59q1P4IvVF5gLwnBKKqHW+PATxwjhLH5tLJhLgmXJmYFi
	 vRGqCKCKRUUYyRLiAdMaucF8/vqZdpxewhE6pAX6NoVrcGFx7qRFnwXOKeXnx2MX39WZW
	 gAR6UIwIo72DBVXaJM2FJ5PROzpD7AT8PNmR2ubU4xQa2/96ZyJfstQz+avLOgwo2fcBm
	 cU4YibT7IY0cAQ5HEW/zuLQm2t/MF43262vBohb8NTXLiPHi4sCneNXghBP+UBwbJFw==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8plAhw9;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035A5606A33D;
	Wed, 11 Nov 2026 06:51:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N8plAhw9
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1794379869;
	b=s3RAdTsOagElMhD4Bm7AS/j+LxizDIsEviBpEdcKCD4XqQtnyXLXvmoECV0mJcqnYmOv
	 TOSOIFeuYXnBpfXnAZ7rNpZIdyBv/pxzAI9QofsuTdxjke4M2rNy1TBwjzVnIWT9xlqPF
	 mRrja3m5g4njI+SpoB3zvOaM54VoXKqVDRmyWert6N9SvBo3aNE7OYBYNGPuyiF45SbTD
	 uTfeZj0V6Oi69Re/GoWXmAVdSkv/TO0fMWZcksayFiHekt6qEOxOTtksQB6Ejty8pEnwK
	 9cA/M2mpkPjnxyTItVcOUE7fiOpkGx1PEnl6PSrUWfcDV5Ln0ccAQADWucQ9pQMWEjw==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1794379869;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XVUVGyYUi2sHoGg8fzW351wDvGL0ueJvYei6N+nJ2PM=;
	b=d1kaJhxMRYXcYVtFO4u97kMKI7YCQspIHUeTJerYmDDs4aUGOdMOhPh9KjwlGsCgVbtL
	 TkFb7FYtAXfNSd15R4sfVJw/iAgJNaFTAgvYaYGWP0r7/3dBY6ifSoT87M17axggUTOq+
	 Uv/NGkifrePmswAuwDD3YBiCJc52QJqxiC2VGUutalki5oVpDaJODad08VdBaVfBNSnsJ
	 EQ8AqpTIA+5T8uBXlgMV7O+t9+ie1PBXsB6fvM2ZmaQ4oHbv+5Zvq5JCYJtlNTe9lVLPT
	 eM7n+Xg2bULnncefsJnK0qYu0JV6xS+SEotCWQGzp+MNv1xUv3tS7K2K7PTJ11eS2yg==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 4E4FA1F00A07;
	Wed, 11 Nov 2026 06:51:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794379869;
	bh=XVUVGyYUi2sHoGg8fzW351wDvGL0ueJvYei6N+nJ2PM=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=N8plAhw9EfaT2dOHECJLw9Fu4EfkHdVe9/Qaoz/3SYJF6bxC4y+MOJ6s0jEZcE2I4
	 a0hg0Ply9W8EG7tm4/KnPSqkCy3La4wfDrKiYSHMEDDIbOxnKcjwqpDtkwu0jGBgSM
	 RL3fiQXRg2QIx2/6RGop2bSw/fxV4oqN12ca018tZJU2sH03tHsRiz6C+5eKAkPhuL
	 5Mup+p2cx1xFYPqPkLFZyUSKK5ejfMa0TfiufBc5o2wYHs3FKnxcN1nOxYFYVmLD1T
	 hJDt7wmgOtPA3Pm5O4xN7UUGC/tePTz0ORQZ5Taw2bfvdHDavNLsDWH32BrXrwgAkv
	 o/MfpJAP1CVQA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id CB66E48E2D;
	Wed, 11 Nov 2026 06:51:07 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Wed, 11 Nov 2026 07:51:05 +0100
Subject: [PATCH net v6 2/3] igb: only strip Rx timestamp header on the
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
Message-Id: <20261111-igb-rx-ts-fix-v6-2-ba5b9903859c@aweta.nl>
References: <20261111-igb-rx-ts-fix-v6-0-ba5b9903859c@aweta.nl>
In-Reply-To: <20261111-igb-rx-ts-fix-v6-0-ba5b9903859c@aweta.nl>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1794379866; l=4403;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=XkxDc7ECcOjIvEKpfl4Rq0cw4WxcDLlkuL2sNSGDtws=;
 b=LDCZpsZfzmnq2QYFhudMEO+iLO73FQBn4rR9+vt4LUuGaskSCmAEr8OWTOnqHe+M9QbLAgrwb
 pVtLK2T0e6MBggvV+8PGXJ8Qb1ST08gHXlHcspSFAULd/J6gx4/2II1
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
index 711a67f0bd80..e787095d3cdb 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9125,8 +9125,11 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
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


