Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802321;
	b=AItkDaPKeS/duC5GJckBq3e+qlGnCgAKPthXJsU5XDgPJpdEWPhKDwV7TiWXfeeYxITp
	 pqy0ydw9mloV4CgJ6aTlM2nx8rcGrADpukwjvaiyAeZ2NGmdVTGGdAMlvd7SzvOgPz+bt
	 Rt1QqE2LFaQyzxXaLEAoRVZPLLm5OfdFrG3sAeUatnX7gA0c3ATNlglYWhCtf/zKh5fmn
	 +7PVFDFJ3KGNUmQ1ENhudp+iUqRFmNT3/eAH6rRMJ+AuJNkd2MT7mFFijesxz0IDmDPZN
	 W+LyLhE4Bs7B8izVI74aOCVAmPKdgm9BDGKq+1QWUQUdIUmx8dolxVTXIROJZgY5xKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802321;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=Zr6KbrylqSaWIVwB1seor5jsbMQ4jm8G48aqXN7Veuo=;
	b=BELCEUomvLAFlEzodf5dNqeG43UVQnDUVQUWEY4d28DqGkuguoFPJgXCeMesPsuzT3nY
	 XoZEee4F7vQKcwZ2bZFqjAIANfUXEPCDB2buQSzEXpSgByiJ7f/KwhJG7BzRT2zphCqe0
	 P4C20mWR92rtUO5S1vhYhZSqccOMHGU6kEZunTNlYrLEr1efUV2hCCS0+iUdIdBp7cJYj
	 jZke/NA2uOQ5OK4x8lzcjxiltEq1QjJFbL6Csogp6pS5aq03Wiyd1whGnGipSCgJ9Cw5L
	 xLpRuJvWZ7pXRnbADaIVfniFg5SFd5oo6AGgaaQ4A1At1rGdwFzY4aLvni1CkHzRWXg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rgTntw0g;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D170E606A689
	for <stable@vger.kernel.org>; Fri, 27 Nov 2026 17:58:40 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org D170E606A689
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=rgTntw0g
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 93ABE1A1844;
	Fri, 27 Nov 2026 17:58:39 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 62E9D6049C;
	Fri, 27 Nov 2026 17:58:39 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 78BA3104395A3;
	Fri, 27 Nov 2026 18:58:37 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795802318; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=Zr6KbrylqSaWIVwB1seor5jsbMQ4jm8G48aqXN7Veuo=;
	b=rgTntw0gM5an+kJXkvwx5VIyvwfGRWTpyetEA0xTAkpNvJyZoJy3DduztA4qRQ9gfztPlz
	lbfxkPn3MQd0ejSRHlZ+p1e1uyXh6uALWtIO7oimZIsWOtt2GdZKGWSMJ+lvWDLZVhrjI3
	Iw/QtdhJJAqS24D6i7Um27sq6gNaHtfJB4xxnS0wF15R3r9v5u6RNbjOa3+MiTaarG9um3
	M+LpQZNk4ZAKrHsg4j13H8uqgx1dNrwWqcEEwEFwQ+BeG9GvYxmHGQPQHM1JcVW7Gw637T
	UY7RacWfkxaAeQLuR0/ai9MA2Cazc6hjx4wGGyEirUVw9hgLzWY/HrSwPomdrQ==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 27 Nov 2026 18:57:55 +0100
Subject: [PATCH v7 11/11] i2c: cgbc: Fetch the status of a write transfer
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Post: <mailto:stable@vger.kernel.org>
List-Help: <mailto:stable+help@vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
List-Owner: <mailto:stable+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261127-cgbc-i2c-storage-devices-support-v7-11-d0e70fc57879@bootlin.com>
References: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
In-Reply-To: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>, 
 Markus Haberlander <markus.haberlander@rosenberger.com>, 
 stable@vger.kernel.org
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

From: Markus Haberlander <markus.haberlander@rosenberger.com>

A write transfer sends the I2C command to the board controller and
returns without reading the controller's I2C status, while a read polls
the status until the controller is no longer busy. The status of a write
is therefore never fetched:

- the write reports success before the bus transfer has finished, and
  an error such as a NAK is only reported by the next transfer;
- the controller keeps the status of the last write pending. On a
  conga-PA7 (BIOS PA70R026, board controller CGBCP032), a board reset
  with a write status pending does not power the board up again: after
  a reboot that follows a write on the general purpose bus, the board
  stays off until it is power cycled.

Read the status after a write as well, as the read path does: poll until
the controller is no longer busy, return the error it reports, and treat
any state other than idle as an error.

Tested on a conga-PA7 with v6.18.64 and "i2c: cgbc: Propagate hardware
errors when polling read status": without this patch, a write to an
absent address returns success, the next read fails, and a reboot after
a write does not come back. With it, the write itself fails, the next
transfer succeeds, and 14 reboots, each right after an acknowledged or a
NAKed write, all came back.

The patch and this changelog were drafted with the help of Claude
Opus 5.5 and reviewed and tested by me.

Fixes: 6894f640b8f3 ("i2c: Congatec Board Controller i2c bus driver")
Cc: stable@vger.kernel.org
Signed-off-by: Markus Haberlander <markus.haberlander@rosenberger.com>
Reviewed-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
Tested-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
[Thomas: Use USEC_PER_SEC]
Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/i2c/busses/i2c-cgbc.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/drivers/i2c/busses/i2c-cgbc.c b/drivers/i2c/busses/i2c-cgbc.c
index 5105b920e919..852fcb9e21fa 100644
--- a/drivers/i2c/busses/i2c-cgbc.c
+++ b/drivers/i2c/busses/i2c-cgbc.c
@@ -255,6 +255,22 @@ static int cgbc_i2c_xfer_msg(struct i2c_adapter *adap)
 		ret = cgbc_command(cgbc, &cmd, cmd_len, NULL, 0, NULL);
 		if (ret)
 			goto err;
+
+		ret = read_poll_timeout(cgbc_i2c_get_status, status,
+					status != CGBC_I2C_STAT_BUSY, 0,
+					USEC_PER_SEC, false, adap);
+		if (ret)
+			goto err;
+
+		if (status < 0) {
+			ret = status;
+			goto err;
+		}
+
+		if (status != CGBC_I2C_STAT_IDL) {
+			ret = -EIO;
+			goto err;
+		}
 	} else if (i2c->state == CGBC_I2C_STATE_READ) {
 		xfer.write = 0;
 		xfer.read = len;

-- 
2.53.0

