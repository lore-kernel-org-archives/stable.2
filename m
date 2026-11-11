Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=46.14.198.178
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794371329;
	b=LCKW4IuSj82IPN46/TECb3jlvZcpI/hWfDEvvZ9mAeVodBCiwgH94HyKebEcmup8xqYC
	 jN4SrhpxBREdT0F0N1Fg7C7pBCsQijuL0lYu6zlCwUI65yBhnR6LsvJKL06Cw3gj6FXg5
	 KTGcia4dEjweHyfKFN+mJrP73VKxwJEE9WZhF45s3FPiUEsMpnezFq/dC+rX4CRhSXhif
	 zMmH7nt4tNO83DOsMc0RRIm9bB/886UYUrFYf4St2KGTnnhduCQKCsafRRB12NMQTO8oA
	 +FVRrBUDuzjsXkY9cdu93oZdlZwI/GvVtsGeAc+zgBbU9TdDYNAi4k1ikLkgmLvl7EQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794371329;
	h=DMARC-Filter:From:To:Subject:Date:Message-ID:X-Mailer:In-Reply-To:
	 References:MIME-Version:Content-Transfer-Encoding:Received:
	 DKIM-Signature;
	bh=mE/QHsD357zcjEUFILZ+oJELgA6OcyStFwafNTVvp0M=;
	b=sq7dD1l+RejSX2gCftvXEl02D/oU6X87O4r7PEAKhbf4wyTfSM89uNZaapEwQslXHPoG
	 DgkegxqebtaH1Gq8tFwmr/CveXEhHUaN+AiVrtv1bWWhsuOVcBW5ppIAgIC0Sh8Ixrw4j
	 KFZ7uqbMs0bomuCJBJIzi6xYg39RJer0lLE0BSxmv8P/VlnWBMaIr/sBY07NM09NJCJYL
	 pD833MP2p3HrJBOLTz6Qtv/ALIC4Jtp1OAY9SruSRBvspzVJKLu5LFwr4WLSvtRdE5Lvz
	 9BV2D+wlvwdVsBhwnF4THQJFV/+PqWv0KXHn9E0qKSE2dpf95/sNCDZl4++CbkE1DZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=rimpianto.com;
	spf=pass smtp.mailfrom=rimpianto.com;
	dkim=pass header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=YaG0H4yO;
	arc=none smtp.remote-ip=46.14.198.178
Received: from mail.rimpianto.com (mail.rimpianto.com [46.14.198.178])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F586606A31C
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 04:28:48 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 0F586606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rimpianto.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=rimpianto.com header.i=@rimpianto.com header.a=rsa-sha256 header.s=s20260314391 header.b=YaG0H4yO
Authentication-Results: mail.rimpianto.com;
	auth=pass (plain)
From: Federico Musto <federico@rimpianto.com>
To: stable@vger.kernel.org
Subject: [PATCH 5.10.y v2] net: atl1c: drop oversized RX frames instead of panicking
Date: Wed, 11 Nov 2026 05:28:46 +0100
Message-ID: <20261111042846.78846-1-federico@rimpianto.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20261109202602-failed-5.10-c4ba1716853d@kernel.org>
References: <20261109202602-failed-5.10-c4ba1716853d@kernel.org>
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
	by mail.rimpianto.com (Haraka) with ESMTPSA id 2CF8FC01-95F0-4B7B-BA18-0AAD64AE2DA3.1
	envelope-from <federico@rimpianto.com>
	tls TLS_AES_256_GCM_SHA384 (authenticated bits=0);
	Wed, 11 Nov 2026 05:28:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rimpianto.com;
 h=Content-Transfer-Encoding: MIME-Version: References: In-Reply-To:
 Message-ID: Date: Subject: To: From; q=dns/txt; s=s20260314391;
 t=1794371327; bh=mE/QHsD357zcjEUFILZ+oJELgA6OcyStFwafNTVvp0M=;
 b=YaG0H4yOnZWuASRHZAFNynnnHYFOZb9DCQ56c64w3E39lsnPmLuJG8r9Q3nisMMKSfe/8FqP2
 66X6roi6riBZGMFsC2+pat9FurlScMJRNuZDSBHrrWMBzKpfQZAgKGE1ZmOHSnNy3tZlD31XhEq
 3odIkz/C/3w4OFW0rb0W27L8obVxtESxo2Htf1CYbWKCT5ru/O6qopQkTsN72S4aw1cBQyWE6ph
 NUqnIDqhJuhEGqZYIV9iuvDA9l5ukTeWWtjObN3zZFlRLxb639rPkDVCbEpUu818+siHWxqvZX1
 tDdoRMPxf5ewPY0Apbtu89+29oIkATcB6x9+2oD/ONPA==

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
[ Federico Musto: 5.10.y has neither dev_core_stats_rx_dropped_inc() nor
  kfree_skb_reason(): count the drop in netdev->rx_dropped, the counter
  dev_core_stats replaced, which dev_get_stats() adds to what
  atl1c_get_stats() returns, and free the skb with kfree_skb().  The RX
  loop is atl1c_clean_rx_irq() here: work_done is an int * and the refill
  at the end of the poll is gated on the local count, so the drop path
  bumps both.  5.10.y does not have the 64 bytes of RX slack from commit
  86565682e905 ("atl1c: Work around the DMA RX overflow issue"), but the
  skb can still be larger than the buffer mapped for DMA, so the bound is
  the same and only the comment is reworded.  Build-tested only, not run
  on hardware. ]
Signed-off-by: Federico Musto <federico@rimpianto.com>
---
This replaces the 5.10 backport I sent on 2026-11-10 (v1, link below);
please drop v1 if it was picked up.

v2:
 - bump count in the drop path as well as *work_done.  In 5.10.y the
   refill at the end of atl1c_clean_rx_irq() is gated on count, so with
   v1 a poll that only saw dropped frames did not refill, and sustained
   oversized traffic could still drain the RFD ring and stop RX.
 - count the drop in netdev->rx_dropped instead of
   netdev->stats.rx_dropped, which atl1c_get_stats() overwrites on every
   read.
 - free with kfree_skb() instead of dev_kfree_skb_any().
 - keep the upstream commit message as is and describe the 5.10 changes
   in the note; v1 also gave wrong versions for the missing helpers.
 - reference the upstream commit by its full id and reply to the FAILED
   mail, as asked there.

v1: https://lore.kernel.org/stable/20261110233836.64643-1-federico@rimpianto.com/

Build-tested on 5.10.274, x86_64 defconfig + CONFIG_ATL1C=m, gcc 14.2.0,
W=1 C=1 with sparse 0.6.4: the same 30 warnings before and after, none
new.  Not run on hardware.

 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 34 +++++++++++++++++++
 1 file changed, 34 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index 46a293b..1a930cd 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1844,6 +1844,40 @@ rrs_checked:
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
+		 * rather than by skb_tailroom(): the skb can be larger than
+		 * the buffer mapped for DMA, so the two are not the same.
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
+			 * poll only runs when count is non-zero, and
+			 * sustained oversized traffic would otherwise drain the
+			 * ring and stop RX for good.
+			 */
+			(*work_done)++;
+			count++;
+			continue;
+		}
+
 		skb_put(skb, length - ETH_FCS_LEN);
 		skb->protocol = eth_type_trans(skb, netdev);
 		atl1c_rx_checksum(adapter, skb, rrs);
-- 
2.54.0 (Apple Git-157)

