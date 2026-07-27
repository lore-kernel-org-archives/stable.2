Received: from mail-pl1-f169.google.com (mail-pl1-f169.google.com [209.85.214.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C32403EB103
	for <stable@vger.kernel.org>; Mon, 27 Jul 2026 09:23:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785144189; cv=none; b=s+5oqVy3Jn13RGOn02lBwTxps7WAi8Ghu0M08RWRlj4VsV1e0/jb183ZxM57SBJJ4bqUwhvENhVe+fHtL7leyCZtlWRETpCoH2YX99R7RXhq6uOG4n4i56VMIWtv2Deqa26t1bOaNrhbJfIvHPXugkvFzxQbTUCC26qL56Dyemk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785144189; c=relaxed/simple;
	bh=scy7/dJO5rBGIP9GeHYpqzS1dSzegqHSnpR9eeQnIQ8=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=EBw3fXQOq4hYUX+v9do/gQQjr59DYxNOLzO6HKYbQZmZHwsqgxsdC4nDubLahP0WR/2GEeriUuUayZOs7tKbMGk/Ko9eqwwQxiKLQ2N3nb5AVWbKxuBmuhxk854PeWddyZ0RD31NRlzZOH0hRCYU78S/q11CSJgxsBF1TydV6sg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=nY1lmvsx; arc=none smtp.client-ip=209.85.214.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nY1lmvsx"
Received: by mail-pl1-f169.google.com with SMTP id d9443c01a7336-2cc7e86e7aeso25916385ad.2
        for <stable@vger.kernel.org>; Mon, 27 Jul 2026 02:23:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785144187; x=1785748987; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=r1/bsnbqHfmYvGyU8Wn3Qn7OtZBAodfgu3Y5gMkW6jw=;
        b=nY1lmvsxOMWbLTlmAcdX8kmfN8pLIMtffpy3YHJW904J0uO7yyOp9GqPCWnCrktbr/
         i1osdcDCEJ9JWbwxS5aybKyAQE5kMQsazDv3+meB3vx5ahNATol3qz+EZOAk3Z1p9WTC
         YqFgUYLSaepomq/LTnLlTKXyyEausbxrUhKDwB/Yc3q+bplzy2KQQ6VJG9ie1GkxzHYX
         rKW1c4iheXhuAdvL422HCn97GsnvET7pLUCPFkygdsmMeofQ2/zGEqyoOirZlmkzOLxh
         l1t8T0ytE8q8odYjq3ec7nBh2mRJIgNXeqNONdL1mqc6kwZ6gKiCDIDipudAuZQlgS+z
         f2Fw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785144187; x=1785748987;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=r1/bsnbqHfmYvGyU8Wn3Qn7OtZBAodfgu3Y5gMkW6jw=;
        b=qEurQyXIUJJ71bPl2xbt3uI7GlgWiFQFpPOQKvthjYdLBztwaKm+HOnZ1q4VehbzRR
         vcYsyGbG5qodjUkr22dpPtYBnWZ0ZM1/i6AaD05f+aExpGpWGwHFZgEmF16/LDgDvb8u
         DkxKhhf61yF1SAJmCciz3oAyIrMjHcEGYGp1YL3P8MOmjLnBy5LcIuJRJyx4kePwtoTh
         4d/Vs3eBGyiuxrx5lmMkRlwtz5ZgkqhQc52qzBgZe33oFj59eD6DyqOpyz0ztYc+f61y
         XsrtKcYgx+lqUDQrdMoBSmzfbDwdTIw96LC7f/mwsPgA0F6OoVmN5Gey9M/VCwlo+KQj
         Umuw==
X-Gm-Message-State: AOJu0YyJaU+jCzvRCwwNe1qAzqNk3LXTamGRiDXYn2VQRv8LK8qjK8pO
	UVzzZAPVOl2wJBlDxxyXwi7IItWj+2dhkTrU43fWzhJpU4h6kduREMMotW1W+A==
X-Gm-Gg: AR+sD13YMKPEObNKkN0Pfu8y4/k3gxUG28ohlYc85l7OR06TNXma9UiT+yQXJj6fmUN
	mhy7ClBs+Xj2HM4/OeO5D5H3wNx4dJPXcpKU586WcZqgBi/jZ49RNNV038XkhuJc3atB6oeCGO7
	8CgxSaBh3hyt++eYOrhDSoqqZ/EleSrAg3AhNy4bvnAXJTy8G0kbwEsQmTkpMK77NSWA0C98jUD
	Z9F3Q4dDxTgVLNh+dkB7uPAplYwUM8cB3PIWennlSuIXensemCkIpfc6ZwOs/E0Az1dpUvpS1CJ
	89AvRE7FoTPLptXVKYkHYmFszO6T+FF64rxNi7ncp4HKAX5Vw9DZyUCC4aikR5Fg3yCWSXqk9Eo
	6bOyRb0zY6YIaCIlrh7U2p7bPpGv0mrFEOrNsf+RBIcFV0p2AGsLss/rFcSdpvxmHVns9HOCMUd
	2q7JK+C0HAas2hvnRCWuA2sR7OVL1XCQ+++EtsOb+lG815bseLv92GcoNySGDtHCKnooD/AbmT5
	bumpLYJwDcrsmQnuyI=
X-Received: by 2002:a05:6a21:b92:b0:3c3:6c90:65b3 with SMTP id adf61e73a8af0-3c67dff9882mr7237406637.65.1785144186988;
        Mon, 27 Jul 2026 02:23:06 -0700 (PDT)
Received: from 7cf34ddc0813.ant.amazon.com ([54.222.46.7])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cbbb660daf6sm2933775a12.2.2026.07.27.02.23.04
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 27 Jul 2026 02:23:06 -0700 (PDT)
From: Jiazi Liu <jiazi.liu1984@gmail.com>
X-Google-Original-From: Jiazi Liu <liujiazi@amazon.com>
To: liujiazi@amazon.com
Cc: stable@vger.kernel.org
Subject: [PATCH 1/1] usb: dwc3: gadget: fix IRQ storm on invalid event buffer count
Date: Mon, 27 Jul 2026 17:22:58 +0800
Message-ID: <20260727092258.1121-1-liujiazi@amazon.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When dwc3_check_event_buf() reads a GEVNTCOUNT value exceeding the
event buffer length, commit 63ccd26cd1f6 ("usb: dwc3: gadget: check
that event count does not exceed event buffer length") returns IRQ_NONE
without writing back GEVNTCOUNT. Since the DWC3 interrupt is
level-triggered, the uncleared IRQ source keeps the line asserted,
causing a tight IRQ storm that accumulates 99,900 unhandled interrupts
and triggers spurious.c:184 BUG -> kernel panic.

Write the bogus count back to GEVNTCOUNT to clear the IRQ source,
consistent with the stale event clearing pattern in
dwc3_event_buffers_setup(), and schedule a soft disconnect via
softcon_work to recover the controller state.

Fixes: 63ccd26cd1f6 ("usb: dwc3: gadget: check that event count does not exceed event buffer length")
Cc: stable@vger.kernel.org
Signed-off-by: Jiazi Liu <liujiazi@amazon.com>
---
 drivers/usb/dwc3/core.h   |  2 ++
 drivers/usb/dwc3/gadget.c | 23 ++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/dwc3/core.h b/drivers/usb/dwc3/core.h
index 608daeb7ef10..0881ed7e956e 100644
--- a/drivers/usb/dwc3/core.h
+++ b/drivers/usb/dwc3/core.h
@@ -1004,6 +1004,7 @@ struct dwc3_glue_ops {
 /**
  * struct dwc3 - representation of our controller
  * @drd_work: workqueue used for role swapping
+ * @softcon_work: workqueue used for soft connect/disconnect recovery
  * @ep0_trb: trb which is used for the ctrl_req
  * @bounce: address of bounce buffer
  * @setup_buf: used while precessing STD USB requests
@@ -1189,6 +1190,7 @@ struct dwc3_glue_ops {
  */
 struct dwc3 {
 	struct work_struct	drd_work;
+	struct work_struct	softcon_work;
 	struct dwc3_trb		*ep0_trb;
 	void			*bounce;
 	u8			*setup_buf;
diff --git a/drivers/usb/dwc3/gadget.c b/drivers/usb/dwc3/gadget.c
index fa0f16ffafef..9b24259272a4 100644
--- a/drivers/usb/dwc3/gadget.c
+++ b/drivers/usb/dwc3/gadget.c
@@ -4669,7 +4669,18 @@ static irqreturn_t dwc3_check_event_buf(struct dwc3_event_buffer *evt)
 	if (count > evt->length) {
 		dev_err_ratelimited(dwc->dev, "invalid count(%u) > evt->length(%u)\n",
 			count, evt->length);
-		return IRQ_NONE;
+		/*
+		 * The DWC3 interrupt is level-triggered. Returning IRQ_NONE
+		 * without clearing the IRQ source leaves the line asserted,
+		 * causing a tight IRQ storm that triggers spurious.c:184 BUG.
+		 * Write the bogus count back to GEVNTCOUNT to clear the source,
+		 * consistent with the stale event clearing in
+		 * dwc3_event_buffers_setup(), then schedule a soft disconnect
+		 * to recover the controller state.
+		 */
+		dwc3_writel(dwc->regs, DWC3_GEVNTCOUNT(0), count);
+		schedule_work(&dwc->softcon_work);
+		return IRQ_HANDLED;
 	}
 
 	evt->count = count;
@@ -4729,6 +4740,14 @@ static void dwc_gadget_release(struct device *dev)
 	kfree(gadget);
 }
 
+static void dwc3_softcon_work(struct work_struct *work)
+{
+	struct dwc3 *dwc = container_of(work, struct dwc3, softcon_work);
+
+	dev_err(dwc->dev, "event buffer error: performing soft disconnect\n");
+	dwc3_gadget_soft_disconnect(dwc);
+}
+
 /**
  * dwc3_gadget_init - initializes gadget related registers
  * @dwc: pointer to our controller context structure
@@ -4772,6 +4791,7 @@ int dwc3_gadget_init(struct dwc3 *dwc)
 	}
 
 	init_completion(&dwc->ep0_in_setup);
+	INIT_WORK(&dwc->softcon_work, dwc3_softcon_work);
 	dwc->gadget = kzalloc_obj(struct usb_gadget);
 	if (!dwc->gadget) {
 		ret = -ENOMEM;
@@ -4868,6 +4888,7 @@ void dwc3_gadget_exit(struct dwc3 *dwc)
 	if (!dwc->gadget)
 		return;
 
+	cancel_work_sync(&dwc->softcon_work);
 	dwc3_enable_susphy(dwc, true);
 	usb_del_gadget(dwc->gadget);
 	dwc3_gadget_free_endpoints(dwc);
-- 
2.50.1 (Apple Git-155)

