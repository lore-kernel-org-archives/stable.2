Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E39D35836E
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:47:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125675; cv=none; b=KHDiF7ESZP5E4OqBS5Jc2U+Jhtm4LRcnZdexKzp9LQmvVqErsLuztqH1a2xWtfbCL3mAmytarQ325Z6Z6QY+v1fRSuj6/ECq3TjwFlOkDEohAeuLrmKP7QvpPEO5xnKsEhf/4/qlGTLK7ZDvh2mg6nIEb7/9DCSkXvwdVAjjJHE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125675; c=relaxed/simple;
	bh=Hra2PL49ixG7SdvsGMec5kwuB50ori3t0CNu/Qofbpc=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=qM8W56Lp5I10BNxDBf/+0GY1s09ac7c9lLpFbCjrifyukEXx8RUE/VDQp4Ur9fgJ6eEIuYeBBlCCnelL074HIg4pMf7qIudrCj9PWGy/yuUEqgtJzOG8XBoVTKPKZUkzIyp+ic5X66gmLeNTofzy1qy2CuoRZeryuRDVJtZKfcg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hmWtapws; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hmWtapws"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36B831F000E9;
	Wed, 19 Aug 2026 07:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125674;
	bh=Z/ZKu3c9jGTjrwQYXh0ZKXVWGk8PxTrJy8asbd6/Em8=;
	h=Subject:To:From:Date;
	b=hmWtapws4n4UXlCPJSrqt6j5uDWYxPuWRBxI48ArYr8DozrrndhK/doHN0IEXTpx+
	 rSa/0MPD6trv6cjiJQdRArTqxmDeAwQ/pht/V+LW1PVhZN9YlALbX9i6pn8/oF9qfy
	 CqvuiRA9hQ2g7MLCITnegzBFPhL2SsNkSQgT/boo=
Subject: patch "iio: light: opt4001: Fix incompatible pointer type passed to" added to char-misc-next
To: nikhilgtr@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:38 +0200
Message-ID: <2026081938-diagram-senior-2922@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: opt4001: Fix incompatible pointer type passed to

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From afa28741c9a2cf6edb2e41e25ff146a562160bb3 Mon Sep 17 00:00:00 2001
From: Nikhil Gautam <nikhilgtr@gmail.com>
Date: Tue, 14 Jul 2026 17:01:32 +0530
Subject: iio: light: opt4001: Fix incompatible pointer type passed to
 div_u64_rem()

div_u64_rem() takes a u32 * for the remainder but is passed val2, which
is an int *. There is no functional impact as int and u32 have the same
size and representation on all supported architectures and the remainder
is always smaller than the divisor, so it fits in the positive range of
int. Fix the type mismatch by using a local u32 for the remainder and
assigning the result to *val2.

Fixes: 9a9608418292 ("iio: light: Add support for TI OPT4001 light sensor")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/opt4001.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index 288e699734af..944923cb8f28 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -173,6 +173,7 @@ static int opt4001_read_lux_value(struct iio_dev *indio_dev,
 	u8 crc;
 	u8 calc_crc;
 	u64 lux_raw;
+	u32 rem;
 	int ret;
 
 	ret = regmap_read(chip->regmap, OPT4001_LIGHT1_MSB, &light1);
@@ -199,8 +200,8 @@ static int opt4001_read_lux_value(struct iio_dev *indio_dev,
 
 	lux_raw = lux_raw << exp;
 	lux_raw = lux_raw * chip->chip_info->mul;
-	*val = div_u64_rem(lux_raw, chip->chip_info->div, val2);
-	*val2 = *val2 * 100;
+	*val = div_u64_rem(lux_raw, chip->chip_info->div, &rem);
+	*val2 = rem * 100;
 
 	return IIO_VAL_INT_PLUS_NANO;
 }
-- 
2.55.0


