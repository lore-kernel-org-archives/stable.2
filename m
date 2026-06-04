Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79F963E2AC8
	for <Stable@vger.kernel.org>; Thu,  4 Jun 2026 08:46:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562822; cv=none; b=Ih090NqhnFnknZn/r9dy3Si7T2E+dCHyQfSlQTOMx9QT9hWydo5j/7b0uBvFkLT49k4RK9LIjPpTj5u4aJjwE+eqdHoEU636n0vBkP3nL6wz97u5ra9jM+b8uqphI+1VsLskBuLRKu4byWidg6UVa6rAA1wJqna+qa9S8ANxaKM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562822; c=relaxed/simple;
	bh=FzY7p9cDQ7ix/aqMn7dPtTv3HJBKD508QxAGyjDj+Q0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=ZwP0u5/0Ycga0eez5w06ZcuuLOlVSzU/qgUxdS+3d4tluMQ5L9QuPiqd4Zcss89pe6sQINqaA70VA1EkztbbwXV7le+JJqomK4fXF7mqaTAEoPZHSkqouf0yWieVbwhBIu8lHqSCizCOtfCUX4JBDA/8GWwELk/hrO2iDQYoLdQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=v2AyDd6l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="v2AyDd6l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2EFD71F00898;
	Thu,  4 Jun 2026 08:46:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562817;
	bh=c2HJEJrRXsw1EM9RqX258IrLHLtkHyTMUlXkAveQvDo=;
	h=Subject:To:Cc:From:Date;
	b=v2AyDd6l5mlNFFNOg4zoPGtwpILSoJ3FCyzbsL88mh2RSTRZzVOhqUy/DDItjWcDz
	 PmQCu8yzmwLWifqZDuAWr9xx5Cfi11vKjDFeTpnmQVI1M2BG8RJiZEVUGRj9zsUo57
	 pcPiwX2lNL9hbgKYY688FYQ90q01T6bf1pc5VN6U=
Subject: FAILED: patch "[PATCH] iio: gyro: adis16260: fix division by zero in write_raw" failed to apply to 6.1-stable tree
To: antoniu.miclaus@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:45:52 +0200
Message-ID: <2026060452-spectrum-purchase-6074@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 761e8b489e6cf166c574034b70637f8a7eadd0ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060452-spectrum-purchase-6074@gregkh' --subject-prefix 'PATCH 6.1.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 761e8b489e6cf166c574034b70637f8a7eadd0ee Mon Sep 17 00:00:00 2001
From: Antoniu Miclaus <antoniu.miclaus@analog.com>
Date: Tue, 31 Mar 2026 13:13:00 +0300
Subject: [PATCH] iio: gyro: adis16260: fix division by zero in write_raw
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Add a validation check for the sampling frequency value before using it
as a divisor. A user writing zero to the sampling_frequency sysfs
attribute triggers a division by zero in the kernel.

Fixes: 089a41985c6c ("staging: iio: adis16260 digital gyro driver")
Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Reviewed-by: Nuno Sá <nuno.sa@analog.com>
Cc: <Stable@vger.kernel.org>
Signed-off-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

diff --git a/drivers/iio/gyro/adis16260.c b/drivers/iio/gyro/adis16260.c
index 586e6cfa14a9..91b9c5f18ec4 100644
--- a/drivers/iio/gyro/adis16260.c
+++ b/drivers/iio/gyro/adis16260.c
@@ -287,6 +287,9 @@ static int adis16260_write_raw(struct iio_dev *indio_dev,
 		addr = adis16260_addresses[chan->scan_index][1];
 		return adis_write_reg_16(adis, addr, val);
 	case IIO_CHAN_INFO_SAMP_FREQ:
+		if (val <= 0)
+			return -EINVAL;
+
 		if (spi_get_device_id(adis->spi)->driver_data)
 			t = 256 / val;
 		else

