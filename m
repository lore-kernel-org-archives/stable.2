Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D5E030E858
	for <stable@vger.kernel.org>; Fri,  4 Sep 2026 13:50:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788529827; cv=none; b=KuDUCXsRab70nN4YVQZPMbk7Jbru/KB4P8jpIfsyVpG1xMI4Ey3P9eQrr52LL//fYyzseSB5nLok/CRQdwmjHxzVtGo0LA6VZ548/35xMGz/2SCIEuut0XMj85OYNN0R3A0B0bY5ofYXq4/tVuzY3zxhp+B+LYnbtCOgSm5WwOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788529827; c=relaxed/simple;
	bh=nP8cjA1efQ4TYHu5+FfueC6gxgfJe4MBgBSQ1+Vv9Ao=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gI6V6H+k6SQ9ql4U8O2Z9ahADUs50fQ85mzphHdBz/7NqX8P7gIwJbcUta28Kr46fqQZwOzuQCHqNPY7ZIcpjwgu+pW4OYiEgH3IEomk8FMiQROJdUOAtO8PkhZ5V+uuXKPuPK3fs9xCLgMgg2zubzyPQdyaxU5ROFez83Bwmgk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Wi2hlVpB; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Wi2hlVpB"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75A481F00A3D;
	Fri,  4 Sep 2026 13:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788529826;
	bh=cI/21DbeJwFCRBZmpRxn1lumPS7WZ0vKpBQesI6/qog=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Wi2hlVpBLthrBctdG7Q7l1O92ikQfk1HnQxxH5SG90wTGb2KvLrzTEn3NqdDSz7jq
	 T01L9r1hGplEgvgC+wQbAwmssC7PcUK9TJ9fjDPPPx5Y8G8MtcqkwxXjgiYeLr0Qv6
	 zq5azqbuiCLXAsDgYUWoTqJvDX5x+10n2/w8FoEWyjY4yKVKFyluEsd925pw5r8YbS
	 LZvDWaEux1ctz+PwQ+GCUMd/7ZeXF10cas9xnIVBUuS3lsQA8YMUERziGA7LYWCYoB
	 WG2T/rZGeK27qcfSN8bp3i0fo7s1a/9PxqLdr9pEfp6D2QwZc3E21g2aaF50ClwiNr
	 icg07GgL50d3w==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] usb: gadget: at91_udc: Convert to platform remove callback returning void
Date: Fri,  4 Sep 2026 09:50:22 -0400
Message-ID: <20260904135023.585066-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026090318-hummus-copier-f77f@gregkh>
References: <2026090318-hummus-copier-f77f@gregkh>
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
index a9a7b3fc60ec9..96d0aabe3c85e 100644
--- a/drivers/usb/gadget/udc/at91_udc.c
+++ b/drivers/usb/gadget/udc/at91_udc.c
@@ -1927,7 +1927,7 @@ static int at91udc_probe(struct platform_device *pdev)
 	return retval;
 }
 
-static int at91udc_remove(struct platform_device *pdev)
+static void at91udc_remove(struct platform_device *pdev)
 {
 	struct at91_udc *udc = platform_get_drvdata(pdev);
 	unsigned long	flags;
@@ -1935,8 +1935,11 @@ static int at91udc_remove(struct platform_device *pdev)
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
@@ -1946,8 +1949,6 @@ static int at91udc_remove(struct platform_device *pdev)
 	remove_debug_file(udc);
 	clk_unprepare(udc->fclk);
 	clk_unprepare(udc->iclk);
-
-	return 0;
 }
 
 #ifdef CONFIG_PM
@@ -2003,7 +2004,7 @@ static int at91udc_resume(struct platform_device *pdev)
 #endif
 
 static struct platform_driver at91_udc_driver = {
-	.remove		= at91udc_remove,
+	.remove_new	= at91udc_remove,
 	.shutdown	= at91udc_shutdown,
 	.suspend	= at91udc_suspend,
 	.resume		= at91udc_resume,
-- 
2.53.0

