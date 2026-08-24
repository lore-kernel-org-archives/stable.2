Received: from mail-lf1-f49.google.com (mail-lf1-f49.google.com [209.85.167.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 68D0538D6AD
	for <stable@vger.kernel.org>; Mon, 24 Aug 2026 20:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787602456; cv=none; b=Mzcg7c/uhBkG+XNJCW+gpiGvWnLda57cRjj/M3qHIzhL2jC088/BY5G+aR35wXNd7TiH2yIT72L8KMDZwrdkLMWpeS59eTocOjeaYP9AAnATFUAVcUyu7Q+ijipMqyTBXJy/nguPPQ/RxzcfZUyE3LrFGlnMoFJr48Y7V1F8rTg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787602456; c=relaxed/simple;
	bh=x2S1FPcFw6xB0ZEc3bzyK1hPMMiTGwFHOTi1d6ZsdXY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lNgG1+np5vDswvCp0KU2lFpixGrbIqS0eZuRdE6F/G9nHDsTkKSF2vyIjFrh8DMxmMQEo/3q2quRg+z2DeK/DE7GBfME/hhSOr6vKWcF1WhSZzMjGcT0oz3Tm84ZRXJPaudyOgoS3WBktaVYHVOmofJz/k1cbFg1n/R5mFy/hmo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=KfyFU3gx; arc=none smtp.client-ip=209.85.167.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfyFU3gx"
Received: by mail-lf1-f49.google.com with SMTP id 2adb3069b0e04-5b011edaf7dso4434452e87.2
        for <stable@vger.kernel.org>; Mon, 24 Aug 2026 13:14:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787602453; x=1788207253; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=tsCzfWJOg7SVbU+X222eaAOaisGnyr8WXZV/pRTp8oY=;
        b=KfyFU3gxlPi16iogDrJAy7JhGORULAirVcUtxjlY61YbR3Puj8xxOACAyNPDEtzCWg
         Dw631odOAZYGlX8nGh5gMHW6LzMe6BVdmR2/pE9i8PuFyFfkkwXijI+eS85hWQbwhyPV
         e1HXynlh+AJtahWoiOY1UTWb9A1M7mNggLV5oUZTPzv1IPstZc6mMz+H2b330JPNq71K
         moubkqIqO9yxWybnuEFoVbbS1arY/NAyMlSi/49BU405BfoEv2m6vJ9cXrbgf3mWDSBT
         Up0UfAIVe4rqTwXnw/AEE05il1fW/Lji1ml4kii1s7XkQ3gWtGru0hKpK0qgCBPmm5V4
         lf0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787602453; x=1788207253;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=tsCzfWJOg7SVbU+X222eaAOaisGnyr8WXZV/pRTp8oY=;
        b=UxMqkbv6yFsCGl4dsjMobIMzZe6QxVSkAOAvHHcN4b7WLIZLmnVrSks2ptYlBD8Hh0
         e6Qubh4sG7aiegdJIoWejybdGRfFJCPZL8eiCmjjnwIQH9hK3n2WlWW6TnXtKRMy1IVw
         zgwFMQ2r2yG8r3GKVlkauXuZLbck6brNBsfC2aXwADN/mj+JHBP6h+nEIQYBf7VxYxZY
         24cL0BKABs/FP90Vl/tQtp5yEveApvqggwzmc7QpbQPTD9bwKw7mD5KAjx+Lxg5dog09
         zMz9jrf+scwrwfGe+nyO+6/qvxgPEZ8cUoTRpjl3cmh4w7qgwpisEcoqrSg0hnArupPH
         Gotg==
X-Forwarded-Encrypted: i=1; AHgh+Rpo491wM7u+iyAB48ugGpDvC+OIAOoxo58H4JsMz8VgaLZumT2vVv77RX8FaT5cL1ASH1cFk0M=@vger.kernel.org
X-Gm-Message-State: AFuF++lzz8TjySbe+9zW+YhR1f/vIMb8Nku6IpIm2PUQQGhIlN1TNNSO
	B5rKN2TOTUGvFK7Q/SLuP8/aycKsIvzG8k5Pr7ZKNmTQCFgmbOtNjsmN
X-Gm-Gg: AR+sD138k4ST0bewJWBdUKov+jAsOD9SVS3QnJXt4MVot6kfAHVqhr/OHE+jWhU6aNc
	cK5KocU01bT1wT+uZVFOvM4gAgf+nhPoFp4kClpBQiDcG8IM0xyF43V/ewCBg9vKa4gBlxoYDZL
	vVwzifYh3bsYbfyNDTEL5tt3jRlAhi2tmjftI98QScYoleU07T/KUUbZOsaeLQyb2dJGznLX0u2
	oyhUqA/SYaV4N5ypr7+SLERdE4ENYS473dzBBec68d8ZQE0BnKvMdbEAqOqnxlwk5TX3c10FO1q
	retrvUOSxwmo36MYPZFxZZkzLOhz4RGEJJL9n7ayG53Q0VvZxCpw/NkC96JzjphW4xX91lFJ7cF
	kfqVBnUGFzegTlARCPikd/obTK6qRI4P5N56OAUq6NEMqtEC+UMdwIHx8mWPKiIwAnB2Mwxf4tt
	K2sO3QqK5x6wzuP5ZpyKqPX9j04iJmg6ma12LRz+LkeGpKviHtBYxGvzqZkoApC68u7NsoUs/zl
	dzleNDTAFXjgqppE+79a6DHi+U1VHhcWgDl/qN1IMEjm6FHbazbO4PGtEc=
X-Received: by 2002:a05:6512:2304:b0:5b2:e947:b3e6 with SMTP id 2adb3069b0e04-5b484209176mr9381158e87.2.1787602452978;
        Mon, 24 Aug 2026 13:14:12 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 2adb3069b0e04-5b48ce0cd9csm1923620e87.71.2026.08.24.13.14.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Aug 2026 13:14:12 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v6 1/6] iio: pressure: dps310: fix CFG_REG bit definitions
Date: Mon, 24 Aug 2026 23:11:58 +0300
Message-ID: <20260824201203.396651-2-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260824201203.396651-1-zoone.rupert@gmail.com>
References: <20260824201203.396651-1-zoone.rupert@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Driver defines them as BIT(4), BIT(5) and BIT(6). Per datasheet P_SHIFT
is bit 2, FIFO_EN is bit 1 and SPI_MODE is bit 0.

Only P_SHIFT has a user. dps310_set_pres_precision() sets it at
oversampling 16 or above, so with wrong bit the result register is never
shifted and stops matching the scale factor compensation divides by.
in_pressure_input returns -ERANGE at oversampling 16, 32 and 64.

FIFO_EN needed by FIFO support later in this series.

Fixes: ba6ec48e76bc ("iio: Add driver for Infineon DPS310")
Fixes: d711a3c7dc82 ("iio: dps310: Add pressure sensing capability")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index f45af72a0554..68382960382f 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -50,9 +50,9 @@
 #define DPS310_CFG_REG		0x09
 #define  DPS310_INT_HL		BIT(7)
 #define  DPS310_TMP_SHIFT_EN	BIT(3)
-#define  DPS310_PRS_SHIFT_EN	BIT(4)
-#define  DPS310_FIFO_EN		BIT(5)
-#define  DPS310_SPI_EN		BIT(6)
+#define  DPS310_PRS_SHIFT_EN	BIT(2)
+#define  DPS310_FIFO_EN		BIT(1)
+#define  DPS310_SPI_EN		BIT(0)
 #define DPS310_RESET		0x0c
 #define  DPS310_RESET_MAGIC	0x09
 #define DPS310_COEF_BASE	0x10
-- 
2.43.0

