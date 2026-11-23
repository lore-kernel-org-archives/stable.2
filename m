Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420313;
	b=CE3sKgqT2wzdDo2z6obRzyU6fQbDRTqdKfPZRtEob2v7TXYPjJS4WYqMmunXTeMX6J9u
	 9f/+tPUh6M/4BRfVBhqPDZbPHDumoNQrekTosOgxHxny6x5GP/Mrbmo/4U4AkiY9A0yur
	 mOgUxdN9LKvKr2+mll6isDMo9EruqNHwNXS3Q6dHziR4iFWgQuSVYDGjNmZyI3Qo5Y7Zr
	 C+qFCX2fhm0Sfq81C1c3pFRuJXuqf+OHV/3uOg1MuEbqkwdk1ZVyl7YjI/z9AMH4EH0qH
	 YbZbE2tVBROSvtltziMv9qlb0LTbj1rEQ3QJEJsRrlem+LYMa+x7KABgrr9FaB+15EA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420313;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=UhqU/Jx83x1rLEZktX/dxjJ0nFQK0B2T2V+HlFh1pHw=;
	b=z8xS1Z1RC2WfkioSxEG3PRKu+hxUUjmolcOr4CinsNZNcSGyui1iKLh5xUqSkE2hG3om
	 yv3sWnYLXKcU7pTaMA0Qqhw1rSrf8KS8ei17WGWgjdBvvfLqUPlgxSreBRfl9rxVp2Z0j
	 9zVS5k7pvetrVHzUnkeOVuPlEgtZSa8Y75bVECe3WdbBPC+uhbNOIHojUCsXIhhRvYMRw
	 r0xlWId7/j9YgRtZdjVJNKsIlSjV6gj4ibCETnhGyaSXF8GSKlvJkY0/b1s+yAPFRaekq
	 sIUd+v/eptc8gafjVD26hzvrxm0ywqkfxIBgOueD3Sgq2p26dMB33HLcAh+IZD1666g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBYeEPk0;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C364D606A321;
	Mon, 23 Nov 2026 07:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DBYeEPk0
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64AA91F000C4;
	Mon, 23 Nov 2026 07:51:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420313;
	bh=UhqU/Jx83x1rLEZktX/dxjJ0nFQK0B2T2V+HlFh1pHw=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DBYeEPk0U9ZU7K324UXVxoPzyM0nqbg9V+2FgIRCxfr+YW0QF59rGD/tyIYr7U+bc
	 bkq1451FZ6ghQZajs3GhsPGVmYFKovd151h25995zeeog4YPU33xcbVYmXCLXVrM0v
	 wH6VySduWEGFUDrR6xjTAIZbFfFIW03WiS8ZASoF9dvVnYwpUWYLAR69Co6HpzfxJc
	 7mr8viutRRYFuNasYybmhdXQw+mmg3GGvaIM62LiIR3fhE0I4Zh+5MQiTrBh1zZ+GB
	 A5/9NZtGzPOwwDRTAaJ63z3gsik9H3NpRC3QNpszgw91cX164CT9lx5FZX38vqmaEw
	 AkkHo6BZJrquA==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Alexandru Ardelean <ardeleanalex@gmail.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 3/7] iio: accel: adxl313: Reject sub-base ODR codes in adxl313_read_raw()
Date: Mon, 23 Nov 2026 07:50:29 +0000
Message-ID: <20261123075122.373060-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.750.gf70dc682cf-goog
In-Reply-To: <20261123075122.373060-1-lee@kernel.org>
References: <20261123075122.373060-1-lee@kernel.org>
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

When reading IIO_CHAN_INFO_SAMP_FREQ, adxl313_read_raw() extracts the
4-bit rate field (0..15) from ADXL313_REG_BW_RATE and subtracts
ADXL313_RATE_BASE (6) to index adxl313_odr_freqs[].

ADXL312 and ADXL314 support sub-6.25 Hz rate codes 0..5 and do not
perform a soft reset during setup, and debugfs register writes or a
faulty bus read can likewise yield codes below ADXL313_RATE_BASE.  When
that happens, subtracting ADXL313_RATE_BASE produces a negative index
and reads before the start of adxl313_odr_freqs[].

Return -ERANGE if the rate field is below ADXL313_RATE_BASE.

Fixes: 636d44633039 ("iio: accel: Add driver support for ADXL313")
Closes: https://sashiko.dev/#/bug/linux-d6086ee0-d732-43b6-b8ac-24e5bf86a9f8
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Return -ERANGE instead of -EINVAL for sub-base ODR codes (Andy)

 drivers/iio/accel/adxl313_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index dd0b3efd594e..aaab1935ac60 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -647,7 +647,11 @@ static int adxl313_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		ret = FIELD_GET(ADXL313_RATE_MSK, regval) - ADXL313_RATE_BASE;
+		regval = FIELD_GET(ADXL313_RATE_MSK, regval);
+		if (regval < ADXL313_RATE_BASE)
+			return -ERANGE;
+
+		ret = regval - ADXL313_RATE_BASE;
 		*val = adxl313_odr_freqs[ret][0];
 		*val2 = adxl313_odr_freqs[ret][1];
 		return IIO_VAL_INT_PLUS_MICRO;
-- 
2.56.1.750.gf70dc682cf-goog

