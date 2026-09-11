Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DA5D53D8100
	for <Stable@vger.kernel.org>; Fri, 11 Sep 2026 09:56:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789120598; cv=none; b=Cq8JD2jGissZ/46g9nMQnWLPg8A+7IsxKTRkRdCSX1On3/Um8iTl0dsCVqiAsQSZQDIoxCDMrQMwG5G4XwgfNcdIbu70cVOAiZjKAhYjGaNOTq0VrtyEzDNhnfE8sKSnMT1NZWGkafO64BJ6FhUzsqt2CiOxknpmYS8tK6ihIGY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789120598; c=relaxed/simple;
	bh=iZ/ELCrX5PwN6bhStbxGodCyEIC5U8vY+E39HEzp8Ig=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=ol/QVNg7smpLaJGU7dRU6uJE330fuGAhyg2w8NuYfX9eMFe3OtOMthIXvOJP87896ZNywMFdZfBYp7swcDuLQw24k9GQz3GaFf36GaLWSAtWqhi1w2u/byxDrh3hMoIDmFnnclpCEfMzPG2qhHzWOPSRfBtjug1VP3w+2Oo5IGc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Rn+qR8az; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Rn+qR8az"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640681F000FF;
	Fri, 11 Sep 2026 09:56:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1789120596;
	bh=7UBr1du/JxsQi8XicY+ILf864MVTkcS0tNovN2wWA9M=;
	h=Subject:To:From:Date;
	b=Rn+qR8azYsKKa8e8p1yuPvgVWJZy1rsdKLY3qoFnx0a5yH91zyGMgB/LQGGSuHssA
	 3/OGau5jK4w7/5c70zg3rvJYgsAvCSCJRy8lT1vfVI31qhksXFNkRvYTBmw8EtBszi
	 lD9BfEtTq1kN50yb8jFiQcAQkiT5Hf/pRcW7IrMI=
Subject: patch "iio: pressure: rohm-bm1390: Return error when read fails" added to char-misc-linus
To: mazziesaccount@gmail.com,Stable@vger.kernel.org,jonathan.cameron@oss.qualcomm.com
From: <gregkh@linuxfoundation.org>
Date: Fri, 11 Sep 2026 11:55:34 +0200
Message-ID: <2026091134-repulsive-composer-f5a3@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: pressure: rohm-bm1390: Return error when read fails

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From b0e951ffc5a28141a106562997ca136ec6a0e1a3 Mon Sep 17 00:00:00 2001
From: Matti Vaittinen <mazziesaccount@gmail.com>
Date: Mon, 10 Aug 2026 10:52:47 +0300
Subject: iio: pressure: rohm-bm1390: Return error when read fails

The data reading function ignores the cached error value, and
unconditionally returns 0. Return cached 'ret' -value after stopping
the measurement so user knows if read failed and data is garbage.

Fixes: 534674463a59 ("iio: bm1390: simplify using guard(mutex)")
Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>
---
 drivers/iio/pressure/rohm-bm1390.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/iio/pressure/rohm-bm1390.c b/drivers/iio/pressure/rohm-bm1390.c
index 57941fb4a535..f9deb48e6a41 100644
--- a/drivers/iio/pressure/rohm-bm1390.c
+++ b/drivers/iio/pressure/rohm-bm1390.c
@@ -289,7 +289,7 @@ static int bm1390_read_data(struct bm1390_data *data,
 	if (warn)
 		dev_warn(data->dev, "Failed to stop measurement (%d)\n", warn);
 
-	return 0;
+	return ret;
 }
 
 static int bm1390_read_raw(struct iio_dev *idev,
-- 
2.55.0


