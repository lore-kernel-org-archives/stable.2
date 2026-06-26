Received: from dvalin.narfation.org (dvalin.narfation.org [213.160.73.56])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F74A3F9F5C
	for <stable@vger.kernel.org>; Fri, 26 Jun 2026 16:10:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=213.160.73.56
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782490214; cv=none; b=VuGDG2aqCWVkEJdfBbVmtMDspWPtEdPtQW8RaTXaGkdUUmP4HadTOYyyRG9tyRCqeNvQ34LJ5NXRFZeAEAW3INOGUgKNXaFVRHi7EufjT6Sg8Tjx1dXpa1vpClUdTdxKk1jJI65UlVBeE/vSFYQc8IOWyGAku3b+OxXOnCdYBjk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782490214; c=relaxed/simple;
	bh=9j/WCnV9hASizvMyfrRDLf5RktwHLbOCEQyhcDJk6hU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=PM0cvvrURFVifxx0baBFRw2dKcM67FLSLLIF/MJHHSTrfnyoU1LY/+O6++AsAwbRTav3+i1hSxDPEgFMdmLDGd5il66JsPC/G85CPlyXYU3G3tFeXrudVBdYhYJoGOrbG+NmXsaSFnJkKp+4MzYRYJ61LN1pSP28cLEqbJtlZDQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org; spf=pass smtp.mailfrom=narfation.org; dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b=K5t3COVV; arc=none smtp.client-ip=213.160.73.56
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=narfation.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=narfation.org
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=narfation.org header.i=@narfation.org header.b="K5t3COVV"
Received: by dvalin.narfation.org (Postfix) id DAA4520535;
	Fri, 26 Jun 2026 16:09:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=narfation.org;
	s=20121; t=1782490196;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6w0KBA6Yu+Dvjx5/OtDIKKoN5o4XvBeaLMNlIKI8VzM=;
	b=K5t3COVV2whjRxcAJ6XDWMpr8MHY2UA8ZNS7Fi5NG8RoOiCb3F6JmiGpFEtxFiRV/Z6VmC
	IiuL0LAo0K/j/Ja8x8eADkfnTH1OvKEhL4WwOcsWgeFT9y+a7WrrL9NoOzV1dS1WQGmTjN
	0jcPIiWt1sHbb4ix4VOEi/b2meKX5uc=
From: Sven Eckelmann <sven@narfation.org>
To: stable@vger.kernel.org
Cc: Sven Eckelmann <sven@narfation.org>
Subject: [PATCH 5.10 06/23] batman-adv: tp_meter: fix fast recovery precondition
Date: Fri, 26 Jun 2026 18:09:35 +0200
Message-ID: <20260626160952.123713-7-sven@narfation.org>
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
index 118cb5dd285c2..cd19684247868 100644
--- a/net/batman-adv/tp_meter.c
+++ b/net/batman-adv/tp_meter.c
@@ -738,7 +738,7 @@ static void batadv_tp_recv_ack(struct batadv_priv *bat_priv,
 		if (atomic_read(&tp_vars->dup_acks) != 3)
 			goto out;
 
-		if (recv_ack >= tp_vars->recover)
+		if (tp_vars->recover >= recv_ack)
 			goto out;
 
 		/* if this is the third duplicate ACK do Fast Retransmit */
-- 
2.47.3

