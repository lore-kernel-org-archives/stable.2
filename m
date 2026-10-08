Received: from mail-ua1-f52.google.com (mail-ua1-f52.google.com [209.85.222.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2D8143C045
	for <stable@vger.kernel.org>; Thu,  8 Oct 2026 20:54:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791492882; cv=none; b=jkb/3kv19T+XxNPFlJvdt54m5obylak22VNinj/AWdCHlIjNeU2Wgj6DLAk/aLtswMBPlr4i9OsxtxKO6h4PJmed7MuSmkxz8bGG27MgnKOLx4LDBqCmr7Z9P3J8xnA4H5bG6HyNKR4prTXg2ZRXSmaUn/01zZfkER/XeAUxFRE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791492882; c=relaxed/simple;
	bh=Ja/n8vnyXKQ4zDXeNyS8eJjsWsS+vVM2lTFns7Ob23M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=IAHT/KHuKPdc7CURMlC8SvsdNUCK12koBVnhasqp2wkExZUk2Z2gjQ06uUOEpKp6iy1KzevApy0JjKtL98KqtEy0IppAV/FTmeGDXlkEyoO9AEkb6aXcFazon5Fxn59PzrWh1elstHWMVW+lqymmsw35PWB0csM3RDYjo1/UWUM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GqPOK7NZ; arc=none smtp.client-ip=209.85.222.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GqPOK7NZ"
Received: by mail-ua1-f52.google.com with SMTP id a1e0cc1a2514c-988d3ad6432so28815241.0
        for <stable@vger.kernel.org>; Thu, 08 Oct 2026 13:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791492873; x=1792097673; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=TUgbiGOrc5TwQa04SOQbqot27foFidgkJz8QzlDVcY8=;
        b=GqPOK7NZfDvGtiQ1p2ZMHU3T7JmqcIq+UelzCkclihcVg1lm4ibq0zKi0odJNili9V
         /GQjYM+iSMMv7R548mNHCV/ztb4Tjg4vMsHMzoKsuhErkn0f6zkscOjLXLSk6N5PQ6mF
         4xMCYFmIKEMmxdB/v8Lm+9+17TY1nlxIiBa6SgvCuGxBiHwWJUPOx2e3b8nCWjkWy9Vg
         4iRStHdx1/px453xNhdg/Z49f8ybdpeIDnc4U2wH42GCIEocx9wgETX4wghxc2/UOjlL
         WBntdRYPBGjUUNmm3RiY28rR1JM4FXtPds8c1kQ05JQtLV/DvlVyn3lMv0fJ1FWTvrDK
         /b8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791492873; x=1792097673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=TUgbiGOrc5TwQa04SOQbqot27foFidgkJz8QzlDVcY8=;
        b=vlPlEd88++jwKD92sOk0CWneQ/zEp9ejz4gzs7rDOI4T24oacdmXZDaPBf6lz2xS4m
         RUHfafc+G9pRZf8WgsDsVp7cYLeaqKs5Kpw5p/KlPALp5ROLtGzSQgZDaeCLQy8+RpLh
         W/M9lCb4JOws/YAQjXUVjkiwnbuWghqGmQp4u4VbcynnVNcvj+4dt7Hdl7YSuBHsuT4L
         gsY5K4J9pceZIHIK4T/rdx1jVHe0QiKBNRSs4BVSH0l8CZNzbt1Z00wyzVwqBVvDS8mh
         Xzw7D8awTsZmIvu0sBaUuIS76KCMtpWhXWOnFkuZ2pbgiM3Sme1qNqRaAxWBTrA8mRKA
         YJWA==
X-Forwarded-Encrypted: i=1; AKwUvBwhwrvIvIT+B6JnFhMqvlYM401ScxCmwqy6AvQo5iByyryBZhZM03nTa1KejlWVQC4hqBolswc=@vger.kernel.org
X-Gm-Message-State: AFq9FYJpV3sy6TnGPen41qtkGzoJyISzme130V1fgtTAkZMEtsQh3n2z
	yUXhwb1hUJbVDfwbp7TT4bDvXAxbalJx4K6PYIq3+anPJRqXPn7Yw49WnzTw99ow
X-Gm-Gg: AYBFou1MGUDLAur0qxFEQNCfK4nCNiqO5HmDkiFYVjs4m2euzZjB66WtjwiTNuS0Qhc
	NyF3Ecm2oVLqyA2Ub3il4C0mGLWybZP+q/eovR09RjbbJiqWenfsAQxYS/HOd17FcVeCz/Xsq3p
	PRVd1AIq6HRz2HI0Bi/b7LDwFSB2pdi9M7CkKVbMsMKXfrX7IK6zc5bL6FL8XT2RjUK5yQlaVph
	Se6KrW1B9qNvSR+4HkQx2fYYLUw5vk61amoKJpoGWb1wry1jpjs+vFh7Yuc9nx3kLP06+uYQAdJ
	Zo535eVPt/NFxrbWRnf0mpSqe5MkHk6Lsh72syKS2aPF8K16i2oxYxYPDPuWlcUeCgqdTX+CY1j
	u1hpHcD6+dPx749gZRpc98vDOwmvakXGvKQA+jrd2+d5ATkqOrplSAn2KEObU/WUlXsQMJu05gR
	KSwBf0QVaDGF7cj+4Uoqrg2XvuJTIkxrOvc61NdATVJUFktWbVecZDNfHaP7u4eCxpdkR5Ph6Hh
	ctiWgBfJBAQdbtc5+y6liNlFTBGuhIZ7Qq/QnuQwTISJbI7nS//abV8/NMQudx/7CqfyD80tUt3
	dzZmvCIR8tSLyb+EBnY=
X-Received: by 2002:a05:6102:5cca:b0:7c3:99a3:314e with SMTP id ada2fe7eead31-7cb361df77amr41886137.0.1791492873129;
        Thu, 08 Oct 2026 13:54:33 -0700 (PDT)
Received: from localhost.localdomain ([132.170.205.109])
        by smtp.gmail.com with ESMTPSA id ada2fe7eead31-7cb35394b27sm124191137.5.2026.10.08.13.54.32
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Thu, 08 Oct 2026 13:54:32 -0700 (PDT)
From: Sanan Hasanov <sanan.hasanou@gmail.com>
To: Marius Zachmann <mail@mariuszachmann.de>,
	Guenter Roeck <linux@roeck-us.net>
Cc: Sanan Hasanov <sanan.hasanov@ucf.edu>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Aleksa Savic <savicaleksa83@gmail.com>,
	syzbot+0f98b0c0bdeaab2dc2fd@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (corsair-cpro) Make wait_input_report_lock IRQ safe
Date: Thu,  8 Oct 2026 16:52:45 -0400
Message-ID: <20261008205310.30832-1-sanan.hasanou@gmail.com>
X-Mailer: git-send-email 2.48.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Sanan Hasanov <sanan.hasanov@ucf.edu>

ccp_raw_event() is the HID ->raw_event() callback and takes
wait_input_report_lock with a plain spin_lock(). This callback can run
in very different contexts depending on the transport: from process
context (e.g. uhid, via a write() to /dev/uhid) with softirqs and
interrupts enabled, and from URB completion, which is softirq context
for HCDs using HCD_BH and hard interrupt context for HCDs that do not
(e.g. OHCI, UHCI).

Taking the lock from process context with softirqs enabled while the
same lock is also taken from softirq context can deadlock if the
softirq interrupts the lock holder on the same CPU. Lockdep reports:

  WARNING: inconsistent lock state
  inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
  ...
   spin_lock include/linux/spinlock.h:347 [inline]
   ccp_raw_event+0x51/0x110 drivers/hwmon/corsair-cpro.c:161
   __hid_input_report+0x41c/0x580 drivers/hid/hid-core.c:2175
   hid_irq_in+0x492/0x710 drivers/hid/usbhid/hid-core.c:287
   __usb_hcd_giveback_urb+0x378/0x540 drivers/usb/core/hcd.c:1657
   dummy_timer+0xa91/0x4cc0 drivers/usb/gadget/udc/dummy_hcd.c:2023

For the same reason, the spin_lock_bh() in send_usb_cmd() is not
sufficient when ccp_raw_event() is called from hard interrupt context.

Use spin_lock_irqsave() in ccp_raw_event(), since it may be called with
interrupts already disabled, and spin_lock_irq() in send_usb_cmd(),
which always runs in process context.

Fixes: d02abd57e794 ("hwmon: (corsair-cpro) Protect ccp->wait_input_report with a spinlock")
Reported-by: syzbot+0f98b0c0bdeaab2dc2fd@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=0f98b0c0bdeaab2dc2fd
Cc: stable@vger.kernel.org
Signed-off-by: Sanan Hasanov <sanan.hasanov@ucf.edu>
---
 drivers/hwmon/corsair-cpro.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/hwmon/corsair-cpro.c b/drivers/hwmon/corsair-cpro.c
index c09645152..e6d31d367 100644
--- a/drivers/hwmon/corsair-cpro.c
+++ b/drivers/hwmon/corsair-cpro.c
@@ -135,9 +135,9 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2,
 	 * the raw event parsing and marked the ccp->wait_input_report
 	 * completion as done.
 	 */
-	spin_lock_bh(&ccp->wait_input_report_lock);
+	spin_lock_irq(&ccp->wait_input_report_lock);
 	reinit_completion(&ccp->wait_input_report);
-	spin_unlock_bh(&ccp->wait_input_report_lock);
+	spin_unlock_irq(&ccp->wait_input_report_lock);
 
 	ret = hid_hw_output_report(ccp->hdev, ccp->cmd_buffer, OUT_BUFFER_SIZE);
 	if (ret < 0)
@@ -156,15 +156,16 @@ static int send_usb_cmd(struct ccp_device *ccp, u8 command, u8 byte1, u8 byte2,
 static int ccp_raw_event(struct hid_device *hdev, struct hid_report *report, u8 *data, int size)
 {
 	struct ccp_device *ccp = hid_get_drvdata(hdev);
+	unsigned long flags;
 
 	/* only copy buffer when requested */
-	spin_lock(&ccp->wait_input_report_lock);
+	spin_lock_irqsave(&ccp->wait_input_report_lock, flags);
 	if (!completion_done(&ccp->wait_input_report)) {
 		memcpy(ccp->buffer, data, min(IN_BUFFER_SIZE, size));
 		ccp->buffer_recv_size = size;
 		complete_all(&ccp->wait_input_report);
 	}
-	spin_unlock(&ccp->wait_input_report_lock);
+	spin_unlock_irqrestore(&ccp->wait_input_report_lock, flags);
 
 	return 0;
 }

base-commit: 6c377d19d4a5116d9bec5203aa3c6c11523e7898
-- 
2.48.1

