Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E734B2877DE
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 06:04:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417084; cv=none; b=sjbkWHGKDKwRMa/Yd8Y7BB4eKrM3/diA6+8wtdvrEqyB3m0tNuns5R4F8+Iif7Bgac4kgd8sk2dWq3szitb9vLfltkTZ/LHRyUTqVyXNHrFkAi2XVlc5OknxDbPU3N5Yoq4cXh+VCQDnXenIN9iw6l+Ch3CjQtJ+92p8VMqy0pY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417084; c=relaxed/simple;
	bh=hOlKUH6UUk4K6GOuudHaPHq1OoydHwFZ0oe56Zp5nng=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=upZKJdtnoyNPeDq9ftdEymuj/KThEEJ4y/WlkSgv6y/TMJgtfzGOWqxvVUAkEO8o6JwP5j3szwf9FcPB5AWoSdClSTypy6r9X6/SqrAY3yvWUzcNdBu/kAv1W5/20sl0yq+KYy/ujbN7fzOfO21MlKCMqPlr6HKy+5xV47R5ldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Yf176zpe; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Yf176zpe"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02FDB1F000E9;
	Sun, 14 Jun 2026 06:04:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781417083;
	bh=77Kd51MHY+voGLkKCwfGD2ej7woMyQaZL5mTUZDi+Bk=;
	h=Subject:To:From:Date;
	b=Yf176zpe53WVnwDoMTCje+PzavALM5a4PauELdkpBaU1AxGrokQogQZYXFHTTSRHp
	 sfNwzt1tZNfI1C4BzKGIOt3H+fp91D1LzN1TEqLVdazKo/JIvzrY/MXfeQVuC7bsyH
	 ihe0FoJKmz8X4/wkOKpyCC8F+tCpeOKMdk8SI8wA=
Subject: patch "iio: gyro: bmg160: bail out when bandwidth/filter is not in table" added to char-misc-next
To: sozdayvek@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 08:03:31 +0200
Message-ID: <2026061431-slain-clench-a015@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: gyro: bmg160: bail out when bandwidth/filter is not in table

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 8320c77e67382d5d55d77043a5f60a867d408a2b Mon Sep 17 00:00:00 2001
From: Stepan Ionichev <sozdayvek@gmail.com>
Date: Sun, 10 May 2026 07:35:00 +0500
Subject: iio: gyro: bmg160: bail out when bandwidth/filter is not in table

bmg160_get_filter() walks bmg160_samp_freq_table[] looking for the entry
matching the bw_bits value read from the chip:

	for (i = 0; i < ARRAY_SIZE(bmg160_samp_freq_table); ++i) {
		if (bmg160_samp_freq_table[i].bw_bits == bw_bits)
			break;
	}
	*val = bmg160_samp_freq_table[i].filter;

If no entry matches, i ends up equal to the array size and the next line
reads one slot past the end. bmg160_set_filter() has the same shape, driven
by 'val' instead of bw_bits.

smatch flags both:

  drivers/iio/gyro/bmg160_core.c:204 bmg160_get_filter() error:
  buffer overflow 'bmg160_samp_freq_table' 7 <= 7
  drivers/iio/gyro/bmg160_core.c:222 bmg160_set_filter() error:
  buffer overflow 'bmg160_samp_freq_table' 7 <= 7

Return -EINVAL when no entry matches.

The set_filter() path is reachable from userspace via the sysfs
in_anglvel_filter_low_pass_3db_frequency interface, so userspace can
trivially trigger the out-of-bounds read with a value that is not in
bmg160_samp_freq_table[].filter.

Fixes: 22b46c45fb9b ("iio:gyro:bmg160 Gyro Sensor driver")
Signed-off-by: Stepan Ionichev <sozdayvek@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/gyro/bmg160_core.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/iio/gyro/bmg160_core.c b/drivers/iio/gyro/bmg160_core.c
index 38394b5f3275..58963f3ea186 100644
--- a/drivers/iio/gyro/bmg160_core.c
+++ b/drivers/iio/gyro/bmg160_core.c
@@ -201,6 +201,9 @@ static int bmg160_get_filter(struct bmg160_data *data, int *val)
 			break;
 	}
 
+	if (i == ARRAY_SIZE(bmg160_samp_freq_table))
+		return -EINVAL;
+
 	*val = bmg160_samp_freq_table[i].filter;
 
 	return ret ? ret : IIO_VAL_INT;
@@ -218,6 +221,9 @@ static int bmg160_set_filter(struct bmg160_data *data, int val)
 			break;
 	}
 
+	if (i == ARRAY_SIZE(bmg160_samp_freq_table))
+		return -EINVAL;
+
 	ret = regmap_write(data->regmap, BMG160_REG_PMU_BW,
 			   bmg160_samp_freq_table[i].bw_bits);
 	if (ret < 0) {
-- 
2.54.0


