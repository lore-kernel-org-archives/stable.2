Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9A6D74A4419
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 14:00:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788530425; cv=none; b=ppe+HS4exNuMPCCQsxtrvwUtxSqqz1CjLjbid+fShrEYW8YvLos0gossWGFNWO1byDgRTeRWjv6Dz+DJ5TS3dp52llHCMv1++1KguulRDwngbJzyglUKp5e/jzbwTpl7wlh9a140KvNfJEM9xeZJHfxJ4fvr8vSZmktIAoKmp7Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788530425; c=relaxed/simple;
	bh=RQsIkUE8WWoagJ2UUQBU8i7UtcFCtK+IAFza3LXPpGE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gZ1138tx4zuWJOcJCVFdwQNRFuUQj1O1abOX3VRuUUuXnko2br42mHh173XCdtRPg/AqJ/zEn76YT9Y6Ka4Pca3jdsfqrCXUv/kr8erL2tnsp77aWv64/6XQY9fWYN/t+gASInIZvXzrU846DhY+gCX50ZNWzxdKxyxNr9U1xPw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EpG2WxeC; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EpG2WxeC"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E0D9D1F00A3D;
	Fri,  4 Sep 2026 14:00:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788530424;
	bh=3k2uPmPxuA9iv6XknSWKYG+ESHY75m5ch2z13nAtMT8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=EpG2WxeCMBMQlvn1fcpcMZyXFKCGIAxz4Qq+OpxVsReXIkFyRenD1gM3zfOrnbIUy
	 S6CgEdCgoB2kH1Jex+SmPeMrUr3TluEJlfiz23X+Oq4RilPMC0f21qUGvQQayA/XhP
	 eeOafrA8pBg4JoWkgD+Oryjzr2HVSWuMS5cCj4A2OPojnHZEwZFNuBOwpcdptrE5eQ
	 kChoD9XcO0KmEZrdnA9867OhIfDKxnl3cdlbWx0lfqX5UQQGbY0J0jzKhG8LWYV9s8
	 2waM+bY6kuYUzL7d1pCXnsW4A/ZR42kzt53nhjCwY5q4YqOoKBb9KtsNvKY43G8czx
	 buWLjFJ5mW9rQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] usb: gadget: at91_udc: Convert to platform remove callback returning void
Date: Fri,  4 Sep 2026 10:00:21 -0400
Message-ID: <20260904140022.656875-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090319-deranged-stage-7532@gregkh>
References: <2026090319-deranged-stage-7532@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>

[ Upstream commit cbd1b152519a581bfe14fb6b14ea6e57cca426c1 ]

The .remove() callback for a platform driver returns an int which makes
many driver authors wrongly assume it's possible to do error handling by
returning an error code. However the value returned is ignored (apart
from emitting a warning) and this typically results in resource leaks.

To improve here there is a quest to make the remove callback return
void. In the first step of this quest all drivers are converted to
.remove_new(), which already returns void. Eventually after all drivers
are converted, .remove_new() will be renamed to .remove().

In the error path emit an error message replacing the (less useful)
message by the core. Apart from the improved error message there is no
change in behaviour.

Signed-off-by: Uwe Kleine-König <u.kleine-koenig@pengutronix.de>
Link: https://lore.kernel.org/r/20231120215830.71071-2-u.kleine-koenig@pengutronix.de
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: c27d13ce4bab ("usb: gadget: at91_udc: drain polled-VBUS timer/work before udc is freed")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/udc/at91_udc.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/usb/gadget/udc/at91_udc.c b/drivers/usb/gadget/udc/at91_udc.c
index d9ad9adf7348f..c2637bb5a65ae 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -1942,7 +1942,7 @@ static int at91udc_probe(struct platform_device *pdev)
 	return retval;
 }
 
-static int at91udc_remove(struct platform_device *pdev)
+static void at91udc_remove(struct platform_device *pdev)
 {
 	struct at91_udc *udc = platform_get_drvdata(pdev);
 	unsigned long	flags;
@@ -1950,8 +1950,11 @@ static int at91udc_remove(struct platform_device *pdev)
 	DBG("remove\n");
 
 	usb_del_gadget_udc(&udc->gadget);
-	if (udc->driver)
-		return -EBUSY;
+	if (udc->driver) {
+		dev_err(&pdev->dev,
+			"Driver still in use but removing anyhow\n");
+		return;
+	}
 
 	spin_lock_irqsave(&udc->lock, flags);
 	pullup(udc, 0);
@@ -1961,8 +1964,6 @@ static int at91udc_remove(struct platform_device *pdev)
 	remove_debug_file(udc);
 	clk_unprepare(udc->fclk);
 	clk_unprepare(udc->iclk);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -2018,7 +2019,7 @@ static int at91udc_resume(struct platform_device *pdev)
 #endif
 
 static struct platform_driver at91_udc_driver = {
-	.remove		= at91udc_remove,
+	.remove_new	= at91udc_remove,
 	.shutdown	= at91udc_shutdown,
 	.suspend	= at91udc_suspend,
 	.resume		= at91udc_resume,
-- 
2.53.0

