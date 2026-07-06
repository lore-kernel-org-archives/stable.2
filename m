Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C800D37F744
	for <stable@vger.kernel.org>; Mon,  6 Jul 2026 15:11:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783350670; cv=none; b=GDvTdrNI/xtvz1qJ9gM+hXjTm6b4roN2R4OQHnYrcKW5SsHvykfJPTGUZ8YGl1JIr7seArhP6+i0lnojrqZEJTg9yESYsltwL9jItTHubrPNGgIvHVlD4MmlE96FtYC6IPec3jB2njwb8+In7+Loh7VFT8Ke8HIJaggIOWV1n3Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783350670; c=relaxed/simple;
	bh=DC8hbtn49OkRdhMEpTeVtkgA5St46LFuImCP51O/Z7c=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=FPfsIQ4KNhYA26dDwdZ0Gt1L2vL/AGJxMry6ByeaBd0sbzNJeOpzQd3ar6OROKHbPd+NiCdpGOkYNYofP03c50z09g5vlbgJT0Eva/R6MauSuFtOQIWN74dstVQb+/uY7xZ88r54hFRrwqTySvFJuP1kO7+WmINcTfSjH4toemw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=byTTlJHJ; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="byTTlJHJ"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2cc84e77e78so12329415ad.2
        for <stable@vger.kernel.org>; Mon, 06 Jul 2026 08:11:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783350668; x=1783955468; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=YvJnbKtZ9JQUQxlIoTBWahfF5cHSq4G8K3OUqqfWB8Q=;
        b=byTTlJHJRNARRkFIETilzDPcAeEQBQdYdEGbm1zWeCz246q6JVUmemJSmgUxHJ1HYV
         L/DJWoQ+4BmB8YBclr6iQ6hA7IcfGSCKs0YKbOi4Yh8k5lFDeFAWBjIhSxMFWGaSxQEb
         juPtqICSIHXkyY6wdB4rrR51y6jIdMPHBwaT8v+YE/Leo7SEWm8xC+NC5T4bOvG1Eha5
         0zdjUg1JAQXbVVtYDgYyIhtmDGJZj0cPtNZssSZEYs+HjHFZ7CVoukcq6SodL8AXw6cw
         +irZhR7m4Prv+8sQzl2vTiAtzRiImqaI4TY4uap+4shgjJFPX/bZR4MTZfmDM3kOJKhQ
         rgUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783350668; x=1783955468;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YvJnbKtZ9JQUQxlIoTBWahfF5cHSq4G8K3OUqqfWB8Q=;
        b=aLJLhpeVxBDKy5xyaeFFHkPZ5VNAOgzYXIf+GeNCLq0QWWfEL6pjh8tWASwC0ZbqQ6
         S2mFDCvLHG+D1UWMJNP55LPvSbAflabIYsQ/UZ9kBACX71D5i/DY0nGHzi/uEiD1OLUb
         M7EQ+aiPYF5E3jdIhWERjnl/OQPLuUAdGQwZGvASyy3MT3QO+rPyO99bsGl9LjndC6bs
         69IUCez0QmNWN9D0LBYmX3el3y6aNoFf3h+IRlMv5DJj3pfEFcouYNbRREwyBjNK9fRV
         81W5mjrun4mGxdBLuVY0HVFzQiDsdC6NKGnzkiLED2g8D59yaCSjxE98ZRDHxjPAbn5O
         HSew==
X-Forwarded-Encrypted: i=1; AHgh+Rq+vcH7FHq5cGEZtwuxgTObKdoTkOqu6TzHy3QiLqxTxVtGs+1vIvfdjRH21E0U5gRT6ob9JI0=@vger.kernel.org
X-Gm-Message-State: AOJu0YypLrVPXQerC4vMm2hSONInCkxL9hZEaMe62N6DUV+CZkzU3lCq
	7p1u4OjPEJ1C6SSpAbStKqNY/8xI5hrapUCgo8gKUNocEWFzPKnoQiE=
X-Gm-Gg: AfdE7ckkMPZQawtfdbex1qmlSNDFBxWZV1Jvl69zwV68UjdYYxPZ7B5g4Eza1qzGY5t
	GV38iw+QCP3cOVm1xD2j+fXb0aMfQiPVEfPDU1ZBdbRb1sgGB42E+xthcHkAlnsohx8dRxWqPg9
	u94lv44kOBCPDxGD0la5VhZxFeRCIpVELJwx8aL7+Cf/xPFTAs1Vfq10kVMw4Iaa7m+dbSf7R82
	oW+pr8WLhhZkqBWqnF0OL/0eY0bWDiNYgh550FyfWTJFEQ/mbBWUuHNcHu4IYAwmWyzr7bW9fNy
	D4jT33YzprZo4hjQW1clQKMoxgGhtIJoU89MkXoF2bNLDBBpz3ZhA0wHykQYgK0Juvdk9LQjW/n
	PbUTTWl55IuN9hv3cqN4o+ZbD5HFOrGwTx80W+OkwKneDAg4lzulFJ5fGPgVmPAbvOy7VZxwtq7
	WEb3a3DrQfbZzDJ6Kk5HhOgl/xbIGHZ81EH0bBbsheG3nifBP9x1s3zCCayKFYsoEeIyACHWpes
	A/wKdKK/FwfmYDDI6LUg4v17RIju4qsObGVq1+KZnRLRb2wZA==
X-Received: by 2002:a17:902:d4c1:b0:2c9:97a8:8c1b with SMTP id d9443c01a7336-2ccbf183a00mr9819105ad.46.1783350668084;
        Mon, 06 Jul 2026 08:11:08 -0700 (PDT)
Received: from localhost.localdomain ([14.5.152.27])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2cad78a9f83sm52218885ad.83.2026.07.06.08.11.05
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Mon, 06 Jul 2026 08:11:07 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Oliver Neukum <oneukum@suse.com>,
	Alex Henrie <alexhenrie24@gmail.com>,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Myeonghun Pak <mhun512@gmail.com>,
	Ijae Kim <ae878000@gmail.com>
Subject: [PATCH v2] USB: misc: uss720: unregister parport on probe failure
Date: Tue,  7 Jul 2026 00:10:49 +0900
Message-Id: <20260706151049.63470-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.39.5 (Apple Git-154)
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

uss720_probe() registers a parport before reading the 1284 register used
to detect unsupported Belkin F5U002 adapters. If get_1284_register()
fails, the error path drops the driver private data and the USB device
reference, but leaves the parport device registered.

Leaving the port registered is more than a private allocation leak:
parport_register_port() has already reserved a parport number and
registered the parport bus device, while pp->private_data still points at
the private data that the common error path is about to release.

Undo the pre-announce registration in the get_1284_register() failure
branch before jumping to the common private-data cleanup path. Clear
priv->pp first, matching the disconnect path and avoiding a stale pointer
in the private data.

This issue was identified during our ongoing static-analysis research while
reviewing kernel code.

Fixes: 3295f1b866bf ("usb: misc: uss720: check for incompatible versions of the Belkin F5U002")
Cc: stable@vger.kernel.org
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Move the parport cleanup to the get_1284_register() failure branch,
  as suggested by Alex.
- Clarify the visible stale registered-port effect.

 drivers/usb/misc/uss720.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/usb/misc/uss720.c b/drivers/usb/misc/uss720.c
index a8af7615b1..bd099cd8c5 100644
--- a/drivers/usb/misc/uss720.c
+++ b/drivers/usb/misc/uss720.c
@@ -735,8 +735,11 @@ static int uss720_probe(struct usb_interface *intf,
 	 * here. */
 	ret = get_1284_register(pp, 0, &reg, GFP_KERNEL);
 	dev_dbg(&intf->dev, "reg: %7ph\n", priv->reg);
-	if (ret < 0)
+	if (ret < 0) {
+		priv->pp = NULL;
+		parport_del_port(pp);
 		goto probe_abort;
+	}
 
 	ret = usb_find_last_int_in_endpoint(interface, &epd);
 	if (!ret) {
-- 
2.47.1
