Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E9F13B71B7
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 07:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791272690; cv=none; b=oZ6Zhj8UQ2F1nyAFa6kyY6kCBiBr9SZ7OGDEf+aO19qhkWX1r3QqXq5eKfAriyq3asl+UuHM+R5J+W7qmhhvwhebZEqXo+p/y6ttiybd8jK78/406WWvODiocN6u3U59wnYXdkItolZBJiJ2/cC05en5nuZd4TZE+ssbEQnjtEI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791272690; c=relaxed/simple;
	bh=5ye+Q8jn8xITd3Rb2/eEtcWUhpoP3GdO9Uk2fZkeuYw=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=HKyD1ivxxlq82hgUTjEYrnByc4l442t2zMCRxUsYAzMUm5s4YvLZnInkKOigrnqmQkWIz7eE9zffA1tdj8GXx7G8D61YG576tTznh5h5mYA/ISfh0wJc7w80EFNSml4Sgc16+PNbmOMz3D+0Z64kiz9ieCp9nUQrOyAXCjzmYz0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=ChzuJvmW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="ChzuJvmW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 078E31F000FF;
	Tue,  6 Oct 2026 07:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791272689;
	bh=kPtnN7r7QeSazTQFyjARVD/DBwGZVRNfSrSrZ6BeqQE=;
	h=Subject:To:Cc:From:Date;
	b=ChzuJvmWqK87JiwGEQBI0ofIaS08nGvNO0IKhg/F2YUc2xqUiuXZD3LMJFCBGZJFO
	 s+Al6oQUY5E1HwBfLHA08oKdjOZtsPoFfuN4aX58Nsj5KzaTg4sZBrl7/jbfPPS49V
	 /as7GcaavsjDVpqg/u7SGo+4WSNxpZiFhr2XVtQk=
Subject: FAILED: patch "[PATCH] iio: adc: max1363: sign-extend bipolar differential channel" failed to apply to 5.10-stable tree
To: congnt264@gmail.com,andriy.shevchenko@intel.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 06 Oct 2026 09:44:25 +0200
Message-ID: <2026100625-reverse-alabaster-6736@gregkh>
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
git cherry-pick -x 91908c0a78baddc8572aa3ab69e62ee2eb496ba4
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100625-reverse-alabaster-6736@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 91908c0a78baddc8572aa3ab69e62ee2eb496ba4 Mon Sep 17 00:00:00 2001
From: Cong Nguyen <congnt264@gmail.com>
Date: Mon, 10 Aug 2026 23:44:46 +0700
Subject: [PATCH] iio: adc: max1363: sign-extend bipolar differential channel
 reads

MAX1363 differential channels are bipolar, but max1363_read_single_chan()
masks the raw value to the ADC resolution without sign-extending it.
Negative differential readings are therefore reported to userspace as
large positive values (e.g. -1 as 4095 on a 12-bit part).

Sign-extend the masked value from the resolution bit for differential
channels. Single-ended channels are unipolar and are left unchanged.

Fixes: d1325cf45077 ("Staging: IIO: max1363 ADC driver")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-4
Signed-off-by: Cong Nguyen <congnt264@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/adc/max1363.c b/drivers/iio/adc/max1363.c
index 65a2d92bb112..629c53af6472 100644
--- a/drivers/iio/adc/max1363.c
+++ b/drivers/iio/adc/max1363.c
@@ -404,6 +404,14 @@ static int max1363_read_single_chan(struct iio_dev *indio_dev,
 
 		data = rxbuf[0];
 	}
+
+	/*
+	 * Differential channels are bipolar and the device returns the sample
+	 * in two's complement, so sign-extend it from the resolution bit.
+	 */
+	if (chan->differential)
+		data = sign_extend32(data, st->chip_info->bits - 1);
+
 	*val = data;
 
 	return 0;

