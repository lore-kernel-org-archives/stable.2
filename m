Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794198554;
	b=BdZu5WDr2dahP10ntzAKLUV3qtsgp1vV6u839WVerSsouT3aeozQbrwz7yArvxj3+anb
	 Ioq7JxUMU01hJBQMrkInVCYiqIpgz5fx0Yejo/PyjfBM6OZP6//0rb/tZjUHX/RrGaw2n
	 mA86SU3vOFQ2RK0hgR5lEmb7rbS+nOwesRCqWddbprb2XYfW6xwhLkSadvH9XpQIPt0uU
	 jDo+HodENDhKtoywLdhLHGdmdqD7G4PFnl9Er1nfHd/5zGyOA0bSULwYhP3dsMsNNSwBQ
	 IESRNL/9divmwhGwRTISvmexuT6ZKSSKxz6SV+J3bX+AwJYKoEK/cSK8/6OeXBf72AQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794198554;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=gFBJfakuS7S903GKdWCSzwZK23A+CkZRWg+QCbzdmnM=;
	b=WCi9yn8IpqY7zZ+x8F2z5sgPvF1OXz18x3XxjLkx2LszjQZVtV4zJrK4XaOJ3V0LIkCr
	 dSigWn79lKHhSDJ4eidIEM/61vlXyi8tvs+3lswc7krR4aXJK2mpIXLvm91USL+4jS1Df
	 5MO5Z9r4qNDwoCFV6NywfA1riw4/ECXDv1roMlqvI+oTNyTydATMBCF1SJ7WJB0O2aIgA
	 j/k7G8WOLK+pAFFHVBogDzPNPIZSkdebNvi7w8bvQtC+3pTGLC2yM2S4iq67HcuhNy7XA
	 wMJDMzClxOAySInyG9HnV6PGfKQNW9cagO716MEhF2EwdcnPjmtmC4fVJepf901LhAw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XbwhGkeh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56ABB606A33D;
	Mon,  9 Nov 2026 04:29:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XbwhGkeh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CAEC1F008A1;
	Mon,  9 Nov 2026 04:29:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794198548;
	bh=gFBJfakuS7S903GKdWCSzwZK23A+CkZRWg+QCbzdmnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=XbwhGkehFoAlkqUV8HG2dzqw/5SM5Fr/R0aUYDkY6L0e8yv0wB/Bb3ZSOESJgim0f
	 PMUm2ErAX5byg9g4jPcRp5NvtXEZXWoxNOEkC4kUq2j0rgke1NPxERd/F3n4zg3zxr
	 xpacPe9n1oLlrLnq5Ql4KrKaw6gPuq8QstCFo0N1fwAfWsHnHFjPYupLdzTt30nJBB
	 EoRWwcOKtu2Xff5KV8RmPPe1kkNlX2KI/0jkHP//sG2dOZnz8wV2ifA9zFXhJj/ryG
	 z+qt5R2ACMyNmq0m17JSrb0MQZQ3d7elxaRI7Xl2T08t8CK9D7QFsF5Ic2QUClsySc
	 LkUuex81GdQZg==
From: Jonathan Cameron <jic23@kernel.org>
To: linux-iio@vger.kernel.org,
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
Subject: [RESEND PATCH 01/14] iio: accel: mma8452: unregister own trigger rather than current one
Date: Mon,  9 Nov 2026 04:28:38 +0000
Message-ID: <20261109042851.1326940-2-jic23@kernel.org>
X-Mailer: git-send-email 2.56.0
In-Reply-To: <20261109042851.1326940-1-jic23@kernel.org>
References: <20261109042851.1326940-1-jic23@kernel.org>
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

