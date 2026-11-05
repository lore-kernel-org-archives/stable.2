Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793839106;
	b=K0t85Fxrep4uBPPIEYH5wn9cCF+Q3w7Wk8x7Wj8YmKRmqLpGvC2BthNpOjyhAWoWH7kP
	 0VA3N48F4ROkMYyT6SlMNFF2U6zFBHQRop8hJMxjdLw50Pn5ZLERoRDLficxscCwJ8xAu
	 /0XyCH1hT9kBga0vsFfenKvyDLNbdpwiU1G2gAI6vLxe2+QUbVDI52EcONzIR/YApaInV
	 fg8mG8X9DvKjXeVs88+n7s/GsCia4d/vEOsCE9+cQVLEWDbZX1I4mdrsLFWJw2n9GUgv/
	 UHqn3TmEA+9kWD2kheQoC3BAUqMhsYy42bMgCZfM8LQHP2PfbFA4dQspp/gor0hwozQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793839106;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Dy1aKQGJJTwtjNmlBymTEs3WMnLFZzsvL/te9TVaVSE=;
	b=bEBocmK3aGiUBODYFVyX5RlqaQlct2sZLbfnLoU3/iB2VxYUm1HuNVS5/qFtbX0Ff14A
	 WVUSck8TGdojl7odAn4jFBsRreDmNQWARmut6A2CnU/lSFUTPTTf9a5r/zibEIjWCnh6v
	 PXZ5jgiPlZOuh0Bs1I2rFZem+82Ew3aXaxhOkpY2M1UEwIqAHTuMtBqK520oc3lTPbrEZ
	 tfCW08omHVNtCsFUzwXVg1feKom8OTjyZa+/Yzlr4e4YVmYd9k/hVcEIokLEsiDoZk/Vu
	 r6oVfoF2HTc73gvlOXloqQGs+F1V3Px74wbDBBDxfaLYsoSgv9o1MwfXWE5jAcO3pqQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSLOxZno;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 16B7B606A31B
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 00:38:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=RSLOxZno
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3C4951F000C1;
	Thu,  5 Nov 2026 00:38:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793839105;
	bh=Dy1aKQGJJTwtjNmlBymTEs3WMnLFZzsvL/te9TVaVSE=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=RSLOxZno2vcremE0POZkJKdn54ImTQSHXUA+38IIc2H7xS+HFNogZbmrjMVUL8AUy
	 N9vTqw5ddqhc6wtbj5aYTA+NI1j7lhPlgy26EsI3xaV2yfr6qXsZvEViw7rzt8CeVD
	 aBoW9rnAljsuZOOFe7NZthg0yyFoUXNvYiYSwAmxrzKA4+6LXxK7Hdf2BDyyWKp4As
	 NH4GhAU2weQNWlHCNDpq3UhkoVcCFWSwItbFOENbajOAv4QyXr7KJOgxrfakgGh6Ld
	 dSvoIxQbBzIYV5TOwmAmhwTbZc9kD0jL2StnWzYu6y/N6Fr5cr0BtFuhBW8DLVE01S
	 LJW4pFVXsv2/A==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Igor Putko <igorpetindev@gmail.com>,
	syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] serial: core: shut down initialized port on removal
Date: Wed,  4 Nov 2026 19:38:24 -0500
Message-ID: <20261105003741.986188-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110437-fabulous-dingbat-b644@gregkh>
References: <2026110437-fabulous-dingbat-b644@gregkh>
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

From: Igor Putko <igorpetindev@gmail.com>

[ Upstream commit 810d467c11f0c85107874d08dfdd11acba6aa0c0 ]

When a serial port configured as a console is opened and subsequently
closed, tty_port_shutdown() skips invoking port->ops->shutdown() because
port->console is true. As a result, tty_port_initialized() remains true
and the port's interrupt handler stays registered in the irq subsystem.

If the underlying device is later unbound or removed (e.g. via sysfs
driver unbind or device hot-unplug), serial_core_remove_one_port()
unregisters the console, frees uport->name via kfree(), and tears down
the port without shutting it down or freeing its IRQ. Consequently, the
irqaction descriptor remains registered in genirq with action->name
pointing to freed memory.

This triggers a use-after-free read whenever genirq accesses action->name,
such as when reading /proc/interrupts:

  BUG: KASAN: slab-use-after-free in string+0x476/0x570
  Call Trace:
   string+0x476/0x570
   vsnprintf+0x422/0x1300
   seq_printf+0x...
   show_interrupts+...

Fix this by acquiring port->mutex in serial_core_remove_one_port() after
console unregistration, clearing port->console under the mutex to prevent
data races with concurrent tty_port_shutdown(), and invoking
uart_shutdown(NULL, state) if the port remains initialized. This ensures
that port->ops->shutdown() is called and the IRQ is freed before
kfree(uport->name).

Reported-by: syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com
Cc: stable <stable@kernel.org>
Closes: https://syzkaller.appspot.com/bug?extid=843bf2f48f4d12e6682e
Fixes: 761ed4a94582 ("tty: serial_core: convert uart_close to use tty_port_close")
Fixes: f7048b15900f ("tty: serial_core: Add name field to uart_port struct")
Signed-off-by: Igor Putko <igorpetindev@gmail.com>
Link: https://patch.msgid.link/20261003163337.45577-1-igorpetindev@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: Replaced scoped_guard() with explicit mutex_lock() and mutex_unlock() for GNU89 compatibility. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index a52e88a750f9e..3fc3b33cadc51 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3071,6 +3071,13 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
 	if (uart_console(uport))
 		unregister_console(uport->cons);
 
+	mutex_lock(&port->mutex);
+	port->console = false;
+
+	if (tty_port_initialized(port))
+		uart_shutdown(NULL, state);
+	mutex_unlock(&port->mutex);
+
 	/*
 	 * Free the port IO and memory resources, if any.
 	 */
-- 
2.53.0

