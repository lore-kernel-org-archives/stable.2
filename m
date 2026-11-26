Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795710195;
	b=IfAJAkPuEAqcY0LA4N5Tle0AnVxzjGnwva0suw9QaX5buKCpCwuWM5ltcmRDxHXi+AVc
	 zLB+wRrHMw98gapkKI1XN/Pyd9GnknahIpv66jJ2IRCEJZnIj9uoJt/ffov9fxiuaMXcN
	 MSHrHxVyqvMUzfNsscWHOQRjCJ8awHUI1unDxMGA/Py87+H0YQeC2FQQnampygiaSmV2u
	 /yqEghNNBn3dEQO3IZJDf1daQwrFgRjtR6nNAXVzUfoye3hLwPb86gbnxyAiKPPWRryy7
	 4tFtONuC8bhFooOhHFam1L42v9NhIocZpf16kiuvVAg98d873N4g3zjObgRwaqN9PXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795710195;
	h=Received:DKIM-Signature:From:To:Cc:Subject:Date:Message-ID:X-Mailer:
	 In-Reply-To:References:MIME-Version:Content-Transfer-Encoding;
	bh=dFREMa3J8bJhL6OdUyTiGsVZK/WuvRC/hH6SGDyY5EM=;
	b=phjp2VqmAuDQ1xeT/VnQ3hfylLsIK9adA2ZICIZ9880KrJvnsWa7b+bX8xSZsQ3lAKnM
	 v8zE1vP9LaDEUcbmL1YNOa2z2nSiTKFnJr47IAaW9Ef7IrqJ0BCyiDmecv1mTfzMxY+Ys
	 5kWg22t3/Jsfbzsw2Rmne8b29XKri7gdSbhUAdlf9Fu/ckM2UprhtLwPUqZeIRo/EOI7F
	 q2I+lCJxmc+cX44ethKHhdCR5Xxwzy/VqTpGGkUlMOKNkE4J+B4nzckIfqFYQd029PGPj
	 yboeZowSWwEBzOtEKo+5tk9OMJG4y25gKo2qn0ZqmuQ7/N3JxbeLwRYiPnn/r6PJJVw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsgKXDYt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF308606A321
	for <stable@vger.kernel.org>; Thu, 26 Nov 2026 16:23:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OsgKXDYt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6648A1F000C6;
	Thu, 26 Nov 2026 16:23:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795710194;
	bh=dFREMa3J8bJhL6OdUyTiGsVZK/WuvRC/hH6SGDyY5EM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OsgKXDYts3Q6Yprp3ENkxoqUjOsarkB8ZYEds3yWkzQUasFu2nKfo9j6zhgomBEAl
	 kxPhhA36RTr/jBq4svGDYK60AAJzg1SYx3qGfv7ovvM8HIfFMz8y7kLbcojqeS7Cej
	 BBqrcPD/0ttZYt+qXtowqtu7N0l5muADi0GfD4vR/Ny0IWRkcefKg1MJQ10wu/PlRO
	 DSnh9999b2EQnTCFsm3liHto7/NPOgJ6WDpSNLA4cOJqadAij3s6OcqWnNS5y0A4T5
	 8Ap+RFkmyTJAli3xv6mQcL77Q/5hOeRysWuUNUFFr8xPA2CHCZl9YhjmEXbqfgmOh/
	 w1MJynu2LyJFA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	Maksim Salau <maksim.salau@gmail.com>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] USB: serial: upd78f0730: fix NULL-deref on hangup
Date: Thu, 26 Nov 2026 11:23:13 -0500
Message-ID: <20261126162259.2579886-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026112503-frayed-lazy-b904@gregkh>
References: <2026112503-frayed-lazy-b904@gregkh>
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
[ sashal: adjusted hunk context because break_ctl() returns void in this tree rather than int; the added code matches upstream. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/usb/serial/upd78f0730.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/upd78f0730.c b/drivers/usb/serial/upd78f0730.c
index 63d4a784ae457..1c75b4fa2c93a 100644
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
 static void upd78f0730_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct upd78f0730_port_private *private;
@@ -264,7 +270,6 @@ static void upd78f0730_break_ctl(struct tty_struct *tty, int break_state)
 
 static void upd78f0730_dtr_rts(struct usb_serial_port *port, int on)
 {
-	struct tty_struct *tty = port->port.tty;
 	unsigned int set = 0;
 	unsigned int clear = 0;
 
@@ -273,7 +278,7 @@ static void upd78f0730_dtr_rts(struct usb_serial_port *port, int on)
 	else
 		clear = TIOCM_DTR | TIOCM_RTS;
 
-	upd78f0730_tiocmset(tty, set, clear);
+	upd78f0730_port_tiocmset(port, set, clear);
 }
 
 static speed_t upd78f0730_get_baud_rate(struct tty_struct *tty)
-- 
2.53.0

