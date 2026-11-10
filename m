Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341051;
	b=qfaauytPdgWrIdoZ7Ej/DNwWegMo/aT44+nvSSpNZZ3Ur2B+CHfg6KrILCJ8LlyXWGxO
	 pfm0H+AbK6tUzvAnXb5W9ImtGtROXnISw5xE4Bdcx7Hd/XeLrosZ3HalK9a74smz7Uebh
	 zt+AcihKLjC8Y11WdtKg/IyUzir01WkACW2ImtwfNE8cCtSoxcgj8GhowNHwEyCLBNTgW
	 Rlx502gHG/Tme9sdDkJ+jHa630PFpZo9Btdq3q/NbSYtPiNRtdu7KB+DQtChnYB4hygPk
	 kET3STZlcfpJ70NU41+ShvXmDs6q2T5GgjNxKwoYVXRlmBICK21gZkcMW8pI7aKibMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341051;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=y/WLz5lJCyuHcOSh6XF19cIhIvvdvxogWwn3i1eykYo=;
	b=jxQgNdFBa+PKmDKsrvg9Pax1oyYYH0Gu91CszQYaRzPpaugtWNj0fIeICSQNrplgU5XX
	 6jGxT6eEkp1fKCt0U59A8OPVgZQlN7hAB/aBJOL9RGttYq4S/PsnXXR7oZGZ/Mkld9Nlq
	 P04HKWVgPlSCQ8i0mipWIet9b74Kc8WzS2SunRxRG9jd0mxay6Vrq8HNarjSF0Z2SkUeT
	 ICFNDZbyBzsqN8sHW371CSnBYrrAyt5LIG0Ruq5biHah+RWIfWBmk9bWn8r26jARDvmdb
	 1wWHC/RlGFTOodG+lKqxWnA9rIBQPqG0TIKy4bhf4QCUCr5Vm7P4nmi8+GJz8Y3h7jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=0iQS6xkB;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id DE5D5606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:04:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org DE5D5606A321
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=0iQS6xkB
Received: by dvalin.narfation.org (Postfix) id 3B6581FE32;
	Tue, 10 Nov 2026 20:04:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794341049;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=y/WLz5lJCyuHcOSh6XF19cIhIvvdvxogWwn3i1eykYo=;
	b=0iQS6xkBHjbAfHIyfL7oaUh2sBVLImmGkH8TlrdreYY7MvUDe//4zSL6c5qpW9V4Yyh8bU
	X2BC+ggZRP/cLBtOAG8fF7yKajp9+s4J4MHgMlE/2bYFSUEk9c67nlfNnZy2dxLoC+T7+E
	5wTSgE/DYFJOowbFWNbphoccRxA7Zv8=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1.y v2 2/2] batman-adv: Close OGM aggregation before transmission
Date: Tue, 10 Nov 2026 21:04:02 +0100
Message-ID: <20261110200402.452525-2-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110200402.452525-1-sven@narfation.org>
References: <20261109201509-failed-6.1-f91f64a91682@kernel.org>
 <20261110200402.452525-1-sven@narfation.org>
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

From: Chengfeng Ye <nicoyip.dev@gmail.com>

commit f91f64a91682c07e6c5f059804e709656364e8a6 upstream.

The OGM send worker leaves its forwarding packet on forw_bat_list until
after batadv_iv_ogm_emit() returns. Aggregation holds forw_bat_list_lock,
but emission reads and clones the packet without that lock.

CPU 0 can therefore start emitting a queued packet while CPU 1 takes the
list lock, finds the same packet and appends another OGM. The sender can
observe the new packet length before the corresponding direct-link flag
is set, or clone the skb while its length and payload are being updated.
This can transmit an OGM with incorrect flags or inconsistent data.

KCSAN reported:

  BUG: KCSAN: data-race in batadv_iv_ogm_queue_add / batadv_iv_send_outstanding_bat_ogm_packet
  write to 0xffff888100fedcf8 of 2 bytes by interrupt on cpu 1:
  read to 0xffff888100fedcf8 of 2 bytes by task 70 on cpu 2:
  value changed: 0x00c0 -> 0x00d8

Mark the aggregate as full under forw_bat_list_lock before emission. This
waits for any ongoing append and prevents further aggregation. Emission
uses packet_len to walk the OGMs, so all queued packets are still sent.
Keep the packet on the list so interface purging can find the worker,
wait for it to finish and free the packet.

Fixes: 9b4aec647a92 ("batman-adv: fix rare race conditions on interface removal")
Cc: stable@vger.kernel.org # 4.10.x: 434becf57bdc ("batman-adv: Limit number of aggregated packets directly")
Cc: stable@vger.kernel.org # 4.10.x
Signed-off-by: Chengfeng Ye <nicoyip.dev@gmail.com>
[ Use BITS_PER_TYPE(...) instead of BATADV_MAX_AGGREGATION_PACKETS ]
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
v2:
- Submit together with the marked dependency commit 434becf57bdc
  ("batman-adv: Limit number of aggregated packets directly")
---
 net/batman-adv/bat_iv_ogm.c | 5 +++++
 net/batman-adv/types.h      | 8 +++++++-
 2 files changed, 12 insertions(+), 1 deletion(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 8885949b5a51a..5a84785613b4c 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1794,6 +1794,11 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
 		goto out;
 	}
 
+	/* Mark aggregate as full before forcing emit. */
+	spin_lock_bh(&bat_priv->forw_bat_list_lock);
+	forw_packet->num_packets = BITS_PER_TYPE(forw_packet->direct_link_flags);
+	spin_unlock_bh(&bat_priv->forw_bat_list_lock);
+
 	batadv_iv_ogm_emit(forw_packet);
 
 	/* we have to have at least one packet in the queue to determine the
diff --git a/net/batman-adv/types.h b/net/batman-adv/types.h
index f3ee914f8d4ee..39cff1e9be252 100644
--- a/net/batman-adv/types.h
+++ b/net/batman-adv/types.h
@@ -2138,7 +2138,13 @@ struct batadv_forw_packet {
 	/** @direct_link_flags: direct link flags for aggregated OGM packets */
 	u32 direct_link_flags;
 
-	/** @num_packets: counter for aggregated OGMv1 packets */
+	/**
+	 * @num_packets: counter for aggregated OGMv1 packets. Set to
+	 *  BITS_PER_TYPE(forw_packet->direct_link_flags) (independent of the
+	 *  real number of aggregated packets) by the send worker to prevent
+	 *  further aggregation while the packet is emitted. It must therefore
+	 *  not be used to iterate over the aggregated packets
+	 */
 	u8 num_packets;
 
 	/** @delayed_work: work queue callback item for packet sending */
-- 
2.47.3

