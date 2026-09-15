Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 532B1175A6D
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 09:05:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789463111; cv=none; b=HsNujMGOAhI0gpsRwGqDPskr6KE2ai7bpmwy+aSn0wbNNR4AdK4wcaYKOENQkmu78vsgPkfGGG0kdsb/B5YRSE7ic4pLP3yzhOyWGzAbwLc2svMMQe4BuSIwSyfIXJYWUs/PqKbVfsLKJ5XssW/UNdiM2+T/AdfT/Xj4XQFxL0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789463111; c=relaxed/simple;
	bh=NEHGUz9YYNPdsfRd5nud5yegJaqx7Zkjlu4HqFW8TRI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=ClXAutSS0xIoGLz7VRa5NXVFEH5hzMKDOADeWc4wOQ3FHGi3ay4RS3E4YpCuKIg3G8d21/hgWEKwqiiALbtOB6w8FHxqAF6ucFO6/QdVlcL+1viBBPKQUcGnjSX5mco8Su/JzRHJk/n7tQBA7lqX3hvrMK4YPnBsXv1NYV4FuD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=kTFAMK+o; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kTFAMK+o"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2db1ca069c8so25738725ad.3
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 02:05:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789463108; x=1790067908; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oTZ8gBM+3gnYnTYBNkjTwF/jY8mB3m3p32yQI1BVbeA=;
        b=kTFAMK+ox6p7RV2PXK5RFdOTdr8FSNsTNPgnroi6MMWVo+n+efkz3MqwJJMkHFBieA
         C/LzL3ZMH2Dc+7C80r4HWaKoYdKBB/pW9u6sMSdLsSvaI4aHOT1tklphjQeZVTRdjp7A
         mfX/3Rym/jQcNcDoH9GmTejg47c3YARdujcckOflE/quCNhw+gyThQJvox4CmBMuiRcH
         aicomc0rIMhSe4Ix+Oq+vtg58mwoISVrMFIhJH/E1fC9pOxDWuvctxUKy2j+JokjTEWh
         Tq9fbKRYhExxzTdQh0l0i6cVjuZgm9OL+EXDYKV50eSzjkbXbQMYYc3+6mtZ2F7wNhXj
         arFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789463108; x=1790067908;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oTZ8gBM+3gnYnTYBNkjTwF/jY8mB3m3p32yQI1BVbeA=;
        b=ZtYuxcrLPlda0g5MKZMJv4brBk2JJKC0T6lSWszJmBerNOH53qGSDsIn/HT9e1FdEA
         Elznpy7mSS6cEXTY+KrUvHF/K8Ny+8x1U/jHzUMA90vjc8VAgAHl5LPxsEZPUq77WGf4
         Ilamzn7tpOfnI3Xnor8Ik96lgVX9oxcK3lH/NTP4VasUgQIm7wEYYdamU9H1x9uPXvaz
         RD9VX5ApZHbD0cmLrSZ+vXMje9F0aP9rcC+IejCU5Hu0PMLanHMvtorYl02K4Ufq5JEM
         3CTYs9xE/7m3BaC+Yg0waj84FOH7bbsyjKEMlWlIW1q69mifq6Ul5RH/9OCfJ7AfEafP
         3bxQ==
X-Forwarded-Encrypted: i=1; AKwUvBxApeeO/UcdreqSd/YT1snvZO1BfX7165EbPgh2WZyF0c11CyhF7J0bsh33F5qECjhZw36PunA=@vger.kernel.org
X-Gm-Message-State: AFuF++mz61+3URMFCOedr4FTiUmIV7l5TvyGjLVsKHaCXK/NG6L02bv0
	wbbvG3+I+DgaG+Kw0ndUL08na8Bm9fZ8+Jg0aAaWpEUC9055oqSRN9vm
X-Gm-Gg: AYBFou0uLOcBNLr7m79Rk+dRigS3I9X0IN4cneFEWqdmICo5bV/FKqj0tSXI6Z/cBC8
	HaO+YNqRaTBUGZUZqMhgJCP4Q/rqg76h3PmkvpuGv1gl0g3BnnJK5cOD1elGN5kh3FTNEDjgGBT
	v31fbPCIDqmEVs8bNMVknQrWBBoMTdeTNrzbF/xBM/V5pgx18JRnRNiXr2eF3BfEdbCVDvw5/A5
	PzFCs7sMiSvDI+BQfU7VlOIJwmw8v0ipCo6UFUKN7ez/nf/dej7FvXKnQQXFYqyGnLRTIes6NVl
	R6x4pD3Pb1phsy9tbPfkqzQaKdXg4Ys2woHnbfifdwUDs0vyEjmf+ijPfWl7Q1DXKeukBY1GLrT
	SUjo6ohKxZSqFCEtltdlvoa1BDd/xUXSndVXLgQEHoVEGFXBCp39ZSdF4UDeM5fior76O/i5O3b
	GZw2tRDBSm+0IKqxSpiEcY65v2SBBvOwo3Pv72u0q99n9bOeAatOw1/Q==
X-Received: by 2002:a17:903:244d:b0:2c8:248a:5dbb with SMTP id d9443c01a7336-2dd6c5eecb7mr126491905ad.7.1789463107311;
        Tue, 15 Sep 2026 02:05:07 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2dd2cff6780sm62702075ad.76.2026.09.15.02.05.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 02:05:06 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Dave Stevenson <dave.stevenson@raspberrypi.com>,
	Jacopo Mondi <jacopo@jmondi.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: ov5647: fix power cleanup on remove
Date: Tue, 15 Sep 2026 17:04:57 +0800
Message-ID: <20260915090457.2342778-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ov5647_remove() disables runtime PM without powering off the sensor if
it is still runtime active or updating the runtime PM state to
suspended.

pm_runtime_disable() prevents further runtime PM callbacks and waits for
pending operations, but it does not force the runtime suspend callback
to run. If the sensor is active when the driver is removed, the external
clock and regulators can remain enabled and the power-down GPIO can
remain deasserted.

After disabling runtime PM, call ov5647_power_off() if the device is not
already runtime suspended, and then mark the runtime PM state as
suspended. Checking the runtime status avoids disabling the hardware
resources a second time when runtime PM has already powered off the
sensor.

This issue was found by manual code inspection.

Fixes: 089b7c70f0d8 ("media: ov5647: Use pm_runtime infrastructure")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/i2c/ov5647.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/media/i2c/ov5647.c b/drivers/media/i2c/ov5647.c
index 3facf92b3841..d42d009772ac 100644
--- a/drivers/media/i2c/ov5647.c
+++ b/drivers/media/i2c/ov5647.c
@@ -1271,6 +1271,9 @@ static void ov5647_remove(struct i2c_client *client)
 	v4l2_ctrl_handler_free(&sensor->ctrls);
 	v4l2_device_unregister_subdev(sd);
 	pm_runtime_disable(&client->dev);
+	if (!pm_runtime_status_suspended(&client->dev))
+		ov5647_power_off(&client->dev);
+	pm_runtime_set_suspended(&client->dev);
 }
 
 static const struct dev_pm_ops ov5647_pm_ops = {
-- 
2.43.0

