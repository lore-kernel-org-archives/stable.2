Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=213.160.73.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794341048;
	b=x9C55IJJGiexTA3nkX1YXmcIgrr3KGp7tnTHYEGvGdAsH+b8H1jwQWMyQJ23ndHZ0Wuy
	 MWu/CPcbr1qxpHMleXqziTqfzGXnHVx2HGpYD49dJ6y+Lex5hmUckOGZ/nG50LfvRVCpn
	 gF3bp9epGGZ7IJoJzAluafIT5XnTSd3UYSgFUQGutPLldiamxA2khO4kIVKMam36Wb+Y6
	 Z5GcEl0z0U+grFnEbukiT1ap30NxQzwvGc1LmNgr+x+ylbp5KIF/ZJWWOIEzO1NgephOc
	 zT5Xkhe7tbZhRwQPe9ZDtyN8e/qM15XmVHglkRJGcspD+S2ZmwPbkmtJotnbcpEvQag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794341048;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=XTF4F6nfiIULfPqUXk/5YLzCIaJmqhbhKi6Jg15n/fQ=;
	b=hnoNXDMl+0V/EP+ljjfJZ9upujOFsqE0cc6/MZBumOu0s9+N2NPJAM58DROt+972+tuv
	 QU6rqzXScj3Zyl61gi4rGlt+NlozRyhHKGEqdtbGqcxgN/SVES3JS9ItjykfjLXieHXeB
	 B+XjR+zP7HYuYpEzn+B8OPaXmta+G5XhticgfuUgAzhufpgOSLp1wwTFQ7yZVQuxwiSQP
	 Jga6DNacfYvMlFREJfZva5actYq0eEggHA3sipiWJHHqizZsBCpqKtB1QqChjjxlLUqai
	 UvFMZsMgKEQvkmfspGcfGm2aMdaursG8OQQd3i0X65sXDqhmglz0rpj2WuGfBeRnQZQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=narfation.org;
	spf=pass smtp.mailfrom=narfation.org;
	dkim=pass header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=GfpzQnkf;
	arc=none smtp.remote-ip=213.160.73.56
Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with UTF8SMTPS id BF65E606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 20:04:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org BF65E606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.a=rsa-sha256 header.s=20121 header.b=GfpzQnkf
Received: by dvalin.narfation.org (Postfix) id E4D761FE32;
	Tue, 10 Nov 2026 20:04:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1794341046;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XTF4F6nfiIULfPqUXk/5YLzCIaJmqhbhKi6Jg15n/fQ=;
	b=GfpzQnkf30BdKPvknuFX3on9yVKD+qFSwUChb20cDO2DQ3Zhn/3OUhTr0PqLz8Du7/MM5o
	t1GXSN1EI4LSobHAskBG5Lv53lednz4Bmm8Nkogi8imD3N6FyhJ5f5Tlbt2EWtFSRlX9KP
	R4rCkzg9v0fkC/+HY6mXDrTpndcuiO4=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>,
	Simon Wunderlich <sw@simonwunderlich.de>
Subject: [PATCH 6.1.y v2 1/2] batman-adv: Limit number of aggregated packets directly
Date: Tue, 10 Nov 2026 21:04:01 +0100
Message-ID: <20261110200402.452525-1-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20261109201509-failed-6.1-f91f64a91682@kernel.org>
References: <20261109201509-failed-6.1-f91f64a91682@kernel.org>
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
index 40f3c110eb2fc..8885949b5a51a 100644
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
index c48803b32bb01..e26bb8840f25b 100644
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

