Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EF607313E15
	for <stable@vger.kernel.org>; Thu,  4 Jun 2026 10:56:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1780570614; cv=none; b=l7HffqO3fmsEIv5EIlxPhfExMm7RShpwBiIUt7CM02ByAWCZEskW7IQdKP6GRH8rb1vSYn2LfBQP11k+ktptOf87ccU14biqvXdFteVT1EIyn4DboAFGlkt0Cj/vrRZtyrupqcQq1QhNBQ/tcLFv6szIwtD+917HEcaLDfPzbwc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1780570614; c=relaxed/simple;
	bh=zLVNGh0/8E7SByYN4hd89Bs46FU0s6GqbgkmDlGvPJE=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=KlQdyOL1U9hLwDYVgREIuG9cPBf97M+W3qD3CEvz5O4/+LaUDbl8FoNRY1xZ5HBhKHlfwQi7i0SLh+Ugbk54CMI/W8QRR0lI9OcOnKKk7I1uwqVdMZjj3izd41xFihXyXb2FGVRXDlwNCkSS2mblPauIuZ1S9+FvPUSQ1Rkatrw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=NAnGWevb; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="NAnGWevb"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 271CF1F00893;
	Thu,  4 Jun 2026 10:56:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1780570612;
	bh=u3J8qKG/7nRpciB7yyoexb0HnejnRmpeF63fMSp/bwk=;
	h=Subject:To:Cc:From:Date;
	b=NAnGWevba/5NfIz7pj6j6Beg9o0Yv05NtcsCXrnZvRTSxtEzC+bgKiCjRfOAe1RUl
	 NGEDVvFikdzlGxznGU8DIVfzvvCKMk+HOWgjegDd+SBYdV1rBiMMWDk4UmiEhbBZdQ
	 z4W1jyBs7Lmt037fu9SZQjXBeDuTEYnMwP8e9aTQ=
Subject: FAILED: patch "[PATCH] serial: dz: Fix bootconsole handover lockup" failed to apply to 5.10-stable tree
To: macro@orcam.me.uk,gregkh@linuxfoundation.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Thu, 04 Jun 2026 12:55:45 +0200
Message-ID: <2026060445-upper-slapstick-c674@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=ANSI_X3.4-1968
Content-Transfer-Encoding: 8bit


The patch below does not apply to the 5.10-stable tree.
If someone wants it applied there, or to any other stable or longterm
tree, then please email the backport, including the original git commit
id to <stable@vger.kernel.org>.

To reproduce the conflict and resubmit, you may use the following commands:

git fetch https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/ linux-5.10.y
git checkout FETCH_HEAD
git cherry-pick -x 7f127b2208e5e2b817243cad41fe4211a6d5a7a3
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026060445-upper-slapstick-c674@gregkh' --subject-prefix 'PATCH 5.10.y' HEAD^..

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 7f127b2208e5e2b817243cad41fe4211a6d5a7a3 Mon Sep 17 00:00:00 2001
From: "Maciej W. Rozycki" <macro@orcam.me.uk>
Date: Wed, 6 May 2026 23:42:35 +0100
Subject: [PATCH] serial: dz: Fix bootconsole handover lockup

Calling dz_reset() in the course of setting up the serial device causes
line parameters to be reset and the transmitter disabled.  We've been
lucky in that no message is usually produced to the kernel log between
this call and the later call to uart_set_options() in the course of
console setup done by dz_serial_console_init(), or the system would hang
as the console output handler in the firmware tried to access a port the
transmitter of which has been disabled and line parameters messed up.

This will change with the next change to the driver, so fix dz_reset()
such that line parameters are set for 9600n8 console operation as with
the system firmware and the transmitter re-enabled after reset.  This
also means dz_pm() serves no purpose anymore, so drop it.

Fixes: e6ee512f5a77 ("dz.c: Resource management")
Signed-off-by: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: stable@vger.kernel.org # v2.6.25+
Link: https://patch.msgid.link/alpine.DEB.2.21.2605062302010.46195@angie.orcam.me.uk
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/serial/dz.c b/drivers/tty/serial/dz.c
index d14a40e8cc0a..03f4fc9248b8 100644
--- a/drivers/tty/serial/dz.c
+++ b/drivers/tty/serial/dz.c
@@ -571,6 +571,18 @@ static void dz_reset(struct dz_port *dport)
 	while (dz_in(dport, DZ_CSR) & DZ_CLR);
 	iob();
 
+	/*
+	 * Set parameters across all lines such as not to interfere
+	 * with the initial PROM-based console.  Otherwise any output
+	 * produced before the console handover would cause the system
+	 * firmware to produce rubbish.
+	 */
+	for (int line = 0; line < DZ_NB_PORT; line++)
+		dz_out(dport, DZ_LPR, DZ_B9600 | DZ_CS8 | line);
+
+	/* Re-enable transmission for the initial PROM-based console.  */
+	dz_out(dport, DZ_TCR, tcr);
+
 	/* Enable scanning.  */
 	dz_out(dport, DZ_CSR, DZ_MSE);
 
@@ -654,26 +666,6 @@ static void dz_set_termios(struct uart_port *uport, struct ktermios *termios,
 	uart_port_unlock_irqrestore(&dport->port, flags);
 }
 
-/*
- * Hack alert!
- * Required solely so that the initial PROM-based console
- * works undisturbed in parallel with this one.
- */
-static void dz_pm(struct uart_port *uport, unsigned int state,
-		  unsigned int oldstate)
-{
-	struct dz_port *dport = to_dport(uport);
-	unsigned long flags;
-
-	uart_port_lock_irqsave(&dport->port, &flags);
-	if (state < 3)
-		dz_start_tx(&dport->port);
-	else
-		dz_stop_tx(&dport->port);
-	uart_port_unlock_irqrestore(&dport->port, flags);
-}
-
-
 static const char *dz_type(struct uart_port *uport)
 {
 	return "DZ";
@@ -769,7 +761,6 @@ static const struct uart_ops dz_ops = {
 	.startup	= dz_startup,
 	.shutdown	= dz_shutdown,
 	.set_termios	= dz_set_termios,
-	.pm		= dz_pm,
 	.type		= dz_type,
 	.release_port	= dz_release_port,
 	.request_port	= dz_request_port,
@@ -894,10 +885,7 @@ static int __init dz_console_setup(struct console *co, char *options)
 	if (ret)
 		return ret;
 
-	spin_lock_init(&dport->port.lock);	/* For dz_pm().  */
-
 	dz_reset(dport);
-	dz_pm(uport, 0, -1);
 
 	if (options)
 		uart_parse_options(options, &baud, &parity, &bits, &flow);

