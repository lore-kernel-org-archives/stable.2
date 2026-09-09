Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4E0A4E8DF9
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 10:32:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788949922; cv=none; b=mWeTpLGcaqPH5240+kawAw0UDSjYL3cTzQ+7WuiE/UPEwJBIQcRxerFQDgxWxeODLkoSSM5vRjBpeWSKVjLw4O+oUgqV+dAFo9Z1N3CUKUiMmWKYkVsaLMn2YJSahyH0umv6RhZsMI52ZrbRZt3qGEcqrB2CKroaXbcV4YYbSPg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788949922; c=relaxed/simple;
	bh=1Waiwpe/rYVjejQ48qn05RoVwjsQxj4H8ak68hrq+bI=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=SikyurrVXY0lq4O8VuzXz1bs4wUogN+KIgaae6+2a0gMN9455o2ZXRgwRtCT+h5Bbife0A+DSBVdAwuehens0fbVBzfM2H2i+UffNzEFkgQRrEmGQyEwNzkUnh3IIhoHpWjaY4i126D/BpfcxCUzTz30m62X5l5NfRZrqAbIXxU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=CJOgfegc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="CJOgfegc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5CAD1F00A3A;
	Wed,  9 Sep 2026 10:31:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1788949920;
	bh=VYLBa5L5oTKRNPKlfU5fkIm0yZLOlPFAKCMxRVEXsus=;
	h=Subject:To:Cc:From:Date;
	b=CJOgfegcTZgEX5rWhKhzr46PCavRN2Hf6zvTjd91i056z4dnKp4kgag3L2Z1Sjuwp
	 xxHOQiUYb3BIAvS0E9jvZLzvMntTJHBYCcT7duXusiUjZf6n3fLC5V6nGELrKYUMnc
	 Le8c7egxdP1u3dyyxEwmeh6U/+CPOwdk9wBO9EHY=
Subject: FAILED: patch "[PATCH] iio: light: apds9306: fix PM reference leak in" failed to apply to 6.18-stable tree
To: mokshpanicker.7@gmail.com,jonathan.cameron@oss.qualcomm.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 09 Sep 2026 12:26:02 +0200
Message-ID: <2026090902-spruce-sleeve-2bcf@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x d378fceaafd79e0dc59d3546bda251a3058062c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026090902-spruce-sleeve-2bcf@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From d378fceaafd79e0dc59d3546bda251a3058062c0 Mon Sep 17 00:00:00 2001
From: Moksh Panicker <mokshpanicker.7@gmail.com>
Date: Sun, 2 Aug 2026 19:07:01 +0000
Subject: [PATCH] iio: light: apds9306: fix PM reference leak in
 apds9306_read_data()

apds9306_read_data() calls pm_runtime_resume_and_get() but several
error paths return directly without calling pm_runtime_put_autosuspend(),
leaking the runtime PM reference and preventing the device from
autosuspending.

Use PM_RUNTIME_ACQUIRE_AUTOSUSPEND() and PM_RUNTIME_ACQUIRE_ERR() to
automatically handle runtime PM reference release on all return paths.

Fixes: 620d1e6c7a3f ("iio: light: Add support for APDS9306 Light Sensor")
Signed-off-by: Moksh Panicker <mokshpanicker.7@gmail.com>
Cc: stable@vger.kernel.org
Signed-off-by: Jonathan Cameron <jonathan.cameron@oss.qualcomm.com>

diff --git a/drivers/iio/light/apds9306.c b/drivers/iio/light/apds9306.c
index 5ca4c87524fe..d582bda4d847 100644
--- a/drivers/iio/light/apds9306.c
+++ b/drivers/iio/light/apds9306.c
@@ -469,9 +469,9 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 	int status = 0;
 	u8 buff[3];
 
-	ret = pm_runtime_resume_and_get(data->dev);
-	if (ret)
-		return ret;
+	PM_RUNTIME_ACQUIRE_AUTOSUSPEND(data->dev, pm);
+	if (PM_RUNTIME_ACQUIRE_ERR(&pm))
+		return PM_RUNTIME_ACQUIRE_ERR(&pm);
 
 	ret = regmap_field_read(rf->intg_time, &intg_time_idx);
 	if (ret)
@@ -535,8 +535,6 @@ static int apds9306_read_data(struct apds9306_data *data, int *val, int reg)
 
 	*val = get_unaligned_le24(&buff);
 
-	pm_runtime_put_autosuspend(data->dev);
-
 	return 0;
 }
 

