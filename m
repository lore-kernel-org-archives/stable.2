Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794368196;
	b=igu+ojnquT8Iy3vYkabJlZ/RGxu2//B6sLkhmbi76w8fhqyTORie40Jh6rf6UitkGDiN
	 jFiNcy039vFqr3lu5grqafjMBd1yrDREG2DrAWtYwIEv/+T9TvDfitnfIkJMs6hMar2UL
	 Y2L4Yapq8y1EIIKUJQ2KYJ8x87gdwhXD4WIjbJvbnxiWU4AwDeW0Wx/571tcifRy+8Kw5
	 Z9TclLoWodoJflnSBcmffjhoneqTyL3IVJNv8AUP7rVkIHOycdyRm+z1nVU1RVT87aDIp
	 GbBqS2rf97jz/DTT+/jEqgYD38eVpfCmVlXUCy2GcvzDu9TO2NGfukKYo6Mhv872IjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794368196;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=+YlCBYU4pgZ/OuDSXNDp8Y5Rr4KMbnziRpXpv25dBYU=;
	b=yeWPLx7AIMX7U9fILzc/xLmWPEIuGkAlkdeoKCmv8PywI9CcsFH9ClZcd9wqzgtaAmcP
	 Lx31RgpsuhRKWeC0B8KrEB/9cEQ4aZhjhGP7OpFgEeGHI3z1M2JTHQfXr7iPNVxk1sHNF
	 Aw2V1YrcXPuyU3af6TI+7MU08SH5mceHyw/BvO5/YEYRNtQyzsiIx9R2R7r4jgXbuECx1
	 lEXl36mR8fvtJspfeURxM6jRR5L/HuNNygKbNZEDRYWHWPycDXXG6JCX+QfZmgVCmxq2E
	 kvckMawJBcLogHICljTtbihqIkDPtBamAUuRh7hmIpzaBVvABhYebiHr8W9MMEWepfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BClTl1eN;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78F41606A320
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:36:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BClTl1eN
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 832791F0089F;
	Wed, 11 Nov 2026 03:36:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794368196;
	bh=+YlCBYU4pgZ/OuDSXNDp8Y5Rr4KMbnziRpXpv25dBYU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=BClTl1eNP3UTcXkoO6qON6bB0EYTMiNP5uuO+OUKiVR4C3kj2qB0uxFcQDHJ6AB32
	 tSVs6Xxs5x9iV8t2WFTyOwDoKoVePlAZHdB6Ft2yaMWiWPzkxiAzDpBCusJcjTgOgn
	 zriOA1fgLU1tVzrrSdHn9WcUhHNjIxB7kPM4iFEQxcA9ImWLqwbCIRcYa6erZR4Imx
	 7sCE1nUwCYRlEEw7fZVGLhKIxPcrnySCXn0AYVWJ26mBaTwcXNw/tatQznvyN4op34
	 +5NDf3Xal33Nvvzso6QgoRbUuqMavsXFFbK7sExQJiUSpxucJfBXcbsdqELqm4jH8o
	 nkJptT5lOIUbA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Ridham Khurana <khurana.ridham222@gmail.com>,
	Guenter Roeck <linux@roeck-us.net>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] hwmon: (lm70) Fix rounding of negative temperatures
Date: Tue, 10 Nov 2026 22:36:34 -0500
Message-ID: <20261111033619.949527-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107061702-failed-5.10-eddb0aaacce4@kernel.org>
References: <20261107061702-failed-5.10-eddb0aaacce4@kernel.org>
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

From: Ridham Khurana <khurana.ridham222@gmail.com>

[ Upstream commit eddb0aaacce4baa9d8176eb2f4bd9e99e867f8fc ]

temp1_input_show() drops the low bits of the temperature register by
dividing the raw value (raw / 32 on the LM70). These bits are not part
of the temperature: the LM70, LM71, LM74 and TMP122/TMP124 always
return some of them as 1, and the TMP125 fills them with copies of the
temperature LSB. Division rounds toward zero, so a negative temperature
with any of these bits set is reported one LSB too high.

For example, the TMP122 returns 0xffff for -0.0625 degrees C, which the
driver reports as 0. The LM70 returns 0xf39f for -25 degrees C, which
the driver reports as -24750.

Use an arithmetic right shift instead, which drops the low bits and
rounds down.

Fixes: e1a8e913f97e ("[PATCH] lm70: New hardware monitoring driver")
Fixes: a86e94dc946d ("hwmon: (lm70) Add support for LM71 and LM74")
Fixes: cd929672a9ef ("hwmon: (lm70) Add ti,tmp125 support")
Cc: stable@vger.kernel.org
Signed-off-by: Ridham Khurana <khurana.ridham222@gmail.com>
Link: https://patch.msgid.link/20260924205326.1739229-1-khurana.ridham222@gmail.com
Signed-off-by: Guenter Roeck <linux@roeck-us.net>
[ sashal: omitted the change to the absent LM70_CHIP_TMP125 case ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hwmon/lm70.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/hwmon/lm70.c b/drivers/hwmon/lm70.c
index 6b884ea009877..a9e3b69075d64 100644
--- a/drivers/hwmon/lm70.c
+++ b/drivers/hwmon/lm70.c
@@ -90,17 +90,17 @@ static ssize_t temp1_input_show(struct device *dev,
 	 */
 	switch (p_lm70->chip) {
 	case LM70_CHIP_LM70:
-		val = ((int)raw / 32) * 250;
+		val = ((int)raw >> 5) * 250;
 		break;
 
 	case LM70_CHIP_TMP121:
 	case LM70_CHIP_TMP122:
 	case LM70_CHIP_LM74:
-		val = ((int)raw / 8) * 625 / 10;
+		val = ((int)raw >> 3) * 625 / 10;
 		break;
 
 	case LM70_CHIP_LM71:
-		val = ((int)raw / 4) * 3125 / 100;
+		val = ((int)raw >> 2) * 3125 / 100;
 		break;
 	}
 
-- 
2.53.0

