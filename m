Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 404181B4F09
	for <stable@vger.kernel.org>; Sat,  6 Jun 2026 12:32:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780749124; cv=none; b=NEPDLW3brvw7jQBRplabaT2xrslyL7K71NkC64VnIiXr8sNnNo9RBy1Y70gd+c5RzPHgiWSJQGHqr035c5NM8UCukOEizTPy2NROQpdMJ3V50LB+oOiG0FzSB6vKF6FUutPRxRSC/UL34H+GVfzdrbyXDLO00l1nUlS6XqovX98=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780749124; c=relaxed/simple;
	bh=3jnxulhg9MlRux2q1fPJkYbwPmOjsgMNq8Reyl36E8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cIXdFP9dZizpHf/nZ4BmOfB8bh8mt8MTjH3jvsypV1GXzNyAhRb3/wgMwfzsACJDqRq97YuVYzZqMzqiUkXLRl6N6BkUutyCQBLiOp2QjTqGJJGIayDmBqkSumuCbv1hrQX6Z0eMT4yxBcunv8lcm42mCiwVLxtziiYK1psNu7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iw2a2euT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iw2a2euT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8C6111F00893;
	Sat,  6 Jun 2026 12:32:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780749123;
	bh=FBHTqNkAv0UEcY3lv9xKZscqsvnoJQGlzug6GQ1Am8U=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iw2a2euTMFHsgRNJ+Hwy9nFF7KC2OqWeKcZzPONORI0d1udVVH6SyCrFjOGlgwGA3
	 pUeT/1TjaV7Tcd3O4r+JTftapMVIri/U9pMelXzX5Lzmyw9I0Hw+plslujTj98zL08
	 yFdfyDGyNza+wxVCHQLiZbqlJfdvmIG9TTfCALQbOOU87lb+VHMAiGrhwvZ9qBaotF
	 9kum45/cacWK8+G41kUTIpYjmu0LxAxWHL8EARVoOX8EkSJS0bMJBofj/YE+i/HYPA
	 nx58iuaQhzlfnwih+Tzjy+jqO9akKDdQtEUJIJhj/18wS8pFUuNLkkCL2hbPjuBnuD
	 aZgydF4Ks41Bw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
	Konrad Dybcio <konrad.dybcio@linaro.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/3] tty: serial: qcom-geni-serial: remove unused symbols
Date: Sat,  6 Jun 2026 08:31:58 -0400
Message-ID: <20260606123200.2861082-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060451-jubilance-margarine-a3fc@gregkh>
References: <2026060451-jubilance-margarine-a3fc@gregkh>
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
index 7caba23365c1c4..98226e84ac6249 100644
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

