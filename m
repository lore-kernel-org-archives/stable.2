Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794397785;
	b=kxrEoUn47ABaq+0vTTuBkO/t93KVgUSoI7oVnBU3GwqPde0RQPRve9mhY8Fm1VKsJ5X5
	 CAxI8A+EZ1UexLSCXNfH3u0+k53zIDxJtYkdGMQr3kjdW6eT02urgltsKmNkdhUj78eVT
	 pOCCTWK7CeRB6dI4bFW9OP7mn/049KYLkFHqEk9YkV13Nb3HEoIAl+GdbuJL1N3vcJQL1
	 2AdPJGKv0qZd1pA+uDxwHShJGAcaWe4hgbawYYblvrJrh9RgprOJ7AkA+AOyTM/5ahaMS
	 WiNCoXzBnJ09htiokYGiYmmfWV9MhdcoV6h61U52mUZlEcd2bxZgT9UYeCk4CnKq30Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794397785;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=jO0VjvUkoXke5VYihliU8dcf5tAfDK0cqhQxSUbr4I4=;
	b=QUhcJAw32nYjen2e92x0bmOF/77iEzgKQ8Ak94DvBSf9OewBP8cv+5GZkWcsJonYrffu
	 k6ml5036zIYsEVnbX7q8J+RWem0fpPU+fx+N5xxdPofb58vfpMsaweh/vDyDDRaqIwghq
	 xKYw/zlDwVOI1M5nMZj1zMpcQUconMf1VM75JTHrhfloYPA2oFL6iqWHFvwTLZEkI0Aje
	 uIespbr8bARLLr+27ZNzNxJHZT9+y8RKH/5mUTLgXvot6rKfUDv/KrH2v0RKpCEG4NWUg
	 FLymSRyzGB3Efz3BoScFvDXy9PLpfpxMkS/n39dcXGc57VNQwV7WA6izyxBXA2rNygQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CI5THnCx;
	arc=none smtp.remote-ip=209.85.221.49
Received: from mail-wr1-f49.google.com (mail-wr1-f49.google.com [209.85.221.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FCBD606A326
	for <stable@vger.kernel.org>; Wed, 11 Nov 2026 11:49:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 8FCBD606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=CI5THnCx
Received: by mail-wr1-f49.google.com with SMTP id ffacd0b85a97d-48e20ed3b9dso2725286f8f.2
        for <stable@vger.kernel.org>; Wed, 11 Nov 2026 03:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794397784; x=1795002584; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=jO0VjvUkoXke5VYihliU8dcf5tAfDK0cqhQxSUbr4I4=;
        b=CI5THnCx9XHPclhLPwF+qhxFNve7iO55qXN6ZeydaXGA7rrp4RHQPgx0ZTCGaL22CU
         dTjyYelltz9wk6HtVEIsn0OA2ruDBC+XDnxoyg6vRxET9ZH8ILgBrGyWrguecPkxKzvD
         bL9JlXWROMq4CDaKThyGwLsg98zk2F4HwpNvFXyhpFp3tAWBX7mPogFw3ubbn2YP8qyI
         kaQaMrU9ztB55Zt01SyeeF0qi7IteQgWldgKVTV1l7aZ5+dKVGsWtDRxSNBMccgf6C6L
         LOcmjz//kyFCQtn/RrO9BJbeLVYTPofalS02+CFzdRgbwCPRsbKk4yBw7WfdOHG0E3Ps
         crkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794397784; x=1795002584;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=jO0VjvUkoXke5VYihliU8dcf5tAfDK0cqhQxSUbr4I4=;
        b=b8sXOJY+SrNP0fC3VErp70VW/onChhw8qjTkkTKQ06jZFn5NiBJvYFyKWtuYqRGfl4
         PvxzqH2e959EQYC58XaJigpY1WgGbmTBlVl9cefEy9+o/qOQ/4CbXFaKZrcgFKpzN163
         A/L9A6lj8uS7mnu4e69mdvTGWR41gFb0VIqW4gL5TgJEPqXTZfkIDmikq+c5yfjPQfr3
         oSDTp3jmVMSA6l2OQAOV0U+6TvdJWjh1xE5+AONq93bVwMLH3GfJRPWooaGAOSqIJYk5
         I6LC4Ukx4LFwjym7cmEFwS2OVw8/hyQXkBGjA+YwAh9prp8j/U05zCMB4abLfQuPopRl
         FOcA==
X-Forwarded-Encrypted: i=1; AL+hErG1zZO8I/kaq0aMUeKU0rX0Aj4Bo5D7I1x3/PWErCDAOCK+TkNhHQnb5esr9U2ugLgWm3Nwc7w=@vger.kernel.org
X-Gm-Message-State: APuU4Z+Rockh+rOpnhg6wMHY1RXYvwbwhS76sv66Ub5l+Urb7daUqRM0
	oe4sIUFJx1w56Dw5BBV8gku80QRpuizhzfM1DVAOPtSBqA5l58ri0mo=
X-Gm-Gg: AYBFou3+6VUhpwVdQlFmQNOsa07U7xTACIjCKOitWP3I9XTh1ifO+FL+GiwltjK1Jsy
	6RyzZRbnyaweEtSNx8+b73pAoAjkHmPVQXwMjTWMlQv86A9nNkIir0LyF6oFoOPennzLi4hdlPb
	IHfMg29swGPy7a4SkqkDYHMBkRLbN3iNXQc3Q3s85wszSbxEMsUX87JycgZ24rh5cf6YP3BV5kU
	XWoSYwbj/sFvb+G2uY/icdCM5O4MVF/vLsiWeIV+DEeQl96ac/UudX5SKoWXc/1EeIUwpYb2Uh0
	NFuQ5wJW99G/KGZDZxoNDyBBpMVfWCt/+5yHCB0Br+683u1GJC9a90rylo0BFHX3oXJwyjx1RoV
	BP2sOPQpsYYsHhWg7G3DEPmthc9kCj6PcgZ0o/C12Dps5xh2P7zeZrGkZ9dKB5mTsV3cyQwQJk7
	5gnK0PDjbnN6EzxPrcC792gg8qa5XBd388LuSoXMCfYYP7dzHW4hjVulnI8DWS+emFqiOJjGXbt
	tJlXPykmb0WU9aLbVks7JWUqBzalw/8J7nktrS3lwzzqD5uFs/Ch0iAP5dBfFRmfqjQN1t4h5zJ
	LzybOSEdtEEBpvfO8r8TnxgTAA09hYwro/7F
X-Received: by 2002:a05:6000:387:b0:490:6e0f:a02e with SMTP id ffacd0b85a97d-499c69cae59mr3687287f8f.17.1794397783745;
        Wed, 11 Nov 2026 03:49:43 -0800 (PST)
Received: from localhost.localdomain ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-4982eedfb36sm10789106f8f.0.2026.11.11.03.49.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Nov 2026 03:49:43 -0800 (PST)
From: Tristan Madani <tristmd@gmail.com>
To: Oder Chiou <oder_chiou@realtek.com>
Cc: Liam Girdwood <lgirdwood@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Tristan Madani <tristan@talencesecurity.com>
Subject: [PATCH] ASoC: rt5668: initialize calibrate_mutex before first use
Date: Wed, 11 Nov 2026 11:49:19 +0000
Message-ID: <20261111114919.95639-1-tristmd@gmail.com>
X-Mailer: git-send-email 2.47.3
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

From: Tristan Madani <tristan@talencesecurity.com>

rt5668_calibrate() is called during i2c_probe() and takes
calibrate_mutex. However, mutex_init() for that mutex is not called
until later in the probe sequence, after the INIT_DELAYED_WORK calls.
This means the first calibration locks an uninitialized mutex.

While this works by accident because devm_kzalloc zeroes the struct
memory, it is incorrect and triggers warnings with
CONFIG_DEBUG_MUTEXES=y.

Move the mutex_init() call to before rt5668_calibrate() so the mutex
is properly initialized before its first use.

Fixes: d59fb2856223 ("ASoC: rt5668: add rt5668B codec driver")
Cc: stable@vger.kernel.org
Signed-off-by: Tristan Madani <tristan@talencesecurity.com>
---
 sound/soc/codecs/rt5668.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/sound/soc/codecs/rt5668.c b/sound/soc/codecs/rt5668.c
index cd6245d6b91af..6748bcc63ac39 100644
--- a/sound/soc/codecs/rt5668.c
+++ b/sound/soc/codecs/rt5668.c
@@ -2490,6 +2490,8 @@ static int rt5668_i2c_probe(struct i2c_client *i2c)
 
 	rt5668_reset(rt5668->regmap);
 
+	mutex_init(&rt5668->calibrate_mutex);
+
 	rt5668_calibrate(rt5668);
 
 	regmap_write(rt5668->regmap, RT5668_DEPOP_1, 0x0000);
@@ -2547,8 +2549,6 @@ static int rt5668_i2c_probe(struct i2c_client *i2c)
 	INIT_DELAYED_WORK(&rt5668->jd_check_work,
 				rt5668_jd_check_handler);
 
-	mutex_init(&rt5668->calibrate_mutex);
-
 	if (i2c->irq) {
 		ret = devm_request_threaded_irq(&i2c->dev, i2c->irq, NULL,
 			rt5668_irq, IRQF_TRIGGER_RISING | IRQF_TRIGGER_FALLING
-- 
2.47.3

