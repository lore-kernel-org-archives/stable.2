Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=209.85.222.170
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794499529;
	b=Mkc8mtwQK8jwRalKkGTAdWB2/C1eBlQW2n0FNX3CleyrU/YKUkvzI9cKso0twHF91Pcq
	 JEL7e2CZQ9WIhVkZv9PiaS7T1Mf4gA/O1Hq47HIuF37SIwRHa/wMaeMQeyRMz8cY0MBTL
	 zMv0Ecl0WjhYIwgDFPTzEmCCUVaYmHkpddOexbljbXxDjfy2Ff2GdUVX6RO+MZ/fW0x/k
	 7K39V2k4w/uwW6aqCmTCugSiSqSfkqXAYURbOujRRqvFIdKRf03+SKG1BouMwtNkFwzFy
	 tGaDW2CwdUs8AXLSGJoeLjVVCmZxggYzUZ9oThecgRJ+9RIlikCMo/pV5Z1LBYSFYxQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794499529;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=VirwsWcUGB+wftXqJRXa0lz3ydc4K0zhD+XqX/ctFlE=;
	b=tAhhjy6x/mJnJ1bt4GgKZ8CdFuoYWw32tfEGocIwSofBSA8lrtfYxF8znGU+iFwJCTpf
	 WF1QotPjtcsG18oKg6WGxbM9XVv/96qQmyxSYPcCMttoQXwug4E4NxZNqzBvn2U9kCYfx
	 uFvFTuTINfp4jU1WlhsikJvxc1nYDgiALzMb0FZP/8D7xrjDKHG+IlcevWmzNxNo7yJR6
	 7urQfFS2iBooD2osIn7XnOZBEx/K+wONdzNh2keQzPY/Nlk5VknnzmKBFHDgwniT8DPgQ
	 XxpkMMg8jPcVZo2r0mjDAIrs2HKl9uZDf5zLfQV0DfbeLZ+9MDC3hvIPOv0fzEv8cfw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0mF15k7n;
	arc=none smtp.remote-ip=209.85.222.170
Received: from mail-qk1-f170.google.com (mail-qk1-f170.google.com [209.85.222.170])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 67AC3606A31C
	for <stable@vger.kernel.org>; Thu, 12 Nov 2026 16:05:29 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 67AC3606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=0mF15k7n
Received: by mail-qk1-f170.google.com with SMTP id af79cd13be357-93f2551f57fso26327885a.1
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 08:05:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794499528; x=1795104328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VirwsWcUGB+wftXqJRXa0lz3ydc4K0zhD+XqX/ctFlE=;
        b=0mF15k7n1pnwLYSn/PF9bLVIRzcqqMmJGsKWoF2ZoSuJ/yayh9RrP/dQzQSWMOgtgM
         OwyUI7iGgtVBtqPWldYWiuxsy0slvrCUIMbKDtKntFC4L2JH8wm7yi7kZU+3tg9Sj3l2
         3C7BlyRfM1iDBjtxRVz6YG6qJQfcQKOqy3Q4bJkZkr16Fx/no8rk8D02ibPCcMyWuEYW
         C0GBsrZ3fQjHXDFdHH2jT2bqZLz58c9WYqUgQIocuJT+tq1cHjrUn4PtW+Ak1hzwsqKG
         /kjWz94e20Qq2Hf4N3EjUupe9ACDlo1NITSv3STddJHe5cLah+iMWqimsdZxGw7aNm6V
         6P5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794499528; x=1795104328;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=VirwsWcUGB+wftXqJRXa0lz3ydc4K0zhD+XqX/ctFlE=;
        b=jG5elqZJWg8udFad38epRBYKqcezKuf75ZTO5MWkZ5UnPqKHntI2zkAoUR7M5+F/Dm
         mrS2ENs4SHhvlRwnPT6LguTXu8EyHG+GxgxUE667Zuj543jT6QY90gjXtJZyfKxH3M+5
         xwtCNycsu32LdOVsQVG7MLNmBpj6y7hR2kHnjMTkgvGJvo43Cr4NzogGpHC6yDQbPyHF
         sjq3rMFV4t+/HAvbEsn57jLTy8dMUsXtlvP7wMTfKCF/01VJbqKWXzMDDqfQnR9peD+u
         D07AS6sfsJbhqjTZYgceFJBqSWKRaCsEuU+w1hrLNAKWuWI3dLhUtQzVaAuU5j6BTTCh
         N7FA==
X-Forwarded-Encrypted: i=1; AL+hErFS87Yl1K2W6yzp9bucbTilZ2RlBa4zAuGmczNUTKu8WhBQyVotDSXibWHJ9THSIj5kHXXtnUc=@vger.kernel.org
X-Gm-Message-State: APuU4Z9Mtb0grY+YUod/bRMaLZic9w4f4z4LxuGe3x8e82D9i/vZOoif
	RKQL2RkdYsoXF2/2bNaXxRaTYDI1VMVxdCIoo3fIgAD2sTw9camJyC7J
X-Gm-Gg: AYBFou2QQdK5nwEx9cPZ7OyJRiqLaqRLtscAZktH7j9H6M2/iBnhDnXT/L6qd/ejQxH
	BqWYKAJudLXNoJpO+tB6Ecmv7C+IvIOO4fiMZx5kR0xaRf6SzbzEXmBEU6RP/InvtYA9x7hkk0o
	i4EUyF5hFLWkBbMJi+h10GOvYc1ncnqqIs66kpAuv1UuOrtPCGQO47fiflYXv1DIuyB21lOm5JM
	J4V/XOw50LGUbLU+winNz/TI36shLSZvOkP06EPk99WTfJp1ehQ0niVRBJ+8aEA3CU28stSaesI
	iJR6hL/FdlAFj7uOGFpzQ4DOqSPh1E5sz45x/NheiXn6i1GWvKRyPSlcC2Vd6/msph5xZAb8ys0
	mYq1atq1B1ksnHvnnfTqcjVvD+ca+si7AIWff8Zm4KeWQ2oT6PKmSV9EXPt1XoXyhj1rVmUxJ9O
	l1oke6rJnPa9sBBFDg13v2lFVOj/pERzFKwsku6ueEG5vKCoMq4x3nfDG2NjTl9TWGs4ZAmRbfl
	tQEjbXkwO8oRL0of3ENQSUqQwY+RzI6w87gcRXHvB2qKS1OOhYdror1B1SDgZbwTXkmjkr3yfFJ
	nAE6xOr5brCN78dVb5KwVtYZAY9tiE8quavmMUpd2jSa/GZR
X-Received: by 2002:a05:7301:4d10:b0:377:d6e5:e642 with SMTP id 5a478bee46e88-377d6e5e7damr4248214eec.1.1794499517613;
        Thu, 12 Nov 2026 08:05:17 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-37922d49049sm613673eec.1.2026.11.12.08.05.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 08:05:16 -0800 (PST)
From: Chengyu Liu <lui2012qwq@gmail.com>
To: linux-usb@vger.kernel.org
Cc: b-liu@ti.com,
	gregkh@linuxfoundation.org,
	nkapron@google.com,
	tony@atomide.com,
	bigeasy@linutronix.de,
	balbi@ti.com,
	shimoda.yoshihiro@renesas.com,
	robert.jarzmik@free.fr,
	Chengyu Liu <lui2012qwq@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH 3/4] usb: gadget: r8a66597: free the IRQ before deleting the timer
Date: Fri, 13 Nov 2026 00:04:47 +0800
Message-Id: <20261112160448.41566-4-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261112160448.41566-1-lui2012qwq@gmail.com>
References: <20261112160448.41566-1-lui2012qwq@gmail.com>
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

r8a66597_remove() deletes r8a66597->timer while the interrupt is
still live: the IRQ is devm-managed and only freed at detach, and
r8a66597_irq() re-arms the timer when sampling VBUS (VBINT).  An
interrupt landing after timer_delete_sync() re-arms the timer, and
r8a66597_timer() then runs on freed memory.

Store the requested IRQ number at probe time and free it before
deleting the timer; freeing also waits for any running handler, so
nothing can re-arm the timer past the delete.

Found by static analysis.

Fixes: c41442474a26 ("usb: gadget: R8A66597 peripheral controller support.")
Cc: stable@vger.kernel.org
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
Build-tested on x86_64: r8a66597-udc.o compiles clean
(USB_R8A66597 + COMPILE_TEST).  No runtime reproducer: requires
R8A66597 hardware.  Fix written with AI assistance.

 drivers/usb/gadget/udc/r8a66597-udc.c | 8 ++++++++
 drivers/usb/gadget/udc/r8a66597-udc.h | 1 +
 2 files changed, 9 insertions(+)

diff --git a/drivers/usb/gadget/udc/r8a66597-udc.c b/drivers/usb/gadget/udc/r8a66597-udc.c
index 469075b064ba..bfccc6565e0a 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.c
+++ b/drivers/usb/gadget/udc/r8a66597-udc.c
@@ -1810,6 +1810,13 @@ static void r8a66597_remove(struct platform_device *pdev)
 	struct r8a66597		*r8a66597 = platform_get_drvdata(pdev);
 
 	usb_del_gadget_udc(&r8a66597->gadget);
+
+	/*
+	 * The interrupt handler re-arms the timer on VBUS changes; the
+	 * IRQ is devm-managed and freed only at detach, so free it
+	 * before deleting the timer.
+	 */
+	devm_free_irq(&pdev->dev, r8a66597->irq, r8a66597);
 	timer_delete_sync(&r8a66597->timer);
 	r8a66597_free_request(&r8a66597->ep[0].ep, r8a66597->ep0_req);
 
@@ -1896,6 +1903,7 @@ static int r8a66597_probe(struct platform_device *pdev)
 			       udc_name, r8a66597);
 	if (ret < 0)
 		goto clean_up2;
+	r8a66597->irq = irq;
 
 	INIT_LIST_HEAD(&r8a66597->gadget.ep_list);
 	r8a66597->gadget.ep0 = &r8a66597->ep[0].ep;
diff --git a/drivers/usb/gadget/udc/r8a66597-udc.h b/drivers/usb/gadget/udc/r8a66597-udc.h
index 9a115caba661..08acabe02421 100644
--- a/drivers/usb/gadget/udc/r8a66597-udc.h
+++ b/drivers/usb/gadget/udc/r8a66597-udc.h
@@ -110,6 +110,7 @@ struct r8a66597 {
 	unsigned char interrupt;
 	unsigned char isochronous;
 	unsigned char num_dma;
+	int irq;
 
 	unsigned irq_sense_low:1;
 };
-- 
2.25.1

