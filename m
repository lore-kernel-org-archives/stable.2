Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E1E1D53ECE4
	for <stable@vger.kernel.org>; Wed,  9 Sep 2026 11:18:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788952700; cv=none; b=pIkCzi/bk9RQY1FQQ8yfXYd/WDkSFwc06hxpPyulkJx2QwnlgAEtcKndW87WR9xLAQz9c/iVzf/FJPQV0ysZJ5UV2U6s3Otw/yxcfyrRMibvcS7HCowbwaMu6HdDJl3v4is+g25V1GlWsNn9GvWptxyhyykHlWOLi4I28ggshHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788952700; c=relaxed/simple;
	bh=ABBsqxhf6izdlxfpr31lkH61x/VWsj5W2NEvVIVsRtI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ew+HDPQ67QOks4iL9iHRlAWJuipsH2FdyWOqoor2z6XKcy3OOvysSzUcT4k/dUZt6rEAHOD3CKIPD6udOlteTbE71K5vr5lkEAhApdikQp6nP0XFaJoYS/nJI4wBR+qYS0zXa0dvbz7F6TmqwSh/q7reHuiZ3riSbdhy4MdUdJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jdL2mCal; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jdL2mCal"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C95B1F00ADE;
	Wed,  9 Sep 2026 11:18:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788952691;
	bh=j1t0uSEttORR0zR69Gl+gSzFOKlaUgXAlWnVQAgFMSA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=jdL2mCalQbncG4mX8zkeNEU7sh8yvf2tFmTZBAjbZH6yJ6kb3xBZX5jQQ5zmSglsM
	 NO9Z+jHI4iIIMC+8sq7qUfcTNOeYNUpCVau57IiajaQjHlI8NuVIsT1oh6OVAx5skp
	 IoJq7hu49ICNVnZ4x6XN9ff7dm2i6fBCWtPfJVf0QVlIOicScnee44xOPCUVRdCPVU
	 ElEBE1xjDpL/BBKD4y64UdJFZ6+PMq2iuLVvr3Xzy+FjMNy7GbFHoeunksVRd69X7F
	 2LOFQ0vApZ7tvz074kRNk5P7qaFQJ0mlGvy5F9RL6Sht6r+OFyBPXJ2DpAUP55snvz
	 nkDFyRRba35XQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 5/7] platform: Provide a remove callback that returns no value
Date: Wed,  9 Sep 2026 07:18:03 -0400
Message-ID: <20260909111805.1804682-5-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260909111805.1804682-1-sashal@kernel.org>
References: <2026090322-humbling-ninth-d3ad@gregkh>
 <20260909111805.1804682-1-sashal@kernel.org>
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
Stable-dep-of: c57cb36f76eb ("power: supply: charger-manager: register regulators before exposing sysfs")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/base/platform.c         |  4 +++-
 include/linux/platform_device.h | 11 +++++++++++
 2 files changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/base/platform.c b/drivers/base/platform.c
index d0b15cbab0ff0..e07043d85c65c 100644
--- a/drivers/base/platform.c
+++ b/drivers/base/platform.c
@@ -1306,7 +1306,9 @@ static int platform_remove(struct device *_dev)
 	struct platform_driver *drv = to_platform_driver(_dev->driver);
 	struct platform_device *dev = to_platform_device(_dev);
 
-	if (drv->remove) {
+	if (drv->remove_new) {
+		drv->remove_new(dev);
+	} else if (drv->remove) {
 		int ret = drv->remove(dev);
 
 		if (ret)
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

