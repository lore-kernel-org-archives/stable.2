Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com [209.85.221.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 965DA1B808
	for <stable@vger.kernel.org>; Fri, 24 Jul 2026 00:10:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784851817; cv=none; b=lL/K6mDkxfA3vpA1Mz6nSH7ChaS3NSNQzkKCr8+JjU/fpw7NuzU6b4eNrdUVZ+ECHpJAgJwAKckcZikwB0IRi5uVPAEv4uzR4J0j6bf+8xsJLT65uTDiYWBVEs3a8uC2einf3q3XvRiwU6cdvyDxXOe4gcqLpSnXSYssQjfneGQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784851817; c=relaxed/simple;
	bh=vh/JKGt51BiPqho1O21KWsVulMR0eJ/JWLjQkb/m7SM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mGqHx08oA40K3U2/1qpy19whzLC1tq6tDpZWZ8rvSQqdmn4HCIJpEf5bSdWUXXdzGHR1w5ZCVJZKW9CVm/u1U7rXtXtExYFdhE6S4vrvrQjcR0VufoyL3HsraWQLVJg6bsZKJsofHxbO92KVTOH1dK0JP/Z9YsAZelCewvfbVfo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=a9URDAgn; arc=none smtp.client-ip=209.85.221.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="a9URDAgn"
Received: by mail-wr1-f51.google.com with SMTP id ffacd0b85a97d-47f7027ca11so732109f8f.3
        for <stable@vger.kernel.org>; Thu, 23 Jul 2026 17:10:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1784851813; x=1785456613; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=nU+jXdKU/lc4CNz9IWGgShjsy/wZZQkGpDW5ftzUhAM=;
        b=a9URDAgngnRpEDGJdqif6nD1hzcEkF41T02GtG6/TOexUsW3g/Alh7Y3z7RDBiufsd
         DqTjudzd4GmrHlRi2ueKFqlyplbPzv6uIjYkv/qrBx/PIF2Pn6yDHf/8e3zIFmHSI0oZ
         VKv4tCjEn5IzJBR4dJlaz+6V8o/O8lZVo/koQm0/D00tnihNcnc/RlfDbxDTRRkXUfQc
         dYnYBwHKZiuhDG4gM5GkV3zkg5Dd2bbsdHPi2ma9CAN63+aK0YD/H4mlxsM+Y/kWPNwV
         nRTcJ/DQZh3dXEWPr104h7/slypwlUzNT5pb+WPDmD2EY1Awq4xNlB8HtCvFklORLF8F
         q6XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1784851813; x=1785456613;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=nU+jXdKU/lc4CNz9IWGgShjsy/wZZQkGpDW5ftzUhAM=;
        b=Buq/lrwVjaoSiG+wNAXFcKTc7a3aqNoDy6SMoQSCzGOrq7jxBUqByB4e8j+74qPaNX
         hB7MQNrnurBNtD35WBy5MAan9diYFfSk3UAOlxDHZgc+RpWrwndAYxNq4A7pS8pSgZmT
         6y9smwh3VWTvijiw+T0bOzrQfsziF4zR+TdeHZ4q3qtVG5Z/htnzojAsLzoGhWXhmBWJ
         pkXZiq5uveoY1KRzdnmQwmF8wzRu76LDLGdLhvjiYA6VpWa/SVSjgKe7gHCEFssbzy3Q
         U4sGRqyJ5CeCvnpB6bBnK/RHLVWTRVPjeCSfIUzZMRnqhsA7o1b178WgCc+xny1HlVQ4
         sDfw==
X-Forwarded-Encrypted: i=1; AHgh+RrNbT46BdUasXxOGOlHeVSIEDsTjYVTBW3oC4/PTxLD7Widv7xC0kCAOAwdcCOgrI54MtSWXqM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxAC2zdkjj8UoIfwX3NKJH9NnzPGTOBuXUQy3ftcyfkHp7FzSbQ
	dteDRI2Q/wPuRaAe5bflT2E0uEOFMJ9Dyz5LlIFenO4IcDprbaJd5VaL
X-Gm-Gg: AR+sD12qGR1chM+F1Iz0cOUmO0PppY86WXsJu7EaG3dJQTn6xUwhS5ykPY7g9YbYryb
	lNaHiYmZc2v4X6NFwP1EDoGtmTSAqEIPgRKalTRqQ4BvN7tkBq+Uu5/5exNoRjagXXaxvoSqpHH
	OPmsDbnVdt90gayZ/eotmlP5JBWdrvDDQ9zwH5pojCmvHUa9kgA0Cv5T15lVjnITlaqGLLFjaKM
	goOLqX28inhnio99r2OBoyT5I/+sXrOY6IdqjC9uutAbye3+FAtWDMuZQAwWycx44TLxZCjteaW
	YqaZLXE/7PnM4sKRSzotJ9zKlq1R9TCzyNBkhVHY7pLv2Yt0lIBuUn3YvQ6pJn36hRbtmuxK0YH
	I42wL0vqlUz+pWEsmnKDBukndkmy3z0X7aBPBK+NXnnM0kqmfhFFJQmVOnlPbNLv3BWGuWdIwIg
	==
X-Received: by 2002:a05:6000:310e:b0:47f:8b94:19d5 with SMTP id ffacd0b85a97d-47f8dcc4039mr6598984f8f.57.1784851813343;
        Thu, 23 Jul 2026 17:10:13 -0700 (PDT)
Received: from beelink.. ([186.247.163.143])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-47f85b9a5a2sm21104488f8f.7.2026.07.23.17.10.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jul 2026 17:10:12 -0700 (PDT)
From: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
To: linux-input@vger.kernel.org
Cc: jikos@kernel.org,
	bentiss@kernel.org,
	linux-kernel@vger.kernel.org,
	Aldo Ariel Panzardo <qwe.aldo@gmail.com>,
	stable@vger.kernel.org,
	Sashiko AI review <sashiko-bot@kernel.org>
Subject: [PATCH] HID: multitouch: stop the release timer from being rearmed on remove
Date: Thu, 23 Jul 2026 21:09:58 -0300
Message-ID: <20260724000958.938675-1-qwe.aldo@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

mt_remove() quiesces the sticky-finger timer before stopping the
hardware:

    timer_delete_sync(&td->release_timer);

    sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
    hid_hw_stop(hdev);

timer_delete_sync() waits for a running callback and dequeues the timer,
but it does not stop the timer from being armed again. The transport is
still delivering reports at that point, and the report path rearms it:

    if (app->quirks & MT_QUIRK_STICKY_FINGERS) {
        if (td->mt_io_flags & MT_IO_SLOTS_MASK)
            mod_timer(&td->release_timer,
                      jiffies + msecs_to_jiffies(100));

A report that arrives after timer_delete_sync() has returned therefore
leaves the timer queued. td is allocated with devm_kzalloc() against
hdev->dev, so it is freed when the driver is unbound, after mt_remove()
returns. When the timer fires afterwards, mt_expired_timeout()
dereferences the freed td:

    struct mt_device *td = timer_container_of(td, t, release_timer);
    struct hid_device *hdev = td->hdev;

    if (test_and_set_bit_lock(MT_IO_FLAGS_RUNNING, &td->mt_io_flags))

Simply moving the teardown after hid_hw_stop() does not fix this on its
own, because mt_expired_timeout() calls mt_release_contacts(), which
walks hdev->inputs; the timer still has to be quiesced before
hid_hw_stop() tears the input devices down.

Use timer_shutdown_sync() instead, which additionally makes any later
mod_timer() a no-op, so neither ordering constraint has to be traded off
against the other. This is the final-teardown pattern the function was
introduced for, and hid-wiimote already uses it for the same reason.

Fixes: 4f4001bc76fd ("HID: multitouch: fix rare Win 8 cases when the touch up event gets missing")
Cc: stable@vger.kernel.org
Reported-by: Sashiko AI review <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/20260723224211.613112-1-you@example.com?part=1
Signed-off-by: Aldo Ariel Panzardo <qwe.aldo@gmail.com>
---
Found by code inspection after Sashiko AI review flagged the teardown
ordering while reviewing an unrelated patch of mine. I have not
reproduced the use-after-free at runtime: it needs a report to land in
the window between timer_delete_sync() returning and the device being
unbound, which I have no way to drive reliably on the hardware I have.
The window and the rearm path are visible in the code, and the fix does
not depend on the race being hit.

 drivers/hid/hid-multitouch.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/hid/hid-multitouch.c b/drivers/hid/hid-multitouch.c
index 0495152091e3..f25065b9ec66 100644
--- a/drivers/hid/hid-multitouch.c
+++ b/drivers/hid/hid-multitouch.c
@@ -2233,7 +2233,7 @@ static void mt_remove(struct hid_device *hdev)
 {
 	struct mt_device *td = hid_get_drvdata(hdev);
 
-	timer_delete_sync(&td->release_timer);
+	timer_shutdown_sync(&td->release_timer);
 
 	sysfs_remove_group(&hdev->dev.kobj, &mt_attribute_group);
 	hid_hw_stop(hdev);
-- 
2.43.0

