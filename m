Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5148345C70F
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:15:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195317; cv=none; b=S4g3rm20rqp0e4uPdWj9LkWoNwjcuy3/2of+xjgt4uaEbXvg7W1eME8m+bYn6mfBmYJRzN1t/bd55HgLaZh/tfGNcyL4h2mOcZv4jlPgvMDkjZ+i6H5tJI1fYjqtWGnCUb2EoMVI1cxTWz+bv7Z3wi+BVaAoCGoITMojW71YAt8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195317; c=relaxed/simple;
	bh=XSuyy6BRLGikh8jPVmFDspJWSumyQ1HAwns+tEaTaLc=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=RpOEaMBBfoyvXd5gomJj5nH+iJYAUupsB7nnTWwnzSn0RiF4IGK4tQAKJIlkvO2jwklzcy3FS9OStwr/KSqvDiV5scj1SFtXY2S8bpWaUu6ATbUKYqDrSgD9RxrHTXV7jdIkUGCXSZmkDG0KfV5kHFELvcUX24bjh+4u4JaKKa4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=GkFlhc92; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="GkFlhc92"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFA051F000FF;
	Mon,  5 Oct 2026 10:15:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195316;
	bh=5M2dfGjz1unNwMINp2ULxy3eYYGsY+EfkHVRbwdeny0=;
	h=Subject:To:Cc:From:Date;
	b=GkFlhc920QTavrUtTIun+Ia+X0c6vxk4G4RMQvhjAXM8K0bsaCoxViKgFDyv6qe8j
	 lOFOBkYgBjwO28b3ymmEHhvFLPUhdM+OTR/YiYGtuESI4v4rVzDOIUFYFajiI6n1IX
	 rjmra6GfL45oTDwUZ+8Ibgj1/DLiCh0qpgHPtql4=
Subject: FAILED: patch "[PATCH] serial: core: fix NULL pointer dereference in" failed to apply to 6.6-stable tree
To: linuxoid@gmail.com,gregkh@linuxfoundation.org,tony.lindgren@linux.intel.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:15:02 +0200
Message-ID: <2026100502-chute-cranial-b5eb@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 499485a67fbacf4d9afbdb43522388c64f853428
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100502-chute-cranial-b5eb@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

