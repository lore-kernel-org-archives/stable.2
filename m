Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E67F3EB0E6
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490303; cv=none; b=EMXDJgo9xQURRzG3P8V+1GxGeewGaE+7Mbd3G6X3mBZ91CJXKTVcXLo5Yt7iT7I+85Z9gjlDKXmlZ6D7bEsYTdx7SN/L3xU4L643Xsac8QsImo3zc+fm7cxUkAWwlgIYc9KReTb4/gNrTm57CehA81acNhaI9rYJawCTuQ4L7ZA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490303; c=relaxed/simple;
	bh=8HIKyq4BSb8qVt3HqOP7c9x5E1T7lWQcfvTnjkEPCmY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=R2Y96FIPD7Be8Seej0fUWXqg9q9AkW6drrtVSuXczXycgz4BWEKD+ckh0ScexkUVjhWIr2DxfHxlB/QcleVAWwzhrJQe9/jnhBpHX1rQtlJzKNR/OICqEpA/CRPH/SFM4bj5isammQiN8YmuKuvr5x3UQOeIGpJWHhC3yLcTY9Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=XJmBAu06; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="XJmBAu06"
Received: by dvalin.narfation.org (Postfix) id 1224E203E0;
	Fri, 26 Jun 2026 16:11:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490301;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=l2Z+W0DL4p3ivSDcSwcRqMFiAbkqyH2J0VIzY3641l8=;
	b=XJmBAu06Ec3JNXd7WvlXKD/xHYcbwOclA2s5v3ieb/kwpNmCF2lJgBFmQDEZwlT8Ulos2y
	PZd9Qru4srvFZJXur673PnIy7zc5zMp44dTXaazh2ToBXrPdBDnHZfz/C3xvSk3gtkdgOL
	3LQSe7sh2O3rkpeFEXs5KXVD8ErWaAU=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.6 03/25] batman-adv: tp_meter: initialize dec_cwnd explicitly
Date: Fri, 26 Jun 2026 18:11:17 +0200
Message-ID: <20260626161139.124425-4-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161139.124425-1-sven@narfation.org>
References: <20260626161139.124425-1-sven@narfation.org>
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
index 750e5e9d3dc9d..f6ccb639744a2 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1055,6 +1055,8 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
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

