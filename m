Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A3B3ED5CC
	for <Stable@vger.kernel.org>; Thu,  4 Jun 2026 08:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562738; cv=none; b=JYKTg4ahdAbgMrexFIs/ui2MaL1VKwG8jiGy5mgFaTcaT8fCxRbrEopWlM036n9gDMD9VEpZ2Edsr/OVxXncs2D+5H+MdiqwKzcOlA8Gdrnua1LP70TIya3p+41Ai+MJR7C+PE9aNA8hIA8STQaRY95fUlsxZreoPIdikDfiJBo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562738; c=relaxed/simple;
	bh=psqp5wL7dLrIisaDdQXMDjYDNVu7P3B79dEnPxut2LA=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=cR/2a31isvUj9YXN4kQRx+CCrMlhyMnH5Pv76DF62n4QsSdHH3n66mZW4uIgDRm/cm0S3CUhZ1LOXhzkA6jQq70DgSsH6fJqI/QmpAJVh9yrjxbW8kbowQkYcZu0DSgYZgYWnxa3ci/GO1cMMmtrIkGb+1INyUNmAy+xS2L2ziM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=u5+6hIzK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="u5+6hIzK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C0B081F00893;
	Thu,  4 Jun 2026 08:45:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562737;
	bh=ZCpKEvS7HYgSzDnvANetVOFZ+qPM61iSE7ldCf6XV30=;
	h=Subject:To:Cc:From:Date;
	b=u5+6hIzKyROempP7svou0oeCexI43C8toY5C5VWoZZE/dwvLsggyC+uEJoEUoOxD5
	 TJSyhdvmehqwt80xJoOPxRH95/x9njDFHXba8fuPRT66w7iCbWlU+p+bXvYH3JwThv
	 mChCd6zoQHoVx/gGgsf05Yoli/SQd1IRy3/UjtPM=
Subject: FAILED: patch "[PATCH] iio: dac: ad5686: fix powerdown control on dual-channel" failed to apply to 6.12-stable tree
To: rodrigo.alencar@analog.com,Stable@vger.kernel.org,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:44:40 +0200
Message-ID: <2026060440-ruse-buddy-b7b7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 8aeaf25a85263a7a43357e16ad78ab969f6f8aeb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060440-ruse-buddy-b7b7@gregkh' --subject-prefix 'PATCH 6.12.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 8aeaf25a85263a7a43357e16ad78ab969f6f8aeb Mon Sep 17 00:00:00 2001
From: Rodrigo Alencar <rodrigo.alencar@analog.com>
Date: Tue, 5 May 2026 13:35:05 +0100
Subject: [PATCH] iio: dac: ad5686: fix powerdown control on dual-channel
 devices

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

diff --git a/drivers/iio/dac/ad5686.c b/drivers/iio/dac/ad5686.c
index 2e443fcfeb39..a7213bc6b156 100644
--- a/drivers/iio/dac/ad5686.c
+++ b/drivers/iio/dac/ad5686.c
@@ -25,26 +25,37 @@ static const char * const ad5686_powerdown_modes[] = {
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
 
 	guard(mutex)(&st->lock);
 
-	return ((st->pwr_down_mode >> (chan->channel * 2)) & 0x3) - 1;
+	return ((st->pwr_down_mode >> shift) & 0x3U) - 1;
 }
 
 static int ad5686_set_powerdown_mode(struct iio_dev *indio_dev,
 				     const struct iio_chan_spec *chan,
 				     unsigned int mode)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	guard(mutex)(&st->lock);
 
-	st->pwr_down_mode &= ~(0x3 << (chan->channel * 2));
-	st->pwr_down_mode |= ((mode + 1) << (chan->channel * 2));
+	st->pwr_down_mode &= ~(0x3U << shift);
+	st->pwr_down_mode |= (mode + 1) << shift;
 
 	return 0;
 }
@@ -59,12 +70,12 @@ static const struct iio_enum ad5686_powerdown_mode_enum = {
 static ssize_t ad5686_read_dac_powerdown(struct iio_dev *indio_dev,
 		uintptr_t private, const struct iio_chan_spec *chan, char *buf)
 {
+	unsigned int shift = ad5686_pd_mask_shift(chan);
 	struct ad5686_state *st = iio_priv(indio_dev);
 
 	guard(mutex)(&st->lock);
 
-	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask &
-				       (0x3 << (chan->channel * 2))));
+	return sysfs_emit(buf, "%d\n", !!(st->pwr_down_mask & (0x3U << shift)));
 }
 
 static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
@@ -86,9 +97,9 @@ static ssize_t ad5686_write_dac_powerdown(struct iio_dev *indio_dev,
 	guard(mutex)(&st->lock);
 
 	if (readin)
-		st->pwr_down_mask |= (0x3 << (chan->channel * 2));
+		st->pwr_down_mask |= 0x3U << ad5686_pd_mask_shift(chan);
 	else
-		st->pwr_down_mask &= ~(0x3 << (chan->channel * 2));
+		st->pwr_down_mask &= ~(0x3U << ad5686_pd_mask_shift(chan));
 
 	switch (st->chip_info->regmap_type) {
 	case AD5310_REGMAP:
@@ -468,7 +479,7 @@ int ad5686_probe(struct device *dev,
 {
 	struct ad5686_state *st;
 	struct iio_dev *indio_dev;
-	unsigned int val, ref_bit_msk;
+	unsigned int val, ref_bit_msk, shift;
 	bool has_external_vref;
 	u8 cmd;
 	int ret, i;
@@ -492,9 +503,18 @@ int ad5686_probe(struct device *dev,
 	has_external_vref = ret != -ENODEV;
 	st->vref_mv = has_external_vref ? ret / 1000 : st->chip_info->int_vref_mv;
 
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

