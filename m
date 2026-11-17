Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794953406;
	b=J0w2KMzDCWxt8lUN75Er0KmhS8VR1tWGggSisW/INrpuZjeGU2XvR255NHGKr3MjTKXK
	 vATcWuY1ZgOx/bX+r4sUH903pmJGNVCJnx47E5/NSgvtIYrbviKjJ7WS6AsEHZgumSwhP
	 Le46WBKUN4HNMxSZSHLqdhDmcVADsDpN9PEkB90MwsSWmD/sZjaHphcvI6nxIKApCMg4f
	 UiB0WoJIKYwOHGaCQCik+XejxGhTA5mZVKk8ykqqZ5Z/kMputF1H7yY3AOOR671cH+kEb
	 Y0td5K+XqXkaU/BsPw1ThwpBYjzGfHpsqv58yURFjLM6YfuAj314c728EBWYhSocfFQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794953406;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9zywkjszLE/9ltEvJUfp+fkwkpacqMgHzmbP6X2blTA=;
	b=ggtV8/idpVaHK9/GI/1ip61Mle64AcUsljxGvKTIcjKmQEjcWkeU9ZHoS0k9k9rWBs/H
	 hsczg3Vm2bfHC99ntLbmf0comO5mskRTrAtELMQNjAfJHrpYX6tUZaHz+IDzXnAqKDSL8
	 5TrIpl+wmxrESFWUbHL2QyJuSTbrACoJDJ59Qm0qePsww6Wc9hmbU0Cu4KRW2dm5F/4VR
	 KIu78doJSfJ8O8wRpQFA9OH19E8ywVCTM6QSSd0ArN5LlIDnPFaXLV7qR6EW+E8Ev2N86
	 MZv+UVgYVJSqPdg8ndAD/AuolN0HTuwQBkvl/QwNVktXPy3/WG/ecMhOCGM9CPCnDNg==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PDSIbosv;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A2473606A32C;
	Tue, 17 Nov 2026 22:10:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A2473606A32C
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=PDSIbosv
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 12476205A5B;
	Tue, 17 Nov 2026 23:10:00 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zywkjszLE/9ltEvJUfp+fkwkpacqMgHzmbP6X2blTA=;
	b=PDSIbosv4AXlemuOGTIq/lwhlCAhtZVZ0F6GAq9k+3B2f4SaPN+rY0NFWjUOQi8aXGQvDF
	4kM9PUpp1C5CG8w+5TJsKtDlB2VOG668FzIm0R9tD1g2eV4GNRta9rAa73MsfeV5uH34GS
	bK0lT4o9egEQkee+e/Zwv0rByMibHwfDHa0RKGzlkasgnwLkqaGOTUM/ZnD6gZmVi4qK8+
	XMhTi7ijCRX7rYqclApv1vGlBh08MI6ZyuSLYnaqcHgh1Feo8WeUICDyQXgyjrNLVJnH1b
	TJ4hmXxl6qItRc3Cx3Njn1RuNh+TmXQ+A5myQvAVR/OSj+KsQkLxnL0wJ/qIVQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794953400;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zywkjszLE/9ltEvJUfp+fkwkpacqMgHzmbP6X2blTA=;
	b=a1Nu70iI9eVsLpbtWai86hJs5UdCn0aSUiZpai8n131L8RAtTCX7ZwYcOknhF5R32iKxlc
	f7xOhCcSn6YjeX1XTIo+kNySVrDwc4MkrcaDcfivH5bIqf6uzR/wZxS0CXdl8+IiJ5sBLI
	bce9HMNLufSd9tyLYyNF5x+8dZXWUCVRwSPO3nArAZUnX0qnyNwXibSwefIhbIX6M1nt52
	ajiwvLksiYodUnz+uxP6QkJq8chqnjxlyMJWvNpHa37T+Owja8Sd/2eyE+dwAqDMz+jiqo
	85wL8LhTqDUiAtsxl/l37y+u5jgbkbnG5DkumP4jeXZVhgcv4YTVA3hv4BatRQ==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794953400; a=rsa-sha256;
	cv=none;
	b=I3NyFAybIt7RAVIsRac3FM7W0i/SEgoM4HIC7eu1kkvfyLu3sl2TJxWt4XtWLSTF1NrwIO
	s5WQ7Ea/7A3M5lS5mAsqfugdha5No4dNIncpu0dubJMScO7nj0B42Oy7cbhDnLRzYb3+8g
	KH3IB/MEdsL/msF7NNO82NzO2UQJW3sT4sBA3CvFWqSF9QZpgWK3MJWRWRX3Tt9WdvWmeP
	eGVlLhhv8niH+BdyqfoZ274Egt0+ffEshgbEwSbtfcaF8LIhuXXHbkNcW4RSXmiyTncYTD
	vO2mi9l3xEP8J+aTOiMbKrF85oz7Z2J3kpRFrsFx3zn4Scej0lAJBpdBuXmYVQ==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xTRNH-000Fn1-1W;
	Tue, 17 Nov 2026 23:10:00 +0100
Received: from blackshift.org (unknown [192.145.8.164])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 9152E5EDA2D;
	Tue, 17 Nov 2026 22:09:59 +0000 (UTC)
From: Marc Kleine-Budde <mkl@pengutronix.de>
To: netdev@vger.kernel.org
Cc: davem@davemloft.net,
	kuba@kernel.org,
	linux-can@vger.kernel.org,
	kernel@pengutronix.de,
	Zhu Ling <zhuling0805@qq.com>,
	stable@vger.kernel.org,
	Sashiko <sashiko-bot@kernel.org>,
	Marc Kleine-Budde <mkl@pengutronix.de>
Subject: [PATCH net 10/11] can: netlink: fix CAN XL PWM attribute sizing
Date: Tue, 17 Nov 2026 23:03:15 +0100
Message-ID: <20261117220818.1142581-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261117220818.1142581-1-mkl@pengutronix.de>
References: <20261117220818.1142581-1-mkl@pengutronix.de>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Zhu Ling <zhuling0805@qq.com>

can_pwm_fill_info() emits the PWM capability limits whenever pwm_const is
present, regardless of whether TMS is enabled. In contrast,
can_pwm_get_size() currently returns 0 when TMS is disabled. It
therefore underestimates the required netlink message size by the nested
attribute header and 6 u32 attributes.

Always account for the PWM capability attributes when pwm_const is present,
and account for the 3 runtime PWM values only when TMS is enabled.

Fixes: 46552323fa67 ("can: netlink: add PWM netlink interface")
Cc: stable@vger.kernel.org
Signed-off-by: Zhu Ling <zhuling0805@qq.com>
Link: https://patch.msgid.link/tencent_9A525E0656A4F7D4CA9CFA1AB1A4BFC6D706@qq.com
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/bug/linux-3924d490-baed-49dc-880a-6fd1163cf08d
Reviewed-by: Marc Kleine-Budde <mkl@pengutronix.de>
Signed-off-by: Marc Kleine-Budde <mkl@pengutronix.de>
---
 drivers/net/can/dev/netlink.c | 10 ++++++----
 1 file changed, 6 insertions(+), 4 deletions(-)

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 10e7ccaf40fb..7f597c975c6f 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -791,7 +791,7 @@ static size_t can_pwm_get_size(const struct can_pwm_const *pwm_const,
 {
 	size_t size;
 
-	if (!pwm_const || !pwm_on)
+	if (!pwm_const)
 		return 0;
 
 	size = nla_total_size(0);			/* nest IFLA_CAN_PWM */
@@ -803,9 +803,11 @@ static size_t can_pwm_get_size(const struct can_pwm_const *pwm_const,
 	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMO_MIN */
 	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMO_MAX */
 
-	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMS */
-	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWML */
-	size += nla_total_size(sizeof(u32));		/* IFLA_CAN_PWM_PWMO */
+	if (pwm_on) {
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_PWM_PWMS */
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_PWM_PWML */
+		size += nla_total_size(sizeof(u32));	/* IFLA_CAN_PWM_PWMO */
+	}
 
 	return size;
 }
-- 
2.53.0

