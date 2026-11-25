Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795608402;
	b=1j//WlaAsARndfVMWeXKhRADGHhvi+9kn/6oBxyu/+rdAjaRGRcTBcX1TtBF+Q++65SU
	 621Vyy8PJibx+ro0JIPfdwvhwsNfLEd6eLZgJd0M5Nzq/PDExQ62Nczo0THvH2CdH+Lii
	 aXOAeGI7sjjUtxB3Mz+NrLCqiwhKPGMo62xOL57SW+s4FtzM4rAc+UwjFUwANGw96kWxc
	 FbGFCE7O6UEG6fW7TJIw24npRMhqud0HTmCdqttZOvxhfmEWuprgMk5nPynJzHmYiNy+E
	 xk8YZ0n+B+YfvhSeukJ79Z54gtg+aEZJg9hjegCwIAPKdp4TDZ9osFgmKMSruL+JacQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795608402;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=sarn/81SyI2i6loS3b/3A+9FNbr9Vxz3LsGy14rlxBE=;
	b=aJtTlNGawdoq7v0lrRhSmdf/LKlTD+gBBhl1AHkf9pE69LXLcibC8mlSL+6sNbFIyPCl
	 /vwWl3at+pBZutdPgGP2XA3k/bjL2Xop7SS99+8G3sjjCJ66oQM5A53rY5MjGdmgtOrD1
	 VP1cItbMKZJwU3BPRx6H8mFb/qSf8IDzvYYhFpKF/hD8w/XS8kpY8WbcVdzbwZxVXjW6I
	 dVivsshPxQUaQofET3WuTkXj9OHAmRPfTKIQAK5+EFmrlTrJ4QEYFO9F35+tY2iYiZfLl
	 5JtawolIls6bjhN5+H9UV8S1JyKJcN0WSvYzekdqgr7z4WdaPJUBzBn9PnrYVF0uEzg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AlAUfRjU;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 39CBA606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:06:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=AlAUfRjU
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 89FEC1F000C6;
	Wed, 25 Nov 2026 12:06:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795608402;
	bh=sarn/81SyI2i6loS3b/3A+9FNbr9Vxz3LsGy14rlxBE=;
	h=Subject:To:Cc:From:Date;
	b=AlAUfRjUifwwkd6A+QXiz4ImDtNyI3ef3xRp8Cr08uj2Dk19FLBMpOboAoQsteP0q
	 zD2uC9/7Q1smK8epI5GmJAZ7kM25175Y+3wNW/aqRgn6ZnkHEQxGzSMRERPNkR8TVQ
	 tusDvECrtdAVGz/jLhnMK8Y9r99RvTGqz5T2j89A=
Subject: FAILED: patch "[PATCH] usb: gadget: u_serial: pin ports while TTYs are installed" failed to apply to 6.6-stable tree
To: krystianmkaniewski@gmail.com,gregkh@linuxfoundation.org,mehmet.fide@screeningeagle.com,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:36:21 +0100
Message-ID: <2026112520-esophagus-hesitate-925e@gregkh>
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


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 1981b53c2b52a00f0f4b9eb87183c9aedc8dac5d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112520-esophagus-hesitate-925e@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 1981b53c2b52a00f0f4b9eb87183c9aedc8dac5d Mon Sep 17 00:00:00 2001
From: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Date: Thu, 22 Oct 2026 11:13:59 +0200
Subject: [PATCH] usb: gadget: u_serial: pin ports while TTYs are installed

A slab-use-after-free can occur when gserial_free_line() frees struct
gs_port while it is still reachable through an installed TTY. The
port->port.count value tracks successful opens, but it is zero before
gs_open() and again after gs_close(), before TTY cleanup has finished.
Teardown can therefore free gs_port while tty_init_dev() or release_tty()
still accesses its tty_port.

Manage gs_port lifetime with tty_port references. Take a reference in
gs_install(), drop it in gs_cleanup(), and move the final free to
gs_port_destruct(). Unregister the TTY device before dropping the owner
reference.

Keep each minor reserved until the old port is destroyed so an installed
TTY for one generation cannot overlap a replacement at the same minor.
Publish the new port before device registration so the cdev and add uevent
never expose a TTY before gs_install() can pin it. Since commit
8df07fe93573 ("tty: fix saved termios reset race"), u_serial registration
no longer frees saved termios. On registration failure, unpublish the port
before dropping its owner reference.

Check in gs_open() that the installed port is still the published
generation. Track failures after a successful install so close callbacks
issued by the TTY core do not decrement port->port.count for opens that
never incremented it.

Fixes: 19b10a8828a6 ("usb: gadget: allocate & giveback serial ports instead hard code them")
Assisted-by: Gemini:gemini-3.8-flash syzbot
Reported-by: syzbot+fe63e4d633540f230624@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=fe63e4d633540f230624
Link: https://syzkaller.appspot.com/ai_job?id=ec789387-2e7b-4a8f-a7a1-a47bf7fa57f5
Cc: stable <stable@kernel.org>
Signed-off-by: Krystian Kaniewski <krystianmkaniewski@gmail.com>
Tested-by: syzbot@syzkaller.appspotmail.com
Tested-by: Mehmet Fide <mehmet.fide@screeningeagle.com>
Reported-by: syzbot+bca09f5d8b843bbf7571@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bca09f5d8b843bbf7571
Link: https://patch.msgid.link/20261022091359.1187468-1-krystianmkaniewski@gmail.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 892d2673e9b0..0a304f508bc3 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -70,10 +70,28 @@
  *	gserial->ioport == usb_ep->driver_data ... gs_port
  *	gs_port->port_usb ... gserial
  *
- * gs_port <---> tty_struct ... links will be null when the TTY file
- * isn't opened; managed by gs_open()/gs_close()
- *	gserial->port_tty ... tty_struct
- *	tty_struct->driver_data ... gserial
+ * gs_port <---> tty_struct:
+ *	tty->driver_data refers to gs_port from install through cleanup,
+ *	pinning the port via tty_port reference counting.
+ *	gs_port->port.tty exists only while the port is open.
+ *
+ * Each entry in ports[] is guarded by ports[i].lock and models three states:
+ *   - Free:      !port && !reserved
+ *   - Published:  port &&  reserved
+ *   - Retiring:   !port &&  reserved
+ *
+ * A minor remains reserved until gs_port_destruct() runs upon final tty_port
+ * release, preventing minor reuse while cleanup of the installed TTY is still
+ * underway. The owner reference is retained through device unregister so the
+ * destructor releases the reservation only after device teardown is complete.
+ *
+ * open_close_failures tracks failed gs_open() calls where port->port.count
+ * was not incremented. The TTY core calls gs_close() on open failure to tear
+ * down the tty; tracking failures as aggregate credits allows gs_close() to
+ * consume a credit and exit without decrementing port->port.count. Credits
+ * are aggregate rather than paired with individual files (another gs_close()
+ * can consume a failed open's credit before that file's own close runs).
+ * It is protected by tty_lock.
  */
 
 /* RX and TX queues can buffer QUEUE_SIZE packets before they hit the
@@ -128,6 +146,7 @@ struct gs_port {
 	wait_queue_head_t	close_wait;
 	bool			suspended;	/* port suspended */
 	bool			start_delayed;	/* delay start when suspended */
+	unsigned int		open_close_failures; /* protected by tty_lock */
 	struct async_icount	icount;
 
 	/* REVISIT this state ... */
@@ -135,8 +154,9 @@ struct gs_port {
 };
 
 static struct portmaster {
-	struct mutex	lock;			/* protect open/close */
+	struct mutex	lock;			/* protect open/close and port slot */
 	struct gs_port	*port;
+	bool		reserved;
 } ports[MAX_U_SERIAL_PORTS];
 
 #define GS_CLOSE_TIMEOUT		15		/* seconds */
@@ -603,22 +623,60 @@ static int gserial_wakeup_host(struct gserial *gser)
 
 /* TTY Driver */
 
+static int gs_install(struct tty_driver *driver, struct tty_struct *tty)
+{
+	struct gs_port *port;
+	struct tty_port *tport;
+	int ret;
+
+	mutex_lock(&ports[tty->index].lock);
+	port = ports[tty->index].port;
+	if (!port) {
+		mutex_unlock(&ports[tty->index].lock);
+		return -ENODEV;
+	}
+
+	tport = tty_port_get(&port->port);
+	if (!tport) {
+		mutex_unlock(&ports[tty->index].lock);
+		return -ENODEV;
+	}
+
+	ret = tty_port_install(tport, driver, tty);
+	if (ret) {
+		mutex_unlock(&ports[tty->index].lock);
+		tty_port_put(tport);
+		return ret;
+	}
+
+	tty->driver_data = port;
+	mutex_unlock(&ports[tty->index].lock);
+
+	return 0;
+}
+
+static void gs_cleanup(struct tty_struct *tty)
+{
+	tty_port_put(tty->port);
+}
+
 /*
- * gs_open sets up the link between a gs_port and its associated TTY.
- * That link is broken *only* by TTY close(), and all driver methods
- * know that.
+ * gs_open associates an open TTY with its gs_port.
+ *
+ * There are two TTY-to-port relationships: port->port.tty exists from the
+ * first successful open until final close, while tty->driver_data is assigned
+ * during gs_install() and remains valid through gs_cleanup().
  */
 static int gs_open(struct tty_struct *tty, struct file *file)
 {
 	int		port_num = tty->index;
-	struct gs_port	*port;
+	struct gs_port	*port = tty->driver_data;
 	int		status = 0;
 
 	mutex_lock(&ports[port_num].lock);
-	port = ports[port_num].port;
-	if (!port) {
+	if (ports[port_num].port != port) {
 		status = -ENODEV;
-		goto out;
+		goto fail_unlock;
 	}
 
 	spin_lock_irq(&port->port_lock);
@@ -638,7 +696,7 @@ static int gs_open(struct tty_struct *tty, struct file *file)
 		if (status) {
 			pr_debug("gs_open: ttyGS%d (%p,%p) no buffer\n",
 				 port_num, tty, file);
-			goto out;
+			goto fail_unlock;
 		}
 
 		spin_lock_irq(&port->port_lock);
@@ -648,7 +706,6 @@ static int gs_open(struct tty_struct *tty, struct file *file)
 	if (port->port.count++)
 		goto exit_unlock_port;
 
-	tty->driver_data = port;
 	port->port.tty = tty;
 
 	/* if connected, start the I/O stream */
@@ -672,7 +729,11 @@ static int gs_open(struct tty_struct *tty, struct file *file)
 
 exit_unlock_port:
 	spin_unlock_irq(&port->port_lock);
-out:
+	mutex_unlock(&ports[port_num].lock);
+	return status;
+
+fail_unlock:
+	port->open_close_failures++;
 	mutex_unlock(&ports[port_num].lock);
 	return status;
 }
@@ -698,6 +759,11 @@ static void gs_close(struct tty_struct *tty, struct file *file)
 	if (!port)
 		return;
 
+	if (port->open_close_failures > 0) {
+		port->open_close_failures--;
+		return;
+	}
+
 	spin_lock_irq(&port->port_lock);
 
 	if (port->port.count != 1) {
@@ -912,8 +978,10 @@ static int gs_get_icount(struct tty_struct *tty,
 }
 
 static const struct tty_operations gs_tty_ops = {
+	.install =		gs_install,
 	.open =			gs_open,
 	.close =		gs_close,
+	.cleanup =		gs_cleanup,
 	.write =		gs_write,
 	.put_char =		gs_put_char,
 	.flush_chars =		gs_flush_chars,
@@ -1206,14 +1274,41 @@ static void gs_console_exit(struct gs_port *port)
 
 #endif
 
-static int
+static void gs_port_destruct(struct tty_port *tport)
+{
+	struct gs_port *port = container_of(tport, struct gs_port, port);
+	unsigned int port_num = port->port_num;
+
+	mutex_lock(&ports[port_num].lock);
+	if (WARN_ON(ports[port_num].port))
+		ports[port_num].port = NULL;
+	WARN_ON(!ports[port_num].reserved);
+	if (gs_tty_driver)
+		gs_tty_driver->ports[port_num] = NULL;
+	ports[port_num].reserved = false;
+	mutex_unlock(&ports[port_num].lock);
+
+	kfifo_free(&port->port_write_buf);
+	kfree(port);
+}
+
+static const struct tty_port_operations gs_port_ops = {
+	.destruct = gs_port_destruct,
+};
+
+static struct gs_port *
 gs_port_alloc(unsigned port_num, struct usb_cdc_line_coding *coding)
 {
 	struct gs_port	*port;
 	int		ret = 0;
 
 	mutex_lock(&ports[port_num].lock);
-	if (ports[port_num].port) {
+	if (WARN_ON_ONCE(ports[port_num].port && !ports[port_num].reserved)) {
+		ret = -EBUSY;
+		goto out;
+	}
+
+	if (ports[port_num].reserved) {
 		ret = -EBUSY;
 		goto out;
 	}
@@ -1225,6 +1320,7 @@ gs_port_alloc(unsigned port_num, struct usb_cdc_line_coding *coding)
 	}
 
 	tty_port_init(&port->port);
+	port->port.ops = &gs_port_ops;
 	spin_lock_init(&port->port_lock);
 	init_waitqueue_head(&port->drain_wait);
 	init_waitqueue_head(&port->close_wait);
@@ -1238,10 +1334,14 @@ gs_port_alloc(unsigned port_num, struct usb_cdc_line_coding *coding)
 	port->port_num = port_num;
 	port->port_line_coding = *coding;
 
+	ports[port_num].reserved = true;
 	ports[port_num].port = port;
+	mutex_unlock(&ports[port_num].lock);
+	return port;
+
 out:
 	mutex_unlock(&ports[port_num].lock);
-	return ret;
+	return ERR_PTR(ret);
 }
 
 static int gs_closed(struct gs_port *port)
@@ -1261,8 +1361,7 @@ static void gserial_free_port(struct gs_port *port)
 	/* wait for old opens to finish */
 	wait_event(port->close_wait, gs_closed(port));
 	WARN_ON(port->port_usb != NULL);
-	tty_port_destroy(&port->port);
-	kfree(port);
+	tty_port_put(&port->port);
 }
 
 void gserial_free_line(unsigned char port_num)
@@ -1279,15 +1378,15 @@ void gserial_free_line(unsigned char port_num)
 	ports[port_num].port = NULL;
 	mutex_unlock(&ports[port_num].lock);
 
-	gserial_free_port(port);
 	tty_unregister_device(gs_tty_driver, port_num);
+	gserial_free_port(port);
 }
 EXPORT_SYMBOL_GPL(gserial_free_line);
 
 int gserial_alloc_line_no_console(unsigned char *line_num)
 {
 	struct usb_cdc_line_coding	coding;
-	struct gs_port			*port;
+	struct gs_port			*port = ERR_PTR(-EBUSY);
 	struct device			*tty_dev;
 	int				ret;
 	int				port_num;
@@ -1298,19 +1397,20 @@ int gserial_alloc_line_no_console(unsigned char *line_num)
 	coding.bDataBits = USB_CDC_1_STOP_BITS;
 
 	for (port_num = 0; port_num < MAX_U_SERIAL_PORTS; port_num++) {
-		ret = gs_port_alloc(port_num, &coding);
-		if (ret == -EBUSY)
-			continue;
-		if (ret)
+		port = gs_port_alloc(port_num, &coding);
+		if (IS_ERR(port)) {
+			ret = PTR_ERR(port);
+			if (ret == -EBUSY)
+				continue;
 			return ret;
+		}
 		break;
 	}
-	if (ret)
-		return ret;
+	if (IS_ERR(port))
+		return PTR_ERR(port);
 
 	/* ... and sysfs class devices, so mdev/udev make /dev/ttyGS* */
 
-	port = ports[port_num].port;
 	tty_dev = tty_port_register_device(&port->port,
 			gs_tty_driver, port_num, NULL);
 	if (IS_ERR(tty_dev)) {
@@ -1319,14 +1419,15 @@ int gserial_alloc_line_no_console(unsigned char *line_num)
 
 		ret = PTR_ERR(tty_dev);
 		mutex_lock(&ports[port_num].lock);
+		WARN_ON(ports[port_num].port != port);
 		ports[port_num].port = NULL;
 		mutex_unlock(&ports[port_num].lock);
-		gserial_free_port(port);
-		goto err;
+		tty_port_put(&port->port);
+		return ret;
 	}
+
 	*line_num = port_num;
-err:
-	return ret;
+	return 0;
 }
 EXPORT_SYMBOL_GPL(gserial_alloc_line_no_console);
 

