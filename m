Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB022247291
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 05:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416753; cv=none; b=aXNmPZmsa5ztCe3K6sopX4gwLgQrFMWGZMZ/dIXFyXws0NCnNT24vH2ssEpktrYGuUr94XQff/TcFmpG3xhk0A3DXKnd5sEJJkcP1d89Yrh6/vAOSNnEJN6uO8UGF5SRY6kzuoz+5zUtKHQ5E/Hrabch34p1cv0swrCbowL7b7A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416753; c=relaxed/simple;
	bh=jE/Yk60TyFHssu0a8LnyeHWYzDFY55l8OvDScEVkfe0=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=AzoRuxJL33x5nhLbuX/FfW+1DwzT5YCmTAaUEE6AnU6vXcl7jKE0PYOaNZSZzUAQMY5dFsFKO3q4lymCBXxQpUFtArzivQFoOSRPUU3eaEQc7aC46RG/bAraxGVFqmFF+rczz94K9IpMF68C9UYNB0y66TAn2sqd4GtyDd1TOIo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WKzBZuyx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WKzBZuyx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0AFF1F000E9;
	Sun, 14 Jun 2026 05:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781416752;
	bh=/ao3otWrIZ6d6wFroZmqkg8EC6zPouPyEEeqvWdkHME=;
	h=Subject:To:From:Date;
	b=WKzBZuyx8d45lT1h1H1CEDKdEm1GDbFn5AVptYcysWGu4aeRz+Nu6fnsZk1C7OhOF
	 hA6VFErkltxUaQ/p64vfXakZsh1SprppiebkB2lK+a49BiUsbeDUyl4tRs3Tqb9hp6
	 +1XYjpSVXYnWN0Q4PPgHGTdZ/m1JevKF11Kb+DK4=
Subject: patch "iio: dac: ad3552r-hs: fix uninitialized data ni" added to char-misc-testing
To: error27@gmail.com,Stable@vger.kernel.org,adureghello@baylibre.com,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 07:57:23 +0200
Message-ID: <2026061423-unwrapped-flavored-5154@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ad3552r-hs: fix uninitialized data ni

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From eaaa7eef181892ef7ba56c6295b81f0ae4492c13 Mon Sep 17 00:00:00 2001
From: Dan Carpenter <error27@gmail.com>
Date: Mon, 25 May 2026 10:15:46 +0300
Subject: iio: dac: ad3552r-hs: fix uninitialized data ni
 ad3552r_hs_write_data_source()

If the *ppos value is non-zero then the simple_write_to_buffer() function
won't initialized the start of the buf[] buffer.  Non-zero values for
*ppos won't work here generally, so just test for them and return -ENOSPC
at the start of the function.

Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
Signed-off-by: Dan Carpenter <error27@gmail.com>
Reviewed-by: Angelo Dureghello <adureghello@baylibre.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/dac/ad3552r-hs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index a9578afa7015..6bc64f53bce9 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -549,7 +549,7 @@ static ssize_t ad3552r_hs_write_data_source(struct file *f,
 
 	guard(mutex)(&st->lock);
 
-	if (count >= sizeof(buf))
+	if (*ppos != 0 || count >= sizeof(buf))
 		return -ENOSPC;
 
 	ret = simple_write_to_buffer(buf, sizeof(buf) - 1, ppos, userbuf,
-- 
2.54.0


