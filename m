Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794290531;
	b=G04POt0+Wm3pBeA5o7HC3knObvbPigzRitlHFbmDKbmboAHKK3AOo45ToQfyNQIIeg8X
	 VeyhmH63218cRpAXrRQAChUI8hbGYOwhlkEqVyf7Owl5fjoUtJPdGG6igb4YQ2tvFxXbL
	 N1gmcOGgCci1ZsGfZdHxHhgQkbszmDcBN4vsCSI0kZaX18Vuv2T6d3YRG3fZPOZxX8BIc
	 DJBFBhwqWlFXExOU8mQdFk98KY+pJDfn8Hyu9fW+EIZXNXbMmyGGvD3xu6sUkwCRbj3vG
	 qrgOI7+zfSLyxKTbFGLvaIpgPfmCAY8k78tcUwq3OvWNP/QqbuBHsSrj3hZWz0e6yGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794290531;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=vRhasezVNnrWan1kXYHAiEmT2+w32w47JaWG93kEhxc=;
	b=paEUQY8zN1w+i3Ok2VHh8w/pp7SmZsqTZHFKPD9veXZ4OR69TUxahgtLpnUt6c51swRi
	 AoH0cUe0l7uZk+SjVXKdVwv3z9+u+DvvDa2KHJve/63ex3+kb5pHMoOiYHlAZqJ02yMr5
	 hFJ9WTfDrgkaqdMgV+igqPqJYBwlw+q4yxrTl+OlmAR8KbNz/FZmchvt2O8Qi5xYDAbeV
	 8RooLr4sfUlj6+qRlsXwrmCZrs349tv5fZItHPooy1jWC8M9faAdLLjEl6FnIyBUDC9nX
	 BhA2Fl9sYR5HoQH9r/12+rGz4wYXJ+L0CKyi17sMZhY9YG0hLvNCGd0bPvZPqbDWUKw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtRLL479;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13094606A31C
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 06:02:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ZtRLL479
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A2B61F0089F;
	Tue, 10 Nov 2026 06:02:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794290530;
	bh=vRhasezVNnrWan1kXYHAiEmT2+w32w47JaWG93kEhxc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ZtRLL479myPV84WJdFIJlmEvOmZpJqRMPOLIREaWlIA0YvAillrSp4m2tFZ8qRCcF
	 R4nVtGh5+kCD6ZR/HKzlldNklx+Sa/XQ1ZHZK9JI+nC5mEl37BNhO3ORyvhHbix/2Y
	 I/b4XxWoyvgMq4NonhUWyLYeOpxAYpPifUXo8oR75uLa4YxIE577l92tzb1aL+XyJQ
	 9y4BmoGTXATNc1p0mIDjXQEotS40ePAEjY/Vc3cmYcG772miUi21E7R5E/J5VD3m0s
	 3bCJ8+mU1uaIO8GphzdFhSatPezLAKIvJUlAhz9N5CRm856NAJcJ5sOCfFNAm6nzZS
	 LiYAQ6CDFbE1Q==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Judith Mendez <jm@ti.com>,
	Moteen Shah <m-shah@ti.com>,
	Nishanth Menon <nm@ti.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y] arm64: dts: ti: k3-am625-sk-common: Set eMMC clock pin as OUTPUT
Date: Tue, 10 Nov 2026 01:02:08 -0500
Message-ID: <20261110060158.485757-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054237-failed-6.1-8ef8a0e38d13@kernel.org>
References: <20261107054237-failed-6.1-8ef8a0e38d13@kernel.org>
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
[ sashal: Applied the change to the existing board device tree because the shared include file is absent. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/ti/k3-am625-sk.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/ti/k3-am625-sk.dts b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
index 93a5f0817efc4..201b7efd5e706 100644
--- a/arch/arm64/boot/dts/ti/k3-am625-sk.dts
+++ b/arch/arm64/boot/dts/ti/k3-am625-sk.dts
@@ -177,7 +177,7 @@ AM62X_IOPAD(0x0b4, PIN_INPUT_PULLUP, 1) /* (K24) GPMC0_CSn3.I2C2_SDA */
 	main_mmc0_pins_default: main-mmc0-pins-default {
 		pinctrl-single,pins = <
 			AM62X_IOPAD(0x220, PIN_INPUT, 0) /* (Y3) MMC0_CMD */
-			AM62X_IOPAD(0x218, PIN_INPUT, 0) /* (AB1) MMC0_CLK */
+			AM62X_IOPAD(0x218, PIN_OUTPUT, 0) /* (AB1) MMC0_CLK */
 			AM62X_IOPAD(0x214, PIN_INPUT, 0) /* (AA2) MMC0_DAT0 */
 			AM62X_IOPAD(0x210, PIN_INPUT, 0) /* (AA1) MMC0_DAT1 */
 			AM62X_IOPAD(0x20c, PIN_INPUT, 0) /* (AA3) MMC0_DAT2 */
-- 
2.53.0

