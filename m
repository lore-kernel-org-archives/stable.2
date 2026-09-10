Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5DC9489FDF;
	Thu, 10 Sep 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045710; cv=none; b=VKjpLif9E2b95XHSJptI/DkFb69hgajSGn8ePB2zJU1Yc4SyORijTyIbib2LbjZsxG+D65IQA6Z4mk+YJXuGlNhvlpemFj3IlDTA6d2h51FaTZBOn6dvukruFRN0zO5zLUjBODflPshizXnpp4mkNCavnx9bpfAMXxKxpJK35Hw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045710; c=relaxed/simple;
	bh=lBtOJIb7Kc0Iam5UO9c1m2KgSwt+sSLgyO5xLNlBBgw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eZtrydMUPAPuS1kL3VrrUP03XKuAO1gp5t6FlPdtJ7MeINXqgArYltPXvSJcZ9MVqsFIdfLbyZ/o6lPEGNER+sr/5n58eBL/b+VUfCojRrX90cDEV12+92sEjxrOeEA+wltPUnGa3igchKILI3/xmhyd9GIKFYwHGFPxWjsACLE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=fAkX6wOH; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="fAkX6wOH"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54E4C1F00898;
	Thu, 10 Sep 2026 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045708;
	bh=G4dCRdwBUSbRtc9Y1vVz7FgABZy+LqLIXpUwJsa0vFo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=fAkX6wOHnY8UcG7hcxTrPhnTp9M5OLGIqR2AAGK8C/C7xvNrObrKd8bRUqW8pDF26
	 3OKeu+addcoWUR+EShRvPme4P2gh3imE00Zm4qeTpzLYY5sALpeDETP4A71GUTLt0f
	 jODiiasaKO8xEqy6u4+Rxr9b6X7QLEl/rqiekz/xlfxsT50dFl9Rit1AX+tpv7zqrd
	 x9s6fHc8/RRWJJ7Zqo+xxkYMEvi6qKuwxpXbdgrs2wU5vEZMy+XzsLjuLzADdEvZ9L
	 FiSif18X2uAMZRXjRjYK0EXGR81io7him8UrOmyaDI/pnqd+tT99Pkwn5l2IZc4gc+
	 y48xol40nK5GQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4eVt-00000002hCd-49Ms;
	Thu, 10 Sep 2026 15:08:25 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v4 1/4] serial: revert guards in uart_wait_modem_status()
Date: Thu, 10 Sep 2026 15:08:13 +0200
Message-ID: <20260910130816.642699-2-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260910130816.642699-1-johan@kernel.org>
References: <20260910130816.642699-1-johan@kernel.org>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Mixing scope-based and regular cleanup is discouraged and
uart_port_deref() used by uart_wait_modem_status() falls in the latter
category.

Revert the guard conversion in preparation for fixing a hangup race.

Fixes: 56609c050051 ("serial: serial_core: use guard()s")
Cc: stable@vger.kernel.org	# 6.18
Cc: Jiri Slaby (SUSE) <jirislaby@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_core.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 95774b0f1484..1553bc6cbe7b 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1213,15 +1213,16 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 	uport = uart_port_ref(state);
 	if (!uport)
 		return -EIO;
-	scoped_guard(uart_port_lock_irq, uport) {
-		memcpy(&cprev, &uport->icount, sizeof(struct uart_icount));
-		uart_enable_ms(uport);
-	}
+	uart_port_lock_irq(uport);
+	memcpy(&cprev, &uport->icount, sizeof(struct uart_icount));
+	uart_enable_ms(uport);
+	uart_port_unlock_irq(uport);
 
 	add_wait_queue(&port->delta_msr_wait, &wait);
 	for (;;) {
-		scoped_guard(uart_port_lock_irq, uport)
-			memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
+		uart_port_lock_irq(uport);
+		memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
+		uart_port_unlock_irq(uport);
 
 		set_current_state(TASK_INTERRUPTIBLE);
 
-- 
2.55.0

