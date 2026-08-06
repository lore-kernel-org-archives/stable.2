Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8ADE384CFE
	for <stable@vger.kernel.org>; Thu,  6 Aug 2026 05:17:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785993469; cv=none; b=Amkw9UR6ZcvhIT9DUa8swgKEpaaAhNXbSVrGam/YkO+0wp98TqVXoZhCHL1b1ZX4Awv8d4kv5AyjH3oVeZSTrd1OAa5QiJfoWB4AMlHWGZ5qNbqrUAWXn8nRGCfq0KkYtPXX8Tas9cBXjpcxuQj9+o/eeON6wZ99wXvTaEnA/Bc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785993469; c=relaxed/simple;
	bh=vjWx689qbeARwGGgPB+QjxwlJP29OTCCH11iiEAaiZM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=k4koJK26bl4ucSSW+LheVvc/BFa1sqRKa9TvQ7Uxg2PsATh6gR41PEhnJ50eZHDGCSdFzBgRvBWbSLzK3WwlBINZIpSDpUtsmKrEPXSzNjikPIlDMZsnblD4JGloOC9QCM7spD90k8EiM1DNZMjYFtDnz6SLWT68RE7RjdhTgds=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=OT6ACGoG; arc=none smtp.client-ip=209.85.215.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OT6ACGoG"
Received: by mail-pg1-f174.google.com with SMTP id 41be03b00d2f7-c9d1fff21edso1253512a12.1
        for <stable@vger.kernel.org>; Wed, 05 Aug 2026 22:17:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785993467; x=1786598267; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=4zrnHL816rlceKPEH+b3G5bh9fGXwY6/iJzzWDpp3Fs=;
        b=OT6ACGoGtQ/t+IIVWjlKUFdP8ojcfk3TAClXeniV2g7JDPUXUxUovnhPnMmIvRsNg8
         NGWX8lEy9pWhLMaT+SIWmZaEnH7sKwqJYMZERGZMVGgWXDmzDDDrAHsIR+mZq/BU+e9F
         ySKrxhBo3JpzoeZzreluId8/lW6NtC5Kiow7HTcj+/hYjvrd7MpKDnCy/Yp24HYW3Etg
         Coe/IOfV4vTBn7b3ZpeszssKKJfFkTRkdIq+2mhBQgFgsNsdOBYJl94KKDZScnTNxEIc
         1E597OVy0bEJfCPcCnOWugcQEwaEs8QDiERTqFkmFSEF9HPy+Gq+zPkxU6oJyEa9vfoY
         xQKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785993467; x=1786598267;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=4zrnHL816rlceKPEH+b3G5bh9fGXwY6/iJzzWDpp3Fs=;
        b=ruVayMOX0ykdyCPl88f2rS/fs1z7rXgVeeSJsFIqxBHg/NVbEi0aJJs0xtBvsDuaG9
         ZSPti4Ht844Beie1XIcvC6sdcqp7VZXl6O6JS6Uy17DtgDUIA5dMsCapP7O6x52gl4tK
         BAf+s4AFMclaggf5wPckH6bFyW6pwBLMiLljG8+fvV2bnTBj34cA78jh9XxdEkqTq6/U
         tulRm+1Yf08cxJUXzujTiBafvnEY4n+dzZvAKo+KQ69moKex+ShvYuhVWtFJQMspeCiv
         Vv2B40TCSAi7YKxmkwbUtYRXVk1SUKw/PbaXIQkjDOgszUletv8/XvxEnsfxWUHnML6c
         8c7Q==
X-Forwarded-Encrypted: i=1; AHgh+RqKz9dJJoIBs5prYXxD1m9faJx/aYP5CXqZoicY8uXgCcHUkYerNfwIUdTt0G8j/a+oTFraDS8=@vger.kernel.org
X-Gm-Message-State: AOJu0YyJybTkmANfYGGPgj8MbPscB8oDel3fKZCRQ/jsM49DLKtJDnOG
	/ud/9BbLTcxehCQP/e7l12ddl+Z6ALwJbcONE+soqN2Ma1Gl8nFPk+vy
X-Gm-Gg: AR+sD116JJ733+L2MyA0s9K5/q03L8ZFc5/Ylg/odzw+oXIbY6LTESOFH1d5QVuFRmy
	8sktn4Vu97mV09A/7RAhUspPYretgpu11VIHYBs1iFFV/85ntekVvz6JEdx5xHZC+9emglXxclJ
	HLEAi/iRI/VbmRqXXKqU5GvHK41hWI0EIIq5fknrEFiTBUwNp3W0GlsO+ozZNiLIYWePpWjycu2
	VvGnKRbLrxSsVt9O4VOoxIW9w4T575fNsIQubVw4s6RNZcMEMdmpJdT1NMcX3Km+hmX3ZtDK/CK
	QGNi//FcCoY8iOru+GBBpK+7/6EBLdG8JOyAilKk5mUNXP/xU4wCiyvw8574CnIyHVFOI9qmW/S
	ahWTxmcvFvEmfZSM2WU+eM3NAHMZGxY0wqITvMJHpp5e6PiW9zZYlu1miA9AqS6996jmPKP4aa+
	LX4owtiQJLmf0HsZ/Gh65nIdvq0L5Rwuwq+XMiX0kJiZD2I0ToNZ3bsm7rAcsLo6yV
X-Received: by 2002:a05:6a20:6a03:b0:3cb:82de:b952 with SMTP id adf61e73a8af0-3cb85de816cmr11307613637.2.1785993467133;
        Wed, 05 Aug 2026 22:17:47 -0700 (PDT)
Received: from Default ([2409:40f4:1038:e01b:68d4:26a8:ff11:f316])
        by smtp.gmail.com with ESMTPSA id a92af1059eb24-13fca6482e7sm20485791c88.6.2026.08.05.22.17.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Aug 2026 22:17:46 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: linux-usb@vger.kernel.org
Cc: valentina.manea.m@gmail.com,
	shuah@kernel.org,
	i@zenithal.me,
	gregkh@linuxfoundation.org,
	linux-kernel@vger.kernel.org,
	stable@vger.kernel.org,
	Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com
Subject: [PATCH] usbip: usbip_host: Fix null pointer dereference in rebind_store
Date: Thu,  6 Aug 2026 10:47:26 +0530
Message-ID: <20260806051726.24343-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rebind_store calls do_rebind which dereferences udev without
checking if it is NULL. If busid is registered using match_busid
but the device is not present in the first place, it triggers a
null pointer dereference when we attempt to rebind the device.
Fix this by checking explicitly for udev first and returning
-ENODEV if udev is NULL.

Reported-by: syzbot+af76b01c9a0f0ab60fb0@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=af76b01c9a0f0ab60fb0
Fixes: 4bfb141bc013 ("usbip: usbip_host: fix to hold parent lock for device_attach() calls")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
 drivers/usb/usbip/stub_main.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/usb/usbip/stub_main.c b/drivers/usb/usbip/stub_main.c
index 79110a69d697..dfaedecedb81 100644
--- a/drivers/usb/usbip/stub_main.c
+++ b/drivers/usb/usbip/stub_main.c
@@ -256,6 +256,11 @@ static ssize_t rebind_store(struct device_driver *dev, const char *buf,
 	if (!bid)
 		return -ENODEV;
 
+	if (!bid->udev) {
+		put_busid_priv(bid);
+		return -ENODEV;
+	}
+
 	/* mark the device for deletion so probe ignores it during rescan */
 	bid->status = STUB_BUSID_OTHER;
 	/* release the busid lock */
-- 
2.55.0

