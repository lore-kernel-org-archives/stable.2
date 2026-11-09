Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=212.77.101.9
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794214087;
	b=zB225dCZbixCTHnh39jq4DOnP3Qv9Uz+1QIdYDQcfTmYb7AIrEDTEgcM2qoNADmU3xOR
	 kNaZcNnflq01b0dkpQSsVcmU77z3a46oKVnNbq4NyVL3JpOVSBCYGsqX+LrbQF7oPQNC8
	 8AcyYzBPbGE2/wLqMF3R7m340gzI7EICZMvxOe4ufW6VSqUC5/jIcKG/L5HoN4fg7krdq
	 0Ejk75dy6ifoxoXjze7t9pLE/r5Hu7VHgEl19QZtflqOBWyMmDVl5Q3yTmfbiA7gq4v8Y
	 fQJucz4gcX2GQAByLSctrF6GYrLjyghJltRfBl+UKDOZpM2/pJVPBfzncBsb1ta53Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794214087;
	h=DMARC-Filter:Received:DKIM-Signature:Received:From:To:Cc:Subject:
	 Date:Message-Id:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding:X-WP-MailID:X-WP-AV:X-WP-SPAM;
	bh=8V+3XeNypufLe5uMPR1QCFK7+WCaXz7H0csVgmVA1Dg=;
	b=NVFJsla5JArH5dhrystMbuaeLZmZ/H5lKf7D5EGqdjX4efo6hjFl+In11tn+3gXgnsFB
	 0CHH6WZe6Jao/2gqnilXr+e8oKvcyQyyxdAN20JFq3Nz1IV9RzBO9ZZzRCE8qp9DuqGU/
	 QP7qtI59Cy06HiIMfVHeswQQ1QLtQUQFqWMFMsZtum4fbCbvP2l4m6vJ4aQkY9DWQ2dcv
	 lGV0Ngwfn+YLHA6XqIXk+tp8lrQd8iR3QX6G+IYQb64OCNwTmp1OkVyHPd7NC3mq6/Kv2
	 lymS6t8MfJRxQu717FvsnO8ME2VviVCN3Thhhqo2wBg6MFyYDMedUjgfPjVI1m/jPMQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=wp.pl;
	spf=pass smtp.mailfrom=wp.pl;
	dkim=pass header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=KWM8hJO9;
	arc=none smtp.remote-ip=212.77.101.9
Received: from mx3.wp.pl (mx3.wp.pl [212.77.101.9])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 70D9A606A31C
	for <stable@vger.kernel.org>; Mon,  9 Nov 2026 08:48:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 70D9A606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=wp.pl
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=wp.pl
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=wp.pl header.i=@wp.pl header.a=rsa-sha256 header.s=s20261001 header.b=KWM8hJO9
Received: (wp-smtpd smtp.wp.pl 14042 invoked from network); 9 Nov 2026 09:47:55 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=wp.pl; s=s20261001;
          t=1794214075; bh=8V+3XeNypufLe5uMPR1QCFK7+WCaXz7H0csVgmVA1Dg=;
          h=From:To:Cc:Subject;
          b=KWM8hJO9GwcsFnip+hfL61SKx+jwJGqZErERqUTWH2hzuK5FRQsI6TDD0fBFIsXa/
           PpsjoH8iLDp6NwmbWW6FU52Nq5b+CDghUx4kxCZh0YWCyU1w/R5Rq9TYMVLZVGvFOj
           j12XI8iouEiaKKrPgmDR53CEFCJK5gXPR7xLJs3R9b+TiflKzhRKOr5yZMl+gMCmlN
           CwOG1MWBIXRg0CQs4b/3WGDC7n9Se1WaYBIYsveF11QuKRoesTDVbmI6PW+VKUZcdL
           y+8k2q8CIQA9QL/i3GPFdoPeVwzLU8m2Mxby6Ot5/yRkOhJCxH4LBgkL9CUBFljm4Z
           B5mSLqr4zMN/w==
Received: from localhost (77-236-11-168.static.play.pl [77.236.11.168])
          (envelope-sender <stf_xl@wp.pl>)
          by smtp.wp.pl (WP-SMTPD) with TLS_AES_256_GCM_SHA384 encrypted SMTP
          for <stable@vger.kernel.org>; 9 Nov 2026 09:47:55 +0100
From: Stanislaw Gruszka <stf_xl@wp.pl>
To: stable@vger.kernel.org
Cc: Stanislaw Gruszka <stf_xl@wp.pl>,
	Johannes Berg <johannes.berg@intel.com>
Subject: [PATCH 6.12.y] wifi: mac80211: queue frames while off-channel
Date: Mon,  9 Nov 2026 09:47:44 +0100
Message-Id: <20261109084744.5999-1-stf_xl@wp.pl>
X-Mailer: git-send-email 2.25.4
In-Reply-To: <20261107051639-failed-6.12-13e51269b665@kernel.org>
References: <20261107051639-failed-6.12-13e51269b665@kernel.org>
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
X-WP-MailID: 5739e55e286a7ea2bcf21b0870f70d6f
X-WP-AV: skaner antywirusowy Poczty Wirtualnej Polski
X-WP-SPAM: NO 000000A [ocME]                               

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
(cherry picked from commit 13e51269b6656768dc595ed6025e4974f2026543)
Signed-off-by: Stanislaw Gruszka <stf_xl@wp.pl>
---
 net/mac80211/tx.c | 55 ++++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 27 deletions(-)

diff --git a/net/mac80211/tx.c b/net/mac80211/tx.c
index 0fad278d8f24..3b01934a6e80 100644
--- a/net/mac80211/tx.c
+++ b/net/mac80211/tx.c
@@ -276,7 +276,6 @@ ieee80211_tx_h_dynamic_ps(struct ieee80211_tx_data *tx)
 static ieee80211_tx_result debug_noinline
 ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
 {
-
 	struct ieee80211_hdr *hdr = (struct ieee80211_hdr *)tx->skb->data;
 	struct ieee80211_tx_info *info = IEEE80211_SKB_CB(tx->skb);
 	bool assoc = false;
@@ -284,23 +283,6 @@ ieee80211_tx_h_check_assoc(struct ieee80211_tx_data *tx)
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
 
@@ -810,6 +792,33 @@ ieee80211_tx_h_rate_ctrl(struct ieee80211_tx_data *tx)
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
@@ -1853,6 +1862,7 @@ static int invoke_tx_handlers_late(struct ieee80211_tx_data *tx)
 		goto txh_done;
 	}
 
+	CALL_TXH(ieee80211_tx_h_check_offchannel);
 	CALL_TXH(ieee80211_tx_h_michael_mic_add);
 	CALL_TXH(ieee80211_tx_h_sequence);
 	CALL_TXH(ieee80211_tx_h_fragment);
@@ -4667,10 +4677,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
 	queue = ieee80211_select_queue(sdata, sta, skb);
 	skb_set_queue_mapping(skb, queue);
 
-	if (unlikely(test_bit(SCAN_SW_SCANNING, &local->scanning)) &&
-	    test_bit(SDATA_STATE_OFFCHANNEL, &sdata->state))
-		goto out_free;
-
 	skb = skb_share_check(skb, GFP_ATOMIC);
 	if (unlikely(!skb))
 		return;
@@ -4748,11 +4754,6 @@ static void ieee80211_8023_xmit(struct ieee80211_sub_if_data *sdata,
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
2.25.4

