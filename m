Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 530E1389110
	for <Stable@vger.kernel.org>; Thu,  4 Jun 2026 08:48:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562886; cv=none; b=GD0P64KesedJnTNppLqprCAxBg9VJ9IxQgqKc49ttwrufOf7yZP99CbtYDB7nEK1uU7t0VJB+TX+zeAtWi4IvQBvmpFf05gSD/StGHTxHYQnaQB+7362+4yVVqWEkasQ3zaIIb7biDnPN8F1oCBeGkxxxUdLrLBvCZdGqQ+ZBKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562886; c=relaxed/simple;
	bh=s4nyiheZx34+wpnv7HjAkqpy0HTb7ad13zJ0WPt5iX4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=mxgs6tMEk565SOs5KboBqMPHg6rklm/eI47UoOSbShCfbsJ9m7MJs2SnfBW7+8DGvwDRCfCRxxK0IiY7zi/WXnYSXZd6YxBrGCW30qQRGD0SnXQ1jg6grdUVpo/96xKzTHnFIBx6+87cyhJlsCdN4oU4oxqKlvY/+g7yxs8rn0s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=P+tG5GnX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="P+tG5GnX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3EB911F00893;
	Thu,  4 Jun 2026 08:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562885;
	bh=mEhMTeWY9M8z0Wl2yawCbas4wDEYou7Fh4xDr8EaSGc=;
	h=Subject:To:Cc:From:Date;
	b=P+tG5GnXbsHPXRf85+e/LhnMB6jPqtiJAoLNrOxe/cm8QEvx5aCXrSZQsCWl5+iNw
	 PRiVfl7nm4l4i4b9d7hIpvP3pdi5QgwKifFjcL9tHFH75/vrr4iomPOFDxLAcEz04s
	 C90TlpM8GHBv952W3IgcxuRsHVzlJkwZ3cY4stnY=
Subject: FAILED: patch "[PATCH] iio: chemical: scd30: fix division by zero in write_raw" failed to apply to 6.1-stable tree
To: antoniu.miclaus@analog.com,Stable@vger.kernel.org,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:46:56 +0200
Message-ID: <2026060456-grimacing-crop-73d8@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 5aba4f94b225617a55fed442a70329b2ee19c0a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060456-grimacing-crop-73d8@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5aba4f94b225617a55fed442a70329b2ee19c0a5 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Wed, 1 Apr 2026 14:08:29 +0300
Subject: [PATCH] iio: chemical: scd30: fix division by zero in write_raw

Add a zero check for val2 before using it as a divisor when setting the
sampling frequency. A user writing a zero fractional part to the
sampling_frequency sysfs attribute triggers a division by zero in the
kernel.

Fixes: 64b3d8b1b0f5 ("iio: chemical: scd30: add core driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index a665fcb78806..11d6bc1b63e6 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -256,7 +256,7 @@ static int scd30_write_raw(struct iio_dev *indio_dev, struct iio_chan_spec const
 	guard(mutex)(&state->lock);
 	switch (mask) {
 	case IIO_CHAN_INFO_SAMP_FREQ:
-		if (val)
+		if (val || !val2)
 			return -EINVAL;
 
 		val = 1000000000 / val2;

