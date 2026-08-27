Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9AB731DB95E
	for <stable@vger.kernel.org>; Thu, 27 Aug 2026 04:40:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787805610; cv=none; b=L8k6uzkvkGzD/NWD7cg3McYNySL/vP+hLXCXG2vXUEPKUe6QHJM7X+XkRCTz9kkRTcTSBU/wQmLqity3Rt8FfXvEQQ1qwL1wNlkwmhChYkB1Fxn0iWKWCQPnNmIc1oYzTN8THFH/XphY7X5Gc4ZZblzEH+A+8wh6hxd4kk3YI/w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787805610; c=relaxed/simple;
	bh=liInS31UGC1KKymx8A0Dwahv8aXPkIl+Jsd+BWwAq5Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=n8KnRy6ONJ+tOz+iMguJ739Dfj6/VDYj01rF0tmcHQGmtfGoPW26+FTmqewL37pE6IRSleoUfvS+5G9LMkluhpKGq9H+bjy2lJd1G5lKP8p5aEUVy+3+WBLq85VaMI/1yCJAM+7GM4MoDGHUFIHm6RXoHsQO/r2GKKpWWFU9WJY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=OPTIhicm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="OPTIhicm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3EBC1F000E9;
	Thu, 27 Aug 2026 04:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787805609;
	bh=GlWODAKZAHdFAC0nGluZXS7Ss050+y1wvHT+Y8zPST0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=OPTIhicmDYF44BjBXtNCToPRR54OzkDpxSEN/WPSlprEmFlOV2/DQlXDL78phXOgA
	 e6wwa1VamfwOhot/0gYYVo/0jvU5uzgYgOMGSb8jAWEjkFSDRK6UsYmfmU45VN8FKx
	 mziZg9f65qBFfVNRM9SDap6HauDaZhKfK41BQU4o2hAZZfljjGM83G76Q0wBCFFioc
	 jId8TFgIZzZKxCNKvn7pwVq9VLTPM3wMUyU2Bx8jXKWDq2uTvKFv+1D5n4veh2cHeZ
	 Z6HUCkRFIyb45SAngIO54/7Z/+wDSnXNVUChXH/8aRuym0lYmqNKLRbuKXkmK77Wnl
	 xgd8c/CnfOROA==
From: Sasha Levin <sashal@kernel.org>
To: stable@vger.kernel.org
Cc: Michael Zaidman <michael.zaidman@gmail.com>,
	Germain Hebert <germain.hebert@ca.abb.com>,
	Jiri Kosina <jkosina@suse.cz>,
	Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.15.y 1/8] HID: ft260: fix i2c probing for hwmon devices
Date: Thu, 27 Aug 2026 00:39:59 -0400
Message-ID: <20260827044007.3635916-1-sashal@kernel.org>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <2026082538-obstacle-cogwheel-cfc1@gregkh>
References: <2026082538-obstacle-cogwheel-cfc1@gregkh>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Michael Zaidman <michael.zaidman@gmail.com>

[ Upstream commit a94f61e63f337d95001e1a976ab701100fa1d666 ]

The below scenario causes the kernel NULL pointer dereference failure:
1. sudo insmod hid-ft260.ko
2. sudo modprobe lm75
3. unplug USB hid-ft260
4. plug USB hid-ft260

[  +0.000006] Call Trace:
[  +0.000004]  __i2c_smbus_xfer.part.0+0xd1/0x310
[  +0.000007]  ? ft260_smbus_write+0x140/0x140 [hid_ft260]
[  +0.000005]  __i2c_smbus_xfer+0x2b/0x80
[  +0.000004]  i2c_smbus_xfer+0x61/0xf0
[  +0.000005]  i2c_default_probe+0xf9/0x130
[  +0.000004]  i2c_detect_address+0x84/0x160
[  +0.000004]  ? kmem_cache_alloc_trace+0xf6/0x200
[  +0.000009]  ? i2c_detect.isra.0+0x69/0x130
[  +0.000005]  i2c_detect.isra.0+0xbf/0x130
[  +0.000004]  ? __process_new_driver+0x30/0x30
[  +0.000004]  __process_new_adapter+0x18/0x20
[  +0.000004]  bus_for_each_drv+0x84/0xd0
[  +0.000003]  i2c_register_adapter+0x1e4/0x400
[  +0.000005]  i2c_add_adapter+0x5c/0x80
[  +0.000004]  ft260_probe.cold+0x222/0x2e2 [hid_ft260]
[  +0.000006]  hid_device_probe+0x10e/0x170 [hid]
[  +0.000009]  really_probe+0xff/0x460
[  +0.000004]  driver_probe_device+0xe9/0x160
[  +0.000003]  __device_attach_driver+0x71/0xd0
[  +0.000004]  ? driver_allows_async_probing+0x50/0x50
[  +0.000004]  bus_for_each_drv+0x84/0xd0
[  +0.000002]  __device_attach+0xde/0x1e0
[  +0.000004]  device_initial_probe+0x13/0x20
[  +0.000004]  bus_probe_device+0x8f/0xa0
[  +0.000003]  device_add+0x333/0x5f0

It happened when i2c core probed for the devices associated with the lm75
driver by invoking 2c_detect()-->..-->ft260_smbus_write() from within the
ft260_probe before setting the adapter data with i2c_set_adapdata().

Moving the i2c_set_adapdata() before i2c_add_adapter() fixed the failure.

Signed-off-by: Michael Zaidman <michael.zaidman@gmail.com>
Signed-off-by: Germain Hebert <germain.hebert@ca.abb.com>
Signed-off-by: Jiri Kosina <jkosina@suse.cz>
Stable-dep-of: bf3e39df3a39 ("HID: ft260: fix stack-use-after-return write in I2C read race")
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/hid/hid-ft260.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/hid/hid-ft260.c b/drivers/hid/hid-ft260.c
index 183eeb3863b38..79505c64dbfe7 100644
--- a/drivers/hid/hid-ft260.c
+++ b/drivers/hid/hid-ft260.c
@@ -969,24 +969,23 @@ static int ft260_probe(struct hid_device *hdev, const struct hid_device_id *id)
 	mutex_init(&dev->lock);
 	init_completion(&dev->wait);
 
+	ret = ft260_xfer_status(dev);
+	if (ret)
+		ft260_i2c_reset(hdev);
+
+	i2c_set_adapdata(&dev->adap, dev);
 	ret = i2c_add_adapter(&dev->adap);
 	if (ret) {
 		hid_err(hdev, "failed to add i2c adapter\n");
 		goto err_hid_close;
 	}
 
-	i2c_set_adapdata(&dev->adap, dev);
-
 	ret = sysfs_create_group(&hdev->dev.kobj, &ft260_attr_group);
 	if (ret < 0) {
 		hid_err(hdev, "failed to create sysfs attrs\n");
 		goto err_i2c_free;
 	}
 
-	ret = ft260_xfer_status(dev);
-	if (ret)
-		ft260_i2c_reset(hdev);
-
 	return 0;
 
 err_i2c_free:
-- 
2.53.0

