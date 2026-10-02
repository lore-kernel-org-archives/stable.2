Received: from mail.savoirfairelinux.com (mail.savoirfairelinux.com [208.88.110.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A1D53AEF24;
	Fri,  2 Oct 2026 18:42:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=208.88.110.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790966541; cv=none; b=O6hdOG6ramQs9d+Lc+CAEJ3Q9gJTL5qKJkH3vHHWjvz0/5ow8gL4Gr7KWImXBO0XleNgK6ZUc8QBqNKkwG039JqeF3S4t3sQE8MfdHZ98sIncAlNfxzR3FUq8KasBv7loTKzX5f3Yq7aA1f3MgAdkaNX75Dzfp4I20BFwyaE5/E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790966541; c=relaxed/simple;
	bh=oisXcTJ9rN/JqV4S6YhuiOPIB3Nlgae9GHCl6jZn288=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=UcSKWpy0pyyOYAoLx65ilzs3mg8F7G8HlB5c0/WIcOWcybEcJkYQUogoebzmkqX05UUAPfjkwFx+Rio1O6uop1yJuy+ntg3YAmNXww/ZfTrw2hI9OoGwBZYmF41mtbIHDcrr6pihIN94LS3+211cLyLotzTtS1VdZ0OL5Mlj564=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=savoirfairelinux.com; spf=none smtp.mailfrom=mail.savoirfairelinux.com; dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b=Roh0qCjg; arc=none smtp.client-ip=208.88.110.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=mail.savoirfairelinux.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=savoirfairelinux.com header.i=@savoirfairelinux.com header.b="Roh0qCjg"
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id BBCE03D81839;
	Fri,  2 Oct 2026 14:35:42 -0400 (EDT)
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10032)
 with ESMTP id 06V3Hts8TVfr; Fri,  2 Oct 2026 14:35:41 -0400 (EDT)
Received: from localhost (localhost [127.0.0.1])
	by mail.savoirfairelinux.com (Postfix) with ESMTP id 2BD553D81846;
	Fri,  2 Oct 2026 14:35:41 -0400 (EDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.savoirfairelinux.com 2BD553D81846
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=savoirfairelinux.com; s=DFC430D2-D198-11EC-948E-34200CB392D2;
	t=1790966141; bh=ocWsfnL4ZNF9F/ibmOKh10OnqNUAfFtCOc+pug7u1EQ=;
	h=From:To:Date:Message-Id:MIME-Version;
	b=Roh0qCjgWQw49srJRpXpQ8FP+vlu4ZI06Y0/BFGDKlrvsAL0hDwbO2z8jQM2iB4u0
	 qBr0BD/znA+p8y5pTgEfBrNOJ1mWbke+RqlOwf9qeLFzBriezsXL7mXipTaNLjudlR
	 i0aD3nZGQ7H9M/3LdMxkZ+JIKT5pDW7EhdqapuFbeMkZzcHDWJd0ojGu/kjLzb92FD
	 DBuXh5weHLZQ0flfSDaHlHdDHV0CREPEItjpubj5xHvGqA2Ws5fy6o0RqhqCrcaaRu
	 rESwMMj90idVXMo68uu/HyjB1bVWsgVugcTRG/zdDVNfJeO091/QHCj63xuHM9NxyX
	 9uiZUBuVZLXHA==
X-Virus-Scanned: amavis at mail.savoirfairelinux.com
Received: from mail.savoirfairelinux.com ([127.0.0.1])
 by localhost (mail.savoirfairelinux.com [127.0.0.1]) (amavis, port 10026)
 with ESMTP id 7CYMOHAZ22RR; Fri,  2 Oct 2026 14:35:41 -0400 (EDT)
Received: from localhost (unknown [192.168.51.254])
	by mail.savoirfairelinux.com (Postfix) with ESMTPSA id E0A363D815B9;
	Fri,  2 Oct 2026 14:35:40 -0400 (EDT)
From: Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>
To: Linus Walleij <linusw@kernel.org>,
	Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc: Maxime Ripard <mripard@kernel.org>,
	=?UTF-8?q?Myl=C3=A8ne=20Josserand?= <mylene.josserand@bootlin.com>,
	Alistair Francis <alistair@alistair23.me>,
	Hugo Villeneuve <hvilleneuve@dimonoff.com>,
	Marc-Olivier Champagne <marc-olivier.champagne@savoirfairelinux.com>,
	linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jerome Oufella <jerome.oufella@savoirfairelinux.com>,
	Felix Boucher <felix.boucher@savoirfairelinux.com>,
	Quentin Lehoux <quentin.lehoux@savoirfairelinux.com>
Subject: [PATCH 2/3] Input: cyttsp5 - init IRQ early to avoid app startup problems
Date: Fri,  2 Oct 2026 14:35:28 -0400
Message-Id: <20261002183529.166248-3-marc-olivier.champagne@savoirfairelinux.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261002183529.166248-1-marc-olivier.champagne@savoirfairelinux.com>
References: <20261002183529.166248-1-marc-olivier.champagne@savoirfairelinux.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable

Sometimes, the driver reports an error when trying to start the
application.

After a reset, the bootloader will assert the interrupt pin to indicate
when it is ready to communicate with the host; on our hardware this
happens about 3.4 ms after the reset line is released. But since
cyttsp5_probe() configures the IRQ and then immediately jumps to
cyttsp5_startup(), there is a chance that the interrupt pin assertion
can happen at around the same time that we try to deassert it by
calling cyttsp5_deassert_int().

Initializing the IRQ while the reset pin is asserted ensures that this
first interrupt is handled by cyttsp5_handle_irq(), which deasserts the
interrupt pin by reading the input buffer. Therefore, calling
cyttsp5_deassert_int() is no longer needed in that case.

However, when cyttsp5_handle_irq() has processed that first interrupt,
it has set the cmd_done completion. Because of that, the launch
application command would complete before its own response has been
received. Instead of sleeping a fixed 20 ms and hoping the reset
sentinel has already been received, wait for it explicitly after
releasing the reset line, so that its completion is consumed before the
first command is sent.

Without a reset line, the device may still be powering up if enabling
the regulators turned it on, or may already be running, and the reset
sentinel may have been raised before the IRQ was requested. Keep the
20 ms delay and the cyttsp5_deassert_int() call in that case, then wait
for the interrupt handler to finish and drop the completion it may have
set, so that the sentinel does not complete the first command either
way.

This relies on the previous patch, which makes cyttsp5_handle_irq()
reliably identify the reset sentinel.

Fixes: 5b0c03e24a06 ("Input: Add driver for Cypress Generation 5 touchscr=
een")
Cc: stable@vger.kernel.org
Suggested-by: Hugo Villeneuve <hvilleneuve@dimonoff.com>
Assisted-by: Copilot:claude-fable-5.1
Signed-off-by: Marc-Olivier Champagne <marc-olivier.champagne@savoirfaire=
linux.com>
---
 drivers/input/touchscreen/cyttsp5.c | 66 +++++++++++++++++++++++------
 1 file changed, 53 insertions(+), 13 deletions(-)

diff --git a/drivers/input/touchscreen/cyttsp5.c b/drivers/input/touchscr=
een/cyttsp5.c
index 04e141eceb45..beeb7d5bcd2c 100644
--- a/drivers/input/touchscreen/cyttsp5.c
+++ b/drivers/input/touchscreen/cyttsp5.c
@@ -88,6 +88,7 @@
 #define CY_HID_OUTPUT_GET_SYSINFO_TIMEOUT_MS	3000
 #define CY_HID_GET_HID_DESCRIPTOR_TIMEOUT_MS	4000
 #define CY_HID_SET_POWER_TIMEOUT		500
+#define CY_HID_RESET_SENTINEL_TIMEOUT_MS	1000
=20
 /* maximum number of concurrent tracks */
 #define TOUCH_REPORT_SIZE			10
@@ -760,6 +761,30 @@ static int cyttsp5_deassert_int(struct cyttsp5 *ts)
 	return -EINVAL;
 }
=20
+/*
+ * After a reset the device asserts the interrupt line with a zero-lengt=
h
+ * report (reset sentinel) once it is ready to communicate. Consume it s=
o
+ * that it does not complete the next command.
+ */
+static int cyttsp5_wait_reset_sentinel(struct cyttsp5 *ts)
+{
+	unsigned long timeout =3D msecs_to_jiffies(CY_HID_RESET_SENTINEL_TIMEOU=
T_MS);
+	int rc;
+
+	rc =3D wait_for_completion_interruptible_timeout(&ts->cmd_done, timeout=
);
+	if (rc <=3D 0) {
+		dev_err(ts->dev, "Reset sentinel timed out\n");
+		return -ETIMEDOUT;
+	}
+
+	if (get_unaligned_le16(&ts->response_buf[0]) !=3D 0) {
+		dev_err(ts->dev, "Unexpected report instead of reset sentinel\n");
+		return -EPROTO;
+	}
+
+	return 0;
+}
+
 static int cyttsp5_fill_all_touch(struct cyttsp5 *ts)
 {
 	struct cyttsp5_sysinfo *si =3D &ts->sysinfo;
@@ -786,12 +811,6 @@ static int cyttsp5_startup(struct cyttsp5 *ts)
 {
 	int error;
=20
-	error =3D cyttsp5_deassert_int(ts);
-	if (error) {
-		dev_err(ts->dev, "Error on deassert int r=3D%d\n", error);
-		return -ENODEV;
-	}
-
 	/*
 	 * Launch the application as the device starts in bootloader mode
 	 * because of a power-on-reset
@@ -888,13 +907,6 @@ static int cyttsp5_probe(struct device *dev, struct =
regmap *regmap, int irq,
 		return error;
 	}
=20
-	fsleep(10); /* Ensure long-enough reset pulse (minimum 10us). */
-
-	gpiod_set_value_cansleep(ts->reset_gpio, 0);
-
-	/* Need a delay to have device up */
-	msleep(20);
-
 	error =3D devm_request_threaded_irq(dev, irq, NULL, cyttsp5_handle_irq,
 					  IRQF_ONESHOT, name, ts);
 	if (error) {
@@ -902,6 +914,34 @@ static int cyttsp5_probe(struct device *dev, struct =
regmap *regmap, int irq,
 		return error;
 	}
=20
+	fsleep(10); /* Ensure long-enough reset pulse (minimum 10us). */
+
+	gpiod_set_value_cansleep(ts->reset_gpio, 0);
+
+	if (ts->reset_gpio) {
+		error =3D cyttsp5_wait_reset_sentinel(ts);
+		if (error)
+			return error;
+	} else {
+		/*
+		 * Without a reset line, the device may be powering up or
+		 * already running. Give it time to come up, then make sure a
+		 * reset sentinel does not complete the first command: read it
+		 * if it came before the IRQ was requested, otherwise drop the
+		 * completion set by the interrupt handler.
+		 */
+		msleep(20);
+
+		error =3D cyttsp5_deassert_int(ts);
+		if (error) {
+			dev_err(ts->dev, "Error on deassert int r=3D%d\n", error);
+			return error;
+		}
+
+		synchronize_irq(irq);
+		try_wait_for_completion(&ts->cmd_done);
+	}
+
 	error =3D cyttsp5_startup(ts);
 	if (error) {
 		dev_err(ts->dev, "Fail initial startup r=3D%d\n", error);
--=20
2.34.1

