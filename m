Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF3633C343C
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125690; cv=none; b=K/BgWGagjC+xEI+Q+ivyoszAg33V0LeoZPkWCGz+aqewQiwKW9J1Myl/wX9Nl0l6PiGl+52zxWVCmztuRmEvR7pmkHRZEmLF0UWfhiNNgNhlZ6mtlwaSvEu1EcSc6dpJ01XuP4cFNYM5iA3lEt0CgL6yRH/hc87RUEXRPIZZPLA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125690; c=relaxed/simple;
	bh=s1HvqddOR6OQJ9MQidounC52lOOcoEr6TyuPpEElaF0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=qoImKyQj5sUMldNTC8tA+Asv9fLNuMyxgxnCVjHqAbtBiz+azf7T5txs9U+rMiFtREpa4sw/z/80Mp6aYBTULSjAbp39f0yItafhGgkfC0eb9tAicDxzxfyFyvfg/KqtbOZuW0NC+0LRHJBt3WdPF9XkjLntgnerSsWVUuabqkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CmzzC6l6; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CmzzC6l6"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D6C1F000E9;
	Wed, 19 Aug 2026 07:48:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125688;
	bh=gvea2HnS30hA0AK74+vUAav1g4mHx3ZRhpI4GP7jrDA=;
	h=Subject:To:From:Date;
	b=CmzzC6l6GDfW/yWeIeVH+YWh9d2rGZVIwZjOYQT46Qf3TC5L1v5OxXyiO1h2EXe4i
	 qiAtVkizQP1za2/WIOXfvvkE+KLUZPkgn14i+JNEYqaogqNvnRRiEv4GGG8P8hgI4j
	 G/xpmjrHp4tpxTcaMwTIHPvFRM/yz6sPXU7CZ9WM=
Subject: patch "iio: dac: ad5446: fix OF module device table" added to char-misc-next
To: pengcan@kylinos.cn,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:39 +0200
Message-ID: <2026081939-skirmish-dramatize-a0b3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ad5446: fix OF module device table

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From a3c03cf36a083893dedad928915471dc8c10692e Mon Sep 17 00:00:00 2001
From: Can Peng <pengcan@kylinos.cn>
Date: Tue, 14 Jul 2026 17:18:45 +0800
Subject: iio: dac: ad5446: fix OF module device table

The ad5446 I2C driver exports its OF match table with
MODULE_DEVICE_TABLE(OF, ...).

The device table type is used by modpost when generating module aliases,
and scripts/mod/file2alias.c matches the lowercase "of" type.  Using
"OF" prevents the OF table from being recognized, so no OF module alias is
generated for the I2C driver.

Use the lowercase "of" type so OF-based module autoloading works.

Fixes: 876d94024087 ("iio: dac: ad5446: Separate I2C/SPI into different drivers")
Signed-off-by: Can Peng <pengcan@kylinos.cn>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/dac/ad5446-i2c.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad5446-i2c.c b/drivers/iio/dac/ad5446-i2c.c
index 2d4c8908d91e..cb3100fa32d9 100644
--- a/drivers/iio/dac/ad5446-i2c.c
+++ b/drivers/iio/dac/ad5446-i2c.c
@@ -84,7 +84,7 @@ static const struct of_device_id ad5446_i2c_of_ids[] = {
 	{ .compatible = "adi,ad5622", .data = &ad5622_chip_info },
 	{ }
 };
-MODULE_DEVICE_TABLE(OF, ad5446_i2c_of_ids);
+MODULE_DEVICE_TABLE(of, ad5446_i2c_of_ids);
 
 static struct i2c_driver ad5446_i2c_driver = {
 	.driver = {
-- 
2.55.0


