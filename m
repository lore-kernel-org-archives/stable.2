Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3FA243F1ADA
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:45:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125532; cv=none; b=paPl2DVDUb0xtqKzeeJtFOeGOlCtXCskWnNQ6mXtt2EjSb1otZTGKOvev5pwESQRGw7a2zFKCfe/y7lnqmSCnfI0vy8HQFWJC7DqN0OLVh3xLwkHsctpi9f0P7GIrMlDJBZ8g1x57Cqqn0Bsn7GuRnM2/J7AAFymqXQs0Iu8c9I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125532; c=relaxed/simple;
	bh=y2qG2ktuce6tjE8CMQlvoMYFPhCBaDAXlDBbsV+ZDK8=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=G0yfJ5PKkM86mAuBRK9e63fE1QlFonAhvCcIeZKSXx+YAwa3mUjAPM2XE/4/NX6uqIBjASeqS8sZu9vShyVk3n0EPHfUjOFdHVnp9a4J6Sz7H2+D+AeL+vA7FHLipCZko8+G32av/FxAm1s73UHRh69IMS2MkHJovpE3g32PYHc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=tz6eh3ql; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="tz6eh3ql"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9CED1F000E9;
	Wed, 19 Aug 2026 07:45:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125530;
	bh=ULH3aBgZzrHXX/x7FTkpYSiZBVK+Bp2AIrmeyn39EBQ=;
	h=Subject:To:From:Date;
	b=tz6eh3qlpUGW3T/RU4wR8mr2mzLLMV5AnuZnQA2oghdWkJqluncGA9MHyQc2+5D6N
	 lYoNxgl74sWfy5klJeDzJRYStgGVzKFjTyD7CewEsdCR8jXyZSnE5L6j/XcsN8YVIT
	 LQEgkCibZrUPGHkR2LMtA0L0QBP8FM845Mh8aVP4=
Subject: patch "iio: light: opt4001: Reject integration times with a non-zero seconds" added to char-misc-testing
To: nikhilgtr@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:07 +0200
Message-ID: <2026081907-large-upper-165c@gregkh>
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
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

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


