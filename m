Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340973;
	b=ls5XiHdp3BCS40/8T4WuAzryp6TJBklKlUlDeRbOQ2LpN5mBFJot1rmgqabci2h3SmyC
	 PBmtNyOZpDXiOxZ2PKBlakF25fUBmRWRivFJ8E0Dro5r4Y2zjNkvL81Gi6nuUdL50AjSI
	 3uMbOmylB4XPEjr2CqyHnFBlyZI6kH5aBxwZAbgdSVTlTL0WKvUsI4zUIJDfAx69CVb4h
	 0GLCEmA+f68zC9r8NTA4nyydqmYUxxkO62E5dloVoiVNkpxrof+4b8ZrlkSL7rUOZi4r+
	 qtsuaM+Ten5/gaTwnCfrvbd3zbfDHReP5+6x85pclcmDSByUwkvqhZcGuGyKYr74FJg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340973;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=HVy2nINl42E1eU38OjLADgo7D8ahT0V25bzX7iS4sZM=;
	b=jMLHu1MZwIpKGBIfE1wV85h7vN3+eySbSPphQcowoCJocja1ULwp2sRhoO4iOOQ2udX6
	 AhqWd/fakMb7KeOSGhPKHNQ0BvR6J2PAGbyDf2yr5ELpBALSJcJwT7W7KozxDAluvm2zI
	 S7yUAVanJteTXGdhbSY2jAlOQiSRCj9Hjlix6RWonCFXuDml90017DUCtgOQZ9w0jVdyv
	 5eIzpbLa72LUK/NE0p++vElNhEEg0V/a4XemQJmbE4GejfaIveNteVo+07APPI6h32LV9
	 06OwiHGlN0VFni4psMd83+T08ziqJP5cRrjmUOrJcnx0z6KTvqn9wyuV9VuVPrI86dQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=XnOTY6OK;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 2292F606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:02:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 2292F606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=XnOTY6OK
Received: by dvalin.narfation.org (Postfix) id 96ADD2176D;
	Tue, 10 Nov 2026 20:02:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794340971;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HVy2nINl42E1eU38OjLADgo7D8ahT0V25bzX7iS4sZM=;
	b=XnOTY6OKQBmfHqruVcTuoYFiPYxYJcc337cM0NOU8th7D3s3kD/tyFOVhNhNZn8gTogLm9
	xr9MMdPD4udPZlekbDw4NTJPPq1NpOz0HiL6G5MDIXncTBEnvoRis3vxu8zYZwrkt8CyfN
	q2uFemk3s7Hbnpc01r9KOSWjKXlWe+k=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Chengfeng Ye <nicoyip.dev@gmail.com>,
	Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6.y v2 2/2] batman-adv: Close OGM aggregation before transmission
Date: Tue, 10 Nov 2026 21:02:38 +0100
Message-ID: <20261110200238.452015-2-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261110200238.452015-1-sven@narfation.org>
References: <20261109201030-failed-6.6-f91f64a91682@kernel.org>
 <20261110200238.452015-1-sven@narfation.org>
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
index b6fc03b61104c..cf6ff9848a7bc 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -1793,6 +1793,11 @@ static void batadv_iv_send_outstanding_bat_ogm_packet(struct work_struct *work)
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
index 2ebc718bc3249..9a43b58ccad7c 100644
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

