Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 98C2520E334
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 14:16:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784470596; cv=none; b=KEqUknURUZYrAncYH2JtwNXtWO8CnV+llSjUNMiduB9azcjOTlFbh0lN8uez3DyyuZEwCfySZimC9DzECN8XY1Ciby0gPf/5FgIWg4dRKK+tFa8h0ztaw2LeiYYaPRurlkT9IsvYN/g1eccYVBsOBEXfPFfBIZJ639GkW/O45gc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784470596; c=relaxed/simple;
	bh=oWRRtARDVIvjD/w+B+7t6FtyfhtveKbxQsMTRbT4xUQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lGjt/bG68QK8Hk+99ZrYYGdTVej/uJRzkMwcEqDhvk9KtNxdlAtG5lZcGukIQH40fRlAaFzcKjnKGg4er0/ZONtKnPpM0ZDCxAuUHhhdBrEVFmRHX+/eomOzY5PF9lALYaf1PlcJhdx1ceOT3JEzmr1Dvgd10SdFMPzqhzAYnak=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bmJA3ggA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bmJA3ggA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B5A1F000E9;
	Sun, 19 Jul 2026 14:16:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784470595;
	bh=VKvHpZ0+qFI9G6d8GMA6MviB0UnZPUFC9shgUbHOy9w=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bmJA3ggA0tiT5DXOWXuRdSljWI3Ug4Y6rRfegcpUX120Jgnde/LqvxHZ2IZkUTPJk
	 ZBwzj3dVEpazU9xg/31Gp4cdyApBT6Kv+XK6Dw3HUzMA4y1u3oBIteXavROks7rLzT
	 ESegOY6bGBY6BlbhN0fij6/qkm8l1sOh4ALzimEyO7gZMi1WAtC3SNX+N8Gqa5nVli
	 jnpSuh56EkjEw1HF9vSffObZWbo+/AwQ2uh8N/6I+KRxeMG6jhwP6/K5jDsvuu0cQI
	 thYSOwUkP3uJbpkovCZ9buAT2zldC/iy8hTXd2CIShO8wuGPoDJgCGa/CIOU5pnjEI
	 6wMI3SexDlpyQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Andrzej Pietrasiewicz <andrzej.p@collabora.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.1.y 1/2] usb: gadget: function: Simplify diagnostic messaging in printer
Date: Sun, 19 Jul 2026 10:16:31 -0400
Message-ID: <20260719141632.4057531-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026071412-chop-overreach-6861@gregkh>
References: <2026071412-chop-overreach-6861@gregkh>
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
index 65378266fd84e8..6f995b87aa5743 100644
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

