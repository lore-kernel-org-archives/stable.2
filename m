Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17084525A94
	for <stable@vger.kernel.org>; Tue, 22 Sep 2026 08:40:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790066421; cv=none; b=txoZfmy4Vi4zzIBslJoxrw+iZQvTdVC9TLVjFHFzVkSOY5vC8BupsWYQczEZ20NR6fgeXlSsJDf+hq9UcUS3fH7siX3BJyG5lgWeOmr6SBalFBio6RmUZjJghE5fWgpourCwm6gNk7mUZRuLMqRiQEY0AjucasqKnLuumF4rN1M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790066421; c=relaxed/simple;
	bh=7ddEEDYiWcRGK/WOOFx/dsbsKYz9W7gultIVoWDHN8Q=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=e4t4gagrnawZvXkzicnEl/ZzdMXTv1Hpcht/EYWrL1g/jATBxBYkd6bktjkOExl3rDF82RxVBQZDhj7LHzr1mFZmoyU/Eak0nhdGXF/gRZ+8Kz8XFAgWIUO5OAn5IU3wzcIFk0dKMdmXXucdfV+2GqjE2lACaE1TcDsoRnpKf2M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=S7b5jlVL; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="S7b5jlVL"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccb1a98dso3002971a91.0
        for <stable@vger.kernel.org>; Tue, 22 Sep 2026 01:40:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790066419; x=1790671219; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=v7Fu3Ae5XFkGmOXs4h7NOUGECaveVKHxHBmx2pZiZGA=;
        b=S7b5jlVLzBu9WYNvC2D1P5pR9P/PxA7kHhvtH8tQSIGdN91mXnimQhGG4bpFDnLlMt
         J7uq7sRwGYGvocTijBN4hmrP0AookObkCYffirveEu8/1pzxlaTOkt6HTOi/h8hyfp2S
         3LiGXGCU+vNBYHdhI+7cRg9qOSN4MAXR0oHPY8PJmUOx2DjWjDsjGtqmO552Xn/TDOMb
         X6vFH9HD7ajeWdBPlznHFSag0FqueokTdPto7vOuIwHMZ5oounjlOmYrit8a6Rw/E6w0
         rreeZ51P57EACr88qUebw77qEpiTlyGoSjagn2vjsF3d7jAJvloZDw7jeMKdZiKjWb4P
         kk0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790066419; x=1790671219;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=v7Fu3Ae5XFkGmOXs4h7NOUGECaveVKHxHBmx2pZiZGA=;
        b=Ho4sB865U+aBCemzyZR2xig0AzD3Rqq/sU0j6XKrnFUzTxChE7NGeeBV/x4ZtrAdy0
         CbfJWsfgMYyLzS+JxobKibHD5KQVRhG5pWiG6wTDPhr0sAQkZ3kmy2NX7g8sfYiGCde4
         zpPN/4xFX6jr2x7/+w/ttmJgTAh7XcM0uH0cWO+dwCeYNTIaiywHyxLWEX4uh+UYwp19
         WH9UDp23oQgJg2lTLx44QS5MV2bZcUoL8owTSVy0py9yql+hgTS0n+Csn1Q7J3rigGdy
         jj2Xs4r35MffrLWk86mLE1w3raPhGWiS38teI70hUYMuJdZa39MS99wFFvthWLL/CPz9
         +jxg==
X-Forwarded-Encrypted: i=1; AKwUvBwUJ2mk3gRcBg/xeRrAsSHQg2RXLz7AY3Phy/hvQbnr0GdTmkNXcfuAStVVBurMd/LOkp/jH1g=@vger.kernel.org
X-Gm-Message-State: AFuF++me4C11/1xjExaZePwkWVJc9CDlVdIiWJUKfcaPRDhFbNOF/VHM
	s7+Hwyx1JGeTOICJmRB7dpkqPQlruivyZTWg66rShWxjv6CBPcXBLem+
X-Gm-Gg: AYBFou0WTTU7lZg2XKmjcVNGEXIkb+het/Fd//Y7HdgIk6/vIl/fVMKVbIT/HnQhQ3n
	upNmOKY0Kh4GEdfFiOzJBmSDBo4lHwjudmcieCJQ5y9OXYzzK2Rt6G/NwkinnhGrfaWMBMhmhOE
	SgqCgzbORBnBtAFyJmgmSat7vVVDJfaCX2RPNdt7wXh3z2IcRH+z6wqhIX8Yp4xT1dwc36gug1K
	H3YJEFiH+stN9kx2yyDpioNr6a7wAt659L9Mf5vU3OJpkT9bK33j2gU8WnSAd6ptTW+pSkRoOZq
	54k0n/+8XsL+FqjbwCNeSezu5xzbXMPHPCRloDNSqG/64VQdliSGony+9KFJxgCrJasml1QSVfZ
	xjulC3lm8U/ifu36XE7zqUoDJnnrbSBbXv8WmkKTA6Q2kOooYpQNFzpP4tAefDsGLY+v660PwES
	4pkreTt8GdG+BRcBRfKhy0MyFzEO4aprOyPq6PCAHHkg472pB31HG1zgM=
X-Received: by 2002:a17:90b:55cd:b0:39e:4c80:44bd with SMTP id 98e67ed59e1d1-3a0731eca18mr446217a91.32.1790066419395;
        Tue, 22 Sep 2026 01:40:19 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-144f294e4acsm3380134c88.1.2026.09.22.01.40.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 22 Sep 2026 01:40:18 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] media: i2c: ov5647: fix power cleanup on remove
Date: Tue, 22 Sep 2026 16:40:09 +0800
Message-ID: <20260922084009.506362-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ov5647_remove() disables runtime PM without powering off the sensor if
it is still runtime active. pm_runtime_disable() does not invoke the
runtime suspend callback, so the sensor can remain powered on.

If the device is not already runtime suspended, call ov5647_power_off()
and mark the runtime PM state as suspended.

This issue was found by manual code inspection.

Fixes: 089b7c70f0d8 ("media: ov5647: Use pm_runtime infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2 :
  - Move pm_runtime_set_suspended() into the conditional so it is only
    called when the sensor is explicitly powered off.

 drivers/media/i2c/ov5647.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index 3facf92b3841..3b3e5653a0c6 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1271,6 +1271,10 @@ static void ov5647_remove(struct i2c_client *client)
 	v4l2_ctrl_handler_free(&sensor->ctrls);
 	v4l2_device_unregister_subdev(sd);
 	pm_runtime_disable(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev)) {
+		ov5647_power_off(&client->dev);
+		pm_runtime_set_suspended(&client->dev);
+	}
 }
 
 static const struct dev_pm_ops ov5647_pm_ops = {
-- 
2.43.0

