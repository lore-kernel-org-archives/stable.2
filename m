Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DB443932C
	for <Stable@vger.kernel.org>; Thu,  9 Jul 2026 05:44:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783575901; cv=none; b=sutpAwrbcyJ8YrTXph+kxtCycvx4+XU7ghRlcqQRpG2EW1TRwiJlL6PzgFDkAfci7ytz0lcdkxYgRGmtpQ3VOUdDK6520lz+Dx6b+XwF+FWd4ttQ/VlLAIE8LUi/NpMzUyqU28tNXRbsG8t50gdU0rOK8VIG7oNmroGLpL6Ydqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783575901; c=relaxed/simple;
	bh=dlw/ZFzYtGKHZ28FEFSJNRw28M+u6Rmc5OO106sTr2E=;
	h=Subject:To:From:Date:Message-ID:MIME-Version:Content-Type; b=CTl3Ed4tiCWkqx00ps6L9o5bCd1mUW9Tohacj10I5LvfhC+HRsIJ+V7ha/ZR0Z813Gh8KzwHGiId389lHPo0dq7HAVI8iYtaowMe6cbIwoywvAUC77/tbYjVeFJUos3A23dxLPXsqATZpq0qeEVwgzNSmWMorBo7DaEgFJyCd/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=zx2K+kjr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="zx2K+kjr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CA0D1F000E9;
	Thu,  9 Jul 2026 05:44:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1783575899;
	bh=S4mSWXkVYTNDZJGpzQmMtpOGkwbWC1hATW0bYNCzhNc=;
	h=Subject:To:From:Date;
	b=zx2K+kjrHA/3Vu3TyE1z/dOx9DxdSKQ86sVwxqs1chu+2l8q5BWcuIzujM/W+gNu1
	 Wldr9y2ZmXydm/00VLHNuxQsCeJ4pM42w2dSw6GRXiCHySB1HcJaLtie3YgTT2uXPn
	 FDxYmYaNfqMqWr7andwsV0ODeCorFGPvonXo+7ew=
Subject: patch "iio: pressure: mpl115: fix runtime PM leak on read error" added to char-misc-linus
To: birenpandya@gmail.com,Stable@vger.kernel.org,jic23@kernel.org
From: <gregkh@linuxfoundation.org>
Date: Thu, 09 Jul 2026 07:44:47 +0200
Message-ID: <2026070947-reward-sandpaper-9bac@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


This is a note to let you know that I've just added the patch titled

    iio: pressure: mpl115: fix runtime PM leak on read error

to my char-misc git tree which can be found at
    git://git.kernel.org/pub/scm/linux/kernel/git/gregkh/char-misc.git
in the char-misc-linus branch.

The patch will show up in the next release of the linux-next tree
(usually sometime within the next 24 hours during the week.)

The patch will hopefully also be merged in Linus's tree for the
next -rc kernel release.

If you have any questions about this process, please let me know.


From fbe67ff37a6fd855a6c097f84f3738bd13d0a898 Mon Sep 17 00:00:00 2001
From: Biren Pandya <birenpandya@gmail.com>
Date: Sun, 14 Jun 2026 12:45:48 +0530
Subject: iio: pressure: mpl115: fix runtime PM leak on read error

mpl115_read_raw() takes a runtime PM reference with pm_runtime_get_sync()
before reading the processed pressure or raw temperature, but on the read
error path it returns without calling pm_runtime_put_autosuspend(). Each
failed read therefore leaks a runtime PM reference and prevents the device
from autosuspending.

Drop the reference before checking the return value so both the success
and error paths are balanced.

Fixes: 0c3a333524a3 ("iio: pressure: mpl115: Implementing low power mode by shutdown gpio")
Signed-off-by: Biren Pandya <birenpandya@gmail.com>
Assisted-by: Claude:claude-opus-4-8 coccinelle
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/pressure/mpl115.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/iio/pressure/mpl115.c b/drivers/iio/pressure/mpl115.c
index 830a5065c008..16e112b796ba 100644
--- a/drivers/iio/pressure/mpl115.c
+++ b/drivers/iio/pressure/mpl115.c
@@ -106,18 +106,18 @@ static int mpl115_read_raw(struct iio_dev *indio_dev,
 	case IIO_CHAN_INFO_PROCESSED:
 		pm_runtime_get_sync(data->dev);
 		ret = mpl115_comp_pressure(data, val, val2);
+		pm_runtime_put_autosuspend(data->dev);
 		if (ret < 0)
 			return ret;
-		pm_runtime_put_autosuspend(data->dev);
 
 		return IIO_VAL_INT_PLUS_MICRO;
 	case IIO_CHAN_INFO_RAW:
 		pm_runtime_get_sync(data->dev);
 		/* temperature -5.35 C / LSB, 472 LSB is 25 C */
 		ret = mpl115_read_temp(data);
+		pm_runtime_put_autosuspend(data->dev);
 		if (ret < 0)
 			return ret;
-		pm_runtime_put_autosuspend(data->dev);
 		*val = ret >> 6;
 
 		return IIO_VAL_INT;
-- 
2.55.0


