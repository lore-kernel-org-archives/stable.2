Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794196388;
	b=sSMcQZkECs8l9fufo0gkY/hyBUmDmXl5ilElUopHcfJKYsOgKdQ2oEX0VkURgRKAwgxx
	 G+VZfhWtJ33zO5Rfg3CuddzCN/TnnIfz6u54bL8nXcaYdUenP98y7W8X8qxoYP7bxpexa
	 kft8lVQQPbbeB+GqoXJvz/h40+Ph+JdrfntiIduHuwuYVBj2hTjRILow6bb4XgMEdlD8n
	 CYvrgBT9KliUGXuwAu2lIUlmcjbWdBQd4jRD9cyhTdg4qvcROXCUkDUAHWOr4nsSd4+Wv
	 SPNIh+TiN5VDvEm7dUNTfXYMkMEgBSRTVxMw6HxzB/B5iTR8p+kwaIL8gtiOecp3aHA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794196388;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gFBJfakuS7S903GKdWCSzwZK23A+CkZRWg+QCbzdmnM=;
	b=GbbLDW45Wh9RIWnTxbbEzC3cX34U6BPhxSJf4U1oADwv42027BW2ijK1A5JpR47CnwgA
	 rLsv9zP0DN2ziDOpN1xzEsEz0vYQFV1k3XqzDqqRtnfdYNRq1XWU/B/kZLSQBN0aIewK/
	 DAYyg50n3AzytYQEUm4yf22T20841oqAHctjfaLXiEkcCXQvIvgKdw4raCYT8LoO7OWGc
	 dNN1OWR+NOOVat75m0npOM8HIEfubWQMlcrKNaMoBEA2kcKW6HfiO04LGGA8JNUXn07wE
	 tQPHBObp7iT87dnmDecq4rfW94pP5bgDOnjoldl9dOvaLCbos2YxxTNlbsynhXivPxA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7DBWjI7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79383606A323;
	Mon,  9 Nov 2026 03:53:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=V7DBWjI7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BFA11F008A2;
	Mon,  9 Nov 2026 03:53:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794196388;
	bh=gFBJfakuS7S903GKdWCSzwZK23A+CkZRWg+QCbzdmnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=V7DBWjI75udX6J2mvdboXY+1gK9F/dqhunVoO4bi978xTfbpn8cQLIOaY1nDgJkgb
	 PmzOecuK5PTVI7nEEJofdpMmvXawv+G4QPnTMNm5oIvjHB52noRlDGrrHbgJ0ikqwr
	 am42IoVyad1+YF+rAcmemLfNJE8g2YBmrLbb9H+N0aY2PB15cpk68qbRAR6GMYnRL0
	 IsoGJ/TF/8TRVNgoyrgEp0amDctC9Vsfs7ELFqK/LD85teSTHgNp9l+LBPXRf/oAiA
	 C6Nr9BFIznIPRfbYzfbl6O0BnfriYcrzvxkUECssf6+NI31SosnM1zDGxtu7xvI3vT
	 Sy45yRRNT2qCg==
From: Jonathan Cameron <jic23@kernel.org>
To: iio@vger.kernel.org,
	Miquel Raynal <miquel.raynal@bootlin.com>,
	Nicolas Ferre <nicolas.ferre@microchip.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Claudiu Beznea <claudiu.beznea@tuxon.dev>,
	Song Qiang <songqiang1304521@gmail.com>,
	Radu Sabau <radu.sabau@analog.com>,
	Maxwell Doose <maxwell@maxwelld.cc>,
	Tomasz Duszynski <tduszyns@gmail.com>,
	Erikas Bitovtas <xerikasxx@gmail.com>,
	Waqar Hameed <waqar.hameed@axis.com>
Cc: David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
	Andy Shevchenko <andy@kernel.org>,
	linux-kernel@vger.kernel.org,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	stable@vger.kernel.org
Subject: [PATCH 01/14] iio: accel: mma8452: unregister own trigger rather than current one
Date: Mon,  9 Nov 2026 03:52:39 +0000
Message-ID: <20261109035252.1295926-2-jic23@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109035252.1295926-1-jic23@kernel.org>
References: <20261109035252.1295926-1-jic23@kernel.org>
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

From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

mma8452_trigger_cleanup() uses indio_dev->trig to unregister the trigger.
That may or may not be the one it registered as this driver allows
triggers other than its own to be used.

Keep a pointer to the driver's own trigger in struct mma8452_data and
unregister that instead.

Fixes: ae6d9ce05691 ("iio: mma8452: Add support for interrupt driven triggers.")
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/accel/mma8452.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/accel/mma8452.c b/drivers/iio/accel/mma8452.c
index dc8031e14c29..f9abff3842fc 100644
--- a/drivers/iio/accel/mma8452.c
+++ b/drivers/iio/accel/mma8452.c
@@ -115,6 +115,7 @@
  * @orientation:		mounting matrix, flipped axis etc.
  * @chip_info:			chip specific data
  * @regs:			reference to voltage regulators
+ * @trig:			data ready trigger, if an interrupt is available
  * @buffer:			triggered buffer
  * @sleep_val:			time in ms to sleep while waiting for drdy
  * @ctrl_reg1:			CTRL_REG1 register shadow value
@@ -127,6 +128,7 @@ struct mma8452_data {
 	struct iio_mount_matrix orientation;
 	const struct mma_chip_info *chip_info;
 	struct regulator_bulk_data regs[2];
+	struct iio_trigger *trig;
 
 	/* Ensure correct alignment of time stamp when present */
 	struct {
@@ -1526,6 +1528,7 @@ static int mma8452_trigger_setup(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
+	data->trig = trig;
 	indio_dev->trig = iio_trigger_get(trig);
 
 	return 0;
@@ -1533,8 +1536,10 @@ static int mma8452_trigger_setup(struct iio_dev *indio_dev)
 
 static void mma8452_trigger_cleanup(struct iio_dev *indio_dev)
 {
-	if (indio_dev->trig)
-		iio_trigger_unregister(indio_dev->trig);
+	struct mma8452_data *data = iio_priv(indio_dev);
+
+	if (data->trig)
+		iio_trigger_unregister(data->trig);
 }
 
 static int mma8452_reset(struct i2c_client *client)
-- 
2.56.0

