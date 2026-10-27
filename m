Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=115.124.28.169
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793068837;
	b=eYaz6JLIPExdnALQorCEmN1EfwMECeAusRgtIfuQ7F4/nUtLZ0YNhbYQBK89vlDbaB0B
	 W6Ulu+bjHrpuUrzm6VpOcpWs5hQYtmG+UFLNfdeWGIsVIOpFhHqtjTiUQPcwYIZnR7Lgz
	 QnMc54AUWpNKB7Q041JUtdXY+RJuV/QYoX0h3IuMpyNfR7nDB6tU2PUpdM/czjOwiWuCH
	 8lkPqMDzezDdaxwnB1Y8drBehkrAnADoN1l3ZRLeoGq9NcjTqsX3UUdeznUsbh8NaHAc9
	 8fsGeLl3a82+8HDNDCBJLz9RGbkTN6j8WCHZoZAFYjjpKn5btPkyY2OcAv8oOhvHl+w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793068837;
	h=DMARC-Filter:DKIM-Signature:X-Alimail-AntiSpam:Received:From:To:Cc:
	 Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=/r7sbHgOMl6flEmwGOSI95NWBozhJ6tRqgN4OdIa9Ik=;
	b=u+GckMv+1NnC/A8fjoOIVas8ATp5pOEWaJvVFBIpEWN3th8BD3FIHnUYctGWZFYtnoKf
	 ClSosski0U0D7mdPOf16l2i9Nd9OaXOS03zYKF/nIMfjiwkgXHPQpaRI0AdhL+j5UMXpj
	 rO03Xa7mexdMHLp/UfEJkISNsCNuXjK05SpCxO33nIwSk/MFw9PM27CcOJjaAGeWy08Vq
	 34bur2DzQ4GCDFIRlzU4iKYq2a5XEC2gQg1XleRZT6eyM++14QQ+4pojNR+qjo1wEddoT
	 969IAm/gB/q+u+vvUet8C/T2Umdd8TX6qfYA+SuUC2fs5Nd0oJzlPbGv47Gwa4RiXDA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=none header.from=xiaopeng.com;
	spf=pass smtp.mailfrom=xiaopeng.com;
	dkim=pass header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=p3eNu3YW;
	arc=none smtp.remote-ip=115.124.28.169
Received: from out28-169.mail.aliyun.com (out28-169.mail.aliyun.com [115.124.28.169])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1617606A31A;
	Tue, 27 Oct 2026 02:40:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D1617606A31A
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xiaopeng.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=xiaopeng.com header.i=@xiaopeng.com header.a=rsa-sha256 header.s=default header.b=p3eNu3YW
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=xiaopeng.com; s=default;
	t=1793068831; h=From:To:Subject:Date:Message-ID:MIME-Version;
	bh=/r7sbHgOMl6flEmwGOSI95NWBozhJ6tRqgN4OdIa9Ik=;
	b=p3eNu3YWtyhRp3dzlzEb17w3kwRlR55eeQsrNWXMaRdHL6WvfUztEbB+JqNTtgPY/FDSxQA66nsQBybm2xzBlZekMF0UV+/DYlWCpitr/hLr+qzs9vA+NcgQZUIv+3KnG0DwaGra7tW79zgcKOXii4+Lc1tl1fNvSinoCVBbP1Q=
X-Alimail-AntiSpam:AC=CONTINUE;BC=0.07439248|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_regular_dialog|0.011536-0.00151875-0.986945;FP=14732518330469582032|0|0|0|0|-1|-1|-1;HT=maildocker-contentspam033037033194;MF=liuc63@xiaopeng.com;NM=1;PH=DS;RN=12;RT=12;SR=0;TI=SMTPD_---.jqKXZaa_1793068829;
Received: from localhost(mailfrom:liuc63@xiaopeng.com fp:SMTPD_---.jqKXZaa_1793068829 cluster:ay29)
          by smtp.aliyun-inc.com;
          Tue, 27 Oct 2026 10:40:30 +0800
From: Liu Chao <liuc63@xiaopeng.com>
To: gregkh@linuxfoundation.org
Cc: neal_liu@aspeedtech.com,
	joel@jms.id.au,
	andrew@codeconstruct.com.au,
	ryan_chen@aspeedtech.com,
	billy_tsai@aspeedtech.com,
	zhugl3@xiaopeng.com,
	linux-aspeed@lists.ozlabs.org,
	linux-usb@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH] usb: gadget: aspeed_udc: fix u16 truncation of descriptor lengths
Date: Tue, 27 Oct 2026 10:40:13 +0800
Message-ID: <20261027024029.1310175-1-liuc63@xiaopeng.com>
X-Mailer: git-send-email 2.50.1
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ast_udc_epn_kick_desc() computes tx_len as u32 bounded by
AST_EP_DMA_DESC_MAX_LEN * AST_UDC_DESCS_COUNT (7680 * 256, roughly
1.88 MB) and hands it to ast_dma_descriptor_setup(), whose tx_len
parameter is u16.  The length is truncated to the low 16 bits before
the descriptor list is built, so a descriptor-mode IN request larger
than 64 KB is described -- and therefore transferred -- as only
tx_len % 64 KB bytes.

The caller still accounts the full, untruncated length:

	req->actual_dma_length += tx_len;

so req->actual_dma_length never equals req->req.actual and the "more
requests" check in ast_udc_epn_handle_desc() never kicks the next
stage.  The request never completes and the endpoint queue stops
draining.

The same handler accumulates the per-descriptor transfer lengths of a
stage into a u16 total_len.  Each descriptor carries up to 8191 bytes
(EP_DESC1_IN_LEN mask 0x1fff) and up to AST_UDC_DESCS_COUNT (256)
descriptors are walked, so once the truncation above is fixed the sum
can exceed the u16 range: a full stage covers 7680 * 256 bytes, which
wraps modulo 64 KB to a value smaller than ep->ep.maxpacket.  The
short-packet check then believes the stage was short, completes the
request before the whole transfer has finished, and adds a length to
req->req.actual that does not match what was really moved.

Widen both the tx_len parameter and the total_len accumulator to u32.

Fixes: 055276c13205 ("usb: gadget: add Aspeed ast2600 udc driver")
Cc: stable@vger.kernel.org
Reviewed-by: Guanglei Zhu <zhugl3@xiaopeng.com>
Signed-off-by: Liu Chao <liuc63@xiaopeng.com>
---
 drivers/usb/gadget/udc/aspeed_udc.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/usb/gadget/udc/aspeed_udc.c b/drivers/usb/gadget/udc/aspeed_udc.c
index 54f81e668009..f8c58158bd51 100644
--- a/drivers/usb/gadget/udc/aspeed_udc.c
+++ b/drivers/usb/gadget/udc/aspeed_udc.c
@@ -472,7 +472,7 @@ static void ast_udc_ep_free_request(struct usb_ep *_ep,
 }
 
 static int ast_dma_descriptor_setup(struct ast_udc_ep *ep, u32 dma_buf,
-				    u16 tx_len, struct ast_udc_request *req)
+				    u32 tx_len, struct ast_udc_request *req)
 {
 	struct ast_udc_dev *udc = ep->udc;
 	struct device *dev = &udc->pdev->dev;
@@ -899,7 +899,7 @@ static void ast_udc_epn_handle_desc(struct ast_udc_dev *udc, u16 ep_num)
 	struct ast_udc_request *req;
 	u32 proc_sts, wr_ptr, rd_ptr;
 	u32 len_in_desc, ctrl;
-	u16 total_len = 0;
+	u32 total_len = 0;
 	int i;
 
 	if (list_empty(&ep->queue)) {
-- 
2.50.1

