Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDBD82F84F
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780748337; cv=none; b=MKk1S5O8PCyPJPeKSY2TiyWsbXWA1xtmoLFfu5yiUE700ZCzC6efKNkdlOjsTYAfexTQqO0QwCmjnTHXOc1RuDSw3r9k66T/UiKnGHuS1BZVc+GfUuV5k+fpCuxqnmI1f2/vJSCOX4Q8BC3amsuVUwBgdf+SOL8zvY5JsGrcpxw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780748337; c=relaxed/simple;
	bh=o0Xte+fvY7MtY5HSw1CiuUoYDI0tRjkz/tfTBkV37C8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eRsuXs3ic3siepDV/XbF2nxaRvR04SAf7hcmrJhw/3RvctHYuTPnkjYT/L39yccxcm45xG/zKwU97sTSZ7uENE/zCjFzshWeb0r/Xj+ir1O3RF35LloRmouOfUg3XnWfp51yIg76hfwI7XSmmiB6RbNWFqbCw61ASmXqCgET5VY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GhCS6pF6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GhCS6pF6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ED32E1F00893;
	Sat,  6 Jun 2026 12:18:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780748336;
	bh=OHaM/3e9zBDhNGumGSfKxuu21SKnSYTlLALsMKy3ztw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=GhCS6pF6TiGRTxYBaiJbjGl81xqg0i2Zpvccx8t2D7+7MLx7PRvoKMn7Q2+8Qi1qX
	 l8pfcVkaZZ9toBjYXZfUAx9bmKgx6TSLncrbedzNauSzKxHtx6qTKhHvZt7UZKovaD
	 6tgIWS2siQIJvTxE/KPpIhXaJBId29UXdIzygUZ70rv4VuPi/WcOxOuptaXdWg3V4B
	 d11d885OUUkauCZKHct55Dhq0k5bxMT5zRASap5O4I+NijQo28GCFF1UTE0foe6TWJ
	 ex/2mDB746xg/ifEWKUd/7XM6eGNXL9ABSEq74JLjGPmbi8lmXrNZnTSrFN4+AQbwN
	 ZN+8u7bhDnMJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/3] tty: serial: qcom-geni-serial: remove unused symbols
Date: Sat,  6 Jun 2026 08:18:52 -0400
Message-ID: <20260606121854.2850880-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060451-antiquely-coauthor-6f4d@gregkh>
References: <2026060451-antiquely-coauthor-6f4d@gregkh>
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
index 45010c77fe3a63..c9e11eeef47123 100644
--- a/drivers/tty/serial/qcom_geni_serial.c
+++ b/drivers/tty/serial/qcom_geni_serial.c
@@ -38,20 +38,11 @@
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
@@ -62,12 +53,9 @@
 
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
@@ -76,11 +64,8 @@
 
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

