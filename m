Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793774408;
	b=Tu1H6iKcDtVwnykgofFHesOHTbCpW1Oz3RZ0GmwdOJAi2E6vX63BbXiNmjhNERmj+gk+
	 tQJPMDUla0yZYbHLcShShxngI+vPYwgSznHY6IRIObxUKAWlA7k9NbKjgJsJGgjmifR+c
	 ykyNqYg7Z163gq08Z0m5hmsDyJPJ1QeCQBh+aRYxb1NNjg909rv5N99a9h82njRAD2UWf
	 BE3TBQxzS0ScREq6fYPAZ1sMhU7hFqCJk4lyJN32fKtDtB9l1yCwAq+9DpE8CkdfivTci
	 kinQW+yvYUbdHRvRLua5oPxED3yQz8FLB+pyCI9KhitycqMLAGvg1l6YVMiuW66qy9A==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793774408;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8BbsvJSapTr8hdDIwEXj9HIx0po9cSbpcewOSWjVeC4=;
	b=pfCvGhWW6xCTBUn4xRm96TyUJDkDb3mC5bYwG8/umuvKtPXpuZSqKfJkMH3RDooBAA8h
	 QIkVgv7pqLNekpjKxAqndFoVMgYAyVLrm2382jwsmA1Z7s1avX4qqjLDVLGsQzlMjtfdp
	 ilF1OVLmov9Yv86wTLr0sAhyJ49+jtkE/98JYzC1XyLNxKI+xKue2UnvG8TVd4038Cm6g
	 833pXrTVBLZsymvR14qTZl7nQa7JAOrvAfTxHZJ4pLibsQN7S+fugGxBogx1NASINNTl7
	 lQ2s/LFCIX+szFNgJP31KdxjWPdfW8vcuYOHRN6OCBnaof6+T2QlMqI235k34RaSRKA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9DPnyaM;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 47660606A32E;
	Wed,  4 Nov 2026 06:40:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A9DPnyaM
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793774408;
	b=UW4BioJKYDpbooEJFsG4SS9xhjEag3IrAR1MwYv8ewienor6WU2GmZT7D2akUNbddVVB
	 QY3W8MvNUtKAupHCEBl2U17MRiA4F3u2rudWngrUTIpPFo2R4GvxUXrh1ghsqsPD4doSD
	 2MkBXvmUaJpkM7gyAw+wleE7Pnfxdl5tZhO1O0MPR6EnHEbYFSChO09i4vnPW+yzSjILR
	 K+Gy7itqhEsFo0VN/YLMB7ntvIc8VP20ppPe1aDoOfD33sxnY9der6c2GicL0HReBLaAD
	 MwmEFztZW0cyaSVwoqLNsAG6jpAKk0GZAoEMOpG/E0Dq1ZcRkgJc1+jkmqFm8p4yR4Q==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793774408;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=8BbsvJSapTr8hdDIwEXj9HIx0po9cSbpcewOSWjVeC4=;
	b=ni0h3t8XQxJ8umZ6V+W8NxHZYJYOOg4YSGdmID5xb2SoDMT1cWfgnE6NYbm9SkT65ouR
	 vjl1zETQCOj4z07kpDxkknV9KPvePEOxHgA4AwFToAQl7eab45ghHOVsmUb537gc2PAIM
	 2/c5GqNZ+j+bcGveirXkPGsDPIbvsZIr+RVJm/2zR44QXazcgfu1S5TraNqTvcYHdGtag
	 f9VRfzoYWhzhHLvUP0RR8cE25t3tnQVliFSv5FpskvSd58veX3pBqSHv1iPQPcMxkda+i
	 y4EWN6p+BufJINJ6qg/12uvz4rkEsTZ145255c6zkGqY2HhzKG5DMUaCGUZSfMIQvXw==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 574001F0093A;
	Wed,  4 Nov 2026 06:40:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793774407;
	bh=8BbsvJSapTr8hdDIwEXj9HIx0po9cSbpcewOSWjVeC4=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=A9DPnyaMz+syfMZUWUDenCPCqjuYgIym/CcAvohJerNIU8Mvnll+8OmsguFDvthrq
	 Zh9x6CCUITiWx+Lu8McRzN52x9ZJ4qvt+oPIL3EYOoip8S8Y8nPJiUyP7FZ1+87xqH
	 61gyxcmj9mURB/AxkbWYey0V5uCQ688ddjuhhfNeRxiSoGX4aGb1fvNu36x6HSTg+5
	 vXDHojzTtKDnsP4Ock79d4CeLZ4X9MUd//kWG3S5QFagdUjyXD1zVFEnFtSCmd2uFp
	 6qkx5QE5vAJp99dEXQYyDtROZSC2E7uoXFj0PD6UMnLMwKVr6AAWmuV9RlwujsvnjR
	 wmsfXQKaXYPpA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id DBD1F46CBF;
	Wed,  4 Nov 2026 06:40:05 +0000 (UTC)
From: Tjerk Kusters via B4 Relay <devnull+tkusters.aweta.nl@kernel.org>
Date: Wed, 04 Nov 2026 07:40:03 +0100
Subject: [PATCH net v5 2/4] igb: only strip Rx timestamp header on the
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
Message-Id: <20261104-igb-rx-ts-fix-v5-2-bf4b4367129a@aweta.nl>
References: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
In-Reply-To: <20261104-igb-rx-ts-fix-v5-0-bf4b4367129a@aweta.nl>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793774404; l=4403;
 i=tkusters@aweta.nl; s=20260619; h=from:subject:message-id;
 bh=Muj1rd8V+7QFHnH0EP+D3AEv7G+gn/NLGqm5+cNtKYU=;
 b=yE0/iq55XmocD6xBOygHgMVPMCdoQ88MXbW9BPw1dwyKdvR4SUZBJhRTVJ5Ql8cpv6JCuAlnC
 IkGKtVI0blhDVUqGq2M5abPfjrHFflepTbuHjkNqE3gdn1nn4nKNCUw
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
index 8abdd4e58550..cf9911137bd3 100644
--- a/drivers/net/ethernet/intel/igb/igb_main.c
+++ b/drivers/net/ethernet/intel/igb/igb_main.c
@@ -9122,8 +9122,11 @@ static int igb_clean_rx_irq(struct igb_q_vector *q_vector, const int budget)
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


