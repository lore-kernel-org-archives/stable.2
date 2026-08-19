Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22583E9C29
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:45:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125517; cv=none; b=La44I/2v+296eqDljaDjhg63N/D62YnyAEkn+JSfb5jSQiPyS9ptv0waNouTJDzT3cKkLs7xbfQ4zd9xH2ySuNDB3+68k1rPK0SJd38pAM7866TYwx8PYvw+F+hhySDkcVv/xPYQM9Y1G+sSjd9RzziHXDhmBaueQvbUjEb77Y0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125517; c=relaxed/simple;
	bh=dDbdGFoxbeZe90NFdL4PsowL+hyAHuJrt6MkgQEAxuE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=eb2fm+92LKusIcaQPwrti3IJ+JFgUItGgxHm8qhAdEgZXcPMNbY8xDBWLL0b+VPACdtlRdb097bKr9tTaVj5m9qxg2xdNRb8QghA6KzsAT6j6/6PwjSmd8GP1/C0unTGA/1czXlo018qarxViLReIic84ZiT0Dv5RkVec6l9ZM8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=MNB6uSTh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="MNB6uSTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 04A5C1F000E9;
	Wed, 19 Aug 2026 07:45:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125515;
	bh=n/zCuMRWH6ze7ruojvO3kZnIphJNKbnix+R+9oj4huk=;
	h=Subject:To:From:Date;
	b=MNB6uSThtKnmNE1C8otK1beFmfmK+wXL2GHyTUCwtk+qfzdRLnF4gBZG63bmiWMYE
	 suaL9zw7yp+07Y7676lE7XAWYLSrIKwO5mFaGPO7mKJw8zjmYc5aH7dDKHCIB83Lx5
	 4/o5uiQkzuEI8j6NfVcxNLviU5i/W190qt7vPIPo=
Subject: patch "iio: light: opt4060: Reject integration times with a non-zero seconds" added to char-misc-testing
To: vidhu.linux@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:06 +0200
Message-ID: <2026081906-duty-smoky-03eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: opt4060: Reject integration times with a non-zero seconds

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From b7e6e9af0d723afdec92364d5e7e064eeef44c8e Mon Sep 17 00:00:00 2001
From: Vidhu Sarwal <vidhu.linux@gmail.com>
Date: Wed, 15 Jul 2026 06:45:42 +0530
Subject: iio: light: opt4060: Reject integration times with a non-zero seconds
 part

When setting the integration time, opt4060_write_raw() only uses
val2 and ignores val. As a result, a write such as 1.000600 is
accepted and programmed as 600 us, silently discarding the whole
seconds part.

Since all supported integration times are less than one second, any
non-zero val represents an invalid input. Reject such values instead
of silently accepting them.

Fixes: 0c6db4506ad0 ("iio: light: Add support for TI OPT4060 color sensor")
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/opt4060.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/iio/light/opt4060.c b/drivers/iio/light/opt4060.c
index c391ad3271c6..cf6f69e5be35 100644
--- a/drivers/iio/light/opt4060.c
+++ b/drivers/iio/light/opt4060.c
@@ -632,6 +632,9 @@ static int opt4060_write_raw(struct iio_dev *indio_dev,
 
 	switch (mask) {
 	case IIO_CHAN_INFO_INT_TIME:
+		if (val)
+			return -EINVAL;
+
 		int_time = opt4060_als_time_to_index(val2);
 		if (int_time < 0)
 			return int_time;
-- 
2.55.0


