Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA81B30DD10;
	Sun,  4 Oct 2026 23:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791158222; cv=none; b=aX6Myu+8eelhWxd9LwHp+/3HOozRCQLJ9cNxghOH6LlcNZ5myCCnG8zgzUEMJ+rqBVx0psDIuAxwHJUx2iHye9Ms5gIz3i+hu3kI7bHh6ZSZ8KUHxI8rID0BMpELxQwkjDMU9ZnQzaodL1eMAH2NCgHigkiS2iQqOMhpuTMaOvA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791158222; c=relaxed/simple;
	bh=RBW/AScZyJu3/Gw/LE/zFDLua18BzFY0Xm+UOGzItuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:To:Cc; b=meR4iR1XFL1yttsgY/vCrMhLClHUNk/aC5tpGUJlOmOvyfbdmtSzxZld+0ayB6waSE0WZAB+NS2p7CE7yFhGU0MmSdXOSjfBC0l+30W8OreCLvGj3TG7BqUKGcF6oFdeB8428eURkxqUFXkHEg5s6Q+HU44DbMFaxyyGBLjof5k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V1Kk1jhE; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V1Kk1jhE"
Received: by smtp.kernel.org (Postfix) with ESMTPS id DC624C2BCB9;
	Sun,  4 Oct 2026 23:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1791158221;
	bh=RBW/AScZyJu3/Gw/LE/zFDLua18BzFY0Xm+UOGzItuw=;
	h=From:Date:Subject:To:Cc:Reply-To:From;
	b=V1Kk1jhEDWyYCAKPZGNsnyVM+hxrBzZqGxSFPO4Sw4bFO5k7S77W8MHRiP9AGStoo
	 CVFwMC+OxZVIMv5cc9I6ENp/rOFbi2zLGUTXAaCRuuyNdSdUwe+cjiyKPsn2fB+yr1
	 88p99hFjL27UepWki8j7GTs6rp39bBVoGzaz0gB8heCNbA6WrqqSNgNXKoIt+QYWaE
	 j4l+KR9WqGJXy5ZXXoJHfammsigTJiA2dsj8+a+Am6rvnczT3Iq+gB3+zdqLYGokT8
	 1rt8LRwtr5zjZIuvPhjQfotH2A3qCiPigwTHwL2X6NchovZsLjMJSE+Kn/AzPppi/I
	 ZDWmBH4yv7rWQ==
Received: from aws-us-west-2-korg-lkml-1.web.codeaurora.org (localhost.localdomain [127.0.0.1])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9F05CA5FF5;
	Sun,  4 Oct 2026 23:57:01 +0000 (UTC)
From: Igor Velkov via B4 Relay <devnull+iav.iav.lv@kernel.org>
Date: Sun, 04 Oct 2026 23:56:53 +0000
Subject: [PATCH] rtc: pcf8563: pass the driver data to the alarm interrupt
 handler
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261004-pcf8563-irq-data-v1-1-f176763ddf2f@iav.lv>
X-B4-Tracking: v=1; b=H4sIAMTnwmoC/x3MQQ5AMBBA0avIrE0ySktdRSyKwWyoVkQi7q6xf
 Iv/H4gchCO02QOBL4mybwlFnsG4um1hlCkZFClTEGn049xoU6KEAyd3OjRDRVZZVdeaIGU+8Cz
 3v+z69/0AWucVj2IAAAA=
To: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: Nobuhiro Iwamatsu <iwamatsu@nigauri.org>, linux-rtc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, stable@vger.kernel.org, 
 Igor Velkov <iav@iav.lv>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1490; i=iav@iav.lv;
 h=from:subject:message-id;
 bh=pgQ6LIQ51UNGiuJ/Vyx/S0XE1D1zzqJGLztwxvNwcnA=;
 b=owGbwMvMwCVmNH1q96v4SmbG02pJDFmHnp9Q82D8NGOhXbNL47YzUbkzL6xRXPa8bqPbFwXVl
 muHhIQ9OkpZGMS4GGTFFFkmHNK4lbHk6l9/D/MHMHNYmUCGMHBxCsBEIhkY/nBtOrSgZPPPQqWz
 n2KCuu57XNJvm/O7878D296UH5WiAX0M/0P3fN/7zG1D/c/FDvEyuXfivW/x3uI75/tKPcK1VbP
 0HA8A
X-Developer-Key: i=iav@iav.lv; a=openpgp;
 fpr=90C228DA68A4D5FD4F4837E03297958BEA5F7903
X-Endpoint-Received: by B4 Relay for iav@iav.lv/default with auth_id=1060
X-Original-From: Igor Velkov <iav@iav.lv>
Reply-To: iav@iav.lv

From: Igor Velkov <iav@iav.lv>

pcf8563_irq() takes its dev_id as struct pcf8563, but probe still
registers the interrupt with the i2c client. The handler then takes the
regmap pointer from the wrong structure: the first alarm oopses, the
level-low INT is never acknowledged, and the interrupt gets disabled as
spurious.

Only an RTC that has an interrupt (client->irq > 0) reaches this path.

Fixes: 00f1bb9b8486 ("rtc: pcf8563: Switch to regmap")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Igor Velkov <iav@iav.lv>
---
Tested on ODROID-HC4, 7.3-rc5, with the INT line wired to GPIOX_5 in the
device tree: the alarm interrupt fires once, the alarm flag is cleared,
no oops.
---
 drivers/rtc/rtc-pcf8563.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/rtc/rtc-pcf8563.c b/drivers/rtc/rtc-pcf8563.c
index 7eebdb058067..0767331a2cc7 100644
--- a/drivers/rtc/rtc-pcf8563.c
+++ b/drivers/rtc/rtc-pcf8563.c
@@ -531,7 +531,7 @@ static int pcf8563_probe(struct i2c_client *client)
 		err = devm_request_threaded_irq(&client->dev, client->irq,
 				NULL, pcf8563_irq,
 				IRQF_SHARED | IRQF_ONESHOT | irqflags,
-				pcf8563_driver.driver.name, client);
+				pcf8563_driver.driver.name, pcf8563);
 		if (err) {
 			dev_err(&client->dev, "unable to request IRQ %d\n",
 								client->irq);

---
base-commit: 8ef8e9839a23ca7f5dda6a69b670633de5a23716
change-id: 20261005-pcf8563-irq-data-6b4092927750

Best regards,
-- 
Igor Velkov <iav@iav.lv>


