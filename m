Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A9484FE2CD;
	Mon, 28 Sep 2026 19:33:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=185.203.200.13
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790624005; cv=pass; b=EnKsBkV1VqplvcAgK70XST0e/67szfQ0J6ndH6XqeszAGRwiO2yP9VU3QGsUPZcw8Nt8wpAFYMgDN7jJXuwwpMyNPJhrL5PmL83o5CrgNL+vk7gDjZ/e7YY5etRe3YuNOv6qw8yW3j3aiVQkS+X3/aFTjZK2DKu9N4C/iDuVqkI=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790624005; c=relaxed/simple;
	bh=/tS9UHfh5oMJXoWU288mgozs1KPH+bmj36WYXgN51gA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tVhfgGtw30q0OeUhoV2UWdjSvVt5R9URaRnk4W/ae+RJu8Ve3hONIt77A1uYJwbkTI4ZAQwM5bom2ARluJAbOGFMQJOtNStWvcDygrH0V3XVMrzH6pkBaVeGK8YryXK0KjwisbuuLyn/onfr1/oWIv9cqd88lJCuntyBfvkZmWM=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de; spf=pass smtp.mailfrom=pengutronix.de; dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b=gL1HICGE; arc=pass smtp.client-ip=185.203.200.13
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.b="gL1HICGE"
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 897B3201F11;
	Mon, 28 Sep 2026 21:33:15 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXE1zh/6Rzobguy30PKw5Prn2N2vT/up9S0WLiJfogo=;
	b=gL1HICGERJaZNGRZRlExTn+4/Cz3Mbbg+vsG2lYSD+brKIwu6o26JrlpS5sU9R6DV0aUKZ
	lzDnvzngMiZAbFSJvH6cB7h14S7BpybG/L2kpxtTKcX7Wub6FXHrP58qMmEBexk3c0cp5+
	lCV/3BqINQAQmNmjRwH2N6fuMemwlmumkyKL+iKmhgmPBXVnXuz4pRkWvaZnhUm0ja8YuE
	KfDnyBCHeTm8wBqmnh+vkTyxkFZm7J1LAMBEZAO/NwPP07C3je6UXw7I9Sz9nBG3AoNHe8
	Mz9ORaFLPPTnVGXfONShhhjYFTQu23fyphwvgLOjE3UXoHo6rDZsuqwWDIodiA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1790623995;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YXE1zh/6Rzobguy30PKw5Prn2N2vT/up9S0WLiJfogo=;
	b=Op1gGJWKFKvYee5NIubxG1zfSMEIL12qEVLgQ/GBoKixaw1FhrVygSaIRTSEaIJpwDwVit
	YQ7BLnzEi+9ljqy94KzeUZ2A7cnu1Z8fegv9fUQnIvfUJU8QDCxNhGSJikM140K4Sdlpa9
	17ccs+FMk7tZOwUDHFih/LUTXf8Yji3QJ+CUT/JqGBkBWNpLJF28H1VqXGwfq2/qcZQlPc
	WDHiIFbXJmTHQ7LIEzqHd19oIgpzPC8rT2FN4vr4x6rLBbNmpd7oovSH+S+0Jo0k5YFNyJ
	aNZVBUqmyq1qt+au23aJ58AVddgj1/OFWk8wqH+tg9+PfbDFA1GKocc0UMMPmA==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1790623995; a=rsa-sha256;
	cv=none;
	b=P2y1mZyGm2l6r6lxg1IktncGaglhAp1smzIn3iMBNKONLCGutrd0Yi64g5hM+QUN+9oAsz
	Qw7W1xgNcqh1QXQelg4oMprJYeIUre48hRFKR/FZUW+YuQmGap91tV7pB0AWVcNb2DHP0x
	VqN3la1k97rfWjIlEJlfToyU/mGvJ6PsBpPbHwkiXH8CK+dPOpB7uviP8evEjMlX27VjO+
	FEcYpkTh/YAjtu32+wW+KRpF0no/V8bJ8+DLJ23Tb7545fzpfQ6CS0RbiG36P9ToUf9B0t
	Eh+5fycenOCANy4xDxCp+9nIcT5S7Wt3I1i5aROFeV4d9/8JQglSN1LiDHnIhw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xBH6B-003H5u-1M;
	Mon, 28 Sep 2026 21:33:15 +0200
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 275235B154A;
	Mon, 28 Sep 2026 19:33:15 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Cunhao Lu <1579567540@qq.com>,
	stable@vger.kernel.org,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 03/22] can: skb: make CAN skb allocation failure paths IRQ-safe
Date: Mon, 28 Sep 2026 20:45:10 +0200
Message-ID: <20260928193312.553632-4-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260928193312.553632-1-mkl@pengutronix.de>
References: <20260928193312.553632-1-mkl@pengutronix.de>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Cunhao Lu <1579567540@qq.com>

The CAN skb allocation helpers are used from hardware interrupt receive
handlers. If can_skb_ext_add() fails, they release the newly allocated skb
with kfree_skb(), which is not safe in hardware interrupt context.

Use dev_kfree_skb_any() for the allocation failure paths in
alloc_can_skb(), alloc_canfd_skb(), and alloc_canxl_skb().

Fixes: 96ea3a1e2d31 ("can: add CAN skb extension infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Cunhao Lu <1579567540@qq.com>
Link: https://patch.msgid.link/tencent_C825C17D442F801351CE2FBC4984064B4605@qq.com
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/skb.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/net/can/dev/skb.c b/drivers/net/can/dev/skb.c
index e0eac3678a77..d1f797d3778d 100644
--- a/drivers/net/can/dev/skb.c
+++ b/drivers/net/can/dev/skb.c
@@ -224,7 +224,7 @@ struct sk_buff *alloc_can_skb(struct net_device *dev, struct can_frame **cf)
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		goto out_error_cc;
 	}
 
@@ -255,7 +255,7 @@ struct sk_buff *alloc_canfd_skb(struct net_device *dev,
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		goto out_error_fd;
 	}
 
@@ -293,7 +293,7 @@ struct sk_buff *alloc_canxl_skb(struct net_device *dev,
 
 	csx = can_skb_ext_add(skb);
 	if (!csx) {
-		kfree_skb(skb);
+		dev_kfree_skb_any(skb);
 		goto out_error_xl;
 	}
 
-- 
2.53.0

