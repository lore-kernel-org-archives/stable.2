Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795510698;
	b=VZIgdib2YyMeaPhOgA25cFhwFoW1IC8r9DfbllikK/jk7JDnTIL+FKgYjLJIYYvI5MQR
	 bjOFhwfs1QIx/WuuWS3MwtpJ+jmqafe+Sjmyp4mYTDN3YHXk7nZjZLdX3lTGU53Jx+cG5
	 m87l1RfCyEltBrGJGxHP+HjvlDxunVXIVnz4Zak7RpFYvdRkXO22TIAN7icDdS1XfDLwg
	 GbWXIVLfJcXnQPo/pExmLwHcazmjneGva0GLfBloaLhwrcDP7WXjcI+AKoGymKVf4+4R1
	 y8eKL9sMIAUsUY9+wOKKCFb4h+m7iNeaBjsGaVsqZ7H3z39Q9TwlVzd6q1EyqeLDQyQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795510698;
	h=DMARC-Filter:Received:DKIM-Signature:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=9zywkjszLE/9ltEvJUfp+fkwkpacqMgHzmbP6X2blTA=;
	b=1BoF/UghbWKGqBb6M5dk5MHz9FsVX+oWPEIFJYq5CzJyuQeNLOil8e0+Q5EXZDHD+DuJ
	 njYtoBSb8XEpcnhK5gseoEYaAXOF4FJx1fxXdbDT22n+VwGM2kajYWlsyqCYe4xkJu+cJ
	 jbV2pPOcMse4es990wyXtIVtBQdXl4Ux8PZpZ7Y9+gm9zFYHtRM8RVsV/v1/Dt1i8JDfv
	 +lRUeLWX1UDxEpTxfOCY+SuPmHw9lrbiXGTs6Ixxs7II8FGnwcYUI1YJW0bRHK9+rLp/B
	 F7fJE4w9iLoPksAUAJ7trBdRA8roo6JYNyYprcZodGCP7le74mbxnpOEmv+ea7hSaxA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b="H4/eYFgz";
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D33760A2606;
	Tue, 24 Nov 2026 08:58:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 1D33760A2606
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=H4/eYFgz
Received: from pengutronix.de (p20030102af17cb00d2e697ee776c6466.dip0.t-ipconnect.de [IPv6:2003:102:af17:cb00:d2e6:97ee:776c:6466])
	(Authenticated sender: mkl@pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 87687205A2C;
	Tue, 24 Nov 2026 09:58:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zywkjszLE/9ltEvJUfp+fkwkpacqMgHzmbP6X2blTA=;
	b=H4/eYFgzGe9BxNHfa1OcqQgwYtj6uyWtznZBsQgysvCcRF94/LwMNwJB78UiYApAMP3jSg
	7BnRffatWc4ZE0YTTurUiGAFSKUnhaG6GrE9+w8PPHP7HkhY7uXEdrS7IUsv8dDzOm9v41
	0dsGftkfRnvGvd7dgDvkbMFpLPaBPgwdaGz90YUJUdI2lcXBldMPnhMXqlwF4A+1QTtkvY
	6fpmsKgrbpbHGVraGEEc4WLmiYyMoAtYqE4Ew/fh15Kh65ZW0NiAoEa3WBrXyVo0OkhoEs
	lMw7Ck6wZNGurmuIik8i1rhF5Oz+eC/AR7JOhLl4PUoUERCRxwLQVKiPVKkdHg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1795510687;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=9zywkjszLE/9ltEvJUfp+fkwkpacqMgHzmbP6X2blTA=;
	b=RibEFsvNqI93Hqpk1gxRFRjEoQ8Yky2xEKNWK7ABkigFcmPRqztAxrpsv92XoNEioshV7V
	BbgcHCpCmoFE+Ltzjvytg9F57qPMv28NctPjioMFD6UaHWteR6kQeC7A2v8QW5PIIm0z5w
	SrTvKPnEnG8vLSI2y/Ur/JMzrOiNFedTafrU+uRmsPQzJIItuCrSSaKaMXip0RqXtoFzce
	M8CMl8FUNeL3YEEd4asAjZbYs7+/7xOfvuWuAjMoHECSP8neV3hayiKie9gxgwoGavUvl1
	yGsz1yNjCJhtyvkFSe8HxSavG7EkLChEVBoF0g7d7b0YAkLCRiWpcSPNUFvBZw==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=mkl@pengutronix.de smtp.mailfrom=mkl@pengutronix.de
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1795510687; a=rsa-sha256;
	cv=none;
	b=K+ia8J4/909k0Z6+Wqz1OxVBvYdBEGGrYnJkTLYTk3wq/Iu8MkWBt7zdAvjDLYpaOe62++
	ffcC37BL7/WfQIbOsGWXYvMyTtaB6BbBZbSrMjMghWtNOh4spWt1orcNGNk8F8AW664H2q
	DKwmkwgMekAmD35qX1q3CJC0QpZom05dvppp7oIdl3pwCF9a7w+gIjJN5ive/p83ZLttAj
	gl8ZNJ2JriOQWgHfVkXzM2ezSt5K+ObwEVDDulvyYtC1DQExE8ZOGR/8oURcK01ekInFg4
	ShSszEDpGEIzufu97IuUBSR+3t0ZGO15YzpEG+zau1Xb53wwVjeH43Ou5O+zsQ==
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
Subject: [PATCH net 10/12] can: netlink: fix CAN XL PWM attribute sizing
Date: Tue, 24 Nov 2026 09:51:37 +0100
Message-ID: <20261124085757.1093632-11-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261124085757.1093632-1-mkl@pengutronix.de>
References: <20261124085757.1093632-1-mkl@pengutronix.de>
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

