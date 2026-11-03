Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=185.246.84.56
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793724571;
	b=16eGKkspDIwyuFxganXP/idsN1EjYhegxp0kEdnnAL5JPUM5MzGqKQ/T8078CV03Wf2g
	 eIH0Fr8RKXbJHT0+bN+cWRITzClzuB88NOs9tsVX8/P9dsEyW1KTN1vvOItdbDO6hnsSF
	 jcLPl02m7WT7nouaDk8rzw/Dv32+in1zp7EeJXqscSJTE3IdFSEPC6uEgrY9s4yQbZJVx
	 WwzYH1+e5eT/D9DQ9YZPqEP67Sz5ezNyy3QUxDe4E9D6n75vig9re1jzujyW3GIroLz82
	 KmgtPtQbP1vfWLYaNQNium9hi/CZsYDAMXcZgM47IcYeHQKT26vDaqjLxO0vFpvfhLA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793724571;
	h=DMARC-Filter:Received:Received:Received:DKIM-Signature:From:Date:
	 Subject:MIME-Version:Content-Type:Content-Transfer-Encoding:
	 Message-Id:References:In-Reply-To:To:Cc:X-Mailer:
	 X-Last-TLS-Session-Version;
	bh=ENJkHkCfpFwdQvw3umeRws6G85S/Qq8yf5a8h/OQL8U=;
	b=r6WLSGZiJFl3+1IUCNJwNzCQ+l0KKu5iWzEgUjRfKxHxHz2HsuF4pYqYj/f4mgs9SScX
	 Jh5YBGrjWDzTqz10QA4LbuduWJSNniBIIZX45eGux0yP545+YCPFmXFrmOuMLNfP3K6Ht
	 Wp2KSvz+O4/cliF3hSZZbC0hIUU24CKmvOoDGx00bhguUwOn/V7kUcZlsdPRP5qE7xFnO
	 UcmvCSQEe4hRm1ynhoXEGKW2OGlsvEbCM639x/asKsMzbGAgRFA4QUle4CEhvgxxzN3SE
	 tSlShAe7wpf7HdDMk1BI6Oguwg2AbOrlfYE0CcBjow6leJF6TTOYNOTgIQNq6GUTLtQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=bootlin.com;
	spf=pass smtp.mailfrom=bootlin.com;
	dkim=pass header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NcSfNv4c;
	arc=none smtp.remote-ip=185.246.84.56
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A5688606A324
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:49:30 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org A5688606A324
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=bootlin.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=bootlin.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=NcSfNv4c
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
	by smtpout-02.galae.net (Postfix) with ESMTPS id 65DF01A1436
	for <stable@vger.kernel.org>; Tue,  3 Nov 2026 16:49:29 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
	by smtpout-01.galae.net (Postfix) with ESMTPS id 340506046C;
	Tue,  3 Nov 2026 16:49:29 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 6FF1010329123;
	Tue,  3 Nov 2026 17:49:27 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
	t=1793724568; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=ENJkHkCfpFwdQvw3umeRws6G85S/Qq8yf5a8h/OQL8U=;
	b=NcSfNv4cNiP0umd6rQiY6FaHSP0DxqMF7EEpB9VLEmr6kTGBIrSZ9AoedIN8oqrV27VcTi
	CMAt4qLCh3FcXjDT6UP+JwWIj82J5+2KA1IeZ3b88GUsVguJE+JPDFGDOmS/ePqq69Ck7Q
	91LB1BdHYRKc/4CsA8Ut42N3Kor4v1HK0PMG6CC+dJa+/5Ob8unqMZ4/ymgmxQjYaocTaB
	a2LhIbcgOTL8ICw+ZCk+RRobpYcHAgDJsKJkVUCg+9PfE4HFnFzRRWVFB+eOimfEdAu0ey
	5eEdcjpETgiSeFy6vzc/3uLKXfr1PLI7b5KNDrOSvZNtvWeFLf3gpgRb8LYuVg==
From: "Thomas Richard (congatec GmbH)" <thomas.richard@bootlin.com>
Date: Tue, 03 Nov 2026 17:49:09 +0100
Subject: [PATCH v5 1/9] mfd: cgbc: Fix use of negative error code as valid
 session handle
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
Message-Id: <20261103-cgbc-i2c-storage-devices-support-v5-1-ac11f23fae51@bootlin.com>
References: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
In-Reply-To: <20261103-cgbc-i2c-storage-devices-support-v5-0-ac11f23fae51@bootlin.com>
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
index 3460c50047ea..02a8c0078287 100644
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

