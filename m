Received: from mail-qt1-f172.google.com (mail-qt1-f172.google.com [209.85.160.172])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26BFC150997
	for <stable@vger.kernel.org>; Sun,  2 Aug 2026 03:15:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785640530; cv=none; b=dUD4+6ag/164fxQXYwkg/5EhQ6yajCVz0Or4M66Zsj4fP+28/7ODhb5EeC/jQ5yGjTsMtDsEN0GTXyU5tQdGBmn9E9xlPx+DmDGH28B4Q6gwXOW3hkvBPKLOpLYmhD1ArUY+PUnD0wsLL9znDR4mvxLMY8xiVZVX8+0zjmX5A3M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785640530; c=relaxed/simple;
	bh=83pfoVdZbW5Vz1QhwKcrGUXLYnXaQkCQyi8dnppnJ5M=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=q2M7HtCVTTPc9Aiqv+nm5kQ6WsgLdmxrlbMmTEGedk7ckBPXYOSbxKzga8xQgBgM16jdoGYD7zEuheJNnLOMInQqjN1gBzFFH6iqMcNZsAVWwzHvK1ahz4BqEftUl6WdhWW786+fDUr9To/XLaLp76I8jnQQrRgAmI71ZiIsiSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=l69cr+KG; arc=none smtp.client-ip=209.85.160.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="l69cr+KG"
Received: by mail-qt1-f172.google.com with SMTP id d75a77b69052e-51bfad59921so13748081cf.0
        for <stable@vger.kernel.org>; Sat, 01 Aug 2026 20:15:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1785640528; x=1786245328; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=e3IfyNkgW9IQAsL2Zxr0BNiKaqjF2nRfAzM5DfsWas4=;
        b=l69cr+KGd6sMtmcGD5/XX2RUa8FobkKjm1YIzGwmjMwmwqM5DgBvOhHOkoAdZMLSag
         j8+2ecfrQqMnB2AaIxKqehO8M5aFKhoiEEtaBr8nD7dIOkojaXInASeAPx5uCrLrMIEh
         dJ6BlUGokPUiVuNyi2xivxWegfb/xwCNtTvZHP2eoZ0FlhuBjvGCkbqVaVVBQCtVETMA
         kqlytz+aSWTQlUpMZ7SsmgNKaGc4hTaADGTQ/7Wgknc/dIxB1oU7QCTJT11yLawvOHZQ
         SMPF28QCFltmjubGNYyGhoYPcoHR4pix9vhLi9gNdOdLV7Uy5aAUoVd7o25TNh9UQoB/
         epNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785640528; x=1786245328;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=e3IfyNkgW9IQAsL2Zxr0BNiKaqjF2nRfAzM5DfsWas4=;
        b=p2C9/cNWiw4LnSv91g29Hl9bCGcZUkyyzZjOmKQIEm1SClIdu+OvS2sjaUXKTMs4LJ
         1iLvJcnKgPQDawFUVAZJHleUUavQw9juX043bU/JnNAflV59x1hIX4bvfOg0wKBUmE0n
         x341ndZIPWtnibvkeKXgL/gih5sKLSM0c7opg78RxVb+hd4ifzxrq3QyFwnsNVbU9h5u
         2akouxQq55s/UquHQwoT4OuY8vsLvaq8+QyklwzdYyk7u9//84ViNMYl/KJPiqyyIE+v
         mId+9nDD4mIqlSUK1Bn+hYA7GzkYjDF4q43tiMZ6hKliIEUYH1TQq5FXRnrieNGV7y8S
         QH9Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro/+auRUlfdxyhWIuWIN8kX9U/dIPaBeoOv7OOS3MNkxNczNWMhRV7/WOeeiuLRckHBCeOnagA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxXEM8bS12/WqwE/LO5wgzN+5tsn/tznhoZI1yQT7p/G+4CoEWJ
	ZMu7lSCECrlrfRASj7sjm3qLNGQK19Ku8TYVYKzBILxZG0VEVMof0ilK
X-Gm-Gg: AR+sD105Crx83yEX24K/ir3GfIeEHyhXGGNOQBARFQlaG6Mug2IoPuSDDAf8OhViuus
	m6ycmiedXDQw1VctcEFIY3nH9q5jgYSpTHIAwJwCg2CLbggz/B6FUcxDZSWV8W/qCdxGA7eP1tY
	RAs+/rY0r5yBCbijkK1QwXsDg0PmWhgLKDCd0/6EXo6V5ikkLTni84nt+MilVOv4sKQ+Dm+Kqq6
	56K7UhxXpJCgizVqW/dfai93uT+0AcS4TjJ/INNMdKvk1f0k41kS4NOpxL2iLkpx2MLhWVxpCUV
	yxTBAjvd6535VAAJ0XZi/NTkMLns4302Tvb22i4ZylsIvWbzJt0bIOQP3Cugw+i8/uW7ggUF1iA
	EFNU0i0eRZ5pMfdZJNMMOYg1VjBCFAQZXwMZDRNeX+YWNsKoCrORvY3GuYQY+cT3aHfq6VVBfKF
	0wLop48NOhBNEQqWoAhPrPa4ig5Cv/qXN/EUDfkpsyRTqO5CwT2Sf3L2+sKk5Q0iDIrw8sd3DRh
	CBCex+S3nuUVORRXA==
X-Received: by 2002:ac8:5714:0:b0:528:15e:d1d1 with SMTP id d75a77b69052e-52b56737b31mr103627351cf.16.1785640527964;
        Sat, 01 Aug 2026 20:15:27 -0700 (PDT)
Received: from i4-l-hqh5357-03.ad.psu.edu ([130.203.139.71])
        by smtp.gmail.com with ESMTPSA id d75a77b69052e-52b4e64df9bsm37039851cf.0.2026.08.01.20.15.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 01 Aug 2026 20:15:27 -0700 (PDT)
From: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
To: "Md. Haris Iqbal" <haris.iqbal@ionos.com>,
	Jack Wang <jinpu.wang@ionos.com>,
	Jens Axboe <axboe@kernel.dk>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Shuangpeng Bai <shuangpeng.kernel@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] rnbd-clt: fix use-after-free on device sysfs creation failure
Date: Sat,  1 Aug 2026 23:13:50 -0400
Message-ID: <20260802031350.1468599-1-shuangpeng.kernel@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

rnbd_clt_add_dev_kobj() initializes dev->kobj and adds it below the
gendisk kobject after rnbd_clt_map_device() has returned a live
rnbd_clt_dev to rnbd_clt_map_device_store().

If kobject_init_and_add() fails, the helper currently calls
kobject_put() on the embedded kobject. That put can drop the initial
kobject reference and run rnbd_dev_release(), freeing dev. The caller
then continues through the normal error path and calls
rnbd_clt_unmap_device(dev, true, NULL), dereferencing the freed device.

Leave the initialized kobject alive until the normal device teardown has
completed and rnbd_clt_put_dev() drops the final device reference. Since
kobject_init_and_add() failure can leave the kobject initialized but not
present in sysfs, only call kobject_del() from rnbd_destroy_sysfs() when
state_in_sysfs is set.

Fixes: 581cf833cac4 ("block: rnbd: add .release to rnbd_dev_ktype")
Cc: stable@vger.kernel.org
Signed-off-by: Shuangpeng Bai <shuangpeng.kernel@gmail.com>
---
 drivers/block/rnbd/rnbd-clt-sysfs.c | 2 +-
 drivers/block/rnbd/rnbd-clt.c       | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/block/rnbd/rnbd-clt-sysfs.c b/drivers/block/rnbd/rnbd-clt-sysfs.c
index eb485e4c12e2..9f5d30659f3d 100644
--- a/drivers/block/rnbd/rnbd-clt-sysfs.c
+++ b/drivers/block/rnbd/rnbd-clt-sysfs.c
@@ -498,7 +498,7 @@ static int rnbd_clt_add_dev_kobj(struct rnbd_clt_dev *dev)
 	if (ret) {
 		rnbd_clt_err(dev, "Failed to create device sysfs dir, err: %d\n",
 			      ret);
-		kobject_put(&dev->kobj);
+		return ret;
 	}
 	kobject_uevent(gd_kobj, KOBJ_ONLINE);
 
diff --git a/drivers/block/rnbd/rnbd-clt.c b/drivers/block/rnbd/rnbd-clt.c
index 4d6725a0035e..5fe5c7e259b7 100644
--- a/drivers/block/rnbd/rnbd-clt.c
+++ b/drivers/block/rnbd/rnbd-clt.c
@@ -1658,7 +1658,7 @@ static void rnbd_destroy_sysfs(struct rnbd_clt_dev *dev,
 			  const struct attribute *sysfs_self)
 {
 	rnbd_clt_remove_dev_symlink(dev);
-	if (dev->kobj.state_initialized) {
+	if (dev->kobj.state_in_sysfs) {
 		if (sysfs_self)
 			/* To avoid deadlock firstly remove itself */
 			sysfs_remove_file_self(&dev->kobj, sysfs_self);
-- 
2.43.0

