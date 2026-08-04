Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E701745DF41;
	Tue,  4 Aug 2026 14:56:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.246.85.4
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785855377; cv=none; b=HGfRJPLuLaP9DOjkpECZCqDL9gHcr1uZfNLnkf3SiUIXZrhNaHeCLRU2bZT6ssm/7SAvF8KQQ+FDGFZ/2ZoAe/C0vCOKeFnJDSKWmcCnAFqNFGZLANKnNioUBbOQCUxM0dO2879NHNlTSa+Vjf9msUfJs/Cn21D3hyWf+lGa0a8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785855377; c=relaxed/simple;
	bh=gb+fwROmnOkLdeNycb9l18F0EWuU7KY89ynmb/WqDF4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jKS4bDqQdpc4K0APJrek7VeKD4S+4iwKaGbdWLDg+DDcVr53vDr+uS32wc4TduIMMkjK0OZhmMYLNbwxSzhfiqDlfqmnJojAL4pyt7xXbg8zo2m0MT0RyBkhd156vaZnj7pRi1CzjCICAeofNPM2JjfboMUctYC7pAdlxwZCACk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com; spf=pass smtp.mailfrom=bootlin.com; dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b=UWyDvUBP; arc=none smtp.client-ip=185.246.85.4
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.b="UWyDvUBP"
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 55D7B4E410DF;
	Tue,  4 Aug 2026 14:56:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 208A26029E;
	Tue,  4 Aug 2026 14:56:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9FF5B11C32F24;
	Tue,  4 Aug 2026 16:56:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1785855373; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=HAyABBQS0V8BnfnIm9rFYNSgw2zlmJq/eAOs916odWA=;
	b=UWyDvUBPHxqpC/K3b7ba7cNASkBTJy0niCMXlnZ7O11NmoDYJkA/RQQM90r+El7A/m5Bao
	Gdf9W97gY6A+k/eiqdfzC3LVMIoPVE8HtU8XYait/AWxfvyLhfehdsayyAq7/A5sPFb0xi
	7i9M/1ko00erOTvJ+dWxry8pGEY2NGXFjzvILiwRtvYo7iTyHKIa0oE5/9DjEnWnfyJeO4
	k5cJy8vsnErdHNVw2P5uvQh3HhHSH1id4KVT4kZq0HJKiGpXKGIyrf3EwYSBphxY3dbKeL
	qDMq+Rdz11ABjPNWp9iw8gmP0dm+Eqae8Km7fJMFoV4kW1D6kU08fXeQKpI6Cw==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 04 Aug 2026 16:55:51 +0200
Subject: [PATCH 1/4] mfd: cgbc: Fix use of negative error code as valid
 session handle
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260804-cgbc-i2c-storage-devices-support-v1-1-fed38510671c@bootlin.com>
References: <20260804-cgbc-i2c-storage-devices-support-v1-0-fed38510671c@bootlin.com>
In-Reply-To: <20260804-cgbc-i2c-storage-devices-support-v1-0-fed38510671c@bootlin.com>
To: Lee Jones <lee@kernel.org>, Andi Shyti <andi.shyti@kernel.org>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Werner Gartner <Werner.Gartner@congatec.com>, mfd@lists.linux.dev, 
 linux-kernel@vger.kernel.org, linux-i2c@vger.kernel.org, 
 "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>, 
 stable@vger.kernel.org, Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
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

