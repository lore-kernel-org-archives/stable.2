Received: from mail-pj2-f13.google.com (mail-pj2-f13.google.com [74.125.227.141])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF09C33B970
	for <stable@vger.kernel.org>; Sat, 19 Sep 2026 16:35:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=74.125.227.141
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789835742; cv=none; b=dpyF72vIe2KLr1moMyczKptX0FVkpfupNNYxY+JL+mwFaPMxu9oIupp1DUw/mV6D/ixNyjiii17mOtjDbqDVJMMNNMb1j6A/0oGREVuLRSaWNbwEXUz22wcYrKWGrvPrB7sEGRnMUCUkBHBWg2T7v3rNTXlc55bnl50wwJ776CE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789835742; c=relaxed/simple;
	bh=ca6cD2antANdPP0+LuiTiDQj5Y6rfhU3wEwzskCDFpQ=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=SVZXmC3mh8Ane5LPwBSVA+3p6+coIjh94k2+bQzBeE9kiZzBsDCI+GV/Plj5K5grh611UlBXnMPlTKt3LF4UjjDeJK8rH6O0YD0LNOR6jqBRFmdgFZ0IhzH70uGcs/e7HNwlMkZHD1J7F1jdmj4RyrBg5JOe37H1bGhIloDkebw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=cxnWD58U; arc=none smtp.client-ip=74.125.227.141
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cxnWD58U"
Received: by mail-pj2-f13.google.com with SMTP id d9443c01a7336-2d747eb79f7so11914845ad.1
        for <stable@vger.kernel.org>; Sat, 19 Sep 2026 09:35:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789835739; x=1790440539; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=HXW/sZxGz1J/1Aqn+pjRkP+au/CIATITWeBYnhNEPd8=;
        b=cxnWD58ULaZpXEmNYkI4iyENl4gt/0BUDd0YWtbR56AVd7PwskDURPe5COg/xgzfOd
         /w5dKmZQpp5dOmK4C20JUZeVnxSvKxly9k+Qg7V4OsA7aI4S9bEk7kdp7oDd2DqtA5g/
         RdoEiXGphGc5kx8yxEelki7JVhXX52Sp9mpq/4c10fMWhr/CwFc681xEjSn7ikOOWy1M
         cu/ThEUF30DFk+chsdfksfESATp8LeBarvB8ZRJbUY5JGLRJzz6LRMYmbKK3a1ZWf+8O
         xjfthLKiaocQm41e1eRT9zjvz0G1E866EzMe6cDj/HFf0RNZu/ykAvm4M6h2xUoUpZi8
         v+4w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1789835739; x=1790440539;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=HXW/sZxGz1J/1Aqn+pjRkP+au/CIATITWeBYnhNEPd8=;
        b=UudTtd0gFsEBEPBrAYISTvGsYHJuRzw8oEWrvddLQlUBTtfo+sMmeJtUYlRWsafmnd
         JpiNpsvtfDCnFMQyXd15sIo6JtDS7YpRWSS7FCE0MKnoqa+vccZQsn5qd5/tLWCrOKdc
         S1Ae2DoGQh+D+NxsrRKluPHPVT+9jG6NoSktVsXYqSWHTYrckvQJFvbe+iO/ImtpNZtq
         9xbU9xl6X075KmNUA2CHbvNol4eZB7UGqqPXglQKUjuHS1bGm+wZb9Rq7qSpdVZCB7U1
         s13RBH74/LbFV8K1MLNVN+JnPqJSoTikRklU30GVLuF5pwa1qBUtd6MQjkFKWHWTp+wY
         S1Zg==
X-Forwarded-Encrypted: i=1; AKwUvBx2KdR/dPOsMJiQN8faIB23FGAJ3TSZupSEkq6ONd3sgctKdieJ59500U+SMot8PGhLXRIFgco=@vger.kernel.org
X-Gm-Message-State: AFuF++khWB2r1k1YhEqgfivCnj5u8uytKH/0oGk0CTjMPTYvNjpO8etz
	MftuhgK9z9Dgw6V5WAYrcD3OgsglIU+qNyXJtdIXncqARMNytQqB8705
X-Gm-Gg: AYBFou3NDJ1n+hvLEYyXaVDpUyg2wxBYBFDWJpQdFYFdBgOpWBwcQlxYtFqzjPZ43/f
	EKNSCZIv0DWkOPKR8Sk5XP4WljyZ1/pb/bXTzZowat76OBfOfSySNwBpPyR5rks66z1ahOuvwuH
	fZlDExyg7+FFZ9U5l7i4WwZcWr8ffsHaI921/mot5GjAy5LH/277xbO3eMJPddbi8VmgYSzopzf
	lmVoF70QVJ32phUDHyDhV8JXI/l962TNVJ31JHv/o39VpPh1oXDM+xT+H+5Kw0rflR6w2XY8cKt
	yJLJBo4I97rI8p1e81GZBenGMJYSTIh5k9m9l+u75Ad3A6FHoVTh6xLBDDuMMSC9YHeHiQM5ij5
	m1eDJ2JJEmSBRHBy2BsFXLMpxgHpYa6OFx7UxUyHheRXEc7dr/wLfKMGeV+wTMYr5tzNgGjv9rX
	16rNuIJfYP++982pwPlAl3cIlv5cP5MPYdBwQcwk8oAwjN7fxyR2ya6hpa+X2r8T69
X-Received: by 2002:a17:903:1b03:b0:2dd:c0ff:e725 with SMTP id d9443c01a7336-2ddc0ffe981mr37455165ad.55.1789835738990;
        Sat, 19 Sep 2026 09:35:38 -0700 (PDT)
Received: from lgs.. ([2001:250:5800:1002::de93])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2ddc17f75c2sm11236085ad.73.2026.09.19.09.35.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 19 Sep 2026 09:35:38 -0700 (PDT)
From: Guangshuo Li <lgs201920130244@gmail.com>
To: Eddie James <eajames@linux.ibm.com>,
	Ninad Palsule <ninad@linux.ibm.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jeremy Kerr <jk@ozlabs.org>,
	Joel Stanley <joel@jms.id.au>,
	linux-fsi@lists.ozlabs.org,
	linux-kernel@vger.kernel.org
Cc: Guangshuo Li <lgs201920130244@gmail.com>,
	stable@vger.kernel.org
Subject: [PATCH] fsi: master-hub: fix memory leak on registration failure
Date: Sun, 20 Sep 2026 00:35:26 +0800
Message-ID: <20260919163526.3667566-1-lgs201920130244@gmail.com>
X-Mailer: git-send-email 2.43.0
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

hub_master_probe() allocates hub with kzalloc_obj(), but the probe
failure path does not free it when fsi_master_register() returns an
error.

If master index allocation fails, fsi_master_register() returns before
master.dev is initialized. The current error path only releases the
claimed slave address range, leaving the allocated hub unreachable and
causing a memory leak.

If device registration fails after the master index has been allocated,
device_register() has already initialized master.dev and holds its
initial reference. hub_master_release() is responsible for freeing hub,
but the probe failure path does not drop this reference, so the release
callback is never invoked and the allocated hub is leaked.

Free hub directly when master index allocation fails. When registration
fails after master.dev has been initialized, use put_device() to drop
the device reference and invoke hub_master_release(), which frees hub.

This issue was found by manual code inspection.

Fixes: e0c24bddf07c ("fsi: master: Clarify master lifetimes & fix use-after-free in hub master")
Cc: stable@vger.kernel.org
Signed-off-by: Guangshuo Li <lgs201920130244@gmail.com>
---
 drivers/fsi/fsi-master-hub.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/fsi/fsi-master-hub.c b/drivers/fsi/fsi-master-hub.c
index e5ac9025762e..2cc0c40717fe 100644
--- a/drivers/fsi/fsi-master-hub.c
+++ b/drivers/fsi/fsi-master-hub.c
@@ -240,8 +240,13 @@ static int hub_master_probe(struct fsi_device *fsi_dev)
 	hub_master_init(hub);
 
 	rc = fsi_master_register(&hub->master);
-	if (rc)
+	if (rc) {
+		if (hub->master.idx < 0)
+			goto err_free_hub;
+
+		put_device(&hub->master.dev);
 		goto err_release;
+	}
 
 	/* At this point, fsi_master_register performs the device_initialize(),
 	 * and holds the sole reference on master.dev. This means the device
@@ -253,6 +258,8 @@ static int hub_master_probe(struct fsi_device *fsi_dev)
 	get_device(&hub->master.dev);
 	return 0;
 
+err_free_hub:
+	kfree(hub);
 err_release:
 	fsi_slave_release_range(fsi_dev->slave, FSI_HUB_LINK_OFFSET,
 			FSI_HUB_LINK_SIZE * links);
-- 
2.43.0

