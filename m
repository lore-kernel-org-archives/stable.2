Received: from mail-pz2-f6.google.com (mail-pz2-f6.google.com [74.125.228.6])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 52E741E9919
	for <stable@vger.kernel.org>; Sat,  3 Oct 2026 09:35:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.228.6
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791020103; cv=none; b=oaqVoR4bjfQOs5QVllZc0l50k8E8uac48Bfx21EZtZl4KRLSXqPegmlBlXpKrfHQPakKVIozT0GKcCrrQ9PZ4gO7I1S9DFoDJkX9iQmqXcOGJpS1ssTXcmhanefYYP8v7Z39CjRkpSOdQhxDCrkcS0/8VEeDh96YOAENnF33FkY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791020103; c=relaxed/simple;
	bh=BnGa8NDJZnK2S1ungKI815U/3TD4/ubYnz77jR0hQ8E=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Yg6sgGnRrgE372NL8qLBlZl2FvSZPDp5wyI5QPwnrUGyGeBxTWz0tfGG1pQJ4Z7JAeD2ZkrQmhvxrQPk3z6R9jXGRFexdfBNmLlfTGQDESIG02V9tRvfbqOvDwh6RdzEoD8cLUiAaKX5EbxRJd0G7KgzwrVon3/fGRIcErX0/BA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=ecYySlvP; arc=none smtp.client-ip=74.125.228.6
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ecYySlvP"
Received: by mail-pz2-f6.google.com with SMTP id 41be03b00d2f7-cc75f2924abso329641a12.1
        for <stable@vger.kernel.org>; Sat, 03 Oct 2026 02:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791020102; x=1791624902; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=rBI89OF+N0vXnxCESFaz463auJhNn0qQwp4320r4m4Q=;
        b=ecYySlvPwZbLZ6zSgXq4BwzXgd2VDG0kMBGnyoQ5VnF9e7UtNnnBOqV5jQsFMhBgpv
         ZMc2JmjeL05jeht+yw8fT4St0PNZYmcxGJ7+1gL1cPlCioBwjVSFClfbHo6/7Zi4dKAd
         8/n23m3HfCqKrMRO96eOHPWA/YgvRgZ4ZG2Zl4HlwJnHYX4VXuNPFPPDoJF99JTeUb5T
         kCoGvuC8fssZ8lOx40RoFNNbHBWgjUxXNyQld1dlaOWQ9m/6jYsrZYcime/ZN52BTd43
         862gkDv5zPtUB2Iia6O4hH7XoLQbHd6LpPp8ksis4UO66wIHRmjsLFSiSmrZRFgkm28g
         dBmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791020102; x=1791624902;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rBI89OF+N0vXnxCESFaz463auJhNn0qQwp4320r4m4Q=;
        b=vwDgGHnUrakevw5jDu8cXmv+NBAhPdYF+kiMCHwS5HXzMI1cskPTIhfk61rNuApp35
         JGhqsiNLnA2O3Di8eqqhU/EneQwLN3G6QvXXA0E8vxcv1GZ8eGyHqIrw0nFFZeT6glhu
         HB/Ziw64OeLn46IQ/fOvVGGziNSriMOdbt9780ihoNXBWl2LD5MLkjZSx1SWHv9eX+Id
         JCJmB0k+RP1k1gWhrfAorLB2+yY8Ge/HrfY56xa469wPFqR1QMnkht+47Or/gJAbKn7T
         coxxyZrYJvNFigmEPrq6pZ2eOTdYprDvgg7HcN+54nkDWpCc83PPLs9G9n9/vn8wdkIb
         1hWw==
X-Forwarded-Encrypted: i=1; AKwUvBzF7sHYX2d/I+ggUlk6/krnngkr1gmd2x94nB6AWSnVUYXyGcUlt6LxBR9+5pOjl1nVb7NoiMs=@vger.kernel.org
X-Gm-Message-State: AFuF++lwnNSBpCU/SjMLMsD0xOoJnh2Fs9+KBnfQJw7/kk12fPTGXAeA
	i2zFlcJp2M6RoA1igbazlr8XFjfV7fNpQODfLzhRowKAIYjThezLiyq8
X-Gm-Gg: AYBFou1lGi9n0W/p3HApwGJmIQLzZIDEa06XpaivvJTiNkbHcheuZTiC/VTWGpF66cv
	ipurlraekJ5l0o3uXnppj816kZ59fU3eJMKMpFF7+9yBUXo149gtykePJNStDn6BtylZz/gwcpD
	dp5a1sWHUJ0c8fOn9gP/KXDCMdhU1TkI3ct4nU+QqgnEfTOSwbH1vnMt1kKS8vEODVRio6HNn1g
	60eR1eYMCoQNI9Yg9ispeE+Fl9vd4sWsVNCIWglz2wcnVqaBbZt0/JL/ZKYyOG2YawtL4zy9aNm
	hJncfUa0lM90i1Df+yyrW75Ofy0qjWjayRr2iDKtIHsoCQZEUMCLW567ZgQW/OIAIxt7f0lsnv4
	Bpaj5LyX/fVtaLbTl3IShDDFzm3C+WSeV5g+pvq8cnl51+HYSRExgjonNabM8cEctt8l0s3i614
	+UcU4Sn5WY+3fDCOXCawf42DqliLN3rne3Jkb3/g7WA5JZFSKiJURbusLzB0BgGCE=
X-Received: by 2002:a05:6a00:1d92:b0:881:2a66:405f with SMTP id d2e1a72fcca58-88af6657eadmr5005327b3a.39.1791020101535;
        Sat, 03 Oct 2026 02:35:01 -0700 (PDT)
Received: from localhost ([129.227.235.110])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-88d3b82bafesm46732b3a.13.2026.10.03.02.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 03 Oct 2026 02:35:01 -0700 (PDT)
From: Evanshenf <archwse@gmail.com>
To: dri-devel@lists.freedesktop.org
Cc: Jianmin Lv <lvjianmin@loongson.cn>,
	Qianhai Wu <wuqianhai@loongson.cn>,
	Huacai Chen <chenhuacai@kernel.org>,
	Mingcong Bai <jeffbai@aosc.io>,
	Xi Ruoyao <xry111@xry111.site>,
	Icenowy Zheng <zhengxingda@iscas.ac.cn>,
	Sui Jingfeng <suijingfeng@loongson.cn>,
	stable@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Evanshenf <archwse@gmail.com>
Subject: [PATCH 1/2] drm/loongson: Fix double free on BO initialization failure
Date: Sat,  3 Oct 2026 09:34:58 +0000
Message-ID: <20261003093415.e64386de1e64-1-archwse@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

If ttm_bo_init_validate() fails, it drops the buffer object's reference
and cleans it up through the supplied destroy callback. lsdc_bo_destroy()
releases the GEM object and frees the enclosing lsdc_bo, so freeing it
again in lsdc_bo_create() causes a double free on a synchronous failure
path.

Let TTM own the cleanup after initialization has started and return the
error directly. Keep the explicit free on drm_gem_object_init() failure,
which occurs before ownership is passed to TTM.

Tested on LS7A2000 by making drm_vma_offset_add() return -ENOSPC for one
selected dumb-buffer creation. The error reached userspace, the destroy
callback ran once, and no handle was published or tracked BO retained.
Normal buffer creation, zeroing, mapping, readback and release passed.

AI assistance was used for the ownership analysis, fix, fault-injection
tools, build and test execution.

Fixes: f39db26c5428 ("drm: Add kms driver for loongson display controller")
Cc: stable@vger.kernel.org
Assisted-by: LLM
Signed-off-by: Evanshenf <archwse@gmail.com>
---
 drivers/gpu/drm/loongson/lsdc_ttm.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/loongson/lsdc_ttm.c b/drivers/gpu/drm/loongson/lsdc_ttm.c
index d7441d9..88536e2 100644
--- a/drivers/gpu/drm/loongson/lsdc_ttm.c
+++ b/drivers/gpu/drm/loongson/lsdc_ttm.c
@@ -475,10 +475,8 @@ struct lsdc_bo *lsdc_bo_create(struct drm_device *ddev,
 
 	ret = ttm_bo_init_validate(bdev, tbo, bo_type, &lbo->placement, 0,
 				   false, sg, resv, lsdc_bo_destroy);
-	if (ret) {
-		kfree(lbo);
+	if (ret)
 		return ERR_PTR(ret);
-	}
 
 	return lbo;
 }

base-commit: bca45af5998a05f34b13a2ef11e639bac9c62643
-- 
2.43.0

