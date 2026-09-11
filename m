Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D02C3D45D4
	for <Stable@vger.kernel.org>; Fri, 11 Sep 2026 09:56:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120565; cv=none; b=WNPc/fTtbc2s1N1cBdZUyTmmTIZoYWhDEH/55BD4lPNyQB0esuwaaOfZ2jVdm65veWhYKy1yaOZgNB/tFl7ZG6f4Z6BQTgophFEexlVLzNAFraMgafLnSUujlwl2mm9Myh1R90Dw/PAJWiXZ6nYF9kTi1Hjyfm+IGp/oQy4GbqI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120565; c=relaxed/simple;
	bh=+HScJy23i7tAv9pvIkBlX9tVEevfdCzfjZfvXzgCYZE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=eRR6twVfTqCATVk9jkwtvnLQphS4mdYsg798lCkbiE5kVkZJPzaa5H/ySZxuJ7l92o9AZ4leve5cFA7sfMrqo7w+F2uMwTDcV1A9FP/v9WETR7Ibs9/F1ZWB2gIPSemw2Qa3bmii0efQ7t5qLNGcRkwljPV9qOIb2xb/JeZvjG4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=sNJoebYr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="sNJoebYr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCF171F000FF;
	Fri, 11 Sep 2026 09:56:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789120563;
	bh=Y8qAX3Iq6mi5y/62rtRpdwrrxbQkXmASTvAyIzrp39c=;
	h=Subject:To:From:Date;
	b=sNJoebYr+DP1kjjdM493GwZYMvZ/JYSjvMAZukOwAxTtm4+ebipdUudthYEGw7gUj
	 rc8RF8yxAswqYrYUP4l/kiakZvPyVtqxYTBlm5bL1pB6FDNT0hnxlGg7zxM4IrfPv8
	 WJgSfBdQlHexoGzVt5M6/Kk7o2dzbyM5XYNVQf6Q=
Subject: patch "iio: adc: ade9000: handle Phase C dip events in IRQ1 handler" added to char-misc-linus
To: antoniu.miclaus@analog.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 11:55:32 +0200
Message-ID: <2026091132-tameness-bulginess-ed21@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ade9000: handle Phase C dip events in IRQ1 handler

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From fafefa925ed7ec10383d9bf0378abf878b7f13cb Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Fri, 7 Aug 2026 11:56:43 +0300
Subject: iio: adc: ade9000: handle Phase C dip events in IRQ1 handler

ADE9000_ST1_CROSSING_DEPTH is the exclusive upper bound for scanning the
STATUS1 event bits, so a value of 25 left out the highest event bit,
ADE9000_ST1_DIPC_BIT (bit 25). Phase C dip events were never reported.

Bump the value to 26 so bit 25 is scanned.

Fixes: 81de7b4619fc ("iio: adc: add ade9000 support")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/adc/ade9000.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ade9000.c b/drivers/iio/adc/ade9000.c
index 167b1f4d6279..da6caabfe2a4 100644
--- a/drivers/iio/adc/ade9000.c
+++ b/drivers/iio/adc/ade9000.c
@@ -219,7 +219,7 @@
 #define ADE9000_ST1_ERROR2_BIT		BIT(30)
 #define ADE9000_ST1_ERROR3_BIT		BIT(31)
 #define ADE9000_ST1_CROSSING_FIRST	6
-#define ADE9000_ST1_CROSSING_DEPTH	25
+#define ADE9000_ST1_CROSSING_DEPTH	26
 
 #define ADE9000_WFB_TRG_DIP_BIT		BIT(0)
 #define ADE9000_WFB_TRG_SWELL_BIT	BIT(1)
-- 
2.55.0


