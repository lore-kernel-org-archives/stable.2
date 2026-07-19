Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 820D12E282B
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 22:10:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784499042; cv=none; b=Sol6x/oSV/wIfQF22mgjuZ618BUlLuVxiUi1D8xPnOgi5mCcdmWwRT+VDddhId/zpcAQk/LEFpPmYX4vfQQWk+AeF7MmvHQW6mH5yFCSxSe5rWg2bvHq/htavkZzrk6EEkvjhc8bRfSbGO0xmZBhjaPwFDHWkg+wV34VuW04BdU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784499042; c=relaxed/simple;
	bh=1RQ8k9otHSPFMO2zg/Ml6BOTg9wSwQhmSZS4Ik9eJdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=bjT6BskNwoB7/vCCIIQFvTqaWa/bIZwQ/FJFNRmZx8xGe8rXR2v2NqABzeuHA2xfqhAuohajPWyMoBa5OsIPWjIiQj02NeDh2JRCX8jZbTbRwHUPVbHwaoKT7n1Ti8hvCiR+uuJj/Rb+YNuN6hITEFybhxJHjzAT8fCj+gWxOa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GsnXUo3H; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GsnXUo3H"
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-49557167508so9526035e9.1
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 15:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784499038; x=1785103838; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pTekW+ENVi0Z1ogLAr2oe8Uj7dHDNrRZFKBwQW5P7mc=;
        b=GsnXUo3HH62IyRMU0vhv1SDvJlxtrqjHCH7T3PWFbazqfoYfnmJtpsbtQphdhecLD3
         FHrIxmITLvRoJEiYfA2AtK3ujlfJ7+ioi0yYd4CjQOgxFTve9wmgx92w9WLyV6RDVGvA
         jM3FmH0onpMjOgKZiquu58iQV9kxcgUMSjts8VOTFn0rqBp8d8AhGQD4KgFSIb1f2ju0
         ZgdrGdp/jPY3fcPk8z/jVdH8p+qYcSmw8x6D/Ik1kZLFyCE+upq2NT88feSF4JffiCEZ
         bL70K9g/QbFohYekyZGsjkdPn7X01vc3/ecx03eZkBQkDNKWVd90Gx4gu8YmAiFHTofH
         eD9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784499038; x=1785103838;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pTekW+ENVi0Z1ogLAr2oe8Uj7dHDNrRZFKBwQW5P7mc=;
        b=IAvo4vzx6sr/XCxhTg7A8Ld8cSCsMTsBTjKiM2isxCqsih1mgVQG0FhfRqXdqT+Ji9
         qzpYhtc7rMmebmmA+hXu2wuS1F3UCB8chA0lcLTuDZNiXaAQyXNwLuWTCfdYOP7fPdda
         bAuWKYdOInsO0PEwQngYz7gchouU7dF2kBJtDRtBPtLekbMWdxQTs2p3OFR/om9EguUt
         vwjxOHrLSciqVtNxGiZuHN0O4+ksLkLOwoZ0QPuDa0AhDHjY4v306XrA/Hez/XfUZSJb
         zZqT4tAGTHGc0Q9UDeFw9QToMTiXrVMNMynfd0DcPmeKUS6BzlVPc4cVZb1h9NpPypY9
         TNlw==
X-Forwarded-Encrypted: i=1; AHgh+Ro0CEjJgAK7Pb8eyEAT7BWFgUVxJauwRtCyrHFj5JybIl0lckdeGLNzh4zN6HxDiCfb0Nf138Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YxHdWGvzEx3Fkt2cOe1hsphuXd9UwwDYHY7FD01iwXuJnoXkuhb
	N6HBS7JsW9DhLgtGxrRK9r6sISBkt3gW3QfvAe/ccThxA6FNeJdpWC0i
X-Gm-Gg: AfdE7clXSJiHunKT4mtQvzyCt3ycX01GZoCA8DQ09Mo2OCP7ofvudJuIS1ZViBtHqWa
	D7WUpZr5RllvNoZzRjNIJEHuxtwFKb9drBsho1Uv8EeJdNryyR1FQsPca2hsa8Cf9dUXvmnG/gZ
	J39AeVcT3q/DNkjtcuVsyidns6GomVlhYFY8PFeUYdDbRSsPC3LSg3exTV7snkWr/tQDY6+uvk9
	UmV1Z4sYWqZhYARLkRz6NCfzx2OYSCK8nIDD+13bkAKlpxc3vv3XNrun258w/2CU0u50BGymkYq
	SquccHZEgUIcLqx+2DjyDTp42HGfOnzmk3/mhtmSNyTFiqyY6TaOF0gyxpiKU6vWYc27utWJOLR
	avx+8C4MHUCIPblv539NFlCuF6/bRSapp0YahLlleNkij/xgjpyEjtrtyis1lHt5PVRlRnCb5s6
	zNp7/S6Fr5O/hmAuaZnHSp7/sQSwMmMm2GGF/Q/P9R3GSbHrpji8wKsZldJUOT9fy+rCurm0Ctp
	XcZ4WncTXI9hwi5K5p7S1f7Qp32kCN1CeTtKxXh+5bzosP+Y37qZXjRyX00BBYqDVR0p5FlazMH
	gE1Lxn1YXzNf72tncLgTukiU
X-Received: by 2002:a05:600c:3586:b0:493:e504:cbef with SMTP id 5b1f17b1804b1-4954a38def9mr127029085e9.0.1784499037536;
        Sun, 19 Jul 2026 15:10:37 -0700 (PDT)
Received: from MacBook-Pro-von-Karl.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4955370d78csm114492445e9.12.2026.07.19.15.10.34
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 15:10:36 -0700 (PDT)
From: Karl Mehltretter <kmehltretter@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: Karl Mehltretter <kmehltretter@gmail.com>,
	Frank Li <Frank.Li@nxp.com>,
	Sascha Hauer <s.hauer@pengutronix.de>,
	Pengutronix Kernel Team <kernel@pengutronix.de>,
	Fabio Estevam <festevam@gmail.com>,
	linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	imx@lists.linux.dev,
	linux-arm-kernel@lists.infradead.org,
	stable@vger.kernel.org
Subject: [PATCH v2 1/4] serial: core: do fallible allocations before the console can be registered
Date: Mon, 20 Jul 2026 00:10:11 +0200
Message-Id: <20260719221014.44354-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719221014.44354-1-kmehltretter@gmail.com>
References: <20260719221014.44354-1-kmehltretter@gmail.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

serial_core_add_one_port() allocates uport->tty_groups after
uart_configure_port() has already registered the port's console. If
that allocation fails, the function returns -ENOMEM with the console
still registered, and the driver's probe error path then tears down
the port state the console callbacks depend on.

Reproduced with fault injection on qemu's raspi1ap board. Failing the
tty_groups allocation during a PL011 sysfs bind makes
uart_add_one_port() return -ENOMEM. pl011_register_port() then clears
amba_ports[0], but ttyAMA0 remains registered as a console. The nbcon
printer thread dereferences the NULL entry and oopses:

  Unhandled fault: page domain fault (0x01b) at 0x00000178
  CPU: 0 UID: 0 PID: 43 Comm: pr/ttyAMA0 Not tainted 7.2.0-rc3+ #1
  PC is at pl011_console_write_thread+0x2c/0x168

This is not PL011-specific: the failing allocation is in serial core,
after uart_configure_port() has registered the console, so any console
UART driver is exposed. On i.MX the retained console references a
devm-allocated port that the failed probe frees, causing a
use-after-free. Reproduced on qemu's mcimx6ul-evk using the same
fail-nth harness under KASAN:

  BUG: KASAN: slab-use-after-free in imx_uart_console_write_thread+0x50/0x278
  Read of size 4 at addr c5246048 by task pr/ttymxc0/63
   imx_uart_console_write_thread from nbcon_emit_next_record+0x360/0x50c
   nbcon_emit_next_record from nbcon_emit_one+0x140/0x184
  Allocated by task 1:
   devm_kmalloc from imx_uart_probe+0x90/0xa5c
  Freed by task 1:
   devres_release_all from device_unbind_cleanup+0x38/0xdc
   device_unbind_cleanup from really_probe+0x2b4/0x388

The pre-existing kasprintf() failure path has a related problem: it
returns with state->uart_port already pointing at a port whose probe
is about to unwind and free it.

Reorder the function so the uport->name and uport->tty_groups
allocations both happen before the port is linked into the driver
state table and before uart_configure_port() registers the console:

 1. Allocate uport->name.
 2. Allocate the tty_groups array with room for three entries
    unconditionally (serial core group, optional driver group, NULL
    terminator). The optional group cannot be examined at this point:
    config_port() may only supply uport->attr_group during
    uart_configure_port(), e.g. 8250 sets it after autodetection.
 3. Only then link the port into the driver state table and run
    uart_configure_port().
 4. Fill in the optional attr_group slot afterwards.

A fail-nth sweep over the whole bind path on both boards left the
console unregistered after every failed bind and did not reproduce the
i.MX use-after-free.

Fixes: 266dcff03eed ("Serial: allow port drivers to have a default attribute group")
Fixes: f7048b15900f ("tty: serial_core: Add name field to uart_port struct")
Cc: stable@vger.kernel.org
Assisted-by: Claude:claude-fable-5
Signed-off-by: Karl Mehltretter <kmehltretter@gmail.com>
---
 drivers/tty/serial/serial_core.c | 31 +++++++++++++++++--------------
 1 file changed, 17 insertions(+), 14 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a530ad372b43..887b1dd80ad2 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3056,7 +3056,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	struct uart_state *state;
 	struct tty_port *port;
 	struct device *tty_dev;
-	int num_groups;
 
 	if (uport->line >= drv->nr)
 		return -EINVAL;
@@ -3068,6 +3067,23 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	if (state->uart_port)
 		return -EINVAL;
 
+	uport->name = kasprintf(GFP_KERNEL, "%s%u", drv->dev_name,
+				drv->tty_driver->name_base + uport->line);
+	if (!uport->name)
+		return -ENOMEM;
+
+	/*
+	 * uart_configure_port() may set uport->attr_group and register the
+	 * console. Allocate room for both groups and a NULL terminator first.
+	 */
+	uport->tty_groups = kzalloc_objs(*uport->tty_groups, 3);
+	if (!uport->tty_groups) {
+		kfree(uport->name);
+		uport->name = NULL;
+		return -ENOMEM;
+	}
+	uport->tty_groups[0] = &tty_dev_attr_group;
+
 	/* Link the port to the driver state table and vice versa */
 	atomic_set(&state->refcount, 1);
 	init_waitqueue_head(&state->remove_wait);
@@ -3084,10 +3100,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 	state->pm_state = UART_PM_STATE_UNDEFINED;
 	uart_port_set_cons(uport, drv->cons);
 	uport->minor = drv->tty_driver->minor_start + uport->line;
-	uport->name = kasprintf(GFP_KERNEL, "%s%u", drv->dev_name,
-				drv->tty_driver->name_base + uport->line);
-	if (!uport->name)
-		return -ENOMEM;
 
 	if (uport->cons && uport->dev)
 		of_console_check(uport->dev->of_node, uport->cons->name, uport->line);
@@ -3102,15 +3114,6 @@ static int serial_core_add_one_port(struct uart_driver *drv, struct uart_port *u
 
 	port->console = uart_console(uport);
 
-	num_groups = 2;
-	if (uport->attr_group)
-		num_groups++;
-
-	uport->tty_groups = kzalloc_objs(*uport->tty_groups, num_groups);
-	if (!uport->tty_groups)
-		return -ENOMEM;
-
-	uport->tty_groups[0] = &tty_dev_attr_group;
 	if (uport->attr_group)
 		uport->tty_groups[1] = uport->attr_group;
 
-- 
2.53.0
