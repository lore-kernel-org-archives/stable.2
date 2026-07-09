Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F9263A381C
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:45:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575951; cv=none; b=Y1WROftXXGaRDQwgCfCAzkyjbFDTWfYur1ddxkYrLm8X93/TgF4kvYBBvEbYIvxcJD6eyyP8TN2eoArprP7BMcXLhSTEFEQW29EDBOturttIFLYBrm2cjmZZqHGQaltBJW98Lzk5hhNhtT7jsY+m/mQsFS2vGFYii85IwE6s3S8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575951; c=relaxed/simple;
	bh=5QBSUym2p8qcEu81J5k1JeIc2teFNnhOKNTpTEZupck=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=WDbi4ilHVA7WmpfuZr6pcz0El/Lt8Cq95hdKSjVAhPJiKvcrCOW9L1WkaHqX27xKk7yBKLFme9zW3FaFFM3ZmDREa8hERt46/EDkSRrrOepgiZgvRctQY1xMrTWWLBqZnT4S8O6S4DNrnCa1q+jD6vOp3xfSFTIAs54miUrz9JE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=DMy1uVZB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="DMy1uVZB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0401F000E9;
	Thu,  9 Jul 2026 05:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575950;
	bh=bFNBB9Z5GaA982HtmnfTOQJoOKbY0EYAPaSOJCrdFpg=;
	h=Subject:To:From:Date;
	b=DMy1uVZB8o5OG/Bd/jvbTbB6tj3v4jlVtv23RioFo+qVB7gzJxNCJw3yuWw63Hvvw
	 +0QNFhXp4Q5fy/esCTj3CwR8LfVLyHQf1kqfZQrP1THN3gJkwIrMxHDCDttwFVBYo2
	 u3RLY+Bvl8NSrZ5t7F7U+5bheL/g/LIx/hZEQ9RA=
Subject: patch "iio: adc: nxp-sar-adc: Fix the delay calculation in" added to char-misc-linus
To: andriy.shevchenko@linux.intel.com,Stable@vger.kernel.org,daniel.lezcano@oss.qualcomm.com,jic23@kernel.org,sashiko-bot@kernel.org,sozdayvek@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:52 +0200
Message-ID: <2026070952-campsite-diffusive-0ba9@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: nxp-sar-adc: Fix the delay calculation in

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From a9f41809bf1bd8e5c1bc4b6a1052adac58eb7ab6 Mon Sep 17 00:00:00 2001
From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Date: Tue, 19 May 2026 23:56:06 +0200
Subject: iio: adc: nxp-sar-adc: Fix the delay calculation in
 nxp_sar_adc_wait_for()

The original code was using ndelay() twice. In one case the delay
is calculated as 1/3 of ADC clock and in the other as 80 ADC clocks.
But according to the comments in all cases it should be a multiplier
of the ADC clock, and not a fraction of it. Inadvertently
nxp_sar_adc_wait_for() takes the wrong case and spread it over
the code make it wrong in all places. Fix this by modifying a helper
to correctly use the multiplier.

Fixes: 7e5c0f97c66a ("iio: adc: nxp-sar-adc: Avoid division by zero")
Fixes: 4434072a893e ("iio: adc: Add the NXP SAR ADC support for the s32g2/3 platforms")
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260416090122.758990-1-andriy.shevchenko%40linux.intel.com
Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Reviewed-by: Stepan Ionichev <sozdayvek@gmail.com>
Acked-by: Daniel Lezcano <daniel.lezcano@oss.qualcomm.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/nxp-sar-adc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/adc/nxp-sar-adc.c b/drivers/iio/adc/nxp-sar-adc.c
index 15c7432808f4..6bf896915788 100644
--- a/drivers/iio/adc/nxp-sar-adc.c
+++ b/drivers/iio/adc/nxp-sar-adc.c
@@ -198,13 +198,13 @@ static void nxp_sar_adc_irq_cfg(struct nxp_sar_adc *info, bool enable)
 		writel(0, NXP_SAR_ADC_IMR(info->regs));
 }
 
-static void nxp_sar_adc_wait_for(struct nxp_sar_adc *info, unsigned int cycles)
+static void nxp_sar_adc_wait_for(struct nxp_sar_adc *info, u64 cycles)
 {
 	u64 rate;
 
 	rate = clk_get_rate(info->clk);
 	if (rate)
-		ndelay(div64_u64(NSEC_PER_SEC, rate * cycles));
+		ndelay(div64_u64(NSEC_PER_SEC * cycles, rate));
 }
 
 static bool nxp_sar_adc_set_enabled(struct nxp_sar_adc *info, bool enable)
-- 
2.55.0


