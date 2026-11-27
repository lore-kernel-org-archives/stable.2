Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.85.4
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795802299;
	b=ZuzdnEQQC04xqcPqHdNVOPWkSUjNp4SrqbLkifdxRqKxvPeoqCKxjKy9CG2kv/kJV8/w
	 FRo+nvDxlsPgws+/PaXuLRm5GLWcI7ZANdHB5U8+uzLjPTLArWSZB5BEZePSBqFfRVtne
	 +TPp8a5t1F/IwP3PwAFlz5gWYBr/PyKG3UApbJF8jCpB4l7hY0z9ggnnPKAPI9awQarEi
	 YS3VZ0knfOzC8y+1B6XpxySxMb2FEdCpUBEgZwzOSJ+Srp0sFcd032GVPpcV6XP8lyhQH
	 oQuRnfybjajmjZUG70GGMgtay+e7WV77yh74sk0cUfil6vM1gwAkxx9BQ2KqNxJj5wQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795802299;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=IiYxbhfaOx0Q++iKRYbtpp1SJX5K+HM2T6/FfN15lU8=;
	b=m+Sy7HLHhTprizCYhy0JCnCLsN3H0cS7Lj7tiSabCtwVY2RttGyBE8XQHhUn6wZjoVnw
	 lVXx0zMg80WRXHAgXuy6sTDo54OP8bPe/VClwAseKhYFit5XS0QbX7HeCP9xaG86TqwjT
	 tBloodQqZPbiaLrot4al+rF+btcpGlTy+KMs9YNpAMRFx8frTz95p9BkSJ/vHMH+hVdso
	 YYJ0bpGpasrfNNwX6t6TZSbZkIpu5QQup+vSLSMrF3iz5Xf/gHFFKvKsGJ//q7hf0ao8W
	 YTHT9cFtZ0POHt60VPW46VTZcb9qxXYvgRwzlZnyK3MDZTDBIc0CooML1Toai0rRvBQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ZkvEKBIL;
	arc=none smtp.remote-ip=185.246.85.4
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC4C1606A31C;
	Fri, 27 Nov 2026 17:58:18 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org AC4C1606A31C
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=ZkvEKBIL
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-03.galae.net (Postfix) with ESMTPS id 644B44E417C9;
	Fri, 27 Nov 2026 17:58:17 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 39FE86049C;
	Fri, 27 Nov 2026 17:58:17 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 9B750104395A3;
	Fri, 27 Nov 2026 18:58:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1795802292; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=IiYxbhfaOx0Q++iKRYbtpp1SJX5K+HM2T6/FfN15lU8=;
	b=ZkvEKBILYNNrByeeDRhBwumMhkayfUPOoGZgLsbveZ+9A2vQARo/izePj53nrheebWN4yU
	UsVWEHSCYNMMIuQ4hfKa5jCofcOqB6uaB+Jlj6yrrlnphAyj0siEBBqKSABvAyBEE2iCxe
	JIrVgOTwJU7DHv8+jD6sI735JzVQzDcbe8IpRuFw7XqCFl2fjzwMPcZoKSLteYywPL/C84
	Fkip6zWNXWBqebmfcn/h9nYOmb9aYDk6qOMendANxAQjovqDcTyl/znIehIlRonj8M52OM
	jcXIItx2EvXA4tCSZgm5Q7D1+QsowVL1XJLluwrBAOXoJHS5I9qmf6LDdj2p1g==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Fri, 27 Nov 2026 18:57:45 +0100
Subject: [PATCH v7 01/11] mfd: cgbc: Fix use of negative error code as
 valid session handle
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
Message-Id: <20261127-cgbc-i2c-storage-devices-support-v7-1-d0e70fc57879@bootlin.com>
References: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
In-Reply-To: <20261127-cgbc-i2c-storage-devices-support-v7-0-d0e70fc57879@bootlin.com>
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
 drivers/mfd/cgbc-core.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/drivers/mfd/cgbc-core.c b/drivers/mfd/cgbc-core.c
index 8a63923d1912..1d5c99a38e85 100644
--- a/drivers/mfd/cgbc-core.c
+++ b/drivers/mfd/cgbc-core.c
@@ -103,7 +103,12 @@ static int cgbc_session_request(struct cgbc_device_data *cgbc)
 	if (ret)
 		return dev_err_probe(cgbc->dev, ret, "device not found or not ready\n");
 
-	cgbc->session = cgbc_session_command(cgbc, CGBC_SESSION_CMD_REQUEST);
+	ret = cgbc_session_command(cgbc, CGBC_SESSION_CMD_REQUEST);
+	if (ret < 0)
+		return dev_err_probe(cgbc->dev, ret,
+				     "failed to start a session with the Board Controller\n");
+
+	cgbc->session = ret;
 
 	/* The Board Controller sent us a wrong session handle, we cannot communicate with it */
 	if (cgbc->session < CGBC_SESSION_VALID_MIN || cgbc->session > CGBC_SESSION_VALID_MAX)

-- 
2.53.0

