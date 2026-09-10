Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5CB2489FDD;
	Thu, 10 Sep 2026 13:08:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789045710; cv=none; b=Ts2Gobd01TBIxg+IAYrQfyHgh8xRsM9ALDiSndoI+xQoBnzMDA1R1l5gXsNCg/xNeR0OgensPIWGp+0D9RsgUwSSZ/2ty9TcLvxzNDVMWzlXUgVC+UwSZgCQalYBS046rUHVyvG30TgLcOABRsDLuhxlBAYqkDgtEnrPL/AyFkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789045710; c=relaxed/simple;
	bh=K5LRS21eAEywaCwpWTP9zNQuF5OgFrmxKq4jTgK+Cls=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rW2g0zK9oRxu/b6FrNDF1TFXtFXi6XboKLeOoxMMuenF0yIiznKKlW5LnIuBEGwptErLXMSBcAQCSGclc8Lza+sAcqfrHocSq29w5APP+nSGCmm0xHYubla2cHBAWwKddkkXV55gv5EgFNe84V7h19+mFGxpd0Ktu0R2wX7/EXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VwMqJEZR; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VwMqJEZR"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 599121F0089A;
	Thu, 10 Sep 2026 13:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789045708;
	bh=kh6o93YAq1wBdd148BhlQAfURtXlXRfV6euq7y3I5Tg=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=VwMqJEZRa3v/oTJWB1UMPfW8B6uhs7e8HRprGxAkUKRNyRhG1zDoWalbo+HSeVGai
	 YqwGdqDFEn839Kf+gweF+LCDaioBPQkjlfNxVImwlgoK0uRaf8Ni4Vz9Ie5iXBzBuu
	 hxtvwh8a++9QGjorSWld2fZTntfoO+ViFQ03MOiBv2cG42CP/gs4x0t4sHXJhrXHdP
	 dPDSWR+ggpQQUzegl33yPIqv9PKa0MBaq0PF/o+C2JtzAdQTzq1v29t3ECF3Mg9JYN
	 Ow48rShfcURtMguqTGaVM+A2SkIzooMdUxAbSsudvHW2jjOF/l/qFZuD7q+xpUfnv2
	 yk2vRuUXNP7yg==
Received: from johan by xi.lan with local (Exim 4.99.4)
	(envelope-from <johan@kernel.org>)
	id 1x4eVu-00000002hCh-02cu;
	Thu, 10 Sep 2026 15:08:26 +0200
From: Johan Hovold <johan@kernel.org>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>
Cc: linux-serial@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Johan Hovold <johan@kernel.org>,
	sashiko-bot@kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v4 3/4] serial: fix TIOCMIWAIT race
Date: Thu, 10 Sep 2026 15:08:15 +0200
Message-ID: <20260910130816.642699-4-johan@kernel.org>
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
index 139b93876229..f7b30f77b231 100644
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

