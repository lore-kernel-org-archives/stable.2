Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9244339768F
	for <Stable@vger.kernel.org>; Fri, 11 Sep 2026 09:56:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120579; cv=none; b=tzwozHHkJY22ACSme1oIb0keEXkoYpbMMzYfWvp4ygOhnT5nk/CazkSw2clBfcaw4WYZykKp2n/WkgoEN3pzGURrcegsDj9ad+dyFnyr+XVomq/XEs7DxBesG+XTs5iQg/3mZfj1XWWSsJ+H36EQkTDuhkEpa3G9ZmCV3YsnViw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120579; c=relaxed/simple;
	bh=2GA92MOAfuAWiubJ118iSwdTrW1g4RDCYoVVlUstxto=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=KUDG3mSpV7gVDVIlTG8NUYSxEnhDCHrVhJm4/eqgQJQ8u6/38GbLQXoFCXUOs1GcLPEvgJREREBpWVKGug/6sDZKBObfKSaiiPBtTSWEu0dAg2Jret00uRBtYzjALXZM2DxzTt8PzcsMzpXASu1S67BLUeP3o8k/lIeTlRkG/RY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DQ/2zlam; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DQ/2zlam"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DE6C1F000FF;
	Fri, 11 Sep 2026 09:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789120576;
	bh=i6tlw8/97hjzKbWkaJ19tsA9v+2wubrBSGF4g+IYwZo=;
	h=Subject:To:From:Date;
	b=DQ/2zlamv25tVbDo92nrNA3QE+r7hgmuQyNngMIH+/cVqHgrrQzrGeQwXcLCb/4pb
	 BHltYtAQEbzGU+/kvewesxsiILjxAtCT8wylQEQ7s5HHTC+QFNPyoPw7pRwpmbSTmc
	 NBBHS4l6okShmD62WvMLjlR5EZHnK0RzuIITjVAY=
Subject: patch "iio: adc: ade9000: fix overlapping scan_index for current and voltage" added to char-misc-linus
To: antoniu.miclaus@analog.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 11:55:32 +0200
Message-ID: <2026091132-numeral-deport-4e77@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ade9000: fix overlapping scan_index for current and voltage

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From d01f63f673e18f3a99ce8d6fbf1a5f58b70990f7 Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Fri, 7 Aug 2026 11:56:42 +0300
Subject: iio: adc: ade9000: fix overlapping scan_index for current and voltage
 channels

Current channels used scan_index "num" and voltage "num + 1", so with
phases 0, 1 and 2 the indices overlapped and no longer matched the
IA=0, VA=1, IB=2, VB=3, IC=4, VC=5 layout expected by
ade9000_waveform_buffer_config(). Phase B and C buffers were configured
incorrectly.

Use "num * 2" for current and "num * 2 + 1" for voltage to get the
non-overlapping 0/1, 2/3, 4/5 layout.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ade9000.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 51cb43755a1f..167b1f4d6279 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -444,7 +444,7 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 			      BIT(IIO_CHAN_INFO_CALIBSCALE),		\
 	.event_spec = ade9000_current_events,				\
 	.num_event_specs = ARRAY_SIZE(ade9000_current_events),		\
-	.scan_index = num,						\
+	.scan_index = num * 2,						\
 	.indexed = 1,							\
 	.scan_type = {							\
 		.sign = 's',						\
@@ -464,7 +464,7 @@ static const struct iio_chan_spec_ext_info ade9000_ext_info[] = {
 			      BIT(IIO_CHAN_INFO_FREQUENCY),		\
 	.event_spec = ade9000_voltage_events,				\
 	.num_event_specs = ARRAY_SIZE(ade9000_voltage_events),		\
-	.scan_index = num + 1,	/* interleave with current channels */	\
+	.scan_index = num * 2 + 1, /* interleave with current channels */	\
 	.indexed = 1,							\
 	.scan_type = {							\
 		.sign = 's',						\
-- 
2.55.0


