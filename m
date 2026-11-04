Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793802221;
	b=G9otkp/xrQ62a+yqqGxHHTggLn8KdcEIibd2o4Fltb5EolvuZlGtP78xykanjl6GGUBm
	 zn+94vfU2nlL/I2CXIxLg9E+hRV53o71vjMcOXh2FFnokG1M6p62a/0cGBoKA0ljeU1Im
	 fxJor1BfQX6bVp2PAnbRs0Mp5G+6WFVaKN1lpMlNB3H1WZGDI2JhUPOnAJ8id16MOzaww
	 AnAnya7YWbsuWbpLK8j6p8siS1Nl5cSmgcbdrNdo0wONw3yboPZpETmpZRbMl8g8w0T94
	 V5HI54o8JstEAn8iXl/fnU89XPX1/DB2ECdtEVn9a2yJOrNcd1pGY9jCn9JXFw1ppXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793802221;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=F7EwJsmj18W0pUfMqXmJj65rq5RvHfF0di84ScosGFo=;
	b=XUZtEHkECYyWc5GRN43ZYntawXyoeMdlz2OsMQW+QrQIlXHTQwncz94mC3SugU/Jv4Pp
	 RzJ/ZHaYARHp+1iMnXiWNfvsNupDHSgZDEXawXsBHsMv4ZQ8lCsNxtHbFEE8T77HmfW7d
	 Z61hoJwH7CnTjOWL5x5ehtrHDF/DHBJ3TwTpHy5eT64ROnsgrRAlO62k+9qbHKp7Q0rlT
	 sV711dlSQ49T0N8tdb7QXzJ7EIGGA8hlCh/V73FTxpXxANQ1fpmNtjGd0ATb6MqjKREYF
	 jBCCHt2lyav/PZSImNE0b1oDSXKzFkIkMcB7PJlyl97kvKDxjJKq2xkWyLU8kZfW5Xw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=a4CH3lJq;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8EB7606A31B
	for <stable@vger.kernel.org>; Wed,  4 Nov 2026 14:23:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=a4CH3lJq
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D679F1F000C1;
	Wed,  4 Nov 2026 14:23:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1793802220;
	bh=F7EwJsmj18W0pUfMqXmJj65rq5RvHfF0di84ScosGFo=;
	h=Subject:To:Cc:From:Date;
	b=a4CH3lJqUF8shvbV8wraMnB4Q6gdbT/8gPzEgOwmVwNpCt4Z16sYR03VvP89yUTt7
	 3sCQAjIH+WFpUrusBgsPOVoU80bLDEy7kJlYpf9eG7w4hq0DXgmjz9T5GqYl0FXbQA
	 ZUuNMDCGC4QRcapB5Gd96sUdrczm95X111E9y4iI=
Subject: FAILED: patch "[PATCH] serial: core: shut down initialized port on removal" failed to apply to 5.15-stable tree
To: igorpetindev@gmail.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 04 Nov 2026 15:23:37 +0100
Message-ID: <2026110437-fabulous-dingbat-b644@gregkh>
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.15-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.15.y
git checkout FETCH_HEAD
git cherry-pick -x 810d467c11f0c85107874d08dfdd11acba6aa0c0
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026110437-fabulous-dingbat-b644@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 810d467c11f0c85107874d08dfdd11acba6aa0c0 Mon Sep 17 00:00:00 2001
From: Igor Putko <igorpetindev@gmail.com>
Date: Sat, 3 Oct 2026 19:33:37 +0300
Subject: [PATCH] serial: core: shut down initialized port on removal

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

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 319a4b427f3a..05450529871e 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3239,6 +3239,13 @@ static void serial_core_remove_one_port(struct uart_driver *drv,
 	if (uart_console(uport))
 		unregister_console(uport->cons);
 
+	scoped_guard(mutex, &port->mutex) {
+		port->console = false;
+
+		if (tty_port_initialized(port))
+			uart_shutdown(NULL, state);
+	}
+
 	/*
 	 * Free the port IO and memory resources, if any.
 	 */

