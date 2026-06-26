Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5C8513E2AD1
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490269; cv=none; b=FfAhwOeFOAPfloMq3OcB9WnF8kDPvE5lCJIVDBqli4efDQmKfxjwSNP2gu/aOIvbZwpBT3xcqceoOS4RaZFEj3B34Uj+0YQKap5wsdzS3sUfeBeDp7GFks7XLxjsT3AnU1+oSpB3q0op05k6iFayMYW87j+IDludeIXVLHjcNTQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490269; c=relaxed/simple;
	bh=S1+ec5TMThGvmLgwTJcOqpyfQ1hcJvhf9CuuqZxvT9o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVPJGWBRdVlF6sGmWardpfH87q/1DSoeuRz2Q0Dfn5VwDoTtqCc0wkNNC/QS6Uba+EgFELXnshsdxKy9WjAzmvSkkGCz7+cEvNH6Qlb0Tkg+wynOy6/QuIhqcjnWznFebo4QgLxPo/SPWUllDE7x1en5wHppG3rN+Luz7+NGOGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=AsSt5YuH; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="AsSt5YuH"
Received: by dvalin.narfation.org (Postfix) id E8B8B203E0;
	Fri, 26 Jun 2026 16:11:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490267;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SZAYiWPqhapoVZRpaaMHYuNNlDaMSotzkapR6kMnFxU=;
	b=AsSt5YuHFZTm4uOk38PQOfYUjtSgvhrxe2m/v/o1QA0Rd/QPLSpMZsKX5jxFxe+0HUGWfi
	9ndqWRBwCbmbCBRsUnH2Qfe2HRnMvYg/LAaUA/2B3L8ZYnynmRiL/Dxq4vl7vRUxeagUWl
	/ml21Nv5V047L5/YKImYNC1k4DFiv2A=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.15 03/25] batman-adv: tp_meter: initialize dec_cwnd explicitly
Date: Fri, 26 Jun 2026 18:10:42 +0200
Message-ID: <20260626161105.124113-4-sven@narfation.org>
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
index 2b68eacd7bf51..f7b0ce3f8e2ae 100644
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

