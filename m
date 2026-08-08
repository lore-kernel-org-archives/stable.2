Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35F461FE44A
	for <stable@vger.kernel.org>; Sat,  8 Aug 2026 13:52:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786197164; cv=none; b=mb3w/uf4Nkq4h9xUDihF7i+KdJUHgVu4wD7Z6pimOpoNZVHb11ODLqwyxxrknwchxEn7vAuE0DyNILxO92vSfHloF6BQowK0ymU3TX3AgRZrNV+eJyq85kNkAXf9ciTC/3ILQPcoumzXn8JwX96bw+KFATHI1flx3HGrv1ChGGA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786197164; c=relaxed/simple;
	bh=0kxnQAsyrqOy4ZMlYuUneDAi5e6UpIqRGR/e1fdFWD0=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=Wbde6lo/RY2Qe5mhZgFoONQDLLL4acY+o5dGDlY/1CBI+0II/e1iJCO9Cnw73vdcznMCxdulkSl/G5wLf08/elykK9udoeW6IrjC/bx5CKpujHDFfOkIgb1mFRPL4JrTDOJQrmylzuOAmAFQWgJg9caGdCSZ1vxqxzmfrcPDO8E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=qjef5c4n; arc=none smtp.client-ip=209.85.214.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qjef5c4n"
Received: by mail-pl1-f178.google.com with SMTP id d9443c01a7336-2ccf2360620so4027495ad.3
        for <stable@vger.kernel.org>; Sat, 08 Aug 2026 06:52:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1786197162; x=1786801962; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=LrFbJmkk2o/TaP9ZJimvbOk+XpiXXLx+TjQ8Tl79+nY=;
        b=qjef5c4nW1i8Ob/AIb8nHmp+IDFmDMTcWeRkz1wrttZTuFMeunFq6PQ1F16mGHtzf9
         6JadfdX82wAaP8xo3EyEsM2PXb9PZy5BA552MQdXafSEts2Pbv/bfk+fbkGn+zUZUncf
         x1Yu/p8r/e7LaVSQ5u3yxwCYeI4aU0XryUTMq02ZbLsbfGfEHNhGuHq76HknGXNYJzn7
         xm8J3gqhPr1V/z6Hvb0x0g6gfB0HDAL8My8BMJ43e91/lExGS9EIooH2dF4UT6f4d7ux
         XQYEQXm8y7vcqxKpPUrZCidgG9V6OMq0TTI/OoQwGz9FkmGulqbWulQo4mifTvUjeixQ
         kZLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1786197162; x=1786801962;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=LrFbJmkk2o/TaP9ZJimvbOk+XpiXXLx+TjQ8Tl79+nY=;
        b=UV2+VLH7ViWPvi5oFFP7ZDxeq3D8fAA7QqFuG9j/5vVAmWV9izxkYqfdHQ8FdLvRaQ
         8RLUm/vjRoZf0NGPZg6Pyx3Isooh7zXteIZyM42pys0BW8XgkmL+ZvKJoCZifarCo5me
         nnf/LR0TAaYHoZRrbH9xC4lmlhFhQJ3zFGQFtk24X3qROeEVXsoQkUozyIbzxGzBdCXb
         XhPzYRBQ24fVFoVc/GTnxkK6oh461li8lhILzBjCG4TIiGGkLfp2Bb6U0TwxpEEH3gaG
         bW6c6JowijIXOu40d4b3kY90kl1BujhWuXYa9SIWxfCz9VV45VRp6VYjuNyYwBA93Fiq
         S6Xg==
X-Forwarded-Encrypted: i=1; AHgh+RqV7Wd3oPk5SO1E9668Goj/GK6YWz557XfFmrAN5QRnQzfhFA04ba97J9Bd/cAcsuvca6vZocA=@vger.kernel.org
X-Gm-Message-State: AOJu0YyklA3HORL7IKkqCbBEacTV+UMglDHEi7gG69h9ZOs977k96QhF
	k5q0+/pCWr3lH7JXFUMA0O8omg/sW2zDkIHwAg6M3l3fQvTgKEeBef4u
X-Gm-Gg: AR+sD12ooDhsw60to7L/RQd4OzAZyaAHKyfTF2Bl3+g+J7XbxAay1oDtEw+ol0A9XBo
	ObGPi77roIvewLldC7e1LK1NtXKaeO9QrcHOleTBcuUON+Jw6n7/7nDyw/0SGK1Ph+x7OcDSkeZ
	BmZPqSyHb9YCdcsBxk3mH2iVJDX/sUgLfteOIuMsY9552ZrOfpikJe9GsbP93JJ2wMr5uIUKg0h
	yRJG7nbXfaMwPgGOYTqQNotRIcovUySWTykdULQAOihOMy+sTuMb0ynCnrXUTUmIMtpsXS3EgFV
	2+6MZc/qXOFMqVH+Y/LRe659lNeHewWrkAzysBVQ6SpIomqgCjm49wt/y1g1BuQ/+ZO+0as1+KF
	2x1XfNJ928jHOZZbhGHl7BH52d+RbWPX1e17QxH3+KlRR0bor2ZVwtXb7Q5txheySlfPnH98Wn/
	SrePIJ+pMqOic5DiOoNOkB1/y7z4KGUWkb6ZzFkm4xG7o=
X-Received: by 2002:a17:902:c40e:b0:2c9:8f4a:90b with SMTP id d9443c01a7336-2d106a1a2f4mr165599635ad.3.1786197162537;
        Sat, 08 Aug 2026 06:52:42 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1000::f280])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2d16c4fc743sm18861815ad.80.2026.08.08.06.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2026 06:52:42 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Rob Herring <robh@kernel.org>,
	Steven Price <steven.price@arm.com>,
	=?UTF-8?q?Adri=C3=A1n=20Larumbe?= <adrian.larumbe@collabora.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Tomeu Vizoso <tomeu@tomeuvizoso.net>,
	Eric Anholt <eric@anholt.net>,
	"Marty E. Plummer" <hanetzer@startmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panfrost: fix autosuspend cleanup during teardown
Date: Sat,  8 Aug 2026 21:50:24 +0800
Message-ID: <20260808135025.2872956-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panfrost_probe() calls pm_runtime_use_autosuspend(), but neither the
probe error path nor panfrost_remove() calls the matching
pm_runtime_dont_use_autosuspend() during teardown.

If the autosuspend delay is set to a negative value while autosuspend
is enabled, the runtime PM core increments usage_count to prevent
runtime suspend. Without calling pm_runtime_dont_use_autosuspend()
during teardown, this reference is not dropped.

The documentation for pm_runtime_use_autosuspend() also notes that it
is important to undo it with pm_runtime_dont_use_autosuspend() at
driver exit time, unless runtime PM was initially enabled with
devm_pm_runtime_enable().

Add the missing pm_runtime_dont_use_autosuspend() calls to both the
probe failure and device removal paths.

This issue was found by manual code inspection.

Fixes: f3ba91228e8e ("drm/panfrost: Add initial panfrost driver")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/gpu/drm/panfrost/panfrost_drv.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/gpu/drm/panfrost/panfrost_drv.c b/drivers/gpu/drm/panfrost/panfrost_drv.c
index 784e36d72c2b..007dcba62e62 100644
--- a/drivers/gpu/drm/panfrost/panfrost_drv.c
+++ b/drivers/gpu/drm/panfrost/panfrost_drv.c
@@ -1011,6 +1011,7 @@ static int panfrost_probe(struct platform_device *pdev)
 err_out2:
 	drm_dev_unregister(&pfdev->base);
 err_out1:
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
 	pm_runtime_set_suspended(pfdev->base.dev);
@@ -1025,6 +1026,7 @@ static void panfrost_remove(struct platform_device *pdev)
 	drm_dev_unregister(&pfdev->base);
 	panfrost_gem_shrinker_cleanup(&pfdev->base);
 
+	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
 	pm_runtime_get_sync(pfdev->base.dev);
 	pm_runtime_disable(pfdev->base.dev);
 	panfrost_device_fini(pfdev);
-- 
2.43.0

