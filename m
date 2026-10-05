Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 451714D0A15
	for <stable@vger.kernel.org>; Mon,  5 Oct 2026 20:25:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791231921; cv=none; b=Kmlm4kOL1TlrvpUdQlZ4DsL8Pp9iD5ybBc4X4DnYxD2yOZSbtv5ZrQFmWTtImRuvaM/qStVL5M7Skv686HnksL6QQ/k/JpaIDuUB+Y8hGZB7C7QPRNlPIlvFpP1EYoiTSe4QMlczP4tAE0p+eVBgTfwBzOCwEqPJjEm7TIM/VW4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791231921; c=relaxed/simple;
	bh=VE1yCjgHT5jj0YWsaBQ3DOiRYPz2rfFYF6VGWA+ouTI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rRaltcsSH0yRd7EYoekAL9bITGCUV8nuiUTIE0FK0HUpIaAE0iVoCxH465GSKK1de7ghHPWBCIyBzkWrutNNyCztOasitiWCqjFzfo6oSQW+M3kJTFHw68p2VdUuIXF1x1GMISpDGSKhWXMgrhtSa57YqESrAIzwoWebPNIhbes=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Y1vEQDK7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Y1vEQDK7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 472FF1F000FF;
	Mon,  5 Oct 2026 20:25:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791231917;
	bh=RaZtcr3twxwUQP1YA2l3cO2kDvX1rVaa+6f+IyRV+cc=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=Y1vEQDK7H11nWCOvtnUrdV/Hm9SOntYwKLeToncEuXe2dx+8aL1uKfisugCB+zzyG
	 qijDUNsgwV5XHos0Aoz8cUqKAoXl/EOnQQbmwgMSdmF97fYjxgopz2Decy0KA+xaJH
	 YN9OUo2onqwbGbFvC5IZ1Y/MMbp74YnNaZVYKPfJ6/f5h4EIcgW3f4Np1EDF09y7Vf
	 TksU0ADPk9Je0mnPUeYRZYJqhnvi6V6ZHOna1tCcGArDia4fq4+O9jS3lq8P6VXTtQ
	 7f3YVTttnDKv3x4SHZ8isP9vQ6S/JtBQbzGbBZztKWfmbWlqw492PA8g0PbQO0lkdO
	 h3Sb1w48GgiWw==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Daniel Starke <daniel.starke@siemens.com>,
	stable <stable@kernel.org>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 6.6.y] tty: n_gsm: fix missing modem controls after DLCI open in convergence layer type 2
Date: Mon,  5 Oct 2026 16:25:13 -0400
Message-ID: <20261005202453.3273146-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026100503-jot-unopened-3384@gregkh>
References: <2026100503-jot-unopened-3384@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Daniel Starke <daniel.starke@siemens.com>

[ Upstream commit 11ea5a63d30ad6d305b1c22301cd99ff45a98c8d ]

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
[ sashal: Adjusted context to match the existing @dlci annotation without a colon. ]
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/tty/n_gsm.c | 47 ++++++++++++++-------------------------------
 1 file changed, 14 insertions(+), 33 deletions(-)

diff --git a/drivers/tty/n_gsm.c b/drivers/tty/n_gsm.c
index 901f5c8311fbf..2c1523b58313a 100644
--- a/drivers/tty/n_gsm.c
+++ b/drivers/tty/n_gsm.c
@@ -453,14 +453,13 @@ static const u8 gsm_fcs8[256] = {
 
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
@@ -4132,9 +4131,10 @@ static void gsm_modem_upd_via_data(struct gsm_dlci *dlci, u8 brk)
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
@@ -4151,41 +4151,22 @@ static int gsm_modem_upd_via_msc(struct gsm_dlci *dlci, u8 brk)
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
- * @dlci channel
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
@@ -4195,7 +4176,7 @@ static int gsm_modem_update(struct gsm_dlci *dlci, u8 brk)
 		return 0;
 	} else if (dlci->gsm->encoding == GSM_BASIC_OPT) {
 		/* Send as MSC control message. */
-		return gsm_modem_upd_via_msc(dlci, brk);
+		return gsm_modem_upd_via_msc(dlci, brk, wait);
 	}
 
 	/* Modem status lines are not supported. */
@@ -4261,7 +4242,7 @@ static void gsm_dtr_rts(struct tty_port *port, bool active)
 		modem_tx &= ~(TIOCM_DTR | TIOCM_RTS);
 	if (modem_tx != dlci->modem_tx) {
 		dlci->modem_tx = modem_tx;
-		gsm_modem_update(dlci, 0);
+		gsm_modem_update(dlci, 0, true);
 	}
 }
 
@@ -4457,7 +4438,7 @@ static int gsmtty_tiocmset(struct tty_struct *tty,
 
 	if (modem_tx != dlci->modem_tx) {
 		dlci->modem_tx = modem_tx;
-		return gsm_modem_update(dlci, 0);
+		return gsm_modem_update(dlci, 0, true);
 	}
 	return 0;
 }
@@ -4539,7 +4520,7 @@ static void gsmtty_throttle(struct tty_struct *tty)
 		dlci->modem_tx &= ~TIOCM_RTS;
 	dlci->throttled = true;
 	/* Send an MSC with RTS cleared */
-	gsm_modem_update(dlci, 0);
+	gsm_modem_update(dlci, 0, true);
 }
 
 static void gsmtty_unthrottle(struct tty_struct *tty)
@@ -4551,7 +4532,7 @@ static void gsmtty_unthrottle(struct tty_struct *tty)
 		dlci->modem_tx |= TIOCM_RTS;
 	dlci->throttled = false;
 	/* Send an MSC with RTS set */
-	gsm_modem_update(dlci, 0);
+	gsm_modem_update(dlci, 0, true);
 }
 
 static int gsmtty_break_ctl(struct tty_struct *tty, int state)
@@ -4569,7 +4550,7 @@ static int gsmtty_break_ctl(struct tty_struct *tty, int state)
 		if (encode > 0x0F)
 			encode = 0x0F;	/* Best effort */
 	}
-	return gsm_modem_update(dlci, encode);
+	return gsm_modem_update(dlci, encode, true);
 }
 
 static void gsmtty_cleanup(struct tty_struct *tty)
-- 
2.53.0

