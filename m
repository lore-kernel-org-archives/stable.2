Received: from mail-pg1-f171.google.com (mail-pg1-f171.google.com [209.85.215.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 703093C10B6
	for <stable@vger.kernel.org>; Tue,  4 Aug 2026 14:15:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852948; cv=none; b=bQg45oaNgX1n3RuwhvdirYEte3A+dTFo/zQdiAF3qvSzAs2Txx0PFv+fXtBt8qVYOS5vtjPitP4FlC5tanHzHCFhzn2E/4AG0gJs0VO2hrHXN2GPFIR3wKyAsOqoQpfPiMya26RItz+1ji9i5QOJRFFg+TcFhc9i8czg4ljjJjo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852948; c=relaxed/simple;
	bh=tseOFkRH+VkKpLPw9eW+OguB+gLNud5Nib8WI23LXjg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=bjAjSjviB6lW5S04teBBAmKPqOd31bSqkUwXOJ3odrhniqUHxTqNE016kH5nq39yaF8ESXAmULIRAuj4RXWSGdPd0md8IPqiX1bdkUznfHOAhuvtp+GywsvJLs3w8ZbQStWjSnsgZDaFLs03j6u5+cKNMekCGo/a9npinpgy2ek=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Vv0Hh89c; arc=none smtp.client-ip=209.85.215.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vv0Hh89c"
Received: by mail-pg1-f171.google.com with SMTP id 41be03b00d2f7-c9e0b89e228so2539048a12.1
        for <stable@vger.kernel.org>; Tue, 04 Aug 2026 07:15:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785852931; x=1786457731; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=pkA8brq9aD3a7UhTDQ51dCKqynsS+dZa04GQD9wvAc4=;
        b=Vv0Hh89cNQYO/nUQIm9aGhNeLirmizlPEgBmX6wUNfZmsQYTOc8XKTMCeMV3J7aKQR
         tmXjwB5D48Pz2ujWFzzv1BsXBZanARX0FSVNP3IwV46mMu9Hgxnz0pYxXcPT1fLmC5zl
         Dge9noHfOzgvuvlODNCW8wb1G/x+f4VHU5xN6I6hAHUUzEkTK8s30Pto4jbeWSkwbK+f
         UA+Hqz/nQagvYHSoeEqxNfUQUllT0c04aaH3BlfL4a0a692t42yWhRJVE/qovszsWQe2
         VAMVbK8k/pIf3QHSAoBxyguKDer956kcbJYIxLubs4QDygjNnwM4ikTc/9nJzwGdJAWz
         YfAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785852931; x=1786457731;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pkA8brq9aD3a7UhTDQ51dCKqynsS+dZa04GQD9wvAc4=;
        b=UJbKoFC3RT3zEDXmxB2GSXkJUyzKAyhThPeAgmAqj5ZfGMoc050lADj5bqk6n1yZic
         UNhm+nsb2SPVxB3/1PZNgLXawS/1OqDUGVeWUlNw9/IZ2U3rAOai4NX1hNj3dT4Oxjn2
         JuV92XFPVh3hnhJ+Jm8YlrhjGpdcjsVCtyC5k2CgMe8+FImz8csA0rQ+ygWwmxFbdIPK
         yClZNQ16ESE2v7IrVmn53i5FLXq1kQTBim5c4BEoMT59JuLCtezKlpbjIkRNRaTvZXKa
         tX+xxbypAH1SGDCAjwDIcAbhzo69k2SRMa215ksrlhJsHpm1LQLmjijRN73gMQkF7cuw
         OSMA==
X-Forwarded-Encrypted: i=1; AHgh+Rr6YJyLZpBGmvf0GCT+dW2uIa6EUoMXthQxftX9z4ZC274AnhBWz4HVNds8rFvixFUBH7Tv1bM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxByxOx5/YWedDeUDAGr3NnYunxNclFmRTvVuQfZ71++do1WxvS
	D3zJf4sN2SilgaHCXEqtjF5m05ZUNYp8fYLaxAOCKa9IzmSpob5RpWU=
X-Gm-Gg: AR+sD106Wajsg9ZOmKdWKIhGW+y886ZFmpC9gg+wm4S0F/EAYGyu08woiY+EkdrmlKP
	ZIsYVpMYmswmw5+co2n+9DwJ1tY3pB1aZtamH12ww3RreEFlTEx0l3k85tAX2HRHutKB14RmmS1
	5UqnztgWOY5yIiiD9hbNrVA+jPzp1UsOOG3fY0x3/mN6A6ldGFkAFYSup7pYijl8JR40EsvV4zY
	0yt8TR2zrjmr1nMqEbsxQwN1tIzwJch58Q9nkfBoZVYbeaWKbqti1q6nNWxLRIHvtbxGTIw0pNZ
	HwPW9w7fPnm3yw9lXxTvOnvm9wXmF9awzZjD7pi3fAvpSQJaQtBa7ke9Ly/0MFystQoTP2zQM1R
	ZgPJjcndzxlXkQHAVYfkcm8q6umhgSQMpyd4Zz+Wi3DtsF046jqefgCrsBmcsmJwV1Pj4Xmem6q
	AZwD7NUuw9FJEc7rfVe9AJkqnBs3+QZmvPBiCTjP8vihOY6mCT02DE31QWKtm10gcZ+AcHxxFsI
	S6gdSPyzj3Apos5Mpg9aPeMoaiqeBh72Am2lzf28FOSK+lv7IboRf+KtzABdYJceOlHesx51Gp7
	i/vaXkHjYDR06fTOJBTVWec3vidyJZYd6Q==
X-Received: by 2002:a05:6a20:6a1e:b0:3c8:e313:8d42 with SMTP id adf61e73a8af0-3c92a77e60fmr14018709637.31.1785852931219;
        Tue, 04 Aug 2026 07:15:31 -0700 (PDT)
Received: from localhost.localdomain ([1.226.165.54])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbe396eb7e2sm5056572a12.18.2026.08.04.07.15.27
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Tue, 04 Aug 2026 07:15:30 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Linus Walleij <linusw@kernel.org>,
	Samuel Ortiz <sameo@linux.intel.com>,
	Rabin Vincent <rabin.vincent@stericsson.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] Input: stmpe-keypad - disable keypad on probe failure
Date: Tue,  4 Aug 2026 23:15:25 +0900
Message-ID: <20260804141525.39388-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

stmpe_keypad_chip_init() enables the keypad block before programming
its registers. If any subsequent register access fails, the function
returns without disabling the block. The later IRQ request and input
device registration failures have the same problem.

Route every failure after a successful stmpe_enable() through a cleanup
path so a failed probe does not leave the keypad block enabled.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 76f10845318b ("input: Add STMPE keypad driver")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
 drivers/input/keyboard/stmpe-keypad.c | 38 ++++++++++++++++++---------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/drivers/input/keyboard/stmpe-keypad.c b/drivers/input/keyboard/stmpe-keypad.c
index 0acded4fb9c9c..58a5ce4eaa80b 100644
--- a/drivers/input/keyboard/stmpe-keypad.c
+++ b/drivers/input/keyboard/stmpe-keypad.c
@@ -280,35 +280,44 @@ static int stmpe_keypad_chip_init(struct stmpe_keypad *keypad)
 
 	ret = stmpe_keypad_altfunc_init(keypad);
 	if (ret < 0)
-		return ret;
+		goto disable_keypad;
 
 	ret = stmpe_reg_write(stmpe, STMPE_KPC_COL, keypad->cols);
 	if (ret < 0)
-		return ret;
+		goto disable_keypad;
 
 	ret = stmpe_reg_write(stmpe, STMPE_KPC_ROW_LSB, keypad->rows);
 	if (ret < 0)
-		return ret;
+		goto disable_keypad;
 
 	if (variant->max_rows > 8) {
 		ret = stmpe_set_bits(stmpe, STMPE_KPC_ROW_MSB,
 				     STMPE_KPC_ROW_MSB_ROWS,
 				     keypad->rows >> 8);
 		if (ret < 0)
-			return ret;
+			goto disable_keypad;
 	}
 
 	ret = stmpe_set_bits(stmpe, STMPE_KPC_CTRL_MSB,
 			     STMPE_KPC_CTRL_MSB_SCAN_COUNT,
 			     keypad->scan_count << 4);
 	if (ret < 0)
-		return ret;
+		goto disable_keypad;
+
+	ret = stmpe_set_bits(stmpe, STMPE_KPC_CTRL_LSB,
+			     STMPE_KPC_CTRL_LSB_SCAN |
+			     STMPE_KPC_CTRL_LSB_DEBOUNCE,
+			     STMPE_KPC_CTRL_LSB_SCAN |
+			     (keypad->debounce_ms << 1));
+	if (ret < 0)
+		goto disable_keypad;
 
-	return stmpe_set_bits(stmpe, STMPE_KPC_CTRL_LSB,
-			      STMPE_KPC_CTRL_LSB_SCAN |
-			      STMPE_KPC_CTRL_LSB_DEBOUNCE,
-			      STMPE_KPC_CTRL_LSB_SCAN |
-			      (keypad->debounce_ms << 1));
+	return 0;
+
+disable_keypad:
+	stmpe_disable(stmpe, STMPE_BLOCK_KEYPAD);
+
+	return ret;
 }
 
 static void stmpe_keypad_fill_used_pins(struct stmpe_keypad *keypad,
@@ -389,19 +398,24 @@ static int stmpe_keypad_probe(struct platform_device *pdev)
 					  IRQF_ONESHOT, "stmpe-keypad", keypad);
 	if (error) {
 		dev_err(&pdev->dev, "unable to get irq: %d\n", error);
-		return error;
+		goto disable_keypad;
 	}
 
 	error = input_register_device(input);
 	if (error) {
 		dev_err(&pdev->dev,
 			"unable to register input device: %d\n", error);
-		return error;
+		goto disable_keypad;
 	}
 
 	platform_set_drvdata(pdev, keypad);
 
 	return 0;
+
+disable_keypad:
+	stmpe_disable(stmpe, STMPE_BLOCK_KEYPAD);
+
+	return error;
 }
 
 static void stmpe_keypad_remove(struct platform_device *pdev)
-- 
2.47.1

