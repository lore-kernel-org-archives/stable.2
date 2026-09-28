Received: from mail-ej2-f41.google.com (mail-ej2-f41.google.com [74.125.228.169])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 142303911B2
	for <stable@vger.kernel.org>; Mon, 28 Sep 2026 06:22:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.169
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790576569; cv=none; b=hyGK6VEoKrEswHtD+oW3GMOep9/EOYhRWPl3VfNgGGK3vDSjWF4Dzof2S+FpfrrOF4S3MgI9ptIqbPVUbHpL1UzVG4YhOXdDJuRY2+QwjjTSkt4muaJPmkzvVQwX9Z5Rn4UJkpfFfGu5jLJugmNYMmRb0xYxeNNg6vXTh8dknd4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790576569; c=relaxed/simple;
	bh=LR/nA4tVHyi6eFNl4mMbMzn2KnpfyeV8b0n4FCCSrn0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ff1Qm5H151RIj24T3ElkAxYZ+3dm5JcReb4qy/8YbEuE+/4YtIIbnRZfVPROWpOp1llQk0CU3oBD8Mt6hoRrMPAKUxSWEeE0t1C9awxF+EsvgckN5hI0tKUIDZKbu9ekp6sCK2jOmFP0LgA6ZWNre7QbeFhFbCSMQLGf2Hb7aHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspiral.be; spf=none smtp.mailfrom=inspiral.be; dkim=pass (2048-bit key) header.d=inspiral-be.20251104.gappssmtp.com header.i=@inspiral-be.20251104.gappssmtp.com header.b=LUd+qxlj; arc=none smtp.client-ip=74.125.228.169
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=inspiral.be
Authentication-Results: smtp.subspace.kernel.org; spf=none smtp.mailfrom=inspiral.be
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=inspiral-be.20251104.gappssmtp.com header.i=@inspiral-be.20251104.gappssmtp.com header.b="LUd+qxlj"
Received: by mail-ej2-f41.google.com with SMTP id a640c23a62f3a-c2dc50c6edfso111811766b.1
        for <stable@vger.kernel.org>; Sun, 27 Sep 2026 23:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=inspiral-be.20251104.gappssmtp.com; s=20251104; t=1790576565; x=1791181365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=PbVyliIXNTgSBOAj+pK7xJkZUV9YZeRWXj8iKW7Lm+M=;
        b=LUd+qxljMVLJckINGPYvWjAF/JZv1PbV69Dd08+Uz6YKRbM++bMm19YwvyT0WNCXDV
         Hme2XzMBi/qWNSQ1CgvyzpcEzG308zMO9vjSw3DInRxTyvZGlIuUL0ShaKdaQngAhiIp
         HpdsMacrFYcydNqbXrL2xTfigP3dd1i5GOT6R4p81O2L5taFNnnZWT0SW12ByP5V2u2M
         nY8S0X8ERkDJkSG/OrqgD3/Vks68e0441lxZ/F9qC9pfnqQwEuZhDeww9jstb2Rzd7Bz
         E/8uDmQjpAUwHfVIbXFcc4Iyx0nQ1nt7ZAw6pWXj+7hV1u9MYqhctGspW4RF7LgjbW8W
         kmIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790576565; x=1791181365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to:content-type;
        bh=PbVyliIXNTgSBOAj+pK7xJkZUV9YZeRWXj8iKW7Lm+M=;
        b=IwkH2QTstNu59VjD8km+cLj1XmpzQNTN21r4vA31IvhauM9/kdAFOw/SG+fkvuhTbT
         SrjXPYKwgeUYBEJwI8AkiYnhTlFntd/nL8RoiKaFUOdwPUtZjvVTEd6qiZb2DhWGOLmg
         r/mighTC0+9pBYFJl+CINaegrbEXHlJhekVi9rc6K9nHF0W2GWBjJuYtYkgH8Nt55GVT
         IC9981U0DeqRWmDWtIFSnPa89kiE1ewe6hyH13yJs3mGeBG876xtivOaXtC69jCWvfr8
         9Dy/HMCzGZ2kc9+pKw6iCLibVqCfu4vM6jNiOapv1ESn2ma301XnRK8uUcDw1eLPZVSX
         EDrA==
X-Forwarded-Encrypted: i=1; AKwUvBzhv9i8zSR4gyX+2tqw5rhIzUdIJvtLrXdLLcKFsU4C290GtFB7AIqkTLZaYEIAgYD50iA9wqc=@vger.kernel.org
X-Gm-Message-State: AFuF++mpEYsVn17kEJZ4lQa7exVjwCJcTq/ZXHqNLRwbpD6KLNG09iEW
	KLisVdRoy/OEXduZqFHLx1yUsJ3lmul/29XpgnWB4Vzn8n+LhKwemXZFc4NX1inhNmPwL2Rx3MQ
	P8IsXc34=
X-Gm-Gg: AYBFou2Ni5b/PjjY0b4wmqOLzQ8iW7+jdeNXIdJQhfjn/n8SM7SFDl/zAP2C+qBljkx
	2M/Zd1mk+cjOwj5tKY/LbKsqtgxQcrc/HFP1x5biWQmWT3hLu6dJ1R6c03XxeyJfpqoVzPKrkFu
	eO7StjCkz0rhpMYukVEeAWD7klXTBJgSJjYCysU2eUHcWzsrs7Ue6ez7tOwZEUDq235MP7tZRJy
	WUSBx+/PTtT8D/i0iHpDlQsFCwf5125RuMyp8I7JoIo3eKvUOjRroqasMz/q+KY7zMYZhSrvvL5
	y9lP+YFzOUs5x9nbd9AE3mQGXVJuDyshKRcM8x7XdUpFYiDfbE5CaTxsrUCNOzKrhHtqH0sbtEF
	t3EXUD1J2Eh7Z5riwD6CMInCXrgPwHyA3E93IZKIxjekW38r/F1L8saPRZ6XRnG5qSYV80F1N/o
	Xsj0eFj2aodCHeTZPWZWGF1sXfGGw4cuA5ivwNYfD0GBsG/Dg/yJfww2nezAc0r0QbPdMiQDQv6
	Bw1ALou45a9nRhy6k0ahgQkPB7PB4udE4AUR8Din+AO19cuKKw=
X-Received: by 2002:a17:907:ea8b:b0:c2a:fbe1:7340 with SMTP id a640c23a62f3a-c2afbe173b5mr498650466b.41.1790576564599;
        Sun, 27 Sep 2026 23:22:44 -0700 (PDT)
Received: from vger (99.240-244-81.adsl-static.isp.belgacom.be. [81.244.240.99])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-c2ae678bbb0sm419858666b.5.2026.09.27.23.22.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 23:22:44 -0700 (PDT)
From: Tom Verdonck <tom.verdonck@inspiral.be>
To: Guenter Roeck <linux@roeck-us.net>
Cc: linux-hwmon@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Tom Verdonck <tom.verdonck@inspiral.be>,
	Sashiko <sashiko-bot@kernel.org>,
	stable@vger.kernel.org
Subject: [PATCH] hwmon: (sht4x) Fix torn read of heating_complete in heater_enable_show()
Date: Mon, 28 Sep 2026 08:22:38 +0200
Message-ID: <20260928062238.67746-1-tom.verdonck@inspiral.be>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <7b2087ccb963e097cf3f6333efaec0c46549003b.1790358356.git.tom.verdonck@inspiral.be>
References: <7b2087ccb963e097cf3f6333efaec0c46549003b.1790358356.git.tom.verdonck@inspiral.be>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Commit 61406e9cac69 ("hwmon: (sht4x) Fix jiffies wraparound in
heater-ready check") widened ->heating_complete from unsigned long to
u64. On 32-bit architectures a u64 is no longer loaded and stored
atomically, so heater_enable_show(), which reads ->heating_complete
without any locking, can race heater_enable_store() and observe a torn
value, reporting a wrong heater state.

Take the hwmon lock in heater_enable_show(), as heater_enable_store()
already does when it updates ->heating_complete. The other reader,
sht4x_read_values(), is only reached through the hwmon read callback,
which the hwmon core already serializes with the same lock.

Reported-by: Sashiko <sashiko-bot@kernel.org>
Closes: https://sashiko.dev/#/patchset/cover.1790358356.git.tom.verdonck@inspiral.be?part=3
Fixes: 61406e9cac69 ("hwmon: (sht4x) Fix jiffies wraparound in heater-ready check")
Cc: stable@vger.kernel.org
Signed-off-by: Tom Verdonck <tom.verdonck@inspiral.be>
---
Guenter, if the hwmon branch has not gone to Linus yet, feel free to
squash this into commit 61406e9cac69 ("hwmon: (sht4x) Fix jiffies
wraparound in heater-ready check") instead.

 drivers/hwmon/sht4x.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/hwmon/sht4x.c b/drivers/hwmon/sht4x.c
index da2b6130fca7..27fddff70354 100644
--- a/drivers/hwmon/sht4x.c
+++ b/drivers/hwmon/sht4x.c
@@ -237,6 +237,8 @@ static ssize_t heater_enable_show(struct device *dev,
 {
 	struct sht4x_data *data = dev_get_drvdata(dev);
 
+	guard(hwmon_lock)(dev);
+
 	return sysfs_emit(buf, "%u\n", time_before64(get_jiffies_64(), data->heating_complete));
 }
 
-- 
2.53.0

