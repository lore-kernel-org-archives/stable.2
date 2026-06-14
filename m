Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DF75E247291
	for <Stable@vger.kernel.org>; Sun, 14 Jun 2026 05:59:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781416744; cv=none; b=ZrzoG0AmesxD+PgxX+sFnq86PUpubkCVYpT8txVTvuiBDX4F2ypjQiuOoR6ZEYn8oDdxAJiqFtQO/1fQQPPZCjrW9JkX8q2JjA02U8N0+1cTTlK9PEwmpAydDsZ7A5C1pHGVXWUi8r5TjwAVhTqJmdSOIChff4STUXHZrFoxCQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781416744; c=relaxed/simple;
	bh=RJ5XAe8hfLcdILJy1Ayo8DnmNcN2f2U0X3d5XrzKwPE=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ryE6xuZhz39U98bY6sx97KR+MYtJErtTcv9Rulp82oK2MsJjWeBe9Q8vW1ICyVEjpNlJP/wyoFwXxlE691sjZWiMbQHPSWA9dT/h1XCHVD+Q6FD1J/2FdJdKH/7FQ2zW7feOyQhi1bZ/VXa4bxU4kcZ0FVdttT08kpUlVvB9OQ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TBDPEeKZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TBDPEeKZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05A211F000E9;
	Sun, 14 Jun 2026 05:59:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1781416742;
	bh=ZuZnna3VI3EUbtwab7tJcYk9w94eoB5rBOMrJLPQU0M=;
	h=Subject:To:From:Date;
	b=TBDPEeKZv4ugBS8O3RkwiUGa3qpYfrnnhhe4qmJc5LCigxOyjOxuiLPn/CxpKL67c
	 Cf/XHCXTkc4Hf1EEt0p4augbcUaBrCcXZF7JRHDn13MLvIGRtwXtmrrzCl0dXDpUEA
	 akoiHojTVZJj6enwmkL5ST5zLDxnjZr8pKaH8lx0=
Subject: patch "iio: light: al3010: read both ALS ADC registers again" added to char-misc-testing
To: grandmaster@al2klimov.de,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Sun, 14 Jun 2026 07:57:22 +0200
Message-ID: <2026061422-snowbound-mongoose-74eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: light: al3010: read both ALS ADC registers again

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-testing branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will be merged to the char-misc-next branch sometime soon,
after it passes testing, and the merge window is open.

If you have any questions about this process, please let me know.


From ee78fae068f52a5582aaf448d9414f826855c106 Mon Sep 17 00:00:00 2001
From: "Alexander A. Klimov" <grandmaster@al2klimov.de>
Date: Sat, 23 May 2026 13:44:57 +0200
Subject: iio: light: al3010: read both ALS ADC registers again

al3010_read_raw() used to read two adjacent registers
until the driver was modernized using the regmap framework.
That cleanup accidentally replaced the 16-bit word read
with a single byte read. I'm reverting latter.

Fixes: 0e5e21e23dd6 ("iio: light: al3010: Implement regmap support")
Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/light/al3010.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/drivers/iio/light/al3010.c b/drivers/iio/light/al3010.c
index 0932fa2b49fa..6af7b5f14a31 100644
--- a/drivers/iio/light/al3010.c
+++ b/drivers/iio/light/al3010.c
@@ -111,7 +111,8 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
 			   int *val2, long mask)
 {
 	struct al3010_data *data = iio_priv(indio_dev);
-	int ret, gain, raw;
+	int ret, gain;
+	__le16 raw;
 
 	switch (mask) {
 	case IIO_CHAN_INFO_RAW:
@@ -120,11 +121,12 @@ static int al3010_read_raw(struct iio_dev *indio_dev,
 		 * - low byte of output is stored at AL3010_REG_DATA_LOW
 		 * - high byte of output is stored at AL3010_REG_DATA_LOW + 1
 		 */
-		ret = regmap_read(data->regmap, AL3010_REG_DATA_LOW, &raw);
+		ret = regmap_bulk_read(data->regmap, AL3010_REG_DATA_LOW,
+				       &raw, sizeof(raw));
 		if (ret)
 			return ret;
 
-		*val = raw;
+		*val = le16_to_cpu(raw);
 
 		return IIO_VAL_INT;
 	case IIO_CHAN_INFO_SCALE:
-- 
2.54.0


