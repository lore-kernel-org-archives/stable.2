Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EA19D406834;
	Mon,  7 Sep 2026 06:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788763502; cv=none; b=Kb9GZvgJtlNANUKReUnRZrlc2lR0E3r8drURMiB3Kthw2xmkEhrXpzL/hsHIUhSObfx1IahKCw9absf8pueDxynDHfe63OMcS4VoOwwCX8nyy/D2BT7NsWt9motD4URdBeq/SJrEYt7wJRiuCEBbYb6pr7vIf1aSWo+Glo0+Ctc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788763502; c=relaxed/simple;
	bh=x66OTmE+2GoMrDOkCx9Gp+1mdgvBmhCVWJZ3x+2aW8g=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=q5CyAGfrCUKbIrZZsS0DaVVx4hy1pFuhdN5f860Rr8wfDzz11hYlPOSOkMqrx9AmoEJZDCd0ivlZb94UJEzk0fQM++Oey5sDsNZJ006dVv68QZE6Ehbfjggos2W4RFFzAwFlDK6E0qKGrWVzfIKN+3smwYV6wf5SadSSX44YoLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DZchNzdW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DZchNzdW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94ED81F00A3D;
	Mon,  7 Sep 2026 06:45:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788763500;
	bh=uKkl+WCnZ3v7/vev4Fux3tOv4sXrORFW6CikZ1muEWY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=DZchNzdWPSIUMz5EDTVju2UauvqwvKBgOZwgWylIvokg8chfX4imLvTbQ0D0sswBM
	 VjzM4gd9j61kqcJZ3b1vf2nHuuAGHAqb7VtcjcUdO4Hrfjs7ukXQja01HF0CoJcd8t
	 YVJHQbvz2w68cbA4+clbvgfjilxAP7PFpEeMhE6NneuzvogNZBzHZJ3DPh3gqX+9hx
	 GP0EzGyDbywa/tRRHz14Nggtc5/ZtqJ0y7EBUn1N4jDoGV4nq6Cf1Ss/tNW93ovJmF
	 kgjFnDro1RNiVALjzNMMLRYjpuJsuDd3EK4Z2QM9rqmMI2KL/UxYxbNw2RUS17GQGc
	 WCaT5NK6PqNyw==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x3T69-00000000OC8-3nyj;
	Mon, 07 Sep 2026 08:44:57 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v3 3/4] serial: fix TIOCMIWAIT race
Date: Mon,  7 Sep 2026 08:44:17 +0200
Message-ID: <20260907064418.92953-4-johan@kernel.org>
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

The task state must be updated before checking the wakeup condition to
avoid missing a racing modem status update.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/20260904115542.E20D11F00A3D@smtp.kernel.org
Cc: stable@vger.kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 4213fa3dc988..c2c2c8fe1a4c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1230,12 +1230,12 @@ static int uart_wait_modem_status(struct tty_struct *tty, struct uart_state *sta
 
 	add_wait_queue(&port->delta_msr_wait, &wait);
 	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		uart_port_lock_irq(uport);
 		memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
 		uart_port_unlock_irq(uport);
 
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
 		    ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
 		    ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
-- 
2.55.0

