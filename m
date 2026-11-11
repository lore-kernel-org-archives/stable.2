Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794416792;
	b=dx/f+gigZ5WVEk3Uqt5AiVOSZ5FUPlV9V7KOIhLRfu+2bzKalmpd+xkKf7Ta6Pd7loN5
	 f81phHW/T0ROTxTY6BNZzDwzHlFVVWXe2QQv9DMeeG5EjKRpSNXzHKk1AxfIkcEtgjkhe
	 +wdSCI29UGQFp+9+O2pa+mn45q/OR5TqRC1uEX4e/5KaqxgEK8PFMFMjcELs6htNHyyTE
	 EGUxtDBeEdidCE7hYOYDoEnFJ5QpqQ8UGtcnkTF468ebqfwY3iMxFernbZKHy+e3jZxW8
	 dvaKtYjjOFAouj5gSSKnUheZ5edpFh3wppt6hFTCdBlZJbVoW0pBGriQm9NKjqVXV2w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794416792;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Bg/Kgc6L7imsGE/8F9XOk762txfGaoS9sODIJYRJBdA=;
	b=sV1Ox9LUhY5RJ5XLu6oArJDz2vrN4+5UqkM91Rs90QB25WEJtDN/kckR+LAgZbt4T9Cm
	 qIUH9CoBN/RxGhSmcSnBzQK6TJtX9yUtyHxM7CQuLhXWxmdv4bbuNcPP3aT3B5d/Z2/U6
	 VZhZEq3XU0NhsuDXnzTvndYlperTyrVyZexYHBSezBTekOSQhqib0pqKylF+HZYc4PFxs
	 mDyuAcBfh9l7uumOM2msr0b2aSZ/TRsMgMjMtRdVtMCg0v+76Vh/JNIXrTAX5O01Xrgjk
	 nQKy8zngNWuC/4YlF2RkylcNH5GqXCIpB5GYYnQ1Udc+9LrLYu87ZqBwQWTypoS4nbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cuUU6TpN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84C81606A896
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:06:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cuUU6TpN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0F4111F00A05;
	Wed, 11 Nov 2026 17:06:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794416791;
	bh=Bg/Kgc6L7imsGE/8F9XOk762txfGaoS9sODIJYRJBdA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cuUU6TpN5MSE9MZg5F8SKgZHJLg+nBVUSaUALNmsRCsQx4h30uLGYePIGWEXnEHLZ
	 MQxwLARjGV8BW5+7QCNDgmn6/qIp+UPikmcjw2O6+VIe6FoLo9yGZlME6R5Wu8ZvOI
	 2lnPz1dABPwiaacV6xpoOL64FDdjXSaon0vqIiIpI5aM7yFbOuWXFDzK0OLkaFZVZH
	 9dJV+i2FSCgA7dxf15G+0Y9MBatPVOB0FDFDgH8S0NbgbshPbAKytjxRuW4uCRMvbn
	 +fgoQ8TOZpdyT4h/FI4cNHmNd1JRMZgIaSHVGXQ3kqapP1jXtJGV/Yp1HhbQa9/U+f
	 RYhln+MwZAYUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Miquel Raynal <miquel.raynal@bootlin.com>,
	Conor Dooley <conor.dooley@microchip.com>,
	Jerome Brunet <jbrunet@baylibre.com>,
	Brian Masney <bmasney@redhat.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 7.3.y 2/4] dt-bindings: clock: ma35d1: Drop CLK_MAX_IDX define
Date: Wed, 11 Nov 2026 12:06:27 -0500
Message-ID: <20261111170618.3423248-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261111170618.3423248-1-sashal@kernel.org>
References: <20261107050550-failed-7.3-1dc3871ce7ec@kernel.org>
 <20261111170618.3423248-1-sashal@kernel.org>
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

From: Miquel Raynal <miquel.raynal@bootlin.com>

[ Upstream commit 653738db38c7c7f0fb959a7870f9461cf4987825 ]

Drop CLK_MAX_IDX define of MA35D1 include. This is not a binding and
should not be placed here. Value is defined in the user driver.

Acked-by: Conor Dooley <conor.dooley@microchip.com>
Signed-off-by: Miquel Raynal <miquel.raynal@bootlin.com>
Link: https://patch.msgid.link/20260930-perso-ma35d1-upstream-clk-v6-3-48937ee6c9bb@bootlin.com
Signed-off-by: Jerome Brunet <jbrunet@baylibre.com>
Signed-off-by: Brian Masney <bmasney@redhat.com>
Stable-dep-of: 1dc3871ce7ec ("clk: nuvoton: ma35d1: Add missing WDT/WWDT parent clocks")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 include/dt-bindings/clock/nuvoton,ma35d1-clk.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
index ba2d70f776a6d..2d6a44a7e55c4 100644
--- a/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
+++ b/include/dt-bindings/clock/nuvoton,ma35d1-clk.h
@@ -248,6 +248,5 @@
 #define ADC_GATE	233
 #define EADC_DIV	234
 #define EADC_GATE	235
-#define	CLK_MAX_IDX	236
 
 #endif /* __DT_BINDINGS_CLOCK_NUVOTON_MA35D1_CLK_H */
-- 
2.53.0

