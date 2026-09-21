Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 348E12222C5
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 01:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789954232; cv=none; b=L6OQ2BLTcIcTLTXxb7QjNrfjpv4WnYVeabIhHDcgtm0BreU4ZKAuK68Pbhvf04tldMnQ/g9AfDtf9TklxMOuE8Li79WWFfGKGGJ/K8vX2IBfm6XSkiKkQrfxfaVAI04KRDTdVc7RO9WqpxA9OntQvrn0DlpRhJ/l4F6WM2y3KvQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789954232; c=relaxed/simple;
	bh=zMqxwI6teS3VOwxtRHfk27QXDqIlkmoAVbWh3+kQlfw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T0GYbJGDDNde/T4xujueeeTGeifsl0zragzACfEdxAbyB+TrMYEE0VyBW2o6KkZc29UVM9hq6F1kXjo6MGfa5+Utp4Rf/HDcOOvrZt04vnMbWdAV3+iH2WIB6bttmNt4PZLVZgMRgHlt0YuZ+meNzamstEZyI4Z6l+k6T30irsE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=U1LWZYFV; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="U1LWZYFV"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccda24afso1738223a91.3
        for <stable@vger.kernel.org>; Sun, 20 Sep 2026 18:30:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789954230; x=1790559030; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=NMtNmNFZbNOWkvKNE1WfQyPDfVcq9/Zj2YuH0QaLlH0=;
        b=U1LWZYFVqTrA5NYqkTNSXB4Fq1hKGDfsEPd1v7kHcrzkjEgzKcwMI7SxZT4cmswpKW
         QlfRJSODsO2rk0aXt23F/n+4vGbOtfMLJAAOcdLDn7Xgy6ffhMFd2fDgpFCtQt6LeVOc
         VlRik1cAb+lS0vFF/mqsrhTctVWOvHskX/UEV8PSi+tUbxU5GLdaYM56d2cjUbYSnel/
         XqQDo+rDeZ6z73TF5tpiMkLrgqqSvQZ1KvTnasSZ9hhGYeoK02GSld8R/v5OqMJf3YAA
         pEZJ6/PdPADGG0sAnYkm8TBbr5nP4i+w0gQxfh8ksOV4bSuvKcsq5xzTZwKuXhfmO2P1
         8fhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789954230; x=1790559030;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=NMtNmNFZbNOWkvKNE1WfQyPDfVcq9/Zj2YuH0QaLlH0=;
        b=ctz2ycoEPRGHl0LB2tjUp0whKWRn0yMX2yFxdXtJGHPX8d2l+x9mdfTrJB8+dxgBzF
         v5RrHvIjApQbjkdzNypCKu0VHZFuJIzZee+Tmi9grQOQuPEBhc9DQzitLTHxKCyrRihE
         TIljBir/UqZmD1OeumodBmAQbkUJgckGoWHrt8avDSfj1/Oi+9pXYGNJSirus4TXFgwn
         UOCe/JX5eCPYPVgDIk7oXsQvZFUbAf4KR+RRkrH4ZwWVtSJAlzjZTdEKDFYKRzOPTEM8
         niQ7hp8z0jpjlLg0YQJ8auLjtPFgasC0PKXjYeY9wtO78q3VRUKlDar348TmKqDm6FsP
         RYuw==
X-Forwarded-Encrypted: i=1; AKwUvBzas405/fcNw9p2QJXVXj+8ZpCKEsWG48QSvssqHi8sZUM/PgTXMF5h+gePoMydIGgixEPTIBo=@vger.kernel.org
X-Gm-Message-State: AFuF++n+lfKJ/YcC+53reUvYsXsUitHU6r7j/ctvo+6gkxGmWL7CInxJ
	ii2JY1Dzu3ceD82Ln3zrqtE5IOG3mhrqtAL30qlV9r/RGO8C3uX4L7Fn
X-Gm-Gg: AYBFou1mJcb4cxnxvr/0R8U5IHxb6Y4Z09O1uos8ObiaTKHmJ/Wv8ix9EgAZzNnkIiM
	jum16qilcMmtWfz534nt7epjF7/E0tzBRMvoNIEWn9kiJNnQH9w0ILqLwibs0u5fb18Yqjy0LPt
	LdLCCi0XdmAfk/y1+Vdop4DN+q6yNo87WPGrTVx5xYxfdmnkpBsOLoHLfY/4nD47TqQUV5a/UjQ
	cvMcPdbdWkWDszg1ZZk/ALAjgest9tTO1cXz9fW565btsLgh54d5cD8+Yuyq6L1vfzoJcB4H62o
	uNgfGxCThRwljqMXTWdp8tLWBeQP5lr4sjjkNl0bFlV1X7ym0kWoqUWv9OW5C7GYb+mXXuloTlQ
	pN/eQ42z0ODyxTu2I2kdwyVVRVsXGxhNTwUXottecBoHPxUU/YRBbIj11SYuW0K0qKwGAo6Zwe2
	tBoV9uH5P+tEhg7MJ3BRmqqQIYuGKw+kLNgj+njEoqGsQWSgINLiiDr6FxoGZbyNy/4csO7os0p
	fGUYjfPFDvsh7oUbAUymlXZa9uo7XfErQ6bKheE4O/7Sof8UAL3ywA02duNrA2yyS7RSSAuCLhf
	L0m7fE3ijA==
X-Received: by 2002:a17:90a:ec88:b0:39e:6c68:1554 with SMTP id 98e67ed59e1d1-39e6c6832aemr9835758a91.28.1789954230295;
        Sun, 20 Sep 2026 18:30:30 -0700 (PDT)
Received: from phui-2.c.googlers.com.com (67.51.127.34.bc.googleusercontent.com. [34.127.51.67])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39e6c3145dasm11291460a91.4.2026.09.20.18.30.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 20 Sep 2026 18:30:30 -0700 (PDT)
From: Hui Peng <benquike@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	John Ogness <john.ogness@linutronix.de>
Cc: Hui Peng <benquike@gmail.com>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2 2/3] serial: core: allow third iteration in uart_get_baud_rate() fallback
Date: Mon, 21 Sep 2026 01:30:26 +0000
Message-ID: <20260921013027.659965-2-benquike@gmail.com>
X-Mailer: git-send-email 2.55.0.1082.g2b9226bbc0-goog
In-Reply-To: <20260919222627.3797854-1-benquike@gmail.com>
References: <20260919222627.3797854-1-benquike@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In uart_get_baud_rate(), when the requested baud rate is out of range
(try == 0) and old is non-NULL, the function copies the old termios baud
rate into termios, sets old = NULL, and continues to try == 1. If the
old baud rate is also out of range (for instance, after uport->uartclk
was lowered via TIOCSSERIAL so max = uport->uartclk / 16 is smaller than
both the old and new baud rates), try == 1 clips baud to [min + 1,
max - 1] and encodes it into termios via tty_termios_encode_baud_rate().

However, because the loop bound is for (try = 0; try < 2; try++), the
loop terminates immediately after try == 1 without re-evaluating
baud = tty_termios_baud_rate(termios) for the clipped rate, hitting
WARN_ON(1) and returning 0, which then triggers a fatal divide-by-zero
(Oops: divide error) in uart_get_divisor():

  WARNING: drivers/tty/serial/serial_core.c:548 at uart_get_baud_rate+0x136/0x260, CPU#1: init/1
  ...
  Oops: divide error: 0000 [#1] SMP KASAN PTI
  CPU: 1 UID: 0 PID: 1 Comm: init Tainted: G        W        N  7.3.0-rc3-g5dd1818b15d9 #1 PREEMPT(lazy)
  RIP: 0010:uart_get_divisor+0x5b/0x100
  Call Trace:
   <TASK>
   serial8250_get_divisor+0x123/0x1a0
   serial8250_do_set_termios+0x21e/0x1610
   serial8250_set_termios+0x77/0x90
   uart_change_line_settings+0xf6/0x720
   uart_set_termios+0x1c1/0x5b0
   tty_set_termios+0x5f7/0x920
   set_termios+0x533/0x7d0
   tty_mode_ioctl+0x8e4/0xd10
   n_tty_ioctl_helper+0x3c/0x270
   n_tty_ioctl+0x4e/0x2c0
   tty_ioctl+0x1028/0x1480
   __x64_sys_ioctl+0x184/0x1d0
   do_syscall_64+0xda/0x4b0

Increase the loop limit to try < 3 so that the clipped baud rate encoded
on try == 1 is evaluated and returned on try == 2.

Tested in QEMU against Linux 7.3.0-rc3 by setting /dev/ttyS1 to B115200,
lowering baud_base to 9600 (max = 9600) via TIOCSSERIAL, and calling
tcsetattr() with B57600 (old = B115200), reproducing the WARNING and
Oops: divide error in uart_get_divisor() on the unfixed kernel and
verifying clean execution with 0 warnings/faults with the fix applied.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Fixes: 091ea8e5d34e ("serial: core: prevent division by zero by always returning non-zero baud rate")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Hui Peng <benquike@gmail.com>
---
Changes in v2:
- Split out from the 8250_core.c and uart_set_info() changes into patch
  2/3, add Cc: stable@vger.kernel.org, and include the QEMU reproducer test
  details and kernel stack trace, as requested by Greg Kroah-Hartman.

 drivers/tty/serial/serial_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..128fc056f5c9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -501,7 +501,7 @@ uart_get_baud_rate(struct uart_port *port, struct ktermios *termios,
 		break;
 	}
 
-	for (try = 0; try < 2; try++) {
+	for (try = 0; try < 3; try++) {
 		baud = tty_termios_baud_rate(termios);
 
 		/*
-- 
2.49.0
