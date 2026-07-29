Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com [209.85.128.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1605F4C0402
	for <stable@vger.kernel.org>; Wed, 29 Jul 2026 14:24:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785335081; cv=none; b=UwBQAyxLooyQbxNIRsm648pQMUGw4e+KGQbDobhbS//sh8Q+OY+PbEMXK6kmtau1nLe7alt8TaJHUVidwehG/dupBzz15xn7PkVla6EK0azxMUbzWIPOmx2WmMhBdox9YvLVUwtxrUkvCI4TugX5fBQIiSg6hbw0XlkBA3KhEj4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785335081; c=relaxed/simple;
	bh=fKkUvmDvRRfHEVPs89a+rGIvpKFeUTytUx1BNtJnSGA=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wp6DxW/OQ+fppguMdv2YWQ5j6HYTK6YmTmShGq0rrqFbmGKgsShb/XvuUreMEAYxZmUABHecXzPrsqdBho3jPiVUwOIC7SiVKWX4bRnv9nC1mfLwz51r18tYbVh0oHNz4VZByl7U2ciS6wvIjR8rgeAsNNdb9Cd7zQEqqsEUFrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com; spf=pass smtp.mailfrom=xbow.com; dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b=j/Db4hwB; arc=none smtp.client-ip=209.85.128.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=xbow.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=xbow.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=xbow.com header.i=@xbow.com header.b="j/Db4hwB"
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-81ecf499af9so15347847b3.1
        for <stable@vger.kernel.org>; Wed, 29 Jul 2026 07:24:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=xbow.com; s=google; t=1785335079; x=1785939879; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=waRiGRNRRE7BjnlCyRtowR9v4vZUtc6UXn19J+eU9W0=;
        b=j/Db4hwBhfnIWu8Hrx+SlJ2NMX5Invf468RGW3BpC6rCVxTg+cAGTgiq7D7WHYoJCr
         83QLPqb9kBNse8UmXb2d4+o5LT6nYHEIOGuuSpBt0X1QznhJKSiFBA4Y4pexTMW2Ubuf
         Giz5/ECG3sY68AMcNpUyqKZK3oDumL/1tAT0QOplUElrkstc2LRpdBPcJznUVUbtvOvu
         Af7ZAv4pw2oRreLDmmnp/O4u9aHIKdM0nCOdQrCgGuQbLFZTnTti1nz95nvJnAZf7utA
         HWkeVefW5u8gx+MPXveqohBYAuTg5oeOA1fzQ0cw7dQT9Shviidf4XP+U2cE94qv1ckI
         RTEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785335079; x=1785939879;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=waRiGRNRRE7BjnlCyRtowR9v4vZUtc6UXn19J+eU9W0=;
        b=iYI3u+DqGd670n0XPoXn0sgE5irr9QwJTzGG/7H7QKrFjxeYuu1NycHPelHaBDhkoJ
         ZjU55gzxows8auWiKdsFI7/4AWIiQeGSMEugmLkzs0XYOk76o13RJgfWUGLgr0cwa6RN
         bn0NRub4u8Nx7n4arEhVDl7X2eeZCmTs6PTUaeWGjqADDMb1gKheVGUg4p54TSaLMBQp
         xu/vXvTuTQ9lHOTyI7GDu32Lii8d8pWu8ewg6a1OSNou6bvlty6n8OMupI9qhRJRyNhc
         2FcSK/BB3sX/rACZAOd4RMKzfuhsBoA7CdTCj+yAqn5pbR3unCAmV+BnkXczgOatAzNA
         pIAg==
X-Forwarded-Encrypted: i=1; AHgh+RrZ//N76FHNd4vEuLCgpIWrR8Dkq6wWOsYGabMtRYKEJ4/gOaisz8780tar5vOTpNkINydJfwA=@vger.kernel.org
X-Gm-Message-State: AOJu0Yy1QEfAtXR2BLwsLoaFE85vfNuOUcAoABrztClKBw4/PLOe9pHP
	2PuCJPP71XCPQas2hQTKI45zr2uoLXtn/Abn5KI1Kfab9LCx3zlkO7756WxnJPAbKFw=
X-Gm-Gg: AR+sD1317CHtNVHjRoFTguCaAXyIKOM63UJEQt2FrDdwf4wbhIHhJtY3Y199ItVYhf/
	l2Xxe6vdNhDZny2HO/assATh5+WlHyq5q+jkd7X3GwMAiAUJmXpIYQA40LJn4VHAEAd2t3R54ty
	TkhrbIpZIcIlg0TSFiP8CmoBMWyK8lY+7vyFRYuEMSbKnxOt+MQrpnrgQ7AGClU+nzpbQSmZvve
	F9wGdiy3jh3oFNHXelXMXh2z4uOAFU7CxJLpG4bITQfrpSioUKle3pBAj2zNa3jiufX5GLVFWye
	cbOQlxykh+WJMmyXmG1hR1qHiOO8/VvLBxqV6G5+JzrJSoCSYMErcYPBJ/g/eEnVZcfz23kZfUB
	kWM8oGRCEYatCHIlTNyB3cWAiNhFZJJ1p8y4z53NFFcqO4pNXKbnAMdvOJ2WBlL/d1R68DSxM6M
	GBuOInTmxs7Pq10i2VAqsdia6l+La5npQD6An9imcbbzgmDeTRMS1N+GzENzX+aM2lQPfCDzdB8
	rKw4jG9nJF6u2mv/IZCX2ArGk34mto/Z+lyguqH+HcIWEIDNC09AbwI38FGbSm64q72DjaCvzLO
	sDUDypKls6U2ZUOvOQe/zMiRkeSdrw==
X-Received: by 2002:a05:690c:6a0d:b0:81e:84dd:2142 with SMTP id 00721157ae682-81f992cd5femr38887937b3.55.1785335078974;
        Wed, 29 Jul 2026 07:24:38 -0700 (PDT)
Received: from buildmachine.tailf331da.ts.net (ec2-3-14-143-233.us-east-2.compute.amazonaws.com. [3.14.143.233])
        by smtp.gmail.com with ESMTPSA id 00721157ae682-81fa279b529sm18830747b3.15.2026.07.29.07.24.36
        (version=TLS1_3 cipher=TLS_CHACHA20_POLY1305_SHA256 bits=256/256);
        Wed, 29 Jul 2026 07:24:38 -0700 (PDT)
From: Baul Lee <baul.lee@xbow.com>
To: linux-input@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: =?UTF-8?q?Tomasz=20Paku=C5=82a?= <tomasz.pakula.oficjalny@gmail.com>,
	Oleg Makarenko <oleg@makarenk.ooo>,
	Jiri Kosina <jikos@kernel.org>,
	Benjamin Tissoires <bentiss@kernel.org>,
	stable@vger.kernel.org,
	Baul Lee <baul.lee@xbow.com>
Subject: [PATCH] HID: universal-pidff: stop the device when force-feedback init fails
Date: Wed, 29 Jul 2026 23:24:32 +0900
Message-ID: <20260729142432.16184-1-baul.lee@xbow.com>
X-Mailer: git-send-email 2.50.1
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

universal_pidff_probe() starts the device with hid_hw_start() and then, if
force-feedback initialisation fails, returns the error through a label that
only does "return error".  The device is left started.

The HID core does not unwind on the driver's behalf.  __hid_device_probe()
releases the devres group, closes the report and clears hdev->driver:

	if (ret) {
		devres_release_group(&hdev->dev, hdev->devres_group_id);
		hid_close_report(hdev);
		hdev->driver = NULL;
	}

The hidraw character device that hid_hw_start() registered through
hid_connect() is allocated with kzalloc() and added with cdev_device_add(),
so it is not devres-managed and survives that.  With hdev->driver NULL,
hid_device_remove() skips hid_hw_stop() as well, because it only unwinds
while a driver is still attached.  The registration therefore outlives the
device on both paths.

Opening the surviving /dev/hidrawX writes into freed memory.  KASAN reports
a use-after-free write from hidraw_open() -> hid_hw_open() -> the
transport's open callback, which takes a spinlock inside the freed object.
A descriptor that carries a PID usage page and no input reports is enough:
hidraw claims the device so hid_hw_start() succeeds, while hid->inputs
stays empty so force-feedback init fails.  The other failure returns in
hid_pidff_init_with_quirks() - no output reports, an allocation failure,
pidff_init_fields(), pidff_check_autocenter(), an unusable effect count,
input_ff_create() - all reach the same label.

Stop the device on that path.  hid-dr.c and hid-emsff.c, which start the
device with the same HID_CONNECT_DEFAULT & ~HID_CONNECT_FF mask, already do
this.  The two earlier gotos must keep returning without hid_hw_stop(),
since neither has a started device, so give the path that fails after the
start its own label.

Discovered by XBOW, triaged by Baul Lee <baul.lee@xbow.com>

Fixes: f06bf8d94fff ("HID: Add hid-universal-pidff driver and supported device ids")
Cc: stable@vger.kernel.org
Signed-off-by: Baul Lee <baul.lee@xbow.com>
---
 drivers/hid/hid-universal-pidff.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/hid/hid-universal-pidff.c b/drivers/hid/hid-universal-pidff.c
index 549dac555d40..60180467a0bf 100644
--- a/drivers/hid/hid-universal-pidff.c
+++ b/drivers/hid/hid-universal-pidff.c
@@ -104,12 +104,14 @@ static int universal_pidff_probe(struct hid_device *hdev,
 	error = init_function(hdev, id->driver_data);
 	if (error) {
 		hid_warn(hdev, "Error initialising force feedback\n");
-		goto err;
+		goto err_stop;
 	}
 
 	hid_info(hdev, "Universal pidff driver loaded successfully!");
 
 	return 0;
+err_stop:
+	hid_hw_stop(hdev);
 err:
 	return error;
 }
-- 
2.53.0

