Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794353925;
	b=is57tSIYL8UhEJjTvgyZCoG6ac0zocyej/42yVfHHhv7cLIfmnfrSw1Z3QEUu4lAaAM6
	 Oy3PaqSGTbbQyhIk0oZzQ8/KpmUuY1mmh/R2XkbFvVjpoM9glaV+9jgfdSgHVh12RkOUT
	 2W8UJxsyM51X5f/zGU73XAJfDcYc3x0y+G7gbc1b5Shhpaf3+RRD8Z4yiz+tt5PfqvXjN
	 dw9ZOebfrW6d4rkoWY1wQPSjhuzPE2IRsbmrPv15e9NwmEAyfLlybQbn7+Km4ahvs3i7q
	 zHgIwx6vTQQMTH+8f18mZYScGRRDCNporioTZ3+gbsysR1+q8cExFcthOkHlegvF7FA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794353925;
	h=DMARC-Filter:From:To:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding:Received:DKIM-Signature;
	bh=BYtc4AWPhVny+xhWBL5yTfMna4RAO65E69fTWhvxPwk=;
	b=38QvEbSmKMlOvInS14kCrpLLtbf9FjQPhVb8ITvF6neJ5STLuFcNjK2pLY5xOqL831qN
	 ZhLBNpiARIo4v9QqxbNL5Ujib19Bie0PgHUVpHKqLE4ukPObzbIEcvIfPd3DbInc3H+31
	 skIRMTOIcOF5m9obilal50w12SLS/skzOCYOBT09B4ZNgbJ6be0MF0V2KV8lBHhVHZlXh
	 3SInngUpPemFCzddakIIk6ogmS5aD2DUHF/Q2U2J3kfTRmc1kN4kG5EmfWtMr1YwBteh7
	 Jhw14a76ny83IEMp1977kh/i89Eqp3edCXyjCvfLUOE5ZiGkNYxZRRYhAFNpf18Tn0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=e1AMSiso;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EEC27606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 23:38:44 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EEC27606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=e1AMSiso
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10] net: atl1c: drop oversized RX frames instead of panicking
Date: Wed, 11 Nov 2026 00:38:36 +0100
Message-ID: <20261110233836.64643-1-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Received: from localhost (Unknown [127.0.0.1])
	by mail.rimpianto.com (Haraka) with ESMTPSA id CB050659-9BD4-43A6-B2F7-D678A45293AA.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Wed, 11 Nov 2026 00:38:36 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: To:
 From; q=dns/txt; s=s20260314391; t=1794353916;
 bh=BYtc4AWPhVny+xhWBL5yTfMna4RAO65E69fTWhvxPwk=;
 b=e1AMSisoGmeJTmW38MjXLtuf1RtrX71NFj6Qw4cGiSe/8l173QZannD4e6gLKfxjPfqS+BWPl
 DiB/3uhPdgkN5S4xl86vGmQ+3UxG3Xv2tNPnPWJhFF8TnEF2uOgOAqv4BtEc/N+2FRZLnl4oMql
 rLMXhKxyc2LkLugUzmHK5nRpVazY9U5kxhv9T5XkgPhrVCun8Mj8za0yjodccJ45FF/linudATG
 NvO8aiIDgn8R5A+10j/Cx8rqOhaIi9u4TDQ3bSvobR5XNflK0zmu7mJlH+VI80V4HTaVGc6jJA4
 +Fg+Pc/VZTkIOYd884CIjqj79+gTWORqmdC74s9CMuxQ==

[ Upstream commit c4ba1716853d ]

atl1c sizes its receive buffers from the netdev MTU plus a fixed set of L2
overheads, which comes to 1522 bytes at the default MTU.  A link partner
that sends a longer frame - in practice a MikroTik CCR2004-1G-2XS-PCIe,
whose RouterOS side defaults to l2mtu 1600 while the host stays at MTU 1500
- makes the length reported by the RX return descriptor exceed what the
hardware wrote, and skb_put() then either includes bytes that were never
received or trips skb_over_panic and takes the host down.

Compare the descriptor length against buffer_info->length, the length the
hardware was given, rather than against skb_tailroom(): the skb carries 64
bytes of slack for the DMA erratum, so tailroom is larger than the DMA
buffer and a frame in between would pass the check and still be delivered
with a tail the device never wrote.  The same test rejects frames shorter
than ETH_HLEN + ETH_FCS_LEN; before this change a reported length below
ETH_FCS_LEN underflowed in skb_put().

The frame is dropped and counted, and it counts as work: atl1c_clean_rfd()
has already recycled the RFD, and the refill at the end of the poll only
runs when work_done is non-zero, so sustained oversized traffic would
otherwise drain the ring and stop RX.

[ Backport to 5.10: dev_core_stats_rx_dropped_inc() is not available
  before v5.16 and kfree_skb_reason()/SKB_DROP_REASON_PKT_TOO_BIG before
  v5.17, so count with netdev->stats.rx_dropped++ and free with
  dev_kfree_skb_any() instead.  work_done is an int * in
  atl1c_clean_rx_irq() here, so increment (*work_done)++.  The drop count
  does not survive atl1c_get_stats() overwriting it, but the panic is
  fixed. ]

Fixes: 43250ddd75a3 ("atl1c: Atheros L1C Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Federico Musto <federico@rimpianto.com>
---
 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 22 +++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 46a293b..5ab85cf 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1844,6 +1844,28 @@ rrs_checked:
 			break;
 		}
 		atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
+
+		/* A link partner whose l2mtu is larger than ours can hand us a
+		 * frame that does not fit the buffer the hardware was given:
+		 * the descriptor reports the untruncated length while at most
+		 * buffer_info->length bytes were written.  Bound it by what the
+		 * device actually wrote; a frame longer than that would make
+		 * skb_put() pull in bytes the device never wrote and, past the
+		 * end of the skb, panic the host.  Frames shorter than an
+		 * Ethernet header plus its FCS are rejected by the same test.
+		 */
+		if (unlikely(length < ETH_HLEN + ETH_FCS_LEN ||
+			     length > buffer_info->length)) {
+			netdev->stats.rx_dropped++;
+			if (netif_msg_rx_err(adapter))
+				dev_warn_ratelimited(&pdev->dev,
+						     "dropped rx frame: %u bytes, buffer %u\n",
+						     length, buffer_info->length);
+			dev_kfree_skb_any(skb);
+			(*work_done)++;
+			continue;
+		}
+
 		skb_put(skb, length - ETH_FCS_LEN);
 		skb->protocol = eth_type_trans(skb, netdev);
 		atl1c_rx_checksum(adapter, skb, rrs);
-- 
2.54.0 (Apple Git-157)

