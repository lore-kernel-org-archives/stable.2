Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1A701400963;
	Mon,  7 Sep 2026 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763502; cv=none; b=YGJBuQe8eQzmMxVh0vpzb0Y4Bs1dydkuE9opAJJbr2U6UDjO8h92orn7t/atBx4aSNkMMsAi0ahAxb6/7bVUsC49NfUrzf3B80r3I/I4DcAnxQCMISS2wCnRYkpimHP4AY17J7PhM8UUoLWTFFrmJ7ctKMaqRZ+ebUGzUOQvyws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763502; c=relaxed/simple;
	bh=5/7mkBg3SXUZmwpNQZbqvDU68kScFEqQw2PSKoYk/7g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=e4z2ga8kXHxBxQAhgOPu8AXw9x6M8iqdAnXs6PXfKEb/j/JV/W0hQ1cnjofuExklSxImEJTqOWEYA7C5lyVrIHS7k1QF0jn8+mvK0EFqCXcSDPf6ipve6vZtatvzd8b9tBN7M5NSr7s5CcfV4ENr6LImTmZd5bTMTSmFuDx6tVA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Eqjv40GE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Eqjv40GE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A584E1F00ACA;
	Mon,  7 Sep 2026 06:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763500;
	bh=p8adRS1Y381PQYv/N8H4PYRUQsR+b+pWo6Uubccta/M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Eqjv40GEKnuI3korcu4hHzfNtWD3jJCS8h4Czmdlex7Jn2IP5hp3KPQf71UAMPoCt
	 o54NDFobn0R73EFVXSecyEc8Uc5yNNA2ADmfSd2vSpqDTMDd0gzLFXM2XXql+UReSL
	 AJ2KMa+gBcBgifTvz87ZT0DZgujb4okQJwYSkoUF4huur6b/+NqFj9pwfoXS6q+v6u
	 3fM2Qp9ruvZNq5JbJCPPaHUkWH0Xv2E3ICF+vExr5566SaeCnmijPwWYROf2uK8OQt
	 9RTucqncaZOGevbvhoj4oMdl+3bnfSALX3mszgHZYdA399Wc/GWB8XI6xud6rIOc6K
	 ZiKG+gtZiSTHQ==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3T69-00000000OC4-3hbG;
	Mon, 07 Sep 2026 08:44:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH v3 1/4] serial: revert guards in uart_wait_modem_status()
Date: Mon,  7 Sep 2026 08:44:15 +0200
Message-ID: <20260907064418.92953-2-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260907064418.92953-1-johan@kernel.org>
References: <20260907064418.92953-1-johan@kernel.org>
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

Revert the premature guard conversion in preparation for fixing a hangup
race.

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

