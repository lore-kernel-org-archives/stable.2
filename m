Received: from mail-ej2-f12.google.com (mail-ej2-f12.google.com [74.125.228.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28CAB48382E
	for <stable@vger.kernel.org>; Thu, 24 Sep 2026 21:51:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=pass smtp.client-ip=74.125.228.140
ARC-Seal:i=2; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790286710; cv=pass; b=YQwV0++yZAhd5EprEZVaHlwobfj0PdhKX4Zok6RnPe2mLZMy0S1VKVnidkKcYtYeUdAMKsWO3hoMpNKaYirlEScFmBnadv/92nNMpGY0eA6IOKMrwvwJFUpt0Ry6IrmbB4RFidtVXW73q392toYJfRXMsZSa4sakwjaKk7mg3mw=
ARC-Message-Signature:i=2; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790286710; c=relaxed/simple;
	bh=vwIL4Z9WhDilYVKgXK6Lo2kf/q7i4XxX4sVI/yy9z8o=;
	h=MIME-Version:From:Date:Message-ID:Subject:To:Cc:Content-Type; b=LcJKAOfHrHxCXaoXPHI1meZNiKIxPpV0YyZZQLafQZ7TmYXnP4aP9ywfoVeYObLqKsBMzEeDPnDR+pA3pKRw/ldft+6J8lLtCgadUtk8294cHRBkI371PiOfQ4GU/AbohBegMatJ1DbXCIvBiNIZf0Ur5S8d0CkmRRD4L4AVq1s=
ARC-Authentication-Results:i=2; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=m0Ib9wJV; arc=pass smtp.client-ip=74.125.228.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="m0Ib9wJV"
Received: by mail-ej2-f12.google.com with SMTP id a640c23a62f3a-c254f9f0b1eso39840366b.1
        for <stable@vger.kernel.org>; Thu, 24 Sep 2026 14:51:47 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1790286705; cv=none;
        d=google.com; s=arc-20260327;
        b=fX2Sxdsvp8OBw/LJbFZRBlNtWPfRySygBbdoVBiof8hO/SgxwRchjFWdEhJGrbMpXz
         Jcx8WhiZdbGzWWFw1uLCV8yCv+b0RiH3qynWuBz7lBeLt5ftQmuzdt4lk0m30hi8GEtd
         HzQ4ua4qLVBhcEW7GeEPzC9FpxejKH3S0XZoy7jmeXj1ojhco6T21MRhSwEYgJVBUPAc
         GRMfJHksZ8iLxPl6rjazySXyaT1D2tFuJfwvXrIp/mCmAdg5NysuZJ1ySuPMEPD8RpaI
         PtqB7VZqTkxr/itxqRxVQKmmA4i9PlJl/qsxVsCVTez5xTHKF9yfnVSsl9vc2pYXj6dg
         gLLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=google.com; s=arc-20260327;
        h=cc:to:subject:message-id:date:from:mime-version:dkim-signature;
        bh=2wsrM4rfWmZ2YkyAaS9ur4eVUQUqD0HI+yn9LbwtrMI=;
        fh=FwkHGIbI3AimFu1GWd3CX/7BChpOZE9oZLRB5LmZpa4=;
        b=lqqRtFZWat3DTnOIqxmWv8Y3DtiwHm3r2vuFW9hX+BS9x02K6f0m9VpOWBDsCZl3of
         HPEwQ602wtLPCL8n7iXblcmhZYW65my9AKvWAXUYU5YeJfRqHZVNcgyTEtBoOTAQmi5S
         oSEhCvEtwp5SLfr2lKWApqsG+Gai1Br1GWcZ6pAcHCTCiGhOF1MzXFrT1sK4HFiRsg0k
         +0wsmYWkHuCMUrMoGQZib1RWrYfaSIJvQ5Nxk8iRmDi0U5AWbAG/vCajc5lVUTun/gb2
         +mPuuIoCqPSQutYUT8O2wo3HytkcojmHJ/Ed/w7aQVl62HE+FqEEXVat2g1z7TmtfPL3
         Wkxg==;
        darn=vger.kernel.org
ARC-Authentication-Results: i=1; mx.google.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790286705; x=1790891505; darn=vger.kernel.org;
        h=content-type:cc:to:subject:message-id:date:from:mime-version:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=2wsrM4rfWmZ2YkyAaS9ur4eVUQUqD0HI+yn9LbwtrMI=;
        b=m0Ib9wJVOpgOXhNz+/LWE73H9/n9f32eS3bTHMzTlICqb13RX7e3pT9/W8BtTNtrBD
         XysOwGhuQXdUSyHcsO+ZC6Pi9ZFyMgQpY+ZstwoWn9qdo5P8/8JPMM4cZ5RKpI6cR+vc
         gdJjMaEtfXcSTTsxE/eAe9DE/sG7I32kNX5dm/OzaDJwpIFKeTF5wgiLoKzZeH7MqsU+
         8L9r8ckypusVwRgzHtUJV042Cb+ysoFg//jxypA2n845fhOQj+Q7fGjb2c4Sqk+EJRqf
         hPauHJJxSWCQECGCLmGk2nMv7OAX9AFJUIXV5a7m8xJrkWt9cMePzCmRh4Ja5OAXFtbj
         ij9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790286705; x=1790891505;
        h=content-type:cc:to:subject:message-id:date:from:mime-version
         :x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=2wsrM4rfWmZ2YkyAaS9ur4eVUQUqD0HI+yn9LbwtrMI=;
        b=qRHxd6sgjd+uyT0aJA6QbAtGA8/6jT8r4ta/fQAe2Vd+QuzZu8ENZgQrNV6UfsviSo
         sAeGiXhmhHlkp+KJZQebNwSgXhF4YtuRsnZHCjx1kVcmsiim6yGH/yGq1s7ZiEOOcbw6
         NO8en2FU0rPt2CzGcP9X76dyD4sxVJFsnYYdC8q9K9qh3fvnnAjFmoqXYY93qNDynjgj
         pyuouKY11YIsur71LUSXbe3tr/vUAcGQhpi7W6y7lQRsXaY7esF9Rgm7/mPTMWkEuTo9
         0J69BgZt1HGlYwLc5/yoKmiAD5N9C/QY4td+WSgZBIgwG75C5yADn5eUXAcVYMzKBgTH
         TFYg==
X-Forwarded-Encrypted: i=1; AKwUvBxoUCDfWXgo46gb66ms2Y8U78xZlWu86435IRmirjii+i077OSvEB2uAgVobuwp2faYLxrnvoI=@vger.kernel.org
X-Gm-Message-State: AFuF++n38toBTynj3CaHuztI5RosAeclwebsZdZjlheFenMBUGvD3jaH
	HYU/7gmjL4+APkTlVUh0Le3PKSKMhKxTKrtHcE2AKYmzZT35pYlsDI75FhbHHoM0fb6+jBI1+dP
	Gru2cQoD0b2KBY5eryxB18lpT9Vxgog==
X-Gm-Gg: AYBFou3QFyri+5otq1FTJXldVsRqDOShZR05O+ZpFtJ2z+rF5e8gFet7X4SSlYb2Iub
	tPHmMxZunKmiFqVsaGnjXow/EQMCc/n8POr2bBIhsbc62B5l4c+25oSThrCcJ+xYoCxaVzrPQNA
	JrCuDSTPLAMBXNA55WUtNdnIgGRdknFNfvDGeBKEZ0in37Sg312t/8+M3mVe6hp+K+mp9QTvG7A
	QePrKc4nkjiPYzdTMV0DxntmtVwx5MDgdFH2nfuHxqlcTJCDbWH88cwclDlnPVMHRDSzteF+MZt
	6B+E4o2C+W77/2ct1V4ICAi0mGteimLAk90qC3VB0xyk06fUYnIVfOTq5PhxD9S8FTDbBas6rqr
	fPiXZA7/OJhXZ06xm7uy+ETVM3f0UZ/OeF23ctbnjoeIUDj6/nETuFME7ERjnDaAQ
X-Received: by 2002:a17:907:868c:b0:c29:4490:50c8 with SMTP id
 a640c23a62f3a-c2ac20ab6f6mr335227266b.8.1790286705286; Thu, 24 Sep 2026
 14:51:45 -0700 (PDT)
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 21:51:44 +0000
Received: from 77377267392 named unknown by gmailapi.google.com with HTTPREST;
 Thu, 24 Sep 2026 21:51:44 +0000
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
From: mhun512@gmail.com
Date: Thu, 24 Sep 2026 21:51:44 +0000
X-Gm-Features: AclHuK9j7u3HNrpkxbPfkJEXXgXPzlWkFF26AnQbZD5u6GM81J290RQpiIihOgA
Message-ID: <CAGEsz8Gwh=Y31EuTJLUp_jq3HhiizHxt7_ivOuytyZZH06mycA@mail.gmail.com>
Subject: [PATCH v3] usbip: vudc: Prevent transfer timer rearm during teardown
To: valentina.manea.m@gmail.com, shuah@kernel.org, skhan@linuxfoundation.org, 
	i@zenithal.me, gregkh@linuxfoundation.org
Cc: ae878000@gmail.com, michael.bommarito@gmail.com, linux-usb@vger.kernel.org, 
	linux-kernel@vger.kernel.org, stable@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"

Commit d96209626a29 ("usbip: vudc: Fix use after free bug in
vudc_remove due to race condition") deletes the timer before
usb_del_gadget_udc() stops the receive thread.  v_kick_timer() can rearm
it even in VUDC_TR_STOPPED, leaving v_timer() to use freed vudc.

Use timer_shutdown_sync() to reject later rearms.  Replace the
inaccurate blanket lock comment with __must_hold(&udc->lock) on
v_start_timer() and v_kick_timer(); v_init_timer() and v_stop_timer() run
unlocked.

A KASAN/DEBUG_OBJECTS_TIMERS x86_64 QEMU harness binds g_zero to
usbip-vudc.0, sends CMD_SUBMIT to usbip_sockfd via a socketpair, and
repeatedly unbinds/rebinds vudc.  The unpatched kernel reported a
free-active timer and a use-after-free in v_timer(); the patched kernel
ran 4000 iterations without either report.  No physical device or
remote client was tested.

Fixes: d96209626a29 ("usbip: vudc: Fix use after free bug in
vudc_remove due to race condition")
Link: https://lore.kernel.org/all/20230316180940.1601515-1-zyytlz.wz@163.com/
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v3:
- Describe the harness, test scope and lock annotations (Shuah Khan).

Changes in v2:
- Drop the lock-held comment and mark v_start_timer() and
  v_kick_timer() with __must_hold(&udc->lock), on the prototypes and
  the definitions (Greg Kroah-Hartman).

 drivers/usb/usbip/vudc.h          | 6 ++++--
 drivers/usb/usbip/vudc_transfer.c | 8 +++-----
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/usb/usbip/vudc.h b/drivers/usb/usbip/vudc.h
index 5ef0e7d9b23a..c129f4c56e8a 100644
--- a/drivers/usb/usbip/vudc.h
+++ b/drivers/usb/usbip/vudc.h
@@ -157,8 +157,10 @@ int v_rx_loop(void *data);
 /* vudc_transfer.c */

 void v_init_timer(struct vudc *udc);
-void v_start_timer(struct vudc *udc);
-void v_kick_timer(struct vudc *udc, unsigned long time);
+void v_start_timer(struct vudc *udc)
+	__must_hold(&udc->lock);
+void v_kick_timer(struct vudc *udc, unsigned long time)
+	__must_hold(&udc->lock);
 void v_stop_timer(struct vudc *udc);

 /* vudc_dev.c */
diff --git a/drivers/usb/usbip/vudc_transfer.c
b/drivers/usb/usbip/vudc_transfer.c
index d4ce85c4c6a2..ba625622975e 100644
--- a/drivers/usb/usbip/vudc_transfer.c
+++ b/drivers/usb/usbip/vudc_transfer.c
@@ -441,8 +441,6 @@ static void v_timer(struct timer_list *t)
 	spin_unlock_irqrestore(&udc->lock, flags);
 }

-/* All timer functions are run with udc->lock held */
-
 void v_init_timer(struct vudc *udc)
 {
 	struct transfer_timer *t = &udc->tr_timer;
@@ -452,6 +450,7 @@ void v_init_timer(struct vudc *udc)
 }

 void v_start_timer(struct vudc *udc)
+	__must_hold(&udc->lock)
 {
 	struct transfer_timer *t = &udc->tr_timer;

@@ -470,6 +469,7 @@ void v_start_timer(struct vudc *udc)
 }

 void v_kick_timer(struct vudc *udc, unsigned long time)
+	__must_hold(&udc->lock)
 {
 	struct transfer_timer *t = &udc->tr_timer;

@@ -490,8 +490,6 @@ void v_stop_timer(struct vudc *udc)
 {
 	struct transfer_timer *t = &udc->tr_timer;

-	/* Delete the timer synchronously before teardown frees udc. */
 	dev_dbg(&udc->pdev->dev, "timer stop");
-	timer_delete_sync(&t->timer);
-	t->state = VUDC_TR_STOPPED;
+	timer_shutdown_sync(&t->timer);
 }

base-commit: 238650ef6c7c7cca08e032527329424c9fbd70e5
-- 
2.53.0
