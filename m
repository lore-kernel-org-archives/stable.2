Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26DD737F735
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 22:12:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791238371; cv=none; b=crU4VGNvoL8uyYLtrtIO7UTk4mO1LdkxAHLTJ3D7NiGF3c/sO/q/PADxkJCzSnmhpcSBN5y3aHQoK1IGlQY6RaR4A+k0qkvO/MgDDbNfEzO5lzkzafZsjaCg4RqV7pZ+ZabWSZU9o4rLtMVrnMLZqkrkptGZpuidpyjqfLRqsfs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791238371; c=relaxed/simple;
	bh=51r7Qn1EdOh4+IU4xRj67TOm56yzhQpLTGe5BxNhkBE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=TBEWTcEFdH1BtTM9Ryut04iJiTVHN5Q0q/OyFpQ8ajNWOjRpQLN83bjabXTLiYOFspgQaL7eXbWPFcgDKNWivQ2YYFoH6vAjaU+pEnOwdKbd/ar2SAWCDIDwwQ+6l8Ps+d816Duw2axeeyW2tQD69nbo4d7+4n5SrVjcNo4VCzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=e3BnIJCX; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="e3BnIJCX"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F8AA1F000FF;
	Mon,  5 Oct 2026 22:12:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791238369;
	bh=MULkRSjL5V/Ei6Ziy/VHbivuXzk0TiwsZl/8cle5vNc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=e3BnIJCX4Tx9zxSLVKxYiHRB7R/I/w5ZxU4RiVE/J1ltyMFHVyDBZB7GiRyt0RMMB
	 MYXU2vGeQEaEc2Guyus7D+qjrVwZpm1DJO6QMmQAMg2PEYdd+ukplA6xD7C7GOUYUA
	 7fIT5rTTpNV9O5RT3sW0iKnAetOR1RaCNBNwYZC+8wYnaNJsPbEya0mrumE6neB4xk
	 pctHeRz0iJ58LIgJgAyg0rbDqvAg3u6y4xMOkTTIAPFLSicep8iR810+23CHvbieIe
	 ABez/nVC2ZqdxhGQNih50P/Km9gPj14d8qI/UnnLs6GyKFwfn2Sa6CNqZWyFb9H2hZ
	 IWnlsFkef/Y7g==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Johan Hovold <johan@kernel.org>,
	sashiko-bot@kernel.org,
	stable@kernel.org,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] serial: fix TIOCMIWAIT race
Date: Mon,  5 Oct 2026 18:12:45 -0400
Message-ID: <20261005221224.3435172-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100501-rubber-equipment-9072@gregkh>
References: <2026100501-rubber-equipment-9072@gregkh>
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
[ sashal: Retained direct spinlock calls instead of the upstream UART port locking helpers. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/serial/serial_core.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/tty/serial/serial_core.c b/drivers/tty/serial/serial_core.c
index c3a51bd59ff74..87bd1be81f77c 100644
--- a/drivers/tty/serial/serial_core.c
+++ b/drivers/tty/serial/serial_core.c
@@ -1253,12 +1253,12 @@ static int uart_wait_modem_status(struct uart_state *state, unsigned long arg)
 
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

