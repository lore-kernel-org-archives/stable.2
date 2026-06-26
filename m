Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7A795403AF8
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490369; cv=none; b=OTgEAw4cct31P3OJUvXiRFTHTzHSJzPHXCvG8VVKYdIkhz1kngKDj4R8/QO31oDH214wuFnyFsU6Yl3YKhRWBUdv/4A217jSfvFfVLnfgWqwdkP7W+6oE+v5Ark44F2hV2N/ZP5UraaQuxHg1oPYnnllfCXMc0zQ/xdzEPJILS0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490369; c=relaxed/simple;
	bh=Y02KKNNrvFKpkWIa37twrDKfBQsPSjvcQ+opjAg5TIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Y/XkpvN7GV40IqfaDjw8ouDi5sGNPlWGd6vvZk5xAHOqV3a92Tlfr8dhRwhs8hm52szMOHTTX+u4UWEVjgHgzSXck4b9sgaCtacs/7CDEugECOijJrPKNxf/5Qt+4Mui+hE47E9i9GKt9tHQMjlW1VX0lVuh+epusjEhf2IDqUI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=mUYvs5qE; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="mUYvs5qE"
Received: by dvalin.narfation.org (Postfix) id CAD6D1FDCC;
	Fri, 26 Jun 2026 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmVOFHYZzthtPpps0ldHMboRyYTXJe7XnIfYbc7KmeA=;
	b=mUYvs5qEVKQ/KUDO6CwuFQ29a+xYsmJsg4G/sl+FEWAUEn8tbx0EiXZch4H/nH6MfSB5Ba
	QSDC39M67vZv2NgK0BlcpELgflx16/8owDJZsqNZxZMUYVMLT2Irwh+EllZzt57YmEjOki
	NCK8cDd4G7V/PIoIIc++KyuKz7NKZgM=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.1 03/26] batman-adv: tp_meter: initialize dec_cwnd explicitly
Date: Fri, 26 Jun 2026 18:12:18 +0200
Message-ID: <20260626161241.124988-4-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161241.124988-1-sven@narfation.org>
References: <20260626161241.124988-1-sven@narfation.org>
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
index 0325b951ff8a8..2ff7aa5ed19fb 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1055,6 +1055,8 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	 * mesh_interface, hence its MTU
 	 */
 	tp_vars->cwnd = BATADV_TP_PLEN * 3;
+	tp_vars->dec_cwnd = 0;
+
 	/* at the beginning initialise the SS threshold to the biggest possible
 	 * window size, hence the AWND size
 	 */
-- 
2.47.3

