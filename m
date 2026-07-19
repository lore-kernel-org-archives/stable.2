Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com [209.85.128.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15CE13ABDB3
	for <stable@vger.kernel.org>; Sun, 19 Jul 2026 16:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784477310; cv=none; b=UMLadjbejebxHaZ4Y4mFDj3QtvQqJ9uZeS44e8osIK9V8LxNV/+lCf5sl8skCnspV/vYH5griz7nGHobng0SVeiYYJnofn8FhpfWtpWuP4D1me5Yi041KDjk86+tbPQGvdTaZ7Z8ixcv+PHDk7QFbdQcQXBhdVoIvm7Em5KKJjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784477310; c=relaxed/simple;
	bh=1RQ8k9otHSPFMO2zg/Ml6BOTg9wSwQhmSZS4Ik9eJdY=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Uh7JT1kZVX7HOrTi/HBx78BOPlLARLlE7Bv0s83DJF6azr1Lvepa3uILGSW3kUJhLfPS+Gjp3EuCnF89XZz1pP9Mma8f/F92Ow4CABvqLu98nmb5uSyea37L+e2f1/0FSvoRwpKC/43Yu7RVldKlQ0s1DK8q7yoBzsVXKn/Huzc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=n2/24m7i; arc=none smtp.client-ip=209.85.128.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="n2/24m7i"
Received: by mail-wm1-f52.google.com with SMTP id 5b1f17b1804b1-4954d383e64so10224265e9.1
        for <stable@vger.kernel.org>; Sun, 19 Jul 2026 09:08:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784477307; x=1785082107; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=pTekW+ENVi0Z1ogLAr2oe8Uj7dHDNrRZFKBwQW5P7mc=;
        b=n2/24m7igcT86/OwKcy9PyVJ60Nwp2RG+NscSGqB1VejOI/YGzDR782iHHQnz9IutU
         KpI/4FNSF+e1I4q7ap6ugEkx8RDsR7lgscwgGY3Riaxddk2777hJP6jTc8k0MMwAr/n5
         M0TrvBP+iidk7v6mb/v+qj2C4n2YkqqZnoi667RizTXZSsT3Fm9D68Fy4iOCNlw5wjt2
         JbGnh1Bmur/RunMGoR1eZ2isNrShJj+VeTHwTiq6q3uN38FDadkiJpxeGG4rWz4SNT9L
         AMYuCJ5vs0fZN5wmtvzcrO65OC90Kz/BacSyaKU72oRENfEldw+VY4+5z/G4/Bgz2efC
         8HVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784477307; x=1785082107;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=pTekW+ENVi0Z1ogLAr2oe8Uj7dHDNrRZFKBwQW5P7mc=;
        b=hrFmjlA+ZTlRAKztBcAGwsDXZ7s0rMuB5+JI16OTLM1UGesla/4SVDBkOZJby7AT3c
         uMGeMXgkMj2GitgWGpngY5HVI5wCju31RAH84K2xvPsMgH1KeBIiLcm1ssPFYBHC2+Dl
         eryiGCZB8E8Rt3v4pbRXwlp3aixh7+hVN674x4v5IXq581R4Ex0TqjiRGupHUBqw7cDF
         t3Qn1IGqHYtOgslCaAjBBQTPyBaai3Q1HWdmjz+SW/i+2jiehPACGDgocns9NMsMhU/d
         cz8M46xakRlHYVINMde2OoGHQ48ac+phsRfte8Wzb/eim8z352edCsbrDzLOIUA1x5tu
         WHqw==
X-Forwarded-Encrypted: i=1; AHgh+RpW6ejQhrLLbYmjG74F5X80COqP9UpahX0iDEojGgHj+SzOIPKKuu2RyXov95XaSM0Y9jhTW7U=@vger.kernel.org
X-Gm-Message-State: AOJu0YzNfYKR9FoxsoFL7uWO5fbEkHc/vH6jjZ7eYKoPOMSm3KwVdr0w
	YmmlTQoX7nNflyMrrZIEIBNSbql4eIRhKbyElM7YyPhnmpk/9HNdoFIe
X-Gm-Gg: AfdE7ckBLD85IoFMYlscyXMqda8uC4tmLTR1PkRSVGiXgPLep/04K6Qve3tKDyHyyJ5
	ghRhO68VDFazql5yR79XfkgnZy+PKuDVDc1Or03ijNkWdSkh/NSorDZ57EMPFbdP6N9yIZzxnw0
	W9e7jA1/EyOtRdUywbOek1EADhlQnYvPtk7l67jCVD/9SqRFFbOD9I5hpERxW51bsK+FpFkbYub
	NCJ0hBShxqJBGG1iSo6GNn5F8tS1+diHvpPGyQSv956zg479PKAm/DmONZ6zmuZ+fOBsiO2HTb0
	tDW0OTuLUzW9/xvnvAF33VrzenADxrBS2yuLdg8Kdb8vwAGtH99ZaILPlQafX2hY1pxsgB8VVzU
	W/ZnYc3yx4VKaHtq8tTogupC43DiReDR5MCANKK3zfih8jMdN6smWR9RDswAloGBb3rTsN6NLMC
	B21Z3ENTaaK6u+eUTcHXkzggs/U+Q2lN0LA9/18Y5yzlJR8wpEPOlMI/ssURGCqi32cHxVWAlr5
	+6HiBRTIfO4IGquNM927fmFIkR3NMLVqrsUXTMFuniUhmL9yUpg+xCUSCVtZjADkZgmh4byKzky
	H/IbR9kpBA==
X-Received: by 2002:a05:600d:6413:10b0:495:573e:1c5a with SMTP id 5b1f17b1804b1-495573e1e23mr29049745e9.13.1784477306815;
        Sun, 19 Jul 2026 09:08:26 -0700 (PDT)
Received: from localhost.localdomain (dynamic-2a02-3100-aeaf-bd01-78a0-2a2d-507f-c97c.310.pool.telefonica.de. [2a02:3100:aeaf:bd01:78a0:2a2d:507f:c97c])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4954a2edbe4sm223826745e9.12.2026.07.19.09.08.25
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Sun, 19 Jul 2026 09:08:26 -0700 (PDT)
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
Subject: [PATCH 1/4] serial: core: do fallible allocations before the console can be registered
Date: Sun, 19 Jul 2026 18:08:09 +0200
Message-Id: <20260719160812.35407-2-kmehltretter@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
In-Reply-To: <20260719160812.35407-1-kmehltretter@gmail.com>
References: <20260719160812.35407-1-kmehltretter@gmail.com>
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
