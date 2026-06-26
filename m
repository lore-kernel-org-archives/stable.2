Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 71A573FD140
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490351; cv=none; b=RsqzUGbRFdwZd0F8o+fHLHEmeOn500qGDMsM9Ln1Nz8+YFH0GnN2h4ULG/PhTERmgqPj1UkTecGbf4x4L8G+UpvOyuXWiwkNnzVRUuOSv/X/FVNlKMVfkOQV0K8q46GzIk9FqwdRAk4gGd/T8UIT8yKIqRma7/vT0DF/oYdoXs4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490351; c=relaxed/simple;
	bh=Y02KKNNrvFKpkWIa37twrDKfBQsPSjvcQ+opjAg5TIg=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=IGOzQctf89FHqOCbHuhS7MyMTzHwWM2ig7LWs2P+tG27JkuG+LXRV6ZQg6vGD7nWtiK9QXjBdCEzD2/LvVk/X5D7oNdp0PkPI5gQnep7o6YrXwe07AmO0P0WohBDAze/8LT82xlPzoGvwRt7sAtjQBgGfuKR3zkZCQiav9fMtII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=cgGiDCVP; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="cgGiDCVP"
Received: by dvalin.narfation.org (Postfix) id C3E62203F3;
	Fri, 26 Jun 2026 16:12:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490346;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=OmVOFHYZzthtPpps0ldHMboRyYTXJe7XnIfYbc7KmeA=;
	b=cgGiDCVPzqRNxo59Mi8XSumLgPl8P9fNokPNRTVs42luIsK37BBjUyNbdFFJV2kpnQ5gaC
	6oaCvd2VNPCK0BU8J61OcOeCpmjIhxrj3dr405y/DQ3y8r4wadNbFXmj7dsezW5sp4Pfaf
	uwY4jpBlPHLB1Wnqy4PFtK2vhuORszg=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.0 03/26] batman-adv: tp_meter: initialize dec_cwnd explicitly
Date: Fri, 26 Jun 2026 18:12:02 +0200
Message-ID: <20260626161225.124839-4-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161225.124839-1-sven@narfation.org>
References: <20260626161225.124839-1-sven@narfation.org>
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

