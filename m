Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794319985;
	b=JrUE5+wwjT4n2NAh7szhPIQUu/fAJkZ2Lp/jg4i3XBEMsNxTLXW8KDZtgEzmSx55XJmp
	 YAMafi7KQgWXmvAwc6oxLTruO75j4du2PczE3GeZvrLhO9UeqXws0yf3StB/brL5smdDf
	 ugkvhn0mNEW298l/ieGZaaXstsZG59ioYnchExsCOVScyBUrqMAQfHdV+/L5+lv9OZMZ1
	 ClXNKrRM7pnK5i7AgsIeuZthSiol7E0hxSQpPXRLnpQYWxiiG3mWnQwEvmyYziJaGYHXb
	 1WsuSoyo1JrAcYN0D0HdjqK+Q+aBNuis0F72WqmdnyvYlMmw1gY3iCngOHY8hKpcojw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794319985;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=U6G8C1StT8tD2z7xJpVquXVgvHoDA6RCeGVAiWk6SnM=;
	b=i5auUzb9prWd7BC8QyaJ5g69jhvalI9AbLSKy30e54por4GpqHQWjYPmPkePByHe0WLf
	 qkzszVo5XKLfVCqTyIgWG8W0sF4TwpoIdr/+deqN8qSjZl8pPgQQhAFDOr549QSsIGpsa
	 jxtT/wI3GhulbAbxwCastR24MrK3sxkJA/XuQwu20PtnwWUwWxlzwKpvixOlY8yaHv0az
	 eWiQ+1XEsvzhpMvyVB5QzRtgITLp/oNp8xHTNJy6QDLa0Vs3N2JZYyFAJLfuWtTOgY/jt
	 9qptkAu9WC1XWf0IHGRkFqf3opb+5Skb+APa+jXW4zHNEvUCyupSh2uBz8GK7gsoZBg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JItxA5Cr;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E3DAB606A338
	for <stable@vger.kernel.org>; Tue, 10 Nov 2026 14:13:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JItxA5Cr
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E94E81F008A2;
	Tue, 10 Nov 2026 14:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794319984;
	bh=U6G8C1StT8tD2z7xJpVquXVgvHoDA6RCeGVAiWk6SnM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=JItxA5CrZSKxVE2og/Gg7aK911bf2TgOySMBseY7zIWrh6BOO+iSUCjEXX/39VZAP
	 rYRSJClR/G7mzkyN1tUzqGcDAXguL0vvK3v2aH1U6GhpsHE0WvWO0xvG+yTngJGuB6
	 Eq3G9HiH8mpauDZZkBvVVbODj6h05lJVG3c9aDYlDvuVQe5aJAevbnD+7PQ6Hp2v9G
	 gWa31MoO3Kb0ukktfyjE4SbzJJ9CjytX29DIFSJkQre6PmW12gjDIc4oRTFKqS/NzZ
	 0rg4agLrVJ1gkHuYvouVQNjw5HJ6a4PgVtybAN3pbh9augni6kDP+XlxIJ4mqRCwvX
	 kJOqor+UsqnGQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Jiale Yao <yaojiale02@163.com>,
	Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: dac: mcp4821: reject devices without match data
Date: Tue, 10 Nov 2026 09:13:01 -0500
Message-ID: <20261110141101.1850038-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261107051800-failed-6.12-6ac1faf4de61@kernel.org>
References: <20261107051800-failed-6.12-6ac1faf4de61@kernel.org>
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

From: Jiale Yao <yaojiale02@163.com>

[ Upstream commit 6ac1faf4de61dcf27ffe8f2c25d96fe5f4b2886d ]

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL,
but mcp4821_probe() dereferences the result while configuring the IIO
device.

Reject devices without match data before using the chip information.

Fixes: cdf3ecb0d8d0 ("iio: dac: driver for MCP4821")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
[ sashal: adjusted context due to missing default gain initialization ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/mcp4821.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index c1a59bbbba3cc..9e4a3cb2a7120 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -172,9 +172,13 @@ static const struct iio_info mcp4821_info = {
 
 static int mcp4821_probe(struct spi_device *spi)
 {
+	const struct mcp4821_chip_info *info;
 	struct iio_dev *indio_dev;
 	struct mcp4821_state *state;
-	const struct mcp4821_chip_info *info;
+
+	info = spi_get_device_match_data(spi);
+	if (!info)
+		return -ENODATA;
 
 	indio_dev = devm_iio_device_alloc(&spi->dev, sizeof(*state));
 	if (indio_dev == NULL)
@@ -183,7 +187,6 @@ static int mcp4821_probe(struct spi_device *spi)
 	state = iio_priv(indio_dev);
 	state->spi = spi;
 
-	info = spi_get_device_match_data(spi);
 	indio_dev->name = info->name;
 	indio_dev->info = &mcp4821_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.53.0

