Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EBC9035C697
	for <Stable@vger.kernel.org>; Wed, 19 Aug 2026 08:07:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787126851; cv=none; b=nYngroxOCeiPctHq/N9+2ETmRRg2V3aXgU9A95yUD9PnoK88maPGAIc4qylu2eecZGmjxWreOdQYHGzLTroMKkVwRmqxDRqfIcTVXSzp6S/x6kpV3+NykRmRa1uj/Ha2P6zapY0lhpU7zBHnxEM3VGxfIjrnzUN8NHj3BC4UyVM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787126851; c=relaxed/simple;
	bh=7cl4F0vNsFyiyMrfoPO6lqHbjQl9TpnEvV21Jv0vpVo=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=CD6vg+fanbqW9K0gLxHbjtx8SLJnspKbdexrZ9IiINZZW+PytrU386SYFWRSjh2Uor+jgX1gvVgxanN4NYX+3ehRXCQLinx9ILyWbOx1j64A1YD4RLviqjZEK2puaoji761RcAzHq0rH+vcg0oLxPTyK0ciPN2Of3Ir3hwVD8EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=f1h9P3Od; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="f1h9P3Od"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BEA111F000E9;
	Wed, 19 Aug 2026 08:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1787126849;
	bh=n4lr2vSOwa1/w4aqFpEHYJSuYhv7mfdChfvkPj1kCM0=;
	h=Subject:To:From:Date;
	b=f1h9P3OdivQklYT7lqFD09FmV7NzDdM2I3PtvzaxlgLJZbmENEsJ2WItTmZHxXTNh
	 OyJ+knyP6xO4n6SnMyqLxAawwGRWekknuitDiqaXSY6uzX1E4LvPoagJLib4ZM/o5d
	 8dhsgDz1AW+CiFD7BnhyVgHL8HnHeDWDsA9MRfA4=
Subject: patch "iio: light: cm32181: return zero after writing calibscale" added to char-misc-testing
To: giorgi@tchankvetadze.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com,joshua.crofts1@gmail.com
From: <gregkh@linuxfoundation.org>
Date: Wed, 19 Aug 2026 09:47:58 +0200
Message-ID: <2026081958-justifier-deputy-0065@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: cm32181: return zero after writing calibscale

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From 8756acd30919a3e9f547ea4a1d4b7f7895f4d340 Mon Sep 17 00:00:00 2001
From: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
Date: Fri, 31 Jul 2026 17:20:48 +0400
Subject: iio: light: cm32181: return zero after writing calibscale

The write_raw callback is documented to return 0 on success or a
negative error code.  However, the IIO_CHAN_INFO_CALIBSCALE case
returns 'val' (the user-supplied value) instead of 0.

Fix it by returning 0 on success, matching the behavior of other
calibscale implementations in the subsystem.

Fixes: 971672c0b3cc ("iio: add Capella CM32181 ambient light sensor driver.")
Signed-off-by: Giorgi Tchankvetadze <giorgi@tchankvetadze.com>
Reviewed-by: Joshua Crofts <joshua.crofts1@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/light/cm32181.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/light/cm32181.c b/drivers/iio/light/cm32181.c
index 2590fc8fd154..b32a94028f09 100644
--- a/drivers/iio/light/cm32181.c
+++ b/drivers/iio/light/cm32181.c
@@ -368,7 +368,7 @@ static int cm32181_write_raw(struct iio_dev *indio_dev,
 	switch (mask) {
 	case IIO_CHAN_INFO_CALIBSCALE:
 		cm32181->calibscale = val;
-		return val;
+		return 0;
 	case IIO_CHAN_INFO_INT_TIME:
 		ret = cm32181_write_als_it(cm32181, val2);
 		return ret;
-- 
2.55.0


