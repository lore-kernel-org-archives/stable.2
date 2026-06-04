Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB8A03CC7D1
	for <Stable@vger.kernel.org>; Thu,  4 Jun 2026 08:47:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780562824; cv=none; b=huT41fhhDA9zEBUcdBeC1b0f27gn+R41auTvExFQrxj8IIcKERhCioeltjA9HXLpDmLmIpnPgVTBRkiIChELIhvAq9BQrK812xvBYtwsHGLg9zvZZOZGgx5piwMywE+SQVMx0Cc9KQb2wnzlgLabGvdymxWnZJzI1WL2bA0dGdE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780562824; c=relaxed/simple;
	bh=9rGvw/BGLvP3bW2wwAZAH+P00HitYb2Y+izZzM3tciQ=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=LcgMk/u0MA5Hh1FCBd0/n2QKN1EJyN41L6zDBWu8ZLcNPNSbR2mDAx+wiUNMASl5dca5eA1gCCfSRB4/25U7Hj4cDIY5DxiIbyTfXOLUUpX/rhV4dDut/bcgHV8ZBHdaLU7e7EOhqBbWzZhzLj/9RvObEQA+i/vGMmu3ROvP+5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=TS8jPTfZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="TS8jPTfZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D618D1F00893;
	Thu,  4 Jun 2026 08:47:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780562821;
	bh=MoYp41JkymWC1WdeoqRH1kux85OUDukdbR7f7FS/W2I=;
	h=Subject:To:Cc:From:Date;
	b=TS8jPTfZyAz49J/oIksgT/n6WoCfsJaCh+c2LBCR/Fo5uIshaVukrZ4ZuPIDHP9nV
	 Q1x+Qm1A+5VCboNnxWlq9BnKZwRMyWwWucMgiIMLXIOhJYrE5uECEmpt22YD3AEgQT
	 +T4uPMjGPVBnD9XmyHTyzqavHfJt62wGNvdJuIw0=
Subject: FAILED: patch "[PATCH] iio: gyro: adis16260: fix division by zero in write_raw" failed to apply to 5.15-stable tree
To: antoniu.miclaus@analog.com,Jonathan.Cameron@huawei.com,Stable@vger.kernel.org,nuno.sa@analog.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 10:45:53 +0200
Message-ID: <2026060453-definite-discolor-7a9f@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 761e8b489e6cf166c574034b70637f8a7eadd0ee
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060453-definite-discolor-7a9f@gregkh' --subject-prefix 'PATCH 5.15.y' HEAD^..

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

