Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34FC0389110
	for <Stable@vger.kernel.org>; Thu,  4 Jun 2026 08:48:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562882; cv=none; b=DOLLlZ5tBo70Ja5BasuCxdY6xDJzJi7Ez0dkp0T1aXHB/c+U/MTlS5OT9GS+91wVe/QMEmR2CD4m8DEVCtUazCJZOgvZ7mBc+Il7XpmuZZ81R0330dIQzaXkVwuG7lvCgs+qyu4xkRiacOh8S8T5agEvvVS7i+J3b3KvbrnMwrg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562882; c=relaxed/simple;
	bh=ujOhXsd62cuabdVQEFJNyz+IvTnVQmw31yrNabgE0Jo=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=U9w1fgvgRJ3hgzxdmt5C9QKMjI/HDLFkKaIVml2IuJcsSBqdBZNcQMXphip8Av4A2DEyBsEOg/psf3YbdJ1KLxKA3wI0ncIaEI9lN1Wh3Yki2+WKusMrHIr9tm+oslE16G6jRkwRCfTvbNeXUel6/m6CzF544xpjbKr0gtg+anw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=UKtNBnU3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="UKtNBnU3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2C21F00893;
	Thu,  4 Jun 2026 08:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562881;
	bh=TTmtsJ38Vgqj/xXdijFkDl/ZhzxaEIiolZ2ekNIZOq8=;
	h=Subject:To:Cc:From:Date;
	b=UKtNBnU35u2RDNs69lQoqmhvEO6+impwHsgk2vJ4iOCvvyeemztZ6EvuPN1J8RJ8f
	 JsS7i+E6rjKsIhbmiZ8WCRuFyT7zmzubFOoFHQPNe0/I22jKKs/xARd3QX0jB9bV6i
	 LJmukHMND9+bY9oloqH3tf42PvYyMDeTo6Q/AFgc=
Subject: FAILED: patch "[PATCH] iio: chemical: scd30: fix division by zero in write_raw" failed to apply to 6.6-stable tree
To: antoniu.miclaus@analog.com,Stable@vger.kernel.org,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:46:55 +0200
Message-ID: <2026060455-strength-moisten-9273@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 5aba4f94b225617a55fed442a70329b2ee19c0a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060455-strength-moisten-9273@gregkh' --subject-prefix 'PATCH 6.6.y' HEAD^..

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

