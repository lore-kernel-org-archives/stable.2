Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35C3F3F6606
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 10:19:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791195547; cv=none; b=H3ap88LU81s+7h9iZ9hn8f4haEcw23Qy/N+RCVun4+IHYT25OwuBJixhdQjY7ESsXjUw0ptSNBZTwYGppEo3FCHqrb2oglDWOK+6DKhrbj5jg2zbwmO8iSyGbZkDMIjIiUEpJwPN0qW99SkkktSG8KufNXElBmhtdkjNmh7wd5Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791195547; c=relaxed/simple;
	bh=EZHQogngTK4J4kFiCE13dQZ11mbGTsfc4hkWjQBZxD4=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=dm9nTlKwjmqU9tlTCSm3mWezgiAvxVlkMM1wKxbTSd6FLJL6nTgLXI2RyvlfT1vnH5ZEKGJSWGJMJRZ/Rt/VJJZqL9uuEKukIWUHxevfrTna11lGCc3u62ENaIR04G/bcnp97KGQNpgNGtid6YfbBw0kzy5kKgaohAghSIUj0EU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=Ek1Os5ba; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="Ek1Os5ba"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A5131F000FF;
	Mon,  5 Oct 2026 10:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791195545;
	bh=F9QOPh8yS93eXoBvqmcMgOjZ2NBCQKWht/bJ0L5ifQU=;
	h=Subject:To:Cc:From:Date;
	b=Ek1Os5bacPUfM3mYgmwxTm4LBKL4r0ES+/Dnh0dHSYz4brFCQUDRJCFM3ba1NLeBn
	 XhvF7LWTHDAiemVPkCL/OICKCyvcRWz9MgGXi9T/E54MDPjJv6CjkFDSLJ7DGPGZZU
	 fYl292g7Flzkv/xKve40o6xMzr1zGmPsYeZ0XOlA=
Subject: FAILED: patch "[PATCH] serial: fix TIOCMIWAIT race" failed to apply to 6.6-stable tree
To: johan@kernel.org,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 12:19:02 +0200
Message-ID: <2026100501-rubber-equipment-9072@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 6.6-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-6.6.y
git checkout FETCH_HEAD
git cherry-pick -x 40adffec8c0090533dfaa863ced7901b60bbf1dc
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100501-rubber-equipment-9072@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

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

