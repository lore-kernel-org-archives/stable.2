Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E90C3401A00
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:12:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490368; cv=none; b=QVR0HEsKq3uasnhlEKye5y1hFfe48y6J6yUmKFEJE/a3zoxTcLf6wkW58V0qvMLw64obEIPgXRLEggBT1Ch6vdma1333Hb6LEmUSpT1B5Ym25VffstpqG6xLWjW4jSMNojIm/5iNS+j4FAiL3/pTPGSHV1rG0ifzaTabT0O11OQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490368; c=relaxed/simple;
	bh=QZktRvAi679Js8LcsPuSgfbx0QIe+PSG1y0OBYyksIw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AOxbHu34GB7SZfAdUiGzm8R4GuQdXkI0DEJRF8+vDI1qh3bMQ5+ZZJU0Ye1pF8HQTSYmCuF9xqA7pW3fBSo2kNxtwTMRd6CndHU8gEhgIkup4lBR4rdgb1TYmt40d31hkE0UihC+GljN33IZTXxOOyY7PQuKboSaloXujVf2V0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=m9k3vWTw; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="m9k3vWTw"
Received: by dvalin.narfation.org (Postfix) id 2BBF4203E0;
	Fri, 26 Jun 2026 16:12:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=MUo/n68WRcfdrH+GxigRX3fJka5Paoze8a3ktElMHtk=;
	b=m9k3vWTw9fggRamp+WocKAlOSX3sugViZtGA++WQ+FsyyetWqOpwzFpiebqOwXEm21PtA+
	YGWjj9U9G3am/1My8UFgobyzvESlqec269qNN0lMxwWZKwRd8a55ws33yIJRvc9PxHXCWz
	HlsFCY966e7bYU8EPUhinNe3qR3ipAE=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 7.1 02/26] batman-adv: tp_meter: initialize dup_acks explicitly
Date: Fri, 26 Jun 2026 18:12:17 +0200
Message-ID: <20260626161241.124988-3-sven@narfation.org>
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

commit b2b68b32a715e0328662801576974aa37b942b00 upstream.

When an ack with a sequence number equal to the last_acked is received, the
dup_acks counter is increased to decide whether fast retransmit should be
performed. Only when the sequence numbers are not equal, the dup_acks is
set to the initial value (0).

But if the initial packet would have the sequence number
BATADV_TP_FIRST_SEQ, dup_acks would not be initialized and atomic_inc would
operate on an undefined starting value. It is therefore required to have it
explicitly initialized during the start of the sender session.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index e8941f753a969..0325b951ff8a8 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -1045,6 +1045,7 @@ void batadv_tp_start(struct batadv_priv *bat_priv, const u8 *dst,
 	tp_vars->icmp_uid = icmp_uid;
 
 	tp_vars->last_sent = BATADV_TP_FIRST_SEQ;
+	atomic_set(&tp_vars->dup_acks, 0);
 	atomic_set(&tp_vars->last_acked, BATADV_TP_FIRST_SEQ);
 	tp_vars->fast_recovery = false;
 	tp_vars->recover = BATADV_TP_FIRST_SEQ;
-- 
2.47.3

