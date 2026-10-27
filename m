Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793102885;
	b=sXcrHnVai7hyTJh2XlPAZStE9snosQDmiycg0iXCafibkxIMK/MzVEpi63MUmG9bRCvo
	 mSLY0CwCRyL1Vn0bXCoCTcZCTARdlMW5Wb1ESodSPHlhXfpO8XZUDmYSftW+I4e69qq0Q
	 1Gz1Su02leAXNzMFjwAjeMdTQSPcS6Rdu7Cr3qOlY3RDG6bBEm2PiMV/Qjvvk+Wgs5sTr
	 8WmVIg+iHShgLrx4HIjYNLCog8uv+jaaj7xLOhwvPWeu59QztiN38U0tbLXMeUQhEU/jc
	 YpDWHb+bjpIht0BQA/QjcIdlcihk5LNrbAYouFdsws1R+bqIufUcmBnLOL2ecgVCYHw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793102885;
	h=DMARC-Filter:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Transfer-Encoding:Received:DKIM-Signature;
	bh=NW22/M5fUtaK0fVanACYV2rmeCp3k9/Yy4PuBxq5OEM=;
	b=w9Qdk1KQdwz3wO2pz3wVZX0PRxM29zV51xgDklQL/mc34wBzm4GCbA2DDBxkUFxaAAdL
	 BV9SZKwET+lEGz9fBRfER+8K1na3t2ShGXifnZyrEgNwK8thNse2SWWxjqBkLAPuOE9Zc
	 6RLEQjJbSIu4w8Kdzxngp+aQcWiLc2BCT/hNCw3tRBy4ko4B+GwCjKRCVf0kE3qq6/340
	 brYxK4PmBq5kPR5j0nz49AtkmOjFW1owblw6vTu/jnKxElyYXIvDfehzukrqgfUaZHuHZ
	 0nEbFiBnbvY1VjY3+Cvw9FGNnklMfxfkAoSundCkgpBTGKIeib25W90vFZOA+wMZPXQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=Ylglh9oZ;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC915606A31B;
	Tue, 27 Oct 2026 12:08:03 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org EC915606A31B
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=Ylglh9oZ
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: chris.snook@gmail.com,
	netdev@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Federico Musto <federico@rimpianto.com>
Subject: [PATCH net v2] net: atl1c: drop oversized RX frames instead of panicking
Date: Tue, 27 Oct 2026 12:51:51 +0100
Message-ID: <20261027115151.17092-1-federico@rimpianto.com>
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
	by mail.rimpianto.com (Haraka) with ESMTPSA id FA3F8D32-D33F-48D8-B99E-BCCF3E36FBBA.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Tue, 27 Oct 2026 12:51:51 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: Message-ID: Date: Subject: Cc:
 To: From; q=dns/txt; s=s20260314391; t=1793101912;
 bh=NW22/M5fUtaK0fVanACYV2rmeCp3k9/Yy4PuBxq5OEM=;
 b=Ylglh9oZqida7IEg+f7wmqe5HL89ZVj2dg5k2IR8dAKLn3vHbTNZXfWHjyjBnQdEnGKcTvopD
 9P7P3FBMlQ3TsrfKDez2aRvPB1pyupaWsygUST00t5bxOr1on+L7ThhgmLZ4wqa6DH5Nyxkf1rj
 Gvp/Rwf7GZmSIBVmc/5D7ugZJ8XKwmXSn0TMAD5Uf1bjCvy9UlfvyJHM+fwLxux6f44AnPmn7uD
 GWFPwCaaKfLRNB8h+vfyhSP1jVLs9yVHQ2TIgZGtcG6Vo/7G6lHUGdzzhd1zVGbJZn5T/T6+mha
 h6O3/OUGTNnBbI4RiajVpq5M9CKqUdKc6cyEotAQCVYw==

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

The frame is dropped with kfree_skb_reason(SKB_DROP_REASON_PKT_TOO_BIG) so
drop_monitor and the kfree_skb tracepoint see it, and counted through
dev_core_stats_rx_dropped_inc(), which survives atl1c_get_stats()
overwriting the hardware counters on every read.  It also counts as work:
atl1c_clean_rfd() has already recycled the RFD, and the refill at the end
of the poll only runs when work_done is non-zero, so sustained oversized
traffic would otherwise drain the ring and stop RX.

Tested on a MikroTik CCR2004-1G-2XS-PCIe (4x AR8151) in a Proxmox VE host,
with atl1c built from a DKMS tree carrying this change: the l2mtu-1600
traffic that panics the stock driver is dropped and counted with the patch
applied, and received normally once the host MTU is raised to match.

This complements commit 36c2009d90f2 ("net: atl1c: fix soft lockup on
out-of-range tpd_cons read"), which fixed the TX side of the same
"host dies while the card resets" problem.

Fixes: 43250ddd75a3 ("atl1c: Atheros L1C Gigabit Ethernet driver")
Cc: stable@vger.kernel.org
Signed-off-by: Federico Musto <federico@rimpianto.com>
---
v1 -> v2, after the Sashiko review:
 - bound the length by buffer_info->length instead of skb_tailroom(): the skb
   is allocated with 64 bytes of slack for the DMA erratum, so tailroom is
   larger than what the device wrote and a frame in between would have been
   delivered with stale tail bytes
 - count the dropped frame as work, so the RX ring is refilled; without it
   sustained oversized traffic could drain the RFD ring and stop RX
 - kfree_skb_reason() with SKB_DROP_REASON_PKT_TOO_BIG instead of
   dev_kfree_skb(), which is consume_skb(), and drop the rx_length_errors
   increment that atl1c_get_stats() overwrites anyway
 - the commit message now mentions the runt rejection as well

v1: https://lore.kernel.org/netdev/20261023093000.73535-1-federico@rimpianto.com/

Not touched here: the RRS_RX_ERR_SUM branch frees neither the skb nor its
DMA mapping (atl1c_clean_rfd() only marks the slot free and drops the
pointer).  That is pre-existing and independent of the panic, so it belongs
in a separate patch.
---
 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index e58f1d2..eddd840 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1934,6 +1934,39 @@ rrs_checked:
 			break;
 		}
 		atl1c_clean_rfd(rfd_ring, rrs, rfd_num);
+
+		/* A link partner whose l2mtu is larger than ours can hand us a
+		 * frame that does not fit the buffer the hardware was given:
+		 * the descriptor reports the untruncated length while at most
+		 * buffer_info->length bytes were written.  skb_put() of such a
+		 * length would pull in whatever the tail of the buffer holds
+		 * and, past the end of the skb, trips skb_over_panic and takes
+		 * the host down.  Bound it by what the device actually wrote
+		 * rather than by skb_tailroom(): the skb carries 64 bytes of
+		 * slack for the DMA erratum, so the two are not the same.
+		 *
+		 * Frames shorter than an Ethernet header plus its FCS are
+		 * rejected by the same test; before this, a length below
+		 * ETH_FCS_LEN underflowed in skb_put().
+		 */
+		if (unlikely(length < ETH_HLEN + ETH_FCS_LEN ||
+			     length > buffer_info->length)) {
+			dev_core_stats_rx_dropped_inc(netdev);
+			if (netif_msg_rx_err(adapter))
+				dev_warn_ratelimited(&pdev->dev,
+						     "dropped rx frame: %u bytes, buffer %u\n",
+						     length, buffer_info->length);
+			kfree_skb_reason(skb, SKB_DROP_REASON_PKT_TOO_BIG);
+			/* atl1c_clean_rfd() has already recycled the RFD, so
+			 * count the drop as work: the refill at the end of the
+			 * poll only runs when work_done is non-zero, and
+			 * sustained oversized traffic would otherwise drain the
+			 * ring and stop RX for good.
+			 */
+			work_done++;
+			continue;
+		}
+
 		skb_put(skb, length - ETH_FCS_LEN);
 		skb->protocol = eth_type_trans(skb, netdev);
 		atl1c_rx_checksum(adapter, skb, rrs);
-- 
2.54.0 (Apple Git-157)

