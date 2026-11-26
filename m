Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795706501;
	b=OqEZJFnN3zCMRxV6O5fs/KaS4TiYvY/pvDPH+UeeELfJJm4b8fo9bTjWN/WhnDIBedbc
	 QpwbRk9SXD6enbhn+B0xjdswk9qra9Moq7u1vF8VFAnEUsMNy7Zh02BGX3Z1DdciD6nYW
	 YaAevBUj8IdmcjqO+T4rxcg/VqzUH/gnD/FUwiqckLCwbDr/n6pz85e0CAe2yqLSokm2T
	 7KlEUCT5J/voTl91tjxAjCV8CQJwQme4xeUmrl3abeyqWP6lsZxeOnRK7sJQBtYMMhulS
	 aF7Xti7djv+xbZR6jYWNsDU4/FjciSbEMtNic6aMarElpOAW6Xqfumz05HTuhV3d5hA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795706501;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=2ae13qpjNWvpeeqtwch7rC6IZVcLkr18VL1Bru1SvRM=;
	b=qnrEc8B28OCmaa8PFFfJq6cF6kMAE+LWXiBLoZMDM9n8y2mjy48+t9eO/LY9+egSxbdc
	 uvJB4zMkl2ruOOY4tDlZXrnAq5kh3mE1wz2L2CzkcXafUKBX5zWPlw1qL7ysFpsi6gey1
	 VAYiN2VE/cBFtH0O8bYBMLkbprdc1UPZxBQ7/De1MULpQwRc29Oj/Pffb45tMtXZfA83R
	 UhtLigBdSoABRHG+59yqT5UPrvuZZxmx0lveij5JG6MDgoY+6Zd0AyYFaROn0LxT+YF/3
	 ayeW0zZR6m5Zp5z5rRe5OWI6SH8jv7oLxsuMu3GxoY+SkogpC4XKlG2Og9M0XEQkWoQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="N/N+qUbI";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FB57606A31C
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:21:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=N/N+qUbI
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54D071F000C0;
	Thu, 26 Nov 2026 15:21:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795706501;
	bh=2ae13qpjNWvpeeqtwch7rC6IZVcLkr18VL1Bru1SvRM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=N/N+qUbIfOwiRAL+wnqfnKenKDLOdt4S0hgD/t5zAaLMLZCVL24RC7jMdzjmh9rvd
	 ATeEnD/D8cmHU3k23wLIS+pJxSmUqEyRQPDrBFWCiQLnwohT2HvPM+k5gFKTfmwU9E
	 0DL9g5vSbHdbogxKIgKxfWUWpapcNAESzG9K6Nmw6lb406kAVnlAR9ujmkQVLibEuL
	 CkDBZwA6zM+0NlCqq7p9dRsMe63v4GBt5w6SWuo8mrCdo7V6v0AOUaU6ehjXWdfKdf
	 i+eo0RWJCpaqipq/MJJ65tLENmXIjL2FDS8qaLhRSHIITee7itgS1qePLMlgNZEYFx
	 yEWHBz606+IAg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Josef Bacik <josef@toxicpanda.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: adc: ad7923: add the AD7927 to the SPI ID table
Date: Thu, 26 Nov 2026 10:21:38 -0500
Message-ID: <20261126151516.2357600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112504-fasting-putt-6cad@gregkh>
References: <2026112504-fasting-putt-6cad@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Josef Bacik <josef@toxicpanda.com>

[ Upstream commit 594157b4f3f64db5833dee679194c33a5968f92e ]

The binding describes the AD7927 as

  compatible = "adi,ad7927", "adi,ad7928";

The OF match takes the second string. The modalias of the SPI device is
made from the first one, "ad7927", which is not in the spi_device_id table:
spi_get_device_id() returns NULL and ad7923_probe() dereferences it for
the chip information. The module is not loaded automatically either, as the
uevent of an SPI device says "spi:ad7927".

Add the name, with the data of the AD7928.

Fixes: 1140f96cd4af ("dt-bindings: iio: adc: ad7923: adjust documentation")
Cc: stable <stable@kernel.org>
Signed-off-by: Josef Bacik <josef@toxicpanda.com>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: Kept the table's existing positional initializer style, adding {"ad7927", AD7928}, instead of upstream's designated-initializer form, because the context lines differed. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/adc/ad7923.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/iio/adc/ad7923.c b/drivers/iio/adc/ad7923.c
index 709ce2a500977..b6f4857365c27 100644
--- a/drivers/iio/adc/ad7923.c
+++ b/drivers/iio/adc/ad7923.c
@@ -367,6 +367,7 @@ static const struct spi_device_id ad7923_id[] = {
 	{"ad7924", AD7924},
 	{"ad7908", AD7908},
 	{"ad7918", AD7918},
+	{"ad7927", AD7928},
 	{"ad7928", AD7928},
 	{}
 };
-- 
2.53.0

