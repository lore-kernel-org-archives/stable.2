Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 97A43366541
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 01:59:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789005577; cv=none; b=EbZ6Oqaav8XTbVPySxtrgYNUR6dKyrz5CaVW/3IPA5yNLDEFUI+IA8WrhhJjgmcAmlJf/Lnc02xytsDR8RADmaTxoczoOr2fSXDEMIQSr8ekLQ94UJFuREUiOslWnw5pArKWwFhwp2lh3OS9hBUlWgQ4AfGm0bAUXLRIELxuWNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789005577; c=relaxed/simple;
	bh=DQ0cujOcyuJCQ9TCOa81SqWsb32n9mYg6sooxxbw/0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=BwdpgnFaneiX3jMEaicMvArlNAGxglw30c58s/iz/9cs7jFwS6abu6iirelweKR9VCiLImVAiUxuVRWYl18jRfT1aXJFxyzQQLpii+XTO2OtznM8/goi3q14O7t6WTh1Akmf+AKVy6UJQoeGrFfsq5I5j4psF8BHE3DTouAMrtQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R/Wbgwzu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R/Wbgwzu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A782F1F000FF;
	Thu, 10 Sep 2026 01:59:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789005575;
	bh=kRwVjT5QjmaQ0ncRzul7yE7FWfOPLhsh34TagL04lwo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=R/WbgwzurArAzuF31gR9tKaKCSFNOcPi6/AhknKZPdIdzekIK+9g2xi+g5NYkTjRg
	 0/wuulpRC7xnWKaXjL7lCjZ7G7uPSSfGY1mzLlxejkRbyFZpp5WParmqKyvt2fMmmi
	 KLh8iNc+1oQgz33I8SOIW4RSNbgWzaYN29HlGyMzCDYaLMHjX77aFIUffNNe95za6a
	 nnX5aMoz3J7r5i9o9ME2oRVqi1S/iJkaXfbcZ47g0KLDqrrsvPtWC2xL5tMtsqyeCk
	 YCF18Jq6vKfs5hLfcBbL880HoWGhr52brBpu89rzdjyN7ifuRhgStEAfWQN9YM1ddl
	 ahW8fzbbnbcLg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.12.y 2/3] usb: cdns3: rename hibernated argument of role->resume() to lost_power
Date: Wed,  9 Sep 2026 21:59:31 -0400
Message-ID: <20260910015932.3952831-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910015932.3952831-1-sashal@kernel.org>
References: <2026090843-suspense-pleading-37f3@gregkh>
 <20260910015932.3952831-1-sashal@kernel.org>
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
index ac0aeb135d6fe..bc1157a4df006 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3484,7 +3484,7 @@ __must_hold(&cdns->lock)
 	return 0;
 }
 
-static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
+static int cdns3_gadget_resume(struct cdns *cdns, bool lost_power)
 {
 	struct cdns3_device *priv_dev = cdns->gadget_dev;
 
@@ -3492,7 +3492,7 @@ static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
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

