Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B61E6A95E
	for <stable@vger.kernel.org>; Tue,  6 Oct 2026 00:10:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791245402; cv=none; b=FRACr0vlpbVibgzYganoXnrYMJmIwWDtvzbVc4btfxrDRxXOeUhUrpLraQrnh4GZsVAzfNqCEZ6UT7tLmdbVaEnM4mFUGNYsBJSoqckXdySI1udfQ2w+cCb7P4ymStMF+YIUs155QhoLp17ENOkaB+fqjgV11GphzGu+/O+pGeM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791245402; c=relaxed/simple;
	bh=FiAYnZG2TOLx25jsLOLBbbCPLuDoH948pSpJsA6ECKA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=erAW7ViU9zpPq9AC4oKe/i+SfnUjxoMOir5nWhznnnw8Vc0SP6gpyDcfor7tI9fH+E2AKRjueBVUdHCPiPJaYHA8clqHoJgjPBQuYq3M1abad1jOG1g8SfgAWil7v1kGFdLjwsB/6L+XJlG0jFrNddsSprY3Bqi116wupl0DOJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=CvBwuzbv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="CvBwuzbv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A74D81F000FF;
	Tue,  6 Oct 2026 00:09:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791245401;
	bh=BgkRiRRoU+qW2Cm7G2n3lXSJB53JwHWg1usaePKXlSU=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=CvBwuzbv2apIxGSol96vURK/Ym1covpUsi2nRyO/54SIBOWNhJNGUSjn+N72nkZxL
	 blIYI4MYdRnanj2JqMacS7/ZRhW4P1ICoiWykz5QXiBoRUc5hnEbR8NugPmq9utrfw
	 cpb2utgA12GEz2fD2sdv+obA761n5NQhrt0etLDUimfP5jvbi+DNCQieKhp0WCUO0+
	 rasb6xCwNx+uvLN4wbmP//xduVxkvYpZcuKylajWw6Js6RTE8aIkyMHRHo1Ld+Dvgv
	 mauSmveQhGFC8Zh3VGfxrtY7mRv9hRNtADWSUKsObzuOOzwDPeEVw9BcVw9LrMNOVd
	 7ZC/2EYsdbzJg==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	sashiko-bot@kernel.org,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y] serial: fix TIOCMIWAIT race
Date: Mon,  5 Oct 2026 20:09:57 -0400
Message-ID: <20261006000903.3542569-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100502-seducing-scabbed-7835@gregkh>
References: <2026100502-seducing-scabbed-7835@gregkh>
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
[ sashal: Adjusted context for direct spin_lock_irq() and spin_unlock_irq() calls. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index 404354727d194..1cba822e068e9 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1213,12 +1213,12 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 
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

