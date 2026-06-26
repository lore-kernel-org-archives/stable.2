Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D18B3EB0E6
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490215; cv=none; b=NPeecNh2kt6O8C1F4fTS71A0763c2f1nvC0pxTbyT0whcdLjcIVQLjHrohLRi+p6RF0uIlJX+Jjqy45diyPgt35zP9xdQNBQ//mxgmtLr9Jnl+cvQ0kdf1CMd0eASqx2eXbQkkDbTKZbgSBcFvqziEvey//zWV0grFSxwmMD9p8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490215; c=relaxed/simple;
	bh=2jChVqF4oU2q6y12zsTHpP0+ZuCnYLhyPY96OCV8NPI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=sr9/iNcFpcF399+I8TDfnU1m0vJ8DMBHqu8Gt17AjQPDJL1Viy1XW2k2Op8Tp9yAiwnGNEiO2IhGHjgj+Rrn8OY4AiCFWkGhRX+yKGT8gCdTQLW59VOY3+8kYHqTr9S/1TT1fFtzEiC2Y2GVTLuq86DlcjamXTZrovFIscHV8g8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=NCn3tQQy; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="NCn3tQQy"
Received: by dvalin.narfation.org (Postfix) id 4A6FF20536;
	Fri, 26 Jun 2026 16:09:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490197;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=IFGTsz4HRr7mGSTewKM7+fqVr4RDf7qIJ52QSojv59s=;
	b=NCn3tQQyfEbsKHu/DYqjM2RXAd+R/+f7cr9sWo10JyQaDI3ys8g7a4i8/9Nr8+zHRZVnE4
	T/fVzjMDxRka46boOnc+fs7mylSG/nE22aEOhaAUsgVIp330UWvidzUowROKrYJmYhVpaO
	sdzuKgbJhQ1wbrqfQnJzA1X8v6qCSH4=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 07/23] batman-adv: tp_meter: handle seqno wrap-around for fast recovery detection
Date: Fri, 26 Jun 2026 18:09:36 +0200
Message-ID: <20260626160952.123713-8-sven@narfation.org>
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
index cd19684247868..a4df826e4ece7 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -738,7 +738,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (tp_vars->recover >= recv_ack)
+		if (!batadv_seq_before(tp_vars->recover, recv_ack))
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */
-- 
2.47.3

