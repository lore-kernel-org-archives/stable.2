Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 912B83E1680
	for <stable@vger.kernel.org>; Tue, 14 Jul 2026 06:48:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784011719; cv=none; b=EMbzRd2rvmSVwcmB/feMo/NVpaKUbGi/eODaza8HsKSIfd1UvBEggJCGsdwFz5UUhiH0aR7HZV7bdBUusFXKBnCGPZs5/FOzfDX+HEPz5gpu6A3XPUvVULQJweaK6ljoTvFl1cSaX9+7STX/3bfkNOYuXAYYvrJpeI6w+W0TU+s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784011719; c=relaxed/simple;
	bh=aZlcH4OxvFHO+ZSx63whlzSsDvYQENRMsi4F/aUDmgo=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=d3ZzZ2MXFomQVAuhxbpfEUQhtFDHwdJJ3F7OBS/CysBn0DsX8jQgotLsrUgl2CVuCET0XiBbyWsgK428/UthKG/n+ESq1VOukvcSXDtwO093LPkTXssrJ9nTxNu9pLtwwHKVEyYdiAN/aQbzqs+akyvRhqNoNM7lrJnhIoyw/NE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=syuhHWFb; arc=none smtp.client-ip=209.85.222.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="syuhHWFb"
Received: by mail-qk1-f174.google.com with SMTP id af79cd13be357-92e5b048375so245879085a.1
        for <stable@vger.kernel.org>; Mon, 13 Jul 2026 23:48:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784011716; x=1784616516; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=/MSWmAHhibOUb8+dtux4VwDB6gj9PYU7Wzltf0lKwv4=;
        b=syuhHWFbrKbzsA+ifX/qFe1iFlQSlOuLFfT1i0tAVviMm9fn5mUhrwGj5NY5kPNGbt
         UdlVI1hCf+ZCh601rW146IW2fcJ5rsqwZI5Yc5j02RK1hoOqIu2ukimuVvxN30p/jIqR
         HjtuoTIodEqVaD3wOXcMVh4zVE6XctT78o/EQiXsXWnXUsNFWQ3mbxo/TJwZlYPd2d9l
         mlEy/2jENE5YWowI0rRKP+vBQBUfORqYGVeeRzyVJmCClvs0YuZT55ee4DqkZSQlvIkm
         6pHAGdr0Ci/SIvVMbbAx+iJCQ2TYpGI1xUqWjZPRAETD/l9qtkcPZNAeUnw5nY6xJtOU
         IzJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784011716; x=1784616516;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=/MSWmAHhibOUb8+dtux4VwDB6gj9PYU7Wzltf0lKwv4=;
        b=pKajHJja1HOUI8KOF7pltdxrmb9hJGCpjlDw80jXzp8f3sewA339HGZyAgSMPbxUbF
         B1l/qjJKn26iPv+QC6JVqabzp4UBTlaK0+Y/Z6oN6pwH+htERybCTrVjc0q6P1ng8k9z
         0S3IcTDWb2Es7BAf7cE1XejLAiG/6AwV8jRan6pGz7Gyh8lL9bg0qne8RTUPjnFVYQ9c
         9TQr7ZoP0X3iVtOU9iETe0Hmdxi0UXbxoVml+69FY4vIYMSscg+EegMQ2AEiqjSFbTvL
         3V5RB8cAT0wLBAz8CPadUKTwm6hTJmmNiUc9YLc7ZEDxE+l+7Db/nHAC+doitwzW2gvA
         fnCA==
X-Forwarded-Encrypted: i=1; AHgh+RrO2ro2mWW2zW7KkVFO+VRZEvyKHB7rab5CQhxpJmmjNJifcjEOr0ThvZQD3psyF5f3MMh70gA=@vger.kernel.org
X-Gm-Message-State: AOJu0YwE3TYT/QCwSaKdWNxfFMBeuVL//ycDazOf6fQYTfUHt5TumNie
	aNm7o/6ulGtkRb9o3YeuF5ew0SvKfae6rGoNul5G4EFaDZUecx5UbW8q
X-Gm-Gg: AfdE7cmlj47aUdJK/XuFXgVAmH2/Ca97YL5NgnJd0dMi7yHoL3tiF+oAr7+n32BHZcd
	L+Dd5B9EBHqpChsMQByC/w1o35BjCt0DdFcWo4WRJgVZ5bCmu5ffxVqTmUwlkStqzQfAj3/Rp5d
	Io9bfYZ/PLES9nQfmI9VXw7KjzydAEjkRvRbaPfdaVrgGVsErl0ia1POFCVrvx7IjpXN8tjvleR
	3IBf166f5HlW1KdvSfvKmDPZd+WANw1Fuilqrt2enehNxxfhVl+vqvZjn9M+FcKKRarz9cnGu31
	J7rpjgFB0/rUXep9FtUYTsy6LLVoxsj1eT5d276+9uTQN0YjELiXmod44slWXz0MYkq3iN0e2BE
	G4Bh4uf3jmMJMD8Sas1XCpdFop8zwEADAgWcUSnDkvZElJf60TStLLK1Svp6WZw6vfWuYSUWY2s
	h39RK5Eo79olHPw2yUFcjM4L+T6QFtXf+fo0gnfrrUS2Vi2orWmJM=
X-Received: by 2002:a05:620a:2b82:b0:92e:6c15:24cd with SMTP id af79cd13be357-9308683e763mr104687285a.15.1784011716346;
        Mon, 13 Jul 2026 23:48:36 -0700 (PDT)
Received: from localhost ([48.45.163.146])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-92ee5d33689sm1343639185a.36.2026.07.13.23.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Jul 2026 23:48:35 -0700 (PDT)
From: Jinchao Wang <wangjinchao600@gmail.com>
To: gregkh@linuxfoundation.org,
	linux-usb@vger.kernel.org
Cc: stern@rowland.harvard.edu,
	bigeasy@linutronix.de,
	eeodqql09@gmail.com,
	kees@kernel.org,
	surban@surban.net,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	stable@vger.kernel.org,
	wangjinchao600@gmail.com
Subject: [PATCH] usb: gadget: dummy_hcd: prevent fifo_req reuse during giveback
Date: Tue, 14 Jul 2026 14:48:29 +0800
Message-ID: <20260714064829.172098-1-wangjinchao600@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dummy_hcd embeds a single shared usb_request (dum->fifo_req) that the
"emulated single-request FIFO" fast-path in dummy_queue() reuses for
small IN transfers: it copies the caller's request into it
(req->req = *_req) and queues it, treating list_empty(&fifo_req.queue)
as "the slot is free".

The completion side (dummy_timer/transfer/nuke/dummy_dequeue) follows
the standard pattern: list_del_init(&req->queue) unlinks the request,
then the lock is dropped and usb_gadget_giveback_request() invokes
req->complete().  But list_del_init() makes fifo_req.queue look empty
*before* the completion callback returns, so a concurrent dummy_queue()
on another CPU sees the slot as free, reuses fifo_req and runs
req->req = *_req -- overwriting req->complete while dummy_timer is
mid-calling it.  The indirect call then jumps to a clobbered pointer,
causing a general protection fault / page fault in dummy_timer
(syzkaller extid faf3a6cf579fc65591ca).  The clobbering write is an
in-bounds memcpy on a live shared object, so KASAN cannot flag it.

Add a fifo_req_busy bit, set across the lockless giveback window via a
dummy_giveback() helper used at all four gadget-request giveback sites,
and require !fifo_req_busy in the FIFO fast-path guard so the shared
slot cannot be reused until its completion callback has returned.

Reported-by: syzbot+faf3a6cf579fc65591ca@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=faf3a6cf579fc65591ca
Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable@vger.kernel.org
Signed-off-by: Jinchao Wang <wangjinchao600@gmail.com>
---
 drivers/usb/gadget/udc/dummy_hcd.c | 40 +++++++++++++++++++++---------
 1 file changed, 28 insertions(+), 12 deletions(-)

diff --git a/drivers/usb/gadget/udc/dummy_hcd.c b/drivers/usb/gadget/udc/dummy_hcd.c
index f47903461ed5..fce3c3ba7a63 100644
--- a/drivers/usb/gadget/udc/dummy_hcd.c
+++ b/drivers/usb/gadget/udc/dummy_hcd.c
@@ -278,6 +278,7 @@ struct dummy {
 	unsigned			ints_enabled:1;
 	unsigned			udc_suspended:1;
 	unsigned			pullup:1;
+	unsigned			fifo_req_busy:1;
 
 	/*
 	 * HOST side support
@@ -330,6 +331,28 @@ static inline struct dummy *gadget_dev_to_dummy(struct device *dev)
 /* DEVICE/GADGET SIDE UTILITY ROUTINES */
 
 /* called with spinlock held */
+/*
+ * Give back a gadget request with dum->lock dropped around the callback.
+ * If @req is the shared fifo_req, mark it busy across the callback so
+ * dummy_queue()'s FIFO fast-path (keyed on list_empty(&fifo_req.queue))
+ * cannot reuse it mid-giveback: list_del_init() already made the queue look
+ * empty, but the request is in flight until the completion callback returns.
+ * Caller holds dum->lock and has already done list_del_init() + status.
+ */
+static void dummy_giveback(struct dummy *dum, struct usb_ep *_ep,
+			   struct dummy_request *req)
+{
+	bool fifo = req == &dum->fifo_req;
+
+	if (fifo)
+		dum->fifo_req_busy = 1;
+	spin_unlock(&dum->lock);
+	usb_gadget_giveback_request(_ep, &req->req);
+	spin_lock(&dum->lock);
+	if (fifo)
+		dum->fifo_req_busy = 0;
+}
+
 static void nuke(struct dummy *dum, struct dummy_ep *ep)
 {
 	while (!list_empty(&ep->queue)) {
@@ -339,9 +362,7 @@ static void nuke(struct dummy *dum, struct dummy_ep *ep)
 		list_del_init(&req->queue);
 		req->req.status = -ESHUTDOWN;
 
-		spin_unlock(&dum->lock);
-		usb_gadget_giveback_request(&ep->ep, &req->req);
-		spin_lock(&dum->lock);
+		dummy_giveback(dum, &ep->ep, req);
 	}
 }
 
@@ -729,6 +750,7 @@ static int dummy_queue(struct usb_ep *_ep, struct usb_request *_req,
 	/* implement an emulated single-request FIFO */
 	if (ep->desc && (ep->desc->bEndpointAddress & USB_DIR_IN) &&
 			list_empty(&dum->fifo_req.queue) &&
+			!dum->fifo_req_busy &&
 			list_empty(&ep->queue) &&
 			_req->length <= FIFO_SIZE) {
 		req = &dum->fifo_req;
@@ -785,9 +807,7 @@ static int dummy_dequeue(struct usb_ep *_ep, struct usb_request *_req)
 		dev_dbg(udc_dev(dum),
 				"dequeued req %p from %s, len %d buf %p\n",
 				req, _ep->name, _req->length, _req->buf);
-		spin_unlock(&dum->lock);
-		usb_gadget_giveback_request(_ep, _req);
-		spin_lock(&dum->lock);
+		dummy_giveback(dum, _ep, req);
 	}
 	spin_unlock_irqrestore(&dum->lock, flags);
 	return retval;
@@ -1523,9 +1543,7 @@ static int transfer(struct dummy_hcd *dum_hcd, struct urb *urb,
 		if (req->req.status != -EINPROGRESS) {
 			list_del_init(&req->queue);
 
-			spin_unlock(&dum->lock);
-			usb_gadget_giveback_request(&ep->ep, &req->req);
-			spin_lock(&dum->lock);
+			dummy_giveback(dum, &ep->ep, req);
 
 			/* requests might have been unlinked... */
 			rescan = 1;
@@ -1910,9 +1928,7 @@ static enum hrtimer_restart dummy_timer(struct hrtimer *t)
 				dev_dbg(udc_dev(dum), "stale req = %p\n",
 						req);
 
-				spin_unlock(&dum->lock);
-				usb_gadget_giveback_request(&ep->ep, &req->req);
-				spin_lock(&dum->lock);
+				dummy_giveback(dum, &ep->ep, req);
 				ep->already_seen = 0;
 				goto restart;
 			}
-- 
2.53.0

