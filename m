Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7D28E3D5C05
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 08:08:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791274108; cv=none; b=a8rjkK8luv2ufUsIrit/XJ/5TT+8GXwArQJjXGdczj2OtQ5VHHWbCMEM8kamMy6nwfH8RvnAjAdBWMou1p1MlRbgszq2VewsGdPcAHw3rqbdQ786R3W5Tv5SPEPkMM/b6ruRwv5PLQWVzYJJfVUhPM/4RnC7wWSCda6+aHj4mNw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791274108; c=relaxed/simple;
	bh=pZ9/MwD52wHEQFtTX6CTmaYklKMR92IBMyJCs5gKmuE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KX1c2X9yAg5qKongqvjemjc3StZQSXcgofTQUiwDvlfZRd3AHZ4GGgYUtlexsEifLO6UlKQB2U9qdQpNc3s13p0Qt7S0Z8buMg+/I14//xuTrN4DhzOpgCzIJRPO657N86AF8kD/ZQADOizCcjEuWEOj25FY75soxOsPHzZ6OMw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MHWaPOqo; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MHWaPOqo"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C3B1F00893;
	Tue,  6 Oct 2026 08:08:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791274107;
	bh=1zvoBIoz/LHB7fHJ25nSey4kfdIw2UhKlnhmrblGH5M=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=MHWaPOqoDWeyI2OjIIslqZHEFMjcCO8hn5/OFV7sUqpjfpsTohLWJ/XtavhXYNorO
	 3yk/vfMTlxb9SgpOW/rHovJEmwFNarGHb1phUb5jMznrgNbYjpCMb4cx3rrEjuYIa5
	 45ysRttQ2rpeiGsthNbACOUtGHEOzkNyqnJc1NEdrBRwExr1Lr9NxoueWLinPCEz1M
	 /d+i8CqyyB9WmNAyW/N0Swy3q3aVUklwkhXWoc/fgT+We9x4m0HPf2W6fcTu96G3We
	 ByV3FRve3tVyAVQ1bwClk6NmIZKbdPwoxNihaUi1CEwq+ebeDMl5COsUlBKhvMHB2g
	 D0gwMG1/u5S8g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	sashiko-bot@kernel.org,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.10.y] serial: fix TIOCMIWAIT race
Date: Tue,  6 Oct 2026 04:08:21 -0400
Message-ID: <20261006072809.3619274-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100502-kinetic-respect-a4ff@gregkh>
References: <2026100502-kinetic-respect-a4ff@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Johan Hovold <johan@kernel.org>

[ Upstream commit 40adffec8c0090533dfaa863ced7901b60bbf1dc ]

The task state must be updated before checking the wakeup condition to
avoid missing a racing modem status update.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/20260904115542.E20D11F00A3D@smtp.kernel.org
Cc: stable@kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260910130816.642699-4-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
[ sashal: adjusted context for spin_lock_irq()/spin_unlock_irq() instead of uart_port_lock_irq()/uart_port_unlock_irq() ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 6d7d448d0fbf5..7e4cab742321c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1240,12 +1240,12 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 
 	add_wait_queue(&port->delta_msr_wait, &wait);
 	for (;;) {
+		set_current_state(TASK_INTERRUPTIBLE);
+
 		spin_lock_irq(&uport->lock);
 		memcpy(&cnow, &uport->icount, sizeof(struct uart_icount));
 		spin_unlock_irq(&uport->lock);
 
-		set_current_state(TASK_INTERRUPTIBLE);
-
 		if (((arg & TIOCM_RNG) && (cnow.rng != cprev.rng)) ||
 		    ((arg & TIOCM_DSR) && (cnow.dsr != cprev.dsr)) ||
 		    ((arg & TIOCM_CD)  && (cnow.dcd != cprev.dcd)) ||
-- 
2.53.0

