Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A62D4E73DD;
	Mon, 19 Oct 2026 12:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792413294; cv=none; b=oTQOgyvGYCs1n11eJ6f94gxOg2HrRsXND1Rz99kBWk9ebUCAcJ0ev4wWvd0SieZc3g2Lw2OlK71LerPpRTlyeJ6CZrwkHeAAOD27Ku7uAEL7NLvrKDDe/VvGZNrm3noZmiNV1e0HAVzF46FysmMjdCNHy15EFG1U2ockyHUkAbE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792413294; c=relaxed/simple;
	bh=FIumoOSiyMnllkdH7vaQGmgMeA2n14LStVbQbffjoB4=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BcPiLXcMN5FNZmnyVyH4PgwQQTCzS81kGy9UylZIppN2H/pyPf4j9IdDgGbDuj3RaFyNZdImH25fg7q0iJNKROEx50TqXvf2n6BMhyvin029vKeaGtWsTCYNM9ZGWq0PpisXr6y1PY/7IccgDjkG4MWayHcTweXcmSW1f9gskKs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=JAjlQDRV; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="JAjlQDRV"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 13DC01F000C4;
	Mon, 19 Oct 2026 12:34:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792413278;
	bh=pfqRwNvIDXgUK6rGQbaCri0jI6Kk8YS9TVYwG5chEmA=;
	h=From:To:Cc:Subject:Date;
	b=JAjlQDRVWQwBdvZpZ07ULBaVloHNT/S/NQPi1JoD5macBPZM+Q8vMwqqwfYGUjR92
	 K97xaFoCGYtxkRombanMP3u6Sqm6IFCSKiANyS+ylk2D/918ZavMXI6Vr/v472jIBU
	 p76q1VjWJSaPfYGQXZIRp8oiq1W5lpeiDPXLbn2WmN9rzgtbwtut/SR7DJZjnNfZ3P
	 /3HZ/xyK8b6Di1uaIq7PGjPnCCMfaAGIRPZd3TTugFOzBmZE/DGIJTN81J8CoeziZs
	 sQYnsVWCKUlFcQDokW6qAXMqWggwPI80wLrASB/DSKdXq9P0q1XyL4nW+Qy3OiF67e
	 yVy+wWA3YgfhQ==
Received: from johan by xi.lan with local (Exim 4.99.5)
	(envelope-from <johan@kernel.org>)
	id 1xImZX-00000008QJ0-3pYq;
	Mon, 19 Oct 2026 14:34:35 +0200
From: Johan Hovold <johan@kernel.org>
To: Johan Hovold <johan@kernel.org>
Cc: linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Maksim Salau <maksim.salau@gmail.com>
Subject: [PATCH] USB: serial: upd78f0730: fix NULL-deref on hangup
Date: Mon, 19 Oct 2026 14:34:12 +0200
Message-ID: <20261019123412.2007715-1-johan@kernel.org>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The port tty pointer is cleared on hangup before deasserting the modem
control signals and should not be used in the dtr_rts() callback.

Factor out a new upd78f0730_port_tiocmset() helper that can be used in
upd78f0730_dtr_rts() to avoid dereferencing a NULL-pointer on hangup
(e.g. on disconnect).

This issue was flagged by an LLM.

Fixes: ea534e0b4047 ("USB: serial: add uPD78F0730 USB to Serial Adaptor Driver")
Cc: stable@vger.kernel.org	# 4.11
Cc: Maksim Salau <maksim.salau@gmail.com>
Assisted-by: LLM
Signed-off-by: Johan Hovold <johan@kernel.org>
---
 drivers/usb/serial/upd78f0730.c | 13 +++++++++----
 1 file changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/usb/serial/upd78f0730.c b/drivers/usb/serial/upd78f0730.c
index 78c4d3c19a8e..f2189b994ed7 100644
--- a/drivers/usb/serial/upd78f0730.c
+++ b/drivers/usb/serial/upd78f0730.c
@@ -201,10 +201,9 @@ static int upd78f0730_tiocmget(struct tty_struct *tty)
 	return res;
 }
 
-static int upd78f0730_tiocmset(struct tty_struct *tty,
+static int upd78f0730_port_tiocmset(struct usb_serial_port *port,
 			unsigned int set, unsigned int clear)
 {
-	struct usb_serial_port *port = tty->driver_data;
 	struct upd78f0730_port_private *private;
 	struct upd78f0730_set_dtr_rts request;
 	struct device *dev = &port->dev;
@@ -238,6 +237,13 @@ static int upd78f0730_tiocmset(struct tty_struct *tty,
 	return res;
 }
 
+static int upd78f0730_tiocmset(struct tty_struct *tty, unsigned int set, unsigned int clear)
+{
+	struct usb_serial_port *port = tty->driver_data;
+
+	return upd78f0730_port_tiocmset(port, set, clear);
+}
+
 static int upd78f0730_break_ctl(struct tty_struct *tty, int break_state)
 {
 	struct upd78f0730_port_private *private;
@@ -267,7 +273,6 @@ static int upd78f0730_break_ctl(struct tty_struct *tty, int break_state)
 
 static void upd78f0730_dtr_rts(struct usb_serial_port *port, int on)
 {
-	struct tty_struct *tty = port->port.tty;
 	unsigned int set = 0;
 	unsigned int clear = 0;
 
@@ -276,7 +281,7 @@ static void upd78f0730_dtr_rts(struct usb_serial_port *port, int on)
 	else
 		clear = TIOCM_DTR | TIOCM_RTS;
 
-	upd78f0730_tiocmset(tty, set, clear);
+	upd78f0730_port_tiocmset(port, set, clear);
 }
 
 static speed_t upd78f0730_get_baud_rate(struct tty_struct *tty)
-- 
2.55.0

