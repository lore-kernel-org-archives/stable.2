Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D31BA2741B6
	for <Stable@vger.kernel.org>; Thu,  4 Jun 2026 08:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562889; cv=none; b=qg2gzavcfUdtiIx6+0iQdriBeRyTSN2BCA/IxMxYMww8VnwIABkOBRDHWCktkaqu/Jat+ufexz3jTeT+sg+NbdVFBCJaSjATmXDrqexvz87qlqS4Z3m1PCyFiKb/7w/8x0GOeSBcEekTuOs3aUyGZGFeUHFu5EQWWkreF2HvhIA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562889; c=relaxed/simple;
	bh=ixEVHdNm54BTE6F8o0WDhsgjJa8/B/zfjUWl6lLkK6c=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=tbum+tYaUcfp3iSOZbwR5qs+mQMRPFmb/+lsxDvg8LpNEQA9Xg6gwlSDSha0czpOOAYfSjIw4v4kmY+sljYPHD1WgtY2dqYfEBCJSq4OzwZ4ki4wHg5NakcjC8+qOBZbYF5xngS5BFO+LQbQ3loiHrZJZWHUsNzRPre3ilffyMM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ol2zTe7L; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ol2zTe7L"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CF9281F00893;
	Thu,  4 Jun 2026 08:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562888;
	bh=3E7pkUKFp1VZ0qXRwA986YRz969X19wpv2omL7F/EFk=;
	h=Subject:To:Cc:From:Date;
	b=Ol2zTe7L5aaU6WBGdWijlko8ggBGEttTC2k0ftEEDu1qMLMRbRDDtTrbJzCKNwrnt
	 34KnuajMW/G43zg1rExqDPALgUyAPSn/7N+4BTWwmR0dDo29ZiOfgD1IOKpZfjR/Q4
	 KIMw0Ez56HpPjMh02826jh3NXiaW8r7oV+N0t6Ds=
Subject: FAILED: patch "[PATCH] iio: chemical: scd30: fix division by zero in write_raw" failed to apply to 5.10-stable tree
To: antoniu.miclaus@analog.com,Stable@vger.kernel.org,jic23@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:46:57 +0200
Message-ID: <2026060457-rubdown-rival-345e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5aba4f94b225617a55fed442a70329b2ee19c0a5
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060457-rubdown-rival-345e@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

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

