Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710602;
	b=3ESMlrMOIG8xIm6nFP9dukqp+qEyJ35sirxlHGTMK9Rq5mWTi7fGNknpzPF3yX0yKDOS
	 TUKjIaTjgUCb4dSJE1xe79Jr/H8PMOYFGbuSo0aTAd7rUb3YMwGvTuTA3oSxKGNyoW5TQ
	 WtoC43To0DhDaK9VYf9iJjiSiU3+z5zIhHMFWD68flF4t8w+9pYR5Kow6fNKzkZthIvdB
	 N7keWHZlGFGRohtgpkuIqiJsJI2tRUhHL3JbFxbUEMhElapAf/OQj+nimbQzj+ueM70pa
	 4vYqp/Hgy/hS9yUJU+8Qxo03eMlenzZ9vPEu4zVQq5Apy3kmzljnNid3UOGLyHDdgmQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710602;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=Wloahy2Mz+wacDFCTtTgxAAIE12e8bZ9nkiYG31yWbc=;
	b=frnFpwL5TMFvBhgu4s1f2srCmfff53nbQJjKsAS2eG9CY2f1r5hdmGbOn6wFIuGRtimE
	 XW83KQ9h8bV4oXq4tkQlwNrZQFsoYXgi08yeg0CzaxdJnix0W+5vXBP4nuJsC+bFzuxJg
	 pPp2jTBGOiTDKaJVlQvbMokLysnlMePiKkzNRtDKA8xkl8oTYsiO4ef1GgmhzzqPbPK98
	 hRDDf5aScz2H1xO3em3ZYjjZhWRU8d72a+rUgwOmgmNmieLYa+nUhyGQtCx40EefsjEvG
	 vP8O7/vzGP7mP+TwwJJHZOaAStpcg8mO/aHZ/mSGh+wUQPXOWAaME1lux/8t4HdJ9pg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRLlAjNx;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 919C7606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:30:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bRLlAjNx
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2601C1F000CA;
	Thu, 26 Nov 2026 16:30:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710601;
	bh=Wloahy2Mz+wacDFCTtTgxAAIE12e8bZ9nkiYG31yWbc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=bRLlAjNx35JnTT8OeHjI3ffjwzR1Cq5jDaZmckvWPYguCCvAu97DU1N+s7T85Vgxd
	 1Uo6rrkH0ndjz6n22oNBf9JuhWEhTQkWNM+LYw7zuJWYmO5chfOJr+iHF5jqyC0X00
	 AKuwxmeNUiNs/yw0rzUrASjrST8xmdoOD9ncJg0fxteLuyHP/21sMimEDDiCVafAva
	 4WU98uZarSt7NI5BOkU3RURu0+7t6BGcSGma75V3hvnRcZQ4Fxp1LVqpD+v0cxen9e
	 Yk2JcoQ7Ok4uhaC5e9Y7kUo74H+UkYu2wT5f9AWrp9Dos0Xg37rrIWz40Ek8ibOemw
	 XLFvsVgK+OQpQ==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Maksim Salau <maksim.salau@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] USB: serial: upd78f0730: fix NULL-deref on hangup
Date: Thu, 26 Nov 2026 11:29:59 -0500
Message-ID: <20261126162945.2604989-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112503-unused-cognition-ac3b@gregkh>
References: <2026112503-unused-cognition-ac3b@gregkh>
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

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 0e0b1fcfb80c0490bda7f7eb633ebb5e431c2e16 ]

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
[ sashal: Replaced the tty-based dev/driver_data setup in the helper with dev = &port->dev, and kept the wrapper above break_ctl, which returns void in this tree. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/upd78f0730.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/usb/serial/upd78f0730.c b/drivers/usb/serial/upd78f0730.c
index 0a2268c479af4..cb6597240b34f 100644
--- a/drivers/usb/serial/upd78f0730.c
+++ b/drivers/usb/serial/upd78f0730.c
@@ -207,11 +207,10 @@ static int upd78f0730_tiocmget(struct tty_struct *tty)
 	return res;
 }
 
-static int upd78f0730_tiocmset(struct tty_struct *tty,
+static int upd78f0730_port_tiocmset(struct usb_serial_port *port,
 			unsigned int set, unsigned int clear)
 {
-	struct device *dev = tty->dev;
-	struct usb_serial_port *port = tty->driver_data;
+	struct device *dev = &port->dev;
 	struct upd78f0730_port_private *private;
 	struct upd78f0730_set_dtr_rts request;
 	int res;
@@ -244,6 +243,13 @@ static int upd78f0730_tiocmset(struct tty_struct *tty,
 	return res;
 }
 
+static int upd78f0730_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
+{
+	struct usb_serial_port *port = tty->driver_data;
+
+	return upd78f0730_port_tiocmset(port, set, clear);
+}
+
 static void upd78f0730_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct device *dev = tty->dev;
@@ -270,7 +276,6 @@ static void upd78f0730_break_ctl(struct tty_struct *tty, int break_state)
 
 static void upd78f0730_dtr_rts(struct usb_serial_port *port, int on)
 {
-	struct tty_struct *tty = port->port.tty;
 	unsigned int set = 0;
 	unsigned int clear = 0;
 
@@ -279,7 +284,7 @@ static void upd78f0730_dtr_rts(struct usb_serial_port *port, int on)
 	else
 		clear = TIOCM_DTR | TIOCM_RTS;
 
-	upd78f0730_tiocmset(tty, set, clear);
+	upd78f0730_port_tiocmset(port, set, clear);
 }
 
 static speed_t upd78f0730_get_baud_rate(struct tty_struct *tty)
-- 
2.53.0

