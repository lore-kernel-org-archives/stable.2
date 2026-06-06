Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D5BD527453
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 02:47:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780714032; cv=none; b=h24gZcKR7WVz3N+NFD3VfIgiq67jYVJt1ONld0UIxCtwrM6S8LOp1vY8KfbBOI/5uXfOvwyVXWHlPqXjFW1WPmphRPZczTVRmpB+7MfZhk3YBE5OokRPWsDVc7qBdfx1vjuwlKVWMeNe7zX5FYJ83SitHDf8mfyo5nKoP1Ix0iY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780714032; c=relaxed/simple;
	bh=TCQqZczXVkv853j4hNjD7RWMs/WggbA6s1oub4OFH7E=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=abt0mCc2JR//LmwhXLu3HWuuMCSNKpxH8cCYrSf41eVW9QFBELxFJe4chidlSL9Jdp0OLYl3Lajs3AbswdP5gxo3zpGBCkxb/usZc+a68O+U/oIbWnkeLt0j9NjHGgSRJmGDPE4lqa5bRAWlSa3h1LCbglirNV1+hMtVNWe+wr8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QNRA+BZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QNRA+BZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E1BC51F00893;
	Sat,  6 Jun 2026 02:47:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780714031;
	bh=rAA/KI3kWV34GQ60lzoLTW7FrgOKZlZz+MPA1Xoe8IQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QNRA+BZEscp5yflyYd9ujir96+lNCoAUW1hiWeCWu2D0iL9meDNnUEJt89EVIChxG
	 bR73tS1hqYpd+/bHqkdkEIJyGEDsQvpo0U8bLrZY0KiNNun5vgz2m6D1gxuPLZ9Nce
	 fDFc3alEXlo560xpblxb2JVWpUHMmFuaTEJ+OG+BQGTE9cLc+D6lP+TYe7dfc9/LST
	 a9Ofq5VgHtYcxx+97AT3xDuT0SgpBijwbbLUKoFW32lSYYwvIsehHS1qtoz8L6O9Mu
	 +pQgzYGbK+YcEkfI0x0WfHjQffLNDVgSfbMXpfik6xmyr0IvEBMF1xWVkqmmrIaLlE
	 N8oh0R09bUjuA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/3] tty: serial: qcom-geni-serial: remove unused symbols
Date: Fri,  5 Jun 2026 22:47:07 -0400
Message-ID: <20260606024709.2514691-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060450-emphatic-dictator-79c4@gregkh>
References: <2026060450-emphatic-dictator-79c4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>

[ Upstream commit 68c6bd92c86cbc4937834c79963b27c77ee3bf51 ]

Drop all unused symbols from the driver.

Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
Link: https://lore.kernel.org/r/20221229155030.418800-4-brgl@bgdev.pl
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: ca2584d841b6 ("serial: qcom-geni: fix UART_RX_PAR_EN bit position")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/qcom_geni_serial.c | 15 ---------------
 1 file changed, 15 deletions(-)

diff --git a/drivers/tty/serial/qcom_geni_serial.c b/drivers/tty/serial/qcom_geni_serial.c
index d6f682ed15811b..0dba8106792954 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -42,20 +42,11 @@
 #define UART_TX_PAR_EN		BIT(0)
 #define UART_CTS_MASK		BIT(1)
 
-/* SE_UART_TX_WORD_LEN */
-#define TX_WORD_LEN_MSK		GENMASK(9, 0)
-
 /* SE_UART_TX_STOP_BIT_LEN */
-#define TX_STOP_BIT_LEN_MSK	GENMASK(23, 0)
 #define TX_STOP_BIT_LEN_1	0
-#define TX_STOP_BIT_LEN_1_5	1
 #define TX_STOP_BIT_LEN_2	2
 
-/* SE_UART_TX_TRANS_LEN */
-#define TX_TRANS_LEN_MSK	GENMASK(23, 0)
-
 /* SE_UART_RX_TRANS_CFG */
-#define UART_RX_INS_STATUS_BIT	BIT(2)
 #define UART_RX_PAR_EN		BIT(3)
 
 /* SE_UART_RX_WORD_LEN */
@@ -66,12 +57,9 @@
 
 /* SE_UART_TX_PARITY_CFG/RX_PARITY_CFG */
 #define PAR_CALC_EN		BIT(0)
-#define PAR_MODE_MSK		GENMASK(2, 1)
-#define PAR_MODE_SHFT		1
 #define PAR_EVEN		0x00
 #define PAR_ODD			0x01
 #define PAR_SPACE		0x10
-#define PAR_MARK		0x11
 
 /* SE_UART_MANUAL_RFR register fields */
 #define UART_MANUAL_RFR_EN	BIT(31)
@@ -80,11 +68,8 @@
 
 /* UART M_CMD OP codes */
 #define UART_START_TX		0x1
-#define UART_START_BREAK	0x4
-#define UART_STOP_BREAK		0x5
 /* UART S_CMD OP codes */
 #define UART_START_READ		0x1
-#define UART_PARAM		0x1
 
 #define UART_OVERSAMPLING	32
 #define STALE_TIMEOUT		16
-- 
2.53.0

