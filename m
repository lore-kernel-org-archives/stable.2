Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 58B70401492
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 08:50:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791190218; cv=none; b=mJUYzPIXM5l6HCRRnh78lxkIo33dD0WTyKlZQnxWkG5rL0Uq4lN9ZTvac1I4IRiG0VIg9y5Z7/H1t1DxtYOj6ou/kuwluHHQzsHhgqwgcTUNuzLiqG8+uG4VCprLS/nAuCAuAI+SHej8cKqTbTDX31oXSGmfcbnIIxUe2U5goNk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791190218; c=relaxed/simple;
	bh=mhxfKhSUfpggVyMJsv2WtmY6HpdI7QaFLGWB48s24f0=;
	h=Subject:To:Cc:From:Date:Message-ID:MIME-Version:Content-Type; b=lB6QmPfdzh/ynIN5ZKOr1XaMd0/xtk4Xpi/xvdT+VWNFvyPadM2PxXEzH/U65POIlvvWH50HZWgGyzSgZJp+Z+yL/sK5T2NgNcrDnUrOftQPgo3JU4mjkT+tNdOU9XoXlvUDXKDPzgA/8Pf48NcROK6O2U8dxzQQlc3H1BYbb3o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b=PB9vXEnc; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linuxfoundation.org header.i=@linuxfoundation.org header.b="PB9vXEnc"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D60C1F000FF;
	Mon,  5 Oct 2026 08:50:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linuxfoundation.org;
	s=korg; t=1791190217;
	bh=caZcxAk/0U451X57PBZIig9K7bMOTpFOOM5cBcMv1EM=;
	h=Subject:To:Cc:From:Date;
	b=PB9vXEncLOI109sZD/29PhMEgEoOSnAQUjmQPwPqeIF6S6N1w8guJqherqnr5qs6V
	 EAh1Z3wmxYFpOjMZxULnoOXxbLtUuZQxO4JrAA/blMWE31fdw7dPmLg3id0JFtga4e
	 o4143+0sv5fb9J8d3NXkxdNkZmYf4+Hb2gqPntd0=
Subject: FAILED: patch "[PATCH] tty: n_gsm: fix missing modem controls after DLCI open in" failed to apply to 6.6-stable tree
To: daniel.starke@siemens.com,gregkh@linuxfoundation.org,stable@kernel.org
Cc: <stable@vger.kernel.org>
From: <gregkh@linuxfoundation.org>
Date: Mon, 05 Oct 2026 10:50:03 +0200
Message-ID: <2026100503-jot-unopened-3384@gregkh>
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
git cherry-pick -x 11ea5a63d30ad6d305b1c22301cd99ff45a98c8d
# <resolve conflicts, build, test, etc.>
git commit -s
git send-email --to '<stable@vger.kernel.org>' --in-reply-to '2026100503-jot-unopened-3384@gregkh' --subject-prefix 'PATCH 6.6.y' 'HEAD^..'

Possible dependencies:



thanks,

greg k-h

------------------ original commit in Linus's tree ------------------

From 11ea5a63d30ad6d305b1c22301cd99ff45a98c8d Mon Sep 17 00:00:00 2001
From: Daniel Starke <daniel.starke@siemens.com>
Date: Wed, 26 Aug 2026 08:30:26 +0200
Subject: [PATCH] tty: n_gsm: fix missing modem controls after DLCI open in
 convergence layer type 2

The current implementation only updates the virtual V.24 control signals
after DLCI open in basic option mode. In advanced option mode with
convergence layer type 2 an empty data frame needs to be transmitted to
inform the peer about the initial virtual V.24 control signals. Not doing
so has two unwanted side effects:
1. hardware flow control status is unclear (initial CTS line is unknown)
2. DLCI user presence is not transmitted (initial DTR line is unknown)

Applications waiting on these lines can not start after a DLCI has been
opened until the first data frame has been transmitted.

Fix this by using gsm_modem_update() thoroughly which handles basic and
advanced option mode correctly. Add a flag in gsm_modem_update() and the
delegated gsm_modem_upd_via_msc() to control whether waiting for the MSC
command response is possible. Remove obsolete gsm_modem_send_initial_msc().

Fixes: 3cf0b3c243e5 ("tty: n_gsm: Don't block input queue by waiting MSC")
Cc: stable <stable@kernel.org>
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
Link: https://patch.msgid.link/20260826063026.2472-1-daniel.starke@siemens.com
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index c13e050de83b..e55779ff0af2 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -454,14 +454,13 @@ static const u8 gsm_fcs8[256] = {
 
 static void gsm_dlci_close(struct gsm_dlci *dlci);
 static int gsmld_output(struct gsm_mux *gsm, u8 *data, int len);
-static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk);
+static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk, bool wait);
 static struct gsm_msg *gsm_data_alloc(struct gsm_mux *gsm, u8 addr, int len,
 								u8 ctrl);
 static int gsm_send_packet(struct gsm_mux *gsm, struct gsm_msg *msg);
 static struct gsm_dlci *gsm_dlci_alloc(struct gsm_mux *gsm, int addr);
 static void gsmld_write_trigger(struct gsm_mux *gsm);
 static void gsmld_write_task(struct work_struct *work);
-static int gsm_modem_send_initial_msc(struct gsm_dlci *dlci);
 
 /**
  *	gsm_fcs_add	-	update FCS
@@ -2174,7 +2173,7 @@ static void gsm_dlci_open(struct gsm_dlci *dlci)
 		pr_debug("DLCI %d goes open.\n", dlci->addr);
 	/* Send current modem state */
 	if (dlci->addr) {
-		gsm_modem_send_initial_msc(dlci);
+		gsm_modem_update(dlci, 0, false);
 	} else {
 		/* Start keep-alive control */
 		gsm->ka_num = 0;
@@ -4136,9 +4135,10 @@ static void gsm_modem_upd_via_data(struct gsm_dlci *dlci, u8 brk)
  *	gsm_modem_upd_via_msc	-	send modem bits via control frame
  *	@dlci: channel
  *	@brk: break signal
+ *	@wait: wait for the MSC command
  */
 
-static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
+static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk, bool wait)
 {
 	u8 modembits[3];
 	struct gsm_control *ctrl;
@@ -4155,41 +4155,22 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
 		modembits[2] = (brk << 4) | 2 | EA; /* Length, Break, EA */
 		len++;
 	}
+	if (!wait)
+		return gsm_control_command(dlci->gsm, CMD_MSC, modembits, len);
 	ctrl = gsm_control_send(dlci->gsm, CMD_MSC, modembits, len);
 	if (ctrl == NULL)
 		return -ENOMEM;
 	return gsm_control_wait(dlci->gsm, ctrl);
 }
 
-/**
- * gsm_modem_send_initial_msc - Send initial modem status message
- *
- * @dlci: channel
- *
- * Send an initial MSC message after DLCI open to set the initial
- * modem status lines. This is only done for basic mode.
- * Does not wait for a response as we cannot block the input queue
- * processing.
- */
-static int gsm_modem_send_initial_msc(struct gsm_dlci *dlci)
-{
-	u8 modembits[2];
-
-	if (dlci->adaption != 1 || dlci->gsm->encoding != GSM_BASIC_OPT)
-		return 0;
-
-	modembits[0] = (dlci->addr << 2) | 2 | EA; /* DLCI, Valid, EA */
-	modembits[1] = (gsm_encode_modem(dlci) << 1) | EA;
-	return gsm_control_command(dlci->gsm, CMD_MSC, (const u8 *)&modembits, 2);
-}
-
 /**
  *	gsm_modem_update	-	send modem status line state
  *	@dlci: channel
  *	@brk: break signal
+ *	@wait: wait for the MSC command
  */
 
-static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
+static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk, bool wait)
 {
 	if (dlci->gsm->dead)
 		return -EL2HLT;
@@ -4199,7 +4180,7 @@ static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
 		return 0;
 	} else if (dlci->gsm->encoding == GSM_BASIC_OPT) {
 		/* Send as MSC control message. */
-		return gsm_modem_upd_via_msc(dlci, brk);
+		return gsm_modem_upd_via_msc(dlci, brk, wait);
 	}
 
 	/* Modem status lines are not supported. */
@@ -4265,7 +4246,7 @@ static void gsm_dtr_rts(struct tty_port *port, bool active)
 		modem_tx &= ~(TIOCM_DTR | TIOCM_RTS);
 	if (modem_tx != dlci->modem_tx) {
 		dlci->modem_tx = modem_tx;
-		gsm_modem_update(dlci, 0);
+		gsm_modem_update(dlci, 0, true);
 	}
 }
 
@@ -4471,7 +4452,7 @@ static int gsmtty_tiocmset(struct tty_struct *tty,
 
 	if (modem_tx != dlci->modem_tx) {
 		dlci->modem_tx = modem_tx;
-		return gsm_modem_update(dlci, 0);
+		return gsm_modem_update(dlci, 0, true);
 	}
 	return 0;
 }
@@ -4553,7 +4534,7 @@ static void gsmtty_throttle(struct tty_struct *tty)
 		dlci->modem_tx &= ~TIOCM_RTS;
 	dlci->throttled = true;
 	/* Send an MSC with RTS cleared */
-	gsm_modem_update(dlci, 0);
+	gsm_modem_update(dlci, 0, true);
 }
 
 static void gsmtty_unthrottle(struct tty_struct *tty)
@@ -4565,7 +4546,7 @@ static void gsmtty_unthrottle(struct tty_struct *tty)
 		dlci->modem_tx |= TIOCM_RTS;
 	dlci->throttled = false;
 	/* Send an MSC with RTS set */
-	gsm_modem_update(dlci, 0);
+	gsm_modem_update(dlci, 0, true);
 }
 
 static int gsmtty_break_ctl(struct tty_struct *tty, int state)
@@ -4583,7 +4564,7 @@ static int gsmtty_break_ctl(struct tty_struct *tty, int state)
 		if (encode > 0x0F)
 			encode = 0x0F;	/* Best effort */
 	}
-	return gsm_modem_update(dlci, encode);
+	return gsm_modem_update(dlci, encode, true);
 }
 
 static void gsmtty_cleanup(struct tty_struct *tty)

