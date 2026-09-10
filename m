Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 04959379966
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:11:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006277; cv=none; b=m4rpUEP8/56UewxiSdecBXXoe5yFKUAWYwRtebu+pCDMZCVsweLNjBqskdijP8y2WDOH6NYCkjmXiouYXH/+fyU2/qHMVkLfRmni0UvQbkwm1KEqYNyz8KASHe8ieErae7eeEhKH0vOTiVEjUd3gFvfThstmHA3lpLVk6tKahiU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006277; c=relaxed/simple;
	bh=SryFeRF+glk7TmSUDbpr1MbwlKA8jsSboUHYwpC+ZxE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=UKOJE+5kAEIstZBrMMcL2xyyr/AlGgch5EhWE5ByUgEvHXRpRcA6JmUzzjwAIzfoIHN8ctl34iF6CET4wYG6g+bkGMj6LenrZF2HOybDCQpNLHZ733/takTI88CzWagzmU622bCmsxgXvsOFoA1tMnGOblku7O5V5ZigFDr4gzE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I1CsThNj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I1CsThNj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5797A1F00893;
	Thu, 10 Sep 2026 02:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006275;
	bh=zMXiBIf96p6dW3LDSw/Fz2/m8vxCJFW+LaModK0GgLs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I1CsThNj3/JgJ7jAcoTgaPLhz8HKYOjrV/5YZiD+tiJ2TMpEF0BkV+I3l3culSoV3
	 ZUIVXSDEH8PrbMzFwXGSkP8tDgJnDMbJviDsqA/dyqBGpVQ6YWwEocTUOQRwE6PZoe
	 7xNezcqlrrcYM9pVduvQGjSaLaBXP/1rRyIWFZkwqtG65F7EeT91AeI/C7lBPtfLQZ
	 a7P2mSRX/Evx3cji7Uaxm65KRG2oWXcV/LPeudQ0jSxr9Xq9pzjetcOUQTcK4ZdvRZ
	 rBEsesHNxzT6HzNxC4sgVwTl/RpWUhGJLGK62Wmr7EN5pZhD5Vm8NFolxtgVVcVlCR
	 Q1kvUadAg/GQw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y 2/3] usb: cdns3: rename hibernated argument of role->resume() to lost_power
Date: Wed,  9 Sep 2026 22:11:12 -0400
Message-ID: <20260910021113.3989344-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910021113.3989344-1-sashal@kernel.org>
References: <2026090844-colossal-stem-a83f@gregkh>
 <20260910021113.3989344-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Théo Lebrun <theo.lebrun@bootlin.com>

[ Upstream commit 0bde749c58c72405c54a1eabf6266a0273377226 ]

The cdns_role_driver->resume() callback takes a second boolean argument
named `hibernated` in its implementations. This is mistaken; the only
potential caller is:

int cdns_resume(struct cdns *cdns)
{
	/* ... */

	if (cdns->roles[cdns->role]->resume)
		cdns->roles[cdns->role]->resume(cdns, cdns_power_is_lost(cdns));

	return 0;
}

The argument can be true in cases outside of return from hibernation.
Reflect the true meaning by renaming both arguments to `lost_power`.

Signed-off-by: Théo Lebrun <theo.lebrun@bootlin.com>
Acked-by: Peter Chen <peter.chen@kernel.org>
Link: https://lore.kernel.org/r/20250205-s2r-cdns-v7-3-13658a271c3c@bootlin.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: eae6460f6173 ("usb: cdnsp: fix wakeup from S3 after controller context loss")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/cdns3/cdns3-gadget.c | 4 ++--
 drivers/usb/cdns3/cdnsp-gadget.c | 2 +-
 drivers/usb/cdns3/core.h         | 2 +-
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/cdns3/cdns3-gadget.c b/drivers/usb/cdns3/cdns3-gadget.c
index b52570c6deff7..9221de5111e4a 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3483,7 +3483,7 @@ __must_hold(&cdns->lock)
 	return 0;
 }
 
-static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
+static int cdns3_gadget_resume(struct cdns *cdns, bool lost_power)
 {
 	struct cdns3_device *priv_dev = cdns->gadget_dev;
 
@@ -3491,7 +3491,7 @@ static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
 		return 0;
 
 	cdns3_gadget_config(priv_dev);
-	if (hibernated)
+	if (lost_power)
 		writel(USB_CONF_DEVEN, &priv_dev->regs->usb_conf);
 
 	return 0;
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 89d3d8167e599..64440fdf97c88 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -2025,7 +2025,7 @@ static int cdnsp_gadget_suspend(struct cdns *cdns, bool do_wakeup)
 	return 0;
 }
 
-static int cdnsp_gadget_resume(struct cdns *cdns, bool hibernated)
+static int cdnsp_gadget_resume(struct cdns *cdns, bool lost_power)
 {
 	struct cdnsp_device *pdev = cdns->gadget_dev;
 	enum usb_device_speed max_speed;
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index ac30ee21309d0..801be9e61340e 100644
--- a/drivers/usb/cdns3/core.h
+++ b/drivers/usb/cdns3/core.h
@@ -30,7 +30,7 @@ struct cdns_role_driver {
 	int (*start)(struct cdns *cdns);
 	void (*stop)(struct cdns *cdns);
 	int (*suspend)(struct cdns *cdns, bool do_wakeup);
-	int (*resume)(struct cdns *cdns, bool hibernated);
+	int (*resume)(struct cdns *cdns, bool lost_power);
 	const char *name;
 #define CDNS_ROLE_STATE_INACTIVE	0
 #define CDNS_ROLE_STATE_ACTIVE		1
-- 
2.53.0

