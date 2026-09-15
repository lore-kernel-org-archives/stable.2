Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com [74.125.227.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CBCC63C1D49
	for <stable@vger.kernel.org>; Tue, 15 Sep 2026 13:54:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.140
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789480461; cv=none; b=uLHJLr0+0D1qdx8WzssT42Mh3zzFKY4UDA2RmanNCMvmnFBdYmTPllymw4nLHRoDtMn7iLQUxUOmhyVk/Cs+drgrHa666MnxxSxy0s/B+eaRdkIF81KJmmkkRGPzujJTjZ6KM+/OsbzX35EkcWBBDkbbeetXWN4psfxMPyejTEk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789480461; c=relaxed/simple;
	bh=Ag5tfz00fBg6YXo3im7agg0lkNAqHNZutLBmML/rBjs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=JltK61Lgec9HRsmajtb2f9NxPgTteQ5CEaDh009V9c1liKSjhRFMbA77RhamZk7lkV7jZ2xBLzNLxEH4zj5+xTid99SISAU/3AccEGXu174wepdyZTNETx6ELMPEZooBV19U/CxhI4VBt/5GwvLOxSPBCfP9eb0wqfuvr6YpcOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=H0mwRs89; arc=none smtp.client-ip=74.125.227.140
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="H0mwRs89"
Received: by mail-pj2-f12.google.com with SMTP id 98e67ed59e1d1-39b31b4281eso3290634a91.2
        for <stable@vger.kernel.org>; Tue, 15 Sep 2026 06:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789480459; x=1790085259; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=whXzJHNF2cPXx+i5FgzKhan4wYJW9EK7frxKYSb7wNI=;
        b=H0mwRs89+UPb/DZtvXtW8tJ20Ms+Ff2SLVKSuZT+nARB6Ady+AbKw5jJno08CkCoKz
         YzPdklCHVLFOWbKc8Mucu7fCEGzR+RcfikB6msm9o5MP1gtuw+3J0//uPLTXlMPmgCIT
         LeqdVVvUrvHH81iyaMwADOZizOjW8ddC4QrN0UEpNg4TJ2bToX75cHcdycb8L3pvas3M
         V1eF3OwY3ykCg7nLieG2uaHDq5b8OcYW5nNaIDb01fUP0t2X7by+SVwNUUD+cF3et6io
         tjzFL4CYZkOGYAHSFXcLQAVood0pF87e2j6+OvcwoHP8Xt21ihO4sy5ATv34hh8h9mFU
         qCDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789480459; x=1790085259;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=whXzJHNF2cPXx+i5FgzKhan4wYJW9EK7frxKYSb7wNI=;
        b=ZG2/Ddn2Ew4uBiHceAm2D5WDcVb1kbpAdo1mbZjTs6bCnww//iLn9Q1KM4EARtYqZX
         N3KA9oPbILTxsPGiOQsDCfmQ8/1iN9/Km5cstfeCGcpwzGiRmxFXbYgJ6MTWqWs4/2lz
         ueagakKNIa852/3vc7CZOtqCPJ9oe6bvbtCiLZonRh/3AsJE7AjItRNn6i3T7S+qiUBR
         TqkEvEx8pq6Su1RviU3Mf5oPiFwzmht7ejdCrDP/tKVnakGodpbJjiddd12fHJnCrZ6o
         dHZw8h3K3FY5+0HT4grIuUbvdo2lUP2BTsSz8niixJfM1l2yTMitd2jOrwFb7Txd4CrV
         pGlA==
X-Forwarded-Encrypted: i=1; AKwUvBxR76W4GDWkbSTYSnO2k3MAE3R/Tn/yZhAmRsKlqP1mMtTVl9jTOO/96cZL9ecjtvSlBkc76zE=@vger.kernel.org
X-Gm-Message-State: AFuF++mafIgGDdtGzEj51kB2ksFEd0XIeqOuwmx9Hv2h3SI1t6Tt+y2X
	o+pbm7Z/qxxt412ysgOzBMEpIFNvkuBH7bnB8u9amcC173VGji4xVvu5
X-Gm-Gg: AYBFou1+5IB+1FerMhRVXHDx6NKXQ7MgALLu7wpeJcIU3YT7WwscW4luExU0hG/wR5v
	E87r6V2BTQRqn0B9K4/z4+3hHjLfMqDOyFUmFa6TjDA/qbDsW6tLQAyaNWjirKe7duB0VTE4Xrl
	04xRI/Mae/NQH+7Aaz+oEmc+NjwNqz3F0ov1xKwkCxluDCO8bHlx8SKcrrwVF2YXuRMCjZdquDX
	mn2fm5Eoc6XP7aqVUeYSUdaCy5DqSzMBsRV2eje6Xepyoo5GnSA12JbNi9NE49B7HPHrttN1CZK
	zXOCMExXGw1L6ylxoNzCtLJtrfi4Ihdy2/ZFMUtaT4nBSgVebHt3Q2aisbqMz/nge+NKf0VX9q0
	fGGA1ZBYoA6ZPvGP8+J7FRgCfir2i2yQIoQ5GvwOnnDMV6vpgPUQYsRpIbaMK9vMjtmR/590/8I
	skd8tbWqrMEqpoCTkuOZlOPNfUYpDxee9J3nSu3T4uKYj0PLHhumC6bcY=
X-Received: by 2002:a17:90b:39ac:b0:39e:261:4e0d with SMTP id 98e67ed59e1d1-39e026159e9mr5815662a91.25.1789480458971;
        Tue, 15 Sep 2026 06:54:18 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39dfdd0ba9bsm5533757a91.7.2026.09.15.06.54.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Sep 2026 06:54:18 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Jacopo Mondi <jacopo@jmondi.org>,
	Mauro Carvalho Chehab <mchehab@kernel.org>,
	Hans Verkuil <hverkuil@kernel.org>,
	Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
	linux-media@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] media: renesas: ceu: free device data if video device is unregistered
Date: Tue, 15 Sep 2026 21:54:06 +0800
Message-ID: <20260915135406.2423337-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

ceu_probe() allocates ceudev, while ceu_remove() does not free it if the
video device has not been registered.

The video device is registered from the async notifier complete
callback, and its release callback is responsible for freeing ceudev.
If the device is removed before the notifier completes, or before video
device registration succeeds, video_unregister_device() does not invoke
the release callback and the ceudev allocation is leaked.

Check whether the video device was registered during remove. Unregister
it normally when registered so that its release callback handles the
final free, otherwise free ceudev directly.

This issue was found by manual code inspection.

Fixes: 32e5a70dc8f4 ("media: platform: Add Renesas CEU driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/media/platform/renesas/renesas-ceu.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/media/platform/renesas/renesas-ceu.c b/drivers/media/platform/renesas/renesas-ceu.c
index 65f7659a9e02..5015b7837381 100644
--- a/drivers/media/platform/renesas/renesas-ceu.c
+++ b/drivers/media/platform/renesas/renesas-ceu.c
@@ -1705,7 +1705,10 @@ static void ceu_remove(struct platform_device *pdev)
 
 	v4l2_device_unregister(&ceudev->v4l2_dev);
 
-	video_unregister_device(&ceudev->vdev);
+	if (video_is_registered(&ceudev->vdev))
+		video_unregister_device(&ceudev->vdev);
+	else
+		kfree(ceudev);
 }
 
 static const struct dev_pm_ops ceu_pm_ops = {
-- 
2.43.0

