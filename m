Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BAC7F2737FC
	for <stable@vger.kernel.org>; Thu, 10 Sep 2026 02:16:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789006615; cv=none; b=ucMDzUHMT7t6T/583fsQHrFvgAQxfErpHthp4yR8IHEMMEJ+w3FZw93hwmiW7oBIPK8RkAItzQDsUt13z/y09t+GlqfB+qBOfDBmlo9izWSwrCqHIOGqoYADhg7X945xbbZi8H8MaNtEXHDs4EYi3OlVK4/yvocTdF7/rz9nfdo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789006615; c=relaxed/simple;
	bh=FvbIqnCzE29IjKKUKQwaOtv428ao2F9WLVUvKap8ZK4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jWZv0PQGq3AZE7LzhPVh64xGfbH6gA4eyyizXCG+fI1a21t9dlcFetEpRFIGKd+7+CzQCTO3O9lTPiEnikEC0ybhXVXuDtFLW647XQpaywjjI9cO80Kd72yGTTdhCVXO5r1h3O+X9yc/2AGXruVc5WnGxAOrgZ7QC6/SR4p4SI0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=I5XOp/BU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="I5XOp/BU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 122A71F00893;
	Thu, 10 Sep 2026 02:16:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789006614;
	bh=ayKsI81PaPlVv0e3IfG2wzzxaWNe6STpPqVw347Hwcg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=I5XOp/BULZuXYAAjuxn7cncKCXFXpj3Fmp09r9lPYz1Oxo50LryXQHS2zqtVI1VCu
	 iBwR1r7y2yOA5tlx36aAsH/tudnT4w5t0ydLGjVB1U+zHElvqngyZru/KTLWO5efn3
	 /0x0n1NngBiio+eqtQ9fbICOXtsXDbTSaiG9Pk9cHljERHqBZHtPkH82AFrndbrvP4
	 cDJQfCrIG6D7aXlBvaZRyrnHz2LknVPxbiL7FgyR2owmjU+JWi9nPmc/7k8Ct96ecA
	 mKOVTsCr4XJKyof/+N1heoxj2jXLl5Vp8ifLhEPC3FoZinuFoWHZv82u6a/2JT4opt
	 r2iEIFuJ42HZw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: =?UTF-8?q?Th=C3=A9o=20Lebrun?= <theo.lebrun@bootlin.com>,
	Peter Chen <peter.chen@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 2/3] usb: cdns3: rename hibernated argument of role->resume() to lost_power
Date: Wed,  9 Sep 2026 22:16:50 -0400
Message-ID: <20260910021651.4003185-2-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260910021651.4003185-1-sashal@kernel.org>
References: <2026090845-lyrically-primal-44f3@gregkh>
 <20260910021651.4003185-1-sashal@kernel.org>
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
index ff10668b0f135..6cc5c50ac0c04 100644
--- a/drivers/usb/cdns3/cdns3-gadget.c
+++ b/drivers/usb/cdns3/cdns3-gadget.c
@@ -3479,7 +3479,7 @@ __must_hold(&cdns->lock)
 	return 0;
 }
 
-static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
+static int cdns3_gadget_resume(struct cdns *cdns, bool lost_power)
 {
 	struct cdns3_device *priv_dev = cdns->gadget_dev;
 
@@ -3487,7 +3487,7 @@ static int cdns3_gadget_resume(struct cdns *cdns, bool hibernated)
 		return 0;
 
 	cdns3_gadget_config(priv_dev);
-	if (hibernated)
+	if (lost_power)
 		writel(USB_CONF_DEVEN, &priv_dev->regs->usb_conf);
 
 	return 0;
diff --git a/drivers/usb/cdns3/cdnsp-gadget.c b/drivers/usb/cdns3/cdnsp-gadget.c
index 9b0f2c7cc9780..4c8f098280f35 100644
--- a/drivers/usb/cdns3/cdnsp-gadget.c
+++ b/drivers/usb/cdns3/cdnsp-gadget.c
@@ -2028,7 +2028,7 @@ static int cdnsp_gadget_suspend(struct cdns *cdns, bool do_wakeup)
 	return 0;
 }
 
-static int cdnsp_gadget_resume(struct cdns *cdns, bool hibernated)
+static int cdnsp_gadget_resume(struct cdns *cdns, bool lost_power)
 {
 	struct cdnsp_device *pdev = cdns->gadget_dev;
 	enum usb_device_speed max_speed;
diff --git a/drivers/usb/cdns3/core.h b/drivers/usb/cdns3/core.h
index 847d738b909e0..aa9873609dca0 100644
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

