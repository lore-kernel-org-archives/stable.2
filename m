Received: from mail-qv1-f47.google.com (mail-qv1-f47.google.com [209.85.219.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A70CD547059
	for <stable@vger.kernel.org>; Sat, 26 Sep 2026 00:03:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790381030; cv=none; b=KIgD7RXfv66XNSL3HjntXOEccax7lOOf4Yk7Ae3xUuQde/vWpyU9jTup9hNiMIiFob614/TfNFJMIoQ9Q/sQFDhHArEeR2ysO5Qni5d2YCbfob6o2KNYXhoHlxCz7+O4F+N7/aJ/lX7Dk7M7dDhbW39+jSyuBj4lGxjWvqKVl5E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790381030; c=relaxed/simple;
	bh=Rj8gOrxPAANXRPclxxJTN1D/z6CeCGAZJqTfPg48H7U=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=sTGZit/mZw0leDZNEhpg0gAmb6kxG9Ocs8VRnJ600KmNVjclQbBK+Un8VhSkl8LCU2q1aFGAQbZsAmVoinmKoRlerE9BVOSAlNBkFmvW+zUbA+ACvGP+xRyC2H5l9z83ApnCeamg9rEq4rV29lN3SblkpZ0qYCWCJ2UH0cb4Lho=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=QbtkfNTR; arc=none smtp.client-ip=209.85.219.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="QbtkfNTR"
Received: by mail-qv1-f47.google.com with SMTP id 6a1803df08f44-914411dd7ecso4101666d6.1
        for <stable@vger.kernel.org>; Fri, 25 Sep 2026 17:03:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790381027; x=1790985827; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=6j+UGuPcmEGai5QWky3o58LdTchPnVyFUzxH6dW9qsI=;
        b=QbtkfNTRrswBKGoD3Kzz/8h7huGxnRuB4a6iZyko6j6BAopcc+XcEt90mj+5FqSYlZ
         muNIWqEazntQwaexBmktHoUvCYUSBSnSCC6b9jGtmdq6hITfGG+XfiSPYPMpW4QxQJTe
         /3M/6kIMoYEFUdqPEYRnDglcrRnEyqo2ikiZ5g3UeuOvl/Z4bwlCu6Qt6wwfhWruWIpm
         txBIvaS1m2LCSbVQeCBjX9K2uQ6yQ5djMcESdBQIbRxxte4LyEdbO+Qj/1HGaroYKSfd
         4qDBW7IClhoK50su+sHfWDoowRkNTpo45NztB/6+VSPcCdwH3n/M2oqgovxWRTxqA1xv
         uO2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790381027; x=1790985827;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=6j+UGuPcmEGai5QWky3o58LdTchPnVyFUzxH6dW9qsI=;
        b=Dle5eKK4gCKUmlSK9ac+LVY1DGATEUhl/rCsrqjm+jDZp1+K8s+2cIiEDSxWzTZpaN
         J5l8mlaMi3oGELtLhT5lfvdxWT4HlwuFcm6X3fF7bUaiudlN+ot3PVYv1cpButkUhzrx
         hl3Aj0DkPZl0g8Ev/MKSlUIofvr1tIOaexGCUORhfXm4BnwmhLbrLVL/9buV03T8sPQh
         oA79M69wg8nJBz92h/TwmsIS+P4TTkBLVOGZELUDdV/+gXbOcs6a5bSHzevTXBlTFTol
         y96fUF3yUuOLOnUEHj9MwRCGS4RqHov2AfYE8vsEneYZbgUIsnoC3kIcI8xHBP5aWXLD
         RIXQ==
X-Forwarded-Encrypted: i=1; AKwUvBwt92c9QzPtXZcWJjakJ+1XyJnNxVTcLGxbrDtkqReWpUBMfurR0z5yTI3aQ1WPVe02YM8npOs=@vger.kernel.org
X-Gm-Message-State: AFuF++nFXDxXyreX+vgzAgNdYZndgKvRvVf3UZPDkyqrhxjSSgJ5++5y
	mdCM1V64ZGJxO3CvP2IQxmwzbJLUPGJi8uVNtGsjx9ccxmlINmTc7sKR+ZKi
X-Gm-Gg: AYBFou2ZhbJjXX5JJ6HG7jRGfApljg1t4OBYivwbR8N3XhSlUg1oELJ+lAMZ1QW4oU6
	45X8swyTA9W0b8OumsxMq0OcXz9hrJWiMkV3yh67PDCnQKU3g75F/BHBBLdPH9cEio0ODDPpmUM
	Mb4gthJv7ThlrVxGyVlx2kI2kskEauAPT2eblSQ6du7iRvYFkkRp9kQavaC4pnHzmSl93vBTZTe
	m3lwLIHNnZ8e1t437J/HOWOxyDWvB7+49oZyInzqNL5hT0sScsyF9CCCY+kLC9caHYdmxof/QTa
	bS+SAw8o4gNwMvUebK8fP12A3jVhZDOjK2RnQSXK3LxGpoI2QC7J3+rdljmlBQYCJZUExw9OEo8
	A8XGECyylCyaC4TS6AuKlYXFIqQ09dGRQrFCiwN10qhgzGKxBdZ2XXQ0WtGGuzPzc1IYkwOEyxX
	5DYAyZs2is0f+udIugZTEN8cO2W7MxQUcaAU7+HfAkgWA/DQo7PAZJTWI0L5WskTO9clStivG3u
	EARmXIszqFlojIAKn1fDBDNWHBHRtUB+SwHXbdm4Kftq1kMVTf6dJTzs3gtozxY0DUDNywFiWrZ
	UFD2eXxaEkkbR48rY/0RPRFnF1YybkCwYkda
X-Received: by 2002:a05:6214:ca9:b0:912:ec8:f82e with SMTP id 6a1803df08f44-9142f8cfdbbmr73559526d6.17.1790381027477;
        Fri, 25 Sep 2026 17:03:47 -0700 (PDT)
Received: from localhost.localdomain ([104.39.230.185])
        by smtp.gmail.com with ESMTPSA id 6a1803df08f44-91430dd1b90sm28177936d6.22.2026.09.25.17.03.45
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Fri, 25 Sep 2026 17:03:46 -0700 (PDT)
From: Myeonghun Pak <mhun512@gmail.com>
To: Jan-Simon Moeller <jansimon.moeller@gmx.de>
Cc: Lee Jones <lee@kernel.org>,
	Pavel Machek <pavel@kernel.org>,
	Joseph Strauss <jstrauss@mailbox.org>,
	linux-leds@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Subject: [PATCH v2] leds: blinkm: Clean up sysfs group on LED registration failure
Date: Fri, 25 Sep 2026 20:03:44 -0400
Message-ID: <20260926000344.29899-1-mhun512@gmail.com>
X-Mailer: git-send-email 2.47.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

blinkm_probe() creates the BlinkM sysfs group before registering the LED
class devices. If multicolor sub-LED allocation fails, probe returns
without removing the group. If multicolor LED registration fails, the
helper removes the group but returns success, leaving the device bound
without an LED class device.

Keep LED class device rollback in the registration helpers, but remove
the BlinkM sysfs group in blinkm_probe() when either registration mode
fails. Propagate the multicolor registration error so probe can perform
this cleanup and report the failure.

Fixes: 56e8c56c9af0 ("leds: Add multicolor support to BlinkM LED driver")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Co-developed-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Ijae Kim <ae878000@gmail.com>
Signed-off-by: Myeonghun Pak <mhun512@gmail.com>
---
Changes in v2:
- Move sysfs group cleanup to blinkm_probe() for both LED registration modes.
- Propagate multicolor LED registration errors to blinkm_probe().

 drivers/leds/leds-blinkm.c | 15 ++++++---------
 1 file changed, 6 insertions(+), 9 deletions(-)

diff --git a/drivers/leds/leds-blinkm.c b/drivers/leds/leds-blinkm.c
--- a/drivers/leds/leds-blinkm.c
+++ b/drivers/leds/leds-blinkm.c
@@ -671,7 +671,6 @@ failblue:
 failgreen:
 	led_classdev_unregister(&leds[RED]->cdev.led_cdev);
 failred:
-	sysfs_remove_group(&client->dev.kobj, &blinkm_group);
 
 	return err;
 }
@@ -714,9 +713,8 @@ static int register_multicolor(struct i2c_client *client, struct blinkm_data *da
 	if (err < 0) {
 		dev_err(&client->dev, "couldn't register LED %s\n",
 				mc_led->cdev.led_cdev.name);
-		sysfs_remove_group(&client->dev.kobj, &blinkm_group);
 	}
-	return 0;
+	return err;
 }
 
 static int blinkm_probe(struct i2c_client *client)
@@ -749,13 +747,12 @@ static int blinkm_probe(struct i2c_client *client)
 	}
 
-	if (!IS_ENABLED(CONFIG_LEDS_BLINKM_MULTICOLOR)) {
+	if (!IS_ENABLED(CONFIG_LEDS_BLINKM_MULTICOLOR))
 		err = register_separate_colors(client, data);
-		if (err < 0)
-			return err;
-	} else {
+	else
 		err = register_multicolor(client, data);
-		if (err < 0)
-			return err;
+	if (err < 0) {
+		sysfs_remove_group(&client->dev.kobj, &blinkm_group);
+		return err;
 	}
 
 	blinkm_init_hw(client);
