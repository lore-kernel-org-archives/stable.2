Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 75535391822
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195305; cv=none; b=SZDzhDeNQ3FYkT9VxU4N5bCNFN7KkFqSAw55ktWCYkctmyUlbyjHh0JkLU02Y0C0lsUmZJuGLxk5DuOKoyHtGKWBpalXAp1SO/PwvLTcFUBKNl2diYYvQ6gDAQDuTMWuqlxYY1wGJ15zBQmJQD2fcJ4/WC1J2k0VyZ/7VwK+Lwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195305; c=relaxed/simple;
	bh=q18Ggga2f+3V/sW4EIxdshgij76IQqriZZhCj5Ymn6w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=hL+/fmDX0RY5HH1RMg8nckZdtkkEEW3PqB8HiGN66PJxA66dzOXoF6meQpMSzDI/v+bq+vuoZErJkwtpAuoGguvze3ZDnBXhmFig8zVSkJCljBMqBNOKj8z6bomtvdEhD9FPPovOEuWVvqr/uePZE3Q1rxCnNMd/H1dpwQ4GEAE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=x1EfgWI3; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="x1EfgWI3"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF25E1F00893;
	Mon,  5 Oct 2026 10:15:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195304;
	bh=ISxnKrT45vSMn9PrUxBGSn0z9rP7DkRgw+g/U6LMgrw=;
	h=Subject:To:Cc:From:Date;
	b=x1EfgWI330rw1csDbDWdY0wHpLajnh2UCJ/HFupOD3n9YylK+bwVtUJtyGpZtY1l8
	 335znXJ9KfLO4kDwhJiULftszLWwsV9bK1Nik5wJaQm9jEre+1ssWhbk36pJmAYJ3B
	 op8rSFxUImNT6/sAwFT/cpbfANpDiWZgX7gEEcdA=
Subject: FAILED: patch "[PATCH] serial: core: fix NULL pointer dereference in" failed to apply to 6.18-stable tree
To: linuxoid@gmail.com,gregkh@linuxfoundation.org,tony.lindgren@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:15:00 +0200
Message-ID: <2026100500-unmoral-shrunk-9a8e@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.18-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.18.y
git checkout FETCH_HEAD
git cherry-pick -x 499485a67fbacf4d9afbdb43522388c64f853428
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100500-unmoral-shrunk-9a8e@gregkh' --subject-prefix 'PATCH 6.18.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 499485a67fbacf4d9afbdb43522388c64f853428 Mon Sep 17 00:00:00 2001
From: Ruslan Valiyev <linuxoid@gmail.com>
Date: Wed, 26 Aug 2026 10:46:54 +0200
Subject: [PATCH] serial: core: fix NULL pointer dereference in
 serial_core_unregister_port()

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
Cc: stable@kernel.org
Assisted-by: Claude:claude-opus-5
Assisted-by: Codex:gpt-5.6-sol
Signed-off-by: Ruslan Valiyev <linuxoid@gmail.com>
Link: https://syzkaller.appspot.com/bug?extid=9f57c1b2792029198fcf
Link: https://lore.kernel.org/all/20260826073237.1377668-1-linuxoid@gmail.com/
Reviewed-by: Tony Lindgren <tony.lindgren@linux.intel.com>
Link: https://patch.msgid.link/20260826084654.1392851-1-linuxoid@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 33c8f3b6ac81..6332ed545c89 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -3381,6 +3381,7 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
 
 err_unregister_port_dev:
 	serial_base_port_device_remove(port->port_dev);
+	port->port_dev = NULL;
 
 err_unregister_ctrl_dev:
 	serial_base_ctrl_device_remove(new_ctrl_dev);
@@ -3395,12 +3396,24 @@ int serial_core_register_port(struct uart_driver *drv, struct uart_port *port)
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

