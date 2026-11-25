Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795609423;
	b=p4ByeC9SEQGx0VvSMf4RcMEJVdHlPqNjXqI+GKp3qZN5ACLnW67EDkohN4ibkJvC9Dtp
	 6i4de49DzyC2CvIyin/BP7WNh2zvnglpPQQcIwkOJhEKwUmtfQBroZ+ixFcZ3ikSIY0Vj
	 KpazhMZBn10bdQ3z70iQIsdQYxmPdE2Sxxb9Uan63Xu9Yyegvio2ZmxsUvGKWUbRCxp5j
	 VXe3X9OHhTs/Nq0lxYXQ46voWGwGyw0CktguM0URQPGLsEhx219b35dIwxpEWsE4X7OnM
	 J3uuzngXAyYT4OFGg0EG35Vl0u8hf3iNirE9k/Xw9wxCENQPI+lnjzq9+fHODa1HHAA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795609423;
	h=Received:DKIM-Signature:Subject:To:Cc:From:Date:Message-ID:
	 MIME-Version:Content-Type:Content-Transfer-Encoding;
	bh=CHBPHKgAiMMVQrw5/SLAugRMw9zfWcMKUBbQtJFZzZg=;
	b=Wn4t+oa+WjscnXH+R/KrvEZJSlC2Karo62YDZXn5PlJ0wPoPBboTs7fs6npeJnIDVUkU
	 FKvdPtfaWVccXDMuVqAXZjK4xs2dpsPVgTPklofpbFOpNZ1dShxxQ7UOnOsNRrSJXVkqC
	 cMqinQ03zbp480Bc+AR//6WtPTzSuCRLImEDUlCDx09J1nSHfmLoKPIXjAM0ztTm2imbY
	 vzpiC6d/loMAw29Vg4mxt9RxQsNdW5oOXCXrvYh5ZqtGAnv5oonL4V5QuVACDApwGpEPd
	 AdSF4EqZcj/g4LTEvF3yU+7sl1hw0yNqfvKK9LiQ20tyk1hfeIB5w2tnHPwPT06B3jg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Bs0CfPpo;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E122A606A323
	for <stable@vger.kernel.org>; Wed, 25 Nov 2026 12:23:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.a=rsa-sha256 header.s=korg header.b=Bs0CfPpo
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 129931F000D3;
	Wed, 25 Nov 2026 12:23:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1795609422;
	bh=CHBPHKgAiMMVQrw5/SLAugRMw9zfWcMKUBbQtJFZzZg=;
	h=Subject:To:Cc:From:Date;
	b=Bs0CfPpoAWoLdoVH2T3pXePtrMl7z91huIszpXKaS9NIzyVbn9m1WLZ5Kt3hskFyE
	 eNGjA3y/v8ocRflinhfUmfPh0zI35MpWm8dofBwCG+BimeMapTT5NIUjeILcEfhodU
	 73eWZumqmO8AVrE+mqhQP+3XAJ46RXUF+BzcpN2E=
Subject: FAILED: patch "[PATCH] USB: serial: upd78f0730: fix NULL-deref on hangup" failed to apply to 5.15-stable tree
To: johan@kernel.org,maksim.salau@gmail.com
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Wed, 25 Nov 2026 13:17:03 +0100
Message-ID: <2026112503-frayed-lazy-b904@gregkh>
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
git cherry-pick -x 0e0b1fcfb80c0490bda7f7eb633ebb5e431c2e16
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026112503-frayed-lazy-b904@gregkh' --subject-prefix 'PATCH 5.15.y' 'HEAD^..'

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

