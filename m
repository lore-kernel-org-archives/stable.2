Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795810325;
	b=4IvKpjwDF3A3BsWwLjp3DqH2K+BG4QolRr8wIMGA7USxvOrUFb7zVpTgLJ2wNiCTSrhb
	 vYIBGoLBQ9NPRlW6BCgZygec8BG1BdHxiLZkm65oW9xgVp06J+5xxZwP8UN+vrIuLTxbw
	 A/an46r2JMmyfUS8YCkkiE+IbBUm+DYm12xgtMwhPQNfB0zd1gUP70078dlHC53s5Q1Vz
	 dZ7tPAojnbWgOawMQerwXdISU8qMGdxuYoROtz7TDL3GRjVIz7fvYU3LfhZSLotW+QtIQ
	 wcZMrQWq+oFHi/wIMyX4XnfD6pgybcsIrogN8JHpZvKYleJn2qqzN/yc4TNIZVNRVdA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795810325;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=CCly3rZMe1dgoSUn0QwNJDq5FBoYCOT3mQ2g/MvPn10=;
	b=Xatqo5WEg9WYIbvuC82Lxcu+Q65y50Pr2KRBe41ivBZbnKV3tBLStt55gcLOt5xGsHzj
	 Tce4Ez0bzNWd7f6LFVJJY45ZKjL1aVZeuHO4DxzGvtXYO/J2p0p452QaZVz9Ok/jqWXUZ
	 Lsnr87bgmP6Z5uMZC16p/DMLGOdZSbyQhuIz+N7Sz8dSl/nOTNoPWEWVViOkPT+tSE6/6
	 /pon/x1yfYAbABmUr2wkmtvUwCZCuUb0zRl/trOFl7KmAZC0nEdp70eyhTz12eveuMFw/
	 pHtaI+1b5ZxZGcqS9GSb+KQ3oq2Ho6AxCpDx4Ll1tdSGXskIM/c+0o6N8gO/SqPHGnQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="mjS/MOyG";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE2E7606A31F;
	Fri, 27 Nov 2026 20:12:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mjS/MOyG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9A7E1F0092C;
	Fri, 27 Nov 2026 20:12:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795810325;
	bh=CCly3rZMe1dgoSUn0QwNJDq5FBoYCOT3mQ2g/MvPn10=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=mjS/MOyGrMjZbznHRUaRqvRxvzE2u4zNX9QYjRFyAuo1GV6/fyi0wEa83zCZ4ywYu
	 R7JvmLRAZ/r631Y3C4OdvWzuMG/pCJ7Ky0C6UXyzIx/qVD3EZNlIbscorzxEnbB6Pv
	 sYT7Nkc5wOaXih+DoBS5I45rgK/E1nkRk3jS8qZYh8+WfjLfH5OEwQAVnBVr5FyNh+
	 GUK3bZ8od8sjbOSCBHhzCTPdzp05XSEtHaxkgmZaPgJBa+fp9P0foCBTMG6+1cieFM
	 PZP+uY3yk9fRVsEf5jhL69fpNumngHfew4YyNsHsobgBxlPii1fIk+9VVHkPYt4e1Z
	 xULAyPW+Umzhw==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Hans de Goede <hansg@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>,
	Neil Armstrong <neil.armstrong@linaro.org>,
	Jeff LaBundy <jeff@labundy.com>,
	Jens Reidel <adrian@mainlining.org>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 10/10] Input: goodix_berlin_spi - validate ic_data and SPI max transfer size
Date: Fri, 27 Nov 2026 20:10:04 +0000
Message-ID: <20261127201050.3532488-11-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.839.g22a8290db9-goog
In-Reply-To: <20261127201050.3532488-1-lee@kernel.org>
References: <20261127201050.3532488-1-lee@kernel.org>
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

goodix_berlin_spi_probe() dereferences ic_data without checking
spi_get_device_match_data() for NULL, and subtracts the SPI read and
write prefix lengths from spi_max_transfer_size() without checking that
max_size exceeds both prefix lengths.  A controller reporting a small
maximum transfer size causes an unsigned size_t underflow (or zero
max_raw_read/write), bypassing regmap transfer chunking.

Return -EINVAL if ic_data is NULL or if max_size is not strictly greater
than both the read and write prefix lengths.

Fixes: 3aa182bbc5b6 ("Input: goodix-berlin - add SPI support for Goodix Berlin Touchscreen IC")
Fixes: 4d395cb071a3 ("Input: goodix_berlin - add support for Berlin-A series")
Closes: https://sashiko.dev/#/bug/linux-a8b8e506-08b4-44c4-bf67-3c8ef31c6da7
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/input/touchscreen/goodix_berlin_spi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/input/touchscreen/goodix_berlin_spi.c b/drivers/input/touchscreen/goodix_berlin_spi.c
index 01f850f484c2..377c81a3e3c5 100644
--- a/drivers/input/touchscreen/goodix_berlin_spi.c
+++ b/drivers/input/touchscreen/goodix_berlin_spi.c
@@ -133,6 +133,9 @@ static int goodix_berlin_spi_probe(struct spi_device *spi)
 	size_t max_size;
 	int error = 0;
 
+	if (!ic_data)
+		return -EINVAL;
+
 	spi->mode = SPI_MODE_0;
 	spi->bits_per_word = 8;
 	error = spi_setup(spi);
@@ -140,6 +143,9 @@ static int goodix_berlin_spi_probe(struct spi_device *spi)
 		return error;
 
 	max_size = spi_max_transfer_size(spi);
+	if (max_size <= max_t(size_t, ic_data->read_prefix_len,
+			      GOODIX_BERLIN_SPI_WRITE_PREFIX_LEN))
+		return -EINVAL;
 
 	regmap_config = goodix_berlin_spi_regmap_conf;
 	regmap_config.max_raw_read = max_size - ic_data->read_prefix_len;
-- 
2.56.1.839.g22a8290db9-goog

