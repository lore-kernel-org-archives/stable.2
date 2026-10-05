Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F987376469
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 21:47:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791236830; cv=none; b=jAmR8MxP8q1PaDwPN+ljSlu4KUKn+it3v50GIfet4vsSMWJFmIK4F/t3PWL00qmZJAR4UwrUCujj8CxWrmYEzh9lPpf9gl4aCfX1Dv/eUlv7tNKLNfjWTJ89tFdiklXroW690bzdRIEMCOhpXDlk8t9j2V3M5Rd20MmSrdwymDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791236830; c=relaxed/simple;
	bh=3huf1cMk7VjwDGpQhhdcr75G9zOWNaq48fAd8CG7xOA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=mc3HOAwWz/xQcfSIc551UtOezDPir00Uzm+hGa+K/jG5/pfc9dTAs1HjmBSgfCvjvx8Zf2ZUoN/0lKSjkF8+/az9WN5u2aQP+YEgxqGg2cM0TjgTman/xMPFD257btqXHawXMUx7dGTiQjGi3MTLT8/hP0rj1ARWU1IHVUJ854s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cbHvLWZE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cbHvLWZE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6C5A71F000FF;
	Mon,  5 Oct 2026 21:47:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791236828;
	bh=+nVrxM7shDPgvOfx9PlI5GimBDjSZFWsmPK1ehEo6bg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=cbHvLWZE1qZtbvf6sB7/G2is+gWPXrXFanXikHbipYzJGu4sUvInxDgyYkte2MIFH
	 rYJQk6uK4S3uwU0J3HqrXKq7xb4WTxsG+vZklC3xbAXcsOceA/s36Ajv/+/IBxApWm
	 ymI5jYLnXE8SuAuHD3LSAHnW0M9MaozeXHkXwsRelP6kxfI96uWseAXhjt13lW9wW+
	 heUl8ydBAZpe7g2SQeg28s6t+Zm+EHYOMizoj5nmCmOp36CSmE60xH7x9jD3yJWkqJ
	 8TRczix2xQMWi0lYbhj6SXW2oY4Lsjbk0ZabPYFXf6QbKje0aeJFerV3f3vxQ/XuJa
	 SvVAx7VhViUoA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.18.y 1/2] serial: serial_core: simplify uart_ioctl() returns
Date: Mon,  5 Oct 2026 17:47:03 -0400
Message-ID: <20261005214655.3401887-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100554-renewable-overpower-2a0c@gregkh>
References: <2026100554-renewable-overpower-2a0c@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: "Jiri Slaby (SUSE)" <jirislaby@kernel.org>

[ Upstream commit f374a33e90e6cc17b05629636e68a012dc8347ed ]

Neither uart_do_autoconfig(), nor uart_wait_modem_status() can return
-ENOIOCTLCMD. The ENOIOCTLCMD checks are there to check if 'cmd' matched
against TIOCSERCONFIG, and TIOCMIWAIT respectively. (With 0 or error in
'ret', it does not matter.)

Therefore, the code can simply return from the TIOCSERCONFIG and
TIOCMIWAIT spots immediately.

To be more explicit, use 'if' instead of switch-case for those single
values.

And return without jumping to the 'out' label -- it can be removed too.

Signed-off-by: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Link: https://patch.msgid.link/20251119100140.830761-10-jirislaby@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Stable-dep-of: 8ca59f7baee7 ("serial: fix ioctl hangup race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 35 ++++++++------------------------
 1 file changed, 9 insertions(+), 26 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 32cdfc59a9ad9..3dc109ab0a7e2 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1564,37 +1564,20 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	void __user *uarg = (void __user *)arg;
 	int ret = -ENOIOCTLCMD;
 
-
-	/*
-	 * These ioctls don't rely on the hardware to be present.
-	 */
-	switch (cmd) {
-	case TIOCSERCONFIG:
+	/* This ioctl doesn't rely on the hardware to be present. */
+	if (cmd == TIOCSERCONFIG) {
 		down_write(&tty->termios_rwsem);
 		ret = uart_do_autoconfig(tty, state);
 		up_write(&tty->termios_rwsem);
-		break;
-	}
-
-	if (ret != -ENOIOCTLCMD)
-		goto out;
-
-	if (tty_io_error(tty)) {
-		ret = -EIO;
-		goto out;
+		return ret;
 	}
 
-	/*
-	 * The following should only be used when hardware is present.
-	 */
-	switch (cmd) {
-	case TIOCMIWAIT:
-		ret = uart_wait_modem_status(state, arg);
-		break;
-	}
+	if (tty_io_error(tty))
+		return -EIO;
 
-	if (ret != -ENOIOCTLCMD)
-		goto out;
+	/* This should only be used when the hardware is present. */
+	if (cmd == TIOCMIWAIT)
+		return uart_wait_modem_status(state, arg);
 
 	/* rs485_config requires more locking than others */
 	if (cmd == TIOCSRS485)
@@ -1642,7 +1625,7 @@ uart_ioctl(struct tty_struct *tty, unsigned int cmd, unsigned long arg)
 	mutex_unlock(&port->mutex);
 	if (cmd == TIOCSRS485)
 		up_write(&tty->termios_rwsem);
-out:
+
 	return ret;
 }
 
-- 
2.53.0

