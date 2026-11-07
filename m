Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794048080;
	b=En7mmM2Ttb44bIl9F0LRZsKG0/ZdricbzzWeN6YQtSMKSGJzAGhuNgYsfRmkj8OW3ITI
	 6gvqJf2VcLiuK63Tr4fY5nJYuhGzvHgxy9pAY6Uzfw+Cr6dGNjY+IfYAIO7mNFe4uxHMx
	 AUXKVRYLu9iiZ1JuRwfYoyaispxS2aTju0GGH4L4XWUM1nYoO5rEX9SHZM3Tn8VnkSU/r
	 4lM2iWAmig2NXn57ik10OZMQET1buEdpVp4h6t6wl6sRJx2bIEkMhfxKGsCEWl+WMLKZf
	 +zBs/czCoKGqu6OxUF/fcL8oZe4uSu6OKh6AP+L09sSqL6UxmbSZryrRP+GiELgq4fQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794048080;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=A0WsHLhKGx9HwXgyuVWNgE3Z+VPbdJNGMNboFk2FUhM=;
	b=kwKosfoSqjNmOWD60pju7KpLIex4Af5aTkFyPkUv1ppkI5FA4IAfn1nOxLpAberuIAm8
	 t5GNDwNaW7XlxJpGMAqe3haMeIZ6EX7wNgYeTXfUSTlBGnfsRXCohIrskNG9AoB3NDDaG
	 pCfZ+QfCS1jTglCG77AA7Bl5eCttVnsISpdmCqE9ie7m0SyS46ajm5mz+Neg/9+8gBKcm
	 hAUMgvPFbYG/+D2Q1Hha/0ugUKRWdfIOt7kmvlmu2XyiFgSrC3CJ5lIzmw8KsE3BP3Hq5
	 +pwha17GOc4OiZ33Bd8HK60N8Uzz+NIpRn0RTmnSWFq18m8FTGy7kUHgytk3Ed3MTKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+mkyfGq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31300606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V+mkyfGq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A47901F0089F;
	Sat,  7 Nov 2026 10:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794048080;
	bh=A0WsHLhKGx9HwXgyuVWNgE3Z+VPbdJNGMNboFk2FUhM=;
	h=From:To:Cc:Subject:Date;
	b=V+mkyfGqCsq8hMauRw1A8I/VK1aeBwggO3Wq0MhPRzvbDkrrLZ89XTyoDGigOub/5
	 F1UXfgBH8qeKVWZboRlRFXQQ3ZHfeJJNR+fAaCZBL5VE4Q8DlkTdqueJDrFcMGzD2l
	 fPV94DMg2E+/LQUstKKeyWTObkjhRkhVMqkea33HW0IpjMdbS7JbVJ9GvwFfXyvcNr
	 tglWuT55GXs+erHv8d7hQNDre+jo/ckRVdy3mj45r8WkEZvWXlau+7MUBAhqrqdXFT
	 JW/h1G5cl2eiPoBUOiy7s/FCc9uY9Duo54T/N5A5dWXxwhiCfhH2JtZaN7MmfBpELL
	 8RwT301pxo9OQ==
From: Sasha Levin <sashal@kernel.org>
To: stf_xl@wp.pl,
	johannes.berg@intel.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] wifi: mac80211: queue frames while off-channel" failed to apply to 6.1-stable tree
Date: Sat,  7 Nov 2026 05:41:18 -0500
Message-ID: <20261107054118-failed-6.1-13e51269b665@kernel.org>
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

The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 13e51269b6656768dc595ed6025e4974f2026543
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107054118-failed-6.1-13e51269b665@kernel.org' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 13e51269b6656768dc595ed6025e4974f2026543 Mon Sep 17 00:00:00 2001
From: Stanislaw Gruszka <stf_xl@wp.pl>
Date: Tue, 8 Sep 2026 14:46:51 +0200
Subject: [PATCH] wifi: mac80211: queue frames while off-channel

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
---
 net/mac80211/tx.c | 52 +++++++++++++++++++++++++----------------------
 1 file changed, 28 insertions(+), 24 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index fd79814661376..d85c84a738f79 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -269,7 +269,6 @@ ieee80211_tx_h_dynamic_ps(struct ieee80211_tx_data *tx)
 static ieee80211_tx_result debug_noinline
 ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
 {
-
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx->skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
 	bool assoc = false;
@@ -277,20 +276,6 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
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
 
@@ -839,6 +824,33 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
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
@@ -1905,6 +1917,7 @@ static int invoke_tx_handlers_late(struct ieee80211_tx_data *tx)
 		goto txh_done;
 	}
 
+	CALL_TXH(ieee80211_tx_h_check_offchannel);
 	CALL_TXH(ieee80211_tx_h_michael_mic_add);
 	CALL_TXH(ieee80211_tx_h_sequence);
 	CALL_TXH(ieee80211_tx_h_fragment);
@@ -4720,10 +4733,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	queue = ieee80211_select_queue(sdata, sta, skb);
 	skb_set_queue_mapping(skb, queue);
 
-	if (unlikely(test_bit(SCAN_SW_SCANNING, &local->scanning)) &&
-	    test_bit(SDATA_STATE_OFFCHANNEL, &sdata->state))
-		goto out_free;
-
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return;
@@ -4785,11 +4794,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
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




