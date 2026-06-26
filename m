Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FC7C39DBEF
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490268; cv=none; b=nBXcIR4CJa2BbUEjYxrd60gQWjqTwTbKb/9+SmSridO7rxiE7RGWz5Su0Z4Ehk4JC/Of2F9ZLIuKoCaR7qRofoSIH2eCRhVULQG95LaQ9f4Di/3WvA6Im5TqZcHstpi87dA1MfRnY2WEvK2sUFlxcOmsltbvhwBXhLehd8AF0xM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490268; c=relaxed/simple;
	bh=5UHSSOM/f3sKakmI5Zb+UyToSw+5Vtc8pYWrXlMAYMI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=fluUbJgUSaVQud67yZO1clUtprpOg9CS0AjpDAKIQCzpRUMrzUwqAAMT/cYkScrHUfK8mTDNbw32leH8bhpurZfZnPvsVA52mF191MNdUpi4HI+EnJ28XqN/bQi3PnboDzmjksxxra2Ofa7C6UT7jF1fAfmD/sVlMoIe2YePFPg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=VZSVJzgt; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="VZSVJzgt"
Received: by dvalin.narfation.org (Postfix) id EAE5A202D1;
	Fri, 26 Jun 2026 16:11:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490266;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=WliH8XIN6WTG216DAT6ibeSbit/liJheXXP4kYdlpcM=;
	b=VZSVJzgt8vRN9AjoGdTaYlDLjpiURp0G2Co+XrJhV9ZWGGPr6hWS5IvzOlohdaotb0Azxi
	cBG4LSbWU8gQRAgS4i61NRR/NynehAc2atqLPYx7g4gosj1PHWyhMUttzLmEXBm8A3tfkW
	skC8pLaRnWYHXjKxLfMHeeTj2XEYS5I=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.15 01/25] batman-adv: tp_meter: keep unacked list in ascending ordered
Date: Fri, 26 Jun 2026 18:10:40 +0200
Message-ID: <20260626161105.124113-2-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161105.124113-1-sven@narfation.org>
References: <20260626161105.124113-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit 5aa8651527ea0b610e7a09fb3b8204c1398b9525 upstream.

When batadv_tp_handle_out_of_order inserts a new entry in the list of
unacked (out of order) packets, it searches from the entry with the newest
sequence number towards oldest sequence number. If an entry is found which
is older than the newly entry, the new entry has to be added after the
found one to keep the ascending order.

But for this operation list_add_tail() was used. But this function adds an
entry _before_ another one. As result, the list would contain a lot of
swapped sequence numbers. The consumer of this list
(batadv_tp_ack_unordered()) would then fail to correctly ack packets.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index c7b48d51e2aed..e8792e1e4eedf 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1325,7 +1325,7 @@ static bool batadv_tp_handle_out_of_order(struct batadv_tp_vars *tp_vars,
 		 * one is attached _after_ it. In this way the list is kept in
 		 * ascending order
 		 */
-		list_add_tail(&new->list, &un->list);
+		list_add(&new->list, &un->list);
 		added = true;
 		break;
 	}
-- 
2.47.3

