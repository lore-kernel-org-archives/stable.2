Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9716B3E2745
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:11:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490289; cv=none; b=fDX3X19i7axYU4CaNHHHIAZG2639G9h6OaNEy8Ymg+4CMaiX9BrKq6Lfo6jObBmHXfRQLYCD2YVlV7oMV5BGbJXdDS67MtH1LKFkoexKXvjHyB097KyBk66RuQJu38GTl9doyjBa9ho9KbQ4Ko+HngPk5+0n7oAgBURCwng4BH0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490289; c=relaxed/simple;
	bh=vXTJ3Ze3AGsT0Ide3e/5npQwojTQ+SKi/Y6S0mcUB4Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M/pXeutYZPW0mctTFJa9T+M9npkgO2/CXcbwFkBQWjT0yB/Djir2gdNZ8QNqCSFo/JlfKGbea5qRTuGPBB82B9X7M2tVhdwJeNdl8+o95/2wBSPVLRg0aYCzRfjkzO1IQPu0s3xjhQ9dUVS7AQ5gJTmPIm9E8E5ZrMQc/DFKSIA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=kekn4ru6; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="kekn4ru6"
Received: by dvalin.narfation.org (Postfix) id EEFB82045E;
	Fri, 26 Jun 2026 16:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490287;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=NHKqF1TMgJntkWHY4WDqo8FKj/iyEUyqxuoSoYWt6uk=;
	b=kekn4ru67Lr57i0PvFJ3/s4VXNYk0CPcqQnxPMgye7xbkqyRJ6WgjHRzrOfLyH7Witucda
	WAZitz5F6lD4NTJ6HNojekZjb07qqq41J96LsfmAFODWBi20K89S+cNeqJ7ZGFsJFe7gJj
	iDgAKTFfJ5WZa5uqLKXNn50BhV02GFo=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 6.1 06/25] batman-adv: tp_meter: fix fast recovery precondition
Date: Fri, 26 Jun 2026 18:11:04 +0200
Message-ID: <20260626161123.124273-7-sven@narfation.org>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260626161123.124273-1-sven@narfation.org>
References: <20260626161123.124273-1-sven@narfation.org>
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

