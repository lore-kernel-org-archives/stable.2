Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACB8437F737
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490208; cv=none; b=o05YjWGce5qcte/6AqU/78qqo7IsT9vMDrIJJUJ3e9dqbh2SWLC8tv1/DE7D6+vDLhABdm4lAZcdFze0NDSf4GeB8n42xxQROY6q4QowJ12P32Am8q9GpmJmv75TQAhc0gpEbmOfBxz8KRCIFJWUcvbADZSMS0UX4OgqgxJtGWI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490208; c=relaxed/simple;
	bh=lNQLVnEty9KAsDUdV50+A7WNXznTX1W40vZdnLI1jsU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bigjjYQFBYqIVB/JTVREtdAwCtu4a0kj2DvkrvmbR5NEBqK0tZ8sAKA5HvODUSuyY1Bj3DHPJpfgPVCuhySxdP6LInY980B+JKQVfbvDqCCM3Bp2/rcPE3YhNos+5+TVxOuIYZrqR92bRtXAqGubH3J9n3JokuNA5aXPAjZHhGM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=oRLr9N8p; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="oRLr9N8p"
Received: by dvalin.narfation.org (Postfix) id 82459203FC;
	Fri, 26 Jun 2026 16:09:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490195;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=cH+RcNsFDYZdEQc2Jjunb3gDb/4YZzPXkyjmlxRfFvE=;
	b=oRLr9N8pXR/EX/r2nTTx2h9s21bkplwHP1Gli/ExZhLV5bC+bJ4CYzWdH6iHGhOiVzbLrF
	TCRLQcsC0oJjd/DBGjYuTKxA5Bxu4Me9/ycwoA7DQqwV2El+HnE0oOYKlSrzMpZVrIIlMz
	1sNdNDEo4KZYHHpQXfnq0kB5BfdCqnE=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 03/23] batman-adv: tp_meter: initialize dec_cwnd explicitly
Date: Fri, 26 Jun 2026 18:09:32 +0200
Message-ID: <20260626160952.123713-4-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626160952.123713-1-sven@narfation.org>
References: <20260626160952.123713-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit febfb1b86224489535312296ecfa3d4bf467f339 upstream.

When batadv_tp_update_cwnd() is called, dec_cwnd is increased. But dec_cwnd
is only initialixed (to 0) when a duplicate Ack was received or when cwnd
is below the ss_threshold.

Just initialize the cwnd during the initialization to avoid any potential
access of uninitialized data.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 1699fb8f8c82d..d8ad58ccef260 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1065,6 +1065,8 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	 * soft_interface, hence its MTU
 	 */
 	tp_vars->cwnd = BATADV_TP_PLEN * 3;
+	tp_vars->dec_cwnd = 0;
+
 	/* at the beginning initialise the SS threshold to the biggest possible
 	 * window size, hence the AWND size
 	 */
-- 
2.47.3

