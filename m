Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 31D513F2113
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:48:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125700; cv=none; b=aXfuB2F7BWPPChgrTCj25IzvQHfBVIAPgPXxyfQ50duHU/yZJjlFe6cnoPWQNwQO0Uzd06LtL/9r85nBwVbJOcToOguq7EML8Kz/k1rbD/zcgDDSZ5fUVUnE0Gj73g66znGuYtSpXjvx5+PD2j2rS5D4B2c0pyMT3pIAGg7DdO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125700; c=relaxed/simple;
	bh=hI3T4Wa1N2wqxjwi5PVp+Pmqb/Nu4/EcCkM1ZNIBs2I=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=grt94S2GvWUjVzj6oKDGk7vDhRbudzDZKDWGKzULLsEKQfYeI5P7UfBXP0muohquRyAb60sboUurtXeqnwPE55jysCAjz2FhOpzJdP0SBFa2MfATnM/ZilsVEbmX8ypx9vn7s/lqyA/tOk3Im/JBo/HFJuv9wVvk4ZY+n8hvyVw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=J98BjIcx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="J98BjIcx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 786761F000E9;
	Wed, 19 Aug 2026 07:48:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125698;
	bh=JovH8Xx5fxUISeHP8WRT46lq/HIUYVZr8QeBTERp+hE=;
	h=Subject:To:From:Date;
	b=J98BjIcxcOpaTlBqpFIwj1HDLIOhpI3NGoRObtUzIC/uMPM+8e5RCkMHH+qhzagu6
	 TitFD1YwpWmGtYh4JIsYyS5jaRvGyB43Vz5oCZZoVYjZloyZlWdtc/KmN+/gOmiewM
	 8jzDx8bm/9csDTMPzpx+5Tm9uNGdPkA8yI5PFAKU=
Subject: patch "iio: light: opt4001: Reject integration times with a non-zero seconds" added to char-misc-next
To: nikhilgtr@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:39 +0200
Message-ID: <2026081939-blurry-enable-89a5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: opt4001: Reject integration times with a non-zero seconds

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From d0f21621f8b2b46661ea066d20705dbf7253db87 Mon Sep 17 00:00:00 2001
From: Nikhil Gautam <nikhilgtr@gmail.com>
Date: Tue, 14 Jul 2026 17:01:33 +0530
Subject: iio: light: opt4001: Reject integration times with a non-zero seconds
 part

opt4001_write_raw() only looks at val2 when setting the integration
time, so a write such as 1.000600 is silently accepted as 600 us.
Return -EINVAL if val is non-zero.

Fixes: 9a9608418292 ("iio: light: Add support for TI OPT4001 light sensor")
Signed-off-by: Nikhil Gautam <nikhilgtr@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/opt4001.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/opt4001.c b/drivers/iio/light/opt4001.c
index 944923cb8f28..2448d6330489 100644
--- a/drivers/iio/light/opt4001.c
+++ b/drivers/iio/light/opt4001.c
@@ -269,6 +269,9 @@ static int opt4001_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
+		if (val)
+			return -EINVAL;
+
 		int_time = opt4001_als_time_to_index(val2);
 		if (int_time < 0)
 			return int_time;
-- 
2.55.0


