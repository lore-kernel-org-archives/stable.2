Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFB23EF666
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:45:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125522; cv=none; b=BBmkb/KtsGLFm+cvFKCCz5dN9KgMH+IKlhm27Ybd3cFlKregOPQ9kQOBhMj0gQ2n3w0knqLpMZDYLNeP47bLUJjSYLrWv6bDmdRSlX/k/ipJqygEih7FGhUNUbcDBUOytWGTK7hAUlQpR9/AaiVcnsF5+IJPrFPqTvk9q0hfSo4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125522; c=relaxed/simple;
	bh=5wA3XVH6RLBpizBHOw9f4AJZeji6gSmuWzB428lf2/c=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=AamObc7yE/CMWbP9par48/jIfZzBPeGfcgwnAKt7+0wapzDfl//aQB8L6YC9gKA6+tmWEGGQnJiY1GAvMKrOo/bsRr2b0JvolHne1Y0YZZij9Bn+5traYYrh7SLZrtix5Hu8L+VopN0lsqRutxLkbHdGlUGkeWF1Z1wqmWudd8c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=hVwiCkBo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="hVwiCkBo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A4E01F000E9;
	Wed, 19 Aug 2026 07:45:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125520;
	bh=w7pZ9GeTlFSPySrlJmKgY0NmpX4ZVaPLagSry0T9yP0=;
	h=Subject:To:From:Date;
	b=hVwiCkBo06dqT9asjcEWNEfwcLhbB/6F6s4oWtd/Ec45z8kMphnR300evyiK2Ylht
	 i32PUamxaTnNUtP4vMSYlIOu2m0y0ySwCKDOm3+OPIhs3UNBgVdPvZAz7edy0n5lZA
	 ILoCj6SQW9ck38caxIxbScx1RqY5J6nZ7VH0Yis4=
Subject: patch "iio: light: opt4001: Fix incompatible pointer type passed to" added to char-misc-testing
To: nikhilgtr@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:07 +0200
Message-ID: <2026081907-dupe-perkiness-2226@gregkh>
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
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

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


