Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com [209.85.210.180])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2FD8434EF0C
	for <stable@vger.kernel.org>; Mon, 14 Sep 2026 06:28:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.180
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789367300; cv=none; b=bDGC1y5A7zgpB8QYTIZKr4YW3l/sfkU0OQc5ppIBwXdR1za53etRkF+kXof5CVcWuMAGCHyFWCD4660INAoVZkW+HRZPSYD6oPbpDK2bOekaB8h/+oJRQCuNJM7PvOZ9wMG42PRBX35eYsqYynHXoMw9e+NTVTsDk+xFXRtupDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789367300; c=relaxed/simple;
	bh=TPDQPFLtPZvZI1VjjY0N2Stg09IIGcwfk/cDP+v1pFE=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=B8iBeBgx+lOAnfEfw0R4xQZCG32vOyNOJn4QjtyE5Ozq4bFlYjv3hSMw4Ffz+4hYteI+sxZUjR8AbREnA9Pdq7FsrcRbB3NI1chGvi5XCk8jpLYu4+XEb7IjcHStL5kOUt3PNDagvP21U7mVJwTGnhevr4fvIIc3AUpIze8WK8g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Im0O/NMv; arc=none smtp.client-ip=209.85.210.180
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Im0O/NMv"
Received: by mail-pf1-f180.google.com with SMTP id d2e1a72fcca58-853e2610bb4so1990260b3a.0
        for <stable@vger.kernel.org>; Sun, 13 Sep 2026 23:28:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789367298; x=1789972098; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=iiJKaMbfu9qWEi2n2OlhqAtcjgz04Z/iHxvz1jHrk94=;
        b=Im0O/NMvog1usWt2PJGPLuFH4wO+sLDVWWgS4PPxInUlmlhk4fVBHL8zHvm7fC9OYH
         g6RrUXxF1Y9KtHTQktb2row3Wwi0B7zV1FApjfprMhms6Kr3NAyfQT8cZQBItUaFrmKY
         UzqZXyQiE5reD8PtSCgcSD6FhRQ+bngeIgL9cRudmZGRDAET9dhqYcNsCYR6dAdC6rBz
         owj4/+EKhVZdNsyXQ+1tG+epyqS46+pRAhTPjZUUWWH3wqreTU6HGbLKpMzVRxx8qMgX
         EyqmtmWwLK6Fm+o+uLMWsIWIvQQbG7fxd9plgRd3ukluMNqeEmGer+8Oe3cjdTX4ICdk
         8Y+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789367298; x=1789972098;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=iiJKaMbfu9qWEi2n2OlhqAtcjgz04Z/iHxvz1jHrk94=;
        b=ZtWwRxJH+ZfJUUOwp+Gwm974eYDQtz+ywjLnfewqdg88QTaNmLu7/ks+w032d+X6G5
         Q4f4/jfNUI3XkSb490Qat+Ozy7VfV6guXmgDyvNi9Nkc2Qpu7jk1dddk3mjy2+BhRlbq
         uUkvS5fW8j801uEfnYAIphFdD9T8Tx35ipPx4ADIuAgVf6BTU31FTps0KfmANpcsoxci
         mydaHeobqNQKTCRhu1Xpuiddnwg+HcTjbiReMpegM7DNa24+IzIJj/GEdUEMdkRQprUz
         iXQyrpyrefXfjDgNze9iPJJd+CoEnjdN6anXVYyHvIeCGfHDgK/0+fYHNvCrxR+SoB0i
         O14g==
X-Forwarded-Encrypted: i=1; AKwUvBzJ6tBKC7XLXqL2q9Cdb1c52O44pKu97tMkv14Yqu/uo3Q3JuiZpMN7xUVYUvifKgpsrS8nLlw=@vger.kernel.org
X-Gm-Message-State: AFuF++lswXdrrKk87tuJoiWtQdw+cf+N3FTJTIWwyW1iIS5qa0CYbpjM
	YPcwUHvpfVvKv/vks/ug1Tbi7TCYKwDr8dzOVMAmuBkEQZUiU+xxqONI
X-Gm-Gg: AYBFou08x7zDsdbrRuMwKrDPoGu+4TgRPaCYb1Xc2VyBizoVHdsMRJCWV5GDnH4Stjz
	KxuFnGCe5Hubvf1b8vuZkiLS/5UN0D0Ljd+yMUOgR8bDKj33vgj7Nk5mLHYsbssUGUQM/aeazHd
	xXV6ZuSw78WomKWQUc70jd5c5CG3pK2c1IuCcMlKJ+rBYenCBsdDWG8jps5Mb8zxUjCgUdVIxWF
	zBLUb5tLYmTOdzg3KuzWysLYOfo9MJoOJ1u/qXnS9Tj7aOY67XsTZP1g9DTA9ndov7zxZ+TVYb1
	IHSwiRvZ6WT2YPr3jbmnooj/iScOZaPPPgdCy21eE1iDNM0w1UGrOfnMLxqFUifBVvsiLNDX17V
	VgF16jlt2y+1WN+eeWjzsZ0pUVLpFI0e7TmjbefdQMyj4n5VQmHBl5SY6APyqIGXFf0J6ADTCSz
	0X4HeZ2azRjuErPHdiWqTSsN83vnbe75OkaDp4KSgx8Mzq9yq6uGMGiw==
X-Received: by 2002:a05:6a00:ae0d:b0:869:31b1:4ce3 with SMTP id d2e1a72fcca58-86e2a7ce365mr6207771b3a.9.1789367298432;
        Sun, 13 Sep 2026 23:28:18 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-86b294be699sm3989659b3a.34.2026.09.13.23.28.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 13 Sep 2026 23:28:18 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Marc Hulsman <m.hulsman@tudelft.nl>,
	Guenter Roeck <linux@roeck-us.net>,
	Jean Delvare <khali@linux-fr.org>,
	Hans de Goede <j.w.r.degoede@hhs.nl>,
	linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (w83791d) remove fan/pwm 4-5 sysfs group on remove
Date: Mon, 14 Sep 2026 14:28:09 +0800
Message-ID: <20260914062809.1650538-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

When the fan/pwm 4-5 pins are not used as GPIO, w83791d_probe()
creates the w83791d_group_fanpwm45 sysfs group on the I2C client
device.

The probe error path removes this group when a later initialization
step fails, but the normal remove path only removes w83791d_group.
As a result, the optional fan/pwm 4-5 sysfs files can remain after the
driver is unbound.

The callbacks associated with these files access the driver data,
which is devm allocated and released after driver unbind. Leaving the
sysfs files behind can therefore result in accesses to stale driver
data.

Remove w83791d_group_fanpwm45 during normal teardown as well.

This issue was found by manual code inspection.

Fixes: 6e1ecd9b8f13 ("hwmon: (w83791d) fan 4/5 pins can also be used for gpio")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/hwmon/w83791d.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/hwmon/w83791d.c b/drivers/hwmon/w83791d.c
index 4a777430af5c..4b07a25ae59e 100644
--- a/drivers/hwmon/w83791d.c
+++ b/drivers/hwmon/w83791d.c
@@ -1415,6 +1415,7 @@ static void w83791d_remove(struct i2c_client *client)
 	struct w83791d_data *data = i2c_get_clientdata(client);
 
 	hwmon_device_unregister(data->hwmon_dev);
+	sysfs_remove_group(&client->dev.kobj, &w83791d_group_fanpwm45);
 	sysfs_remove_group(&client->dev.kobj, &w83791d_group);
 }
 
-- 
2.43.0

