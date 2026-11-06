Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=74.125.82.49
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793989088;
	b=16+W1s9kPeSucoXvcV3Y20lfuYWuIhmse7IqjcWBGhozVj5IB3+QHdjNPcwZlLTpxmBo
	 w+HsyklSWNu2lYu8ucTo0VX850Hz1/y/0ZDJz0P1YfS64RGYm1zlNLx/b8EXArIM+R3jW
	 7r1x1BRvsV0XDoOryJAWHH6hgieHveh/NLBG0lda60yxsg058Db8ONwYfEBrmwN/5y1kJ
	 HpfeI3hq3+YsKVi/VddZeijsQUGPw092Tx1FixoO3JGBKUwlQJ1byAC+q3eWQBfAyQ0Hw
	 pNAFXGvvx/uKO740azy1OguP9sVUcJm1gVJDyE4caII5il4IhtAM3zl/8feXWFoaOfw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793989088;
	h=DMARC-Filter:Received:DKIM-Signature:X-Google-DKIM-Signature:
	 X-Forwarded-Encrypted:X-Gm-Message-State:X-Gm-Gg:X-Received:Received:
	 From:To:Cc:Subject:Date:Message-ID:X-Mailer:MIME-Version:
	 Content-Transfer-Encoding;
	bh=L5gQz6r3rvvEATVBUbUn0e05T2fzNXD25Qm7128FeVY=;
	b=sYQQUvNcALRIc92c2AZKCbjUGDdUTdk6dit8oY+GNf1u51om7hU4iIFZ5rrwQQL96zBG
	 rSxVQuzy0S7RmDcvuroNGSfI+pNIxaL+Gb6hdPk91CMTNXeDsXVU2HQdSpaq1FE0oXU9x
	 zADVh8TgsH5kPlyhFHYXC22aHem+6cEea6tnsRhBtrmxjBhHSXq9M6BZTxuboX9vj4bc4
	 XfP0WylUMvTteUpj/+8bjZhJH/of1xFWIlVjiQ4czijRZBJxR2Bw596f+QEd0Q5l5rRXN
	 A6X9QFjbucHDHpnj9G+VQ1t1bz79SAFZIr3Zc6aBTsL7moem8tcBt1xUsGYfSHEMJYg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=gmail.com;
	spf=pass smtp.mailfrom=gmail.com;
	dkim=pass header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D4DGCDh3;
	arc=none smtp.remote-ip=74.125.82.49
Received: from mail-dl1-f49.google.com (mail-dl1-f49.google.com [74.125.82.49])
	(using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 13121606A326
	for <stable@vger.kernel.org>; Fri,  6 Nov 2026 18:18:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 13121606A326
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=D4DGCDh3
Received: by mail-dl1-f49.google.com with SMTP id a92af1059eb24-170135e43c7so1683107c88.0
        for <stable@vger.kernel.org>; Fri, 06 Nov 2026 10:18:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20260707; t=1793989087; x=1794593887; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=L5gQz6r3rvvEATVBUbUn0e05T2fzNXD25Qm7128FeVY=;
        b=D4DGCDh3Dg5GTI6TLXwAMpOyLQNu9wZUp5TAAGiHjoptXmaUP11m0C7t1kZ2mFlIgw
         S9jPDGPA9ULRIwScWWpOLGczaA5N2DcXjRB2u5L668eIYac6T0lZ6y7BMRAE6eLj/E48
         oEzfBIzDVYp+SxrSKU6M+S84CmJxZTUc5n/7+i+yFZ0HlJ0CHwIXpDwNNl+3rFwxPdM9
         xo+YaDnIYsCORDGz+7DEqf/KMuRNfLMPDKnlSwr8xrHD4fvN2q0WPfV4WEaHNEu0/7O+
         ip/bTl/axndXpmk4hAD7jlmdYMAyMylO4XimB45L5rsBodRrGAbxr8u7wCGNiJSeUqvR
         5YmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1793989087; x=1794593887;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=L5gQz6r3rvvEATVBUbUn0e05T2fzNXD25Qm7128FeVY=;
        b=ipZ1bi3R3XKaIQltNJ+oMpQ6eWFP8GK4m4d64NFUlaVyl+0TSwRYz5zfKHX+syaZWR
         L/6d5BksdvYhFMyONfUGQDKAWmPVMyxpJU/LmyIJ9mdMrQqe3bnrmTGEL18KCxl6+gc9
         GcucJyesH74iNOTh0zhFNIM8ZEa9uV7G7R0YTkDoViajZ8L+WflT6yy+FXyj7EL1e4lo
         itAF+Jwrbzce3+3FzjiyPTIpfbInbENsX0QLRWb2ETuUag2FvrgL4DT6x5gFGN0+U4LD
         yvSnEi7K7KH8njMu5q+/58LmITB1qdQKPddSVSN2VfLK1lIioZrqXrqN7ihiZbMuABcH
         6/zQ==
X-Forwarded-Encrypted: i=1; AKwUvBym/3JzpYGQQCFPu1QFo0zlbIOFEiE6vbRmoHfDzaEkkYRiMkmrVn+FYxUEDUXUjPEKakMXXpk=@vger.kernel.org
X-Gm-Message-State: APuU4Z+F/iNY36dvEjuYMln/Q5di4kvGYmfmn2h4FckJdocmGr88YlGi
	uBybo+K75KvCILqxJQ9GlGrbdTiTgpEc4Odqnv6GrxGN/WFPHy6Qg6waQK33KUwF39g=
X-Gm-Gg: AYBFou0lcE0Hv3uQO7RXyiycgEynqYytmgGkgHzYEqJcNgRSclbwv1elWfynzZc9Pwg
	h9Pt4YrqoCFpV8+hRJDCVJlQnA8XWTSTIN2HPzaUMUbGWfMB1v5W+Znsju2ju/A7l4twKZJj5Sk
	C8j08I2pgXnV+fSsscVh+2QkfMcVYmO3M6OfsiVxgRionCAkk9smsquK2+czSOu4s2ewt/Xt/7I
	prdAceofRMNbN5+5sBeymIlwXnqMxUQl8cQXrYEWraqcsPqgSVgrsXY95X6yz3ukKRuKyUeB5PL
	urj2t0d4lOa4P0x+AJkIzne3MHV6qhksRXo5PlrPM1f8dSTuEcg/EIBn38Ui1GNfg0aIHYSwXt9
	oE+K3t4k3VI/hi28uPlVGZohJdYhBlfcgOGYQb4kx8m5Qrsr9f/nMP0tKeYSvSIg4vxC3koyg1V
	rrGx2Qjldw8cKOtO6fwyXiK1wtuhedcTqmWgYy0PYGWm97ekuAELR10V5n568SrA23NsN0fJOAi
	22ssySNOxZWYX/engPfVWZQ6URIlne6D8IRcrLSklmI4O8BUaVVgjli8AnqfvS+vjcSuXl8Pndl
	4bo5sMzFqRZasTz1qgsaHONRdiUvxqBqbI/txu8QbkAQjabwtKa6sxmKkGIPQ/AFIAIWAbXvLWX
	9DWpmy6ho0Il0WDNv5NsCyjl2tASEDPCIp72UtSle+UflB2/jhAWA4dvdHOAgFpdrGsdrS/b3LS
	aOJXVd18RntOCvXPhMHlrKdeuoPcgU
X-Received: by 2002:a05:7023:a8a:b0:1a9:f97a:34d with SMTP id a92af1059eb24-1b25d30593amr5772166c88.13.1793989086878;
        Fri, 06 Nov 2026 10:18:06 -0800 (PST)
Received: from zbook-HP-ZBook-Firefly-14-inch-G8-Mobile-Workstation-PC.. ([49.207.55.157])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-1b25e4880dasm6609066c88.8.2026.11.06.10.18.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Nov 2026 10:18:06 -0800 (PST)
From: Payal Lenka <payalm.lenka@gmail.com>
To: payalm.lenka@gmail.com
Cc: syzbot+f8fb5598924c7e645553@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] HID: corsair: cancel the LED work again after unregistering the LED
Date: Fri,  6 Nov 2026 23:47:52 +0530
Message-ID: <20261106181752.2530369-1-payalm.lenka@gmail.com>
X-Mailer: git-send-email 2.43.0
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

Commit eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering
LED to fix use-after-free") cancels the LED work before calling
led_classdev_unregister(). But unless LED_RETAIN_AT_SHUTDOWN is set,
led_classdev_unregister() turns the LED off, and k90_brightness_set()
then queues the work again. The k90_led holding that work is freed right
after, with the work still queued. The removed flag does not help, as
the worker would read it from the freed memory.

This is caught by debugobjects when a device is disconnected:

  ODEBUG: free active (active state 0) object: 0000000097898442
    object type: work_struct hint: k90_record_led_work+0x0/0x1e0
  WARNING: lib/debugobjects.c:629 at debug_print_object+0x189/0x2a0

Cancel the work a second time after unregistering the LED, in both
k90_cleanup_backlight() and k90_cleanup_macro_functions(). The first
cancel stays, as it keeps a running worker from using led->cdev.dev while
the LED is unregistered.

The root cause analysis and this patch were prepared with the help of the
Claude Opus 5.5 coding assistant.

Fixes: eb51c9f8cb4f ("HID: corsair: cancel worker before unregistering LED to fix use-after-free")
Reported-by: syzbot+f8fb5598924c7e645553@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=f8fb5598924c7e645553
Cc: stable@vger.kernel.org
---
Tested in QEMU (x86_64, KASAN, DEBUG_OBJECTS_WORK and DEBUG_OBJECTS_FREE)
with a C reproducer from the syzbot report, 120 seconds per run:

  no fix:                     warnings for both work items
  this patch:                 no warnings over 124 disconnects
  only the backlight cancel:  warnings for k90_record_led_work
  only the record LED cancel: warnings for k90_backlight_work

The reproducer does not exercise the race fixed by eb51c9f8cb4f, so that
is not tested here; the first cancel is kept for it. Not tested on real
K90 hardware.

 drivers/hid/hid-corsair.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/hid/hid-corsair.c b/drivers/hid/hid-corsair.c
index 278c6efb5..7e5ff3d52 100644
--- a/drivers/hid/hid-corsair.c
+++ b/drivers/hid/hid-corsair.c
@@ -526,6 +526,8 @@ static void k90_cleanup_backlight(struct hid_device *dev)
 		drvdata->backlight->removed = true;
 		cancel_work_sync(&drvdata->backlight->work);
 		led_classdev_unregister(&drvdata->backlight->cdev);
+		/* Unregistering turns the LED off, which queues the work again */
+		cancel_work_sync(&drvdata->backlight->work);
 		kfree(drvdata->backlight->cdev.name);
 		kfree(drvdata->backlight);
 	}
@@ -542,6 +544,8 @@ static void k90_cleanup_macro_functions(struct hid_device *dev)
 		k90->record_led.removed = true;
 		cancel_work_sync(&k90->record_led.work);
 		led_classdev_unregister(&k90->record_led.cdev);
+		/* Unregistering turns the LED off, which queues the work again */
+		cancel_work_sync(&k90->record_led.work);
 		kfree(k90->record_led.cdev.name);
 
 		kfree(k90);
-- 
2.43.0

