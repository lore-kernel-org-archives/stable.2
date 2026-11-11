Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794420533;
	b=uHNAh1vFlyUhXWh5DBguznTq6mZLcACaWi15EE333VzIXBIsUPlxOSLA/6zpQbqiX429
	 xn2ceicPKVjm+41r2AnKNcPksREFm2HX2OHllqcHy0JXPESVKpKQWTkZ30i2+3E2T/mIB
	 4ry23NFNzVOKZNGtr8KQg597PEzibq+SrXtuFFOELotSYjWnuPj3AjRYGOFOqIIMAKU7y
	 z9q6Ohl3qtd7Ajro2M93cxE38jDtawGlLSZgBKR53XsutI3YrT5PJptN+euj9FtlWffgJ
	 HgYaddiHjWmg6Jo9g64jXIH/zcRHuvi5I64ME3vo8hsSvWAnCRXpZkJRZyMjfQKgzFw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794420533;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=RRRD3mUh7XhQVkT6Xot58F7F7HEeQIy03BAyQk7oTg8=;
	b=F8r5HRAMHa7nbr3ZY2y3lvLk7S2SuUxBBCCVzglzwa4Ao5apN2pBOzFGhaIvbx5peL7m
	 fkdUuDgoPk64nI9LZoxamizmWj/aZHmfxl3I/p5fBhfrfLKPUKvDEESrDJu7/Qx9cpGDT
	 SEUsGB9wjLJraGO79FcSLz2PRVHw/Xyc3HkHLh/KtlAqr7+4Fqm8nxrzjb90ipytgdS3f
	 T39WG4ZbjRxct+WDFdAaDRA5oS5rs/gTyOhoJEy6iPdOk9SwJYERqsE83upLhWGB3w1+z
	 GsBSJdl6qsM3VT7l8Qr7Qg+Pe7hId1VB3Fu2NtsSLPIFpoz49aB+MB9P71l46gWYTYA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Rw/YO5T2";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C2C15606A324
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 18:08:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Rw/YO5T2
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB5201F00A05;
	Wed, 11 Nov 2026 18:08:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794420533;
	bh=RRRD3mUh7XhQVkT6Xot58F7F7HEeQIy03BAyQk7oTg8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Rw/YO5T2Ri4KaSSYqy8ZNGZK+m897De449byi/kiaobdrHLXbobOSf82brDSkqgnc
	 V/W4Gimv+UV9K1GRat7e4358BkV5C0X0j8DhdKtLlSoZ9A4Dxc5cBR5+gTeJ+8jK41
	 vyMpDkwqhZXkhaDn960hI9JobI79pnSya+GCD80QPUO862gBweYlEmXZP8tvOBlFVK
	 DIgaYBHoEWiRMw3cFVk5pLR6ZeDkpSrcNNy09kVJRH3lamhf7V2YyBUkh+cHKe2+Lm
	 Ly63XVaKlpUN+8I0k5z6vZEv0mdI7xQ94l+lJbFkgGoiWR1kP/hK1zfDyISLowUZyC
	 neubAPNKPOHqQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Takashi Iwai <tiwai@suse.de>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] ALSA: aloop: Use guard() for mutex locks
Date: Wed, 11 Nov 2026 13:08:50 -0500
Message-ID: <20261111180831.3732596-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107054422-failed-6.1-ded106036984@kernel.org>
References: <20261107054422-failed-6.1-ded106036984@kernel.org>
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

Limit the conversion to the four hardware rules needed by the
notify-mode playback fix. The access-control callbacks are absent,
and the remaining mutex conversions are unnecessary for that fix.
The scoped guards preserve the existing lock boundaries and release
the mutex if a hardware rule returns early.

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

