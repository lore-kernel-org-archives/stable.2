Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371329;
	b=CerbWiuM9gWZi4khVYXElCE10vkxbH7+0SS4l0hrxoTRxQjAwLJN+DnjLpg13JPibG1K
	 mZODRe1ZPWnhV/G3JI0zyHMumQnE47xUs69DM/6YGS8ACcvWuQ9W5HOEvxM97sPlzQCwr
	 AebO+j+Nt/wI042Ebp4VJDTcPs99jzywwUmVhHM0dXwi3P+UOwZp31yaeWJu0BAwKGWYq
	 6IHrlWlbdvoD1k6Y72oHS2I+7ce974rP8gTmSO+53IyIPulBHFEEShBKeM9c1eqAwK69Q
	 t1RksaGn4BOIk9rpW1nu8QIDaEsoP4Sd4CERkq5hRQ/q6b7l4c+CHedYtVYOMcrDgAQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371329;
	h=DMARC-Filter:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Received:
	 DKIM-Signature;
	bh=h3pmhXjmpaykbRJj2AtZ/5WNRt4fRDBqGzOQ/uiNSc8=;
	b=oH567EUnv5n8iHPMNeJqLhoFiseAjZUQ4U5zef9pUk50CE4kEM3NuAQSnfvxtkUfCZMf
	 RSRgcHZwKhzdECq58fod4I1155V6Rt2csLE8HEeJrOaL1Z1+jSh1gdVUWH2jW+taf9Y2V
	 NRXVOyQ3Trpyl9FSiLN3h0F1rVDogcMII0r3ELFYQiELYV23q3elAuu0og+k6Wrr9I9Lb
	 b5VOlsRq6eupAwBafAkPPfusm4j1sDFuQBHsgOptlieSWk9yNqgglFy97BNMjS8bKI8bB
	 pREhx/IvVsOm3IpHYOuU1nHxcOfTTdRD4rx7cqY8EOW8M7puX1m0HIDfvNmPY4wpeaA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=Bjl4yX8N;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3710C606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:28:49 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3710C606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=Bjl4yX8N
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.15.y] net: atl1c: drop oversized RX frames instead of panicking
Date: Wed, 11 Nov 2026 05:28:47 +0100
Message-ID: <20261111042847.78866-1-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109202059-failed-5.15-c4ba1716853d@kernel.org>
References: <20261109202059-failed-5.15-c4ba1716853d@kernel.org>
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
	by mail.rimpianto.com (Haraka) with ESMTPSA id 4C8F15E1-46AA-4CFA-95CD-313C424871EA.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Wed, 11 Nov 2026 05:28:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: To: From; q=dns/txt; s=s20260314391;
 t=1794371327; bh=h3pmhXjmpaykbRJj2AtZ/5WNRt4fRDBqGzOQ/uiNSc8=;
 b=Bjl4yX8NCmfnkxKTq5N9wOP/S9f1Nm4NtK2DzqF2QxAhXFggZ75J52E066GWXHOdblnmqp8Lb
 QOoBS43Z9QylrPOJGiWNw93fDtEv8FtOOUs8j3Te1Lmvt+voDuynJ/ZMcF/6ekEgC26cqZpnuXK
 fIStdKRr/ektWcqol2TnJjYb0g2zD4IZ5CQBIOFhld2k0KhGUPOdnaoE8U8ukeaGpT1ckjhMx7E
 OroYmeOnX43djExSeEqcXMsWU0E/FVKeChvfODvpRqO4LwVNdqSjaEMfayo1USa0WPI+d1Kds19
 yvM09baMibnvCX+s3HejTHEMKoP9fYpBZw/jZPwxnv+g==

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
Signed-off-by: Dave Miller <davem@davem-thinkpadp1gen8.ibmlond.csb>
(cherry picked from commit c4ba1716853de5178a9df785844ebb5e397a80e6)
[ Federico Musto: 5.15.y has neither dev_core_stats_rx_dropped_inc() nor
  SKB_DROP_REASON_PKT_TOO_BIG: count the drop in netdev->rx_dropped, the
  counter dev_core_stats replaced, which dev_get_stats() adds to what
  atl1c_get_stats() returns, and free the skb with kfree_skb().
  Build-tested only, not run on hardware. ]
Signed-off-by: Federico Musto <federico@rimpianto.com>
---
The upstream patch applies to 5.15.y but does not build there:
dev_core_stats_rx_dropped_inc() and SKB_DROP_REASON_PKT_TOO_BIG are
missing.  The two substitutions are described in the note above.  The
5.10.y backport is sent separately.

Build-tested on 5.15.225, x86_64 defconfig + CONFIG_ATL1C=m, gcc 14.2.0,
W=1 C=1 with sparse 0.6.4: the same 31 warnings before and after, none
new.  Not run on hardware.

 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index a8ac469..c30540f 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1943,6 +1943,39 @@ rrs_checked:
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
+			atomic_long_inc(&netdev->rx_dropped);
+			if (netif_msg_rx_err(adapter))
+				dev_warn_ratelimited(&pdev->dev,
+						     "dropped rx frame: %u bytes, buffer %u\n",
+						     length, buffer_info->length);
+			kfree_skb(skb);
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

