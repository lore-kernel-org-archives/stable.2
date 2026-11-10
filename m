Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794281232;
	b=lPRYEoU6zPCB6z2k9lZJylIAC6eae3WzuHL7DyR35puebBPnzs67QgkpYC3grS/vUy4b
	 VUyD4MKq1FIJ89DYclu4L6+TFh5UdA0kD2M2TGjoYu1vHzg4IRleLkT8apLj9+Rxhqfzl
	 nIpZND8To2dLn3TVaKz2yO5jzvBDG2q4T+dQm/sofvpyk+sYvSlp9UMI/tE5HmTyLwm/L
	 ArDSObyol1sGu0omJOm80TxQERQNGThRObrxgk6spR53ugv6JgWKGxM/ImdH+xiQizjxt
	 yqbdaJLvlr412Js7bQazvY7NtG7uNYWSEcMZCe6dTC8/v8DDgbD7exohaYgDfNc9cgA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794281232;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=9AvXbhAHvbIJydkc7wESiwVHrCSozIEixPr0a6MRCKU=;
	b=m0flt+GHJmsppt4YNzDJtoxK4P+Kd/8ygSSFuZRZqMY888q2ZLABUfYX5l8gTjygF0qR
	 DiR0pNGYw7MWg4ddYr4+mqkvRtzxxNfbZRYhnZzvxltAEYpMBwXFTzVBygO22HBOzr/P8
	 HOr1H3e+wn/c7+8t6RHL59ottfl0L5AoJHQ5HI+w3KIJRHYAzcOpD0WCQDG9EudxZDzEz
	 BTGxHTgQYOKO8ltSTjWIFlilGT3fzuIJpGm8ZNh68txmj1Ys652tyceFgeoO+ElExX5lv
	 rDNG4jQGm8oEx7wq4Jy3B4PODwdWDNMMpXoLp8ZJ/p9avE6ifGAk3M9guIA5FSaKuMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aozM+Nih;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98FD1606A325
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 03:27:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=aozM+Nih
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5C7FC1F008A1;
	Tue, 10 Nov 2026 03:27:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794281231;
	bh=9AvXbhAHvbIJydkc7wESiwVHrCSozIEixPr0a6MRCKU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=aozM+NihZY5OPcf8job308tNgSAnBpRH8TQ5K6hUHmfPIje1imwTN5Zp6aPeVtVzF
	 bfsGqRif+kBSo6M46ElrUaAEIbPn7pmY622MLDpTEfbEdJ1YGwoQE1I3mAc8csmbEP
	 SBaDtSfq7GwsQDgD2ZYqSSpB/bXnGkPm4th+eB7ctj+I2GZY9qTeuYFovz6/CRxUDB
	 RHr2TAC0qYlDoVZfTBz9gcR+MWnCuJgtiukBwPUEfp19SBq6Kaux6IHbvmrkLWpXVI
	 fERvCTwINwjxlY9plwyWfN1mWUDzmALAIm/MSrMgxxhGLwT+9Ar3weiOuA98BzZUu0
	 HJ8jPQIbC/TSg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/2] wifi: mac80211: queue frames while off-channel
Date: Mon,  9 Nov 2026 22:27:09 -0500
Message-ID: <20261110032703.180401-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110032703.180401-1-sashal@kernel.org>
References: <20261107052845-failed-6.6-13e51269b665@kernel.org>
 <20261110032703.180401-1-sashal@kernel.org>
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

From: Stanislaw Gruszka <stf_xl@wp.pl>

[ Upstream commit 13e51269b6656768dc595ed6025e4974f2026543 ]

Drivers without FAST_XMIT and hardware scan support currently drop TX
frames during software scanning while being off-channel. This happens
in ieee80211_tx_h_check_assoc() before frames reach internal TX queue.

Move the off-channel check to invoke_tx_handlers_late(), after
ieee80211_queue_skb(). Frames can then remain queued and be transmitted
when the interface returns on-channel. This how TX works currently when
code goes via ieee80211_xmit_fast() path.

Below is rt2x00 driver ping output example while scanning, before and
after the fix. After the fix, packets are no longer lost. Some have
increased latency, what is expected behavior.

BEFORE:
64 bytes from 192.168.0.1: icmp_seq=29 ttl=64 time=3.61 ms
64 bytes from 192.168.0.1: icmp_seq=31 ttl=64 time=3.33 ms # Missed 30
64 bytes from 192.168.0.1: icmp_seq=32 ttl=64 time=4.03 ms
64 bytes from 192.168.0.1: icmp_seq=34 ttl=64 time=3.10 ms # Missed 33
64 bytes from 192.168.0.1: icmp_seq=36 ttl=64 time=3.04 ms # Missed 35
64 bytes from 192.168.0.1: icmp_seq=38 ttl=64 time=3.05 ms # Missed 37
64 bytes from 192.168.0.1: icmp_seq=40 ttl=64 time=4.14 ms # Missed 39
64 bytes from 192.168.0.1: icmp_seq=41 ttl=64 time=4.50 ms

AFTER:
64 bytes from 192.168.0.1: icmp_seq=29 ttl=64 time=3.40 ms
64 bytes from 192.168.0.1: icmp_seq=30 ttl=64 time=6.10 ms
64 bytes from 192.168.0.1: icmp_seq=31 ttl=64 time=4.69 ms
64 bytes from 192.168.0.1: icmp_seq=32 ttl=64 time=4.49 ms
64 bytes from 192.168.0.1: icmp_seq=33 ttl=64 time=148 ms
64 bytes from 192.168.0.1: icmp_seq=34 ttl=64 time=6.83 ms
64 bytes from 192.168.0.1: icmp_seq=35 ttl=64 time=8.66 ms
64 bytes from 192.168.0.1: icmp_seq=36 ttl=64 time=13.0 ms
64 bytes from 192.168.0.1: icmp_seq=37 ttl=64 time=4.78 ms
64 bytes from 192.168.0.1: icmp_seq=38 ttl=64 time=3.85 ms

Cc: <stable@vger.kernel.org>
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
Link: https://patch.msgid.link/20260908124651.2995-1-stf_xl@wp.pl
Signed-off-by: Johannes Berg <johannes.berg@intel.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 52 +++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 14513d4fe6329..c0e9ed8ec1d19 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -283,7 +283,6 @@ ieee80211_tx_h_dynamic_ps(struct ieee80211_tx_data *tx)
 static ieee80211_tx_result debug_noinline
 ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
 {
-
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx->skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
 	bool assoc = false;
@@ -291,20 +290,6 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
 	if (unlikely(info->flags & IEEE80211_TX_CTL_INJECTED))
 		return TX_CONTINUE;
 
-	if (unlikely(test_bit(SCAN_SW_SCANNING, &tx->local->scanning)) &&
-	    test_bit(SDATA_STATE_OFFCHANNEL, &tx->sdata->state) &&
-	    !ieee80211_is_probe_req(hdr->frame_control) &&
-	    !ieee80211_is_any_nullfunc(hdr->frame_control))
-		/*
-		 * When software scanning only nullfunc frames (to notify
-		 * the sleep state to the AP) and probe requests (for the
-		 * active scan) are allowed, all other frames should not be
-		 * sent and we should not get here, but if we do
-		 * nonetheless, drop them to avoid sending them
-		 * off-channel. See __ieee80211_start_scan() for more.
-		 */
-		return TX_DROP;
-
 	if (tx->sdata->vif.type == NL80211_IFTYPE_OCB)
 		return TX_CONTINUE;
 
@@ -814,6 +799,33 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
 	return TX_CONTINUE;
 }
 
+static ieee80211_tx_result debug_noinline
+ieee80211_tx_h_check_offchannel(struct ieee80211_tx_data *tx)
+{
+	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx->skb->data;
+	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
+
+	if (unlikely(info->flags & IEEE80211_TX_CTL_INJECTED))
+		return TX_CONTINUE;
+
+	if (unlikely(test_bit(SCAN_SW_SCANNING, &tx->local->scanning)) &&
+	    test_bit(SDATA_STATE_OFFCHANNEL, &tx->sdata->state) &&
+	    !ieee80211_is_probe_req(hdr->frame_control) &&
+	    !ieee80211_is_any_nullfunc(hdr->frame_control)) {
+		/*
+		 * When software scanning only nullfunc frames (to notify
+		 * the sleep state to the AP) and probe requests (for the
+		 * active scan) are allowed, all other frames should not be
+		 * sent and we should not get here, but if we do
+		 * nonetheless, drop them to avoid sending them
+		 * off-channel. See __ieee80211_start_scan() for more.
+		 */
+		return TX_DROP;
+	}
+
+	return TX_CONTINUE;
+}
+
 static __le16 ieee80211_tx_next_seq(struct sta_info *sta, int tid)
 {
 	u16 *seq = &sta->tid_seq[tid];
@@ -1866,6 +1878,7 @@ static int invoke_tx_handlers_late(struct ieee80211_tx_data *tx)
 		goto txh_done;
 	}
 
+	CALL_TXH(ieee80211_tx_h_check_offchannel);
 	CALL_TXH(ieee80211_tx_h_michael_mic_add);
 	CALL_TXH(ieee80211_tx_h_sequence);
 	CALL_TXH(ieee80211_tx_h_fragment);
@@ -4632,10 +4645,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	queue = ieee80211_select_queue(sdata, sta, skb);
 	skb_set_queue_mapping(skb, queue);
 
-	if (unlikely(test_bit(SCAN_SW_SCANNING, &local->scanning)) &&
-	    test_bit(SDATA_STATE_OFFCHANNEL, &sdata->state))
-		goto out_free;
-
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return;
@@ -4713,11 +4722,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	ieee80211_tpt_led_trig_tx(local, len);
 
 	ieee80211_tx_8023(sdata, skb, sta, false);
-
-	return;
-
-out_free:
-	kfree_skb(skb);
 }
 
 static bool ieee80211_check_mcast_offload(struct ieee80211_sub_if_data *sdata,
-- 
2.53.0

