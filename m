Received: from mail-vs1-f48.google.com (mail-vs1-f48.google.com [209.85.217.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AD363346BE
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 04:25:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.217.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788409515; cv=none; b=bUvOe2BOXtlp+wKbVQr+HbfKMtFK7y0LzTI80057Sv5b5U6qpLmv1DPDtLGpo8HPKOstOJEPWnvnOH/5d14iTsw1EjaxjUxlEyjTKkGAxKx86Zt9ntlEi9WEmdJ+JJDAg1cRPvbQmMltc56/TXwxqbfZ3E3u56eNpcQlPIdRkBs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788409515; c=relaxed/simple;
	bh=ew07gJj3EnVaoQAPvGrzPOrhwHTzfymzVKP5nioSTs4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=HLitC4RjaBmx11hvM/OfYyYoq3GgmobXBcLij7b1SKwxSf1uz6d7bRgtFBBw2wfTRrPgoHVpKzmTloWgikky/gLowISe2eGqcV+2Mrs1vehb8jVcxveooPC/lqkHlwR/6xxsBSlKt6Qlncq8VYPfZLGM9fsW4wqHwTCSQv9JKEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Yv/uhisH; arc=none smtp.client-ip=209.85.217.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Yv/uhisH"
Received: by mail-vs1-f48.google.com with SMTP id ada2fe7eead31-78a220b5778so594199137.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 21:25:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788409509; x=1789014309; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nZE+MOA7ewbEt4KSRlLGrOtyyL1y6EOsD8XVCfrxcmg=;
        b=Yv/uhisHg27qqobK58dFT9yFg3qbFMmn5PUeSrKwA/5MaTAyI+mz9RT4gLjd81PK0Y
         bs0ZhZHeVhVpOJ8trG7LuK4/OiIWqCsrCun0O6o/GPQh2LzfUuw8lgdHntQQzTgOw9OW
         Hu32bn/wKH6nIWlAGptBalTbDTNEyHuNCcTnDj4FeW7yGBtI29NBY8GvAlNZY2BcjcRo
         g3nOdJTvQDP/cwUH27r1qp/PKsm+sPNT8Ni2By5eL29Txuabyj/bv1Punl8ok6boZchV
         nq6uR49p794KHrEJFkE/WG7XYJyrCQXT6J1q5ZP/UQgSL86KlfQTZC0/S8yo0ZJih7Vb
         oVMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788409509; x=1789014309;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=nZE+MOA7ewbEt4KSRlLGrOtyyL1y6EOsD8XVCfrxcmg=;
        b=HcrHaCF3+xwloj5yOTdIiwfhkFmG3yKNV7Fu2Zn9xUC37wBB55CRMeY8EI0gwqrgLp
         8Z8smgpxRzOqCEQyeorYUGv4YQ3xi/1WA08zXyTPceGNG0JuT6+PpuXMfNU2C280z2Wo
         Xu7lp0CAee9leB9JtUO+I1rnLZaIfD9oSixzQHHkQuoIJ+mzjVx6Mgy9OWEt8uFEtmyV
         JcR+uKodMsp60XKP268PZUFrWgdSJ9/3K37nVDNRPuB8YBAR6givxDn3f7OJ77zffBTE
         a0Jjnwbg0VRxnZ0bkD0IzMpS4XHA7QDkSL08jg1sknCkn1ThsGXdPAs9vLpecaxh4Ily
         ApaA==
X-Forwarded-Encrypted: i=1; AKwUvByhL0vPGaDSKoqIUKSnwkE22W1RfK4PLa0QUnz5YyGSYNT3Rnj6Mi08qYBaAILANv65DBgEgas=@vger.kernel.org
X-Gm-Message-State: AFuF++mZUaSA7OVohFDVf2rQKc+ReNhwQrwqnqz0rwyTXCWQuqEFWwfM
	IPIFmcFO0N82P+aZxjMab51Byoqshc2MtWUXR9ASnw0eN/qBCLl/AeXN
X-Gm-Gg: AYBFou3rUzfi6pYyu0fBFj6MsH6gqO+BXAhJMJF+O31V+jhXkfQ7dLXTNbhjhBqbTJ/
	8cyCTG8w2LnSU4bnzaOIiY9loMQAZM6O2wtYPVifvM9mapURCYV6a8S1V+Moc/UAt25dT8g4WGn
	v9K1KtVM7NCYoqZkY6iYD8UqQxaq7HVbQ/HJRrapL0LYRh/wbShHF3198PktPOPXNlou8KSRbrl
	ffz88P1TV2beBh2Cs7QNqF/ZjGZ4AZKNIb//f+Tuc9InuZDLBLD+dXQcRrAZ2kevdverrnnN3Yw
	hjZ5afSfoYf8fTMi1Jx+p5DfjEduxqO1Hpk8tJ0kRNDdsZvt8tcggeNamy5xpXvbcCidMYn2RVD
	cSMQVYsWiH/g01bT5+uEJ0FCOurwBQZMzm6vhQBHLWC00W03+rNRk1TokMdAAvq82t8UQbEwuUl
	9al0QL28EE/KQ0uV+VT3Vl88oaP0jzDUdDuLh9kDQ5Qf+WGUlz+nt8
X-Received: by 2002:a67:e010:0:20b0:782:913b:c2ca with SMTP id ada2fe7eead31-78a2f0798camr775892137.22.1788409509254;
        Wed, 02 Sep 2026 21:25:09 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-78a1a4b1143sm3857241137.7.2026.09.02.21.25.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 21:25:08 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: gregkh@linuxfoundation.org
Cc: johan@kernel.org,
	jirislaby@kernel.org,
	linux-usb@vger.kernel.org,
	linux-serial@vger.kernel.org,
	Adriano Cordova <adrianox@gmail.com>,
	syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2 2/2] tty: fix break race
Date: Thu,  3 Sep 2026 00:24:29 -0400
Message-ID: <20260903042429.130320-3-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260903042429.130320-1-adrianox@gmail.com>
References: <20260903042429.130320-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A timed break (TCSBRK and TCSBRKP) can race against hangup and call
break_ctl() on a tty whose driver data is gone, causing a use-after-free
or NULL-pointer dereference in the driver.

Check the tty hung-up state before each break_ctl() call, including the
unconditional TIOCSBRK/TIOCCBRK paths, so the driver is no longer called
after hangup.

Suggested-by: Johan Hovold <johan@kernel.org>
Reported-by: syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=473d7477c523b41d4046
Tested-by: syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
---
 drivers/tty/tty_io.c | 19 +++++++++++++++----
 1 file changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 48569035da56..272f2839acdb 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2429,6 +2429,7 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
 
 /**
  * send_break - performed time break
+ * @file: file object
  * @tty: device to break on
  * @duration: timeout in mS
  *
@@ -2438,13 +2439,16 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
  * Locking:
  *	@tty->atomic_write_lock serializes
  */
-static int send_break(struct tty_struct *tty, unsigned int duration)
+static int send_break(struct file *file, struct tty_struct *tty, unsigned int duration)
 {
 	int retval;
 
 	if (tty->ops->break_ctl == NULL)
 		return 0;
 
+	if (tty_hung_up_p(file))
+		return -EIO;
+
 	if (tty->driver->flags & TTY_DRIVER_HARDWARE_BREAK)
 		return tty->ops->break_ctl(tty, duration);
 
@@ -2455,7 +2459,10 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
 	retval = tty->ops->break_ctl(tty, -1);
 	if (!retval) {
 		msleep_interruptible(duration);
-		retval = tty->ops->break_ctl(tty, 0);
+		if (tty_hung_up_p(file))
+			retval = -EIO;
+		else
+			retval = tty->ops->break_ctl(tty, 0);
 	} else if (retval == -EOPNOTSUPP) {
 		/* some drivers can tell only dynamically */
 		retval = 0;
@@ -2714,10 +2721,14 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 	 * Break handling
 	 */
 	case TIOCSBRK:	/* Turn break on, unconditionally */
+		if (tty_hung_up_p(file))
+			return -EIO;
 		if (tty->ops->break_ctl)
 			return tty->ops->break_ctl(tty, -1);
 		return 0;
 	case TIOCCBRK:	/* Turn break off, unconditionally */
+		if (tty_hung_up_p(file))
+			return -EIO;
 		if (tty->ops->break_ctl)
 			return tty->ops->break_ctl(tty, 0);
 		return 0;
@@ -2727,10 +2738,10 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
 		 * This is used by the tcdrain() termios function.
 		 */
 		if (!arg)
-			return send_break(tty, 250);
+			return send_break(file, tty, 250);
 		return 0;
 	case TCSBRKP:	/* support for POSIX tcsendbreak() */
-		return send_break(tty, arg ? arg*100 : 250);
+		return send_break(file, tty, arg ? arg * 100 : 250);
 
 	case TIOCMGET:
 		return tty_tiocmget(tty, p);
-- 
2.51.0

