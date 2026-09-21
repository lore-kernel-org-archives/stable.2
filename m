Received: from mail-lr2-f12.google.com (mail-lr2-f12.google.com [74.125.230.76])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3659E4F96CB
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 18:31:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.230.76
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790015500; cv=none; b=J8ag+qP4QTb7IOhKusE3XkAO/BbN4PyJIkL1n3B9sNyta2Uh2WCtzgU/pcXtu3H++eL9bKepP+GuBXXaypoaxPa7BQS0nw5qQvUKCFwHaG3sm9FOXqsgWU+8iwbykejvHoy/q7ji0joRxGjkFkc4U0LRYZsFMOGp0rAEnAeVymY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790015500; c=relaxed/simple;
	bh=XEU3X6TrPs6UzvTqsbHKRzxHg0PLadxing8itj7f4nw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dIrNjYcANSUnRNtmMMLh0GWPoNwLb0ZLD1gRhFu/SJC2D3XKQvRqAeOid9+vEKXaAGdBnRlgyDgKLo0w6ca10Px0xriV93NG3knCCa1ePb6xgJVHZNz+pTdsZV8tePBiW0SHOwAoyHYgPmR6WWv87gFslHRnROkNqRPjGqINJFg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cegrOKc2; arc=none smtp.client-ip=74.125.230.76
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cegrOKc2"
Received: by mail-lr2-f12.google.com with SMTP id 38308e7fff4ca-3a2ff176d5eso28726031fa.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 11:31:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790015497; x=1790620297; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=OfR3YrnGEF1eVDtqqFJbMom6dYue/Q5AxIRNa4I1fXg=;
        b=cegrOKc26pwraiUOJ/KxqyikJ1qAhhFe7sTYMj3m4iCSg0MDk8n88bs7lWGVl4MLqF
         rgK7U1QQUqG8C6K2Hw8C4qKna3hZZ0b2UiyvoP7FabW394o6k9e6sUh/t8syn2o2Rbds
         nshCTL36TlEuSc0CGeADLDjPgu3Jjz1TKCp+cugEwG/YzzPWSVyCfvN4UlDr6zG2U8YX
         4Fwin/+kGP7SDnv0O5cjAiF+ichBsmYlMphI+3spvKW1ySKZIzIyyfbJu8X1shDTy7ms
         cjSfYBjCYiFkjevf47IQZsjggsM0BhGB7VPXd9qge/5BljeATNSBemE7u4eUdMQ6pQhv
         R2Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790015497; x=1790620297;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=OfR3YrnGEF1eVDtqqFJbMom6dYue/Q5AxIRNa4I1fXg=;
        b=Z0H/MM8H7fLVuQumJzXLjkFJlLW3Eujl0LH0ZKyKzzWttdMDzGFkzaOSlPYTFQJa6h
         m5mux1rSRMedB0i3zOrdHiIBVeOtfx8iCjceAoAzNZI+AwjtRr04qUji81CnXCE553Qc
         amq5K+T5zsHpXcJbdg6JkqJaJiQE3QYuDgQ5gWyxSLYenatETDdbG4zMrJM375lSg0lE
         JznrAvOZvGHrFhEZjhOlKi3bilwkdCw2GG1izTbdVytMtScVZ6KY2soc7foqZRSBQWyv
         fqZ6HUzXJ467ZqTOjFhuWeHwlTz7WfrHSxTzNUKyFSfDtO+5rlDC0ZF6ONRLMY9OFcgA
         /L8A==
X-Forwarded-Encrypted: i=1; AKwUvByKKrbDbY5/G4BQ4EZjvKAFuh3SCNOsrZk2gxmu2/kbaeHUJcpPkerNj+NWCo5jiWMUripiobo=@vger.kernel.org
X-Gm-Message-State: AFuF++lkgpoFCvgJpk0jZtYc9HN1r39D5J8xBRwUsO20n1Gej3/Wa14F
	d0h5paspN544ZbdNf6mjhgHhGwl9mIUwQE5Zp2xGbOjfgXK3gTysBLaL
X-Gm-Gg: AYBFou1VRGkL8S2xzI8g1WTFvFBEad4Vdp7MsqlTClagZcIZewRgY9Dc+BtjukUnK3b
	0kwtcXYCAm0yNXxuKYhfjO8diRZuv472eRgnRf1VEvhEGfuJG/Mzlg7tWIdlCRHJtYvpRbzK63B
	3qKMCOxbeROVbnDdxHPKsnX1QAjvNzBJRlrUpv5u+XvQO/uQDiLU72/ElgODnja+L+hOvQ7gPRg
	X4pDS1Dmuqb0DBDZMq2B2h7Uc6UwjnT7Pac6knEKs3Hr2KV9XL060lZnAxQUnGzeSePLo1u73ZZ
	BTi7by0kYT6XHgp+jm7rN+kNuHp++jw/jY3gyEPqRf7eWaIE39lmVdZjZw0ttKyjE9HzBzWwOUW
	N9g9WQ3SFipTE0t+66MLD/FTxiCN0OT6fYfhcqo9lkEf02r4nHe6y2e+4BouIVu6U7+R8zHTr6c
	L+61UilHfkGR5vL3YQtP3oK6MzMqVgcRwNqqJ6s9Etf6V/S3Z8m4MA7QJ3uqb8MggKRz5+U1OqM
	iSR+y8Kr5l7cWOH70cfY+MYdn0HsxgnAEb2RUOvLdQXkY6mAtUfoyA7mmvUNpWdPJNmxQ==
X-Received: by 2002:a05:651c:1b0f:b0:39b:3e32:4a58 with SMTP id 38308e7fff4ca-3a5fbf10e6bmr21808141fa.10.1790015497115;
        Mon, 21 Sep 2026 11:31:37 -0700 (PDT)
Received: from yantra.. (dsl-trebng21-58c187-236.dhcp.inet.fi. [88.193.135.236])
        by smtp.gmail.com with ESMTPSA id 38308e7fff4ca-3a60761e5d6sm24260141fa.29.2026.09.21.11.31.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 11:31:36 -0700 (PDT)
From: Rupesh Majhi <zoone.rupert@gmail.com>
To: Andy Shevchenko <andy@kernel.org>,
	Bill Wendling <morbo@google.com>,
	David Lechner <dlechner@baylibre.com>,
	Eddie James <eajames@linux.ibm.com>,
	Joel Stanley <joel@jms.id.au>,
	Jonathan Cameron <jic23@kernel.org>,
	Justin Stitt <justinstitt@google.com>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>
Cc: linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev,
	Rupesh Majhi <zoone.rupert@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v8 01/10] iio: pressure: dps310: fix CFG_REG bit definitions
Date: Mon, 21 Sep 2026 21:31:23 +0300
Message-ID: <20260921183132.233136-2-zoone.rupert@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260921183132.233136-1-zoone.rupert@gmail.com>
References: <20260921183132.233136-1-zoone.rupert@gmail.com>
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
Assisted-by: LLM
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
---
 drivers/iio/pressure/dps310.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index 45bdb8c7670f..35260b399390 100644
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

