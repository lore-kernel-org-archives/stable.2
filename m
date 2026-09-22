Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1FB6E3E4C6B;
	Tue, 22 Sep 2026 04:40:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=124.126.103.232
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790052057; cv=none; b=tBvoClD8+F5pDsxvGuCezOJSWaKEsidu5pKjmcQOFxW899C7doATY3EYXzTzeTfJYZI5aB7rsN55/j8SLf+cb65MXnWHxlkLjxnYg7G1q61pzXi+/hq/pM/Z53PAFP5W1jgYKhtD8SJOTKjSq7LMmi+1+Tyk4Kwl11oNZ21dGlM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790052057; c=relaxed/simple;
	bh=PHkc647ZpDIBHOJ+Vf+AfN3X2Il8lQBNow/8wvVNXdI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=j1x3hRbVWgZP+2xhz2heOy5SgI/KHy+pRsh1FLohS2nPGk4nhXaUt7+k4mcQhod5Obu8ePOaU5iPZBpvCn/tZ0cylR3AANDohEzCWnUnLncBLmeA9mNhyBQFEtTy5aeidTgK7IJSTj3o78w6P+PW9FBNbEgDNBGSOGh/8hw0KAY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn; spf=pass smtp.mailfrom=kylinos.cn; arc=none smtp.client-ip=124.126.103.232
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=kylinos.cn
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=kylinos.cn
X-UUID: c79e001ab63f11f19a56ed5b684f684d-20260922
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.3.19,REQID:99fb1a02-cb72-41ec-a2b8-5ae9963baf8a,IP:0,U
	RL:0,TC:0,Content:0,EDM:25,RT:0,SF:0,FILE:0,BULK:0,RULE:Release_Ham,ACTION
	:release,TS:25
X-CID-META: VersionHash:7db8b62,CLOUDID:f9727c3a18b6fcdb0b306d270e58f5f1,BulkI
	D:nil,BulkQuantity:0,SF:81|82|102|136|865|898,TC:nil,Content:0|15|50|99,ED
	M:5|-100,IP:nil,URL:0,File:nil,RT:nil,Bulk:nil,QS:nil,BEC:nil,COL:0,OSI:0,
	OSA:0,AV:0,LES:1,SPR:NO,DKR:0,DKP:0,BRR:0,BRE:0,ARC:0
X-CID-BVR: 2,SSN|SDN
X-CID-BAS: 2,SSN|SDN,0,_
X-CID-FACTOR: TF_CID_SPAM_SNR
X-CID-RHF: D41D8CD98F00B204E9800998ECF8427E
X-UUID: c79e001ab63f11f19a56ed5b684f684d-20260922
X-User: liupeng01@kylinos.cn
Received: from t14 [(10.44.16.150)] by mailgw.kylinos.cn
	(envelope-from <liupeng01@kylinos.cn>)
	(Generic MTA with TLSv1.3 TLS_AES_256_GCM_SHA384 256/256)
	with ESMTP id 109217882; Tue, 22 Sep 2026 12:40:47 +0800
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
Subject: [PATCH v2] drm/nouveau: Fix memory leaks in debugfs and hwmon init error paths
Date: Tue, 22 Sep 2026 12:40:44 +0800
Message-ID: <20260922044044.21442-1-liupeng01@kylinos.cn>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <ff3015a1c4b08088b0638b00670e86d612a27978.camel@redhat.com>
References: <ff3015a1c4b08088b0638b00670e86d612a27978.camel@redhat.com>
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
Signed-off-by: liupeng <liupeng01@kylinos.cn>
---
Changes in v2:
- Add Fixes: tags for the commits that introduced the leaks
- Add Cc: stable@vger.kernel.org for stable backporting

 drivers/gpu/drm/nouveau/nouveau_debugfs.c | 15 ++++++++++++---
 drivers/gpu/drm/nouveau/nouveau_hwmon.c   |  2 ++
 2 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/nouveau/nouveau_debugfs.c b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
index 47d5579c568d..88223931f382 100644
--- a/drivers/gpu/drm/nouveau/nouveau_debugfs.c
+++ b/drivers/gpu/drm/nouveau/nouveau_debugfs.c
@@ -295,13 +295,22 @@ nouveau_drm_debugfs_init(struct drm_minor *minor)
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
+		return ret;
+	}
+
+	return 0;
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

