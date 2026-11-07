Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794046050;
	b=fq4o6YpzDVTa/BIRiw3Jb99hdWg6vRre55C/JX6E99col4XlhB+gqHa87TcZ8LfBYHS0
	 T4NPseN1Vkd+EftuP6lbAnHSmpSN6bMhLXPf20+ZRryBJELH77zO9w0CiqiXY5kM9BeUd
	 GfxOpqbDrrcCjDU2yQEs13eDgaZ2kn1RJ3XVWoEm+zx3ZYvuUaxR8lQabhHZR6Hfh99m3
	 /fqYLaL8FCDahYD8biLzvzKEBc5SKa69WS17VxFUYU35HFG3LlETlK/YeBPkj2L1mIDFq
	 zV2IumAIpXhfCXg9FlZCb3Bd57op9/A3U8OQgnDERPuHWazCLE4tJ502XhNAmmJNFkg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794046050;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=WPrHFHOv2pYes/wEa537DHPXDbFpak69lIYQlwhyTuU=;
	b=2Gn6Jzrq+LEQgBMTq1D1GcAJknH6KS+cNcIMfUnk+kvwxVJOEDStkXOHhAUhn7dcaLCG
	 gmQrfBK7O3+pieyFaY1nqDWJZ9/VNovsnCmXRp/y0ckMKBGolS3v51R3Ny+O2hwC2yx/i
	 szIn2MIpe/9xtnr2dPfC7vVXQH+7VOIlXl9pzeXey8cf1rZDG5C+vWjYwXNaSJevnCsDF
	 6oXrDdca/4BgQ2WGvE1fHil+Kz2AnUoTIxXpLr1HasOhkovCYYwu/dcMPquMXKIsLzg9V
	 ivZRBVVlqINpcqzTO6/sHhAXpfcUBsb64U23rRfCmrGF9e8Thw2Wxp3Lln+te7H2gTg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R21VH6VD;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 535CF606A32C
	for <stable@vger.kernel.org>; Sat,  7 Nov 2026 10:07:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=R21VH6VD
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B9541F0089F;
	Sat,  7 Nov 2026 10:07:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794046050;
	bh=WPrHFHOv2pYes/wEa537DHPXDbFpak69lIYQlwhyTuU=;
	h=From:To:Cc:Subject:Date;
	b=R21VH6VDtww4YFOKxcWUySLqN5V+tQ/OUEAmMIa6cACv/60QchXwsUeNcojOJoNph
	 skUOdL5z4axxl+s1QvFvJgYrT9lD163sa7nLUHuWohINyeDu8xTHQWgs7viFQ4YZsF
	 PZQ0tkPO7BiWMBX1eIYM6U+iLORapADOrJb9z9EMNLu2u+KYN+kvBTTtdutDDrajLL
	 T4hdJtc/MPmFowfwjmob9ebje4jH/Ab/MkkH8G6EKGqDoTL8Q+bDjXGOjU/e/hgn6O
	 wnyheoS0ktx0vDiwAWuxTWv2Mdqd/cUPhwzlc1qe+sRXMPa6AZe1qJXdSDZOlEca1l
	 u2lHAlkb6Fdeg==
From: Sasha Levin <sashal@kernel.org>
To: yaojiale02@163.com,
	jonathan.cameron@oss.qualcomm.com
Cc: stable@vger.kernel.org
Subject: FAILED: patch "[PATCH] iio: dac: mcp4821: reject devices without match data" failed to apply to 6.18-stable tree
Date: Sat,  7 Nov 2026 05:07:28 -0500
Message-ID: <20261107050728-failed-6.18-6ac1faf4de61@kernel.org>
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

The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 6ac1faf4de61dcf27ffe8f2c25d96fe5f4b2886d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '20261107050728-failed-6.18-6ac1faf4de61@kernel.org' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

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




