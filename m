Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795705468;
	b=W9+qHa4QS5gaQCkKt8+AtN3KhcQhFFn952KusLeSwB81mxPBiTfGh8teZ5wzbpwFLn8x
	 Ai5kxxfpy3N4zFoy4nXHQ7Q2qaLFLYUBiZ/biSPk625Z1BS/e/405hQwKxQES6thRKtNg
	 sZu3S7OgAYTorsE8QFsdELmPiX4AInBnyi9niCpgjfSwbeVfoPE9WLbMx7eixFE85jJjw
	 myIUbQ7clDgE+/8daF8NOHBk2w3QbVOmt3z3pfmykX0puFfljonGFrbeMj7TfQQhNH9nj
	 N1mtybt1vzKQE4xAN+Z5qYVqoDNbnX7vpOxn3gkT0ZzdhQp8Fj9VSnbQtZjD4oRMpdQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795705468;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=46vr+tNfvgw0z/JttHWsqmE/sZvMU3Hw1eiqBmywgIM=;
	b=ki1E/0CbJJ1F6HC6c/6bu/AYAriKehTOYGuGDw+MuVxYjQKbBHqP6/T4oCbFC1VpFa1v
	 dVA+Oo64NDwn64MEI8wzzI+3CyPAjusYToVvu1pAE0/j6kFBPlUJoy1e99Y7UKS8P6a+q
	 yWWe3uwxZAdOfdstZPwIvwHgQ/Y7FCE6BPSoGn9JN7rGFHIuqJ4bNrDeBbxsyljyAwnV6
	 E7v7Ou9wiislnuSBPX6Hhq4Q23e5aMZVrIGGsUYf0fXaAIs/HAwiw8mjskhpcn9gzeJML
	 lsMiDxC20AcblysCN8EuM2CyWO3eQR5dq+qYPbSsBlhWqzCfwZAw55Kqgm2mU90Y64g==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gXJnUIsE;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E63B606A338
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 15:04:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gXJnUIsE
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1002E1F000C0;
	Thu, 26 Nov 2026 15:04:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795705467;
	bh=46vr+tNfvgw0z/JttHWsqmE/sZvMU3Hw1eiqBmywgIM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=gXJnUIsENct9IIIhU/uC4ANQhB844Gh5xjuCzFnyIDV26cnon17yK/Xm7coOuoXX3
	 qbYTL1curgz8XWHh0KbVuuu4ndxz/uVll+PidRNz2sjiCzXgvuGEXToF3847Aaa7Ws
	 Gk53U62yIzay9qL16bNRSVViE+1EBlAfrDQOlPt5yEFHO6F0JJRbStGBZDpYsVGYZ6
	 wytm5vwQRM15RkyNwT4KTe+cNBzHQ74DWd7aJhIQhYUn+TxPwU+TjGxO/tgUi3ul6Y
	 sMytwNK9wDKuZQ9MYRSwDtIzYblas4zu317UB95UET8q21RZn8Ci8Pz/DELqWGtxWw
	 OyztB3EGtZltA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Chris Mason <mason@kernel.org>,
	stable <stable@kernel.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Nicolas Pitre <npitre@baylibre.com>,
	Kees Cook <kees+treewide@kernel.org>,
	Joshua Rogers <linux@joshua.hu>,
	Helge Deller <deller@gmx.de>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	Mingyu Wang <25181214217@stu.xidian.edu.cn>,
	Randy Dunlap <rdunlap@infradead.org>,
	Ronan Pigott <ronan@rjp.ie>,
	Liav Mordouch <liavmordouch@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] vt: serialise the producers of the flip buffer
Date: Thu, 26 Nov 2026 10:04:24 -0500
Message-ID: <20261126150358.2214600-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112548-finale-enigmatic-9f31@gregkh>
References: <2026112548-finale-enigmatic-9f31@gregkh>
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

From: Chris Mason <mason@kernel.org>

[ Upstream commit 5d1d814408c1c8e797031eac8ddd40de1a9e8e93 ]

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
[ sashal: Kept the older puts_queue() per-character insert loop and added the guard(spinlock_irqsave) line above it, since the tree lacks the tty_insert_flip_string() form that upstream's context expects. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/vt/keyboard.c | 6 ++++++
 drivers/tty/vt/vt.c       | 2 ++
 2 files changed, 8 insertions(+)

diff --git a/drivers/tty/vt/keyboard.c b/drivers/tty/vt/keyboard.c
index 1f0b93126f69b..ef00f5675397d 100644
--- a/drivers/tty/vt/keyboard.c
+++ b/drivers/tty/vt/keyboard.c
@@ -307,15 +307,20 @@ int kbd_rate(struct kbd_repeat *rpt)
 
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
 
 static void puts_queue(struct vc_data *vc, char *cp)
 {
+	guard(spinlock_irqsave)(&vc->port.lock);
 	while (*cp) {
 		tty_insert_flip_char(&vc->port, *cp, 0);
 		cp++;
@@ -564,6 +569,7 @@ static void fn_inc_console(struct vc_data *vc)
 
 static void fn_send_intr(struct vc_data *vc)
 {
+	guard(spinlock_irqsave)(&vc->port.lock);
 	tty_insert_flip_char(&vc->port, 0, TTY_BREAK);
 	tty_flip_buffer_push(&vc->port);
 }
diff --git a/drivers/tty/vt/vt.c b/drivers/tty/vt/vt.c
index 474f6abc900b0..82a868ef0aa5c 100644
--- a/drivers/tty/vt/vt.c
+++ b/drivers/tty/vt/vt.c
@@ -1835,6 +1835,8 @@ static void csi_m(struct vc_data *vc)
 
 static void respond_string(const char *p, size_t len, struct tty_port *port)
 {
+	/* The keyboard handler feeds the same flip buffer. */
+	guard(spinlock_irqsave)(&port->lock);
 	tty_insert_flip_string(port, p, len);
 	tty_flip_buffer_push(port);
 }
-- 
2.53.0

