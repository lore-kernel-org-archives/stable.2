Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794340872;
	b=Zlp3wj+YFqlH3WEGkvOVO6rd09Iki7SU2gZXuK/1fYEKCA68s83VPcL2yetBJXR/8aQz
	 NTeQ7rgDdxlQDGL08/6qwU60HzHDYPaPzXRKZDpQgiIU3/FDq5ZTGm6Tv4PKDMjWaFJ5z
	 F20eAE/nmZJQ5YC+mW6EqOy6ovjAxLVb+JvIVEkrE/hWlgBye9M6iU2lL2d5bFp+gLJmg
	 ZW6bs6JcNkqGjoV6dj20+Fg1xiSNYwyaFy1lrWg732LIet0ZEl5+2EnO3cG4iHL6VY6sK
	 jUk9E1blq3MV8wqjRCmuIpvQC/lhzMaV0v0IP82egrcZt0U8zto8qN2xdpxuGg7Mc5w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794340872;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=QAXthfXE0IhouqsXZ0u5uh42w/Z8OoWYNtBJboIR4Ms=;
	b=Q00vYQ39j8NEFvQMhcrintjL8L4EaNuDn2EteLyXjxga83jFcegMRchw2zatS1pmhWR6
	 SmiHvliJYrDCjS68ksx2vPYOMFZaNhtXQ3wkNnjHCOZByePKPuzOxrB9uESv2kFjKvGkR
	 7U+bWNNaTnwqLaCjsxPz3EGOmzPHJZxFIUo5xRePdbmqcw8taOHCmH8u4JVdp84TeBgIL
	 Bndla6MwpPpqMHrNnSgpoOpOdFBhGRzvjSkYBrctLykx3u3xxL6mkPVNSeDHKOnosqOZQ
	 7vdailgoOobToL07xNIoxNfO272swUnCDEKq9Gh48jY1fh0PQ1gBE47BLL8TVCKl3bg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=HRSlWhlH;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id E2492606A32D
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:01:11 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2492606A32D
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=HRSlWhlH
Received: by dvalin.narfation.org (Postfix) id DED7F1FE32;
	Tue, 10 Nov 2026 20:01:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794340870;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=QAXthfXE0IhouqsXZ0u5uh42w/Z8OoWYNtBJboIR4Ms=;
	b=HRSlWhlHnBKvxy7bXwWO7hkbHFzzyu5mqwEVzVpUx86tuebDPNh45zpMg+o5i0aS3/YoP0
	2+gfWdZ2+WwBKHvGwCXD+9aSeOtV39SdPE/wWB52THsKd01APGNySOie3PBP7vof1m8jcb
	gjdQokCESzHR8Syd1wAnQmJpP2dCQgM=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 6.12.y v2 1/2] batman-adv: Limit number of aggregated packets directly
Date: Tue, 10 Nov 2026 21:00:25 +0100
Message-ID: <20261110200026.451472-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109200610-failed-6.12-f91f64a91682@kernel.org>
References: <20261109200610-failed-6.12-f91f64a91682@kernel.org>
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
index 35028134ebdcb..b6fc03b61104c 100644
--- a/net/batman-adv/bat_iv_ogm.c
+++ b/net/batman-adv/bat_iv_ogm.c
@@ -449,6 +449,7 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	struct batadv_ogm_packet *batadv_ogm_packet;
 	int aggregated_bytes = forw_packet->packet_len + packet_len;
 	struct batadv_hard_iface *primary_if = NULL;
+	u8 packet_num = forw_packet->num_packets + 1;
 	bool res = false;
 	unsigned long aggregation_end_time;
 
@@ -474,6 +475,9 @@ batadv_iv_ogm_can_aggregate(const struct batadv_ogm_packet *new_bat_ogm_packet,
 	if (aggregated_bytes > BATADV_MAX_AGGREGATION_BYTES)
 		return false;
 
+	if (packet_num >= BITS_PER_TYPE(forw_packet->direct_link_flags))
+		return false;
+
 	/* packet is not leaving on the same interface. */
 	if (forw_packet->if_outgoing != if_outgoing)
 		return false;
diff --git a/net/batman-adv/main.h b/net/batman-adv/main.h
index 3d4c36ae2e1ad..9f3c1134e0069 100644
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

