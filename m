Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C61F63D9539
	for <Stable@vger.kernel.org>; Fri, 11 Sep 2026 09:57:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120639; cv=none; b=ckfJaJALiCVdMrmjO5Tz0ub/X9VkLKIDU6PMxaL1dYmYEQqkiJ6Of6r5BiIfQZjvt/rp5+dsHq4BMRardNHjAvazuCk3vHbm1bOk5oPcC55fsZ6SvKXWlXXjzWzJsYBjq9Lpifi/1sXddJx/inYR+r2lnRc6KoF7zL7NhkXCYhs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120639; c=relaxed/simple;
	bh=A/6udJWtHS0IFvo7nvOjQOCwaoRx4iK0W6U4fWniH10=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=cbouJ8zLkobWqkcdsSLRzlLUzLlnh2vOdICn1ro73dM240lm3/Dx+NbanmesfXULj5lBj9Kf1F1LbErtEFOtHuD/EpE8SNZ/FNDk1S+iw5DWxLq6w/qWg5MR+hwL4XjOCcIRtaOwC9lbOPRYpZAZNRP3Cz/06yVaWB1zp2y2CIY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tYVJBGCt; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tYVJBGCt"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8CEA11F000FF;
	Fri, 11 Sep 2026 09:57:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789120637;
	bh=SWo6Zcjg65HCmhyiKAIIEPrYxIehsftu+w/a+QdJRTE=;
	h=Subject:To:From:Date;
	b=tYVJBGCt9Kq833p35lZZaIMIap2yhQniTrWqQUUzjBqMBNGrX5/kaxMWneOlds25b
	 VRFDHwaMwch3h2ngqvt3wXL91XHyfEeEw/mZ5cIQjF9PsBK2MIvfbI2cbcZLA046j9
	 iRH4YwlhZOB8NRey8WrL4AQC3/BfsPGDpXZmpzPw=
Subject: patch "iio: buffer: Ensure bounce buffer used for unaligned case is zeroed." added to char-misc-linus
To: jonathan.cameron@oss.qualcomm.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,joshua.crofts1@gmail.com,nuno.sa@analog.com,sashiko-bot@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 11:55:35 +0200
Message-ID: <2026091135-alongside-unloaded-a798@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: buffer: Ensure bounce buffer used for unaligned case is zeroed.

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 5330036bc68d23672bfcc16c60c54701ae123083 Mon Sep 17 00:00:00 2001
From: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
Date: Mon, 3 Aug 2026 02:22:24 +0100
Subject: iio: buffer: Ensure bounce buffer used for unaligned case is zeroed.
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

iio_push_to_buffers_with_ts_unaligned() leaks uninitialized heap memory
to userspace if the data passed in is not a multiple of 8 bytes and the
timestamp is enabled. Specify __GFP_ZERO for the devm_krealloc()
to ensure any extra space is cleared.

Fixes: 95ec3fdf2b79 ("iio: core: Introduce iio_push_to_buffers_with_ts_unaligned()")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260529121005.1470-1-kimjinseob88%40gmail.com
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/industrialio-buffer.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/industrialio-buffer.c b/drivers/iio/industrialio-buffer.c
index 2c9ec93dff47..902401be0b67 100644
--- a/drivers/iio/industrialio-buffer.c
+++ b/drivers/iio/industrialio-buffer.c
@@ -2462,7 +2462,8 @@ int iio_push_to_buffers_with_ts_unaligned(struct iio_dev *indio_dev,
 
 		bb = devm_krealloc(&indio_dev->dev,
 				   iio_dev_opaque->bounce_buffer,
-				   indio_dev->scan_bytes, GFP_KERNEL);
+				   indio_dev->scan_bytes,
+				   GFP_KERNEL | __GFP_ZERO);
 		if (!bb)
 			return -ENOMEM;
 		iio_dev_opaque->bounce_buffer = bb;
-- 
2.55.0


