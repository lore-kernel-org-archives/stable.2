Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D85539A7FE
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 06:48:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790664498; cv=none; b=gUKNoOzCFK2Pg4KgHBX/1JLBuPbatGyOUpPXVWFjEfHbJJ9E11Xb+LoygNCZUHB3KEP/VmVXJ3Xuifj3bu5VQw+g9PZ1ojktGrRkcV7Fbn1QwC+m4X8DmhfWylmW6HoKAnA4d1UllGDXTrdUgQVo77l1yGBDvdFcqd9rQSLBvBQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790664498; c=relaxed/simple;
	bh=L9SleVf0Gzc9yJUVbg/YZUQR3sk0bI804Kgh5SH2G0I=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=PkaXguou5sltbh7SA7iEWHjSfrmIRx89CbhuTjkk31dyev0N+EffXHfwQ+g0p3qTyz4XLj6sR9quGj3McQxU+oWeptGTFEv/bPHPAARfs8V/RQTKhpPKXQ8uyBjH1E6FiiZ6kjxZ7/MHDATvMMH6reRpnn4NNLRHDkCFJMq/dAI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=xyL2T2gP; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="xyL2T2gP"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EBEC81F000FF;
	Tue, 29 Sep 2026 06:48:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1790664497;
	bh=aLpHt1cdSiwShZTbofMz50czhrgL/JK7g0jbYJh189A=;
	h=Subject:To:Cc:From:Date;
	b=xyL2T2gPOnFaEPUOB3mUxq5xoSsITgiYx5k02Sl7RAnyUK8BI5NwAfsovIZOrDZpD
	 FRQ0GRohE0p7bSGXZGwPyfuKAVgoGQqVtnkiNzAOHQ7heTmdT9kkFoYr3zdRq+QkbR
	 +XNCLXR0F+GpJllhc9tiG+J7swrEh5LvPP5Jadfs=
Subject: FAILED: patch "[PATCH] gpio: cdev: fix kernel stack leak to user-space in error path" failed to apply to 6.12-stable tree
To: bartosz.golaszewski@oss.qualcomm.com,sashiko-bot@kernel.org,warthog618@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Tue, 29 Sep 2026 08:48:14 +0200
Message-ID: <2026092914-tipping-waviness-6ae5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.12-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.12.y
git checkout FETCH_HEAD
git cherry-pick -x 1feb5d39b05afd902ed9fc902ec5b15be03a4bdb
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026092914-tipping-waviness-6ae5@gregkh' --subject-prefix 'PATCH 6.12.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1feb5d39b05afd902ed9fc902ec5b15be03a4bdb Mon Sep 17 00:00:00 2001
From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>
Date: Tue, 22 Sep 2026 10:52:28 +0200
Subject: [PATCH] gpio: cdev: fix kernel stack leak to user-space in error path

If we fail to acquire the GPIO chip guard in gpio_desc_to_lineinfo(), we
return immediately before zeroing the info struct we'll end up passing
to the user-space later in lineinfo_get_v1(). This may leak the kernel
stack contents. Make gpio_desc_to_lineinfo() return int so that the
-ENODEV returned on failure to acquire the guard can be propagated to
the callers.

While not strictly necessary: move the memset() before trying to acquire
the SRCU read lock too for good measure.

Fixes: d83cee3d2bb1 ("gpio: protect the pointer to gpio_chip in gpio_device with SRCU")
Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260912123529.7951-1-tzungbi%40kernel.org?part=3
Reviewed-by: Kent Gibson <warthog618@gmail.com>
Link: https://patch.msgid.link/20260922-gpio-cdev-stack-leak-fixes-v3-1-7a0c7a4299d5@oss.qualcomm.com
Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index d1105b7ae437..5d53bfcdf726 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2172,18 +2172,19 @@ static void gpio_v2_line_info_changed_to_v1(
 
 #endif /* CONFIG_GPIO_CDEV_V1 */
 
-static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
-				  struct gpio_v2_line_info *info, bool atomic)
+static int gpio_desc_to_lineinfo(struct gpio_desc *desc,
+				 struct gpio_v2_line_info *info, bool atomic)
 {
 	u32 debounce_period_us;
 	unsigned long dflags;
 	const char *label;
 
+	memset(info, 0, sizeof(*info));
+
 	CLASS(gpio_chip_guard, guard)(desc);
 	if (!guard.gc)
-		return;
+		return -ENODEV;
 
-	memset(info, 0, sizeof(*info));
 	info->offset = gpiod_hwgpio(desc);
 
 	if (desc->name)
@@ -2258,6 +2259,8 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 							debounce_period_us;
 		info->num_attrs++;
 	}
+
+	return 0;
 }
 
 struct gpio_chardev_data {
@@ -2309,6 +2312,7 @@ static int lineinfo_get_v1(struct gpio_chardev_data *cdev, void __user *ip,
 	struct gpio_desc *desc;
 	struct gpioline_info lineinfo;
 	struct gpio_v2_line_info lineinfo_v2;
+	int ret;
 
 	if (copy_from_user(&lineinfo, ip, sizeof(lineinfo)))
 		return -EFAULT;
@@ -2326,7 +2330,10 @@ static int lineinfo_get_v1(struct gpio_chardev_data *cdev, void __user *ip,
 			return -EBUSY;
 	}
 
-	gpio_desc_to_lineinfo(desc, &lineinfo_v2, false);
+	ret = gpio_desc_to_lineinfo(desc, &lineinfo_v2, false);
+	if (ret)
+		return ret;
+
 	gpio_v2_line_info_to_v1(&lineinfo_v2, &lineinfo);
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
@@ -2344,6 +2351,7 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 {
 	struct gpio_desc *desc;
 	struct gpio_v2_line_info lineinfo;
+	int ret;
 
 	if (copy_from_user(&lineinfo, ip, sizeof(lineinfo)))
 		return -EFAULT;
@@ -2363,7 +2371,10 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 		if (test_and_set_bit(lineinfo.offset, cdev->watched_lines))
 			return -EBUSY;
 	}
-	gpio_desc_to_lineinfo(desc, &lineinfo, false);
+
+	ret = gpio_desc_to_lineinfo(desc, &lineinfo, false);
+	if (ret)
+		return ret;
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
 		if (watch)
@@ -2489,6 +2500,7 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	struct lineinfo_changed_ctx *ctx;
 	struct gpio_desc *desc = data;
 	struct file *fp;
+	int ret;
 
 	if (!test_bit(gpiod_hwgpio(desc), cdev->watched_lines))
 		return NOTIFY_DONE;
@@ -2519,7 +2531,13 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 
 	ctx->chg.event_type = action;
 	ctx->chg.timestamp_ns = ktime_get_ns();
-	gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
+
+	ret = gpio_desc_to_lineinfo(desc, &ctx->chg.info, true);
+	if (ret) {
+		fput(fp);
+		return NOTIFY_DONE;
+	}
+
 	/* Keep the GPIO device alive until we emit the event. */
 	ctx->gdev = gpio_device_get(desc->gdev);
 	ctx->cdev = cdev;

