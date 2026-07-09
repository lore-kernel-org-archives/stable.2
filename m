Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 91EFE43932C
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:44:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575898; cv=none; b=I/oCAjoNl2z4Do7nEWfT58bXJbS4V9z5yLoZx92047cPw/7RDTrji6ojtpgan6WDCWbPBULVlxN/ir2ZO+IAkp6IphT+RieJk1KThIZdDdohNnuQbyxLidsik8ve0HYWlkIoUNtjuphR9qnyYSpgaZWgumOAlL8t74EHDM4e75s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575898; c=relaxed/simple;
	bh=Pk6XNHtwuU5N8PIMACjSVKWcDMMG2g2ztckdWrYaO7o=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=BpxHL8/PcfpgpsnB6rnV025Mx2DTWRpoewXqhFiJrhRuXZnnMrw/g804H0Bsp2pYKff+YFoYdMGQKhw9e4Cj2MDGCtMhTm8lzixD+lzM212xXUgTGrTx52FpbJtcYIRV3Hiqh6orlf48aMHEqaKy41kyeM2yjMUHnv7YPH0vMRc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=wbSUK6KP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="wbSUK6KP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B83A31F000E9;
	Thu,  9 Jul 2026 05:44:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575897;
	bh=UCKH4De1xcvch6IKGpLdRSe2n8vLUJBi1E4cm/sAP8w=;
	h=Subject:To:From:Date;
	b=wbSUK6KPksAm9hbtoPtePIF/6YXpkUKWr839bG2VHk3maHNA9nk+wdtwBhVOrbifW
	 WXBVu6zftRDHXZNIGoNwpJ0ZA3//FDEQFolupF5sij1u4VoXufcCUgdY8CpVm4V7BG
	 Uv7QqnpMO+mF5sHKNp45WRDGppvYsbqm/rAs+qCA=
Subject: patch "iio: adc: ti-ads1119: fix PM reference leak in buffer preenable" added to char-misc-linus
To: lgs201920130244@gmail.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:46 +0200
Message-ID: <2026070946-unfazed-squeak-0fe3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: adc: ti-ads1119: fix PM reference leak in buffer preenable

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From adf4bc07f814da8329278d32600147f5a150938c Mon Sep 17 00:00:00 2001
From: Guangshuo Li <lgs201920130244@gmail.com>
Date: Wed, 3 Jun 2026 20:16:40 +0800
Subject: iio: adc: ti-ads1119: fix PM reference leak in buffer preenable

ads1119_triggered_buffer_preenable() resumes the device with
pm_runtime_resume_and_get() before starting a conversion.

If i2c_smbus_write_byte() fails, the function returns the error directly
and leaves the runtime PM usage counter elevated. The matching
postdisable callback is not called when preenable fails, so the reference
is leaked and the device may remain runtime-active indefinitely.

Store the I2C transfer result in ret and drop the runtime PM reference on
failure before returning the error.

Fixes: a9306887eba41 ("iio: adc: ti-ads1119: Add driver")
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/adc/ti-ads1119.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/iio/adc/ti-ads1119.c b/drivers/iio/adc/ti-ads1119.c
index d31f3d6eb781..b0f04741ddc6 100644
--- a/drivers/iio/adc/ti-ads1119.c
+++ b/drivers/iio/adc/ti-ads1119.c
@@ -459,7 +459,11 @@ static int ads1119_triggered_buffer_preenable(struct iio_dev *indio_dev)
 	if (ret)
 		return ret;
 
-	return i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
+	ret = i2c_smbus_write_byte(st->client, ADS1119_CMD_START_SYNC);
+	if (ret)
+		pm_runtime_put_autosuspend(dev);
+
+	return ret;
 }
 
 static int ads1119_triggered_buffer_postdisable(struct iio_dev *indio_dev)
-- 
2.55.0


