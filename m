Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 353664A1DFC
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:43:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529419; cv=none; b=E2AoX/A8DhDjUngRGsNj1Px50g8QMyRUJ3RGoUmXwBqR5AooOV+HAMbQ+g+TWLYpI42K6KMgmztPbVBEWSsC0CKnLUJZaIY3V3F7LS8T6G2ahyVRWTv4ybqO50T+wGeL9yQg/vBujtzZn/PbVE5XN4542TGFkwfTlLKs9YSIhtk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529419; c=relaxed/simple;
	bh=k7tVBJ5guHCEK5Yxswk4F4FMSaw1sUtahEvFUQwkgTY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bgJZwrgALqaJauDt3MOfyzo5pqqfp4/bioBTHEBSo2ZW1Ua3EvQUlxdCzFAphTSV/qJ+gahejJkPJXDjULyENW+1wQYcAoLpej4qszIDnzjIE+GdjE0oVPviw77LxabIm20tvoBTz+S1ZlT4Bh4cT8u4O/ugOwoi1K1tJhokmDo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QJDpJ5+G; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QJDpJ5+G"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 35B791F00A3D;
	Fri,  4 Sep 2026 13:43:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788529417;
	bh=LbWVPax8aUmWkMItLymL8erNIoZLEjVh5UpSsJ3hmOQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QJDpJ5+GIbYUE2Kn5SV6FJnIoImgp6kjCOR0dek51UwxNajwL5K0v8R4TQmfsEW4r
	 02oNx5Bh6gdh1Fazop2iwr65bXPKevRfHjJfapbO/lXNHhzAf+n7DXtchSPoYJDylm
	 fp32Jr6fYfBNm7M9x/UubTdy2uwLX5JrahcM4nMw32F38OXg6pOVq55Pil2UMm09oK
	 AwbuGb5bTFcQxeKgxjx1xqPpNKvMMJFGQcnQemXFqsep6hVXetI4zLsMB9XZ6qyvKr
	 Ykus+B8CvQ+k6pXJUfhQizZStXV5thgQef6Hxq5agdLgpybYnHRrap/4A0T5JWlpST
	 5klgjx890dYRg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 1/2] usb: gadget: at91_udc: Convert to platform remove callback returning void
Date: Fri,  4 Sep 2026 09:43:34 -0400
Message-ID: <20260904134335.566921-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090318-vixen-overarch-9359@gregkh>
References: <2026090318-vixen-overarch-9359@gregkh>
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
index 922b4187004b0..bb37a19667772 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -1924,7 +1924,7 @@ static int at91udc_probe(struct platform_device *pdev)
 	return retval;
 }
 
-static int at91udc_remove(struct platform_device *pdev)
+static void at91udc_remove(struct platform_device *pdev)
 {
 	struct at91_udc *udc = platform_get_drvdata(pdev);
 	unsigned long	flags;
@@ -1932,8 +1932,11 @@ static int at91udc_remove(struct platform_device *pdev)
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
@@ -1943,8 +1946,6 @@ static int at91udc_remove(struct platform_device *pdev)
 	remove_debug_file(udc);
 	clk_unprepare(udc->fclk);
 	clk_unprepare(udc->iclk);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -2000,7 +2001,7 @@ static int at91udc_resume(struct platform_device *pdev)
 #endif
 
 static struct platform_driver at91_udc_driver = {
-	.remove		= at91udc_remove,
+	.remove_new	= at91udc_remove,
 	.shutdown	= at91udc_shutdown,
 	.suspend	= at91udc_suspend,
 	.resume		= at91udc_resume,
-- 
2.53.0

