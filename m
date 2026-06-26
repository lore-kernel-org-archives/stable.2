Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B26B3FBB6C
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490322; cv=none; b=L0zhcqS+W4AeGjNUcyRJczno414HqA2Qdvc1SNg89HSkPMew7c6KEoDBjzrWfoaUB5INia1yWelb5xb8aDLp+8mH8KotktUAimsnEClsvJ/Ta+0toX0TUq06oGVO+tFKydH3l5sLfXnVdHduemnWhppwRZZoEfvi6iPKixJ+Aog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490322; c=relaxed/simple;
	bh=A8u42liaprNP/PhHokMe7if1pI0HdebfXjSWHvPRZ4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pztAMDGderURaQcb7xk8cRg0hc3FGDDw0vV6u4hogV8wlKNwUijnPeq+zuPfdd1NtkI4b4dtriRkgekRFbKDz4TfOPSC+kb50QDS4UOUC73JA7VMeeIDMneuvUQA8ScOgKTNYlahTFW3FpBfVA+LlhiS6E2udjL0gtzImKM25iM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=ekKiEmYJ; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="ekKiEmYJ"
Received: by dvalin.narfation.org (Postfix) id 300AF20019;
	Fri, 26 Jun 2026 16:11:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490318;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=u7b3U+e08OqxMAcpByoU4I6VVFh5+9DObfIpgMbxK54=;
	b=ekKiEmYJVB/f0XGqmqIjFJ9KrFYS/zLIez1jaXBPqXmvHsOJY+dje5oCGodFYxrc0z9fxw
	/LGplT2BR7chhiTbr0f8PjQxOkAPehqRHP5s861trEF+WGv830lqp5hqLgv1AmIp9BkNA1
	wYhBdxcN4ZoP7kUTPGzu72ICgj/PRfA=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.12 07/25] batman-adv: tp_meter: handle seqno wrap-around for fast recovery detection
Date: Fri, 26 Jun 2026 18:11:36 +0200
Message-ID: <20260626161154.124562-8-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161154.124562-1-sven@narfation.org>
References: <20260626161154.124562-1-sven@narfation.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

commit f54c85ed42a1b27a516cf2a4728f5a612b799e07 upstream.

The recover variable and the last_sent sequence number are initialized on
purpose as a really high value which will wrap-around after the first 2000
bytes. The fast recovery precondition must therefore not use simple integer
comparisons but use helpers which are aware of the sequence number
wrap-arounds.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index c79352cfddc4a..089ac7cc9fbeb 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -733,7 +733,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (tp_vars->recover >= recv_ack)
+		if (!batadv_seq_before(tp_vars->recover, recv_ack))
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */
-- 
2.47.3

