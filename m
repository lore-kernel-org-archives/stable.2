Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340409;
	b=ASjqfq53aZL9GfyuSFweF9KL+dKvspbQeXfvHposKp+A+IyI8huUuwStF1Q5qJWk3GCR
	 sM96wQ1EA5DVLwhluQXQdwvQnZkO8jxRZK7hSk1me2nWqmtTVWwBUpN2rpRnmFuEBdYoa
	 0hPClbdvbtVKmwzF0x2Ri5D6zt/VwtC689bXEX6/9l6vliWXfp4xc0CVfBLKOHmSq6+Km
	 +sIkmKkurDRwL1AZ+B1bnbqWYsWm24Wuf/CY9ExZKb6pHb66UGSs0VpdKbneemIUgUeEY
	 J3fTh1BBcHtsp7NT5rcOVbNx4388dMfnFeu7sD2+s9Zj4E2u+qTqQF3WUZ/qtTzctYg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340409;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=oGnvqOFgJg50/40sjNsIvTW8SlHdaT2IZztP2L6tu2A=;
	b=DzIERCq69q+HPxjmfmsj4xxEcHOuVExgS2XNn+QG0PZdxFuRjpm8b2x1kPDYJ3OdFMly
	 XogTrVBqXHlw6joq69/lwryp+xu6aDeGU8G5cgpTNPiMIDc2XEVhz/GxGaTTK7AQ7zmu6
	 XOZDfBfyf4Kghr76cpuBJvHrF7mkatM7xS1dFd+gOk1B9MBY6r51B4uLnLMg5tXK1ko1I
	 90447u1Zul9GMqB8v0Jg5sZo9hENyRBWuf3t3YFzg/8t4hufgv2XLDqFo2PM9xTvUVTaD
	 UcUKjMorWyV1pkfBsoopANAHh3RrWddlUHdGkZPRUuZwbGdqP/mMTf6vI3Dllq59Ydg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b="IoZ/hMwi";
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id D8BDA606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 19:53:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D8BDA606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=IoZ/hMwi
Received: by dvalin.narfation.org (Postfix) id CA34F1FD16;
	Tue, 10 Nov 2026 19:53:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794340406;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=oGnvqOFgJg50/40sjNsIvTW8SlHdaT2IZztP2L6tu2A=;
	b=IoZ/hMwih+c7witI+JwVrbOYpYgsSuHwJZNO8DB6GrnY6gCoqciov3drgQk8RL5VgwZ76k
	O5jeBIrTikTeFZ/aIT+5IpavpwHgalqM/20VaRYoHi6rckiky4CLwXhc6Ef6+eQDys7JGR
	ry3gmgaO4WA5gX2gh8Z5ZtIoHfKOW6o=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.10.y 1/2] batman-adv: Limit number of aggregated packets directly
Date: Tue, 10 Nov 2026 20:52:59 +0100
Message-ID: <20261110195300.406888-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109202521-failed-5.10-f91f64a91682@kernel.org>
References: <20261109202521-failed-5.10-f91f64a91682@kernel.org>
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

commit 434becf57bdc89f939db635ed3337b9d1da5967e upstream.

The currently selected size in BATADV_MAX_AGGREGATION_BYTES (512) is chosen
such that the number of possible aggregated packets is lower than 32. This
number must be limited so that the type of
batadv_forw_packet->direct_link_flags has enough bits to represent each
packet (with the size of at least 24 bytes).

This requirement is better implemented in code instead of having it inside
a comment.

Signed-off-by: Sven Eckelmann <sven@narfation.org>
Signed-off-by: Simon Wunderlich <sw@simonwunderlich.de>
---
 net/batman-adv/bat_iv_ogm.c | 4 ++++
 net/batman-adv/main.h       | 3 ---
 2 files changed, 4 insertions(+), 3 deletions(-)

diff --git a/net/batman-adv/bat_iv_ogm.c b/net/batman-adv/bat_iv_ogm.c
index 16a1294c443eb..2ed98463e99e6 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -451,6 +451,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	int aggregated_bytes = forw_packet->packet_len + packet_len;
 	struct batadv_hard_iface *primary_if = NULL;
+	u8 packet_num = forw_packet->num_packets + 1;
 	bool res = false;
 	unsigned long aggregation_end_time;
 
@@ -476,6 +477,9 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	if (aggregated_bytes > BATADV_MAX_AGGREGATION_BYTES)
 		return false;
 
+	if (packet_num >= BITS_PER_TYPE(forw_packet->direct_link_flags))
+		return false;
+
 	/* packet is not leaving on the same interface. */
 	if (forw_packet->if_outgoing != if_outgoing)
 		return false;
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index a47dc332d7968..369f7c8d0c01f 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -103,9 +103,6 @@
  */
 #define BATADV_TQ_SIMILARITY_THRESHOLD 50
 
-/* should not be bigger than 512 bytes or change the size of
- * forw_packet->direct_link_flags
- */
 #define BATADV_MAX_AGGREGATION_BYTES 512
 #define BATADV_MAX_AGGREGATION_MS 100
 
-- 
2.47.3

