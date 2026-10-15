Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D0C59388E59;
	Thu, 15 Oct 2026 01:53:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792029232; cv=pass; b=qLToUMorkkGz6YYP/finCUaYMBmOLbVAJmbAFeh7JN4rthm6fquE6esxA28eCLJXHPacVOZYBU5Ah4pv/PMhqOQPlchAdxldW0h/ofgysdDxZEDUXaaQ6mFM9xfqF2EXigjoG1tUwN13L+7lOyMve+BazLu5pzqjofq+xTcWTTA=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792029232; c=relaxed/simple;
	bh=848LzRvnlnQzlqeA+kBmcLmF8BouHfWSkPJntA0ExHI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JRjrIR3QdvKciHbJVHXVkIlPf3RYE/qGRYhGY7NESzxl29CgL/rjOAAfMZspKXmHMzO2m70SGS+G1uu6WxXxG52ROFco4/4iqdWbrthviVKibzdysqo2rk8CV6yZirXuixDz0CrpIesH7e1JU6iBtA2Izp+jBRbxJ1ATIzVUC8I=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gBCF/3qA; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gBCF/3qA"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 616542027E8;
	Thu, 15 Oct 2026 03:53:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSadS0UA+Oi+k7qAj5ETX1kfD9e7tPd6g1V6+n52G4k=;
	b=gBCF/3qAv66oQyXUG+AqzPDU/VnlO5FWrjQ8+lgV8I7ZwAIjjnfJkUAAo+MHAPi8ewYQwp
	/LnLWnAIdb9BFDumA0QVXwdfyaCwbYWb8tD7FXxOUXmKcGO0jnmSqjbYPkD1rSAVz7hAFu
	A+ZyihJ0hCCW1iTguymEQfFSluAPETkxevQfX2ydJ8d6RUqN851FviA+MozC2VsjaefFw6
	FbstadV8RZr0pNuwu5POXCCRjH7JiRkRb+gjKPaEh6sEXBN4FwCE3QJV8gIJlxmn29OF9h
	6Egn3QKOTMTbzYdvTHrBciFrEgeBsSz9FibNkCewpjlw9lOy0DTR3RtaaSr+cA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1792029222; a=rsa-sha256;
	cv=none;
	b=dgZhqi/usMhhzu21FRjeBuURiNRdrXJJJetotAejL0/dHYqy1+RM7c6z/lzjKSl3kJqvkE
	6dCnDHga3CEdtP01TKUH4gsczVi7kxPb/sF95qTEAC0Vu1VD/ed4VvkGLZ/ZDPSfbwTzt+
	zAsQT7ATZFpD6ENt0Lb4sg29eCSqvp7UVyT3yDK/W4kQgXtCr/0frBSDUkLJ3AGvcHuIwt
	Ma1Tq5RLZUiWEqzhUTQbFmAOzUvsxIrw7gSAW+NPksE3CPsTNsISqMAAtaR+jJQnUtdssi
	7pDfvZPvYiXX+4i/a7UNIizcW7I+s6qQkzZMc1r1ifqfBtxGxTa9EChKxHgqWw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1792029222;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=SSadS0UA+Oi+k7qAj5ETX1kfD9e7tPd6g1V6+n52G4k=;
	b=bQvo/hRoYoseODNJxYtt5f0W/o1RT5gXk5tf7OSBjKYYvXmXy+YT0bChG0TDh4PslygU9s
	9ILcP91sBGwQ0lDyp543O673NXFV0sOXcWfg2eozTpgU97bupWOCCfXXVMATT0JmIsQQ6U
	nb2z9SFHpQLfDs09Vr5AQJuNYGH1x0XBv4QVGSJBYmOGvFcrESE6jpKJdQon4nxmqy+6bW
	dzjF54/tRGTJzHbrp6Kq25rruSMpMcTvdp/zohqiUgLVm0CjIByR2A7RjTJFN8yXcR5+op
	JRKUUOr+lNF/8DPHmvaci9lKy78TYaYVEv4hQvslOH9RFceZYpWcelzPl+KkTQ==
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xHAf8-005wrX-0z;
	Thu, 15 Oct 2026 03:53:42 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 157975C47B0;
	Thu, 15 Oct 2026 01:53:42 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Wentao Liang <vulab@iscas.ac.cn>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net-next 30/37] can: flexcan: flexcan_setup_stop_mode_gpr: fix OF node reference leak
Date: Thu, 15 Oct 2026 03:40:28 +0200
Message-ID: <20261015015336.816543-31-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261015015336.816543-1-mkl@pengutronix.de>
References: <20261015015336.816543-1-mkl@pengutronix.de>
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

