Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 202F83F9F26
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490321; cv=none; b=kdiVkkUv249fsmATRtVM/ENC4YHPDQdE7a78T5AvBd5iNRf3O2KPy+82ZNh7ywegzZOPWmU6YuM/qT6LpEHdLMcJRxlIwDXNfQ/hxC/oqBlHCLh28CFIP4XCEpdS1ebvCkeBzes3KyCPFvk7GromtLxfKqa8ZsiCPHDPCpvU8Qc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490321; c=relaxed/simple;
	bh=vXTJ3Ze3AGsT0Ide3e/5npQwojTQ+SKi/Y6S0mcUB4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NNV094AwImYggmC4AkmNZoE7yb3u0J84Khp+dxCXV0Wub/4OColY0ZOr7c1NiY55FTDHsfKdVEVppkdHNLfTfdIt6vLDZMxqsUTv2Nx9g6OsmzIZVzFa+jx2HXzdM3F5fICBKHepAkDWRxfHKrWWepLuSvJt3GC3Eillw8+UxKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=dzfwvYnW; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="dzfwvYnW"
Received: by dvalin.narfation.org (Postfix) id B0A552045E;
	Fri, 26 Jun 2026 16:11:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490317;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NHKqF1TMgJntkWHY4WDqo8FKj/iyEUyqxuoSoYWt6uk=;
	b=dzfwvYnWdbtVtCi4hQM9aDmwpCO8m09sTwcoJe7G9uB7Z0ri2g77xaeUDK9UAYgd/g/yZ2
	51kML/Ix88iM1P1BXpc34w6K9UhgmtpdrYxrPzSq5ruHT9fpOjrQerR37jAzdwBvbNJ1FN
	LWdKh5GlLJJmGDwoY7tpz5Mw/PTnNHo=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.12 06/25] batman-adv: tp_meter: fix fast recovery precondition
Date: Fri, 26 Jun 2026 18:11:35 +0200
Message-ID: <20260626161154.124562-7-sven@narfation.org>
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

commit 2b0d08f08ed3b2174f05c43089ec65f3543a025b upstream.

The fast recovery precondition checks if the recover (initialized to
BATADV_TP_FIRST_SEQ) is bigger than the received ack. But since recover is
only updated when this check is successful, it will never enter the fast
recovery mode.

According to RFC6582 Section 3.2 step 2, the check should actually be
different:

> When the third duplicate ACK is received, the TCP sender first
> checks the value of recover to see if the Cumulative
> Acknowledgment field covers more than recover

The precondition must therefore check if recover is smaller than the
received ack - basically swapping the operands of the current check.

Cc: stable@kernel.org
Fixes: 33a3bb4a3345 ("batman-adv: throughput meter implementation")
Signed-off-by: Sven Eckelmann <sven@narfation.org>
---
 net/batman-adv/tp_meter.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/batman-adv/tp_meter.c b/net/batman-adv/tp_meter.c
index 4ff80e4214ff0..c79352cfddc4a 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -733,7 +733,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (recv_ack >= tp_vars->recover)
+		if (tp_vars->recover >= recv_ack)
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */
-- 
2.47.3

