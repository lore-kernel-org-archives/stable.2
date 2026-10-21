Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792586174;
	b=vCAaLtMyYDTOJY/Gwbw+L4RSFo+aasFnMK5CtNFZ5GOGlIfNpo5JNy29ni+nHTYGUcqC
	 FO2F/vGfQpb92+wHq9W0l5poqC4PPLt0Nm3yRInaNOCYXrUmKMZOF3N9ootVoWAR8IY2n
	 d94iiTlOSaVulrp0mGL+uvmP3f3+SdGS9VyiNCskRml0wqTnQz5tshbR0k0e8OIKD8Nn1
	 lZ21YFIUBZniB+MJsR0e3v3cJ3ftnMaJ2SopqKGtUX7QdPGqO2ltEByqovcDukkWldfn5
	 ABcG9iuqQXx2TXkANSwu6WBrI2so8TeU1EJhckf+qdXJhfFvjd8oYN0/pDGRma/yO0A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792586174;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=R5LOcbdYihG0cSv9ouGbWCqMo0Q7GqUkqTqkwywYFuM=;
	b=zQ2w0Nm3xPtotLHmtyIb1VM4CgCKycQIJlJ3L+RnNqqZZ/5HYgU/DRQSaQPVpNDrHlZO
	 09xDzoY8uBAMZlSuS7K9zIdreW9voQCCSWPZ95RvVn+C3yilNIcl9UgC0uLHUCzHP0HGS
	 LhQmRAQwBHyvbptXwowyJOAGTSzu9stimrMdvulCvXBvcRahweCYEJ/vd1TaTzw9i2UtE
	 WFdVjHltyd0/WVAdIoyYe/xKiZdUgP59/cGOUqSw+Wspa0bLQxPQiRKlv+OGO75ial61U
	 2MeAPhfO+foXxB/YVT2IRtCTIxyT/YCU6rS7Y4s9fmXM2hy6Qq6UCJj9hNwvvgydFQg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVpgFknD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 53636606C00B;
	Wed, 21 Oct 2026 12:36:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MVpgFknD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CBE5E1F000C4;
	Wed, 21 Oct 2026 12:36:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792586174;
	bh=R5LOcbdYihG0cSv9ouGbWCqMo0Q7GqUkqTqkwywYFuM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MVpgFknDthVL6Jjz4kJo3FFQwIDao40alAovPfyDPxD7XdVS0EY731e8ph1aGYic4
	 WN6r8K9qjzZdadgEJfEm+4d6LgK9MeRfE7M1xjcy7GDokUsLy7NqxE1TFmZO+bbLTd
	 vY3UNB5iEMlfOR9obd/sukMZpVGTpLOf1W80hzz3JT9Z9vUazxjkmQy7JdGFV/Y1kQ
	 RaQ0nF+43lv6f4Pj8ISgCxEZACKHI/VTDuWCC1jZ3Z+DgeF+dieSVHIWcngmTrxk0X
	 jTjkROJIpDz7Bk0J1aNUAyfgiRhQAgliM3T413hARwBSkRTlWEX0OKNzTCO3I/4J4W
	 NuHtE5Kygxriw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Pavel Machek <pavel@kernel.org>,
	Daniel Mack <daniel@zonque.org>,
	David Rivshin <drivshin@allworx.com>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 19/21] leds: is31fl32xx: Clamp channel current limit in is31fl3293_reset()
Date: Wed, 21 Oct 2026 12:32:28 +0000
Message-ID: <20261021123406.3163547-20-lee@kernel.org>
X-Mailer: git-send-email 2.56.0.218.g1ec904b173-goog
In-Reply-To: <20261021123406.3163547-1-lee@kernel.org>
References: <20261021123406.3163547-1-lee@kernel.org>
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

is31fl3293_reset() uses max() instead of min() when comparing
led_data->max_microamp against IS31FL3293_MAX_MICROAMP, ignoring any
lower led-max-microamp limit configured in the Device Tree and
overflowing the 8-bit current level register if a larger value is
provided.

Clamp led_data->max_microamp to IS31FL3293_MAX_MICROAMP when specified,
falling back to IS31FL3293_MAX_MICROAMP when the optional property is
omitted.

Fixes: a18983b95a61 ("leds: is31f132xx: Add support for is31fl3293")
Closes: https://sashiko.dev/#/bug/linux-878f32ad-ca35-4759-a194-76fe03caee21
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/leds/leds-is31fl32xx.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/leds/leds-is31fl32xx.c b/drivers/leds/leds-is31fl32xx.c
index 285085d27453..aebedf8b2f4b 100644
--- a/drivers/leds/leds-is31fl32xx.c
+++ b/drivers/leds/leds-is31fl32xx.c
@@ -194,7 +194,8 @@ static int is31fl3293_reset(struct is31fl32xx_priv *priv)
 	for (i = 0; i < priv->num_leds; i++) {
 		struct is31fl32xx_led_data *led_data = &priv->leds[i];
 		int current_level_reg = IS31FL3293_CL_REG + led_data->channel - 1;
-		int microamp = max(led_data->max_microamp, IS31FL3293_MAX_MICROAMP);
+		u32 microamp = min_not_zero(led_data->max_microamp,
+					    IS31FL3293_MAX_MICROAMP);
 		int current_level = (microamp * 0xff) / IS31FL3293_MAX_MICROAMP;
 
 		ret = is31fl32xx_write(priv, current_level_reg, current_level);
-- 
2.56.0.218.g1ec904b173-goog

