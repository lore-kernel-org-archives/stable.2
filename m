Received: from mail-m155101.qiye.163.com (mail-m155101.qiye.163.com [101.71.155.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A80D306778;
	Fri, 12 Jun 2026 05:25:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=101.71.155.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781241929; cv=none; b=PSgP3chevtvBRJQwD2QJq7v1T9od772aDjhz/dkAQ/L31IMho2O40sTryZFQZ7y/9pDnk3NPq3ohz/X7y3iCHCju63U6tKBC39q2niBqNU44wnM7Z9IFL0rZkuBzGPxlP1jn5d1vG9+4QQ+bEQXYzHopDM9tgrbCnr3QKVf3kV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781241929; c=relaxed/simple;
	bh=6AXVtEgiCzO/2RP/Wt1qsytfBuE3IodFRGvzMuYE61M=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=rcivNHDX1hw0NpFR0aUKqrvQzQexAVDZR4bfaFvruSGtxHbEXcFnUji/L0LD4kNZAtG2hSASW70YxMOJG3sX8eMlBVHObWtosuv/8s2tZ6C0Ibljaf0Ch2nccbt8/xeEi5ju02uqBNfb52LuByj5cNQAVUQHpXZklcK513wfW3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn; spf=pass smtp.mailfrom=seu.edu.cn; dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b=n/xURZ1U; arc=none smtp.client-ip=101.71.155.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=seu.edu.cn
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=seu.edu.cn header.i=@seu.edu.cn header.b="n/xURZ1U"
Received: from PC-202605011814.localdomain (unknown [58.241.16.34])
	by smtp.qiye.163.com (Hmail) with ESMTP id 421b3136f;
	Fri, 12 Jun 2026 13:20:12 +0800 (GMT+08:00)
From: Runyu Xiao <runyu.xiao@seu.edu.cn>
To: Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Roger Quadros <rogerq@kernel.org>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	"jianhao . xu" <jianhao.xu@seu.edu.cn>,
	"runyu . xiao" <runyu.xiao@seu.edu.cn>
Subject: [PATCH] usb: dwc3: run gadget disconnect from sleepable suspend context
Date: Fri, 12 Jun 2026 13:20:05 +0800
Message-Id: <20260612052005.3849659-1-runyu.xiao@seu.edu.cn>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9eba46086503a1kunm1643b5d918651a
X-HM-MType: 10
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
	tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCH0IYVkpITEkaHxlJS0weSlYeHw
	5VEwETFhoSFyQUDg9ZV1kYEgtZQVlOQ1VJT0pVSk1VSE9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpPSE
	xVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
	b=n/xURZ1UYfeoJ8x2oZ0neNrO0lI4NaXqV2FFClx+XInEszJTdAs8KPBuvYz4d/dR7HqdijBBAMtCdbzpsi3y6TfN7a5bvIps8c0t7E2k4D7kRaNlKY6GDXlx2YYM5Bg6m+masNK7q7EE9iMkwlnSsfNV2wnp06oFc2/hN3cHSCQ=; s=default; c=relaxed/relaxed; d=seu.edu.cn; v=1;
	bh=Gbm/mGQFxmKA5WEZQ72EuY/oIBOh6E65pmH0EXPD82w=;
	h=date:mime-version:subject:message-id:from;

dwc3_gadget_suspend() takes dwc->lock with IRQs disabled and then calls
dwc3_disconnect_gadget().  For async callbacks that helper only uses
plain spin_unlock()/spin_lock(), so the gadget ->disconnect() callback
still runs with IRQs disabled and any sleepable callback trips Lockdep.

This issue was found by our static analysis tool and then manually
reviewed against the current tree.

The grounded PoC kept the dwc3_gadget_suspend() ->
dwc3_disconnect_gadget() -> gadget_driver->disconnect() chain, and
Lockdep reported:

  BUG: sleeping function called from invalid context
  gadget_disconnect+0x21/0x39 [vuln_msv]
  dwc3_gadget_suspend.constprop.0+0x2b/0x42 [vuln_msv]

Keep the disconnect callback selection in one common helper, but add a
sleepable suspend-side wrapper which snapshots the callback under
dwc->lock and then runs it after spin_unlock_irqrestore().  The regular
event path still uses the existing spin_unlock()/spin_lock() window.

Fixes: c8540870af4c ("usb: dwc3: gadget: Improve dwc3_gadget_suspend() and dwc3_gadget_resume()")
Cc: stable@vger.kernel.org
Signed-off-by: Runyu Xiao <runyu.xiao@seu.edu.cn>
---
Notes:
  - Validated with a grounded Lockdep PoC that preserves the
    dwc3_gadget_suspend() -> dwc3_disconnect_gadget() ->
    gadget_driver->disconnect() chain.
  - Not tested on dwc3 hardware.

 drivers/usb/dwc3/gadget.c | 43 ++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index db5e5b77b1ea..63faa2d3811b 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -3934,15 +3934,48 @@ static void dwc3_endpoint_interrupt(struct dwc3 *dwc,
 	}
 }
 
+static bool dwc3_prepare_disconnect_gadget(struct dwc3 *dwc,
+					   struct usb_gadget_driver **driver,
+					   struct usb_gadget **gadget)
+{
+	if (!dwc->async_callbacks || !dwc->gadget_driver ||
+	    !dwc->gadget_driver->disconnect)
+		return false;
+
+	*driver = dwc->gadget_driver;
+	*gadget = dwc->gadget;
+
+	return true;
+}
+
 static void dwc3_disconnect_gadget(struct dwc3 *dwc)
 {
-	if (dwc->async_callbacks && dwc->gadget_driver->disconnect) {
+	struct usb_gadget_driver *driver;
+	struct usb_gadget *gadget;
+
+	if (dwc3_prepare_disconnect_gadget(dwc, &driver, &gadget)) {
 		spin_unlock(&dwc->lock);
-		dwc->gadget_driver->disconnect(dwc->gadget);
+		driver->disconnect(gadget);
 		spin_lock(&dwc->lock);
 	}
 }
 
+static void dwc3_disconnect_gadget_sleepable(struct dwc3 *dwc)
+{
+	struct usb_gadget_driver *driver;
+	struct usb_gadget *gadget;
+	unsigned long flags;
+
+	spin_lock_irqsave(&dwc->lock, flags);
+	if (!dwc3_prepare_disconnect_gadget(dwc, &driver, &gadget)) {
+		spin_unlock_irqrestore(&dwc->lock, flags);
+		return;
+	}
+
+	spin_unlock_irqrestore(&dwc->lock, flags);
+	driver->disconnect(gadget);
+}
+
 static void dwc3_suspend_gadget(struct dwc3 *dwc)
 {
 	if (dwc->async_callbacks && dwc->gadget_driver->suspend) {
@@ -4836,7 +4869,6 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 
 int dwc3_gadget_suspend(struct dwc3 *dwc)
 {
-	unsigned long flags;
 	int ret;
 
 	ret = dwc3_gadget_soft_disconnect(dwc);
@@ -4850,10 +4882,7 @@ int dwc3_gadget_suspend(struct dwc3 *dwc)
 		return -EAGAIN;
 	}
 
-	spin_lock_irqsave(&dwc->lock, flags);
-	if (dwc->gadget_driver)
-		dwc3_disconnect_gadget(dwc);
-	spin_unlock_irqrestore(&dwc->lock, flags);
+	dwc3_disconnect_gadget_sleepable(dwc);
 
 	return 0;
 }
-- 
2.34.1
