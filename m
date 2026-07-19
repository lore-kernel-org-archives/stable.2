Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B2B9330B07
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 14:26:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784471182; cv=none; b=SGwP7IGC+y1dA0KEDeadK0/Wuh8pjqHBl+GfI9sZ5gha/ReK/JyK5+TxwE1LLPno5CO9MUWBl5sG69Ky4H8qNBmWB+7/PgvKR5GWyzMj29YGLPHlgzexV8aPlSrwNq+DIYEeX7spah5vuCCZLzcQgw02Yx3RFn1XM+DVGdePS6A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784471182; c=relaxed/simple;
	bh=8cIi+CHThbw47GFMvG4HK0rdvLyHFifYjQsQciQwd0c=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=NH++rw8+lg3PjOuhHXYdSNSRn0eEw5uzP6AF0rgTEsN/gge4S7nrmEzQqT1nfycYLDDExTZsX9fD962PDk7FMXZH2e7QtHN+sg8iUDxEbxm9pYqkOyCTuku2aI58mUSiDQ7GLZZ0qs8SARt2SXcB/d4OEyxqhyNghj4M5CTn+e0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QbVyKSqq; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QbVyKSqq"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 68D331F000E9;
	Sun, 19 Jul 2026 14:26:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784471180;
	bh=HCmDfcUKJ7MSZlTG84s3vB9F8EhiMn16iZxcFNOJy94=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=QbVyKSqqP3ZXIPMRIpOPx2GFM9I+BOLv6AahCKMVEI0J+A075V/35Jo6SmEpjEPu9
	 6rQBjbFlOerKxKapO1wtCmJdP5rUQhgADIXsrxLvTuSIbVN1V+SEOnBGCbsMqz5wiF
	 nv8CpdoEutRhKj9lawcNQwEzPL4bs2w6Wqq598TC9lKZuwX2FiSGAyr15hKaZaukRj
	 DQOr5XEUJKTdxswIgmQDltaYa2EaGnegEJHGGlc3MdTUMrXLy9yGscJWwNukp1m3p9
	 Ow2FkauWdij3hz8nRDpljkPl3IMY0uN/v/+jpMhNXGp9k/e9aNxvQDGtJEgrM7gAXB
	 yIbtC4mIJjeMA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/2] usb: gadget: function: Simplify diagnostic messaging in printer
Date: Sun, 19 Jul 2026 10:26:17 -0400
Message-ID: <20260719142618.4094375-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071412-palpable-underuse-1c58@gregkh>
References: <2026071412-palpable-underuse-1c58@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Andrzej Pietrasiewicz <andrzej.p@collabora.com>

[ Upstream commit 57b7b733b1a7aeab25bc2670afff608214284863 ]

Don't issue messages which can be easily achieved with ftrace.
In case of printer_open() the return code is propagated to other layers
so the user will know about -EBUSY anyway.

Signed-off-by: Andrzej Pietrasiewicz <andrzej.p@collabora.com>
Link: https://lore.kernel.org/r/20221123110746.59611-1-andrzej.p@collabora.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 30adce93d5c4 ("usb: gadget: f_printer: take kref only for successful open")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/gadget/function/f_printer.c | 9 +--------
 1 file changed, 1 insertion(+), 8 deletions(-)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 728cb9702d5a99..60e833bd75f8e6 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -365,7 +365,7 @@ printer_open(struct inode *inode, struct file *fd)
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	kref_get(&dev->kref);
-	DBG(dev, "printer_open returned %x\n", ret);
+
 	return ret;
 }
 
@@ -383,7 +383,6 @@ printer_close(struct inode *inode, struct file *fd)
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	kref_put(&dev->kref, printer_dev_free);
-	DBG(dev, "printer_close\n");
 
 	return 0;
 }
@@ -868,8 +867,6 @@ static void printer_reset_interface(struct printer_dev *dev)
 	if (dev->interface < 0)
 		return;
 
-	DBG(dev, "%s\n", __func__);
-
 	if (dev->in_ep->desc)
 		usb_ep_disable(dev->in_ep);
 
@@ -907,8 +904,6 @@ static void printer_soft_reset(struct printer_dev *dev)
 {
 	struct usb_request	*req;
 
-	INFO(dev, "Received Printer Reset Request\n");
-
 	if (usb_ep_disable(dev->in_ep))
 		DBG(dev, "Failed to disable USB in_ep\n");
 	if (usb_ep_disable(dev->out_ep))
@@ -1205,8 +1200,6 @@ static void printer_func_disable(struct usb_function *f)
 {
 	struct printer_dev *dev = func_to_printer(f);
 
-	DBG(dev, "%s\n", __func__);
-
 	printer_reset_interface(dev);
 }
 
-- 
2.53.0

