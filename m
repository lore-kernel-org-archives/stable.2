Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6C5C4E4332;
	Fri,  9 Oct 2026 13:43:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791553425; cv=pass; b=f0s88Sq8cL+EBkx2VWoVOM1tyyKBjTXa5F6vUvwbCh0Y5VlLSvXoOVYmtVtoCdAUlY0RVgETtCDxLvHYajASzda0jv1CUsLlXz8CWRH+sc8Fivp6SYDM79nHFq9KO7GZPoTqWwn0heLO1fF02q/4S9/Vh3aGY5gbYUAOSM6n3w8=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791553425; c=relaxed/simple;
	bh=848LzRvnlnQzlqeA+kBmcLmF8BouHfWSkPJntA0ExHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OPFZnYnRynlRdHQQ/+jhak8yhrqz5qFzwPe5zX9VLU11gw8eWfSGc2ldAbIXsx1g9cruU2VU8XTkIu4JRhE4kkmSUrBBRbPdimx4uJtQHPMLj7pViRCX77zAqgywkQLrmDJJeh2cjFOwG20g2W0WsTN/8Bru/elh26etczSQk2U=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=WKDx1+VD; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="WKDx1+VD"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 77ABD20266A;
	Fri, 09 Oct 2026 15:43:39 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSadS0UA+Oi+k7qAj5ETX1kfD9e7tPd6g1V6+n52G4k=;
	b=WKDx1+VDfbP0xp4S3nndSpT3w9rWyVosA8bPCjsuHsp03dhKjMpGFnI7ob8z0SASuVIWHN
	/TTrd6Dvi7kCIHQ4377o/7ivQ/YTxOQPeBTwd6vdMqs/QOm+j7tsQ5N5q9YOgaAmzID6mw
	WpA6ewuhAiHz9/OxWAEB9VPDIwqdVdTawdeEH8S0zluFeU4T1smW+DtBgynm3B6mtjQBjU
	+wthK+6f9o3A9vhV5KQJ2AZ8L2ZqJw1m+JZo7f1oMZ79lpLVZxc68PNdW8MWMuNZtXFQYJ
	Hbs885UGyXG4h0JAevVbFLPQ/kNor8rt19utnJIGSgOKY2BsXgMZ2apLoFS0nA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1791553419; a=rsa-sha256;
	cv=none;
	b=UoGdGDWQfe7WsGpe6YiE2Zje10fs+33HyoGNORJjvb63dnaMZCpE0fpiFMPDn6bPhmzxYq
	Rk36ZN6zMKV0hLtZBHP04Ebgth9byAf6CZN7dICUGr93TwQvVfmztsjcSezrIzv9Y2piXv
	OKHIOvbKKB+7WF8HER6YiKagRnSRr0/PIlyH0xdVMW3mDDSBj8ZHXrr7WNt5Ifm6GbiV2C
	hEDlTxTfpheE0qnQXnmDxBoTC6AqbCkqcPMYhANZRPsQVipWBhR8uJuWeph6tR1CMqoFc3
	BfnvdrRLGC7KjAT5UG+iWmj3+rqtGq3qnCsq2fUhsLwx+i/9ffsG8fCsSGAzBA==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1791553419;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSadS0UA+Oi+k7qAj5ETX1kfD9e7tPd6g1V6+n52G4k=;
	b=U9cbrKi71TQMB7QHyXPEDoQwOgcg0kBCnR65tTlIQ5pUqxILbztlXMoJQsMjtwN1gTQXW7
	RMHNpQhj6GGq1yixXPC6RcZU8Lvh9Mt2+HoKzYN650nfBzSxeAwfV1D0O0/zhjW5rWpP4z
	3hf6DE2Z5p/QLj4au2eI6bSgArp4235QPbnx1a1mHt/Q4+j5f9PWfVtm0IH/2ShPJrrDob
	xJSHTuQSvM9/8iGt659BIRJojDODfLdmWbUCR9P3PTHJMu9k43Us9BUoVHBgRwhuJr5rJw
	PXKIAWrK3jogC5lavEmvH1rpNBDmbmeVU8rfVixFMJSOk5Q5Bs/X1wvywLsEjQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xFAst-0053TI-1G;
	Fri, 09 Oct 2026 15:43:39 +0200
Received: from blackshift.org (90-182-211-1.rcp.o2.cz [90.182.211.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id EE9365BD8DC;
	Fri, 09 Oct 2026 13:43:38 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 28/37] can: flexcan: flexcan_setup_stop_mode_gpr: fix OF node reference leak
Date: Fri,  9 Oct 2026 15:28:00 +0200
Message-ID: <20261009134323.64064-29-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261009134323.64064-1-mkl@pengutronix.de>
References: <20261009134323.64064-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Wentao Liang <vulab@iscas.ac.cn>

of_find_node_by_phandle() takes a reference on the GPR node and the error
path releases it through out_put_nodeq. The success path returns before
reaching that label, so the reference is leaked every time the stop mode is
set up successfully, and the node can never be freed.

Release the node reference before returning.

Fixes: e9f2a856e102 ("can: flexcan: fix an use-after-free in flexcan_setup_stop_mode()")
Cc: stable@vger.kernel.org
Signed-off-by: Wentao Liang <vulab@iscas.ac.cn>
Link: https://patch.msgid.link/20260917095302.2145506-1-vulab@iscas.ac.cn
[mkl: update Fixes: tag]
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/flexcan/flexcan-core.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/net/can/flexcan/flexcan-core.c b/drivers/net/can/flexcan/flexcan-core.c
index 86b40abe9e76..30ae7c344a05 100644
--- a/drivers/net/can/flexcan/flexcan-core.c
+++ b/drivers/net/can/flexcan/flexcan-core.c
@@ -1986,6 +1986,7 @@ static int flexcan_setup_stop_mode_gpr(struct platform_device *pdev)
 		"gpr %s req_gpr=0x02%x req_bit=%u\n",
 		gpr_np->full_name, priv->stm.req_gpr, priv->stm.req_bit);
 
+	of_node_put(gpr_np);
 	return 0;
 
 out_put_node:
-- 
2.53.0

