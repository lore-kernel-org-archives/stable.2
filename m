Authentication-Results: smtp.subspace.kernel.org; arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
ARC-Seal: i=2; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=pass;
	t=1793749313;
	b=YIkFuTOicYMJ+5R9euIn3XjfJF7UIlSqVzcii6cKb4C6iyoUSOgY/vvX7ekUa0t1BImD
	 YTgaPtoNUujoioq1St87IJv+SNCx51H7mTguAQbIGXNUC9As1EV4E2x3994Cba6Y5D7hf
	 lBCa26a1eMdUvP9SIiF3EGCegQjKN39+Tu7OiQoODt6nprocdTx9DPRIDVD/04U8MGFCc
	 VaFoTbA2gYPFKIDmuvBWpNC8aUHYUZW+rIdQjnfbpBNW+5QX7RQUQbM99zhwIUfv2qoTb
	 ZsDzsNxEpzAyMR1S6F3Qnr/bFvQFPM55aNAUjc4VaTxMoCcSEsI94vnGdHe4hxJc5wQ==
ARC-Message-Signature: i=2; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793749313;
	h=Received:DKIM-Signature:Received:From:Date:Subject:MIME-Version:
	 Content-Type:Message-Id:X-B4-Tracking:To:Cc:X-Mailer:
	 X-Developer-Signature:X-Developer-Key:X-Endpoint-Received:
	 X-Original-From:Reply-To:Content-Transfer-Encoding;
	bh=upTfiQRy+DzSxk9UIPPnCZDadurRE8rswVOHeOJf8Eg=;
	b=lYV6GMn4GzY5YuPAfJbfxRGqxfY2stwZ71Z4tSJbNCe6vxHzB9BvuUhOP4EWwWvyLQau
	 8BkV/PNIvXKkkq8LzvHVkpzKZB5QVPDqM9yiQFBtlE9uSpaq8RhjhrA1VJW03hKt88vF+
	 G7jpleVQZkCL9nv3Am6InuUJRDbnXqQBstI2lrN/fZ6xfDYtNsriAyygJZCTbpu3mzAkg
	 Sn1VFwA+O+hdUzVCiB7MngLJUM74CEIRiPF28DsSb2ruHo3f85iZaHH3ZiOVR/xK5rdfc
	 BZUAvCEgUzgAvXMQnF5Y2HBbA7rPPPIuL+6iGN3UZYR9momNMpihCEHKNwszx6twvsQ==
ARC-Authentication-Results: i=2; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k54oUhuJ;
	arc=pass header.oldest-pass=0 smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5F2D606A324;
	Tue,  3 Nov 2026 23:41:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=k54oUhuJ
Authentication-Results: smtp.kernel.org; arc=none smtp.remote-ip=100.80.115.77
ARC-Seal: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256; cv=none;
	t=1793749312;
	b=dZvFKvjQ+u+IkvmDlv4aIUsT1Xp7/fU5zjxCbOSHljouYuzGiL9RqNXWcWqxTQx3YdCY
	 eH75yL0Xf1ZllXcwj8SCUah8TaxBQZpjeMVDFtNnO2Z/sHiQpbBbsxWqAB+L2HIbrzC73
	 Pp4hDygWKHoQzsMsRzyhQClUru0/ZL/WgV0T6hnEwub6MmY3sBKnkwowwLwWTkmQ2wKb0
	 qsMCgI/Gym2TmH6rfgBRn8PE685sbRO/2oYW23NkB0qLprJu5NjHNjWPeMf142FW26WVy
	 GgJ8lG1dEytVK95WXohD7s/it3AgcLL0Fx2li+21XV6Xk/RnCeIXzfmpK7Hf/PXVS4w==
ARC-Message-Signature: i=1; d=kernel.org; s=arc20260519; a=rsa-sha256;
	c=relaxed/relaxed; t=1793749312;
	h=DKIM-Signature:Received:From:Date:Subject:MIME-Version:Content-Type:
	 Message-Id:X-B4-Tracking:To:Cc:X-Mailer:X-Developer-Signature:
	 X-Developer-Key:X-Endpoint-Received:X-Original-From:Reply-To:
	 Content-Transfer-Encoding;
	bh=upTfiQRy+DzSxk9UIPPnCZDadurRE8rswVOHeOJf8Eg=;
	b=QI6XR1YuZTHTvc8NpcgnwTq9lzSxjqz2E3SGyy1vRiL/9pfKhs7SLgq8xPd+KPrbzxWV
	 jf1Y866vmOeZZCjQjqmY4rRJR0/Pu9WLyaR2AxnyPj/oz5fWpDUa6jOI0+f2mQfqiGh16
	 cOzxfW1Fk5Hg3HroczIy/S92nTzAt3dBcwYVx65tywUV/CvdG4UzojmX79nn5LapWx637
	 ynl9/lnHVUTtavQJ5iBTyi1mVBC+sfHrnIN6ePClUdeeLltIYg/hhwVwi9gZ9cm45k8UH
	 oyGcKLyNT0UWf8u4e0JaXHqMa/2HeYKSWqt9Oz1CXE1twMmSaiE8eLMDYzYAP172c3Q==
ARC-Authentication-Results: i=1; smtp.kernel.org; 
	arc=none smtp.remote-ip=100.80.115.77
Received: from lkml.kernel.org (nexus.subspace.kernel.org [100.80.115.77])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.kernel.org (Postfix) with ESMTPS id 78D541F000C1;
	Tue,  3 Nov 2026 23:41:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793749312;
	bh=upTfiQRy+DzSxk9UIPPnCZDadurRE8rswVOHeOJf8Eg=;
	h=From:Date:Subject:To:Cc:Reply-To;
	b=k54oUhuJybkreWCynO4qR+7dEnL8a1A9SOIg2LLtzR0OpA9ExXWO+PA5aABf4vVB7
	 YvoV5cq5wx7rjcqGAklJQvZZ3POXp6xtOPy4jiMJQqR7z9wZwbRUBWhpIarpilMVW8
	 G6zcIviZMVrq9HqC1WuHoKbkE0F9b3YS5tGk3c4i6DXXE354M+RBpNS/gHIPX2Ye+6
	 7OYAOqxBL2rRw4+0w2v7X2lsHw/XmxM15mWf463S9H25YHkkh1WiYCtrV4exaPeJO7
	 jPruAaS/sfavFOYS0KI6cYsK75rU04ToRdUTaTCMtla6Y53ZfZt6GLlxuM31n+Ptgq
	 FMpo/mfGWDRQA==
Received: from nexus.subspace.kernel.org (localhost [IPv6:::1])
	by lkml.kernel.org (Postfix) with ESMTP id C682C46B87;
	Tue,  3 Nov 2026 23:41:50 +0000 (UTC)
From: Joas Antonio dos Santos via B4 Relay <devnull+joasantonio108.gmail.com@kernel.org>
Date: Tue, 03 Nov 2026 23:41:51 +0000
Subject: [PATCH] serial: 8250: fix use-after-free of IRQ action name on
 port removal
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
Message-Id: <20261103-serial-8250-irq-uaf-v1-1-24223dcc3119@gmail.com>
X-B4-Tracking: v=1; b=H4sIAD5x6moC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzNDQwNjXZD6xBxdCyNTA93MokLd0sQ0XYMUA+M0i0QTi0RLCyWgzoKi1LT
 MCrCp0bG1tQDmZD5zZQAAAA==
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Jiri Slaby <jirislaby@kernel.org>
Cc: linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org, 
 stable@vger.kernel.org, 
 syzbot+bc6b37960b1d13f68f9f@syzkaller.appspotmail.com, 
 Joas Antonio dos Santos <joasantonio108@gmail.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1793749310; l=3589;
 i=joasantonio108@gmail.com; s=20261031; h=from:subject:message-id;
 bh=Vj1DUOXxenSAPPDmSUT0HtmMZVzSOWReRJpl/rpE5m0=;
 b=RtK5sce09jMCtpUzz10809eZmaAN2TcxLlFael8IJpcwKhsR0wJZYm3UPfvtQqtuZ2Vjtn6l1
 9hl+ZqqFMV+C28dIDEk1Lbxc8PkFg4qTOt6jy+w5m8/sVYfWOeDocGp
X-Developer-Key: i=joasantonio108@gmail.com; a=ed25519;
 pk=ZxAznJT/FcPPdzLrDDFJQm4LLjjHVGBBqDSG3TXS23w=
X-Endpoint-Received: by B4 Relay for joasantonio108@gmail.com/20261031 with
 auth_id=1371
X-Original-From: Joas Antonio dos Santos <joasantonio108@gmail.com>
Reply-To: joasantonio108@gmail.com
Content-Transfer-Encoding: 7bit

From: Joas Antonio dos Santos <joasantonio108@gmail.com>

serial_link_irq_chain() passes up->port.name directly to request_irq().
The IRQ subsystem stores this pointer in irqaction->name without copying
the string.

When the port that originally called request_irq() is removed while
other ports still share the same IRQ:

  1. serial_unlink_irq_chain() removes the port from the shared list
  2. Since other ports remain, free_irq() is NOT called
  3. irqaction->name still references the removed port's name string
  4. serial_core_remove_one_port() frees uport->name (kfree at line 3292)
  5. irqaction->name becomes a dangling pointer

Any subsequent read of /proc/interrupts dereferences the freed string
via show_interrupts() -> seq_printf("%s", action->name), triggering a
KASAN slab-use-after-free on the freed kmalloc-8 object.

Fix by giving struct irq_info ownership of the name string passed to
request_irq().  serial_get_or_create_irq_info() now kstrdup()s the port
name into irq_info->name when creating a new irq_info, and
serial_do_unlink() frees it alongside the irq_info.  This decouples the
IRQ action name lifetime from any individual port's lifetime.

Found by LLM-assisted code review of syzbot-reported crash patterns.

Reported-by: syzbot+bc6b37960b1d13f68f9f@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=bc6b37960b1d13f68f9f
Fixes: f7048b15900f ("tty: serial_core: Add name field to uart_port struct")
Cc: stable@vger.kernel.org
Signed-off-by: Joas Antonio dos Santos <joasantonio108@gmail.com>
---
serial_link_irq_chain() passes up->port.name directly to request_irq().
When the first port sharing an IRQ is removed, kfree(uport->name) frees
the string while irqaction->name still references it.  Reading
/proc/interrupts then triggers a KASAN slab-use-after-free.

syzbot link: https://syzkaller.appspot.com/bug?extid=bc6b37960b1d13f68f9f
---
 drivers/tty/serial/8250/8250_core.c | 10 +++++++++-
 1 file changed, 9 insertions(+), 1 deletion(-)

diff --git a/drivers/tty/serial/8250/8250_core.c b/drivers/tty/serial/8250/8250_core.c
index 42319843c..f73113daa 100644
--- a/drivers/tty/serial/8250/8250_core.c
+++ b/drivers/tty/serial/8250/8250_core.c
@@ -47,6 +47,7 @@ struct irq_info {
 	int			irq;
 	spinlock_t		lock;	/* Protects list not the hash */
 	struct list_head	*head;
+	const char		*name;	/* owned copy for request_irq() */
 };
 
 #define IRQ_HASH_BITS		5	/* Can be adjusted later */
@@ -122,6 +123,7 @@ static void serial_do_unlink(struct irq_info *i, struct uart_8250_port *up)
 	/* List empty so throw away the hash node */
 	if (i->head == NULL) {
 		hlist_del(&i->node);
+		kfree(i->name);
 		kfree(i);
 	}
 }
@@ -145,6 +147,12 @@ static struct irq_info *serial_get_or_create_irq_info(const struct uart_8250_por
 	if (i == NULL)
 		return ERR_PTR(-ENOMEM);
 
+	i->name = kstrdup(up->port.name, GFP_KERNEL);
+	if (!i->name) {
+		kfree(i);
+		return ERR_PTR(-ENOMEM);
+	}
+
 	spin_lock_init(&i->lock);
 	i->irq = up->port.irq;
 	hash_add(irq_lists, &i->node, i->irq);
@@ -172,7 +180,7 @@ static int serial_link_irq_chain(struct uart_8250_port *up)
 		i->head = &up->list;
 	}
 
-	ret = request_irq(up->port.irq, serial8250_interrupt, up->port.irqflags, up->port.name, i);
+	ret = request_irq(up->port.irq, serial8250_interrupt, up->port.irqflags, i->name, i);
 	if (ret < 0)
 		serial_do_unlink(i, up);
 

---
base-commit: 05441d697f7f9a927264f4058cbbc6a03dfcac9d
change-id: 20261103-serial-8250-irq-uaf-0d03f8a48a98

Best regards,
-- 
Joas Antonio dos Santos <joasantonio108@gmail.com>


