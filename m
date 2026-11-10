Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794278481;
	b=NFkHDgQCjrzE4DrPJQpWwh5D9OOM6zhoPeN6p1HZhI+EoHrCvA9uiihco1J169FvDTRL
	 RnmmiwAs6wd2KbcwLsidf1aJ9rz7fpieAFbLz40vleaGm7ZvbVpuLCFS16ds4zpvVaCsZ
	 SbjbEjzPIqcN1W+7cdCpncX0y/AJUou2CXOSKXHkhjTaI+0tN/6HZqpTZ8KRGc2D5a2fj
	 DWvJRQc1tTIY3xImbw3MjNP3N7ojsb/x4WvVs6t4eexD+CvJKwtipusK6HZQEt3ziHgQK
	 o/A0hvB6zYdMq91zZFUzKGzw4YIzR0eeWb+R/RmAULpiIoN4wxmkDjSuKdmhq/Tjdkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794278481;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0+CEVYuj+xLV8rl3BnGIpVdgmdAcSAMyVq4sxjr25VQ=;
	b=qMmK4NsxsEdXnqYlVwgF/27638F7VIdKsQl6bEHg5fryLsY1uKa2S+v+ybu42lTI2RHk
	 Npr9xw3U8vv3pd9DYvFnWI/Terltd7IKmQZfXKwSvBUgn33GGOFfASO4r8K9GXOlOb48D
	 Qmiz0X0hSYwPCC3celO3VJS07TRf4jUVJ3Zf+buVuDQhRDEQAsd5Y6kLPWhKycqc0YgaO
	 geZHr6cvjOm+YcZXM14HLMjTnKLtJpTm/2A4PV/VCOha+WFalQGMDBP/y0Xhqjc4BtsN6
	 qoozAB6XWLppEx5SbUF1cGiOzRHsZilUuG7sil0bd6oIzj7rx1HlNeIj1+oYW5lgovg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTAOn921;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E0E62606A321
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 02:41:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iTAOn921
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B893E1F0089F;
	Tue, 10 Nov 2026 02:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794278480;
	bh=0+CEVYuj+xLV8rl3BnGIpVdgmdAcSAMyVq4sxjr25VQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=iTAOn921PzBbbJLeCD5kTlJLeEJFOazI5wgGVmarcBeNb3e2acNMF72ML4mJWubbh
	 u/ygqqdDafHMfYnWYyUptacFStSE060N07GPCZc910iQp+x+y5gbLeEOGdb5+aSE1K
	 G7DhnHRFBi1ONGhBXdogMqp1T2f8S40VXCnNotUxpKWRm0QpJLpiYVZ/mJhyA9Xiuk
	 kG6euJrzXh6ziHK2okGPithw+xec6zqqs8zi9pvqKIVh50DlA70TQizfpcmRt6mKdh
	 IYl7On2t3kNVWr/ePC1m6yYhH1ygHTPQJJipPN1Kt/8laERS4xI8mfw7XOnJ9J8v+6
	 4Qyz9h3Qhdykw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Esben Haabendal <esben@geanix.com>,
	Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@intel.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] iio: light: ltr501: Power down chip if request irq fails
Date: Mon,  9 Nov 2026 21:41:17 -0500
Message-ID: <20261110024106.3879067-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107052814-failed-6.6-8a9bcd587d7d@kernel.org>
References: <20261107052814-failed-6.6-8a9bcd587d7d@kernel.org>
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

From: Esben Haabendal <esben@geanix.com>

[ Upstream commit 8a9bcd587d7d768e6c8e9fff88bb89645e412731 ]

In case devm_request_threaded_irq() failed, we were leaving the chip
powered instead of powering it down again. Power down the chip switching
ALS and PS modes to standby.

Fixes: 7ac702b3144b ("iio: ltr501: Add interrupt support")
Cc: stable@vger.kernel.org
Acked-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Esben Haabendal <esben@geanix.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: adjusted context to preserve existing IRQ request failure logging ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/light/ltr501.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/ltr501.c b/drivers/iio/light/ltr501.c
index 498cff9327132..deaa18d88e47a 100644
--- a/drivers/iio/light/ltr501.c
+++ b/drivers/iio/light/ltr501.c
@@ -1557,7 +1557,7 @@ static int ltr501_probe(struct i2c_client *client)
 		if (ret) {
 			dev_err(&client->dev, "request irq (%d) failed\n",
 				client->irq);
-			return ret;
+			goto powerdown_on_error;
 		}
 	} else {
 		indio_dev->info = data->chip_info->info_no_irq;
-- 
2.53.0

