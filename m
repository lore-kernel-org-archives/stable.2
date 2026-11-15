Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1794736676;
	b=BWFcsv9mGkJR4psoQ6svMM5Cf0G6oQTAhYC88fJ8WvMvnlQbWbWGyQK22Kf2deoydwDj
	 Ly/rB/dtodaIv8ocOUW4M0wa6AhsUD+nw4Lj50I+Z13/hEAOuh7XX0T1WQ4b3jc/e2RkG
	 VD/QdSseAB0I4U/Z2O9LN8LMTPKiYuU5Uy/dxvDffJuesmbLi4cSK3HQhoQmBX2cGW/BS
	 KHx47EfWWDcI90N63E8eMNEGk96MojhfhnHhWgNMS45WO0+d03w6t2eYrR/UFgdEqbPZR
	 Nt3zauaqSKWviU1x9FxxIUxF9omrrFCg04T/JQUD2MMdKMt6TYycVVQPxbhTOeEIuog==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794736676;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:In-Reply-To:References:MIME-Version:
	 Content-Transfer-Encoding;
	bh=aPf4nWP/msnsObcEmYeM7UUyuMAGJkUfnjaCBIfLpmw=;
	b=R8moAkzzXUQTV60hgqGQkDVdFqSAqDJMcbiO3/LXH3Bn16cd/GitoGIXW3ouSbQw6qaD
	 yQr9NDyZbtW4hnp53F2QLEizngjKkdQs/6EgfTxhcqL8GBJik6nbvDlHgh160yoHZzFfp
	 yj3P7cezuxJwg93c8cZlreDkNKvyn64L5bVeZ0HRNJoLok3JlnqfbIzlSigtO0axwckVl
	 2XzAgX5X9PgiBuP47T81qPrBWe/n7czLVQ9my8lRBJ8GTm5LGRHP+4VgnJy6mmllpK6GG
	 8KKt9ROCFWZ17BYEiBrnpPrW6mLNpMSwEZCYJxeWWIG4XHTZWgin++DJXQ6sLtXhJZQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dmarc=none header.from=pengutronix.de;
	spf=pass smtp.mailfrom=pengutronix.de;
	dkim=pass header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=daDK35jL;
	arc=pass header.oldest-pass=0 smtp.remote-ip=185.203.200.13
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de [185.203.200.13])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7C4E2606A89A;
	Sun, 15 Nov 2026 09:57:55 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 7C4E2606A89A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=pengutronix.de
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=pengutronix.de header.i=@pengutronix.de header.a=rsa-sha256 header.s=20260414 header.b=daDK35jL
Received: from drehscheibe.grey.stw.pengutronix.de (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
	(Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
	by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id 98031205A08;
	Sun, 15 Nov 2026 10:57:50 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPf4nWP/msnsObcEmYeM7UUyuMAGJkUfnjaCBIfLpmw=;
	b=daDK35jLYErpRJFXDE0LTo2teGQ87nYoowfmOMnNdGhpm1sr5CA8cXm6XCfTzEn9D8K2/W
	pMaEff5pI2RFWIbF3CIOsv3drRjkVB7S4441WlYoH2WlN0UDgUgksLvnV/34yZB170h+gp
	7IMUkSj2cOu5hE7igHKlcP7XsfRjLETGdeXPkB6LykvjsZf59BqxHwskmSYxeVMa7S09Bx
	Ubeik1vjVMzpjA/zql8LMwfg8I/6jVNmm01BI5Q8k9KT8WmqZGfTPA/SE3ESLdNzqZ8XmY
	Tw8PmfcDY5chmjFdpAMv4X5RzM5wK7+70RxQg8k1SqDVRFxyWKuvZIxsxyj9Xw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=pengutronix.de;
	s=20260414; t=1794736670;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=aPf4nWP/msnsObcEmYeM7UUyuMAGJkUfnjaCBIfLpmw=;
	b=GMteqbHVS3dtARIyr0zxsD+GuAZ5cz0P63zjREhUiyAqqfT6xGE1B3QM+bQoqTgW3HGplz
	KwmVdprUlzzsBGzHjsP54s2RwgSuqzmR7anwgAsfPm8Ijo6KP1XeEQrkXN/kBTuCMTPx4r
	fGjiL7hNijgxeIkVu+Cj52iK6+u0WyarNW2HBedl++g0BmN2IPPyXPNISBGtbjsWptSW8q
	EZxEvO7J+vSqwcp3B0oevQAxiNvoC+YliP5+fClxwdY7Kn1ZEfIAhyWfPTuOKhpbfCNqCc
	iYUlo0MtJHpp8TH2h9W/Lgq3ejBfbVstIOJ72g5rA4fjkg4esbviiqsAqt2DPw==
ARC-Seal: i=1; s=20260414; d=pengutronix.de; t=1794736670; a=rsa-sha256;
	cv=none;
	b=DkkbDeWPyeVu15C2liKP+9GDCcUUR0a0yAtyXxAMrOM1LJoX3LsluOIHTRSQc4SlQ2iNVb
	cHJV44mxidzVioj4C08cjqshtqW8ez01qqYkHlJdCYCE/5hmz5V+EE6HEseeVuX9qyFAUG
	iA92Oee+xyDjz0A2D7NN8bIvQA1Wj7cnoGrghVLr++VqFKK/XjA/2+OfK/tRYVWXP2GIwk
	R4B6SiNMULzgfPEstiOZBVZeBUFySsFwUNLGA5U2ehNoQ/NtB+kSlNk+5n/MJRGD9ilKDe
	kCFvcV+UCJfqEIbiv/zy5KY9ahFhmquYs97ckZJaS6o3K3CPDQvZTb/i5S5t5w==
ARC-Authentication-Results: i=1;
	ORIGINATING;
	auth=pass smtp.auth=relay-from-drehscheibe.grey.stw.pengutronix.de smtp.mailfrom=mkl@pengutronix.de
Received: from moin.white.stw.pengutronix.de ([2a0a:edc0:0:b01:1d::7b] helo=bjornoya.blackshift.org)
	by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
	(Exim 4.96)
	(envelope-from <mkl@pengutronix.de>)
	id 1xSWze-004GWQ-1X;
	Sun, 15 Nov 2026 10:57:50 +0100
Received: from blackshift.org (p4ffb23c7.dip0.t-ipconnect.de [79.251.35.199])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519MLKEM768 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(Client did not present a certificate)
	(Authenticated sender: mkl-all@blackshift.org)
	by smtp.blackshift.org (Postfix) with ESMTPSA id 32EF25EC253;
	Sun, 15 Nov 2026 09:57:50 +0000 (UTC)
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
Subject: [PATCH net 7/9] can: netlink: fix CAN XL PWM attribute sizing
Date: Sun, 15 Nov 2026 10:54:58 +0100
Message-ID: <20261115095746.709371-8-mkl@pengutronix.de>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261115095746.709371-1-mkl@pengutronix.de>
References: <20261115095746.709371-1-mkl@pengutronix.de>
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
index c0367c9e65f4..5a3c453a65a7 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -783,7 +783,7 @@ static size_t can_pwm_get_size(const struct can_pwm_const *pwm_const,
 {
 	size_t size;
 
-	if (!pwm_const || !pwm_on)
+	if (!pwm_const)
 		return 0;
 
 	size = nla_total_size(0);			/* nest IFLA_CAN_PWM */
@@ -795,9 +795,11 @@ static size_t can_pwm_get_size(const struct can_pwm_const *pwm_const,
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

