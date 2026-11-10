Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794289372;
	b=j1fCIsXa+/a9+UvTtAQceI6dpa6d6qgKXOP1LfboBkHgLdbPebkbA42/1lJfw3v9aTRd
	 RlsUEeS3vn5S+eqbpUw0iJuYz0nUGB9pAuMhq2JISOwFepN2Y+SqrvuzDgHvWQF9igj2N
	 tKPqCuxhNHCT/5WPd2qG5dU1xoeB7Xc6D2uoOZIf+syugJlz3FhYDScuu9VqfShIlVlQ4
	 ZEbBp7bNEiY6guucol3PM8P3RFFTCSlffydWkND9gCcx4j3pkCk+2PFUYJTSVA/fDEu/b
	 ZfsRowr1XBhlrmkXARRdwvaUUfdct/32hRXgTGmqKcTOkkgW2k1vAjdLxnIcY2wXw6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794289372;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=nxXHi64ngc/1nq7WESci6+cnwi+2DCIBb6QqLiLenq8=;
	b=dzPj2AjXY0v/EVAUQoZ2gjvsFFZ/B3jWnF9NpFD+NcVe+HR+Qtyek/hUsfRJZTEmPF0e
	 MXz/jXipD8dL5TnJgXm2YL6XgUpYw/7i6KkMq3cv/uG7YeYBhM7+i/HGpmcTGA/FD9Tzb
	 gLqGGUUWG7pVkyuOjRCVhArYUhsC7E3DmFwldl9e/xfyhkqU3d3KXnbhBBHpjd/0B88OC
	 HkwgRhMMck1qqp8PfAEzkbFkpHKoRpD7mCqWmJBGUFBA8kCZwODK5aFVDrLRpImFuTPkC
	 ym6uwq+Lzupow2QNCx8vpj/ApXkMv597KDUTH6Cb4GW5V5K8WvAa4jtAnDCxq5JS/6A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIZQwu99;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 81477606A331
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 05:42:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gIZQwu99
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7653F1F0089F;
	Tue, 10 Nov 2026 05:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794289372;
	bh=nxXHi64ngc/1nq7WESci6+cnwi+2DCIBb6QqLiLenq8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gIZQwu99fbHK0dAIViI5JtYVvGztxTCgsk2wsZyjSY5j4PFAZ7TgvoInsSvkwgH1c
	 HBuOZQtXtpM+nW62aiwG4ZfGpme9CP6qNdol4JCydXi2aixm5aDgbzxdi8KNOPuGiS
	 BJ4BVKwKpuf7gEhzbSFKemnS2woYicFGAhmjPYCu/2TqTRQRGvs2SE+ZFKP9w9I2NO
	 grQdOQZ0tdVX3QppXcp8IMAQJTGtPlUqMQ+/5p1Iy+Qy+nfIdWFMhGtexWXfwQ/6Ay
	 6GUHK/4svQQJh8CKmjZCAFxTWh5paFgmzHzDqBeMNRa9T3l0EiP8GrE7E7wNZ+dMp6
	 1NwdA0q7aDjQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Judith Mendez <jm@ti.com>,
	Moteen Shah <m-shah@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 3/3] arm64: dts: ti: k3-am625-sk-common: Set eMMC clock pin as OUTPUT
Date: Tue, 10 Nov 2026 00:42:48 -0500
Message-ID: <20261110054242.455209-3-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261110054242.455209-1-sashal@kernel.org>
References: <20261107051734-failed-6.12-8ef8a0e38d13@kernel.org>
 <20261110054242.455209-1-sashal@kernel.org>
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

From: Judith Mendez <jm@ti.com>

[ Upstream commit 8ef8a0e38d1377c6d51c06f95c64d87641b2c717 ]

MMC clock pins must be configured as OUTPUT-only per TRM [0] with
receiver disabled (RXACTIVE bit = 0). Change MMC CLK pins from
PIN_INPUT to PIN_OUTPUT to match documentation.

[0] https://www.ti.com/lit/pdf/spruiv7 Rev. C: Table 12-246. MMCSDi I/O Signals

Fixes: d19a66ae488a ("arm64: dts: ti: k3-am625-sk: Enable on board peripherals")
Cc: stable@vger.kernel.org
Signed-off-by: Judith Mendez <jm@ti.com>
Reviewed-by: Moteen Shah <m-shah@ti.com>
Link: https://patch.msgid.link/20260909214743.899477-11-jm@ti.com
Signed-off-by: Nishanth Menon <nm@ti.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi b/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
index a9e372e9feada..db85d354133f6 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk-common.dtsi
@@ -98,7 +98,7 @@ main_mmc0_pins_default: main-mmc0-default-pins {
 		bootph-all;
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
-			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
+			AM62X_IOPAD(0x218, PIN_OUTPUT, 0) /* (AB1) MMC0_CLK */
 			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
 			AM62X_IOPAD(0x210, PIN_INPUT_PULLUP, 0) /* (AA1) MMC0_DAT1 */
 			AM62X_IOPAD(0x20c, PIN_INPUT_PULLUP, 0) /* (AA3) MMC0_DAT2 */
-- 
2.53.0

