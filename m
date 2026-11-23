Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795420306;
	b=GsV0aHv/R5Xt9Ew7g97AEcdbF+lDKrbKZlmDxkL7Km1C5dPed03HZ2Jh8pm2ZvgFC9az
	 /9KLrAjDpVYnck3j2jp/jdH9vpLpeay0evIuQvaMPWcQAGkh+TA3CKvtUCcAg7ZgKL/6l
	 9DzjBV0pjEdYzFGRHwfe9QSzsWnkgSJRXXx3BBgg/yF+iOK2FszbT/wrQobJ2tePcgxe0
	 XhNAaOLzFUpQ/07c00VUM0xK2NBTrwQxanTjjXsqCkJkUs23ziaQm6vKylwLWOdz7lxPD
	 Uqco2k7+aHhs9OgcHmQny4MYpcgA3lk0A0wirqn1VieekYg/4qUPyxLKmv6PyKZzpDw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795420306;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=4U9CbCw+DHOvkyr6gju/PyFcVkH3hB0bo/MNj6uBwF8=;
	b=g2+Vz2OcraD2nYy9YVaUhvLBA6nStlNpXRv8GkKD7IZTfAwyqZtYqK9Bm/8MQRNb79tQ
	 QtKEM97EBxxEUr8t3v/TS97r/XvQeGJ3EEeox6GgBnvDpRtj4vfxSBw5hbZRSpfZeJyi6
	 P0SGrM2izxd1CfW4jpfA7YzJnxf8qfq3ti2WqcwjPodigkb4dcsltt+7S5qmEnTv0+msg
	 8tWa2l8fe6glI2Y2GPhSp6kAUBz0wJgccNjUQwl9pleeZKqt5cH06ieIuec81xY7duGQo
	 pvGNXdQZgoSZ2fh0BQEyKso8kdXBGVArs3HkHmrVhVjUm2AkZMGzu50IikCx5jr4e4w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SX2gE6Gl;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B69606A31A;
	Mon, 23 Nov 2026 07:51:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SX2gE6Gl
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 88E7C1F000CA;
	Mon, 23 Nov 2026 07:51:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795420306;
	bh=4U9CbCw+DHOvkyr6gju/PyFcVkH3hB0bo/MNj6uBwF8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=SX2gE6Gls7B9LjRpUvHD3NISkbLG9H2oKGq8Yt1mPvZ41+PH2rdULZ5n5OWyjrb2h
	 z5AYtdwdFlNtBrc1oqRmXhB7o0Vq0Ay4qqH0SX1h2jJhvGiiKEDKZklOXIfCxV+P41
	 +5akEKaL71bAkLzaERkrRDEuvKByKhDTqLY2cKjtUwrL9kta06mfr3vhofVwy+ZDR+
	 S1FKISkCj27b22xjyvsYBbCQDBsLTC5IAdh4Rl0zDAR8uN+c1e6qBDMXLj14b2T5ZY
	 Z3KL6neI36qp+GDp0/HfK8OkSu3+yuCu0ft0yV+lttvzrJhUSEOEdbQlp1vHT4MR66
	 HWCLBhRusM1Lw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Lucas Stankus <lucas.p.stankus@gmail.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Michael Hennerich <Michael.Hennerich@analog.com>,
	Jonathan Cameron <jic23@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Andy Shevchenko <andy@kernel.org>,
	Lothar Rubusch <l.rubusch@gmail.com>,
	linux@analog.com,
	linux-iio@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH v2 2/7] iio: accel: adxl313: Prevent FIFO buffer overflow in adxl313_fifo_transfer()
Date: Mon, 23 Nov 2026 07:50:28 +0000
Message-ID: <20261123075122.373060-3-lee@kernel.org>
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

The ADXL313 32-entry FIFO plus one sample held in the output filter can
yield up to 33 3-axis samples (ADXL313_FIFO_SIZE + 1).  Because of
missing parentheses in ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1,
fifo_buf is sized at 97 16-bit elements instead of 99, overflowing the
buffer by four bytes whenever all 33 entries are read.

In addition, adxl313_get_samples() returns the 6-bit FIFO_STATUS entries
field (0..63) without bounds checking, allowing a malfunctioning or
spoofed bus device to overflow fifo_buf on the heap in
adxl313_fifo_transfer().

Parenthesise (ADXL313_FIFO_SIZE + 1) when sizing fifo_buf and reject
entry counts exceeding ADXL313_FIFO_SIZE + 1 with -EIO in
adxl313_get_samples().

Fixes: ff8093fa6ba4 ("iio: accel: adxl313: add buffered FIFO watermark with interrupt handling")
Closes: https://sashiko.dev/#/bug/linux-6baeb7fe-ad68-4961-b5f9-5f0c7628df1e
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---

v1 => v2:
 - Return -EIO instead of -EINVAL when FIFO entries exceed
   ADXL313_FIFO_SIZE + 1 (Andy, Jonathan)

 drivers/iio/accel/adxl313.h      | 2 +-
 drivers/iio/accel/adxl313_core.c | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/adxl313.h b/drivers/iio/accel/adxl313.h
index 75ef54b60f75..de0bccfcdd0a 100644
--- a/drivers/iio/accel/adxl313.h
+++ b/drivers/iio/accel/adxl313.h
@@ -93,7 +93,7 @@ struct adxl313_data {
 	struct mutex	lock; /* lock to protect transf_buf */
 	u8 watermark;
 	__le16		transf_buf __aligned(IIO_DMA_MINALIGN);
-	__le16		fifo_buf[ADXL313_NUM_AXIS * ADXL313_FIFO_SIZE + 1];
+	__le16		fifo_buf[ADXL313_NUM_AXIS * (ADXL313_FIFO_SIZE + 1)];
 };
 
 struct adxl313_chip_info {
diff --git a/drivers/iio/accel/adxl313_core.c b/drivers/iio/accel/adxl313_core.c
index 6dc918c4ae17..dd0b3efd594e 100644
--- a/drivers/iio/accel/adxl313_core.c
+++ b/drivers/iio/accel/adxl313_core.c
@@ -921,7 +921,12 @@ static int adxl313_get_samples(struct adxl313_data *data)
 	if (ret)
 		return ret;
 
-	return FIELD_GET(ADXL313_REG_FIFO_STATUS_ENTRIES_MSK, regval);
+	/* 32 FIFO entries plus 1 entry at the output filter */
+	ret = FIELD_GET(ADXL313_REG_FIFO_STATUS_ENTRIES_MSK, regval);
+	if (ret > ADXL313_FIFO_SIZE + 1)
+		return -EIO;
+
+	return ret;
 }
 
 static int adxl313_fifo_transfer(struct adxl313_data *data, int samples)
-- 
2.56.1.750.gf70dc682cf-goog

