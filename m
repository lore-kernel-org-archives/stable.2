Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFC94F55BE
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:31:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949892; cv=none; b=IN4pn6RLXCoXXHxKIxTROEsj3HkoELDSXZTi6Gid6SToj3p5g7g6GzPOcdkZ0WdJrynjfkt8KgMv6dJKThze2AZyvdTqfbg43tp2zHOKa+kmhHVOMyPqJR/x5V8XirbH92KbmRN5xfUi8aPE23Vw8AFPUoBcyzBex+Zrk+bnXvI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949892; c=relaxed/simple;
	bh=zw9sgXn6iVK1niEphB7NSrLZuc3GcgiM8ebRLaIiWx8=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=Y4OmKIcVuBtwLj1iCj4JUDoYwQ3ogD48Xls3rO/bHGTb6a/zlesZH4/c9Qwh74YgRXfCc1Lc9hNUSi6v5dXL7oFL0uxQE68shXUq34YMXBXIU6AjlY+Et17BFuYd8oVKEod0iNEL2gJETwsjzD4rWHbpTKOZKOi6MDj5XDMAn+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=W1kX8KkA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="W1kX8KkA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9E741F00A3A;
	Wed,  9 Sep 2026 10:31:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788949886;
	bh=P+BdO+/WXG7x+BmS9C+3cnQazYT4bH4L6uFvdcMwLlI=;
	h=Subject:To:Cc:From:Date;
	b=W1kX8KkAvl/lZQ76UbJ+CkiaIul7ohOeduVKo8Wx77m65w6CyyBWgKcshI1FGEluW
	 /CszHqSWLKi2yZeZzfY9MgRH1lCitfO3pAQeVDuL1eVDGqhNv/oqseAL4OjXVVxXkT
	 QnWVjVDL2YXXn/aJNoPWmHSvxmR+G0YUGFyq9JTc=
Subject: FAILED: patch "[PATCH] iio: pressure: dps310: fix NULL pointer dereference on ACPI" failed to apply to 6.1-stable tree
To: zoone.rupert@gmail.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:23:22 +0200
Message-ID: <2026090922-unread-confused-555a@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 26e9213898fc949923188ef0aeea31fc87708836
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090922-unread-confused-555a@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 26e9213898fc949923188ef0aeea31fc87708836 Mon Sep 17 00:00:00 2001
From: Rupesh Majhi <zoone.rupert@gmail.com>
Date: Sun, 19 Jul 2026 03:07:52 +0300
Subject: [PATCH] iio: pressure: dps310: fix NULL pointer dereference on ACPI
 probe

When the device is enumerated through its ACPI HID (IFX3100),
i2c_client_get_device_id() returns NULL: the ACPI-derived client name
does not match the driver's i2c_device_id table. dps310_probe() then
dereferences that NULL pointer in "iio->name = id->name" and crashes the
kernel during probe.

The IIO device name is always "dps310", so set it directly and drop the
now-unused device-id lookup.

Fixes: 72ff282819d0 ("iio: pressure: dps310: Add ACPI HID table")
Cc: stable@vger.kernel.org
Signed-off-by: Rupesh Majhi <zoone.rupert@gmail.com>
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
index f45af72a0554..45bdb8c7670f 100644
--- a/drivers/iio/pressure/dps310.c
+++ b/drivers/iio/pressure/dps310.c
@@ -845,7 +845,6 @@ static const struct iio_info dps310_info = {
 
 static int dps310_probe(struct i2c_client *client)
 {
-	const struct i2c_device_id *id = i2c_client_get_device_id(client);
 	struct dps310_data *data;
 	struct iio_dev *iio;
 	int rc;
@@ -858,7 +857,7 @@ static int dps310_probe(struct i2c_client *client)
 	data->client = client;
 	mutex_init(&data->lock);
 
-	iio->name = id->name;
+	iio->name = DPS310_DEV_NAME;
 	iio->channels = dps310_channels;
 	iio->num_channels = ARRAY_SIZE(dps310_channels);
 	iio->info = &dps310_info;

