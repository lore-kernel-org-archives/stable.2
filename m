Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13CD93FC5DD
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490337; cv=none; b=Djw2LtXsS0ubfwii9M4NDmnvFiBWc46t80trBEfb/0nS/UbBr+ZZQw1aqbbXleK6ALfas3KN5b9YRPKBYSth2+gg+Tik+/LD12BKtXeiUv/+ekkim2Yv652iNaka8O77lOzZFZS5XrgOG6oOIdxNsG+yGIIxDKlWti5pxbR+tsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490337; c=relaxed/simple;
	bh=HFV9zMSfz6y9vsz6bD3pnBRlsupfWeZlLoKChZFVrug=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=quSeizCZI/hTlEuwMiabBSGEIXcaGQL7Djt9THsi4BG7jsNceuhCAS3dIgX4N4qH+kFU45JPKbIHyPr2X966AVmHJD70X66H41XzcjvBIn+4oF5S4Yxp+aEWWuCgWztVPA9sRzWlNgX8jIQS9CmtW0zSDLozSzPGyB2YLlnBzUE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=hVSWNzvX; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="hVSWNzvX"
Received: by dvalin.narfation.org (Postfix) id 7082D203F3;
	Fri, 26 Jun 2026 16:12:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490332;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NU4QrmwGiT0OpK327eM37959cvI+bPaZj6rT15wqN1g=;
	b=hVSWNzvXYPVZTurxj3F6Kv+LHODmgqWsXRYLeZQazQ1fZSOSF4EbawLhea5nnZ9GJeoKhS
	eLpvLBcG/Vg6BLs75lSl9tnMV5exiuUozuwBv/4CWONckwJCbxtJATr75YVysplEQfbHcl
	R+4W5IGs54te7tILVMBzKUTUm+BDUB8=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.18 03/26] batman-adv: tp_meter: initialize dec_cwnd explicitly
Date: Fri, 26 Jun 2026 18:11:47 +0200
Message-ID: <20260626161210.124712-4-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161210.124712-1-sven@narfation.org>
References: <20260626161210.124712-1-sven@narfation.org>
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
index fe9a447643074..473641d32dc68 100644
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

