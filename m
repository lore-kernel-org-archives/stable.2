Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795464047;
	b=RFl69ODLbRirEX2qIqURYVza+LltD9CI7BZsyxpQAY4qVSlF/T95AEBZXEkyiwz1AFXC
	 bpxhnA2O3QdvFmzZ46BdkZjWMd07Ieh6T6buaoKXeXQg3vrVFV85QHTm4ybgNwRAhr2Ng
	 Ptl0lvhx+t3z7D/KJkpLp4SC7YLdjtSuXJm1cNZngVRknCwJWhG1n4zv7uuZ3s94LRd5d
	 aQYuAe4ytBUNd+3UHX4rQ0Uz/4BA2yWF92UQP86HGKiP7VJiCdRw4KPQwcZ+nPvuo5l6c
	 3xTJS9MW6O4no162CjreKxoZVWUoRz2cqNxATpD1xV41qKZNeNZJPIyGvrna541Rk6Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795464047;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Type:
	 Content-Transfer-Encoding;
	bh=4eAcgUNnxWrp9hy8N4DuyA/w6sJxP6JRbsBLxfU6jTs=;
	b=L9aDUZb7SqMn74TaoYUvKqVPpLNuyz24D2rP9eFbNKAf0z8X2kiTHqbgFMyCr8MT/HiH
	 rLW9Lla1H1TAmgPVLgUPazngF0Sier4E2Z246j/p3Kr7zk6QaYYdWAbHw2YF0J7yrwNuA
	 1lXKYoP5cbEc7xRpNYG/+a/TIttEBUpmFhccztqvrZZgO05IWcxarwlg5jfkQO7p6m880
	 YwxpRqXMB7tl3130iDc2uUi004NsYUIAxtUWHKs1Gvqyl1NL82WsvIqhtrduL3471ZDbh
	 dG51Q4+K/MWQtMiaSoXf7TuT/+3XKl+BQHt7KST3vWgB1gdiJRYMBY3iJyFdethVx/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVTSML+c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77B21606A326;
	Mon, 23 Nov 2026 20:00:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gVTSML+c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 72DA71F000D8;
	Mon, 23 Nov 2026 20:00:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795464047;
	bh=4eAcgUNnxWrp9hy8N4DuyA/w6sJxP6JRbsBLxfU6jTs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gVTSML+cPW/P25YS69F7J0HcOpM5kwo3uCfWf2rnSAppsh8q8UQfyO9MmSOx7kpTj
	 d6N9VaPGiw0QyCJo9o/OcnCKLoEBAAUhTmp0mZ/f6J202u9xjyj3cWFQ0R8TQbDtfJ
	 /BybRBPNSJeg+ezcNLjT6d2OiaQeJFuARiXPg/SB9dtB9L4mkgIz5TmuoFnUxIjT3e
	 AgxHl4VRV+WYknmTHI8EUJXt/bheVdj2XDF0EfZRft3obwl2zDVjsnep2MhhYGZNjD
	 pWqMMFlmq+WuRKO3CryNksoxas0w/IgoA3fd+ktsnP3T7z3oH0CXKCw8Ley046CJ9Y
	 aY3wVjTW+f/4w==
From: Lee Jones <lee@kernel.org>
To: lee@kernel.org,
	Jacky Huang <ychuang3@nuvoton.com>,
	Shan-Chun Hung <schung@nuvoton.com>,
	Alexandre Belloni <alexandre.belloni@bootlin.com>,
	Ming-Jen Chen <mjchen@nuvoton.com>,
	linux-arm-kernel@lists.infradead.org,
	linux-rtc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH 03/10] rtc: ma35d1: allocate RTC device before requesting interrupt
Date: Mon, 23 Nov 2026 19:59:14 +0000
Message-ID: <20261123200012.502284-4-lee@kernel.org>
X-Mailer: git-send-email 2.56.1.831.g720f3f5937-goog
In-Reply-To: <20261123200012.502284-1-lee@kernel.org>
References: <20261123200012.502284-1-lee@kernel.org>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

ma35d1_rtc_probe() registers ma35d1_rtc_interrupt() via
devm_request_irq() before allocating rtc->rtcdev via
devm_rtc_allocate_device().  During driver unbind or if
devm_rtc_register_device() fails, devres unwinds in reverse order and
frees struct rtc_device in devm_rtc_release_device() before
devm_irq_release() unregisters the interrupt handler.  An RTC interrupt
arriving in that teardown window passes a dangling rtc->rtcdev pointer
to rtc_update_irq(), dereferencing freed memory and scheduling a freed
work_struct.

Allocate and initialise rtc->rtcdev before requesting the IRQ so that
devres frees the interrupt handler before releasing the RTC device.

Fixes: dc0684adf3b6 ("rtc: Add driver for Nuvoton ma35d1 rtc controller")
Closes: https://sashiko.dev/#/bug/linux-26674087-baed-4ef2-83a0-78888ea8d16a
Cc: stable@vger.kernel.org
Signed-off-by: Lee Jones <lee@kernel.org>
---
 drivers/rtc/rtc-ma35d1.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/rtc/rtc-ma35d1.c b/drivers/rtc/rtc-ma35d1.c
index eb0da8b091dc..beeef6db92d9 100644
--- a/drivers/rtc/rtc-ma35d1.c
+++ b/drivers/rtc/rtc-ma35d1.c
@@ -235,13 +235,6 @@ static int ma35d1_rtc_probe(struct platform_device *pdev)
 			return dev_err_probe(&pdev->dev, ret, "rtc init failed\n");
 	}
 
-	rtc->irq_num = platform_get_irq(pdev, 0);
-
-	ret = devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
-			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
-	if (ret)
-		return dev_err_probe(&pdev->dev, ret, "Failed to request rtc irq\n");
-
 	platform_set_drvdata(pdev, rtc);
 
 	device_init_wakeup(&pdev->dev, true);
@@ -254,6 +247,13 @@ static int ma35d1_rtc_probe(struct platform_device *pdev)
 	rtc->rtcdev->range_min = RTC_TIMESTAMP_BEGIN_2000;
 	rtc->rtcdev->range_max = RTC_TIMESTAMP_END_2099;
 
+	rtc->irq_num = platform_get_irq(pdev, 0);
+
+	ret = devm_request_irq(&pdev->dev, rtc->irq_num, ma35d1_rtc_interrupt,
+			       IRQF_NO_SUSPEND, "ma35d1rtc", rtc);
+	if (ret)
+		return dev_err_probe(&pdev->dev, ret, "Failed to request rtc irq\n");
+
 	ret = devm_rtc_register_device(rtc->rtcdev);
 	if (ret)
 		return dev_err_probe(&pdev->dev, ret, "Failed to register rtc device\n");
-- 
2.56.1.750.gf70dc682cf-goog

