Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 073B73CA497
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 08:05:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789459516; cv=none; b=Kzsiy7rdLMactduRf15QYhx4XSkgqiO/BR0EDb7U7vCcU7hV5DqET0GY9t4H9IDgwpBlsO5zDBq4o36VC6mU6xi5OnoWSqRzRP8sjtf73OSLdbjBh8b/CsARqPQzbsTbgjo4UEKGUougTFl08EzIJZskfRvEwSw9wvvfra9IiJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789459516; c=relaxed/simple;
	bh=oZ0N0PsuEqbDomR5sP8cO8KR7NnXA59aOg2GPCnVdzM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=DmYE5BWgXS+LYHs+7INUlQ6s8kzDE0w7McL5d0i6bTzr/7aZD7ZvG9h/SCv/Za7tmc4CyQlhxiHkxNMsf9xVFM4O8YphOuhgzO5MnaqCBx32Pk40m7fevLaztNX5mafTyGsIuqsCuNsirqhQdBBBhMydZhz+7F7JAPRh07+1798=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=YvUHXw09; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YvUHXw09"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-396ccd78e6eso861013a91.0
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 01:05:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789459513; x=1790064313; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8oXVOqLbDDmDiQXcRbmwevDgD4MKWOik8Fi0EZ/eGXA=;
        b=YvUHXw097GpnOeKx3RqOvXwHCDuOFBisU2oZR8wSUAlVg587FR5RKspun6BYboviEE
         JJWC8Xl3JaAoNWvSFokP4axbLJ3T5W0lojiJku32hZen8xx0MIzsgYD91x/zaOuUXri2
         AygA/0kn6SgQVCrUtNpq8KGevX+FuAv2Y4pSwwJxDc4h6YVyH2y4T7iVHjv9a0LfN13i
         Wj7R3U00jJaeOhnhFPeMAR3O6WrWc13Y2N9zg3KMgajXP4pe1bD2YX/ngwaMPcJJldya
         RNRqh5ZbVnlSCtGPyGNH21tvL+8cflMvBD05v2t9Sj9ceYgqTEmaVosiyfY9829iWW7/
         Ocog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789459513; x=1790064313;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8oXVOqLbDDmDiQXcRbmwevDgD4MKWOik8Fi0EZ/eGXA=;
        b=ZHd12Ey3wvCuB4gBroeh/wMLH2QSg0s+073uiFXJzzlYZzU+BaWfoTv5vynquI5+FT
         O3SVUT9+VaXMpcgAT4FipaI0b9lx73BZJbo+vx3W13+Uouav5F7qNB2I62L0xgSZpRZO
         oONtntXBScFK7u0eBcNyUTjEWS9z8M9J0oKdJ7usnVHBjDWGc845+hDICZksQ97KmtQI
         WiUeXY9Erfe4pYaC4bvjx7xkNqdHZ426OiPSMQVW9oGv/ypw7JBZduv1Ho7NdtF2Gk4A
         owdCZGiqrxgff5nRvV3VhGJMVU99bbq8fGGfoOYBKRQtPd0Ds14Y+w8cOmyM9npKwObp
         sfEA==
X-Forwarded-Encrypted: i=1; AKwUvBwG9RaxXiiBjuFovjp7TOLBjmMy3CMVcpiBJvTJbQYhQMifegFd8fmSkF8em0y1HLUn/h/hkIM=@vger.kernel.org
X-Gm-Message-State: AFuF++n0wfBk614rCV8x+L1X68M7JidzN1oVmYIKJ/69KhxO1iglDMmK
	SI/r3Qp6smYcZawOGxdZwVv8TXxAIE33pz3XMifZSUvSNinEHpbtRDNo
X-Gm-Gg: AYBFou1gN1J8B8bHA0y+sCWgOMBTKNn2VsCvHyIDS81BGUWmgjL76Uu2mn4zsgNizke
	/xGIC8bbyQPLp1u8UAMyZd3DcU/68MQYWEfCAurg9TrMT2nIMa+er3+d6QBcVsthnCzkB7v5qv4
	3U3xB6kymZuiCsXlHYoN+PucvPDJStqlznkLIgnVW96iQTfOMRfgnyGH+tNtf6R3YsHoRH3uCvM
	QGii1lsAFTUckyWr4J83V4epOEbrCfl4hX2lvcQRkEBYpMm+kWGGZqApyVfaIkTEeb2AB2mStlE
	h7scB8pBvjVVzo7xC2XR2PCPw+bqDJ5djfunR2Du3zO86iuY10aXYKJvx6oKwHfgQQps0RqV3Sw
	l9/g1/8xIGsWqkpXw7B8NIZV/1x/yYOoXbFPWmZK+2gEbtenQHNSKLEsE64xwx2wQCSD6vJxGmF
	pe5kE31z9FpkwU0sDzr/VlzRFLyEH5Pqpz6Rsl/BzrTsvrmh/D+tlA0w==
X-Received: by 2002:a17:90b:314c:b0:398:9bd3:d6d6 with SMTP id 98e67ed59e1d1-39dfe1901e4mr2977305a91.16.1789459513101;
        Tue, 15 Sep 2026 01:05:13 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfddc2759sm3727034a91.17.2026.09.15.01.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 01:05:12 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Sakari Ailus <sakari.ailus@linux.intel.com>,
	Sebastian Reichel <sre@kernel.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
	Hans Verkuil <hverkuil@kernel.org>,
	linux-media@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: i2c: gc0308: drop runtime PM reference after probe
Date: Tue, 15 Sep 2026 16:05:01 +0800
Message-ID: <20260915080501.2164892-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

gc0308_probe() powers the sensor manually and takes a runtime PM
reference with pm_runtime_get_noresume() before enabling runtime PM and
autosuspend.

The probe error path correctly drops this reference with
pm_runtime_put_noidle(), but the successful probe path never releases
it. As a result, the runtime PM usage count remains non-zero for the
entire lifetime of the bound driver, preventing the sensor from
runtime-suspending when idle.

Drop the initial runtime PM reference with
pm_runtime_put_autosuspend() after the V4L2 subdevice has been
successfully registered. This allows the usage count to reach zero and
the sensor to enter runtime suspend after the configured autosuspend
delay.

This issue was found by manual code inspection.

Fixes: 3ae52083b533 ("media: i2c: gc0308: new driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/i2c/gc0308.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/media/i2c/gc0308.c b/drivers/media/i2c/gc0308.c
index 15900d5414cf..266f737f9c5d 100644
--- a/drivers/media/i2c/gc0308.c
+++ b/drivers/media/i2c/gc0308.c
@@ -1385,6 +1385,7 @@ static int gc0308_probe(struct i2c_client *client)
 		dev_err_probe(dev, ret, "failed to register v4l subdev\n");
 		goto fail_rpm;
 	}
+	pm_runtime_put_autosuspend(dev);
 
 	return 0;
 
-- 
2.43.0

