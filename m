Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E8141489FD7;
	Fri,  2 Oct 2026 11:13:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790939590; cv=none; b=BVvZ+N/C9u5v2KYPVbos/sCNwGFHvo06r7HYjPrjyi+3f7LZcKwC+gCsjaGze8bvpRuuX+pSlNYeV/jdEtSM4GGYhtRiaeUTx7gf4JoG2PhPycrmKa+czJlsuEnGBbm4VzWp0+QRf0NPiUKfljLJk1GFuZA/JwyAIU5X3i28NBI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790939590; c=relaxed/simple;
	bh=gb+fwROmnOkLdeNycb9l18F0EWuU7KY89ynmb/WqDF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dgD7ZbliFD1I/LxwmfbcNgPX9Ken3KJbp+LN8x36NMmWIhTWLZD5iDgzraEkHQqVB1EYzHt3tUk8weAbr6o8nGXVzOYIdtzY2Z57zCWkFaRi/Cduv18qEXEJdgsD7cvBpgn8/c0mQrmbO2ZAOdbG1le12CUoks6vQ3UhRNGmuvA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=SIoUBqjA; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="SIoUBqjA"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 17B484E4110C;
	Fri,  2 Oct 2026 11:13:06 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id D915B603DC;
	Fri,  2 Oct 2026 11:13:05 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 02D121032811F;
	Fri,  2 Oct 2026 13:12:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1790939581; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HAyABBQS0V8BnfnIm9rFYNSgw2zlmJq/eAOs916odWA=;
	b=SIoUBqjA+FBYFkRkesp8iOB0xCQsNyp45cHA8EaccTOvFFwoGyj7GeI3dZr4HbQLuNPwFc
	Cd4aXC86+PSxr8vGz9qdJFrQRYygjF+IQfHRWaAGVlVLGjIPr0QucU7pdFD43gGpUrmSsG
	9jWWCr8eIitcfFMXFDrnef8nCfvXlcryyp/CYKs/aTpo5ZHtcAcFC2nolAZQTwMLBMuczM
	UAtqrhbbslr4RRKT71MvaRkX/PU/h6lLO81Tot5FGP+z5wCNIWs7vF6Y3ypGdF6tYLkpi3
	kRtNja7Xhzwu7kooXO/2Bpvimw0wvTAgxh2B60jmD1R/YlT7TxUPwHD7XUxlyQ==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 02 Oct 2026 13:12:39 +0200
Subject: [PATCH v4 1/9] mfd: cgbc: Fix use of negative error code as valid
 session handle
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261002-cgbc-i2c-storage-devices-support-v4-1-eb42e0f1df59@bootlin.com>
References: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
In-Reply-To: <20261002-cgbc-i2c-storage-devices-support-v4-0-eb42e0f1df59@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3

The cgbc_session_command() return value was directly cast to u8 and used
as session handle without error checking. Casting a negative error to u8
produces a valid-looking session handle. So check if return value is
positive before to cast and use it.

Cc: stable@vger.kernel.org
Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260713-cgbc-core-fix-cgbc-remove-v1-1-79274ad62b3a%40bootlin.com?part=1
Fixes: 6f1067cfbee7 ("mfd: Add Congatec Board Controller driver")
Signed-off-by: Thomas Richard (congatec GmbH) <thomas.richard@bootlin.com>
---
 drivers/mfd/cgbc-core.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 2becaf797646..4a409234e66c 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -103,7 +103,11 @@ static int cgbc_session_request(struct cgbc_device_data *cgbc)
 	if (ret)
 		return dev_err_probe(cgbc->dev, ret, "device not found or not ready\n");
 
-	cgbc->session = cgbc_session_command(cgbc, CGBC_SESSION_CMD_REQUEST);
+	ret = cgbc_session_command(cgbc, CGBC_SESSION_CMD_REQUEST);
+	if (ret < 0)
+		return dev_err_probe(cgbc->dev, ret, "session handle request timed out\n");
+
+	cgbc->session = ret;
 
 	/* The Board Controller sent us a wrong session handle, we cannot communicate with it */
 	if (cgbc->session < CGBC_SESSION_VALID_MIN || cgbc->session > CGBC_SESSION_VALID_MAX)

-- 
2.53.0

