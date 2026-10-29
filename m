Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.41
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793309110;
	b=0aoJzf4bZnA1i+Ft3RQkuijz7BJnjqqhBm+7/PcUIlHq50JtMPZmZNAZfzKbZbo0uZKb
	 nTdziFJSBsxG8tM7qw3j5AV2BgyOf5umjwgXM8ZG40++Lh3snziSWRl25i9QSq8N/R025
	 obyjAW8NPqYP4uojYrYndwTYVxPLLx7HijfYTcZvZiEZo19+SJscIuNMvKBl73yXp4UxA
	 dJenC6n04nMPUYMbTGhXZZkXT67LwptCSXEbF/8QcCj/i+YG6TELAT1eMmj8ha5gmpjkt
	 ecHIhUQWiDrbmbSeDFoe5C3VqEJlxsHCbcoAcAFYy8I3dNTnbtK/0caJMR1oFueVW5g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793309110;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=1SuzwHSnhY9Y2jiz10v7EAdYBzQeXqjGVjeOmHpQR9s=;
	b=e7a16lYgTTBb7kA8793ttIE0F/8BrhWcwZmsfS49RAhO06cSi7wq+v096uclxN2Gtek4
	 6h9cxBOXQuXmKLnMIlAKkjnK7qkdi8Og78Ax8NTElx5KKt/zGRpq2Q7pgtEAatBHi7HYr
	 NX0OdapbXbhKVFMjpHG0Z1xaM1IGu32tTBKcidIYIzJVKhB9zI8qHfo2ZbdYxMmHmpE8w
	 LBwWYqwaN3j7pKHXt1gl2hZL+93/yA3zpz+qdRFV7+Zjq9eLLEbVRE4VFR6duS6IRtY83
	 UjLlKGwezRhwmY8NVcnZ0+j8K/zAyMclqEPutIpiPEBssqUsLR5zniYiPC7H9QtVYmA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0wNUcDI;
	arc=none smtp.remote-ip=209.85.221.41
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com [209.85.221.41])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865D1606A31C
	for <stable@vger.kernel.org>; Thu, 29 Oct 2026 21:25:10 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 865D1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=o0wNUcDI
Received: by mail-wr1-f41.google.com with SMTP id ffacd0b85a97d-48b060ec084so45029f8f.0
        for <stable@vger.kernel.org>; Thu, 29 Oct 2026 14:25:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793309108; x=1793913908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=1SuzwHSnhY9Y2jiz10v7EAdYBzQeXqjGVjeOmHpQR9s=;
        b=o0wNUcDIH7Y0/9J2mtVVORG6cqirZ170goS3FGW23LBVnh19o9i7YMzuYgQxA6pC/p
         IBlkh9HEhdwfkHvb+l+m6h36uiJZ+YYihW/YvLvWnuHhXpgC2xOXGaQQpkDcKVfnqfaw
         pDPzoBsZn33OhVEhbK6x45RysfrVqDCUFPeLsUzRheNOPHH2KuXjo1xajtBS8g3kXvDN
         GZ+hbo/RzEDAYfWiq4gbqns25XdDd3/oi3VWmIlTBFv1v7cmoSWOvMR9WbDkWEOL2nvq
         PCMWfeJcMfkwITYCFibpQC+rAwqT0LFvhKE0+GUF6jH6honHnLrqEptQWsZN9IffC3ej
         I/fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793309108; x=1793913908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=1SuzwHSnhY9Y2jiz10v7EAdYBzQeXqjGVjeOmHpQR9s=;
        b=kIwqt2VbMUO7Vpa8JRxVSuKJUKyUX59PZ7/9jZpO1iAn8ztjPz3/AoqhCEROgDZTDZ
         dB/F3KRn811ZVtw1FRjlalEPo1NQxxt1Ah2JspH67g2Jm3qfEUVuJ10fCjyzmCsFbYJ/
         JSlfiObGs8XYV7JUhB12KfVxoS956Rt8XYHeVOQKz9axBTEOgF4h2tXLvqzaQ8X38uXL
         S2w8zPSqnsxDECTNOpORO1a3RBW3cFKzouk0uHPnrTbFx5U4zmc9SisrZfxvOpx30Aos
         nyusUx125smqiKv3nhdAWeyojiuam2BkqdqjSWzo0j/H2XAmsGlBZY+VfXDK+GXlfBUN
         xt5w==
X-Forwarded-Encrypted: i=1; AKwUvByr9ZTpRW7OO0PjzUDeioMWaNNUypsSUXn3mh27umR1KFHFQUAC/+AqHHvp/ubsO4UHp1aOmgk=@vger.kernel.org
X-Gm-Message-State: AFq9FYKVN+ZoCJuBQaPtlAEF6tpx8F57zA3+pMN5CtnLUSz0+ZwbPWnZ
	IjdSF02TF2C0H9ppIUR+vQGkFT9D7Ln6xS2+T8hROlTHM4g8TkDiY98=
X-Gm-Gg: AYBFou0jeqBVdSwU/iDCNljcAyLDxxDNV8RmUUA2N66FNjqedMLD+y6qjFi5kxgSoYh
	wDtz1UvV+C5xuamOt7zlaD5K6vtawRlgG4U8HTZlP+AFqbGfMlVk/oR8JknSYDpfjtJpi51E24n
	mA7rOuRCdfVcsmXD2m0BChav6ohFTYLA6B51RGA2fNRzOM2R07i5RU1wW7rjCeNKmgVRL0g7eKd
	/+5TiDQNOcA/BtGWi1hLNEBblcxA3jb17JzLgxJQ5tDgGs2+qbzBT7aU2nSpp4vcwI8z/GKJkK6
	K1wGCDth+keN63jMcylS3reoF30CkIq7O2DM5xaogkVdZ9DKDw7zW1Aks5zPHtK65jfQoY6fjHF
	ETw6kPaTmeSXbO4uHD81b9piDp/BzPEpT9yZyDjhtlw/XSqzv+W2TDF9Y6znsWl0K7in4E7rnTu
	W0R0HZFImZ4OL+Xyj90z/pyZ4OHpG+nu8nczr9qH7CrV6h02Inq69vTI9CiIMKhnXmrL1LAuWzr
	95EwQEyd5vPInMj422Cu/O/3TMdD60o+UvGBgohcKD/Q7Ono/LShaR8yWlY+tUmh/YRctG1zA==
X-Received: by 2002:a05:6000:2f84:b0:48e:e98:8b64 with SMTP id ffacd0b85a97d-48e6e2eb232mr1243353f8f.19.1793309108442;
        Thu, 29 Oct 2026 14:25:08 -0700 (PDT)
Received: from debian.. ([2001:41d0:303:db6b::])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e6eb82584sm714873f8f.27.2026.10.29.14.25.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Oct 2026 14:25:06 -0700 (PDT)
From: Tristan Madani <tristmd@gmail.com>
To: Mark Brown <broonie@kernel.org>
Cc: Oder Chiou <oder_chiou@realtek.com>,
	Liam Girdwood <lgirdwood@gmail.com>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Bard Liao <bardliao@realtek.com>,
	Misael Lopez Cruz <misael.lopez@ti.com>,
	patches@opensource.cirrus.com,
	linux-sound@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 0/4] ASoC: cancel pending delayed works on codec removal
Date: Thu, 29 Oct 2026 21:25:00 +0000
Message-ID: <20261029212504.2997364-1-tristmd@gmail.com>
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

Several ASoC codec drivers schedule delayed works for jack detection but
do not cancel them in the component remove callback.  If the device is
unbound while a work is pending or the IRQ fires shortly before removal,
the work handler can execute after resources are freed.

This series adds cancel_delayed_work_sync() calls in the remove (and
where applicable, probe error) paths of four affected codecs:

  1/4 rt5668 - jack_detect_work not cancelled on remove
  2/4 rt5659 - jack_detect_work not cancelled; INIT_DELAYED_WORK is
               conditional on jd_src, so a guard flag is needed
  3/4 twl6040 - hs_jack.work not cancelled before free_irq
  4/4 wm8994 - multiple delayed works (jackdet_bootstrap, mic_work,
               mic_complete_work, open_circuit_work) not cancelled

Changes in v2:
- Resend as unified series per Mark Brown request (previously sent as
  individual patches with inflated version numbers)
- wm8994: cancel mic_work both before and after jackdet_bootstrap to
  handle cyclic re-arming (mic_work -> DAPM -> jackdet_bootstrap ->
  jack detect -> mic_work)
- rt5659: unchanged from prior version (jack_detect_work_inited flag
  per Mark Brown feedback)

Tristan Madani (4):
  ASoC: rt5668: cancel jack_detect_work on component removal
  ASoC: rt5659: cancel jack_detect_work on component removal
  ASoC: twl6040: cancel headset jack work on component removal
  ASoC: wm8994: drain delayed works on remove and probe error

 sound/soc/codecs/rt5659.c  | 20 +++++++++++++++++++-
 sound/soc/codecs/rt5659.h  |  3 +++
 sound/soc/codecs/rt5668.c  |  2 ++
 sound/soc/codecs/twl6040.c |  1 +
 sound/soc/codecs/wm8994.c  | 14 ++++++++++++++
 5 files changed, 39 insertions(+), 1 deletion(-)

-- 
2.47.3
