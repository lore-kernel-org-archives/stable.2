Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795606416;
	b=g4x2lVFbPaDAk9Vlx2Fd27ERHz4nLOcaopFFL7GDvVtmr2yS3NA2xoeyJTdsNFMSxvrx
	 fZQGt8kkoRxjb6IyKstfjBdpomJ0YMsE22n6BF1fiVHxRdFMTcY2v1tbjRpO9s8NwpT4H
	 JK/xHzHtzjP82oEun+jJ3Cmm0XSeOLEicWTc/ocsvZeftm1zZdJp9dbHIebgkmVUkdNo1
	 wyAUynqdlNwbskQPhgu/Sb0qXbdK4hxXI5aYRlyMr67kyx1NZLizR5jyl8WKQ8FnJrNXy
	 B95cOnQ0c3NkH5IYdXAPNiW/10JhBxRJE5wQiwO2LDR+qiDDSAIBVmNDxfUpk3PfqlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795606416;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=i5u0+aZ+4zBe8vsiyrT9Q9mmH8v2CrSKxwdimgnHb4Q=;
	b=T/rTYkcBB/KEQ2bybzFc89lJCd7jnCzJyCENiFbdxVkkTx6m2PmHJeG3UHogOxbPawpM
	 zff+vSebSy3a+1eKVQhLx37bGyyHbPDG8XQIIoGPEl+lPpa/pcCj5q20ODZzkjqomFIjX
	 hTc/qj7Zs1uKNM2r5DAP0RjUp8RC7aGNmCecpVErQfoPr0PwOcJgoQ5OFctfHG9y5pRd5
	 HUJU1XwLs/9DiL5u2xbEjbcuaPpMU5LqoT4MWf8gts99794gd/7mQw37UPxiAHVLvHzoY
	 sMYJgVc9JCqXFumGxWXnxRo4yJpDIq/NIbSUmqpwJRlUxXTZaPJuGVTaa0LEfOYkHJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0chd5fo8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 19F34606A321
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 11:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=0chd5fo8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5265E1F000D4;
	Wed, 25 Nov 2026 11:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795606415;
	bh=i5u0+aZ+4zBe8vsiyrT9Q9mmH8v2CrSKxwdimgnHb4Q=;
	h=Subject:To:Cc:From:Date;
	b=0chd5fo8TmpseU43yOUh9IGsiR0MCYE+qNKQvq4DRia3OabN+slneFp6P6az2NPpU
	 oy60To+893EUYqkRt0ZBtngollAkmqLb2rhjwrSX9AbO6D+MZ2SJR6Hrxywz6fshk6
	 z/NTsxlQBlQ3XfBc8d4GWcjQEAK/ld8IJkPQI+s0=
Subject: FAILED: patch "[PATCH] vt: serialise the producers of the flip buffer" failed to apply to 5.10-stable tree
To: mason@kernel.org,25181214217@stu.xidian.edu.cn,deller@gmx.de,gregkh@linuxfoundation.org,jirislaby@kernel.org,kees+treewide@kernel.org,liavmordouch@gmail.com,linux@joshua.hu,npitre@baylibre.com,rdunlap@infradead.org,ronan@rjp.ie,stable@kernel.org,tzimmermann@suse.de
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 12:24:48 +0100
Message-ID: <2026112548-finale-enigmatic-9f31@gregkh>
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


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 5d1d814408c1c8e797031eac8ddd40de1a9e8e93
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112548-finale-enigmatic-9f31@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 5d1d814408c1c8e797031eac8ddd40de1a9e8e93 Mon Sep 17 00:00:00 2001
From: Chris Mason <mason@kernel.org>
Date: Tue, 27 Oct 2026 12:06:27 +0100
Subject: [PATCH] vt: serialise the producers of the flip buffer

Typing on a virtual console while the console replies to an escape
sequence can make the kernel write past the end of a buffer. A user who
can write to the foreground console can cause this on purpose if they
can also inject key events, through /dev/uinput or by writing to the
/dev/input/event* node of a keyboard.

Input for a tty goes through the flip buffer of its port. A driver
inserts the data with tty_insert_flip_*() and then calls
tty_flip_buffer_push() to pass it on to the line discipline. The insert
functions take no lock: they check that the current struct tty_buffer
has room, copy the data to offset ->used, and then advance ->used. So a
flip buffer supports only one producer at a time, and a driver that has
several must serialise them.

Four functions feed the flip buffer of a virtual console:

- put_queue(), puts_queue() and fn_send_intr() insert typed characters
  and breaks for the keyboard handler. They run under kbd_event_lock.
- respond_string() inserts the reply when a program writes an escape
  sequence that requests one, such as a cursor position report. It runs
  under the console lock.

The keyboard handler gets its events from the input layer and feeds the
foreground console. Key events that a program writes to /dev/uinput or
to an event node reach it in the same way as typed keys.

The keyboard handler and respond_string() share no lock, so they can
interleave:

    keyboard handler                respond_string()
    ================                ================
    room check passes
                                    room check passes
    memcpy() to offset used
    used += len
                                    memcpy() to offset used
                                    used += len
                                      /* used > size of the buffer */

The room check subtracts ->used from the size, and both are unsigned.
Once ->used exceeds the size, the result wraps, so the check always
passes, and each later insert lands further past the buffer.

Reproduced as root, with keys from a uinput keyboard and cursor position
reports on the same console: KFENCE reported an out-of-bounds write
1,024 bytes past the buffer in under 10 s.

Fix this by taking port->lock, with interrupts disabled, around the
insert and the push in these four functions. kbd_keycode() already takes
port->lock under kbd_event_lock, so this lock ordering is not new.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Cc: stable <stable@kernel.org>
Cc: Jiri Slaby <jirislaby@kernel.org>
Cc: Nicolas Pitre <npitre@baylibre.com>
Cc: Kees Cook <kees+treewide@kernel.org>
Cc: Joshua Rogers <linux@joshua.hu>
Cc: Chris Mason <mason@kernel.org>
Cc: Helge Deller <deller@gmx.de>
Cc: Thomas Zimmermann <tzimmermann@suse.de>
Cc: Mingyu Wang <25181214217@stu.xidian.edu.cn>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: Ronan Pigott <ronan@rjp.ie>
Cc: Liav Mordouch <liavmordouch@gmail.com>
Signed-off-by: Chris Mason <mason@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Link: https://patch.msgid.link/20261027-tty-llm-v1-1-99b0202ae546@linuxfoundation.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index ef4a19aeb3ce..f4b742e091fb 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -322,15 +322,20 @@ int kbd_rate(struct kbd_repeat *rpt)
 
 /*
  * Helper Functions.
+ *
+ * A flip buffer allows one producer at a time, and respond_string() in vt.c
+ * feeds the same one under the console lock. So take the lock of the port.
  */
 static void put_queue(struct vc_data *vc, int ch)
 {
+	guard(spinlock_irqsave)(&vc->port.lock);
 	tty_insert_flip_char(&vc->port, ch, 0);
 	tty_flip_buffer_push(&vc->port);
 }
 
 static void puts_queue(struct vc_data *vc, const char *cp)
 {
+	guard(spinlock_irqsave)(&vc->port.lock);
 	tty_insert_flip_string(&vc->port, cp, strlen(cp));
 	tty_flip_buffer_push(&vc->port);
 }
@@ -587,6 +592,7 @@ static void fn_inc_console(struct vc_data *vc)
 
 static void fn_send_intr(struct vc_data *vc)
 {
+	guard(spinlock_irqsave)(&vc->port.lock);
 	tty_insert_flip_char(&vc->port, 0, TTY_BREAK);
 	tty_flip_buffer_push(&vc->port);
 }
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 7dbc0072a40a..6a6eb8b2a6de 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1971,6 +1971,8 @@ static void csi_m(struct vc_data *vc)
 
 static void respond_string(const char *p, size_t len, struct tty_port *port)
 {
+	/* The keyboard handler feeds the same flip buffer. */
+	guard(spinlock_irqsave)(&port->lock);
 	tty_insert_flip_string(port, p, len);
 	tty_flip_buffer_push(port);
 }

