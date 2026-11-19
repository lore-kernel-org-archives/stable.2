Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795102344;
	b=Tn1o+RB2Jf/Gaf+Bs1evd4BPv2QYt7tLlULL05niFtdP3tkL5GymV8RSqj999m4NdZoc
	 FVggg9JvmNsQkNjqFPUsz/5IxdG0qaFUdshVNH8hy55TlhgjxVvEVx2mg9rGEk3KCG0fK
	 XA6gFnJSDdneAq+MYTHAOkFEtl6JkyhKwANudz5n9cEZcfIra0P7KcuXSQuD2nlVk8Pfz
	 BxUKDtLqYytz/dGn2wnJRn5F/gV6jRAAaWAw8iFx53smZYX0XLFqz9ET8k1RJVlXobcwi
	 H4vZrwGT8Cxl69ZoTFq8jfIPhXA7LIXPKcbi7qLU+fjNiRO2xp2TAeHRkygLDleusRw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795102344;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=0dZXDVmpIj4s6SbDHEBP5PTHYwtd3ILCgixyaG+S4j8=;
	b=Ae0tm7dESGDFpcep6VooIqwyEgm8teh6KaxjQUe4AbF8ayaul7c2G4hbZS101dSuk6wj
	 OkUl2f8GGPzhj2VvxQE49Oy9658sbkdRwN26mT56WqAlNd0Aq0/MMu9g+sYSBLbJzaZoJ
	 pCQuwnklWXHH7sjgIPy8Hs8hqqvrQ3c+53tM2W+PYOvRKv9YEfOW9YjzPCOgdaZWSJ+jJ
	 1/vBkm/9zo66bvuENzeTuIgOJqIsalL2TukgV0ie6GoMehacmK8Bipo1ijC+a3KL+DJD4
	 GeN5yJhMfchZDlwJeWM1AHUBDPBZXpOQs6ibl8oiD3yuyBAlhDF+cNH1T0QlQTA9TPg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NrsjcNwc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6411D60A5BE3;
	Thu, 19 Nov 2026 15:32:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=NrsjcNwc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05DA91F000C6;
	Thu, 19 Nov 2026 15:32:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795102344;
	bh=0dZXDVmpIj4s6SbDHEBP5PTHYwtd3ILCgixyaG+S4j8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=NrsjcNwcoHipyWiUCWB5wQ4wkFiAfcoX3fRD6zowF8QDjnKKOUMvAucTciEeE3QEr
	 WJHvdlASUVVKkC7R00W9QKxr8f+fvn1ss4U/+y8jX9FTiJsjkvB2wdv9IHsCHgze3/
	 u9NWKBG3Z2+X25NoNuKeqoDZwV0cFG/2vYTuw9gxXQ83rJDY7mT07iIUhTB2HgjnYY
	 IfzGzHSuQCBxbo9hoUNIlR3CFkOTLilnRqyaIVbo9zhivE4GzMvRglDRhHQkMMMHQy
	 gKqM9xBRz7nJTf6++XNgKVTPrb0ZR+O1vvoaDMY5ITe6F+igxzRI3oOGpT5OvNCH9C
	 PaOrv1rYyfgqw==
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
	linux-iio@vger.kernel.org
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH 03/10] iio: accel: adxl313: Reject sub-base ODR codes in adxl313_read_raw()
Date: Thu, 19 Nov 2026 15:30:36 +0000
Message-ID: <20261119153151.1397003-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.708.g77570a6a1d-goog
In-Reply-To: <20261119153151.1397003-1-lee@kernel.org>
References: <20261119153151.1397003-1-lee@kernel.org>
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

Return -EINVAL if the rate field is below ADXL313_RATE_BASE.

Fixes: 636d44633039 ("iio: accel: Add driver support for ADXL313")
Closes: https://sashiko.dev/#/bug/linux-d6086ee0-d732-43b6-b8ac-24e5bf86a9f8
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/iio/accel/adxl313_core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 72ef8652d398..811218953c2a 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -647,7 +647,11 @@ static int adxl313_read_raw(struct iio_dev *indio_dev,
 		if (ret)
 			return ret;
 
-		ret = FIELD_GET(ADXL313_RATE_MSK, regval) - ADXL313_RATE_BASE;
+		regval = FIELD_GET(ADXL313_RATE_MSK, regval);
+		if (regval < ADXL313_RATE_BASE)
+			return -EINVAL;
+
+		ret = regval - ADXL313_RATE_BASE;
 		*val = adxl313_odr_freqs[ret][0];
 		*val2 = adxl313_odr_freqs[ret][1];
 		return IIO_VAL_INT_PLUS_MICRO;
-- 
2.56.1.708.g77570a6a1d-goog

