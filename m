Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2162C1F427C
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 14:53:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784472826; cv=none; b=AY4e7IfKsrvQyQAtIwfhKBeiPUEhCGw50pVJmbeVjDxB+5yBwtt+zvPppv1CGKjF/Ecf6lDPPBgQ1JODtf7mUmsDq4VHuvlf/hfg6xWFpmWX6ssiB3Q0UgKwcr935jzTOkIR0axbQaQS7cV6zMHHkq3hEH1IUt3HjuzYZKYK3JI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784472826; c=relaxed/simple;
	bh=EBQU40Gislt3ggB7SgtC75YNqc5YgkHEpNp4DE94l0U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EcSlDZsw/IWSckX6trnmHbdkMieyJY4gE1BiJRdkzJtXan+9BUvZiBLv2sE6D10HHbEMvQsLAdydfJ2rAXcxkIUIGZdR4CD+sRaZZVvWHKSHIwSJNAB59iSmy1W0F+gGX3TN+rIMnJS59SWZOy5RUgvqBidONLXOYz9lFMISFq4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LoW2IrWD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LoW2IrWD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CE321F000E9;
	Sun, 19 Jul 2026 14:53:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784472824;
	bh=71Ag4jQ69XBJ6WNIjcjf5hmek8MokEjH1wfjGMhqg3E=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=LoW2IrWDio4VVYWZbbJXRScrQ8Lt9FZCFyS3WegUzSRzLLTiNfvtUpp+MBkEdpwdX
	 Oxak9eSta7kgas/qgK0w7T7hCzGp8qjtqZB8HM7mCO19EIYPAtXkxMIAis+hqPhaTb
	 EBe1Uf1v4+ughKbVun6XK9vLXa2jd2XILcdlKowDfP4hYPxdpJUIz4gEaB1zpOxhUO
	 z9GfU5eE1kGmkABhXMrGexyjPXjNU7/S2A+5f7RXS3Hd7fNx9OF1Wuo/bA3GjdXkor
	 h0kRWz0RJ3c/CXfEqqyufaXhDqSnmsGD8VKBn3fK+Jg+O75em3FD+LHlNyZ7apf/Lk
	 FHuT7vErTS97g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y 1/2] usb: gadget: function: Simplify diagnostic messaging in printer
Date: Sun, 19 Jul 2026 10:53:41 -0400
Message-ID: <20260719145342.5397-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071412-epilepsy-clerk-af1b@gregkh>
References: <2026071412-epilepsy-clerk-af1b@gregkh>
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
index a31f2fe5d98434..8a65094c421e3b 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -363,7 +363,7 @@ printer_open(struct inode *inode, struct file *fd)
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	kref_get(&dev->kref);
-	DBG(dev, "printer_open returned %x\n", ret);
+
 	return ret;
 }
 
@@ -381,7 +381,6 @@ printer_close(struct inode *inode, struct file *fd)
 	spin_unlock_irqrestore(&dev->lock, flags);
 
 	kref_put(&dev->kref, printer_dev_free);
-	DBG(dev, "printer_close\n");
 
 	return 0;
 }
@@ -867,8 +866,6 @@ static void printer_reset_interface(struct printer_dev *dev)
 	if (dev->interface < 0)
 		return;
 
-	DBG(dev, "%s\n", __func__);
-
 	if (dev->in_ep->desc)
 		usb_ep_disable(dev->in_ep);
 
@@ -906,8 +903,6 @@ static void printer_soft_reset(struct printer_dev *dev)
 {
 	struct usb_request	*req;
 
-	INFO(dev, "Received Printer Reset Request\n");
-
 	if (usb_ep_disable(dev->in_ep))
 		DBG(dev, "Failed to disable USB in_ep\n");
 	if (usb_ep_disable(dev->out_ep))
@@ -1204,8 +1199,6 @@ static void printer_func_disable(struct usb_function *f)
 {
 	struct printer_dev *dev = func_to_printer(f);
 
-	DBG(dev, "%s\n", __func__);
-
 	printer_reset_interface(dev);
 }
 
-- 
2.53.0

