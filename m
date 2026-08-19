Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F0F703DEAC1
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 07:44:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787125478; cv=none; b=nrFU+suCtIHccNREIGDHYfEAEh6YnuYHSDM1ZAwnYjHaF7HD3nH+TQlnONF5EzaV19/YiEs9QxLeXJxtY6u+4MO+z6kGtnKVvgNYCacuz9S3bHzE0m693iciE36FvCVK1Ey7K+SZxRAuSgU5HhfF4yh2Pc5NGJbZ/muC/Pj3Z8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787125478; c=relaxed/simple;
	bh=rxIHoihCYSzDESdjPyGu5T73JM1hLeiWHlsTAe1m5NU=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=UAxK9k/1YEyfk9b9wCaeagPdD5/sgJ3FGBKJPwMb3toxGB7yq26oil3iW0ktjosSkVffjoPNX9A1kaa0hAMfx29YRdt0f1SYFgTKspv7Oj7bNzPoJP4Tmnmf1Btq6tFvPXadUo7pW3BtWhrnq36iXlc9cOqgCmLMXiBl3xk6A28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=e/k6t4XP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="e/k6t4XP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 56D9C1F000E9;
	Wed, 19 Aug 2026 07:44:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787125471;
	bh=iZ/UqoPEW+mQC5W5fuN6HzwIg9AEmRtBlUJaNqWMHGM=;
	h=Subject:To:From:Date;
	b=e/k6t4XPDxz83C2BjVQHAG6DJGbpgmbkv2kxOFSljJLQF1PLNq6BGQOqiwq3gQ+xq
	 B21qNfsRkKUQCITpXsT/ww5bGYKQIkJeXYDHjH/0Vo8sgjQsC+H7juNJbhOYk2C8s0
	 dPwqXfFq63kKTTkvgp1g6Dxn235zvDqjsDGmD1I0=
Subject: patch "iio: dac: ad3552r-hs: fix scnprintf() buffer bound in data source" added to char-misc-testing
To: bbnpreetsingh@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:44:04 +0200
Message-ID: <2026081904-harmonize-dosage-25a7@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: dac: ad3552r-hs: fix scnprintf() buffer bound in data source

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From f2c5c76306fadb834dd5ea76cab0b7cd447e6035 Mon Sep 17 00:00:00 2001
From: Babanpreet Singh <bbnpreetsingh@gmail.com>
Date: Sat, 18 Jul 2026 18:22:36 +0000
Subject: iio: dac: ad3552r-hs: fix scnprintf() buffer bound in data source
 show

ad3552r_hs_show_data_source_avail() formats the available data source
names into a 128-byte stack buffer, but bounds each scnprintf() with
PAGE_SIZE instead of the buffer size, so the bound does not protect
the destination at all.

This cannot overflow today - dbgfs_attr_source[] has two entries,
"normal" and "ramp-16bit", 18 bytes formatted - but the bound stops
protecting the stack the day the table grows. Use sizeof(buf) so the
bound matches the destination.

Found by smatch:

  drivers/iio/dac/ad3552r-hs.c:593 ad3552r_hs_show_data_source_avail()
  error: scnprintf() 'buf[len]' too small (128 vs 4096)

Fixes: b1c5d68ea66e ("iio: dac: ad3552r-hs: add support for internal ramp")
Assisted-by: Claude:claude-sonnet-5
Signed-off-by: Babanpreet Singh <bbnpreetsingh@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/dac/ad3552r-hs.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/dac/ad3552r-hs.c b/drivers/iio/dac/ad3552r-hs.c
index 6bc64f53bce9..5d6c2517a7a8 100644
--- a/drivers/iio/dac/ad3552r-hs.c
+++ b/drivers/iio/dac/ad3552r-hs.c
@@ -591,7 +591,7 @@ static ssize_t ad3552r_hs_show_data_source_avail(struct file *f,
 	int i;
 
 	for (i = 0; i < ARRAY_SIZE(dbgfs_attr_source); i++) {
-		len += scnprintf(buf + len, PAGE_SIZE - len, "%s ",
+		len += scnprintf(buf + len, sizeof(buf) - len, "%s ",
 				 dbgfs_attr_source[i]);
 	}
 	buf[len - 1] = '\n';
-- 
2.55.0


