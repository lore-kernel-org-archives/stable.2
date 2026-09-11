Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F5693D5643
	for <Stable@vger.kernel.org>; Fri, 11 Sep 2026 09:56:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120587; cv=none; b=YPsQwtrs7uMDR3hKMe1P1kbQQkdNiaeaXT5oeyHI/+bo9sEhCZFbftt+cjzWKGwRpC0lL2rykKbbwcJrx93nndzNIyofuz25ApCsp6fb5pOkN+sDCfdqxKdNW7agAJiC3A7zFuTDoXNp1yQjkGQ1QCvkedKcHiflF5KRmIDwguY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120587; c=relaxed/simple;
	bh=4E/4CXvhW5Q47aTzpjmb3sC5/HY5VgFMHx2WAU9hHds=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=H9On0fVJA48yDoS8wKb8T1MZAzUBjI5iQRgoXtxBdFd7Xz2bemmkkxtFgE8JhdpfDki15zIJYxlXrw9HOOgq5huhPnoXsErlwrGb1mEgG9Eng2j1+ehjwUzbU0BUI9HzzU9o/T2QaneuGNdXhdITaUswkQwF5HnemCHVjQBSnj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=WVBE63PS; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="WVBE63PS"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411AA1F000FF;
	Fri, 11 Sep 2026 09:56:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789120586;
	bh=iiHkZsurniY2xHlOB0M5OYkmcZYIW0o3lbR8r1C2+lY=;
	h=Subject:To:From:Date;
	b=WVBE63PSKG8ZwNEAwfUKCGo/45JvzbjOqWn2gx2dAsuA21xJ3SgAZZTGHdIoU0Rfs
	 SdH0UJIuHp5gDZFODVwg3Pg+ffx4+yy6Pd8pvFYm/Z3dGce3maV8MrKIIdyQCiewDH
	 gXqxVIcQZxUA1zLEXaXWbC73+85Rqa83YMwZ1t5Y=
Subject: patch "iio: adc: rohm-bd79124: Catch regmap errors at measurement start/stop" added to char-misc-linus
To: mazziesaccount@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 11:55:33 +0200
Message-ID: <2026091133-exemption-manicure-cf4d@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: rohm-bd79124: Catch regmap errors at measurement start/stop

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From 196cc715dce3576a54065f5cb07185c75778f9a8 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Mon, 10 Aug 2026 10:51:20 +0300
Subject: iio: adc: rohm-bd79124: Catch regmap errors at measurement start/stop

The bd79124_start_measurement() and bd79124_stop_measurement() ignore
errors from the regmap reads, causing potential use of uninitialized
stack variable when deciding whether the measurement is already
started/stopped. The bd79124_stop_measurement() may also ignore failure
to clear the sequencer state bits, which may make the hardware to ignore
the setting and leave hardware and driver states out of sync.

Check the return value and bail-out if error is detected.

Fixes: 3f57a3b9ab74 ("iio: adc: Support ROHM BD79124 ADC")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/rohm-bd79124.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/iio/adc/rohm-bd79124.c b/drivers/iio/adc/rohm-bd79124.c
index f5b3096f553f..8091a138cca8 100644
--- a/drivers/iio/adc/rohm-bd79124.c
+++ b/drivers/iio/adc/rohm-bd79124.c
@@ -381,6 +381,9 @@ static int bd79124_start_measurement(struct bd79124_data *data, int chan)
 
 	/* See if already started */
 	ret = regmap_read(data->map, BD79124_REG_AUTO_CHANNELS, &val);
+	if (ret)
+		return ret;
+
 	if (val & BIT(chan))
 		return 0;
 
@@ -420,11 +423,16 @@ static int bd79124_stop_measurement(struct bd79124_data *data, int chan)
 
 	/* See if already stopped */
 	ret = regmap_read(data->map, BD79124_REG_AUTO_CHANNELS, &enabled_chans);
+	if (ret)
+		return ret;
+
 	if (!(enabled_chans & BIT(chan)))
 		return 0;
 
 	ret = regmap_clear_bits(data->map, BD79124_REG_SEQ_CFG,
 				BD79124_MSK_SEQ_START);
+	if (ret)
+		return ret;
 
 	/* Clear the channel from the measured channels */
 	enabled_chans &= ~BIT(chan);
-- 
2.55.0


