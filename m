Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 296D63F9F2D
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490271; cv=none; b=mQ1vFaZTrUM1v8l7Ce3SdkBuRti8JFfGkJUwlocrn4Vs2HgsuIFyw7DdK6f6H0ZhhMsbP7wq1kdwwhwIqiHdKIADVYyutGrFXG19cKaUYbLlAVJlMBwto6ZZHu2uo/P9pIK34DU/Gp/M82qbvS6GHHehXzFak6Q64DQvDFTK8wU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490271; c=relaxed/simple;
	bh=mrOHCjmarxacIfYVNLxh/HDZsnPtpmHEBZT7FV3e2YQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Zdw1iEf4xeN/jXaQegmluwrtZudm5NggdIEsnoxtZEoPIlCwJHjbMIMSrUW9n5YoNfinHzxQMBrQ9Trfq65psunKGXgA8DYW5oy/1nEOXKnYy5OuL6GmMaOJA2320pfIBZakZq5GRlOnspfa+8liWaMoSDXhIBE9GC+tUd8gQsI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=EndbmAAg; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="EndbmAAg"
Received: by dvalin.narfation.org (Postfix) id AE1DC20019;
	Fri, 26 Jun 2026 16:11:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490268;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kKSQytBYWRhx/U4SFgGK43FmJHhND1hDtkzQvuEFr6U=;
	b=EndbmAAg411IrWakxHbIDjD5KSf5nflJCfrBUmrsvV9x5dCNd9DMR+O8dwz4bNINGSRkej
	sCwURA+HOIiC+NXUUiIWxSSp2L8zc6RyHOW6qn8mi80e3IbnwTW23eS2S8EPn2RI2iTNPP
	A4DE/2OQ4w2Oo5ptmfgKLilDZKWNH2s=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.15 07/25] batman-adv: tp_meter: handle seqno wrap-around for fast recovery detection
Date: Fri, 26 Jun 2026 18:10:46 +0200
Message-ID: <20260626161105.124113-8-sven@narfation.org>
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
index 1fc8d6e6f99b3..7385cd02abf9f 100644
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

