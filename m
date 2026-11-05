Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793844122;
	b=gsEUU8XbML5OiUni5Tyg8HcmXnB229wM8eoW74H3aSjVgZpmnSnkcdgD5lyyHo4vQFGW
	 DsEoqauNPrrrZZyUmb6oWMm54ZpR2czb0qiN6lgN7JNCLPlYV+ymMyr7psLDqkcosQe6j
	 IbzCVaTyyHdAUDaYkipBOYSDgJZq6nh8ZGeFWZ2+cUwKITmLYW3mop1DS8yvd/UxfU4MF
	 H2SOKVnxIa8Ri+dyIR7XeD1ONNSmL/YLBCH1Fb0BzM8ewcwy9WRlKTI2ufhCPyYQo3iOS
	 Ccri3UN4Cdecwy4Jfs0cWleU1n8BX9bNV9cPPimI2ALw1wDzBiimotqpCJzRwiQaTJA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793844122;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=FuAqkpgoO7HpbE7sMhjChunAscLHt7MBRHE68FkgSIs=;
	b=EljWph7EgcXpznj6Z5lMWhiUXKJizZ0YtkvCvd9PwvgfdhN1H1EQWEvHEZC0n9FOmrzG
	 oaMRrKm6kGCwoE84CNfYDPvxAhx17zk1soOKVQoYA7MQLK5sTGJ5szAdaYw3B7+JAnHH+
	 3bFVhpUh++Yp6jHo/nXSCCgCyNw5C4HAqSVmIavuKRP5VHimdtNH1D7VqTen0wo6DHiyO
	 VnGPLyD/3ZPlgCU4SDh0rWCSk7ZCgy4Szn/JD36Acn0XO2cQ5DuEg6S78QUq0H5enJgga
	 YGhdMQVWGLW5EuEJ9lp8M0fJsy8jrKGoSTaHrcp6ZwJFTPDcmcjqguIXFLuO4sXBMew==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bt8C6hf7;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6354606A338
	for <stable@vger.kernel.org>; Thu,  5 Nov 2026 02:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Bt8C6hf7
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A64721F00A16;
	Thu,  5 Nov 2026 02:02:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793844121;
	bh=FuAqkpgoO7HpbE7sMhjChunAscLHt7MBRHE68FkgSIs=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Bt8C6hf7NxnTw1l7i/E3AYoAuulFD7S8ioa8n7x5AnWgm3Lq/d/EL0IXuXH6UWd99
	 JojfAS4f2XFieEPD0MxJlEioHOcXPGN8Q5ZrN31zJbV9akk2PRYeV1MYNkyX0QtoHz
	 Eu+G5agl0zJ57310ddJc7mjDrSPYb3QUa3YIYRLTJeYdkq2AchpzYTfxIoxL4kOban
	 OBEi6HaxgdgPVJxSH0LiH1hN6EDud9TUlAO9S2Tuh/bCQuTA1H/UeoPuhcsafx2L1U
	 csr6B08f4UPAc+baYbtWu5hQf4QfXC5GQIY5FXTNnIcFpvZbgW96KCklU4nEo4F3ZB
	 GToPZVetIVhAw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Igor Putko <igorpetindev@gmail.com>,
	syzbot+843bf2f48f4d12e6682e@syzkaller.appspotmail.com,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] serial: core: shut down initialized port on removal
Date: Wed,  4 Nov 2026 21:01:59 -0500
Message-ID: <20261105020047.1070896-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026110440-crouch-oblivion-2771@gregkh>
References: <2026110440-crouch-oblivion-2771@gregkh>
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
[ sashal: Replaced scoped_guard() with explicit mutex_lock() and mutex_unlock() calls for GNU89 compatibility. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4ffa682203166..ada412490668e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3090,6 +3090,13 @@ int uart_remove_one_port(struct uart_driver *drv, struct uart_port *uport)
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

