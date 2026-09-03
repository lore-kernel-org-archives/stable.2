Received: from mail-vk1-f178.google.com (mail-vk1-f178.google.com [209.85.221.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15AE734BA5B
	for <stable@vger.kernel.org>; Thu,  3 Sep 2026 02:25:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788402319; cv=none; b=tBh91yJMy901gfKDzOcBNR4TZPM01de6LP0QylmH9qhXECcuVWlAChgKn2gGutcZPaSnE60j4AIAoyoJXBESNoKiqQffYANzNmO32NSaLsTpNKdZpRPvLO6HwokU9jJrH+lYdtOKmY5YrF0bhlCW0pTLczZ9l5MVAs7d1arnK0Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788402319; c=relaxed/simple;
	bh=w475PZnYT+qupaUsHdWVwt4QmtvGzvXXtzpIUFIoKJY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j34mbPoQD9Sg4UGAosQfHw837wn3Kmu2x+dztz81eede/2Ed7JYcbJrGGnvSyr5+cHmLPMGdWcQBlS6MiLA2tllIDGBLI/7zXR/1qNTK7Itni/GBVShezE3aYhNwflrvzeU+zmm0MIZg9lXmK6eTKZfOZGnRODTpscXfT5dVKKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ZdtsMDgT; arc=none smtp.client-ip=209.85.221.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ZdtsMDgT"
Received: by mail-vk1-f178.google.com with SMTP id 71dfb90a1353d-5c7afda4515so1096905e0c.1
        for <stable@vger.kernel.org>; Wed, 02 Sep 2026 19:25:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1788402314; x=1789007114; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=5kP68FnfQ9oonErKnDDNgWKAERDEINqUIV7Ynk7gm7s=;
        b=ZdtsMDgTjifCogjqz4JFJzb1YU0X0CjWOLMHK6VDuVwaXpg7Ky649riiCuFCiGjnJe
         GG3clLURUOkf9hyGmrHAnhS+HMg8HdHYBFBCW4WRytHT3zYggkdV+a9QwIAsu7iRXG+n
         7pwC8GT7WTPCgUlz2n244PFhPvQAla59vKHrCNV34BmMuEptT8Tf7RMnNglaGc7Cb3YB
         iavzBLsrYri/8jP4suzrR98wZ+Y2yiFvRtbpcur35MCterAGzUSYzqmvz6QHQh8+Vcv1
         e6cCzmTm7dReN3NpOvzJ++b8rmLAQ0m8hbysF5AQCc7J5hAUVLPLwU2W1HuwwGX6CcIz
         qPXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1788402314; x=1789007114;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=5kP68FnfQ9oonErKnDDNgWKAERDEINqUIV7Ynk7gm7s=;
        b=HcRLQAdYN6feXlJIo5jiTHo7wUtdXnyupKcWB+2BBDzsLp8iilgfpppdRmk3asPTbP
         if405ygej9GuOTLKnP1MREzDYX1lcysvaeFPoAoCU+fTfxx8pX2t4Xf2Pwr3RV28hCh8
         dcmG2vFH3gmagUeZgQsSZJJh/46B6B2zjkFeFMEbcquvg+UDG9EtRrgMNv9dlk6KAsrG
         WaHLch653iX+U8vHTwyaihnziHX5o3vsTt44l6t2K+SKU5DzAHi+eyEzXIcRCHCUUtGF
         qCN7X69Jmzix1RAcI/Z8krXsQROk0ZqvdKo7tM+iNt7hrmt3CClVbPw5eIcRg9pGeLuZ
         +K1w==
X-Forwarded-Encrypted: i=1; AKwUvByq1j+dyxdJBRW/Hy1iRY7lbWZhuQSaxAawB8Edc+zp8cpEIuPZfiTexnD46ZbdUj/6i4ESFSQ=@vger.kernel.org
X-Gm-Message-State: AFuF++kZ9nxZP4l24ruAA7wTKMFKqJFTvVeuI37F8kg54VhpUof+zlGd
	7qrjVvvbUWYqFnsKC9lWts91GEiSpMEIrknkZg092q04A5soaM90xhHFmzCjtbMxrvI=
X-Gm-Gg: AYBFou1ZqFTFlnjlcm7AXN6aXNrbRoX1pTocRRpXe5rCIXoFZ4+dGIqyRo+bVN7ljLm
	FUP/cdRJMS/cCTY4xesh+VCcOLUv9JOFoddliBhr7El+olKL2bvvL9NkYKYGOAvjnkxrAWYvuMa
	b4BCHKi6KQ+adnYUWM7X2nOhgStLaM8+7GizuUZWBwEvZKPvyWqmI8kqHdmREzgB5MqcpcIkIar
	b3BkkomSuJNEdQ9toQxRJYbOPRKMn93E/obuXHqlgg2vfu4wGGhrzmUhxIl3j1On2p58LULCE4B
	xxn0Zz+RH1jmIEB1rB4+7xFHQBViJYR3pvH/wViLOABXPxobaKyMC/Y0qGng+IobohM1RclCoUG
	EdcmXa7To7ctAb1yqQn2ECUjk1N4wdjbN5TXRg+LhGUG2m+6x0v8wJ7+GBr3nu4pQSnWb8cMPvY
	juGkmkxfSwkd4Yf4aywPjXyZ/oS7BbN0jJGxrPIlCYnTzh/Z4CPIH0++XkgpfN3X+C
X-Received: by 2002:a05:6102:4495:b0:785:eb33:8794 with SMTP id ada2fe7eead31-78a1f352f3bmr3283329137.10.1788402313992;
        Wed, 02 Sep 2026 19:25:13 -0700 (PDT)
Received: from adriano ([190.215.95.120])
        by smtp.gmail.com with ESMTPSA id a1e0cc1a2514c-980672f5277sm3602631241.6.2026.09.02.19.25.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Sep 2026 19:25:13 -0700 (PDT)
From: Adriano Cordova <adrianox@gmail.com>
To: adrianox@gmail.com
Cc: Johan Hovold <johan@kernel.org>,
	syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] tty: fix break race
Date: Wed,  2 Sep 2026 22:24:45 -0400
Message-ID: <20260903022452.111316-2-adrianox@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260903022452.111316-1-adrianox@gmail.com>
References: <20260903022452.111316-1-adrianox@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A timed break (TCSBRK and TCSBRKP) can race against hangup and end up
calling into a tty driver after the underlying device has been removed,
for example when a USB serial device is disconnected while a break is in
progress. This can result in a use-after-free or NULL-pointer dereference
in the driver when the second break_ctl() call is made after the sleep,
as reported for the keyspan USB serial driver.

Make send_break() wait only for the break duration and then check the
hung-up state of the tty before invoking the driver a second time. Since
the tty is marked hung up (f_op == &hung_up_tty_fops) before the device is
torn down, the second break_ctl() is no longer issued after a hangup and
the driver is not called for a device that is gone.

Suggested-by: Johan Hovold <johan@kernel.org>
Reported-by: syzbot+473d7477c523b41d4046@syzkaller.appspotmail.com
Link: https://syzkaller.appspot.com/bug?extid=473d7477c523b41d4046
Assisted-by: opencode:deepseek-v4-flash
Cc: stable@vger.kernel.org
Signed-off-by: Adriano Cordova <adrianox@gmail.com>
#syz test
---
 drivers/tty/tty_io.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/tty/tty_io.c b/drivers/tty/tty_io.c
index 48569035da56..c9d8a138b84c 100644
--- a/drivers/tty/tty_io.c
+++ b/drivers/tty/tty_io.c
@@ -2429,6 +2429,7 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
 
 /**
  * send_break - performed time break
+ * @file: file object
  * @tty: device to break on
  * @duration: timeout in mS
  *
@@ -2438,7 +2439,7 @@ static int tiocgetd(struct tty_struct *tty, int __user *p)
  * Locking:
  *	@tty->atomic_write_lock serializes
  */
-static int send_break(struct tty_struct *tty, unsigned int duration)
+static int send_break(struct file *file, struct tty_struct *tty, unsigned int duration)
 {
 	int retval;
 
@@ -2455,7 +2456,10 @@ static int send_break(struct tty_struct *tty, unsigned int duration)
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
@@ -2727,10 +2731,10 @@ long tty_ioctl(struct file *file, unsigned int cmd, unsigned long arg)
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

