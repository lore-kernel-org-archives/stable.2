Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D758B50E5B0
	for <stable@vger.kernel.org>; Tue, 29 Sep 2026 12:46:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790685985; cv=none; b=G2BuAQjUdFoGlxMYBIrpct0KrmdvrOgJL7tpSRsuKMKr7wiP1IBY2r+3jVx3b/2MGa+xzWY/LdIFvXe8BzQamItPGerNvZmgE16PRDzqdkK1+uCwDPrZQJXGNLVPjmp2r9A2Arfro3fh2AoJWWXD02ymbO0bTt6Bz89Z5Ie+uMo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790685985; c=relaxed/simple;
	bh=xdKBJu5/713wNJ47WSA2bcD81N4eme1Ju2N2CSTtV2s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=cegerI/GmeqDDUSzUzKT4KzVMoLR8PcLZnLP5ccAWDSyUct5dbRedaaPMNqN8RBwTipvpuzD+480VM+e2s1jYrbj5s7RWvI8i59Ga9g7pkKFGcvS1M0FoUNnU0Wbsf0oNAKpqfRsxOHCk4bxU6WukR/yVEP8IPvGk6omUtl4ElE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hR1nMoCU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hR1nMoCU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C2821F00898;
	Tue, 29 Sep 2026 12:46:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790685982;
	bh=c7MLqM31y0aubIX1dbdE9mZoOEG6uJhoPD/3nUlfEDo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=hR1nMoCUbgbxUwczI7Ty5GaPh/rZIA+IaL2Xns4jvWFjCYT4gToluTLJWXNCwtuGO
	 kuenCPuklyYF8QKG6/rmVsUOj8H9KNqII8cal6GnOzjSml4wDfthOdAso48xKArZuX
	 UEhnr8OzZN4wQlw4JXkmbcqHZ+oC9V3U+f2M0jiDa1NcNqOgKCoYIg6w1Dy/S9YT3Z
	 YbR9mLXJYtvJDpPAoo1wKLsUamVn4CzNexOfLWkq9i9de14+bXvl3KaaYKH/awxSVC
	 /OhiZ6UzWT0fYkCTzI1Byy684FNRIZ4Yrl/ldt4iTUwsWsgfktFHq/QWnNMsNiWqzw
	 x5x2/Ch1AgfUg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>,
	Sashiko <sashiko-bot@kernel.org>,
	Kent Gibson <warthog618@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y] gpio: cdev: fix kernel stack leak to user-space in error path
Date: Tue, 29 Sep 2026 08:46:20 -0400
Message-ID: <20260929124620.3453273-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026092914-tipping-waviness-6ae5@gregkh>
References: <2026092914-tipping-waviness-6ae5@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Bartosz Golaszewski <bartosz.golaszewski@oss.qualcomm.com>

[ Upstream commit 1feb5d39b05afd902ed9fc902ec5b15be03a4bdb ]

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
[ retained the two-argument gpio_desc_to_lineinfo() signature for Linux 6.12’s synchronous notifier. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/gpio/gpiolib-cdev.c | 30 +++++++++++++++++++++++-------
 1 file changed, 23 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpiolib-cdev.c b/drivers/gpio/gpiolib-cdev.c
index e77ec4b205f42..b85ba9989b143 100644
--- a/drivers/gpio/gpiolib-cdev.c
+++ b/drivers/gpio/gpiolib-cdev.c
@@ -2365,17 +2365,18 @@ static void gpio_v2_line_info_changed_to_v1(
 
 #endif /* CONFIG_GPIO_CDEV_V1 */
 
-static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
-				  struct gpio_v2_line_info *info)
+static int gpio_desc_to_lineinfo(struct gpio_desc *desc,
+				 struct gpio_v2_line_info *info)
 {
 	unsigned long dflags;
 	const char *label;
 
+	memset(info, 0, sizeof(*info));
+
 	CLASS(gpio_chip_guard, guard)(desc);
 	if (!guard.gc)
-		return;
+		return -ENODEV;
 
-	memset(info, 0, sizeof(*info));
 	info->offset = gpio_chip_hwgpio(desc);
 
 	if (desc->name)
@@ -2440,6 +2441,8 @@ static void gpio_desc_to_lineinfo(struct gpio_desc *desc,
 		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_REALTIME;
 	else if (test_bit(FLAG_EVENT_CLOCK_HTE, &dflags))
 		info->flags |= GPIO_V2_LINE_FLAG_EVENT_CLOCK_HTE;
+
+	return 0;
 }
 
 struct gpio_chardev_data {
@@ -2490,6 +2493,7 @@ static int lineinfo_get_v1(struct gpio_chardev_data *cdev, void __user *ip,
 	struct gpio_desc *desc;
 	struct gpioline_info lineinfo;
 	struct gpio_v2_line_info lineinfo_v2;
+	int ret;
 
 	if (copy_from_user(&lineinfo, ip, sizeof(lineinfo)))
 		return -EFAULT;
@@ -2507,7 +2511,10 @@ static int lineinfo_get_v1(struct gpio_chardev_data *cdev, void __user *ip,
 			return -EBUSY;
 	}
 
-	gpio_desc_to_lineinfo(desc, &lineinfo_v2);
+	ret = gpio_desc_to_lineinfo(desc, &lineinfo_v2);
+	if (ret)
+		return ret;
+
 	gpio_v2_line_info_to_v1(&lineinfo_v2, &lineinfo);
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
@@ -2525,6 +2532,7 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 {
 	struct gpio_desc *desc;
 	struct gpio_v2_line_info lineinfo;
+	int ret;
 
 	if (copy_from_user(&lineinfo, ip, sizeof(lineinfo)))
 		return -EFAULT;
@@ -2544,7 +2552,11 @@ static int lineinfo_get(struct gpio_chardev_data *cdev, void __user *ip,
 		if (test_and_set_bit(lineinfo.offset, cdev->watched_lines))
 			return -EBUSY;
 	}
-	gpio_desc_to_lineinfo(desc, &lineinfo);
+
+	ret = gpio_desc_to_lineinfo(desc, &lineinfo);
+	if (ret)
+		return ret;
+
 	supinfo_to_lineinfo(desc, &lineinfo);
 
 	if (copy_to_user(ip, &lineinfo, sizeof(lineinfo))) {
@@ -2637,7 +2649,11 @@ static int lineinfo_changed_notify(struct notifier_block *nb,
 	memset(&chg, 0, sizeof(chg));
 	chg.event_type = action;
 	chg.timestamp_ns = ktime_get_ns();
-	gpio_desc_to_lineinfo(desc, &chg.info);
+
+	ret = gpio_desc_to_lineinfo(desc, &chg.info);
+	if (ret)
+		return NOTIFY_DONE;
+
 	supinfo_to_lineinfo(desc, &chg.info);
 
 	ret = kfifo_in_spinlocked(&cdev->events, &chg, 1, &cdev->wait.lock);
-- 
2.53.0

