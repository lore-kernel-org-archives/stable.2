Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3775638E5C5
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:43:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272591; cv=none; b=TkJoSoMFnOuKpmxKRy/4uIlZ27yd3wOxPlcwOyyNEHP/+z80p8MhFjZmDRJa7Uq3J0zq27b3Ht1l0AXwsmVg3K8qFj1M0d8SK3f2pzGw1t9oKvMPjPT78wQso6etkr87704hfzBg8nZjgMe1gEcWhBrU0UVoJdmPyMVp9d2Z4ZQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272591; c=relaxed/simple;
	bh=Mynqf854UW0KyB1DgzkOrS9dsHmla0GHZ0b391JucZY=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=f7+Zbjgn2/8ByVbqVfEv6jSkxnzm/TBaEpGM4026AiihON3FaPhHoFPCqmJyaMqA5uoeFGjieYS/+VaqFwPWnniLa/bIwFClpCa0uXwEcqEBYrNaP8rUR9OviV5NS5NqoOhT27vsbngwdwnvIjDG7HRqzrz8v8W2l8MoiUdDUNU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=B5ir00uL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="B5ir00uL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 971181F000FF;
	Tue,  6 Oct 2026 07:43:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272590;
	bh=CHjIwxSl9++LuetOFkR2NSg2f1R97bmwIu68dlZWOBg=;
	h=Subject:To:Cc:From:Date;
	b=B5ir00uLaAebpqk7+ckUrdkMX7kB46mErDNp7x7FUKpqnoMKdj6aQqlrzA1VwyFmu
	 iO/TK8zXu4JW0Ez+rWwqA59lh7wHdoOAsQU5ND7YKEqvpUbdvYDrRfoAJybAlZs1SC
	 AlSpdzSByTQTLAa+AFfm/2CQaCkeE/JmHHNx/bFk=
Subject: FAILED: patch "[PATCH] iio: adc: ad4030: fix invalid oversampling_ratio validation" failed to apply to 6.18-stable tree
To: salah.triki@gmail.com,andriy.shevchenko@intel.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:43:06 +0200
Message-ID: <2026100606-wolf-obsessed-e5c2@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d615210564205993e8f0e7ccb57cc2e66b7d5706
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100606-wolf-obsessed-e5c2@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d615210564205993e8f0e7ccb57cc2e66b7d5706 Mon Sep 17 00:00:00 2001
From: Salah Triki <salah.triki@gmail.com>
Date: Thu, 3 Sep 2026 12:43:09 +0100
Subject: [PATCH] iio: adc: ad4030: fix invalid oversampling_ratio validation

In ad4030_set_avg_frame_len(), the logarithm is calculated before input
validation. Passing zero or negative values leads to an undefined result
from ilog2().

Validate that the input is strictly positive prior to computing its
logarithm.

Fixes: 949abd1ca5a4 ("iio: adc: ad4030: add averaging support")
Assisted-by: LLM
Signed-off-by: Salah Triki <salah.triki@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/adc/ad4030.c b/drivers/iio/adc/ad4030.c
index e97400a1aa48..877b06007396 100644
--- a/drivers/iio/adc/ad4030.c
+++ b/drivers/iio/adc/ad4030.c
@@ -746,14 +746,21 @@ static int ad4030_set_chan_calibbias(struct iio_dev *indio_dev,
 static int ad4030_set_avg_frame_len(struct iio_dev *dev, int avg_val)
 {
 	struct ad4030_state *st = iio_priv(dev);
-	unsigned int avg_log2 = ilog2(avg_val);
 	unsigned int last_avg_idx = ARRAY_SIZE(ad4030_average_modes) - 1;
+	unsigned int avg_log2;
 	int freq_hz;
 	int ret;
 
-	if (avg_val < 0 || avg_val > ad4030_average_modes[last_avg_idx])
+	/* Reject unsupported modes */
+	if (avg_val > ad4030_average_modes[last_avg_idx])
 		return -EINVAL;
 
+	/* Avoid invalid values for logarithm since it's undefined */
+	if (avg_val < 1)
+		return -EINVAL;
+
+	avg_log2 = ilog2(avg_val);
+
 	if (st->offload_trigger) {
 		/*
 		 * The sample averaging and sampling frequency configurations

