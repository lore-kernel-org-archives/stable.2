Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609420;
	b=oTG+9odXpqC/zDj0mk+ByUTlVaMdBpr7tQPxObbCsZ8jnCXVl640J6O3EPy1nczWHTSa
	 7fIZNwZDpsSn2VxG3/CeeEWOEfQ19zQ6kRbKaGOgmrtWTwbD8Pw5oU1raMEnWCk2h7+FV
	 SgBuCDuuQwhmddK6A4NKuIYWuaQzrhTDNTtAoU9vBUOuxZqDKEUQ1ub1qTW2ZUP6kyK1k
	 bpA3piUlq5NjGOGxNolzY67Br/4yndPHMBmbo6VHl7pvaZIVPkee9mmMq5d3fX7BctxfR
	 5Vorit5rjOfqtZZohTRE9JVmdwo0an0L6GBc7VYIJLNXmQCGCff86Q+xm2ZZ/dq85MQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609420;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=kZ8+jLcmDLRIqaVaSIx5WG5f4arCLFD8ibxouv9+ktg=;
	b=d5eXHzLEpgH8oY6D9lagbgMjNlYd33iXCkZqYCfu3htpbfC5jBRDYo60lMsKGI71gcAJ
	 y3gDRVIdzx0WIc8fCjGtR8wATHDb4zORa+Egcih1alFEYrBAeb3BvpIDjulHTGivIlDwL
	 OKuLmIdlI2drS8l6oO/XQXa/FbwU//0JhGpWcOvpZpB+HALVZZ94oujIBuZOHXRGqzgwK
	 Pn2R0y8Erf5ErZoAnuWVp7m7UnZZz9MQTEajJo8txOWa4d4DwRrLsNGZOYWEI4AnhklKs
	 +cYXfPjWWqzyDjWgemTyJZvZKmT+gec7X9q4Ydcc4L3LfgfxYXwALH0TT7qMcpmIQww==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=EM1rmSOJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2ABD7606A31E
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:23:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=EM1rmSOJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C4441F000C0;
	Wed, 25 Nov 2026 12:23:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795609419;
	bh=kZ8+jLcmDLRIqaVaSIx5WG5f4arCLFD8ibxouv9+ktg=;
	h=Subject:To:Cc:From:Date;
	b=EM1rmSOJiAWiz/6a30DdqJY8/nd3huioVZE7Q9mvUMf388RTEC0ppUA3mghJug794
	 clmtxW+7hfo/IU+5spqIVVwFTkYhr23E6nErDgetUawTY5CcarES3MG5yCZmQPgdlv
	 /VzCVwgqGdycsjQ5AMu2gdKIAaqgpupORBXNcEww=
Subject: FAILED: patch "[PATCH] USB: serial: upd78f0730: fix NULL-deref on hangup" failed to apply to 5.10-stable tree
To: johan@kernel.org,maksim.salau@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:17:03 +0100
Message-ID: <2026112503-unused-cognition-ac3b@gregkh>
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
git cherry-pick -x 0e0b1fcfb80c0490bda7f7eb633ebb5e431c2e16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112503-unused-cognition-ac3b@gregkh' --subject-prefix 'PATCH 5.10.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 0e0b1fcfb80c0490bda7f7eb633ebb5e431c2e16 Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Mon, 19 Oct 2026 14:34:12 +0200
Subject: [PATCH] USB: serial: upd78f0730: fix NULL-deref on hangup

The port tty pointer is cleared on hangup before deasserting the modem
control signals and should not be used in the dtr_rts() callback.

Factor out a new upd78f0730_port_tiocmset() helper that can be used in
upd78f0730_dtr_rts() to avoid dereferencing a NULL-pointer on hangup
(e.g. on disconnect).

This issue was flagged by an LLM.

Fixes: ea534e0b4047 ("USB: serial: add uPD78F0730 USB to Serial Adaptor Driver")
Cc: stable@vger.kernel.org	# 4.11
Cc: Maksim Salau <maksim.salau@gmail.com>
Signed-off-by: Johan Hovold <johan@kernel.org>

diff --git a/drivers/usb/serial/upd78f0730.c b/drivers/usb/serial/upd78f0730.c
index 78c4d3c19a8e..f2189b994ed7 100644
--- a/drivers/usb/serial/upd78f0730.c
+++ b/drivers/usb/serial/upd78f0730.c
@@ -201,10 +201,9 @@ static int upd78f0730_tiocmget(struct tty_struct *tty)
 	return res;
 }
 
-static int upd78f0730_tiocmset(struct tty_struct *tty,
+static int upd78f0730_port_tiocmset(struct usb_serial_port *port,
 			unsigned int set, unsigned int clear)
 {
-	struct usb_serial_port *port = tty->driver_data;
 	struct upd78f0730_port_private *private;
 	struct upd78f0730_set_dtr_rts request;
 	struct device *dev = &port->dev;
@@ -238,6 +237,13 @@ static int upd78f0730_tiocmset(struct tty_struct *tty,
 	return res;
 }
 
+static int upd78f0730_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
+{
+	struct usb_serial_port *port = tty->driver_data;
+
+	return upd78f0730_port_tiocmset(port, set, clear);
+}
+
 static int upd78f0730_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct upd78f0730_port_private *private;
@@ -267,7 +273,6 @@ static int upd78f0730_break_ctl(struct tty_struct *tty, int break_state)
 
 static void upd78f0730_dtr_rts(struct usb_serial_port *port, int on)
 {
-	struct tty_struct *tty = port->port.tty;
 	unsigned int set = 0;
 	unsigned int clear = 0;
 
@@ -276,7 +281,7 @@ static void upd78f0730_dtr_rts(struct usb_serial_port *port, int on)
 	else
 		clear = TIOCM_DTR | TIOCM_RTS;
 
-	upd78f0730_tiocmset(tty, set, clear);
+	upd78f0730_port_tiocmset(port, set, clear);
 }
 
 static speed_t upd78f0730_get_baud_rate(struct tty_struct *tty)

