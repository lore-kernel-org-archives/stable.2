Received: from out28-170.mail.aliyun.com (out28-170.mail.aliyun.com [115.124.28.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E24C94BD361;
	Thu, 17 Sep 2026 10:32:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.28.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789641139; cv=none; b=qP3fYKPDZtOzn1H5dOlHapk763UuUzzar8HC1fZNs7Oz9RjZRYcLyAGydhOk6We9cUH4mFEHbPqwo4OKb20hHSbNviw8b8udN3MVm/+vJyKvltVd2+1q5YIUOd0WhiVou7eVI5XoqIwBMXQCkMstaR6byPSP0rx/5Yr5Gy/MyOc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789641139; c=relaxed/simple;
	bh=E5u6pFOAMO/003GOJUov5E9oMgUUOX9dsqS294n/pvM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=UfVs3EmSzdtObO6PGVF5fTMksHB82UnekzdvOGe2+s1vTwJzKOfszNoDc6cMXZE1qTk9BzcgHfO83CmdXCgdjpG5a/q5joOXyS0XC6k+G+rMGd175OX49/yYWcr+Csm/SuuArlM9Vcd3a7/lN78RCaF3vrdwH8jZTdno9npBJg0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com; spf=pass smtp.mailfrom=xiaopeng.com; dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b=FYcO+E3I; arc=none smtp.client-ip=115.124.28.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=xiaopeng.com header.i=@xiaopeng.com header.b="FYcO+E3I"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1789641128; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=92DqYzsY5tQw8zrK7ygfUYU1Rl0yvZP1MFAZ/+j1d2Y=;
	b=FYcO+E3I4dCg0XWVrTf5qHdgm1PgOnrnOcSj0YC2Lxm379gpfFHlzAtbCOc98A5kwnRAzuPcpu6+rAtofY03FMmZbliL1fhwM+ayPRF3YUb7AVdCIQSMzNzn3NE02qQxYz8H4n7jgrMKJ6q++DbsbEN43amxGJKvQ9vi9sfHXyY=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.0743678|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0333185-0.00133189-0.96535;FP=10121135997339731664|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037025160;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=13;RT=13;SR=0;TI=SMTPD_---.jFzyINx_1789641126;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jFzyINx_1789641126 cluster:ay29)
          by smtp.aliyun-inc.com;
          Thu, 17 Sep 2026 18:32:07 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: neal_liu@aspeedtech.com,
	gregkh@linuxfoundation.org
Cc: joel@jms.id.au,
	andrew@codeconstruct.com.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	liuwb@xiaopeng.com,
	Liu Chao <liuc63@xiaopeng.com>
Subject: [PATCH] usb: gadget: aspeed: clamp transfer length in RX completion handlers
Date: Thu, 17 Sep 2026 18:32:04 +0800
Message-ID: <20260917103205.3049861-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ast_udc_ep0_out(), ast_udc_epn_handle() and ast_udc_epn_handle_desc()
read the received byte count from hardware registers and add it to
req->req.actual without clamping against the remaining buffer space
(req->req.length - req->req.actual).

When actual reaches or exceeds length, the subsequent DMA has already
written past the end of the request buffer.  Across multiple short
packets the overrun grows with each completion.

A malicious or malfunctioning USB host can exploit this to trigger a
heap buffer overflow in any gadget function (e.g. f_mass_storage,
f_fs) layered on top of this UDC.

Clamp the received length to the remaining space before accumulating
it in all three RX completion paths.

Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
Cc: stable@vger.kernel.org
Reviewed-by: Weibin Liu <liuwb@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 54f81e668..53f6218b4 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -793,6 +793,8 @@ static void ast_udc_ep0_out(struct ast_udc_dev *udc)
 	req = list_entry(ep->queue.next, struct ast_udc_request, queue);
 
 	rx_len = EP0_GET_RX_LEN(ast_udc_read(udc, AST_UDC_EP0_CTRL));
+	if (rx_len > req->req.length - req->req.actual)
+		rx_len = req->req.length - req->req.actual;
 	req->req.actual += rx_len;
 
 	SETUP_DBG(udc, "req %p (%d/%d)\n", req,
@@ -865,6 +867,8 @@ static void ast_udc_epn_handle(struct ast_udc_dev *udc, u16 ep_num)
 	req = list_first_entry(&ep->queue, struct ast_udc_request, queue);
 
 	len = EP_DMA_GET_TX_SIZE(ast_ep_read(ep, AST_UDC_EP_DMA_STS));
+	if (len > req->req.length - req->req.actual)
+		len = req->req.length - req->req.actual;
 	req->req.actual += len;
 
 	EP_DBG(ep, "req @%p, length:(%d/%d), %s:0x%x\n", req,
@@ -944,6 +948,8 @@ static void ast_udc_epn_handle_desc(struct ast_udc_dev *udc, u16 ep_num)
 
 	} while (i != wr_ptr);
 
+	if (total_len > req->req.length - req->req.actual)
+		total_len = req->req.length - req->req.actual;
 	req->req.actual += total_len;
 
 	EP_DBG(ep, "req @%p, length:(%d/%d), %s:0x%x\n", req,
-- 
2.50.1

