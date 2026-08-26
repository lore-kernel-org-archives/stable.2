Received: from mta-65-227.siemens.flowmailer.net (mta-65-227.siemens.flowmailer.net [185.136.65.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3E9D63A9DB1
	for <stable@vger.kernel.org>; Wed, 26 Aug 2026 06:30:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.136.65.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787725845; cv=none; b=scZrnkx1nZVbkyIA/lu/CoNc3xKnUnf5+jpmdBLeOQ7Aaxn+Q29c0HsqLxE+Ka3wqxyKXqRPFC4bN3XSCAYm+EdE/e82gvmY6ZUclhxWrolkKGjU19CnoWdTZP/dd5ePAa9GScH1zuMSiX+a5xJ9fdwz/0AJ2uguXczeKbRwRgY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787725845; c=relaxed/simple;
	bh=FOszNFw/4sQEKe6yUgGVhemf+EWgIQM+e/WBa/O7Qfc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=NoqQqxsSB6OFIUygN9zFSP4IH9XfeXw+stKyeiQSfR+f2OpGsxucesPXCWQqS82Ifj5Y9JzAlgSk3DB1yvLj+ngUN7QaIRfJeI5JlmRqlVwlBCUHaazbKPYwtbmdnv7R77ltcNfii7jUVc7n5Ms94M9GmMNkrNBsN6iExuDqaHM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com; dkim=pass (2048-bit key) header.d=siemens.com header.i=daniel.starke@siemens.com header.b=FbaEqoEU; arc=none smtp.client-ip=185.136.65.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=siemens.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=rts-flowmailer.siemens.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=siemens.com header.i=daniel.starke@siemens.com header.b="FbaEqoEU"
Received: by mta-65-227.siemens.flowmailer.net with ESMTPSA id 20260826063026e49758ecad000207b9
        for <stable@vger.kernel.org>;
        Wed, 26 Aug 2026 08:30:27 +0200
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; s=fm2;
 d=siemens.com; i=daniel.starke@siemens.com;
 h=Date:From:Subject:To:Message-ID:MIME-Version:Content-Type:Content-Transfer-Encoding:Cc;
 bh=vJra5ilEIV8G2ps9USDPGZ/zNoOM9txTTcFpCz8N5Q4=;
 b=FbaEqoEUtRZ7bgR1hMmtpd+XL5X1D705u35h4AonusBUsBUVypFNU4TXk1Ho6KHqJ5YTHR
 QwGa4jXQi9K62ptKDKOXV8+PyLCGz0EHpBCarN76h4ziK9jp/dKSUWEDIx20lE3El4/huIjP
 uDRrL1mNg4eHzL1jw3YgmPL7PHcAZQ8n5CDQ94tv5gR0HNou5THk7GpzhmVIEmBZY6Thl6+6
 HJEI6iqLE6b1WCKZODK1oN/KqxwIEHGOTt3Ag9YzS69c/uxazJpTdaU/b4P+McV6RXwU1HqX
 6smMccmoXNaAtyHqnqN/MaExfLjd6UWRPwGL3OMUZSgOeoQ3Di2z1H5w==;
From: "D. Starke" <daniel.starke@siemens.com>
To: linux-serial@vger.kernel.org,
	gregkh@linuxfoundation.org,
	jirislaby@kernel.org,
	seppo.takalo@nordicsemi.no
Cc: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Daniel Starke <daniel.starke@siemens.com>
Subject: [PATCH 1/1] tty: n_gsm: fix missing modem controls after DLCI open in convergence layer type 2
Date: Wed, 26 Aug 2026 08:30:26 +0200
Message-ID: <20260826063026.2472-1-daniel.starke@siemens.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Flowmailer-Platform: Siemens
Feedback-ID: 519:519-314044:519-21489:flowmailer

From: Daniel Starke <daniel.starke@siemens.com>

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
Cc: stable@vger.kernel.org
Signed-off-by: Daniel Starke <daniel.starke@siemens.com>
---
 drivers/tty/n_gsm.c | 47 ++++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

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
-- 
2.43.0

