Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4184B4E322B;
	Fri,  9 Oct 2026 11:52:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791546734; cv=none; b=PPgvgOMy/K6n931kl1HfJh76q5AdmFlNWxJ8xG/H9OJD+M+c8dWdOfkkY7EDZGSk7j0BiyStvShPxZHDZW1S2z6gv2nIyrABoRItuX0J4TAa1+6KNbgKx8OCrkYSyqzMyRbV4LXDvA/RO9goF2uGAF2TxhjsHkpxkIUvQw8xsZc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791546734; c=relaxed/simple;
	bh=4/Gga294M8q+YAkg5gHCxHIliBc8snjlyNvp9hHdFFc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=pEnEytHb0FBvvS7RXCsahQqkt8/wP0hrfthoBtxO6Lt54uV2o9XBozr4uIY/JWbmkoG2SttoM6bTmHGppPBt3XGpUQHyAXsYw4iCLaEGglTUli2HZ8+JgYHsnPRgwgIMzlx6/gXn1REe2A40CeZNfRylcdZAWHNepivjvbAmv3Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: d2798a54c3d711f19a56ed5b684f684d-20261009
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:c691bcf6-e7dd-4ae4-8863-0b37bebbeaeb,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:ceed06e202d5449ce84cc283a9489a01,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|865|898,TC:nil,Content:0|15|50|99,ED
	M:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: d2798a54c3d711f19a56ed5b684f684d-20261009
X-User: liupeng01@kylinos.cn
Received: from t14 [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liupeng01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 551343682; Fri, 09 Oct 2026 19:51:54 +0800
From: liupeng <liupeng01@kylinos.cn>
To: lyude@redhat.com,
	dakr@kernel.org
Cc: maarten.lankhorst@linux.intel.com,
	mripard@kernel.org,
	tzimmermann@suse.de,
	airlied@gmail.com,
	simona@ffwll.ch,
	linux@roeck-us.net,
	nouveau@karolherbst.de,
	bskeggs@redhat.com,
	dri-devel@lists.freedesktop.org,
	nouveau@lists.freedesktop.org,
	linux-kernel@vger.kernel.org,
	linux-hwmon@vger.kernel.org,
	stable@vger.kernel.org,
	liupeng <liupeng01@kylinos.cn>
Subject: [PATCH v3] drm/nouveau: Fix memory leaks in debugfs and hwmon init error paths
Date: Fri,  9 Oct 2026 19:51:51 +0800
Message-ID: <20261009115151.13877-1-liupeng01@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ea9a1d374cf3127e5047bc73807ce821022e026e.camel@redhat.com>
References: <ea9a1d374cf3127e5047bc73807ce821022e026e.camel@redhat.com>
Precedence: bulk
X-Mailing-List: stable@vger.kernel.org
List-Id: <stable.vger.kernel.org>
List-Subscribe: <mailto:stable+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:stable+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In nouveau_debugfs_init(), if nvif_object_ctor() fails, the previously
allocated drm->debugfs is leaked because the function returns the
error code directly.

In nouveau_hwmon_init(), if hwmon_device_register_with_info() fails,
the allocated hwmon structure is leaked because the function returns
the error code directly.

Fix both by freeing the allocated memory and clearing the pointer on
the error paths.

Fixes: b126a200e9db ("drm/nouveau/debugfs: we need a ctrl object for debugfs")
Fixes: b9ed919f1c8f ("drm/nouveau/drm/pm: remove everything except the hwmon interfaces to THERM")
Cc: stable@vger.kernel.org
Reviewed-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: liupeng <liupeng01@kylinos.cn>
---
Changes in v3:
- Drop the extra return in nouveau_debugfs_init() as suggested by Lyude.
- Add Reviewed-by tag.

 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 14 +++++++++++---
 drivers/gpu/drm/nouveau/nouveau_hwmon.c   |  2 ++
 2 files changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 47d5579c568d..338421e52f69 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -295,13 +295,21 @@ nouveau_drm_debugfs_init(struct drm_minor *minor)
 int
 nouveau_debugfs_init(struct nouveau_drm *drm)
 {
+	int ret;
+
 	drm->debugfs = kzalloc_obj(*drm->debugfs);
 	if (!drm->debugfs)
 		return -ENOMEM;
 
-	return nvif_object_ctor(&drm->client.device.object, "debugfsCtrl", 0,
-				NVIF_CLASS_CONTROL, NULL, 0,
-				&drm->debugfs->ctrl);
+	ret = nvif_object_ctor(&drm->client.device.object, "debugfsCtrl", 0,
+			       NVIF_CLASS_CONTROL, NULL, 0,
+			       &drm->debugfs->ctrl);
+	if (ret) {
+		kfree(drm->debugfs);
+		drm->debugfs = NULL;
+	}
+
+	return ret;
 }
 
 void
diff --git a/drivers/gpu/drm/nouveau/nouveau_hwmon.c b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
index 726397ab035d..ffbe7f542ab0 100644
--- a/drivers/gpu/drm/nouveau/nouveau_hwmon.c
+++ b/drivers/gpu/drm/nouveau/nouveau_hwmon.c
@@ -697,6 +697,8 @@ nouveau_hwmon_init(struct drm_device *dev)
 	if (IS_ERR(hwmon_dev)) {
 		ret = PTR_ERR(hwmon_dev);
 		NV_ERROR(drm, "Unable to register hwmon device: %d\n", ret);
+		drm->hwmon = NULL;
+		kfree(hwmon);
 		return ret;
 	}
 
-- 
2.53.0

