Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 85B01381E9A
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:45:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272718; cv=none; b=FvR0y6oolLgBfPeiL79PTv92tbalw/xkS0/qVD0OrUXg2a+GUpd3gtkkqahGj9M60umQehb2tlc4+6r8SVOC/5dsrE/aGwqBj6LixkAF7waFkJyZQZ1YCTyx/ONio9pXcvBho8oMelKHZqpRwGxVVK1KGcVjV0NnRc4wmGFT0zE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272718; c=relaxed/simple;
	bh=eaoZR75zK7xVQJkgp1kuQD8sI7kk7I1dOMrS3YLPckc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lY/LLSXz5FXPCQTq4lvi4aHP+LeUdzyFtMDvOI6QCETSdbuzmB52Y+Dgb1zANu90SemwOzneOvKGrYIn/2OhFNfb3RRq0MgTnHKC2JsNy9DYO1o0Ra8NLGCrWRUryFjZaKNpYHtJgFgewAGIjjTdo8cpCzbfbxL7myAUo+MaYzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DDLQdntw; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DDLQdntw"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E04E1F000FF;
	Tue,  6 Oct 2026 07:45:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272717;
	bh=XqPe/Y8B66jzcUIwoBtzNcgYQqNbZ/nj6+mx6OJP8lI=;
	h=Subject:To:Cc:From:Date;
	b=DDLQdntwclTV+LvML75SCfjuzU4/hjgiEK2s/Jp3eU14dAoJyZ/2LvPloKoCeHoJA
	 h9F8ls1WBdDX4VD1q3l5DkFeI2HZAtez/qvCZ+J2KV0nrRVz6R/Mtp4bsyzohll4MI
	 LFDBkV/DF9hz0fkeVa9N12DGOitJmHHvRBIep+LE=
Subject: FAILED: patch "[PATCH] iio: adc: stm32-adc: fix possible division by zero in" failed to apply to 6.6-stable tree
To: fabrice.gasnier@foss.st.com,andriy.shevchenko@intel.com,jonathan.cameron@oss.qualcomm.com,sashiko-bot@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:45:06 +0200
Message-ID: <2026100606-vitally-sprain-dbc6@gregkh>
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
git cherry-pick -x c5de6a6f855fdcf1e0ea549fb227a316db51c405
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100606-vitally-sprain-dbc6@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From c5de6a6f855fdcf1e0ea549fb227a316db51c405 Mon Sep 17 00:00:00 2001
From: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Date: Wed, 16 Sep 2026 19:15:04 +0200
Subject: [PATCH] iio: adc: stm32-adc: fix possible division by zero in
 processed channel

In case the conversion has failed or returned zero, processing *val
can lead to a division by zero. Need to check for errors, or converted
value is zero, before processing the data. In case the converted value
is zero, e.g. the Vrefint channel, this should be considered as invalid
in all cases.

Fixes: 0e346b2cfa85 ("iio: adc: stm32-adc: add vrefint calibration support")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://lore.kernel.org/all/20260911161555.244F31F000FF@smtp.kernel.org/
Cc: stable@vger.kernel.org
Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/adc/stm32-adc.c b/drivers/iio/adc/stm32-adc.c
index b77f39f305d8..90f0e257e6d1 100644
--- a/drivers/iio/adc/stm32-adc.c
+++ b/drivers/iio/adc/stm32-adc.c
@@ -1608,11 +1608,16 @@ static int stm32_adc_read_raw(struct iio_dev *indio_dev,
 			ret = stm32_adc_single_conv(indio_dev, chan, val);
 		else
 			ret = -EINVAL;
-
-		if (mask == IIO_CHAN_INFO_PROCESSED)
-			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
-
 		iio_device_release_direct(indio_dev);
+		if (ret < 0)
+			return ret;
+
+		if (mask == IIO_CHAN_INFO_PROCESSED) {
+			if (*val == 0)
+				return -EINVAL;
+			*val = STM32_ADC_VREFINT_VOLTAGE * adc->vrefint.vrefint_cal / *val;
+		}
+
 		return ret;
 
 	case IIO_CHAN_INFO_SCALE:

