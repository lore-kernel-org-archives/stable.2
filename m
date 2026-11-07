Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046684;
	b=4JgAbFGlYaJwZ8LpTn/7DGADTVbD6Jy1a6pBGk+n1VqGlAXGi5Q+2zTgVTq7AT2nRa0+
	 V9E3G+zVNHLtfrt1VtaXnByXBmjIBlqj4PZd395vl1QFUontys1My9kUUDMV7WKPfosXL
	 LiwIMxgfxenvebJGgNG2QWDVCCvKQjfC5Aea9SIfMe6AxBSW23E8QNmQ0d4M8KYjkSUo3
	 +sBw5fYMA5eOfqTjDKTzn4rLKTH3unvXX1tSpqnQN7GYws00ItcA3IQRW4Dh1S2Jhw8ho
	 cvvSJ7Up20sTrBzw5BrzyPijopSUKJBOw3gL+mpPF5162LnWDstnNho8zTgPLnNv0Ww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046684;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=Nd9A3lEQamOgOobaldHFCAejXOW2Z32E0rLXS0ngeyQ=;
	b=mrexIKzgv3fM9Tc0WeivFDz1bgUSI5IBHKIrNdDDmqQT2FcMrVLWpRgSxh9h6D7LQuqi
	 AkTYz9NbkaLyjHzQTMqsQuUgPAKtuyGBDKnVUaGgC9DGNHaqfSHayML+A/7K5C+FWfTv0
	 UcDLp4zvi7T/YckhRp3t4FG/h3Grw46RZfVeGHOhHi9B0ZsiRujy/1k/kZgmtmfIWatk7
	 9N1J/R5XRpk911y1sMOwANEQAqvCQirIAcKhEbjvryg/N6/U04SFK87XEU1xVEMoDv0vx
	 4j0gJWvSwBCCwINlAk/Ox7gTJStcCz/rJQZ26mKCv4xGnJBdPfu0ZkKxW+zHTf1FgMA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpbfrlAc;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B711606D812
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mpbfrlAc
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E8A41F0089F;
	Sat,  7 Nov 2026 10:18:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046684;
	bh=Nd9A3lEQamOgOobaldHFCAejXOW2Z32E0rLXS0ngeyQ=;
	h=From:To:Cc:Subject:Date;
	b=mpbfrlAcRnVU8ND28cFhxYNi6T2MwfSaoeRofX2IYYQqIUJfsj92FQ84cVK0EVSf0
	 TDLwK5hYFsHHQo9Qr2UZuLii9BUbGml9oVNWIOlHH2MHqOgs0Cr/rEoZ2L4HvVU6/e
	 zNUaT3u0+ilakaVAeeFhk8QzpZBTmXfSI59Ksi0ix5hTm4CcOcl87wDuVk5VaJZ5cz
	 +C+zQkkX4y+V2jvsZiGvFIIYigjddD+JS6VxFhIDaRCJYdX/YiQ4eNpP+4jB9rKrKp
	 Q+KZK3vLW23ZAHuK3z9b9stdqNo9VAOOLKNd94jX+bF7pGKwJ57vQcbnKxN2tw2FJJ
	 kf1tcBFGPd8sg==
From: Sasha Levin <sashal@kernel.org>
To: yaojiale02@163.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: adc: ad7192: reject devices without match data" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:02 -0500
Message-ID: <20261107051802-failed-6.12-7f7a119a370e@kernel.org>
X-Mailer: git-send-email 2.53.0
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

The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 7f7a119a370ecf6c8d4ab9e9ee0a8cdd77afedd3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051802-failed-6.12-7f7a119a370e@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 7f7a119a370ecf6c8d4ab9e9ee0a8cdd77afedd3 Mon Sep 17 00:00:00 2001
From: Jiale Yao <yaojiale02@163.com>
Date: Fri, 25 Sep 2026 20:57:39 +0800
Subject: [PATCH] iio: adc: ad7192: reject devices without match data

SPI driver_override allows a device to bind to this driver without
matching either the OF or SPI device ID table. In that case,
spi_get_device_match_data() returns NULL.

ad7192_probe() immediately dereferences the returned chip information
to initialize the IIO device, causing a NULL pointer dereference.

Commit 572a00852635 ("iio: dac: ad5686: missing NULL check on match
data") fixed the same driver_override issue in another SPI driver.
Reject devices without match data before using the chip information.

Fixes: c3708c829a06 ("iio: adc: ad7192: Convert from of specific to fwnode property handling")
Cc: stable@vger.kernel.org
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ad7192.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/adc/ad7192.c b/drivers/iio/adc/ad7192.c
index d8f5886fcf694..8bd8105463111 100644
--- a/drivers/iio/adc/ad7192.c
+++ b/drivers/iio/adc/ad7192.c
@@ -1406,6 +1406,9 @@ static int ad7192_probe(struct spi_device *spi)
 	st->int_vref_mv = ret == -ENODEV ? avdd_mv : ret / MILLI;
 
 	st->chip_info = spi_get_device_match_data(spi);
+	if (!st->chip_info)
+		return -ENODATA;
+
 	indio_dev->name = st->chip_info->name;
 	indio_dev->modes = INDIO_DIRECT_MODE;
 	indio_dev->info = st->chip_info->info;
-- 
2.53.0




