Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CCC932DC764
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 06:05:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781417131; cv=none; b=L9wp5Bqc4QtHQSxin59XURn0da7XA54qX/2G3cNObjfJGrjZXK5GNpMoazUxL3AzYQ4/UooCbDbu8MvHPpDOTscHINEM56Kd4l4KfmZ6D/MHbOC0yYyODN08XTz2hTVhnKiBQovP5bkjo0n8LIkapiE2Y9qQNy3FJX+c1/569w4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781417131; c=relaxed/simple;
	bh=SWGXED45forJ5tylH1gli/GaQ6rGO7j4/9hChc9vBh8=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=mf7/twzbkWSh/tHcTszNu2ucwjgVMtl/6bxBNd7nq7x0J2ZvrHuor/+ZL1KzACCVZO+JkjNHJ4nl0bWIUWP+a6n0gZBnR7mz9D7h7E2TE5/4RhjcdlDKehCtz2m9S750m6mgB2kX/uBCZlO46Hj0mX2M6mDaYOhdO234bSb5Sko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=mfrl4dyl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="mfrl4dyl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1971D1F000E9;
	Sun, 14 Jun 2026 06:05:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781417130;
	bh=a+L5b6I7osZleqfwrxcRj9hfP1IYkeBzuGu/vc9MPow=;
	h=Subject:To:From:Date;
	b=mfrl4dylX/0mV8WBNNERsnSAaoimV0qagH10NifKbcFTTGIto+3Opa+8og9C41r9e
	 2y+LvspPrGS2GWNKhX7jmbX+AOoadAWzl9PInoBd62eQks3QWejVcexNUQiCbrWvMp
	 7dsKsGEN43KvFGJ+lGzkwO/wo4rFOhVHsCt9JHmA=
Subject: patch "iio: chemical: scd30: Cleanup initializations and fix sign-extension" added to char-misc-next
To: m32285159@gmail.com,Stable@vger.kernel.org,jic23@kernel.org,sashiko-bot@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 08:03:39 +0200
Message-ID: <2026061439-smirk-kindling-9687@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: chemical: scd30: Cleanup initializations and fix sign-extension

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-next branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will also be merged in the next major kernel release
during the merge window.

If you have any questions about this process, please let me know.


From 60d877910a43c305b5165131b258a17b1d772d57 Mon Sep 17 00:00:00 2001
From: Maxwell Doose <m32285159@gmail.com>
Date: Tue, 26 May 2026 17:55:24 -0500
Subject: iio: chemical: scd30: Cleanup initializations and fix sign-extension
 bug

Include linux/bitfield.h for FIELD_GET().

Create new macros for bit manipulation in combination with manual bit
manipulation being replaced with FIELD_GET().

The current variable declaration and initializations are barely readable
and use comma separations across multiple lines. Refactor the
initializations so that mantissa and exp have separate declarations and
sign gets initialized later.

In addition (and due to the nature of the cleanup), fix a sign-extension
bug where, float32 would get bitwise anded with ~BIT(31)
(which is 0xFFFFFFFF7FFFFFFF) which corrupted the exponent.

Fixes: 64b3d8b1b0f5c ("iio: chemical: scd30: add core driver")
Reported-by: sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260524020309.18618-1-m32285159%40gmail.com
Signed-off-by: Maxwell Doose <m32285159@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/chemical/scd30_core.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/iio/chemical/scd30_core.c b/drivers/iio/chemical/scd30_core.c
index 11d6bc1b63e6..d02f2de42327 100644
--- a/drivers/iio/chemical/scd30_core.c
+++ b/drivers/iio/chemical/scd30_core.c
@@ -4,6 +4,8 @@
  *
  * Copyright (c) 2020 Tomasz Duszynski <tomasz.duszynski@octakon.com>
  */
+
+#include <linux/bitfield.h>
 #include <linux/bits.h>
 #include <linux/cleanup.h>
 #include <linux/completion.h>
@@ -43,6 +45,11 @@
 #define SCD30_TEMP_OFFSET_MAX 655360
 #define SCD30_EXTRA_TIMEOUT_PER_S 250
 
+/* Floating point arithmetic macros */
+#define SCD30_FLOAT_MANTISSA_MSK GENMASK(22, 0)
+#define SCD30_FLOAT_EXP_MSK GENMASK(30, 23)
+#define SCD30_FLOAT_SIGN_MSK BIT(31)
+
 enum {
 	SCD30_CONC,
 	SCD30_TEMP,
@@ -89,10 +96,14 @@ static int scd30_reset(struct scd30_state *state)
 /* simplified float to fixed point conversion with a scaling factor of 0.01 */
 static int scd30_float_to_fp(int float32)
 {
-	int fraction, shift,
-	    mantissa = float32 & GENMASK(22, 0),
-	    sign = (float32 & BIT(31)) ? -1 : 1,
-	    exp = (float32 & ~BIT(31)) >> 23;
+	int fraction, shift, sign;
+	int mantissa = FIELD_GET(SCD30_FLOAT_MANTISSA_MSK, float32);
+	int exp = FIELD_GET(SCD30_FLOAT_EXP_MSK, float32);
+
+	if (float32 & SCD30_FLOAT_SIGN_MSK)
+		sign = -1;
+	else
+		sign = 1;
 
 	/* special case 0 */
 	if (!exp && !mantissa)
-- 
2.54.0


