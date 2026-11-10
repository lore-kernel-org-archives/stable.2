Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794273964;
	b=MtL6t6wwUltZ1GE92xcS22iccS0ED6wadB8FEuCpBsuSb37OcbeLbZhKVvpVwB8FQ1Hr
	 TtzasbsGtIe6IkmK1lYaWc0EbeuRQZtjSe/Ufy2x62joVsXIpe2hmCSToNzEwA3Y126eH
	 L3Jd+QSrol2s78G7/AXAkT4SSKzrMUvexSxoo9XUBRSybQePCrMYAFQvQt55HAuYAoRHk
	 b7/KE1JOTZzVJ4KlJq5LiYbFR56VRd1zh7WYilg72MNx4aecCEetcc9pc9wctuZzWarmM
	 Itp7Vw/0yTuMoL6Dg4qp4Snd8ICTjhP/lv3Kj65Xb8DHzyo5f9Ubq1FFRUDhtO38qyg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794273964;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=XZlK++nrVAYj2Vbrio0pZgxgBGidWaExfTgE8aBani8=;
	b=UIS5q7z8PRGGXvgI9OvHlU1OsXOg5wtVfzr8ycRc95L9tvkEyzwmWraSWPibDORFzGN6
	 1ouktv1k2BR444b2RN5aLwh3RMy2irL1ER5l8UF3vESomhxE5kdnNklsuYePiI4a494TS
	 XxFftmGsPC5hSmIkVFo9gNPnRN7hwBsUur9iLM633teEmz9n0Pptnn+1qO/emOEJiURtX
	 6sYjzFy0Eulpg9HRM6TP3G0EnxbOzU7BAUg69UzTpLaL/bo4M+rC/4fOIVdXylnDdAO5H
	 fCBRJVJKjZcfxigQzTbcQ6xqFQHkjrQims0G3FI5t6YTRRrE5elHW7vIt4braY6YuxQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n10kfwlG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFC0760A2603
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 01:26:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n10kfwlG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FC31F0089F;
	Tue, 10 Nov 2026 01:26:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794273963;
	bh=XZlK++nrVAYj2Vbrio0pZgxgBGidWaExfTgE8aBani8=;
	h=From:To:Cc:Subject:Date;
	b=n10kfwlGNmwuIihFsRQ/R2rx18RUvQE8zLQoVs+WUdweoUFBuJ9fpoF/Fstt1wLKo
	 KgWCWh7eTPIEO7xZWDI5spVInhnKvpGxh2m9c6HUuUSQJnEkHyiRhhvUhGIeX1nKj9
	 gyJDKO+C9RcVpCC2ro7aiTFYfFsfr2ywiAy/Ec1B2T/fNspGxnwGB7ZwIRkw4xumut
	 VxZ+OkXEYkMkXPko57sJrWgaWPw1R/nmz4Fc0s/2Hk90C/mYB4Ytm6TXApLGgOu2Ro
	 pXp/UgMoxC1vBjjw4iO70SX5CwVgVdHaBL4ToWKPVK/ZsNHAFmNjtq8t72hkEvZv34
	 /DszSGApqVu/Q==
From: Sasha Levin <sashal@kernel.org>
To: federico@rimpianto.com,
	davem@davem-thinkpadp1gen8.ibmlond.csb
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] net: atl1c: drop oversized RX frames instead of panicking" failed to apply to 5.10-stable tree
Date: Mon,  9 Nov 2026 20:26:02 -0500
Message-ID: <20261109202602-failed-5.10-c4ba1716853d@kernel.org>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x c4ba1716853de5178a9df785844ebb5e397a80e6
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261109202602-failed-5.10-c4ba1716853d@kernel.org' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From c4ba1716853de5178a9df785844ebb5e397a80e6 Mon Sep 17 00:00:00 2001
From: Federico Musto <federico@rimpianto.com>
Date: Tue, 27 Oct 2026 12:51:51 +0100
Subject: [PATCH] net: atl1c: drop oversized RX frames instead of panicking

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
---
 .../net/ethernet/atheros/atl1c/atl1c_main.c   | 33 +++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
index e58f1d2c26bdf..eddd8406867f7 100644
--- a/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
+++ b/drivers/net/ethernet/atheros/atl1c/atl1c_main.c
@@ -1934,6 +1934,39 @@ static int atl1c_clean_rx(struct napi_struct *napi, int budget)
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
2.53.0




