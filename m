Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.128.43
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792963143;
	b=rkXOlsooqFxk7xzCG/Iz+n/qdoBigN9Xp2jTxZRjD9QzUZhKn/ungNOeZgCdOG1DyLZ+
	 zaHqW7u/+zZOjQxN2qNn+yAjah8WJkzLIuVw5y0tkad9yoKnceMlow8g2lzh9+YZmakjK
	 jmcOJsRu8cCehS1zwnrvk6w78sMr/WIQQNRulIAZfxZw/sv2NNmdmYXIDqdsRQ0PUMPDV
	 dIkgdaAY9neLII9pz2J90detICcAFdniBluZ5/f1O0l1Id+qdNLK+VQcxE4BmqXVTEUu6
	 h2IBSyOst4CCM1P1BcBxvki2DnsNvuYz5uW6WRJVERcYcuAlLxXm75ZURviep/d1OZA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792963143;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=FXGhUdMYFe84Q2exJIrjjzOzKvQUZFwJp2fh0+1LvJE=;
	b=332380JDfhWD4IXAAasxKz6i9GnCuNIEOnKJ8CSelEHXUZP1hdEsjwKWCA7XyKcxRdgR
	 Lb4LIAcz6XeJ2kkvj57ZL3HYqVSg2ExM/3vgodXVpEtTSVAlItg5gElH9M++otJ7Btd6r
	 sj6lMwkrfuZqesKllQU4PZkGNLuyEzeh9+pqXoA7JtLyQprBdV8e+CwChLk/+VuwihLZ/
	 7jVCzQjdcOhFCWD2NnkZYyaIlLzKBgeCm1waHlOy7bl61xJYIRW5DflKx7ZJ/uBadIj7Y
	 XXBuZ2fADciH1RdewwrZ+Tgi6RDh6+jkULVgQWDHQDCSTaoHkKR4UB3lggwJhq16Wmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qWvS9mht;
	arc=none smtp.remote-ip=209.85.128.43
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2FA2606A31A
	for <stable@vger.kernel.org>; Sun, 25 Oct 2026 21:19:02 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org B2FA2606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qWvS9mht
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-4a210470b49so18795625e9.2
        for <stable@vger.kernel.org>; Sun, 25 Oct 2026 14:19:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1792963141; x=1793567941; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=FXGhUdMYFe84Q2exJIrjjzOzKvQUZFwJp2fh0+1LvJE=;
        b=qWvS9mhtmyvByJDIHURYFkr/5eqn7i7qDZO2PVNtr0S9vOYi2ETj1lu6AY5XwBDA+5
         o0qgEhlJtFSMQGxXaH/Pe4i40Y02+d+26euInPYWFKl2BMV1zwyjD6tN6q/Z8wy4AEZD
         aw1JLpK94Yu6U4N24cH4l+o8kAAtZAZjAeAAXWzbjxNyy2J2Z5mp9UHyyVT6e/Nk1EmQ
         pzRTvRmtjguPq8FCdDvMPX5ljOcyq78kjH8QysSH5v/yhNjm4qD8KhbnV45/jmwD3X6q
         zUNJNJdFA3BYNaRPdm2zUWgq0ECjb5TxMZ4bQK8MN9rRCBVjf4pYXkCBHP8WhTtq8lLJ
         D49g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1792963141; x=1793567941;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=FXGhUdMYFe84Q2exJIrjjzOzKvQUZFwJp2fh0+1LvJE=;
        b=mW6idCynXtx+JgWOcrpA7pu8H3/Tcov1jJwDQD8RSfwGNEXt6RDFuOJW0V+b9Qu7Dp
         XZ5c1U4p/L/XV64WkKOCtcdbh5LhYm4NKffgkpfY+tzk9Xy2WWRKuM9ihPnxOvPRG1ud
         bUVCUlr+1z7D6JtTCn5GlUJ3v0rpIPkcRIratYrtUzXAYRwC9vho/tR9qmNoqfkwuwMP
         lPZheEYFLp9mN+AC8fGEyVg9WeNij806oALEC63O/7UFtrZumGYtI+uW8xQdBkt8tODr
         kUgnLg8Oe8ltJp5x52Od0UsK9bJmYYehFUXLhJzdrp4rO+O8rKNaVJ+vWQAk3dgjsgn4
         eC2g==
X-Forwarded-Encrypted: i=1; AKwUvByajpE6Z13nJPqsmJcsIzLhrSl4EAIoS9+pzWYqJpVjHkX6qnMI777GF6t4pM5u9Ndpv0km6rQ=@vger.kernel.org
X-Gm-Message-State: AFq9FYKc5yrZ/kFVfSCAeQAwNXaICuwvBHVGmA9/u4sDBOxjdi9CwXtn
	+6HBPpzIeY+E5YInIn1+cFJCzuxLqlrhMXsokGlvmks2Hw34CtgigXqG
X-Gm-Gg: AYBFou27o5/18IVrbycs40MStkgrtRlzJ6yKxXl9y7UlSf+lc7a0b5JJKu47q+z0wXF
	SWZED9kHqV5QDNr4cmykva5gZAHBEOve0WxKVxz38+hezziXvuAuAdTqiqNXp3/iExosUnU35gH
	kDYZoqJjmmV8HQi8DeeCSTY5cqw0YpahM/3XyqwYlvb74XkzSeSUUZRFg7MCHRy7vHOOCB5N/EA
	eq1eCKOAzwIu+QxLpYOSqDLN/C95GV1LpZs/5s5rfJIrVNLsvNT8oYnIICVcrbzy5GYFnI6DcGx
	O52vn27n3lVSgn4T6t6Z8iGnsYX2fJxPI0T6AEVNqGu9lb8v6PhbFvKDXltjAv5LEyYuFeCtRzb
	pPS2yc5UksKS+hrA4wqzPgeUvr+W2c8ofMmcbsTOTDwwr3dmI0ofOUeqLTgZTvnvzDD2Nxl6sOc
	TaHZZkRyQnT8WMqzNI8F43YPDWPM4uY9EqKjmdm7isveBNCaTS7gEvDrqNSVGA//m8kgxxdHb8x
	2rCkTGe+PPxBgni8RYFOgrDSQpTeVOhBGp+29X9b2V9ZmeRu3sOcMYkcvnDrgX3fct3CWh01P4V
	QImOKh8buFsmFaL1z0XpruZLtRDHYJB5RApRXqu4
X-Received: by 2002:a05:600c:34c8:b0:4a1:d675:b031 with SMTP id 5b1f17b1804b1-4a35ac99ba8mr99928915e9.6.1792963140806;
        Sun, 25 Oct 2026 14:19:00 -0700 (PDT)
Received: from dohko.chello.ie (188-141-5-72.dynamic.upc.ie. [188.141.5.72])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-48e3ebc3932sm13228574f8f.18.2026.10.25.14.18.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Oct 2026 14:19:00 -0700 (PDT)
From: David Carlier <devnexen@gmail.com>
To: Jonathan Cameron <jic23@kernel.org>
Cc: Ariana Lazar <ariana.lazar@microchip.com>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	Joshua Crofts <joshua.crofts1@gmail.com>,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	David Carlier <devnexen@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] iio: dac: mcp47feb02: reject out-of-range raw values
Date: Sun, 25 Oct 2026 21:18:56 +0000
Message-ID: <20261025211856.256491-1-devnexen@gmail.com>
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

Fixes: bf394cc80369 ("iio: dac: adding support for Microchip MCP47FEB02")
Cc: stable@vger.kernel.org
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Signed-off-by: David Carlier <devnexen@gmail.com>
---
Found by LLM-assisted code inspection, reviewed and verified by hand.
Build tested with W=1 (=m and =y) only; no hardware was available for
runtime testing.

v2:
- Use GENMASK() for the upper bound so it is safe up to 32 bits (Andy)
- Drop the Assisted-by tag, removed from the docs in 1e035297ffda (Joshua)
- Move the testing note below the --- (Joshua)

v1: https://lore.kernel.org/all/20261024214423.865635-1-devnexen@gmail.com/
---
 drivers/iio/dac/mcp47feb02-core.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/dac/mcp47feb02-core.c b/drivers/iio/dac/mcp47feb02-core.c
index 88bffbab0854..b5a2ac4a2e67 100644
--- a/drivers/iio/dac/mcp47feb02-core.c
+++ b/drivers/iio/dac/mcp47feb02-core.c
@@ -696,6 +696,9 @@ static int mcp47feb02_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
+		if (val < 0 || val > GENMASK(data->chip_features->resolution - 1, 0))
+			return -EINVAL;
+
 		ret = regmap_write(data->regmap, REG_ADDR(ch->address), val);
 		if (ret)
 			return ret;
-- 
2.55.0

