Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A91930FF08
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 20:01:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788984072; cv=none; b=NF689RPn/dbw1yGmb5vP0pz/ihAE0o6cBUCtZFUwZ21Yclaah4SNAQHYK+cOvzGMTkzWvmMRx1HT3ePMbzwa6eEI/vIU0OnaWqbpY4qKmNVYooA+Z6DqbHThWTTy0QyBoae+CvlRsdoIvjps0WFnLpigxYYwvAMEqJDl4LpO05M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788984072; c=relaxed/simple;
	bh=SJE/USr1qjFzWDptLAIwWtkW6QYA58eYQOwi9YIFEvY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AEYDteoi3iSHVPs0rs/MV3jFeZ81g1KSCurANbKdbDtO/kXl9GjQwlUdElLIjsrdd3OUmtGzjK8MKN82lOb75fYvPuH+hgpVK+KB325HV9spmEJBxMKMdFmMRHFScYVaZCVqkLYwLYA72YwhC4rizYsy2BKeYgBwKEu3l0Rfhk8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J1+dE8Oh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J1+dE8Oh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B07981F00899;
	Wed,  9 Sep 2026 20:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788984068;
	bh=CFX5cH9gEJFHMscSwkNz1jb/kHlGmMK4Lon2hk5gwW4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=J1+dE8OhHBPvyV2GXNLVbRvZzxrjukejttJODjJhZVrWSSXCdkdSOYqZ7AN2Vds/l
	 C4P8uqvoVF0AL5uALmT56BzbMMvUyS/yQUWZ5yd4PHnH3bvyTdgkvAmJSanPsEwZ/q
	 0xnLjDVLsFmzppBySr6zxtTGw5ZKBauV87yygMgI5nML1KrI4nWkXA9evaEv4kWUrf
	 VGiS1Nd0AcVvjVsV6wAHY3WW9InuidevSjs1igtXXT4bwvtgbKDSCgxgK4a2X+oY27
	 bkShHS0et8bsXrjNmYrmgTLXnFxN2SpzNg2YxAIL/sDmogTqu2MWOZYbl0fUnTwWJd
	 lEWGO6uJ3kpxA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 2/3] platform: Provide a remove callback that returns no value
Date: Wed,  9 Sep 2026 16:01:04 -0400
Message-ID: <20260909200105.3592162-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909200105.3592162-1-sashal@kernel.org>
References: <2026090352-pavestone-customary-a077@gregkh>
 <20260909200105.3592162-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit 5c5a7680e67ba6fbbb5f4d79fa41485450c1985c ]

struct platform_driver::remove returning an integer made driver authors
expect that returning an error code was proper error handling. However
the driver core ignores the error and continues to remove the device
because there is nothing the core could do anyhow and reentering the
remove callback again is only calling for trouble.

So this is an source for errors typically yielding resource leaks in the
error path.

As there are too many platform drivers to neatly convert them all to
return void in a single go, do it in several steps after this patch:

 a) Convert all drivers to implement .remove_new() returning void instead
    of .remove() returning int;
 b) Change struct platform_driver::remove() to return void and so make
    it identical to .remove_new();
 c) Change all drivers back to .remove() now with the better prototype;
 d) drop struct platform_driver::remove_new().

While this touches all drivers eventually twice, steps a) and c) can be
done one driver after another and so reduces coordination efforts
immensely and simplifies review.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20221209150914.3557650-1-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

Backport notes for 5.10:
- Dispatch .remove_new() from the existing platform_drv_remove() wrapper.
  Keep its int return type, the legacy .remove() return handling, and
  unconditional PM-domain detach; this tree predates platform_remove().
- Include the SM501 callback conversion from c20fddf7acfb ("mfd: sm501:
  Convert to platform remove callback returning void"): change the existing
  callback to void, drop its return 0, and select .remove_new(). This gives
  83feedd9d83c ("mfd: sm501: Fix potential memory leaks during remove") the
  context it requires to apply cleanly, without adding any functions.

Stable-dep-of: 83feedd9d83c ("mfd: sm501: Fix potential memory leaks during remove")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/platform.c         |  4 +++-
 drivers/mfd/sm501.c             |  6 ++----
 include/linux/platform_device.h | 11 +++++++++++
 3 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index 647066229fec3..94a4c8184cc91 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -783,7 +783,9 @@ static int platform_drv_remove(struct device *_dev)
 	struct platform_device *dev = to_platform_device(_dev);
 	int ret = 0;
 
-	if (drv->remove)
+	if (drv->remove_new)
+		drv->remove_new(dev);
+	else if (drv->remove)
 		ret = drv->remove(dev);
 	dev_pm_domain_detach(_dev, true);
 
diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
index c4c31a890ab2a..5aae0c16bf47d 100644
--- a/drivers/mfd/sm501.c
+++ b/drivers/mfd/sm501.c
@@ -1669,7 +1669,7 @@ static void sm501_pci_remove(struct pci_dev *dev)
 	pci_disable_device(dev);
 }
 
-static int sm501_plat_remove(struct platform_device *dev)
+static void sm501_plat_remove(struct platform_device *dev)
 {
 	struct sm501_devdata *sm = platform_get_drvdata(dev);
 
@@ -1677,8 +1677,6 @@ static int sm501_plat_remove(struct platform_device *dev)
 	iounmap(sm->regs);
 
 	release_mem_region(sm->io_res->start, 0x100);
-
-	return 0;
 }
 
 static const struct pci_device_id sm501_pci_tbl[] = {
@@ -1709,7 +1707,7 @@ static struct platform_driver sm501_plat_driver = {
 		.of_match_table = of_sm501_match_tbl,
 	},
 	.probe		= sm501_plat_probe,
-	.remove		= sm501_plat_remove,
+	.remove_new	= sm501_plat_remove,
 	.suspend	= pm_sleep_ptr(sm501_plat_suspend),
 	.resume		= pm_sleep_ptr(sm501_plat_resume),
 };
diff --git a/include/linux/platform_device.h b/include/linux/platform_device.h
index e7a83b0218077..870a918aa251c 100644
--- a/include/linux/platform_device.h
+++ b/include/linux/platform_device.h
@@ -203,7 +203,18 @@ extern void platform_device_put(struct platform_device *pdev);
 
 struct platform_driver {
 	int (*probe)(struct platform_device *);
+
+	/*
+	 * Traditionally the remove callback returned an int which however is
+	 * ignored by the driver core. This led to wrong expectations by driver
+	 * authors who thought returning an error code was a valid error
+	 * handling strategy. To convert to a callback returning void, new
+	 * drivers should implement .remove_new() until the conversion it done
+	 * that eventually makes .remove() return void.
+	 */
 	int (*remove)(struct platform_device *);
+	void (*remove_new)(struct platform_device *);
+
 	void (*shutdown)(struct platform_device *);
 	int (*suspend)(struct platform_device *, pm_message_t state);
 	int (*resume)(struct platform_device *);
-- 
2.53.0

