Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341107;
	b=WoSdkvDfarAkVZ1QTsJRJXnwix/zrDY3ZVIgpvmDoScENe0ncFoBcPscBesOb0q0iLdv
	 O8H3tcoKo6ZFfWmAuAHIv4gDouCqHexGhD7iDgs0H2GdCaBkRNk1xaWNLjJISy43ln2Ln
	 uKyHpGe+mwOi5uyPFnxwt2mTTP8HOeRjT2js1yxLKDJ9bXqATpFv4pjuCvytxKoZgOKeH
	 mevuaktjGAta2ztonkR7nmM38l+BscLXulqezxStsP1Zwumnz6+596THZHA8skw1tl5F+
	 XHj2cpNrMtF8erLARhGJKce/IND4al9I9Ikv4Icwjj2C45mIYWbs2qu+Xw8nbaFpf6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341107;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FlDDAk9MRE+zDzZ2r5YyKJcKWPmBZgjySQo0vHPV9to=;
	b=qOvS9yS1I9e2R6AJUHwzidq/NL6BzgYQTZWkxvpvzzS/E4vX2AWRPQu5UAqdYfUHQQCV
	 0HPpja7AVXt23BAJhkY3J708GtoQG6HrKN60cI7E5kjGfPPvgAKvdcaLZnT+ae3LOWlRP
	 8I/ZqwDbWHyXX5JZ2wRjX2EQi7ACuDtcXZg39d16F+M1mohC8fythTj2Yb8hSsenTOtEr
	 jsoR+pE3C4NVShped9deymORsWFPZYIaCJ61li/Gw1YWJguvrzhQLuo877a9TV5Veu5YX
	 KYVO2dICNVw4ee0wJCyacnmWEtm7ukvoV3Hfl1lkl4L+PO5p8wtwrULRyr82t5TZ38w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=lgQLfrpr;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id 3C780606A320
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:05:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 3C780606A320
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=lgQLfrpr
Received: by dvalin.narfation.org (Postfix) id A27BC20FF9;
	Tue, 10 Nov 2026 20:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794341105;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=FlDDAk9MRE+zDzZ2r5YyKJcKWPmBZgjySQo0vHPV9to=;
	b=lgQLfrprrRnG8BmWouhU4dTozOJoviovt+/4XjhTV0re+T1I+XqzJnuPpWN2iviI7undLW
	KDG4cKC7/HcYO7Tqag6c8MX4ln/8dC28uPajb+qfFLvkubF0a/aLIK91/WRHjwytY4ZIaN
	5Sk1jCr2XacYF24YKU37GOGkK5falxQ=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 5.15.y v2 1/2] batman-adv: Limit number of aggregated packets directly
Date: Tue, 10 Nov 2026 21:04:57 +0100
Message-ID: <20261110200458.452945-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109202015-failed-5.15-f91f64a91682@kernel.org>
References: <20261109202015-failed-5.15-f91f64a91682@kernel.org>
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
index 383310b72e5e3..62ee9b8bf9da1 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -450,6 +450,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	int aggregated_bytes = forw_packet->packet_len + packet_len;
 	struct batadv_hard_iface *primary_if = NULL;
+	u8 packet_num = forw_packet->num_packets + 1;
 	bool res = false;
 	unsigned long aggregation_end_time;
 
@@ -475,6 +476,9 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	if (aggregated_bytes > BATADV_MAX_AGGREGATION_BYTES)
 		return false;
 
+	if (packet_num >= BITS_PER_TYPE(forw_packet->direct_link_flags))
+		return false;
+
 	/* packet is not leaving on the same interface. */
 	if (forw_packet->if_outgoing != if_outgoing)
 		return false;
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 058b8f2eef654..30fa42211680b 100644
--- a/net/batman-adv/main.h
+++ b/net/batman-adv/main.h
@@ -102,9 +102,6 @@
  */
 #define BATADV_TQ_SIMILARITY_THRESHOLD 50
 
-/* should not be bigger than 512 bytes or change the size of
- * forw_packet->direct_link_flags
- */
 #define BATADV_MAX_AGGREGATION_BYTES 512
 #define BATADV_MAX_AGGREGATION_MS 100
 
-- 
2.47.3

