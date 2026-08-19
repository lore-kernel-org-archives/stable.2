Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07B5D3F2116
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125622; cv=none; b=D9KE428so254He+GVaJq/9H+A1WbNrApMMHGun4NPv43kN1CG3nc+Hya54/Kpul3a5x1cXXxibpklhKL1K1Ky03AmD2aKGjdpDEFy9doUxKr46I3Ifjt5JEn2GkIok0g/jjEuzAq+RF77nCJ+/g/IXqL1AYV74Aqj3DiTWHGPl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125622; c=relaxed/simple;
	bh=nsOyRN8HL4JbZh/YAY97On40kuMvOqoEbsbRAupIs6E=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=APVSRfkW3Nj22nYaHmnZKjPJ5jUPxUApkzAWRynprnms5wLCsr2XH5ZiI6RwYO/FJeZW7uCl5zuLmf0QSA36MXSV81tttsjjvreUP22KpDuNScRtnYNG6NkdnDxXMIYXuI7w53o4AWZiFVzv/J2CToaEc3hImSy1EMWeV3s29J0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sAYlKN3A; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sAYlKN3A"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ADE611F000E9;
	Wed, 19 Aug 2026 07:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125617;
	bh=zfb5KHERD/VTRYqhUxSM0CZxAlQfZ0gLht0PJbVyXzY=;
	h=Subject:To:From:Date;
	b=sAYlKN3AGorDBICXvi0k+OoDvWvOb8OIGdJFaSNDwX/cHK+ZTyWk375ErztuxSe6c
	 u2us6bUGrx9fRd3TFlacf59qUYUhnaLH63OzyGg+IXfx9C9VVgbSvelTkF9nNhhJpy
	 OumotBQOtuju6MRpQi9UiOwb/22xclooDGWQc6q0=
Subject: patch "iio: ti-ads7138: Disable STATS_EN bit while reading conversion" added to char-misc-next
To: paul.geurts@prodrive-technologies.com,Stable@vger.kernel.org,dlechner@baylibre.com,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:35 +0200
Message-ID: <2026081935-salami-earpiece-663b@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: ti-ads7138: Disable STATS_EN bit while reading conversion

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From bcb721c1bcb02ab225b3937bf131a0bc6fc1fecd Mon Sep 17 00:00:00 2001
From: Paul Geurts <paul.geurts@prodrive-technologies.com>
Date: Mon, 6 Jul 2026 09:48:03 +0200
Subject: iio: ti-ads7138: Disable STATS_EN bit while reading conversion
 results

There is a data race in reading the STATS registers, resulting in wrong
data being read. When the data in the RECENT register switches between
0x24F0 and 0x2500, occasionally value 0x2400 or 0x25F0 is read. This
happens when the value is updated in between reading MSB and LSB.

The data sheet says: "Until a new conversion result is available,
previous values can be read from the statistics registers. Before
reading the statistics registers, set STATS_EN to 0 to prevent any
updates to this register block." As the STATS_EN is currently not
cleared, the values of the stats registers might change mid read,
giving faulty values.

Disable the STATS_EN bit before reading one of the statistics registers to
make sure the device does not update the register mid read. This is
applicable to registers MAX_CHn_xSB, MIN_CHn_xSB and RECENT_CHn_xSB.

This means reading one of the statistics registers resets the MAX and
MIN registers. This is unfortunate, but necessary to get correct data
from the device.

Signed-off-by: Paul Geurts <paul.geurts@prodrive-technologies.com>
Fixes: 024b08fee342 ("iio: adc: Add driver for ADS7128 / ADS7138")
Reviewed-by: David Lechner <dlechner@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ti-ads7138.c | 42 ++++++++++++++++++++++++++++--------
 1 file changed, 33 insertions(+), 9 deletions(-)

diff --git a/drivers/iio/adc/ti-ads7138.c b/drivers/iio/adc/ti-ads7138.c
index af87f5f19a0f..da82a6947b2b 100644
--- a/drivers/iio/adc/ti-ads7138.c
+++ b/drivers/iio/adc/ti-ads7138.c
@@ -227,6 +227,26 @@ static int ads7138_osr_to_bits(int osr)
 	return -EINVAL;
 }
 
+static int ads7138_read_statistics(const struct i2c_client *client, u8 reg,
+				   u8 *out_values, u8 length)
+{
+	int ret;
+
+	/* Disable statistics update so the value is not updated mid read */
+	ret = ads7138_i2c_clear_bit(client, ADS7138_REG_GENERAL_CFG,
+				    ADS7138_GENERAL_CFG_STATS_EN);
+	if (ret)
+		return ret;
+
+	ret = ads7138_i2c_read_block(client, reg, out_values, length);
+	if (ret)
+		return ret;
+
+	/* Enable statistics update after read */
+	return ads7138_i2c_set_bit(client, ADS7138_REG_GENERAL_CFG,
+				   ADS7138_GENERAL_CFG_STATS_EN);
+}
+
 static int ads7138_read_raw(struct iio_dev *indio_dev,
 			    struct iio_chan_spec const *chan, int *val,
 			    int *val2, long mask)
@@ -236,28 +256,32 @@ static int ads7138_read_raw(struct iio_dev *indio_dev,
 	u8 values[2];
 
 	switch (mask) {
+	/*
+	 * Reading the statistics registers reinitializes them. This is
+	 * unfortunate but necessary to prevent data races.
+	 */
 	case IIO_CHAN_INFO_RAW:
-		ret = ads7138_i2c_read_block(data->client,
-					     ADS7138_REG_RECENT_LSB_CH(chan->channel),
-					     values, ARRAY_SIZE(values));
+		ret = ads7138_read_statistics(data->client,
+					      ADS7138_REG_RECENT_LSB_CH(chan->channel),
+					      values, ARRAY_SIZE(values));
 		if (ret)
 			return ret;
 
 		*val = get_unaligned_le16(values);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_PEAK:
-		ret = ads7138_i2c_read_block(data->client,
-					     ADS7138_REG_MAX_LSB_CH(chan->channel),
-					     values, ARRAY_SIZE(values));
+		ret = ads7138_read_statistics(data->client,
+					      ADS7138_REG_MAX_LSB_CH(chan->channel),
+					      values, ARRAY_SIZE(values));
 		if (ret)
 			return ret;
 
 		*val = get_unaligned_le16(values);
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_TROUGH:
-		ret = ads7138_i2c_read_block(data->client,
-					     ADS7138_REG_MIN_LSB_CH(chan->channel),
-					     values, ARRAY_SIZE(values));
+		ret = ads7138_read_statistics(data->client,
+					      ADS7138_REG_MIN_LSB_CH(chan->channel),
+					      values, ARRAY_SIZE(values));
 		if (ret)
 			return ret;
 
-- 
2.55.0


