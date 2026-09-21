Received: from mail-pz2-f12.google.com (mail-pz2-f12.google.com [74.125.228.12])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 227FA329C48
	for <stable@vger.kernel.org>; Mon, 21 Sep 2026 08:22:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.12
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789978941; cv=none; b=MSz4IyaXFreTiX3CksGcxxB7+jgmp1Ve57+EAMPlSry+cRT3Dlxae7BtBXQh1ZrXFIGe1uMTYLKDHFxmq8qVpTWqRwOr2TG1HxM07bQMVHgyAqam6y65u4Dd+4wNe9QMFbYXKE8dr/Ni/i9X9dg71CM8B+7pPsYG6IyybsZXlX0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789978941; c=relaxed/simple;
	bh=SMcDrXDqlMLMSWItZhzONWpiQQwJGuLMdSYPsacLrYQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=nSOpCOcTnYc5PebJ0g/zCwg6Vp+x68qD2iATKoduG2e6dZUAa9LJFG6FqNTz5d68ZE9KY0bC1paYjJNbDpE3QG5DmT0ye3r4f80dpo3BOfov0QogWq/OVkzwK5viUyfiL373CXsgHzya06NUVpNumwXc2jjHcdhxQs/ldDiQ+iE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=RoJoQddb; arc=none smtp.client-ip=74.125.228.12
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RoJoQddb"
Received: by mail-pz2-f12.google.com with SMTP id d2e1a72fcca58-8686f46e4adso2260856b3a.0
        for <stable@vger.kernel.org>; Mon, 21 Sep 2026 01:22:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789978938; x=1790583738; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=oroj33Lk2vXbfhyXWgQGSCksQ6cUFJmkYowA5JxOAlU=;
        b=RoJoQddb4uchlqXHykM7A5DA0hHgsTQxd6w3ppr/vHUbNXoFw6RvEFmU0xDeDW28wB
         R0+7U/fNHLOeWkyEtHKArLnGGGD6TJ3Tu/7O673l97T3gbpCM9aYp/TqUA56qHb9zoWH
         8mHTJFHqhsTgf84LMxdaZR5vFEW+Y+a5GGMufMx+/130kZ2JO8ASA3SV0+1FhbnWrVcT
         Yf/fs+zlxwPQNDKqveOLoz3urLEpj5LyUkQX3PIF6YDhNDsMlLegNhNhJtHDi563cDPn
         E3affXEMOWeUfNQBX/zfXJnoo/G2MdoevDdY89a0wzLy12rHaDOEIx6aC7s1lgWGd57S
         VDKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789978938; x=1790583738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=oroj33Lk2vXbfhyXWgQGSCksQ6cUFJmkYowA5JxOAlU=;
        b=UVAFn8iH/Wv4Sxwr1FiCna7pDsoHwFW8WSxNy/uMaa6xvs1c4yT+Mqi8DtGJ9i8+4N
         qgt+7bq0seV0+hDlNlG4Ekdgk9zr/uhrD1KxKOZ7t9WkIVm0udykCQOAbAbeLwrRq5YI
         WyXA62PfxQMGTz6Q6NKDAiCNXUOyxJx4eeocEJCIqnLm1lN0IX0FmLakn3aEcavpkQZy
         dAcpmqx63G+3L9zhSBeG4dcBVPQ+RqEnqBj3r0+Lxl5WVV1wvw8/E3Wn0q325DuO8JvR
         RRzCDjX7dSvHJuJPZLzJvwKMjGnV874YawwF5Gqee6MBDUYYZLL2tzV3DfjJ/nt4ztPK
         WBzw==
X-Forwarded-Encrypted: i=1; AKwUvBx0r/VzAD5E183ceQR1aPcvnP8mDAvj9zE2IsdwUUBJvnRF0+/hNteR/dgKHEWOIy7aXWY+HJc=@vger.kernel.org
X-Gm-Message-State: AFuF++m2W5YI5dCkH1EF5UMVhGVSJ+u4Nt7ifDu/6gUpiXCTvFftD0kb
	HXPEGZUdz5o6kGKctm9L0fV6uMsR6lDYDc/LHcikkHDvk/w0hqROvnD/
X-Gm-Gg: AYBFou3icmI+a39c63wBu8quzrPZYIfI4UeN4sJ9gev0BQ6TB2ZnxEkDS4JKqlRbbYq
	APhhdQZiMyVJvX7QwSo/BW3AKFCxbhuUUooF1u+4BlpE0su49JrCifJBxQshw3N+EHi8fkhuGVt
	ujvq0btDxJxNtxN55vi6ovMJKEKChgUr7yFp5RCoIX7zlOFzyoDqljqGi8/rBh0lcLdBjr2APJV
	33gqEThYnxRlblTLvWhG2n9sdD7od9T3sTkJ/4n2uNd5yfR2r9Bp8V3uDaSx1+0PALxANl25AGp
	Iumw66DrZWUaL3qqs/CWn9Pm77Dikov7mo9p8jjVnVDxVFyt3ufuZTZ7/8KyMl2NOmjvfKQHdRh
	3RQFFNG510lTlCmivQJgBP31PM2OjebySFutUbHsVQmiEckTtm2llbyiQxRJ2TRCUapdBfVPGIn
	nX+3Nj+qrSGvzZWPS7LJuP/+X8aG8K6sFyBTuDxPveh7FQngnJdSKC1cxKhIMW/H4ZDg==
X-Received: by 2002:a05:6a00:893:b0:871:9e1b:8a75 with SMTP id d2e1a72fcca58-874dd7f8ab2mr13461980b3a.20.1789978938500;
        Mon, 21 Sep 2026 01:22:18 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-877aa104197sm2861748b3a.45.2026.09.21.01.22.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 21 Sep 2026 01:22:18 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Thierry Reding <thierry.reding@kernel.org>,
	Mikko Perttunen <mperttunen@nvidia.com>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Ulf Hansson <ulfh@kernel.org>,
	Dmitry Osipenko <digetx@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-tegra@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH v2] gpu: host1x: fix runtime PM reference leak on remove
Date: Mon, 21 Sep 2026 16:22:06 +0800
Message-ID: <20260921082206.234421-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

host1x_probe() calls pm_runtime_resume_and_get() and intentionally keeps
the runtime PM usage reference for the lifetime of the driver because
host1x is not yet ready for dynamic runtime PM.

The probe error path drops this reference with
pm_runtime_put_sync_suspend(), but the remove path only calls
pm_runtime_force_suspend().

pm_runtime_force_suspend() disables runtime PM and invokes the runtime
suspend callback when necessary, but it does not decrement the runtime
PM usage counter. As a result, the reference acquired by
pm_runtime_resume_and_get() remains held after the driver is unbound.
Repeated bind and unbind cycles can therefore leave the runtime PM
usage counter increasingly unbalanced.

Drop the usage reference with pm_runtime_put_sync_suspend() before
forcing the device into suspend during removal.

This issue was found by manual code inspection.

Fixes: 6b6776e2ab8a ("gpu: host1x: Add initial runtime PM and OPP support")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
v2:
  - Replace pm_runtime_force_suspend() with pm_runtime_disable() after
    dropping the runtime PM usage reference, as suggested by Mikko Perttunen.

 drivers/gpu/host1x/dev.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/host1x/dev.c b/drivers/gpu/host1x/dev.c
index d2c64728f804..123143b2836b 100644
--- a/drivers/gpu/host1x/dev.c
+++ b/drivers/gpu/host1x/dev.c
@@ -729,7 +729,8 @@ static void host1x_remove(struct platform_device *pdev)
 	host1x_unregister(host);
 	host1x_debug_deinit(host);
 
-	pm_runtime_force_suspend(&pdev->dev);
+	pm_runtime_put_sync_suspend(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
 
 	host1x_intr_deinit(host);
 	host1x_syncpt_deinit(host);
-- 
2.43.0

