Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794283347;
	b=TCsTHOBFf7JCSM1hjG2flU3kX78LLixLjuWy15GYQu0TfUw0qME+piRivVmWK9u+mU32
	 CHcsNy7kq4PFQq65/u7gXVf1JJlEX8FktnILOaPCLtbJHGbWdM0ZSl0J9CpWJ4vYy+086
	 v04luicttkov+JZvfAP+3y2JlmhDONOAkzUHud4mr8TvXJP72B51VqjAmYkGM83XutURf
	 lhU/fQHyrWVANE54wNrLS/JSjU2Z7rsCiVGsaBVPMqIC8cooMqVs1UHVn45yyInOhSpn4
	 lBIzSJFx2SYAAHSrVKsF+A9Lbx+3iOQ50re6xJNeg9h721q4rrDq1CWwilHtrQm8kHg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794283347;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RX8KVuP4hLj4sjlHe2hWC1RxRmgIKO4ozvLv6zyPbkw=;
	b=pxmNdKVvr/PX1GZzDrxtQwsIXQi3TzFs//LXXf1otXzjxRZ2XZ289RoSGDsRbpbP9PNz
	 wKWcy4HYTFQ9Gk2jfgcyET+RB3u1MV/QyuYKu/3hQNzlQn2YBPjZ6Hi8axI0KgRPoQ5u/
	 lJa9Un/VSIWd73ON0Rrmstl619qv6GBuLRSEcsaS1o1N0T2xfojSvWCCx5ekztvJVCR8P
	 +n6WiipoMFTg6Pgj0hG8Kk6+dlNLXiavevl0nKqc44cTg5kF/dlLkG3maufBZ1s23HK/S
	 2DZVPcUUR9rxoFzO8MvCWWg+bAH1GrXa5lxJRqGzNOcz5YzMGPDYkjmGl1LaVY+fxOg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pz6JnnK0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CB29606A32A
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 04:02:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Pz6JnnK0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5446B1F0089F;
	Tue, 10 Nov 2026 04:02:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794283345;
	bh=RX8KVuP4hLj4sjlHe2hWC1RxRmgIKO4ozvLv6zyPbkw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Pz6JnnK0q+2RBd4MBEZfWFtsd/h7hxhGkwidFVXGcfi9tTnmV1cbdtLEbMisU8TvU
	 kLhnt84b9Qe0gJ3yJusqVYzGShcqmOflWcnqdlAug/hkqvgQ4u6A/Ppk/fIB/wsCxr
	 A5CbuUi/fIueG+6gxSyIA6nS4Ma0l4Z+Ycceol1EN1Up1ie0vMC+0UkwDPPkWRnBo+
	 Tgqo92E5li2BfBcKHzT+aBQJ24S7ow2XDOmcphuGA9zLIgEef00M9r/CaolpgTbu+j
	 yG0RSb/eE1xAsvE2s75GKmXu9UahbKmfDUAXbfZ/U9mPebGpxxT/6qltdhVW9B8Qp5
	 +1I7EnRUjVkqA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes.berg@intel.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] wifi: mac80211: queue frames while off-channel
Date: Mon,  9 Nov 2026 23:02:24 -0500
Message-ID: <20261110040201.287336-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107055753-failed-5.15-13e51269b665@kernel.org>
References: <20261107055753-failed-5.15-13e51269b665@kernel.org>
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
[ sashal: preserved the existing memset() initialization and out_free cleanup path in ieee80211_8023_xmit() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 net/mac80211/tx.c | 50 ++++++++++++++++++++++++++---------------------
 1 file changed, 28 insertions(+), 22 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index a919d585b6b1b..6e5dde41e11e6 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -282,7 +282,6 @@ ieee80211_tx_h_dynamic_ps(struct ieee80211_tx_data *tx)
 static ieee80211_tx_result debug_noinline
 ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
 {
-
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx->skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
 	bool assoc = false;
@@ -290,23 +289,6 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
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
-		 * off-channel. See the link below and
-		 * ieee80211_start_scan() for more.
-		 *
-		 * http://article.gmane.org/gmane.linux.kernel.wireless.general/30089
-		 */
-		return TX_DROP;
-
 	if (tx->sdata->vif.type == NL80211_IFTYPE_OCB)
 		return TX_CONTINUE;
 
@@ -791,6 +773,33 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
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
@@ -1838,6 +1847,7 @@ static int invoke_tx_handlers_late(struct ieee80211_tx_data *tx)
 		goto txh_done;
 	}
 
+	CALL_TXH(ieee80211_tx_h_check_offchannel);
 	CALL_TXH(ieee80211_tx_h_michael_mic_add);
 	CALL_TXH(ieee80211_tx_h_sequence);
 	CALL_TXH(ieee80211_tx_h_fragment);
@@ -4477,10 +4487,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 		skb_get_hash(skb);
 	}
 
-	if (unlikely(test_bit(SCAN_SW_SCANNING, &local->scanning)) &&
-	    test_bit(SDATA_STATE_OFFCHANNEL, &sdata->state))
-		goto out_free;
-
 	memset(info, 0, sizeof(*info));
 
 	ieee80211_aggr_check(sdata, sta, skb);
-- 
2.53.0

