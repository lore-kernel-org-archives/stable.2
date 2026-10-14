Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B713A568FA2
	for <stable@vger.kernel.org>; Wed, 14 Oct 2026 17:34:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791999272; cv=none; b=mNeV7ENo1Z7MjVf58uzh6jfyDX/VJ3WhnOkU3T003OGdw2LUcKqmRSgKyLXLKCeCm0Vp4EoK88XldV87xb4TbUH+fSy6CvjOarOqyfMLMsNtegfPqhvkzB2ZjAtdjYom2RX64kS1beVrSWi06Rk9JIbdrlIIAHE78XiFQFZYYq4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791999272; c=relaxed/simple;
	bh=fIqA33wSyUtbRcCcYiczdNv6wVti+pGWaArnAAC/2uc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=qLqMnw/Af5qaTjHgocwXRAJJaoXMUwUKe8ISC5Ef5wpBErWt/d8k5cWovChITspcNO1qKtLMVBhCo8ic09IRsW4hLvGX1AzLBuUSFJpL1mYBYaisMqO0P3JRDNQ4OGSY7g+5C+6+jeLlN6+s6x4t0YoaXNogGZH32k3EDT7moKQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nRgkEyzF; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nRgkEyzF"
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-c315729ad50so726639266b.0
        for <stable@vger.kernel.org>; Wed, 14 Oct 2026 10:34:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791999265; x=1792604065; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=bK91X2SdwuCyQyEfLGRdQUCBBXpE80vPU5AmtR26wN0=;
        b=nRgkEyzFJ02Z1m7gFpmVV2z7oYmCwZt3aIUHuAxF7lPS+ROaLZW+lA1JidWm2NQYgT
         796jHY5tRGyywfxrRNGEhiTy3HUxUZN+RM7Hu/zTbxWD/sXws/Lchd5zns9b6fEynGS0
         UMLN4IFrQvJS5tAQn84EEU8wsKat/MNonna9QA2L6/x99nbrlfyQpDLjd8iJxJnPxzdC
         Tcwk+hW7lu+oxipDil8RHrwzpmmGGils8nveJ6CCm9ZZhlRpyQPyFOqmKTkXcW/V47bq
         gWUQ/qOMt3s1xdI7+vRjI45NyMPTvZobi7YUCsxODYNmSKbWSkS0VMIs8RF13vMmHVKd
         C7Lg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791999265; x=1792604065;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :content-type:mime-version:subject:date:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=bK91X2SdwuCyQyEfLGRdQUCBBXpE80vPU5AmtR26wN0=;
        b=N1xQ2nTRHf9UHHW4iWmrGzy8K2Nj7SweDRMbauAcSiNivrKma+uvyJABAloPsBBxjQ
         wxOzKWTxs56oiV/uHCFCd4UveW+HWkczZIWC0OLximcNOq4PPi+mDnK7FXvoaquVuQyM
         NOXSJwZf1TvFRiQpIpAyv8m/gVA6R8Sho+XWPYx+cZhYYujSOZJZZ75vkW0b3RQxUVgG
         OYlV9kt4uc6qeWD+5SLiP8/7yz8ThOTQa+Vy+/YK6Dh5dKzsrzNdT7uFcwd8UytAuWjZ
         o7Ey63DDwjuCPqNLXGEDj41H4XHsavjXXrL0d9T7Ma/1/afd6kR93d6W/L9NE9fQsFEd
         JGeQ==
X-Forwarded-Encrypted: i=1; AKwUvByaNZLQBMY1pVV8mIk/j5mR8LJSnvJVcIBMrxPMwM5iGmbfKozG0VcQvsMmU4u/T0FswkwTWWU=@vger.kernel.org
X-Gm-Message-State: AFq9FYJUgqGhz4JkCghpp4THN6kolWGZVUwgHZ1jq4vd5Tj/qM3z8DoJ
	HNHgndMDiohrUDDMbD66h6Fd3rmT9W5xkdbwtQulmyfNLv/wAENWeZYq3gYr4/C7
X-Gm-Gg: AYBFou0xmT6fmIr2jj92J07C/LCZxPz73BCvXFFXYcqIHNMgg7KSBg0DE+XyHygPXNZ
	tsgo1NW83Q2hmaOyfaWp55vcSPysWUap6ZtLb4QgHH90hwj+9029xDCISCnaw6Gaa+lvIXocdiK
	ZgFgl6v/GDqRwvkm8d3ybilDNQBVzGRk/yWYxzEY1/CyN/t7VbqcUhFvp3XX3N2kPcpOuM3nOVb
	ffnPnzSxXW8BC9MWfgj37efQCDj0ADGA9nprrG+qjwg2GurYQJIHjwWS7wORugQqGjRcAkLvDHa
	eqyQ+8It9KngAJyFsFX+8JOPPfO1XjReTPX+CRVZn1BbZqo7u5zcAkZcRUw+jAQ05jB94oqCAqd
	btCP3NWv8WSYEkqEJFjCucJlXusUMpO4jZaPIR5HMkhZQl9GW9ZnqSQ57phOqA8EbgrayarU6nI
	p2rFKDL0b5wO8q18ffNjmS7tfNye4U0AcpJ2Pfahwo05mrK7TQipvKVc1JBWEIu76LaEPMUK3vW
	4rmQFVVL2qoeGeSJfTk58mRMuQ=
X-Received: by 2002:a17:907:9686:b0:c1f:983f:d8a with SMTP id a640c23a62f3a-c31aa017261mr1685459966b.24.1791999264715;
        Wed, 14 Oct 2026 10:34:24 -0700 (PDT)
Received: from [127.0.1.1] ([2001:4bb8:148:f08c:65a8:f8e5:f310:5a71])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c3ed963cecesm9381366b.21.2026.10.14.10.34.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Oct 2026 10:34:24 -0700 (PDT)
From: Javier Carrasco <javier.carrasco.cruz@gmail.com>
Date: Wed, 14 Oct 2026 19:34:06 +0200
Subject: [PATCH v3 07/11] hwmon: chipcap2: enable IRQ processing when
 regulator is already enabled
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261014-chipcap2_locks-v3-7-27ebfc2c5b9e@gmail.com>
References: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
In-Reply-To: <20261014-chipcap2_locks-v3-0-27ebfc2c5b9e@gmail.com>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Javier Carrasco <javier.carrasco.cruz@gmail.com>, stable@vger.kernel.org
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1791999252; l=1283;
 i=javier.carrasco.cruz@gmail.com; s=20260924; h=from:subject:message-id;
 bh=fIqA33wSyUtbRcCcYiczdNv6wVti+pGWaArnAAC/2uc=;
 b=wGwEIFvv57yZEZRHNLCnr5pHFMdGHny3xsVW76RPyioM1t8Hqj03BSfwk9UChXIEm0Sf6Hlt8
 TJldbe/ES8UByswF2ukfIfMUIQQgn+r0EIUg0837081JqI2pn8heN00
X-Developer-Key: i=javier.carrasco.cruz@gmail.com; a=ed25519;
 pk=VV+hcMoOj1Sx6xSiY0W/FZNAskGZe2AagSMVj0PsmAs=

cc2_enable() returns early when the regulator is already enabled.
This can happen if a previous regulator_disable() failed or if the
regulator was configured as always-on.

In this case, process_irqs remains false, causing the ready interrupt
to be ignored. Subsequent operations waiting for the ready completion
then time out.

Set process_irqs before returning when the regulator is already
enabled, so that the driver continues to process ready interrupts.

Fixes: 3af350929e75 ("hwmon: Add support for Amphenol ChipCap 2")
Cc: stable@vger.kernel.org
Signed-off-by: Javier Carrasco <javier.carrasco.cruz@gmail.com>
---
 drivers/hwmon/chipcap2.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hwmon/chipcap2.c b/drivers/hwmon/chipcap2.c
index 654f6420da7a..837b1830f2e4 100644
--- a/drivers/hwmon/chipcap2.c
+++ b/drivers/hwmon/chipcap2.c
@@ -120,8 +120,10 @@ static int cc2_enable(struct cc2_data *data)
 	int ret;
 
 	/* exclusive regulator, check in case a disable failed */
-	if (regulator_is_enabled(data->regulator))
+	if (regulator_is_enabled(data->regulator)) {
+		data->process_irqs = true;
 		return 0;
+	}
 
 	/* clear any pending completion */
 	try_wait_for_completion(&data->complete);

-- 
2.43.0

