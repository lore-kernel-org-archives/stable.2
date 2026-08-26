Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF9B23C503
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 08:46:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787734023; cv=none; b=T50MwrBGGLjhjtJynDBgynR0UptV188RdedwOCpey9ridPMrAGtCfXDqJ9qOp8s96yDG7ZS+XSIqMvaInKNd5pxCj3cPbJT9R0OHyMKPOAhpBvoRLVrYF1E32eVYxnsAgn/+ul8DwVdd8CuRXgOXUrWl6QxPV+GD37a219JyNw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787734023; c=relaxed/simple;
	bh=VpWuCzeY6a+pKShl7Gzzs0onv2J20gxfYzmfMWr2ddc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=aNw+WNBKFEVU+E1nqSdsOFJXzNFoXJZ4xy5r9pAyIhidQoXyzoTSXYIplahHLN/YkPiMy4ykHhX6QpfpyugdXmlyqk1BpqNbZWIwJuNif2ytFSwfMwe8u6koBwsCTvbm/oimHAiJ6Tg1TU7nRJX7y6oe/Zc2GTzXDqTpoerXGuc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Y3E8YmC3; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Y3E8YmC3"
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-c20e70a0962so95028166b.2
        for <stable@vger.kernel.org>; Wed, 26 Aug 2026 01:46:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787734017; x=1788338817; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=VpHKJln0hytlvoXeZalPHW8VStAHN6NxRb9rKVsmoIs=;
        b=Y3E8YmC3yeIqeSKJ4GpmP0Bw13mzYIp+NEFWpNMVpxj9PbXTfn1Pacf3scK0Mv+4yo
         AVff5FQov6l+o6P5yHrtiCrztQl3MzLj46P6G+B2oLedlHsOm5vfRgKsM5ci8+AG2N3C
         ugRdjzyTMGIeR8mbYoSSIoBo7OoqfLAdtGcNrsJUzrMdLw1HExYKEOGN8h+EHe7uRf5L
         DDCgLTjsNdzNvsheN6vElOS8Ic9YCcyb0GKqHgNO7H/DkZkoSpcHvcJUplWRZN5l8cmr
         D6/wwNv+9/bZ8eYLkIkOAA8nsfQEEOAVLIUxdrnXR+oWdt0LbrmuiUig67w310LveJLi
         qlog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787734017; x=1788338817;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=VpHKJln0hytlvoXeZalPHW8VStAHN6NxRb9rKVsmoIs=;
        b=Nq7p3WVOtIu2scu6j9qFZ1JrgJax+Qz7pIeIpWC+Ap0Aw6U09ZbhNwdjv51egAd3do
         hF/Vq3qgPoQZf68LUirVOPPdt5P/wA9+CUbMG9KJANCySAyOvdmBasC2VBMvVEgoqF7p
         9FBLuZceSwDcNx1FBbPlY+R6yhk8MU5T4n3A4+ncfaRvoM+fH2r4pllhCIAEOJBDwvIQ
         holg3VRby/8THi1Ebc3G/7JclfR8nwrAgXNOMXiPo+AjpvYsyn4071Va7gF8hJgjDCBA
         N6mQbl+eB00nfk6REWfL9Uz3rscYDag4sjVG95leZan1CC1mp6r8IqDyBKjI4InjEQgZ
         wp2w==
X-Forwarded-Encrypted: i=1; AHgh+RoaMqWS80rJqQzd6IZWbkp4+4EU1c0NsEJpuZVN2yOVhNNkjz3LRbYZNYJBUs/49/zIZuI9Dm4=@vger.kernel.org
X-Gm-Message-State: AFuF++noVRSjv5Zjs9wVo2/Q7u5uOZi1WM6PJKZ9BjftzZ+srKYMpSaQ
	gqWN1HliEwJ3UQhQtfAZK2P4lh/KAjSpcefM+ZVrbpQcAHClT6fwOe2c
X-Gm-Gg: AR+sD10qkV3/2qo7Fjmt8M7KUiANY8eqP+DvpbohGlcf7RKClAHIzYwA8f5BzgxImNJ
	xUjslTSSGt2ZALmegw61+5JSY2LcB5UU9+CuYsZ7x/Ut1uCUrZAONGPvA4Lz+n0mZw4XjKFW0gg
	9EyyU1ST5xJM32GdWR4gsGJJ5bdXwoBgcSfAw96WFUqanDmRDabOpfD+WJxY2JwKuA4yf2rJACU
	AH/HEoIPD3fvhvfoRp/ukATLuhCkOykSqhEuk6MoDhNr8yvqmqogXuLJUyjLno559DO0NGxGvuJ
	dWUxuXNscJ7s/qclPvcmO1vVYwxawSpkgHU5Sr4m31uxPFXi0YgzxI3dDlQklBAKuQHkOSaZJL+
	6DreDikGRbtZbXhVW+A3MA1wwtP06/Ax273iXnu9FLi8SkxM+tb/TWgewOLfpqMTyAf4uCGkAsE
	A9f0BjQxHcthn5TakHkZXXXDVP02yqYuPqPeDeiq4wKdfzSWx2ZM+ib/V9QhiF0mOKQeA=
X-Received: by 2002:a17:907:c807:b0:c25:4e5:fe33 with SMTP id a640c23a62f3a-c250c352a4amr604914666b.24.1787734017148;
        Wed, 26 Aug 2026 01:46:57 -0700 (PDT)
Received: from x1.tail0e71db.ts.net ([46.140.7.198])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c250a9b28basm281564666b.46.2026.08.26.01.46.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Aug 2026 01:46:56 -0700 (PDT)
From: Ruslan Valiyev <linuxoid@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Tony Lindgren <tony@atomide.com>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	John Ogness <john.ogness@linutronix.de>,
	Lukas Wunner <lukas@wunner.de>,
	Gerhard Engleder <eg@keba.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzkaller-bugs@googlegroups.com,
	Ruslan Valiyev <linuxoid@gmail.com>,
	syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH v2] serial: core: fix NULL pointer dereference in serial_core_unregister_port()
Date: Wed, 26 Aug 2026 10:46:54 +0200
Message-ID: <20260826084654.1392851-1-linuxoid@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

port->port_dev is NULL when no port device is installed: it is cleared
on teardown, and never set if registration failed before
serial_core_port_device_add().  serial_core_unregister_port() passes it
straight to serial_core_get_ctrl_dev(), which dereferences it:

  KASAN: null-ptr-deref in range [0x0000000000000040-0x0000000000000047]
  RIP: serial_core_unregister_port
  Call Trace:
   serial8250_unregister_port
   serial8250_remove
   unbind_store

Return early when there is no port device, and read port->port_dev
under port_mutex.

Also clear port->port_dev on the serial_core_register_port() error
path, where the port device has already been removed.

Fixes: 84a9582fd203 ("serial: core: Start managing serial controllers to enable runtime PM")
Reported-by: syzbot+9f57c1b2792029198fcf@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=9f57c1b2792029198fcf
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-opus-5
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
---
Reproduced on 8d3ae59288f1 with syzbot's config under QEMU/KVM x86_64:
6/6 runs oops on stock, 0/6 patched.  checkpatch clean, no new W=1
warnings.

The reproducer still does not run to completion on a patched kernel.  It
goes on to hit two pre-existing problems in the tty layer that this patch
does not touch: tty_cdev_add() leaves driver->cdevs[index] pointing at a
freed cdev when cdev_add() fails, and tty_unregister_device() deletes that
entry unconditionally when it is NULL.  Mentioning it so the remaining
crashes are not mistaken for this fix failing.

v1: https://lore.kernel.org/all/20260826073237.1377668-1-linuxoid@gmail.com/
v2: trimmed the commit message and backtrace per Andy Shevchenko's
    review, added the Assisted-by tags.
 drivers/tty/serial/serial_core.c | 17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a530ad372b434..5bf71d7bbd223 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3327,6 +3327,7 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 
 err_unregister_port_dev:
 	serial_base_port_device_remove(port->port_dev);
+	port->port_dev = NULL;
 
 err_unregister_ctrl_dev:
 	serial_base_ctrl_device_remove(new_ctrl_dev);
@@ -3341,12 +3342,24 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 void serial_core_unregister_port(struct uart_driver *drv, struct uart_port *port)
 {
 	struct device *phys_dev = port->dev;
-	struct serial_port_device *port_dev = port->port_dev;
-	struct serial_ctrl_device *ctrl_dev = serial_core_get_ctrl_dev(port_dev);
+	struct serial_port_device *port_dev;
+	struct serial_ctrl_device *ctrl_dev;
 	int ctrl_id = port->ctrl_id;
 
 	guard(mutex)(&port_mutex);
 
+	/*
+	 * A NULL port device means there is no registered port device to
+	 * remove: serial_core_remove_one_port() clears port_dev on
+	 * teardown, and it is never set if registration failed before
+	 * serial_core_port_device_add().
+	 */
+	port_dev = port->port_dev;
+	if (!port_dev)
+		return;
+
+	ctrl_dev = serial_core_get_ctrl_dev(port_dev);
+
 	port->flags |= UPF_DEAD;
 
 	serial_core_remove_one_port(drv, port);

base-commit: 8d3ae59288f1e7d58d76558a6ee96d533bc5019f
-- 
2.43.0

