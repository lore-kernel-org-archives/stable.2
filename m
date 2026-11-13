Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.171
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794551682;
	b=R1m0JtsQMD5YbcheMbgcG4WJsLB++Dz7wzqP2pXQHymZ0boZLD2st5maZXiBqICIdr5H
	 cEiKFnPAF5NrXuYkFe9omjcnncI1dtQdcwW5Ge8XSCEMODzs1FJSaWETZKO0kd3BtLZWm
	 DX+LBYX3/IT9jmH9fLsA1GHRI885vBCBeT2v7KMKhVS84zpiHXXAqomHeTUzg32gmqkKx
	 zB9lek64FwpJdt6sCRuIF7weWtt0d3zLy9uOz8pyIgk44crDVE8FmAB4ilaX9fyz1EM8M
	 FNqO7xL2ooI4FCVI1iy4evbg1i30p4Xj/1G6TIYhc+tuXfkFHmczjgxOhMDp2ni8YFg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794551682;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-Id:X-Mailer:In-Reply-To:References:
	 MIME-Version:Content-Transfer-Encoding;
	bh=axXbVbTMs8zsZ3lI2s9N/4Jxd4kEwJx28aoWH25x+cE=;
	b=0AC92qLokcfDjkpx6fFf/qF0nr2haZE2+Xry3QJG1p6DquXqWtbvj5FAPuJIaKY4ZcHL
	 dulrkvIaxrlbfo1IB4DEcEqBty1gPLcVAMUE8RezIwgd5tjvyAPYWTYk1RjM5iUvTcbuz
	 nX1YzqFcUThzs9AvQe/ILjO3BV92DJMSokbSxmcEnUSY+JhAyGkPo3g4PDeFK3ehM0ikL
	 +fPH0/T8Ki/OlFnQZW4UlfbDGH45qSkVqnYLdFxh/LjYDrJZ0tROusbsn5DJrNySgIRFK
	 9/9NIoDdj0W2IF73aZ9jtRnx2BKbs8LU9NLzNd2sL/bJ757NtWzKLt8y/i7CZ29PD5Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AKPme0Av;
	arc=none smtp.remote-ip=74.125.82.171
Received: from mail-dy1-f171.google.com (mail-dy1-f171.google.com [74.125.82.171])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D21D606A327
	for <stable@vger.kernel.org>; Fri, 13 Nov 2026 06:34:42 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 6D21D606A327
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=AKPme0Av
Received: by mail-dy1-f171.google.com with SMTP id 5a478bee46e88-36d1b3b9974so49391eec.2
        for <stable@vger.kernel.org>; Thu, 12 Nov 2026 22:34:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1794551681; x=1795156481; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=axXbVbTMs8zsZ3lI2s9N/4Jxd4kEwJx28aoWH25x+cE=;
        b=AKPme0AvXK7JzQlo+nBWEoXKS4bY86V2/qGYM1ZoBLB8APsem5UDhO3yhfRwU0UFIb
         gxItqkm7SCJlF4x4IuHd2s3D3NafGW6E+BRCCvswEwUGmNbpOxtuuN800UpkU/uCNo82
         h7KLW546ooD9Cz+mZ8Ce34GRKXBv1hwznBC/t7xtF/Hrp+5CNrS7xL4ODiQ+aTWqPaEk
         5Q7I4Oae6btd2Lu8hY3hs3oWQYoBkAn4+wjW13uBdvAhz6fCYNlLVSZPzSW9J6pTdNHM
         ZrRW+aqilWB1rhUyX1IBdJZ0C9I24qrqWQk76pC2XNpQEaRpH1IYWKXwkCDgH+K4y57V
         NFaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1794551681; x=1795156481;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=axXbVbTMs8zsZ3lI2s9N/4Jxd4kEwJx28aoWH25x+cE=;
        b=fGo1exKvF0/PH8gYDTZJ7m/y7wy6bp45SQDeQS4UQAjOaE6kk60mpBB+ITJ8/VLJ/j
         HBi0eAPI00pCTKjQhFmPCpIL3nZxQKaa2ohaA8dHQOQhjBVS/HeV+7nW3V6hTJDXkRsB
         XLAEwYDUl9NvLBOjyBbeHGzd20uzGF/wbLZCrpHhLVarC4PFJdtwUBXRaapdUbtX55Eo
         SjRfBaYsScNJV95BlCcfYX7IS/tWgaXhaB/y4Hh3R9B5mNvQ+91BUlZu7wdnwCAOYpUw
         Nu+WOGTDxk5Aue2ig0x+oMdCzpPQQ9/JObfl83ZeaEI0BXv/P7YcA+tohXIxwsQ7p8bI
         7N3w==
X-Forwarded-Encrypted: i=1; AL+hErEpJw4JbneteeH6Q53FzNe1sp/mSrekZE0oWrx1EOv/+tNCnreKmV3WLSPGTPxfdsAC5UTQCpI=@vger.kernel.org
X-Gm-Message-State: APuU4Z8SXJb0en8LP1Aeg5rNnKoJp7GvbxjhSgvJwUZ7CGVI6yGN4Kg5
	qRGOcQstC/JL0TDY7n2+twSqEBS0QmmlGMw9HrsvObLfFG34IqpHfIo8
X-Gm-Gg: AYBFou2QhmqgWRRef4sBdgPmhnM47dNVi8L6sIa+aXzzsh4Htqa5xHkGh+o/XTlPSFC
	S+N627l2VixHKQTRRZDXxPa6+Eni2MRYnoyrA+NawuhoVyM2geD18zqty8Gw+WVEAEpM35xkzf/
	VYZVDEmKDAZ8iPL6KhfyKzNuuSaX1fQfu0aLFA1My3v5t7IxFAZn/c0P7BcovWLyeXkvKb1BCwP
	/mHoZcZkyGzk3y+Y1z36YRn9DTvnFzU0u9Z+vmuyDkCx6hZb+1TeBkb4la98RTAwDY4OBgpk3uT
	PleptgfJDt3oBU7c+pudhpmbfAd2n1RQtODR10wZInY/ZPuLMytl+A2BOr/5czYMYPseziP75jy
	8ZuPN8zNZdPjSEC1qNtRV4JhnmYpwGn9fcN4N0u3XS5JCxrON++MBr1u93RQH/bhRIenHRnWKiE
	Xie6PCRPUZmVX/xbg4Pl5wFttDstNcJY7efXDYBdWQNVJx5eUsH5JDiKbN8Z/b2lYb17eYERws+
	cM3A91SnB3tUVz57xleRM5vJULRuJEbhkWM1uWPBUywy+tYE/0w25ecOZElBQjXBHiElnerBbxZ
	x8qrcHB54DbUbWgo7RHAMrKjcPvZ4zgo717f6iMAGg==
X-Received: by 2002:a05:7301:a0a:b0:375:f846:5b3f with SMTP id 5a478bee46e88-3796057e734mr1831234eec.0.1794551681320;
        Thu, 12 Nov 2026 22:34:41 -0800 (PST)
Received: from CRASHEDROM.localdomain ([142.249.36.161])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-379569b8389sm6745027eec.25.2026.11.12.22.34.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Nov 2026 22:34:40 -0800 (PST)
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
Subject: [PATCH v2 3/4] usb: gadget: r8a66597: free the IRQ before deleting the timer
Date: Fri, 13 Nov 2026 14:34:08 +0800
Message-Id: <20261113063409.47485-4-lui2012qwq@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20261113063409.47485-1-lui2012qwq@gmail.com>
References: <20261113063409.47485-1-lui2012qwq@gmail.com>
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
Reviewed-by: Neill Kapron <nkapron@google.com>
Signed-off-by: Chengyu Liu <lui2012qwq@gmail.com>
---
v1 -> v2: no code change; collected Neill Kapron's Reviewed-by.

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

