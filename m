Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794419732;
	b=D/iP32qECvAe2kwFCYCfA1Ii7femFiQDxKNBwB9+8WrwH1kHh8wwV6wiD/lUEe2KDiM/
	 FlCeaVw+u8c4EBT8jQcoJPEyGyAa/geN2GjLaZMqG8KOBEiuAh3mijyAISwXfS8MoKTp4
	 tF73faaxullnP0CDVoR+CUNISAdFxyXTQ5XALnp5U1SvMkiZYO/EUyY6BOMxx2mZwnIEP
	 YzDVFAKxjKA1RjWOqv8GdBGf0XlPsnrJN74qOzvDqKhJlIyYcC7JlDe+63pNCV0NUCBdh
	 mwIhwjhUSW5s2kh/4sD+6yPcjkREk9rZYzt8dl9bsxlRM1sVsM0uV1WO9MiHpQA2xLg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794419732;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=5GrS29ILD63NeMXZndo7EYTQZl+6hyODYBhjmmBMpow=;
	b=UpjvLZ0dq3AhduZ4Q9YBaYhN2p0begZLNXPQbQiGBaRpbaC6W9M5lIxf8VHxtua1Mkz4
	 qdkvK+9XvEIUSzb/nBjh7DMLzx1XSV7q61OKrAnJlC9Xa9umqwes5tW8skTX17aekwc+q
	 si04BnM67M2GVhDfdOpEGunY6RG3JLoBqS3wZ0FeLmJq9Yl6V+j/2kP1rige/8Ntd5+Ue
	 SRGlPcx48bROWrcjfnO2hOFBqjeRY9uYVcH6RzMD5mdADug3aWsN9YNeO56onyyt3LPnj
	 B+hWNfVYGfTcu7RndMCWoN9XqF1KwyE5FoF5/1g8CEL+z9mAEcDfWgriqMCoJtuuh0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4xtxRi5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0051F606A33B
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 17:55:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k4xtxRi5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B80C1F00A05;
	Wed, 11 Nov 2026 17:55:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794419731;
	bh=5GrS29ILD63NeMXZndo7EYTQZl+6hyODYBhjmmBMpow=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k4xtxRi5pvRN27NWaM4CNKks0SZh6m8CogOuCPG5uBOwvSKCjLGwAXXRY5VX1fP6T
	 Qly5bc2iiOwo0ZDGKTLPwDedrgAiqwu4+M+gE1oF7vYjlYfvIU3BrPlffaWqP7g473
	 ouc5yTolDsuhyk/8ebQutEhYdd0Gjik44zFPful1KykwSX89ekrUeiN9X2u/oyAsXB
	 rLUE/aDDSR6cKubR9BcEv0m0Cna8ipLMxOFH2ifooGRjkA0ub4HCBz97EB1GAcK99P
	 8u6bDc42hSqFC+ULI0QIAFqiuo/ZqYBWAcJwNO6XiU2LWSI5M4L1ZdAakpsokO+1Zq
	 b0WsjcTMwMdeA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] ALSA: aloop: Use guard() for mutex locks
Date: Wed, 11 Nov 2026 12:55:29 -0500
Message-ID: <20261111175508.3684835-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107053132-failed-6.6-ded106036984@kernel.org>
References: <20261107053132-failed-6.6-ded106036984@kernel.org>
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

From: Takashi Iwai <tiwai@suse.de>

[ Upstream commit ebd9b6c91d4e345b7ded4b56567c46267a45d961 ]

Replace the manual mutex lock/unlock pairs with guard() for code
simplification.

Only code refactoring, and no behavior change.

Signed-off-by: Takashi Iwai <tiwai@suse.de>
Link: https://patch.msgid.link/20250829150026.6379-2-tiwai@suse.de

Keep the conversions in the format, rate, channels and period-bytes
constraint rules, which need automatic unlocking for the notify-mode
early returns. The other mutex conversions are unnecessary for that
change, and the access-mode control is absent.

Stable-dep-of: ded106036984 ("ALSA: aloop: Don't constrain playback params in notify mode")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 sound/drivers/aloop.c | 32 ++++++++++++++++----------------
 1 file changed, 16 insertions(+), 16 deletions(-)

diff --git a/sound/drivers/aloop.c b/sound/drivers/aloop.c
index 9c7671f034d54..cc0c59232d61f 100644
--- a/sound/drivers/aloop.c
+++ b/sound/drivers/aloop.c
@@ -952,10 +952,10 @@ static int rule_format(struct snd_pcm_hw_params *params,
 	struct snd_mask m;
 
 	snd_mask_none(&m);
-	mutex_lock(&dpcm->loopback->cable_lock);
-	m.bits[0] = (u_int32_t)cable->hw.formats;
-	m.bits[1] = (u_int32_t)(cable->hw.formats >> 32);
-	mutex_unlock(&dpcm->loopback->cable_lock);
+	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		m.bits[0] = (u_int32_t)cable->hw.formats;
+		m.bits[1] = (u_int32_t)(cable->hw.formats >> 32);
+	}
 	return snd_mask_refine(hw_param_mask(params, rule->var), &m);
 }
 
@@ -966,10 +966,10 @@ static int rule_rate(struct snd_pcm_hw_params *params,
 	struct loopback_cable *cable = dpcm->cable;
 	struct snd_interval t;
 
-	mutex_lock(&dpcm->loopback->cable_lock);
-	t.min = cable->hw.rate_min;
-	t.max = cable->hw.rate_max;
-	mutex_unlock(&dpcm->loopback->cable_lock);
+	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		t.min = cable->hw.rate_min;
+		t.max = cable->hw.rate_max;
+	}
         t.openmin = t.openmax = 0;
         t.integer = 0;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
@@ -982,10 +982,10 @@ static int rule_channels(struct snd_pcm_hw_params *params,
 	struct loopback_cable *cable = dpcm->cable;
 	struct snd_interval t;
 
-	mutex_lock(&dpcm->loopback->cable_lock);
-	t.min = cable->hw.channels_min;
-	t.max = cable->hw.channels_max;
-	mutex_unlock(&dpcm->loopback->cable_lock);
+	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		t.min = cable->hw.channels_min;
+		t.max = cable->hw.channels_max;
+	}
         t.openmin = t.openmax = 0;
         t.integer = 0;
 	return snd_interval_refine(hw_param_interval(params, rule->var), &t);
@@ -998,10 +998,10 @@ static int rule_period_bytes(struct snd_pcm_hw_params *params,
 	struct loopback_cable *cable = dpcm->cable;
 	struct snd_interval t;
 
-	mutex_lock(&dpcm->loopback->cable_lock);
-	t.min = cable->hw.period_bytes_min;
-	t.max = cable->hw.period_bytes_max;
-	mutex_unlock(&dpcm->loopback->cable_lock);
+	scoped_guard(mutex, &dpcm->loopback->cable_lock) {
+		t.min = cable->hw.period_bytes_min;
+		t.max = cable->hw.period_bytes_max;
+	}
 	t.openmin = 0;
 	t.openmax = 0;
 	t.integer = 0;
-- 
2.53.0

