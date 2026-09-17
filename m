Received: from out28-218.mail.aliyun.com (out28-218.mail.aliyun.com [115.124.28.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6BEBD371053;
	Thu, 17 Sep 2026 08:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789632997; cv=none; b=CEuDx8beCZOYQiajZMtzmYTaP6iJUI4qnvG6n8Fxtlh/jnNNUaP/lgt1ChRsmtbc7IpdHfHacpRJjRxyfZsdtIwKZaGTvKegI6VA2lbpIDD2gU9cOukmXU9AwMKFHnKT0WEfQ6nLmzed7kh74GVVPnvPxqACG9QxjCPKkC8D84s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789632997; c=relaxed/simple;
	bh=rz6i68MRyBamDWoTZk5GX2hQTxrCH64jqCgP0ouAB58=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=XWIaO7SlpCzPFjgJBimvwcwFT7G2ak79Jn8zRJIJM4zX53onuesqjJeE/f5wm58ZUD1iYeOQyFDH0HyJwZY4nt5prIL4xY03GbLT0kI26G5K7kaT7iUimoLq3CvrRTg1rsJIAtDZ4GdnnQ3pibtqcxxDDEjMAxTkRz4T/rUpn90=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=VkBThnXp; arc=none smtp.client-ip=115.124.28.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="VkBThnXp"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789632981; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=azEa0K7AVYEr3Rt/TfPiT4j+dXFigA+xG4RnXfPMFlQ=;
	b=VkBThnXpeM/KSdCIfJ7zjlN43i1/5OXXa9WeHMw3wQik+pHLDc5wA01xOp8Ura6WUxoftxH/7DLdFyVfiJIBHIPCgYBU5lPBG4OC59D6I4z6q3credxlpzmWo4Kz7Vs9AVKiEeT9gWg6M/dF2o2q8Jx8qqM9n8IstmY3HaQGSI4=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.1853095|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.0194711-0.00457834-0.975951;FP=10302236968724652752|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037022039;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=6;RT=6;SR=0;TI=SMTPD_---.jFljBb4_1789632980;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jFljBb4_1789632980 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 16:16:21 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: gregkh@linuxfoundation.org
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH] usb: gadget: f_printer: fix list corruption in printer_soft_reset()
Date: Thu, 17 Sep 2026 16:16:16 +0800
Message-ID: <20260917081616.174096-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

printer_soft_reset() has three loops that drain different lists back to
rx_reqs / tx_reqs.  The second loop's condition tests rx_reqs_active but
its body was copy-pasted from the first loop and still reads from
rx_buffers:

    while (!list_empty(&dev->rx_reqs_active)) {
        req = container_of(dev->rx_buffers.next, ...);  /* BUG */

The first loop already empties rx_buffers, so by the time the second
loop runs, dev->rx_buffers.next points back to the list head itself.
Consequently:

 - list_del_init() treats the list head as an entry and poisons it
 - list_add() splices the rx_buffers head into rx_reqs
 - rx_reqs_active is never drained, so the loop condition stays true
   indefinitely

This results in linked-list corruption and a hang that is trivially
triggered by a USB host sending a SOFT_RESET class request.

Fix by reading from rx_reqs_active.next, matching the loop condition.

Fixes: 856c5e59aa0d ("usb: gadget: f_printer: copy Data Interface instead of using a singleton")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/function/f_printer.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/usb/gadget/function/f_printer.c b/drivers/usb/gadget/function/f_printer.c
index 1857d7861..2305733fe 100644
--- a/drivers/usb/gadget/function/f_printer.c
+++ b/drivers/usb/gadget/function/f_printer.c
@@ -940,7 +940,7 @@ static void printer_soft_reset(struct printer_dev *dev)
 	}
 
 	while (likely(!(list_empty(&dev->rx_reqs_active)))) {
-		req = container_of(dev->rx_buffers.next, struct usb_request,
+		req = container_of(dev->rx_reqs_active.next, struct usb_request,
 				list);
 		list_del_init(&req->list);
 		list_add(&req->list, &dev->rx_reqs);
-- 
2.50.1

