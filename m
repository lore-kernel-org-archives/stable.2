Received: from mail-pj1-f42.google.com (mail-pj1-f42.google.com [209.85.216.42])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 242BA2931DB
	for <stable@vger.kernel.org>; Fri, 21 Aug 2026 13:53:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.42
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787320389; cv=none; b=KbZYrjMG6WFs6RTjj0dAzfgqLj+yxvFTjoM2XNQKPu04W36cQkOLiX2vJbZrVac9yHbM4gxDdgS8nZAbvszf/RnHZMrO2WMgSehsVKDD5EV8zbZQniV/R1fgdUxa+B+JM5iXOYUTvt1/iQQOVfVOODdYxdN6aFX8TQs1bSob+ms=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787320389; c=relaxed/simple;
	bh=bcVIeuxH7OuUJ+wC/h6WnWnKDDC/AKdiFS2tnABFAgI=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=eBa1IRfpFFZwyu5Oo6JW5w/7fxGxpbvbdfrj1Ae42rj9Di60nV42vFdGN6SXkpTn1VN4LCrz23VeEjVre9EvT86+paX4FQKu6id+Xbh1T1AkG1OVw/kA/vCoJV0y9j48oq/HhO7bnQ9iU99p08vvwo6ejkFlO0ue01LE/gK3E/o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=DzW3s3Yp; arc=none smtp.client-ip=209.85.216.42
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="DzW3s3Yp"
Received: by mail-pj1-f42.google.com with SMTP id 98e67ed59e1d1-38deea72eebso983877a91.1
        for <stable@vger.kernel.org>; Fri, 21 Aug 2026 06:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1787320387; x=1787925187; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=mtWi7dCSmO1v1H5hXBdpE85NppeNwpU1PcOyFZFGvPs=;
        b=DzW3s3YpJ2GcnI1IJ1OFN6GgP4WkW/1LR5fDL2WFDyguj3eSqDymnOzUYTaHFkAHCX
         LpJcGqxkosAGerwNukEKT9fOaMTyTCosH9ptphUBzS0rDIVHJx980k9jh6vpCNU/EfVa
         abq4AGf5anILIkGQ4mucM4VQVBSb9kWd8M4NupglVUN88xT8WqXCtiHUy0d/IwsChhfH
         WOwBkd9w8AXiijWrWmzdEMeYV+azpzxOjk6eUZiA+BONHYLB63Ybu9jCALBPL/JLL7bB
         fJp9++L2WsA/jzVVRM+eaE7u5BhktCjBhVSDJdELGncj3enH328+nVW/2SXEIz/8wKIq
         BfEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787320387; x=1787925187;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=mtWi7dCSmO1v1H5hXBdpE85NppeNwpU1PcOyFZFGvPs=;
        b=bVaOz5xm04VIMjbJfUOaqYlWgzrVbk2iGzqjQsZ3CHQUOYyojTfEQbwHe0wtjeUrSH
         AC/f/KuHNZf7uTsp8WoNkWaoOeESaPU0kYS/hH1K7Vc9T/z48GcxqOHgzMJGCrh+MCJb
         EBsG/miW/3sLGHaol5wcR7/e9nmnAMskpwfAQyAyJIoykjJu0JtuZ149b80VoNC0gPIU
         8YSB5yZC4T4X1PjacQy+oxlFfgwb6K2WtX9xBe5qAN+16Ut+KoAb3ivWQ4urGsGCtU9+
         td4q7kTyfah3nttARdkKVTdELKZ3pAG3mUt1HA+OoTDAh9pIr7mzoCcaYoawUildLDFa
         UVdw==
X-Forwarded-Encrypted: i=1; AHgh+RqVCcTzFb2rchFfLahLMS4CHDYWZXZaUjo+NpCkws2VA/MwIh/8aNPycIMMOf7vl9v5zDOdp3U=@vger.kernel.org
X-Gm-Message-State: AFuF++kiINeucf/RUHoXemMIHhiABmBlRYICTSthEez9ycI5FXSL0LiR
	w8C9h5lacH/hj6d4G4VYuVUwvsfiEtYLszeEIThWmHLslX7D6LJEaRFT
X-Gm-Gg: AR+sD13hH4KU77KpIeQQtDhtNriFYVKCK0H3y+YAFz1t6WdeF1rguEIURydkjQ13KTg
	J+G51eF5fVZxIpUQ83b6V1RseO6h+UstjS5CpBCdhEUdC+1kg/5Fn07B3nDQ47Qe2McEg0xnmwG
	kAUVc9py/pPNBE7D77VvFQSt1GKxSxWGtdZmrDx1pjWzUvjZEpIBbrYZxP9pAUFb+eS4DjNwB40
	dNuWTxJBfLaPbHsDxh5rYrnVEMBevRfpot+RF1uE6k5GPlhc+HXQhLgb5SNDFLn/VtgPvVXsd0a
	1f2up9Qdvwl09RJdTsbRy2Mfq1wpppTSAAsP3Nnev5y9R2cSn+Ri+9tJwY/zVUBhTPppoWlLfw7
	mVfC+l28bPLRQSV+48kd9QVS2dpOlPBwLcB40Cpc+F4sZEy7Y4Uz9aus5soAJ5zuaXjLpzAQBLE
	XPKbC1kgAZQN9dJ7gvRl2IzVKDiztSrVLlkD4ZMTI15JRkgOn/J1ILHRTRDR52ZJTo
X-Received: by 2002:a17:90b:288a:b0:38e:b400:a860 with SMTP id 98e67ed59e1d1-395c3719f99mr12113635a91.13.1787320387327;
        Fri, 21 Aug 2026 06:53:07 -0700 (PDT)
Received: from Default ([2409:40f4:1021:524:57f0:975b:bd1e:1e04])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-327d01ff056sm19947145eec.19.2026.08.21.06.52.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Aug 2026 06:53:06 -0700 (PDT)
From: Jeffin Philip <jeffinphilip14@gmail.com>
To: heikki.krogerus@linux.intel.com
Cc: gregkh@linuxfoundation.org,
	mika.westerberg@linux.intel.com,
	linux-usb@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	syzbot+520d7648a0d934061fb0@syzkaller.appspotmail.com,
	Jeffin Philip <jeffinphilip14@gmail.com>,
	syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com,
	stable@vger.kernel.org
Subject: [PATCH] usb: typec: fix null-pointer-dereference in wcove_typec_probe()
Date: Fri, 21 Aug 2026 19:22:46 +0530
Message-ID: <20260821135246.17907-1-jeffinphilip14@gmail.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

dev_get_drvdata() on the parent device can return NULL if we attempt to
bind our device as a root device with no parent. This causes a null pointer
dereference when accessing pmic->regmap later as pmic uses the parent
struct. Fix this by adding a NULL check for pmic and returning -ENODEV
if to_platform_device() returns NULL for pmic.

Reported-by: syzbot+1a01783ea233350598b5@syzkaller.appspotmail.com
Closes: https://syzkaller.appspot.com/bug?extid=1a01783ea233350598b5
Fixes: d2061f9cc32d ("usb: typec: add driver for Intel Whiskey Cove PMIC USB Type-C PHY")
Cc: stable@vger.kernel.org
Signed-off-by: Jeffin Philip <jeffinphilip14@gmail.com>
---
 drivers/usb/typec/tcpm/wcove.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/usb/typec/tcpm/wcove.c b/drivers/usb/typec/tcpm/wcove.c
index 0e5a3e277c3e..80bca8edeba6 100644
--- a/drivers/usb/typec/tcpm/wcove.c
+++ b/drivers/usb/typec/tcpm/wcove.c
@@ -612,6 +612,10 @@ static int wcove_typec_probe(struct platform_device *pdev)
 	int irq;
 	int ret;
 
+	/* check if we have a parent device first */
+	if (!pmic)
+		return -ENODEV;
+
 	wcove = devm_kzalloc(&pdev->dev, sizeof(*wcove), GFP_KERNEL);
 	if (!wcove)
 		return -ENOMEM;
-- 
2.55.0

