Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1795398518;
	b=o9V9z1fLEJDA0IqeAnEa74w+nXXLAeUIENm6u2v1DSn5eELfWYEVG9CjaZZzhFjse2hO
	 QptuRx8zV0Gc/bEyl2vSTdyybK6fZ4ST6lVsdWCkIHxOV7DNrHvNa3cUo+CTDP27jv9Mm
	 xLjy65G3Laj66VGXmJD1nHRBr4UeQgz0kFcvlrRhm0ssCVSTBwjUrBu6Mz68yK2KPLLpd
	 MXs7rI1o/1FcuNc/fIQcs5kUSaM1lBqZcdswJqXsi4uWPG3DZeaPLP8IECXhJ9WP561K2
	 LcwSlLhSpYDGFb6KNPE3O4ra6oRUwH/i++3l+SSrp+Nq+ZQi9EFaB0BbqxikziTwfow==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795398518;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XALtPDd8DonhX3PMnwhRii26VgRfNBlpSPXMtIJoeIQ=;
	b=0ANoyglIho7JtakkL8/1mRcEkTWW4cBXVxv2vyTiVDeGviOGFWIeUXzFdGCKArpIk0PJ
	 WDl5qAP1L4CsK6xz87EO26r4LDpx5oxPA1SorX08+ABx/AdF9yCSFK8JcUcOMSSr3bdth
	 bYjkeeE0iVxXRk35ngJ+Mm75u1SZ414LrxnQwfUkbwZjn46kztDnAdYz+dSUPMk9N8VwO
	 5v8+ey8ODuvk+F7/8fvEntohRdYcPqwg30Gax1KfbEFRXXbmnhLDDzBHyvM4MhHpnyUae
	 fg7oQXi06eWG1D/TiDyEkREiEciAyHkZjrLyKUWmkELsjrW3xFjJhJl6Zfz3N6ysCSA==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VB7+o5E8;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8BF61606A327;
	Mon, 23 Nov 2026 01:48:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=VB7+o5E8
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1795398518;
	b=e8g12Q/ZTNa/ngIygLjoWE7MFT8cKtx5/PtWKRRSSxVKq9ouyREK7sw3qtr9kanJQRG8
	 4M6rm/fVuIaRzLBdfG6ZCRsOXe5ZULyIZ+LxJo76FPkF7cPh7P+VO5dJ7RsPNfn5ObGNF
	 gnm4niZIyeDQ8xH4GuIhOF2ZwRZhct1tHqaP0YYR0JU8AK7vFRAX9/nFxxfojCtTI6Spd
	 NVps3bSr5UFEJpMMGxVWsHZker0wnyD5waZrYCw993xvD5uftlFTx8vMBES9cOAtmWtEZ
	 hjPEBoP05SjgoqbOQ17wMsElMkIpmDGqmUFb4ahNQgL15aQBqNI6MygQTcl1MTCn3XQ==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1795398518;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=XALtPDd8DonhX3PMnwhRii26VgRfNBlpSPXMtIJoeIQ=;
	b=FJxvNEAlVSDsz/MVk9vY6p57Gy41xiaRsRDqjswaf6+NwHF1TTl61Xp/5d/RhKjb1R5y
	 6gE0T9vpWp8WApZKZBsDn97GE/BxRkxO/UFSeEGQ4tWFlKUMSbXv12lm9bkaIVTTLsesr
	 4T9Shs0g7j132ZV/ASNeG2zNsEaKm8GWMSRtbwEcRBDqJJKyXY1gPByv7dvz9SxHR4M0a
	 DSZ2g6TGX+pp3wobbsbrzO7pph63FN039zKCcZkH1orMRrLi6HMpvtvqniEnbUWQwcPpC
	 AYYVXCFLwCZ+aC8955ZPkvPvAvY5lDw5cDC+tP/2ErP4Ubwxq1wTDLyR1qcuUPUwEsA==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 660771F000CF;
	Mon, 23 Nov 2026 01:48:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795398518;
	bh=XALtPDd8DonhX3PMnwhRii26VgRfNBlpSPXMtIJoeIQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:Reply-To;
	b=VB7+o5E8q4y/l2biw4NwMitSu6ewEJwDButqWuT6+xOa0WtMYoq5n38yvsOdIQvty
	 NXK0S6x2XKvx5OxMyh7E4/qQdX/9QEBzVo7fKNwkLOjpfQ4HRXTDSa95+KHSoMYs2n
	 gXC0j1xQBK5r9YEEh1jotZpbpZUhXHq0qSSgYV+UagB6qnLlu/nPfjPhQorfBYIyVL
	 DFAcNMUi78eD1qh/SH1Xirjb8aXqL87vt0v5yopH7TZpD3MRaWcT26URodpzM9nHf+
	 +enRO4UdeiRy4ztQi2In8oyv6T0iXPsDQDxS85ThOomOd3rzePKQUF+Rkif7+cJ4ph
	 UvfmyS3D+Douw==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id E6E0C4C2E2;
	Mon, 23 Nov 2026 01:48:36 +0000 (UTC)
From: Fabricio Akio via B4 Relay <devnull+fabricioakio.gmail.com@kernel.org>
Date: Sun, 22 Nov 2026 22:48:35 -0300
Subject: [PATCH v2 2/2] usb: gadget: u_serial: Free the console request
 only once it is back
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Message-Id: <20261122-u-serial-console-dequeue-v2-2-820f355827e6@gmail.com>
References: <20261122-u-serial-console-dequeue-v2-0-820f355827e6@gmail.com>
In-Reply-To: <20261122-u-serial-console-dequeue-v2-0-820f355827e6@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Neill Kapron <nkapron@google.com>
Cc: Krystian Kaniewski <krystianmkaniewski@gmail.com>, 
 Brian Ellis <brianellis@gotenna.com>, Ai Chao <aichao@kylinos.cn>, 
 =?utf-8?q?Micha=C5=82_Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>, 
 Prashanth K <prashanth.k@oss.qualcomm.com>, linux-usb@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Fabricio Akio <fabricioakio@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1795398515; l=8468;
 i=fabricioakio@gmail.com; s=20260928; h=from:subject:message-id;
 bh=69hjgYfN3tBwZsKHKKPp7YLsWXixOc43fSHobPp3dys=;
 b=9TB1ZrOHQI41zFbMz7PD2SiwXmeqNvxMw6zSZ1UBW7lYmxJ7dVIcUKmtjlqgylMImlM3Ox9qT
 eUooItT6HNPAvldYUe0koUjUlUn4ZubWzQriaIJbMtXGXS0pbG/QIt6
X-Developer-Key: i=fabricioakio@gmail.com; a=ed25519;
 pk=TlMUT8bPI/ZQzp2q24BIQTb2qSx/jdUTBlGEXIRCm54=
X-Endpoint-Received: by B4 Relay for fabricioakio@gmail.com/20260928 with
 auth_id=1076
X-Original-From: Fabricio Akio <fabricioakio@gmail.com>
Reply-To: fabricioakio@gmail.com
Content-Transfer-Encoding: 7bit

From: Fabricio Akio <fabricioakio@gmail.com>

gs_console_disconnect() frees the console request right after
usb_ep_dequeue(), which is asynchronous: the controller, dwc3 here,
gives a queued request back from usb_ep_disable() in
gserial_disconnect(), after it was freed. __gs_console_push() also
queues the request with cons->lock dropped, so a disconnect in that
window frees a request still being queued. An idle request is dequeued
too, which dwc3 reports as "request ... was not queued" at each
disconnect.

Track whether the request is out in a console flag, cons->busy, under
cons->lock, instead of in req->length, which the driver may not examine
while the request is queued. On disconnect, the console gives the
request up and frees it only if idle. A busy request, now orphaned, is
freed when it comes back: by its completion, or by gs_console_work()
when usb_ep_queue() fails. Until then it holds a reference on the
console, so that the console outlives it after gs_console_exit().
__gs_console_push() is folded into gs_console_work(), its only caller,
so that a failed queue takes cons->lock only for as long as it needs.

The disconnect no longer dequeues: in gserial_disconnect(),
usb_ep_disable() follows and gives the request back. gs_console_exit(),
where nothing follows, drops the unsent output and dequeues a request
still queued itself.

Fixes: fe1ea63ad806 ("usb: gadget: u_serial: reimplement console support")
Fixes: e5990469943c ("usb: gadget: u_serial: Avoid spinlock recursion in __gs_console_push")
Cc: stable@vger.kernel.org
Signed-off-by: Fabricio Akio <fabricioakio@gmail.com>
---
 drivers/usb/gadget/function/u_serial.c | 130 +++++++++++++++++++++++++--------
 1 file changed, 101 insertions(+), 29 deletions(-)

diff --git a/drivers/usb/gadget/function/u_serial.c b/drivers/usb/gadget/function/u_serial.c
index 1f0110ea7f6a..fd511327c083 100644
--- a/drivers/usb/gadget/function/u_serial.c
+++ b/drivers/usb/gadget/function/u_serial.c
@@ -29,6 +29,7 @@
 #include <linux/kthread.h>
 #include <linux/workqueue.h>
 #include <linux/kfifo.h>
+#include <linux/kref.h>
 #include <linux/serial.h>
 
 #include "u_serial.h"
@@ -111,8 +112,10 @@ struct gs_console {
 	struct work_struct	work;
 	spinlock_t		lock;
 	struct usb_request	*req;
+	bool			busy;
 	struct kfifo		buf;
 	size_t			missed;
+	struct kref		kref;
 };
 
 /*
@@ -998,46 +1001,81 @@ static struct tty_driver *gs_tty_driver;
 
 #ifdef CONFIG_U_SERIAL_CONSOLE
 
+static void gs_console_release(struct kref *kref)
+{
+	struct gs_console *cons = container_of(kref, struct gs_console, kref);
+
+	kfifo_free(&cons->buf);
+	kfree(cons);
+}
+
+/*
+ * Free a request that gs_console_disconnect() orphaned while it was busy,
+ * and drop the reference it took for it. Called without cons->lock.
+ */
+static void gs_console_free_orphaned(struct gs_console *cons,
+				     struct usb_ep *ep, struct usb_request *req)
+{
+	gs_free_req(ep, req);
+	kref_put(&cons->kref, gs_console_release);
+}
+
 static void gs_console_complete_out(struct usb_ep *ep, struct usb_request *req)
 {
 	struct gs_console *cons = req->context;
+	bool push = true;
+	bool orphaned;
 
 	switch (req->status) {
 	default:
 		pr_warn("%s: unexpected %s status %d\n",
 			__func__, ep->name, req->status);
-		fallthrough;
+		break;
 	case 0:
 		/* normal completion */
-		spin_lock(&cons->lock);
-		req->length = 0;
-		schedule_work(&cons->work);
-		spin_unlock(&cons->lock);
 		break;
 	case -ECONNRESET:
 	case -ESHUTDOWN:
 		/* disconnect */
 		pr_vdebug("%s: %s shutdown\n", __func__, ep->name);
+		push = false;
 		break;
 	}
+
+	spin_lock(&cons->lock);
+	orphaned = req != cons->req;
+	if (!orphaned) {
+		cons->busy = false;
+		if (push)
+			schedule_work(&cons->work);
+	}
+	spin_unlock(&cons->lock);
+
+	if (orphaned)
+		gs_console_free_orphaned(cons, ep, req);
 }
 
-static void __gs_console_push(struct gs_console *cons)
+static void gs_console_work(struct work_struct *work)
 {
-	struct usb_request *req = cons->req;
+	struct gs_console *cons = container_of(work, struct gs_console, work);
+	struct usb_request *req;
 	struct usb_ep *ep;
+	bool orphaned;
 	size_t size;
 
-	if (!req)
-		return;	/* disconnected */
+	spin_lock_irq(&cons->lock);
 
-	if (req->length)
-		return;	/* busy */
+	req = cons->req;
+	if (!req)
+		goto unlock;	/* disconnected */
+
+	if (cons->busy)
+		goto unlock;	/* busy */
 
 	ep = cons->console.data;
 	size = kfifo_out(&cons->buf, req->buf, ep->maxpacket);
 	if (!size)
-		return;
+		goto unlock;
 
 	if (cons->missed && ep->maxpacket >= 64) {
 		char buf[64];
@@ -1049,21 +1087,24 @@ static void __gs_console_push(struct gs_console *cons)
 	}
 
 	req->length = size;
+	cons->busy = true;
 
 	spin_unlock_irq(&cons->lock);
-	if (usb_ep_queue(ep, req, GFP_ATOMIC))
-		req->length = 0;
-	spin_lock_irq(&cons->lock);
-}
 
-static void gs_console_work(struct work_struct *work)
-{
-	struct gs_console *cons = container_of(work, struct gs_console, work);
+	if (!usb_ep_queue(ep, req, GFP_ATOMIC))
+		return;
 
 	spin_lock_irq(&cons->lock);
+	orphaned = req != cons->req;
+	if (!orphaned)
+		cons->busy = false;
+	spin_unlock_irq(&cons->lock);
 
-	__gs_console_push(cons);
+	if (orphaned)
+		gs_console_free_orphaned(cons, ep, req);
+	return;
 
+unlock:
 	spin_unlock_irq(&cons->lock);
 }
 
@@ -1080,7 +1121,7 @@ static void gs_console_write(struct console *co,
 	if (n < count)
 		cons->missed += count - n;
 
-	if (cons->req && !cons->req->length)
+	if (cons->req && !cons->busy)
 		schedule_work(&cons->work);
 
 	spin_unlock_irqrestore(&cons->lock, flags);
@@ -1107,7 +1148,6 @@ static int gs_console_connect(struct gs_port *port)
 		return -ENOMEM;
 	req->complete = gs_console_complete_out;
 	req->context = cons;
-	req->length = 0;
 
 	spin_lock(&cons->lock);
 	cons->req = req;
@@ -1126,6 +1166,7 @@ static void gs_console_disconnect(struct gs_port *port)
 	struct gs_console *cons = port->console;
 	struct usb_request *req;
 	struct usb_ep *ep;
+	bool busy;
 
 	if (!cons)
 		return;
@@ -1134,15 +1175,22 @@ static void gs_console_disconnect(struct gs_port *port)
 
 	req = cons->req;
 	ep = cons->console.data;
+	busy = cons->busy;
 	cons->req = NULL;
+	cons->busy = false;
+	/*
+	 * A busy request is queued, or being queued by gs_console_work(). The
+	 * console gives it up here, and the orphaned request is freed when it
+	 * comes back: by its completion, or by gs_console_work() if
+	 * usb_ep_queue() fails. It holds a reference on the console until then.
+	 */
+	if (busy)
+		kref_get(&cons->kref);
 
 	spin_unlock(&cons->lock);
 
-	if (!req)
-		return;
-
-	usb_ep_dequeue(ep, req);
-	gs_free_req(ep, req);
+	if (req && !busy)
+		gs_free_req(ep, req);
 }
 
 static int gs_console_init(struct gs_port *port)
@@ -1165,6 +1213,7 @@ static int gs_console_init(struct gs_port *port)
 
 	INIT_WORK(&cons->work, gs_console_work);
 	spin_lock_init(&cons->lock);
+	kref_init(&cons->kref);
 
 	err = kfifo_alloc(&cons->buf, GS_CONSOLE_BUF_SIZE, GFP_KERNEL);
 	if (err) {
@@ -1187,21 +1236,44 @@ static int gs_console_init(struct gs_port *port)
 static void gs_console_exit(struct gs_port *port)
 {
 	struct gs_console *cons = port->console;
+	struct usb_request *req;
+	struct usb_ep *ep;
 
 	if (!cons)
 		return;
 
 	unregister_console(&cons->console);
 
+	/*
+	 * Drop the unsent output and wait for a push in progress, so that the
+	 * request is busy below only if it is queued.
+	 */
+	spin_lock_irq(&cons->lock);
+	kfifo_reset(&cons->buf);
+	spin_unlock_irq(&cons->lock);
+	cancel_work_sync(&cons->work);
+
 	spin_lock_irq(&port->port_lock);
+
+	/*
+	 * Nothing gives a queued request back here, so cancel it. Holding
+	 * port_lock keeps a disconnect from orphaning it, so it cannot be
+	 * freed under usb_ep_dequeue().
+	 */
+	spin_lock(&cons->lock);
+	req = cons->busy ? cons->req : NULL;
+	ep = cons->console.data;
+	spin_unlock(&cons->lock);
+	if (req)
+		usb_ep_dequeue(ep, req);
+
 	if (cons->req)
 		gs_console_disconnect(port);
 	port->console = NULL;
 	spin_unlock_irq(&port->port_lock);
 
 	cancel_work_sync(&cons->work);
-	kfifo_free(&cons->buf);
-	kfree(cons);
+	kref_put(&cons->kref, gs_console_release);
 }
 
 ssize_t gserial_set_console(unsigned char port_num, const char *page, size_t count)

-- 
2.56.1


