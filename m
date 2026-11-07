Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046682;
	b=chWbAy1K4FRHP3FKP8o31qjYdftOGVm0ZCD5QRZ41P2GTWPF+y42lK7zZe8gWudA7W6N
	 wLSDZqMGEx8b1Ul7iPteAQ11xY4L+ydYWdQgCjhHktbeoCS2DqM1WEZw+14IKN5bvLo5M
	 8KsZ7K5CgRy41txjgFLoAOCNOV60jlWpp6LF+OUrfrbfsLpKQr/73XruX9XtDTkFGP0Kg
	 0xe1y7I9ONgMYZoWH9aShxa3L1xdHS0CuIstW1sOgyEUyyHyETpZ9sA0/exbIh26F/wU+
	 rkm7tFj4PewMQu/dQRGEm9horwpuoq8FcytCZe8bWxTB2J25gIkT/TWav6OdaO9NZlg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046682;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=BgJoEiGccGyr8Cb9K4QFkufCTqJ1SbyVrLp/O6RVjmg=;
	b=ruMQYEBF5xql1B/iPLNcALyrclBu84sDPWAwrrfA4d4uN/OeSxhNIdT1lPbR3ZbYAze6
	 GebbANsPDX4BULRK/kzFMd+ub+K5pHDW2Rfk5irXhuYlbUz65HVzI3GjeI0+9mLf504Qs
	 JgOWAGt3nUgvJ2c8aH/ewO7Nf5wiSxYmq0oNG0zcGL+UCU6jkSOk88yCaYwR1qpO5aeyj
	 /AHO2gb1DTK2xX3tpWkM5hjG/tE374EgiWsiAoeOTJnkmDQm8VPpZnlzQBwPmmogU6J4o
	 YvLn6nUctg5fE0WPeHU19G6qxFja2/GVI2bP2G0Uy5GFnQsrvUcr1xZLPfxG2UlDbZA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILPm8zXU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1D0D2606D836
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:18:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ILPm8zXU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8F8B91F0089F;
	Sat,  7 Nov 2026 10:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046682;
	bh=BgJoEiGccGyr8Cb9K4QFkufCTqJ1SbyVrLp/O6RVjmg=;
	h=From:To:Cc:Subject:Date;
	b=ILPm8zXUFtW6bn2C6POvuRZFzZRz9UvWIhpImhoCBtRXQSWy7R6Tq2tl4S1XYV+2j
	 G9vSoNKs+wIf0zpuKpIveTDfTMctgfwVlXvyfHmyUk7hGAZLfyretwvqjSyx/NVOEZ
	 xgzwLc6LvzGRDTsnXt/kIgPbgVfTyJsZmZPVt2tywjIGEizZ4ScrtYTOnZQIuAeOAw
	 kIO7EKRdN2kGnMFBhSqeitfXPvzeIq+ypf9DIb5MtAhFgxWwYJdp1NeO7QkwMMSyQ9
	 bGL6pHBfiN/cVVs5YR2nSKOQMAVxM9cQO5ZtePVqusI53egkirMeflFWxOswFPC0q6
	 v48kx3LQadzmw==
From: Sasha Levin <sashal@kernel.org>
To: yaojiale02@163.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: dac: mcp4821: reject devices without match data" failed to apply to 6.12-stable tree
Date: Sat,  7 Nov 2026 05:18:00 -0500
Message-ID: <20261107051800-failed-6.12-6ac1faf4de61@kernel.org>
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
git cherry-pick -x 6ac1faf4de61dcf27ffe8f2c25d96fe5f4b2886d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107051800-failed-6.12-6ac1faf4de61@kernel.org' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Thanks,
Sasha

------------------ original commit in Linus's tree ------------------

From 6ac1faf4de61dcf27ffe8f2c25d96fe5f4b2886d Mon Sep 17 00:00:00 2001
From: Jiale Yao <yaojiale02@163.com>
Date: Fri, 25 Sep 2026 21:17:32 +0800
Subject: [PATCH] iio: dac: mcp4821: reject devices without match data

A device bound through driver_override need not match an entry in the
driver tables. In that case spi_get_device_match_data() returns NULL,
but mcp4821_probe() dereferences the result while configuring the IIO
device.

Reject devices without match data before using the chip information.

Fixes: cdf3ecb0d8d0 ("iio: dac: driver for MCP4821")
Signed-off-by: Jiale Yao <yaojiale02@163.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/dac/mcp4821.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/dac/mcp4821.c b/drivers/iio/dac/mcp4821.c
index 8d8c00cd60e98..59defb1b5e621 100644
--- a/drivers/iio/dac/mcp4821.c
+++ b/drivers/iio/dac/mcp4821.c
@@ -255,9 +255,13 @@ static const struct iio_info mcp4821_info = {
 
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
@@ -268,7 +272,6 @@ static int mcp4821_probe(struct spi_device *spi)
 
 	/* default gain is 2x */
 	state->gain = 2;
-	info = spi_get_device_match_data(spi);
 	indio_dev->name = info->name;
 	indio_dev->info = &mcp4821_info;
 	indio_dev->modes = INDIO_DIRECT_MODE;
-- 
2.53.0




