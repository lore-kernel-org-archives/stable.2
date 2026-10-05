Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7C3A3B8BD9
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195556; cv=none; b=fWQZCG0MKTVbGngnirSkLptt4Ok46FvSkY2Ww3wnaCbqI8hQhvM4ws+AGU12axZmLuUGBzLXUNxQ9qYfhVSWOF4aXE9cOadkwMmAnIrAMdNECAYfRXqmds/K1ZU7Hm5m66j5aTOOfffCZRn9Apqenm+0a5Vs3GVlY9RXtzwDS1Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195556; c=relaxed/simple;
	bh=9WNCJmhwvV5Pi7RMuu4I77zmHaUE3A2cEGlBpayKj8w=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=OTbadByFecpjCzdQVrk0ckKSHXtj8JtVVKjVyDsk2lOtvuSThonM1Q9dcGP+5lfhG41OVsr8wXtPiIr/XbEEkZNEPTOp4xqy1RRAhorR9c6S1vnVvm8LzkgAcyHAmZDOomt5KaObp/s0om/rmFhQO6LMd44wFcdSmITWNwTYIu8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=L2zofamZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="L2zofamZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AAFDA1F00893;
	Mon,  5 Oct 2026 10:19:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195554;
	bh=lUeVJe4n4PdqQRT9dGMHiARJP0q31Ff+HgYPgL1rNwM=;
	h=Subject:To:Cc:From:Date;
	b=L2zofamZWjmzBVgEnb8t2RkicbZI1D90X98DuCzEBHF3+wDRagNetL+U+doNfZVue
	 MjQx1xxPOgqpaJyhsXZxc9hHDnasroxX8PV5zcxiCByCrlxZCmKAaqOTh8vS7RKePN
	 UtuTUf7mahZ62hH5b9aQg6ApvQ+sf47emlblCcj4=
Subject: FAILED: patch "[PATCH] serial: fix TIOCMIWAIT race" failed to apply to 6.1-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:19:02 +0200
Message-ID: <2026100502-jab-vividly-0ef4@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.1-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.1.y
git checkout FETCH_HEAD
git cherry-pick -x 40adffec8c0090533dfaa863ced7901b60bbf1dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100502-jab-vividly-0ef4@gregkh' --subject-prefix 'PATCH 6.1.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 40adffec8c0090533dfaa863ced7901b60bbf1dc Mon Sep 17 00:00:00 2001
From: Johan Hovold <johan@kernel.org>
Date: Thu, 10 Sep 2026 15:08:15 +0200
Subject: [PATCH] serial: fix TIOCMIWAIT race

The task state must be updated before checking the wakeup condition to
avoid missing a racing modem status update.

Fixes: 1da177e4c3f4 ("Linux-2.6.12-rc2")
Reported-by: sashiko-bot@kernel.org
Link: https://lore.kernel.org/r/20260904115542.E20D11F00A3D@smtp.kernel.org
Cc: stable@kernel.org
Signed-off-by: Johan Hovold <johan@kernel.org>
Link: https://patch.msgid.link/20260910130816.642699-4-johan@kernel.org
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

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

