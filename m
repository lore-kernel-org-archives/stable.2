Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.221.53
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792878269;
	b=IMJZicxwq2cIuLtfYEQcctJn1psFuDzlrxpchdwwEZVZyOTTDUpdihr2gTW17YZuN1Ph
	 xqYpVuexso/URvGtTjEdj2LxmQzrpEiTE9jRt32VQq7YChOiIjBDCcZJXQwuzgzvyKrfo
	 KiJfWUbx7k1kqMydUzyvOPaLFCZlLZH4su8Bast990NE9bZ/8fI7ZcUTpancsjbnML6Iu
	 xhhyeJDRV7OJUw2LcbQWEkIrVViKR86GNFgiRrpR2NOnyYfltB5snPiA+pytBr7S+u7Lb
	 jcZDeyN+uVvc7X9Yh3GiFYv2NSfSX20JUlq9bUpqYk1o0avUfifiNwLDkDhpNAXKa4g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792878269;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=o9dLc90NOwCQ8gMqbMbmGkdZs1HGcCbm5itPdWqDFhg=;
	b=DT75h+NTSGcj5LxCcFz0kyUtIjhahhpymGsVJ3EIu+b9ZP2Su6K24zX5Q+NRwu2fAMK5
	 jQWCZhKdwwbZgSj5Gr0fldq68DJNdxvTuIcLXFTykLT35RfCnKxJLX9Jsu2D2xIY/nxRo
	 qNMAj/TKqh+2Ohg5GROApQuFjIBBVULkRG47FPmmffQXG1M/tipBcBCiP8S5i0eVcMiRl
	 jTQRr9y0A4BKdgdU/OZMFIZ2BRX/XxQUWxiI9NpGSOFFc7J8EmbBsZ5+D30z8ToaSumzl
	 V1Hd+IjFJSAIOE248jwr1aWPnrNoL5NLWHeohVjTyq8ocC6N1jh4bZsz+PFCQeRtU/g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F3vnlwLJ;
	arc=none smtp.remote-ip=209.85.221.53
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 61659606A31F
	for <stable@vger.kernel.org>; Sat, 24 Oct 2026 21:44:28 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 61659606A31F
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=F3vnlwLJ
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-48dee593f18so1426846f8f.3
        for <stable@vger.kernel.org>; Sat, 24 Oct 2026 14:44:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792878267; x=1793483067; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=o9dLc90NOwCQ8gMqbMbmGkdZs1HGcCbm5itPdWqDFhg=;
        b=F3vnlwLJxSQs9B3MUogpQhfEkXeXwkfpVfAWgu+HUDrbEJUoobOTEajYZL3MD1Mj6W
         7H31hNMbpYjyFA6tSGXQb/dnF3t9hxppaTNI9cOb8bH72RH+qC+D305nJ99gdGHxiM6m
         7OdCr4cclSTxb7xyDh3ZoUjxxx1Qk/grC0gv31SMkskBqaYENar9XhQbvJ5HkM1p74XT
         4AQrpYYpujsXPCCJiZztRrM/x3ANtV+HZvcyRtb8gqPThL+hH4hTLj5ZJrReTXvjA2u0
         t3VPV5P/WpRaYt6YSgoOD4DSpCDW0FpCNUzQhFIZ6bA3ScTkUrJrsLyTYf7NoAOLZzTW
         Tchw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792878267; x=1793483067;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=o9dLc90NOwCQ8gMqbMbmGkdZs1HGcCbm5itPdWqDFhg=;
        b=Wk75zvOWWvzTYMInOP6vDTWqmr0XZDyiH6ymhk8R5uhdWtnT0pWLBFvCxAKfIJxlw0
         Qe/Ec0Hbw5/Wt0Z1r7WsQOsCzghKdSmHrWhTw4JnJFWxQp5CEhEsaFFHhvk+ZrUeUooX
         LD8lc91vyNyit6aO0Vb86DIqGwyLcBoC3BuB5j7ZJzaDCBT2hWj4EFxs2B9ZkRh12vIR
         MVAwDWTGmwg3n8pjMd/6AfafyyLeayuCSPo0TTYqPX9EmyI/9cNt/J45pko0aksHz+hT
         Kw5ubglYrbG1vrNZ0qqZ9PHHd7iXKFtLXi4hvwO/r8ZTHPkMoJSdkfdvPI/puAmRxjoF
         pgeQ==
X-Forwarded-Encrypted: i=1; AKwUvBwxU5Z4i0ToN3waJZwrcJpgI24iGtS3ecMrqFyf0W3p43N9IX45HrpsS3HrpdRxPFxrFvgy0QA=@vger.kernel.org
X-Gm-Message-State: AFq9FYJnkwJHsSfVlXpCsOzE8pfCxILHUorF7bB8W+fZc3uD69jfYlZM
	C6A7T+PqqhYsP03QtHAxi+2c5ojuQHZA4Tg07dlfJaJ4Q2jsVcALHp18
X-Gm-Gg: AYBFou1JImVyPSLN+3QGIr+HGW2xB3YxcFo4Yjz8GNnaRY2W37e+0O5CGm3YTznvCpk
	oef4SVsY0x998Q6VLpvOZi3imafOtB7FNEaAWiVQKfE02fe5LHVsHxBgm2V7UW8oCh/qbMbOwuW
	lT2lLfKapvxTJ0yjJ0JxyVWGHV0pztfhCTEEABVsc4RbkKaV3IP1GlOurcN2ObYVdkERfrfdI4U
	DbFlGYe92p0x/Ce3QKiu7RwOswYItiuVkkHlpsLsixBrMm2jpGGr4M2LUYjTbBN3rXqasChMz1Y
	XEno3QOGJSZnSjIcPQcz1cJPblP2Tic5BZ7Tmq6ReqbMtecWxTLgjszogj35RcSPnZW7yd4zHdX
	r6ULHVBTkH3jNl9VuqRmZc9iu99E6D6Nz5cD4n149w21aU3x/ZB5+GPXevBiwmxgzT5sexsZEdK
	/CKug8DyUxWWCAcjLvP737mlqEuD9eYl3PdLzomJ0Aqqy+D06++jDrxXHGQ0IzSTnG8/r+vL+pl
	3WU6mHJ7FlpLsZRed71vc4FKWgHFoqpo7/yUwL8Lcl3hsCvJYeSsuHrJiV844+3SIZYIMeCYN8O
	Qrzi720n0lOqWOtAlLnoA42HXImOQixqq/pMj4zp
X-Received: by 2002:a5d:4743:0:b0:48d:f249:82c3 with SMTP id ffacd0b85a97d-48e3eb8b816mr3059620f8f.30.1792878267110;
        Sat, 24 Oct 2026 14:44:27 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3c5bsm6981411f8f.9.2026.10.24.14.44.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 24 Oct 2026 14:44:26 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] iio: dac: mcp47feb02: reject out-of-range raw values
Date: Sat, 24 Oct 2026 22:44:23 +0100
Message-ID: <20261024214423.865635-1-devnexen@gmail.com>
X-Mailer: git-send-email 2.55.0
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

mcp47feb02_write_raw() writes the user supplied raw value to the DAC
register without checking it against the chip resolution. The parts
are 8, 10 or 12 bit, and the bits above the resolution are not
implemented, so writing 300 to out_voltage0_raw on an 8-bit part sets
the output to code 44 instead of failing, and -1 is written as 0xffff.

The out-of-range value is also cached in dac_data, so it is written
back on resume and stored to EEPROM by store_eeprom.

Return -EINVAL for values outside [0, 2^resolution - 1].

Found by code inspection. Build tested with W=1 (=m and =y) only;
no hardware was available for runtime testing.

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: David Carlier <devnexen@gmail.com>
---
 drivers/iio/dac/mcp47feb02-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/dac/mcp47feb02-core.c b/drivers/iio/dac/mcp47feb02-core.c
index 88bffbab0854..1a0e80b5db87 100644
--- a/drivers/iio/dac/mcp47feb02-core.c
+++ b/drivers/iio/dac/mcp47feb02-core.c
@@ -696,6 +696,9 @@ static int mcp47feb02_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val >= BIT(data->chip_features->resolution))
+			return -EINVAL;
+
 		ret = regmap_write(data->regmap, REG_ADDR(ch->address), val);
 		if (ret)
 			return ret;
-- 
2.55.0

