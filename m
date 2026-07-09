Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAB291F91E3
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:46:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575964; cv=none; b=MYGex36qRdIVDQhudaLakqjkidHK83a8QK15RRFoEx6CpfLH52XfL0xOAlwZTGnOO2Rg8EY+sV7e1A8Exezn9Bidkv05bpc2YGogMwChz9/qMR2FTXiSGNq/YprniVGfq632PsMC5Kx1y27tzP4aACKG+uwsrHRRCYhElFkdSPk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575964; c=relaxed/simple;
	bh=4ElvRs99T5XHtXNX+0keCfSpUjk+GF9PTuhdFATrP6Y=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=sNmJkTQ/AHyuDe+1Wfj6xPy+7fVTR+gZMbksRgtOE3l+JAfpFXtzqBpEKg6hycTyD9bYAkssyOV5XR9QQW6oFnxwA45ZoGP0yl5VsJ2lY/OuQK+gLQ+LyYOf0Ok07uf1s+KCXhYRsUkkPdWWJYNrRNDmZZhSu9KAYmPomEXLsmM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=nbdzJ+At; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="nbdzJ+At"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4BA1F000E9;
	Thu,  9 Jul 2026 05:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575963;
	bh=G9jrIQ2IVt+Zs9FQJITSr3ndGqea/26FGAiLEMJL1jM=;
	h=Subject:To:From:Date;
	b=nbdzJ+AtyzpkAXthmVrTa6Dgx0WGqgEtBocBpE9/CDpEww/H/v3CX1aHtjl6q6hFf
	 WUCR0JbDt5puF9N80GgzsKLwDL2CGbBhkvV4B5Vrd353sE+FpH7xZW4xJ2XrrnC3iI
	 ZML/MdMoR/MgWnD+swN2dXBqT2fV8LyYFx8GORK4=
Subject: patch "iio: light: al3010: fix incorrect scale for the highest gain range" added to char-misc-linus
To: vidhu.linux@gmail.com,Stable@vger.kernel.org,andriy.shevchenko@intel.com,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:53 +0200
Message-ID: <2026070953-laurel-defacing-d628@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: al3010: fix incorrect scale for the highest gain range

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From aa411adc6ce40ad1a55ebc965f255a4cfc0005f8 Mon Sep 17 00:00:00 2001
From: Vidhu Sarwal <vidhu.linux@gmail.com>
Date: Sat, 4 Jul 2026 17:22:45 +0530
Subject: iio: light: al3010: fix incorrect scale for the highest gain range

al3010_scales[] encodes the highest gain range as {0, 1187200}.
For IIO_VAL_INT_PLUS_MICRO, the fractional part must be less than
1000000, so the scale 1.1872 should instead be represented as
{ 1, 187200 }.

Since write_raw() compares the value from userspace against this
table, writing the advertised 1.1872 scale never matches the malformed
entry and returns -EINVAL. As a result, the highest gain range cannot
be selected. Reading the scale in that state also reports the malformed
value.

Fixes: c36b5195ab70 ("iio: light: add Dyna-Image AL3010 driver")
Signed-off-by: Vidhu Sarwal <vidhu.linux@gmail.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/light/al3010.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index d603b4a6b8e8..ca1d7fd6defb 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -42,7 +42,7 @@ enum al3xxxx_range {
 };
 
 static const int al3010_scales[][2] = {
-	{0, 1187200}, {0, 296800}, {0, 74200}, {0, 18600}
+	{ 1, 187200 }, { 0, 296800 }, { 0, 74200 }, { 0, 18600 },
 };
 
 static const struct regmap_config al3010_regmap_config = {
-- 
2.55.0


