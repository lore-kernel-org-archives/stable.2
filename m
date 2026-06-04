Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E600F368D78
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 15:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780588155; cv=none; b=RLPOzQk5XXj/BlaGmlE5oT58/5q2J1UMpHwz7SMCMGh8Ct07BVwRpiWT7WmK1Ztmxdq6Aas1jgJbFR9Urh3ZHIrCbVO1VPTRJKzj5kFAiCWUhw0vtQKu6R6kZBhVKGVzN9ChMlEyvSuW1xCdIgAuqG/U20+5zmoHVfrCpJmBQOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780588155; c=relaxed/simple;
	bh=8Ah4HNJ61Iv3IAd/b+HBoIE8FqJEUK6sa6mMuaq+Gvk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ccPX6lUOYYzRYToxNNnzLSGz30cxpLBGGajbyJ/ulNcYsQSk9TTJxgaLIjeIKIPWfh7zTQ7NR1YEQPlI3yKr0uIpEg3SSWBg+gXNunjqoBbpktVIrhs0EZ1ASxP60XPa7nGYvuWJ36oHgroYSY2MtAuBSyDEm56JwgbugkmKECk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k8baUncI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k8baUncI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE45C1F00893;
	Thu,  4 Jun 2026 15:49:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1780588153;
	bh=vr3ZL54SlJEL62MS6MQuWKSIW/Vsbt2gekVM+VAV9aE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=k8baUncItAt1Zir45Hxrvbr0DDsRnajHJp+sF09vL45Oji1HNHrdxtU/AHTy199GP
	 1i7UXPAAViTi8qMPHKDZ8J9PDua3m7p1cupM9v57j58leggEn9mXLLu9uRGqSW8m4S
	 JVm5dSNf3Z/f2Rkx9CJ87O1rIJI6W5ZRgl/YexIZG+qkWob7PHTH2soscFiunLrA59
	 ojloMj3FC8yPySD8vrp78c/XQ6taa2JODZ8ffQxiKTop5/L0klfb3AdAV7rdxtHbPB
	 oTCfVPgJgZ1X5f+oezEMMTzqi2b5BzN1c3e3QI3RM3TfrFLk/aEaLw9BGQ7++W8iKu
	 9x7d0kD6ZO0GA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Rodrigo Alencar <rodrigo.alencar@analog.com>,
	Stable@vger.kernel.org,
	Jonathan Cameron <jic23@kernel.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] iio: dac: ad5686: fix powerdown control on dual-channel devices
Date: Thu,  4 Jun 2026 11:49:11 -0400
Message-ID: <20260604154911.3732174-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026060440-ruse-buddy-b7b7@gregkh>
References: <2026060440-ruse-buddy-b7b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Rodrigo Alencar <rodrigo.alencar@analog.com>

[ Upstream commit 8aeaf25a85263a7a43357e16ad78ab969f6f8aeb ]

Fix powerdown control by using a proper bit shift for the powerdown mask
values. During initialization, powerdown bits are initialized so that
unused bits are set to 1 and the correct bit shift is used. Dual-channel
devices use one-hot encoding in the address and that reflects on the
position of the powerdown bits, which are not channel-index based
for that case. Quad-channel devices also use one-hot encoding for the
channel address but the result of log2(address) coincides with the channel
index value. Mask as 0x3U is used rather than 0x3, because shift can reach
value of 30 (last channel of a 16-channel device), which would mess with
the sign bit. The issue was introduced when first adding support for
dual-channel devices, which overlooked powerdown control differences.

Fixes: 7dc8faeab3e3 ("iio: dac: ad5686: add support for AD5338R")
Signed-off-by: Rodrigo Alencar <rodrigo.alencar@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/iio/dac/ad5686.c | 46 +++++++++++++++++++++++++++++++---------
 1 file changed, 36 insertions(+), 10 deletions(-)

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 4c9f7ade52b32d..d9002ee8bb7aca 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -25,22 +25,37 @@ static const char * const ad5686_powerdown_modes[] = {
 	"three_state"
 };
 
+static inline unsigned int ad5686_pd_mask_shift(const struct iio_chan_spec *chan)
+{
+	if (chan->channel == chan->address)
+		return chan->channel * 2;
+
+	/* one-hot encoding is used in dual/quad channel devices */
+	return __ffs(chan->address) * 2;
+}
+
 static int ad5686_get_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
+	guard(mutex)(&st->lock);
+
+	return ((st->pwr_down_mode >> shift) & 0x3U) - 1;
 }
 
 static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     unsigned int mode)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
-	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
+	guard(mutex)(&st->lock);
+
+	st->pwr_down_mode &= ~(0x3U << shift);
+	st->pwr_down_mode |= (mode + 1) << shift;
 
 	return 0;
 }
@@ -55,10 +70,12 @@ static const struct iio_enum ad5686_powerdown_mode_enum = {
 static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
-	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
-				       (0x3 << (chan->channel * 2))));
+	guard(mutex)(&st->lock);
+
+	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (0x3U << shift)));
 }
 
 static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
@@ -78,9 +95,9 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 		return ret;
 
 	if (readin)
-		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
+		st->pwr_down_mask |= 0x3U << ad5686_pd_mask_shift(chan);
 	else
-		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
+		st->pwr_down_mask &= ~(0x3U << ad5686_pd_mask_shift(chan));
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
@@ -460,7 +477,7 @@ int ad5686_probe(struct device *dev,
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
-	unsigned int val, ref_bit_msk;
+	unsigned int val, ref_bit_msk, shift;
 	u8 cmd;
 	int ret, i, voltage_uv = 0;
 
@@ -495,9 +512,18 @@ int ad5686_probe(struct device *dev,
 	else
 		st->vref_mv = st->chip_info->int_vref_mv;
 
+	/* Initialize masks to all ones provided the max shift (last channel) */
+	shift = ad5686_pd_mask_shift(&st->chip_info->channels[st->chip_info->num_channels - 1]);
+	st->pwr_down_mask = GENMASK(shift + 1, 0);
+	st->pwr_down_mode = GENMASK(shift + 1, 0);
+
 	/* Set all the power down mode for all channels to 1K pulldown */
-	for (i = 0; i < st->chip_info->num_channels; i++)
-		st->pwr_down_mode |= (0x01 << (i * 2));
+	for (i = 0; i < st->chip_info->num_channels; i++) {
+		shift = ad5686_pd_mask_shift(&st->chip_info->channels[i]);
+		st->pwr_down_mask &= ~(0x3U << shift); /* powered up state */
+		st->pwr_down_mode &= ~(0x3U << shift);
+		st->pwr_down_mode |= 0x01U << shift;
+	}
 
 	indio_dev->name = name;
 	indio_dev->info = &ad5686_info;
-- 
2.53.0

