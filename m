Received: from mail-pz2-f41.google.com (mail-pz2-f41.google.com [74.125.228.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A69DE436BC8
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 07:38:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789976341; cv=none; b=pE01NxpfOCcngn7+ax/TBaFgidrUqcORXMLxHN8BRRK53JPAzw+4lSLA+VIde1cmlk/V4YxSH2tfF0NihT0m58QaFSI9Phi7GBTBGgAsEMH/9wiKsMFXi9vAMk0F+FufyMpc5yQittFdNgnEfh/rYWhVzkO82nUpun30Dx8eBoc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789976341; c=relaxed/simple;
	bh=1oGHKBzHrxoX8CDM/z524FTQ57Egw9xruprsovBKdbg=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=I3SqZgdB80yRaYGSFbS8l0Ksxtlmszrfo+LveLWQImhNtCFIYn+gOjg+6VJbd8o1zj1uXLCHNv/SMOi60GJ//LJ/dUtMfhLe4koBfR5BUKnRDsv8V9TT4I9Ex4YpwGhqMH9q44iyFBUuzkPOYUFHcqTrPwjuLywqaXJFiM+6MtU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WRy+Vz3y; arc=none smtp.client-ip=74.125.228.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WRy+Vz3y"
Received: by mail-pz2-f41.google.com with SMTP id 41be03b00d2f7-cc50d1b048eso2147569a12.1
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 00:38:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789976338; x=1790581138; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=V1aVBw9zdrM4El40DQjPRHAcTE50i+bnMPj3LzqLGDw=;
        b=WRy+Vz3y5ozcfYa7Mv5blem/dBCCjHCyRcAtjn2OdhtCr0Yefuz8oR44C63e1N/JMQ
         FrkGY4iBZsXBnal9JeS7exsefo7MonEDFjxlTRD0/7P279F2Rbb41fTbb1/78UrV0dYL
         EVI6JUf1qgtHxTm3jQMHvtiLA06aUcQNV7PomtL2dDwDPLacwlYlFAVZHmqK10bvlpOs
         c4y0xCI6oT6MrKNV5NT/0k0snuGQRN5eBWqP+iJLQaSyptqQR4QQjPQYVOg7Wf86P9CW
         Eem4xjzEjihnBezO0sEMLP7Z+KbnuoMYILwj3h6J8AY/lcbxkrzCbKPTwApd4YHyQ62c
         xiww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789976338; x=1790581138;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=V1aVBw9zdrM4El40DQjPRHAcTE50i+bnMPj3LzqLGDw=;
        b=pO9g/48RexYilB4GmDae5fm20AbXo2ujyiFuQEfbXFwTJtvw3kMlG7gQFIhwvAREpG
         TR1QbJ2JjzqxOPl22pmSEQ5uZwEQqOx4eSKGg9twJ+L+okdtCjsDzEqyEs3NGIB4kagG
         XD6s/CKan+avz9NsszABBikc+PuoweHg4jwLCxOjZA7jyVClu2++nVZv7BPXiJoxyBe/
         9Zp14SHx4QfoRtExgyhNVIub3JlB/Imy5fhJ8+R0QIheTIZsCmksUuq7W5YAWDjqYTK0
         lPZ7FZuMpIre1UnQPs2XK+Ym8pTUJJHZDOFvyLw65NVWKRF5ASRla+WOJ/QmuaGinF4u
         CIEg==
X-Gm-Message-State: AFuF++lXOqzy4TYPcN1xK1pxr02XCfB/gYNC6quP+DRqZsYE8a2YLFh1
	jP9W0jE2eDrMk0YXpI58lyyRjRdcqPt+kBC7CRmfkJVywYQzXTsUY6/u
X-Gm-Gg: AYBFou1qIHnNkzMmXyMsgT55+orX6eLX93yRqBlKWyzOZktVkj/0UcL0PYnGe9HMB7H
	SjmOUCPqLIO6W7iPLagKRgWl1tUkbOFyWaMuEvCdlZjOuMuNSM1xH7qVlKomNhNlEm9LwLsoLgm
	k1UAIFdSVvrPJMZdhssLxU2uXaluJHFDiOqDs2y9Zvb6DwW0AtIo6916LWw950unjMbmzw5pcsj
	L5unUlv+gRy3kJJIS+dlJ7rLhYa/Idf9x9cfjCn5N+rwr+Kspi/TYoamnEKEqf9RXaef7g5tVRj
	AlNO1pSahEWdan8HIV3z4q/nptuJOkGSKEgGWzUH0iRtYfSOwMNjKITWrzdEYJNgQkFnPVX0CAr
	DSyItpEks1QTnys1FlnvDeDArE9lSKvW0FynSwWqRkTOjFjEUzBv9LMCjKj9y/q8GQO+wMhWjBm
	55f2pLLM4/GKDd+wyYPwgwwHqn/nBHxYOodBncihodltWz/mv8KIpWBQ==
X-Received: by 2002:a05:6a21:7481:b0:3dd:a196:69dc with SMTP id adf61e73a8af0-3dda19677c2mr9204200637.55.1789976337848;
        Mon, 21 Sep 2026 00:38:57 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-cc72ae71fe3sm2981178a12.8.2026.09.21.00.38.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 00:38:57 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Cezary Rojewski <cezary.rojewski@intel.com>,
	Liam Girdwood <liam.r.girdwood@linux.intel.com>,
	Peter Ujfalusi <peter.ujfalusi@linux.intel.com>,
	Bard Liao <yung-chuan.liao@linux.intel.com>,
	Kai Vehmanen <kai.vehmanen@linux.intel.com>,
	Pierre-Louis Bossart <pierre-louis.bossart@linux.dev>,
	Mark Brown <broonie@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Thorsten Blum <thorsten.blum@linux.dev>,
	Guangshuo Li <lgs201920130244@gmail.com>,
	linux-sound@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: stable@vger.kernel.org
Subject: [PATCH] ASoC: Intel: SST: fix platform device leak on probe failure
Date: Mon, 21 Sep 2026 15:38:47 +0800
Message-ID: <20260921073847.63505-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

sst_acpi_probe() registers platform devices for the SST platform and
machine drivers using platform_device_register_data(), but does not
unregister them when later probe steps fail.

If machine device registration fails, the already registered SST platform
device is left registered. The same leak happens when
sst_platform_get_resources() or sst_context_init() fails after both
platform devices have been successfully registered.

A registered platform device owns resources allocated by the platform
device core and must be released with platform_device_unregister() so
that the device reference is dropped and platform_device_release() can
free the backing platform_object.

Unregister the created platform devices on all failure paths to restore
the missing cleanup.

The issue was identified by a static analysis tool I developed and
confirmed by manual review.

Fixes: caf94ed8629a ("ASoC: Intel: bytcr_rt5640: fixup DAI codec_name with HID")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 sound/soc/intel/atom/sst/sst_acpi.c | 13 ++++++++++---
 1 file changed, 10 insertions(+), 3 deletions(-)

diff --git a/sound/soc/intel/atom/sst/sst_acpi.c b/sound/soc/intel/atom/sst/sst_acpi.c
index 73624e1b138a..a1f16083bd3d 100644
--- a/sound/soc/intel/atom/sst/sst_acpi.c
+++ b/sound/soc/intel/atom/sst/sst_acpi.c
@@ -352,7 +352,8 @@ static int sst_acpi_probe(struct platform_device *pdev)
 	if (IS_ERR(mdev)) {
 		dev_err(dev, "Failed to create machine device: %s\n",
 			mach->drv_name);
-		return PTR_ERR(mdev);
+		ret = PTR_ERR(mdev);
+		goto err_unregister_plat_dev;
 	}
 
 	/* Fill sst platform data */
@@ -361,15 +362,21 @@ static int sst_acpi_probe(struct platform_device *pdev)
 
 	ret = sst_platform_get_resources(ctx);
 	if (ret)
-		return ret;
+		goto err_unregister_mdev;
 
 	ret = sst_context_init(ctx);
 	if (ret < 0)
-		return ret;
+		goto err_unregister_mdev;
 
 	sst_configure_runtime_pm(ctx);
 	platform_set_drvdata(pdev, ctx);
 	return ret;
+
+err_unregister_mdev:
+	platform_device_unregister(mdev);
+err_unregister_plat_dev:
+	platform_device_unregister(plat_dev);
+	return ret;
 }
 
 /**
-- 
2.43.0

