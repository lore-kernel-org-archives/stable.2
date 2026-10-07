Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC02C4DB547
	for <stable@vger.kernel.org>; Wed,  7 Oct 2026 18:12:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791396757; cv=none; b=V3+NpDFVCknzNaI+9c5ybAesRzKEm8R8KHGWj+1lbG08lzzxQmGD/CMODwereI3zwoSzy28Y8/ZKc4R9rCLzKViHUZUwS9vhXRUFxz2T4i9te0d2nZeM6rVxY2qKDiDcMlRPB2MHLI9hnX52pmKGjNmEDe1YJZR+CBv1g08+fmM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791396757; c=relaxed/simple;
	bh=Eb8kM8V9UZqAw0KzgDYT0NopEv+l/SYxpht3rBesG7A=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=lUQGqV/F/KfePT/5b1SJwVo3tiV9xYI0SGk+qPCsODT5QR3PWDGhofV4w95ZhQqevgLk1MnQkOcG0vQILbMPYONsErjWmGkvwIC3E3QXsqnklum2+y/6Wa3YwF0Xsy4Rpnu4SqoFtbaEIUheQwtI+OGHkADNUfVkaKDoRj2zTbY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WEnAep3p; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WEnAep3p"
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-4a16c399641so21460015e9.2
        for <stable@vger.kernel.org>; Wed, 07 Oct 2026 11:12:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1791396754; x=1792001554; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=SmdRitxTTgFdGJeHgGQ6RNQbSBJ7pC2HNIG3s7QSzuM=;
        b=WEnAep3pVUR29Nh487tCOHw5fic+P+PQuLzV5BpYTiy6ld+cugQWi0IyghwbkHyIWS
         9O/ken87ChJ0ZVuz1LgYcCTJdZab0fTGZXiFEWCTODhH50tvvw5shh4X3myCf2JZHtEG
         KQOCt28zRyXoIjOjV4DWljnHJmjxFzFPzkb+W8Fk9YBuHSt4brMyilWmp+Z8WVC462b4
         Ex6C7mBPsplj4Vvir1IdFh+naR2Xx1JWEawzhNFUi4YgdLoNOxwP9W6uAaeTllGdWI2w
         OR2VOVCidRcmJMIB1VNP3axHvbeohTsGRtLf6rE9M5vng++SuRahtT1voMxGEe7/o2pM
         Tltw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1791396754; x=1792001554;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=SmdRitxTTgFdGJeHgGQ6RNQbSBJ7pC2HNIG3s7QSzuM=;
        b=BD5+Lvs42+XZU1KL4UsaCoiHd1/4/ts8TvwGeSmM2tb0PFin3cQl763Vjex+LvcZq6
         6NlDC2Hu/eXNOjz/voRKGCqrKCeSf/ZDM5/2UWNlfLUZELHBge5YJfy73s0ma3XcuDsS
         yxCyviAYopO12fQGxBSF1239fOAs/eJWk/gkUtTAEPMXt0TH5/vRVvMbjfLsJWplWHBk
         kQQX2TJKrElkysQvOq/IkhauUgCIgUNkpFWHvrwSEBnEio0btid47UIVgzNE+pdED0jT
         vAVemdJJrQ0guqY3P8J/IMIklwX6CLwa+l+8iAPrj/3mwP0ZRRg2NRTApW3flCgn8jvT
         3WGw==
X-Forwarded-Encrypted: i=1; AKwUvBxeoM4TvLFvCGn0ZeZnujjsGeICemAytEkBQ2wUC1ze6e8JNMwklaCKF93eUX8isecdEeGW/CU=@vger.kernel.org
X-Gm-Message-State: AFuF++lhcZ4AkSE/ijO4bhIdN7GNy9O9YuXUm/iMQeaDFVSmeAHJ7GTY
	NKWuOLcWj1sTy31df0HxRqEfXgaus37eSWMW3PLdCEdTjfBZyZvtp43x
X-Gm-Gg: AYBFou3ka28/8D7XOm6PLtzPtIpN2OhtDyHkBrrOH0lzIkv79NO9BUbC+yTVGbT7uL1
	MduHlyieY/SbFZvE3bYDYIQ18Zj85Rqw7SLIGeyPBv6qBDvsRN79NHYlXDB0Csg47TF90m5lkZC
	9SWakHhvbsh8Q4fM691yFHkppD/87amZ/6QAnBWi2QWMWDg0CsDHh3iHmOjSt9fBX1eivxyGQXb
	JqT43urdszgNAdCT6oCp9EBl1l7tR/PpCtEVQJuvKoyheqxJNYrLQP+1ZdMoBGdOi/qsupcDlMG
	ScZ2PNhzfkuHtlsNPOAkl4B76GzXsmJ8+Nrcsndu8W60J5aZolI9vMV455M7PTvJ2oOF1Gl3fZH
	X62XDckJQ94iuaLhYYobL8PVcgaKzimwsq8I+IQ0kKz6MrrlsUxB1yUnMTjiJ06bIEy236zKkNU
	HeoSh9mt+aGTrnS64T8AUviX2y1dMD/pl8UP0CCLY6LstQAEl0WG/fEnHi1mrFkP7hBTpw5HIq9
	Z82Q1fD4opgHVwhxJ/fjc7tOcCCInJQLg==
X-Received: by 2002:a05:600c:6749:b0:4a0:251f:a726 with SMTP id 5b1f17b1804b1-4a180455d47mr54022405e9.24.1791396754013;
        Wed, 07 Oct 2026 11:12:34 -0700 (PDT)
Received: from osama ([2a02:908:182:d1a0:b456:28a3:bd59:abb6])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a1843e3356sm7115815e9.14.2026.10.07.11.12.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 07 Oct 2026 11:12:33 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: Boris Brezillon <boris.brezillon@collabora.com>,
	Steven Price <steven.price@arm.com>,
	Liviu Dudau <liviu.dudau@arm.com>,
	Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
	Maxime Ripard <mripard@kernel.org>,
	Thomas Zimmermann <tzimmermann@suse.de>,
	David Airlie <airlied@gmail.com>,
	Simona Vetter <simona@ffwll.ch>,
	Akash Goel <akash.goel@arm.com>,
	Chia-I Wu <olvaffe@gmail.com>,
	dri-devel@lists.freedesktop.org,
	linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] drm/panthor: Fix TOCTOU race between GROUP_REGISTERED check and erase
Date: Wed,  7 Oct 2026 20:12:19 +0200
Message-ID: <20261007181220.2418060-1-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.53.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

panthor_group_destroy() checks the GROUP_REGISTERED mark and then calls
xa_erase() without holding the xarray lock across both. If the handle is
destroyed by another thread in between, and a concurrent GROUP_CREATE
reuses the freed ID, the first destroy erases and releases the new,
still-initializing group, leading to a use-after-free in
panthor_group_create().

Do the mark check and erase atomically under xa_lock().

Fixes: eec7e23d848d ("drm/panthor: Prevent potential UAF in group creation")
Cc: stable@vger.kernel.org
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
 drivers/gpu/drm/panthor/panthor_sched.c | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/panthor/panthor_sched.c b/drivers/gpu/drm/panthor/panthor_sched.c
index 0493858e55d7..a343c5180e01 100644
--- a/drivers/gpu/drm/panthor/panthor_sched.c
+++ b/drivers/gpu/drm/panthor/panthor_sched.c
@@ -3770,12 +3770,18 @@ int panthor_group_destroy(struct panthor_file *pfile, u32 group_handle)
 	struct panthor_group_pool *gpool = pfile->groups;
 	struct panthor_device *ptdev = pfile->ptdev;
 	struct panthor_scheduler *sched = ptdev->scheduler;
-	struct panthor_group *group;
+	struct panthor_group *group = NULL;
 
-	if (!xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
-		return -EINVAL;
+	/*
+	 * Check the mark and erase the entry atomically, so a concurrent
+	 * destroy + create can't make us erase a group that's still being
+	 * initialized and happens to reuse the same handle.
+	 */
+	xa_lock(&gpool->xa);
+	if (xa_get_mark(&gpool->xa, group_handle, GROUP_REGISTERED))
+		group = __xa_erase(&gpool->xa, group_handle);
+	xa_unlock(&gpool->xa);
 
-	group = xa_erase(&gpool->xa, group_handle);
 	if (!group)
 		return -EINVAL;
 
-- 
2.53.0

